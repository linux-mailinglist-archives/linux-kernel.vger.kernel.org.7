Return-Path: <linux-kernel+bounces-833757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9FBA2FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113DC1BC688A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39C29898B;
	Fri, 26 Sep 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LdkpYY2+"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D32749D5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875938; cv=none; b=dO/0oRv5Z0pNrrNgfnRgxGEa7HzkyIECCHKvJU192Pmq+Fl4K5NzZnLVXNJY6liaWVKNnosMfxYSqHvVClQA0lQsIs/igmGR+yPc4Cyk2xAt0Chek7vEgc4WkgIY/8DV9slh4DQahWbFBsOrH9sPxq1kyq0vOLShWfnksoLzV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875938; c=relaxed/simple;
	bh=gx6yo2EpNNvuu0a/5B+A/+mcsOFXsrTZL+cOI0puzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZq4A0f4lqqaYpa4VzC9Zim9d1A5mR5K55tQkOXe8cgW8mSyGCjACDN5/csZJ9HAjR/opR3WElgs5Yx2uIuj+BRXpO1BefmUxbRMslLqcH63v68aO1dO/v7nH1NUpL/B2mWpIX+7XTCVfqk8P/WcZE/NAOiLdwTTEaOOWcBlGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LdkpYY2+; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-46c889b310dso14561095e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758875934; x=1759480734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZiVR7h5ZN/gELlS5qCM97TCjH2rB9c0VXR6Mrmk+4c=;
        b=LdkpYY2+7+n7Op7HOcA1kdwiU/B5C7i03KzlhI4CMnol50j9pXIleJneuPRvN0r+Va
         ve6JwZO+1RIcouoHSQtgvgTTxnhRXvzZXRgwlz0xv+R5q+GC0e4USZnX3CFwplQ4Q5kc
         sy/FG0Uq9r/HO5bSECSV06MDKmjdtGYINMexCpBVknglzxNRkRKF4G2PeF4eWFiC3MaO
         6Rhm3xTGW2HvCJN0d0l0RE8AO7bcSd1BUBYUnyMyW1PjXRW/LEx/MJTL8e01Rzq5Gz52
         lH48gDliBjp1RhdxMHS1nzq6VpeaH1HZZEneQ0OapqeNsKpv01JwOLTTg3JGTrw4kKW4
         mQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875934; x=1759480734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZiVR7h5ZN/gELlS5qCM97TCjH2rB9c0VXR6Mrmk+4c=;
        b=io60YAKe0fIhbGcm6orVw43AuyI2jRfzxrTK/2oOGX6YQIuxxhpxzN3arNjj8P3tqj
         3OG4IfGwfr4vObZgQOdbdlsxu4K/HMTXRMd5HxuObKGlEyLMAKtJR9QNRmq2/GdSibwT
         y9KUiNQQH6C0Tm8pst7J2NgUHMrTDW0KPJiO3Sl1cH+A6e25WByyqiewR5MSAHG+NSO9
         m/I8wXuu9i3xStFExHGeSQaFnp2WLUq0Q+JvHmNcQlfx7sHrEsMFcyf3aGhSA+EEGm29
         H2JdpTNtOk29KnFKOMPy68oPhBFgLrCSQLk77CbUbO20PC6PGPkDzDgpUaO4Kcyc+/1r
         Gojw==
X-Gm-Message-State: AOJu0YxOMZptZzd42Kq7FwkkAC+tzJOO8QSXJ3kfw8TZYJKUQoZnkNYf
	xij7Qx+bs52bFmajm/yAasJuLuxi4+xbxq72KFEOyj6aima0HrbG/vVDn/ECuZkrIOnTqRuCf2i
	qj3Eg7Z0Byg==
X-Gm-Gg: ASbGncvGkRevgXcxOm4f6e/5uBN98EUQtM43oN33K8hHhqH011TXpj86zCGGipklM5Q
	Hi75rdUyYzR/Cp14qfm65lRjlgTl/wVpRuw5W9uHY4MhkL5mnXJyI2mprlGDKd9GUp6HEjBQcf+
	7gdMzBgKlGcAFfh4V46xQQoqs3yCS0lFL2gDPqs7JStQREC/hMMeBp481mRJ+0EZKRZPttGu0/3
	wWoGAOBYJxgkt4LaYCic1ZEKxjDEYICdOxx8OGuo4E0QS17iKOC/D+3UjJ+Um5WMX+Laof1yJ3j
	L0CMlFPXn6uUb6X31CZMKwocgr6llUvZUwosts9E88bvtCMYvKLaUd/MhuHMPycrSPeOLP/hTrV
	2wXL2WstThfZ0BOBwe4SOl9AOKkpKmMkFBSUKQfv/32MHFBU=
X-Google-Smtp-Source: AGHT+IENIVuLyCczxGQmeqeaKKbwei3zPC4VqG4E2j2f9bjLNqaHjt/Ggj1ryBvOjNZwQz0cqHaLsQ==
X-Received: by 2002:a05:600c:1993:b0:46e:28cc:e56f with SMTP id 5b1f17b1804b1-46e33c36d9fmr57090405e9.6.1758875934183;
        Fri, 26 Sep 2025 01:38:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be363esm65702575e9.15.2025.09.26.01.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:38:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/2] wifi: add WQ_UNBOUND to alloc_workqueue users and rename system_unbound_wq
Date: Fri, 26 Sep 2025 10:38:39 +0200
Message-ID: <20250926083841.74621-1-marco.crivellari@suse.com>
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

1)	[P 1] replace system_unbound_wq with system_dfl_workqueue
		system_unbound_wq is to be used when locality is not required.
		This should be the default choice. Make this clear renaming the
		workqueue in system_dfl_wq.

2)	[P 2] WQ_PERCPU added to alloc_workqueue() users
		Every alloc_workqueue() users should specify one among WQ_PERCPU
		or WQ_UNBOUND.
		
		Make this change ensuring that every alloc_workqueue() without
		WQ_UNBOUND now make use of WQ_PERCPU.


Thanks! 


Marco Crivellari (2):
  wifi: replace use of system_unbound_wq with system_dfl_wq
  wifi: WQ_PERCPU added to alloc_workqueue users

 drivers/net/wireless/ath/ath6kl/usb.c         | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c | 3 ++-
 drivers/net/wireless/realtek/rtlwifi/base.c   | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c      | 3 ++-
 drivers/net/wireless/silabs/wfx/main.c        | 2 +-
 drivers/net/wireless/st/cw1200/bh.c           | 4 ++--
 net/wireless/core.c                           | 4 ++--
 net/wireless/sysfs.c                          | 2 +-
 8 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.51.0


