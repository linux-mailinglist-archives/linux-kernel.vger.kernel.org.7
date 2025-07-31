Return-Path: <linux-kernel+bounces-751925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D254EB16F67
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9F3B29F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA912BE041;
	Thu, 31 Jul 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSnG/wlt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC0238C25
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957379; cv=none; b=FyTx/t8BYTyJXiYGjlC2P99uRcD3TTW9CneZVMUhMTr7TdXaPT+Sn0k55ltxPNxFpULElu8RordznmLO7x11S2hPsN4sBx4zEMctL48ILl0CrTc9Lk6P4q/Hu8bgBgUPHVeQ3DZqSfO5qYxeLSk+CgZXB6HlS02MuHBH7eRh9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957379; c=relaxed/simple;
	bh=lkkuqC2vambzk9CuZzq6i1jaxoC4n9Munmr9+qei71s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUVMrG0cEYllFkeshQw/3ZuPk1rtQFS3n2sLn7Lfezyjr1m8q+XIpyiheqoF7eWQgS7EMO7rrQOGOFI+5MPEG6q+JNbfo97u8lXJzQp2pvmikVygCIeFmIDP3BgHpZF0Xya6Xlg1jaI5qgSq8rTQLg7lCvNRuJU903B2mLDl/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSnG/wlt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753957376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgIENI2JJx96NikmUSVWyLKcBHri0nd2ZYhEFTwOWPM=;
	b=ZSnG/wltvRqZiSxr3VCkXpJsaZbTTJeq+QThleWApnlAg9BzSqjoXRNX6ynFm1xKOZqZfx
	37AYqVL9i4D55bjbFu0k8iUEr3MK7yfu1QBb+gSquztFEnsfHpDAvqSDj3UdOk08IWHB7h
	x1ChC9ClcaRIKmgYgLqV49IXDAbkBwg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-lyAZYsORNXKTQrsAMXaCLQ-1; Thu,
 31 Jul 2025 06:22:51 -0400
X-MC-Unique: lyAZYsORNXKTQrsAMXaCLQ-1
X-Mimecast-MFC-AGG-ID: lyAZYsORNXKTQrsAMXaCLQ_1753957369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C3A9196E073;
	Thu, 31 Jul 2025 10:22:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AFB91800B6A;
	Thu, 31 Jul 2025 10:22:39 +0000 (UTC)
Date: Thu, 31 Jul 2025 18:22:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 0/5] blk-mq-sched: support request batch dispatching
 for sq elevator
Message-ID: <aItD6juaFaPncYka@fedora>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <aIsmvj_lxLA6ZaWe@fedora>
 <99e9aa7e-b33c-ce2e-bf0f-0021434690e8@huaweicloud.com>
 <aIs2e3wJpMmCHeZk@fedora>
 <da726ac2-28be-6fc6-d723-3277b2dd7011@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da726ac2-28be-6fc6-d723-3277b2dd7011@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Jul 31, 2025 at 05:33:24PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/31 17:25, Ming Lei 写道:
> > On Thu, Jul 31, 2025 at 04:42:10PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/07/31 16:18, Ming Lei 写道:
> > > > batch dispatch may hurt io merge performance which is important for
> > > > elevator, so please provide test data on real HDD. & SSD., instead of
> > > > null_blk only, and it can be perfect if merge sensitive workload
> > > > is evaluated.
> > > 
> > > Ok, I'll provide test data on HDD and SSD that I have for now.
> > > 
> > > For the elevator IO merge case, what I have in mind is that we issue
> > > small sequential IO one by one with multiple contexts, so that bios
> > > won't be merged in plug, and this will require IO issue > IO done, is
> > > this case enough?
> > 
> > Long time ago, I investigated one such issue which is triggered in qemu
> > workload, but not sure if I can find it now.
> > 
> > Also many scsi devices may easily run into queue busy, then scheduler merge
> > starts to work, and it may perform worse if you dispatch more in this
> > situation.
> 
> I think we won't dispatch more in this case, on the one hand we will get
> budgets first, to make sure never dispatch more than queue_depth; on the

OK.

> onther hand, in the case hctx->dispatch_busy is set, we still fallback
> to the old case to dispatch one at a time;

hctx->dispatch_busy is lockless, all request may get dispatched before
hctx->dispatch_busy is set.


Thanks,
Ming


