Return-Path: <linux-kernel+bounces-599175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FFA8505D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 02:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9980443EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09C20FA90;
	Fri, 11 Apr 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrChvCdx"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F187215067
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329609; cv=none; b=S6nk7V2GtjWFgBKCbEi9gNdGLfAwhmU0D3G4GegkcHN/R7IVTnkuhbnCG71ySFesi/c07yQHxvfqiXuPhvFDKXrumoJ/zFP8fGuw3QFwnopMOkoz99uQ4hcLtroVcFT2pkJX/texPUbujaY/L1lMI5i+CIljQ0uUg67NElgP6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329609; c=relaxed/simple;
	bh=KlgwoACMu9cGLhcFhVjRq5cgj63lNPNHKQGYwpUXzlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjKOuI//rhIccU+wAy+FwHedTrUo/AOtip4IuXKutHnSYV9MsNVij+1M1/H+6ewo+b178iDFYw5hMJlPqJi2PXjOf8W90qSMCvRRPFEhKLN/8KAQsSTVNQGZTVv96TbHhFU9WfdEzcbalRDDq1j3OTHoRzzESLzgDtEuvWYie/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrChvCdx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744329593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlgwoACMu9cGLhcFhVjRq5cgj63lNPNHKQGYwpUXzlU=;
	b=SrChvCdxSxE8UFwPqJ6jAwLJFC2TqTpiMacg3gSaMmhtYdovwlTyWH0K/Yhm5YEahHUB4/
	yAzePr1AOlvpWz2e5WRoS8YTH5hq8SNN8tV1C56ij9D28rGaHTBavkfeztN3kCLJmiIv9B
	8OK+SeRrh3z2BVXT+jh17eMqJ4Jd270=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Yosry Ahmed <yosry.ahmed@linux.dev>,  Waiman
 Long <llong@redhat.com>,  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: no refill for offlined objcg
In-Reply-To: <20250410210535.1005312-1-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Thu, 10 Apr 2025 14:05:35 -0700")
References: <20250410210535.1005312-1-shakeel.butt@linux.dev>
Date: Thu, 10 Apr 2025 23:59:47 +0000
Message-ID: <7ia47c3r1sb0.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> In our fleet, we are observing refill_obj_stock() spending a lot of cpu
> in obj_cgroup_get() and on further inspection it seems like the given
> objcg is offlined and the kernel has to take the slow path i.e. atomic
> operations for objcg reference counting.
>
> Other than expensive atomic operations, refilling stock of an offlined
> objcg is a waster as there will not be new allocations for the offlined
> objcg. In addition, refilling triggers flush of the previous objcg which
> might be used in future. So, let's just avoid refilling the stock with
> the offlined objcg.

Hm, but on the other side if there are multiple uncharges in a row,
refilling obj stocks might be still cheaper?

In general I think that switching to atomic css refcnt on memcg
offlining is a mistake - it makes memory reclaim generally more
expensive. We can simple delay it until the approximate refcnt
number reaches some low value, e.g. 100 objects.

