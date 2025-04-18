Return-Path: <linux-kernel+bounces-610020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62604A92F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 03:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1452119E3A95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC491D514B;
	Fri, 18 Apr 2025 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc7mfEwX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808B1C84C4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939828; cv=none; b=VKnHrDooeUOwBngeKE3JW9nbBXXIRMZCyKlZZGJD0JVmmt8JmtfnViF88+4jYx0ptUE5XYcrxJlYua61msXdPlBSD6gy5QPOhep6pQIdF3BtDCIM0W6OXF7+iRdSnDlNt9UImxTuDvf+F71O1XexGFh/3UhuXVgLlE9cdLd2nSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939828; c=relaxed/simple;
	bh=MEgZjNtskQXm6HFNYZJ7iMSGrAMiDzT+N/Kb1iu9daA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiw0v+i5bCaucyBmAMJUiFt1KcORf99GQ1ckdJ00FZs2lkeenqkhWNYJsezDuL8u3WOIcybBQPu2Mn2iwFLL82ARkZPwFVTeQ6IbsNas6s8/RjzdhA+u4PWMeqSpx2Oi/yxOSKSXEbQb4AmHgQbunBiOpgA+Ka9bvpQmaqEMcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc7mfEwX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744939825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1zlgXQPsuy4r3lGn9hZVrkLc3Vo0/KGwnhy/QIVqNk=;
	b=Xc7mfEwXtuiF7na34vLAHnCoZm2kXXVbaJfeF9najJHvaRM2WgEfNaptj8G0aEur6ZEeKK
	86Wm0Z6dcUiIwUnnSOGMYfiT1WXFzOUC6KWa+z4FgsGeQvUSfsZvODME2mVbPKUTadCtGW
	rx3GDhG1r9kmLB+nQ1yeXnawORRf+do=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-VO7Gw8YJPO2CTSg2dR5JaQ-1; Thu,
 17 Apr 2025 21:30:21 -0400
X-MC-Unique: VO7Gw8YJPO2CTSg2dR5JaQ-1
X-Mimecast-MFC-AGG-ID: VO7Gw8YJPO2CTSg2dR5JaQ_1744939820
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B20B91800878;
	Fri, 18 Apr 2025 01:30:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F9A19560BA;
	Fri, 18 Apr 2025 01:30:16 +0000 (UTC)
Date: Fri, 18 Apr 2025 09:30:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ublk: require unique task per io instead of
 unique task per hctx
Message-ID: <aAGrI8wqLLCWzqNe@fedora>
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
 <20250416-ublk_task_per_io-v5-1-9261ad7bff20@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ublk_task_per_io-v5-1-9261ad7bff20@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Apr 16, 2025 at 01:46:05PM -0600, Uday Shankar wrote:
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
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---

I guess this patch need to rebase against yesterday Jens's merge.

Given this change is big from ublk serer viewpoint, it should aim at
v6.16

As I suggested on V3[1]:

- it is nice to make it as one feature, so you can make any optimization
for this feature only, such as applying BLK_MQ_F_TAG_RR for improving
IO locality

- add selftest for this usage, which is helpful for

	- verify this usage

	- avoid to break the feature with new change

	- and evaluate performance effect

[1] https://lore.kernel.org/linux-block/aABZl4Yxdf3yew4q@fedora/


thanks,
Ming


