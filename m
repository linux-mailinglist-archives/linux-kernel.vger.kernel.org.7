Return-Path: <linux-kernel+bounces-871360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EADC0D086
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038DE189B547
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF102D4814;
	Mon, 27 Oct 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fgIWNLYG"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1E224AEB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562827; cv=none; b=aEFI3m3Ic8M04bmydLVL1QzIJR/m4eRy7Enn2scg8VS1a3zjvoPbYHlnR/rVNSoLknmLaI7HWtezf3G/0HsRIsjbB+FNgwXh3/f+gFxbLCtPkrasVdPClTtK74EdQ17PfvF5itxr7YYiMFFOVBvr1Ez2BgoMaWn3fYvkPrQbKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562827; c=relaxed/simple;
	bh=VI+OL653D/9X85S9/FOuG9K/WIY3pbRzYcqNDWp7r48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bLJUUKqn0Jh7vhHT2YrbCguuF6uxxKdvJtN9lmiqRZ1wMFLPQA1BU3mdAyqKN45917iQZPBtkawD4u5tcHVndzYCsRxkXZQDQsSzxt3wEs375aiEnK5bjZzPquk0mO1mouttvZxi+S1P64IMmEylTTlkXxWfv9z6ZDB1g48LA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fgIWNLYG; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oNtBAjGkhzZkwZC+rIvdBIoH1GOJbNr2aEotHhsyOEY=;
	b=fgIWNLYGFU+OeD9IGg5ucYpOfxSu6tSKhxggzQpspg+C+gC3U9sNQ87UQiPdxTItbottOYai1
	zLT3D2zsDekeKyuNyF4l45N9Kg8gbg2+1zcNey9nm0NHQvE7e5JRGzsjYTqhWtMN8PerVdiAwLy
	vLXlrbEyC5AU9nimVNOCKIg=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cw9WK3Rvzz12LFQ;
	Mon, 27 Oct 2025 18:59:41 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C2AE518048F;
	Mon, 27 Oct 2025 19:00:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 19:00:19 +0800
Message-ID: <346efa9b-5718-4963-842c-649ec2243453@huawei.com>
Date: Mon, 27 Oct 2025 19:00:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Chunhai Guo <guochunhai@vivo.com>, <xiang@kernel.org>, <chao@kernel.org>,
	<zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>, <dhavale@google.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2025/10/27 10:52, Chunhai Guo wrote:
> In the past two years, I have focused on EROFS and contributed features
> including the reserved buffer pool, configurable global buffer pool, and
> the ongoing direct I/O support for compressed data.
> 
> I would like to continue contributing to EROFS and help with code
> reviews. Please CC me on EROFS-related changes.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Acked-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..f482c7631dae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9201,6 +9201,7 @@ R:	Yue Hu <zbestahu@gmail.com>
>   R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>   R:	Sandeep Dhavale <dhavale@google.com>
>   R:	Hongbo Li <lihongbo22@huawei.com>
> +R:	Chunhai Guo <guochunhai@vivo.com>
>   L:	linux-erofs@lists.ozlabs.org
>   S:	Maintained
>   W:	https://erofs.docs.kernel.org

