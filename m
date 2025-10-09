Return-Path: <linux-kernel+bounces-847279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE4BCA6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4324B4E7CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7811E2614;
	Thu,  9 Oct 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="SvPir9XI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18B223DD4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032228; cv=none; b=pD07aq1v5N2MCR30xEo7xarVcqK1ORXsA/xIhw1SXwBQyLQGTafjvIa7jSgtBZBxa1xrbF0UARDOz2lSQ8fhq0XwvHpuf7w45vb86MdZKOMkhP0+iN0aJkYs7x5xP7BlRAlyK0z3Kss0eHPIKTBRcF0XH/kzTEsL8VZAXZlUj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032228; c=relaxed/simple;
	bh=81OCvozsxVuLtWUQCNblLzzY2eOGkAvorDqJmgZ1C8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHZ29RDw4aGwdroMMi+LLS1/hpsWvDVSolbBeRteH2acM4BXzntRUJ3ywJHYkvpCXx9K5gZRvvIYCq8YTRxE3AECYklmJPoOz/rLie80KAViMwVRlE07YFK2IqA4p6a+Hk7Man7QrwbnJrnAMyCYuBrpR9mRfq0FrjynKKpYGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=SvPir9XI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so15181775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760032225; x=1760637025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ks/MTKg0YoCjDlnUh+3C5Magvqx36EuPX64Sc6wPGg=;
        b=SvPir9XI+1PqBLao4m+AHEUCbOksJnQSgh6Z5vtv2sZ335k+Gb8LFpoGZ+4ZA2XsNr
         ebvR9GKed0htrNr++5gOEixkod2KjEzPSZnOd2Ci20vKQUVA4Gw9uY7Uom5c8kGyStlE
         olsbsYICTWXk8pPI0S8WkNmPuk4xWVJsBaTzyV5EGHUjAignbgnhy/0s0C0dw/5ZOqut
         ypvrWlERUDLmG7YN6O40iliD3UtS9a455qCLE0Fbus2Ano80Mxkw0tb4pqh23QJDDP3i
         4oEoyOIOjQU/ra5WyMwd5hK+sSKywLsyBQHUKkjYSpKOITV9ggs+8ILRKxm/wuJegenV
         cmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032225; x=1760637025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ks/MTKg0YoCjDlnUh+3C5Magvqx36EuPX64Sc6wPGg=;
        b=C2npP4s9kpS6ts3Ms394zp7MrstfrigdKa7H2nur17gBHS0Y6h5S866sChqV8UA44X
         s59xUSCcOsz7FIjpNLgq5hvDQEsdyxhKcMC+mdfXSZz6jsYLW6a0qOVP+qLOhZXC9wui
         3Xe6MLga82EeTUghub6zWCrw1qjqsoUOOpiiybZS3UUcZOH0x48Aoq8kdR8WM29WIgcM
         9hE37vC29KAMN0C4e9STbQGPrGiiQysX/z1NJTHcbvvW9t5ATRZ2Jr9BAClMWyojZq8Y
         3PkpTbLNfUk7a+lzwD8pZfxlrf746v+CCk/XE+AX0KurPYozQfYbMt28/NadD4E49X7G
         4q9g==
X-Forwarded-Encrypted: i=1; AJvYcCVFMIhceB+m7gl06dTTA1IOuk8kasi6BCu2FL1ZEIt15VgoqlAvIZ1keP9hAxBbN7wr/0xVAZK2m+Ov8sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23WXBbX3J7gKLpj46zZNTOgugu/hrDXMZd0lLpf4vWY7cheU/
	eKMpwjzVlvzDRG6NI7ihDzdIdhnMO+6JqUhANsynthcaNNr1b4aR3lzFwIFieFL/+mw=
X-Gm-Gg: ASbGncsDh/Y4ZwLap22Mor9R/YtkucJ6DpHLpR2bDD+A3azLtJPn3KODrCHpdtWaDfE
	qzBql6ivO/FzNBx0pINXzNbBjl96akLfwRrwKK5piuOD5mebgKSQIlIOD3hr8CrheDeo8QVBwUR
	okqsGp05s3ych6jTu+JRdTjzOo0Gmrp0sZMPSQhiiMAqofqvKFlviEGcNyHpI43gbwH0NO4+z46
	fHt9wpe7TeNjpc8aggvfw+DkkHx3Ta1rvMeKMGgqINdCU9nQzxeFQ5hFAyaqT8Q2Bgxu80WClRm
	Dsg3rUXq6UzBG9kE7Puwf9UTSOghVXzSkxqcgFXYDW9g1q/XIH6WBWa3Gbwbo2OAEu2AzHYzkvz
	hVRz9UOCFoI7299qGdB9wP9QDpGNruRU=
X-Google-Smtp-Source: AGHT+IF1difQVKEJP2TbXWm1fao8I+fxiVlJ9Mz29m9hxZ4zGhUTJBidvU775n983cRscyRjCViJ8w==
X-Received: by 2002:a05:6000:604:b0:408:9c48:e26c with SMTP id ffacd0b85a97d-4266e8e0b99mr5235827f8f.62.1760032224674;
        Thu, 09 Oct 2025 10:50:24 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0efasm105756f8f.41.2025.10.09.10.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:50:24 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:50:23 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009175023.ftbnizjmabbe3x2l@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <aOesS6Feov9mrbJh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOesS6Feov9mrbJh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Oct 09, 2025 at 06:06:27PM +0530, Ojaswin Mujoo wrote:
> 
> Hi Matt,
> 
> Thanks for the details, we have had issues in past where the allocator
> gets stuck in a loop trying too hard to find blocks that are aligned to
> the stripe size [1] but this particular issue was patched in an pre 6.12
> kernel.
 
Yeah, we (Cloudflare) hit this exact issue last year.

> Coming to the above details, ext4_mb_find_good_group_avg_frag_list()
> exits early if there are no groups of the needed so if we do have many
> order 9+ allocations we shouldn't have been spending more time there.
> The issue I think are the order 9 allocations, which allocator thinks it
> can satisfy but it ends up not being able to find the space easily.
> If ext4_mb_find_group_avg_frag_list() is indeed a bottleneck, there
> are 2 places where it could be getting called from:
> 
> - ext4_mb_choose_next_group_goal_fast (criteria =
> 	EXT4_MB_CR_GOAL_LEN_FAST)
> - ext4_mb_choose_next_group_best_avail (criteria =
> 	EXT4_MB_CR_BEST_AVAIL_LEN)
> 
> Will it be possible for you to use bpf to try to figure out which one of
> the callers is actually the one bottlenecking (mihgt be tricky since
> they will mostly get inlined) and a sample of values for ac_g_ex->fe_len
> and ac_b_ex->fe_len if possible.
 
Mostly we go through ext4_mb_choose_next_group_goal_fast() but we also
go through ext4_mb_choose_next_group_best_avail().

> Also, can you share the ext4 mb stats by enabling it via:
> 
>  echo 1 > /sys/fs/ext4/vda2/mb_stats
> 
> And then once you are able to replicate it for a few mins: 
> 
>   cat /proc/fs/ext4/vda2/mb_stats
> 
> This will also give some idea on where the allocator is spending more
> time.
> 
> Also, as Ted suggested, switching stripe off might also help here.

Preliminary results look very promising with stripe disabled.

