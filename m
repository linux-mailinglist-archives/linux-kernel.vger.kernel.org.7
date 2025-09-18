Return-Path: <linux-kernel+bounces-802189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D0B44EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD241C279C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC92E92BB;
	Fri,  5 Sep 2025 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eDgvczZg"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F82D47E6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055790; cv=none; b=hKp6pQqgflJ/CUTUQfPX23XTwNv2SBVfYgB7uRb7xKJNRLr3RIvCLmVRp15o32PDUsHV4+P0sz1Lk8pszweBM7s9pqvGYzGKsLdXBPyEA4l5dzp45b1/VguLyf3/yUONFpTCI4CDiW8ACV58RZfr4E5BsnZij4RQVKcltZxtmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055790; c=relaxed/simple;
	bh=XMJVFVxRmh3peicYbuF2su+FZK1Muiig8ssiRVbYBOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=fzT7qLrdXzGOYke7hn/xj8dpWkzDcZfAeePJ45Sa2/PhKR/DUeKhk48KT9vQ5wVs0zyiRBTsCxtpG7n+lTDTuyb79eAQFr5ANtg3wObI3njsBO/rfeTCwU0sGPSq5520sQRSI6ciAjG3q6cCpFnp319ZiSv2ckt4NMQRpK69Bvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eDgvczZg; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250905070304epoutp016df5e9f341aaf863f28738d99df98c55~iUO1VGBm_0734707347epoutp01E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:03:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250905070304epoutp016df5e9f341aaf863f28738d99df98c55~iUO1VGBm_0734707347epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757055784;
	bh=DAf7IFgHBvJDfZgahFooC6ZDHHY5mojc5Pt4LAfJBqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eDgvczZgIORsWJwp3BltKDN6mX593KLO3a4NUZlRR5+HO7pLzp2/mdben03Edh3rc
	 ego4yKyv4GJ36XkIzjNYoORvfwJ2T7KSFm5FOkFS+a6q8KpDilB/guio5ssZBtBblc
	 NZfN/0LRSN6qc1aKBD2dYQ3Coa5JaBlQzs/aAktE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250905070304epcas5p39c0032908b488c386cbe535766d8e214~iUO03IwUR3104231042epcas5p3E;
	Fri,  5 Sep 2025 07:03:04 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cJ6kJ2XsWz2SSKv; Fri,  5 Sep
	2025 07:03:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250904143941epcas5p3bf2c74895a2fc6b54606dcd189bc9fc5~iG0N0S1192088120881epcas5p3Q;
	Thu,  4 Sep 2025 14:39:41 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250904143939epsmtip15e39fdf391bd9e426d283533cfe902f9~iG0Mr1S470742607426epsmtip1z;
	Thu,  4 Sep 2025 14:39:39 +0000 (GMT)
Date: Thu, 4 Sep 2025 20:09:33 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V2 13/20] cxl/mem: Refactor cxl pmem region
 auto-assembling
Message-ID: <1256440269.161757055784348.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c22affa9-1dad-4a66-8db8-8e268806e0a1@intel.com>
X-CMS-MailID: 20250904143941epcas5p3bf2c74895a2fc6b54606dcd189bc9fc5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_eadef_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250730121239epcas5p37956b2999f61e17e8dbfbde7972cef35
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121239epcas5p37956b2999f61e17e8dbfbde7972cef35@epcas5p3.samsung.com>
	<20250730121209.303202-14-s.neeraj@samsung.com>
	<c22affa9-1dad-4a66-8db8-8e268806e0a1@intel.com>

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_eadef_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/08/25 09:41AM, Dave Jiang wrote:
>
>
>On 7/30/25 5:12 AM, Neeraj Kumar wrote:
>> In 84ec985944ef3, devm_cxl_add_nvdimm() sequence was changed and called
>> before devm_cxl_add_endpoint(). It's because cxl pmem region auto-assembly
>> used to get called at last in cxl_endpoint_port_probe(), which requires
>> cxl_nvd presence.
>>
>> For cxl region persistency, region creation happens during nvdimm_probe
>> which need the completion of endpoint probe.
>>
>> In order to accommodate both cxl pmem region auto-assembly and cxl region
>> persistency, refactored following
>>
>> 1. Re-Sequence devm_cxl_add_nvdimm() after devm_cxl_add_endpoint(). This
>>    will be called only after successful completion of endpoint probe.
>>
>> 2. Moved cxl pmem region auto-assembly from cxl_endpoint_port_probe() to
>>    cxl_mem_probe() after devm_cxl_add_nvdimm(). It gurantees both the
>>    completion of endpoint probe and cxl_nvd presence before its call.
>
>So there are a few issues with doing this. If cxl_endpoint_port_probe() fails, you won't know that while running in cxl_mem_probe(). So you may need to do something similar to here [1] in order to make the probe synchronous with the add endpoint and make sure that the port driver attached successfully.

Hi Dave,
devm_cxl_add_endpoint() makes sure cxl_endpoint_port_probe() has
completed successfully, as per below check in devm_cxl_add_endpoint()

	if (!endpoint->dev.driver) {
		dev_err(&cxlmd->dev, "%s failed probe\n", dev_name(&endpoint->dev));
		return -ENXIO;
	}

Above check confirms synchronous probe completion of cxl_endpoint_port_probe() and port
driver attachment.

> Specifically see changes to devm_cxl_add_memdev().
>
>Also, in endpoint port probe you are holding the device lock and therefore is protected from port removals (endpoint and parents) while you are trying to scan for regions. That is not the case on the memdev probe side if you aren't holding that port lock.
>
>[1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=for-6.18/cxl-probe-order&id=88aec5ea7a24da00dc92c7778df4851fe4fd3ec6
>
>DJ

Sure, I will go through [1] and its devm_cxl_add_memdev() implementation.
And see if any changes required as per your suggestion.


Regards,
Neeraj

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_eadef_
Content-Type: text/plain; charset="utf-8"


------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_eadef_--


