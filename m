Return-Path: <linux-kernel+bounces-769980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC374B2759D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5C11757B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCF298CB7;
	Fri, 15 Aug 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="doU5Vdgu"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B73295DA6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224633; cv=none; b=Sp0/yKa+Oj8FQvC9p3g9qysCctW3QvwhgDOXYaSFUgp7zpZbz99BpeKUJWTsFUgcaEJtDXr6lzmol6rpcwAn54lTRRkTcvWFIVNDm9SEvoVMUBuUrqLCUSHQv+hr/YdlFA5572JSgM66TgaXbbKsCbzrnj33PEgvPy4mNqTTrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224633; c=relaxed/simple;
	bh=iGpiuMVJGtdIkVmTfPfuyQdh6Q2Q7FQkJ4+ZghkWp8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jH8sX6IGiNsMTBx+STPAWPqhL6jCkjUPtxeu0PcY1m6mmKwRHXIbNE7ILicCqbVJ6D5jRVcAGtcawbF+MWDvTGx2rdBiUEsrH5pK44dyTn/ovH5lsrbhlgexgtr8Hp9sRoDwVaI90qKH8VFAurK7MEdMNcv4KiuAn48mXGTHhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=doU5Vdgu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250815022349epoutp0298ace87df6dc92fc98cc0d104ed87ffa~bz4ApePdz2430824308epoutp02U
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:23:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250815022349epoutp0298ace87df6dc92fc98cc0d104ed87ffa~bz4ApePdz2430824308epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755224629;
	bh=iGpiuMVJGtdIkVmTfPfuyQdh6Q2Q7FQkJ4+ZghkWp8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doU5VdguGL4XDnEWBbWCz/83cedC4XqZ7VTQclZJrb7IdleYK0IfBdj/D6Z4n8ZtM
	 /6VvmR1FPgoVZdzUj1H/KgFwvvM+fDQx4qowAoFJiZ5FgCwOGpJ0S1qq5mffsoOFaV
	 dCVt0SmXIaxCbnuom9wfH5YYU2Hp3sMQQJbJsomw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250815022348epcas5p308b1e84b1a51311e6e2950c378d07b95~bz4AAI9g12290922909epcas5p3K;
	Fri, 15 Aug 2025 02:23:48 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c35Wl3Yxlz2SSKX; Fri, 15 Aug
	2025 02:23:47 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e~bz3QdmzWE1407014070epcas5p3H;
	Fri, 15 Aug 2025 02:22:57 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250815022255epsmtip19fe40763e2627809b0c5ccca38b858a7~bz3O_gx3L0969109691epsmtip1z;
	Fri, 15 Aug 2025 02:22:55 +0000 (GMT)
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
Date: Fri, 15 Aug 2025 10:23:08 +0800
Message-Id: <20250815022308.2783786-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e
References: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
	<CGME20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e@epcas5p3.samsung.com>

Sorry, I basically mean that the tx napi which caused by userspace will not be scheduled during suspend,
others can not be guaranteed, such as unfinished packets already in tx vq etc.

But after this patch, once `virtnet_close` completes,
both tx and rq napi will be disabled which guarantee their napi will not be scheduled in future.
And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `netif_device_detach`.

Thanks.

