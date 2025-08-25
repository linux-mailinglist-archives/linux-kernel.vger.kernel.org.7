Return-Path: <linux-kernel+bounces-784478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B6B33C80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B467189315F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C2F2C1597;
	Mon, 25 Aug 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZzu5ewb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFLAhtgz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14506393DD0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117361; cv=none; b=vC2RL7jvbKv0gQ9Fxh+GLC6seMQARzxbNfnofy5s3qWkVCJcYuN8FQueA9qxzt6CJe6SQDOJ1h5PkgBTNitWyF+s1tVfCwosRMADHU1TGoqHrrHqi7sbJ0B4ZuSIo2+o/Cpc13dlHKY20m5bAXRH7awC0jv7dhasdfDh2mN5Pm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117361; c=relaxed/simple;
	bh=V4fmVHb2IiA9AWVftkQJZlrP1SSHDUUyOxb3dd85M9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqfn8dvvP6gUHMqky1aW5WE9HbFkQv6Uqbmg3McgNfbTAcLuYtCGoKIT9nBDORoQT2ZZtibtQpmmQcZM/EqtY7ibDdAxJvApBeRPUFoKhwJz8zyE3b7JiOZF4FiLBW8VJUff1NIOuUd5DubBpmpWR9HndbiIrfNy6r725XsOQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RZzu5ewb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFLAhtgz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 12:22:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/1nKUqNecknlqp2vb1Y2FEbDISE9b/vjCF4dbIlY/0=;
	b=RZzu5ewb8jYNZMWpjaON9LY9X5FZmwJAJ95YatmjxybP0B38JxnQjuXavCWP37nb+evRDd
	UIWG1kXQegEy+hm7ODY63tAUbOE+rQzuT5TrbrbcXZYVBs/rGE6dilYYBAXap49vSD8BFm
	mrek7rLg10vu8Kdk6YYkL6dU+aVOCT/Gzb7v+Y2nKHIG6qHmBrrkHkhqM9PtwwGS83/+8N
	4cf1GvRrF2rLWYGH5SkdsqG4krZNCtC5bV66esGnLBgmFIxaZAfnCMzs0S/mN9V7V9gKUJ
	pcNtFNDKusjYr2wsm+uBieylP4Al2kHBPy4ro87oSDn/STRr63kHu3FXBmBE0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/1nKUqNecknlqp2vb1Y2FEbDISE9b/vjCF4dbIlY/0=;
	b=gFLAhtgzWcmRxI84xq3dyMQO66/3UnP+qp+Awa7exsNloRJR7Tb6utZ4OzhS1jaBQ0eqGP
	UDA3UJUorWT17TDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	john.stultz@linaro.org
Subject: Re: CLOCK_AUX stepping
Message-ID: <20250825121415-a748d95f-7cfd-4d28-be56-dc0addc27ff1@linutronix.de>
References: <aKwsNNWsHJg8IKzj@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKwsNNWsHJg8IKzj@localhost>

Hi Miroslav,

thanks for the report.

On Mon, Aug 25, 2025 at 11:26:12AM +0200, Miroslav Lichvar wrote:
> There is an issue with the new system auxiliary clocks. When I make
> a larger step of a CLOCK_AUX clock (by clock_settime() or
> adjtimex(ADJ_SETOFFSET)), the system slows down significantly to
> almost being unusable. This didn't happen with the original
> tglx/timers/ptp/driver-auxclock branch, but happens with 6.17-rc1
> and later.
> 
> Reproducer:
> - echo 1 > /sys/kernel/time/aux_clocks/0/aux_clock_enable
> - git clone -b staging https://github.com/mlichvar/linuxptp.git
> - cd linuxptp && make
> - ./phc_ctl CLOCK_AUX0 set
> 
> "echo 0 > .../aux_clock_enable" revives the system.

For high offsets we are stuck looping in __iter_div_u64().
As far as I know, doing regular divisions in the timekeeping hot patch are
problematic on some architectures, so instead of storing the offset as a
single ktime_t, we might need to switch to 'struct timespec64' and do the
division on clock adjustments.

Can you try the following patch for now?

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 8ba8b0d8a387..8190e9dc6569 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/hrtimer.h>
+#include <linux/math64.h>
 #include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
@@ -143,6 +144,7 @@ void vdso_time_update_aux(struct timekeeper *tk)
 	struct vdso_timestamp *vdso_ts;
 	struct vdso_clock *vc;
 	s32 clock_mode;
+	u32 nsec32;
 	u64 nsec;
 
 	vc = &vdata->aux_clock_data[tk->id - TIMEKEEPER_AUX_FIRST];
@@ -163,7 +165,8 @@ void vdso_time_update_aux(struct timekeeper *tk)
 
 		nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 		nsec += tk->offs_aux;
-		vdso_ts->sec += __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+		vdso_ts->sec += div_u64_rem(nsec, NSEC_PER_SEC, &nsec32);
+		nsec = nsec32;
 		nsec = nsec << tk->tkr_mono.shift;
 		vdso_ts->nsec = nsec;
 	}



Thomas

