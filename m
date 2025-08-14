Return-Path: <linux-kernel+bounces-768777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4AEB26554
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDA1B6135D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F45D2F998C;
	Thu, 14 Aug 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuMOvynp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DE28D8C1;
	Thu, 14 Aug 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174331; cv=none; b=j8BjRXFpudzJVe2N9pY0zbI2KWwPVosdbFmKmxDBTT20J5LE1Q3JRiZlbeiZc0xZpcat8JciSPBdXqIkKrC4v/GRQCcVyPdjTJMopbXOTLRbQCA4VBTNR1Rh53z9L/lNjuBHNHLnDzqFOQQc5PiJW/14Rulmd/g6WkDUXlLnnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174331; c=relaxed/simple;
	bh=TMRNS4/NevbbcdPgGkBj7pDR66311bh0nxYKiBtY5QY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bl7ArKGXdapayCV9cUZDPAZB5UT5AOQknXTcCbp2g42wJd7zJBtP3qxR3vrTJRXEIPspVSPJbYk6RNeYuoO9vMXCJ2humudO4ggNqjMVxgWpMaVfs9l27Y8g0G5ufNNgpP+A5qVknuqzZZwmdSKd+0C1n8YfsEcMTwH/XI2EvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuMOvynp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78e70c5so139296566b.1;
        Thu, 14 Aug 2025 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755174328; x=1755779128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Zn0zTLrLFpjS2ruyB+t+7Ky512n2nN3JSsV0usxRq4=;
        b=TuMOvynpslpMIGTzSuEVc4YjxshwzNtxYC03XRbUFYXSaefQ/oBWnAWSIg4DmcjzPV
         u5LF809Ruwp9iAMDBYl7fx0FI01FKnVCkfR7uiaK/nRbC+Tm/xEC2SKP1xaJO2KvsboQ
         mhIroqtnMMd+9rPnjs9r1hyUS7Em8FDPcBWHuU3dBFiEx0oIhmwfUONdMXE2/yJiYDA+
         +JtYoXMrLRRpvrRGVzCrpMBosyfHWniOykvMtqhHJ35+eimbYbfgWS7ZjpPyhqjqyfzJ
         vD5USKBsnAUOxneHJsk9NNvVnBJkBa7mZUEtXFjekRrsrSiDxWhac2cLoY38alG61KCY
         UjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174328; x=1755779128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Zn0zTLrLFpjS2ruyB+t+7Ky512n2nN3JSsV0usxRq4=;
        b=Z1fFRVolKQVZJtMUmOHGKEv0/nttccW2G6iE8d1xbB4e5eGsieBGUHxIOlcanf7q7P
         bxsobgNi6wpdRcnkbga1eT4X615QKJwH168jmqM2iSGpr149IJmZDLeQj01CGIDY/vUW
         kQ+DVJEsecj6mjeGCL5tgg/fFFW6y5TK1tk+xlcbzbXOKps/XYbREhtAvSyusb4A4DS0
         UYHm4yRKXBy9WYPrhQvZ0G44TA+1RcrsTPqSYQjVDH5k8IBUslmvKUudUt7CypHC8L9a
         EgxfAZx1rCLnj9mdFJxtwAyjEKtp2a4HE6dJk+AjgaRCRuF4a2T1wa/54LoQlIHIWSeK
         lNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyWhTHMdSJGHPBDTOWbAUOWcGuAvjNTY5zsO24EzhPsV9Pt0vsPnvfLNbHZjZNCl6HIH/r0qZtdBff@vger.kernel.org, AJvYcCXzSuaJfOsHeqlHGTa8MXcsWpDtdTX8hsm5DYD4gmeKzpQ2quh5+4rl5YIcoijDY7iTjGdegRQPNK5FkmoX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wogmbYfnC2olu0thAfx8pvB4Tgbk5nczk9F7gA5uJ8ten86t
	4/Udt4hXeaTpWJ4nwgG1NxvWHp/wTVDjOzdokJ7QCsGGFqnTj233zKq7
X-Gm-Gg: ASbGncvnfh+EevxWnK969KvzQOfhi0kquGKqD8Z0B8tmcKB4wZc82B3fEOoOlufZOQ/
	+/TtcpMc5zeE20d/qKz/7Svys4RnvCaCXa+xO/WQOFYjIc1G2F5CEeaMoARz/ilAXV1NHsd3fYr
	l5JZwPRsnnBr3CLIRaJRODqEvija2ZtbRduX0uvhm1IXz58cy0/fvYaaP5q6GJi+vYoprtCAS0J
	kvgzqEVeacXO9n6G+2+We3Lk7TICi3ClETUeWo5y+NVZlCpWbt4rZ8d0FcEKVZVdMsbMEPLirUk
	4wfGexNBnb92di+c6GVZtXzuMVA+BYnWG4otnQgNsIv+VadupgKH9mzSJ2GGQwvwqWw7pw3exdt
	O3rfyBoq6KnJPOaJxgK5jwNQrBM1opPEQc0es7aM=
X-Google-Smtp-Source: AGHT+IHjsxCUiYW/uoWEjgeek8aaBeXGwkkMXVAUYPiTK0zQoad1DLVXJqClmAJwLq5qVxazIWZmOQ==
X-Received: by 2002:a17:907:7ba8:b0:ae7:cb7:9005 with SMTP id a640c23a62f3a-afcb98cef01mr245291666b.35.1755174328076;
        Thu, 14 Aug 2025 05:25:28 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af937c86989sm2364446966b.74.2025.08.14.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:25:27 -0700 (PDT)
Message-ID: <2c04e14269f1462a76ba0b4f42f90501ef57913c.camel@gmail.com>
Subject: Re: [PATCH 3/3] eeprom: at25: make FRAM device ID error message
 more precise
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Markus Heidelberg <m.heidelberg@cab.de>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Christian Eggers <ceggers@arri.de>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, 	linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 14:25:27 +0200
In-Reply-To: <20250814111546.617131-4-m.heidelberg@cab.de>
References: <20250814111546.617131-1-m.heidelberg@cab.de>
	 <20250814111546.617131-4-m.heidelberg@cab.de>
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
> The error description would be wrong in case the "size" Devicetree
> property is missing for an FRAM without device ID.
>=20
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/misc/eeprom/at25.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index c90150f72836..e2868f7bdb03 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -399,7 +399,7 @@ static int at25_fram_to_chip(struct device *dev, stru=
ct spi_eeprom *chip)
> =C2=A0				id[j] =3D tmp;
> =C2=A0			}
> =C2=A0		if (id[6] !=3D 0xc2) {
> -			dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
> +			dev_err(dev, "Error: no Cypress FRAM with device ID (manufacturer ID =
bank 7: %02x)\n", id[6]);
> =C2=A0			return -ENODEV;
> =C2=A0		}

--=20
Alexander Sverdlin.

