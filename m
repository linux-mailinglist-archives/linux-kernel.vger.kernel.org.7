Return-Path: <linux-kernel+bounces-841042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84DBB604F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8131AE00A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB48221710;
	Fri,  3 Oct 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rNU5cVhm"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296121254D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474789; cv=none; b=q2IXV5YTM3fV0dKsyfU+rGq1L1dtiPr/Y/H8T/Vxmb5OXKME1g2cFu576T3nOdlJnRV7KpTqhe++tIS5uhzpugkQLVay1vVdxOtq0ixaqYbPGNgCRy7ooGW5V+bZNq2GKeDM/f9tSTz6RpA5ZFtLdWUC+flnX7TScGKXsKbQ2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474789; c=relaxed/simple;
	bh=pxq4030zou4KskYzMAlEXeJqDpWVxl92uqfucQTX1qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=X69wWhKQnRDAOt8ehhETps09WRXJy7kYnEoykZHBSZ8mCFUI6pIsQ9/mbJgXpOTSo0xNzmNIxgFVksiOfqD8VJIpEauZ11rxOL04rka4IK6ieD0QyDBeulQtcWbeDWMZCqdv6xZHp/H/2AQiC+eAiPSSoCK47FpCJ2ebMjFRpKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rNU5cVhm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251003065939euoutp0175f07789068177efcd61897019177d4f~q6P1pLJI60644906449euoutp012
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251003065939euoutp0175f07789068177efcd61897019177d4f~q6P1pLJI60644906449euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759474779;
	bh=WB9sbfpLecnMxMoiDerCoUS7521vhN66oFyAsMbTO/0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rNU5cVhmOZDMaP/OVCGCAd+ZxwmVqRRGG57bXmlVB/vN1it679D39JUs4rj/uD8O9
	 LGrFX2hKQxMK57173qZPyqhKP8sw40gFWvNADtmbVOOJhgVSnzve3te5S9Q11LX87K
	 Rz18lpX5u3vdLqOFqzdKcwE0nJDGMax+tDSmMxBI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251003065939eucas1p2a570a631290b2053af4bfee78ca93977~q6P1Z1Cy11393413934eucas1p25;
	Fri,  3 Oct 2025 06:59:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251003065937eusmtip1440172238527b922b950b45020a53526~q6P0IH4u62724027240eusmtip1D;
	Fri,  3 Oct 2025 06:59:37 +0000 (GMT)
Message-ID: <c921d3d4-3f15-4b46-bd6c-2f48b2747e60@samsung.com>
Date: Fri, 3 Oct 2025 08:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] kmsan: fix kmsan_handle_dma() to avoid false positives
To: Shigeru Yoshida <syoshida@redhat.com>, glider@google.com,
	elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
	jgg@ziepe.ca, leon@kernel.org
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251002051024.3096061-1-syoshida@redhat.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251003065939eucas1p2a570a631290b2053af4bfee78ca93977
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251002051101eucas1p250c65f775d8e64053ee7e009142c89c7
X-EPHeader: CA
X-CMS-RootMailID: 20251002051101eucas1p250c65f775d8e64053ee7e009142c89c7
References: <CGME20251002051101eucas1p250c65f775d8e64053ee7e009142c89c7@eucas1p2.samsung.com>
	<20251002051024.3096061-1-syoshida@redhat.com>

On 02.10.2025 07:10, Shigeru Yoshida wrote:
> KMSAN reports an uninitialized value issue in dma_map_phys()[1].  This
> is a false positive caused by the way the virtual address is handled
> in kmsan_handle_dma().  Fix it by translating the physical address to
> a virtual address using phys_to_virt().
>
> [1]
> BUG: KMSAN: uninit-value in dma_map_phys+0xdc5/0x1060
>   dma_map_phys+0xdc5/0x1060
>   dma_map_page_attrs+0xcf/0x130
>   e1000_xmit_frame+0x3c51/0x78f0
>   dev_hard_start_xmit+0x22f/0xa30
>   sch_direct_xmit+0x3b2/0xcf0
>   __dev_queue_xmit+0x3588/0x5e60
>   neigh_resolve_output+0x9c5/0xaf0
>   ip6_finish_output2+0x24e0/0x2d30
>   ip6_finish_output+0x903/0x10d0
>   ip6_output+0x331/0x600
>   mld_sendpack+0xb4a/0x1770
>   mld_ifc_work+0x1328/0x19b0
>   process_scheduled_works+0xb91/0x1d80
>   worker_thread+0xedf/0x1590
>   kthread+0xd5c/0xf00
>   ret_from_fork+0x1f5/0x4c0
>   ret_from_fork_asm+0x1a/0x30
>
> Uninit was created at:
>   __kmalloc_cache_noprof+0x8f5/0x16b0
>   syslog_print+0x9a/0xef0
>   do_syslog+0x849/0xfe0
>   __x64_sys_syslog+0x97/0x100
>   x64_sys_call+0x3cf8/0x3e30
>   do_syscall_64+0xd9/0xfa0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Bytes 0-89 of 90 are uninitialized
> Memory access of size 90 starts at ffff8880367ed000
>
> CPU: 1 UID: 0 PID: 1552 Comm: kworker/1:2 Not tainted 6.17.0-next-20250929 #26 PREEMPT(none)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> Workqueue: mld mld_ifc_work
>
> Fixes: 6eb1e769b2c1 ("kmsan: convert kmsan_handle_dma to use physical addresses")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Applied to dma-mapping-for-next (for v6.18-rc1) branch. Thanks!

> ---
> The hash in the "Fixes" tag comes from the linux-next tree
> (next-20250929), as it has not yet been included in the mainline tree.
> ---
>   mm/kmsan/hooks.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 90bee565b9bc..2cee59d89c80 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -339,13 +339,12 @@ static void kmsan_handle_dma_page(const void *addr, size_t size,
>   void kmsan_handle_dma(phys_addr_t phys, size_t size,
>   		      enum dma_data_direction dir)
>   {
> -	struct page *page = phys_to_page(phys);
>   	u64 page_offset, to_go;
>   	void *addr;
>   
>   	if (PhysHighMem(phys))
>   		return;
> -	addr = page_to_virt(page);
> +	addr = phys_to_virt(phys);
>   	/*
>   	 * The kernel may occasionally give us adjacent DMA pages not belonging
>   	 * to the same allocation. Process them separately to avoid triggering

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


