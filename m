Return-Path: <linux-kernel+bounces-824753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174FB8A145
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8AE04E248C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC6314D0F;
	Fri, 19 Sep 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OqEFGsEe"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C2257AEC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293458; cv=none; b=pJYftEcQ/nLayiqZfNfYTG1eDSEWaY4ieSHwU5DV7wdZ4IlCc1hRkI9wQtH/nsBs/sdoT9i7ZgFz1mzCvln1lMapTX805niPgZRnybtpp5Wb+lca+3gTARHVi6C1NnX92ONIURZlOrgm4Z6kfRx/aY/IhDTL6bt6186LNAouKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293458; c=relaxed/simple;
	bh=eHLNUygB/VZPzQfrdpRf+rYxokJiHSA09acDWZOmNYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ktMZ0SFU9+V+meq9Git8ZqOWf5wnLiMQISJCnBllM6XXl8E7PkigRbPxMynunXuAu6xvUbN+tEnxoerUWyaV/QRNlI1YcXOLN0bCJAVHBcOOp6OJm749098f81PlvkbKzuR4teEJbG4KySOFUiOKth1uYQ3GaKrBvmacmOxauz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OqEFGsEe; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso25273755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758293452; x=1758898252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkKXFt050iBpd1q1kwfDPcpxL0hJR2YAHnRn43yZJzU=;
        b=OqEFGsEelFg5WnDC8mXDsGkiiwLv5+3ofPL9YH+UnRqSGJCLkFGnuwFT9Py6sSJKIj
         cBIXLrdn3hF0T2H04cY1FFnGMS2lXT1+amtza4/boR8fXGYbByofP2PMxI1TcXzEuPdd
         Jn8Poh73OOAJVTpbqNoLLLxRKDYWMkSHmB4XuT0RmyvX1rkYbivqwwQ0jMfOKovC2H+Z
         d2n7FyGxVV7YJsG65LRHYr6rBy2hWKpaYNZFY71p85/cMV9yoqt+7ZxAiACkBNvTG5tw
         biFHLsUVDNpvEDi5scY/uCeyu8PS0DtfAHNNaI/iVGjG6ncx12I5AH9HGp3AHLWDKqiM
         5X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293452; x=1758898252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkKXFt050iBpd1q1kwfDPcpxL0hJR2YAHnRn43yZJzU=;
        b=uu71yqFLlm1Cde7FBYTBwGcQINvMFwE5+MR8T2JhL+WpAaxxr3Oz0uWKHHQ9Qa8m/q
         Z6BI9kHw3dGhIPKkGBVeclZT12p9gpoN0BfSQsk3hCmuu/m2tGBfsAv9G+SRUcxCYAox
         95PeDSGPH4Yum58jSDQQcS7GqXv7InyGdYfE+d24UukuP+I3MBqX1XHX4/skAm0rEtgY
         Mag1p3ryo9DeZrpDvOF0Vig1JykK8sBkmHIPOvRaN3iBnyVzmUTOyKXPC6s7Jhq3IaYI
         zuST1AVDFAnmCBPEsILy8Dgxl7jUqR/gjLSPdjwNLjx8OBJgtp1pkMtgbJb5jZ0Ay02a
         o6oA==
X-Gm-Message-State: AOJu0YyAoO+Yp2fIGSkiy7BgtYXupFITc8qx19E6cag2PACYMwOosxrJ
	yDufFVMgcuwTLIA1NpOumYE1rgc/6l3hNWodTQiyPRkhMxirFIGb2aJv0eTtRgVVMbSf2Nrpz3K
	fRGLZ4F731A==
X-Gm-Gg: ASbGncs50u4aMMpdNHfNnufvkTFC+0vDYOS1xC8NLsl5AfeEVJJ/ohjWpd452ZJg7mw
	FbnjR9ffjkY/a4Yj3AG+z5QXO3QzXRCBsKbT2IbZ/GsVTHyeGpinyqi6TlsgrcOkiiyWbVxuvMa
	U1ztbEMNn936Y2LsIVdOzDokWKpGrfRQqwpwQYNehes1Mo0O9oduidUmVT5T7ec+qyYZUt3UlDs
	x3f4n46RjkZ8txdsoejAbUqJ2XuqJmnIxJrkrGymAGEIKO98zOopMp33bt2jKCchmBEmOXGtIHr
	5GqqE5W+X81wCUgsJ5ffUQf3NGFUpzgy+HsSFol2Ep0i2kbCYIEfa2k2c4wlTF2C2Wj5/kJyLdr
	NpoAQ/kjS6O0aUeU/xdy1bEjSxHpdq6uaSq6wR/0CKBceUw==
X-Google-Smtp-Source: AGHT+IE0AyRQFy027O0we9IFGaJ57T0mN5jW/Xm8OltK/XV8i7+HDlJxVmBQqOlUogJN4zAsYSHkmg==
X-Received: by 2002:a05:600c:3593:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-467e6b64adbmr33591565e9.1.1758293452249;
        Fri, 19 Sep 2025 07:50:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm86220025e9.3.2025.09.19.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:50:51 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 0/3] rcu: replace system_wq and add WQ_PERCPU or WQ_UNBOUND to alloc_workqueue users
Date: Fri, 19 Sep 2025 16:50:36 +0200
Message-ID: <20250919145040.290214-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

2) [P 2-3] add WQ_PERCPU / WQ_UNBOUND to alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.


Thanks!

---
Changes in v2:
- removed WQ_PERCPU from sync_wq

- added patch 3/3: explicitly use WQ_UNBOUND if WQ_PERCPU is not needed


Marco Crivellari (3):
  rcu: replace use of system_wq with system_percpu_wq
  rcu: WQ_PERCPU added to alloc_workqueue users
  rcu: WQ_UNBOUND added to sync_wq workqueue

 kernel/rcu/tasks.h | 4 ++--
 kernel/rcu/tree.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


