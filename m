Return-Path: <linux-kernel+bounces-827555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E9B92112
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F312A0ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C830F7F2;
	Mon, 22 Sep 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g5STKAr6"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212030DED7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556387; cv=none; b=sYrvoJ2kgNqXmzKEmGuhshhyvbO5FpMPZb4gfydN6vOITwGcOcU0bvQqRNyWdCgixRbh9HACZC5Mm3rNVe0V6L/V2DQgx+LxNykMVKGa8vE1vKsws3ilZl0hwtiIdaAmB9aBRI52an/V5ezm7qftdxJsWc+jDpT8GUjIYMavYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556387; c=relaxed/simple;
	bh=05uZUSHK1ZRZPKyutlbi4v9p8ZTOK4HKg5l3XLxRYks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=V8M/pVbjnvaE/33p5YwN8c2Alhi7nl4iH/lTFmFyCeHct60BNJ39ffBDbF9CRvp+BQ5uB46Fc6AZpbRAzMhKpybe9vCwu9E0vTzX9k+IZn9nO0VpgNCu0yjT109+2/VJCUHUVd6eLhFyjHShnenfHtDgrIIADibQcRN5e2Eo+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g5STKAr6; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250922155303epoutp01ad8f828b62c75662e7370cd434d34e25~npbauNm883039630396epoutp01o
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250922155303epoutp01ad8f828b62c75662e7370cd434d34e25~npbauNm883039630396epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758556383;
	bh=xnh7fxlGbFoKH0snsUrxkRKAGT4p64l40PjTAQylMhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g5STKAr6qD3sCcxA005xl9R/ZKwTM8RU7HwWOcbdwmGr7VnSFEqcXstfBWZ7suhdo
	 KZuZmWcXwGCmlDPM6gBVIflDdRSqfaV14LlX/zibimpNloETU6e6mb1KUD+BVakVTZ
	 dmWOFQpqTBRwIaAo2x083M2L56OjCzme8CWw41t4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250922155303epcas5p30a7b0dca04acbc1430833850d6a8eda8~npbaVC6gw0102901029epcas5p3m;
	Mon, 22 Sep 2025 15:53:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cVngz0SjDz3hhT3; Mon, 22 Sep
	2025 15:53:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250922130335epcas5p46ee4227cb3a68becef60ab9392da4b4a~nnHdSGQqY2781427814epcas5p4e;
	Mon, 22 Sep 2025 13:03:35 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250922130334epsmtip2e00db58dfd37125f60a98a898fdcede9~nnHcH0pOq0628206282epsmtip20;
	Mon, 22 Sep 2025 13:03:34 +0000 (GMT)
Date: Mon, 22 Sep 2025 18:33:30 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 05/20] nvdimm/namespace_label: Add namespace label
 changes as per CXL LSA v2.1
Message-ID: <700072760.81758556383053.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3bfaf4e6-739f-4998-8343-770ef3ab3791@intel.com>
X-CMS-MailID: 20250922130335epcas5p46ee4227cb3a68becef60ab9392da4b4a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d1a_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134138epcas5p2b02390404681df79c26f7a1a0f0262b8
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134138epcas5p2b02390404681df79c26f7a1a0f0262b8@epcas5p2.samsung.com>
	<20250917134116.1623730-6-s.neeraj@samsung.com>
	<3bfaf4e6-739f-4998-8343-770ef3ab3791@intel.com>

------eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d1a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/09/25 04:59PM, Dave Jiang wrote:
>
>
>On 9/17/25 6:41 AM, Neeraj Kumar wrote:
>> CXL 3.2 Spec mentions CXL LSA 2.1 Namespace Labels at section 9.13.2.5
>> Modified __pmem_label_update function using setter functions to update
>> namespace label as per CXL LSA 2.1
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>> ---
>>  drivers/nvdimm/label.c |  3 +++
>>  drivers/nvdimm/nd.h    | 23 +++++++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
>> index 3235562d0e1c..182f8c9a01bf 100644
>> --- a/drivers/nvdimm/label.c
>> +++ b/drivers/nvdimm/label.c
>> +static inline void nsl_set_type(struct nvdimm_drvdata *ndd,
>> +				struct nd_namespace_label *ns_label)
>> +{
>> +	if (ndd->cxl && ns_label)
>> +		uuid_parse(CXL_NAMESPACE_UUID, (uuid_t *) ns_label->cxl.type);
>
>Personally would prefer something like:
>
>if (!(ndd->cxl && ns_label))
>	return;
>uuid_parse(....);
>
>Also, no space needed after casting.
>
>> +}
>> +
>> +static inline void nsl_set_alignment(struct nvdimm_drvdata *ndd,
>> +				     struct nd_namespace_label *ns_label,
>> +				     u32 align)
>> +{
>> +	if (ndd->cxl)
>> +		ns_label->cxl.align = __cpu_to_le32(align);
>
>same comment as above
>> +}
>> +
>> +static inline void nsl_set_region_uuid(struct nvdimm_drvdata *ndd,
>> +				       struct nd_namespace_label *ns_label,
>> +				       const uuid_t *uuid)
>> +{
>> +	if (ndd->cxl && uuid)
>> +		export_uuid(ns_label->cxl.region_uuid, uuid);
>
>same comment as above

Sure Dave, I will fix it in next patch-set


Regards,
Neeraj

------eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d1a_
Content-Type: text/plain; charset="utf-8"


------eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d1a_--


