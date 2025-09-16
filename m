Return-Path: <linux-kernel+bounces-819146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4EB59C15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743B11C0233C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09280343D74;
	Tue, 16 Sep 2025 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxLoaYJb"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21133A02D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036522; cv=none; b=pQHDgupdr/0/jE7LLfrsGQ9rEB5r7wNNORp+YdObidLmmzoXYlW5paXcIV3hshyfsQ9Q1UukwIcKbWXYQbJ+0OQy1OEmdM73hmKXJCfXor3dzSkiBn0IOdv5z5qduyUj/ZFJlHhV+MYB/ZxvrbAvAkqNMEutJ+IBvtpSyjqICEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036522; c=relaxed/simple;
	bh=HMi70pxt5pqIOM/hUs/7FdIflZt8ftpTb7wcBBC3AG8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL4rhOWocK+2a4Va2ulgQtrtGs6R9dd8Mj5sBLZvB0ew7IZCcEfI7r6HV2PPqYFPuAgMGRrqKu67tAV+yHSN2hnk1nzFyd8FjjzsYMx74pj23m/sjREmN50CZwTdPmnmn3+XMsWY8eaKRVXnJ7pLxn/h6kfSwX+x4419v6Dztvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxLoaYJb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so5061104e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036519; x=1758641319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lkVUCKscU4LdhT7ZZeIBczUpJ7bTCoNz2jaUueMz7Y=;
        b=NxLoaYJbgGwhlYoJB98eWAut3rI3+b2BdSgvY2l+iTC9bu6bzJtEgoJq7IsN5WB/hA
         ZAapIpIYKcBhyEmsDwhBmUjzAWWL7qNsbR8VPIfJCvjq8p9BqmeZhtpUQnii8ObLmQB0
         BNDX8xaG7zlAka9O4qNESptbuS1Y+6f3Q/AlouQBQ/xqDsTLIm+IW/E/SSN/fdZwDLV+
         x1r0MmpvtFaY8SF1YoXy1tRW7ZBtGfHYX7J41BwtTGzS/glpTno6vdlA0j4N+51FTxM7
         x7ZHwDtjrcnyFLpGGXKjw4KRTJU+wAoLge51UTqkpA/CLnWu3lHKLt0BFslxDIV07Bva
         gXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036519; x=1758641319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lkVUCKscU4LdhT7ZZeIBczUpJ7bTCoNz2jaUueMz7Y=;
        b=KRMd49EzdWxqYv3knJB8U8D2xAZjbHtjXaoNRiFBKRLAS2PhhkyTKK72RlWqERmk5N
         7P03ZBwsTPATGLaK+pfIL7WvAoA04WDnuREHXMegtzj+yK0cU93Zdn/nBKrFm/OlfWcC
         B47QLmzZdC6fCU14up4jdJRhOhId6hvmjOgoQ6g4mgsauZ7tEPgPx55T9yiCsLA4R3fw
         MOLGxtwUBJJqmT+8N/NNU00P5bW0dU2FVnBaJ1vXhyoznnJmid9jlDLbarzg3MLdI3X4
         zwIm9AbhxlTiRDqfaBnjB8f84DGpoEYnE42A14JfVaCtavDM2T1dIj68+VmDMhzXFa5a
         4Zgw==
X-Forwarded-Encrypted: i=1; AJvYcCV3dAyYCEtdkE9+ZatkLcP7mhfUlcfVhaEhF/hwsqT6KRzLmsajUCzL6Y1ApLsMMKXFsZ8GGCG12EOR5v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQ8AiS/LN6gYFuttISnlLnKJKxeVGtXo1BD68V72PFOlHcIvB
	4PaHfn58uXQcGFV9cAyJlxObNlMulqn9AjhUNofm9myZdloZ/ElI4Gqa
X-Gm-Gg: ASbGnctaXqi7je1eO8Ps4NZZt+pIN4zpcodC/v4eh4Xxo9DGDgUdEW07bWrodaKuENG
	84k79x3zudnv854NdkXy13goyyisfR8K2IO/yJlgX+4DJKMiBZ8+BhwtGN5mxvtxxLdBcfTjc+L
	cCSMNow24WvvuWZJNzJ1sWgxhxM0qxi26BjFVzUM8REJT/hGDIfqysTQCUyR22R47Ox808vI8WV
	iXiw+FsTVE9QE2FzcOHbjQHCvSqHqPFVNC80HRa/QBW/hgBkvrS2UzjRrFvr3oQhzGcRsh/jRH6
	n58HHMGGKcnDro/aiRLRuaQaY1g8Z/72uU4csyj8HoAS8DkGt98JBXHZUapYX/7YxQ==
X-Google-Smtp-Source: AGHT+IGt7r2a+wXhhK7ipCX/Lf94HHFiWDEXgmqdygMMJMgy5MAxoYQRX0uAJHvkbWQZEpkCgmb1uA==
X-Received: by 2002:a05:6512:24cc:10b0:55f:701f:92f with SMTP id 2adb3069b0e04-5704a106293mr4503294e87.19.1758036518466;
        Tue, 16 Sep 2025 08:28:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c692daesm4540326e87.26.2025.09.16.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:28:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 16 Sep 2025 17:28:36 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] mm/vmalloc: Avoid cond_resched() when blocking
 is not permitted
Message-ID: <aMmCJOJFMTuCXH3m@milan>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-5-urezki@gmail.com>
 <aMhIv3HfRMyjlSec@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMhIv3HfRMyjlSec@tiehlicka>

On Mon, Sep 15, 2025 at 07:11:27PM +0200, Michal Hocko wrote:
> On Mon 15-09-25 15:40:34, Uladzislau Rezki wrote:
> > vm_area_alloc_pages() contains the only voluntary reschedule points
> > along vmalloc() allocation path. They are needed to ensure forward
> > progress on PREEMPT_NONE kernels under contention for vmap metadata
> > (e.g. alloc_vmap_area()).
> > 
> > However, yielding should only be done if the given GFP flags allow
> > blocking. This patch avoids calling cond_resched() when allocation
> > context is non-blocking(GFP_ATOMIC, GFP_NOWAIT).
> 
> We do have cond_resched in the page allocator path, right?
> So unless I am missing something we can safely drope these. I thought we
> have discused this already.
> 
Yes, we discussed this. I did some test with dropped cond_resched() for
!PREEMPT kernel and i can trigger soft-lockups under really heavy stress
load.

I prefer to keep them so far for consistency. I need some time to
investigate it more. As i noted in commit message, the vmalloc()
path only has those two resched points. Probably i need to move
them into another place later.

As for page-allocator, it is in a slow path which i do not hit in
my stress-setup.

--
Uladzislau Rezki

