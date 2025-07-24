Return-Path: <linux-kernel+bounces-743409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B9B0FE58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8427AB962
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D9156C79;
	Thu, 24 Jul 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="xFNRCseF"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218D70831
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753320019; cv=none; b=kPKurxJS02LgRXlukvnfc/FFnWoMrAU+HcDW3naGkzO3iLZLT0mRNHrsVXw31q9IQvnE5Z/MDUinzWRmoZm+A/hoA76r2bU9Ib6hTh31c3wnY/ndvhlfVfZxA1vssZvM0Lnq+MT3l95Pv1UCMHNJYWNtitgQxYQf/JUTgBkRblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753320019; c=relaxed/simple;
	bh=mDD70Q0yeAlFwV7OKohDiy4mFKvI3jVQz1CMtmTBuJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jX7aROoppCPDqk38wMOHEBZKSI90UxF7Z2iZCT5E0wmlwyslThyJJBmhqdxxJzi7EhUhkBP3akOZlOcLeoQnRaqeG1l5Hgt1jchHP/roFcCabwH3tWunN/afcSRSMr/yE/3C3gxd7PMv32+dGW7jxnRH7qGx90WLd4//qjwsP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=xFNRCseF; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753320011;
	bh=HxOg07j8XSOPOmST+Z7BvpNeAdBjsjbaa+rEGh4idSc=;
	h=From:Subject:Date:Message-ID;
	b=xFNRCseFpw/9eRHR8I19U3ENkIE1TQAf26VG4lQPuDyHkD8CW4YdzParAlTgt/Nbo
	 P4nRSi565tRGNjxEfzQSP3wwesX1Z7sRBNCSHtr+ND7hs3HkUbPw/KbxceehJO0zea
	 dWVEYWS9djIJ0BssFjb/h7TnclE2PRikRupJxKho=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68818A41000067DB; Thu, 24 Jul 2025 09:20:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6893174456743
X-SMAIL-UIID: 40610C3A39A743CCBCBE9913FDAE4EA7-20250724-092002-1
From: Hillf Danton <hdanton@sina.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: thomas.hellstrom@linux.intel.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	regressions@lists.linux.dev
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking dependency detected when plugging USB stick after ffa1e7ada456
Date: Thu, 24 Jul 2025 09:19:49 +0800
Message-ID: <20250724011950.2836-1-hdanton@sina.com>
In-Reply-To: <CABXGCsOwAQuisqpfUvW+1BWtOV+O1GypcQ6mb4SSUgN3YkAZUQ@mail.gmail.com>
References: <CABXGCsPgCBahYRtEZUZiAZtkX51gDE_XZQqK=apuhZ_fOK=Dkg@mail.gmail.com> <20250722005125.2765-1-hdanton@sina.com> <CABXGCsO5mFu9fOq8oKwByZaAjJrCB_V0hKgOsLLJJ4x3PmHr1g@mail.gmail.com> <20250723010336.2793-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 24 Jul 2025 01:36:37 +0500 Mikhail Gavrilov wrote:
> On Wed, Jul 23, 2025 at 6:03 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> > In order to cure the deadlock, queue is thawed before switching elevator,
> > so lets see what comes out with that warning ignored.
> >
> > --- x/block/elevator.c
> > +++ y/block/elevator.c
> > @@ -575,7 +575,6 @@ static int elevator_switch(struct reques
> >         struct elevator_type *new_e = NULL;
> >         int ret = 0;
> >
> > -       WARN_ON_ONCE(q->mq_freeze_depth == 0);
> >         lockdep_assert_held(&q->elevator_lock);
> >
> >         if (strncmp(ctx->name, "none", 4)) {
> > @@ -661,6 +660,7 @@ static int elevator_change(struct reques
> >         unsigned int memflags;
> >         int ret = 0;
> >
> > +       /* updaters should be serialized */
> >         lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
> >
> >         memflags = blk_mq_freeze_queue(q);
> > @@ -674,11 +674,11 @@ static int elevator_change(struct reques
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
> > --
> 
> Hi Hillf,
> 
> Thanks for the patch.
> 
> With this patch applied, I haven't seen either the lockdep warning or
> a soft lockup within 13 hours of runtime. Not sure if that's
> sufficient yet for a final verdict, but it's definitely promising.

Thank you for testing it.

It works for you so far, but given the "correct" locking order enforced
in ffa1e7ada456, I know the chance for reversing that order is not zero
yet either in Jens or upstream tree. Nor simple to fix every single case.

Hillf Danton

