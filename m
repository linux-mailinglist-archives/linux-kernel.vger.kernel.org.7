Return-Path: <linux-kernel+bounces-804992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B86B482BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B859B189B4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A291F582A;
	Mon,  8 Sep 2025 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e5GL2pol"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206537494
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300651; cv=none; b=gx5MIDfqaFtkplw+/0X7ITlq/01vcsvpHNCdGPzyDTdHZuYH4Vn4JvKneBlMCLgLJqnqO/aL4RKJhKh44FLLFblifFlFqaxc2tuM2r0k4DncCAph0zz4bUYd6gxEZfHMTS19IDmtYI3dML9m5+Tzx6umPbUvb93n3vlgGNm6M48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300651; c=relaxed/simple;
	bh=cmG4H5bIIqmx2EXjALzztbF3bXbjq4/zgEFrqh3XTfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbY5e18zSppDiLT61cqAOCxIui/60H7Y7XQL5Ry6uHUgdIOTn9mL7Z7oRVl2bZDLxIEdv2LMjwnIabeG40yn+sZdNqxBffzRW5ePpp68pCJP+ycqmnlMHS+khACbbKVz8E9Qf6/ATsdn3772SxyRSyHwQiD1mG+7HGTvpoolC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e5GL2pol; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757300640; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ch8Enmtj/KH0mQ+evioqR/00NLP1dhKFZnhe/KioV9E=;
	b=e5GL2polxJlqd/Pa2Foc3PVe4NP0NUBGRd42VTIEdTqOJCWq/Q9lDCra30u0p+N5AP+0kLl//YvgHLXi87evP7SK/+wME3Fp5FaNpD8Grm7S45ZKh1PjhKxlih4bM8COj31CQUR5fEb2LudNPlx6l4C4wJEKqFiDHOa+izVik/I=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnQXU.e_1757300637 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 11:03:58 +0800
Message-ID: <91aa3a4f-5c20-4591-ae2f-bcd57c2533c2@linux.alibaba.com>
Date: Mon, 8 Sep 2025 11:03:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] mm, swap: rename and move some swap cluster
 definition and helpers
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-7-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250905191357.78298-7-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/6 03:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> No feature change, move cluster related definitions and helpers to
> mm/swap.h, also tidy up and add a "swap_" prefix for cluster lock/unlock
> helpers, so they can be used outside of swap files. And while at it, add
> kerneldoc.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


