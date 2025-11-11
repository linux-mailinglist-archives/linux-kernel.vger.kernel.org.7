Return-Path: <linux-kernel+bounces-894566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EBC4B50C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618264F1465
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025534AB17;
	Tue, 11 Nov 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHoqOIN4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C234AAF9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831562; cv=none; b=shylRe9kGL0gPZZVMkTI637t1Qb8trxD3FLi4RsJon0V6nk/gEuyOrp9X0Q4tOBJ/z6uGUy54CHe389po7i5Jxiu8+T6uUpM+CrNlSxnVyWbu2L5xv01lm7jpbHWH+Hh31WYFX0n6+WbDEWsM6wkS0xnTt/IKeAgRkFPVrXPNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831562; c=relaxed/simple;
	bh=OagPxu3BDFrMdi8d9a7SIWrmYUKVURgm7s+OlqgLC0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l49niCvUmBhlyhDfrfPNB/j1lIQbDFVg9f/3jZPwKTvyF6Pnu4YkABcIpGfyvlzuzfG4QTj5Rx3VtEgDdhdv+ZBmAROqOrXKNIP6Ufl3xZAb2LiOZIxvKpeMY6A7ztGmw1GviBu8tlScxCbUOkWRQe/5L6dcjdUCQcOhEvgiTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHoqOIN4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762831559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO5w3yJkudGRFXI8OauYWxvQ3+YR+NH5t9Z29OeLOJo=;
	b=bHoqOIN4kV9zf/VkWq97FaVf7WY/rgw/y6opeIhxaEMRM1QmWLCiONB3ezTH/gvsVrhD6E
	vLFzXhl2ffhebZ+ZxnHPeamRP3XPVPfPLq7I2e/RIEhwBaBmwbBcNl7jM+f2biegn1erpt
	zx/7KQ3evTu4Qyps38KQOC1BeanSqjs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-gGQa16xoORyOd_8dTj8QQg-1; Mon,
 10 Nov 2025 22:25:55 -0500
X-MC-Unique: gGQa16xoORyOd_8dTj8QQg-1
X-Mimecast-MFC-AGG-ID: gGQa16xoORyOd_8dTj8QQg_1762831553
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51BB1180048E;
	Tue, 11 Nov 2025 03:25:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 461EC30044E0;
	Tue, 11 Nov 2025 03:25:42 +0000 (UTC)
Date: Tue, 11 Nov 2025 11:25:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Wangyang Guo <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aRKssW96lHFrT2ZN@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111020608.1501543-1-wangyang.guo@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> As CPU core counts increase, the number of NVMe IRQs may be smaller than
> the total number of CPUs. This forces multiple CPUs to share the same
> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> performance penalty can be observed on some platforms.

Can you add details why/how CPU cluster isn't aligned with IRQ
affinity? And how performance penalty is caused?

Is it caused by remote IO completion in blk_mq_complete_need_ipi()?

	/* same CPU or cache domain and capacity?  Complete locally */
	if (cpu == rq->mq_ctx->cpu ||
	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
	        return false;

If yes, which case you are addressing to? cache domain or capccity?

AMD's CCX shares L3 cache inside NUMA node, which has similar issue,
I guess this patchset may cover it?

> This patch improves IRQ affinity by grouping CPUs by cluster within each
> NUMA domain, ensuring better locality between CPUs and their assigned
> NVMe IRQs.

Will look into this patch, but I feel one easier way is to build
sub-node(cluster) cpumask array, and just spread over the sub-node(cluster). 


Thanks, 
Ming


