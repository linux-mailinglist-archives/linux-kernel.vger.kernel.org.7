Return-Path: <linux-kernel+bounces-830488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30759B99D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B957B4657
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFF3043B0;
	Wed, 24 Sep 2025 12:22:19 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C18303A38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716539; cv=none; b=SHyzm8pS6lS6FGFHXqNI5RAqo0HvvuzgBegKfZmbnQkTeyx3i+lIuhkPMADxqu42NMgZn2V9g9QKQDH7rV7tHjuffA8+/cuDyU4JzNdGlPmSaJNvlA1Avg3+W7qYKOMpZdZ0QN7EdlhtYhg6BAIZeiNFXr+Oio6txQMOYhSWypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716539; c=relaxed/simple;
	bh=DYWtNAd2ipu6vMvUNjTxOuC6nLmwhMubAsibachtn+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3SCJb1GXWaU7DDwP9+Dtbp1hUEnN8cVmqyxW0uOsyYDrCNEM0rSDLqTer40W88o8mF35D1G/k0IUEDDZlmus0//YZgAQwgajkHVMlRjgKi723vJJq9qQnUXrzhalILZd7VHlSWU4g1hA9zVgXABQ0JmCeteTxEmmmp8hGhU6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so2321748e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716536; x=1759321336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tAtYXWN7ryUB5vWJvXtt7rrilhjlT2dOX7k08gBfcc=;
        b=XHuxJAwe10Fwa8KtV3c6N0/L6yBYKqmIj4rB7BBFghDyE8ARCm/E4XTOebO9f6g5Kk
         V3S9jSimSvtyNxXDpn2q2nAdAzznYLP7rReEgnBMtU8ElEOmlhYEdBSgR73tPGQ6fFeI
         J5TZwqHpaAdvyOuDdOkulGXkcMis4eEi8esLyzelLupEwDh31GYdhXB28DeRgyUmSynd
         xNRsjffGsHxF18qBpI9bBuE7rYwEAtvxAA7wOuPITalc8+zBJE7ZbmY2xWDrAjxoNYf+
         LGrhJbwy2rDYECDsGhzn9BoUY7TmtGW7lpZ4bp6L29RUF1mhu0iGWh155e4iIsmZF0EF
         cvpA==
X-Forwarded-Encrypted: i=1; AJvYcCXNCH5KuWQQ3/bMh7KLOmigfHXWy1wArnquK0HZK3aqaz7a2v79P4vnIOlQoZ6vnhAW2jyc0aht1L4P/Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAO8HIOXU9FApE/lcR2et8nUpbxaDk8hyyWp3rYGOWgChfVJh9
	7j9txEaut9PBlOAbNVhul2lhyJBnkQcShzl8iZPt/dW+a0bDoaT2yU4ZGzmQn/ME
X-Gm-Gg: ASbGncvLEveAiqkpJrMAGXI0c6PJIwExo4bP2f05DQsPtOYmxDCpapgVxJ3lnxk7S0D
	zigsfRkYwnQs/B9KdgD0C09V+qjQ/hLBepAh/4dFLrO8liHgM/bPDVllPnM8zQD6ovn2InRLbsY
	M2nsXASOJdRAb4BuZB3xr4rddAD59BWXFtG7Eq2p7aDOwUzW2kbAG3xH4hCN0pDo9yI8dTjAUOt
	0QiQsZPxMY2ZE8LSysUt2P3r6S0Ocb0bRMi4PdIWVIbhjTax4WSMwhjaqireSyH0qPsU6V4GVaA
	of7HE6ByKMKgIB9hgtOTeslAHIH/dBYRKV3Lyb77D4/F4s0LDZ0qwyoD87oi9D4W06gJfqZGkio
	yeiDfIPMZ1Q4LzmF6CD8zCvnmPO6j1s54XYIY9hi0Hf2zez628DTCMTmr/FS/
X-Google-Smtp-Source: AGHT+IFu9AuGE0TkjVjxoFLFZv4xNmO6pVM2EwnQjE5YNzotA8699iMOosx5O0fnd7itNzUWi9Z9jw==
X-Received: by 2002:a05:6122:6582:b0:54a:70d3:66b0 with SMTP id 71dfb90a1353d-54bcafae5bbmr2100607e0c.12.1758716536155;
        Wed, 24 Sep 2025 05:22:16 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a8d9f286asm3117990e0c.0.2025.09.24.05.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:22:15 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-580144a31b0so3043239137.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:22:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX66b6OasnSfHADWsBGFMs1pXANYvt4osaN7X7cDxdEDRlzPrefKC6C6+bfMlwq4gwFdqwSnfTfDmWq6TE=@vger.kernel.org
X-Received: by 2002:a05:6102:292a:b0:51f:66fc:53af with SMTP id
 ada2fe7eead31-5a582ed6587mr2478165137.34.1758716535525; Wed, 24 Sep 2025
 05:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com> <20250916150255.4231-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250916150255.4231-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 14:22:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgjgsAG5my_vDYF+2692NyFOuDqMXH9F-1zE_KXVzigQ@mail.gmail.com>
X-Gm-Features: AS18NWD96xgwB4aeZ6Vi7llmU6wbBVQwbgzGfR5YAigBPMea8x1UL6uuirF4Jr4
Message-ID: <CAMuHMdWgjgsAG5my_vDYF+2692NyFOuDqMXH9F-1zE_KXVzigQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: phy: renesas: Document Renesas RZ/G3E
 USB3.0 PHY
To: Biju <biju.das.au@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 17:03, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document Renesas RZ/G3E USB3.0 PHY. This IP is connected between
> USB3HOST and PHY module. The main functions of the module are
> as follows:
>  - Reset control
>  - Control of PHY input pins
>  - Monitoring of PHY output pins
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

