Return-Path: <linux-kernel+bounces-852621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA8BD979F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1384E1927D05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA88B313E34;
	Tue, 14 Oct 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z0uuohsq"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C619F135
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446574; cv=none; b=G6oSqJ3z0tvNzUa4B0epzSuT/cIYawJeC4aVy+vn8piFVDCQT2BjBzq6Ax1mIGyQQbohSnSItk3VAlyC/z9yqImwXMV8zHA3VgJ/frlX7jQb1KbY+2cC8+Q7fOL4otzzVYok+gVSCk2zLV1Xv7Ab3LDp4aI7CpRHk7uUSplPrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446574; c=relaxed/simple;
	bh=oOoMCg4/1vDsD6BLsoeV5wac8hSuGH2pzXavQmet+DA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AgYM4GhX5C4bpPMv6mmksGeB2J63PPDESzTA8n4g0Jo3fLzb60PG1rEEQGdJi/MFi5Yv/wgEx2jS/nj8hOoGnteugSWnwrAsdEydA/di3iGL8y1PXJZBfFuTBHsHsVRL4fsRdSLAyj758TbYolypDAlV1OwAIn3FWOtAeBqpNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z0uuohsq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760446568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d80O38LxInO3RE5E1ZtL0vaLg4kbXe5845oQ64nU2Mk=;
	b=Z0uuohsqURAnC3fKaPtMPA0vpiJv2cHrLOxynTW3IZoeUJyY+B+AodkQaQnfoTUgyr+N7u
	2ixWgc8HImPK1lufV2uAGEHawfoiL9fEZnhqclg1HxQZzdarnXIMJaIgqv5eWRPxjk9KtE
	vpbNivyB2EgkuZ9ENyUF223yRwONiFE=
Date: Tue, 14 Oct 2025 12:56:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
To: "Michal Hocko" <mhocko@suse.com>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie"
 <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "David Hildenbrand" <david@redhat.com>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <aO4Y35l12Cav-xr4@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
X-Migadu-Flow: FLOW_OUT

October 14, 2025 at 17:33, "Michal Hocko" <mhocko@suse.com mailto:mhocko@=
suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > wrote:


>=20
>=20On Tue 14-10-25 16:18:49, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> We can set memory.low for cgroups as a soft protection limit. When =
the
> >  kernel cannot reclaim any pages from other cgroups, it retries recla=
im
> >  while ignoring the memory.low protection of the skipped cgroups.
> >=20=20
>=20>  Currently, this retry logic only works in direct reclaim path, but=
 is
> >  missing in the kswapd asynchronous reclaim. Typically, a cgroup may
> >  contain some cold pages that could be reclaimed even when memory.low=
 is
> >  set.
> >=20=20
>=20>  This change adds retry logic to kswapd: if the first reclaim attem=
pt fails
> >  to reclaim any pages and some cgroups were skipped due to memory.low
> >  protection, kswapd will perform a second reclaim pass ignoring memor=
y.low
> >  restrictions.
> >=20=20
>=20>  This ensures more consistent reclaim behavior between direct recla=
im and
> >  kswapd. By allowing kswapd to reclaim more proactively from protecte=
d
> >  cgroups under global memory pressure, this optimization can help red=
uce
> >  the occurrence of direct reclaim, which is more disruptive to applic=
ation
> >  performance.
> >=20
>=20Could you describe the problem you are trying to address in more deta=
ils
> please? Because your patch is significantly changing the behavior of th=
e
> low limit. I would even go as far as say it breaks its expecations
> because low limit should provide a certain level of protection and
> your patch would allow kswapd to reclaim from those cgroups much sooner
> now. If this is really needed then we need much more detailed
> justification and also evaluation how that influences existing users.
>=20


Thanks=20Michal, let me explain the issue I encountered:

1. When kswapd is triggered and there's no reclaimable memory (sc.nr_recl=
aimed =3D=3D 0),
this causes kswapd_failures counter to continuously accumulate until it r=
eaches
MAX_RECLAIM_RETRIES. This makes the kswapd thread stop running until a di=
rect memory
reclaim is triggered.

2. We observed a phenomenon where kswapd is triggered by watermark_boost =
rather
than by actual memory watermarks being insufficient. For boost-triggered
reclamation, the maximum priority can only be DEF_PRIORITY - 2, making me=
mory
reclamation more difficult compared to when priority is 1.

3. When we find that kswapd has no reclaimable memory, I think we could t=
ry to
reclaim some memory from pods protected by memory.low, similar to how dir=
ect memory
reclaim also has logic to reclaim memory protected by memory.low.

