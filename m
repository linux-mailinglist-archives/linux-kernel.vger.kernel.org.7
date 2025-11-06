Return-Path: <linux-kernel+bounces-888772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7456C3BDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3003188E8F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7931A06C;
	Thu,  6 Nov 2025 14:46:01 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F018D65C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440361; cv=none; b=ciwq45bKLDSwiMSmzoAWfdu9628zTT3zBEFRW/lDYdolQrVSKbGM6lQ8ksRtVIleiQ+UxVa4VBo9vXn36LEhHYIxIpnHdig9RSjYOdrjZqRCYuDJOan+C0CE9VHagCPGHlLGt/EfiILHnJkr7+iREkFj3YnnYLYbWEFRPGsREOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440361; c=relaxed/simple;
	bh=Rko3xstkOlWNzB0nEx8Xajkj6lMTjfDffEyYCE5Ooa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGqmtZsCqcdYtXgo2zS+SqqE/oxSpOrS3DFYQk5gnJe+qD33BF/yd/1YyN6ITg2wNnCA99nlCo8j6m3vA67EGw2VdZNizVl/J+7yKvhosa7LtDnTNaZr6D7pC3Y30RhzctZ4FklJwu1lmiFEt2skOr0tzqC+VvzM/regBIdY9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7291af7190so136036066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440357; x=1763045157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3st7eMMaSXO0TyFbpqjCRrUrNA04OPi8LDn9CrKLFWE=;
        b=fpVECor6tz+eqNOtL3BhxBf5S3C3rdYxiwXKOsc2F6l85eAsUqU+4wi9WFc5GqUtqj
         riqaX8wsw4cIb+4J3Zpnk4YC4bJN6IBDy9Ptr954BOztB5aTWmV/SkW8nJGEzHJTqmts
         DYeCVjrDjMJJLMANGXMHxQeyidVpflPPIeVZZqogQrZpztV8sL24OM1mmZuVcKAybh6+
         7ukFUiaZa4ZXLfnPZyS24CVX8WOstFOnEqj00Tv9TGngzywfuMZ7hoU8RY2mywxlhb1D
         CPrbEZpKCfCHJkGrFMhWq5RYhIqX6TckR9cwYQXhAfAPjAvsALxmMZcmiJYgnQtOBFpB
         LabQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7aCx1Tw5KezDiRSab9wIUjbDdb4ZAa2oYcRF12ub79SEM0xnGJOSNbM+301yRE1coxVxAdFK9hg6OX3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVJlH+X+gb8kEbaVN90wzvd24SvSLREr3/flgWIQBQjnJadYd
	u92zShe8rAOs+Kwbkw+SmfOlhAEyIqLk62pCmie3Ps242w5Cq6MoN0smcbTeL5YDvvQ=
X-Gm-Gg: ASbGncszUOyTrPB95G8/5l17AlCedm23/IoL7+9BBQAE+Mdk0YTrfcs0ij8M0M2V/3n
	IX8cAqH0Yy2oZsegwHtUJBbo7hr5HT2R4kRQqylypy89JgZ1eqVehV52ibVJFJp+UQbQ11NQZ0R
	DI/1t3KGISwA0fmG/t5bBvB5Nf7dH2WGyT9BACqhkkog+B+TNHanLef5aJ7lSW1cDaqz0DyWaep
	6sEBXX64pgJwIgBQljPjZgn/PWu/lnQkAz/iCjQEg9tFZ5adrVMOr4d366Dfv/GKvh7HYZbr6dm
	1iSDJAM3Fm3Y0PLk5hjn0d6bj1zXpQFuuG13sDO5BTxghZdsg32aL/wDRrydUaninMfoBjd+wUV
	l+ULE9I2tzLoZtQ+uKdLc9nkDxy0v7G617TGQI1P8kB4Tn+RnxQ5qkNgqVtca5LriVJ4A/+kTQx
	OOIXowU3xyUgL2e48TKFkUbswCRNtqhrB7XyKIeA==
X-Google-Smtp-Source: AGHT+IEqDYpIyrJXv2dDGlVWMgajwu3T9mADm4nRq5KMlKuHauieNJ5vWmLwyLcgcJ3ZUWSzEbeU+A==
X-Received: by 2002:a17:907:3c8f:b0:b72:9d02:f4a7 with SMTP id a640c23a62f3a-b729d030057mr269417666b.18.1762440356610;
        Thu, 06 Nov 2025 06:45:56 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289335c6bsm233949266b.7.2025.11.06.06.45.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:45:54 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so1842103a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc+RDwzPm8mQxQjOIJAgp1TpdeLmDAK/EurcLRfiFVeIP7zcjnU6Qq0mfE+lcummnNLyDuudvljMHNQ0c=@vger.kernel.org
X-Received: by 2002:a17:907:94d3:b0:b39:57ab:ec18 with SMTP id
 a640c23a62f3a-b726553b58bmr784930566b.45.1762440353864; Thu, 06 Nov 2025
 06:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com> <20251106143625.3050119-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251106143625.3050119-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:45:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYZ2HwbjGfqec34Yi0hr42f4wqNt__qzdPtOQbQYOt+g@mail.gmail.com>
X-Gm-Features: AWmQ_bnyGe-tBa6vxDdoGWRrQ67QYUNEF41407Ery3IfFjyCSmOT93dLDuJTfnM
Message-ID: <CAMuHMdXYZ2HwbjGfqec34Yi0hr42f4wqNt__qzdPtOQbQYOt+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: host: Do not check priv->clks[clk]
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

Thanks for your patch!

On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> There is no need to check the entries in priv->clks[] array before passing
> it to clk_disable_unprepare() as the clk_disable_unprepare() already

them ... as clk_disable_unprepare

> check if it receives a NULL or error pointer as argument. Remove this

checks

> check. This makes the code simpler.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

