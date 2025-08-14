Return-Path: <linux-kernel+bounces-768774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B53B26548
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A63B1C23379
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083D2FD1A8;
	Thu, 14 Aug 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyMKDhdO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A21F582A;
	Thu, 14 Aug 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174250; cv=none; b=QLE6//tHcgLS2WADbYyeLVsGjs/hf6qnSmKNhJHE0+KrP/yuP1dKK0qf48JgvUSd5aMZ2VCjjf/4EHLUNh4c48XSqhrWSnEVQS8+czluwWb7NpkxsZ1vRk7oMSOkk8lqu9pA4TeeJQO2PTv2hulOvKDd3SoVeTMuU0055+alG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174250; c=relaxed/simple;
	bh=ry2LinR5+acyR+ZXIapg4oAMbGxmEAvdfYv9R45eHbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ax2enjoe14EL66oTTHn3+StKyfNkJinid2e3UjRJuK0xlkUrSPmzo7hHHXBYkwI5+5htnO7dB+VYGelLclCatmBbJW8vP31IeMuZ38812z+BtxK7UjGEKs38CQe84ZMeB/WPWrwHWfx+UqCLNKtsfaXRsiiov1nCNV4wRN65A+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyMKDhdO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b654241so1703430a12.1;
        Thu, 14 Aug 2025 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755174247; x=1755779047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kz21h/GxK1yaFVpKMjB0SGbD6rY9JcSSIlqWXA/9/Bc=;
        b=UyMKDhdO1613sLowdYMRXsf2hkknsN++/q7BkT1oDYfCx0DOoSNWhdS+Q0KdoHBhU6
         4iY7JzPfHS50meg7WJo0LRUmOHE3rV6j4NIvvkrpZ1aebu/QcW1sjTPVa9PA2/2Siz4r
         J+Qjb50kuEcHnAy2yUiU6E+XRcQrIcrKXFR8aaI4dj3LtYRb8YRE9GX/K0wbSCaKdrSu
         SCdOIxE307ElBdsSj8UbcsWGcx1WA1MfSMdHPl6mgg5LS2UykWqVNLX9XRqr6HXPF74/
         kWRUOXkAIdM9bCp2ENcC2AUGz+O2EVJIftkfxXx7MewHhfVsevsicozHiNqfMQiYBLTq
         UGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174247; x=1755779047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kz21h/GxK1yaFVpKMjB0SGbD6rY9JcSSIlqWXA/9/Bc=;
        b=wM/VGueHXHgzoIpVhtHABzOljchwsO5lbK8QUg75La9/kSB47gGSD8RR+uP4UR/cEt
         04UqqPEZtDfAYEyEsmyuC8hkIENjsgywa1VlyXKwLqIx4JxFD5Q3kOXCJe+1Cm6ywH9E
         0xbbcByes3C3LNv1n1Ay1yVhit5pX2k9OY2JxzwAylO23RV/ihazQVJweHRW/1ybfFQi
         oGmZ7o/VD7CifIBMI/mZDZdl4ER8qUcf/eTErKseQFPe4eujrIyUY7hYlLAh2UZJgYEU
         4odc7dbsD6N9oOv6oBNfwUaRArlPf7MQ+8tNVUgm5YB6xjMqf6nsggRBMeUMVK/nPE8s
         XLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj2qKgJCzuxicCwmCtb6yiEfKjDksN2IXzGyEF6NLJ/6HeBLpLtZ8ky7QNqXmTK4L+9fgGIAWOEC/z@vger.kernel.org, AJvYcCW69q/WpoTkBE40sLgAIo08d8m71xCRQt43KxL6kjjG092cduzmfb2sEssrDCEEnAMWbudAtbXXOrHbZN/O@vger.kernel.org
X-Gm-Message-State: AOJu0YwBph3ADvZTwaiJykMTCzbuRq8BeULAsnT9x4GLN2a0IBAqpvo2
	8rLX5wkoBmIhSOZgXWsVocfXGInNl4J1F0wxrt/VXx69+UFTmVWqScP4
X-Gm-Gg: ASbGncvjN6h7QfQvugXzomS5QlUDT0BxuYZzl4mF0rrupjYekZzxUpF5dcjzaqRhvdO
	0iL7J0n8dH7F2wyxcNieZ448EFqNCWpUvdkGMhHCos3g2+7RzolhkJFjU8fA81eGFk2mPHu/m5l
	K8b6VNdWiyozVXxOABQRp8rkNV4DA5dx2NClUinb6KUecvqS9WXrbPfVYekFQ8ABNRBeM7YCayw
	MOBcJ6l+vk1yJOSL7n3aoPG/SwSOK5/Qj3NF9141GydA2XIOv87QyoDgKXfbFgdujunKvGBC78p
	LrQApYdoNzrGKN0UeQ2Oco3nOdzqJSzzmnqmOZdBi01yAQdWvbt2rkXNSYh7J1HbhpnJVJPyvwn
	h4h70DgBYIliSr8C8Qv5NkA5bUdX/6nfHxZ688F8=
X-Google-Smtp-Source: AGHT+IGWiJlYtfNSxH2mHMJP2mtKl4b47xVZr2FIn9jVQU6Cs4T+6t19fvx/g0eKtkgdqO8JhlXlFw==
X-Received: by 2002:a17:907:2d1e:b0:afa:1d30:1437 with SMTP id a640c23a62f3a-afcb993eafamr234382566b.53.1755174246837;
        Thu, 14 Aug 2025 05:24:06 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21ac0asm2582706666b.99.2025.08.14.05.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:24:06 -0700 (PDT)
Message-ID: <cfdff4f068c98feba252b28fb61de7629637dc45.camel@gmail.com>
Subject: Re: [PATCH 2/3] eeprom: at25: support Cypress FRAMs without device
 ID
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Markus Heidelberg <m.heidelberg@cab.de>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Christian Eggers <ceggers@arri.de>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, 	linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 14:24:06 +0200
In-Reply-To: <20250814111546.617131-3-m.heidelberg@cab.de>
References: <20250814111546.617131-1-m.heidelberg@cab.de>
	 <20250814111546.617131-3-m.heidelberg@cab.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-14 at 13:15 +0200, Markus Heidelberg wrote:
> Not all FRAM chips have a device ID and implement the corresponding read
> command. For such chips this led to the following error on module
> loading:
>=20
> =C2=A0=C2=A0=C2=A0 at25 spi2.0: Error: no Cypress FRAM (id 00)
>=20
> The device ID contains the memory size, so devices without this ID are
> supported now by setting the size manually in Devicetree using the
> "size" property.
>=20
> Tested with FM25L16B and "size =3D <2048>;":
>=20
> =C2=A0=C2=A0=C2=A0 at25 spi2.0: 2 KByte fm25 fram, pagesize 4096
>=20
> According to Infineon/Cypress datasheets, these FRAMs have a device ID:
>=20
> =C2=A0=C2=A0=C2=A0 FM25V01A
> =C2=A0=C2=A0=C2=A0 FM25V02A
> =C2=A0=C2=A0=C2=A0 FM25V05
> =C2=A0=C2=A0=C2=A0 FM25V10
> =C2=A0=C2=A0=C2=A0 FM25V20A
> =C2=A0=C2=A0=C2=A0 FM25VN10
>=20
> but these do not:
>=20
> =C2=A0=C2=A0=C2=A0 FM25040B
> =C2=A0=C2=A0=C2=A0 FM25640B
> =C2=A0=C2=A0=C2=A0 FM25C160B
> =C2=A0=C2=A0=C2=A0 FM25CL64B
> =C2=A0=C2=A0=C2=A0 FM25L04B
> =C2=A0=C2=A0=C2=A0 FM25L16B
> =C2=A0=C2=A0=C2=A0 FM25W256
>=20
> So all "FM25V*" FRAMs and only these have a device ID. The letter after
> "FM25" (V/C/L/W) only describes the voltage range, though.
>=20
> Link: https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab=
.de/
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/misc/eeprom/at25.c | 67 ++++++++++++++++++++---------------=
---
> =C2=A01 file changed, 36 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 2d0492867054..c90150f72836 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -379,37 +379,49 @@ static int at25_fram_to_chip(struct device *dev, st=
ruct spi_eeprom *chip)
> =C2=A0	struct at25_data *at25 =3D container_of(chip, struct at25_data, ch=
ip);
> =C2=A0	u8 sernum[FM25_SN_LEN];
> =C2=A0	u8 id[FM25_ID_LEN];
> +	u32 val;
> =C2=A0	int i;
> =C2=A0
> =C2=A0	strscpy(chip->name, "fm25", sizeof(chip->name));
> =C2=A0
> -	/* Get ID of chip */
> -	fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
> -	/* There are inside-out FRAM variations, detect them and reverse the ID=
 bytes */
> -	if (id[6] =3D=3D 0x7f && id[2] =3D=3D 0xc2)
> -		for (i =3D 0; i < ARRAY_SIZE(id) / 2; i++) {
> -			u8 tmp =3D id[i];
> -			int j =3D ARRAY_SIZE(id) - i - 1;
> +	if (!device_property_read_u32(dev, "size", &val)) {
> +		chip->byte_len =3D val;
> +	} else {
> +		/* Get ID of chip */
> +		fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
> +		/* There are inside-out FRAM variations, detect them and reverse the I=
D bytes */
> +		if (id[6] =3D=3D 0x7f && id[2] =3D=3D 0xc2)
> +			for (i =3D 0; i < ARRAY_SIZE(id) / 2; i++) {
> +				u8 tmp =3D id[i];
> +				int j =3D ARRAY_SIZE(id) - i - 1;
> +
> +				id[i] =3D id[j];
> +				id[j] =3D tmp;
> +			}
> +		if (id[6] !=3D 0xc2) {
> +			dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
> +			return -ENODEV;
> +		}
> =C2=A0
> -			id[i] =3D id[j];
> -			id[j] =3D tmp;
> +		switch (id[7]) {
> +		case 0x21 ... 0x26:
> +			chip->byte_len =3D BIT(id[7] - 0x21 + 4) * 1024;
> +			break;
> +		case 0x2a ... 0x30:
> +			/* CY15B116QN ... CY15B116QN */
> +			chip->byte_len =3D BIT(((id[7] >> 1) & 0xf) + 13);
> +			break;
> +		default:
> +			dev_err(dev, "Error: unsupported size (id %02x)\n", id[7]);
> +			return -ENODEV;
> =C2=A0		}
> -	if (id[6] !=3D 0xc2) {
> -		dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
> -		return -ENODEV;
> -	}
> =C2=A0
> -	switch (id[7]) {
> -	case 0x21 ... 0x26:
> -		chip->byte_len =3D BIT(id[7] - 0x21 + 4) * 1024;
> -		break;
> -	case 0x2a ... 0x30:
> -		/* CY15B116QN ... CY15B116QN */
> -		chip->byte_len =3D BIT(((id[7] >> 1) & 0xf) + 13);
> -		break;
> -	default:
> -		dev_err(dev, "Error: unsupported size (id %02x)\n", id[7]);
> -		return -ENODEV;
> +		if (id[8]) {
> +			fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
> +			/* Swap byte order */
> +			for (i =3D 0; i < FM25_SN_LEN; i++)
> +				at25->sernum[i] =3D sernum[FM25_SN_LEN - 1 - i];
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	if (chip->byte_len > 64 * 1024)
> @@ -417,13 +429,6 @@ static int at25_fram_to_chip(struct device *dev, str=
uct spi_eeprom *chip)
> =C2=A0	else
> =C2=A0		chip->flags |=3D EE_ADDR2;
> =C2=A0
> -	if (id[8]) {
> -		fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
> -		/* Swap byte order */
> -		for (i =3D 0; i < FM25_SN_LEN; i++)
> -			at25->sernum[i] =3D sernum[FM25_SN_LEN - 1 - i];
> -	}
> -
> =C2=A0	chip->page_size =3D PAGE_SIZE;
> =C2=A0	return 0;
> =C2=A0}
> --
> 2.43.0

--=20
Alexander Sverdlin.

