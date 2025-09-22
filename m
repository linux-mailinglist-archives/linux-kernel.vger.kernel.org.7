Return-Path: <linux-kernel+bounces-827554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54814B9210F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD22A0CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6130F55A;
	Mon, 22 Sep 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FOpL3ggM"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9830DD37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556387; cv=none; b=fJCLwYLndO32wmMhC6XIwsAkBMHo9BxHyh7FkhiQgRSOI16DotuzSGjG8i8vP+jUe06rFpxGN3A+63rkBIQ95MVXqGlGvBWggLqgfto3T/9jctQGj+LSMl/8meKl6OLE+r6/C2BY10dLJ0Q79wMxAAyUEp2NXY1cvFaTFIZpjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556387; c=relaxed/simple;
	bh=QRjXyQFSuI4J3thCUkXLzHQGmvtCQn/loIzOPpxNs+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=fIQEWwEJAKUQEXXyx8hW6IydO8S0K700KA2B3xki8iDgGTowZ8t2TB5WAqOte9ADkLdLuuD714FTyQS+ev4zlmA6eFKTRVMp63D3E4RoP51PQHVdqXGQFj8QpAW1koxPIhZCpF5Ez8iug6phZ6L+CAL98zfYS08jTV8EVadKC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FOpL3ggM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250922155303epoutp0309f5beacef21be1cf663c255db21e904~npbaUr_VQ0886408864epoutp03u
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250922155303epoutp0309f5beacef21be1cf663c255db21e904~npbaUr_VQ0886408864epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758556383;
	bh=W36mltLmev3mjFYBVD0fRRwSlXih6RCojOhs+gu7fi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FOpL3ggMOPi4XIp2KzM0JE08lppxWs+/eVihWJxxJof7waWHlazZ2YvIu+XRabnEL
	 mrsQdkgZAtpGfTpQepkVU7lSM4WMBXaFvDe0vvGKu1aeYRwugBhDFJ0gDYXxGBSaLM
	 KPQB4HB/idDbH73fQzjpAQRvnI63Cs2KxxLm4bWM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250922155302epcas5p451082652195f094bf46e43c816b5db81~npbZ_zdk91175111751epcas5p4z;
	Mon, 22 Sep 2025 15:53:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cVngy5321z6B9m5; Mon, 22 Sep
	2025 15:53:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250922125700epcas5p4925f1a3a1b0773452a046964ffa4aac9~nnBtD4k3K2405124051epcas5p4Z;
	Mon, 22 Sep 2025 12:57:00 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250922125659epsmtip23d2e35208c7270805e984af5f39155cb~nnBr6JblQ0131301313epsmtip2z;
	Mon, 22 Sep 2025 12:56:59 +0000 (GMT)
Date: Mon, 22 Sep 2025 18:26:54 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 04/20] nvdimm/label: Update mutex_lock() with
 guard(mutex)()
Message-ID: <1931444790.41758556382694.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68cdd157cf7be_1a2a17294f1@iweiny-mobl.notmuch>
X-CMS-MailID: 20250922125700epcas5p4925f1a3a1b0773452a046964ffa4aac9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_26e6e_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134136epcas5p118f18ce5139d489d90ac608e3887c1fc
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134136epcas5p118f18ce5139d489d90ac608e3887c1fc@epcas5p1.samsung.com>
	<20250917134116.1623730-5-s.neeraj@samsung.com>
	<68cdd157cf7be_1a2a17294f1@iweiny-mobl.notmuch>

------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_26e6e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/09/25 04:55PM, Ira Weiny wrote:
>Neeraj Kumar wrote:
>> Updated mutex_lock() with guard(mutex)()
>
>You are missing the 'why' justification here.
>
>The detail is that __pmem_label_update() is getting more complex and this
>change helps to reduce the complexity later.
>
>However...
>
>[snip]
>
>> @@ -998,9 +998,8 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
>>  		label_ent = kzalloc(sizeof(*label_ent), GFP_KERNEL);
>>  		if (!label_ent)
>>  			return -ENOMEM;
>> -		mutex_lock(&nd_mapping->lock);
>> +		guard(mutex)(&nd_mapping->lock);
>>  		list_add_tail(&label_ent->list, &nd_mapping->labels);
>> -		mutex_unlock(&nd_mapping->lock);
>
>... this change is of little value.  And...
>
>>  	}
>>
>>  	if (ndd->ns_current == -1 || ndd->ns_next == -1)
>> @@ -1039,7 +1038,7 @@ static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
>>  	if (!preamble_next(ndd, &nsindex, &free, &nslot))
>>  		return 0;
>>
>> -	mutex_lock(&nd_mapping->lock);
>> +	guard(mutex)(&nd_mapping->lock);
>>  	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
>>  		struct nd_namespace_label *nd_label = label_ent->label;
>>
>> @@ -1061,7 +1060,6 @@ static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
>>  		nd_mapping_free_labels(nd_mapping);
>>  		dev_dbg(ndd->dev, "no more active labels\n");
>>  	}
>> -	mutex_unlock(&nd_mapping->lock);
>
>... this technically changes the scope of the lock to include writing the
>index under the lock.
>
>It does not affect anything AFAICS but really these last two changes
>should be dropped from this patch.
>
>Ira

Sure Ira, I will drop the last two hunks and elaborate commit message.

Regards,
Neeraj

------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_26e6e_
Content-Type: text/plain; charset="utf-8"


------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_26e6e_--


