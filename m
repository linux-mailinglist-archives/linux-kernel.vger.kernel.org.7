Return-Path: <linux-kernel+bounces-736800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654FAB0A2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEA87B1F45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760622D94B6;
	Fri, 18 Jul 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtZ0n1q0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAC2980D3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838743; cv=none; b=nK+wjB2rvRMhNefaZLmAyvY5R0BDM87H0Jna+ysKVdQN75IQa+KwOvECVtR/Tjye0JIJxCkWHICLUKbMU6OOGXxeH/lHMMBc6Y5iYSUhSBoqMWonINGR2rpCJdoKQlgU+JyJ0MWZSn3vE7otayzBYIiPQxyxLPK30qc83vrwx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838743; c=relaxed/simple;
	bh=Kf+7oh36QrDwS9mZM6Amo65cOEloLJksi8e6ghfmAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUjihDN+gYJ2OR/jmZ1Ev3FpodRVXuC56TI0fdXG1YYZN9ZOlZUBCf8BPpB2Kjh+HJiZKObTCu95du/rBD0MooXQKhSHRyN3aZ+NRKLwSn2sNCRqN34cXl+MsIZdpC1uvg3tMhu6W+8TXqxm86M/c/aG0OuM3h4FOk6kburlKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtZ0n1q0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1151839f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752838741; x=1753443541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZPJJ+4Fgqu+sH2cmZAiUL7oZgaQVG909PxYnaGG3tA=;
        b=OtZ0n1q00HJ+2G0KbK/PnKbNQKsOwzhV6aurSOKVG6a2++h2HqDEx3r7xiKbcNOi0i
         ueKIgmlM3jHis73Po6PBi9XdN0xKtR7BOGShe4jihtNWNGWiX6FokNGudw/GYiLQEnGz
         wZVyQ8cBJmBipEJwtzDLcHt/9+fmRVgSBhKQFh8t3CY16A+byiGhNwmDrJM7UQvR5opz
         PzfNC/rOFbxVyrvW8dCkS8XD3jswBhCoA+sRausWYmsxlMUKtrNsY/xYTYuTTQDPFlaR
         eKUbyRXMEqBNhPckmBS7SFKooiZpZrmM3juj5DBuV8H15z7w1kg4iV99OYwgw0CSdIk+
         5QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752838741; x=1753443541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZPJJ+4Fgqu+sH2cmZAiUL7oZgaQVG909PxYnaGG3tA=;
        b=emm3olbg3PBxqPYcWrnNhZnY6y4G3SZUJy2Zi7dbmwgGG6EY1fsK6kTJPxqA0efWRO
         CN3w/5P1WFofti9gZ1iXGIZrFa1fcBF5jLTuImy1xs2wKfBnWwnuvsWWPJ4LZjl65yDY
         WpME9m+bi0F6gKuHny9EveIPJ4R6/kQGsIow3/U7Ob9kd+soc3DhYp1nre/L9nxPpdZf
         8J5Qo0VUtJVgX25jZvhLJ711HgB3sfSR4wXJYjV7hqyZvOuGTPZ9bpnIW0Dmv1TeDCWk
         pxNwRONU3KcCPng51zQyYTf40zNVv+w1qLG2YB5pWwn47HKGjA4fQp+y9vDKuEc+sk+8
         z7xA==
X-Gm-Message-State: AOJu0Yz/k+GN6w/pzmUOdX3wvLeGskvHGP7t8iWCm7fYkEy9r6XJxgbE
	aiXo789QLEv4cfzXFvQiAyfnBfZCwq1LVg1lY21weZBR3MtAsWjGf0jB
X-Gm-Gg: ASbGncvQajBdft9KmKocCuPxXgBOp2ssoSItkb5I1a/du4MLMjEoVQd2KeXCBQfQRxi
	WRweSBCL9rQWb3KQhN7AnJ/ynMTPAzldnBezPY2dOZVVp/b4H15pYgBNdho4bEvKfgWeh1gXRhF
	5ddHK6KqHVhu6KUnBBiwaVrOSNRjdPCy25QrSvya4MUF9ucsOxGBCreBWv4Xw/arHYWKDYZvPzy
	9nF+8MmU2WP/sbGlgN1yE+eXlRn8mrX2TwIyu8Q4qDB0bBp3F4Y1Gz+fb8oOwF20DR9XAW0kSam
	dWMy+F5G0wB7BelykA4i21swI/2SlhYQBwRJ4t1rbXJBnx0qDCXVsqBzaWMlcq4uNS1ijTbcxBE
	miPY04W2gBQkRpM3XdZw=
X-Google-Smtp-Source: AGHT+IHoLT//xE0B+m2Z+ETBiLbTrQD11ZoGk7/kx/48CLz4tdYNBBqCcwJgKD4soLPldsqYkSDTlw==
X-Received: by 2002:a05:6000:290a:b0:3a4:dc2a:924e with SMTP id ffacd0b85a97d-3b61b0ec050mr1693954f8f.6.1752838740649;
        Fri, 18 Jul 2025 04:39:00 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48bc0sm1605163f8f.55.2025.07.18.04.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:39:00 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [BUG] Bw accounting warning on fair-servers' parameters change
Date: Fri, 18 Jul 2025 13:38:48 +0200
Message-ID: <20250718113848.193139-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I've been lately working on fair-servers and dl_servers for some patches and
I've come across a bandwidth accounting warning on the latest tip/master (as of
2025-07-18, git sha ed0272f0675f). The warning is triggered by simply starting
the machine, mounting debugfs and then just zeroing any fair-server's runtime.


The warning:

WARNING: kernel/sched/deadline.c:266 at dl_rq_change_utilization+0x208/0x230
static inline void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq) {
    ...
	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
}

Steps to reproduce:

mount -t debugfs none /sys/kernel/debug
echo 0 > /sys/kernel/debug/sched/fair_server/cpu0/runtime


It does not happen at every machine boot, but happens on most. Could it possibly
be related to some of the deadline timers?

I'll probably follow up with some more tests to better understand what is going
on but I first wanted to bring this up.

Have a nice day,
Yuri

