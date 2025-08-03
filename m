Return-Path: <linux-kernel+bounces-754352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D710B19323
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1581C18969BB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FAD283159;
	Sun,  3 Aug 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="zQls5lpD"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674BE2561C2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754210986; cv=none; b=Cp459boNOUKogi6baTnizvdU9F0NrQUw9wyPiGDOsOtjcIEkE8DdXa3ZjbAc4XFQAo4fQXtkqYb8ux2oofrvcp6Y9UKqDKxTAfGME0JotM2W/fSbxCnO/gQfARrhKSFVlVNMqlPa3by4gw/ph0elRv6OZUlkV0pIlnXVV5+gOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754210986; c=relaxed/simple;
	bh=0wRQ7Vjd+waQXQUM5VP3gX8nP6aRoarWaQa8wq2dT2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHHY01/fBhBHYEdYMM8kY6lWcTJh2qk3Ve6obXtSfyTFQwHJpnHd28fbef6V2UKLHcwlM9MCa6B36pshUc8O7kLwhB6nZy3wpFcKKSv9Nmyo9SSSZRoL3/2ssfLIhuG3qaIk1i7XG9DMn2qhPe+C6zM9oJrl2bl8XGihBwpStpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=zQls5lpD; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754210978;
	bh=H9D1Yvgdf5YCIeKPmwvOIAGztLxkKKKtL44n/H71qio=;
	h=From:Subject:Date:Message-ID;
	b=zQls5lpD1DvQ3t75FrFFwdDoTteWfR9fFA5AufyzS2lNwpZzu1sipHqzwthNSHj0M
	 4X7azsvMCs+YH7RNqEyDZ20NFw2o9DDMRqHVn8sS2UI+EFe75RJanlwutmPODwoGod
	 osd77VBNzAU8df4xNgVtdF5A1U9zWkiMtgmxY0Wc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 688F229D00003E4C; Sun, 3 Aug 2025 16:49:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7101176685153
X-SMAIL-UIID: F5609F38602A4B968F153207D8DDAC4A-20250803-164935-1
From: Hillf Danton <hdanton@sina.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Sun,  3 Aug 2025 16:49:22 +0800
Message-ID: <20250803084924.3785-1-hdanton@sina.com>
In-Reply-To: <18003f21-f83a-4bad-93b2-70273c03974f@kzalloc.com>
References: <20250802142647.139186-3-ysk@kzalloc.com> <20250803023439.3760-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 3 Aug 2025 12:07:11 +0900 Yunseong Kim wrote:
> On 8/3/25 11:34 오전, Hillf Danton wrote:
> > On Sat,  2 Aug 2025 14:26:49 +0000 Yunseong Kim wrote:
> >> +	raw_spin_unlock(&kcov_remote_lock);
> >>  
> >>  	/* Can only happen when in_task(). */
> >>  	if (!area) {
> 
> 		/* 1. Interrupts are temporarily re-enabled here. */
> 
> >> -		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> >> +		local_irq_restore(flags);
> 
> 		/* 2. vmalloc() is called safely in a non-atomic context. */
> 
> >>  		area = vmalloc(size * sizeof(unsigned long));
> > 
> > Given irq disabled for the duration of the coverage collection section [1],
> > vmalloc does not work here [2].
> 
> 
> Thank you for the detailed review and for pointing out this critical
> interaction. You are absolutely correct that vmalloc() cannot be called
> from an atomic context with interrupts disabled, as it is a sleeping function.
> 
> However, upon closer inspection of the kcov_remote_start() function's
> control flow, it appears the original author anticipated this issue and
> implemented a safeguard. The vmalloc() call is explicitly wrapped by
> local_irq_restore() and local_irq_save():
> 
> >>  		if (!area) {
> >>  			kcov_put(kcov);
> >>  			return;
> >>  		}
> 
> 		/* 3. Interrupts are disabled again to protect the rest of the function. */
> 
> >> -		local_lock_irqsave(&kcov_percpu_data.lock, flags);
> >> +		local_irq_save(flags);
> >>  	}
> 
> This sequence ensures that the vmalloc() call itself does not happen in an
> IRQ-disabled context.
> 
> My patch reverts the per-CPU locking back to the local_irq_save/restore
> primitives but preserves this essential bracketing around the vmalloc() call.
> Therefore, the sleeping function bug should not occur.
> 
What you missed is the local_irq_save in kcov_remote_start_usb_softirq().
See comment [1] for detail.

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kcov.h#n73
> > [2] Subject: [RFC 0/7] vmallloc and non-blocking GFPs
> > https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
> 
> Additionally, I have tested this implementation by running syzkaller
> for a full day, and no issues were reported.
> 
> Perhaps a comment could be added here (I can volunteer to do so) to
> improve readability where the control flow isn’t obvious to future developers.
> 
> Thanks,
> 
> Yunseong Kim
> 
> 

