Return-Path: <linux-kernel+bounces-897215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C15C52464
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EE0188EEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A113346A2;
	Wed, 12 Nov 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS87xDT8"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB9329C78
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950975; cv=none; b=DkYKt5T0alimNE/9XFJmPFok5Aoz3hm8ANxEt3JcUkoGy1uE7kODIUEjmjB2TeVlxIEfBOFadoWyY1xSvONforPhDAEilVMoQvYxVLseP1RiPBChk0GN227gkihAsj+38dKMzWdIDxsbG6bp8JxOmbyuwmH2/TpqKUZ0zESxvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950975; c=relaxed/simple;
	bh=+H8mi4wzWuOnGOUj+vry+C/RsrNVNIni+GZfNRFC6RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vERQQuvOcR/T+T45vmLx1pq5JAAMwjc/A3v8rpfWmUQyAFpjKJ/c2A06z2A02jqqh1beeaRKh/6xFpahgfo2dLP3KT9hKuTqX246RfUjAjMhasio5c/JsJ9xXolxAFxkfUqSFzEYd47d08hO7j6oaDXIXp74ByHl8PWGRrqSTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HS87xDT8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957753e0efso798095e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762950972; x=1763555772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+H8mi4wzWuOnGOUj+vry+C/RsrNVNIni+GZfNRFC6RQ=;
        b=HS87xDT8PEa/QupP0c9X7zCVhMNbcHHjXVhcTCYOEDHLj2zRjPZGoh0c/lHBV+M3x1
         muIqy0huYSn/0x3Ur1jJDwZjiu09gpdvdDk7gfst4Rg7KmREjJfbZ2Y2uU8lD1/Dq5d2
         KwMBUfqKrRexDDnrEPGdP+F1tvE2YM66SkevBQETEGoElaUvVi+XNTjH/X1I6ccqlPgD
         ZE5Uf8qHhvLkWDqBNKgMKkTmdQmMKewh9C/lWNtrEyv72wILFSUh/1YqN4nHkIs8suOQ
         3uWz5LT+S29EVLhk1nwZnxYSVjkpqemJRvo5+QcbEeNoR3OM72eEK3q+t5Y+8dsyAvLM
         sBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762950972; x=1763555772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+H8mi4wzWuOnGOUj+vry+C/RsrNVNIni+GZfNRFC6RQ=;
        b=m30zfqazY8fUbie2qLhh46XgC0c82AjTxPBl+jlXeGenaDCyDIgp6Aq7eNEWzMeS9s
         D69rR6qlV2Qc473KBVz+7lus1DGmD8ydc59aL1Ya9+eALa/uIW9VC0uE4n87aqjCLkCH
         iKeolow5H95k96CcQshT4cAxeWn2dqFpaMofjfU5W7CV0MmXCPY6Ye8a0Gcdou7Gx9W9
         Ug6xNrHk+6HlVKkFJ0ThqdnY0xMUp4fChQmtnoBq8I8v6Cz71fZ32sH7mcPeNk6kvHAk
         R4bFYAQbJmfta+PL4JiEgzyxUUjILWIapzo4f4pBbEB27AJk3v3Tl1un87crXB/2HZM7
         zE9w==
X-Forwarded-Encrypted: i=1; AJvYcCXdP06fWxZTD+WvYAtlLOxT1bcwk1u8U5zLB1TmcJ5Kx1OIoaI+4TReUqJWe2mR2NXzJTo/HxDauCPDkwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycr7zEeljrrAauoRd9ydJ8OteTDaEOD29RiJAxERejuannCSbm
	GnPY66L4/USBTk9yoON7J7tmglHdpcvlYwrUOcMT788aD9NmvVyKwltr7LmrcSrXpFjp3XA/cPG
	1aS/ABeH3autnSjzN7iGrpef9+CaV6RhVdvYk2NQ9Yg==
X-Gm-Gg: ASbGncvsiRkpGt9gVVkq3muMkL7iEzZrlkGE4ZCvAV3KcDzAmIGMD9VYD24egAcOPYe
	o8Jd2sxZiAgynHhNqY2fJ04L7kjDNwDnuDUnz6dmFRSKHMjyFbE1owkjWVDUxhAt64Z2jWM3mql
	eY/MLOEYyEtRtkAuZbCdD6xivZ68f5HyWOGlVogbZbiEtNiLaipnSIQHgtUxj8d8hp/hohSewwW
	QiKXAqJhmgdWgVnoNQmiztX8nLjbCA4uH5n8Tx2AkfQkzQwDxJkECrx+65A
X-Google-Smtp-Source: AGHT+IF35xdCqK83Nq/ybJ3AbuqFKvL1x2W49echwpcmfLqDZKgxLvlKCL2HANZseQeKP1IlFhLxTXVM/a5c4VD3rP0=
X-Received: by 2002:a05:6512:3089:b0:595:7dcc:3a8d with SMTP id
 2adb3069b0e04-5957dcc3d9dmr101267e87.48.1762950971883; Wed, 12 Nov 2025
 04:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111192422.4180216-1-dianders@chromium.org>
 <20251111112158.3.I35b9e835ac49ab408e5ca3e0983930a1f1395814@changeid>
 <b55d94f2-6b79-407f-af58-b9847db3c9a2@kernel.org> <CADrjBPpCKfd_0PY=DULnmqfb8veqH-SQ-kr5gC6Y28uBVo8iRA@mail.gmail.com>
In-Reply-To: <CADrjBPpCKfd_0PY=DULnmqfb8veqH-SQ-kr5gC6Y28uBVo8iRA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Nov 2025 13:36:00 +0100
X-Gm-Features: AWmQ_bnt3mMa52ZapQDOrQjKyBrrsOytzgBujrgqyXTEfoNcsLTSjhn-fe-x9cc
Message-ID: <CACRpkdYN=FN92cuS3U-XBVoyD3DcKkfzEXYVNnQNK07rxJJZ=A@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: google: Add dts directory for
 Google-designed silicon
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	Roy Luo <royluo@google.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
	Julius Werner <jwerner@chromium.org>, William McVicker <willmcvicker@google.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Drew Fustini <fustini@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:26=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:

> There will be some Laguna SoC
> drivers for pinctrl, clocks etc,

Oh new pin control, interesting!

Will you be doing the upstreaming of that?

Yours,
Linus Walleij

