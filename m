Return-Path: <linux-kernel+bounces-875560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36433C19422
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2885F1C82CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1831DDBB;
	Wed, 29 Oct 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqz4r1XN"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568B31AF25
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728180; cv=none; b=L1AeF/lZnyr61QeReLUNy9CKCOtc4jLinVafYlxmWcNLzcRBWNhkX+25wZC/yyPWGIzukaK0P13IGblg12bdnisjDKYL1PiBqqEeswmfzXJzsPrkfw5pAMm1MKvnAffD4WOoRUbvoglb5f/gpeyd0MQ7S9AAxs9QD7Fw5z9wRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728180; c=relaxed/simple;
	bh=gQngBN1oIrSPeuN/8JnpHtlVha9EssQp9IxOyxDc+3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TVxZhwkJ0J3h8pEBHfae/4OsD0jUaoncicDsjx4VQIwt+eLK2+AzvOoATI4Wk+YcthN1Aw3I7TG6c8Vn52EUj+ggc0VnkTLjKHjRVOBqibj0e23+XeRQp5dftFVVZV8z8LonMLyjTAFZ2UNWVDjbS3g6s9WQ0jhYwEFdGZDeg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aqz4r1XN; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251029085615euoutp0115d71730b9e344ce9f1da8eb046731c0~y6nD1OS0X2205722057euoutp01n
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:56:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251029085615euoutp0115d71730b9e344ce9f1da8eb046731c0~y6nD1OS0X2205722057euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761728175;
	bh=ClIpAJTmFJcpN6hK7oA/d9mLfJjWs3F7WhiMC6Odbc4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aqz4r1XNYNG46IWG6mFYMkYuTHVAX2trlLDCF6SJkvYPG/shEXUg9ZFDK3KpxuGTU
	 HpAGoCiywlrCU20pvFGeFfT5+cjHXDfOBlzg8X33J2vK8tpfnmpHQF7s5W20aC9Ruf
	 CfSDTg+6aYyaEB6sCNw4i0e2u6Qm42GzFHiLhimk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251029085614eucas1p2287556f3254027017c68c5a43debd6ec~y6nDg3N9t1017510175eucas1p2b;
	Wed, 29 Oct 2025 08:56:14 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251029085613eusmtip2176a052b788873d52ee4cae07add6963~y6nCLStyq2009420094eusmtip2Q;
	Wed, 29 Oct 2025 08:56:13 +0000 (GMT)
Message-ID: <bf8c45f6-f7f8-49aa-8daf-7428751f463e@samsung.com>
Date: Wed, 29 Oct 2025 09:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 2/2] tools/dma: move dma_map_benchmark from selftests
 to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>, 21cnbao@gmail.com,
	robin.murphy@arm.com
Cc: prime.zeng@huawei.com, fanghao11@huawei.com,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
	Barry Song <baohua@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251028120900.2265511-3-xiaqinxin@huawei.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251029085614eucas1p2287556f3254027017c68c5a43debd6ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028120926eucas1p298889436d08a2523e207267a8dad9eca
X-EPHeader: CA
X-CMS-RootMailID: 20251028120926eucas1p298889436d08a2523e207267a8dad9eca
References: <20251028120900.2265511-1-xiaqinxin@huawei.com>
	<CGME20251028120926eucas1p298889436d08a2523e207267a8dad9eca@eucas1p2.samsung.com>
	<20251028120900.2265511-3-xiaqinxin@huawei.com>

On 28.10.2025 13:09, Qinxin Xia wrote:
> dma_map_benchmark is a standalone developer tool rather than an
> automated selftest. It has no pass/fail criteria, expects manual
> invocation, and is built as a normal userspace binary. Move it to
> tools/dma/ and add a minimal Makefile.
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Thanks, applied to dma-mapping-for-next branch.

> ---
>   include/{ => uapi}/linux/map_benchmark.h      | 13 +++--
>   kernel/dma/map_benchmark.c                    |  2 +-
>   tools/Makefile                                | 13 +++--
>   tools/dma/.gitignore                          |  3 +
>   tools/dma/Makefile                            | 55 +++++++++++++++++++
>   tools/{testing/selftests => }/dma/config      |  0
>   .../selftests => }/dma/dma_map_benchmark.c    |  1 -
>   tools/testing/selftests/dma/Makefile          |  7 ---
>   8 files changed, 74 insertions(+), 20 deletions(-)
>   rename include/{ => uapi}/linux/map_benchmark.h (80%)
>   create mode 100644 tools/dma/.gitignore
>   create mode 100644 tools/dma/Makefile
>   rename tools/{testing/selftests => }/dma/config (100%)
>   rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (99%)
>   delete mode 100644 tools/testing/selftests/dma/Makefile

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


