Return-Path: <linux-kernel+bounces-883145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB9C2CA80
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BA418804C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7470332EDC;
	Mon,  3 Nov 2025 14:52:09 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6C332EC7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181529; cv=none; b=ufhzarK4WlPRWPB04zw/CmRmZD3Ht0HRFl8B8Ns3MLnpseJe2pBA3DfEK11gPnNugEyYISIIGT1kLodVi6hfJen4Z7TQCD7TNCurq/GnPK8b+xrsdLvpmc6F4vB9iv+E6kGXoN6oFMmXXngbVRCky6M1K4ozpTmzfrSO1aGonRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181529; c=relaxed/simple;
	bh=kyZFo/IEic/pNMA3pRq7OzAQup7CQuPdzl24uLGrwEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqS+IhahzJ7Qr49k47MPrl60H9EY/NX0XuQKHvflRvg5twiaeouQKBeZTNu7cuBdkGtTX8xlL3Q1kC1ACZtHHWkenI8V+5EM/Ax29lM7dnG01n8L8rAb786iwmSPT4aJermqQQS0RsEzAVodOtBlDE8uRb//HBk8ZsXs47yb6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso4212914241.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181526; x=1762786326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yZuUM0vSJzTDMkCs4SIwBgC08R7t/skmrEIOYPMpKA=;
        b=IcNS2XXIayf0COOIgJ4+Sy5UJkoI4FIWkTINz7j8SFh3o03X7O4eo/JbXRMy7Fwhqw
         lfY93/1vVkfZbtvF4eUdk2+KJLtDq9D5Ty5NtWelKb0bCtas+e3Q1al07t9phUwtVM4G
         SBkm5ufPMGA/JPVUjiRM6cE9GLHZWUSE95BRUK80Afp0a4jLGYuEwPFtimzoRYDAb4wN
         gFWiZLNuRAbialu4fJA1LcS0nRPdeC/I9W3hrL2SzrimK9PQfUa9ks3CWrVhMsgfWDWp
         olUq/Hm1+XogQ9yb0VAZZ9yilO+LveuzktBaeAByZwnmczVeuL1Uy8WvIHlOE2mOCAs9
         SjYA==
X-Gm-Message-State: AOJu0Yw5cJaVJIx+5LuvUGR+1Da+IbXgUnNVPmAisVtNA2jaDs8KPYNB
	8BsTVUuSccYpri4vs3Uheu1DjBmHuZxBaXO6lVPqrq7vdlDB62NFMVO0AvHXRY/g
X-Gm-Gg: ASbGnctF51aGztS1VDkmJ5K9D603nHthIyFJfP78a8zx6bb38/WYMY8In8fJ0kVt7gN
	ik0042SLRPVr67+w8mGbLBNfwhi3aNB1XCvtKVLs0e6iLPNvOQJfDB5q7UE4tx6s9VP7E21UI3w
	6DriA2ohL7dZonQqCedfe6Oe+3kdWQPNCiFEhd5SQia73i/IlZ4l0nEC/D8kgR+rF8miH8ydzDu
	vlT0LuEWLxypue1i5KaS5fzRhTDsgN0wHUGVjawdBtGLXmBFy99Ci9uw+FszLl4HqlogGbrJy8H
	WLZoC8ZK9uEvyIJRVDbax5UtNOG+iJj/lB1QFUibvD0oe7MGkkxKbNN4QmHGFzSlc7Tg6riPNNA
	g7x6ljk7IWem1ZcCgHjQn+YxzpxAj37NQ0ZdFnzIiL31QOBKGeXHaGvdVRnAOYzvihIrWz31y8k
	VX56FBWTaZrme8PGyE5BHLMNrflm5306Cdk1Jcq+Pf/lUeaqIC
X-Google-Smtp-Source: AGHT+IG9VvnzDXtX0JKFQiQUX+In4MVf6y6Akxn4NQO63RSBV4mp4D/++PPUhhN1Oq8eI4TqcX3yrA==
X-Received: by 2002:a05:6102:50a2:b0:5db:e373:f0af with SMTP id ada2fe7eead31-5dbe373f995mr875526137.31.1762181525976;
        Mon, 03 Nov 2025 06:52:05 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf332cebbsm172757137.13.2025.11.03.06.52.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:52:05 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93515cb8c2bso2630563241.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:52:05 -0800 (PST)
X-Received: by 2002:a05:6102:588d:b0:5db:c9cd:673d with SMTP id
 ada2fe7eead31-5dbc9cd6b9amr1394207137.26.1762181525198; Mon, 03 Nov 2025
 06:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102141733.160640-1-yuntao.wang@linux.dev>
In-Reply-To: <20251102141733.160640-1-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Nov 2025 15:51:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW0mLsZmJsWmQEaN=g-kRMMVHaBpRZmQW1VFRqyDvK6UQ@mail.gmail.com>
X-Gm-Features: AWmQ_blF-HrJJFZ6UawjIZOL5JF9-1QW9wszE5S3sxv-Mq_PqjGG7F9PQMoMuHo
Message-ID: <CAMuHMdW0mLsZmJsWmQEaN=g-kRMMVHaBpRZmQW1VFRqyDvK6UQ@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

Hi Yuntaoi,

On Sun, 2 Nov 2025 at 15:18, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> The len value is in bytes, while `dt_root_addr_cells + dt_root_size_cells`
> is in cells (4 bytes per cell).
>
> Comparing them directly is incorrect. Convert units before comparison.

Thanks for your patch!

> Fixes: f7e7ce93aac1 ("of: fdt: Add generic support for handling elf core headers property")

My commit consolidated existing code, so you may want to add
Fixes: e62aaeac426ab1dd ("arm64: kdump: provide /proc/vmcore file")
so code in v5.14 and older will be fixed by stable backports, too.

> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

