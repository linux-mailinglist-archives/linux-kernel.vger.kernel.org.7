Return-Path: <linux-kernel+bounces-897501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A938C53035
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF19D541C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B2337B80;
	Wed, 12 Nov 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXjr/BiL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83233A033
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959644; cv=none; b=Vk3xoIzfDdpfLTAkner4oGLcfjqZZUJTnDm9uHEym4um6RgzdUMgAi+7HB0DHzWupOmELucZQTvp9smAU1f0UHkeu46XjNz0GF5T73bxEK2T/9pwaFG9BCEaSL8zIm3N/sWIVP/O6dm8Y8z4OqsKrjke4ARD2V1gcX4Cyv/n3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959644; c=relaxed/simple;
	bh=ftMi4rxMW7WjJXTDqOFjHRsNI+XGfNycEd6D7yRiwf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ft/nyUrRkRSaZ/7sYl98qtd0walLJgDqi8te1MZxV7UTO3fSdSqq9kX+TBkucqiw7gznUUQmnpsEpeyTGxaQ9UB5zUgsZYoSryrwmVqy66sq08x8kOZEe2EPdxzJMVZU0idjv77/gtGzcu/1DUGqH3mMJG433WM7kmCM1VqMZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXjr/BiL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c8632fcbso692858f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762959641; x=1763564441; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftMi4rxMW7WjJXTDqOFjHRsNI+XGfNycEd6D7yRiwf8=;
        b=xXjr/BiL1xgYHNNsXrXQ4khd/bi3J6djLyO/bHVn86qOUbVkUF3rK9MYM0seJ0Bwt1
         YiO2SPPJ0PpUsBXbo8YUEkXFDUQQRhkYebv3ILk9Kl0M/H75pK4vPmaHkMS7Vg5oBNha
         QXuL+wmq33tFbpSLp4lLkLfRKFhEFDcssKXknqAK9JUVQBHANBgXnDXJGIn1WDDlrLRH
         h7YIv5qnhymqFyT7Mm5Xx4gRcExVv5sC4+XwGYwPv8aoeab++xUYbPOAmq/z73RQEdjY
         mQOvViiLiJQRNwDZ1LcQxHVELUa2p3WRZqDAj4ZJtrUSNCm4YczECQKfHGYihFLWk/Og
         OzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959641; x=1763564441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftMi4rxMW7WjJXTDqOFjHRsNI+XGfNycEd6D7yRiwf8=;
        b=CZnHVU4r/F+DFaLdPC2/AwkvDSoYTxZ/KJnqdkc9gaaWQqYRjjs86qG6I2AJZHZaDT
         MPjQMawk6Jsb006DmSm0OTyxOgkdS3vFc1kcJ1EkjElz9SAVMC2UrWccvETRNMiN00Ou
         i30ddPmwUvnQ7TH1XovVjlC8e1v1M3Mpw1x1ugFbBBe4R24YptpRDZK6AtrlT87Wd48N
         I1iwz3ptdNxY1SrDP4MaMiYJwDAG/F/C9K6xYK6OAlq1GS0QdWgmDPlpUssB9BMLfU7F
         0Rus7m/92cDXddFLAMwa3IY3gNXbsUXfhuPkPADR4b0ktV5V2gUBmTPZkgKke5uPtmwa
         KSUA==
X-Forwarded-Encrypted: i=1; AJvYcCWDb+IS3aoFWigWjCCrgJlGA4oSl4K0nONL1I1bW7MN0wdilt4Jgs7HM9Zu5hA8q0EpZojpdFSZLvXvo5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9ZAH7gcy4/t8DuGcCaJTxBrniuzGp+luQ/WEbdm9hdUBZvJU
	csazGzZJeycHkqTzBXeoiPtvSX1tlZ/C/83KpOKdiSyIm3BwcBQSykK+R14kSjkcDRs=
X-Gm-Gg: ASbGncuUuxbbnCcnF600EQWTt6Xk5p1eR+1Cs224hOHYwTF2kiiXHPltK9LnEWPny8y
	uh9fNjeHqIeuTsr0lriQjt1DkctTJh5+66M3jFFv3cZ6BP1pEkSqypnXj2ZXHWYYYherzzz+Atb
	tC9B7AZekuoKdnfxtdofKUgOOwtGVcMQcKOnMNf8BdtZzBN+tCPz5uV3A3D5IyGkI7XcczEocvU
	k8QB0uEZLbtRzWvjTIWQuaKRjHjy2ke88QwDG3X00fqs7nvTasfneNEjOQjPMk6WiuJDd3tiEks
	6rb/r2+qCItgfYSr7LM3giJ4al/QCVabgGL8uDpTTeaQM/Xl7bnCuV9hntLEkqBLDqzvzXroYDy
	wObCYRC3KsAuT4G6ATyfoZDMjyhJhNiRFh1IoNplW4quawtQrBrFsoKEJYRTDvtfuiw0MLvoLG7
	WyqoUtXg==
X-Google-Smtp-Source: AGHT+IEWtr1202SXBAEfNbT/oc0QWLUzOqznUI68ArPxhBNv/vhbmeoXarGP0UDkdCcwtG0Wq/w4+w==
X-Received: by 2002:a05:6000:2dc8:b0:42b:3eb2:1b97 with SMTP id ffacd0b85a97d-42b4bb8b5e7mr2354687f8f.9.1762959640534;
        Wed, 12 Nov 2025 07:00:40 -0800 (PST)
Received: from draszik.lan ([212.129.80.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b4789896esm8854605f8f.38.2025.11.12.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:00:39 -0800 (PST)
Message-ID: <0bc6fadc6ec9578873fc5413da4405c968bb402b.camel@linaro.org>
Subject: Re: [PATCH v4 02/20] regulator: dt-bindings: add s2mpg10-pmic
 regulators
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,  Lee Jones <lee@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, 	kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-gpio@vger.kernel.org
Date: Wed, 12 Nov 2025 15:00:39 +0000
In-Reply-To: <20251112-gainful-flashy-seal-f2c5dc@kuoka>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
	 <20251110-s2mpg1x-regulators-v4-2-94c9e726d4ba@linaro.org>
	 <20251112-gainful-flashy-seal-f2c5dc@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Wed, 2025-11-12 at 10:51 +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 10, 2025 at 07:28:45PM +0000, Andr=C3=A9 Draszik wrote:
> > The S2MPG10 PMIC is a Power Management IC for mobile applications with
> > buck converters, various LDOs, power meters, RTC, clock outputs, and
> > additional GPIO interfaces.
> >=20
> > It has 10 buck and 31 LDO rails. Several of these can either be
> > controlled via software (register writes) or via external signals, in
> > particular by:
> > =C2=A0=C2=A0=C2=A0 * one out of several input pins connected to a main =
processor's:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0 GPIO pins
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * other pins that are e.g. f=
irmware- or power-domain-controlled
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 without explicit=
 driver intervention
> > =C2=A0=C2=A0=C2=A0 * a combination of input pins and register writes.
> >=20
> > Control via input pins allows PMIC rails to be controlled by firmware,
> > e.g. during standby/suspend, or as part of power domain handling where
> > otherwise that would not be possible. Additionally toggling a pin is
> > faster than register writes, and it also allows the PMIC to ensure that
> > any necessary timing requirements between rails are respected
> > automatically if multiple rails are to be enabled or disabled quasi
> > simultaneously.
> >=20
> > While external control via input pins appears to exist on other
> > versions of this PMIC, there is more flexibility in this version, in
> > particular there is a selection of input pins to choose from for each
> > rail (which must therefore be configured accordingly if in use),
> > whereas other versions don't have this flexibility.
> >=20
> > Add documentation related to the regulator (buck & ldo) parts like
> > devicetree definitions, regulator naming patterns, and additional
> > properties.
> >=20
> > S2MPG10 is typically used as the main-PMIC together with an S2MPG11
> > PMIC in a main/sub configuration, hence the datasheet and the binding
> > both suffix the rails with an 'm'.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > ---
>=20
> What is the base of this? base-commit from cover letter:
> fatal: bad object ab40c92c74c6b0c611c89516794502b3a3173966

v4 was sent on top of next-20251110 which is ab40c92c74c6

Cheers,
Andre'

