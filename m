Return-Path: <linux-kernel+bounces-789779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C1B39A97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CDA1C211C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230930C63E;
	Thu, 28 Aug 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqiwLiQC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9925D549;
	Thu, 28 Aug 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378015; cv=none; b=lkoftWLhcKYdinhxbc4JMJbGqcSXXf7+vfHvy/bHO6ErEijTr+1P8Sb81sxjRP78eYpCD5zMCaHbAl3/v5L4AjDkbqlCRukKIO8IK/AX/oeiff6eiDAINOi8DPPt2YnL5FUQpjFC9+PEd5/NEULfDMuCOgSyP9cljysCBUhwOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378015; c=relaxed/simple;
	bh=DSsbPc2IT2cQcyc/0ft7nwPnrDBbtZyv3Ky7EjOBi0w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jQgM0PJh8geNjFETFHm3tRceocTXmeG7BS2R5nVN/Y0g2fhAEz0I+XH37/3YIM2kb9xbskSuMeFvOZ+cSZd6SdrANAVCsS+uXw3HMZ8YzyeR2HAfpbJLfhKClTM43fr7ljrrJ+fLLd683Z4dXyVk5ytsd8RHdIC9K//isQ7xJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqiwLiQC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756378014; x=1787914014;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DSsbPc2IT2cQcyc/0ft7nwPnrDBbtZyv3Ky7EjOBi0w=;
  b=kqiwLiQC9Lcy6UBoI3S9Rj1ehtJ72Q396R+zLB0Foob+N6/8pSXW/roa
   eimw8p6o0sRXIPVBVTHCxHC0aiTXobRET8mHXNN1YT5sKYh92fo8PvpPy
   hu/Deh3JywiS8wDX0BjaAXSg3C+wK6Rnibv+RdGTU1SxjCGg1OU0L3OVD
   h4wXnvw3NLV5P2xFgNVd4+yJCGFnp8gMP+m4Dh1H9KN934IvSZmu5YbTK
   pVqrqN1i751iSZN3D/U59hHQpbmNX1BvTF7ymSJMfPf7Gg8LwiT4KJrQJ
   FSOM3zVclT4IMQ7WkS+7HPOtfdw5ovWj9FqZ0sAwbfcP14sBjDUIDQcKh
   A==;
X-CSE-ConnectionGUID: PToMG5pgRQ+S5mYT75l4Zw==
X-CSE-MsgGUID: m5S0EOcEQk2XYHlUqXK8TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58573396"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58573396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:46:53 -0700
X-CSE-ConnectionGUID: 6QRm6xPVQ1SJZ54MnmsfqQ==
X-CSE-MsgGUID: YBlL8d4UROKxQBpFSRnkaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207223538"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:46:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 13:46:47 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: hansg@kernel.org, kean0048@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] platform/x86: think-lmi: Certificate support for
 ThinkCenter
In-Reply-To: <20250825160351.971852-3-mpearson-lenovo@squebb.ca>
Message-ID: <3894a10e-7b42-771c-3ecb-b4c2240b00ac@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20250825160351.971852-1-mpearson-lenovo@squebb.ca> <20250825160351.971852-3-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Aug 2025, Mark Pearson wrote:

> ThinkCenter platforms use a different set of GUIDs along with some
> differences in implementation details for their support of
> certificate based authentication.
> 
> Update the think-lmi driver to work correctly on these platforms.
> 
> Tested on M75q Gen 5.
> 
> Signed-off-by: Kean Ren <kean0048@gmail.com>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2:
>  - split patch up into series
> Changes in v3:
>  - Move check for no thumbprint GUID to this patch
>  - Add structure fields and missing comma
> 
>  drivers/platform/x86/lenovo/think-lmi.c | 54 ++++++++++++++++++++++---
>  drivers/platform/x86/lenovo/think-lmi.h |  1 +
>  2 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
> index a22d25f6d3c6..3a1cec4625e5 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -119,6 +119,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   * You must reboot the computer before the changes will take effect.
>   */
>  #define LENOVO_SET_BIOS_CERT_GUID    "26861C9F-47E9-44C4-BD8B-DFE7FA2610FE"
> +#define LENOVO_TC_SET_BIOS_CERT_GUID "955aaf7d-8bc4-4f04-90aa-97469512f167"
>  
>  /*
>   * Name: UpdateBiosCert
> @@ -128,6 +129,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   * You must reboot the computer before the changes will take effect.
>   */
>  #define LENOVO_UPDATE_BIOS_CERT_GUID "9AA3180A-9750-41F7-B9F7-D5D3B1BAC3CE"
> +#define LENOVO_TC_UPDATE_BIOS_CERT_GUID "5f5bbbb2-c72f-4fb8-8129-228eef4fdbed"
>  
>  /*
>   * Name: ClearBiosCert
> @@ -137,6 +139,8 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   * You must reboot the computer before the changes will take effect.
>   */
>  #define LENOVO_CLEAR_BIOS_CERT_GUID  "B2BC39A7-78DD-4D71-B059-A510DEC44890"
> +#define LENOVO_TC_CLEAR_BIOS_CERT_GUID  "97849cb6-cb44-42d1-a750-26a596a9eec4"
> +
>  /*
>   * Name: CertToPassword
>   * Description: Switch from certificate to password authentication.
> @@ -145,6 +149,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   * You must reboot the computer before the changes will take effect.
>   */
>  #define LENOVO_CERT_TO_PASSWORD_GUID "0DE8590D-5510-4044-9621-77C227F5A70D"
> +#define LENOVO_TC_CERT_TO_PASSWORD_GUID "ef65480d-38c9-420d-b700-ab3d6c8ebaca"
>  
>  /*
>   * Name: SetBiosSettingCert
> @@ -153,6 +158,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   * Format: "Item,Value,Signature"
>   */
>  #define LENOVO_SET_BIOS_SETTING_CERT_GUID  "34A008CC-D205-4B62-9E67-31DFA8B90003"
> +#define LENOVO_TC_SET_BIOS_SETTING_CERT_GUID  "19ecba3b-b318-4192-a89b-43d94bc60cea"
>  
>  /*
>   * Name: SaveBiosSettingCert
> @@ -161,6 +167,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   * Format: "Signature"
>   */
>  #define LENOVO_SAVE_BIOS_SETTING_CERT_GUID "C050FB9D-DF5F-4606-B066-9EFC401B2551"
> +#define LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID "0afaf46f-7cca-450a-b455-a826a0bf1af5"
>  
>  /*
>   * Name: CertThumbprint
> @@ -197,6 +204,16 @@ static struct tlmi_cert_guids thinkpad_cert_guid = {
>  	.set_bios_cert = LENOVO_SET_BIOS_CERT_GUID,
>  };
>  
> +static struct tlmi_cert_guids thinkcenter_cert_guid = {
> +	.thumbprint = NULL,
> +	.set_bios_setting = LENOVO_TC_SET_BIOS_SETTING_CERT_GUID,
> +	.save_bios_setting = LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID,
> +	.cert_to_password = LENOVO_TC_CERT_TO_PASSWORD_GUID,
> +	.clear_bios_cert = LENOVO_TC_CLEAR_BIOS_CERT_GUID,
> +	.update_bios_cert = LENOVO_TC_UPDATE_BIOS_CERT_GUID,
> +	.set_bios_cert = LENOVO_TC_SET_BIOS_CERT_GUID,
> +};
> +
>  static struct tlmi_cert_guids *cert_guid = &thinkpad_cert_guid;
>  
>  static const struct tlmi_err_codes tlmi_errs[] = {
> @@ -690,6 +707,9 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
>  	const union acpi_object *obj;
>  	acpi_status status;
>  
> +	if (!cert_guid->thumbprint)
> +		return -EOPNOTSUPP;
> +
>  	status = wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input, &output);
>  	if (ACPI_FAILURE(status)) {
>  		kfree(output.pointer);
> @@ -868,8 +888,16 @@ static ssize_t certificate_store(struct kobject *kobj,
>  			return -EACCES;
>  		}
>  		guid = cert_guid->set_bios_cert;
> -		/* Format: 'Certificate, password' */
> -		auth_str = cert_command(setting, new_cert, setting->password);
> +		if (tlmi_priv.thinkcenter_mode) {
> +			/* Format: 'Certificate, password, encoding, kbdlang' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s", new_cert,
> +					     setting->password,
> +					     encoding_options[setting->encoding],
> +					     setting->kbdlang);
> +		} else {
> +			/* Format: 'Certificate, password' */
> +			auth_str = cert_command(setting, new_cert, setting->password);
> +		}
>  	}
>  	kfree(new_cert);
>  	if (!auth_str)
> @@ -1605,6 +1633,16 @@ static int tlmi_analyze(struct wmi_device *wdev)
>  		wmi_has_guid(LENOVO_SAVE_BIOS_SETTING_CERT_GUID))
>  		tlmi_priv.certificate_support = true;
>  
> +	/* ThinkCenter uses different GUIDs for certificate support */
> +	if (wmi_has_guid(LENOVO_TC_SET_BIOS_CERT_GUID) &&
> +	    wmi_has_guid(LENOVO_TC_SET_BIOS_SETTING_CERT_GUID) &&
> +	    wmi_has_guid(LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID)) {
> +		tlmi_priv.certificate_support = true;
> +		tlmi_priv.thinkcenter_mode = true;
> +		cert_guid = &thinkcenter_cert_guid;

Now that this code is more readable :-), I started to wonder why this 
pointer wasn't placed into tlmi_priv?

--
 i.

> +		pr_info("ThinkCenter modified support being used\n");
> +	}
> +
>  	/*
>  	 * Try to find the number of valid settings of this machine
>  	 * and use it to create sysfs attributes.
> @@ -1750,10 +1788,14 @@ static int tlmi_analyze(struct wmi_device *wdev)
>  	}
>  
>  	if (tlmi_priv.certificate_support) {
> -		tlmi_priv.pwd_admin->cert_installed =
> -			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
> -		tlmi_priv.pwd_system->cert_installed =
> -			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
> +		if (tlmi_priv.thinkcenter_mode) {
> +			tlmi_priv.pwd_admin->cert_installed = tlmi_priv.pwdcfg.core.password_mode;
> +		} else {
> +			tlmi_priv.pwd_admin->cert_installed =
> +				tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
> +			tlmi_priv.pwd_system->cert_installed =
> +				tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
> +		}
>  	}
>  	return 0;
>  
> diff --git a/drivers/platform/x86/lenovo/think-lmi.h b/drivers/platform/x86/lenovo/think-lmi.h
> index 9b014644d316..c805ee312539 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.h
> +++ b/drivers/platform/x86/lenovo/think-lmi.h
> @@ -109,6 +109,7 @@ struct think_lmi {
>  	enum save_mode save_mode;
>  	bool save_required;
>  	bool reboot_required;
> +	bool thinkcenter_mode;
>  
>  	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
>  	struct device *class_dev;
> 

