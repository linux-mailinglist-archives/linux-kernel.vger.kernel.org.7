Return-Path: <linux-kernel+bounces-856879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C294EBE550F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4132B1896B56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C92DA779;
	Thu, 16 Oct 2025 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bm3OROqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZ32Jv18"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823F1CEAD6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645232; cv=none; b=jO8wV+GEIuIm8Hwn/ZanDZiZmVzG32OkALQ+O4kbJZPD4ftoEjw3Lxrdaw6xfSm4PPloUrZqu52/TjBDK5xiE3CNki17GXVFySqB9w6KdTw0tX3HvN428Th5LxFBXLGBnJUn0WOftwv488e1k4Rh9Nm4FHoNbmobQzXWJaFMP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645232; c=relaxed/simple;
	bh=guLaFfo46+vY53Whq+ZK0dujZw7Ckjw89P4YnFk7818=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bkbR9ECh0PCrQKB+elUhJyiOxEQ96t6PuP+THDO26qyJBz4nM6DH8L0Zqvlcv/nd7xSMieaNR6AnF7Z2BxFFFFlLfu8spA/aRoDz9ZusHlzD/8CeaKdB8VozTdMhd0rnhkMs6y5k01zEXac52AdS3RJd/oS8Kcbxl/q8T9n+9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bm3OROqc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZ32Jv18; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760645228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A17aKYML9kMLL9Aj48X1SEbwdtxeUVv4+l79hSecF0=;
	b=Bm3OROqcDQm1TknDGMB6aYe88IcWurCowrIkZSYbNTOtoa2IrFNwLRwJJfYnzRPA7e4JCh
	1a0ccC5WGP6dpqXNHyKHQXE9NBwqMFp1WgKAiDMPk8mi9suB5iM9aXtAS9dGyBGWy8IAIv
	DNNJBzcxN+TpnmEsPWkWtELxk9PUwlV65L40eeR2oiOYEuNMkYAJcX+6gLFF85AyJDVrKb
	kKkDpv3kno2OePLyFGZgKuykEn+UM94QC8McASprvxU2Tn/NrjsAKNtAIUM7jBIoM43rUc
	cOqMq/P/sjFqxBq3IwFw8hgSclzdMPBzNq4N/8brxReppZD7XydpjGYi7rJ4fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760645228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A17aKYML9kMLL9Aj48X1SEbwdtxeUVv4+l79hSecF0=;
	b=iZ32Jv18tKAPd5D9DvKBsa/gSQymNUyILdg3ZRZ8iH2cWjP5Y9q1hYmuiMZtm5HZ9T6l9+
	3uq7XQk15ZU5cODQ==
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, Kyle
 Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH] tick/sched: Use trylock for jiffies updates by
 non-timekeeper CPUs
In-Reply-To: <20251013150959.298288-1-steve.wahl@hpe.com>
References: <20251013150959.298288-1-steve.wahl@hpe.com>
Date: Thu, 16 Oct 2025 22:07:07 +0200
Message-ID: <87a51q1uhg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13 2025 at 10:09, Steve Wahl wrote:
> -static void tick_do_update_jiffies64(ktime_t now)
> +static bool _tick_do_update_jiffies64(ktime_t now, bool trylock)
>  {
>  	unsigned long ticks = 1;
>  	ktime_t delta, nextp;
> @@ -70,7 +70,7 @@ static void tick_do_update_jiffies64(ktime_t now)
>  	 */
>  	if (IS_ENABLED(CONFIG_64BIT)) {
>  		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
> -			return;
> +			return true;
>  	} else {
>  		unsigned int seq;
>  
> @@ -84,18 +84,24 @@ static void tick_do_update_jiffies64(ktime_t now)
>  		} while (read_seqcount_retry(&jiffies_seq, seq));
>  
>  		if (ktime_before(now, nextp))
> -			return;
> +			return true;
>  	}
>  
>  	/* Quick check failed, i.e. update is required. */
> -	raw_spin_lock(&jiffies_lock);
> +	if (trylock) {
> +		/* The cpu holding the lock will do the update. */
> +		if (!raw_spin_trylock(&jiffies_lock))
> +			return false;
> +	} else {
> +		raw_spin_lock(&jiffies_lock);
> +	}

Why inflicting this horrible conditional locking scheme into the main
path? This can be solved without all this churn completely independent
from this function.

Something like the uncompiled below. You get the idea.

Thanks,

        tglx
---
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -203,6 +203,21 @@ static inline void tick_sched_flag_clear
 
 #define MAX_STALLED_JIFFIES 5
 
+static bool tick_try_update_jiffies64(struct tick_sched *ts, ktime_t now)
+{
+	static atomic_t in_progress;
+	int inp;
+
+	inp = atomic_read(&in_progress);
+	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
+		return false;
+
+	if (ts->last_tick_jiffies == jiffies)
+		tick_do_update_jiffies64(now);
+	atomic_set(&in_progress, 0);
+	return true;
+}
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int tick_cpu, cpu = smp_processor_id();
@@ -239,10 +254,11 @@ static void tick_sched_do_timer(struct t
 		ts->stalled_jiffies = 0;
 		ts->last_tick_jiffies = READ_ONCE(jiffies);
 	} else {
-		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
-			tick_do_update_jiffies64(now);
-			ts->stalled_jiffies = 0;
-			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
+			if (tick_try_update_jiffies64(ts, now)) {
+				ts->stalled_jiffies = 0;
+				ts->last_tick_jiffies = READ_ONCE(jiffies);
+			}
 		}
 	}
 

