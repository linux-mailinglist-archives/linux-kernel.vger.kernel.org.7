Return-Path: <linux-kernel+bounces-772682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41208B2960D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C454E2705
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F520DD75;
	Mon, 18 Aug 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r5bieQaQ"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461013B293
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755479994; cv=none; b=ifFNEU706HAd+Qct0VmFlpPY5Yl/9vzo6aRuexbqtXT5+dJtk9ZK5C6DtNBNhiAoC7vePQOEggE1T5LAln4SYrA8WY4GyAjO/GFyS/aNJSeI7+8laaWwYO8W/YwHM5iOgZjk84jskG5OaT0HEc4ZNfzvDChLQ69h0J/rt5aceGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755479994; c=relaxed/simple;
	bh=iMJ1oHRbauEj3lcgwQet8BFInJoPoG6llDJNmYuo08M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=rIn5rlF11GGqtmvoL3XhYer314NKc5Cbn9GMEBXE7OcvJpNSnqOTJ0uXRY0Xqaf0caQxgu/z3I7CC5sVYAQ65KpFGv/gNgIsvD4gmDNwbVoZGw0mxpTdXRX7y8Prft58/7LreD0NZHiGjSrKeSRvslV9EQVe19Qh2K5sQpBKJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r5bieQaQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250818011943epoutp04ac07f4cb0c136342f9f395fa3d8d98d9~ct756hdF62674026740epoutp045
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250818011943epoutp04ac07f4cb0c136342f9f395fa3d8d98d9~ct756hdF62674026740epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755479983;
	bh=oNTFgx0f6ht5S3wLJmJIF+ULm2VzvhkkVhPoqV1VuFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5bieQaQDK+udQuQ/GAQ5N52e5rs0LXmxAZRW3grU3xxgxroejR7nBhMq5bp/FOrj
	 91R/485IL4Owz8xUHaVPhvN4g7tBjbtDuKpcIXwQKmy1poKuoZ6rmO5LWbnYiLUfzT
	 WvwHanvYLOYWlpf70NMDpbvYko7DCy6deLZS3XgA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250818011942epcas5p2aaaec9298cbcd1112fd218a1ae73ec32~ct75Ip0qr0869608696epcas5p2p;
	Mon, 18 Aug 2025 01:19:42 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c4vyP46yvz3hhT3; Mon, 18 Aug
	2025 01:19:41 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250818011515epcas5p21295745d0e831fd988706877d598f913~ct3--8YNT1315413154epcas5p2j;
	Mon, 18 Aug 2025 01:15:15 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250818011513epsmtip12d2ab6910a9fefba463c4b8f998f0853~ct3_D_ADu1149011490epsmtip1x;
	Mon, 18 Aug 2025 01:15:12 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, jasowang@redhat.com, junnan01.wu@samsung.com,
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Mon, 18 Aug 2025 09:15:22 +0800
Message-Id: <20250818011522.1334212-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815085503.3034e391@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250818011515epcas5p21295745d0e831fd988706877d598f913
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250818011515epcas5p21295745d0e831fd988706877d598f913
References: <20250815085503.3034e391@kernel.org>
	<CGME20250818011515epcas5p21295745d0e831fd988706877d598f913@epcas5p2.samsung.com>

On Fri, 15 Aug 2025 08:55:03 -0700 Jakub Kicinski wrote
> On Fri, 15 Aug 2025 14:06:15 +0800 Junnan Wu wrote:
> > On Fri, 15 Aug 2025 13:38:21 +0800 Jason Wang <jasowang@redhat.com> wrote
> > > On Fri, Aug 15, 2025 at 10:24 AM Junnan Wu <junnan01.wu@samsung.com> wrote:  
> > > > Sorry, I basically mean that the tx napi which caused by
> > > > userspace will not be scheduled during suspend, others can not be
> > > > guaranteed, such as unfinished packets already in tx vq etc.
> > > >
> > > > But after this patch, once `virtnet_close` completes,
> > > > both tx and rq napi will be disabled which guarantee their napi
> > > > will not be scheduled in future. And the tx state will be set to
> > > > "__QUEUE_STATE_DRV_XOFF" correctly in `netif_device_detach`.  
> > > 
> > > Ok, so the commit mentioned by fix tag is incorrect.  
> > 
> > Yes, you are right. The commit of this fix tag is the first commit I
> > found which add function `virtnet_poll_cleantx`. Actually, we are not
> > sure whether this issue appears after this commit.
> > 
> > In our side, this issue is found by chance in version 5.15.
> > 
> > It's hard to find the key commit which cause this issue
> > for reason that the reproduction of this scenario is too complex.
> 
> I think the problem needs to be more clearly understood, and then it
> will be easier to find the fixes tag. At the face of it the patch
> makes it look like close() doesn't reliably stop the device, which
> is highly odd.

Yes, you are right. It is really strange that `close()` acts like that, because current order has worked for long time.
But panic call stack in our env shows that the function `virtnet_close` and `netif_device_detach`
should have a correct execution order.
And it needs more time to find the fixes tag. I wonder that is it must have fixes tag to merge?

By the way, you mentioned that "the problem need to be more clearly understood",
did you mean the descriptions and sequences in commit message are not easy to understand?
Do you have some suggestions about this?

Thanks!


