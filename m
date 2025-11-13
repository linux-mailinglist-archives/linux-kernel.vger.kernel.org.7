Return-Path: <linux-kernel+bounces-899088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D25C56BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C0434E8B77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F7283C83;
	Thu, 13 Nov 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PGtK9514"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562082773F4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028167; cv=none; b=tIiftYm8QMwHgTZt+cYZVyeEfdUwe+AMxofYF4iHma16RTvdFDUhzmK1bPOvr67bBI3cvgpmi5QJGi49ioYWVwIKV21MTCWEszuGyvunABduTqs1t2blqXnVxuuaDAW0BwP2dKguhD+CbYH+xQiUhuz/kTvqnUyBHsxFGl/NaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028167; c=relaxed/simple;
	bh=39ntxjF7HM0Qr5kxQfS+FwVbyjKPp5niiblHmTNcCT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYY9bmbf7C0AeVkTD09h1u0yyejuLjpVevc1TEvUnC7vwKymiZN21QZ12jZQpxr8vu7sJ5x6GmZ31b86ygLxVlmTehr/9ImD8yJs3HFwwGwDGtXJGwTY85rh2lzTYpsgx0usHlC3HH+6pTT2kGHtUOfZJiib9C2jdNgJz5zTDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PGtK9514; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b7277324054so78006966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763028163; x=1763632963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJ4GxbkUghftUZgz8LHIpmZo8o/kmvfsJg9H+9W9+nY=;
        b=PGtK9514sc4uqUopGnaEDdZssNsJZ0NB7p/uJGHNEZOlhrmCuw2gPENxSXG4Ik1hop
         BYIoeMyt9LM7Ozx95CWUEy9InJdJXQnkCMmsQRcQARVa3AIQnynoRjhH1nh6TBTWC3nr
         eNHAUi4HyupuKdEwe+uiIirRlgIf123OrdZipxGXBn6T8tWJhJoaaVEBxy2jfAwD8nJq
         z6N5xUr6l9R/9rfZM/CA436eKP4wkskhuWu7awTCmDvI6lIEShu1EBIGKOUeKoJ6/3kL
         pWJvqjvffOzjdT5lcVf7Ydo3YjAlljqecq/4C/ly3SgsQjiBgvZcb6NwEJVLefCgtrtD
         Sb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028163; x=1763632963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ4GxbkUghftUZgz8LHIpmZo8o/kmvfsJg9H+9W9+nY=;
        b=QUfk9SLGfApCEfpj+V1eyq6LRtBUPjaTojvRD3yNqIUx9m0ZlIzzU230XsbB9n2bqM
         NT8AwTp0f1J57m5lmGNp1cEzMEICVDD/B56Z89pDx/TsC4tDbpEub+xJPIVJTMk92mTb
         BzaRm0mxBv9wkHvo5CXjmGK0MLrZPlaTrQM5I7jbXM4dSFOqkn5YXCgqzs52yDI2F5LQ
         2VvaJfl80aJLW7HBuZtC7fSu9MNmrdFqY9bG4rRY2L8OvToHlsc9uk1fhTtgpiV+/6Nx
         MyWRpF46CVWgH6n9Ye4Y/ofBabrl9e7WvodH8TRttiePx3wTZjcl0c2lDZnA4NLsWSLW
         Wd7w==
X-Forwarded-Encrypted: i=1; AJvYcCVcgoagWgHmX3/oKV/+indXo+2yOCC5wwofYZOi3Z7lxml9GwjESJe6j7GezvVrQ3n8WGY+rZxcXcVsShs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWAw8b0kzDie+eR+/3xWvP3pDRGMBeTbi9iPfJhnWwNgRerBO
	9ee8duRvHcwWHsz+ZFH5CuiA7IUwDTl/f7O8PUn2I8JqmSAg6kHI9NeNkCVeSqymBGY=
X-Gm-Gg: ASbGncvR09OepWNY7BotU2Anltuedk9xHzSvQxHZHwQ5CahoKf48kQu1ioOyOvGyxHJ
	Kry529VB1OTTpxSmWTDQQKAekvO2g1ZGY8QP6QHN17COUuRajJJAptz7+9rDjVL/2VGCXYMDd+0
	C2cVpRN+F4QoezmjPK49D9UxIBc0PcTUuX+1EQnId65lFq1sTPHSShGsJK4tIMsuKmBWQGUHEtQ
	ALZGOqPLYEL4YQ+e+mZqyEsS3Zsa+lQ8MIHrqSV1uOKCfzCZEZAl1toA/80fSiMlf8uVlkjukSF
	yIq+1pbmc4lmNZ5S6tRido2nSEWpRaf+y6ZBkcgiaN2pWBwJNxgvy5Q2ZoQndoWdk/4k77rarId
	v7o+L05fBUQmZrjBoajN1wFYj1K4T6GLeZPgl3BLjnaRswm92Zwo+pc9bIVt6z8Cs68E0ux4PrE
	rRkc3dBbL7yn7Nl5h97WVk3Yjx
X-Google-Smtp-Source: AGHT+IHzMgr8IXl+lxvWL/AmsNusVkAzjm9LLmMgRR0v6716of7tCRPkKpAGaASPUUXN6pEg5IRywA==
X-Received: by 2002:a17:907:848:b0:b73:4fbb:37a6 with SMTP id a640c23a62f3a-b734fbb40b4mr169500766b.64.1763028163438;
        Thu, 13 Nov 2025 02:02:43 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81223sm133331466b.4.2025.11.13.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:02:42 -0800 (PST)
Date: Thu, 13 Nov 2025 11:02:41 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: skip increasing kswapd_failures when
 reclaim was boosted
Message-ID: <aRWswVgIaAqJEvQB@tiehlicka>
References: <20251024022711.382238-1-jiayuan.chen@linux.dev>
 <e5bdgvhyr6ainrwyfybt6szu23ucnsvlgn4pv2xdzikr4p3ka4@hyyhkudfcorw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5bdgvhyr6ainrwyfybt6szu23ucnsvlgn4pv2xdzikr4p3ka4@hyyhkudfcorw>

On Fri 07-11-25 17:11:58, Shakeel Butt wrote:
> On Fri, Oct 24, 2025 at 10:27:11AM +0800, Jiayuan Chen wrote:
> > We encountered a scenario where direct memory reclaim was triggered,
> > leading to increased system latency:
> > 
> > 1. The memory.low values set on host pods are actually quite large, some
> >    pods are set to 10GB, others to 20GB, etc.
> > 2. Since most pods have memory protection configured, each time kswapd is
> >    woken up, if a pod's memory usage hasn't exceeded its own memory.low,
> >    its memory won't be reclaimed.
> 
> Can you share the numa configuration of your system? How many nodes are
> there?
> 
> > 3. When applications start up, rapidly consume memory, or experience
> >    network traffic bursts, the kernel reaches steal_suitable_fallback(),
> >    which sets watermark_boost and subsequently wakes kswapd.
> > 4. In the core logic of kswapd thread (balance_pgdat()), when reclaim is
> >    triggered by watermark_boost, the maximum priority is 10. Higher
> >    priority values mean less aggressive LRU scanning, which can result in
> >    no pages being reclaimed during a single scan cycle:
> > 
> > if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
> >     raise_priority = false;
> 
> Am I understanding this correctly that watermark boost increase the
> chances of this issue but it can still happen?
> 
> > 
> > 5. This eventually causes pgdat->kswapd_failures to continuously
> >    accumulate, exceeding MAX_RECLAIM_RETRIES, and consequently kswapd stops
> >    working. At this point, the system's available memory is still
> >    significantly above the high watermark — it's inappropriate for kswapd
> >    to stop under these conditions.
> > 
> > The final observable issue is that a brief period of rapid memory
> > allocation causes kswapd to stop running, ultimately triggering direct
> > reclaim and making the applications unresponsive.
> > 
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > 
> > ---
> > v1 -> v2: Do not modify memory.low handling
> > https://lore.kernel.org/linux-mm/20251014081850.65379-1-jiayuan.chen@linux.dev/
> > ---
> >  mm/vmscan.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 92f4ca99b73c..fa8663781086 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -7128,7 +7128,12 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >  		goto restart;
> >  	}
> >  
> > -	if (!sc.nr_reclaimed)
> > +	/*
> > +	 * If the reclaim was boosted, we might still be far from the
> > +	 * watermark_high at this point. We need to avoid increasing the
> > +	 * failure count to prevent the kswapd thread from stopping.
> > +	 */
> > +	if (!sc.nr_reclaimed && !boosted)
> >  		atomic_inc(&pgdat->kswapd_failures);
> 
> In general I think not incrementing the failure for boosted kswapd
> iteration is right. If this issue (high protection causing kswap
> failures) happen on non-boosted case, I am not sure what should be right
> behavior i.e. allocators doing direct reclaim potentially below low
> protection or allowing kswapd to reclaim below low. For min, it is very
> clear that direct reclaimer has to reclaim as they may have to trigger
> oom-kill. For low protection, I am not sure.

Our current documention gives us some room for interpretation. I am
wondering whether we need to change the existing implemnetation though.
If kswapd is not able to make progress then we surely have direct
reclaim happening. So I would only change this if we had examples of
properly/sensibly configured systems where kswapd low limit breach could
help to reuduce stalls (improve performance) while the end result from
the amount of reclaimed memory would be same/very similar.

This specific report is an example where boosting was not low limit
aware and I agree that not accounting kswapd_failures for boosted runs
is reasonable thing to do. I am not yet sure this is a complete fix but
it is certainly a good direction.
-- 
Michal Hocko
SUSE Labs

