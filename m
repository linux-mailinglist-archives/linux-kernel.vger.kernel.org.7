Return-Path: <linux-kernel+bounces-899918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD81C5917C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB0562A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D39935CB6D;
	Thu, 13 Nov 2025 16:54:59 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00035CB68
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052899; cv=none; b=Ca2QOVJR9uPdfjHMu7bB3fPl2GY8YGTNUaksfAtPuT6bo6biOwzEimUysddtOwT83bjHmcATHaEZuq4W4aVCj4a6WGDIm+9pVeLEiIs8lp06PoJBvl9YchwVfXMcpaTWzfn0dTSxu+OKG/zwqyLrzPAFoh9vBHOOSXabtWp3yP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052899; c=relaxed/simple;
	bh=/w7U1lULN0Wt5cy2n+o8BXmaQCUvdOw6lpumB8VVy08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdANJd36QrQe8y2jd5O/xOMQNtXQgJJ3GmGYnSvirl0n83KKuj/4W1ha3yQ8fP41rVl6MgEy24XZJbE7w0FvaMdcuU/n+7rMcU8no3X0Omsz9xP66YQDwJjTu4kSmeleDDo8x4NmRhk7TebemGL/Vt0BIXcDXGWxxvuki/LBkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5595c4a7816so667113e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052896; x=1763657696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiVTOOriFml3/StIKpZ5dwhW9Hno3lDZNqDkWyJuxDU=;
        b=SgjYrOCvwk5fGMR5LtlnGlCUg2FEaFyG+1Tp1d/jiPMJVki+5DutDs4d2cdsZSD5iL
         O7YJtua6YSN5wxUZTLI1Zj8TD63tFNED1M3MXdaBlAwqayBrOuu1DoGuwrfRDkm4OyrN
         Bc/8NmCyLKfH9C+MfcXt2mUzXql2GenGjGj+p4FD4s0OJWoqwMe0ZRNsRRLn1WBuLRmN
         Z2lpT4v8r7+m2Ch//tg0rk2hfWwHc9RTKhs7ym4PgNfbvFvAt8yRM1u6+ghK/FSYbZjI
         gpFfMtleU0hUkP2NLUDE3b8ByA9XFWPCSUEwDwiZN0opcTjy1gl+w1hzSlvmYu81tNRA
         rVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGIg6gqeNFyJ56aM9P47zBuiK3P1PXcIQR8nf8caS9LpU2lqRIJNsyg0gA+PvUXXZHsJYh4wEKXXYIbzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjo314h8yXCSMJJIqdfuMzAB5UO1tn+9nx1PvQXakCFyef9a9
	FgsMFy4Gd0UKSyOZd1MdqQzuzs2VBJi07YTBtpR3qBJxValqstIbynaLBmWIcuQ3u7M=
X-Gm-Gg: ASbGncsFcDna4MGzBN17c9eAObMCmtK+FfHWM6MzwHWIyBiULi6WCkpSSrqm6fWjTls
	fc8UTZz27LQ05KiTQaHDmqo6Kw9QL6Z8m4u5f006yBz3Sxww09YluC5Ijl27BVyTqrERuFyJXxp
	KjeaVwGd1F1OU+xQ97Fzz9mYk8O63LLBPD07pw009N0xPCEokg48PXVWLuiTXGRvhe6DpK96AtP
	O5RsMidx0acC48lYYSLCFTuh63TaogMjEgWs2L+nHqKT+jdQnmXFPbSFjSFhvUy4lPaYh0yPCUe
	Ek0YgF7lVGIEEviAPq6fj9dtEaKsZRNBg1mst2k3hZyypPcCVKDN9ydrk61lkpiezuxasc2w5Nk
	f30oMWAi4HJwmJ1V+vsi+4+Saia8UUal/fEwYM/7NGMPgN3fTSzv42uJT58TdrH6cRHcpj8WoiB
	DD5JP8/Oe2fycqcqqnWXlqw+UC6owM8iPz+bqkvps3yg==
X-Google-Smtp-Source: AGHT+IG2gWx8FRDbkIfjWZqSLZS4nnWYYXUVoxJ0xBXz4mi9OXPKH0EJtiES4otztq6WFkrLobQ4mA==
X-Received: by 2002:a05:6122:488d:b0:557:c38b:4dbd with SMTP id 71dfb90a1353d-55b1bde8c79mr206275e0c.9.1763052895716;
        Thu, 13 Nov 2025 08:54:55 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f359fa2sm932578e0c.8.2025.11.13.08.54.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:54:54 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5595c4a7816so667099e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaq3CoLJ40GoMx9BfFPGrUpJXP+BQeFKWWMBVxVYZ4qgFjnIX1dP9dLMQZ8hKj12dzyGfYufGLo3GZlvA=@vger.kernel.org
X-Received: by 2002:a05:6102:3751:b0:5dd:c538:b85c with SMTP id
 ada2fe7eead31-5dfc5b9485dmr175827137.24.1763052894285; Thu, 13 Nov 2025
 08:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251101050034.738807-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251101050034.738807-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:54:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRkiJHSFj1QsQjH_6g-WqVK0aYE4Q1+WS2zGKLXWoj1Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmUKyeVUtnm2gNnWCtpgD7bmlT9Yk_sNHgyVVXH3XqZY-ChGkFlPHKyXXU
Message-ID: <CAMuHMdXRkiJHSFj1QsQjH_6g-WqVK0aYE4Q1+WS2zGKLXWoj1Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: renesas: r9a09g056: Add USB3.0 clocks/resets
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 06:01, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add USB3.0 clock and reset entries.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

