Return-Path: <linux-kernel+bounces-878256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB996C201D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763874EB43E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7633546E6;
	Thu, 30 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gdlfWGl2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2B320382
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828927; cv=none; b=ZVsUs7/flWdE5cHv/sKoHjx340gLPWWkxWkBgtwSGRIp1AT5/3K4dHzcdZkhPin+K0efBZ8qgkIQTwlqalFBHaqqa01H5hPo/Htp4M8fGxNt+u1WXFoTdSi1zfCAl3X/vpmrSZVYdwqGvQqzH6xYDhB1uXFrQ1NLJKy9NaUN5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828927; c=relaxed/simple;
	bh=hDoug8aqE0H9YWALi8NfTTpqiEkwG6fAlIEDVp5LNbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv80nyE9KiQKkgfx4K+/obNNN96dupSr52pQToLn6Br3VzFIE5BZ5WiXRS8+avNLtDjZir0/tIApm/X9ZwtxRZoxoxlNPxtmuxEf+qpsUspj3JPxWG9QfTai6ERiQ//u1TbENjVyf5Ni9YuRqdadVDtaRn4JYvIxip+hKkLt6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gdlfWGl2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ecee8ce926so8819461cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761828925; x=1762433725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjXAFY7Yf0YuI8Me8mv/zue8i3Kx5a6EOrshoHCz3hk=;
        b=gdlfWGl23B3iDrrHFGSttI8Y/8tZxBxzJg8KDgqgdS4zU5P+1v37Ve0nxK/BzbRREL
         JhJn/KKB2wtreDb0dXEg0qc0RixaE+nwDG9OQ/IHH/YZNDNzaBCd9Cdd/+0wFoPROD7i
         Nplc2KuY3IutsnF1D9lcpvZkYk9Nm93CgUHY6NtLQosK5c74slUgrGq0hRWhbkgmEtIt
         X4qeTx/z5WjNndyM1jOLMIjyGRcbfF3yfJToIm8aatTcK+OtI8q9R/9InR/jQmAWsL5p
         35AZ3sik0OAo7+9vTt+4gmkLpWGBE/x+pXpTScIV0/t7Ggkb2KHw1RAzuUmx4sn898xj
         OLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828925; x=1762433725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjXAFY7Yf0YuI8Me8mv/zue8i3Kx5a6EOrshoHCz3hk=;
        b=Hh8r0Ieo765Kx/WQ0sg25Hdk6a45bv1Isu/Qyl3pon4njKo+g+JjadcVEdZ0aRBVSj
         Q94mRp4CtGxdiralDY5vsbjtvg6AD11E9Qv6wAV85lzu2KSzrd35EeQFihCoTKcrHYio
         59ELTjitHujjVkfEIT5MDyUoSi9SWvr7kTLx0cwmKy6WKORDdLTsNNPKU31KlobCVOAw
         wYm2vNDM7YHnfHQzNT+osoYqlz8Whm1BAZI6ptyuAggAMoBjNe2WfL1NeW/Npcd+X3H6
         g7bZPqIdlHWJpiSdikxLLEx+HXzKFCfWtez2M5pYrpUidAo3NqOQpYo6VYB2skSZidBV
         KLug==
X-Forwarded-Encrypted: i=1; AJvYcCUsZJIfzGtl93FhAUrxtFZi6DKqd3Ngjkk2NXmgPa6M8iJIPoY6EJkcmqBDVATufxjeL50sYx9+nei95Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8dfYAmcgQRWoF7cqk7oZZsoZ+XDnOldMA9Ghq0OhJlknPbs1
	ivyOIsC/z0UQRI559lLJBzitXamcu132mmmTMjW2t+yxSN0OztHSszSMRH0kzVGcFLM=
X-Gm-Gg: ASbGnct0nMI44sYNn5XP13Ubpv+G/9h1e1OBkMq7Dhym/L26onnvDWMPRUK17YeNlBB
	8OZkDUZUUnWXXvTAHQh/HvEm9IHeohMvyzVKpIr3aW3aCEVh4yYGsUB96o7gH4sHZeyC1vG7rVW
	VngfG/YBJHFj2Jqj5nBAFn0nK1HQE4ArDfXWPQfyj70TkFx5Zyo6akBDEMXps1xFFE57hkVLEk9
	aCPTTFSKWeLZ8RYOKEl/Ffd5M48Sd6aZyAcE/WBnGKxk38EmiEVqyuaSQmEB5Ko0KKG5vtM7gCB
	1f3jkqU9WO+TuXts8HOvJVer64PW9bCh1A+m48mc3Bz5luJr6bOKnhdytxqAfShELiryWWcVQ7O
	SBGH7Dek8Zxi4R9nkW4VxaYb0UhWPzz1P2Lm5kCwYhtskf+bRlkimDIFVksgefKLX7dUAnSUu2P
	j3Fus4Cb3ws/kwk7IAW/GP24xu4CQI3we2rqiYyLubRpzuX2EjSD4WTU6g
X-Google-Smtp-Source: AGHT+IFa87tUftxLW7en98BSp1AWY+Kl/BwNB6G5pnoREpGqN6QyPQ5zvarZ4A1oRBRNtr+ofNzIbw==
X-Received: by 2002:ac8:5a50:0:b0:4ec:b598:2544 with SMTP id d75a77b69052e-4ed15c19a74mr78731841cf.54.1761828923949;
        Thu, 30 Oct 2025 05:55:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3860692sm110493811cf.30.2025.10.30.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:55:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vESBV-000000058Xq-46nj;
	Thu, 30 Oct 2025 09:55:21 -0300
Date: Thu, 30 Oct 2025 09:55:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	John Hubbard <jhubbard@nvidia.com>,
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
	Gregory Price <gourry@gourry.net>,
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
Message-ID: <20251030125521.GB1204670@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029190228.GS760669@ziepe.ca>
 <f1d67c7b-5e08-43b3-b98c-8a35a5095052@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d67c7b-5e08-43b3-b98c-8a35a5095052@lucifer.local>

On Thu, Oct 30, 2025 at 09:07:19AM +0000, Lorenzo Stoakes wrote:
> > >  fs/proc/task_mmu.c               |   4 +-
> > >  include/linux/mm.h               | 286 +++++++++++++++++---------
> > >  tools/testing/vma/vma_internal.h | 341 +++++++++++++++++++++++++++----
> >
> > Maybe take the moment to put them in some vma_flags.h and then can
> > that be included from tools/testing to avoid this copying??
> 
> It sucks to have this copy/paste yeah. The problem is to make the VMA
> userland testing work, we intentionally isolate vma.h/vma.c dependencies
> into vma_internal.h in mm/ and also do the same in the userland component,
> so we can #include vma.c/h in the userland code.
> 
> So we'd have to have a strict requirement that vma_flags.h doesn't import
> any other headers or at least none which aren't substituted somehow in the
> tools/include directory.

I think that's fine, much better than copying it like this..
 
> The issue is people might quite reasonably update include/linux/vma_flags.h
> to do more later and then break all of the VMA userland testing...

If only the selftest build system wasn't such a PITA maybe more people
would run it :(

Jason

