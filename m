Return-Path: <linux-kernel+bounces-790758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799DB3ACA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4E7B76F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4877279DD6;
	Thu, 28 Aug 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="BAV60Rbf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PC0NxvYr"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197417404E;
	Thu, 28 Aug 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415782; cv=none; b=jhD2YRiUO+CnsNeXTE38X4U7G1IlaYm2R0LqoMKy1taKsnoRAzV70OsCfyjga5dKSK0PMaOnB0Dr0qcVpVKaSpxwJr0OD6GwsWxVR6o9RybgiyKMu10eoSLUvxBXqN6zQXowwKJjORcOuI1YW/L3Id/oBHzD8+bzLEc+5+1H7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415782; c=relaxed/simple;
	bh=fBZCZ+oQLbjRmNd66M7G6zBt/GuH8/CfzfRz/YkpzKE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dLAVnQ2x9UL3LUGcnxEeF3qMC1r2B2sYGtJmHv4rhXLAW7fTNViENpl7TYVBbkpDHkZuE83lUjrS8432j7UN2FbQ/JKQI8GLhf2MhRGhcmjl2uRKxhyf2ezwwKo0GtlbN4hd5GU/54BfDpJmF1+HJ8b1ntkBb7zk7FFlKk/+WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=BAV60Rbf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PC0NxvYr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF9F87A015C;
	Thu, 28 Aug 2025 17:16:17 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Thu, 28 Aug 2025 17:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756415777;
	 x=1756502177; bh=sC+uo+u1edHM5E2TQKmnCqaXZR+qwlD3V1wMnF4GRz4=; b=
	BAV60Rbfqanwgfl9SDb8o2Y41+AH+DA0brwij5h663iUdTkWO9LsS4ehXPL4sL63
	VxEORQFDnMcVdnCe3DjVS92KGh2mLWuW63fNdOGQ3gBc36rsjfS2Ike8PL1uIufY
	Jp+hNsOsMCexZEwvTZUSPUE7he1y/vATGYh5LmLJ1MMRfbjxk3hIXT24KUOrHOcB
	dSsle5GNi6rh6u6+ZxcExgADckX2Sp+piimPVeinzw3V5QfqNpCRlZWvDWQ/x3BK
	zOrCA/18mWwWylB6Wn51v9Ib7fxZFR3pEDjZpJe/HUw9FyHGpnu1gAP1+Wqhxr3j
	bccIjV8Db3SxDY/gkAxowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756415777; x=
	1756502177; bh=sC+uo+u1edHM5E2TQKmnCqaXZR+qwlD3V1wMnF4GRz4=; b=P
	C0NxvYrVcasVTdvtMtaDVYne21Q1tHs2KBXZEeL5L1m3KHYWdNdyufadIphcyFIC
	bLcHrs3zjZ8qbzgRBswfz7Y8nQD7YNsQ2N/j8rA1qcqP+RHrXqGDDRRNTfneKT0Y
	qjh626MruMBxunsGpTgnbgqEZRcUU6N6WEYdi5Ea889nDz4SSw44NTs+dR03od8I
	jw3UnRu9tnWvFVLBsU+ascaymeeGmQ9aN7E5JTFBfAWllOSIK01FqlMGAKu6R8Xm
	UN550ywhQj8qok0VSrYhBVp6BsPVfmv6pPXKdFJkYMJp1B1rdY8MOXu2TNK7XcuF
	9EhkbltvGCqSu1YWF84iA==
X-ME-Sender: <xms:IcewaCjxXMBzcpTzdyVAS-kapSrsVlJETZ_QqF2mlJo9AKJCDcSJUA>
    <xme:IcewaDC6ErEcGouIfu7QAe7QRb8eBqUjbJFam_7qS10uwegnA-dMOcwIzpGfQjZuX
    ayj4VuVqUNC-WbtueA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhveekjeeuueekfefhleeljeehuedugfetffdvteek
    ffejudelffdvjeekfeehvdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggrnh
    dttdegkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IcewaPe-6ccYQpI8DQPqtNUyWl6Wgf6fsfrjsV5CIJjsoZxtF2nbeg>
    <xmx:IcewaNqTj6aRANbyTcsCkJuQtpz0FT5NDdhBzFxNTMoIHGbn_vTOCQ>
    <xmx:IcewaI8_3SbwBeBkaDzmlIH7MO9xwfmPCYd_AUDYG0FtFsSd7Qi3UA>
    <xmx:IcewaBdZmFPpH2toAjXHJU3wg1aSMDHshObnb1N_nkVP136PyilwdA>
    <xmx:IcewaK47a15PojshsMxWtCBUaIhLKbgzwp0jlJcT13Dl2dyE5hxlHxaz>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58A322CE0078; Thu, 28 Aug 2025 17:16:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxLiYJmP0NXg
Date: Thu, 28 Aug 2025 17:15:57 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, RenHai <kean0048@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <aec9c6b1-c578-4835-8f48-d1747a7388ab@app.fastmail.com>
In-Reply-To: <a5ecc59a-65bb-a270-9642-f2c59fc958ce@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
 <20250825160351.971852-2-mpearson-lenovo@squebb.ca>
 <a5ecc59a-65bb-a270-9642-f2c59fc958ce@linux.intel.com>
Subject: Re: [PATCH v3 1/3] platform/x86: think-lmi: Add certificate GUID structure
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Aug 28, 2025, at 6:50 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Aug 2025, Mark Pearson wrote:
>
>> Add a certificate GUID structure to make it easier to add different
>> options for other platforms that need different GUIDs.
>>=20
>> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2:
>>  - split patch up into series
>> Changes in v3:
>>  - add field details to thinkpad_cert_guid declare.
>>  - add missing comma
>>  - Move null thumbprint GUID check to later in series
>>=20
>>  drivers/platform/x86/lenovo/think-lmi.c | 38 +++++++++++++++++++----=
--
>>  1 file changed, 30 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platfo=
rm/x86/lenovo/think-lmi.c
>> index 0992b41b6221..a22d25f6d3c6 100644
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
>
> const char
>
yep.

>> +};
>> +
>> +static struct tlmi_cert_guids thinkpad_cert_guid =3D {
>
> These are not supposed to be altered, right? If so, this should be con=
st=20
> then.
>
Weird...I could have sworn I made it a const. I'll fix

>> +	.thumbprint =3D LENOVO_CERT_THUMBPRINT_GUID,
>> +	.set_bios_setting =3D LENOVO_SET_BIOS_SETTING_CERT_GUID,
>> +	.save_bios_setting =3D LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>> +	.cert_to_password =3D LENOVO_CERT_TO_PASSWORD_GUID,
>> +	.clear_bios_cert =3D LENOVO_CLEAR_BIOS_CERT_GUID,
>> +	.update_bios_cert =3D LENOVO_UPDATE_BIOS_CERT_GUID,
>> +	.set_bios_cert =3D LENOVO_SET_BIOS_CERT_GUID,
>> +};
>> +
>> +static struct tlmi_cert_guids *cert_guid =3D &thinkpad_cert_guid;
>
> const here as well. Please also note my comment on placement of this i=
n=20
> patch 2.

Ack.

Thanks for the review
Mark

