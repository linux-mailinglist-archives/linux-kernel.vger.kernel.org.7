Return-Path: <linux-kernel+bounces-790757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E12B3AC9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBC17BB40C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2D2C11D3;
	Thu, 28 Aug 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ADYYOwal";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl2vpdFO"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC092BEFFE;
	Thu, 28 Aug 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415715; cv=none; b=N35wQxtIr2FfJ1U815sQNQOnTZ/BQHoerDgTZIMK0GUD2V324Ay9IZ5lEusRYvd7+8aMzhXxWx4ZmtMtlpfeW7Y4N4YRMSQarS2dorvAh+YSZO7cAKzO/zCO+FpUD27jx+XZ9II4+U0sRoZl1ELHb5MQtqz2Byqua89se1MP0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415715; c=relaxed/simple;
	bh=CPUVEgQSeTykKENWewSgsmVG0XhL9SkBnGOXJrDHTcU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gteZ5ULBvhcIo8QQdSOtPtThfhA2S6GnQpg14+eZl+5WcfzhHcGXaWr8fml2RXAI49xkw54G3Dm6/Wx1udV2HJjlmh0CBgo+O2HfEIUAh3+iX4vvLdop+4ELjWIaf7d/5Se0yMfvIoJ7mNsZowDHtgt2TXwIDuH2M/SD3cJIEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ADYYOwal; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl2vpdFO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DB0C7A0129;
	Thu, 28 Aug 2025 17:15:11 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Thu, 28 Aug 2025 17:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756415711;
	 x=1756502111; bh=pWIT3cH7gMhRZNlHxlbiU66RMHH7NJv9Qg8oSa2T8MA=; b=
	ADYYOwalglNKoPDQh1sH6IthVxlIILIsyN6vLa+QOXKVq9uORlQGAzrBSt+NZw2E
	NcTpDiTUhVTrwQx2TvM0mQExQDuWZDsNAXC2Cl0zAlUIogvYhYoQb5evgkouoBro
	Hj4ZDOE2+hBjwIgEIppwqn+mJ7qAJBEYkAjOoChT1BvcW3qqkcuJJtbehH7Pqggx
	5EB6S6ADkclh8J6J7rYmsxNVDZJLF7LwHMZ3Hw608RLQK6xbRRa/HR0KxIwVJAIj
	vbtZB/gPNRdRBY/9LodqUDviXpM61Fl4yNzdrPFjob8btHMHIF5LYZiC6nh8VC4l
	vhn7gvWVY2v5KP4dH2XXug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756415711; x=
	1756502111; bh=pWIT3cH7gMhRZNlHxlbiU66RMHH7NJv9Qg8oSa2T8MA=; b=k
	l2vpdFO/TIIoV92Q+hHYdUoYBExNzbJe9niu09qytsSTwJqwwaMiCvLKBEaKxWIk
	k/SnA4toXCvPRtBCu7H7EfGL/XGZMOREVIaV/jEYgpE5bA503D2baE12R0vGXBys
	aFid9t9frRE+jaAvLeMcu3RuytvQFO7XtplrH0X3y4YCZbKjZ6U0AAO/OhN0zjvp
	9nruH+McKrbhSyV29FzIhGtoH96UlNyfhswK7UtBS8+qxqvDdQ3uyKbmUMSoZK4+
	E9wZUEd3ygfcQ5J28Ga3jL0AP9LuZCZE19E68LJf71Qd7tWMOUef0GKyFQJIh9ff
	ndJ+CDFRWOdEBh4fBPKqQ==
X-ME-Sender: <xms:3sawaNN4v51NM4hLPv-ITHYd8-hNZO46Tuejwg5x-2szcvHbG_Qoew>
    <xme:3sawaP8fjtW7dO-0CSjPC5pYUzhz_2emZYmEX1YGlaPS_fXSyrWucTPTPbV8cXivm
    eausN3Mv4kAhFI4Kpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:38awaMrmyf-fnUjaxi_YihHNwl1cIHEQVRiOdEfW4cVJTHxcm3k9DA>
    <xmx:38awaLEaTIVgqSMFcwpMogkbLm_PozAilBwxPco3bTOWtNKln9VNAw>
    <xmx:38awaBrTex5er53z8e5t9X6h5qR9LUX1dtQDKfq6lfYw-S80wpMwJA>
    <xmx:38awaEYN0MglEoXMaLKgBYKP5RpdBtZqVJFwZkU643mhRyQ69pGLUQ>
    <xmx:38awaADMJ8UQVFTGaAtBVCV_ZUjZb5lkkwFyDSQdA9DNkTFNBacKKFEU>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DB0E92CE0078; Thu, 28 Aug 2025 17:15:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjRhIq0_sNIg
Date: Thu, 28 Aug 2025 17:14:50 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, RenHai <kean0048@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <76c3ef28-0867-4711-997b-7042ee9ede75@app.fastmail.com>
In-Reply-To: <3894a10e-7b42-771c-3ecb-b4c2240b00ac@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
 <20250825160351.971852-3-mpearson-lenovo@squebb.ca>
 <3894a10e-7b42-771c-3ecb-b4c2240b00ac@linux.intel.com>
Subject: Re: [PATCH v3 2/3] platform/x86: think-lmi: Certificate support for
 ThinkCenter
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Thu, Aug 28, 2025, at 6:46 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Aug 2025, Mark Pearson wrote:
>
>> ThinkCenter platforms use a different set of GUIDs along with some
>> differences in implementation details for their support of
>> certificate based authentication.
>>=20
>> Update the think-lmi driver to work correctly on these platforms.
>>=20
>> Tested on M75q Gen 5.
>>=20
>> Signed-off-by: Kean Ren <kean0048@gmail.com>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2:
>>  - split patch up into series
>> Changes in v3:
>>  - Move check for no thumbprint GUID to this patch
>>  - Add structure fields and missing comma
>>=20
>>  drivers/platform/x86/lenovo/think-lmi.c | 54 ++++++++++++++++++++++-=
--
>>  drivers/platform/x86/lenovo/think-lmi.h |  1 +
>>  2 files changed, 49 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platfo=
rm/x86/lenovo/think-lmi.c
>> index a22d25f6d3c6..3a1cec4625e5 100644
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
>> @@ -197,6 +204,16 @@ static struct tlmi_cert_guids thinkpad_cert_guid=
 =3D {
>>  	.set_bios_cert =3D LENOVO_SET_BIOS_CERT_GUID,
>>  };
>> =20
>> +static struct tlmi_cert_guids thinkcenter_cert_guid =3D {
>> +	.thumbprint =3D NULL,
>> +	.set_bios_setting =3D LENOVO_TC_SET_BIOS_SETTING_CERT_GUID,
>> +	.save_bios_setting =3D LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID,
>> +	.cert_to_password =3D LENOVO_TC_CERT_TO_PASSWORD_GUID,
>> +	.clear_bios_cert =3D LENOVO_TC_CLEAR_BIOS_CERT_GUID,
>> +	.update_bios_cert =3D LENOVO_TC_UPDATE_BIOS_CERT_GUID,
>> +	.set_bios_cert =3D LENOVO_TC_SET_BIOS_CERT_GUID,
>> +};
>> +
>>  static struct tlmi_cert_guids *cert_guid =3D &thinkpad_cert_guid;
>> =20
>>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>> @@ -690,6 +707,9 @@ static ssize_t cert_thumbprint(char *buf, const c=
har *arg, int count)
>>  	const union acpi_object *obj;
>>  	acpi_status status;
>> =20
>> +	if (!cert_guid->thumbprint)
>> +		return -EOPNOTSUPP;
>> +
>>  	status =3D wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input,=
 &output);
>>  	if (ACPI_FAILURE(status)) {
>>  		kfree(output.pointer);
>> @@ -868,8 +888,16 @@ static ssize_t certificate_store(struct kobject =
*kobj,
>>  			return -EACCES;
>>  		}
>>  		guid =3D cert_guid->set_bios_cert;
>> -		/* Format: 'Certificate, password' */
>> -		auth_str =3D cert_command(setting, new_cert, setting->password);
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
>> @@ -1605,6 +1633,16 @@ static int tlmi_analyze(struct wmi_device *wde=
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
>> +		cert_guid =3D &thinkcenter_cert_guid;
>
> Now that this code is more readable :-), I started to wonder why this=20
> pointer wasn't placed into tlmi_priv?
>
I never thought of it. It would be a better place for it.
Will add in v4.

Mark

