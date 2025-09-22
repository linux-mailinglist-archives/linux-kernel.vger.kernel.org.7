Return-Path: <linux-kernel+bounces-827553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E2B9210C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AAD2A0C56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950530F546;
	Mon, 22 Sep 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tcDAp9xS"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5430DEA7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556387; cv=none; b=f9e6qXhASJ9vuxDvlpD3azVL8VM3Dd//8F1atWvN3QslHxROgYhjN0g4dSrMejbPNNLOV00HbaXtjUon9FRlA6Ii+3AbFtFD9ZntsjkbhFlm9XUFweKuOTpWeJ4UNHwHGli5Hq/X4oZUli6mQEkYrQzjugDZKKFUSzJ+tS/AJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556387; c=relaxed/simple;
	bh=nTAiUXc7YPNhzVMskHwfnAtKOJU1lFSzoQUAunE5Nh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UGAietj6U/H0MKtyXImwxOlChBPUCNGp3qJiJW+VPkYe4BbYgtrRjFGq8ideBwwOj6XR1VTfdb5NG9bUyLo+z6cfhv1VHj3f+56lM6jWHOG45MgNKosQwxhtc6/0axist/UUDe/wAIvYsbTYbVzJy33Bs6WMMODSV9yIi235byk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tcDAp9xS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250922155302epoutp02b2410a7a0e60a3aa4ed213254f58f910~npbaEofxz2243822438epoutp02U
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250922155302epoutp02b2410a7a0e60a3aa4ed213254f58f910~npbaEofxz2243822438epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758556382;
	bh=cb+U+Tkli/i0cLtgDmQMqdfYAS8rfARZ0T/H5mDemaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tcDAp9xSmTdHUJljmabG39R5XZM5yL8vQILO8WVX5r20RComWj0t3xuLtX666lhh/
	 0/UIhgIoQ+4kjz4bAS8AteBEYPlxfrfaXVtinrgJg6FdgBtySxIGEfQ2h6pvBnJgfb
	 WV7sBDMEOMxGJgUHfWpSJp7YLhH59nWHfkZ5vVDs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250922155302epcas5p498ca7e2ea2f11c115de16c4cc34cd33e~npbZl6IhI1157911579epcas5p4v;
	Mon, 22 Sep 2025 15:53:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cVngy23sVz6B9m5; Mon, 22 Sep
	2025 15:53:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250922124141epcas5p37e5a72c3edcaff0e7b1b9912b199a91c~nm0VansYh0475204752epcas5p34;
	Mon, 22 Sep 2025 12:41:41 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250922124139epsmtip2d92509fd3289b4dd18e0d18fbb3766a4~nm0Tvwp422506525065epsmtip2G;
	Mon, 22 Sep 2025 12:41:39 +0000 (GMT)
Date: Mon, 22 Sep 2025 18:11:34 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 01/20] nvdimm/label: Introduce NDD_REGION_LABELING
 flag to set region label
Message-ID: <1983025922.01758556382272.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8c6bb8fc-7801-45d3-8563-054b12295df0@intel.com>
X-CMS-MailID: 20250922124141epcas5p37e5a72c3edcaff0e7b1b9912b199a91c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_26d70_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134130epcas5p417d7c26bc564d64d1bcea6e04d55704d
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134130epcas5p417d7c26bc564d64d1bcea6e04d55704d@epcas5p4.samsung.com>
	<20250917134116.1623730-2-s.neeraj@samsung.com>
	<8c6bb8fc-7801-45d3-8563-054b12295df0@intel.com>

------M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_26d70_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/09/25 04:10PM, Dave Jiang wrote:
>
>
>On 9/17/25 6:40 AM, Neeraj Kumar wrote:
>> Prior to LSA 2.1 version, LSA contain only namespace labels. LSA 2.1
>> introduced in CXL 2.0 Spec, which contain region label along with
>> namespace label.
>>
>> NDD_LABELING flag is used for namespace. Introduced NDD_REGION_LABELING
>> flag for region label. Based on these flags nvdimm driver performs
>> operation on namespace label or region label.
>>
>> NDD_REGION_LABELING will be utilized by cxl driver to enable LSA 2.1
>> region label support
>>
>> Accordingly updated label index version
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>
>With the change noted below,
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>


<Snip>
>>  	/*
>>  	 * EACCES failures reading the namespace label-area-properties
>> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
>> index 21498d461fde..918c3db93195 100644
>> --- a/drivers/nvdimm/dimm_devs.c
>> +++ b/drivers/nvdimm/dimm_devs.c
>> @@ -18,6 +18,13 @@
>>
>>  static DEFINE_IDA(dimm_ida);
>>
>> +bool nvdimm_check_region_label_format(struct device *dev)
>
>Should be called nvdimm_region_label_supported() since a bool return is expected instead of resolving the checking in the function.
>
>DJ

Thanks Jonathan and Dave for RB tag. Sure, I will rename it accordingly


Regards,
Neeraj

------M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_26d70_
Content-Type: text/plain; charset="utf-8"


------M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_26d70_--


