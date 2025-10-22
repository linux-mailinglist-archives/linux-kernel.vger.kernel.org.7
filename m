Return-Path: <linux-kernel+bounces-864684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7226BFB55E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AD98506A01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E63254B8;
	Wed, 22 Oct 2025 10:10:38 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E3323414
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127838; cv=none; b=D4rm5pEKIGKMhJU2iFijs8gko9ue9ZnOnNmsrbyq3rUgUBpWveqKyzKhchpQSMJ55Wg0bbtzet/Obo+C68UGv85NaVrhrOeqy9xvbGGcAOB3ef4lUeeOiACqsYbe/xLMiUOlb8vxwZMWatcFbE4E65i9ug7bWVhZl8ZfB3eBSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127838; c=relaxed/simple;
	bh=59/49K3ZN1tUBWEWYa+DC5Kzr4dbDuxfMnqefZEkseg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKEhAsJx1rZ5/C94NAsawk/4lVEFM54wHjGlIm61ET86TYpnmDuhLZWNY/YR2S8dRVMCnpfeYmUtRJIa0VuZo5IGyWGQpnRlsT100qFtDWBoWvTX7eg1O9R8vO37AjCCSz0YqtuWD957Gf7ZjP5dhs0/PJQz0S8KOUw3UCir81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78ea15d3489so76834236d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127835; x=1761732635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9nsZS9cf0Yesyto3hqsvaV4sJKL6LJk8tudSlukngM=;
        b=BfK60+HmsZjedIrvQIGj8VWgZOStoTTeITvXs2hKS/GIybVGzoNbYF34Zr5flVJdhc
         sucoCWLtZhCCKnwcg6X8HzLaB4IAE40CNoLiU1sT304NimJ9A3f2Uz4s6EPfcGrQaF+a
         sEni/AbALmnq7pBs0LzyKeiDvGS5dMD0mawN5Cp90g5hp4BndkHcUJ/89DVv4QN2GaCZ
         E2hyKalghMQkAXrQmBKpXQ+WZb0/cBPEQ2JFEVpXTlrogkc5JfAfmnvjMSMxC//VBPVd
         J+1iBIcog8KlmRkq4DkFWpS+mgf7ZEKlrOBXxD0pc1j3c+7iTjurVhAY/kxpZ0uwqQGa
         dPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPPqtjgU/hIsej5NJ2IY3xmeouZYkIIbWCGFNf0mO1gktPCZCChf5xaFw9uZYxr8zsBux4kbBR34dX5XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuGHxiYss1sHJz/pDNFdRddIn87MGadC7UmdtUmW2ujA1mg9i
	0sSycdDo/J9ZlvGpgkglhalCBYmxh1ZNcVySaJawNHMYEV3qWT7KsaMHnWutqBDu
X-Gm-Gg: ASbGncucn23ZQ1kbHH+ltVu7Ol9TxUpYPTvpkXGWOPzAa11vFKmX6P44OjsF1Id4cpd
	XOKkQjb15qnWhTIrF8X7ga4MpF42yZRkmp2dcdPSqwVRlsu+wQ8DBnosRsy7tq6nRUD3+NvMBhl
	t+mX/A16qHC/FNT6figCV7M+EdNakfMAH0V3FklEUAUsxSDOreiOWHDbFqlEjagUahCDotDYfCo
	fY/BIBVrm+qKbpIlFLPhWqFBf1xnN9pt/pGbO1mEYdCnQ0uh1+08nbjAPlZd5+z9vAqYXDUMT9h
	bOWfSKXeIclKxjhFbZCnO7pij16LJDKKEnRxb86yT4wOUOX95hCnnoTvZZINjJOBDnmiV2qAcv0
	yiUlJYWndQ84tYnQWdyOa5ORFEgho2B74YXIsdb3yHc8+rZsXNcY7Wj1m2mlC927sWxYWDhyd+r
	MKRY4E7JN9OV9DNSB6GrqFp2gQ/uYMWVNkvuH+pWatLP8LXnh/t0nH8mhwDjw=
X-Google-Smtp-Source: AGHT+IFrd+FX2J5wnEhnVqeRRR9Xoy4j9St8INdT6/zXgUf6BNqt8+C9o6M81wE2I4mmm5apBw+LDw==
X-Received: by 2002:ad4:5b85:0:b0:766:be67:3e63 with SMTP id 6a1803df08f44-87c20572737mr232038616d6.18.1761127835276;
        Wed, 22 Oct 2025 03:10:35 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fcd46sm85259666d6.11.2025.10.22.03.10.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 03:10:35 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87d8fa51993so67216236d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:10:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe9NeFiUAp+Ybpn3ikA3SoC4yZ51swQiiaqEnujCgnchMrbppWWDrqzS9TaV66UZL4lvbdTazDeKInEKU=@vger.kernel.org
X-Received: by 2002:a05:6102:32d3:b0:5d6:fcd:dc86 with SMTP id
 ada2fe7eead31-5d7dd568745mr5376089137.4.1761127531051; Wed, 22 Oct 2025
 03:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020101311.256819-1-richard.genoud@bootlin.com> <20251020101311.256819-6-richard.genoud@bootlin.com>
In-Reply-To: <20251020101311.256819-6-richard.genoud@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 12:05:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVf2dgWqsfVt9HCytJmmRLYiCkhzSJVp3drZ6KDq0Wwg@mail.gmail.com>
X-Gm-Features: AS18NWDWB3ss9iz68cJvppf6RUhrU6v4v0GhpWefkhntn5szf5Osn3JvNoovQ3I
Message-ID: <CAMuHMdUVf2dgWqsfVt9HCytJmmRLYiCkhzSJVp3drZ6KDq0Wwg@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] mtd: rawnand: sunxi: rework pattern found registers
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 22:51, Richard Genoud <richard.genoud@bootlin.com> wrote:
> On H6/H616, the register ECC_PAT_FOUND is at its own address, and not
> part of ECC status register.
> So, introduce the pattern found register offset in sunxi_nfc_caps, along
> with its mask.
>
> Also, introduce a non compile-time field_get() because FIELD_GET() and
> u32_get_bits() don't work with non compile-time constant.
> https://lore.kernel.org/lkml/cover.1739540679.git.geert+renesas@glider.be/

FTR, v4 at
https://lore.kernel.org/all/cover.1760696560.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

