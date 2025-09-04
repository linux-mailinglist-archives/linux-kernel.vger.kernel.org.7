Return-Path: <linux-kernel+bounces-799987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB288B43210
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161C57C27A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF424E016;
	Thu,  4 Sep 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zw3zRPkO"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98834248F4F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966291; cv=none; b=SebjiONv6rAdoa3bhq7xJLQyztzrcy0w4QbuohN0fTQL/J+O4AVDa+yb3x1y+LvZqqOWZNAuAms+A+nwGuRlc3T34cuWj5eZ+x2L8MShV3atXKo8m3UlterhnKT7UXKqBGCaXqVYGV8TxDQQg2OOYHEo/aMSB/T8CMz2FjlOyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966291; c=relaxed/simple;
	bh=/TpJ9ooFtbzm4iwjnf7q41q4BGoczl8zNAtRuRyAcoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArfOJLLGy1TJ1rRmEOZ9Y/y2P3qXkEMC/PrzS+xt+FZD3xlYKydsCwtRKdRr2180djhqdFrrzoMXMOWAAIO9b9oDZbmxGGSrx1NA74NoBtuXm3VEG+GDo5aIFeQSa6jHSsnuNyrY9iGPtUKV9jV+AQOW9pI15S4lVh3zCKFRR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zw3zRPkO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756966286; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pMr2AJyZ2cwZjMK+R2zzArtB3tmjy+ONY5ZQPKXfLA8=;
	b=Zw3zRPkO1axEGr8w1PtyxGjhG34U26F9uvpVsF/iQuxX5UZ7OfEahljVnMaYzKpcUp2YobffEfbLUB2gO5d1abRfkJHx4LgO1WgNWvDtisz4n+dCdrxcF0hL2DPSwLrg7cdNgz3PI6Hgqaq8tKAe0tvHtpUOd9ugDC6jbJDBlww=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnERfV8_1756966283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 14:11:24 +0800
Message-ID: <8cf7a0c6-be15-4935-827b-a6000395d545@linux.alibaba.com>
Date: Thu, 4 Sep 2025 14:11:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 kas@kernel.org, willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250903054635.19949-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/3 13:46, Dev Jain wrote:
> Currently khugepaged does not collapse a region which does not have a
> single writable page. This is wasteful since non-writable VMAs mapped by
> the application won't benefit from THP collapse. Therefore, remove this
> restriction and allow khugepaged to collapse a VMA with arbitrary
> protections.
> 
> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
> non-writable VMA, and this restriction is nowhere to be found on the
> manpage - the restriction itself sounds wrong to me since the user knows
> the protection of the memory it has mapped, so collapsing read-only
> memory via madvise() should be a choice of the user which shouldn't
> be overriden by the kernel.
> 
> On an arm64 machine, an average of 5% improvement is seen on some mmtests
> benchmarks, particularly hackbench, with a maximum improvement of 12%.

I also wondered about the writable check before, but never dug into the 
history. The result looks nice.

> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

