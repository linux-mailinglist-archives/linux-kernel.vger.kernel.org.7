Return-Path: <linux-kernel+bounces-800510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72577B43894
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EB61C81F48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7C2FA0F7;
	Thu,  4 Sep 2025 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xL9Ja/u5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXs/IIfl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36271D432D;
	Thu,  4 Sep 2025 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981261; cv=none; b=Gmt58t2NelFLBF6SfPhT8tGnzcqxKReU9Os6BffwGdzYrsAjiYsK7Hfk2opu3EZL53ByvQc/GCQ8J4UQlXtbCpzhW8qJqi59YAm+SBcE0YUG3T7DA3s8TW2qdHf/BxqPMF6E4zbBZpV2EZhjiOnIknYCEIXjpEIaCRYE0YpfiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981261; c=relaxed/simple;
	bh=bq5CTFtIi1VN2s5gJ3WNt7YS8aY6jsvi7q7T8nGCTpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNeJk8Kcu0oHUk+K1e0k4gROWgSonkY+JJJR7BT2eqCfS2lJSNwkoM/2N/LpDJP5MyD0caFtGiWQfC4Ggxnf4Tl5t9JtvLPyWA2XdTJOmxCX1k5Jmr73+7t33Zko5DPYmQE/B1xKA9oglPz1UMhrSMYXI6z17ElDYMbUKQDEDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xL9Ja/u5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXs/IIfl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 12:20:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756981258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo/GCBNNEoLa3zRVufE+F+aOMHPopqUOJZVpt8Nx0fw=;
	b=xL9Ja/u5RbIIxp11jEzcYX3nXisPaSlKLMWTaSVc4vvh+E+Fgeu+Tzdo5mvLQ8Kr3XlXvq
	X6N3rOPfPoO5wPhIbtC7v9Qm9GYoa0keabxS2K1MPmuhdRi0y6vTn2YWZ2DNjlO/12W0lk
	PISOLndWcyoU9r2eUGSFDgFu5Emu5BU6vr2xNRmbCxDYiJ1d1+HRLhCrrptf9vUXj6wArw
	tDc9ERtbH99Q8CCR4s6d9E8vNyDRvbwZEp8X3v23RQa2KSP5fQBJMQVmXU3cajtfs/vyqT
	HwZ51ldkPVt2mDqqsFBcJmNVGs4qqFzj3dgRhKSK96yxEqJIfBpJn+QnRT9yaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756981258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo/GCBNNEoLa3zRVufE+F+aOMHPopqUOJZVpt8Nx0fw=;
	b=ZXs/IIfl67CHO4ioq2N/iL7XZByCS2NkQ94C204C8uFo4igB48rxhIPT7Z1wlfCAe8IrqI
	TAdr/GpcbmvKxZBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	tglx@linutronix.de
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	mingo@redhat.com, perex@perex.cz, syzkaller-bugs@googlegroups.com,
	tiwai@suse.com, x86@kernel.org
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
Message-ID: <20250904102056.YCByXJXj@linutronix.de>
References: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
 <68b2406a.a00a0220.1337b0.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b2406a.a00a0220.1337b0.001e.GAE@google.com>

On 2025-08-29 17:06:02 [-0700], syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit d2d6422f8bd17c6bb205133e290625a564194496
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Fri Sep 6 10:59:04 2024 +0000
> 
>     x86: Allow to enable PREEMPT_RT.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12db5634580000
> start commit:   07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11db5634580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16db5634580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> dashboard link: https://syzkaller.appspot.com/bug?extid=10b4363fb0f46527f3f3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10307262580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17110242580000
> 
> Reported-by: syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

This is unfortunate. There is nothing that sound did wrong, it is rather
special softirq handling in this case. We don't see this often because
it requires that a timer is cancelled at the time it is running.
The assumption made by sound is that spin_lock_irq() also disables
softirqs. This is not the case on PREEMPT_RT.

The hunk below avoids the splat. Adding local_bh_disable() to
spin_lock_irq() would cure it, too. It would also result in random
synchronisation points across the kernel leading to something less
usable.
The imho best solution would to get rid of softirq_ctrl.lock which has
been proposed
	https://lore.kernel.org/all/20250901163811.963326-4-bigeasy@linutronix.de/

Comments?

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -84,19 +84,24 @@ void snd_pcm_group_init(struct snd_pcm_group *group)
 }
 
 /* define group lock helpers */
-#define DEFINE_PCM_GROUP_LOCK(action, mutex_action) \
+#define DEFINE_PCM_GROUP_LOCK(action, bh_lock, bh_unlock, mutex_action) \
 static void snd_pcm_group_ ## action(struct snd_pcm_group *group, bool nonatomic) \
 { \
-	if (nonatomic) \
+	if (nonatomic) { \
 		mutex_ ## mutex_action(&group->mutex); \
-	else \
-		spin_ ## action(&group->lock); \
+	} else { \
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_lock)	\
+			local_bh_disable();			\
+		spin_ ## action(&group->lock);			\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_unlock)	\
+			local_bh_enable();			\
+	}							\
 }
 
-DEFINE_PCM_GROUP_LOCK(lock, lock);
-DEFINE_PCM_GROUP_LOCK(unlock, unlock);
-DEFINE_PCM_GROUP_LOCK(lock_irq, lock);
-DEFINE_PCM_GROUP_LOCK(unlock_irq, unlock);
+DEFINE_PCM_GROUP_LOCK(lock, 0, 0, lock);
+DEFINE_PCM_GROUP_LOCK(unlock, 0, 0, unlock);
+DEFINE_PCM_GROUP_LOCK(lock_irq, 1, 0, lock);
+DEFINE_PCM_GROUP_LOCK(unlock_irq, 0, 1, unlock);
 
 /**
  * snd_pcm_stream_lock - Lock the PCM stream


Sebastian

