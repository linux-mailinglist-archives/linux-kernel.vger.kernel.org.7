Return-Path: <linux-kernel+bounces-764323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4286B22194
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F301886EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64032E7F3B;
	Tue, 12 Aug 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iFIhx3q7"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E92E7F33
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987728; cv=none; b=ZLHQXcQTDlmu3PEJqd02F9IVj4rsmpPriyU4AT5VAXiZU8razYXgYqyEzAr24dRJjCi3wT1mTIU2bENn40DVCMVocGtJoLIddUgYbeVdaPzNi/OBe+kJ9odUsg7tyhZX2VMC+j/LWyKqrLgbwA9ZNQSBfDTG/UIr4+KO3PlCz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987728; c=relaxed/simple;
	bh=WwpEBk5j928XDlaW3MQpspA17zNKZTuUg+N3L2P5Q8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGijoKp4AKmJpV1vdzFzeeC+E8LxkfSn8WxrtMIXMhh768OPQJ1TNlgMD52hQjxkHs8UZkDQoaTdCTBqSRVsYga50Y+Te+IO14QFelYWBzAHYeavoQ/CCDQDY7q/yKiqg8q4j2Fl8nmpoP311eUMGlhUjf75JoBpiHmQXuY5V9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iFIhx3q7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754987717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E5UCujp6LpemgWNTAHmJG6DMzWeh3JLe/fdx68Wjim8=;
	b=iFIhx3q7/TOwY80SWB6gCTVw7uRUReuL/v75ogGJJF1dnPDCWUUuRM7CFL0876Zz+T1jfjeMhjZ4qsJsz7amC+/J6jUoGG9jQYbFB80FWwI1FgB4uS4YvskDq/d911sPZsbiIaF61ikUUuDaavFC9b6TqEZJgiFkYD2tgVscjVg=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlaOJEW_1754987715 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Aug 2025 16:35:15 +0800
Message-ID: <e6898dca-d6c6-465c-a373-8298858839ab@linux.alibaba.com>
Date: Tue, 12 Aug 2025 16:35:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: shmem: fix the strategy for the tmpfs 'huge='
 options
To: akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/30 16:14, Baolin Wang wrote:
> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
> we have extended tmpfs to allow any sized large folios, rather than just
> PMD-sized large folios.
> 
> The strategy discussed previously was:
> 
> "
> Considering that tmpfs already has the 'huge=' option to control the
> PMD-sized large folios allocation, we can extend the 'huge=' option to
> allow any sized large folios.  The semantics of the 'huge=' mount option
> are:
> 
>      huge=never: no any sized large folios
>      huge=always: any sized large folios
>      huge=within_size: like 'always' but respect the i_size
>      huge=advise: like 'always' if requested with madvise()
> 
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
> allocate the PMD-sized huge folios if huge=always/within_size/advise is
> set.
> 
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
> semantics.  The 'deny' can disable any sized large folios for tmpfs, while
> the 'force' can enable PMD sized large folios for tmpfs.
> "
> 
> This means that when tmpfs is mounted with 'huge=always' or 'huge=within_size',
> tmpfs will allow getting a highest order hint based on the size of write() and
> fallocate() paths. It will then try each allowable large order, rather than
> continually attempting to allocate PMD-sized large folios as before.
> 
> However, this might break some user scenarios for those who want to use
> PMD-sized large folios, such as the i915 driver which did not supply a write
> size hint when allocating shmem [1].
> 
> Moreover, Hugh also complained that this will cause a regression in userspace
> with 'huge=always' or 'huge=within_size'.
> 
> So, let's revisit the strategy for tmpfs large page allocation. A simple fix
> would be to always try PMD-sized large folios first, and if that fails, fall
> back to smaller large folios. However, this approach differs from the strategy
> for large folio allocation used by other file systems. Is this acceptable?
> 
> [1] https://lore.kernel.org/lkml/0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com/
> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Note: this is just an RFC patch. I would like to hear others' opinions or
> see if there is a better way to address Hugh's concern.
> ---

Hi Hugh,

If we use this approach to fix the PMD large folio regression, should we 
also change tmpfs mmap() to allow allocating any sized large folios, but 
always try to allocate PMD-sized large folios first? What do you think? 
Thanks.

