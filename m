Return-Path: <linux-kernel+bounces-879928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D59BC24697
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FA224F1D28
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3C33F38A;
	Fri, 31 Oct 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fcfhd2Mm"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD1334372
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906031; cv=none; b=oBhuMSiNwTDahfxEbgOpzNV6rIbkfN7ELGkg6KVobRREIdORq29FGohdWpBzCywDumZXawgl8ZirCIJ3yY9gYTtTVv1W8zQJmn37MjNv4VAdnOPIgjOWNY4MgsqO1nSldqqlqkZeZqspqubrFU+tLbcEJjnp5pxr0/Lr3Ijtusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906031; c=relaxed/simple;
	bh=t+ASZSj38mNjWIt+szRzuDIEuuqJDPVtVyUF9GpfKRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lfachDy186NHuj2P8FG1cWmEyXLyG66emnTZegTpNEqqM7jL6Az7xY3Kyc7gr0gUraJabZOw5xRmfgPj/1m7lu4CWhHH2MHc9cRCOJ2JBgg0cElHnMGbaa/i/L/WzPiRZ2cqGbuIomqJCFlEPsv1LZLUoguUyTMu9gC7i7+yNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fcfhd2Mm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4298b865f84so969634f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761906028; x=1762510828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3B/i06NPGDlGfPSmm0JeDJD/jaUMsY04sT9K+okWQQ=;
        b=Fcfhd2Mm1vDrrNNluSKr/gdmLpUEVY0b8MjENJ1werW8IQiB1xuqQf8BBbzviBj71M
         1ME8UjbbU8sL+N04/6UB9OOz7R+xmteGkAM0w3KVa+dAk03RMVGu5O2Jk3OFmA4b+3C/
         sjn7xIp6M78o/4hSDsJR2rCoDVrQNJQT5ModLoWdGrHJHE9OhVIrSKvrLK4NpYqwandG
         V37GLZGtTk3cJW+x9I0js20eajVqBZHZVz+EXTKR/txNc0qIdixDNqIY9QAdJma+aEm0
         u3v2HjgN8xNGxz3ZBzjKI06LbPMHsB19F6C+wPk4O+HQZ2WLdA364CT4La0RJSJC3Uq8
         dTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906028; x=1762510828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3B/i06NPGDlGfPSmm0JeDJD/jaUMsY04sT9K+okWQQ=;
        b=IEnSY7vuC1PJjbvQyETfmxMBqllY07wi320FWdSFBY6IXrQtrEYtlyhXZNcaWb8cUJ
         lcwMqUvinIt5x4azvYR9LIqOly8ic2lufFjzX98cJKBt3S6Yy4euQrMocDpOANUYshD5
         g59iGMuwKw9XD1px4geMCTjtsd9y4EBEoTfMQUIKMCYVZ0S8toWzSBs/mNXOMSMjSr6F
         cDFuGInEebNkXHdXUFJPnwmVKUStL0vbHHoIu9COuQNBszv+ESkqzyRBa6WKZ4ju6c+4
         JMwjn7zTS1BcQwsemf9Rk+Xz0vOk+3yOxQ0IISrj4LTdDpowuAGpBkNFVg/yC8r1hhLz
         X7ew==
X-Gm-Message-State: AOJu0YzZPQg/F+ZhzZcEAqmgjSEvKw4tsO73Bcwm8fYZ5Y2C7BI0hHD4
	Jc8eMcBEFdcavJzIH0OIgmfGB+cY5fM2k1pHu9yRrB7GhXDJjRSWKIMeDM0vRTYp6B5wMmwooHJ
	PGEj4
X-Gm-Gg: ASbGnctJMZjBCfjMtDE/qHaOel/K9shg9L//QbKVggRzgTNPrVciy4qc38yKwZXXRoA
	+7KS8i28vPhWRDszMTmrtw11npQCKBb6lZJO2MJ9kojIyjYg3G7X2xtFTrJMaaDD6/0eqhL1TTT
	m40JnriSoJa1FxoY7om3qHz8SBYn6hra269hzpvWBceotuO4TaGZFQ9cdXKCpgLNN3g8Ct7FOYO
	zIWT+ZD1tLn/YF1A+4K4+RiqI8OM5dqBoafXEOwyXpDKG3v7HTtK27diBGsdlPTuTP/+yUaH5G8
	ictecOZla1bLpGCXQJSYTTsdfJfB9LEySlSLjGqmbG299cmcINlrfXGcN2CncYqgOSaXO17k8fU
	DCV8CtWn+PZwcsGr0nzVGbVAanduVHcsqtQBhuSLqffnRKdWudEVrd4xAwUhfPLr2xiOUTtnX9Y
	QuDWqE8/KRoPYOQ5awlUvmkN10Nr6Q0aF5diOJdnuaBR5YCQ==
X-Google-Smtp-Source: AGHT+IGfCTVgpG9l9puSWTYiK3G0d8gKcngL5r4WJ3Xi2AmzTOfMv+bHNEWDuIFmlbATDHcuNOQgMg==
X-Received: by 2002:a05:6000:2892:b0:428:55c3:cea8 with SMTP id ffacd0b85a97d-429bd6e16bemr2293210f8f.50.1761906027732;
        Fri, 31 Oct 2025 03:20:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110037asm3090410f8f.3.2025.10.31.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:20:27 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] replaced old wq name, added WQ_PERCPU to alloc_workqueue
Date: Fri, 31 Oct 2025 11:20:18 +0100
Message-ID: <20251031102020.95349-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
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

1) [P 1]  Replace uses of system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

    Because of that, system_unbound_wq has been replaced with
	system_dfl_wq, to make it clear it should be used if locality
	is not important.

2) [P 2] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
  drm/nouveau: WQ_PERCPU added to alloc_workqueue users

 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.51.0


