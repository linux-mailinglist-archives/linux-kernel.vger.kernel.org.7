Return-Path: <linux-kernel+bounces-825377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3576B8BB4E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F2918928B2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6E86331;
	Sat, 20 Sep 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1j61Dzj"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AEB4A01
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329400; cv=none; b=tlEWzpwh6Gv0Q2EvPLW8JPZdW6OZuQOoA2iCEY72dKyPQOhhBxzkyPzLewAvl7zfN/mZbiaLuFiJztthfHSNloVLpir4lEKd3AI69OE+AbOBoZ+iP65kz2XXRSqDDt0g46xWmoAqp8GCSPcXvsfSP6WtfaTZiYZ6yW5Yx5JJ36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329400; c=relaxed/simple;
	bh=BEfv/CXraMXuo0VX8shgY1UFGOdECL5yYJTAksQW18g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk6a6nLJGU6w45MFufLS3tYT6Y0lNYc/C440/LVEIpX81hv6Gp3Z9pXC3+TNX/ik6/yFDk92V2U0k1MvMI9MX5vXCXvQSKqvN55tZ+kb0/v4Ffc/CH+hgiRYYqI91LWyiNx4gGdLCusomSN00cp9IrDoZLAvO574FFDoOKGv1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1j61Dzj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 17:49:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758329394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hEihim8vKtht5JHRfmYVIiOJByu0+5c7d4P7gZnX9z0=;
	b=f1j61DzjTjqsHJ1I+apAfiQAh+xjjjo7Ma1Z9O1gZoZy6hKt0YxvcGoBVQN8F0KjS1zUV+
	uQ//pI48JWJLaHz+4gPPOBmvMpxPEndCwFmhquFD7xkXk8sOCXBJjicbDXBId/zu/wToGR
	TpMnO96YyBFTp2XbJdr/fjdxnp8DwIk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its
 variants
Message-ID: <v7xskholk2cdoofuv247lbk3l643jovxqheuq7hu32wj2ncz64@irs7qwsbaiqz>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 11:46:33AM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In future memcg removal, the binding between a folio and a memcg may
> change, making the split lock within the memcg unstable when held.
> 
> A new approach is required to reparent the split queue to its parent. This
> patch starts introducing a unified way to acquire the split lock for
> future work.
> 
> It's a code-only refactoring with no functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

