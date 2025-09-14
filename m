Return-Path: <linux-kernel+bounces-815570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9A3B56851
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155FC189C3E7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806122B8C5;
	Sun, 14 Sep 2025 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyHOSFR5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B4195808
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851718; cv=none; b=u8d97mE2hXDfvpCqgzKY9RzQC0PyA5Ady80ONDrfsmMgd92zWgyL31wGsrLlIstwJ92ieOtLe13c31JivRqBLUMV3bqCJ/Fvoc7432lDVsLBGCCCfA5dfcKinVbo6yId5di2L0lcc5QA2dLQjAZpeEqG1r3IYcm7gz3DeXt1KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851718; c=relaxed/simple;
	bh=EigXt8LqTfePC/LqOfQhPeqk7WEnREgVUKFouhhjbzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCfZs7oDWNaf28CAiRB4dL4z1WoEJfgQF017HpHnBjqpf0P5Zo2/I344BMCpqh9Ai3449YNK5WXcpEKMZzteOgIW7dPzaZ9wnE2H0dlj7WaPokPIuKpu0Um/92en6CXGqNE/g2DHOQaBWuR5xjix9Yo6Uo8NstlcEGcgVdBKx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyHOSFR5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07d01fd4fbso264571866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851716; x=1758456516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymLIEuumg4YCNkpQZsBBfzaLM4aMXii3QJ3NddaKZEs=;
        b=ZyHOSFR5WRT+InZlRPr6YfavsqxoQ0ewZD8KGP5DrtVlTkFIwxetYM+p9AdZSVVRcZ
         XwVxJPJM6IEhDVNI+nmcFOEP0QMdriMG1Y3bohRPjInQkQZN4XEqmvXr6wsC2G6BIehj
         Dhy7eudCOByaNf10gkTj4S3QQLVfV1q1EyhhdQ7dbntUbwlfq+dq6rmt4kGycsHcEWsZ
         UD37z4WiEJ1gY/UmwFLEZ6TJhmThRf56mweRInX+T4/PiDWjT0O6Ypc6F5/pSP2ZPGqJ
         du5947VXhPd1TtYWHb4VRsfGXI87FrYFtxfgnGXZT0QscgkOmTpCvm/G0dqlMnD23yI9
         Mimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851716; x=1758456516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymLIEuumg4YCNkpQZsBBfzaLM4aMXii3QJ3NddaKZEs=;
        b=Ptx5eRrGs1WWSlmoAvMCc5Yl1yfi3MOETggkP6RnmuRf7J1meelLmy2+wqJOd3ZsKu
         cMd+hG5Zrm3KcNyUx1ukF/DjEmi/4hrsbv2Ya9Ttaik2HO/mCRrHbSHWmBsHLI1YfjN6
         nYRXKV7N1p2DZP1XqJEEWKYVOI4XIwxGVkeY4ka3U2KzlmcQNgNpaWo1w22OMz84t8Cn
         MiPcki6NLUiZZvhUF7fas7Rp+eLxroqEa5kYruTVIzJ5z0eN5L/2df3PCdCSwnvGmKr2
         94qtmoJWbRHGTSbOj4gELtPOtxCv17A0LcXqmcKxj21qIXSLdqlDD5UL1a2TgNx0mqKK
         XW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7T0SQ/loFvk26EN6Ce5IJyE2xOo9bPjWH2eZmPLaitdsps7c0YwHz27/WLaERhoeCGqpMKNEjNkKefws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwPryjinod/ZCu1jnS2U79zh4BeVsE8GCFDG6Ex6wLcc/MlGb
	eAHOLk4TsLCTmZmwim+UlQ4NKMj56wkQ/eOTkWG33xopoSBK4Ymc4q3EWQTbIukooazVTFoRpHU
	Xh1w4QCXoGqJa8ML7Vj2MaUmOtXCP4Wk=
X-Gm-Gg: ASbGncuEGS6cSfT5Tm1f4oel4s4eIwMt+PByta7KqghTp70n8NpUQtW3rjpCSTvbbJk
	fHNBJ8zD41sPawz2w/iJLPsH22xKmmFlkBZNYzoEp7vDEAzkUEINbLYLf5nLMWvkD6v7EqkyTn3
	oAMNIqwg92DYDygKQSXrsEdBStZ7/wsuQN6ql0uTQTPh/C0NjwuZlrX0dLArvfC4dsdUpx/e9nN
	hSDPkgoGiF+8Z42n8BgfpsIb0KV
X-Google-Smtp-Source: AGHT+IEKkbNP3MW3lSi/qyjRAql//emEvsvwlMA+9H36XPYpDZpeNQ0Wlwf6V3nUlHWa6e6uCNQbNFf0xyyBqH3XLew=
X-Received: by 2002:a17:907:7f05:b0:b07:89ff:5ff0 with SMTP id
 a640c23a62f3a-b07c365fb66mr908806466b.51.1757851715422; Sun, 14 Sep 2025
 05:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-8-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-8-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:07:59 +0300
X-Gm-Features: Ac12FXwgIGwTL2oMKLhNSJfFYEfKocLrB2d6dw-jdxsp4PGcNAww3JU4P4nSCzA
Message-ID: <CAHp75VdPdSrXDyuiwvOyC64qDhoTRZ0YFEDjHnYCX7dvBE1P1w@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] iio: accel: bma220: reset registers during init stage
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Bring all configuration registers to default values during device probe()=
.
> Remove trivial code duplication regarding bma220_power() in _init()

...

> +static int bma220_reset(struct spi_device *spi, bool up)
> +{
> +       int i, ret;

Why is 'i' signed?

> +       /**

Same comment as per previous patch.

> +        * The chip can be reset by a simple register read.
> +        * We need up to 2 register reads of the softreset register
> +        * to make sure that the device is in the desired state.
> +        */
> +       for (i =3D 0; i < 2; i++) {
> +               ret =3D bma220_read_reg(spi, BMA220_REG_SOFTRESET);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (up && ret =3D=3D BMA220_RESET_MODE)
> +                       return 0;
> +
> +               if (!up && ret =3D=3D BMA220_NONRESET_MODE)
> +                       return 0;
> +       }
> +
> +       return -EBUSY;
> +}


--=20
With Best Regards,
Andy Shevchenko

