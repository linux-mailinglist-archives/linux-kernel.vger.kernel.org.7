Return-Path: <linux-kernel+bounces-577930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D079CA7289F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 03:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D7F1896E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303D78F2E;
	Thu, 27 Mar 2025 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxcQIMFn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB426ACC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041194; cv=none; b=Lpsv086eKRmvO5qPK6EvvsM38qFV6X8cK5HixDs/f9nW7fPwdH/nMKwxeW8FvOLF7Fd87SZm8by5yvcBZ1OgxDZEOi8ZzuL0rMdQs0hqC2wpnaGlXq6B7uRopDSU6I3JHzD65O54x2hxbdvxaL+yT70pB4t+DzqxLYzIyPlmAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041194; c=relaxed/simple;
	bh=86YYl81eRmiakWtXrq/kGH1QHVGqt/VcyOi+HVli0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+hz5Y5cUPysfIEodJApzMYW9UA37YcWXs09GbGC9YJV5Ktcce/v15x5KKIOn1ODfzE7JjDyIoE9QwwSX9MQRfI4PnDkwlCGuTzU7Ca70nZiZrquPLaykZn5TjrUpEpmcZc92tL7CsBRUc8gES5mRCBRB9JV9q57MmeVt8sCffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxcQIMFn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743041192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGafn8W6404zCRSipJrPF7EkAssm07zFjsw/uEZbUBM=;
	b=HxcQIMFnc2YDZXqa/Vnm6JfBfOov9o1QwjIRbFnQCVbLzzVNanIbjCi+ja6vUG/Wyi2Vmb
	AZnaZk4y0/99ikhAr6jj5zkPXC4zKfLpbaxiYgMTXR8gh82dDH3BY5h5D3yglP/rh0aXOM
	chIbqR0sGls2/Vlws2Yhf4OOlDbcP7c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-6QAqZn0UM-e516BFc7EwRQ-1; Wed,
 26 Mar 2025 22:06:28 -0400
X-MC-Unique: 6QAqZn0UM-e516BFc7EwRQ-1
X-Mimecast-MFC-AGG-ID: 6QAqZn0UM-e516BFc7EwRQ_1743041187
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB6F3190308B;
	Thu, 27 Mar 2025 02:06:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D216D180094A;
	Thu, 27 Mar 2025 02:06:21 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:06:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z-Syl52pFLllilmu@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
> There are currently two ways in which ublk server exit is detected by
> ublk_drv:
> 
> 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
>    have not been completed to the ublk server when it exits, io_uring
>    calls the uring_cmd callback with a special cancellation flag as the
>    issuing task is exiting.
> 2. I/O timeout. This is needed in addition to the above to handle the
>    "saturated queue" case, when all I/Os for a given queue are in the
>    ublk server, and therefore there are no outstanding uring_cmds to
>    cancel when the ublk server exits.
> 
> The second method detects ublk server exit only after a long delay
> (~30s, the default timeout assigned by the block layer). Any
> applications using the ublk device will be left hanging for these 30s
> before seeing an error/knowing anything went wrong. This problem is
> illustrated by running the new test_generic_02 against a ublk_drv which
> doesn't have the fix:
> 
> selftests: ublk: test_generic_02.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 30.0611 s, 0.0 kB/s
> DEAD
> dd took 31 seconds to exit (>= 5s tolerance)!
> generic_02 : [FAIL]
> 
> Fix this by instead handling the saturated queue case in the ublk
> character file release callback. This happens during ublk server exit
> and handles the issue much more quickly than an I/O timeout:
> 
> selftests: ublk: test_generic_02.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0376731 s, 0.0 kB/s
> DEAD
> generic_02 : [PASS]
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
>  tools/testing/selftests/ublk/Makefile           |  1 +
>  tools/testing/selftests/ublk/kublk.c            |  3 ++
>  tools/testing/selftests/ublk/kublk.h            |  3 ++
>  tools/testing/selftests/ublk/null.c             |  4 +++
>  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
>  6 files changed, 72 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	unsigned int nr_inflight = 0;
> -	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
>  		if (!ubq->timeout) {
> @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  		return BLK_EH_DONE;
>  	}
>  
> -	if (!ubq_daemon_is_dying(ubq))
> -		return BLK_EH_RESET_TIMER;
> -
> -	for (i = 0; i < ubq->q_depth; i++) {
> -		struct ublk_io *io = &ubq->ios[i];
> -
> -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> -			nr_inflight++;
> -	}
> -
> -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> -	if (nr_inflight == ubq->q_depth) {
> -		struct ublk_device *ub = ubq->dev;
> -
> -		if (ublk_abort_requests(ub, ubq)) {
> -			schedule_work(&ub->nosrv_work);
> -		}
> -		return BLK_EH_DONE;
> -	}
> -
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	bool need_schedule = false;
> +	int i;
> +
> +	/*
> +	 * Error out any requests outstanding to the ublk server. This
> +	 * may have happened already (via uring_cmd cancellation), in
> +	 * which case it is not harmful to repeat. But uring_cmd
> +	 * cancellation does not handle queues which are fully saturated
> +	 * (all requests in ublk server), because from the kernel's POV,
> +	 * there are no outstanding uring_cmds to cancel. This code
> +	 * handles such queues.
> +	 */
> +
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> +
> +	if (need_schedule)
> +		schedule_work(&ub->nosrv_work);

Thinking of it further, you needn't to call ublk_abort_requests() and schedule 
stop work to remove disk here.

It can be the following way:

1) do nothing if 'ubq->canceling' is set, and it is safe to check this flag
because all uring commands are done now

2) otherwise, abort any in-flight request only by calling
ublk_abort_requests() and skipping the get & set ->canceling part.

which should avoid the 30sec delay, right?

Thanks, 
Ming


