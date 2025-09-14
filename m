Return-Path: <linux-kernel+bounces-815545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E844B567F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB03167A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041372494F8;
	Sun, 14 Sep 2025 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzyoTVga"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB317469D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850086; cv=none; b=CKuUlHtFxMtI5vT9aAETi+u35oJ6Aik6wkDs4+wVQ46GdqSmuiuczKhfpDRPXpF8aPCx/HzhuW86H+k/3RVPTeg6BQyEZigO/8h1N5XlipIeNs57GW6Te6CLnvl7rlihC8vOy0PWrVqldXr3jlljWPc2GV9NrQ4RXjkwyjuBNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850086; c=relaxed/simple;
	bh=USED9SSTq30I5Iv3xaKuXQzkbUhRv94tw97rZZ3jDvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4K5niicL8q05kCfWXmzgdIKMg6/6yKeyFT7qSlhK2kcNo+MWG9hvjRMOXyV3zSED4GmghPWtscJ6guaXd/y3eRWHtHhGlBwZIZh2L9hoYGxdECM4MFmxSM2DjczWCBFeMkipTSbsP3aSPckyqILzB8azVijxKuG17vmIV6yyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzyoTVga; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0418f6fc27so564067266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757850083; x=1758454883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFE6FxzSZI/jNpqYTwjPIoXW6ZJAD8JeqJ6auD/7/HM=;
        b=PzyoTVgaEl+r1GFHthU9M+tjtDjIsGeNK9KIRSJ61QtJsYUl0fh1dcqDVe4KW/OyKY
         I1WX9ahUEb13dFrBdCLC2OKvIeaWkQ0IBqGg5YW9EsVQq/zCW+jWkinUjm9fe3N9Rfze
         FfjiRgr4rOrLXvEmIua6O1fMRrc/Xu6sljV5KwXGxuENlhHKbTKlSrkKlPry+SLPwKa3
         fnHX0ulOuBuR+aQmDGiiX6wKBwsbzXQQpJWolz1/ZPIMlAB1y9Msg2RhDvbLD9DE8tJr
         y404Zb7yFWihI6yiWsR96WXUdMmGaECGDW44dqYtmtwrlgbMMOL74M3j1PH5CKIK3GhV
         Bi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850083; x=1758454883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFE6FxzSZI/jNpqYTwjPIoXW6ZJAD8JeqJ6auD/7/HM=;
        b=Sw3LpOuwLtrJ+RQPAIyvqUIyMlXOyVvTt5eDJaGE12LFTPm9GYmw1LCW5d7b3nZZJX
         jwW0yg44+7T9O041LIfsVVGDi4e+WgWxg5oKNNzpDztJMSRc0nOQWbZcFtTLsT09BXF4
         m4p114L8NodBNVh6d18CpLUrQR9fSPZQ3c8TH/ilgGuitvqqNbOsuoiH7shmSIBocevL
         cHiOQC2D7niSSV/ZIsdsjUOZn5Y8Of4wh8qIP/DrYEPy1UCujEW3ROWd5shBljp1573T
         J5+dQGqi7hjyYVuBEdXH4oe42cxFk6XdWqiEqGpUDuET2VzNWyMTKTxdkNRSxxf/EUCT
         1YQw==
X-Forwarded-Encrypted: i=1; AJvYcCUxdZPXWc3Ioh4f0/5hRdvG4pmcPtKDBxQTxuXJcG1bcx/D4U7M07gADDk/dOe79nqjoVg5xy1iISvw9oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyee6X0qfP6glS+8d+tR5HafVbJcB3qSuiAua7CBzBMkoS8zVzP
	XNx8ehvhGAvIANxMVupmijttRwdYPKdJbTR8R52VHkhDQYgAuo6S8LcQxdI7RIlahdWypz9lrLQ
	2A1WPUZzkHYtHFB/T0OUD6LrU4eNvR4U=
X-Gm-Gg: ASbGncsGN2P4LaI6JrFXejsiuAkBNAeHf9Hb3CtMwvvYQZP+Zpdb2npK+KCbT45tT1Z
	A2bwQtWeCUUxfBS29gyHnJMFv9uQbn6H7lwzWZPE4UXKhP+HlRuIEY96Iu7cNU8bnjZ/IFP/jPI
	qps8QVae8/9pKkaVKZZy4ywE/uITTRfLmdeosekLCJ7+rIw8vGI8wKGyMcJ0gIXHv72u4U2s8We
	fRLJX5rv51EtxgsMQ==
X-Google-Smtp-Source: AGHT+IFhxYcEHRcnFk9fqIj4afX1A1ypXUJ2GDopC4rmnJx/cQtj7/LgHTam9NLE6Z4WaFa/M5/aBtmhxFL97wBEDMY=
X-Received: by 2002:a17:907:1b08:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b07c35fb999mr907487766b.40.1757850082917; Sun, 14 Sep 2025
 04:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com>
 <20250830115858.21477-2-gustavograzs@gmail.com> <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
 <lipouuxehycprgdxg4yqg4wuw7pqpeynpfbzzpukatn3wbnwak@znjzqj434atw>
In-Reply-To: <lipouuxehycprgdxg4yqg4wuw7pqpeynpfbzzpukatn3wbnwak@znjzqj434atw>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 14:40:46 +0300
X-Gm-Features: Ac12FXyAqKuPJpMqtVwrTmiAAzq6DxjqtDXr05FkTf4OlVpcEC5OvnqceFmLAlQ
Message-ID: <CAHp75VfAe2=ok4U07M27B_b=BxGMcNPT=upCmv7WfNFdxTVt0Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:45=E2=80=AFPM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
> On Sat, Aug 30, 2025 at 03:44:37PM +0300, Andy Shevchenko wrote:
>
> > > +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> > > +       ((val) * (scale) + ((val2) * (scale)) / MEGA)
> > > +#define BMI270_RAW_TO_MICRO(raw, scale) \
> > > +       ((((raw) % (scale)) * MEGA) / scale)
> >
> > In the macro names "MICRO" in the implementation "MEGA", please make
> > this consistent.
> >
> These macros are intended to work with values of type
> IIO_VAL_INT_PLUS_MICRO. The division by MEGA is what produces the
> fractional part in micro, so the naming was chosen to reflect the
> result.
> If you prefer, I can rename them for clarity. But please note that the
> same naming is already used in the BMI323 driver, and I kept it
> consistent here.

Ah, okay, this makes sense. So, if we ever want to switch it's better
to do it with both (or more?) drivers.

--=20
With Best Regards,
Andy Shevchenko

