Return-Path: <linux-kernel+bounces-802443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC786B45272
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A5616BFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B389284689;
	Fri,  5 Sep 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XQQ8LwjK"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949F27C875
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062983; cv=none; b=OmddPqPW61c2q+Ls+zo88s9gLr0haZbVIB/yeICjUOHhdSC/vtDKi9/kT5OsOSOksf3Oh9/ZdmoQm3aBC/6Qmqjj2S/mIdHX1B7F06+BhuIbZOpKyLxZHTVGimferVfY6q5RmQX0Lsic2cHURwFozHoCrG3D4P5NYUpbJ6slovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062983; c=relaxed/simple;
	bh=PqS+1LjKbOZFfXeOLZ4D+nEV7+N2cBwmDrpXGJ9QeaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5J5azCKovCX321OCSSGEly6ss5OFNFy/Rin4T6v8Y38/MQGkcC6+tWe4QlCJywqGgaTQpLjPrbYh2/yvPiESM4qXfBxBqZkymnRDmw8YFBiyz1VZxDaDz1MLMbYNm0QSYiEgfIJdWUmwzPzuf9OZb2Sb0gWP80195cvtVIXK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XQQ8LwjK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so13597435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062980; x=1757667780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLmNojkhKQr+ZfpCW6o90Nh9aVEoHIgPx0cWvx9O/2o=;
        b=XQQ8LwjKQazzFndC+TSyFmLYU4SCzB4fJsTlIsV3ut9io8OwqseWGWtZXDyCL52ytd
         XmACSVSVb3DW9cLqLNEWg7ou7f2kydf4o2O0d0Fs7TxG/Vhk7HiqPLb4LwQf9AvFnUEg
         C4+jger+9czKmvlc/XhwU62nNWIKlGbt+9bpQdi6sXpIJto3N0Utuqan5jU1Pvc4Xes+
         XzMnIfwNP9C9bARZyB9itOOHU0cz0fvNHK5xglhZDlAqvAggnYEJw6WQeVombT04Vwlf
         QDFPfw2Ej3pLZX1I7Q4taD4v9AOQLGBaSWOkJ7mWI5t7iF5uwtFC+ZlnUtf8b3NrW07C
         CnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062980; x=1757667780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLmNojkhKQr+ZfpCW6o90Nh9aVEoHIgPx0cWvx9O/2o=;
        b=gQ9Hvf7PgVfw04U4u5J31MhFM9MupJW8c+ZWsjz42gq8QSZ+GxB+wnxW46FyclTR1Z
         OsohscKq17t0jV3CIwxwNMT9GEMmAQNIf6MGmXuYW1zOwEZnrrfCNsm8Zf1mAw0y6sTC
         YQt472gYe1NHq4lPDcyyEy+VcOhyrfOfN4v8hI3YQppx6AqDtiTlXYF8acZTb1TSFsat
         gZVFEP66ZPgKu8T1lWKI3etOBx0pluuPD9Bm7NBT/9uz9bd6freEhmXVvIa0tzdhQZYJ
         DQGOEpjcbdcTRRyjeyPatX+JhQf4QrYXj+LjsrXT1i0mtfces94BnK0L+/5NC5faiiAU
         ng8Q==
X-Gm-Message-State: AOJu0Yw/A/N3kzSfXdQxUa/Sn6NsooDrB0r2tBkdSrtz9Zqq9gj6d7Wh
	/C1gIPvJxoBhsvTvL8zejkNv5g/OZg92+8qVu1/jv9SBBPVnDlizVnGyckXfmVVHlpW8voKyNVX
	uLjDX
X-Gm-Gg: ASbGnctgo9PtOqaFQYn9kekmB7zDtqVZ7awsxe/B6b0K8hO++S8wWjY8soMlXIfTfkN
	G8Yg8kpp2ongObw1APJBBGkUUi8SveFDVv7JhyAMoaxH/53DOfSiZo4LRoHv5rRdzOKe/WcRzdS
	Zl+aAEGRL04p9hGFS75XJn5zyhvGlI3iaOB+nbIjhyM/32qqA0KXNfl9hJ3rv991qUN3jWsm3E9
	UazF1gghCWL+S46HiPga2w3wztHs6QGq5EnUp6g7VeSbEYTj75WV/Nx2CLqBJ/El2GLstixXIIX
	RlSnbUHTxDfx186XzQDc5KT/czXd2I1W0dniiP/USo52x8J/TyhUSAl6BV40gIfZiO70todgAvH
	u5VcEpedak8BpvRRwShyl/dt5Y9oPOWEWYfkflqOmiSOCYK8=
X-Google-Smtp-Source: AGHT+IFJDeW/8tfML5qSKSXOQzK9oSLt5fWvP4818XXNHL6v4h7OHzowEX79FOVh/ifKvJcru8KA/A==
X-Received: by 2002:a05:600c:c4ac:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-45b85525d98mr188143075e9.6.1757062980009;
        Fri, 05 Sep 2025 02:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm19653105f8f.28.2025.09.05.02.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:02:59 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/2] io_uring: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:02:38 +0200
Message-ID: <20250905090240.102790-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (2):
  io_uring: replace use of system_wq with system_percpu_wq
  io_uring: replace use of system_unbound_wq with system_dfl_wq

 io_uring/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0


