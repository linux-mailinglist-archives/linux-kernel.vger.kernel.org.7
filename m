Return-Path: <linux-kernel+bounces-863957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B0BF9987
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1B773546CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B41B78F3;
	Wed, 22 Oct 2025 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="rLoBujf4"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B12A1AA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095906; cv=none; b=dUaZ0HTVpq0AK73d7OjdJIzZs71rQmwC2oKKzBfSFlN7NUNydmATiB3XiHtk7L6aD1bJQEKXf7dmGvGAvg7ZIz2VjZfSJGBIl6JXWgelfl5EVDbe58RJHnSx6UW5MLwrM8IT4BmtCiOqEFloMvsdLTvcJH/79D//+QA23DpFHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095906; c=relaxed/simple;
	bh=yPI+NRDchou+55Z5ZkUQDZsXRs5KUlMpO3blhZVOeeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqMlFJ7qm8RziSbiJN8nTq+JpfspnWR4ia+CfijWIxhulxAZNyAqlsjLFhJFUqEPnqmbnbzhOFS207v8aiTUuYBEGnvQR/lDXSiTIjydXJQEIsEate3wjEtLj//tT0gw0LADJ8EEsigWVh87f3q4PESb/EbVE6vBtgG+Tmv0wEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=rLoBujf4; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1761095903;
	bh=owyn/VL0z1aMn38Icbz6k6j8VqVYe7fKFQhXKrFPPLY=;
	h=From:Subject:Date:Message-ID;
	b=rLoBujf4rncNmtdKHMedXkalq11ng5f1T0iuY28qk8CNteKzyrkNV6EvgHbZ7tPcy
	 s073Ia8zzc2LmRXNnS9N5+wP/gEND/s5iFnKJX3dHxCAtXuKRzoyQsTE1nfEwujFwl
	 Y1Mb4w9o7U1eo7qXiZhghFAl3WvCNRaJg5qHHooQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68F8304A000043CB; Wed, 22 Oct 2025 09:15:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2015496685394
X-SMAIL-UIID: 46B6DD55AC574FDFACD9C46C0F2385F6-20251022-091556-1
From: Hillf Danton <hdanton@sina.com>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
Date: Wed, 22 Oct 2025 09:15:44 +0800
Message-ID: <20251022011547.8648-1-hdanton@sina.com>
In-Reply-To: <CAG2KctpHA+L=xh-VQ8SVDSRcqyL+ch=WMVrKS+pckLmC6uJwvw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 13:13:39 -0700 Samuel Wu wrote:
> On Fri, Oct 17, 2025 at 5:17 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> > > +/**
> > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > + *
> > > + * Return 0 on successful file system sync, otherwise returns -EBUSY if file
> > > + * system sync was aborted.
> > > + */
> > > +int pm_sleep_fs_sync(void)
> > > +{
> > > +     bool need_pm_sleep_fs_sync_requeue;
> > > +     unsigned long flags;
> > > +
> > > +     do {
> > > +             spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > +             reinit_completion(&pm_sleep_fs_sync_complete);
> >
> > Given difficulty following up here, can you specify why reinit is needed?
> 
> There are two possibilities that make reinit_completion() necessary:
> 1. Suspend abort triggers completion, but is canceled before
> pm_wakeup_pending(), so need reinit to restart the
> wait_for_completion() process.
> 2. Handling back-to-back suspend attempts: after a subsequent suspend
> attempt finishes waiting for a previous suspend's fs_sync to finish,
> we need the reinit to start the wait_for_completion() process of the
> subsequent suspend's fs_sync.
> 
If 1. and 2. matches the comment for wait_for_completion() below,

	static DECLARE_COMPLETION(foo);

	waiter		waker1		waker2
	---		---		---
	for (;;) {
	  reinit_completion(&foo)
	  do anything
	  wait_for_completion(&foo)
			do bar1 	do bar2
			complete(&foo) 	complete(&foo)
	  if (end)
		break;
	}

the chance for reinit to drop one wakeup is not zero.
If drop makes sense, for what do you wait after receiving two wakeups? 

> > > +             /*
> > > +              * Handle the case where a sleep immediately follows a previous
> > > +              * sleep that was aborted during fs_sync. In this case, wait for
> > > +              * the previous filesystem sync to finish. Then do another
> > > +              * filesystem sync so any subsequent filesystem changes are
> > > +              * synced before sleeping.
> > > +              */
> > > +             if (pm_sleep_fs_sync_queued) {
> > > +                     need_pm_sleep_fs_sync_requeue = true;
> > > +             } else {
> > > +                     need_pm_sleep_fs_sync_requeue = false;
> > > +                     pm_sleep_fs_sync_queued = true;
> > > +                     schedule_work(&sync_filesystems);
> > > +             }
> > > +             spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > +
> > > +             /*
> > > +              * Completion is triggered by fs_sync finishing or an abort sleep
> > > +              * signal, whichever comes first
> > > +              */
> > > +             wait_for_completion(&pm_sleep_fs_sync_complete);
> > > +             if (pm_wakeup_pending())
> > > +                     return -EBUSY;
> > > +     } while (need_pm_sleep_fs_sync_requeue);
> > > +
> > > +     return 0;
> > > +}

