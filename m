Return-Path: <linux-kernel+bounces-717319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C533FAF92C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349B55A586C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8362DA756;
	Fri,  4 Jul 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiKl8KFx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC32D9EED
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632522; cv=none; b=ix1QJNMrQr+KimVGMPwqLP/B4w776qaeTO3620aj/22S24B6BwRxQg2TPVE1L2VeVLTdmnmQ/J2wosA7dcspm7wXtnqlG6F6FTNPDr7VyelrBO4RAzGNe+RBfvcnhlxeAObfnFCLXzMqnNyYVaa0WT/XycDmemYAkwGWJE+kAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632522; c=relaxed/simple;
	bh=OH/S5Xf/akubkTB/M7c41buZiBN/xKiF0+A68b+UFO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l37Djs4Bp/7wSRflt1t8U5goKM01dCiD/nDhWfsiyWr3NPBrHr9qADvc/ypDqJ00b8lJ9PxU/8iXwxrZ/A51KGVXMWwraaHwdUlnGttTaqe0uXZHBymgEphXT09Zwrr8ojopsANz9nG2IOTHd15/vUTK/OsTIGpxD1STOdhszXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiKl8KFx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751632518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YxNoGfTOaVX6gH5YqJOrBHs93Ad4uVvroRXTooz5cq8=;
	b=MiKl8KFx78qiqecuXiTEfqtJmJNw50M8THHWbuIqGcwNYuxnORuxDpQKJyG2+tX8yyjTF4
	i7y19AxjdGOwJnrXSICUcCv5idQZZZBGJg5aKro7xNpGdwQUncIpH5rs1UKNDKiFObzctN
	JWceP7xgKkCGgUC9zgD5X7RkRhje+mk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-krD5i7NPMle7W_KR2lcLfQ-1; Fri,
 04 Jul 2025 08:35:16 -0400
X-MC-Unique: krD5i7NPMle7W_KR2lcLfQ-1
X-Mimecast-MFC-AGG-ID: krD5i7NPMle7W_KR2lcLfQ_1751632515
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32D6B180136B;
	Fri,  4 Jul 2025 12:35:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD18E3000218;
	Fri,  4 Jul 2025 12:35:09 +0000 (UTC)
Date: Fri, 4 Jul 2025 20:35:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ublk: speed up ublk server exit handling
Message-ID: <aGfKd9CwU97kLyTM@fedora>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
 <20250703-ublk_too_many_quiesce-v2-1-3527b5339eeb@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-1-3527b5339eeb@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jul 03, 2025 at 11:41:07PM -0600, Uday Shankar wrote:
> Recently, we've observed a few cases where a ublk server is able to
> complete restart more quickly than the driver can process the exit of
> the previous ublk server. The new ublk server comes up, attempts
> recovery of the preexisting ublk devices, and observes them still in
> state UBLK_S_DEV_LIVE. While this is possible due to the asynchronous
> nature of io_uring cleanup and should therefore be handled properly in
> the ublk server, it is still preferable to make ublk server exit
> handling faster if possible, as we should strive for it to not be a
> limiting factor in how fast a ublk server can restart and provide
> service again.
> 
> Analysis of the issue showed that the vast majority of the time spent in
> handling the ublk server exit was in calls to blk_mq_quiesce_queue,
> which is essentially just a (relatively expensive) call to
> synchronize_rcu. The ublk server exit path currently issues an
> unnecessarily large number of calls to blk_mq_quiesce_queue, for two
> reasons:
> 
> 1. It tries to call blk_mq_quiesce_queue once per ublk_queue. However,
>    blk_mq_quiesce_queue targets the request_queue of the underlying ublk
>    device, of which there is only one. So the number of calls is larger
>    than necessary by a factor of nr_hw_queues.
> 2. In practice, it calls blk_mq_quiesce_queue _more_ than once per
>    ublk_queue. This is because of a data race where we read
>    ubq->canceling without any locking when deciding if we should call
>    ublk_start_cancel. It is thus possible for two calls to
>    ublk_uring_cmd_cancel_fn against the same ublk_queue to both call
>    ublk_start_cancel against the same ublk_queue.
> 
> Fix this by making the "canceling" flag a per-device state. This
> actually matches the existing code better, as there are several places
> where the flag is set or cleared for all queues simultaneously, and
> there is the general expectation that cancellation corresponds with ublk
> server exit. This per-device canceling flag is then checked under a
> (new) lock (addressing the data race (2) above), and the queue is only
> quiesced if it is cleared (addressing (1) above). The result is just one
> call to blk_mq_quiesce_queue per ublk device.
> 
> To minimize the number of cache lines that are accessed in the hot path,
> the per-queue canceling flag is kept. The values of the per-device
> canceling flag and all per-queue canceling flags should always match.
> 
> In our setup, where one ublk server handles I/O for 128 ublk devices,
> each having 24 hardware queues of depth 4096, here are the results
> before and after this patch, where teardown time is measured from the
> first call to io_ring_ctx_wait_and_kill to the return from the last
> ublk_ch_release:
> 
> 						before		after
> number of calls to blk_mq_quiesce_queue:	6469		256
> teardown time:					11.14s		2.44s
> 
> There are still some potential optimizations here, but this takes care
> of a big chunk of the ublk server exit handling delay.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming


