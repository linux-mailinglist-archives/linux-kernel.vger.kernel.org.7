Return-Path: <linux-kernel+bounces-877015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A713C1CFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A366D4E11CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D3330B1C;
	Wed, 29 Oct 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aLl/bqy6"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879C2E1758
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765739; cv=none; b=omdXxXc8HSpuB/pk0KPG9WHIutgOeAzOg/SupWsOWZ9wRrjYSyXEgZl/GWJuBQUH9xQftAIv93KfIHabX1XooUViTBDYeKt9nz0W0rshqv7/DQWF1ur6vU4npJ0XZYPLx4lq+CdPRsz6up7gIuC2hmYU4beIbTdrCVLgCBiAmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765739; c=relaxed/simple;
	bh=2ceEKQ8CzB1W4xtiUMJZU9tmJDc3qWj+7F+UoKPCJcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuQ7Rwct3N5h3vBjXuM4+cZAp9AG0ZGXl+2xSwQU47wTaiPGGzqk+5PSJqcOMwfl+WuZXTXvFH+7+vXViB8NfyVIJdPDOEqqloe5IBjvFYEgeXZNSpls3J72Yp0JY0M2oZlZH4VbsSLn7Rmi0RFJcdFwQf4Pmvkf8OP2qpFRGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aLl/bqy6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ecee585f23so1095161cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761765736; x=1762370536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfIXEvPunijsVQuODQPeiqITAMmRR37QOmIAdEcsp8I=;
        b=aLl/bqy6Gm57D2yfe45FpOpVDDDrluEVMiJznLx+XPM2ptQBpzyteWopG0fdjOqiyc
         +t6fErsXY24KLwkfUcibd1by6X8FvxR2qqswuH+bGyKMzpSvP5uO0wYrL0CV8GKYk5l6
         YYpKpUsCt/YMh8Pdhbyta1zmYVvTZc4fCijwkeNfINtmDsQcNW3royQOFMnUzgzV/8Ph
         rxkd63YkINZXSRUZqKxqqpISBy9dMnheZQthZuoXO8AkcXI1a5q0FVFtngEoCm3wYZoB
         3dCe3iSEzhdL8mELcBmCYmWRqx2Pp42xVTshq8/pEwmg42AjqiCXuGloOHNJCPmnzB8h
         sMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761765736; x=1762370536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfIXEvPunijsVQuODQPeiqITAMmRR37QOmIAdEcsp8I=;
        b=tVCNoSPCMa8iNayWXNhUQN/smcQVh+DlwD3UbaHQ/UoZc7m9WPSejM7rhCTk8ZTqFp
         2oRjjC4YUmgO77vSYAUpAgvUFtN748Vb+2dI5u1j3TYybpsPPIZJz9KxuTrBIpZX3S13
         vfXvV8VSpQMJYWsOiCjgqt9doLLUqMPWxqXez266vzKm5nIKkA89jyuBjaa2L1dEHdrw
         XXkEx6Is0RWPN/2vFyHK97cK2iKT/h/pzX4/EXOw81MRZLrMizWELOMGJOpxB4gBTnPK
         nqnpYHJaB32SzF5MyfE0JRlHyhEDgoTeFBfXeqVLS7F5EhpIqUB6rlJAuYA1+VakQvjt
         fxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN26qKKUX7RLs3rKFsc+acOF4uK8VB2fa6qWV/mCqHpEQEXLJsIsND4Cc6EG6NxtiTMcHFgZ0kcdjkdnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9d8b2EJiQEg+dZTYxa5cMUC0PNuIpfdTRL07xAcf9AW6r5L0B
	ACHecDqhLNe9aWnAGQ4GMB8klrhj7KJXuPvM7ZbmrRTE476HgDM1/EkSG7F9SfjkYWw=
X-Gm-Gg: ASbGncv03sVAOx1z8F1X7r+oMNk/9XSbYNDr8q7tkACzMUB4xlAL5kNAFnq6T7l2kwK
	A7kFs2lZAdD5AtO111YM6Suoys31+sZrZda1HUQ9e39TJu8y71Oz0rlm9FP7kaybpHcp8fCOWYC
	2s9wP2O3jaulcaWsFBncRg5aZrJXoHsyWaPjA7iYrBA4fdyglGFYB7s+ie/80AF1s6eXpSau9p+
	mPlDLy/5ngoq4JUD4YYvFomWbM0DYPyZNKTpUp7CGbqLYdELO7BIkCjrVq2U9UdfnzKX3FCCMKk
	IvkhNXRg+k2gBblbZawCtNW9vPhHDsAfD/Yi8fSefDEu1kPvIdsGjq6jCA/RR/aEIVJvz2O+o7k
	yuxyVIgObC5/YC9ZL4TukZWlOEJ3fzd1rUgArx15aKfZIsM5gwzwtSHVKMGPtlXqx53BWtME66H
	Ai/SJPSUPG4Q3fnDP7glyw4KxtoOmMEuuuwNVMNEbbo2tjag==
X-Google-Smtp-Source: AGHT+IGVRBhpr0YCJrxmGJz0F6X/D7oq9NIhu9pswYWpNbC/PlxAuIyihNKYSR7/JFQ9FslbSzKeuQ==
X-Received: by 2002:ac8:5954:0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4ed229fd4fcmr4752601cf.28.1761765736088;
        Wed, 29 Oct 2025 12:22:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3803e96sm98354441cf.19.2025.10.29.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:22:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEBkM-000000051hV-46Wr;
	Wed, 29 Oct 2025 16:22:14 -0300
Date: Wed, 29 Oct 2025 16:22:14 -0300
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
Subject: Re: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Message-ID: <20251029192214.GT760669@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>

On Wed, Oct 29, 2025 at 05:49:38PM +0000, Lorenzo Stoakes wrote:
> We introduce vma_flags_test() and vma_test() (the latter operating on a
> VMA, the former on a pointer to a vma_flags_t value).
> 
> It's useful to have both, as many functions modify a local VMA flags
> variable before setting the VMA flags to this value.

Hmm, sure would be nice to not have this inconsistency though.

It is a bit wordy but with the C preprocessor we can make this work:

struct vm_flags_t {DECLARE_BITMAP(..)};

void func(..)
{
   struct vm_flags_t flags = OR_VMA_FLAGS(VMA_READ_BIT, VMA_WRITE_BIT);

   flags = vm_flags_or(flags, OR_VMA_FLAGS(VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
}

Where OR_VMA_FLAGS's OR's together its __VA_ARGS__ and returns a struct vm_flags_t.

Would that be interesting? Eliminate the inconsistency?

eg

https://stackoverflow.com/questions/77244843/c-macro-to-bitwise-or-together-a-variable-number-of-arguments-lightweight-solut

Or other similar solutions.

The compiler is pretty smart so this would all fold away to very
few instructions.

Then everything only works with _BIT and we don't have the special
first word situation.

Jason

