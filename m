Return-Path: <linux-kernel+bounces-837039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886FBAB246
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA0A7A1939
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B62220687;
	Tue, 30 Sep 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O75qkQ40"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F28194A44
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202308; cv=none; b=owZ5axm5dJTuqrWrtRrMnvuV4m+2fq+kmCfYJSdV0qoPCVAivH+oTA56w+zsxFl50+LPorjZnu/NbMxa3F48kM4ZeZLFOfeqYVMhrMp3medvtjVI/8DDczxsF7KhW1H4Qi9JTJuSUeWzwU4R3EKgTEDDSED/6qm8MDF5ib7YlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202308; c=relaxed/simple;
	bh=uaZ8qq9KG7UhYZxnVtn80+b0ZXQ4Rtj1Kxa7cWa5kJU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P+AZ/eNar7AV3uy91V+/Gwigi5qRMOXpaS+KQwiwXTtKVqD/oWRET4n7pCsbcuaKrp7XpZX3G2DFZmKUWqD0SbZr12Psxe311aupUDwQBoHQVHboIPv1qvp2JBgE64JD2HG3y/TRHnz/2IZnmOgpOc1k4f4gAXKszDJuZkl3h3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O75qkQ40; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603b674aso58078117b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759202306; x=1759807106; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGNLCKGJrXLWa6eAFuG7oNqbsQrVZxx3Sl0hu9yULUc=;
        b=O75qkQ40pw22uylvopJESH6JKLYiXMxdyEg8sddHMx4hHeh+0yQ2lxNQaa8JtNAVmb
         Yu5As4F9fJ16cvdexnGDB276BDXurozvuYcaj/sP+WKy5KetYQQOFY2Qz2da7Acp8vqJ
         UwryZs9l6DgFfFtzq7Lax8P31AhstIxx7W7jkv06mtXcpSf7puSaFpt5HEI6EV9GE/mg
         wbERmM2E1oDt0FyUvo8FDTGteiwQ0XsJwv0kzUcPaK4gIlXbVQ81kkcNmqp857Zkzm7y
         FOYk4TiFNMv+E5sWJrl7o2EvnVivNGjHMTW6+dlrhooY4uyVbI9UbqSvBsaEkhBhFW+W
         mYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202306; x=1759807106;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGNLCKGJrXLWa6eAFuG7oNqbsQrVZxx3Sl0hu9yULUc=;
        b=nq99LhbdXXs/JFliZx4lWyJCeS/EQEfB88MIpWYgEZD6tg33bE0fgsGmVIiHNWiULA
         r46KwZB+iWzUCo0sTbmoCQNjogzx8TNqKdhmOTuQ9l9wXB11LopP5JiJ+LQF5+T0lrM6
         HIRNi1xvnzmPxwggkB/BztcH78JV9K3ND5gRXApVr0PLrBMMUqYSCD6x4DcNguiYbi0r
         u1E6btaFkRAAc4ic5ylDBtX0XD8h3avZ0B8asADEv9SvAFAD5YsNQrz0Yi8XqSLYNiN9
         LT6vycvj0Qv1oxG1Lfpv08ucqGu1uBIYvcmwqHizwXOe4WH87q3VMIUe/4do1kVHEKqA
         JkAw==
X-Forwarded-Encrypted: i=1; AJvYcCU+GNSIcbwKXNbw4tIBdMkPvJUaPJfGcMh7OfRmjkqlObHYFscJEHYKYmi9yJy8aZPpm8y73i0ZGciPvpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiyJMkRXg4DUIaZMMUx1c/cZfh7F45xiUY2NE8IfOrgd8wcSzY
	ImPrElyyVmEAW+FjVESesnMKAuWhg/WfHK2YvCVTf39qFCKEDxU14GcKgIdL8utR8P0RZ55tkW3
	JaMYGKA==
X-Gm-Gg: ASbGncs+aLQc8dekgUTUtMo7Q450hA2psLyGL49efUyYdwe6IvFxmD/ohLmNu3tpNYh
	KCP/LV2gSz7sAKwTPg5D0tKiVQnlqhLravjmoPs1Pk0xMkSUlzgCToZpquFGwFvpSVSetSlSWn9
	DKRx5xsneGChkqODxnWtJ1LfAsN24RImMMdwB23+Vi9JW6FZi4ITdeY8zcpStUWACQOI2l2gZgB
	LlkNOtx7g/Y8VAhns89Xql/0s+lRTZMvTorcaF//SpLJd8NDUGKHkDPVI9PvqysRrPaRuk6dXHX
	oDqeJo3eJR134nZcSHop6u4Tp7QhLhpA+ZM6/kfbFb5Lmg/f4DKP0d/+p/x/v21jiYIW7GRDI0H
	i8oOHFihfdUF8RWf0UbID5pbMDj9pzs/fSOKcgFxCn5sfx8Zsc0B0lDqW21bKdhcx/5l9HU/g4I
	1v8dBwQnkKTpwp/pZVn/YE1JnR1f+T3MiYpf5g
X-Google-Smtp-Source: AGHT+IFcZqYas2wBQmI9BbRmqml9F+2QA9spZ9yKoBd8FyOombPucba4gtkHHMksFeRZI+3E7DFoZg==
X-Received: by 2002:a05:690c:7302:b0:734:ee:200b with SMTP id 00721157ae682-764052014damr237888467b3.51.1759202305941;
        Mon, 29 Sep 2025 20:18:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c77e72d0sm34142987b3.49.2025.09.29.20.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 20:18:24 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:18:13 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: SeongJae Park <sj@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
    damon@lists.linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Xinyu Zheng <zhengxinyu6@huawei.com>
Subject: Re: [PATCH] mm/damon/vaddr: do not repeat pte_offset_map_lock()
 until success
In-Reply-To: <20250930004410.55228-1-sj@kernel.org>
Message-ID: <07267988-1736-1372-8994-76892c5cc804@google.com>
References: <20250930004410.55228-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Sep 2025, SeongJae Park wrote:

> DAMON's virtual address space operation set implementation (vaddr) calls
> pte_offset_map_lock() inside the page table walk callback function.
> This is for reading and writing page table accessed bits.  If
> pte_offset_map_lock() fails, it retries by returning the page table walk
> callback function with ACTION_AGAIN.
> 
> pte_offset_map_lock() can continuously fail if the target is a pmd
> migration entry, though.  Hence it could cause an infinite page table
> walk if the migration cannot be done until the page table walk is
> finished.  This indeed caused a soft lockup when CPU hotplugging and
> DAMON were running in parallel.
> 
> Avoid the infinite loop by simply not retrying the page table walk.
> DAMON is promising only a best-effort accuracy, so missing access to
> such pages is no problem.
> 
> Reported-by: Xinyu Zheng <zhengxinyu6@huawei.com>
> Closes: https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com
> Fixes: 7780d04046a2 ("mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails")
> Cc: <stable@vger.kernel.org> # 6.5.x
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Thanks,
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/damon/vaddr.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 8c048f9b129e..7e834467b2d8 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -328,10 +328,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	}
>  
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte) {
> -		walk->action = ACTION_AGAIN;
> +	if (!pte)
>  		return 0;
> -	}
>  	if (!pte_present(ptep_get(pte)))
>  		goto out;
>  	damon_ptep_mkold(pte, walk->vma, addr);
> @@ -481,10 +479,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte) {
> -		walk->action = ACTION_AGAIN;
> +	if (!pte)
>  		return 0;
> -	}
>  	ptent = ptep_get(pte);
>  	if (!pte_present(ptent))
>  		goto out;
> 
> base-commit: 3169a901e935bc1f2d2eec0171abcf524b7747e4
> -- 
> 2.39.5

