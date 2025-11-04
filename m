Return-Path: <linux-kernel+bounces-884662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA4C30B92
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AFD421C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25542E92B2;
	Tue,  4 Nov 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XPYw2TLw"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4022E6CDA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255548; cv=none; b=RX5VrvyLVTcEtsqRET5TQ7VbqcswCpcUxYqNR5VmCV86TsNlm3l04Ff1/jTQl1sHYuM6N4IiouYcfwcFOEpe65CpcGnfgWhPGj2S9hsw3h9QVXN86LnPNz2hR3Yz806T5pwqQwwyS2MWYjEOMXdJU4g3XA26wofIh2qGMkLTScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255548; c=relaxed/simple;
	bh=6W7I6FSyzCSRCWSTmGdFVg89FYzxMaAmimzUl1dyH6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WlqyfhaR5vVaF0d4HVBF8Sj9239hjg1TnBKqVbHEyKTik3qPnBneXWuCnOcOfyPbzFOJLFyM6Gu6XhqOIPs014WWFSUSWu9E75jlXK/T1g9yc3gVxIhvlxn5rTI42NhAKjOsjC+36EqdV3xrZdHnLnKdTyMjpURRJ4KUY/dNzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XPYw2TLw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so2598409a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255544; x=1762860344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Xp9ctdrJTnuepb7+nDjK/iDuYp1r6PztWGWHY6lgNk=;
        b=XPYw2TLwl5fMotZoNGOLJnRgnxLdSE/yR0ymgovk97gypWWxp0ggWpaql+kjPkc2Rb
         v8Exgz7n2V0/hLKAY9eaAwd5barjJ1AUswB+OwlBbm74xetL3KQJ/cd3Xk0L8OWtveJc
         6VvfFmScEPhQDfQLo+5Nq37pzCZCr0RFtOy5hJlKP6ryuAtpphJbValpreyt/7NIpIHP
         voak97C849CRRnVQgb3M8su2HUdOHlOpEuy0o4dRpnQFoB+J5wjqoQrzAmQAw+fnclGQ
         Va/TZkRnB+MZV0EjtmoW+Xk7TtqnIXwGJRCAhxFTTpvBuAGrLTLMmbl8ElxSrPy5zHj7
         4SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255544; x=1762860344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Xp9ctdrJTnuepb7+nDjK/iDuYp1r6PztWGWHY6lgNk=;
        b=hGDtpOyuFm47h7Q8wLa1pIpQeOg6txrCAFpN/TKMi4hU2F176/SFs0kVUefh8f1BIB
         LxswjrkebWPYNJYXLwOwqBDGI+5w3OneXYUq30Zfx6VUq5yYPqW7F+xOvG1PCyAa1UCO
         kEujfy3Xm8DOoj6tae6G4xn5RKrsnH3ayta1DxnzyftO08IzYbVILle3GdVeacPWnKmb
         c7fz6KbbaUv47UdjBfylvBXBv9is0uS1TWk1yhyXwaOAIUJO0s3Z1/Cuq8oTKBV7zhUB
         tfyKo6rBK7eSi5NImypAt8n/Wzq8ov0N3qvtdWygY5zQgrmi5Vn7v4kyAKVdKjirNHsp
         p6Pg==
X-Gm-Message-State: AOJu0YxIrVKzBzePVWXZguw8sKGJDYHtbnT0iUl3Byj4UTvjr8XAHtWf
	UCDCLkQq5H1MyTO55K7UCHBRFpEQRiQzTEelD40CstgiLONgoQ4aJzfo6hJn8kxR81zukhCy8ng
	L9jHM
X-Gm-Gg: ASbGncthPDH980X7BxpKhV/BOi9QWd5Jc4+fDJDQhzoqzp2zGCS7Wqwqy6275EWcqnU
	/WBe5klT+cDTq4KU8Yq1Fd1LclOOpoXCt5GGi7ydYNKR4rVIyHVVYPHPDZzdH7JagqAhKhS7fq4
	5CnOLArr13rWgN4hYaCvScgtTHY4K8QjO7pE+qQ7lVXk65Hv4+huVZc8rg+5saaP08pQZgoigAl
	ebd/DT0jUa8nBYnrKosp8vdmJF6dLrNm+gBKhtgxIW+hbrTITP2ksLK8Yfu2Y0+UQ0qqS/gYfpl
	1u3mi8hKx78DekfVQX9g3gRyI8X3wm4UqKhrJrQY7E2kRulmKve03qwDPhXANf959Z8e3+OAxR2
	ETL7O8blbjKyWCdzgqGOj4HJSGf9so1S8X8gFUlEmMaADT2KeN3XAruu+2nm37M5aBdfM0YgQvX
	k6nkQ=
X-Google-Smtp-Source: AGHT+IF47+Ru16HFhBx79SrCPlvL4Uj9m+E95mkhvrJKGKHzgU0wubBE57igwdej7VLsMe3wY5redQ==
X-Received: by 2002:a17:907:2d89:b0:b71:c2be:3dd7 with SMTP id a640c23a62f3a-b71c2be49dcmr454970866b.25.1762255544042;
        Tue, 04 Nov 2025 03:25:44 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:43 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: [PATCH 0/3] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Tue,  4 Nov 2025 12:25:25 +0100
Message-ID: <20251104112535.139450-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
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

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1] Replace uses of system_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    Because of that, system_wq has been replaced with system_percpu_wq.

2) [P 2-3] add WQ_PERCPU to all relevant alloc_workqueue() users

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

Marco Crivellari (3):
  nvmet: replace use of system_wq with system_percpu_wq
  nvme: add WQ_PERCPU to alloc_workqueue users
  nvmet-fc: add WQ_PERCPU to alloc_workqueue users

 drivers/nvme/target/admin-cmd.c        | 2 +-
 drivers/nvme/target/core.c             | 5 +++--
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 drivers/nvme/target/fc.c               | 6 +++---
 drivers/nvme/target/tcp.c              | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.51.1


