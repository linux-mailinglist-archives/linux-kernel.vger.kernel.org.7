Return-Path: <linux-kernel+bounces-827200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822AB91239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54837AE5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49A3064A0;
	Mon, 22 Sep 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KgcDunUy"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92208304BDF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544594; cv=none; b=bULRvDmf4ReRF9LhZcMaef+9hqySAViFtwTxPObiidwPOD2R1SJYtedRyM/gtmrA8nETL416/fda0ZUhFAI2LhHRdfl5I0bSxCYzGxrg9h7/NvMNU1gjLWy/mpiQDPGSXm2UMOcRviV+ckGt4VbpthOnLJyd40906zQInHKm6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544594; c=relaxed/simple;
	bh=/2dFLXefAWec9kPIFBiOdf7vvOvOOA/2JEGtLWgKrBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=kOfzL/2nIQGWozRqSx5MMyuoq+jooG40sIhXovcU5w+XCxKhEkJmjqmOsz+NiuLid8SbkfTi/oreroC3K1wQ8ng+aV1b/TF7O2FuDuisEg4/4LOxq9XKm9ebPGaq4OTibO2xYIgOHkpiN2KOKxSZogZTUIEcgaWtnV5mC5f/JSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KgcDunUy; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250922123629epoutp0337358ea282e77290815edbf7572fe078~nmvyphfKr0171301713epoutp03-
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:36:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250922123629epoutp0337358ea282e77290815edbf7572fe078~nmvyphfKr0171301713epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758544589;
	bh=/2dFLXefAWec9kPIFBiOdf7vvOvOOA/2JEGtLWgKrBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgcDunUyWDjdPF3rOSKYvgv3e3ygQ5pJBWCo812v0UlQ63iwnld59KyeWPe4u46fV
	 yx50ZRbJ7Fu9brgeQkYUhY57Kw0FWvrDigJg4wCdQVnhyvxlX8HL5g7O5q4EpjxOv2
	 khrhzZL2CYGIrnVyndBzOpJGNPwsFtYd9fbFDzE4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250922123629epcas5p2de5d21797e204a8c7012ee228404e040~nmvyNHgzQ2905229052epcas5p2K;
	Mon, 22 Sep 2025 12:36:29 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cVjK80DmCz2SSKY; Mon, 22 Sep
	2025 12:36:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250922123627epcas5p33eb3e2d65cfb1705857413dd573d17e7~nmvw7Hj8g2990029900epcas5p3g;
	Mon, 22 Sep 2025 12:36:27 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250922123626epsmtip11dcba42479f7df0af8c0a27e8e54a23c~nmvvyBGV92355923559epsmtip1c;
	Mon, 22 Sep 2025 12:36:26 +0000 (GMT)
Date: Mon, 22 Sep 2025 18:06:16 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 00/20] Add CXL LSA 2.1 format support in nvdimm and
 cxl pmem
Message-ID: <20250922123616.y6yi4heay26ktlhl@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250917155053.00004c03@huawei.com>
X-CMS-MailID: 20250922123627epcas5p33eb3e2d65cfb1705857413dd573d17e7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----9bSguDi.zIPe2mzIRptk1CwOcoXw-B36MWpfyHe4p2iroT9e=_26cb6_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917134126epcas5p3e20c773759b91f70a1caa32b9f6f27ff
References: <CGME20250917134126epcas5p3e20c773759b91f70a1caa32b9f6f27ff@epcas5p3.samsung.com>
	<20250917134116.1623730-1-s.neeraj@samsung.com>
	<20250917155053.00004c03@huawei.com>

------9bSguDi.zIPe2mzIRptk1CwOcoXw-B36MWpfyHe4p2iroT9e=_26cb6_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/09/25 03:50PM, Jonathan Cameron wrote:
>On Wed, 17 Sep 2025 19:10:56 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>
>Hi,
>Not sure what difference between the two versions I'm seeing is.
>Patch 02 is missing in both of them.
>
>Jonathan

Hi Jonathan,

Because of some compliance check, Patch 02 got delayed. Now its visible
in lore. Can you please take a look at it.


Regards,
Neeraj

------9bSguDi.zIPe2mzIRptk1CwOcoXw-B36MWpfyHe4p2iroT9e=_26cb6_
Content-Type: text/plain; charset="utf-8"


------9bSguDi.zIPe2mzIRptk1CwOcoXw-B36MWpfyHe4p2iroT9e=_26cb6_--

