Return-Path: <linux-kernel+bounces-741690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D98B0E7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA837AF94F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77114A60F;
	Wed, 23 Jul 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="XLMDA25x"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C2149C51
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232791; cv=none; b=IoflCiJVL/VGO3YqzQgmTbd94aF3Mjs70vJIYsVyJI34M7fpQsTAZhnJMQKyJcHdy8uJfhLATFEv5LWea4xID5lPyxGv7JCF8ZaMlZNO0a6zc6J3ePm/92dcTjGJEOyLEW50TGpjJCtkAIKwdu2eu2+JOlbbmQ8VFD68e8JWJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232791; c=relaxed/simple;
	bh=uSar9xHTnGUQj7iYqiDRlLrJCkeSSB2Ouf2GH3Pr1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEdfDojCK05EmeYS8xoC2mxl94FHsdyRZOFSSoQdUNC7AA2VzWJltDRqxChwLzBVxnExM4Fl7zgkswtoX7BlHSS1c01iUagYNxwMPv5LtcqeXYSXzDHDt5ubJOoPuNGDZ0wYmJJPpW/ULhqkZAeI7ZYEAdhMHjQkC/CYGVlPmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=XLMDA25x; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753232783;
	bh=xV1mGKNcZIdCI/Yqy+MW7AgI9iRp29g0Rl6VzIV3Dek=;
	h=From:Subject:Date:Message-ID;
	b=XLMDA25xIH/+xhYkxVU4mwGpCe0uKXJhL9Te8Lkj7ApsCDk0M7KhlnB91/jgnG+Jz
	 hKr2CBZ2rzCtrQvJqWjCfyHQGf+ndhVz35cZ2mLsyxYP/KjXxcIT2UmEh1tbmiU8V6
	 4JooubFnhWjprP7hv0RaJv2ISihXxMK3KXFwYLOU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 688034F200000F1B; Wed, 23 Jul 2025 09:03:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1175294456963
X-SMAIL-UIID: FB494A7CF96241028F43B38BAFEACAE8-20250723-090350-1
From: Hillf Danton <hdanton@sina.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: thomas.hellstrom@linux.intel.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	regressions@lists.linux.dev
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking dependency detected when plugging USB stick after ffa1e7ada456
Date: Wed, 23 Jul 2025 09:03:34 +0800
Message-ID: <20250723010336.2793-1-hdanton@sina.com>
In-Reply-To: <CABXGCsO5mFu9fOq8oKwByZaAjJrCB_V0hKgOsLLJJ4x3PmHr1g@mail.gmail.com>
References: <CABXGCsPgCBahYRtEZUZiAZtkX51gDE_XZQqK=apuhZ_fOK=Dkg@mail.gmail.com> <20250722005125.2765-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 12:11:36 +0500 Mikhail Gavrilov wrote:
> On Tue, Jul 22, 2025 at 5:51 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> > Try the diff that serializes elevator_change() with q->elevator_lock if
> > reproducer is available.
> >
> > --- x/block/elevator.c
> > +++ y/block/elevator.c
> > @@ -661,6 +661,7 @@ static int elevator_change(struct reques
> >         unsigned int memflags;
> >         int ret = 0;
> >
> > +       /* updaters should be serialized */
> >         lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
> >
> >         memflags = blk_mq_freeze_queue(q);
> > @@ -674,11 +675,11 @@ static int elevator_change(struct reques
> >          * Disk isn't added yet, so verifying queue lock only manually.
> >          */
> >         blk_mq_cancel_work_sync(q);
> > +       blk_mq_unfreeze_queue(q, memflags);
> >         mutex_lock(&q->elevator_lock);
> >         if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
> >                 ret = elevator_switch(q, ctx);
> >         mutex_unlock(&q->elevator_lock);
> > -       blk_mq_unfreeze_queue(q, memflags);
> >         if (!ret)
> >                 ret = elevator_change_done(q, ctx);
> >
> 
> Hi Hillf,
> 
> Thanks for the patch.
> 
> I tested your proposed diff that serializes elevator_change() with
> q->elevator_lock. Unfortunately, instead of the previous lockdep
> warning, I'm now seeing a soft lockup warning.
> 
> Here is the relevant excerpt from the kernel log:
> 
> [   78.573292] sd 6:0:0:0: [sda] Assuming drive cache: write through
> [   78.581496] ------------[ cut here ]------------
> [   78.581507] WARNING: CPU: 7 PID: 300 at block/elevator.c:578
> elevator_switch+0x512/0x630
> 
> This happens after plugging in a USB flash stick (sd 6:0:0:0) with the
> patched kernel.
> 
> Full dmesg trace is attached below.
> 
> Let me know if you'd like me to try additional debugging or patches.
> 
> Thanks for looking into this!

In order to cure the deadlock, queue is thawed before switching elevator,
so lets see what comes out with that warning ignored.

--- x/block/elevator.c
+++ y/block/elevator.c
@@ -575,7 +575,6 @@ static int elevator_switch(struct reques
 	struct elevator_type *new_e = NULL;
 	int ret = 0;
 
-	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
@@ -661,6 +660,7 @@ static int elevator_change(struct reques
 	unsigned int memflags;
 	int ret = 0;
 
+	/* updaters should be serialized */
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
 	memflags = blk_mq_freeze_queue(q);
@@ -674,11 +674,11 @@ static int elevator_change(struct reques
 	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
 	blk_mq_cancel_work_sync(q);
+	blk_mq_unfreeze_queue(q, memflags);
 	mutex_lock(&q->elevator_lock);
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
 
--

