Return-Path: <linux-kernel+bounces-768082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F1B25CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FBF1BC1EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D526561D;
	Thu, 14 Aug 2025 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qhfBT4H0"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE6263C8E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155420; cv=none; b=qKZTOyRtC9ozBBPcBdDMDj2YV3A3vAk1gT3GJffHmzbb1xrU20J0Q8b/qzwmsOf6dO/G7WEcZkvTktQ2YAmDf8ShL/66VifD+KQEQ1FZMxFlys8w5RFL4C06juQ8+f1M/sEh+bfXCUuqSzVpw/7OBfhMhkppUYAXVdXAZt+irKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155420; c=relaxed/simple;
	bh=lch8aVeg2M0Un/tBpZiaeFcnAJXX6vJNLe9Y5YUF7QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=X09reb0x5D7raUVZfeuyx66MjdLD+JhsSA3W0woS5Pw6+5/itELBQQynsL6xyIIM8n+MLbAAXb4ARiicwDI8rHXxQ0PYRAjQJgf5cBYAGTfoC7Nk1pM/iTngddMQNEkHBAo1HgPqz/QZMkTBlBLFyesCyoXLNqAHN6lId7nwWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qhfBT4H0; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250814071016epoutp01732664d22e1d6e7dd8f5bef6737ef00a~bkI1B21zT3010930109epoutp01z
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:10:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250814071016epoutp01732664d22e1d6e7dd8f5bef6737ef00a~bkI1B21zT3010930109epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755155416;
	bh=MPvvXGlKnavvQz2YJEvA9alXVq22vI+juGIh/Eeqync=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhfBT4H05xhWw8CDTNdQ2uLh4QOZcaCoVWBqbKag0KMlhPVgkOw2f2iBN0V2wnaqd
	 nJPNl+PQvuUgW6VR8CsB35AUmqhIjmiJeuHH/nIjIAecCoyKsOlzNZTLTDGnmgr35B
	 e92AoE8tsb0D+NKeC5LUC01b/x++icKyU6neCJLk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250814071015epcas5p48b23e6cec4e265c03a1e54a4e4ea21c6~bkI0csvFj1096610966epcas5p42;
	Thu, 14 Aug 2025 07:10:15 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c2bwk3cvTz6B9m9; Thu, 14 Aug
	2025 07:10:14 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814070809epcas5p46bc5a5fe62fd5bedc8a858ae4d28a92a~bkG-hESx00412404124epcas5p4X;
	Thu, 14 Aug 2025 07:08:09 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250814070807epsmtip1de0a9e8777b9474a04c8c2fd05aa43d2~bkG9RiAJs2811428114epsmtip1R;
	Thu, 14 Aug 2025 07:08:07 +0000 (GMT)
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
Date: Thu, 14 Aug 2025 15:08:21 +0800
Message-Id: <20250814070821.1792157-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEuCaOs_towX_CGUdnpDJBPrN9vZ3=s84RKJ3PsRX5s7OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250814070809epcas5p46bc5a5fe62fd5bedc8a858ae4d28a92a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250814070809epcas5p46bc5a5fe62fd5bedc8a858ae4d28a92a
References: <CACGkMEuCaOs_towX_CGUdnpDJBPrN9vZ3=s84RKJ3PsRX5s7OQ@mail.gmail.com>
	<CGME20250814070809epcas5p46bc5a5fe62fd5bedc8a858ae4d28a92a@epcas5p4.samsung.com>

On Thu, 14 Aug 2025 14:49:06 +0800 Jason Wang wrote:
> On Thu, Aug 14, 2025 at 2:44 PM Junnan Wu <junnan01.wu@samsung.com> wrote:
> >
> > On Thu, 14 Aug 2025 12:01:18 +0800 Jason Wang wrote:
> > > On Thu, Aug 14, 2025 at 10:36 AM Junnan Wu <junnan01.wu@samsung.com> wrote:
> > > >
> > > > On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > > > > Sounds like a fix people may want to backport. Could you repost with
> > > > > an appropriate Fixes tag added, pointing to the earliest commit where
> > > > > the problem can be observed?
> > > >
> > > > This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414633"
> > > > After this patch, during `virtnet_poll`, function `virtnet_poll_cleantx`
> > > > will be invoked, which will wakeup tx queue and clear queue state.
> > > > If you agree with it, I will repost with this Fixes tag later.
> > > >
> > > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> > >
> > > Could you please explain why it is specific to RX NAPI but not TX?
> > >
> > > Thanks
> >
> > This issue appears in suspend flow, if a TCP connection in host VM is still
> > sending packet before driver suspend is completed, it will tigger RX napi schedule,
> > Finally "use after free" happens when tcp ack timer is up.
> >
> > And in suspend flow, the action to send packet is already stopped in guest VM,
> 
> The TX interrupt and NAPI is not disabled yet. Or anything I miss here?

When system suspends, the userspace progress which based on virtio_net
will be freezed firstly, and then driver suspend callback executes.
so though TX interrupt and NAPI is not disabled at that time, it will also not be scheduled.

