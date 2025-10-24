Return-Path: <linux-kernel+bounces-868545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F1C056EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 101A135AE4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939B30CD9B;
	Fri, 24 Oct 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bMdF6lfw"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45C35B15C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299540; cv=none; b=EI1ANgnOpGxKKhaqg9pcAH7bud6O1Zb9hqFqD/3jukwVa9KhMirCFJz80pmuan28jnU+wg1ZqZWfZTbxA3aLaT0CFn4W1XidXnEZZUwsMVGcNVvRcFiON4Vb67862cwg+QXzTyQCYYavltwMsoA5qWBq+xHkhGa3E/bvOb0Exvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299540; c=relaxed/simple;
	bh=aJN0i4zn5oLMl/Su5l90wr/EwylPc9je2CvQdBlttHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxqUlxwyKAKDHK/ALGfzI5/Hbk/4fYmm9zGekkkm2pVst+FQJwiBn2AzHeWDkB1uhneiff/xnQl8D0pWUQffpuU4NGj6DYTn3yRfusF5R55Z+xBUkELk/osgMAUJtte2lwGpkwn8MLHytratvi49MbC7yoxPIf5ia0l7hRKko0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bMdF6lfw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-428564f8d16so989304f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761299536; x=1761904336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5wnGoXKsRaTCFgkIGT0AkusbbG3tenE5x2rrfbGT6o=;
        b=bMdF6lfwXins57gTt2/Gk4ip3Vu/MP+Hv/6zYxJaic/ovZN8ZjsyWImbkYwF5voume
         +vAHIY7EYCOn5cVS6FckeUnj+YC3K/z2iCXuD/M2I0PPptuEeIT9OQ0K4Xqm8D0J/mQ/
         pvtUaaEmjFieA2S0oxKWwyrYkMtAanEbHrGY0qXvMyGhCVBtg/PbYdHIcAi7uxQU7B+K
         MZjOineLTU3PdvrRlMYaELRZfWtfumwuhtHoCj9RNRu2zTDusQjDKPutWtd40PPANSN0
         ZqFH0YlqLtVwoxRMyqR6boHEsv1Ecf2JDljKMYUDpIwb+4VjLNhufACBDBW5BmGfeHd4
         uQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299536; x=1761904336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5wnGoXKsRaTCFgkIGT0AkusbbG3tenE5x2rrfbGT6o=;
        b=IRFujDcwuvXukYlhGtSwubZOM3jEuqUoSpDJ6u7cXvcLyKb2fy0SSk7AKSyaH4Snaq
         yPpKhjiawiGaRSVjxEW1k3DtE4ctUNr2bTGeYQp4T1BxR51W+O6s/J4UFenzQdU47a6Q
         yzRAv4RZnsmsvWkHnDWk9v6YPj264LSzXz8X3q4kkGRfgzzEeybHEsxvulntwyauea1d
         SSquJaRW0WmcjGC1U29/FFdO78tpUsxVATMXdZTUNsStKfU4u7XHXcFQafwec70+5juM
         nmUKQDaV1xctWOqKKRtf9/+muc2yrfIz+KC9KddbNUpeOcFsYdeSStbYW5XIfNKYX5bg
         1raQ==
X-Gm-Message-State: AOJu0Yw4Icb8f0K7QK/TBELX9r2v+OfSLT7f29DMxDs/qu8++vfSGAiZ
	ntMa+yTpMSNRo/3GWbiCvWhGKVNHSIcPiJ2aLZ0Ry/qpeDttGrot8eYgfhl2RokHFHLV3BYvMh4
	nRSzw
X-Gm-Gg: ASbGncv23loOZI5R0xvDdgUWkEoFkgn6V2zufk31xQxGGrbaXVIp5JkS/AjK5Tsufdp
	zZiIeBi+ViaZAB0XYk2h4BTti5wYDecxZ/3dAcbU65h/42s+QQN25H7o22Fcd7nbguCMTbji5ft
	ThxAvawVJuG5Coxl8FCVcdE2oqMAREKp9ZF6GjHcq94n3+qYmfO6oSu7lVBgivN/43+OQNJk7qL
	Rb+kRC4b1LPJTxeQJnl4/noSo4fllrZLI4xm8Jh4QhSfKWVLea97AuEj+pViB+vHDngWzG8D2jo
	15S9pkhAu5PQbjiCjfFDnS7ufehoSPD8QnNBxzRDcxH1FQi2poBA97V4wg9XR4a1cam/6Uw15iw
	e8TFGt93IPjw5lfQPtChGTL0ZM3KwMM27q8RDKE9yDoQrR9eS2UhainSIaQqDnk1Af6CcRLIo30
	O4mKPGeGFocsEHGcruLa/bsbKE
X-Google-Smtp-Source: AGHT+IGaWla0S3oP4FeiPYt4qNYawi3uGEvlwY3UsXLw1UfNDuPKA3jrU35DvurAR5mlQUu3V8qnoQ==
X-Received: by 2002:a05:6000:1ac9:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-4298f5768b9mr1681277f8f.23.1761299536428;
        Fri, 24 Oct 2025 02:52:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57b7sm8402376f8f.16.2025.10.24.02.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:52:16 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH 0/2] replace system_unbound_wq and system_wq with the new wqs
Date: Fri, 24 Oct 2025 11:52:03 +0200
Message-ID: <20251024095205.123123-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    system_unbound_wq is to be used when locality is not required.

    Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.


Thanks!


Marco Crivellari (2):
  accel/ivpu: replace use of system_unbound_wq with system_dfl_wq
  accel/ivpu: replace use of system_wq with system_percpu_wq

 drivers/accel/ivpu/ivpu_hw_btrs.c | 2 +-
 drivers/accel/ivpu/ivpu_ipc.c     | 2 +-
 drivers/accel/ivpu/ivpu_job.c     | 2 +-
 drivers/accel/ivpu/ivpu_mmu.c     | 2 +-
 drivers/accel/ivpu/ivpu_pm.c      | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.51.0


