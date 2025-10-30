Return-Path: <linux-kernel+bounces-878732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A1C215B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AADB3A8121
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A12E1EEE;
	Thu, 30 Oct 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4GxQwTX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F21DF269
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843488; cv=none; b=fWQ52BLQvfyg52m1KnvLnywBcawEh31ISdquScJvH8/a51lmohWKLkRl8bOggupciO2WtM9mtHmc7NRZq+PiHj9mCGlkjaLQis10DeC8VfjRMSXIgu+P1on4y12wVGkKw3zbqnR7NRRw5y1yV45j+ZYfc+5X1b53XrRmWV8AEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843488; c=relaxed/simple;
	bh=MgfuD+X+reEYsZWWSJ3a5HfuCUcHA0yw6XFi9qUAUpY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rX7St1fpENrLE4sUr+HT8rQQfGmQSqJBvMv8MA0gdCb89CMs5kdvr1hPcpwNeYctPboarfm/XWSm5Nu/RXTii10Y1CY63Zg6ZwFkTqlQRae/4gvh2x3P52wuREVfZkbwqoh5CB56n4EB2KhtcZxctxHpT5BDQKGxUy32o5opTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4GxQwTX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711b95226dso17007425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761843482; x=1762448282; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asHTuwHQMlsaIwxd7fRvxE9E6RLII85FGsjE8sF6u2s=;
        b=d4GxQwTXDRB581EU4H+LtW4s6t8Y6JJjnWMfRYNfJp9osc7p2CgqB7jNeUHSx4wz3v
         44lVaKA+w3Q51rLqPQyzu3/y6EfHg9oONtNpbVqgao4gK3tJw0sYv349/HET+v+fcDSy
         UK+pwR+phrKsGlEO2rRA0IuoIGCQ6iACLiFBXBv2T62RgYVZeeSjdrYbgwiRUtxTZk3X
         VrjZVJU5JnvFDZwUP8W6grHRL5wZJGkoeNiWsOGBwyeS4SoMtGuRcpVZqfoC268Gwrev
         ptYU1N2xTxjdpP4EeMEI8vUm66LTqt3h+5cnIHsgQx0QhRmnSJk365b64+3/DmrEhfau
         T0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843482; x=1762448282;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asHTuwHQMlsaIwxd7fRvxE9E6RLII85FGsjE8sF6u2s=;
        b=RVBgLl1+2kvPuDavCLiogN2uuIKExUfn1IblOGCTVmM1Ucy+74tpxrq/V6TDkVdAnm
         qhguFDFDfuHCqIo4Qiie8xl3bdAdXTOf5wfF4bFilSBD0xi8ZjTVcuqAK9b05lYAxkJ3
         vwncgOzsitMuMhG4/AhRrnsyu/0vEh7v9i0ZZFK9Z1D2XlQfgMFaVqfhD5G0KtVCXhzL
         ng5MJlPum7sFMNW+BoyvWWAO3xjiI9C8m5jZfudqLi69+d88loH7s/deA1ZND6IPoXWm
         GH6xVQrPkunIpV8WkcU2GC+vYaNidm78z+QE+VkQFzbjaMyqzED9/8vxfS/T1eg+R5MD
         Ec+g==
X-Forwarded-Encrypted: i=1; AJvYcCWg80DqCgKhd+KWoujMB6r7OVA5kYJAqPkxu9cU/q8FkYj9+O1zg9MssdxEV3JSdufwZaMn089mM3yitQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBNV/9wKB4K4rFLJoiXleggjZ/05BFycZAjKmUMPEYPBUsJhw
	rTRUmgtIqsPee3lihaxtt5D8/4FS3efc3NgHxrOXdYMkmVMOPv8RoVF3ccEo9+nQT4E=
X-Gm-Gg: ASbGncvd8UMqw3uZuXq+Qvwnm4TyAyz62G+pAEPSyikwf1UoFp6JD1V3ummZvec2jfy
	g/QwXxhpVT+jZ0oJOJKrQwAAg8uR4KYaghe0Z3Ca+EAjlBjUE8pRFUWieYjfw50gXeNBFIx1vSc
	yFhjkQM/ISzouseHxZzj3nd76fOAV2ILz/CP1LyIz2BE8uRcYM5Cz2mWcsyGPFPdX3kl+dYXJ1a
	Jm5cClzOtDlax6LgJplkFvcdypfav4p+Sw8e8bjbjPpeKqlIoHTrunptBfzGWieGBYMmQ3Mcrmn
	5TW9001ZuIaGlGeBPrq8tgZr58UYwdJv1MjUw5W1h4Ra02MdJjCELDJRk4oXskFQQOohNeAOCsF
	mJtKZIF9hEoHd1ziZNznIP0LS23cpNLBYRlL2QtI/wP9zbB9JS/NJ//ZK8SOsLIGzFaigzp0rkq
	iCEYM=
X-Google-Smtp-Source: AGHT+IFqi7Xpp7w622mR0rNuKijgJ6z8TIArkNB6daVO26Go88Si98M7vPyCpKED2icvujDHVbXEhw==
X-Received: by 2002:a05:6000:26c3:b0:427:690:1d84 with SMTP id ffacd0b85a97d-429bd69e14bmr268308f8f.32.1761843482254;
        Thu, 30 Oct 2025 09:58:02 -0700 (PDT)
Received: from localhost ([195.52.63.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm32814036f8f.43.2025.10.30.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=752930e6c5b8c7be54d7a69ae03bc5b16c5525c23708b9d108f2a94d97cf;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 30 Oct 2025 17:57:53 +0100
Message-Id: <DDVTDY4T9I21.2MG05Z8984M5T@baylibre.com>
Cc: "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/3] firmware: ti_sci: Remove constant 0 function
 arguments
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Andrew Davis" <afd@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, "Nishanth Menon" <nm@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Santosh Shilimkar" <ssantosh@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com> <20251030-topic-am62-partialio-v6-12-b4-v9-1-074f55d9c16b@baylibre.com> <1b3f183f-3923-4183-a237-861e4f886958@ti.com>
In-Reply-To: <1b3f183f-3923-4183-a237-861e4f886958@ti.com>

--752930e6c5b8c7be54d7a69ae03bc5b16c5525c23708b9d108f2a94d97cf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Andrew,

On Thu Oct 30, 2025 at 3:13 PM CET, Andrew Davis wrote:
> On 10/30/25 4:26 AM, Markus Schneider-Pargmann (TI.com) wrote:
>> ti_sci_cmd_prepare_sleep takes three arguments ctx_lo, ctx_hi and
>> debug_flags which are always 0 for the caller. Remove these arguments as
>> they are basically unused.
>>=20
>
> They might not be used today, but the TI-SCI command does support
> passing them, so why remove that ability from the wrapper function?

Thank you. I removed the arguments as I prefer something like

  return ti_sci_cmd_prepare_sleep(&info->handle,
                                  TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED);

over

  return ti_sci_cmd_prepare_sleep(&info->handle,
                                  TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
                                  0, 0, 0);

As this function is not part of any API and only used by
ti_sci_prepare_system_suspend I didn't see a problem in removing it.
Also I don't know of any code that will be using these arguments.

If you prefer I can drop this patch.

Best
Markus

>
> Andrew
>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   drivers/firmware/ti_sci.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 49fd2ae01055d0f425062147422471f0fd49e4bd..24ab392b4a5d0460153de76f=
e382371e319d8f2e 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -1661,14 +1661,10 @@ static int ti_sci_cmd_clk_get_freq(const struct =
ti_sci_handle *handle,
>>    * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
>>    * @handle:		pointer to TI SCI handle
>>    * @mode:		Device identifier
>> - * @ctx_lo:		Low part of address for context save
>> - * @ctx_hi:		High part of address for context save
>> - * @debug_flags:	Debug flags to pass to firmware
>>    *
>>    * Return: 0 if all went well, else returns appropriate error value.
>>    */
>> -static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle,=
 u8 mode,
>> -				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
>> +static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle,=
 u8 mode)
>>   {
>>   	struct ti_sci_info *info;
>>   	struct ti_sci_msg_req_prepare_sleep *req;
>> @@ -1696,9 +1692,9 @@ static int ti_sci_cmd_prepare_sleep(const struct t=
i_sci_handle *handle, u8 mode,
>>  =20
>>   	req =3D (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
>>   	req->mode =3D mode;
>> -	req->ctx_lo =3D ctx_lo;
>> -	req->ctx_hi =3D ctx_hi;
>> -	req->debug_flags =3D debug_flags;
>> +	req->ctx_lo =3D 0;
>> +	req->ctx_hi =3D 0;
>> +	req->debug_flags =3D 0;
>>  =20
>>   	ret =3D ti_sci_do_xfer(info, xfer);
>>   	if (ret) {
>> @@ -3689,8 +3685,7 @@ static int ti_sci_prepare_system_suspend(struct ti=
_sci_info *info)
>>   			 * internal use and can be 0
>>   			 */
>>   			return ti_sci_cmd_prepare_sleep(&info->handle,
>> -							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
>> -							0, 0, 0);
>> +							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED);
>>   		} else {
>>   			/* DM Managed is not supported by the firmware. */
>>   			dev_err(info->dev, "Suspend to memory is not supported by the firmw=
are\n");
>>=20


--752930e6c5b8c7be54d7a69ae03bc5b16c5525c23708b9d108f2a94d97cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaQOZERsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOM
vgD/bew27FQMEeji6OeLZOJJgA8vPqrL/NU4DrIdV/zVC98A/iLGQiDwd2GnsjGV
gXIBqqIameTAi7bsnPw9wg9lVhcN
=fkwa
-----END PGP SIGNATURE-----

--752930e6c5b8c7be54d7a69ae03bc5b16c5525c23708b9d108f2a94d97cf--

