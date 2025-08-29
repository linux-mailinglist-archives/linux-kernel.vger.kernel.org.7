Return-Path: <linux-kernel+bounces-792334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C7B3C2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72807C628B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21B239E65;
	Fri, 29 Aug 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maMdnIWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB7238C26
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494450; cv=none; b=b+NsRY7ccllEBxcnfIK1DOJUjizAzAXvuXAH0Y5onJpVhQjJdUHefETUMA70F39KJu3b2xqwD7Rk++xpTFGHATtO++cesfa7vS4Xm0a6uzJkw4v35r1MHPDxr4RBToaeJ437B/dLBDy51uH+zJGEnNnS4h7wphlXbKH4UMcSR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494450; c=relaxed/simple;
	bh=1Shi8HJrteTcOySM/bdJs2aeSH/sLRydCCsiHIebN7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDQQTzM/KTrOFNunoHFFehqxw4/i/CkJU3ZWRfW20Ae9w7Q+b0zCb+5QmENbPRtkGcfkl37HdyrSmpYtkMw8AIappSLVHmpkU/jy1fEl4dA2yPJnNRvCF9v6umEUKDGv/KjC3K2ueVMJ/oJ6hroY+xV69R93ERJDH+czOTPAvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maMdnIWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D322C4CEF0;
	Fri, 29 Aug 2025 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756494450;
	bh=1Shi8HJrteTcOySM/bdJs2aeSH/sLRydCCsiHIebN7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maMdnIWkF/k0CEl1/wG66nhX5O+AKCirshD5t3aZABep2ejOazOLulBkrPP8HZh6e
	 g8aQse/iYVDueyL7axACXOq5H6snn87RL10izSFOzRCvJHAGV586zGKMEUVDrv7Nvc
	 a11IxNRkDivBLUv1DymNfo5CLWc/cPUgzA7Qy8idC0W0eGuOhQ1DAH32JRA91q6dGY
	 BVxg1bnPaT7wBv9UUxHYtt1oM4cAbbEwX+GxDwupyLSpBglcJCINlkRhktnMObnvFx
	 n0/Vw7ZQYiBC+z602mptQJCJv8Xbi1oKWzamKlA5gCb9WCA3QaNCLFRsHpit3tP5p9
	 M451sfa+0Lh1A==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Date: Fri, 29 Aug 2025 12:07:28 -0700
Message-Id: <20250829190728.60675-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829162212.208258-3-hannes@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 Aug 2025 17:15:27 +0100 Johannes Weiner <hannes@cmpxchg.org> wrote:

> With zswap using zsmalloc directly, there are no more in-tree users of
> this code. Remove it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
[...]
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
[...]
>  When a swap page is passed from swapout to zswap, zswap maintains a mapping
> -of the swap entry, a combination of the swap type and swap offset, to the zpool
> -handle that references that compressed swap page.  This mapping is achieved
> -with a red-black tree per swap type.  The swap offset is the search key for the
> -tree nodes.

Nit.  s/red-black tree/xarray/ ?

Other than that,

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

