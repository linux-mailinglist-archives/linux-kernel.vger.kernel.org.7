Return-Path: <linux-kernel+bounces-782385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE1B31FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035881D278CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B5242D62;
	Fri, 22 Aug 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8XNCmWI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E721254F;
	Fri, 22 Aug 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877312; cv=none; b=eqgF2kmhwNZEWDONURSQY/mDDE7MCiN3QRHLrH9r4DXsLBmRCdHz473P2Lc9VUwAbhPLd4kTkAV7IGFsMMV/2gKTEzL0Jbj7MC7EiJidlfsZpen9axGfLJTAcUZYg7gAIyIjM8/kLl3l2ne7rOZplTMAGVwaq+8w7KhNhK9OVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877312; c=relaxed/simple;
	bh=N/oyzhidX2HrDrlgYBW47gzWyPuSs9DczFIHP0fsa5c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YIdHk1kQupqlnIeSYVB19+hkPXCpdmm2zyUOJlxf2EYtbUK1c/nDKHcKabkxdISIEm9KMyZLuFMV1eM0+uULyKKmaraMXDMjHxnG6tbx037RTIIExNvsDrBYgf+RgotGe5dWMPgW6giQgIRWxksz4HA55KyDy/mEU3crDx0NmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8XNCmWI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755877312; x=1787413312;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=N/oyzhidX2HrDrlgYBW47gzWyPuSs9DczFIHP0fsa5c=;
  b=a8XNCmWIEuo3XVar/CFZXFDeoXC6SAf9gtpuwqJKSRJCNRvnWfFDfu72
   ugNmHjfw7qngbXqS5heLJjdj89bvQpJng1gL8l/OGLv6gdoYRyL/xFmit
   4+Kjtzo/I8IaN2g84KjjWfkV905rs1V5LOltBU1PhmO6RuFlqV4bLFk1K
   K6xLM8aVuuRpHnCaKp0h16gy4u3SHSOi+umHKwUyO4kZqfKJxK0K9IV6B
   G/OX/HcuLqX0Pfs+EOk2GGasJOoAmsHW/t5fb59AvEybVnd4nUdnXqpuS
   Gg/PZzjSWO6O4wnNYgfj7hcQwYTKOtoQ/pQK8H+pX7KkT7gF09oHnWGyy
   Q==;
X-CSE-ConnectionGUID: fCA5GRbASZePgCQVRQu+6Q==
X-CSE-MsgGUID: r7MH1E8ZRq2La5bjkMNWEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58253474"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58253474"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:41:51 -0700
X-CSE-ConnectionGUID: UcBtj7crSeaUHBOK/4zC0w==
X-CSE-MsgGUID: ZZbOSGfnQxypp+njWbRpdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168634368"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:41:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Aug 2025 18:41:46 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: hansg@kernel.org, kean0048@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] platform/x86: think-lmi: Add certificate GUID
 structure
In-Reply-To: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
Message-ID: <6d726a7d-b9c7-d4c2-2e1c-4d32f5cda731@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-82937277-1755876860=:937"
Content-ID: <619fd5cf-0c47-3a89-0101-5ec3307a1162@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-82937277-1755876860=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6fde09a1-13b3-5e95-6d77-2e1bb6c4cc18@linux.intel.com>

On Fri, 22 Aug 2025, Mark Pearson wrote:

> Add a certificate GUID structure to make it easier to add different
> options for other platforms that need different GUIDs.
>=20
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 41 ++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x=
86/lenovo/think-lmi.c
> index 0992b41b6221..88bae5b33c57 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -177,6 +177,28 @@ MODULE_PARM_DESC(debug_support, "Enable debug comman=
d support");
>  #define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
>  #define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
> =20
> +struct tlmi_cert_guids {
> +=09char *thumbprint;
> +=09char *set_bios_setting;
> +=09char *save_bios_setting;
> +=09char *cert_to_password;
> +=09char *clear_bios_cert;
> +=09char *update_bios_cert;
> +=09char *set_bios_cert;
> +};
> +
> +static struct tlmi_cert_guids thinkpad_cert_guid =3D {
> +=09LENOVO_CERT_THUMBPRINT_GUID,

Don't use the anonymous initialization but name the members for better=20
readability.

> +=09LENOVO_SET_BIOS_SETTING_CERT_GUID,
> +=09LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09LENOVO_CERT_TO_PASSWORD_GUID,
> +=09LENOVO_CLEAR_BIOS_CERT_GUID,
> +=09LENOVO_UPDATE_BIOS_CERT_GUID,
> +=09LENOVO_SET_BIOS_CERT_GUID

Always remember to add comma to any non-terminator entry.

=2E..And thanks for reworking these, they look so simple now to review. :-)

> +};
> +
> +static struct tlmi_cert_guids *cert_guid =3D &thinkpad_cert_guid;
> +
>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>  =09{"Success", 0},
>  =09{"Not Supported", -EOPNOTSUPP},
> @@ -668,7 +690,10 @@ static ssize_t cert_thumbprint(char *buf, const char=
 *arg, int count)
>  =09const union acpi_object *obj;
>  =09acpi_status status;
> =20
> -=09status =3D wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &in=
put, &output);
> +=09if (!cert_guid->thumbprint)
> +=09=09return -EOPNOTSUPP;

Either mention this in the changelog or move it into the next patch
that is the one needing the check. The latter of those seems more logical=
=20
as this is the only GUID you're NULL checking.

--=20
 i.

> +
> +=09status =3D wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input, &=
output);
>  =09if (ACPI_FAILURE(status)) {
>  =09=09kfree(output.pointer);
>  =09=09return -EIO;
> @@ -751,7 +776,7 @@ static ssize_t cert_to_password_store(struct kobject =
*kobj,
>  =09=09kfree_sensitive(passwd);
>  =09=09return -ENOMEM;
>  =09}
> -=09ret =3D tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
> +=09ret =3D tlmi_simple_call(cert_guid->cert_to_password, auth_str);
>  =09kfree(auth_str);
>  =09kfree_sensitive(passwd);
> =20
> @@ -797,7 +822,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09=09if (!auth_str)
>  =09=09=09return -ENOMEM;
> =20
> -=09=09ret =3D tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
> +=09=09ret =3D tlmi_simple_call(cert_guid->clear_bios_cert, auth_str);
>  =09=09kfree(auth_str);
> =20
>  =09=09return ret ?: count;
> @@ -834,7 +859,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09=09=09kfree(new_cert);
>  =09=09=09return -EACCES;
>  =09=09}
> -=09=09guid =3D LENOVO_UPDATE_BIOS_CERT_GUID;
> +=09=09guid =3D cert_guid->update_bios_cert;
>  =09=09/* Format: 'Certificate,Signature' */
>  =09=09auth_str =3D cert_command(setting, new_cert, signature);
>  =09} else {
> @@ -845,7 +870,7 @@ static ssize_t certificate_store(struct kobject *kobj=
,
>  =09=09=09kfree(new_cert);
>  =09=09=09return -EACCES;
>  =09=09}
> -=09=09guid =3D LENOVO_SET_BIOS_CERT_GUID;
> +=09=09guid =3D cert_guid->set_bios_cert;
>  =09=09/* Format: 'Certificate, password' */
>  =09=09auth_str =3D cert_command(setting, new_cert, setting->password);
>  =09}
> @@ -1071,13 +1096,13 @@ static ssize_t current_value_store(struct kobject=
 *kobj,
>  =09=09=09goto out;
>  =09=09}
> =20
> -=09=09ret =3D tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_st=
r);
> +=09=09ret =3D tlmi_simple_call(cert_guid->set_bios_setting, set_str);
>  =09=09if (ret)
>  =09=09=09goto out;
>  =09=09if (tlmi_priv.save_mode =3D=3D TLMI_SAVE_BULK)
>  =09=09=09tlmi_priv.save_required =3D true;
>  =09=09else
> -=09=09=09ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09=09=09ret =3D tlmi_simple_call(cert_guid->save_bios_setting,
>  =09=09=09=09=09       tlmi_priv.pwd_admin->save_signature);
>  =09} else if (tlmi_priv.opcode_support) {
>  =09=09/*
> @@ -1282,7 +1307,7 @@ static ssize_t save_settings_store(struct kobject *=
kobj, struct kobj_attribute *
>  =09=09=09=09ret =3D -EINVAL;
>  =09=09=09=09goto out;
>  =09=09=09}
> -=09=09=09ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09=09=09ret =3D tlmi_simple_call(cert_guid->save_bios_setting,
>  =09=09=09=09=09       tlmi_priv.pwd_admin->save_signature);
>  =09=09=09if (ret)
>  =09=09=09=09goto out;
>=20
--8323328-82937277-1755876860=:937--

