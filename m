Return-Path: <linux-kernel+bounces-704531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C6AE9E98
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 15:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D118517E5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7372E62C0;
	Thu, 26 Jun 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r6HauxlS"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F528FAB7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944188; cv=none; b=jgkrLdGrcXkjdBIYT1cOtIfJPHAo9I2PHV53IlkaFhHKboT25ZIRF03Ob+roMAswFBPbdmd+vj55FMk7bLt+3QbWZ1jCHe2MkGEV+pwsnxT7CdX5uL5IHM6C/ESbfDEs+FOdGhIZxG64HWv/ibl7QvEYlc3jcg6wncFsMH0yT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944188; c=relaxed/simple;
	bh=X1j454m49N8w0CJ0gNUlBnCr4cCL1tJGAsgTDgxPxZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=MK4V3Ox6IKVQWeT4yBsvLcYdhU1oWy01As71OXJT/rq6BW11sbdClz7F51fRkIF3sbGs88029JBAn+fuWNjUDHmkdvZhDaHTGbkU+p7unkunVrgHy6NOpbOF9kOk+loM18QyRbPYBMTrB2GNKeevMFce9PyUrag9rriA1FIdRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r6HauxlS; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250626132304epoutp0463cd1d6391923bbe139db93654429f66~MmnVutDhu2529625296epoutp042
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:23:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250626132304epoutp0463cd1d6391923bbe139db93654429f66~MmnVutDhu2529625296epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750944184;
	bh=p3SgMZmcQFMVQiUhzolevvmMg+vbh2F42OJuAiYE36w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6HauxlS5rmlUCcDCY/DdVrUmypCKK2lJcCmY2cIsbjsontlGtqZErHJsRvZl3V8S
	 B9UhTUT+6JcgKeqMGkCOxPKvN0tO/7totX/uozHOfLd5WeBEygbdHSOrQaw3VrMEeI
	 wTB3hq8ho+6dLNGUruZtxFbC960NYo0cO3Xu143o=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250626132303epcas5p2b64aa7f7ee544763938649fd2504d67e~MmnU3bRrO2644726447epcas5p2O;
	Thu, 26 Jun 2025 13:23:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bSfWW2NZDz6B9m5; Thu, 26 Jun
	2025 13:23:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250626100356epcas5p30a8c00ed331b3b1ff3bf31d9004ea980~Mj5eOS8IU0923609236epcas5p3o;
	Thu, 26 Jun 2025 10:03:56 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250626100353epsmtip26d4aa2c522bf6afb4ae83c4c856c81e6~Mj5b04kK-3008830088epsmtip2c;
	Thu, 26 Jun 2025 10:03:53 +0000 (GMT)
Date: Thu, 26 Jun 2025 15:33:47 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	a.manzanares@samsung.com, nifan.cxl@gmail.com, anisa.su@samsung.com,
	vishak.g@samsung.com, krish.reddy@samsung.com, arun.george@samsung.com,
	alok.rathore@samsung.com, neeraj.kernel@gmail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, gost.dev@samsung.com, cpgs@samsung.com
Subject: Re: [RFC PATCH 13/20] cxl/mem: Refactor cxl pmem region
 auto-assembling
Message-ID: <158453976.61750944183327.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250623102047.000020fc@huawei.com>
X-CMS-MailID: 20250626100356epcas5p30a8c00ed331b3b1ff3bf31d9004ea980
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd547_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250617124043epcas5p21e5b77aa3a6acfa7e01847ffd58350ed
References: <20250617123944.78345-1-s.neeraj@samsung.com>
	<CGME20250617124043epcas5p21e5b77aa3a6acfa7e01847ffd58350ed@epcas5p2.samsung.com>
	<1213349904.281750165205974.JavaMail.epsvc@epcpadp1new>
	<20250623102047.000020fc@huawei.com>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd547_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/25 10:20AM, Jonathan Cameron wrote:
>On Tue, 17 Jun 2025 18:09:37 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>> In 84ec985944ef3, For cxl pmem region auto-assembly after endpoint port
>> probing, cxl_nvd presence was required. And for cxl region persistency,
>> region creation happens during nvdimm_probe which need the completion
>> of endpoint probe.
>>
>> It is therefore refactored cxl pmem region auto-assembly after endpoint
>> probing to cxl mem probing
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>For ordering requirements this needs more eyes.  I've never cared that
>much about he persistency and auto assembly code so not something I have
>a good mental model of!
>

Sure, Will see how other maintainers responds to it. Thanks for your
feedback.

>
>> ---
>>  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h       |  1 +
>>  drivers/cxl/mem.c       | 27 ++++++++++++++++++---------
>>  drivers/cxl/port.c      | 38 --------------------------------------
>>  4 files changed, 57 insertions(+), 47 deletions(-)
>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 2f03a4d5606e..aaea4eb178ef 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>
>> @@ -180,6 +171,24 @@ static int cxl_mem_probe(struct device *dev)
>>  			return rc;
>>  	}
>>
>> +	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>> +		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>> +		if (rc) {
>> +			if (rc == -ENODEV)
>> +				dev_info(dev, "PMEM disabled by platform\n");
>> +			return rc;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Now that all endpoint decoders are successfully enumerated, try to
>> +	 * assemble region autodiscovery from committed decoders.
>> +	 * Earlier it was part of cxl_endpoint_port_probe, So moved it here
>
>I would drop this history statement. Good to have in the patch description
>but no point in keeping it in the code. Just state what the requirements
>are now.
>

Okay, I will remove this and update commit message with the same

>> +	 * as cxl_nvd of the memdev needs to be available during the pmem
>> +	 * region auto-assembling
>> +	 */
>> +	cxl_region_discovery(cxlmd->endpoint);
>> +
>>  	/*
>>  	 * The kernel may be operating out of CXL memory on this device,
>
>
>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd547_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd547_--


