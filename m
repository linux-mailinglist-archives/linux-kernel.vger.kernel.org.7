Return-Path: <linux-kernel+bounces-815648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB24B56967
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2872F7AC55D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F891DF755;
	Sun, 14 Sep 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aWueR1n3"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5131DC988
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857475; cv=none; b=YppRACwa01fQIy9twYTvWLZSLKllpylarnY2LX7IyUMCbNedeapZN2B17mn7fp0FYI5MPuBGEcpCcruh7ze8nX2eqE6FSY80t1/wKHPkWJ51H2mjIQboW71yz0tJCcsc+kLvHFSQdnbrNgnXcUbgzvu8mKRqfzqnkK6VX7FAlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857475; c=relaxed/simple;
	bh=JAkc+B1m/oGM5nInrVDwEgGa45ayzug4JDYJByhOw8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XB/m+OK08c99dmUo7uCu82ws6pNV9EO9f+sCAFubH3WbV6nMH59pWzp1THsgFAByY5WocbvW0bn6fGwbnBNEJnLBT3EmLY96ezAeIm7VrLCwZoD3YfOL8ZkaEE3eRyqIenkECwOZ0ZdxUANd5gCctTn4on2dkqSHS2r9eCjwRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aWueR1n3; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1997050f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757857472; x=1758462272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUk0OvoOErJPO2ApTPrgo/VFQ0MEP5hd5qY7R7y0UKw=;
        b=aWueR1n3V3Ir3HkVFmWryoss5B19uKxmNAhpYxnNyPO2vW6SvQNIqeq+ZrcugK6735
         YAGNKPaWo2PXItG+fBVK2YUCvLbKo1017OExFYaxWCyVz6fJS1CARFUEsERNaPzpNq/3
         UrZCOl70ma/93s3PHhbnsyZ1TTphZ0pWFQsfd5yJn0M/KHw16AZ/qqW9z5ByQMDRkSZC
         M0+MzJx03K0BRUZGpQ3x2jDhKMs4aAjeg3tf7kG7cz6BL/x8dsT7KNbjTCoXap3tLGKM
         2VJIxN73oGVFEHY6p49+8vguTs6zBzJhcuhKhxMNfw7sXALAdB43Pig0InaSL6CQgO+5
         BaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757857472; x=1758462272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUk0OvoOErJPO2ApTPrgo/VFQ0MEP5hd5qY7R7y0UKw=;
        b=KnNTfmLCpEI4buMIEKifWKkDJOp//AlJvcrX+NnMOcd1wk3SrQCx19evu+HdBCRPre
         bTpxxCD4dE8tvk4oziucgkpWje/vM4prjiznAzWtPrtSQnYSsaNismFFvvIOfXTZMPtU
         TdTb7na6bkRNSTKAoeFbOIFMQ/IHtQSw8KugdF6Fs4HM0mSruoD0qpq58we1QHzwQIxr
         M8Uyiiwry+POCcmJN8EwdQz2nj3eeHPkpt7qtz2j5YFSa0lQHUOuk+WVhalqpVaKfSyA
         XQx7c0hZnWIBhMNgJQ3UvkzYGTj5TyjDgPMzfDbbz5RJvdwdi54XS0Ke2wxt4xAFjMMP
         PlvA==
X-Gm-Message-State: AOJu0YzPSADqIqT31H0xcgJg2W+CDvax+y+9uX6Rx8LWHGy4j49Dpd1P
	rj4GuK/MRNPtD2jynlIlO5pWHGRYR4tdEcM7eqMZnksBtcwwIpQmrw5uDz0pmHijq98RNzrQqw7
	KuN6UzDFuDw==
X-Gm-Gg: ASbGncu/1iUOafMJaqM1yQS4J+D/0gRugotXsXvuQoe0knkGojTmyrXgn+WWjmwVGvp
	oRFBE+J1bSWYY0q5C5loA0L7Lxild4AaE2MMWxsjSVm5z+ykSeN50vvggNxrZcaL87pw3w14Av+
	o0Nsmx0jIf42ynW2q5FkH72TErP6eomsIierf3crNC5RC8w2zeWGQvGYL75uZz9vMgLlWgvLf9S
	mOVVFvq0um/WhiodxUgIN470BhWnOPFnPD8sOg5M3wFqV4uixNRErH3nlCbwtphT4XgZWn26oC0
	U0rSWUFJa1JvbNMjg2ko9R4SRuEZTHt886xkStnRZ3JNu8wST8L98jbmBs4m9heNKKvvY497K0Z
	F4UAu/ENWWCjugaJvCLetUJ6rMh0YNWowT6TGOOQbxKFkW8d4Bl6uZo0Jdg==
X-Google-Smtp-Source: AGHT+IHbqzBdb0Js23g605n2ZxxYwLkOj2itnX45G/fiJq+R1w0Yvh+M34rGcYMxNCtzUJCOAvp9RQ==
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8fb4 with SMTP id ffacd0b85a97d-3ea66809353mr786533f8f.20.1757857471874;
        Sun, 14 Sep 2025 06:44:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e86602a7d5sm6318876f8f.62.2025.09.14.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:44:31 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 0/1] workqueue: WQ_PERCPU added to alloc_workqueue users
Date: Sun, 14 Sep 2025 15:44:25 +0200
Message-ID: <20250914134426.43269-1-marco.crivellari@suse.com>
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

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

Thanks!


---
Changes in v2:
- removed patches 1-2/3 from the series (applied)
- added WQ_PERCPU where missing
- work based on top of the wq.git changes


Marco Crivellari (1):
  workqueue: WQ_PERCPU added to alloc_workqueue users

 include/linux/workqueue.h |  4 ++--
 kernel/workqueue.c        | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.51.0


