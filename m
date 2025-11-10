Return-Path: <linux-kernel+bounces-893423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60136C475AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64B624ED452
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D793148D0;
	Mon, 10 Nov 2025 14:51:51 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC30313E3F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786310; cv=none; b=kNM5xoUl0RM1QCt17Gw7MWBc4X3pS1C/rMKcOc5a0CY6JdgLEth1g9TrOlqGyOOWqymMhU4MFZyJDSdEZw6gXxZsaZjBewGRReqL817ZGZ/hgS1ErWD3ShnR3Xi/lJYH7lZMvwXLpdlmrCAYbiDg946rsrkyA5xllT+dUydey/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786310; c=relaxed/simple;
	bh=CCvKEtAI6jJe+wQ+hvQBc+gGA4o7sIkvHAFBhmYQfzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf8ljsTj2EWmxmD6UYfCl8fySoMavdUrsHDSPimxB+VMW7ddiF/onLNnDcPQmKGT+uSKM/JI3L8KME9yJngAxkYcd3SK4rb33DdJhFNFldP6CdvBVf6bV6ALQHqlmW1fGzRZubKyEksfIT3rFK0xrmtERpwCFwieFmCYRTKwZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93720fd0723so659643241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786308; x=1763391108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/xU9tR1E4wV7DQk5eCBvIBzhbojswkrBibvtyFHs7k=;
        b=SOZn1Tu1oBBRGgfwFFrk5qEltsD/01aW6NgVop36pl2362WUIbw2ar+W1Q5SjwsTsY
         mDohwrR+7rTX4aL8e1rQgiadAQb1PvFA546RQ7iFRKRs5Jb54hxJ/4A4Fvip2uRsdDnH
         8FYUuQmxxXGz3gcvmLNAHqSyEImcyypilKG7pPPbO71vDywri+IxGyP3c+j5DKtSqS7h
         U1+Hte0CXv5CXRWo9DFbP2MRRHkK3UkoWcLlBsWNhAgPZAIgMsNLZUaQSJI+4nIFARKP
         RIsy4VO5nS7/dWBhX2ynBRMzFHsSaFtl+QhbA8CCycJm0a5IQ5+c+YOU4UQtk5ZnWCVc
         cPaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWJX4l1+k2Rd5FVDFbEimaeEZEeYe0GgGy2rrCZ2vuXMLDxRz3kVTY+lMPaKhBjICiU1kImQB15UDgioQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx63ei5tbZjAx63nIWiNW/3MM71V9mMkc3QFmraSvozQBp5mvp
	hF6Wt26lIMuCdR3GYzXVYi/Xvm+B1G8Serrx8TCNd/0Dsi6GYIrCa8GNjFMmpZWF
X-Gm-Gg: ASbGnctwsSSm2U6WRfpLta4pDRlfd43gEoOowQfdjXobwwz31Ynx0ORNuJzRRtwyzg7
	mQSdAIZUx+UXFEGuS3Lx/kn+cmUF0rVKg+81mvA0PCxnVN9MngDQYZ9OEh0o30t2OCFKxb67TLv
	QMzfiPhpIkN+VdhiTnpQqlf+3NEXsCjgFKasH/SjwzZCKV4AGF6vwNk83+S7XSamY4nNbY7BBGJ
	b3Lp/XmOFaME4Qq4RCYJnZtXDCFEELRjvqI3PFofwZ1zRwCrxC0DrTQ5JIqZGrGXfAAB1ZhvgrZ
	cuuOADFKOysKS9aJLyqT704QPTcB6ZBvcC076Moh+YTY5mNn/b7qEEoRR6y3wRZImnZfVIz9m93
	DPRT106kA71JLyWMp4a50XCCrZrZgcbkDvwdjbY5S2qkCkSp/L1jASv5jVLmZibTzKesVHlURZe
	5EDCkamkqOp4wmqpereKXtxpBmti0Y3iIrJ1urUH0KGxu8uOqU0pl6
X-Google-Smtp-Source: AGHT+IGMJA8xkPzJKXx3CC+tQq8yzc3yz3oYhuYv4NlWuKnkTRYCRsx5mtIJCbbFx826bjLDE+Pe4A==
X-Received: by 2002:a05:6102:32ce:b0:5db:e721:8624 with SMTP id ada2fe7eead31-5ddc467eef9mr2520663137.1.1762786307477;
        Mon, 10 Nov 2025 06:51:47 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708aa2ef2sm5874975241.14.2025.11.10.06.51.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:51:46 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55960aa131dso916798e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:51:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEs7kkEZ5/7HKTie/IXhpCZ4DUbcWd0nzgdVsScUVcUMDvrLgEI1Pu/kNaYxPqPHSBAGf2vA0LzRgJygA=@vger.kernel.org
X-Received: by 2002:a05:6102:c90:b0:5dd:b100:47df with SMTP id
 ada2fe7eead31-5ddc467f9cemr2192981137.4.1762786306367; Mon, 10 Nov 2025
 06:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028175458.1037397-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028175458.1037397-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 15:51:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdURuFbC4U7_G7nfCFubcxj=3MnrFp4S5Ez-pe8bF-MeWg@mail.gmail.com>
X-Gm-Features: AWmQ_bm_zKD22m7Lh9siCarTBK_WgDcNJsSbzh_nmteCRcAMLoqoVhrNrXJOf1Q
Message-ID: <CAMuHMdURuFbC4U7_G7nfCFubcxj=3MnrFp4S5Ez-pe8bF-MeWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: renesas: r9a09g087: Add ETHSS node
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 18:55, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add an Ethernet Switch Subsystem (ETHSS) device node to the RZ/N2H
> (R9A09G087) SoC. The ETHSS IP block is responsible for handling MII
> pass-through or conversion to RMII/RGMII.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

