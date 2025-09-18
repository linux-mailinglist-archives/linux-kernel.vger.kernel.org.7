Return-Path: <linux-kernel+bounces-767062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E54B24E89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78AEC7B39F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58B287256;
	Wed, 13 Aug 2025 15:56:01 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3227B50F;
	Wed, 13 Aug 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100561; cv=none; b=kSxmw1XRbBekRXPPpSpKMIurJXkhMrFRwcnYhJ/l49bVxbdTLxJ3cAdNFBObmj5J6dCBvmKLZznhmMFZ1rShNEcjJrIdwNaBCDglgDPAyrrAPosDX2fNhzkGnnr97Xko58kW4jMxD4TBsCXYTntdxY9YBW3sKzyit1HwcDLAlhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100561; c=relaxed/simple;
	bh=xzBNb/50mbyLTPm5Suj2K7W5uV4Vxpn9qpduAfvNPgI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZt0Su4r5L7vUPZf51KTIEElFwAILS/K0ujmla+xivP5KAjcqY6AKwceet5Aq7Q/+U/PIU3Vz5R+eRuRvJ5XxPszmohpTSc4QdyEo9R0BfRIniceP3Gnpw1YHtGbNAJ89M+2TAQaNhnHx5VE4pzGZzuBCzzrMb3QjSILSysnb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c2CbT6hPTz6GFlc;
	Wed, 13 Aug 2025 23:53:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DB3361404D8;
	Wed, 13 Aug 2025 23:55:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 17:55:55 +0200
Date: Wed, 13 Aug 2025 16:55:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Neeraj Kumar <s.neeraj@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
	<a.manzanares@samsung.com>, <vishak.g@samsung.com>, <neeraj.kernel@gmail.com>
Subject: Re: [PATCH V2 12/20] nvdimm/namespace_label: Skip region label
 during namespace creation
Message-ID: <20250813165554.00002dea@huawei.com>
In-Reply-To: <20250730121209.303202-13-s.neeraj@samsung.com>
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121238epcas5p212dcce5cc5713173913ee154d5098a2c@epcas5p2.samsung.com>
	<20250730121209.303202-13-s.neeraj@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 17:42:01 +0530
Neeraj Kumar <s.neeraj@samsung.com> wrote:

> During namespace creation skip presence of region label if present.

Confusing description.  What does skipping presence mean?
Reword.

During namespace creation, skip any region labels found.


> Also preserve region label into labels list if present.
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 50 +++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index e5c2f78ca7dd..8edd26407939 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1985,6 +1985,10 @@ static struct device **scan_labels(struct nd_region *nd_region)
>  		if (!lsa_label)
>  			continue;
>  
> +		/* skip region labels if present */

This is kind of obvious comment. I'd drop it.

> +		if (is_region_label(ndd, lsa_label))
> +			continue;
> +
>  		nd_label = &lsa_label->ns_label;
>  


