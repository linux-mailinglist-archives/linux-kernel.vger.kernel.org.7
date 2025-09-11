Return-Path: <linux-kernel+bounces-812390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918FFB53787
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EA63A8229
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADF34A332;
	Thu, 11 Sep 2025 15:21:45 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACED3431F1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604105; cv=none; b=CDWC+eZDV9e3flwQ3ZXyOHBCoeAp0owMFcD8/cPcAiuvYNBf93aYoQFOsRY4Bm4cvaKmB5hH658EoJPFP4G8oKnz7qPYC+M2li1AWR11xvrlmwslQpYFK47bsbpf6CT1gzsIyJQoaqZKEDPcXbaMkbjEbs0cfb2BDqbeyhBNko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604105; c=relaxed/simple;
	bh=oC4vmluiwrX18cIeVqBz0JWNRurMmcePlH97Y2tSYjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C57aXPPKkGR5xkETvgD1CK5DdtnKPcUamyHX7qGMAYLliwewiPh+Nty00OLk7ZgsGm7eOKvWioIeIblATwob1YOl1sTYSNa1RpDizFmoPUFDqzUPK+OUgID/pIcBo4aqK/Qb/fphBzMNj1y5sPck0XpzQYgofRcGbYDMkMLg3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-544ad727e87so570370e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604102; x=1758208902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zw8eBQvDUCVhODh2n6UuXo9fuHt2pQGWUMRk5klLYM=;
        b=HxeDdU2leQcVUkuYzvhAOLIw4Ja1SweEDsh6tjPB/KCNGUJcgvIp1wHOWKTWUM8HKH
         MutOUUYQ1S92BT8L+UiFCKTvyLpHLy3hwE8fzUe47a8hyJ37jglQ2JdIj1ivg0ettCHx
         5RAdUwEgl3r7pFrS0m8dT0I6w414DxARiSMjpMN2jqgPAKQZnnVx6L6odE+BGQLL5GUE
         1RuvVOdK5Eyl3NuX0aNZUME8XueaC3LXW1U9mhbEanRqI93UWiS8D2XwzVg2ylBgO/8a
         6EgfXKsxkgqFElrw3HKZv7u8uWbH0LsuF3TG6e898vgEl8c5GNXPD0CzaA8BKUEVP8xq
         zYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmTG7VVpepOkSBBYku1R76V3ZCLnYb+eMgv+gjxkSz6DbWuT5xEtPkBoHzWS9xC+NaUOQ26d4n+K/ebJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3WJUm9F535Q0JP+W//M9mNi1ssFWpuN6M6N5kTvjV4Zj0uYh
	1HGzwvL76Ta0WJhuS5cb+jQl2yaDl+nDvHNpv0d0kVYtAM67QjnzZERWXXnyHiSI
X-Gm-Gg: ASbGncu9ZQjUjuf4VBDnB1E/5Cl4/IhLJmtpDpQUaZEmeNFJFvguvA+5L4Fptnv/2EF
	t2HwCF8ZQWVLyPXkIbgRpHL2bJTYKY7f6gY1+iKysp7f/DgTUewpUPOAMgAtVTv9GpvIicV8XNE
	VcdtpwirUj7YXFvmDVJGDu+PyO7wFCvpZg/IVnJEsv7dzE0U1SRS+t/eRCGR9q0tc9fCK/WzzXG
	vqnvnPmr791qxEURXW2a2KJyEVOyzND9CkFpcwm4KlCzvZub8hoeZmvA9SAKwK4VQ/LFxV4GTqF
	uP51Tr3yFXkKHp/gwTaJhHA6G4u0cnyGrseIszFKHDAewz9YIZN+Z+Ots2o+QhaRRwYg2dL409D
	0y1o0yR01ibSMN0tRM7xvaA6enz2tj1RXkqSgMiT6CsNyAupy6Hs42VDu82iEXHvb
X-Google-Smtp-Source: AGHT+IFJQW45G6VZzCIvAu/0AcNaWBcplTJVFUovaPMEeJAdmMjnJBS8bHHLvKmaxSK2zBTps+bSAQ==
X-Received: by 2002:a05:6102:1612:b0:521:d81:6dc2 with SMTP id ada2fe7eead31-53d2490eb0bmr6933122137.33.1757604102064;
        Thu, 11 Sep 2025 08:21:42 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55370649fe7sm372023137.7.2025.09.11.08.21.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:21:41 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-544af5b745cso552080e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:21:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWT9kDlKI/TVuWt2qHqPVx2cGmJtob5KBJBkkVj50wt+sdsFntThrApr49woYGmK2tdLxtU3dJQ04IjZuc=@vger.kernel.org
X-Received: by 2002:a05:6102:14a8:b0:529:bfd2:382a with SMTP id
 ada2fe7eead31-53d2490d25emr7502207137.32.1757604100881; Thu, 11 Sep 2025
 08:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904100435.4033858-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250904100435.4033858-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 17:21:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+YXwMCbQy8g88s8hQ+zzV8Vqr2iaX98J5d+RR_q4QiA@mail.gmail.com>
X-Gm-Features: AS18NWDe3BfDNkISbgAn9TPJsLdnq75CKg4tLUlECWyOdSKnu33jwgTzPbJMnms
Message-ID: <CAMuHMdW+YXwMCbQy8g88s8hQ+zzV8Vqr2iaX98J5d+RR_q4QiA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: rzt2h-n2h-evk: Enable USB2.0 support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 12:04, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable USB2.0 support on RZ/T2H and RZ/N2H EVKs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Reflowed comments to adhere to 80 char width.
> - Updated comment about simultaneously using USB host and function interfaces.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.18.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

