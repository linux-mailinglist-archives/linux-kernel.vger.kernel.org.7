Return-Path: <linux-kernel+bounces-768028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 213FFB25C12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF61C84650
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540B254855;
	Thu, 14 Aug 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oTNIqIKK"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABD2356C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153866; cv=none; b=IZ3A8vPYNChpWcXhNeR8QeNW647VqaF11ibPLEOucGv7YO9kCgvvPKEO8ARqL85Zo3l5vbAbnM0Ef8qOG/G1qGbTPLdcE8aSko/0k6QNkXqsZbGUHdr0krTnzxhZyXpP6q1t2Kb0SkpbdDRQb+OQO1yxJQoG8CQ1GJcNRgJSuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153866; c=relaxed/simple;
	bh=59laSJQXWlSlK+B9v18tia5SiJt6XeLEoP4+l1sdaAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=U68emqdojRXSup/D2Y/OatatlJ5KOSm9Zo/64OntWUUMFgeQLinHAtOqKsoOTmjASuZx69g8smSECIzcdTp2uoDwUoV5N4s80QdgG+/tl9Ax9lzD77r6bmGygpJYOW7L2Ar4uGaPgmyZ/BOQ6gN9oF2R4sE7s9D424v7aRSLEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oTNIqIKK; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250814064421epoutp04ea08124560846583195951aae8eec3ca~bjyNEBXGH1066210662epoutp04N
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:44:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250814064421epoutp04ea08124560846583195951aae8eec3ca~bjyNEBXGH1066210662epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755153861;
	bh=9mu3Kr43gODSkwREa2kQCSQaS5/A6ZAwGOOHIA57X8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTNIqIKKSOtkgJ6jJF7hTbctRaDfTayLvBBoyt8hmSJG2B06QJZogL2BU/0adWrBK
	 c49TFT0qJP5BAXGLjwPi3HES7ktqPgODYYRl3Ed9WUaRTtjBwuyAhSC5Qrcy3Vp448
	 hsSMKkaMDb7OX0mXQquopA6WBKYaj0lGwAWbPDc4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250814064420epcas5p4613140cca937d212d6247e63ece17107~bjyMCR9ZD0489104891epcas5p4x;
	Thu, 14 Aug 2025 06:44:20 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2bLq0FjHz2SSKh; Thu, 14 Aug
	2025 06:44:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3~bi88aUFnB0059300593epcas5p1-;
	Thu, 14 Aug 2025 05:43:21 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250814054318epsmtip150bf90dc5ddaa45d1c93f3e7189cc7e2~bi86DY1py0648906489epsmtip1E;
	Thu, 14 Aug 2025 05:43:18 +0000 (GMT)
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
Date: Thu, 14 Aug 2025 13:43:33 +0800
Message-Id: <20250814054333.1313117-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3
References: <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com>
	<CGME20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3@epcas5p1.samsung.com>

On Thu, 14 Aug 2025 12:01:18 +0800 Jason Wang wrote:
> On Thu, Aug 14, 2025 at 10:36 AM Junnan Wu <junnan01.wu@samsung.com> wrote:
> >
> > On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > > Sounds like a fix people may want to backport. Could you repost with
> > > an appropriate Fixes tag added, pointing to the earliest commit where
> > > the problem can be observed?
> >
> > This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414633"
> > After this patch, during `virtnet_poll`, function `virtnet_poll_cleantx`
> > will be invoked, which will wakeup tx queue and clear queue state.
> > If you agree with it, I will repost with this Fixes tag later.
> >
> > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> 
> Could you please explain why it is specific to RX NAPI but not TX?
> 
> Thanks

This issue appears in suspend flow, if a TCP connection in host VM is still
sending packet before driver suspend is completed, it will tigger RX napi schedule,
Finally "use after free" happens when tcp ack timer is up.

And in suspend flow, the action to send packet is already stopped in guest VM,
therefore TX napi will not be scheduled.

