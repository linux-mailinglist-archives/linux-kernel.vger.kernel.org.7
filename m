Return-Path: <linux-kernel+bounces-878633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5CC21220
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C027188CFED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C833678A4;
	Thu, 30 Oct 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PM8cIps6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07831366FBB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841257; cv=none; b=kTtTlEewDPEaYfrJoWBAkSE80RUl2Yic6kcGfcD28+rZjMVyfndlYSewo6PbM+wktHDlbYNTs3j12R//K6edWf2OPa54W1qvEqy1x8gRgor/QaAw4U2A+7fMQyh899F4q+nbq6azX2ObFdxRh7OVWnQHrtqF1JsMq7oU2LvDQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841257; c=relaxed/simple;
	bh=Yy8/iNxsKKjs5GtUymWDFP3UP5ddAqVUanhMe3sI0tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUojN3zC77Dm9DUZhIb/7QzJYvxcxEDEMeUWvNwNGwR4Br+0KMDw0daZfBKXjYWTdUjao/GedFuBD0sDqDb1ItfAw0ig4jaiZCKJN4ATUbv8WdFkSLoAKpgI3MuIQ7pyu9olfl5MRnUu0hfyhfyexQPQRfutsaXeQ7XIBunEfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PM8cIps6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-421851bcb25so750608f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761841253; x=1762446053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0WrpRXaIIPq62Cazh2atC//FDY9UEnvwzq9WIxjhlI=;
        b=PM8cIps6yHYor4sm/tZxn0ADKiv5+B3GVQJ0MCpBxWmAoL2nupkTAUidC32qvXYeI/
         xJd8mmAWaQpUvIknCfe+uBmYj+OrLq0pVqOdIiZFsv1AZMzEDKBTzj8gCAVKv4likQss
         rogwHXgsXP6jkIuwdJeexlp7i0hlmfkoru3DAK2/i5qne29cejyaUZfZQju34XKIiK9w
         Q6YlXvB4kuOYhTaMkwODAyGLIGfnPsGX3AAlcXs+qoOrkdRjeT3dnRa5g3030JwrZeN9
         x07L/C+Fj2oLUlNwIie970tqA02FMxZGFIgdZOKeiNMEFt09Y5e7NJ39v6JqRx1KhEzk
         l2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841253; x=1762446053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0WrpRXaIIPq62Cazh2atC//FDY9UEnvwzq9WIxjhlI=;
        b=BlOWZXvMz8nyK43X0BdoFu6UU/ZXnLRtQCu191xfjAEuXy2E1x+wnyt5U/6kIdcxxf
         QK7pXSMqk0YLsBWFaeD/X+LsogJ+z/OsHpTW9i//jsnemHg03tFVXkIL/XVyZhLJIcUO
         HNlAiOCp/TPC1Fe1z8omin6vc5Pte2wDONxb3AwPe3SNmRRUuY+EJP9XahW9na5Y/r7e
         hBQWpE6R2PXaacH7XwpP9OHk33+juCXPkOlMNAtShWDwXdeTn58l1xPGVoKaJB5oZGt6
         VvbZ8No0HuZviMJ56JscnLxCoNjVTVdIStfaXNK2BTN7cf5dJ85kfHICxHQAQ91wwv36
         stNg==
X-Gm-Message-State: AOJu0YyBYVwtaUcxq0/I38WFxqvvitLWQjpa2KE6PlvoRmqH6DuoopSc
	31BwVr+dRO13TwsPcb5yehDxM9m2nn7Ur4ild9qRIs5yMn9Uqy3vx9g3+OenBK6SNGQ9Q0mRnGh
	PoKLL
X-Gm-Gg: ASbGncuIIhbQ3k2ZYJLWzKzm0fjT1R+S3jwnXD6rU8dw5trBlo65kPpsKBPLlpq3sRh
	Eic9HCLLUUszhmtcRs0z3iWUlouVP4l/h+UE1he2Ar1zVyehEo5xKeiB1WctxFV7IskZef3xSIH
	5NdGWlaF/tboV9bDymMlKDCPQc1WpRO2BDzwALL/UlsAFl3eAokkce2HL4RrQ9qYzbge4iFMSZ+
	vHNhHBDrkxRfgOqStRaT3wFeTjPnCQeblpG7dB3yGbLieHWSZq/9JiKrJywrxubvvDrWi5hDBVL
	Db0szgd2LdOz1ioDa5RcUX9aP9oRBuUPLxq/CIMBjeriPkNh5Njb5dG31xqxWvxA8H7YMckZw0Y
	dpqFNwiS1ULvUPPfvNkz/CIniGBn0Qiu6rOh0BHGhZYBNkTpIeDszQjax5kQeHo4keRAuj4S+Q4
	kJH8LQy/pM9dPesGk=
X-Google-Smtp-Source: AGHT+IEs1bZ7Q8jx+0doTn45ULYFTLd7A4k+NN6GgkpG4vMw8AQmTzk7FWtDBBAgeuMCM8BDjE5fcg==
X-Received: by 2002:a05:6000:24c3:b0:427:15:ff3b with SMTP id ffacd0b85a97d-429bd676a93mr157901f8f.13.1761841251471;
        Thu, 30 Oct 2025 09:20:51 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm32758678f8f.42.2025.10.30.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:20:51 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/3] replace system_unbound_wq and system_wq with the new wqs
Date: Thu, 30 Oct 2025 17:20:40 +0100
Message-ID: <20251030162043.292468-1-marco.crivellari@suse.com>
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

1) [P 1-2-3]  Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    system_unbound_wq is to be used when locality is not required.

    Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.

Thanks!


Marco Crivellari (3):
  drm/atomic-helper: replace use of system_unbound_wq with system_dfl_wq
  drm/probe-helper: replace use of system_wq with system_percpu_wq
  drm/self_refresh: replace use of system_wq with system_percpu_wq

 drivers/gpu/drm/drm_atomic_helper.c       | 6 +++---
 drivers/gpu/drm/drm_probe_helper.c        | 2 +-
 drivers/gpu/drm/drm_self_refresh_helper.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.51.0


