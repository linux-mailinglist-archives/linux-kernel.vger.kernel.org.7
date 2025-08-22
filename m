Return-Path: <linux-kernel+bounces-782436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CEB32057
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7AF566CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DC263F3C;
	Fri, 22 Aug 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="HxCNlHze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wcraesde"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE057C9F;
	Fri, 22 Aug 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879334; cv=none; b=OfAb+rmWfnZer8+Mi7gfcm4DQDVOshVEd5uvhwSKtJHVxLSipCHsMsxisASZVgVKYpQIZkCr/gkfLjkE4SwPfYa91Rqxro8t6VSmi01ZVjT70s6EYO8UiBKaKX57pXgvFhpEtL0dp8gKfNsPJEIeecwFoTgsmaZAEJf4fZ2sRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879334; c=relaxed/simple;
	bh=YfiSQxNQgCacavGubcidMSU0rMJYFevUQN7T1HGcdyU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OHdiO3BEs7/oS4eUqT3SfydSASEL6mlGvLmbIxpZGcYrEKqwViFSs77vKEl0gqdhDYPkwvH8eRV4ObT6HWmkVv+k6NNKvfAKrDYVjRaoNmrTKvMigozlYEClCuJ81uWcoqsmZLJieNAYJUIQN1uL6zQBw4g0+cpBDYbATsSHlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=HxCNlHze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wcraesde; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EC2861D00165;
	Fri, 22 Aug 2025 12:15:30 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 12:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1755879330;
	 x=1755965730; bh=T1mOIYEfYUMOamvCbS1jtrw/uZXOucg8s5pPAHjnnn0=; b=
	HxCNlHze8nKeDFV2hz9j05V2gGt8z9Axm8b/yqekBd+PKh+UVFOnkTaEA5TDiube
	RXgcWVgoXWuqG4+XdzIhCz56zYF0N5tJR3gEUqHiWzaqOCc1kRPdyGCj8XAysBma
	vh5EVp8vSPnWXYwuT00M/+gLrXv9ZUMlNZtiXEqtGBYMvQiBMShMFBOJZC7Q9DFS
	fofi3iS20FKkjWfsN5/CTq6eGpX8C8TzbJ913TbfaLhGcCJGu0tz5RXJ7NicuZvY
	cQuJJx+slj23I9LTFzeyvEBcfpCVPK0juKzUZtC3HvD7VnAMVGyqKeVJU1dQUc86
	TpdaweM0dkbX4jT7LBgvZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755879330; x=
	1755965730; bh=T1mOIYEfYUMOamvCbS1jtrw/uZXOucg8s5pPAHjnnn0=; b=W
	craesdeZE28bIcWnBzwl4n86ujf36BemK2k9IjE+V+ZqRXkGuPi9NkqSoi3PJ52P
	mDE7DLKuOkfcYaDePIh/25eRbNv2bEtluPSuoXBWt1jMaW+dLy/R5kRbeL6rScxj
	+t2flzGCq+1S62b2t6Skzj0oX5RI2F9jpEWFquIzG+f3IHQ3Evjdy6aWNHjguizH
	98SMqrZ1Wv9F/Y+HqeSLwpb/F1HCloCGzlti8lGiOgxtokhF55X2vNZPktwVXuJ+
	c/UC4LZ78Qt4deijlhNnaeQ4Rb4j7NSRLFQD+Y226tFh8LqnoGQuoKfnjCG+i8rM
	W5vrrVKYe2SJ0I9Gu1ykQ==
X-ME-Sender: <xms:opeoaJYZbsJWWVOvXRirHVUD8moadqk25qMzNa4TUE3g4pCPosF6Ig>
    <xme:opeoaAbFG6YikDom2OqsOw7pc9bMsEZIESWY6wiQRETpGOWvmYBjZQIbEHHPBSbgP
    -REXoosQ8XW-rvJhE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:opeoaPUqLFEQW9FhXVP7iBy-_X7U5uS-3w-FLr-4epwwLnLCrp4c5w>
    <xmx:opeoaADDBZfRr0Om4pXsR5GR6FlH1U7FP21Tgo0GK6aIiT8ZH3Nf6A>
    <xmx:opeoaL12kyK0tee0nni5PHkDjtjr2AB_LK8x9idHBj9IQ7I9ZYwvlg>
    <xmx:opeoaK0rKfhUP5ys3B0n5JDitn4qrQLmD4SNNEl_g0RXOoc6QYv7Jg>
    <xmx:opeoaMy4eZV-_R_Nd1UhgiSVKtFUWiDr148XiHQD4VZEnMBiYyf4nukU>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 272F42CE0078; Fri, 22 Aug 2025 12:15:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxLiYJmP0NXg
Date: Fri, 22 Aug 2025 12:15:04 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, RenHai <kean0048@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <a601983d-2a49-4119-8e94-bde0f1e949d5@app.fastmail.com>
In-Reply-To: <6d726a7d-b9c7-d4c2-2e1c-4d32f5cda731@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
 <6d726a7d-b9c7-d4c2-2e1c-4d32f5cda731@linux.intel.com>
Subject: Re: [PATCH v2 1/3] platform/x86: think-lmi: Add certificate GUID structure
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Ilpo,

On Fri, Aug 22, 2025, at 11:41 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 22 Aug 2025, Mark Pearson wrote:
>
>> Add a certificate GUID structure to make it easier to add different
>> options for other platforms that need different GUIDs.
>>=20
>> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/platform/x86/lenovo/think-lmi.c | 41 ++++++++++++++++++++---=
--
>>  1 file changed, 33 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platfo=
rm/x86/lenovo/think-lmi.c
>> index 0992b41b6221..88bae5b33c57 100644
>> --- a/drivers/platform/x86/lenovo/think-lmi.c
>> +++ b/drivers/platform/x86/lenovo/think-lmi.c
>> @@ -177,6 +177,28 @@ MODULE_PARM_DESC(debug_support, "Enable debug co=
mmand support");
>>  #define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
>>  #define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
>> =20
>> +struct tlmi_cert_guids {
>> +	char *thumbprint;
>> +	char *set_bios_setting;
>> +	char *save_bios_setting;
>> +	char *cert_to_password;
>> +	char *clear_bios_cert;
>> +	char *update_bios_cert;
>> +	char *set_bios_cert;
>> +};
>> +
>> +static struct tlmi_cert_guids thinkpad_cert_guid =3D {
>> +	LENOVO_CERT_THUMBPRINT_GUID,
>
> Don't use the anonymous initialization but name the members for better=20
> readability.
>
Sure - I will fix that

>> +	LENOVO_SET_BIOS_SETTING_CERT_GUID,
>> +	LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>> +	LENOVO_CERT_TO_PASSWORD_GUID,
>> +	LENOVO_CLEAR_BIOS_CERT_GUID,
>> +	LENOVO_UPDATE_BIOS_CERT_GUID,
>> +	LENOVO_SET_BIOS_CERT_GUID
>
> Always remember to add comma to any non-terminator entry.
>
Yep - will do. Interesting that the checkpatch --strict didn't catch tha=
t one.

> ...And thanks for reworking these, they look so simple now to review. =
:-)
>
It was a good suggestion :)

>> +};
>> +
>> +static struct tlmi_cert_guids *cert_guid =3D &thinkpad_cert_guid;
>> +
>>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>>  	{"Success", 0},
>>  	{"Not Supported", -EOPNOTSUPP},
>> @@ -668,7 +690,10 @@ static ssize_t cert_thumbprint(char *buf, const =
char *arg, int count)
>>  	const union acpi_object *obj;
>>  	acpi_status status;
>> =20
>> -	status =3D wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &=
input, &output);
>> +	if (!cert_guid->thumbprint)
>> +		return -EOPNOTSUPP;
>
> Either mention this in the changelog or move it into the next patch
> that is the one needing the check. The latter of those seems more logi=
cal=20
> as this is the only GUID you're NULL checking.
>
I did debate whether it was patch 1 or 2.
I think you're right...I'll move it to patch 2

> --=20
>  i.
>
>> +
>> +	status =3D wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input,=
 &output);
>>  	if (ACPI_FAILURE(status)) {
>>  		kfree(output.pointer);
>>  		return -EIO;
>> @@ -751,7 +776,7 @@ static ssize_t cert_to_password_store(struct kobj=
ect *kobj,
>>  		kfree_sensitive(passwd);
>>  		return -ENOMEM;
>>  	}
>> -	ret =3D tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
>> +	ret =3D tlmi_simple_call(cert_guid->cert_to_password, auth_str);
>>  	kfree(auth_str);
>>  	kfree_sensitive(passwd);
>> =20
>> @@ -797,7 +822,7 @@ static ssize_t certificate_store(struct kobject *=
kobj,
>>  		if (!auth_str)
>>  			return -ENOMEM;
>> =20
>> -		ret =3D tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
>> +		ret =3D tlmi_simple_call(cert_guid->clear_bios_cert, auth_str);
>>  		kfree(auth_str);
>> =20
>>  		return ret ?: count;
>> @@ -834,7 +859,7 @@ static ssize_t certificate_store(struct kobject *=
kobj,
>>  			kfree(new_cert);
>>  			return -EACCES;
>>  		}
>> -		guid =3D LENOVO_UPDATE_BIOS_CERT_GUID;
>> +		guid =3D cert_guid->update_bios_cert;
>>  		/* Format: 'Certificate,Signature' */
>>  		auth_str =3D cert_command(setting, new_cert, signature);
>>  	} else {
>> @@ -845,7 +870,7 @@ static ssize_t certificate_store(struct kobject *=
kobj,
>>  			kfree(new_cert);
>>  			return -EACCES;
>>  		}
>> -		guid =3D LENOVO_SET_BIOS_CERT_GUID;
>> +		guid =3D cert_guid->set_bios_cert;
>>  		/* Format: 'Certificate, password' */
>>  		auth_str =3D cert_command(setting, new_cert, setting->password);
>>  	}
>> @@ -1071,13 +1096,13 @@ static ssize_t current_value_store(struct kob=
ject *kobj,
>>  			goto out;
>>  		}
>> =20
>> -		ret =3D tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_st=
r);
>> +		ret =3D tlmi_simple_call(cert_guid->set_bios_setting, set_str);
>>  		if (ret)
>>  			goto out;
>>  		if (tlmi_priv.save_mode =3D=3D TLMI_SAVE_BULK)
>>  			tlmi_priv.save_required =3D true;
>>  		else
>> -			ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>> +			ret =3D tlmi_simple_call(cert_guid->save_bios_setting,
>>  					       tlmi_priv.pwd_admin->save_signature);
>>  	} else if (tlmi_priv.opcode_support) {
>>  		/*
>> @@ -1282,7 +1307,7 @@ static ssize_t save_settings_store(struct kobje=
ct *kobj, struct kobj_attribute *
>>  				ret =3D -EINVAL;
>>  				goto out;
>>  			}
>> -			ret =3D tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>> +			ret =3D tlmi_simple_call(cert_guid->save_bios_setting,
>>  					       tlmi_priv.pwd_admin->save_signature);
>>  			if (ret)
>>  				goto out;
>>

