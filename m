Return-Path: <linux-kernel+bounces-613630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB55A95F12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121347A83C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DFE2367B7;
	Tue, 22 Apr 2025 07:14:38 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299622F392;
	Tue, 22 Apr 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306077; cv=none; b=NM7NLs3vLX7wAXhAEUQx9iC3mzPhjHjbg3rZaGOUhskjEvoqXYNserV3IZDBqtGsEoZRlwf5b+n3FOhG7cQ+o3KUxsNNAxnJdyvDWyi2X0Jtk+HD3Jdg4X/dNuZVYkZ82X2WC9xhq3ZskPxA5TLA6f17bB6XMPtH8Nmq4QvXN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306077; c=relaxed/simple;
	bh=Q6g68voosX5+UzacaSsV735apj8dv4dfJg2JgQki8j4=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PEcH5a28IE3hF3SGG3GB/L0MwkFUzech7Tq8upKebbn57YiYmRcvwCfXoc5Rco048Yhwz8RS2ry4vwVB17kzPYEaUaIzYtu0qzHgZH1P3pd4eoFaYidkrWOARQIlHe50KsSPT5fqhXm+shRZXuFJxdAcvh0cczw610a4aCB8JWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZhYPv6dG7z1j5xV;
	Tue, 22 Apr 2025 15:14:11 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 92074140278;
	Tue, 22 Apr 2025 15:14:26 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 22 Apr 2025 15:14:25 +0800
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] perf vendor events arm64: Fill up Desc field for
 Hisi hip08 hha pmu
To: Junhao He <hejunhao3@huawei.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>,
	<leo.yan@arm.com>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<mike.leach@linaro.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
 <20250418070812.3771441-2-hejunhao3@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <976fceb4-f0fd-eae4-066c-6b77e5adcea9@huawei.com>
Date: Tue, 22 Apr 2025 15:14:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418070812.3771441-2-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/4/18 15:08, Junhao He wrote:
> In the same PMU, when some JSON events have the "BriefDescription" field
> populated while others do not, the cmp_sevent() function will split these
> two types of events into separate groups. As a result, when using perf
> list to display events, the two types of events cannot be grouped together
> in the output.
> 
> before patch:
>  $ perf list pmu
>  ...
>  uncore hha:
>    hisi_sccl1_hha2/sdir-hit/
>    hisi_sccl1_hha2/sdir-lookup/
>  ...
>  uncore hha:
>    edir-hit
>       [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
>  ...
> 
> after patch:
>  $ perf list pmu
>  ...
>  uncore hha:
>    edir-hit
>       [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
>    sdir-hit
>       [Count of The number of HHA S-Dir hit operations. Unit: hisi_sccl1_hha2]
>    sdir-lookup
>       [Count of the number of HHA S-Dir lookup operations. Unit: hisi_sccl1_hha2]
>  ...
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  .../arch/arm64/hisilicon/hip08/uncore-hha.json   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> index 9a7ec7af2060..b52f056d0255 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> @@ -30,15 +30,18 @@
>     {
>  	    "ConfigCode": "0x4",
>  	    "EventName": "rx_wbi",
> +	    "BriefDescription": "Count of the number of WriteBackI operations that HHA has received",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x5",
>  	    "EventName": "rx_wbip",
> +	    "BriefDescription": "Count of the number of WriteBackIPtl operations that HHA has received",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x11",
> +	    "BriefDescription": "Count of the number of WriteThruIStash operations that HHA has received",
>  	    "EventName": "rx_wtistash",
>  	    "Unit": "hisi_sccl,hha"
>     },
> @@ -87,66 +90,79 @@
>     {
>  	    "ConfigCode": "0x23",
>  	    "EventName": "bi_num",
> +	    "BriefDescription": "Count of the number of HHA BackInvalid operations",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x32",
>  	    "EventName": "mediated_num",
> +	    "BriefDescription": "Count of the number of Mediated operations that the HHA has forwarded",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x33",
>  	    "EventName": "tx_snp_num",
> +	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x34",
>  	    "EventName": "tx_snp_outer",
> +	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent to another socket",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x35",
>  	    "EventName": "tx_snp_ccix",
> +	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent to CCIX",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x38",
>  	    "EventName": "rx_snprspdata",
> +	    "BriefDescription": "Count of the number of SnprspData flit operations that HHA has received",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x3c",
>  	    "EventName": "rx_snprsp_outer",
> +	    "BriefDescription": "Count of the number of SnprspData operations that HHA has received from another socket",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x40",
>  	    "EventName": "sdir-lookup",
> +	    "BriefDescription": "Count of the number of HHA S-Dir lookup operations",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x41",
>  	    "EventName": "edir-lookup",
> +	    "BriefDescription": "Count of the number of HHA E-Dir lookup operations",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x42",
>  	    "EventName": "sdir-hit",
> +	    "BriefDescription": "Count of the number of HHA S-Dir hit operations",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x43",
>  	    "EventName": "edir-hit",
> +	    "BriefDescription": "Count of the number of HHA E-Dir hit operations",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x4c",
>  	    "EventName": "sdir-home-migrate",
> +	    "BriefDescription": "Count of the number of HHA S-Dir read home migrate operations",
>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x4d",
>  	    "EventName": "edir-home-migrate",
> +	    "BriefDescription": "Count of the number of HHA E-Dir read home migrate operations",
>  	    "Unit": "hisi_sccl,hha"
>     }
>  ]
> 

