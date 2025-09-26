Return-Path: <linux-kernel+bounces-833811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEABA320C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FF118960F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB614299957;
	Fri, 26 Sep 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DDF6Jxsd"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A148273D84
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878723; cv=none; b=J1gVAXjien5LpN0GA0wLQP7Tda3iQk3yPPfwjS79xgwLxlcE+GUE33Jm1w21bkgdbtIkTmuLWQ6Olz4gjMJLSuhmoGgPmlqookRBtpZ56C/ZF+rn955VCRtcGWPthMZixAGKlyGW7mdB879XgCVTx0m+REpAMpZqZf7H8BljcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878723; c=relaxed/simple;
	bh=aq52oxwiEOPcD70sX6s/Qc0mFvOa6m5PPMClwOZV8M4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Zn2cwHzHeIE9WW6fobQP0zE0V2AhurZ80AiExFcvKV+Ks6r58MpYOlktSQkPxGegm9sLQE5drHxR/lRQjCZHqpNPNlcmyPStqBVlEbp9Yvr/fx3mytzMQr7iuD6F6p/YziXlvwVJjAktxkRQDBmymxUuK6flGajm7L6D7rje8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DDF6Jxsd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so356556966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758878718; x=1759483518; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/7KnSoEHO6Q+y10Pw4nJ0Fx1mX0Xj32P5DNhE4ALAw=;
        b=DDF6JxsdEc0b6Rgcmstl43JRgu4dd5OF20BVcQ8pEX3AYiuVkJ9f1A3DzTSvWI+YyY
         NVN/X/Mq2MK6jLU455IjHH5ELe+loB72n4tP6gtV1AXrHg/dXoVMt/s2U6r7A/BYKknL
         xdypvKtSr+K6V3b6OiU4kLM+gwyZr7OTz1tnlmfE3WJ5cyG3+vCuJy3aoyQf+eGfTqxu
         rLamAWs6ldalMdV98wHQDTmcifVtyhScqkoisyDNug4Q/LPDwUWJ3y+AiIn2rlIgc19m
         wp5qHqvPU+2MnvFoZHRsQj4eN5/yw/ggbUhfl0ojxFNh/Nbo1Zv1xXHHeHBMTN9R4mZV
         L/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878718; x=1759483518;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/7KnSoEHO6Q+y10Pw4nJ0Fx1mX0Xj32P5DNhE4ALAw=;
        b=XZBVaCUpORsuEIqqHhZkezZQrHBSiud4XLtwgigzafWMEuqxAs9DeHG5t385v4fUsS
         GwdfAGJDy1mOBGHrOGvo1oM6QK2j+E2Fus05l3TO3gYtMgfwl0YKfWN2V/fR0Gj9nXJW
         qXA2eX24YIViFx6t0pivwkToFdrHBmUqK+4VTBTfOIzKZPYC7Fi4qFrb5W65pB7Aw2XO
         RfKA5Mn7V9zP0DigAEs6DP7LEV8HCX0NEt7jpz/XeEJLyOt7ZCSsVTLqzFZNTMheUzpS
         mrKDV3PpvrOnff0xb2VZadEWTg6oN2F9hHIvMEcdebHD+jayc9+PJPi2MBQwmfQQdEjn
         Bnhg==
X-Forwarded-Encrypted: i=1; AJvYcCVffD6aQEReNwgXDruULqFCIQi++W+iuB2LpVhBD9aU+Q/Uhei0LjvE1wmiBSihc9vmlPuLYvgZX7c+9XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS3BM27ARXw8tl3ongiicVwtwSa0jV+hbKMGYESZHSIE7P3NYg
	6fdni2YdpR+U5UktVxOenmUhL5ilofFRoZqAsQTQB7rXuhwh7jewjOLJiFVMhblfV6s=
X-Gm-Gg: ASbGncuS/teegdV1eOrTpeO2oS9hssaWv+YY6F1kc3wL0l67pjjpmqvxfP9Sw2n0XKM
	keSt9quH3vQNUd+nZ5IPvN0KTxGFCdo8mDdtoeq5FA3cUzjmHhv4w9uMt8fC0dFL8/AqbWCGvHa
	BdnDSrrXPaChIbuIjOPeFB+XgFc00esNoPFEpMEsKvT0f3Y/fRcz77W7qe4j8HwcV6nbcRyx7XR
	40plK9aKJH4LWg6kZ7y66Uz6bLJ4jt7nZdRApBGo1C0bkkMOy0Oy1ebxisIEUKKc2TT61pDtoCk
	NOmwS3OcjXpnyQweLt9j9dsPgthWERZHBeVLVfZuhew+KxweqZIKGDLmuZINs+NvUR9r4RD7aaY
	rTv0UywKOIjraWcQXDmQG0d2c0foxqf3FpyHi
X-Google-Smtp-Source: AGHT+IEJQrKUnSzYQN5L/Z3qQi8ycCnSGseY5gC0pPJuGx7RQ4p3T8BSAU1abLUUr8cnY3qJZ6eTXw==
X-Received: by 2002:a17:907:9451:b0:b2d:a098:ad01 with SMTP id a640c23a62f3a-b34bbebe257mr719981766b.51.1758878718079;
        Fri, 26 Sep 2025 02:25:18 -0700 (PDT)
Received: from localhost ([195.52.63.148])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634a364fd05sm2553079a12.13.2025.09.26.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=49a9f11264181de2036887cb7d9491dd520f43cb0d8ef1d42acfc07ce21a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 26 Sep 2025 11:24:56 +0200
Message-Id: <DD2MGMEFW5NT.1L6C0O4J23ZE5@baylibre.com>
Cc: "Nishanth Menon" <nm@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Santosh Shilimkar" <ssantosh@kernel.org>, "Vishal Mahaveer"
 <vishalm@ti.com>, "Kevin Hilman" <khilman@baylibre.com>, "Dhruva Gole"
 <d-gole@ti.com>, "Sebin Francis" <sebin.francis@ti.com>, "Akashdeep Kaur"
 <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] firmware: ti_sci: Partial-IO support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com> <20250812-topic-am62-partialio-v6-12-b4-v7-2-ac10865c2d87@baylibre.com> <20250923174904.s6jqj35uizclpsxd@uda0506412>
In-Reply-To: <20250923174904.s6jqj35uizclpsxd@uda0506412>

--49a9f11264181de2036887cb7d9491dd520f43cb0d8ef1d42acfc07ce21a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kendall,

On Tue Sep 23, 2025 at 7:49 PM CEST, Kendall Willis wrote:
> Hi Markus,
>
> On 11:19-20250812, Markus Schneider-Pargmann wrote:
>> Add support for Partial-IO poweroff. In Partial-IO pins of a few
>> hardware units can generate system wakeups while DDR memory is not
>> powered resulting in a fresh boot of the system. These hardware units in
>> the SoC are always powered so that some logic can detect pin activity.
>>=20
>> If the system supports Partial-IO as described in the fw capabilities, a
>> sys_off handler is added. This sys_off handler decides if the poweroff
>> is executed by entering normal poweroff or Partial-IO instead. The
>> decision is made by checking if wakeup is enabled on all devices that
>> may wake up the SoC from Partial-IO.
>>=20
>> The possible wakeup devices are found by checking which devices
>> reference a "Partial-IO" system state in the list of wakeup-source
>> system states. Only devices that are actually enabled by the user will
>> be considered as an active wakeup source. If none of the wakeup sources
>> is enabled the system will do a normal poweroff. If at least one wakeup
>> source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
>> message from the sys_off handler. Sending this message will result in an
>> immediate shutdown of the system. No execution is expected after this
>> point. The code will wait for 5s and do an emergency_restart afterwards
>> if Partial-IO wasn't entered at that point.
>>=20
>> A short documentation about Partial-IO can be found in section 6.2.4.5
>> of the TRM at
>>   https://www.ti.com/lit/pdf/spruiv7
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  drivers/firmware/ti_sci.c | 131 +++++++++++++++++++++++++++++++++++++++=
++++++-
>>  drivers/firmware/ti_sci.h |   5 ++
>>  2 files changed, 135 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index c187fb714b3a4c658d0593c844716d4b160e4fa9..fb6f3d7f7413917cf9534ba6=
5f0a9786d1183c71 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -3750,6 +3750,116 @@ static const struct dev_pm_ops ti_sci_pm_ops =3D=
 {
>>  #endif
>>  };
>> =20
>> +/*
>> + * Enter Partial-IO, which disables everything including DDR with only =
a small
>> + * logic being active for wakeup.
>> + */
>> +static int ti_sci_enter_partial_io(struct ti_sci_info *info)
>> +{
>> +	struct ti_sci_msg_req_prepare_sleep *req;
>> +	struct ti_sci_xfer *xfer;
>> +	struct device *dev =3D info->dev;
>> +	int ret =3D 0;
>> +
>> +	xfer =3D ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
>> +				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
>> +				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
>> +	if (IS_ERR(xfer)) {
>> +		ret =3D PTR_ERR(xfer);
>> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	req =3D (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
>> +	req->mode =3D TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
>> +	req->ctx_lo =3D 0;
>> +	req->ctx_hi =3D 0;
>> +	req->debug_flags =3D 0;
>> +
>> +	dev_info(dev, "Entering Partial-IO because a powered wakeup-enabled de=
vice was found.\n");
>> +
>
> IMO this print should be in the ti_sci_sys_off_handler since that is
> where the check is to find the wakeup-enabled device.
>
>> +	ret =3D ti_sci_do_xfer(info, xfer);
>> +	if (ret) {
>> +		dev_err(dev, "Mbox send fail %d\n", ret);
>> +		goto fail;
>> +	}
>> +
>> +fail:
>> +	ti_sci_put_one_xfer(&info->minfo, xfer);
>> +
>> +	return ret;
>> +}
>> +
>
> Just something to think about: another way to implement this function
> would be to change ti_sci_cmd_prepare_sleep to add a parameter of flags
> for ti_sci_get_one_xfer in order to be able to choose if the
> TI_SCI_FLAG_REQ_GENERIC_NORESPONSE or TI_SCI_FLAG_REQ_ACK_ON_PROCESSED
> is used. This would make it so there's not duplicated code and
> ti_sci_cmd_prepare_sleep could be used to enter partial IO.

Thanks for the suggestion, I just tried your approach and I personally
prefer the code as it is. I needed two additional ifs to switch to a
different rx_message_size and handle or not handle a response. In the
end there is not much common code left. Also the pattern is quite common
between many of the functions doing transfers.

Thanks for your review, I fixed the rest.

Best
Markus

--49a9f11264181de2036887cb7d9491dd520f43cb0d8ef1d42acfc07ce21a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaNZb6BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN7
9gD+MBLHhYe5W5TwXxMM41fCqweBpTb+287RKDd7uveEnkoBANYk3/Jp+jqTvqmL
4kBV9d8V0PxSPIA9hkCuwvPCoo4I
=GyNH
-----END PGP SIGNATURE-----

--49a9f11264181de2036887cb7d9491dd520f43cb0d8ef1d42acfc07ce21a--

