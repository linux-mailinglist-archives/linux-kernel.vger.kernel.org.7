Return-Path: <linux-kernel+bounces-823428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A2B86665
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0D585D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FC25B31B;
	Thu, 18 Sep 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EF9+DckZ"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57A72628
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219453; cv=none; b=KM6f6hSo+HxNOnWTwl2PuybHJM7BBmUwmxaO6l1I9w/+oDVnlZotiBrWORtIFyX3Lk5mPIFSK7HHKVbio8MP45MBRuy/5hGc4MkFocnXkN8iO4BT2E2vY9gIDU4pmP0d9pMSutnOhyCR+eH4JMq1bIjxLnJiLEIANK6ij8qd9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219453; c=relaxed/simple;
	bh=4u8ciNwVSkPiz1yitBxplO1/dbl+GDsKaR+Vq9xLyO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NgTG/TFK30Tn5X3Dd7tBluIz4zy3ldPv+63PjnYaOasfUL+wrNiAcPeyNwpeUQ/OLoIjeVlG36xsdukpA1sVXXtpqRdaz5LbOWmH9ESM/9uUcRYQG8gfWstCII4dbRzx2H581Zf19sbAxLCwQc/G+ApsAJrVI/sLpqSGuzY8I90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EF9+DckZ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250918181722euoutp027dc05b94b2a2a66ba674fd27ca1ac529~mc0SE9r2-1614816148euoutp026
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:17:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250918181722euoutp027dc05b94b2a2a66ba674fd27ca1ac529~mc0SE9r2-1614816148euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758219442;
	bh=mUpHMi1H9SKYEqgI2B6oz+Pr1gUNoOg+N9gU07EwaSw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EF9+DckZysnQMSTnCSBeWHnJ4jHHqJCMdjZr1KuSBQYozfTyqV2hymH/tHm78WJ8+
	 RUdkQNcn+0ThQ6E3y+jcOEukSUQCbuN+cXoquIQ5Mxf/ucGol50JZ1NxyOXH7ibVRZ
	 zvI5VoOSCvh2s4xFC/Scc8c8R85sRrZHXkIe96kI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250918181721eucas1p1189a5a009d9c52bfbfe2fa0463563721~mc0RaVmCc0700107001eucas1p14;
	Thu, 18 Sep 2025 18:17:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250918181721eusmtip2683f95e8f5ddb5cb6ce123c1c3fe32a8~mc0Qs3JhJ1726017260eusmtip2x;
	Thu, 18 Sep 2025 18:17:20 +0000 (GMT)
Message-ID: <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
Date: Thu, 18 Sep 2025 20:17:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Qinxin Xia <xiaqinxin@huawei.com>, 21cnbao@gmail.com,
	robin.murphy@arm.com, jonathan.cameron@huawei.com
Cc: prime.zeng@huawei.com, fanghao11@huawei.com,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250917011759.2228019-1-xiaqinxin@huawei.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250918181721eucas1p1189a5a009d9c52bfbfe2fa0463563721
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161
X-EPHeader: CA
X-CMS-RootMailID: 20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
	<20250917011759.2228019-1-xiaqinxin@huawei.com>

On 17.09.2025 03:17, Qinxin Xia wrote:
> Since Chenxiang has left HiSilicon, Barry and I will jointly
> maintain this module.
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6206963efbf..512bc67aa02c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7218,7 +7218,8 @@ F:	include/linux/dmaengine.h
>   F:	include/linux/of_dma.h
>   
>   DMA MAPPING BENCHMARK
> -M:	Xiang Chen <chenxiang66@hisilicon.com>
> +M:	Barry Song <baohua@kernel.org>
> +M:	Qinxin Xia <xiaqinxin@huawei.com>
>   L:	iommu@lists.linux.dev
>   F:	kernel/dma/map_benchmark.c
>   F:	tools/testing/selftests/dma/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


