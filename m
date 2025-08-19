Return-Path: <linux-kernel+bounces-775397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE84B2BEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D973B680CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435032765F5;
	Tue, 19 Aug 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVP6+E4D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3627145F;
	Tue, 19 Aug 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598520; cv=none; b=TYtHWIwAeVNaEBrNAWoVgUqRLj9VBGcYFHiChaJdLRtFBvv8kFGxfUzqqkKKKAsSoyVu3/hmeDjj5TEZ5S2hEpDHzzq2WInbO3JW0eytntxmxD+mC/9p+yenJBxfJLLtp0qdisovtAJRAsBvYdOf6OvVTDe/qHq05PEyPYATB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598520; c=relaxed/simple;
	bh=cedxV3HOBeHsxmgpHzEoXkEyW6zbmGu21WzlcSfqhiI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mqqczbSPut8fwzbMDVUYoCsEEhmTpRgfCSaGq5g/YRWiu1adRP7lhYCpdHlrgzSL/NGXt/RA5BbvnBtNsp9olqbQTuuJlVzBsYHE1ucrdLe8PGwjmEEIqAxwf2rm5jEnrcFDX3mBHSN8HTYPUyqojNgdjmdFEqUlVJXn+4rYQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVP6+E4D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755598518; x=1787134518;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cedxV3HOBeHsxmgpHzEoXkEyW6zbmGu21WzlcSfqhiI=;
  b=mVP6+E4DbSngW5FtAS58Mt2j5ODYvDopX46bkDzwXUfuGTaAZIS2VAAm
   5QCAbFPh/7wH1soM+aLlnIpA3utEwiB9KmYVZEbQ4jgAVWw8sb4B2aEVT
   lXldUkm5KFDRmwSh8/kkGoRHBuJUI+x28EMz4e7MgALIEOWYzx2PsdirQ
   3U2r/UW01dwyeo77PFvkK77n/wQuogwRwCemzcAb6O3RiWc+gJd68QF0E
   7zQ/IVduxhrV3pANGkq9r+Tu4tQnCIQ+bFd4kSVbv4/VxVdHaf3KNXmC3
   17yPE16OcMEq5MeNxdRmC4ugslW/Z1UQ4Mwl04CDdnl3+7ZVGWvEWL89+
   Q==;
X-CSE-ConnectionGUID: R0xqj79MTZyfuhh5vDPx6w==
X-CSE-MsgGUID: Q0OlFq75QJqVwMYLAEnLcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="56866064"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="56866064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 03:15:17 -0700
X-CSE-ConnectionGUID: UoFm2TOcQay2kbUpT+giqQ==
X-CSE-MsgGUID: QOC77mZSSFaGoPAklROiYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="173172924"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 03:15:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Aug 2025 13:15:11 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: hansg@kernel.org, kean0048@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: think-lmi: Certificate support for
 ThinkCenter
In-Reply-To: <20250801142648.3752293-1-mpearson-lenovo@squebb.ca>
Message-ID: <8841e7c7-b181-67a0-c2a6-0b31fd38c4f0@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20250801142648.3752293-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 1 Aug 2025, Mark Pearson wrote:

> ThinkCenter platforms use a different set of GUIDs along with some
> differences in implementation details for their support of
> certificate based authentication.
> 
> Update the think-lmi driver to work correctly on these platforms.
> 
> Tested on M75q Gen 5

Missing .

> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Co-developed by: Kean Ren <kean0048@gmail.com>

Missing -.

Also, any change which is developed by multiple people should have the
signed-off-by for all its developers. Effectively, Co-d-b is always to be 
paired S-o-b (obviously the other person should be okay with it, don't 
invent S-o-b just to please the procedure :-) as it has certain legal 
significance).

You should also put your SoB as last.

> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 85 +++++++++++++++++++++----
>  drivers/platform/x86/lenovo/think-lmi.h |  1 +
>  2 files changed, 72 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
> index 0992b41b6221..08eac6c18688 100644
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
> @@ -170,6 +177,14 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   */
>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
>  
> +char *cert_thumbprint_guid = LENOVO_CERT_THUMBPRINT_GUID;
> +char *set_bios_setting_cert_guid = LENOVO_SET_BIOS_SETTING_CERT_GUID;
> +char *save_bios_setting_cert_guid = LENOVO_SAVE_BIOS_SETTING_CERT_GUID;
> +char *cert_to_password_guid = LENOVO_CERT_TO_PASSWORD_GUID;
> +char *clear_bios_cert_guid = LENOVO_CLEAR_BIOS_CERT_GUID;
> +char *update_bios_cert_guid = LENOVO_UPDATE_BIOS_CERT_GUID;
> +char *set_bios_cert_guid = LENOVO_SET_BIOS_CERT_GUID;
> +

These should be static, no?

>  #define TLMI_POP_PWD  BIT(0) /* Supervisor */
>  #define TLMI_PAP_PWD  BIT(1) /* Power-on */
>  #define TLMI_HDD_PWD  BIT(2) /* HDD/NVME */
> @@ -179,9 +194,20 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>  
>  static const struct tlmi_err_codes tlmi_errs[] = {
>  	{"Success", 0},
> +	{"Set Certificate operation was successful.", 0},
>  	{"Not Supported", -EOPNOTSUPP},
>  	{"Invalid Parameter", -EINVAL},
>  	{"Access Denied", -EACCES},
> +	{"Set Certificate operation failed with status:Invalid Parameter.", -EINVAL},
> +	{"Set Certificate operation failed with status:Invalid certificate type.", -EINVAL},
> +	{"Set Certificate operation failed with status:Invalid password format.", -EINVAL},
> +	{"Set Certificate operation failed with status:Password retry count exceeded.", -EACCES},
> +	{"Set Certificate operation failed with status:Password Invalid.", -EACCES},
> +	{"Set Certificate operation failed with status:Operation aborted.", -EBUSY},
> +	{"Set Certificate operation failed with status:No free slots to write.", -ENOSPC},
> +	{"Set Certificate operation failed with status:Certificate not found.", -EEXIST},
> +	{"Set Certificate operation failed with status:Internal error.", -EFAULT},
> +	{"Set Certificate operation failed with status:Certificate too large.", -EFBIG},
>  	{"System Busy", -EBUSY},
>  };
>  
> @@ -668,7 +694,10 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
>  	const union acpi_object *obj;
>  	acpi_status status;
>  
> -	status = wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &input, &output);
> +	if (!cert_thumbprint_guid)
> +		return -EOPNOTSUPP;
> +
> +	status = wmi_evaluate_method(cert_thumbprint_guid, 0, 0, &input, &output);
>  	if (ACPI_FAILURE(status)) {
>  		kfree(output.pointer);
>  		return -EIO;
> @@ -751,7 +780,7 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
>  		kfree_sensitive(passwd);
>  		return -ENOMEM;
>  	}
> -	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
> +	ret = tlmi_simple_call(cert_to_password_guid, auth_str);
>  	kfree(auth_str);
>  	kfree_sensitive(passwd);
>  
> @@ -797,7 +826,7 @@ static ssize_t certificate_store(struct kobject *kobj,
>  		if (!auth_str)
>  			return -ENOMEM;
>  
> -		ret = tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
> +		ret = tlmi_simple_call(clear_bios_cert_guid, auth_str);
>  		kfree(auth_str);
>  
>  		return ret ?: count;
> @@ -834,7 +863,7 @@ static ssize_t certificate_store(struct kobject *kobj,
>  			kfree(new_cert);
>  			return -EACCES;
>  		}
> -		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
> +		guid = update_bios_cert_guid;
>  		/* Format: 'Certificate,Signature' */
>  		auth_str = cert_command(setting, new_cert, signature);
>  	} else {
> @@ -845,9 +874,17 @@ static ssize_t certificate_store(struct kobject *kobj,
>  			kfree(new_cert);
>  			return -EACCES;
>  		}
> -		guid = LENOVO_SET_BIOS_CERT_GUID;
> -		/* Format: 'Certificate, password' */
> -		auth_str = cert_command(setting, new_cert, setting->password);
> +		guid = set_bios_cert_guid;
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
> @@ -1071,13 +1108,13 @@ static ssize_t current_value_store(struct kobject *kobj,
>  			goto out;
>  		}
>  
> -		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
> +		ret = tlmi_simple_call(set_bios_setting_cert_guid, set_str);
>  		if (ret)
>  			goto out;
>  		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
>  			tlmi_priv.save_required = true;
>  		else
> -			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +			ret = tlmi_simple_call(save_bios_setting_cert_guid,

Could you please these conversions in a preparatory patch. Then add the 
new stuff in the second patch.

>  					       tlmi_priv.pwd_admin->save_signature);
>  	} else if (tlmi_priv.opcode_support) {
>  		/*
> @@ -1282,7 +1319,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
>  				ret = -EINVAL;
>  				goto out;
>  			}
> -			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +			ret = tlmi_simple_call(save_bios_setting_cert_guid,
>  					       tlmi_priv.pwd_admin->save_signature);
>  			if (ret)
>  				goto out;
> @@ -1583,6 +1620,22 @@ static int tlmi_analyze(struct wmi_device *wdev)
>  		wmi_has_guid(LENOVO_SAVE_BIOS_SETTING_CERT_GUID))
>  		tlmi_priv.certificate_support = true;
>  
> +	/* ThinkCenter uses different GUIDs for certificate support */
> +	if (wmi_has_guid(LENOVO_TC_SET_BIOS_CERT_GUID) &&
> +	    wmi_has_guid(LENOVO_TC_SET_BIOS_SETTING_CERT_GUID) &&
> +	    wmi_has_guid(LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID)) {
> +		tlmi_priv.certificate_support = true;
> +		tlmi_priv.thinkcenter_mode = true;
> +		cert_thumbprint_guid = 0; /* Not supported */
> +		set_bios_setting_cert_guid = LENOVO_TC_SET_BIOS_SETTING_CERT_GUID;
> +		save_bios_setting_cert_guid = LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID;
> +		cert_to_password_guid = LENOVO_TC_CERT_TO_PASSWORD_GUID;
> +		clear_bios_cert_guid = LENOVO_TC_CLEAR_BIOS_CERT_GUID;
> +		update_bios_cert_guid = LENOVO_TC_UPDATE_BIOS_CERT_GUID;
> +		set_bios_cert_guid = LENOVO_TC_SET_BIOS_CERT_GUID;
> +		pr_info("ThinkCenter modified support being used\n");

This looks like you'd want to have a single (const?) struct which holds 
all this information so you'd not need to assign a gazillion of pointers.

> +	}
> +
>  	/*
>  	 * Try to find the number of valid settings of this machine
>  	 * and use it to create sysfs attributes.
> @@ -1728,10 +1781,14 @@ static int tlmi_analyze(struct wmi_device *wdev)
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

-- 
 i.


