Return-Path: <linux-kernel+bounces-864598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BEBFB253
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C904854EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39203148D4;
	Wed, 22 Oct 2025 09:24:14 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB555313272
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125054; cv=none; b=gQ77BUE3CfFbznS2/4iQx686HjtM6PWNIpxvEmZOk6B5E/xcph1/Qvnw/zkHOyC//bwjLinix8BAH/uAEbyvXWkyyl/iHUKcoNWvVocuranlRNHFNsHOC9A/Pyv/qZG2ZwOZmEcbSiZ8ORwTTyIyIqshG5+AuIC2rBR8hq3D2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125054; c=relaxed/simple;
	bh=8d6U+AZ6ls6GClKTwdIqFENvIc2P8xFjCTiccday/rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/6/n6yzrsjIVWs0utiWqac0uoOOIjX6RYNGYpHb0o6fTYyPg7CJBPu1TOzJ1H/ZAmCGXp/RN+Buo6lvMgaQ7r6bMNLBD7+w0j+nJ+nhTjeKP+618F83fsdAXgE+gubi0epalQULrQiCN4WOepjuM7EroMXAkUOZXioWYdRk0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5d967a34203so751531137.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125049; x=1761729849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fY34+dYGV7UyIONr40TVvg0COyfe5ASAP91HB2HQf80=;
        b=r0e7UnFEd7XfHngtwTvMXYV0zQsrfhHLmoc42IxqnOIwtTznLEs8f49WVujUf+XsQt
         e1qhhz90/fZCHgRqBIqa6rjxyin7jCZ607eqLiEfTGzyNtaWWhHz/q69JqjiUmGuZcpz
         4Vce/MOOu8ifjqwywyZOfKS/SgpiElL4gPGtRX0FtVvYIGcCB/8d4aqe82J2025l4krZ
         2AGC9gbB1GKCrll5BxPFM3ovaiiwjeAbxDzWI6S4hYVJVBth4BAhMrw2IgLg9aMsGhmf
         ikWl2sDLbhGfc/p0Y9Wjfta3hrRMWC6hQcEOmro1cy2wjo6Rd8OPMkZdiPF0RSplQZGn
         jbeA==
X-Forwarded-Encrypted: i=1; AJvYcCXCqMf08XSJ8qZqSXUliYCudfcGjwvqcnktneqd9rVq7HEs0vRKAUm9csSPbhCxjiUrFPvwYYUeVDQgJ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWiqNAIepM2jn4oky8MOWtbgvv+4hkyzXePmHs5CfH51TXBYY+
	WaLpjRbRNNcMIhVeg8CNPHB7BURVUG5n/ST/HQUaN+HsnBwHrtGaZLLA2KH49Yoe
X-Gm-Gg: ASbGnctg1zylfMURK5d1rYXyGL/0sfRNad+kPyfr24sqMlWyjaBxNoXKS1F3oHb/jyR
	0rYG/NMaFaTG55CdvFbIf/Wl00mncSNp2zWxWT3yQXhvKRtyvqBtQTqFqw3/wgaXuPpHMJ/JGGk
	YIo8onO7eCIJGIBtUqkU6VO+uD2xj9R1jZ2Ur2e+7kuSRTZ2S4T/Gdn+3HOkCkOVR+yS+fxZhNl
	hMI7fayn/ZW+8JgzQAGWtxXtuYj4MPqzi2TnjaPHunEAdzEm9xa/2qLZsO4rp7edZ6TUxbBXaoE
	Ix65Uj+ilIJ7jsixFCfkDWCRZ5Jn010EAEbTeacgcqdDoVLahu+yNE1VTjDC9WODky/tIjiti7K
	EUNPVNdJgAOcPJnb4hYeNkyOrV9empbC0Vi9xcINzVLZ9ZldMXjJ/uQg5OE+5Oj/Lp5A6T/F8cU
	ijyVoxWy91Hh8UcNeLNGXFg5HT79IeKSHj+17QVALHa15I6BiY
X-Google-Smtp-Source: AGHT+IGg8Jof4P5deaoJpbjnZ+27a90MAsI6HaiB2+94hjJ4JmAgp3O2yB1SG2BlINcsrGLM/N1xKA==
X-Received: by 2002:a05:6102:358a:b0:523:a3a2:2638 with SMTP id ada2fe7eead31-5db1b3a8721mr1097446137.2.1761125049400;
        Wed, 22 Oct 2025 02:24:09 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c1156e2sm4347598137.7.2025.10.22.02.24.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:24:09 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so823957137.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:24:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKvhRsO/6ngZUVL4ywQQlkgA6+YJy8lSVbQLq/2NEqo8wjv6cnedzlKhYztCVYmwNtuEC9G73rlUfrCIc=@vger.kernel.org
X-Received: by 2002:a05:6102:5e8f:b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5db23797834mr205161137.4.1761125048873; Wed, 22 Oct 2025
 02:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022073558.1992384-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251022073558.1992384-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 11:23:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcMmhsxzyrYBQ5k24ZTMOAGutOz04Z5yemSGixOW-XJg@mail.gmail.com>
X-Gm-Features: AS18NWDZOT2RRrGWcZmqzMmWwxTEKA6GdpkcH_3d2HMddyNeE6iqlTCgn_Djfeo
Message-ID: <CAMuHMdWcMmhsxzyrYBQ5k24ZTMOAGutOz04Z5yemSGixOW-XJg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-rzg2l: remove braces around single
 statement if block
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 09:36, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Braces around single statement if blocks are unnecessary, remove them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

