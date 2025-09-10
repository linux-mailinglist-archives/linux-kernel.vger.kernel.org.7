Return-Path: <linux-kernel+bounces-810202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84426B5172F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B14C1C26ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66A1A0BE0;
	Wed, 10 Sep 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="NcWVxE0H"
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0131B833
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508311; cv=none; b=ViSCo3hRKARray3N0X+BvnzRVxdfv4PNgcKsSFbP5Y+eENTK7A0+htIO5WiwEOFYfl8ifTHKhYxxNpSIbPpImlY6VrWcf8CHqhkkDx7N4lVNrjru895fRzKSvQpwPxXEp836rcHradzTNIR1q1blZqpwmnZQqxxQPKjVhaN1Wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508311; c=relaxed/simple;
	bh=friDOi+j2o6hQPANR07L1IPeAnSMQyso3EV72HcrS7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNX+1E3piNv+U28FF9YfkuIk8Tib5132EWB42N5eQ6nI9/DfvuRf/iIFsoYEE8OQ5xc/Wjj7ZTMdImizqmjbvlYZTZ8tSAbvyYmYQ6b3tyAg4tM8RqB6hNnAXdOjEtlaF6WAhJLC4csXj397MdZPdJHu58WmdyOxeFdsdoYJf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=NcWVxE0H; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757508306;
	bh=wrI27L50Krmhj1fPADGXvtbzVUmtq03K20RQqcV8sng=;
	h=From:Subject:Date:Message-ID;
	b=NcWVxE0H6KMVQXXNfOsaZA3Ra6YyOM5y6LITw3sp1BkAHTLN8jdVQPPb3ShBQ670T
	 PKvGWyw9m8a5B6StteXoFqLbKljAQWVccAB+/n7PphB0Gth8eFD909efvMzTy/2JxY
	 jHMNINst0oszr9y10uA0Kt64RUV+lyCTKunhDfGA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68C172CB00004803; Wed, 10 Sep 2025 20:45:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8252306291757
X-SMAIL-UIID: 7D4C23C301F749E79BF9F5BE7AA477E1-20250910-204501-1
From: Hillf Danton <hdanton@sina.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Excessive page cache occupies DMA32 memory
Date: Wed, 10 Sep 2025 20:44:49 +0800
Message-ID: <20250910124452.6747-1-hdanton@sina.com>
In-Reply-To: <9dc9e324-4a39-43d0-8716-be325fae2247@collabora.com>
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com> <aH51JnZ8ZAqZ6N5w@casper.infradead.org> <2025072238-unplanted-movable-7dfb@gregkh> <91fc0c41-6d25-4f60-9de3-23d440fc8e00@collabora.com> <2025072234-cork-unadvised-24d3@gregkh> <c93b34ca-1abf-4db0-90f9-3802ac02c25a@arm.com> <bdd1efa8-691c-4e84-8977-cdfd48e7363a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 16:23:37 +0500 Muhammad Usama Anjum wrote:
> >>>> For example, in the mhi driver, the failure is triggered when the
> >>>> MHI's st_worker gets scheduled-in at resume.
> >>>>
> >>>> mhi_pm_st_worker()
> >>>> -> mhi_fw_load_handler()
> >>>>     -> mhi_load_image_bhi()
> >>>>        -> mhi_alloc_bhi_buffer()
> >>>>           -> dma_alloc_coherent(GFP_KERNEL) returns -ENOMEM
> >>>
> >>> And what is the exact size you are asking for here?
> > 
> > 512 KB
> > 
Any order above PAGE_ALLOC_COSTLY_ORDER is not guaranteed in 90+% cases.
Nor is it DMA32 specific.

> Another update:
> This issue reproduces on v6.11.11. To summarize, we're unable to reproduce
> this bug in the v6.15.9. We wanted to do bisection and find out which kernel
> change has caused/fixed it, but it's too difficult considering the complex
> reproducer setup (Tekken 8 Demo game + page cache stress). We don't want to
> spend more time on something that is very hard to reproduce and is already
> fixed in later versions.
> 
> My debugging has shown in v6.15.9 that the allocation succeeds under the same
> constraints of power management. My hunch is that somehow the dma memory

Can you try again without the JW work [1] applied?

> doesn't get occupied to the extent that dma allocations start to fail at
> resume in v6.15.9.
> 
> ---
> Thanks,
> Usama
>
[1] Subject: [PATCH 0/5] mm: reliable huge page allocator
https://lore.kernel.org/all/20250313210647.1314586-1-hannes@cmpxchg.org/

