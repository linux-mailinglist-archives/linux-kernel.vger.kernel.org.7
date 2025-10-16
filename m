Return-Path: <linux-kernel+bounces-856119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4CBE3260
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A0B1898D37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D931BCBC;
	Thu, 16 Oct 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="byhMwOZk"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31A6F06B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615176; cv=none; b=nG6GgcbisPmANAsisonYv6EgtT194mx5g4TVPNpyW23TKUQ9MZsLw1kG5jbPa5ZIB/nAh2jinZZvm1vBuHh+VY/pof8fCmiMIRKQ3qOsou+kDcEex5OlmrA+KdWI2EHwIzR/0ZAwMPf5D7UUzYgOYFSMdmG92Upcj/gwyPiRkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615176; c=relaxed/simple;
	bh=pRpK96lDE6OLloR8De0xh8oznT3ec2ytHdz3sdAVwkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFel3vf5HmjRDjCsNoF7pnalB4lhcCbIxVHFhnHkFXKlTBxIZPSWtlS3y8wOR9FDxTUFW1YeLhOIlSkk/lnBDh3gp5acugJfrR3Jk+yq8Cny79zbo5CUuFMLd1x/5LURAXvsuz4S+zpcIl66txN92fUn8hN56UBo/mUozr7KlYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=byhMwOZk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bbeec2ed7so212574a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760615172; x=1761219972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEybVDne/oWSW1AYKT7VZNJlFsHn8SBzTGn6UtfiXGc=;
        b=byhMwOZkv2bbQW/ha/FLkZa+By+dasif7WO9uNClratFhZqLDTnP0+VhT2W0W3gHte
         mDG6LgIjPBw6oITvzTAigZKpzoWUtKmSbJzpEcYYPCHOrQ6vzWBJcp3BmMCIL/YirfMt
         Ohn643CsG1m0aA7Yo/TpHpUjNhSVsw73McQlt5JRqkRL6FANf6emMG3daulqt6tNW4aO
         VMN1Z1e9GFkqcCCf0hATTtczUcT9fCkbnkvIo/esxclCP8PFSgA/yKUQI+kyl2ppm3VH
         Ktkx9cXFJZnKkxDXtkChS9RViP1PeuVycDQUzHjW6JhqpUT6xlpuXuSSsgS29/uyDtRR
         wQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615172; x=1761219972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEybVDne/oWSW1AYKT7VZNJlFsHn8SBzTGn6UtfiXGc=;
        b=M5rwpsLOr5w+5LIMsEqdUL5vhZcRGpgPRgOtITT3ijzsNAC9DBxjfMRifBuu3QcUsb
         wyTKrC0sYk64lWJE6Td92hryBRC7Ds2n/yf/KHZp1tXVJYRtAIFdT+v/wipaSmXYonsT
         zKehMoa11UvulRR06WViw/VDfg1JCrHv2fEZdyJCvfk4puoMBSN3xUbnXKZvjchhwus5
         /8/NzaFRr6A3o8RIGDKdq8QOv6dnxyvADClUmfIc7GvpACUm3b6WyNEN/Oyy6p0W13Wy
         wz9A8LnwE/rZS18FPqNTUKMWjVsyVyX/I2C3E5qATOzxBwv9zI3DVS6Kn/GWVMfDf0/m
         +MXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCiNEOzr9LXuQwSiWyG/VFqOCP5PsHt7qQAIgmVl2FBIUc/jjwZOzQQ1Zbs0DuAS9ae2t1tjGQCLszFrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfokQQPI7Gfp2NAnr5JHP1A76juaeWWmhfXH3AsnZHmXYLJVee
	wzbYiqD7XORI+P6qGiTWspDjFQSy1RHamqwGEgM0oxwg1e6hY7kEcXvw8MQuKwDCXQ==
X-Gm-Gg: ASbGncsGfPucBAc4vNxBnWSB8/F3RyxmoZ82yxfp7y9YbzonDjymculjsSi1seXYyC8
	RWBYTJ0508uFHpjae5aWi6m64t1BvzMySqVRBBo4cUQXlChLht3VkT10cuMJg6qgJiELSRL1Icj
	ormiCUYinqJk838udvAjO+jhB12o+7JaR59PA+ggoih3oPvIHwdw7Y/qkoIqimSNF3h/AYiep/2
	NKSeSpZL+UKw8WILsdP9FMx5FanHs08h/keDUw+u1PriGcFf7XjsOPq7A8G4XoWrKsHcIES77ac
	Z4NyDJq40dAaQoYT6GPG3MYDvVBm9XRWHjOhXMqyXiW1G21Qkcea5XpBTE6BezcbsQ6n4jMApqH
	xRR2O6VY2Zift9LGSKVhUEKapwQ3DOK1VVshIBfrZGTmlOoXnRIgVyhVSv+k81XmDU0PMNNLOZC
	8mPnWhAYkFTVQZvObZA3W6YqaQiw==
X-Google-Smtp-Source: AGHT+IFicv9CoX73fy5pRfeN/psIfxPvl8a4N7ufpUxivJzgu4OD3/AYY1rOZwlNlxhpJX7OTBuHvQ==
X-Received: by 2002:a17:90b:180d:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-33b5137586emr44200008a91.23.1760615171585;
        Thu, 16 Oct 2025 04:46:11 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6522dd7sm1662750a91.3.2025.10.16.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:46:11 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:46:03 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251016114603.GC32@bytedance>
References: <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
 <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
 <20251015084045.GB35@bytedance>
 <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>
 <20251016065438.GA32@bytedance>
 <ff16098b-00ff-80ee-5130-f1327b0af17d@gmail.com>
 <20251016092300.GB32@bytedance>
 <eaedc19e-8647-ab3b-c09b-a8602d193011@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaedc19e-8647-ab3b-c09b-a8602d193011@gmail.com>

On Thu, Oct 16, 2025 at 07:04:30PM +0800, Hao Jia wrote:
> On 2025/10/16 17:23, Aaron Lu wrote:
... ...
> > With the above said, this shouldn't matter anymore but just out of
> > curiosity: did you notice this by inspecting the code or actually
> > hitting the warning about using an outdated rq clock?
> > 
> > Per my understanding, most likely: __assign_cfs_rq_runtime() in
> > throttle_cfs_rq(cfs_rq) will grant 1ns runtime to cfs_rq so it won't
> > reach tg_throttle_down(). The comment I added above that if condition
> > is kind of misleading though.
> 
> 
> I did encounter this once.
> 
> perhaps in the following corner case:
> 
> If cfs_b->quota is set low (and quota is set at each level), and there are a
> large number of CPUs.
> 
> After tg_set_cfs_bandwidth()->__refill_cfs_bandwidth_runtime(), we release
> cfs_b->lock. cfs_b->runtime might be consumed by cfs_rq on other CPUs.

Ah I see. So I suppose in your setup, tasks are already started and then
quota is set.

> 
> Then, on one online CPU, we can't get 1ns runtime via
> __assign_cfs_rq_runtime(). Current limiting is triggered on this CPU, and
> tg_throttle_down()->rq_clock_pelt() is called.
> 

Got it, thanks for the info!

