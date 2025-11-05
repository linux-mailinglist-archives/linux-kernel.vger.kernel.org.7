Return-Path: <linux-kernel+bounces-886831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A6C369AE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59098661EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93343191AA;
	Wed,  5 Nov 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q7vsxQbc"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A96322C6D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358281; cv=none; b=t5pZjsCjP5+pHEwzl/kWJ/zdE/sEVHa9KGCrxfZf4WC7tSP2+onmlJ4XqFaXkjTVI2gD6j7zfVqDAvQiZJs+e4RinN0jnylmNgm0lS1GsWEoO8jmLNzEJscZM9bG9Jxt8fjtu1+wf0+8ZwzrbDTIaOkaCm2JbJx4GB6cEVk+YhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358281; c=relaxed/simple;
	bh=A5WxgB24Iicz/fulYhpscwRvjdTSPTIWkt/b0QOJr80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEho3EeD0pBgDylqQCa3ty2h9HN974Lad8O9juD///HObpbGtjlhTIxdjZgXB19atXLPYqipOcGJkd9GMV8kr8pU9xU1wG2jjtle2I+qinS2r9a+Xi7LJso6witq9K79urBsxQCB0QbXJaPXKlviVSpl7G8qUlfwKN9l/wHzLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q7vsxQbc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117f92e32so55439245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762358277; x=1762963077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/A412NFhvhu3H4tQb5Y6cQKOWK78E6hdKCTKbsd/sQ=;
        b=Q7vsxQbcWbCVDwpOJFGcWMB3eYjpQknreIORyPJ2OLs3rvAzTGNK6supncvXzYwJmo
         rzXCpDP8beYY8CvwXxaiAL0h08itQPcylTPTkWUCAW2K7iq6omV1kwjwkDzduBIwXvbp
         95CP7ggiozkDA0NBpHHaobFU1+an+BPN8AeTklo8bVPPUMWmbbzx/Ja8IOK9+5pJjvJL
         UMTcQQE9oYqbtpJtgnadv5IKATQD/oX29G/MBzihvHs8gxq07KmmJ5tMuEU0WacI3JGO
         QIDMpfN6/XiyQDBsM4F0fb7w0cOkV+CnSsw9ZwYly6SrbqmwGtzfJfcWLiIzRqs5i3D2
         oRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358277; x=1762963077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/A412NFhvhu3H4tQb5Y6cQKOWK78E6hdKCTKbsd/sQ=;
        b=Zn2+eG41wBKFwb1FKFFf851aZ9/3X8j7CNisPgrkPp1uIRGu6yX3gQ6E5p4Y0Gb/wz
         /THsowfJJzkm6Hs1toDVNhAEgX1kiIxFNS9cR7q91EqMy+dm4rV6eyzuPyfScHpCfDbX
         EhwGyIPhcUkiTEAxs2/ifsgEclQrz4S72SDTbHAxWAo2z/OZfjInEQedY42iVbDDKSWL
         mIaXtH6OZKn3uipG7NOogKONNYdQuFYwFyWxCMzwhBGiZ5XmJn4bJnJqOF49qFxfu9rA
         UwR2q024t5OfdGh1MB2Xs4Lml0DHeC82nnUqMo+0RdAa4ePAGY0LM/2IItZSBEZ2ijCI
         iATg==
X-Gm-Message-State: AOJu0Ywas6gB2jc9WdMQNvpPFzN3JV9LEPgzE0R2mdfMaC3on0zuvv9Z
	G9VchNRyrfEcsnIax0RhIc9qhtKpkoZNIrhCge81zNGg22Znd+7F/bbtbekC183cF6oY4WmmNLQ
	hnwQg
X-Gm-Gg: ASbGncttzpDNAyPg2rFlFAG82JEC7kDoYTfdqnYx0dtnNomgS4neZxvatKYtgAB546z
	ur+R+a5cTlNTXpGcn0ZyweTqZmoBSYAP/ffrO6oTKfxiJrkFnTx/AfTAGVaV6eRU2aFhzHvDzr5
	9O2E/D+R0GFbBvDgoumorUDO7ijTBWpX7iGwSZk3zBCCWKo5RmZlTXFs/EGbpVXtn8p8QTfQvLp
	y55on7cJBgPMFqASJ0ZUX4w2KMhMCUuWxiff5xHpN+GLSxtG+wu+XardioyL4XnqEO8AhDCyaxH
	Vuk+MFE8toW8hULzBQ4LEPAxe7XJ/IIUyNgF5XSH6QsTWNTsYwacDOZkqHmfSAV+YVhgNaDUz0h
	GJhdt+Mcw64cD1utRGJ5IhaT3uosruHnjAek1/Y4dB7PKjm2Yvar/vOIYz9ybegqVVJrh9h2vrg
	jkl/QT7EM40nD9pN1ayzAV9oI=
X-Google-Smtp-Source: AGHT+IFjpeqoO70UXV5l6zbIwyENFWbQ0LYrxlDZKajaSiejeP7cbeJkXoreRtd8Wj6Dd3kCS/n7XA==
X-Received: by 2002:a05:600c:5488:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-4775ce15707mr33093435e9.29.1762358277271;
        Wed, 05 Nov 2025 07:57:57 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2d14sm55567045e9.1.2025.11.05.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:57:56 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/2] replace system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:57:34 +0100
Message-ID: <20251105155742.293326-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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

1) [P 1-2]  Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    Because of that, system_wq has been replaced with system_percpu_wq,
    keeping the old behavior.

Thanks!

Marco Crivellari (2):
  platform: surface: replace use of system_wq with system_percpu_wq
  platform: x86: replace use of system_wq with system_percpu_wq

 drivers/platform/surface/aggregator/ssh_packet_layer.c     | 2 +-
 drivers/platform/surface/aggregator/ssh_request_layer.c    | 2 +-
 drivers/platform/x86/gpd-pocket-fan.c                      | 4 ++--
 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.51.1


