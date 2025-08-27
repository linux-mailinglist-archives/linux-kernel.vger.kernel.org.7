Return-Path: <linux-kernel+bounces-788802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF5B38A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B654189B55A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C02ECEAB;
	Wed, 27 Aug 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNxJCjqc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35212641E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324283; cv=none; b=pr1p1ag0wYq1MG/vr6z5PCrQ9eDztyZ9u4RNbEfJb/EQp164oI35dRUj8WjdnRUAO4LI4rYvxt4qpCNWbr+o8UN/C25mCfs75PdOqOHJUGOo6dDw1A4Qz5lFkpIYTIy3AfZQCE5IaQ7VQJR8Ma4kBtLDuE+4i6Du2KRCBSHRgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324283; c=relaxed/simple;
	bh=MmmBKKAX709bgOzm1/92OS28LpuQKUnx6GINZknq74U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz2Emy2BO5T02dBMLBFlp7UxwKzXTbBV10fW1HNuuA3EHtBXl8zffIO7ecA3YiWONgYM2amE8jvxRTpwATfR1kofWLIPWn02IeLq/Y8OPLzt+w0L38DOmKvB97ldmnCRKBMOuvMc8FCBYwXXwPxBeOIH3e8sQCmkL35FHhMGy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNxJCjqc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771fa65b0e1so155846b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756324281; x=1756929081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VG7+A/Oo1bd3pV8ZAkMIxPp9o09kNI7G+rW6VPIkmEo=;
        b=JNxJCjqciXxguWuuzyRkWGLUJ9EdqdpdWtWvLQPQUVVoa1fFs/qLymJU6wXStapDcY
         d9w0WE+N3oNieXU1UznB2CuYo63MQKOCVxz0mOabHfz9SXHUUptDSqFhzu0acNmYzPhE
         uhWZjQkb6CWIWGyV3lncmCAMF7EQNC4T1EZB2qGxWn7wx1McsrIXvf5VuOMII542MYzo
         YzirzTr5vZg72vtNsWy12ToqbhQsor2a2tqJDPJRqEPE1yNvVDdCjpZh5/Brj77M8hxO
         bHnbY58dE4DjsnICGLvFtoVXVl38Qk6Iy8vQ07VFeujzoDRFYk091YHbtYrpzSLuNTcb
         0y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324281; x=1756929081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG7+A/Oo1bd3pV8ZAkMIxPp9o09kNI7G+rW6VPIkmEo=;
        b=j7CJXNYv0tOR/Efred/6kMHq+uB/q3uz0vHYtyF6CleIXip28pLumkrhPX9v7hn+qj
         gJpUGfJzppA+KXaH0/KAvqyXkYt22SFYQmQlauu/Erya5RA4JTI+ctr/TU6zShip1vX0
         bgBynMocRUHQa/O5HD9t1RkJHJKPmi5re+F+IEqtXaeJgrjadclJc5h5QpajdYmbZYM1
         ZPg+byZIc5DAOiThkQQGJGQP4Y2gOFF8RemV9xDqWFZQCck40HfmuVoWY23qy+KPyCIs
         xU2SGJl0NoRX1dtqabUffsY2BfqNa853nl5ufT7qjAhvpYme+elXzaxHC87L169Imj1W
         nqGA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/KdBLnN32WaqVt07FgMyNve3I2l8ZusCgmRNoR77n9PDtCfo7HHsYCHGcMEhk5bTlnxzfuzA/xOloMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeQj8ul2y4Mj9XaTl86nDjaMbBFzdinODOSoHkjVj62dnbguK
	9Dhq8zxGYtyYwWjXhCznlR8Z025tDD/6nIvDO6hCv5lHNxU2LcQpnxvA
X-Gm-Gg: ASbGncuFeFblL8uYlCQNmjbNqakm1ZNvqwWQry5ZYjBRHlA9zyxDg0HW0sZUVLB4SH1
	7qlH2YKzOj+mcTmZKog3TvMiT2V6UmR0nPGtXNTqyTwmX0U6rNScJ1Qmaoj7aLXkqhqeo0amyH0
	Cj675yfwukSonn8FPsBMZPoKr6BPnNhZY5hhHxHeHHtuRT3+zc+lqT4MWtMcuRqAkQ1aWI2bDaU
	03pgDOO1RKX/FIByy6TyXMEoVyWHSWO0cSKRStu6wB2CIG1dU1sxr2NudNGup9BmyJvTT+ZLZ3Q
	fFCX918Tz+DuAIl3il32QkO0gC6gN91WYJ0vBbKcBwyN9t9Rafqlwitdb0Np9iuC6tHcbViUoQs
	KeWTVDboLl4I3eyVsi2MQ2K97rUpigsz/ihZcxOwlTl/k71dIRaZnzA==
X-Google-Smtp-Source: AGHT+IHTTKWM8hzK/JmcECalaHK1fC1BJBj3FvHBboVAHWIiFpuxF2r5PhP3FhfJfd5S2iVPhh7lXg==
X-Received: by 2002:a05:6a20:a121:b0:235:4a12:6adb with SMTP id adf61e73a8af0-24340d11da9mr31837355637.33.1756324281068;
        Wed, 27 Aug 2025 12:51:21 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7bf2dsm12224892a12.31.2025.08.27.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:51:20 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:51:17 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mm/show_mem: Bug fix for print mem alloc info
Message-ID: <aK9htWRehfJDLFJD@fedora>
References: <cover.1756318426.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756318426.git.pyyjason@gmail.com>

On Wed, Aug 27, 2025 at 11:34:21AM -0700, Yueyang Pan wrote:
> This patch set fixes two issues we saw in production rollout. 
> 
> The first issue is that we saw all zero output of memory allocation 
> profiling information from show_mem() if CONFIG_MEM_ALLOC_PROFILING 
> is set and sysctl.vm.mem_profiling=0. In this case, the behaviour 
> should be the same as when CONFIG_MEM_ALLOC_PROFILING is unset, 

Did you mean to say when sysctl.vm.mem_profiling=never?

My understanding is that setting the sysctl=0 Pauses memory allocation
profiling, while 1 Resumes it. When the sysctl=never should be the same
as when the config is unset, but I suspect we might still want the info
when set to 0.

> where show_mem prints nothing about the information. This will make 
> further parse easier as we don't have to differentiate what a all 
> zero line actually means (Does it mean  0 bytes are allocated 
> or simply memory allocation profiling is disabled).
> 
> The second issue is that multiple entities can call show_mem() 
> which messed up the allocation info in dmesg. We saw outputs like this:  
> ```
>     327 MiB    83635 mm/compaction.c:1880 func:compaction_alloc
>    48.4 GiB 12684937 mm/memory.c:1061 func:folio_prealloc
>    7.48 GiB    10899 mm/huge_memory.c:1159 func:vma_alloc_anon_folio_pmd
>     298 MiB    95216 kernel/fork.c:318 func:alloc_thread_stack_node
>     250 MiB    63901 mm/zsmalloc.c:987 func:alloc_zspage
>     1.42 GiB   372527 mm/memory.c:1063 func:folio_prealloc
>     1.17 GiB    95693 mm/slub.c:2424 func:alloc_slab_page
>      651 MiB   166732 mm/readahead.c:270 func:page_cache_ra_unbounded
>      419 MiB   107261 net/core/page_pool.c:572 func:__page_pool_alloc_pages_slow
>      404 MiB   103425 arch/x86/mm/pgtable.c:25 func:pte_alloc_one
> ```
> The above example is because one kthread invokes show_mem() 
> from __alloc_pages_slowpath while kernel itself calls 
> oom_kill_process()

I'm not familiar with show_mem(). Could you spell out what's wrong with
the output above?

> Yueyang Pan (2):
>   mm/show_mem: No print when not mem_alloc_profiling_enabled()
>   mm/show_mem: Add trylock while printing alloc info
> 
>  mm/show_mem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> -- 
> 2.47.3
> 

