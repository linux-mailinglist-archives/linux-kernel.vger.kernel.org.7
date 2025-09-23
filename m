Return-Path: <linux-kernel+bounces-829186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D565B96777
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8737A7D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A824679A;
	Tue, 23 Sep 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/K5g7DK"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4411F75A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639560; cv=none; b=kAGqlGQ235OZO42PXpl9ozhz+UySXs+FkRwvPQtuW9sOphtuGEhDEr7GGJ4MVYIr9DbseOLLJtEIMldSHBXrX7M/ABfY2eyYTGKkDaWf6X7FJp/S/GN5xAJfl9p+jChopxFE2lqsOjyCkEiPwI+B0amIQlzBDeqovyxSGrTU+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639560; c=relaxed/simple;
	bh=SLnhFI05Fz11ae5CjSbNKc7NQNXk3wOI5ZuyTeWv8tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qcRLA8c7HcZZtUvBCGYM+dCHTPxJGbUywOy1GR6iNx2DuycZ0lanPFnAZIzWbBJpceUNzwiA1GIDV0T3OTLJ2i9xeqcJtPDawQuvDOVodmoOpliPLJJW329eQPtag+Xn+O5nvP344z5gZcl1O/muCgCUMOX4Pg5OKQKnebSyquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/K5g7DK; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso42123485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758639556; x=1759244356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ya093LRLW+XJ0H+DvzuEl9T3QXxj2lpflh2eT0oygQ=;
        b=D/K5g7DKh3z5QQkUW/PSSQRd2mu0K0lyNOgwINn/Y5v+WpkXRFgG9aV7Ra/UYCJEoZ
         Bj57zUYvk85kaZyCz70OOql7hhUYtuOGo+dFyoEspPCPE33e0Cb+d0m7oxUApG1rR/g7
         G32litrak6Fl4fS96pI+1pbW/CbCM9CFgV9qAvxNgcQ7YCZywcVcXmvc12qnK+ZAJrOO
         KNwP8E1EGvztwZ1x7YUmbJbIplMTstAJPqzWn0lfGZjRFdQmaXlOEjX4T9GyD0xc/nn7
         nuv1Eh1mpJAf3YW8eKxBGc86S8bwHeqvmfpP0/1osTNNfyCq80bB6Amsqhww76pmDrAm
         mixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639556; x=1759244356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ya093LRLW+XJ0H+DvzuEl9T3QXxj2lpflh2eT0oygQ=;
        b=qOa/G4/hvB8dRn6vhYU6PXeCxsTeQ+CWgMQXTibJ3oGGtBtxQcCgcQKA2EfzpdM4ba
         jUkfIDLFoKe/7M5babfg5j5RLBUaR957vHbIeq8oA1BR3GcOcxoJ2ZutC2e/Xgy4xX0I
         D2TcY3GvStFkhPKTGITG2P6VKUlCZGoLHNyTFTOwpZcUOTAKusPcedzLY+B2DtexlbDW
         o4D7nOZLrSCgabmaD7Frsl4QB28LfVufKMS2F2JZtPQroZf8YxqCwkL/SmwRl5IEf0EM
         Sz2LWf/NHBmVX0gHJteBRbTq4Ta4Am05Bh3Kf3sm7HDjMuQycISESUj69UAQiWGvi3QE
         k+rA==
X-Gm-Message-State: AOJu0YwRvJ8bkino7wXS/cOnOg2T8fF7OCHMlOBS3EjPdCH2ZzXtQWHo
	inBUGSia+A3M2ac3IfdR172gCTqyQjjzqFNsViHY8oF2m3v7wRIj6SxrP/kfJOBJ1N3EUNDqqQ/
	5JVY63ph1xA==
X-Gm-Gg: ASbGnct9Rrk97MOvvLyYdfcJoWW460vQZ15cREUFhh10iqOBk/hTKMmCJqhbeI8F3jp
	AbAkOGLelSgAUlWkvdboJ4s3NK20PHoF5Jk8bL3PlEdYh5YrvC59CZkoJTh4g1PjU32hPAYenAc
	zjtYuUDuMF/Gs32BOISUrUQFAk9WHoLqWp6G9bBmQ4CyBti35+IApR/8EsRF9rQaqjn/xkWkBv/
	Ohg31128+xiNkJm+BMsDIlGKXIm5GKOXzZ0pZDzei3V1ZUpnpf+I6YczW7PkTQKrcV2KPeFup4y
	Jtdy1WnAl1AAnvYXu1HbyyCHixaj4HMW4KDgM+ztqsXqptLqS26jeuypWqZ3+k81o2x/gKbPbdH
	B52umzmdHtAiMJWs2uNNk6bBEDaXm7Sb5ZZOWyBTyEOazYv9URoyun6ORHg==
X-Google-Smtp-Source: AGHT+IFaArUbYvxb5BM/VZcMjPlJhNyUCun1Sdw8oQgKqY7KOM53qX+PrHjd5uushQkRqaISaPwZAw==
X-Received: by 2002:a05:600c:82c3:b0:46e:27fb:17f0 with SMTP id 5b1f17b1804b1-46e27fb19a9mr662195e9.9.1758639556129;
        Tue, 23 Sep 2025 07:59:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46de4d67625sm76708005e9.16.2025.09.23.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:59:15 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Brian Norris <briannorris@chromium.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	Jeff Chen <jeff.chen_1@nxp.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: [PATCH v2 0/1] wifi: libertas: add WQ_UNBOUND to alloc_workqueue users 
Date: Tue, 23 Sep 2025 16:59:04 +0200
Message-ID: <20250923145905.327269-1-marco.crivellari@suse.com>
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

1) [P 1] add WQ_UNBOUND to alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.

Thanks!

---
Changes in v2:
- libertas: WQ_PERCPU changed with WQ_UNBOUND

Marco Crivellari (1):
  wifi: libertas: WQ_UNBOUND added to alloc_workqueue users

 drivers/net/wireless/marvell/libertas/if_sdio.c | 3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c  | 3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.51.0


