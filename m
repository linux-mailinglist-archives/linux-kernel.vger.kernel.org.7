Return-Path: <linux-kernel+bounces-774798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D10B2B7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D2F7B6B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48092FC874;
	Tue, 19 Aug 2025 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XAv7CCLM"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423112EE5FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574472; cv=none; b=czgZcDrv6xbQi+Pr95Jkhm4j9ZYr3bVbeFUHNubm1NxyOH8C8k170QMo/N9W6OCik/qrW6ZNaZAfoZoUgueH9zO7wjecfhX/KgwzSOqAl1jrpYN42kuZxBy0dIvztCXH3gKlMbeeSkKzNNQV873NU3PV3dibYm6QEXiq4p5NMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574472; c=relaxed/simple;
	bh=JKNZX2bbEIrC8xCWZSb+vHXAfSZLVZNxXfIdG7LwcsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SSqz0x/P4K/AYW3Z99mFCQifhxmU3BUMDktxYe8hjMT7A//gTB4ATG4aorR9pT3/yhvzyqNR7Ii05yJFaFnE6e+zzNXVYiQMKLwWsMDfJ6V2TxAxrlgzIadjph8PfWRExMuvN9iUPBqSjtBhyJHITW4uFWfty/G9QILRZKa827Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XAv7CCLM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250819033421epoutp039e68d971e0a7e9af049af36a096c2c60~dDavowUhF0871108711epoutp03w
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250819033421epoutp039e68d971e0a7e9af049af36a096c2c60~dDavowUhF0871108711epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755574461;
	bh=Hsc9puMhPwaXFA5i4kUspsGUpcSO7N7D73eS4uhdn3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAv7CCLM6SQreTulkQMq4em7c1xdncPU0BbOGn72h1yGzDf2reKDAFT53/LGf7Rvi
	 uVWulezwXSgwqdt4SVA//YSk6KUE7ECtdMi5HiLNq+BDzRDiH64XpAs3u87Pjjnr1x
	 8YzLaIRFMpRw4J1uRoJ1jWfNSPxKvar/br7kHh+Q=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250819033421epcas5p386142418c9dce35e45e0a8ed238f7a60~dDavLPnx-1213112131epcas5p3t;
	Tue, 19 Aug 2025 03:34:21 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c5ZvJ1tHGz6B9mD; Tue, 19 Aug
	2025 03:34:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a~dDZ034sxy1308013080epcas5p3B;
	Tue, 19 Aug 2025 03:33:18 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250819033316epsmtip2600ea94da3ad14d0a16bd9af8a307fec~dDZzQbId-1926619266epsmtip2D;
	Tue, 19 Aug 2025 03:33:16 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: jasowang@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, junnan01.wu@samsung.com, kuba@kernel.org,
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Tue, 19 Aug 2025 11:33:26 +0800
Message-Id: <20250819033326.3602994-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a
References: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
	<CGME20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a@epcas5p3.samsung.com>

On Tue, 19 Aug 2025 10:48:37 +0800 Jason Wang wrote:
> On Mon, Aug 18, 2025 at 11:39 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 18 Aug 2025 09:15:22 +0800 Junnan Wu wrote:
> > > > > Yes, you are right. The commit of this fix tag is the first commit I
> > > > > found which add function `virtnet_poll_cleantx`. Actually, we are not
> > > > > sure whether this issue appears after this commit.
> > > > >
> > > > > In our side, this issue is found by chance in version 5.15.
> > > > >
> > > > > It's hard to find the key commit which cause this issue
> > > > > for reason that the reproduction of this scenario is too complex.
> > > >
> > > > I think the problem needs to be more clearly understood, and then it
> > > > will be easier to find the fixes tag. At the face of it the patch
> > > > makes it look like close() doesn't reliably stop the device, which
> > > > is highly odd.
> > >
> > > Yes, you are right. It is really strange that `close()` acts like
> > > that, because current order has worked for long time. But panic call
> > > stack in our env shows that the function `virtnet_close` and
> > > `netif_device_detach` should have a correct execution order. And it
> > > needs more time to find the fixes tag. I wonder that is it must have
> > > fixes tag to merge?
> > >
> > > By the way, you mentioned that "the problem need to be more clearly
> > > understood", did you mean the descriptions and sequences in commit
> > > message are not easy to understand? Do you have some suggestions
> > > about this?
> >
> > Perhaps Jason gets your explanation and will correct me, but to me it
> > seems like the fix is based on trial and error rather than clear
> > understanding of the problem. If you understood the problem clearly
> > you should be able to find the Fixes tag without a problem..
> >
> 
> +1
> 
> The code looks fine but the fixes tag needs to be correct.
> 
> Thanks

Well, I will do some works to find out the fixes tag.
Once there's progress, I will let you know.

