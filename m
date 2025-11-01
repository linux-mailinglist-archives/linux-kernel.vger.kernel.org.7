Return-Path: <linux-kernel+bounces-881425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F4C282C4
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4653B4E3899
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C62652B6;
	Sat,  1 Nov 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gUIKm6rf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11D253B64
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014705; cv=none; b=WwTgtD2a1pXXnQ+Sz2y+rvw/VtW92HB4w842jXrIbHb845Z6vfOq3hrU/EzojL3DUzKUf0Y0pQ6Nc+v4NdCtpVXsJG5JLnFQyMa07+F7bkPu5A+Mhz0Uf/9LWxjmlKr2HVVgR3cKegOczN1Zk/SyuTadyHGA9FAuWL0OuSoe6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014705; c=relaxed/simple;
	bh=1knJm+gZFW/b1YzTgpyrV+yC1hvpfIP9iwpL7HSjFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjPBfPvfum8m1BO9r70vPZkcEKvJOQMUvNRLrymTFNJ1ZhByav7wE05Clc7CF3J8+1AQu1TKw3Rk1WJS9kt5TApGlhgRUbj2oAQh+h2xCnEIgVgsOvCPXwy/dTm0R8HbHklu4MTTJ+JQkWUeBfIMO5bFjGtXmj0WNogGvJzOLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gUIKm6rf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471b80b994bso40207785e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014700; x=1762619500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hsASTuS8SBuaXxtIeQtR0l4ZGx3oezgGYfGVIK0wk8=;
        b=gUIKm6rfWQaWRhlvOU6kw3XZcpwEZenIMfpNITXLLS6dJSOsTBXaLWw6CPCXeL2IuY
         C+huWUkNyzRKaHIoQg1TCAsjYILKSra4OFqT6R50ilGDX0mduRXDi3vcdFBaWQWRtqFW
         sfN3LL94jdupWCBCh6mHAvOrLrCY8wO0R7HdVzsNTrvigevVzBRcL7U4JlHQ/zPaQ53h
         khJxu4xcII8NmNV6t1A9DtEUPtoibZ4gZT6VwDmibzesM5A0cLe8RSfpyv/5y19cM72J
         jNEI00FRzHIZj6TRidxK1WNpkqtWDiEyCoyTeQv6nfdEwQ+kwdSFjmwi9RdRyY33aNx6
         nclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014700; x=1762619500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hsASTuS8SBuaXxtIeQtR0l4ZGx3oezgGYfGVIK0wk8=;
        b=EyD4e0HOWKRKmVRfV1+FnYjB9mVld+OM3i69cRvhMk1MWWvlsqvyCSHTJ1yJEoyGif
         NaYZoZgJVdsTQHSOwUv/InUp48c5fPrOSpepY/lsuJn5dVBv1iaKLLB4Q2ZyZXzNwTnj
         /eOKTbxPF84ZG4fj6a+gWN7GpIRBYrHi/fmXSQ9LkkQnoX1p//iqGOKdtKsTeNJbZZ9u
         pa0pSnYn6Awg/VTlglYHDNRApzhmWGG2NIkIn7xNg9vUACLDodG/n+gx6Xx+RQzWeWFK
         bEp29wl7q6Soa4aRpIQWNv+Otjql0rAxWvtuKb7I4JpsRiuxsofXDeaN7wrXqGZ3KLLW
         nDgw==
X-Gm-Message-State: AOJu0YxFUO1Jg+1IqC570WnKJBUyggyDdlXojE76ljXDkigCjh/32rAD
	rAKzsgLiBvqhHygfN1Z3QWjD0zE4Bn+nQ7TB5+JgWFsb8W2sXAlybwn0bgbuNBQLjiLlLiUtBpn
	32rN9
X-Gm-Gg: ASbGncvJcXUGVyjNG2aqr3ZY5ggKNte1aScPU9vy4s9F0qEg1uJgybDJKVmje6SmSjM
	hL6t3Sj2YyzOqnTODio/slB1uBZ2bqdJ6PiExnXJiVETEKQrE24+ijBFtLcAiMfUqEmpzbX26Cr
	NxP2QbB0n+By7rLFKuV4VASwwqaqqJ10KQp9s7Sw1PCh7sw1vJW2O4XlUwV8DToSGj8u/Z563c/
	rs9DFtS539cn9sglfPVErI8L7KlXvYR7T0a3Psm+plSaALft5pTHXEPEKFe5lueeyY7IZEtZFiX
	T5NSk71OcFw+wJGw/2EhrcSmJw0Q6HJLgbkRR/0Z0okjoj24uLaWz5ugYkgraiPhQdsexcZkQnH
	7l8SlEtcbKNV10kEI+zjn1jNglLkxZO0/QDdskHJSNAaq22mamqNRfiaYbKkEQYOPMr/kUAroMh
	03Dngdco4zQ29aAnSTbiSRL7k6Llkmae8O2ao=
X-Google-Smtp-Source: AGHT+IHIun7MzFAVHGB6qF4KN179+4rTOhPG/e7xXDMwaiYnH56eJs/M0S4ud15gEhUITEEwUOlcng==
X-Received: by 2002:a05:600c:8b24:b0:46e:39da:1195 with SMTP id 5b1f17b1804b1-4773a8e4543mr48931195e9.3.1762014700210;
        Sat, 01 Nov 2025 09:31:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:39 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 0/5] replaced system_unbound_wq, added WQ_PERCPU to alloc_workqueue
Date: Sat,  1 Nov 2025 17:31:10 +0100
Message-ID: <20251101163121.78400-1-marco.crivellari@suse.com>
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

1) [P 1]  Replace uses of system_wq and system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

    Because of that, system_unbound_wq has been replaced with
    system_dfl_wq, to make sure it is the default choice when locality
    is not important.

    system_dfl_wq has the same behavior of the old system_unbound_wq.

2) [P 2-5] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (5):
  RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with
    system_dfl_wq
  RDMA/core: WQ_PERCPU added to alloc_workqueue users
  hfi1: WQ_PERCPU added to alloc_workqueue users
  RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
  IB/rdmavt: WQ_PERCPU added to alloc_workqueue users

 drivers/infiniband/core/cm.c      | 2 +-
 drivers/infiniband/core/device.c  | 4 ++--
 drivers/infiniband/core/ucma.c    | 2 +-
 drivers/infiniband/hw/hfi1/init.c | 4 ++--
 drivers/infiniband/hw/hfi1/opfn.c | 4 ++--
 drivers/infiniband/hw/mlx4/cm.c   | 2 +-
 drivers/infiniband/hw/mlx5/odp.c  | 4 ++--
 drivers/infiniband/sw/rdmavt/cq.c | 3 ++-
 8 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.51.0


