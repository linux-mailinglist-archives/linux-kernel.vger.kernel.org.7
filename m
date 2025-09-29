Return-Path: <linux-kernel+bounces-842585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E9BBD137
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C0274E718E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BCF26059F;
	Mon,  6 Oct 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kEVrJkBz"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8924247287
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759726512; cv=none; b=rGojKmWz3JMPsTN1OYUUDgKPxkrgy1UvqT54rf2ZMHwUEKEk+InUxITpZbFQ1gnPWpQY6LfNxYwin8O7Hb+j+VyDRLIMrc01maXHwWzlwQoBEgylZSPuO4NSmayBr4ZsQfS1+8oP+4vjgjDIraGQRvCejLRRvlaDAPjM16sidIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759726512; c=relaxed/simple;
	bh=wYWRqaWgm9+8LwpbAuK4DIVyqxpOMPZ25ln6t5GlOtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=i6w6mwCFGru39vkS/0/NEEAxPVaBraEYOxBquPtJy/wxYsNFAWZT9y87kMTpHcv9wW2SDVOlJDp25rE45d5hHQkiXnm3rFa+yDqtTU2Oh81pP3zYiWIHjTDIBpTJ8b2iXzCW0uzyfAolYSUZnxs+tWZrabnTRFVe2JRQGqKIkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kEVrJkBz; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251006045505epoutp0397a82c3bc21b083002639b2dd6785ef9~rze7pnfot1934019340epoutp03g
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251006045505epoutp0397a82c3bc21b083002639b2dd6785ef9~rze7pnfot1934019340epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759726505;
	bh=wYWRqaWgm9+8LwpbAuK4DIVyqxpOMPZ25ln6t5GlOtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEVrJkBziTseHHuA5IcVQQ9A6BKdsPHVpfcg5N4BMuaLIWSjME2XNG37MyJJmzydA
	 RkPlQ2ulRAnvg1AUsLZi4hHugOmwcKjcsCX72FSyEDM34Krj7o9qKIVAJPEqIprWs2
	 Ejf8YSe8IWcHo4weJP5FzTKX76u/L5ZusbVr8vYo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251006045504epcas5p3463d09bf1ea661f5ec0cd5087d20a1fd~rze7NsuTf1614616146epcas5p3C;
	Mon,  6 Oct 2025 04:55:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cg6QJ6ZDrz3hhTC; Mon,  6 Oct
	2025 04:55:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250929141021epcas5p1856cbd760322aabca3ee38fb3424ccde~pxiwLZU6-3124931249epcas5p1S;
	Mon, 29 Sep 2025 14:10:21 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250929141019epsmtip249173b129c91412d17862a1d7d5f4932~pxiuNGBPI1938219382epsmtip2C;
	Mon, 29 Sep 2025 14:10:19 +0000 (GMT)
Date: Mon, 29 Sep 2025 19:40:14 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH V3 08/20] nvdimm/label: Include region label in slot
 validation
Message-ID: <306123060.201759726504908.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aNRjE9gckXeC60-Q@aschofie-mobl2.lan>
X-CMS-MailID: 20250929141021epcas5p1856cbd760322aabca3ee38fb3424ccde
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_75ac_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134144epcas5p498fb4b005516fca56e68533ce017fba0
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134144epcas5p498fb4b005516fca56e68533ce017fba0@epcas5p4.samsung.com>
	<20250917134116.1623730-9-s.neeraj@samsung.com>
	<aNRjE9gckXeC60-Q@aschofie-mobl2.lan>

------fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_75ac_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/09/25 02:30PM, Alison Schofield wrote:
>On Wed, Sep 17, 2025 at 07:11:04PM +0530, Neeraj Kumar wrote:
>> Slot validation routine validates label slot by calculating label
>> checksum. It was only validating namespace label. This changeset also
>> validates region label if present.
>
>Neeraj,
>
>Was it previously wrong 'only validating namespace label'
>- or -
>Is validating region label something new available with cxl
>namespaces that we now must add?
>
>I'm looking for that pattern in these commit messages, ie
>this is how it use to be, this is why it doesn't work now,
>so here is the change.
>
>-- Alison
>

Hi Alison,

Earlier labels were meant only as namespace lables. LSA 2.1 introduces
new region label because of this slots for both namespace and region
labels should be validated.

May be I will elaborate the commit message to properly communicate
this information


Regards,
Neeraj


------fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_75ac_
Content-Type: text/plain; charset="utf-8"


------fevm_dXp0U54qslEOU8oiqO.VnigTQz743t4hqwhjBnK2JlQ=_75ac_--


