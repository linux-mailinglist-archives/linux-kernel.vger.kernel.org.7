Return-Path: <linux-kernel+bounces-885135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311FC32161
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EADC46527C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7819333427;
	Tue,  4 Nov 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8sorH65"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92720330B03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273863; cv=none; b=UuA2b/SkZdAjizJVPF8nSqhNE2QFkpkxugSuYOW4ak+7kw5SzsiNUeHZuelHp1oKCqEpr8O4H0/x6cDrN3UHlelaJAuD7NjPnluepWjf6iJYJkXIXkHXvSCpw3TRE2cHhtj715WpE7/LoFBX9Mctl2PHK8yyAgyDI0lOsIc+TQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273863; c=relaxed/simple;
	bh=w788ObXubICtp0KbkHwSL4HxYG+QsV//b36Pt1+gFMM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFE0aKfeWnGDSuvh1bLemckiS0ODDGIsQIo8i5/XRdyjWKWyJ5a0fJ72/0eOwpi8vTXQg0gd3moXU6g5lUp5Qm/JdPpTNlI3AyUs7+4pc5ORFrBokqUdHX3PDJlaAkxMeJcvoINbJ5xWnbyALWs3gSYHHdd6ytFqeuM5QcZWwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8sorH65; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592f29e273bso4826608e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273860; x=1762878660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1K41FpSTyMhMwpjnLkzdwN+5hJNCqA+l7aOYaDJpwGQ=;
        b=d8sorH65qHadxeVQgmkWfaQORbHFDT/rVei+zpPSYoaLHNPkED26wE+QMG6q72+3kG
         gBrp9DGwxd/QkFabq2IgD0plYJXubzRhEHfI/wjWbnezQ2waNPFmQBEXSThpaswBmury
         B4E1bZMxVSZ+jwXwpX17bpcaqfD/33CbSMxCpYAtPsW7zrQ37MDod44Mj2+vgg8AzypQ
         GMPB3Z+d80t8RcXH/3do3kyJ5dFxjTk9wm4qWAGKsa/MNyK3upEyRPgRL42Ae6VUBMUZ
         FK9LavJylAUlq2x80lkqDaACZFTw47zHT6HZ6MDlPr+7mw606Hg2MwPm8aEjIUtKJGfD
         g2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273860; x=1762878660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K41FpSTyMhMwpjnLkzdwN+5hJNCqA+l7aOYaDJpwGQ=;
        b=DwaWpQGEgjdFZQRUAMeNdSI9JB50r03v5FXeRMndSl6Zp2qP6Z+jtgxg5Kg9qrz4BQ
         COsUUTUpGU0//EqnJekEiVCWZHbTw8RQNc0ktiz/taof42dy4es5vtGlzea91ckUx2oZ
         6SNnwhExgo8dfCVvpRgKDVCr/724MYnTg66UR8sKTSUQtcqr0K6dwk+WztL9df8yCbvt
         ihq5fkGcnQKFOJ8OAkTD9uGCKczKc5/UFJU7wlmw6/xIDv+Po8hbf/rGLC8rzk5uc4+t
         deZ2vAaZNXxUGO2fGbXmIySIWsref0Ph3PDzPCgSKWaxK3UJCRMsqv8xVjjXF97V58Iv
         i84A==
X-Gm-Message-State: AOJu0YwsHN0IW7G9IDOoZS1XSbifd/eO9wbJLH/YXRRN579wNBCETCr9
	HXONgrRJMyy49uyjSCpcqqGrchnW0yzU9SXqZGtvMICq7ZYXMhfSvwUV
X-Gm-Gg: ASbGnctekkHkT+r62riOZcISJCNdF51u2dcnVzIfQJM3LcR8Sn3UqTcKjV3F3DGa5vj
	P3pI4dkvbbVE96LbAMl0LAFnvu3YoafIfG0DlYyUlwBfHAQ/8ILDVdP/mFySAwXaI5ZP2/J8rFE
	dxFwcJaUUhQMz5knb++zXDOtGtCNC/Fz+eqgAkVPB6k7eakdSMLmKcYDKqYxjREiiRxi/7OY9rH
	vOvXUUv686f4nD6vlHFWBray4f2+UEArx2MS4YLDoDBi3uZ1hntKobxS1Pi8NZDF2KOOsRM03E7
	vTOpH6TIZp8/dRT4Hw3s7HHYjNUQ0VIeyFW7hMglGZHMidSznpxcd+81z8kJn9obIVpdkTq16uS
	9ozvp6uoPtapGynb1kkkrL7fI88wlHdSzvmycKQJXTnnFgzClOM521zQbxYMI0Tj6kyDmGaob5A
	flKV/XbEwpZN234zYiR+vcpOd0nGw14A==
X-Google-Smtp-Source: AGHT+IFmbm2Fq3kzbdScH8XjwPnhJY3J4MjrwW1Qn2hrU2H4RmtJEUs+hgkoN/wai1HlbLQs7HFPBA==
X-Received: by 2002:a05:6512:ea2:b0:560:932a:c3c7 with SMTP id 2adb3069b0e04-5941d51cf58mr4683850e87.13.1762273859298;
        Tue, 04 Nov 2025 08:30:59 -0800 (PST)
Received: from pc636 (host-90-233-197-228.mobileonline.telia.com. [90.233.197.228])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59434390fd4sm839403e87.31.2025.11.04.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:30:58 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 4 Nov 2025 17:30:56 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in
 new_vmap_block()
Message-ID: <aQoqQA8jGygmOCpD@pc636>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-5-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103190429.104747-5-vishal.moola@gmail.com>

On Mon, Nov 03, 2025 at 11:04:29AM -0800, Vishal Moola (Oracle) wrote:
> The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
> which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
> this mask here, remove it.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/vmalloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ced77fc65ce3..e6cca6219e48 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  
>  	node = numa_node_id();
>  
> -	vb = kmalloc_node(sizeof(struct vmap_block),
> -			gfp_mask & GFP_RECLAIM_MASK, node);
> +	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
>  	if (unlikely(!vb))
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.51.1
> 
LGTM:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

