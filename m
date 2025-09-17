Return-Path: <linux-kernel+bounces-820197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48B6B7EBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E0520561
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8FF305E2F;
	Wed, 17 Sep 2025 08:05:40 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DC3054FB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096340; cv=none; b=DdgZXQDPQ1PyHi62ZbozMfKKvXmTiPPMPwwwrMKgWEBsSkt9jw/eDZdlAhGzgrNtbkC76bX7eTSvpTeHFQpvUY6FsCCj3IoVRWhSuDJmd6pk2T9EkqnW9wYbPsG5pRnTog2VyLi+00eEt9mkf5n4FmFjnMyYV2ccPtVpx64vdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096340; c=relaxed/simple;
	bh=Ec9ei6B/8ewo89UcVD8Q7X1+MZiGXpFbC8JM3y5kSV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTw3zEmpe/rIunBTB8wilomaEIWGyFCXCakoy4ol0x3I05c24YiWl++NMZqqe2PaE/BTGwONqO9k5UuppjoCr8HvfedAAAQoCjqvJHpVreJIuvjJDvNvbtSeXYd5gZ8+Dje2JVWPKYRA9Ub5Gi7J46WAunVFccNkaniipe7tyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0418f6fc27so1083519266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096336; x=1758701136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHmK1DphSWWRr1U++nog5qIJKFnFzeb4vk8JecyOkhQ=;
        b=IYEDbo4bc6TbNLnEk/RnXpyS8+diMMtR0DTraj/ZahPlPeGGYKucktNkK+nlds69bH
         0Mu3SvVbe2LLoxHUbRbFqOOau9nh6/tPopMIuqkTgKpbQzAfoucdzA4mwlyDBHQf8FPH
         WgvsHippsiSw4ujClozD69YGqRDU9PKrSjZ/UF4JFLJId1pc1y4huGfvNwXBLKfsdpsW
         a7SpIhPbbsN/di8QKkhPfMmANCJROuSLgBkQseIlhBvfuvThO4Sgb/XXsjzhVmw4GdFq
         YclGoCRWWraliN1qFw31C7w7bnq1lnN/nWoJ4311sOzMVWY4jvtOv4iFbcnA6EzAXr9+
         Qkig==
X-Forwarded-Encrypted: i=1; AJvYcCXAz2OdKSZB4j7xWR3d28qocssovhpf1fpX8WU0Z6x7ufCaxAw7zm2aqpfSqX7QzUxUQA6FqOFO4q7x8x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VCSD3331n0k9n/ujgQnYS7vUXGWMZPov3XVENzcp02+B6bq/
	KUzGbsX1TBPY1EFiUcr4n0y9eWAUVQALbdgORbdwYjqPN7Q61saT9K249RiekvfwS9w=
X-Gm-Gg: ASbGnctptjUZBCiDVAy2SljyfG2W7iUxeulxgk/4X7x1vkmQL2v0ziAWyy0BKkBDN7O
	AKGO4gI54cfURWbxDTNuKJOeftV+P7oaW0W5oYhJFfBXFTGyFIiprk3NX007Q4MS0sinv33GTgh
	2jTqfSxLutF6sjF/TEQotGbk3xZ3pclwqI6Mi7zOTFNWO7I2EbJQ7mm7p4P3dqpKYeBJPd4+E/u
	4IKhZvqK4kzrAfeXdwFRRpnsJKqnR+RD+AFF7YvD+W2vjRHESDiqbqKqayYt1pjk0Op5HX8iPLU
	OcyA4Kae3ZKkk2ItaqeZd5kY44mzZf/sRP4bQTAL5SAQXShdZ/exVYE5+7YG2IBGDujACQLpqPf
	Szm+jDe8vImbH/s86lLB/BGaRHw5pLP4FHEdobMKGepWGq2NDwzuTVbbNOytq
X-Google-Smtp-Source: AGHT+IGUpn3Tv6gGFFgCQ9DVOMymK2cwhYyMp5Y9JmJsh3FQpkPZW8FTGAzK07HsNl21d5htsGIuhQ==
X-Received: by 2002:a17:907:6d26:b0:b04:37ca:77e7 with SMTP id a640c23a62f3a-b1bbd49ad2bmr149239766b.44.1758096336459;
        Wed, 17 Sep 2025 01:05:36 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1c40fe2df8sm61724766b.18.2025.09.17.01.05.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:05:36 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so963421966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:05:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq/dHXpSawqnRGvSU29+Lx77eFAE7p+ksENazoQOOFXQtgne0QVx8LwWmFU5EhP/3zxZmJmOEQXv/sgZE=@vger.kernel.org
X-Received: by 2002:a17:906:9f8e:b0:b04:6e94:f317 with SMTP id
 a640c23a62f3a-b1bbbe68575mr139964666b.34.1758096335970; Wed, 17 Sep 2025
 01:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2025 10:05:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhUHAMtOx1RVtva5iGmJhKy1DyvNJdjNMj=OxmL_ydFQ@mail.gmail.com>
X-Gm-Features: AS18NWBJ_DPCNXyZLdkJ7u6e0yw3d9zcREiBtm4I2Y3XsgBeWPU4BTw3RRIOiqE
Message-ID: <CAMuHMdXhUHAMtOx1RVtva5iGmJhKy1DyvNJdjNMj=OxmL_ydFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: pcs: Kconfig: Fix unmet dependency warning
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 18:23, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix the Kconfig dependencies for PCS_RZN1_MIIC to avoid the unmet direct
> dependency warning when enabling DWMAC_RENESAS_GBETH. The PCS driver is
> used on multiple Renesas SoCs including RZ/N1, RZ/N2H and RZ/T2H, but the
> existing condition only allowed ARCH_RZN1, ARCH_R9A09G077, or
> ARCH_R9A09G087. This conflicted with the GBETH/GMAC driver which selects
> PCS_RZN1_MIIC under ARCH_RENESAS.
>
> Update the dependency to ARCH_RENESAS || COMPILE_TEST so that the PCS
> driver is available on all Renesas platforms.
>
> Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/aMlgg_QpJOEDGcEA@monster/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

