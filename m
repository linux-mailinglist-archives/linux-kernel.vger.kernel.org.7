Return-Path: <linux-kernel+bounces-800782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B24B43BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703701C257D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB72FC00B;
	Thu,  4 Sep 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCH5Dg1P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF925464D;
	Thu,  4 Sep 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990013; cv=none; b=AEFHiLMIO5Z0HG1NaaerJ2VV8dVEDhqnl/kVeOHPNAhbwQoDql6DiZcPJ5s2uKNKyrKwbzVewtKA3/DDHv6xUVgr4+mMLraFiS2bpuYlNisgY3fChMlihWy6nG02r2c9QHfgOkcttAyveVnKbdzRYCm5/h+TIBCKVusr0WcsIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990013; c=relaxed/simple;
	bh=oVGKvk3bgxaPprv7TLfdzzY5AzKcpERHe0b11a9kV8Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AVujQSKA8RmDfTGNewRLy7mPB+VnBbln0zwrnZ3EKseQhmT4dc9cMhkDu+vskljXjg+UAPxGwWRYbE94vzHWSsk7IuHJp3oeSEFvDTqM2FiGm/aKhNQKxR61FZVtRjugyAwvsgbs8uxbqx3I4afevoZiHkbPI4jZ+TJ1PrwF7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCH5Dg1P; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756990012; x=1788526012;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oVGKvk3bgxaPprv7TLfdzzY5AzKcpERHe0b11a9kV8Y=;
  b=aCH5Dg1PecLWNnGAFUC7b4tPh+mnwsIdGeQ0A4y3xD4m6o5ruWImk1VR
   lkVGb6Z+ohqJ/+YQhH+nH/d1MTcQtpVTdKOShJRhmWjHbdRWnuL3t+eJ1
   Tdz/KpAHBcqXCUH/dWztD/PcBr3A6zot9khl8N2lgPE91kcv8ESoBZo7o
   rcdujkHy+YL8iyD5M/0Cn9X80ea8fDQKZw3IBJfW9Fsu7yOcii0A0SIRu
   84o3glNaQh4KSRmB+eeudRZXAVmaBDQu7RylNPpw3LrQQK34IrfECBlRg
   IWQVQIz0K9yfO2QPPWkSON4LBiViakMbyxL4kARl7ZXVRIuzjbTBBorO/
   Q==;
X-CSE-ConnectionGUID: WOO9QlgyS2WZFBujcE8UNQ==
X-CSE-MsgGUID: UgjiQT0fSGWN2dWt5NgqeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="61960095"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="61960095"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 05:46:51 -0700
X-CSE-ConnectionGUID: LeRPOXlhSzieaoHteFi5gg==
X-CSE-MsgGUID: mPthvucsT62sILrAjnKhqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202728065"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 05:46:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 4 Sep 2025 15:46:45 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: ilpo.jarvinen@linux.intel.com, hansg@kernel.org, kean0048@gmail.com, 
    platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] platform/x86: think-lmi: Add certificate GUID
 structure
In-Reply-To: <20250903173824.1472244-2-mpearson-lenovo@squebb.ca>
Message-ID: <5e27f8b6-1d11-aafd-917d-478dba10ec94@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20250903173824.1472244-1-mpearson-lenovo@squebb.ca> <20250903173824.1472244-2-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2145216708-1756990005=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2145216708-1756990005=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Sep 2025, Mark Pearson wrote:

> Add a certificate GUID structure to make it easier to add different
> options for other platforms that need different GUIDs.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2:
>  - split patch up into series
> Changes in v3:
>  - add field details to thinkpad_cert_guid declare.
>  - add missing comma
>  - Move null thumbprint GUID check to later in series
> Changes in v4:
>  - Moved cert_guid into tlmi_priv
>  - applied const where needed
>=20
>  drivers/platform/x86/lenovo/think-lmi.c | 29 +++++++++++++++++--------
>  drivers/platform/x86/lenovo/think-lmi.h | 13 +++++++++++
>  2 files changed, 33 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x=
86/lenovo/think-lmi.c
> index 0992b41b6221..de287987f20c 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -177,6 +177,16 @@ MODULE_PARM_DESC(debug_support, "Enable debug comman=
d support");
>  #define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
>  #define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
> =20
> +static const struct tlmi_cert_guids thinkpad_cert_guid =3D {
> +=09.thumbprint =3D LENOVO_CERT_THUMBPRINT_GUID,
> +=09.set_bios_setting =3D LENOVO_SET_BIOS_SETTING_CERT_GUID,
> +=09.save_bios_setting =3D LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09.cert_to_password =3D LENOVO_CERT_TO_PASSWORD_GUID,
> +=09.clear_bios_cert =3D LENOVO_CLEAR_BIOS_CERT_GUID,
> +=09.update_bios_cert =3D LENOVO_UPDATE_BIOS_CERT_GUID,
> +=09.set_bios_cert =3D LENOVO_SET_BIOS_CERT_GUID,
> +};
> +
>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>  =09{"Success", 0},
>  =09{"Not Supported", -EOPNOTSUPP},
> @@ -668,7 +678,7 @@ static ssize_t cert_thumbprint(char *buf, const char =
*arg, int count)
>  =09const union acpi_object *obj;
>  =09acpi_status status;
> =20
> -=09status =3D wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &in=
put, &output);
> +=09status =3D wmi_evaluate_method(tlmi_priv.cert_guid->thumbprint, 0, 0,=
 &input, &output);
>  =09if (ACPI_FAILURE(status)) {
>  =09=09kfree(output.pointer);
>  =09=09return -EIO;
> @@ -751,7 +761,7 @@ static ssize_t cert_to_password_store(struct kobject =
*kobj,
>  =09=09kfree_sensitive(passwd);
>  =09=09return -ENOMEM;
>  =09}
> -=09ret =3D tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
> +=09ret =3D tlmi_simple_call(tlmi_priv.cert_guid->cert_to_password, auth_=
str);
>  =09kfree(auth_str);
>  =09kfree_sensitive(passwd);
> =20
> @@ -774,7 +784,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09char *auth_str, *new_cert;
>  =09const char *serial;
>  =09char *signature;
> -=09char *guid;
> +=09const char *guid;
>  =09int ret;
> =20
>  =09if (!capable(CAP_SYS_ADMIN))
> @@ -797,7 +807,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09=09if (!auth_str)
>  =09=09=09return -ENOMEM;
> =20
> -=09=09ret =3D tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
> +=09=09ret =3D tlmi_simple_call(tlmi_priv.cert_guid->clear_bios_cert, aut=
h_str);
>  =09=09kfree(auth_str);
> =20
>  =09=09return ret ?: count;
> @@ -834,7 +844,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09=09=09kfree(new_cert);
>  =09=09=09return -EACCES;
>  =09=09}
> -=09=09guid =3D LENOVO_UPDATE_BIOS_CERT_GUID;
> +=09=09guid =3D tlmi_priv.cert_guid->update_bios_cert;
>  =09=09/* Format: 'Certificate,Signature' */
>  =09=09auth_str =3D cert_command(setting, new_cert, signature);
>  =09} else {
> @@ -845,7 +855,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09=09=09kfree(new_cert);
>  =09=09=09return -EACCES;
>  =09=09}
> -=09=09guid =3D LENOVO_SET_BIOS_CERT_GUID;
> +=09=09guid =3D tlmi_priv.cert_guid->set_bios_cert;
>  =09=09/* Format: 'Certificate, password' */
>  =09=09auth_str =3D cert_command(setting, new_cert, setting->password);
>  =09}
> @@ -1071,13 +1081,13 @@ static ssize_t current_value_store(struct kobject=
 *kobj,
>  =09=09=09goto out;
>  =09=09}
> =20
> -=09=09ret =3D tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_st=
r);
> +=09=09ret =3D tlmi_simple_call(tlmi_priv.cert_guid->set_bios_setting, se=
t_str);
>  =09=09if (ret)
>  =09=09=09goto out;
>  =09=09if (tlmi_priv.save_mode =3D=3D TLMI_SAVE_BULK)
>  =09=09=09tlmi_priv.save_required =3D true;
>  =09=09else
> -=09=09=09ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09=09=09ret =3D tlmi_simple_call(tlmi_priv.cert_guid->save_bios_setting=
,
>  =09=09=09=09=09       tlmi_priv.pwd_admin->save_signature);
>  =09} else if (tlmi_priv.opcode_support) {
>  =09=09/*
> @@ -1282,7 +1292,7 @@ static ssize_t save_settings_store(struct kobject *=
kobj, struct kobj_attribute *
>  =09=09=09=09ret =3D -EINVAL;
>  =09=09=09=09goto out;
>  =09=09=09}
> -=09=09=09ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09=09=09ret =3D tlmi_simple_call(tlmi_priv.cert_guid->save_bios_setting=
,
>  =09=09=09=09=09       tlmi_priv.pwd_admin->save_signature);
>  =09=09=09if (ret)
>  =09=09=09=09goto out;
> @@ -1728,6 +1738,7 @@ static int tlmi_analyze(struct wmi_device *wdev)
>  =09}
> =20
>  =09if (tlmi_priv.certificate_support) {
> +=09=09tlmi_priv.cert_guid =3D &thinkpad_cert_guid;
>  =09=09tlmi_priv.pwd_admin->cert_installed =3D
>  =09=09=09tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
>  =09=09tlmi_priv.pwd_system->cert_installed =3D
> diff --git a/drivers/platform/x86/lenovo/think-lmi.h b/drivers/platform/x=
86/lenovo/think-lmi.h
> index 9b014644d316..59aa03c3f846 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.h
> +++ b/drivers/platform/x86/lenovo/think-lmi.h
> @@ -41,6 +41,17 @@ enum save_mode {
>  =09TLMI_SAVE_SAVE,
>  };
> =20
> +/* GUIDs can differ between platforms */
> +struct tlmi_cert_guids {
> +=09const char *thumbprint;
> +=09const char *set_bios_setting;
> +=09const char *save_bios_setting;
> +=09const char *cert_to_password;
> +=09const char *clear_bios_cert;
> +=09const char *update_bios_cert;
> +=09const char *set_bios_cert;
> +};
> +
>  /* password configuration details */
>  #define TLMI_PWDCFG_MODE_LEGACY    0
>  #define TLMI_PWDCFG_MODE_PASSWORD  1
> @@ -121,6 +132,8 @@ struct think_lmi {
>  =09struct tlmi_pwd_setting *pwd_system;
>  =09struct tlmi_pwd_setting *pwd_hdd;
>  =09struct tlmi_pwd_setting *pwd_nvme;
> +
> +=09const struct tlmi_cert_guids *cert_guid;
>  };
> =20
>  #endif /* !_THINK_LMI_H_ */
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-2145216708-1756990005=:943--

