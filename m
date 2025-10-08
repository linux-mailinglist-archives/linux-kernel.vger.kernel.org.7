Return-Path: <linux-kernel+bounces-845256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFBBC42C2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7724EE386
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8362F3C1A;
	Wed,  8 Oct 2025 09:38:22 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3D2EC0AD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916302; cv=none; b=ob1/Gu2UWSYjV4LOgk/8bxxw46/xe4SsTAHTReLyb8Yl6M97IXXivdxcofiXnm3FPaGgcoBr8E7VidWnnqFbWh+p3YRDflkeuteNV/0hWJRe5OiZj1PzP59EQo+gwsCMzn3A0lOPAQGH568aLwNrokj/2/RhNaAadVuSHSufKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916302; c=relaxed/simple;
	bh=QZNWWheMYqQzuuKISvLeOiDECD6lMhoLTkQ8WAFFFfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXBGgoBhLZ9PSZuGMqjn8FBrCGGYVPl11/5H5d+W59eVyZPA7FezUK3NLuXVb6sXkhMlTaG5A0AmvDenapp+hnO04lrg+WTa31WaXuAU43fSNsqsE/48177LRkYgz834qXZolz2H9mQCgXhspYXMCHpohTrBwp//yRuWHbhJP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso561157e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916299; x=1760521099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6l+B9owPtIKrCSeyTE4F8NmW+PJqEJv1NByjt8yVUI=;
        b=uu074/dQof7zQcGOGQbwFUn2KpcrpqMwb0/7/mQSHuNs2uoh253pVDpsCTW9n4n0wG
         K8DiHUu81NNV6/f/X73KYF/LqHes2tWOYtbcd+l8Adq2ijjpeIjjRjhVlUWwk86iM6OD
         9ysunkqmdBwNpqJeEB0tMwX11tOaF3WPB9MtzEgguWEv9tEozJYM6hax6QXaRUbt/Cr+
         +LipkawkSMhwti+2URbwYrGa5gffmXOfyb3RKzKUBGtJJaRPUX5ZQ2d+eZigDeNx9AIs
         FixMeNZpPbHNIyrDeU4eNHtU0O6lPXMuWLKpv5BVAErR2olHOy9q89K+O26tx33cZCp7
         Hprw==
X-Forwarded-Encrypted: i=1; AJvYcCXLR5Ms0o1lgoac/7jqjn7VaMJhYAkyEIguTFJnVtYKy8p2kBg690AipB0NvyZ9YomjA4U0/ke/IQXqNog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynh9AvMQxwxLEAzQRgSRc7gUsB0O4AEsPBM16j3JPqtaKAdzLd
	xBHvec9A2IelIdSkmU/bRaEPVuFZInaXrfZxcyecW33vmGt5SXzB5d5ZMiLiqDOR
X-Gm-Gg: ASbGnctXv8ceCC1E/Eb1Kzyn2DdubiNHiSvU7b8/R+jHsp6DiXBOBmABqg4xoSKObmj
	WbOV00I9wUnBhZqIXQUbv6q/5+dySvT9Rx191STSogbiW6bFt7WxAB6TFXfX4d6NJdhHsK/8XJy
	LYhDfW0C5/IE5dqjMPXJqmmxSrZ6jUVodQHn+8Y32QcFBxI4FMNOE8b4P/k5pXsSAEls8FHdID2
	kI3ubCiY/Eu21E3DvTGnLcKcbSCR6/QHY5JwjpohJ0DD3/KYQBQ4z3/uc0Hic78NdvtQx6NysNL
	5ZEbCMPaGFrAEAzsOx7FVkPjRchNY4hYn+OCzgqrf/MOXtpfTyP0RwXABLBTrwuELR5pa6sQ9JY
	7OaTNNxYIXmmL0AZot5NsYPL/iLbIckw5W1UThsR+YN4dTiRzaObB3P11oOgOMUrdfU0G37teBS
	97/nZUKPOKc2RgLT+YgMJnaPI=
X-Google-Smtp-Source: AGHT+IGMdbXIY3lsP+1P94HjBZEn4NaoAQqIDIfpi9+wfyZrB2bekwRUDYbtWkWEIR6w7yaipR+bNg==
X-Received: by 2002:a05:6122:6582:b0:54a:a782:47d6 with SMTP id 71dfb90a1353d-554b9465a07mr999623e0c.7.1759916298799;
        Wed, 08 Oct 2025 02:38:18 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce202bbsm4401803e0c.4.2025.10.08.02.38.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:38:17 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso561134e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:38:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWu0yITlnh6st+W0xMn8+OXRQYnTViYLuZa5B2YSzdED/OmXk2YmTkrWxvvCG3WneUfin4a4J8NSNUYspI=@vger.kernel.org
X-Received: by 2002:a05:6122:e011:20b0:54a:8ad3:7b5 with SMTP id
 71dfb90a1353d-554a8c9b568mr2813894e0c.1.1759916297008; Wed, 08 Oct 2025
 02:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN-XoqpP2Jz75pjj@stanley.mountain>
In-Reply-To: <aN-XoqpP2Jz75pjj@stanley.mountain>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 11:38:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwpWLvnAWhHqPUL1Cg7dq3rX8wzptHrWC954T0sh9bEw@mail.gmail.com>
X-Gm-Features: AS18NWBegczPMChD6JEBf2DL6C5D4h1G1LphqBzffcl9ZraTnd023jN3u5ksKbg
Message-ID: <CAMuHMdVwpWLvnAWhHqPUL1Cg7dq3rX8wzptHrWC954T0sh9bEw@mail.gmail.com>
Subject: Re: [PATCH next] mtd: nand: realtek-ecc: Fix a IS_ERR() vs NULL bug
 in probe
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 11:30, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> The dma_alloc_noncoherent() function doesn't return error pointers, it
> returns NULL on error.  Fix the error checking to match.
>
> Fixes: 3148d0e5b1c5 ("mtd: nand: realtek-ecc: Add Realtek external ECC engine support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

