Return-Path: <linux-kernel+bounces-819366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709FB59F65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9F1465615
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E62DC77E;
	Tue, 16 Sep 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmfj7YbB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F482727E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044162; cv=none; b=lRCZdW76vF5GOsCJfweJqsjZyQ5sOiwmMQw6X41w6ZNGK9UD1zV6dAwgaDr8qZQXTwMvBEjZTuyrNtf3AFOll+KOxEHDrJrwSdEe+F5TlnE/xNRAezfLgP+aApaBhxV1GDWbe91I5NgoVFZkOr7a/gch6JjYp+j1oSE4eXSP/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044162; c=relaxed/simple;
	bh=tlC3ZD3XEEuwIzmhG3I6H9Seyhjw2DIy8AOuxOlbPw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkcJfQ4zfmUTxB+J1XGan4tZo0BUXR5KDZF5DrR9ddEjoFgoQhumm6kigd+LWtStqHtFZtBAFnNjLhkNbSW6GFHTNhn40X0Jbu9dp5S2ngLJF9B0VsVF7YX2eV/nhhsLv/fekG5UBE3NhYs7n1r+aENIVepybnKv/bkX52BGyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmfj7YbB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5720a18b137so3550027e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758044158; x=1758648958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2Ihv5z97gqsBIftASj6vQfuIv22E/RdI27GnWOHZog=;
        b=hmfj7YbB00tmkxD6Q69eoJTVU8haAsxplyXLJzDTYnMLcBmgc1tI2bx+RZpw5H/JOv
         gHgSe6Zs8T8sTRrDhXY6n9e0u8lQTW5w+6cmvUIo6jmyP8qUF1ECCvq6TqOuhqWdCPDT
         aQK1EwbB9tnvp2oXJme+AkyaZzO2bh/Kfq+9UlyeIwt5k0aKxhG8uxAS63XQCgr4FYch
         S9TY05FniKWihxhLe9iQ6gO7xwgjGp4l5Hj8blrPMwFYP7tmQY2de+YBBbJ8ul8a/MT3
         rCRAyMITYWvU8KWLXH3VsJThR4LWJToEe/PXnHSz1tWDW2tKW5Ps9xX4Dr7jmjWwNTYL
         jaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044158; x=1758648958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2Ihv5z97gqsBIftASj6vQfuIv22E/RdI27GnWOHZog=;
        b=uNUls3agAUWKMUDgVndus5Az1fukDOR6t8GBULVMqefGcZJuE9QDAHwVExrIQK2Aju
         e5W7Msd9HqZl9bO2HUcgP6oPcLGVgKMoudIPw/YKOm/epzi2+m+EtXO93Hde0AoWwwc6
         xpmDdu3IBqRcTtbfooNC4TZ3ut6l50gCJLRmEB3gM7lxwkmhz7KmI9re2oq6PycEsVK5
         iXyiDAoxaewy+ljh/1PPfCUYAgpsFdMgOTkYWqQi1uPqdNcCdUGHQyCPMx8qJeOzSWy1
         Va9TUHdXtqCaapR5JIFdmdoWoFJJwMOD8JDTtGALE7PYDgAhmPD/+9rz9JHdf3HKJtvm
         Av5A==
X-Forwarded-Encrypted: i=1; AJvYcCW9HTXyCpSpxnAtcOGGMyLUefmjVzTxNyrE1dIretzVdOWTWKebbCKkQe/oB930jlBFGll+5xmhplud+Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEWxSEQ2TDClx/lXnizVC8p5tKN066nJ5wAGuQkwi+5OBteAS
	DfYp8wIowmtOp0cT2u+Vm6sb4e4c47Gs1sMU6MZJNTUPNNkIATRrRagpZ6uBUreM3w3BRwbZvxG
	j2oGUtHcmpfO1nuhOrxUytQEh/l7NPHZT0+o6O9E=
X-Gm-Gg: ASbGncspb7G6XWIoJgGnZrpzZbo5fxtZ1oGFWmCK7GUlXMiJN/FsyVIfEmJlmUG69HV
	mrYRxWC042uNVCxlPUA/OSkOJl8vrTa+sIp2U3iK599+iplzPv8KlYMaDw1JpDPql1yKsNOXTfu
	3p8qzTa65I5WHQaTBzc+/KMJwf+d34Ou+8mcae9pfXGgfxBmixLyfHkldilb87nm95elYI7un+R
	/8myEHy1WCmZ8ioIE9REYt8pMAR7njqwhVaPow+JoA=
X-Google-Smtp-Source: AGHT+IEeOyQT/lthV2beQ4II1JnDAkhNQ3aqSPZuuPpfm/xPLkUoxEmFh0A9Df2lSwWHJcqLWZoa9Z01WCgm86xt9hQ=
X-Received: by 2002:a05:6512:b1b:b0:576:150b:ca3 with SMTP id
 2adb3069b0e04-576150b1fa5mr1226683e87.12.1758044158226; Tue, 16 Sep 2025
 10:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com> <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Tue, 16 Sep 2025 10:35:46 -0700
X-Gm-Features: AS18NWAT1iwwiB2JuNj2hNEB_Z62vRvr_oY0sroq2yeOM5t2h5L6YRSHiVhKW5s
Message-ID: <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Suleiman Souhlal <suleiman@google.com>, Qais Yousef <qyousef@layalina.io>, 
	Joel Fernandes <joelagnelf@nvidia.com>, kuyo chang <kuyo.chang@mediatek.com>, 
	hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Now, the case John trips seems to be that there were tasks, we ran tasks
> until budget exhausted, dequeued the server and did start_dl_timer().
>
> Then the bandwidth timer fires at a point where there are no more fair
> tasks, replenish_dl_entity() gets called, which *should* set the
> 0-laxity timer, but doesn't -- because !server_has_tasks() -- and then
> nothing.
>
> So perhaps we should do something like the below. Simply continue
> as normal, until we do a whole cycle without having seen a task.
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5b64bc621993..269ca2eb5ba9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -875,7 +875,7 @@ static void replenish_dl_entity(struct sched_dl_entit=
y *dl_se)
>          */
>         if (dl_se->dl_defer && !dl_se->dl_defer_running &&
>             dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->=
runtime)) {
> -               if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_s=
e)) {
> +               if (!is_dl_boosted(dl_se)) {
>
>                         /*
>                          * Set dl_se->dl_defer_armed and dl_throttled var=
iables to
> @@ -1171,12 +1171,6 @@ static enum hrtimer_restart dl_server_timer(struct=
 hrtimer *timer, struct sched_
>                 if (!dl_se->dl_runtime)
>                         return HRTIMER_NORESTART;
>
> -               if (!dl_se->server_has_tasks(dl_se)) {
> -                       replenish_dl_entity(dl_se);
> -                       dl_server_stopped(dl_se);
> -                       return HRTIMER_NORESTART;
> -               }
> -
>                 if (dl_se->dl_defer_armed) {
>                         /*
>                          * First check if the server could consume runtim=
e in background.
>
>
> Notably, this removes all ->server_has_tasks() users, so if this works
> and is correct, we can completely remove that callback and simplify
> more.

So this does seem to avoid this lockup warning issue I've been seeing
in my initial testing. I've not done much other testing with it
though.

I of course still see the thread spawning issues with my
ksched_football test that come from keeping the dl_server running for
the whole period, but that's a separate thing I'm trying to isolate.

Tested-by: John Stultz <jstultz@google.com>

thanks
-john

