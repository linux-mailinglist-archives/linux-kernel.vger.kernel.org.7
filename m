Return-Path: <linux-kernel+bounces-766742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32583B24A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836A216587F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5082E8E13;
	Wed, 13 Aug 2025 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="So/3wFpv"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260862E8E0E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091584; cv=none; b=IqAYKxmTyAaDgA/zFMEL5Xxem+GeNcqOX1GO3zcdVJky63OxReET03opLeiXgojoX1gHjFKV/aAv9BDPL6ZJVhcDkYgGeNQaGl66JggTrIoSdlef8d8Xb7Cpw8j8Jv7WzQOYkh6qIEOCCibyF44dqiwSth7qke6UF1wiCTG3wP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091584; c=relaxed/simple;
	bh=Uq9n0I9N5l8mMnseAxwMTJToi2ytaZfBB0V8c7fEYoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQbcUcAFfKc+pot2jV5HMcya8u6aqvm+qRKcE416Vefy6ppXjp1tg7DLrgNpCFvyLcxfZkIHm0BuiwoJYEjxzbVZISwe2I62X4DCSZjBM3bB1PY1/AhjdNjsH5fahd8xGPLpANE+wm3/ugMyRQBvw1qH4OtDLFIV4+24VAgQi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=So/3wFpv; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755091575;
	bh=D2wtmkC5cRwj57r9Km0rnHswAsCqKsDcHe53mfuX6aA=;
	h=From:Subject:Date:Message-ID;
	b=So/3wFpvuBsMRESAH4y0b4b8lX8cCJeiU45NTFWDMxMyJTQ8KoZDUEMYtoWyRfsZI
	 mDMSMzAkwAh6HVe5uMw2y4B9YSGFjhgJxBDgNZ+yJlodSNoaOgaGrfkpdEdzOehUzi
	 vhX9KkitrfSvZSPxI0JzO1mBNQT4vyJI/E4Nj7XM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689C926B0000478F; Wed, 13 Aug 2025 21:26:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4862744456671
X-SMAIL-UIID: F3A7C21EFC92444F91B50E695AC80BA3-20250813-212606-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Wed, 13 Aug 2025 21:25:53 +0800
Message-ID: <20250813132554.4508-1-hdanton@sina.com>
In-Reply-To: <20250812112226-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-10-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > transmit data. Unfortunately, these are always linear allocations and
> > can therefore result in significant pressure on kmalloc() considering
> > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > allocation for each packet.
> > 
> > Rework the vsock SKB allocation so that, for sizes with page order
> > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > instead with the packet header in the SKB and the transmit data in the
> > fragments. Note that this affects both the vhost and virtio transports.
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> So this caused a regression, see syzbot report:
> 
> https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> 
> I'm inclined to revert unless we have a fix quickly.
> 
Because recomputing skb len survived the syzbot test [1], Will looks innocent.

[1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/

