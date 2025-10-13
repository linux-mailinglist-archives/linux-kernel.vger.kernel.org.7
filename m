Return-Path: <linux-kernel+bounces-849936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCDBD1620
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456EE3BF457
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F212BEFF3;
	Mon, 13 Oct 2025 04:36:45 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB322BE7B2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330204; cv=none; b=tuHRU+pNyXzR2saC1K2bxewWAkTPHAJvA+OcjSyJEh5juqlIjPK+hSZFTu7BKHP6S8ZLv/+fTZ1LovGdAGTWBiMwFQjFFLRBlUmkej+VY6ixQTG8DlphHtMBB7JbJ9K0pZ6KLuYlOHwJpwBXcReQkfAUcDMN3GiT4yEFNxzW6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330204; c=relaxed/simple;
	bh=h8Fe6P63PQ7RaRnQU/Zy7yRzxH5ISIvleVFTbzMgXyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV8hKMZWsChjKF80/DU5L56OYADal06UJEFHtlnh71RMh0a+uMhsYykGXxg55+TJZxw6qHW48kscq7WN9kSGVHMhumxInK0M3uNHgk1lje+VmTmW1jVsz8XfCywHmNn0vix1gkxztW05uH0Raqaxe9z4TwSvjZfuXJkS2p7XID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-b4-68ec81d4371c
Date: Mon, 13 Oct 2025 13:36:31 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yunseong Kim <ysk@kzalloc.com>, Hillf Danton <hdanton@sina.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
Message-ID: <20251013043631.GC6925@system.software.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <20251002220211.8009-1-hdanton@sina.com>
 <20251003004828.GA75385@system.software.com>
 <20251003005230.GB75385@system.software.com>
 <3b66d603-543d-4616-92a5-9e6e32f116be@kzalloc.com>
 <deb6c0a2-e166-4c91-9736-276c9f1741c9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb6c0a2-e166-4c91-9736-276c9f1741c9@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnoe6VxjcZBtMP6FvMWb+GzeLr+l/M
	Fgd+PmexuLxrDpvFvTX/WS3mfjG0+LJ6FZsDu8eaeWsYPTZ9msTusfD3C2aPEzN+s3i833eV
	zWPSC3ePz5vkAtijuGxSUnMyy1KL9O0SuDL+Hd/EWPCUvWLlsqwGxm62LkZODgkBE4lvO1ew
	w9jHrr8Gs1kEVCWOLJkNZrMJqEvcuPGTGcQWEdCQ2NS2Acjm4mAWuMQosXRtJ1hCWCBcYnr7
	ORYQm1fAXGLFrjmMIEVCAsuZJL59f8YIkRCUODnzCVgRs4CWxI1/L5m6GDmAbGmJ5f84QMKc
	AnYSm+9vB1ssKqAscWDbcSaQORICe9gkruy9DHWppMTBFTdYJjAKzEIydhaSsbMQxi5gZF7F
	KJSZV5abmJljopdRmZdZoZecn7uJERjsy2r/RO9g/HQh+BCjAAejEg9vxu7XGUKsiWXFlbmH
	GCU4mJVEeM2r32QI8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi
	4JRqYFzx91jHTpGov1Yf2c1bfbsnG0VdZap9vcRhxhmBHAsxVqPjHVMZF095zb+p4lWD4MW8
	K+IT98fcVapa8OviSvuz3BnNf5X/KHOcDOK+b1T0gNnvjHbfS8U7y/mWOR5SOnpMZAvT5Kx+
	qYNu/+5P3tZ1MO7PUQHOSrO2S6HaeefiTtg8jOG4M1GJpTgj0VCLuag4EQDaKre4cgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXC5WfdrHul8U2GwdHzShZz1q9hs/i6/hez
	xYGfz1ksDs89yWpxedccNot7a/6zWsz9YmjxZfUqNgcOjzXz1jB6bPo0id1j4e8XzB4nZvxm
	8Xi/7yqbx6QX7h6LX3xg8vi8SS6AI4rLJiU1J7MstUjfLoEr49/xTYwFT9krVi7LamDsZuti
	5OSQEDCROHb9NTuIzSKgKnFkyWwwm01AXeLGjZ/MILaIgIbEprYNQDYXB7PAJUaJpWs7wRLC
	AuES09vPsYDYvALmEit2zWEEKRISWM4k8e37M0aIhKDEyZlPwIqYBbQkbvx7ydTFyAFkS0ss
	/8cBEuYUsJPYfH872GJRAWWJA9uOM01g5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU
	5mVW6CXn525iBIbusto/E3cwfrnsfohRgINRiYc3Y/frDCHWxLLiytxDjBIczEoivObVbzKE
	eFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGA8vSl52Y6NP
	j4nbeZczotd2zbWXuZVxm8snXlHkm80926W8F61z+HYeSpqWb76LbfNWg/9/NRJ2fltm4eax
	/mSCyWcjsdwD25Kv8LXm3jkl8OrGXAGxMzrLpVh7ag7PvvOelyHqq8rR6De5myaYZaewlP2s
	+5h49ee+w3sv5PX+viQcLhkhWKHEUpyRaKjFXFScCAA6FUjaWQIAAA==
X-CFilter-Loop: Reflected

On Tue, Oct 07, 2025 at 09:04:59AM +0200, David Hildenbrand wrote:
> On 07.10.25 08:32, Yunseong Kim wrote:
> > Hi Hillf,
> > 
> > Here are the syzlang and kernel log, and you can also find the gist snippet
> > in the body of the first RFC mail:
> > 
> >   https://gist.github.com/kzall0c/a6091bb2fd536865ca9aabfd017a1fc5
> > 
> > I am reviewing this issue again on the v6.17, The issue is always reproducible,
> > usually occurring within about 10k attempts with the 8 procs.
> 
> I can see a DEPT splat and I wonder what happens if DEPT is disabled.
> 
> Will the machine actually deadlock or is this just DEPT complaining (and

Of course, it was an actual deadlock, not just DEPT splat.

However, even though this patch resolved the acutal hang issue, it
looked mismatched between the watchdog hang report and the DEPT report.
We are now re-checking it using the reproducer.

	Byungchul

> probably getting something wrong)?
> 
> --
> Cheers
> 
> David / dhildenb

