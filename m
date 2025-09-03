Return-Path: <linux-kernel+bounces-797678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E098B4136D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C204D162942
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4F2D29CA;
	Wed,  3 Sep 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i97AVeL3"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA82D2494
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872673; cv=none; b=FsULmopSptIO6wLuqZiiXAMm65rqBM81DRFf3l76zB83hMME5xUMvWGRD1ZHrXeq7CWmfumrNm1LyzmtVxtvMktRCquBnVjwy30/yL0HrpKjOpKtwNtJaUTCQo6XwdWSN8x8szldc4GXnJNVnvkAvb8OtAPBZZjdVVMK42SNU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872673; c=relaxed/simple;
	bh=EOpIoZ+QJ3yKu2lp11f+X+mDcgCMYdWaEANVtuakPuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW5+RF9TiuO0/HqSKo9kbg+6ttWgEatenCXTMf+ScB4mq84dfgqdsAkVdew3sKCuSHWy8S1Og2ruRsLLnDoIq6rsJGVXrTNTSDXJJ/A4+fGtSpGb3vqkN9pwnJrZmQkaEy2jjzlac1f4l21CjhwMhGAI0F8Yr66VEpcFdJzMqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i97AVeL3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336d84b58edso29622531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756872670; x=1757477470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOpIoZ+QJ3yKu2lp11f+X+mDcgCMYdWaEANVtuakPuE=;
        b=i97AVeL3AiBrOtPeEGxh/Y0SChfi7/NWkNLSiY4nrdM27ltjZ0tSL4kYDyMuNLPS5M
         N9nYfYy5SOdXVlat4XVQ/oVtqMqmA6E39Pd9fCgXKPLQx7kOAKYschmtO4+AIIJ02edL
         6eb7RsyOIYzcY/4H5BZRRj7ZmKElylqguq8zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872670; x=1757477470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOpIoZ+QJ3yKu2lp11f+X+mDcgCMYdWaEANVtuakPuE=;
        b=lJmdqclp6L3J3AckiGKwtmkmQaSRTA6EuV6zww41OUHes8QqsK+HaCkTbmGUTSOr/c
         SuDNynfmLIH0xzQdexUBrb2GLUBV+OUuR4ap1/9DRyuVfIha1EW/NksAXZEFSk1KmQJZ
         6uYaTqLemIcqWLxaMm60ePfOt2tVwPC8PHRoSCzgWkVD1AZrKI6rR0ReDR5Oi9lbbGse
         IFdrEsWcrY4DbjTw9nNntRm1eQp1piLWbZLnrmNHJRopzdj1R4pTZX5aX19vMd0f+2Ii
         h60RUoIWxlej3dcO2G5kEnquRZfCaG47Yg9FqDXrbm37yMRTA3A0sue8/p5tSH5EmCY8
         xnZw==
X-Forwarded-Encrypted: i=1; AJvYcCUYQrbjip3cH6PmICZtmiFoNij3fnPRAhCrf0a7AdsLWiD442MjdUr76SNknknh5i83WeOvbr7oanUjjns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHoce4sfZu1cVg0gL4K3zAcujjpXObbqOKQcJVDF+QUeVVmKl
	pBErzeV1KgBr3K2TABmp87ofch8IWa9QzeRhy9ZVkE+WAuCj8FETVW6PdYGapOhn2O/sG5AD4Ts
	/RYXf4xBpMdnmwyPu/8ZdLO6yyJo/ADJX8YqDz9/b
X-Gm-Gg: ASbGncuJa5dBy+aa16rs5vWVKpjj0WmFE0Jt+SqPM0h6qd7CYheLnFM2yqB9H/PBfnY
	W8J6rYusTwivS0D/igQfmTg7HJS2Soc2rgvSVvAcEc4iBd7pcYbY4EhDrTo6lZjtzP4Jke/RBm1
	4VghKFysVceyHp4jrB6M18NiAaiYK9ds0BZMiudkKqeLRWx3A6tHiZZD2vrAS501HWmdL7B6s5i
	KAoNcLRDx3wMcv6THJVmU+bYLSE/s2YPWjZqw==
X-Google-Smtp-Source: AGHT+IETiwoqu3jA0q9QRK+CqDCEcgW+ZXk2qygZizGlpal3JlGHcBuz5NWXPRG3Osy7OAGRM6Ng6di200B3S6sTE44=
X-Received: by 2002:a05:651c:3246:10b0:335:40e6:d051 with SMTP id
 38308e7fff4ca-336cb0dfa15mr33548211fa.44.1756872669828; Tue, 02 Sep 2025
 21:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722171152.58923-2-robh@kernel.org> <5d7557f0-841b-45ea-901c-5b595ac8bde3@collabora.com>
 <CAL_JsqJaC47zFY7zvTVFum9oMiV87dgo49a9e3HW1T5_vQtAzA@mail.gmail.com>
In-Reply-To: <CAL_JsqJaC47zFY7zvTVFum9oMiV87dgo49a9e3HW1T5_vQtAzA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 3 Sep 2025 12:10:58 +0800
X-Gm-Features: Ac12FXwYb9oV3zYXJk8hHuf8yXRCNfDIMSMGlmD1yfi_WJphj9A2DKWKSeZdpBg
Message-ID: <CAGXv+5FWTUkjWCyFhnryq2nB9NN3wQjKeOYf-NReYjMDXmgiuw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Fix out of range pull values
To: Rob Herring <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ben Ho <Ben.Ho@mediatek.com>, Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:53=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 23, 2025 at 3:16=E2=80=AFAM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 22/07/25 19:11, Rob Herring (Arm) ha scritto:
> > > A value of 10 is not valid for "mediatek,pull-down-adv" and
> > > "mediatek,pull-up-adv" properties which have defined values of 0-3. I=
t
> > > appears the "10" was written as a binary value. The driver only looks=
 at
> > > the lowest 2 bits, so the value "10" decimal works out the same as if
> > > "2" was used.
> > >
> > > Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> > > Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > > This is just a few of the warnings related to mt8183-pinctrl... Media=
tek
> > > is #1 for DT warnings on arm64. And by #1, I mean worst. :( It would =
be
> > > nice to see some progress on fixing them. Otherwise, seeing new Media=
tek
> > > bindings rather than fixing the existing stuff makes me grumpy.
> > >
> >
> > Thanks for this fix.
> >
> > You're absolutely right about this, let me check what I can do (and if =
I can get
> > some colleague(s) of mine to look at that while I'm away in August).
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>
> Is this going to get applied and into linux-next sometime soon? Only
> been like 6 weeks...

AFAIK Angelo is on vacation but should be back shortly in September.

