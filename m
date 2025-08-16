Return-Path: <linux-kernel+bounces-772168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0BFB28F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A85C07E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB12512D7;
	Sat, 16 Aug 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K98Bhnlm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2947261C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362357; cv=none; b=j0PCVBv+fTtiGnPjXsBPvI4aDVQTT/QzdJVuwz1a/Mh4J+R2ndilB72MzR53BiGA2pZbzP7ia3a9uDsrD9z35JRmyttWa1SQ07sRVX4qs9vjiwXunWsriX5sm0+3a2uR09is9VI8DryZUmrx1RKPnsS27hGG2xtwOA0d3VLUCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362357; c=relaxed/simple;
	bh=vME0ZngE4bQl5kn0AQB2kMSges2+ADQpOtr9UnrzP5Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NZBYlzNpKbthnsdw5FA29hRFuJMxiHCVBZzqb41kRHMt181YaVMKoI4MgSR5lFgEkvuVQDpag1SbT/mNTj+FlE8DCtARb/IjP7Q9s3frV7ZAI+8uAbREykwF1FXC8kiq0RwuySViI/hEcXB8LOEsV/ukAS+uP9CF2q7IBMGtSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K98Bhnlm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755362354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MWmL2oVXJczc7g3P72KJ61eiH7fIoChDjNLW/W2RW3w=;
	b=K98BhnlmEtsw7tTetxrA8g8P5PbX6mwUENvFlgLMtl6eD95qJR0EwpHWmU0BsclXTukVMc
	Wvp8iWZg0ptWjDfn7wOm4FdzotzGCQDCi0EhO3FIHBuqQqTxL+dHdWyZy7zrLU+aD0n+cv
	YLYYJL6YMp3hMzQWLyi08s+KfnMiYuI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-X61t2arfPfy-WYP_FNXsyQ-1; Sat, 16 Aug 2025 12:39:12 -0400
X-MC-Unique: X61t2arfPfy-WYP_FNXsyQ-1
X-Mimecast-MFC-AGG-ID: X61t2arfPfy-WYP_FNXsyQ_1755362351
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-333f8f2c2bfso15594751fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755362346; x=1755967146;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWmL2oVXJczc7g3P72KJ61eiH7fIoChDjNLW/W2RW3w=;
        b=dpeWyKsm7jkxhnTpMHsn40YYCOmiSxHOuxYnexBEip1V/+QfWozfYBWCo8nvn1Pa9B
         /Up0lCVVHE9+z79gOvDwbyd2hXHnUFsmz2SYfea/bUp7x6pJeBxQoqg9IAkpPDdX9cmY
         PPCKKesoi99D2ql8gdsdTU8EeXQR/Cn+Ec8CYRjQq7ijfJCkNP8TKCfLm5m2gL64FXSa
         X9zV1mE/XR46UZ/nmWSeDf0tIfdO41CJDpRCUEEEBNIEYNf0sEjlnlvjpZirx59s5ekH
         +duULn3sPfKkStUNYp+kL9ATLCt2LBSHcDjmeY1fvc4/21y+Wm87XhG4U05XZUL1jbg7
         G8gQ==
X-Gm-Message-State: AOJu0YxU+IFgVSq4Cn1kSPDYkj4TpgFQT014d9zprvGZasb0lIV0wqQg
	fCGM4xxIK5edviTmSs8WEXgXcSk/Jr9+UNk1/TvKxzBAN5fKu5QS//RCVIjSfslPyfjv/ptp648
	O1+zsMkd/VsTDKnuLFlMRxqor3l62c+R1CYkXJTiA8O/AdeBvCjwK80E34VxS8pPrcA0TBzAfeE
	G9w8VjdvUaLLJbgLlxqPEOS1MOl/sRHG0vEXTyl0cRyudHWwaBsFI=
X-Gm-Gg: ASbGncsFV7HXPtdylp4AA232YPaYc0Ek6/JYI2WOees3vMnwES+jDq31VQTsi0kMYdR
	RMfri4QZXWCqNuLzVER5X9gh251Bi5cZpIpOCksBt7YLROnoXFIDx8w0XPlX/pBe+LFIZTkFVI7
	bCa6u9a7Tft70SjM0ar54=
X-Received: by 2002:a05:651c:2115:b0:32a:6e20:7cdb with SMTP id 38308e7fff4ca-33412bf36e3mr8539001fa.17.1755362345937;
        Sat, 16 Aug 2025 09:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe1LzaEmO1iJmTUOpOuUzc2NcK2Xe6SYrxW/YX2lAdgkIFkzE2iX9vTHjBsMSAgNT7LW6Z8Y6Zp+ERoByTUBE=
X-Received: by 2002:a05:651c:2115:b0:32a:6e20:7cdb with SMTP id
 38308e7fff4ca-33412bf36e3mr8538941fa.17.1755362345463; Sat, 16 Aug 2025
 09:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jirka Hladky <jhladky@redhat.com>
Date: Sat, 16 Aug 2025 18:38:54 +0200
X-Gm-Features: Ac12FXyDNtc3P6WeviznXzZhQIyN-C4FeizrScL5lIVDkYiMb_kok8ts04hBdNs
Message-ID: <CAE4VaGBZzpkfkBXbiuED8Pv-UnjQ5xSk+t=dAdwSjv=u7-b8pw@mail.gmail.com>
Subject: [REGRESSION] 76% performance loss in timer workloads caused by
 513793bc6ab3 "posix-timers: Make signal delivery consistent"
To: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	john.stultz@linaro.org, anna-maria@linutronix.de
Cc: Philip Auld <pauld@redhat.com>, Prarit Bhargava <prarit@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Miroslav Lichvar <mlichvar@redhat.com>, Luke Yang <luyang@redhat.com>, 
	Jan Jurca <jjurca@redhat.com>, Joe Mario <jmario@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm reporting a performance regression in kernel 6.13 that causes a
76% performance loss in timer-heavy workloads. Through kernel
bisection, we have identified the root cause as commit
513793bc6ab331b947111e8efaf8fcef33fb83e5.

Summary

Regression: 76% performance drop in applications using nanosleep()/POSIX timers
 * 4.3x increase in timer overruns and voluntary context switches
  * Dramatic drop in timer completion rate (76% -> 20%)
  * Over 99% of timers fail to expire when timer migration is disabled in 6.13
Root Cause: commit 513793bc6ab3 "posix-timers: Make signal delivery consistent"
Impact: Timer signal delivery mechanism broken
Reproducer: stress-ng --timer workload on any system.

/usr/bin/time -v ./stress-ng --timer 1 -t 23 --verbose --metrics-brief
--yaml /dev/stdout 2>&1 | tee $(uname -r)_timer.log
grep -Poh 'bogo-ops-per-second-real-time: \K[0-9.]+' $(uname -r)_timer.log

6.12 kernel:
User time (seconds): 9.71
Percent of CPU this job got: 73%
stress-ng: metrc: [39351] stressor       bogo ops real time  usr time
sys time   bogo ops/s     bogo ops/s
stress-ng: metrc: [39351]                           (secs)    (secs)
 (secs)   (real time) (usr+sys time)
stress-ng: metrc: [39351] timer          11253022     23.01      9.71
    7.01    489125.18      673113.26
timer: 3655093 timer overruns (instance 0)
Voluntary context switches: 720747

6.13 kernel:
User time (seconds): 4.02
Percent of CPU this job got: 28%
stress-ng: metrc: [5416] stressor       bogo ops real time  usr time
sys time   bogo ops/s     bogo ops/s
stress-ng: metrc: [5416]                           (secs)    (secs)
(secs)   (real time) (usr+sys time)
stress-ng: metrc: [5416] timer           3103864     23.00      4.02
   2.08    134950.34      509002.47
timer: 15578896 timer overruns (instance 0)
Voluntary context switches: 3100815

CPU utilization dropped significantly, while timer overruns and
voluntary context switches increased by a factor of 4.3x.

It's interesting to examine hrtimer events with perf-record:
perf sched record -e timer:hrtimer_start -e timer:hrtimer_expire_entry
-e timer:hrtimer_expire_exit --output="hrtimer-$(uname -r).perf"
./stress-ng --timer 1 -t 23 --metrics-brief --yaml /dev/stdout
perf sched script -i "hrtimer-$(uname -r).perf" > "hrtimer-$(uname -r).txt"

grep -c hrtimer_start hrtimer*txt
6.12: 10898132
6.13: 17105314

grep -c hrtimer_expire_entry hrtimer-6.12.0-33.el10.x86_64.txt
hrtimer-6.13.0-0.rc2.22.eln144.x86_64.txt
6.12: 8358469
6.13: 3476757

The number of timers started increased significantly in 6.13, but most
timers do not expire. Completion rate went down from 76% to 20%

The next test was to disable timer migrations with the 6.13 kernel:
echo 0 > /proc/sys/kernel/timer_migration

6.13, /proc/sys/kernel/timer_migration set to zero
User time (seconds): 10.42
Percent of CPU this job got: 59%
stress-ng: metrc: [5927] stressor       bogo ops real time  usr time
sys time   bogo ops/s     bogo ops/s
stress-ng: metrc: [5927]                           (secs)    (secs)
(secs)   (real time) (usr+sys time)
stress-ng: metrc: [5927] timer           7004133     23.00     10.41
   3.11    304526.98      518257.73
timer: 7102554 timer overruns (instance 0)
Voluntary context switches: 7009365

Results improve, but there is still a 40% performance drop compared to
6.12 (489125 versus 304526 bogo ops/s).

I have also tried to add CPU pinning, but it had almost no effect:
6.13, /proc/sys/kernel/timer_migration set to zero, processed pin to one CPU:
$ taskset -c 10 /usr/bin/time -v ./stress-ng --timer 1 -t 23 --verbose
--metrics-brief 2>&1 | tee $(uname
-r)_timer_timer_migration_off_pinned.log
User time (seconds): 10.34
Percent of CPU this job got: 61%
stress-ng: metrc: [6230] stressor       bogo ops real time  usr time
sys time   bogo ops/s     bogo ops/s
stress-ng: metrc: [6230]                           (secs)    (secs)
(secs)   (real time) (usr+sys time)
stress-ng: metrc: [6230] timer           7129797     23.00     10.33
   3.53    309991.17      514479.47
timer: 7152958 timer overruns (instance 0)
Voluntary context switches: 7128460

Using perf record to trace hrtimer events reveals the following:

Kernel      hrtimer_start    hrtimer_expire_entry    Completion Rate
6.12         10,898,132         8,358,469               76.7%
6.13         17,105,314         3,476,757               20.3%
6.13+mig=0   17,067,784            30,841                0.18%

Over 99% of timers fail to expire properly in 6.13 with timer
migration disabled, indicating broken timer signal delivery.

We have collected results on a dual-socket Intel Emerald Rapids system
with 256 CPUs, but we observed the same problem on other systems as
well. Intel and AMD x86_64, aarch64, and ppc64le are all affected. The
regression is more pronounced on systems with higher CPU counts.

I have additional performance traces, perf data, and test
configurations available if needed for debugging. I'm happy to test
patches or provide more detailed analysis.

We have also tested kernel 6.16, and it behaves the same as kernel 6.13.

Thank you!
Jirka


