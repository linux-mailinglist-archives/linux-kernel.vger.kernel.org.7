Return-Path: <linux-kernel+bounces-899775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E16C58D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30CF4342E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CE35C19E;
	Thu, 13 Nov 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J7WQU/bZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DB28FFFB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050379; cv=none; b=KRQToB4Z78d/Z7xQ43FjSGhgBDHpCZUCjVp1pwwB/MnXRVZqS6vIHahe8D3sCHiTKMpAHX3k1JNSSxMH7hAhFcTgDMuCTJt6SYB6J3YWyW7AL5Tdb71XMEl7ZXufuNlb+WbHiwz5zuz37vF/owyQgLnTjeQuEM4nr+cb8SS1qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050379; c=relaxed/simple;
	bh=42xJSif+pmctYjHuGtfJDdWLcqKYQ+aUoY/Bqcow8CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmdCQST9UjezGvNHVvXvC5BGQOSQrbEDassXXL41hNq+ylFxeOnm2z05T/MDyJm2d5snOkCbFJMnCoy3/sKZYZjulGLOqrjl/JYPilMOk+wrUl7Y+iW5VmTcXiYTXwB21UzQaq3LwwfRYSDx8lI95lzRYxp7yl3HezY3rEPdmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J7WQU/bZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47777000dadso7724325e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050376; x=1763655176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4P1naAhoro6awNrxaSVBn3BybkUtsIgcyUewhj0B5cg=;
        b=J7WQU/bZtLmjW1XxGS/k99Z1cO+I8VOn8vA2jB0UWSQNzSx0c1P1z8A+flldJ3yw3k
         J0BkctrSirB/kjQNg0mabGeLWj7Dao6iI8/U6UvsjHR2CG7xA9LbEGEg+oP+AXQOnFAb
         C1TZYmeJ/33bGaIfZRHXdm91HeqJ53eQaTcle3Ibxq38TMRear+zVm6sRb8d7fE+MKL/
         B290ed6tgSYbKfJSbvqcczKrTqBm2fo/vKsU2orVL+1FNcSncPH+7L+VX+2ih5nGU9JM
         J611Y0k5NQBUZ4MnlMS/NB7+1VG+qv/mjh0gS/TyVf1569jLQYTyd2IsgvTRHZGdH8OR
         bCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050376; x=1763655176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P1naAhoro6awNrxaSVBn3BybkUtsIgcyUewhj0B5cg=;
        b=o9M/SENF2z2BqTCIDHddx/BP4T0lse9ubyuERdIaCY8pv6wGoUUfVPaI009tVDOc9E
         cPpoTnL5En9LktEFYnWi5ybCvvGbZdGFm6MzYrxc9a9i6pxNdA7s7F/I6G2pTV49fXo+
         VTW/wCImSw5HEfo3HXyVBGuuT1J9cXFiK1mnThzQQ2SB9raRM1+axkzfiXX6Tn0O8Vp+
         hiFiPUXfKjK5NPtl2bsyViPb/Ia3cKZmis398Q+MEMti99qcjNFGj4i0WwNTbI8ZxNQa
         2BWoUR6jZd3VVWI68Sci8mk/wOEqF2LrSz8pMX9g9kqXABOqrtNGiukwe6QIhxFjxnqZ
         NfPg==
X-Gm-Message-State: AOJu0YyE8CbhTGaeSZIl93J+7OQFTaoGYp1dBsQNXdbFE4REzMIdcnBl
	RZxzPIVOlKbEpG4Q4Yx/1gG3YHijkjriDia9lFoTknO58m+tN9LOvUZX3U6+M1XHi/kCrk8hqLh
	eRP2O
X-Gm-Gg: ASbGncuINIqn+rXI9qojnDnL7rmfV77Sfnz2ymV6yCJQ8yH9tt9kT7M06ltLqVik//q
	EdtdlrzV0sWu/mQ5yTpWsH4jOiwo2b+JV4yjteyEDeakDjpn0qKPuubgCl2HnY3vfweW6KMAIRE
	HGDE48Eeu5J3yQRteoD74+QeNLLKNvDWbd1J2IPXZjulfzvYWNhJu2jAxeNRqR02UlHmZ2eOWgW
	sbKqI+oiuFXNU4tkLfKk0XQn5sfBp3t8YKRAPc1lOarvNI8tdP3Dz66EC1snxjgkdps3gwLG1n7
	7eFOUCoLBB4BcT6pn1fxYbPYRactH+uGeXIo3JM++JjlRVEhuQZWPzEAuTN861SEYbFJSC2NiKz
	TFSf2aajIsvp3mmDVpokDOJ3p/HITAGHyclxGeVxfg0njjztoVDZ8TIl9Jzx0ytf/oEjC6jrzGs
	d6QruHkETiD+LH0cKHLkIGdQhr
X-Google-Smtp-Source: AGHT+IEd0JcdC98u3Fx/TXg1DQ2U+YBJI/MM71iHZiF0ptfCzqL+gsUNk7VTCxQtrOq0IUEgFyyVQA==
X-Received: by 2002:a05:600c:4585:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4778feaa7f5mr66485e9.25.1763050375564;
        Thu, 13 Nov 2025 08:12:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850000sm41700085e9.4.2025.11.13.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:12:55 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue
Date: Thu, 13 Nov 2025 17:12:46 +0100
Message-ID: <20251113161248.387964-1-marco.crivellari@suse.com>
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

1) [P 1-2] add WQ_PERCPU to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  ath6kl: add WQ_PERCPU to alloc_workqueue users
  cw1200: add WQ_PERCPU to alloc_workqueue users

 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 drivers/net/wireless/st/cw1200/bh.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.51.1


