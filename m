Return-Path: <linux-kernel+bounces-842586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE7BBD140
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270431893FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D0244687;
	Mon,  6 Oct 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t7X9oniF"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E561DED64
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759726697; cv=none; b=mJxGyQEmaTlBkv7U3iVjGAO8PIF72F9Z2Hpk6ARGgvTkryBLdSr9deqE8aIceJXbo2lYRLSaHPYNL0AR9EsKrk/MCBZNc58Fxcj7opl5ISRfwLfvMZXnU+29Bq3zaDrsOtwE29vRT+LtsKXl7w5T/1mSayaZTqRpR9LAeK+DYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759726697; c=relaxed/simple;
	bh=uR75BCVZ6r3o8n2JHxZklEM0P6Tcd4w6w+UH3FP2RqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=OGCLQ4/BiooAxWFpwtO4pGDoYvWhuvc07F0JIkSRi5lVJUz7wau72rf0oiUk/u8/g+sqXNn82UqWVmfo9G+1DaB+hVnTjidKlvTud401OJuEHr5ib/GC9hgEXXoEOQL3vBoTPXNw8I/8dykpeOYsmt7aDyLPcnYKKZLGzb2txOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t7X9oniF; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251006045303epoutp04644f7c1bb6d4cf8a5be78d4df08d18b5~rzdJwfSh80279402794epoutp04S
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251006045303epoutp04644f7c1bb6d4cf8a5be78d4df08d18b5~rzdJwfSh80279402794epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759726383;
	bh=7SziAcs69Ob1GmYme5dJMaRr/WnjrJV6VSEynsS+bZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t7X9oniFwMi5TC++Kr658co1gcnzX0fR4VyyNC/k8gDdMeJPOrL+C9UqmxxNvzCqW
	 hbN+IUWIHzv33naptPVGGymLxfEDZv+vDjttBjRBwlTwXMOrAinZ0+PjBVs3ZIO9EJ
	 8mak3RlEt8H6OHf8kWVi3IZRulcbKX8+8pgFBDwk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251006045302epcas5p36d894bd40f35a1a4aa5ddfdca08738ee~rzdJDaZNM0317603176epcas5p3b;
	Mon,  6 Oct 2025 04:53:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cg6My2Rbkz3hhT3; Mon,  6 Oct
	2025 04:53:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250929132629epcas5p4f44fae4e2e0bcde47b7bd185582494d2~pw8czcfQR2147921479epcas5p4s;
	Mon, 29 Sep 2025 13:26:29 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250929132627epsmtip1a7bc6a34c233be2b6d8723843c4d541b~pw8a7SUoc2638126381epsmtip1T;
	Mon, 29 Sep 2025 13:26:27 +0000 (GMT)
Date: Mon, 29 Sep 2025 18:56:22 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 12/20] nvdimm/region_label: Export routine to fetch
 region information
Message-ID: <158453976.61759726382339.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a1fa16f1-c75f-4f7d-b297-a32ba4c7d109@intel.com>
X-CMS-MailID: 20250929132629epcas5p4f44fae4e2e0bcde47b7bd185582494d2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----xsJXu.fD5V5xDhddWNWtQINaZQo.kzBR_hLvg.7oVeVxw7Lp=_733d_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134153epcas5p1e1f7a7a19fb41d12b9397c3e6265f823
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134153epcas5p1e1f7a7a19fb41d12b9397c3e6265f823@epcas5p1.samsung.com>
	<20250917134116.1623730-13-s.neeraj@samsung.com>
	<a1fa16f1-c75f-4f7d-b297-a32ba4c7d109@intel.com>

------xsJXu.fD5V5xDhddWNWtQINaZQo.kzBR_hLvg.7oVeVxw7Lp=_733d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/09/25 01:23PM, Dave Jiang wrote:
>
>
>On 9/17/25 6:41 AM, Neeraj Kumar wrote:
>> +bool nvdimm_has_cxl_region(struct nvdimm *nvdimm)
>> +{
>> +	if (nvdimm)
>> +		return nvdimm->is_region_label;
>> +
>> +	return false;
>
>Just a nit. Would prefer return error early and return the success case last.
>
>> +}
>> +EXPORT_SYMBOL_GPL(nvdimm_has_cxl_region);
>> +
>> +void *nvdimm_get_cxl_region_param(struct nvdimm *nvdimm)
>> +{
>> +	if (nvdimm)
>> +		return &nvdimm->cxl_region_params;
>> +
>> +	return NULL;
>
>same comment
>

Sure Dave, Will fix it accordingly


Regards,
Neeraj


------xsJXu.fD5V5xDhddWNWtQINaZQo.kzBR_hLvg.7oVeVxw7Lp=_733d_
Content-Type: text/plain; charset="utf-8"


------xsJXu.fD5V5xDhddWNWtQINaZQo.kzBR_hLvg.7oVeVxw7Lp=_733d_--


