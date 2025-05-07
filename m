Return-Path: <linux-kernel+bounces-637056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D5AAD40B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 05:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D533B5046
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 03:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839B1B6CE5;
	Wed,  7 May 2025 03:22:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4201AF0B4;
	Wed,  7 May 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746588159; cv=none; b=TcAtymeF6rhrZBOwAfoLPwFP+GMRu1FXyQU5KnRUbCOVjLTiNlAGFNRBahEoG1YgcOOwUFdyH1H9rmhT2IZ0J2o0rDs48MA0FYPDTEpbr0gzkda0YFlZTzKdEKP9eqvGwU5ym/FW0Rj+yFCJt5GMmrO269JHHt/D50unBBUCbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746588159; c=relaxed/simple;
	bh=LxwMWPg+PFWNBv6WML1H6Mcw4NIhuvm/FTM1bIYofF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qcfHViZGtE9XARs+Al5/nr9F8HbuqjqQor6b1RllRxYmWT3/dRUnhDzfHk2CoHK/yqFuXDrSZ8irPLTGQiqFwKXlhb4d5pO+KhToX/TB8wZSU2XZ2ySe6i+LxVvHB2MMLWhOpayeE4wG/2eumxpep85VT/R2Vud73K9YI349qGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZsgX72k43z1d023;
	Wed,  7 May 2025 11:21:11 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B244180B43;
	Wed,  7 May 2025 11:22:28 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 11:22:27 +0800
Message-ID: <8a16ca96-8624-358d-39d8-e17fbf60a1b1@hisilicon.com>
Date: Wed, 7 May 2025 11:22:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/hns: fix trace TRACE_INCLUDE_PATH
Content-Language: en-US
To: Huiwen He <hehuiwen@kylinos.cn>, <tangchengchang@huawei.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250507030433.599021-1-hehuiwen@kylinos.cn>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250507030433.599021-1-hehuiwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/5/7 11:04, Huiwen He wrote:
> TRACE_INCLUDE_PATH should be a path relative to define_trace.h, not the
> file including it. (See the comment in include/trace/define_trace.h.)
> 
> Fixes build error found with CONFIG_INFINIBAND_HNS_HIP08=m:
>   CC [M]  drivers/infiniband/hw/hns/hns_roce_hw_v2.o
> In file included from drivers/infiniband/hw/hns/hns_roce_trace.h:213,
>                  from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:53:
> ./include/trace/define_trace.h:110:42: fatal error: ./hns_roce_trace.h: No such file or directory
>   110 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> 
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
>  drivers/infiniband/hw/hns/hns_roce_trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infiniband/hw/hns/hns_roce_trace.h
> index 23cbdbaeffaa..19bd3c0eec47 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_trace.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
> @@ -209,5 +209,5 @@ DEFINE_EVENT(cmdq, hns_cmdq_resp,
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE hns_roce_trace
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_PATH ../../drivers/infiniband/hw/hns
>  #include <trace/define_trace.h>

We've found this bug and decided to fix it by modifying Makefile, please see:
https://lore.kernel.org/linux-next/b7dd4dda-37d8-47e4-8d78-b6585be21cfd@paulmck-laptop/T/#t

Thanks anyway!

Junxian

