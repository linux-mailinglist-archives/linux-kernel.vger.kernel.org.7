Return-Path: <linux-kernel+bounces-809901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25D6B5134E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E30616C3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DF314A6A;
	Wed, 10 Sep 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JP8VSGb8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221518FC97
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498129; cv=none; b=kMRnrSQcsSWJI1ZE2gZ+d/GLPJYwMtxm7WxhV/cl4TTVyeGq+nVcLKpmXZiv484ZzSzjJSr0medR4GLNIK16ffZfINnAEZFVk3P5hb2bwwzr7BfmoEuX3kTf2MJj30tTw4bd+xyolaRb9nwYTgnNo1jYAuivXqnGh2d/I+oqX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498129; c=relaxed/simple;
	bh=xfTqnHdvgd+w7nvWVenmv/Zl+heyzHkpemmTdjv859E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCPCg33mIUTBo9e3Dkvo/+kB5asqvncDviguPjmZjE1/vtCi7UQORVIDbUsapy8JPNLGh7gel1Edl+S8aSN8IBnJeiwAncU0hyuK2zPv4821cs8Wn/MAzP6Cjs39KyIYQ/BLD87Fe3nS+iuLuS9+EW6uicRNG/eiXfMFJQk6lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JP8VSGb8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7741991159bso6230036b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757498128; x=1758102928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCDCW1DJDwjeVUsbjWyUYxZAgB9l/KJebELwDQQoPFg=;
        b=JP8VSGb8Ck7n+3ZhZkekFtRjnJjikAE+htg4//7eC5nDBavtLgNgv7WeiDvw2KDC+k
         g4fZVlqiwFVFhmf4dgQKm+UI9yCHcFGxJ4EfQFkISBVZEPVOVe5TMBGQJGIYorZmcFKY
         zZp0ImfOb9K0gcy+MjfYegcX4fUMSc3nWzX3dSJ1z4vLU+T1xZJr6Zc5RDAsTYfpahxY
         mqwxwetdbPcdFOQ3eDX/GYu/NZOpnUq1itvrKAtyGCnLOcSTA8wJURSKpWZSsL6oFHWz
         4G8Dp5vTnjgtDhGAwzaEQpqfLW0rEvOXcQ6Lfb/oq9Y7PxBbS30MBCOUKz5W1cShSgUt
         +wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757498128; x=1758102928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCDCW1DJDwjeVUsbjWyUYxZAgB9l/KJebELwDQQoPFg=;
        b=N2fS1woP+77MOy9QMvtrDPVwNRT/Iba0Zb4x8BdAX4RqGuirHshT8qUe8K6ETI8U0E
         UjfGlaqXWBVXbckDDyjwyi84nIaAxrLJ5FFEcL5aUD0t5s59Ld0AW2bLunO1x1iTldYx
         rBS75j/ULCwF+acN3a1H86yadF0AzZ8hR4K8pL7kKOuBfoFczZ1yr66bAs79FmZdT4a5
         NDDk0YfChRYxR4bS5UXhl1XZpzKhlq/hkzWLtqGepsmvhcaGhjWO25bgczeSRw3Qv0Ca
         /xPipRHi+A646fCttfPfO4aWq9+dWpLYiYWyqJatCqqMsibbImWDycwwnIA0PU8o4fRl
         fpKA==
X-Forwarded-Encrypted: i=1; AJvYcCWaKwrZPJN7iQK9oPz17pkI7lZmgtU4I8pVOVVA7NFaxioQntIj+YpTm1M/bsICeY1tG/TXa3VbeN9ozfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvigyTzM90QXkwHvS0juQf9PUOU0jP58KM4hUKmw48suYB3whV
	S52lQlngpaTdmL/w9epxFLTMK/yXHNyYAevVyz4n3bXoJ7JDvWcdi+1AmTEgaAjT5g==
X-Gm-Gg: ASbGncvKMCUIK+EmXuMsPKP49vrtvblA0r8Q2uYkbFTi07g3uZMb2I10dEm+UuyjkJM
	wF8d8T+VImTk7y9ePaczkDez3VbKm6NrMBNJf1bOaBYRRJ4mWP3SDEWtA+Asf8dn2x3xeSl7a7v
	GEQ01gKsSmbqzSBuOgSW2mlMOLjbk/0JMyrV5/Y+405Xnl98pBaAL8+mBjrl/IYb90gfnWBTNMd
	6cSa9yhTcj8iphj+oF8VXQGSNYvjeOvqayZvlBnNB0LB/y2TByuG2uPV2tQkVsMmKpMWT/I8IVa
	zWBxryoIMLwMRlvYlmIPZCfXTTHpJAa3oaYYffvySw7x86DX+EjLILcFhNBj+YdR3GDT6i4h3DO
	zV10WZfKZXEbzoUAQi8/F4r0jzFfP0UVJKTj+Jn1VnR7u9fNyAQ==
X-Google-Smtp-Source: AGHT+IFmU3xrUacDZpXLML8Y+6XKXJYFALe5fXyF/Z8mNdu2z6DBp0qPcfflXDumO96Ad3U8GHtFWg==
X-Received: by 2002:a05:6a20:258c:b0:251:9f29:4544 with SMTP id adf61e73a8af0-2534441f61emr23884742637.34.1757498127563;
        Wed, 10 Sep 2025 02:55:27 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a50cb23sm2065239a12.19.2025.09.10.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:55:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:55:03 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250910095503.GA261@bytedance>
References: <20250908110548.GA35@bytedance>
 <202509091233.f6nP3BVh-lkp@intel.com>
 <20250909061746.GB35@bytedance>
 <fd017cc8-0eb0-4961-8f59-575505f27a68@amd.com>
 <20250909062715.GC35@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909062715.GC35@bytedance>

On Tue, Sep 09, 2025 at 02:27:15PM +0800, Aaron Lu wrote:
> On Tue, Sep 09, 2025 at 11:52:55AM +0530, K Prateek Nayak wrote:
> > Hello Aaron,
> > 
> > On 9/9/2025 11:47 AM, Aaron Lu wrote:
> > >>>> kernel/sched/fair.c:6747:1: error: expected identifier or '(' before '+' token
> > >>     6747 | +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
> > >>          | ^
> > > 
> > > Sigh, I remembered I did a build test with !CFS_BANDWIDTH and now I went
> > > to check that build directory and noticed I didn't have CFS_BANDWIDTH
> > > disabled...
> > > 
> > > Sorry for the trouble, will send an updated patch later.
> > 
> > While at it, another nit.
> > 
> > On 9/8/2025 4:35 PM, Aaron Lu wrote:
> > > @@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
> > >  {
> > >  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > >  
> > > -	if (cfs_rq_throttled(cfs_rq))
> > > -		return;
> > > -
> > > -	if (!throttled_hierarchy(cfs_rq))
> > > +	/*
> > > +	 * If a task gets attached to this cfs_rq and before being queued,
> > > +	 * it gets migrated to another CPU due to reasons like cpuset change,
> > > +	 * we need to make sure this cfs_rq stays on leaf cfs_rq list to
> > > +	 * have that removed load decayed or it can cause faireness problem.
> > > +	 */
> > > +	if(!cfs_rq_pelt_clock_throttled(cfs_rq))
> > 
> >           ^ Can you also add a space after the "if" here.
> >
> 
> Yeah, I definitely should do that, thanks for catching this.
> 
> > >  		list_add_leaf_cfs_rq(cfs_rq);
> > 

Just a note that the updated patch is sent here:
https://lore.kernel.org/lkml/20250910095044.278-2-ziqianlu@bytedance.com/

