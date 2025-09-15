Return-Path: <linux-kernel+bounces-817333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC3B580CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B59D483B95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4B34DCC9;
	Mon, 15 Sep 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCU31LXs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6cJcrFi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880033EB0E;
	Mon, 15 Sep 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950136; cv=none; b=PULojLHeUIglSJarnXI/jU2Ko5V0SSMOrR5vlpZ2pgmUeWQniCjDWpFoClb4h8UEOIJZVTWGf2AMOuUlQ/L7YkaIXJKYhew9wrZlZuCe7e7i1kbuGZ8SFQ8VoOc9HlYi9Ozhslki0U58Y7n46EcLzBhQv1x+kSlIL7weC1IQwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950136; c=relaxed/simple;
	bh=FrUwLVp9oT4QMuvl2+RLd/Htn+U5s410/r63EHY3p/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC95zh2PsgtYECXs8f3R1UWLKzMUiK9FLpTojLluOIdQ6j01aqnHmiVNXmMGym5d+RownXwq27lU0z8mSzudUNvA7qdT8g3RSXhhMlzIXbhSz1hXatG29nS7lPhhDAYRDdRDvmmatpGvvSV7Uoe2SUFwdzZNm86DN1CtFIeEGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCU31LXs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6cJcrFi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 17:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757950132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QS0vbJrwIK1VQTFT5zhVSNs9IJ/m8dvIWJUpIwiwK8U=;
	b=zCU31LXs/r0NGtwvRYwyysXxFYv7vsG9uosroledtZJ4oPNVAhwzeO/r6oZJbs/w40Cec0
	VJccwLhaWHTDAEUV/ObtVc4pTMpPzw4AYhiVLB6HV2hl5tDVpmQiFmg5J6dzNfQ8IQcPM2
	s2RS2GieVF9l0Gj4i+0oENdKnr4NzjPIl+Z2Hy5785y0QdFSfGkNYCxWkQLXxO9tocxls6
	XhHUPLLpL7m2UTVLo7+0G+fQvcZaFoU2Vy3HhUAN+WQAh+vrYJHnR5X2S3u+HkPohrrPrF
	lS797pwiQe9KEEh8yUtBs3kMZd4cInErQ1Sv0MMlyjGkS81bxbyp5xagBoUfPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757950132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QS0vbJrwIK1VQTFT5zhVSNs9IJ/m8dvIWJUpIwiwK8U=;
	b=a6cJcrFit+gRGaEG5ZVVlq82BoXzdMzQMe7ukHCn7C4gasz64Ln14c26jcIoins5RLhWvQ
	XFJiQd3O2TLNwoCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, mingo@redhat.com, perex@perex.cz,
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, x86@kernel.org
Subject: [PATCH] ALSA: pcm: Disable bottom softirqs as part of
 spin_lock_irq() on PREEMPT_RT
Message-ID: <20250915152851.-ATGMKhp@linutronix.de>
References: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
 <68b2406a.a00a0220.1337b0.001e.GAE@google.com>
 <20250904102056.YCByXJXj@linutronix.de>
 <878qiutsdu.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qiutsdu.wl-tiwai@suse.de>

snd_pcm_group_lock_irq() acquires a spinlock_t and disables interrupts
via spin_lock_irq(). This also implicitly disables the handling of
softirqs such as TIMER_SOFTIRQ.
On PREEMPT_RT softirqs are preemptible and spin_lock_irq() does not
disable them. That means a timer can be invoked during spin_lock_irq()
on the same CPU. Due to synchronisations reasons local_bh_disable() has
a per-CPU lock named softirq_ctrl.lock which synchronizes individual
softirq against each other.
syz-bot managed to trigger a lockdep report where softirq_ctrl.lock is
acquired in hrtimer_cancel() in addition to hrtimer_run_softirq(). This
is a possible deadlock.

The softirq_ctrl.lock can not be made part of spin_lock_irq() as this
would lead to too much synchronisation against individual threads on the
system. To avoid the possible deadlock, softirqs must be manually
disabled before the lock is acquired.

Disable softirqs before the lock is acquired on PREEMPT_RT.

Reported-by: syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com
Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I don't see a way around this given the report. I don't see how to
address this within the softirq. Taking this lock as part of every
spin_lock_irq() would be a mess and while testing I didn't even manage
to boot the machine. So I probably missed a detail (but then I would
only know how mad it really is).

This can be an intermediate solution until
	https://lore.kernel.org/all/20250901163811.963326-4-bigeasy@linutronix.de/

gets merged and the !PREEMPT_RT_NEEDS_BH_LOCK case the default (i.e. not
a config option anymore).

 sound/core/pcm_native.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1eab940fa2e5a..68bee40c9adaf 100644
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
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_lock)   \
+			local_bh_disable();			\
+		spin_ ## action(&group->lock);			\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_unlock) \
+			local_bh_enable();                      \
+	}							\
 }
 
-DEFINE_PCM_GROUP_LOCK(lock, lock);
-DEFINE_PCM_GROUP_LOCK(unlock, unlock);
-DEFINE_PCM_GROUP_LOCK(lock_irq, lock);
-DEFINE_PCM_GROUP_LOCK(unlock_irq, unlock);
+DEFINE_PCM_GROUP_LOCK(lock, false, false, lock);
+DEFINE_PCM_GROUP_LOCK(unlock, false, false, unlock);
+DEFINE_PCM_GROUP_LOCK(lock_irq, true, false, lock);
+DEFINE_PCM_GROUP_LOCK(unlock_irq, false, true, unlock);
 
 /**
  * snd_pcm_stream_lock - Lock the PCM stream
-- 
2.51.0


