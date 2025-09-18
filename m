Return-Path: <linux-kernel+bounces-805403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FCB4881B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2342616A8D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEC2ED16B;
	Mon,  8 Sep 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ADcrsOKZ"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D391E1E19
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323088; cv=none; b=TUZ1yMni3KnZGGGeyWzdDsu6LEN1NYmiuRTDQ2espdRnlg8aoCcHEPedrnbcnF2SpoVMtzAiwsnetqYNHv6Ltr+KHuT4v7jFltEujfRT017zvvuztdIc/QUb0BImkHM7vFk+omgCAwHTMmX9vLQIsEO1XjkgxN2pX4+jWZQLK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323088; c=relaxed/simple;
	bh=60cR7w6WJvBWNXE45/vBoF62wgNCkwjiNGFKC3Lwy0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=QadNviCmDkNFFoPlFWm3LOSqKC53uRRAfZw8Lo3F9uDJoFqNrxXzUq/Z8PgIaCzsNr/rUswLQ4DkskVLV+ox31pEUw3nocNfZYJ8QDstT8pY+Y2dPLBrHERvWo77T+56l3kdv5TYAWmX2vayCGp5I0dcFnGO0YUD+JHovi2Cj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ADcrsOKZ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250908091803epoutp010fc6022a7fefe9f3cefe8e4b644e6a19~jRAiqNzEx2777527775epoutp01n
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250908091803epoutp010fc6022a7fefe9f3cefe8e4b644e6a19~jRAiqNzEx2777527775epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757323083;
	bh=DxWOi6X/2j1jgcG8gMqvq6+p4MwwlbNq5ZFmqB5jV5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ADcrsOKZkm8MKM2FYssm5gTQu8JgaRoUAUK0h2ayzTJIFXNt8MKPD8hFLgNwp33Kn
	 Q/8QcJv/RyIII5TytRwnWA+vwCOCbycjFoWzoxdWr9OZIykomXJMI0qTKYIp5pAE/k
	 4SOfuJZVsV71aIzmvPgY++B0NzOy8V0YbT+beKFU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250908091803epcas5p1d6ddf147d92c88b7d6ba23b47ebed66c~jRAiHnzAL1532815328epcas5p1B;
	Mon,  8 Sep 2025 09:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cL1Zf6R3fz3hhT3; Mon,  8 Sep
	2025 09:18:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250908053635epcas5p46748ea95e52617e58fd31049208bc22d~jN-LflqTT1041210412epcas5p4N;
	Mon,  8 Sep 2025 05:36:35 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250908053634epsmtip19fc36e72781bdd2c86915535c53cbe40~jN-J-hS3Q2951529515epsmtip1x;
	Mon,  8 Sep 2025 05:36:34 +0000 (GMT)
Date: Mon, 8 Sep 2025 11:06:28 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V2 07/20] nvdimm/namespace_label: Update namespace
 init_labels and its region_uuid
Message-ID: <1983025922.01757323082896.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68bb43351ea_9916329427@iweiny-mobl.notmuch>
X-CMS-MailID: 20250908053635epcas5p46748ea95e52617e58fd31049208bc22d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NUum2bl.CiaUPDLBlJLeOFPEqthXJjtuaYQe8aeKsoDg0nUl=_ed1d7_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250730121231epcas5p2c12cb2b4914279d1f1c93e56a32c3908
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121231epcas5p2c12cb2b4914279d1f1c93e56a32c3908@epcas5p2.samsung.com>
	<20250730121209.303202-8-s.neeraj@samsung.com>
	<68a4c8d971529_27db9529479@iweiny-mobl.notmuch>
	<1690859824.141757055784098.JavaMail.epsvc@epcpadp2new>
	<68bb43351ea_9916329427@iweiny-mobl.notmuch>

------NUum2bl.CiaUPDLBlJLeOFPEqthXJjtuaYQe8aeKsoDg0nUl=_ed1d7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/09/25 03:08PM, Ira Weiny wrote:
>Neeraj Kumar wrote:
>> On 19/08/25 01:56PM, Ira Weiny wrote:
>> >Neeraj Kumar wrote:
>> >> nd_mapping->labels maintains the list of labels present into LSA.
>> >> init_labels() prepares this list while adding new label into LSA
>> >> and updates nd_mapping->labels accordingly. During cxl region
>> >> creation nd_mapping->labels list and LSA was updated with one
>> >> region label. Therefore during new namespace label creation
>> >> pre-include the previously created region label, so increase
>> >> num_labels count by 1.
>> >
>> >Why does the count of the labels in the list not work?
>> >
>> >static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
>> >{
>> >        int i, old_num_labels = 0;
>> >...
>> >        mutex_lock(&nd_mapping->lock);
>> >        list_for_each_entry(label_ent, &nd_mapping->labels, list)
>> >                old_num_labels++;
>> >        mutex_unlock(&nd_mapping->lock);
>> >...
>> >
>>
>> Hi Ira,
>>
>> init_labels() allocates new label based on comparison with existing
>> count of the labels in the list and passed num_labels. If num_labels
>> is greater than count of the labels in the list then new label is
>> allocated and stored in list for later usage
>
>I think I'm following better but shouldn't this hunk be included in the
>code which creates the region label in the list?
>

Yes we can include this hunk in patch 5 where we are updating region
label. I will drop this commit and include it in patch 5.

>I'm concerned that this '+ 1' out of the blue and will be confusing in the
>future.  Why can't count be kept up to date when the region label was
>created and added?

Yes this '+1' is hardcoded and it creating confusion. I will fix this
with available region labels in the list.

>
>What code (patch) added this region label?
>
>Ira

Patch 5 add this region label using nd_pmem_region_label_update()


Regards,
Neeraj

------NUum2bl.CiaUPDLBlJLeOFPEqthXJjtuaYQe8aeKsoDg0nUl=_ed1d7_
Content-Type: text/plain; charset="utf-8"


------NUum2bl.CiaUPDLBlJLeOFPEqthXJjtuaYQe8aeKsoDg0nUl=_ed1d7_--


