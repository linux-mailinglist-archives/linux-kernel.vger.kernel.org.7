Return-Path: <linux-kernel+bounces-893671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD4C48079
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FAD1883496
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697E31961B;
	Mon, 10 Nov 2025 16:37:38 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CC31690D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792658; cv=none; b=YKTcx4oDI4s9BcmaNN+kpRG6guXe+SzB9LN3EmUNRCj39yspJnhE9MysjEgHPorSSMXdY0oQUNYhVLU3g23Lx+JYxATOI41F3r2i7zXO+VNxZupB9iXWjNv6iUMIKNFqJ9aAiRcebxwl3eEGHH6i6v7LCsCXQgx3Bar5/wnGPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792658; c=relaxed/simple;
	bh=ytHIDgU/qJ2cOfjrTacAh9vt9YGb5WOKdUkBnY4rcBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcKJtyzWOevZay4y0/BtrfmVf37QKbWnv148aAc+QVmP4csbN3LW5K/rdNe+Vc42ixrhTsrSwlzLqQxhYrW86mzsxsULLWgyHDNJHjiZknSeKyx3p2ShS+M9eosvj53gSX5eJYwVuf9gyn8HdoqppXP2rHvstwnOiky/CVhJ2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-559876b6514so673373e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792655; x=1763397455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNNWB8RzQw4ag+R4GGbGdNDxdfn6zllvkiSdySRdu9E=;
        b=mU5t/rEy8AVZM3jV3x/4Xxih9ljrxLPx+stj+PEHbH7Zf456/j0w2n7PsZp0pdyetE
         FCgNXYYgqby19u1ZYTyU/Wv/60cL7DfwNKJtDtCvPyNHKA/AEV+j7TBmaXn5rbejH8xd
         do2aVfY+Kemx1AAo44dcgk3PkXnovjMn+qgARkfgeKKLKQVpz47PBplb2yZm+Rd1hdMY
         X6msniFHt80ibDNcFm1zB1Gf39oR/2c/wuCrZs8TsL/d6a+xQGQk61PponIHclrPy4Mr
         id3mVFzDHdi37w7m26pZOoTRo8KJ5XqCZdK7K9SUzsQxU7cX0M6cU1/eaOvPUC09g9QC
         1OVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0DwXwPXi8gN9WDjfMT6BEvUv66YiAlUBGBGxKIumhE2zIA5RjS8i0xRuHi0uPCJHzgwBAd+beD+zdOxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqqZHeT7KWiRsPI6znvHwW28fWyrdreEGPh97p6utHJsqkQi1
	e3lx3I5wSMkoEOO5PHh0Tos3YQ0auxsbPHsHuCk3Lylv6gqWBL9dwezmhM9Ro+Bh
X-Gm-Gg: ASbGncunu2vxyfvl150LebTTuhZi+Mhxh9ukeTOdC4uM6sA3hmZqcUTc9o0k6f/CIR3
	ONOaCfSGe/IQuj3mABGSXiE5Q/iveUg5mUqv9Si6z25qKHl8HDpAMuiTvTPArCglmQDr/SrTPEt
	ajfxuBkBd4WfrSvkgxbh0T+HQyYEvXg4PFmHaMpAZEB63AW4XAC77fssZJragQ4CSi/5IvmPmAl
	PCPVPt7MJ1aHf0CTN/uiBnLPRXX+KwKPrtrXHIqCaoE+9hC2C5d3rj9+Ro5HElXos33W4zyzVMX
	4QibjaIO4F59LYAJ5oQk6JJYHUPNILm57L37NDHHoGXEZGftC3EoiOrBWxUz3ZtJ9/yx0/mt1yS
	eXQPJt2Q89rLRh2M/ncMszKroW+4e7nif0uehx/wZmAqaQh3s0xDp9x7DuGuLOQNA1CTC+H+/Ug
	tltNF0OaINyYQqe6Ml8DrGlWRf/iHxwJ8jzDZeeXRcCu6L1zoK
X-Google-Smtp-Source: AGHT+IGYjeFhUxNnt8WpH3NAQuQpqMSx+tH3WwHiPfh+H01ki7rUvPJhEr0z5/cx1ykq9BnQHWsx7w==
X-Received: by 2002:a05:6123:2c8:b0:54b:c83b:9299 with SMTP id 71dfb90a1353d-559b32c65eemr3153524e0c.10.1762792654769;
        Mon, 10 Nov 2025 08:37:34 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm7780334e0c.16.2025.11.10.08.37.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:37:34 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9371f7571cfso773770241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0dQh9xTccDS9cn2pbvZUrRsVCYUm6EFRorqnQ6hPB4Va+fQp1E4VCd5frGU52OEZXke5WkYynp0hq4Vw=@vger.kernel.org
X-Received: by 2002:a05:6102:3753:b0:5dd:89af:459b with SMTP id
 ada2fe7eead31-5ddc467f048mr2635129137.7.1762792654419; Mon, 10 Nov 2025
 08:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030061603.1954-1-vulab@iscas.ac.cn>
In-Reply-To: <20251030061603.1954-1-vulab@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 17:37:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVrngq2P+uPq79Rgi=Ba8hYBftG8ztSGXxyTvppqwYc1Q@mail.gmail.com>
X-Gm-Features: AWmQ_bn0aO0m42o8pyfa9vnXYaa3ntXxxVMU8sBWoUFD7yP4GCSqBzv-mQ8MKV0
Message-ID: <CAMuHMdVrngq2P+uPq79Rgi=Ba8hYBftG8ztSGXxyTvppqwYc1Q@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a06g032: Fix memory leak in error path
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 07:16, Haotian Zhang <vulab@iscas.ac.cn> wrote:
> The current code uses of_iomap() to map registers but never calls
> iounmap() on any error path after the mapping. This causes a memory
> leak when probe fails after successful ioremap, for example when
> of_clk_add_provider() or r9a06g032_add_clk_domain() fails.
>
> Replace of_iomap() with devm_of_iomap() to automatically unmap the
> region on probe failure. Update the error check accordingly to use
> IS_ERR() and PTR_ERR() since devm_of_iomap() returns ERR_PTR on error.
>
> Fixes: 4c3d88526eba ("clk: renesas: Renesas R9A06G032 clock driver")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

