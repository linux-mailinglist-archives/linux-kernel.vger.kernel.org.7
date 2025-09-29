Return-Path: <linux-kernel+bounces-842578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A7FBBD128
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9270C4E63FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49F243954;
	Mon,  6 Oct 2025 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sAftzDRD"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4232472A5
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759726510; cv=none; b=YPbFVN2jbKoI4TahhrRZpIhrqBaay4WX51h/cMNynCwT1AIcgw6Ir313umfe5Y4L+U9nlbO4H44iyztkaY84mpUOi2QVeJ+5If2PquUL/e9xHGQSp8TH9dxLEElGzuq9zbwaFAvw2uGm6okb548ThIgvyG2XLALHYe0FPpwXANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759726510; c=relaxed/simple;
	bh=u4Rkk/XPq4sm1ecP5jFSaYINMSC9Q3ZShnVbxXlHPag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=kYd77PYIcdcZ6BMfzI7idQS80HLD9mcw3ihm+ak4hpX5QMRGvTmoE+MFLga373SkZXMlgzRucruxMY1dgbgTAjBEFE6sJRn+wan2IZ1EZ23UVr3l2YBlmIgEhuD/0otq3KAXTdn0OmeVOZfjLpqJe+Vd78+dOUx1C7HJ/h2Gdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sAftzDRD; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251006045504epoutp023cae133b469515053b75ad150fae0db7~rze62Dwzn1050110501epoutp02l
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:55:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251006045504epoutp023cae133b469515053b75ad150fae0db7~rze62Dwzn1050110501epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759726504;
	bh=u4Rkk/XPq4sm1ecP5jFSaYINMSC9Q3ZShnVbxXlHPag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sAftzDRDEgAd9o82lEuWD4qn7f8jnOcFX9AXNNue1Z/pOFyO/EKVPtD9pNL6ZYJgG
	 vVcTe9giFU9+OBzAkUGRcv9Y8ZYWXAydlSQ/ZkASJ6ILcywsj2vFQ00WVCXXQO+xns
	 EU3sg7qulrvROtkVBYcC6Za4Z2XpNDel40irA1K8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251006045504epcas5p4a0c3caf21317c3ac1e6000b8750b68cb~rze6iIuQr2196921969epcas5p4n;
	Mon,  6 Oct 2025 04:55:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cg6QJ1N1lz3hhT7; Mon,  6 Oct
	2025 04:55:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250929135210epcas5p38239fc5a1426ee49707e1fc2e11e81fe~pxS4ES8Ib1329113291epcas5p3l;
	Mon, 29 Sep 2025 13:52:10 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250929135209epsmtip1893dc67ae02275be0dacfb510be74402~pxS21k5db1115311153epsmtip1P;
	Mon, 29 Sep 2025 13:52:09 +0000 (GMT)
Date: Mon, 29 Sep 2025 19:22:06 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 16/20] cxl/mem: Preserve cxl root decoder during mem
 probe
Message-ID: <439928219.101759726504189.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0bcc237d-08ba-4909-8ad2-748570cbc1db@intel.com>
X-CMS-MailID: 20250929135210epcas5p38239fc5a1426ee49707e1fc2e11e81fe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_7480_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134203epcas5p3819aee1deecdeaed95bd92d19d3b1910
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134203epcas5p3819aee1deecdeaed95bd92d19d3b1910@epcas5p3.samsung.com>
	<20250917134116.1623730-17-s.neeraj@samsung.com>
	<0bcc237d-08ba-4909-8ad2-748570cbc1db@intel.com>

------fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_7480_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/09/25 11:23AM, Dave Jiang wrote:
>
>
>On 9/17/25 6:41 AM, Neeraj Kumar wrote:
>> Saved root decoder info is required for cxl region persistency
>
>Should squash this patch into the previous patch. It's small enough that the usage and the implementation can be in the same patch.
>

Yes its small change. I will squash this in previous patch.

Regards,
Neeraj

------fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_7480_
Content-Type: text/plain; charset="utf-8"


------fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_7480_--


