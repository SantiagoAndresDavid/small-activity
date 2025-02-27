using System.ComponentModel.DataAnnotations;

namespace Model;

public class User
{
    public string? UserIdentificationType { get; set; }
    [Key]
    public string? UserIdentificationNumber { get; set; }
    public string? AdministratorEntityCode { get; set; }
    public string? UserType { get; set; }
    public string? FirstName { get; set; }
    public string? SecondName { get; set; }
    public string? LastName { get; set; }
    public string? SecondLastName { get; set; }
    public string? Age { get; set; }
    public string? AgeUnit { get; set; }
    public string? Gender { get; set; }
    public string? DepartmentCode { get; set; }
    public string? MunicipalityCode { get; set; }
    public string? ResidenceZone { get; set; }
}