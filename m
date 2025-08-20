Return-Path: <linux-kernel+bounces-776730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3FB2D0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DD07A5228
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A41A9F82;
	Wed, 20 Aug 2025 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NaSh+1mH"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44319F48D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651860; cv=none; b=I1ro117ZONEp7C7ldgD53iu5O9dWZYMcrEi5I7L6VYCZouD02iD8T/0mIpmd2090D2yID9QarkpGykCFmMweBauz2eDW6VTMvMkKonAXGQMh9uc8pUp7eUn6NaDRIpJD+M2LcH4mYLHR/fgSJk+sn+rvEArC6yBw86+82TlEcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651860; c=relaxed/simple;
	bh=kzv+jpvC5L7csXxSyd5HYKu/iYI5rnReVSxetXxdWgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SRxpNVcXHtw2mbf565eRmXe6/09PrZxQ96Siu0jEOE56Pt56C6S7ibdcDwJpBtTpASp0xs6PfWXXj8s2lHy3TJUGJigPTmECuCChsfWHaz3WSVR9DU4eoXbNRyiAeDOxANy9D/tmVdVDSgV7gYfslYXFdbH9IxIavqnItDfC0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NaSh+1mH; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250820010415epoutp013e8f4e97f2ac4d670462dcd43dbf387c~dVA98T19v0442704427epoutp01S
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:04:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250820010415epoutp013e8f4e97f2ac4d670462dcd43dbf387c~dVA98T19v0442704427epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755651855;
	bh=wCYIQyAJiOuaJphtdWGWzF82otRQ8kALPJ+EqpjWN7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaSh+1mHnQJ7DQvMWUa6/oP8gJoltp4WjdmSBC1Nf7PqxkFgQW3QtUGkkRzTKGPNb
	 wYxzB0US4UkynuSuawqw2QQ3dbqkPgs311SQFyNcYd/dwTyLAHBJf/hTMJ21RsxwR+
	 JtuM1YEts1G+TwP+B5iXdPTxNY8xiNlwcJozeVZ4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250820010414epcas5p356a261c56c6abec8b7ad1a7da685b96c~dVA9SoAza3019030190epcas5p3l;
	Wed, 20 Aug 2025 01:04:14 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c67Wd2V4Lz6B9m8; Wed, 20 Aug
	2025 01:04:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250820010117epcas5p462384377e138058d135512d8ba7438b8~dU_X-HyQC2623726237epcas5p4q;
	Wed, 20 Aug 2025 01:01:17 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250820010116epsmtip29c2f7588133ceb28a37e6f9572b5de6a~dU_XDNn6x2090820908epsmtip2f;
	Wed, 20 Aug 2025 01:01:15 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: cristian.marussi@arm.com
Cc: arm-scmi@vger.kernel.org, florian.fainelli@broadcom.com,
	junnan01.wu@samsung.com, lei19.wang@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	q1.huang@samsung.com, sudeep.holla@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Set device ready before register
 scmi_virtio_driver
Date: Wed, 20 Aug 2025 09:01:23 +0800
Message-Id: <20250820010123.64603-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aKRvBrRstEFDu93g@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250820010117epcas5p462384377e138058d135512d8ba7438b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250820010117epcas5p462384377e138058d135512d8ba7438b8
References: <aKRvBrRstEFDu93g@pluto>
	<CGME20250820010117epcas5p462384377e138058d135512d8ba7438b8@epcas5p4.samsung.com>

On Tue, 19 Aug 2025 13:33:10 +0100, Cristian Marussi wrote:
> On Tue, Aug 12, 2025 at 03:53:43PM +0800, Junnan Wu wrote:
> > Fix irregularities in scmi driver probe.
> > 
> 
> Good catch, thanks for this: indeed after the transports have been
> converted to modules the probe sequence changed a bit and we cannot
> leverage anymore the virtio_device_ready() called by the core in
> virtio_dev_probe() since the scmi_vio_probe() does not complete until
> the core SCMI stack has probed with scmi_probe() which in turn transmits
> the first BASE protocol exchanges.
> 
> I did not know about this behaviour of type_1 hyp..

It's our local hyp, which intercepts notification until driver is ready.
That helps us to find this irregularity. I think you can ignore this.

> 
> > After 'commit 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")'
> > making SCMI VirtIO transport a standalone driver,
> > `scmi_virtio_probe` will follow `scmi_vio_probe`,
> > and during `scmi_virtio_probe`, it will do `scmi_probe` which will invoke
> > function `scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE)`,
> > and this function will send message via virtqueue and wait device's reply
> > 
> > Before this patch, only after `scmi_vio_probe`,
> > frontend will mark device DRIVER_OK by function `virtio_dev_probe`
> > in 'drivers/virtio/virtio.c' itself.
> > 
> > Accroding to chapter '3.1 Device Initialization' in virtio-spec,
> > ```
> > The driver MUST NOT send any buffer available notifications
> > to the device before setting DRIVER_OK.
> > ```
> > 
> > In some type1-hypervisor, available buffer notifications
> > will be intercepted until virtio driver is okay. In this case,
> > `scmi_vio_probe` will be blocked at `scmi_wait_for_reply`
> > and probe can never complete.
> > 
> > Therefore, the operation to set DRIVER_OK must follow
> > perform device-specific setup immediately,
> > then available buffer notifications can be sent in function `scmi_probe`.
> > 
> > Fixes: 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")
> > Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
> > ---
> >  drivers/firmware/arm_scmi/transports/virtio.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
> > index cb934db9b2b4..326c4a93e44b 100644
> > --- a/drivers/firmware/arm_scmi/transports/virtio.c
> > +++ b/drivers/firmware/arm_scmi/transports/virtio.c
> > @@ -871,6 +871,9 @@ static int scmi_vio_probe(struct virtio_device *vdev)
> >  	/* Ensure initialized scmi_vdev is visible */
> >  	smp_store_mb(scmi_vdev, vdev);
> >  
> > +	/* Set device ready */
> > +	virtio_device_ready(vdev);
> > +
> >  	ret = platform_driver_register(&scmi_virtio_driver);
> >  	if (ret) {
> >  		vdev->priv = NULL;
> 
> ...also, I suppose, that here nothing is to be done on the error path
> regarding the vdedv status, becasue is already taken care in the error
> path of virtio_dev_probe()...am I right ? (just confirming..)
> 

Yes you are right, I also checked it, error is handled by `virtio_dev_probe`

> Maybe you could simplify a bit the commit message but other than this
> 
> LGTM.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Thanks,
> Cristian

Thanks for your kindly review!
BRs
Junnan Wu

