Return-Path: <linux-kernel+bounces-580588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E5A753F7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 03:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4C3175DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D0250F8;
	Sat, 29 Mar 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqGs0JQ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADD8F49
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743213596; cv=none; b=NytBplXHWT4V+hZu25SdIrE6FIz+EiVoQ6qotZpvoaI+ta8wDyhS+DKcRBffnJ4ZzbOIPrNx6kJV0RqAOnJqE5RidMfGdRB+ms53z48QhYbrLAOc4sjxdgmTZAOX9Eyar/s7cNZM6pGAjdoYJ4rdS9q0Jq2qk1Y0SKSK5AnCLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743213596; c=relaxed/simple;
	bh=fzfKJMbK5AcAKl2AmcfVvaTF+8nmCh0DPH0nLxVk9Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz7pUvSEne/pDTxZLTD1g6L0TwCjSmy7BbBDzWW5zmxpByHbplQ83HrNsrOzIwxsikWkavKWKZlsIZELKf18uSu8QsUzfCgkgtibQIDKgvYCZmruNFxKfe8c2RdPPGr7eZPhhsxvAdHGwg1+AtGnOFxBtC3IW8I3zP9aRXq/lQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqGs0JQ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743213592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ujqnZ6t3I87/+eNzjM8VGw0zdV2aNa4K5PuELkT1So=;
	b=OqGs0JQ0FLafk/+F51UofbVE0YB/YLMa/Ti01zuPUnuNnYpoL4W/y7LFcXQzAsPM1ADaFC
	vEMKT52o7xpKce7UImNDTYe8F9PPjOkxoMw8uWxPXFV+1yE0ZvwL6xz5xWNG0a+GfrPtUK
	VqlrIxAoH0kp2rM/Q4cqTjc8llYPDbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-yVmLorBuMqymqhlicz1PDw-1; Fri,
 28 Mar 2025 21:59:49 -0400
X-MC-Unique: yVmLorBuMqymqhlicz1PDw-1
X-Mimecast-MFC-AGG-ID: yVmLorBuMqymqhlicz1PDw_1743213588
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CDB01800EC5;
	Sat, 29 Mar 2025 01:59:48 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD42619560AB;
	Sat, 29 Mar 2025 01:59:42 +0000 (UTC)
Date: Sat, 29 Mar 2025 09:59:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [syzbot] [block?] possible deadlock in elv_iosched_store
Message-ID: <Z-dUCLvf06SfTOHy@fedora>
References: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Mar 28, 2025 at 07:37:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1384b43f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7163a109ac459a8
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c7e0f9b94ad65811efb
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178cfa4c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8ca4c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc7dc9f0d9a7/disk-1a9239bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f555a3ae03d3/vmlinux-1a9239bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/55f6ea74eaf2/bzImage-1a9239bb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> 

...

> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..d7a103dc258b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4465,14 +4465,12 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	return NULL;
 }
 
-static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-						struct request_queue *q)
+static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+				     struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i, j;
 
-	/* protect against switching io scheduler  */
-	mutex_lock(&q->elevator_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
@@ -4505,7 +4503,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
-	mutex_unlock(&q->elevator_lock);
+}
+
+static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+				   struct request_queue *q, bool lock)
+{
+	if (lock) {
+		/* protect against switching io scheduler  */
+		mutex_lock(&q->elevator_lock);
+		__blk_mq_realloc_hw_ctxs(set, q);
+		mutex_unlock(&q->elevator_lock);
+	} else {
+		__blk_mq_realloc_hw_ctxs(set, q);
+	}
 
 	/* unregister cpuhp callbacks for exited hctxs */
 	blk_mq_remove_hw_queues_cpuhp(q);
@@ -4537,7 +4547,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q);
+	blk_mq_realloc_hw_ctxs(set, q, false);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -5033,7 +5043,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		blk_mq_realloc_hw_ctxs(set, q, true);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;

Thanks,
Ming


