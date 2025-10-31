Return-Path: <linux-kernel+bounces-880301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95EC25601
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE91A68264
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0434B42D;
	Fri, 31 Oct 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SivK9mM1"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61519286A4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919105; cv=none; b=MWmK7UvX+8f9xmwpVFSSY6VCrfzFrFa/UmBHYwRDi+FsmP2VxpJLEOKcChwykcfi0hOQ8p2ZuwBqMfrK4x+1pguHOA9zNY71TZyNldhcUDsrAv6HbM6r+KobPughBk0Y/KvVOAnCmK8fwNmOVico/gMDkk99WlZATHvwhdNtnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919105; c=relaxed/simple;
	bh=jxbdgfaupleKnoKUaQ3/ywyBHovB8OcivEL0GTAj8QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV9DTkP8h/Wh7gvAd3BC7OLdVBBMybLsH9EVqygfHmZYRxwGNROZzf51bLZHEAUk/OPAy20SZ41H2RuBwF5O+wrAku27xRwYvYQUC0aeFb94e8S4c0lgR47UgXdg3KZbXuYVkCsl/nddjbh+kjgaJnR7RTxwJLn2Q21P1lWDPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SivK9mM1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eba124d189so24267341cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761919102; x=1762523902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4S0mka8jGiqhtu5Z/8KUXJ1hNRdqooEO/ICp8xqPw1s=;
        b=SivK9mM1FM9aNj+j1zkz+BM1pi1rpZkSdkhIUdr67YJ2Ozdnr+O3y0hpFrRrRHcbLe
         Ma0Fdd+gg5q9eltKVFatQlAywtABlQ41n1S65E2v9D9XCs/X2bHcLTxL8TMOoVJMcb1t
         XJzy6I469rm8tw8e1PtMiJ1o8C6KNn4CLd+WYrRu8Vvz0Vk0fHGF9FW3wereh2PibfdI
         mzzgqE6OU1Tg7jXc93L8cZ4plRP/f0TTU81rNo8by7pdjLjwk5BRh3PcDgCZCpPZ58jS
         u0WAieaGjjMNsnKuLBEPdR16YnXwtrrHaPMEuuVVkJ0S9WLBkwk6BZPKgSVlWZxDupSW
         kYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919102; x=1762523902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S0mka8jGiqhtu5Z/8KUXJ1hNRdqooEO/ICp8xqPw1s=;
        b=hO+hi+dl05ogbHNtDBb0YkkO+V2z8RdaYvNtbmEKZc1HVu/buotg4oog0hP4+vOBJe
         EjL7E6Ufl9ESO74qlqx8L/Yk2tzmQ4fqGNbPYL+5TFUgPxvVM+2RTbT6/bN2038MaMe8
         lhbtJRmTcbkT46dTD30X6G9ZMH3eStyT3Xr1lboI8smgJacgjsHqUaF/4jotpOV8Qm5s
         FaFXoTrTMG6wuKm8sxDhh/U25M01xv4o6c/3FXDayz8yLPl9vQUUi2e7VwX0X9cvsHEd
         GMn1IAxUcqBe/BqoRQwAye5rV6iUzna+1QguE72LvX1uTUftQZzv0A7PESoVY/DRSoj+
         bSog==
X-Forwarded-Encrypted: i=1; AJvYcCWD0hwAuYeagdBLGfkL+goFcO5yXSlFkCUwPjOwIqP1h7ORjVFT6y8/gjk1HZ0ITeLlxH67pXdu10j335g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXY4sJYS8qadUZD0/WWCgAPF+BQKxU/+qoCN99cYI8D1WGwLD
	AWTtDFx2vUKM1SOfQLBtrAbmOOjLVOoy9XZwg4jJK1g82laGib1hd2ia4bXxkHVBjHU=
X-Gm-Gg: ASbGncsruZAEMy4v6D2xIjDOcjCgh/2HeeFf5D8RWtB7MSZuUj2tZb+dvXM8gY+M0jT
	U4FjDyuRJhI+wrGus0mYIQQDs6qIjGG6oCs6LN8t9qfKLU28qPWHEkI6Gqizqb0lCmzwcUFyyQK
	DBgpaATYeXc6/V4gRBaCzQKmg37mDBGnPfZ5axz+Cf7UE0OiZMcOnqwnhV4C12qBRff6R8WKDTW
	Mw5GOS4+UgDU++68RBnR9G8Jf26gNe9KO4ESC+2eUse2qJmt+DnsBWQsZ67btV43J3mEi+BIJhC
	5QbklrbsKrtvr2uugVEGtBBJ8wYS7tqROCd+OA+YlraM7A7eewqB23ilfYg/DfJEtes/wwINJhb
	w7/kp58CmZzZ2gQ4Jwf+U1Je9vsfc/DxY1yJK7F6mu3y4ViR280kGT2FVAz2E3sWhmwSdvfO/wG
	y3QAMJno2U4mWGcJEv2CjIU4vFXCw/OIQu+cdJOEccckQVdIKK/+cDW+DsOYgc1MqJxdGZHA==
X-Google-Smtp-Source: AGHT+IFUTwsA2dbbxdluP2M6MQtg1EQ3qn+mIRsc6BUtZCrQZJJLWzhdFTNRyqmV7Af8J/4OoxxHWg==
X-Received: by 2002:a05:622a:1985:b0:4e8:a3ed:4c50 with SMTP id d75a77b69052e-4ed30dd6d5bmr40807401cf.24.1761919102031;
        Fri, 31 Oct 2025 06:58:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880362d7baasm11755356d6.33.2025.10.31.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:58:21 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:58:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: declare VMA flags by bit
Message-ID: <aQTAejgLn8_Er8RF@gourry-fedora-PF4VCD3F>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>

On Wed, Oct 29, 2025 at 05:49:35PM +0000, Lorenzo Stoakes wrote:
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index db16ed91c269..c113a3eb5cbd 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1182,10 +1182,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT0)]	= "",
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
> -#if VM_PKEY_BIT3
> +#if CONFIG_ARCH_PKEY_BITS > 3
>  		[ilog2(VM_PKEY_BIT3)]	= "",
>  #endif
> -#if VM_PKEY_BIT4
> +#if CONFIG_ARCH_PKEY_BITS > 4
>  		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */


I realize this causes some annoying churn, but is it possible/reasonable
to break the no-op ifdefsphagetti fixes into a separate diff?

it makes it easier to see this change:

> -# define VM_PKEY_BIT0  VM_HIGH_ARCH_0
> +#define VM_PKEY_BIT0 VMA_BIT(VMA_PKEY_BIT0_BIT)

~Gregory

