Return-Path: <linux-kernel+bounces-827556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60337B92121
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB1E19040D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BAB30BB8F;
	Mon, 22 Sep 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QBj6/FJ+"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4B30E0FB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556388; cv=none; b=b2XwCMSv42xGoOwh/O5MaW5Z554q3gVNk6ktUi1Jn8Axy+j73+U02i6bxTKMlOobwhKMRkum3FgGHoUjpTT98O2j4272ExZl6m8WwTOkVexaRU+ITjfYShXw/wm+laMTCLeAbeD0J9T/bIocZAJrmRFS9HdgFjBY+5kAZ15+sDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556388; c=relaxed/simple;
	bh=UO9DQsrKA93JMMQ0MKH6EUkVh9p3xM8BKS5q1KtAVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=KkyooDBOvkl7rLbAm3VgoWHi+BuM0fez4kmM9Z4/OyHk3CqKV6u1VfE8IxSNSKAc6oSitaF92u+bHUEYq7FhEpDBDIK+wHd8yx0+r7ujAhQigmeCxUTzeQpaZMJn4ZFsgwHEFZKyIauKthg8LreGxt8SjCIKpTT+SjWB55BHrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QBj6/FJ+; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250922155304epoutp041a079170e1652fe2e9d5ce08fcbc792e~npbbSYeQw2096620966epoutp04I
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250922155304epoutp041a079170e1652fe2e9d5ce08fcbc792e~npbbSYeQw2096620966epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758556384;
	bh=PVd11SH1umpLuTwKukA509cqXTgpF93/PRhn1vgp1GA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QBj6/FJ+hkoZGUnS2nAwzbAbALmgBHZEIKjLjiMZw6dyXvpum0Ramut76Q8DUxwaC
	 1UZQEm8Z5eN5+Ms1JPS0ev59Ig8D32j3pjccHKD0PNbIb8+IlQyHIGYXHP9Py9wZ5d
	 X/sJ0vqC8/fbFR2M6eYVSEXzzviXvIVf/DjYwJzc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250922155303epcas5p2f292b1c915746b799e0bb319493f2f33~npbadzrlk0096500965epcas5p2q;
	Mon, 22 Sep 2025 15:53:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cVngz1dRzz6B9m5; Mon, 22 Sep
	2025 15:53:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250922130536epcas5p4dab9590bdc86b86dc3d8ad92ac9346c6~nnJNs1ET90059300593epcas5p4v;
	Mon, 22 Sep 2025 13:05:36 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250922130534epsmtip10e7ced87578cd0711d11a8a085964319~nnJLce0H50967409674epsmtip1G;
	Mon, 22 Sep 2025 13:05:33 +0000 (GMT)
Date: Mon, 22 Sep 2025 18:35:29 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 05/20] nvdimm/namespace_label: Add namespace label
 changes as per CXL LSA v2.1
Message-ID: <439928219.101758556383225.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68cdd281bd9bf_1a2a1729410@iweiny-mobl.notmuch>
X-CMS-MailID: 20250922130536epcas5p4dab9590bdc86b86dc3d8ad92ac9346c6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d2b_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134138epcas5p2b02390404681df79c26f7a1a0f0262b8
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134138epcas5p2b02390404681df79c26f7a1a0f0262b8@epcas5p2.samsung.com>
	<20250917134116.1623730-6-s.neeraj@samsung.com>
	<68cdd281bd9bf_1a2a1729410@iweiny-mobl.notmuch>

------eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d2b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/09/25 05:00PM, Ira Weiny wrote:
>Neeraj Kumar wrote:
>> CXL 3.2 Spec mentions CXL LSA 2.1 Namespace Labels at section 9.13.2.5
>> Modified __pmem_label_update function using setter functions to update
>> namespace label as per CXL LSA 2.1
>
>Again I'm curious as to why?
>
>Is it to be able to use the setter's later?  I see a call to
>nsl_set_type() added later in the series but then deleted in an even later
>patch.  (??)
>
>I don't have time ATM to really follow this through but giving a why in
>the commit message may have made this a simple patch to review.  Now I'm
>not clear if it is ok or not.

Hi Ira,

Yes these setter functions are required because of namespace
modifications as per LSA 2.1.

Actually it looks deleted due to refactoring of __pmem_label_update() in
later patch.

I got your point, I will re-arrange it after __pmem_label_update() refactoring.


Regards,
Neeraj

------eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d2b_
Content-Type: text/plain; charset="utf-8"


------eh7qRvcfO6PRFbEYZqDEORj5Ys3ZDDqSWzhM1v_RBQGd0jaZ=_26d2b_--


