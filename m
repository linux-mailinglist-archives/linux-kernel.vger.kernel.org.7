Return-Path: <linux-kernel+bounces-789900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366CEB39C53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B9E466262
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8E730F7F3;
	Thu, 28 Aug 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEbsDSKO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3930FC2D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382960; cv=none; b=u3469zMpdA5yzhIS93tpyl0dm5opxXC9ijjt+DRaCxwAc4Cyg0CSAdGWFOVoIqoBb//QkMRH8IzW/lwxbvoAerQ6zM6VF8/L4jacsyO0MIIvUi7md9AJczuHwGDd3PM1pB06nBYd3qhg6hEDQRRNSSPEY0uGVlDc7YOiYub8XAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382960; c=relaxed/simple;
	bh=00isV9pgMOT+EOxLZrvOcj/hyY1mQftLr8hMFssxPt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1tUHgkNRKiu2j6JL/xUrMXAs88av72Qqpyy8DOsGz8EacW1Bj2MaI0ZOtC35KdhPw/634pxvZestc1aTBAgR7vdOeA3bLcFhV93b9lMkBsv8/ub/ezRTg9yAoe+kFr81JL7Rcz+MCWEc+mW5+OIove0Eau2eYJR0tZEm+TtJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEbsDSKO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756382957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeaggWAAFNQCZlCBo2LizV3WKfNjpyXN5B4dcdfNqIM=;
	b=AEbsDSKOqFmI6DTnsXfX/GYoF1dzf/WSZcFtn7YJv6ZgM3/5hnep70bQJnMn8XcftEMo0M
	at2lC5kjiZD1rKUTWbWkSc48qOp+yndWARUIZq4kPdA9SZd03qfo/IdxiCEr+3b0F4RwB5
	D2S89AH/XpemvwKnq8tJHBPF99eF7vw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-h4rSok_AP3y182jUk-5QhA-1; Thu,
 28 Aug 2025 08:09:14 -0400
X-MC-Unique: h4rSok_AP3y182jUk-5QhA-1
X-Mimecast-MFC-AGG-ID: h4rSok_AP3y182jUk-5QhA_1756382953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A1271800291;
	Thu, 28 Aug 2025 12:09:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F11C51800447;
	Thu, 28 Aug 2025 12:09:02 +0000 (UTC)
Date: Thu, 28 Aug 2025 20:08:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
Message-ID: <aLBG2VCNZEnSYxx9@fedora>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
 <aK69gpTnVv3TZtjg@fedora>
 <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Aug 28, 2025 at 05:28:26PM +0800, Li Nan wrote:
> 
> 
> 在 2025/8/27 16:10, Ming Lei 写道:
> > On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
> > > 
> > > 
> > > 在 2025/8/27 9:35, Ming Lei 写道:
> > > > On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
> > > > > Hi,
> > > > > 
> > > > > 在 2025/08/27 8:58, Ming Lei 写道:
> > > > > > On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
> > > > > > > From: Li Nan <linan122@huawei.com>
> > > > > > > 
> > > > > > > In __blk_mq_update_nr_hw_queues() the return value of
> > > > > > > blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> > > > > > 
> > > > > > Looks we should check its return value and handle the failure in both
> > > > > > the call site and blk_mq_sysfs_register_hctxs().
> > > > > 
> > > > >   From __blk_mq_update_nr_hw_queues(), the old hctxs is already
> > > > > unregistered, and this function is void, we failed to register new hctxs
> > > > > because of memory allocation failure. I really don't know how to handle
> > > > > the failure here, do you have any suggestions?
> > > > 
> > > > It is out of memory, I think it is fine to do whatever to leave queue state
> > > > intact instead of making it `partial workable`, such as:
> > > > 
> > > > - try update nr_hw_queues to 1
> > > > 
> > > > - if it still fails, delete disk & mark queue as dead if disk is attached
> > > > 
> > > 
> > > If we ignore these non-critical sysfs creation failures, the disk remains
> > > usable with no loss of functionality. Deleting the disk seems to escalate
> > > the error?
> > 
> > It is more like a workaround by ignoring the sysfs register failure. And if
> > the issue need to be fixed in this way, you have to document it. >
> > In case of OOM, it usually means that the system isn't usable any more.
> > But it is NOIO allocation and the typical use case is for error recovery in
> > nvme pci, so there may not be enough pages for noio allocation only. That is
> > the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?
> > 
> > But NVMe has been pretty fragile in this area by using non-owner queue
> > freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
> > really necessary to take it into account?
> 
> I agree with your points about NOIO and NVMe.
> 
> I hit this issue in null_blk during fuzz testing with memory-fault
> injection. Changing the number of hardware queues under OOM is extremely
> rare in real-world usage. So I think adding a workaround and documenting it
> is sufficient. What do you think?

Looks fine for me.


Thanks, 
Ming


