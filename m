Return-Path: <linux-kernel+bounces-599705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F09A8570A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2626D7ABFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4685296158;
	Fri, 11 Apr 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPc8Mves"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193711FBCB1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361618; cv=none; b=YPfM0hxjdyaSvi0QGg8DJ+DU37kCpc9HslNbcH9GPlUcmxL1IWuwpFUWvpleUM7G1ZSYueEadjojDZi4yNaD8cc7Ue5KvcAwyuxtQdrIBACz/XGF+TVCo9UFw98DplnUagdm52w5a6yySOSWJ7oBVMpqi5PwFizTsRUJtqnpeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361618; c=relaxed/simple;
	bh=Du5iqnvfawjuYpPozM9Hzm6S6A+I7fABDERNzH0HfVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZHXeUFkIsb4B9EaPRTD8R+I+Sz4pL//Pdb8wybZI6mscVpfAbdrlAPb9Cg7jSWI7em93+EyvIBofehVCk76bfPmPINT8jQ0SbMOspSwnMaQFlo9xwJu+0J/DIF47KLVQ+SIikJ00iUoqOdO9pAvJzIvxSjBsTf95aQR32kYF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPc8Mves; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744361615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5C7Q05Cmg6RietpAXrzHXxL88YS3OA9/C782nP8RhY=;
	b=OPc8MvesHVNTORRoDaxZUeaiDcthtHkKDpf7ap8vcbH4j0iczAuZcSXu4idC7LtOPe8Xjv
	kEviypubd7VlREQ7PQ9F8z2rgA3FFymWt7g8Ds1h6idP3MYpI/H8m6uY3tv+nzDgGzAKe5
	dulXZNAKJ2KjdNOno61TQ8peJW1B/1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-yzlCelZaMLW8eVlD_BKmdA-1; Fri,
 11 Apr 2025 04:53:31 -0400
X-MC-Unique: yzlCelZaMLW8eVlD_BKmdA-1
X-Mimecast-MFC-AGG-ID: yzlCelZaMLW8eVlD_BKmdA_1744361610
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39B121954B33;
	Fri, 11 Apr 2025 08:53:30 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 753401956094;
	Fri, 11 Apr 2025 08:53:24 +0000 (UTC)
Date: Fri, 11 Apr 2025 16:53:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v3 2/2] ublk: require unique task per io instead of
 unique task per hctx
Message-ID: <Z_jYfwFN_AYkUNJK@fedora>
References: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
 <20250410-ublk_task_per_io-v3-2-b811e8f4554a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-ublk_task_per_io-v3-2-b811e8f4554a@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Apr 10, 2025 at 06:17:51PM -0600, Uday Shankar wrote:
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
> 
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.

Agree.

The limit is actually originated from current implementation, both
REGISTER_IO_BUF and UNREGISTER_IO_BUF should be fine to run from other
pthread because the request buffer 'meta' is actually read-only.

> 
> Therefore, address this issue in ublk_drv by requiring a unique task per
> I/O instead of per queue/hctx. Imbalanced load can then be balanced
> across all ublk server threads by having threads issue FETCH_REQs in a
> round-robin manner. As a small toy example, consider a system with a
> single ublk device having 2 queues, each of queue depth 4. A ublk server
> having 4 threads could issue its FETCH_REQs against this device as
> follows (where each entry is the qid,tag pair that the FETCH_REQ
> targets):
> 
> poller thread:	T0	T1	T2	T3
> 		0,0	0,1	0,2	0,3
> 		1,3	1,0	1,1	1,2
> 
> Since tags appear to be allocated in sequential chunks, this setup
> provides a rough approximation to distributing I/Os round-robin across
> all ublk server threads, while letting I/Os stay fully thread-local.

BLK_MQ_F_TAG_RR can be set for this way, so is it possible to make this
as one feature? And set BLK_MQ_F_TAG_RR for this feature.

Also can you share what the preferred implementation is for ublk server?

I think per-io pthread may not be good, maybe partition tags space into
fixed range/pthread?

`ublk_queue' reference is basically read-only in IO code path, I think
it need to be declared explicitly as 'const' pointer in IO code/uring code
path first. Otherwise, it is easy to trigger data race with per-io task
since it is lockless.


Thanks, 
Ming


