Return-Path: <linux-kernel+bounces-847381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE55BCAADE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96563AD40A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F92566E2;
	Thu,  9 Oct 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6A7cs0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410911E0E1F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037875; cv=none; b=rv8Mw0hUPh2ZAaU60b8xWQ8pgv/ca6Bn6HDYfLbssRdBQG10GoGGJJnyI2g6DUY32oXVzr1hfEXPSEc0n9Uqjp+Xxao6KAPWqs0TxfAceofy5CAvx+HLKWh5O0h6JzlEQcmv0gKnXujMdcWAcaUaZ18klNuvJhC+Ryh7MV1IaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037875; c=relaxed/simple;
	bh=R7UMgm5DhR2eirTXtSm8DLpDeVeW5tIj/PilGVHqk+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgSFcA5tez3iZmEthbJCMQBI+5IPz4cIUiTibq+dQvlbRPOknIt4qXDzEcSKbfmK/u7jq/VqDPOx4mnMo+DTht6JHYErAvu2OkwHurrSzca0/BdzNevRum3oxMRepfbFta/KLs0w8AgysdmW44SMkHdRQAsvhTSoS2AFlxqJGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6A7cs0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9663C4CEE7;
	Thu,  9 Oct 2025 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760037874;
	bh=R7UMgm5DhR2eirTXtSm8DLpDeVeW5tIj/PilGVHqk+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6A7cs0s3J8ts2bx4mCJCxa4hzcNkg26elMzG7vV5kvuxpFQs8MLO+81GrRw32lLP
	 veXWheAK7H4A8HoxVgMq2nbZEqPoRnZsNST4zfgHM+hyrSZUBQ4cYhn4pRg7GsGkl1
	 HrYzG6TFTh7WBNeapiE5KiC18YBMIurgCb/afeD3ohLqGVB8lxl/G7JYKcXV82YKkW
	 9neydoNB/d3jfvGzU3oLiGjOIj17wMqcox+AN/gwVpC4gRfNPLTtP/KLp7CeAb9JUJ
	 JY3kzT4hCfVz8AYIun17ngtITZPBHhbidZsIfGKozX656RjJ6SQOkKh3maYulmYk62
	 nZfpGBLoE0AxA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Thu,  9 Oct 2025 12:24:29 -0700
Message-Id: <20251009192429.57910-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009191149.57652-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  9 Oct 2025 12:11:49 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Usama,
> 
> On Thu,  9 Oct 2025 18:24:30 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
> > This is a common condition used to skip operations that cannot
> > be performed on gigantic pages when runtime support is disabled.
> > This helper is introduced as the condition will exist even more
> > when allowing "overcommit" of gigantic hugepages.
> > No functional change intended with this patch.
[...] 
> It seems the new helper could be used for three more cases.
> 
> On mm-new:
> 
>     $ git grep gigantic_page_runtime_supported mm/hugetlb.c
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:           if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
> After applying this patch on top of mm-new:
> 
>     $ git grep gigantic_page_runtime_supported mm/hugetlb.c
>     mm/hugetlb.c:   return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
> I'm curious if you are planning to do the conversion later, or there is a
> reason why this patch is keeping those as is but I'm missing.

Ah, seems like that's because the v1 [1] of this series is already merged into
mm-new.

Please ignore the above question unless I'm wrong.

[1] https://patch.msgid.link/20251009172433.4158118-1-usamaarif642@gmail.com


Thanks,
SJ

[...]

