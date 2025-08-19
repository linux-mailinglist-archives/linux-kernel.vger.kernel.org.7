Return-Path: <linux-kernel+bounces-776320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C71B2CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B57C175EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B730F53E;
	Tue, 19 Aug 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="drn6Gs5e"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCF30F544
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627815; cv=none; b=qu6QNXTrx1MV5Jad6k4QWhQaAvt89EhH/abM3kc71IcRO3OlE/CcxRoIJm9sn4HLa5Q6DmZCaBwfrtKEg7IFt+LbPsFSbyFjoORkBwHRcSr/iyZenTGmdZu7mKzVUK/mlrDbYq0CGc4j0qaKN4B82wyc23T0SGxNpZhH5Jd896o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627815; c=relaxed/simple;
	bh=MRxNBxm4n9KrOVBqwu/HszGJ6wQy43zedOEPgzdI0CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrPQDBYNN7vH/eQTNA59HzgjpMUgah+L6SsH0xzEi3gjxZfdxwxHRzw5oyo5aMn1UeI8Jw8TZla6RDvfQZY5cjE/8TFFOwXVC36OweNjSUnv56FON/Om9Z1W5+ugO71h5QOcDsP3y+i1kncJHua0Qfvi+MZQOM5RfWm4nZpz7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=drn6Gs5e; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88432ccd787so346886539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755627813; x=1756232613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMib1RNsLOZzveOKUcNUc71UDB3u2hrf5eBAgYUIDP8=;
        b=drn6Gs5eIC6waIXOjfVBBuy0ZqX8Ofy4Bx+oF6jxm3nvxh061YwJhfcsP2iW5BChyk
         Gieywy5Dbx0F5MllY4Cjcj1rLcOXogpPc4bdKxCWmQOCLMzSabtNf9D1axwXbznou88A
         Zs/lKHlY8WA2pegsBlg4hBpNHkZxYVLlP8a979tWzFTahzP+W9/rlM+3YUBI5pTsat+/
         PJiYXsWW/xKEu5V0y21OvMml7V40jI+Vog4Km41UuL0faBu/ioYIgxe5LYX7kUQkryJs
         j+VI+GGmqGFHbsXulRE6f6mCaKfI4/wPZpETmKtHP75PaBR3IVIMf6/kTU2gJCod+qul
         smHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627813; x=1756232613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMib1RNsLOZzveOKUcNUc71UDB3u2hrf5eBAgYUIDP8=;
        b=lojThpb/23HJENbBIKTgeWOQmEDhJhwR5q47tAlS2Z55XQ06ptpyIIFftNC08a2z66
         q9a4JaRNutjQBUqXtRNDkYnxXQtErE4ykEs1tF3dGeGlUCzr31D7ahNa3jWpgvhQ/VU9
         3km7jucG3ZddoqjxsaQBV/t+z5m1W5x0QrIab/Y3QjHBG7zzl70sAAqh0C6rUXbpT4nt
         p7JT6psO3eXuHBpTw/St/iyVVGQkJIhTYQNE3IaxiYqeDNPoLXct8U16mYtOsGHEDedv
         yr2ZAu2lCXOIfP+TCRWWw9ErsmKrgwuHbNGAe+EzOMqJKefxYjm60rhz2ozrjrcAxXt/
         mM7A==
X-Forwarded-Encrypted: i=1; AJvYcCXRkHcpjwam5G4JPk0LlS+y56XIMOzAiQ9brC2DZI5pvID/AQdez82kv+lz1tkxLPN3f9pAT1CjI9+hi3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ur8VBuDJ6e0eOMmq70D0T+7AP7O9A5bEcwZGqQbfdtRDcZP5
	TWG/jJ8RG+ZOZNT5sWct2e6TJZ1Tbck8SOrRaamkRydNwJzHI4jKukeVPEvWTvoC4iU=
X-Gm-Gg: ASbGnct4O9MH7ZonuPLS+Z7+0s+KjKpDZFn6+lGIZ6B7uzD1zi07K3d5lzR2hkl91nF
	PsYIRnmUrZ8Glv6bxRQL0Yt42IerCt1INqUPm+VoOXLQxCsg71qNqfh59zgfZRsP8ghNDDUx101
	GUmeNR1z71ca8ypxCBnQf9rzmtHL14FZDqJzE7AjM5OLb/WObt68YC5GyvrcBfqjNHSg+eP/DSf
	d5DmvpxVpdusIA1o+LuCCZT/pvud8BGPvdo1KfgROMo3pYb8GOSYfypNoLblw/YkdSA7v7Z3RfX
	7kFWDPtzb9t49cKlL9C2l8Tangea7rqs4p9dx7U4taS5bWkxnmTYH8DfrkK9tHApaeEcFBwrmSK
	yxvF8+Mb0q8xqROduExaK4/8C
X-Google-Smtp-Source: AGHT+IGezg0FiA6Wv0CaeekJKLOj10bdJNcyHpwqlIH+/ZsWLwUEs9/JQbQ8Pzd+oEx+vnLPaxgYtw==
X-Received: by 2002:a05:6602:15ca:b0:873:47c7:6ff3 with SMTP id ca18e2360f4ac-884718e300bmr58966739f.7.1755627813157;
        Tue, 19 Aug 2025 11:23:33 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f7f9854sm411794739f.7.2025.08.19.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:23:32 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:23:32 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jimmy Ho <jimmy.ho@sifive.com>
Cc: linux-riscv@lists.infradead.org, troy.mitchell@linux.spacemit.com, 
	ziyao@disroot.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, cyrilbur@tenstorrent.com, cleger@rivosinc.com, 
	charlie@rivosinc.com, kees@kernel.org, ben.dooks@codethink.co.uk, jszhang@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: fix using wrong load type
Message-ID: <20250819-cf406b3d02087824245b5576@orel>
References: <20250819071318.21103-1-jimmy.ho@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819071318.21103-1-jimmy.ho@sifive.com>

On Tue, Aug 19, 2025 at 03:13:18PM +0800, Jimmy Ho wrote:
> thread_info.cpu field is 32 bits wide,
> but is accessed using an XLEN-bit load, which might be 64bit load, fix it
> 
> Changes in v3:
> - replace space with tab to keep it aligned with code block
> - Add "Fixes" tag
> 
> Changes in v2:
> - add a comment to explain why use lw instead of REG_L.
> - correct commit message

The changelog belongs below the --- in the patch.

> 
> Fixes: 503638e0babf3 ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
> Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> ---
>  arch/riscv/kernel/entry.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 3a0ec6fd5956..492ae936dccd 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -45,8 +45,10 @@
>  	 * Computes:
>  	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
>  	 * a1 = BIT_MASK(cpu)
> +	 * 
> +	 * using lw instead of REG_L is because the thread_info.cpu field is 32 bits wide
>  	 */
> -	REG_L 	a2, TASK_TI_CPU(tp)
> +	lw	a2, TASK_TI_CPU(tp)
>  	/*
>  	 * Compute the new_vmalloc element position:
>  	 * (cpu / 64) * 8 = (cpu >> 6) << 3
> -- 
> 2.39.3

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

