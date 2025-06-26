Return-Path: <linux-kernel+bounces-704513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D19AE9E63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027414E0964
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611C62E427A;
	Thu, 26 Jun 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HseF3YoJ"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8D2E542A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943713; cv=none; b=jwA5ppjR8pieTVlEQGPaPrl+wyiqFkm8O9cut63QDgf6y3UP4o1sdRtZXMZK6ENqRBvjcW5iyD4Ulki+qoRVs5Dd45uT/cw+gdEuTEp8RgkJ1fIT61PLw91eSGYqcBEBzsOBLmaWxtFOHK+vfbbI/NCXFo/Hd+7EZHoXxd1j93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943713; c=relaxed/simple;
	bh=5u9cun5r3VtNRTKJoYoiJ4o51uev8f7R7V33C7qbCmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UGypvFzBJSPxMN5ulqLQqJaUFTyY1U3Y2vXG/5czpXR5+Qev+Db6Htg8G54jlc4Z0V3bQULJbXpnfjfHpQVE4EhSbCn5Tdj7Jq2rPap0xxuIYmD0RwcCf+QawSC4iSMlSmyZINt50YON3DrS9rdfRfQerFut+TsILdor6JXX2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HseF3YoJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250626131503epoutp02bfd81caa7192de014b36abc82aed4338~MmgWJIV1u1401914019epoutp02d
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250626131503epoutp02bfd81caa7192de014b36abc82aed4338~MmgWJIV1u1401914019epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750943703;
	bh=Z48CYdHuCTJ8UqTDSPkDCBaoRT5Me1js72mN5Gpyzc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HseF3YoJ/ErY1Q3qa8hrIZSWKvis+9/cOakNJcNU3YfiiS3ZGcY82cFKHb/hO7h/4
	 YzjQ20vlHbPsjt/uEh0e8hOi7Cymp8BqVtzUSXSCvmsK13Tbpa7GpAdEJYwy6cGWAr
	 HgjKAP7SPWdlMr9l3+oQDoo0iE6mvKjGny+8vNyc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250626131503epcas5p3ad3b098c17283812411ba6ae12e24742~MmgVg38-g2713827138epcas5p3g;
	Thu, 26 Jun 2025 13:15:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bSfLG73jWz2SSKX; Thu, 26 Jun
	2025 13:15:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250626094852epcas5p3dc4fb79d144ce6259c3ed731bedf661c~MjsUQCGNZ0414204142epcas5p3b;
	Thu, 26 Jun 2025 09:48:52 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250626094849epsmtip1111d25dc34d42797b28a2665724e47e4~MjsRx9vFF1194711947epsmtip1b;
	Thu, 26 Jun 2025 09:48:49 +0000 (GMT)
Date: Thu, 26 Jun 2025 15:18:40 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	a.manzanares@samsung.com, nifan.cxl@gmail.com, anisa.su@samsung.com,
	vishak.g@samsung.com, krish.reddy@samsung.com, arun.george@samsung.com,
	alok.rathore@samsung.com, neeraj.kernel@gmail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, gost.dev@samsung.com, cpgs@samsung.com
Subject: Re: [RFC PATCH 01/20] nvdimm/label: Introduce NDD_CXL_LABEL flag to
 set cxl label format
Message-ID: <1983025922.01750943702980.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250620174001.00003aa2@huawei.com>
X-CMS-MailID: 20250626094852epcas5p3dc4fb79d144ce6259c3ed731bedf661c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd417_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250617124008epcas5p2e702f786645d44ceb1cdd980a914ce8e
References: <20250617123944.78345-1-s.neeraj@samsung.com>
	<CGME20250617124008epcas5p2e702f786645d44ceb1cdd980a914ce8e@epcas5p2.samsung.com>
	<158453976.61750165203630.JavaMail.epsvc@epcpadp1new>
	<20250620174001.00003aa2@huawei.com>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd417_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/06/25 05:40PM, Jonathan Cameron wrote:
>On Tue, 17 Jun 2025 18:09:25 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>> NDD_CXL_LABEL is introduced to set cxl LSA 2.1 label format
>> Accordingly updated label index version
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>A few local comments.  I'll need to read on to figure out how this
>fits in generally.
>
>> ---
>>  drivers/nvdimm/dimm.c      |  1 +
>>  drivers/nvdimm/dimm_devs.c | 10 ++++++++++
>>  drivers/nvdimm/label.c     | 16 ++++++++++++----
>>  drivers/nvdimm/nd.h        |  1 +
>>  include/linux/libnvdimm.h  |  3 +++
>>  5 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
>> index 91d9163ee303..8753b5cd91cc 100644
>> --- a/drivers/nvdimm/dimm.c
>> +++ b/drivers/nvdimm/dimm.c
>> @@ -62,6 +62,7 @@ static int nvdimm_probe(struct device *dev)
>>  	if (rc < 0)
>>  		dev_dbg(dev, "failed to unlock dimm: %d\n", rc);
>>
>> +	ndd->cxl = nvdimm_check_cxl_label_format(ndd->dev);
>>
>>  	/*
>>  	 * EACCES failures reading the namespace label-area-properties
>> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
>> index 21498d461fde..e8f545f889fd 100644
>> --- a/drivers/nvdimm/dimm_devs.c
>> +++ b/drivers/nvdimm/dimm_devs.c
>> @@ -18,6 +18,16 @@
>>
>>  static DEFINE_IDA(dimm_ida);
>>
>> +bool nvdimm_check_cxl_label_format(struct device *dev)
>> +{
>> +	struct nvdimm *nvdimm = to_nvdimm(dev);
>> +
>> +	if (test_bit(NDD_CXL_LABEL, &nvdimm->flags))
>> +		return true;
>> +
>> +	return false;
>
>	return test_bit(NDD_CXL_LABEL, &nvdimm->flags);
>
>Unless this is going to get more complex in later patches, in which case
>may be fine to ignore this comment.
>

Okay. I will fix in V1 patch.

>> +}
>> +
>>  /*
>>   * Retrieve bus and dimm handle and return if this bus supports
>>   * get_config_data commands
>> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
>> index 082253a3a956..48b5ba90216d 100644
>> --- a/drivers/nvdimm/label.c
>> +++ b/drivers/nvdimm/label.c
>> @@ -687,11 +687,19 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
>>  		- (unsigned long) to_namespace_index(ndd, 0);
>>  	nsindex->labeloff = __cpu_to_le64(offset);
>>  	nsindex->nslot = __cpu_to_le32(nslot);
>> -	nsindex->major = __cpu_to_le16(1);
>> -	if (sizeof_namespace_label(ndd) < 256)
>> +
>> +	/* Support CXL LSA 2.1 label format */
>
>Might be good to sprinkle some extra details in the references.
>E.g. CXL r3.2 Table 9-9 Label Index Block Layout
>

Sure, I will update it in V1

>> +	if (ndd->cxl) {
>> +		nsindex->major = __cpu_to_le16(2);
>>  		nsindex->minor = __cpu_to_le16(1);
>> -	else
>> -		nsindex->minor = __cpu_to_le16(2);
>> +	} else {
>> +		nsindex->major = __cpu_to_le16(1);
>
>Same for these.  Case of making reviewers jobs easier by
>giving them breadcrumb trails to follow.
>

Sure, I will update it in V1

>> +		if (sizeof_namespace_label(ndd) < 256)
>> +			nsindex->minor = __cpu_to_le16(1);
>> +		else
>> +			nsindex->minor = __cpu_to_le16(2);
>> +	}
>> +
>>  	nsindex->checksum = __cpu_to_le64(0);
>>  	if (flags & ND_NSINDEX_INIT) {
>>  		unsigned long *free = (unsigned long *) nsindex->free;
>> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
>> index 5ca06e9a2d29..304f0e9904f1 100644
>> --- a/drivers/nvdimm/nd.h
>> +++ b/drivers/nvdimm/nd.h
>> @@ -522,6 +522,7 @@ void nvdimm_set_labeling(struct device *dev);
>>  void nvdimm_set_locked(struct device *dev);
>>  void nvdimm_clear_locked(struct device *dev);
>>  int nvdimm_security_setup_events(struct device *dev);
>> +bool nvdimm_check_cxl_label_format(struct device *dev);
>>  #if IS_ENABLED(CONFIG_NVDIMM_KEYS)
>>  int nvdimm_security_unlock(struct device *dev);
>>  #else
>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index e772aae71843..0a55900842c8 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -44,6 +44,9 @@ enum {
>>  	/* dimm provider wants synchronous registration by __nvdimm_create() */
>>  	NDD_REGISTER_SYNC = 8,
>>
>> +	/* dimm supports region labels (LSA Format 2.1) */
>> +	NDD_CXL_LABEL = 9,
>> +
>>  	/* need to set a limit somewhere, but yes, this is likely overkill */
>>  	ND_IOCTL_MAX_BUFLEN = SZ_4M,
>>  	ND_CMD_MAX_ELEM = 5,
>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd417_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_cd417_--


