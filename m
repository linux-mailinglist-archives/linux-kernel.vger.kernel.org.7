Return-Path: <linux-kernel+bounces-776355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79233B2CC56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421583B984B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77F31B137;
	Tue, 19 Aug 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FH+5H8F1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtIH7w2O"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AA319844;
	Tue, 19 Aug 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629176; cv=none; b=VbyhqfAH9slsYsYcuVyQQCSarmE97QQozPSFLpJUurs34h8EWxQ7FxqWGZow6+t9QUkdEXA0RVedn8t40RKpLkOCo4q9wYz2ngP+57E+VBu/unCUgylqAp+u6yuG4cef9Jqh6H1/53e9R5j4A9jpqhMevZsn1l4jxepmNBPIERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629176; c=relaxed/simple;
	bh=vPdNKNa7JOORdsQN03M6M/20RrXXYtwLpxSjjNmhE+U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DQBUEqdgwoSpgbwvxAaIPj3enAKYxZU9rZu4EgiuRCuKuESIE7+2egbWelPgSSJhAmJ7w/IwCn4EAXahxQUdh/7jT0ziS5SXen87FxUtLxQRtoHr/p1edfi1Gnu6/PotZ8kEOId6KmMlLKG23/xh8Fx7yHwU6QcVQnlEwwKRrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FH+5H8F1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtIH7w2O; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id AE0CB1D00251;
	Tue, 19 Aug 2025 14:46:12 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 14:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1755629172;
	 x=1755715572; bh=pKortGbAXHFmBAtAdfq0nwaJITJtuPgg3tWHGe7ZdsU=; b=
	FH+5H8F1QKjVxbTcvYHKk1QzAEJXn/TGrCVFibqDXxU6jjIqXlhlZuZSAGBQbEyd
	00bsaqvtsOMWGRPgMuqxLcBonUxguF1kvOoYH0xjh9gG1T+Qp4IXWiLkZ4gBEadA
	9jrOatIPBGMWaFQxOgQ5j41wQ/W0pCdBYh/yfRJ81IPt5iubqmC+imVNoiKPmba8
	URA7aH+CNgRGBgYS9MCVFimHpSkBS6klGj8UEHaC7fUqUK7CHL1MJ7egW2cu7V2N
	xfvWJaMatcFraaHVcv6hOZuxikhzjhKsF1pvAoaUH7NR8chLW/Mg29pQop0BYSxb
	O0/Zr5sPuH5neQD76M+BSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755629172; x=
	1755715572; bh=pKortGbAXHFmBAtAdfq0nwaJITJtuPgg3tWHGe7ZdsU=; b=M
	tIH7w2OcW5pZ2wUmlvc0IPiKQ8ENqMvf3ld4IycfU7YziHPgkeJ7hwJNERs1/+Bx
	xh1bndgMmtairD2QKLaE6umIJwaCWiJw7mnt6yAM3yFptAo5JBzAmLnuWY7Lzo8R
	PSFk0zWX3bCtTMJSDSMEx8cCo03n0XB2+TCKMpl9CdnM0/S3l/Ap/hYUPuekPhWV
	ohCeQn/slw9cC66UbXuCczas5z471h5sAJmyP2zPsSDnOnyUCrnfJ9VX+/l2spwW
	WKS28+zi7+eIaIwI5+2JSha2796H1gOictEbLHHnU4dI3QUutBc8mFVRaiBAHgPP
	9mWed8TUOLrxJ12QLDedQ==
X-ME-Sender: <xms:c8akaN-IX4ItkhBupZ66Tuq36znTIo9wzo7wOvx3TF-_GXoer0cdWA>
    <xme:c8akaBu9Ly-KMQ3IYfblq3lDcCNxdoovO72puiaF-Lf9h9n1gplM2W8LQp79JRE5f
    wMK3nZ2mSY7-vfnINk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeivdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhveekjeeuueekfefhleeljeehuedugfetffdvteek
    ffejudelffdvjeekfeehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggrnh
    dttdegkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c8akaHacClpn0aOvjgIiC1DtvY0aR66t8qlCjnWub2_HSTA8rASWMA>
    <xmx:c8akaO38obhn_o0HhnggaEVWFS96kjRN_kNGNXnbCTHAQIwnzl5wxQ>
    <xmx:c8akaKYOn7qUmOGKfXB721fG_DnohsTdVgityStcLY--zW7t3OdCxA>
    <xmx:c8akaOIvYDg2GptmS_bxylB6XYnO4LTEiJTNcxxtcgdzSG8cxudl9Q>
    <xmx:dMakaHwMVukBS7mXekntqJUr0hA5SCbr1XaZprTs0elPaZv3LOZ1oTME>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA4812CE0071; Tue, 19 Aug 2025 14:46:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjRhIq0_sNIg
Date: Tue, 19 Aug 2025 14:45:51 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, RenHai <kean0048@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <0e274b29-ac88-4806-a4e1-6f1e38bf42c6@app.fastmail.com>
In-Reply-To: <8841e7c7-b181-67a0-c2a6-0b31fd38c4f0@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250801142648.3752293-1-mpearson-lenovo@squebb.ca>
 <8841e7c7-b181-67a0-c2a6-0b31fd38c4f0@linux.intel.com>
Subject: Re: [PATCH] platform/x86: think-lmi: Certificate support for ThinkCenter
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Tue, Aug 19, 2025, at 6:15 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 1 Aug 2025, Mark Pearson wrote:
>
>> ThinkCenter platforms use a different set of GUIDs along with some
>> differences in implementation details for their support of
>> certificate based authentication.
>>=20
>> Update the think-lmi driver to work correctly on these platforms.
>>=20
>> Tested on M75q Gen 5
>
> Missing .
Ack
>
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Co-developed by: Kean Ren <kean0048@gmail.com>
>
> Missing -.
Oops. Will fix

>
> Also, any change which is developed by multiple people should have the
> signed-off-by for all its developers. Effectively, Co-d-b is always to=
 be=20
> paired S-o-b (obviously the other person should be okay with it, don't=20
> invent S-o-b just to please the procedure :-) as it has certain legal=20
> significance).
>
> You should also put your SoB as last.
Ack. Will update

>
>> ---
>>  drivers/platform/x86/lenovo/think-lmi.c | 85 +++++++++++++++++++++--=
--
>>  drivers/platform/x86/lenovo/think-lmi.h |  1 +
>>  2 files changed, 72 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platfo=
rm/x86/lenovo/think-lmi.c
>> index 0992b41b6221..08eac6c18688 100644
>> --- a/drivers/platform/x86/lenovo/think-lmi.c
>> +++ b/drivers/platform/x86/lenovo/think-lmi.c
>> @@ -119,6 +119,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug com=
mand support");
>>   * You must reboot the computer before the changes will take effect.
>>   */
>>  #define LENOVO_SET_BIOS_CERT_GUID    "26861C9F-47E9-44C4-BD8B-DFE7FA=
2610FE"
>> +#define LENOVO_TC_SET_BIOS_CERT_GUID "955aaf7d-8bc4-4f04-90aa-974695=
12f167"
>> =20
>>  /*
>>   * Name: UpdateBiosCert
>> @@ -128,6 +129,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug com=
mand support");
>>   * You must reboot the computer before the changes will take effect.
>>   */
>>  #define LENOVO_UPDATE_BIOS_CERT_GUID "9AA3180A-9750-41F7-B9F7-D5D3B1=
BAC3CE"
>> +#define LENOVO_TC_UPDATE_BIOS_CERT_GUID "5f5bbbb2-c72f-4fb8-8129-228=
eef4fdbed"
>> =20
>>  /*
>>   * Name: ClearBiosCert
>> @@ -137,6 +139,8 @@ MODULE_PARM_DESC(debug_support, "Enable debug com=
mand support");
>>   * You must reboot the computer before the changes will take effect.
>>   */
>>  #define LENOVO_CLEAR_BIOS_CERT_GUID  "B2BC39A7-78DD-4D71-B059-A510DE=
C44890"
>> +#define LENOVO_TC_CLEAR_BIOS_CERT_GUID  "97849cb6-cb44-42d1-a750-26a=
596a9eec4"
>> +
>>  /*
>>   * Name: CertToPassword
>>   * Description: Switch from certificate to password authentication.
>> @@ -145,6 +149,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug com=
mand support");
>>   * You must reboot the computer before the changes will take effect.
>>   */
>>  #define LENOVO_CERT_TO_PASSWORD_GUID "0DE8590D-5510-4044-9621-77C227=
F5A70D"
>> +#define LENOVO_TC_CERT_TO_PASSWORD_GUID "ef65480d-38c9-420d-b700-ab3=
d6c8ebaca"
>> =20
>>  /*
>>   * Name: SetBiosSettingCert
>> @@ -153,6 +158,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug com=
mand support");
>>   * Format: "Item,Value,Signature"
>>   */
>>  #define LENOVO_SET_BIOS_SETTING_CERT_GUID  "34A008CC-D205-4B62-9E67-=
31DFA8B90003"
>> +#define LENOVO_TC_SET_BIOS_SETTING_CERT_GUID  "19ecba3b-b318-4192-a8=
9b-43d94bc60cea"
>> =20
>>  /*
>>   * Name: SaveBiosSettingCert
>> @@ -161,6 +167,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug com=
mand support");
>>   * Format: "Signature"
>>   */
>>  #define LENOVO_SAVE_BIOS_SETTING_CERT_GUID "C050FB9D-DF5F-4606-B066-=
9EFC401B2551"
>> +#define LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID "0afaf46f-7cca-450a-b4=
55-a826a0bf1af5"
>> =20
>>  /*
>>   * Name: CertThumbprint
>> @@ -170,6 +177,14 @@ MODULE_PARM_DESC(debug_support, "Enable debug co=
mmand support");
>>   */
>>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318=
176C4"
>> =20
>> +char *cert_thumbprint_guid =3D LENOVO_CERT_THUMBPRINT_GUID;
>> +char *set_bios_setting_cert_guid =3D LENOVO_SET_BIOS_SETTING_CERT_GU=
ID;
>> +char *save_bios_setting_cert_guid =3D LENOVO_SAVE_BIOS_SETTING_CERT_=
GUID;
>> +char *cert_to_password_guid =3D LENOVO_CERT_TO_PASSWORD_GUID;
>> +char *clear_bios_cert_guid =3D LENOVO_CLEAR_BIOS_CERT_GUID;
>> +char *update_bios_cert_guid =3D LENOVO_UPDATE_BIOS_CERT_GUID;
>> +char *set_bios_cert_guid =3D LENOVO_SET_BIOS_CERT_GUID;
>> +
>
> These should be static, no?
Good point. Will update.

>
>>  #define TLMI_POP_PWD  BIT(0) /* Supervisor */
>>  #define TLMI_PAP_PWD  BIT(1) /* Power-on */
>>  #define TLMI_HDD_PWD  BIT(2) /* HDD/NVME */
>> @@ -179,9 +194,20 @@ MODULE_PARM_DESC(debug_support, "Enable debug co=
mmand support");
>> =20
>>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>>  	{"Success", 0},
>> +	{"Set Certificate operation was successful.", 0},
>>  	{"Not Supported", -EOPNOTSUPP},
>>  	{"Invalid Parameter", -EINVAL},
>>  	{"Access Denied", -EACCES},
>> +	{"Set Certificate operation failed with status:Invalid Parameter.",=
 -EINVAL},
>> +	{"Set Certificate operation failed with status:Invalid certificate =
type.", -EINVAL},
>> +	{"Set Certificate operation failed with status:Invalid password for=
mat.", -EINVAL},
>> +	{"Set Certificate operation failed with status:Password retry count=
 exceeded.", -EACCES},
>> +	{"Set Certificate operation failed with status:Password Invalid.", =
-EACCES},
>> +	{"Set Certificate operation failed with status:Operation aborted.",=
 -EBUSY},
>> +	{"Set Certificate operation failed with status:No free slots to wri=
te.", -ENOSPC},
>> +	{"Set Certificate operation failed with status:Certificate not foun=
d.", -EEXIST},
>> +	{"Set Certificate operation failed with status:Internal error.", -E=
FAULT},
>> +	{"Set Certificate operation failed with status:Certificate too larg=
e.", -EFBIG},
>>  	{"System Busy", -EBUSY},
>>  };
>> =20
>> @@ -668,7 +694,10 @@ static ssize_t cert_thumbprint(char *buf, const =
char *arg, int count)
>>  	const union acpi_object *obj;
>>  	acpi_status status;
>> =20
>> -	status =3D wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &=
input, &output);
>> +	if (!cert_thumbprint_guid)
>> +		return -EOPNOTSUPP;
>> +
>> +	status =3D wmi_evaluate_method(cert_thumbprint_guid, 0, 0, &input, =
&output);
>>  	if (ACPI_FAILURE(status)) {
>>  		kfree(output.pointer);
>>  		return -EIO;
>> @@ -751,7 +780,7 @@ static ssize_t cert_to_password_store(struct kobj=
ect *kobj,
>>  		kfree_sensitive(passwd);
>>  		return -ENOMEM;
>>  	}
>> -	ret =3D tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
>> +	ret =3D tlmi_simple_call(cert_to_password_guid, auth_str);
>>  	kfree(auth_str);
>>  	kfree_sensitive(passwd);
>> =20
>> @@ -797,7 +826,7 @@ static ssize_t certificate_store(struct kobject *=
kobj,
>>  		if (!auth_str)
>>  			return -ENOMEM;
>> =20
>> -		ret =3D tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
>> +		ret =3D tlmi_simple_call(clear_bios_cert_guid, auth_str);
>>  		kfree(auth_str);
>> =20
>>  		return ret ?: count;
>> @@ -834,7 +863,7 @@ static ssize_t certificate_store(struct kobject *=
kobj,
>>  			kfree(new_cert);
>>  			return -EACCES;
>>  		}
>> -		guid =3D LENOVO_UPDATE_BIOS_CERT_GUID;
>> +		guid =3D update_bios_cert_guid;
>>  		/* Format: 'Certificate,Signature' */
>>  		auth_str =3D cert_command(setting, new_cert, signature);
>>  	} else {
>> @@ -845,9 +874,17 @@ static ssize_t certificate_store(struct kobject =
*kobj,
>>  			kfree(new_cert);
>>  			return -EACCES;
>>  		}
>> -		guid =3D LENOVO_SET_BIOS_CERT_GUID;
>> -		/* Format: 'Certificate, password' */
>> -		auth_str =3D cert_command(setting, new_cert, setting->password);
>> +		guid =3D set_bios_cert_guid;
>> +		if (tlmi_priv.thinkcenter_mode) {
>> +			/* Format: 'Certificate, password, encoding, kbdlang' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s,%s,%s", new_cert,
>> +					     setting->password,
>> +					     encoding_options[setting->encoding],
>> +					     setting->kbdlang);
>> +		} else {
>> +			/* Format: 'Certificate, password' */
>> +			auth_str =3D cert_command(setting, new_cert, setting->password);
>> +		}
>>  	}
>>  	kfree(new_cert);
>>  	if (!auth_str)
>> @@ -1071,13 +1108,13 @@ static ssize_t current_value_store(struct kob=
ject *kobj,
>>  			goto out;
>>  		}
>> =20
>> -		ret =3D tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_st=
r);
>> +		ret =3D tlmi_simple_call(set_bios_setting_cert_guid, set_str);
>>  		if (ret)
>>  			goto out;
>>  		if (tlmi_priv.save_mode =3D=3D TLMI_SAVE_BULK)
>>  			tlmi_priv.save_required =3D true;
>>  		else
>> -			ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>> +			ret =3D tlmi_simple_call(save_bios_setting_cert_guid,
>
> Could you please these conversions in a preparatory patch. Then add th=
e=20
> new stuff in the second patch.

Sure. Will do

>
>>  					       tlmi_priv.pwd_admin->save_signature);
>>  	} else if (tlmi_priv.opcode_support) {
>>  		/*
>> @@ -1282,7 +1319,7 @@ static ssize_t save_settings_store(struct kobje=
ct *kobj, struct kobj_attribute *
>>  				ret =3D -EINVAL;
>>  				goto out;
>>  			}
>> -			ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>> +			ret =3D tlmi_simple_call(save_bios_setting_cert_guid,
>>  					       tlmi_priv.pwd_admin->save_signature);
>>  			if (ret)
>>  				goto out;
>> @@ -1583,6 +1620,22 @@ static int tlmi_analyze(struct wmi_device *wde=
v)
>>  		wmi_has_guid(LENOVO_SAVE_BIOS_SETTING_CERT_GUID))
>>  		tlmi_priv.certificate_support =3D true;
>> =20
>> +	/* ThinkCenter uses different GUIDs for certificate support */
>> +	if (wmi_has_guid(LENOVO_TC_SET_BIOS_CERT_GUID) &&
>> +	    wmi_has_guid(LENOVO_TC_SET_BIOS_SETTING_CERT_GUID) &&
>> +	    wmi_has_guid(LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID)) {
>> +		tlmi_priv.certificate_support =3D true;
>> +		tlmi_priv.thinkcenter_mode =3D true;
>> +		cert_thumbprint_guid =3D 0; /* Not supported */
>> +		set_bios_setting_cert_guid =3D LENOVO_TC_SET_BIOS_SETTING_CERT_GUI=
D;
>> +		save_bios_setting_cert_guid =3D LENOVO_TC_SAVE_BIOS_SETTING_CERT_G=
UID;
>> +		cert_to_password_guid =3D LENOVO_TC_CERT_TO_PASSWORD_GUID;
>> +		clear_bios_cert_guid =3D LENOVO_TC_CLEAR_BIOS_CERT_GUID;
>> +		update_bios_cert_guid =3D LENOVO_TC_UPDATE_BIOS_CERT_GUID;
>> +		set_bios_cert_guid =3D LENOVO_TC_SET_BIOS_CERT_GUID;
>> +		pr_info("ThinkCenter modified support being used\n");
>
> This looks like you'd want to have a single (const?) struct which hold=
s=20
> all this information so you'd not need to assign a gazillion of pointe=
rs.

hadn't thought of doing it that way, six pointers didn't seem too bad :)
I'll have a look at that approach.

Thanks for the review
Mark

