Return-Path: <linux-kernel+bounces-811618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A676EB52B97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5F71899F93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3542E03ED;
	Thu, 11 Sep 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jldt/Gva"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096E2DFF12
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579204; cv=none; b=VfZk7oKS+IczIMvMYIEHs7vWLHOWipNS0l3OIdn+mqShW0Ew7QW1z7sEUU/j314qhtN7bDbx54Otpe58AVtqjLdoUDcRoFow6BipnFl+ptb9x1HFQnMPUlSmKGFB/og9WhwoCUCfeGzp9zAXdxF80HpB7o5V4JOkaAhZfpYqmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579204; c=relaxed/simple;
	bh=7G0Gigbg3lf2yJzEbCtDBXBUZOCpEa9S5paz6bcYs70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+0ru9l4NiK9PROuHWfFULpMv3kNvDj3KDGCj4wQmcG3I/Nkik0QDKz2pEwzagD7FmhmUUTZtKcOva+87CMZxyoMD7nPtZCBX/+nme2x/GYn+012uuS0ORSM8Qhfx2siPZox7IPMvS8iCNIlQrnTLxLrbulJsTLjRlTd+wWgP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Jldt/Gva; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cMrHy1Sj9z9sZK;
	Thu, 11 Sep 2025 10:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757579198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=impNTtmimBVpMpk2A50bdGSwXBnav8MDAIfgL8/eWtk=;
	b=Jldt/GvasF0DV+wmm9a3Ok4LtMDbdKNGmHtXARNqBIJeTHN6hd/iVYVXbxTk9dwleGVlIZ
	GoBIl8DPCDgv5p8y6a9AvLOh1Anlfvte27rL9RtlXC/iwPiSMhMEEVUpLREsOMidsdyNkE
	rKxP06KIMbma2xmS0fRDS6oP1K0SpMVfRoEk+nJ1FA8WCaXA7ONFL3yq8dIZo9VU0aHQs9
	YpNlQZbdXJvZ+56ZJ+GeLyDJxCIDgFFhxYH1rAttfuYzRB1M1xnjPL02xT41/u8fZ6QLw7
	gXlHYhJ92dwFlHZ4p91L6qm9FuKMnWslriKsR/HyWi9AU3xp7Xs47JVMfsZggA==
Message-ID: <262a176a-4c80-40de-96e0-c97f50c20fe6@mailbox.org>
Date: Thu, 11 Sep 2025 10:26:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: ttm: do not direct reclaim when allocating high
 order pages
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250910-ttm_pool_no_direct_reclaim-v1-1-53b0fa7f80fa@igalia.com>
 <e79a134b-89de-4da1-b64b-b890227fce8a@amd.com>
 <aMF0fe7CIVD-8zVo@quatroqueijos.cascardo.eti.br>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <aMF0fe7CIVD-8zVo@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5d904369927bf810511
X-MBO-RS-META: 1b4dh5w49qn5wku16r8i3c8fbdzjok5y

On 10.09.25 14:52, Thadeu Lima de Souza Cascardo wrote:
> On Wed, Sep 10, 2025 at 02:11:58PM +0200, Christian König wrote:
>> On 10.09.25 13:59, Thadeu Lima de Souza Cascardo wrote:
>>> When the TTM pool tries to allocate new pages, it stats with max order. If
>>> there are no pages ready in the system, the page allocator will start
>>> reclaim. If direct reclaim fails, the allocator will reduce the order until
>>> it gets all the pages it wants with whatever order the allocator succeeds
>>> to reclaim.
>>>
>>> However, while the allocator is reclaiming, lower order pages might be
>>> available, which would work just fine for the pool allocator. Doing direct
>>> reclaim just introduces latency in allocating memory.
>>>
>>> The system should still start reclaiming in the background with kswapd, but
>>> the pool allocator should try to allocate a lower order page instead of
>>> directly reclaiming.
>>>
>>> If not even a order-1 page is available, the TTM pool allocator will
>>> eventually get to start allocating order-0 pages, at which point it should
>>> and will directly reclaim.
>>
>> Yeah that was discussed before quite a bit but at least for AMD GPUs that is absolutely not something we should do.
>>
>> The performance difference between using high and low order pages can be up to 30%. So the added extra latency is just vital for good performance.
>>
>> We could of course make that depend on the HW you use if it isn't necessary for some other GPU, but at least both NVidia and Intel seem to have pretty much the same HW restrictions.
>>
>> NVidia has been working on extending this to even use 1GiB pages to reduce the TLB overhead even further.
> 
> But if the system cannot reclaim or is working hard on reclaiming, it will
> not allocate that page and the pool allocator will resort to lower order
> pages anyway.
> 
> In case the system has pages available, it will use them. I think there is
> a balance here and I find this one is reasonable. If the system is not
> under pressure, it will allocate those higher order pages, as expected.
> 
> I can look into the behavior when the system might be fragmented, but I
> still believe that the pool is offering such a protection by keeping those
> higher order pages around. It is when the system is under memory presure
> that we need to resort to lower order pages.
> 
> What we are seeing here is on a low memory (4GiB) single node system with
> an APU, that it will have lots of latencies trying to allocate memory by
> doing direct reclaim trying to allocate order-10 pages, which will fail and
> down it goes until it gets to order-4 or order-3. With this change, we
> don't see those latencies anymore and memory pressure goes down as well.
That reminds me of the scenario I described in the 00862edba135 ("drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages") commit log, where taking a filesystem backup could cause Firefox to freeze for on the order of a minute.

Something like that can't just be ignored as "not a problem" for a potential 30% performance gain.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

