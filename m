Return-Path: <linux-kernel+bounces-878574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04195C210D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6AA1AA1646
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBE359F85;
	Thu, 30 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/xScyqN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186821CA03
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839276; cv=none; b=ZriPE6I46H62W3mxCo1cBZcV8HmtWzGzqnj3UZlDAwEDkz6VZDWhND8hSmKpr33DzVkMlzKWu+MVtZlE58/hum1oK5V9Ahg2F0ERJ+8awRc/rIr4JYTPNOQu/IXHzOYYfZRNuwP7cYAMidpraxUn3Lh5TtszZo0mSiRaBHpdr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839276; c=relaxed/simple;
	bh=W1zw8qCD1fGu6vpnn4V64xxQGTS5z7t2Go4O+Abr6i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+gHoe57X2WEhkLJRwum9Ti4pMfHpRyCQPIiHmsd5LBZ+eFBdGXjW9/Fv0E+mSsunUeSSN5ifFMinlCIfQhkgKgyg8F0llRtugT1JV8Zvetj2pqQZoDgmG/i7PjkACdXvFlfTpFwqNc9ZqKYysCrLED4AQ1LAQJ2gEpdRw4SURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T/xScyqN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so751859f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839273; x=1762444073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+2vUN9vUrrG0TjG/UGpxBf0iBedJfrxlMW3xSp+vBQ=;
        b=T/xScyqNpG0vSitb/PRRo3WYI1mUJ20pIOBwISfby+JNFHMvYBLxwwhqPQ1GskxV/6
         sx483naw3H2w9hzpgB5PwhiaqptpL9qnucmIZsFJqhsf36X4n8vQTMIkbNu9S3r0C96d
         xHzNYf0ENAM0s0ZWm2bwpg+iD2yAKWvEJIPA2+iWKSH7HFSx3vPrO0E4pIhI0M+afNkt
         2JEQlLIh3o3HaTkJTD4Gg8H/KwPOtH9sbdqwMhrS2Sw64k+9ICOwVhL3DWRSYLwD3apI
         +2dhoEUu/ykbCSjSgWLja3BYJUwzaS3asFYKL81nELrmNS51jGc5oqUERTG4ycTu54Ap
         HueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839273; x=1762444073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+2vUN9vUrrG0TjG/UGpxBf0iBedJfrxlMW3xSp+vBQ=;
        b=E1XJgjR/QpEtGMeNtb8uxuyFrDRUGffGKNd4+Gw6k55jCwW7XdtFSlu+dtHf8YkfN5
         Cc3uBOk2kLKWKzQJpTMPoCGdyNEHzdFM0IDjM6n8qMHjj71rOo5TVYj6ivy5Eb9vuQXy
         MVRZcS8vXqdFWYoe6gmD18ws9HbqB8+8URllyAn14WDsPPM0Tt7yxU8VT3aEMNu0p7De
         zqoJcRRhAdl+htcyF8uS9QxcvBv6TZRLxAjM2++guUddwWzuV8rPIwtGqLPwsxjz9gai
         fe2gqFd81gvQ1aJ87wRhsUWByKpq1rithfotaIqxtzYZt93xB9wt/6qpV3vq00QvvOJB
         ZNAA==
X-Gm-Message-State: AOJu0YwJnl+G89+DtjCt3srAaVgWkSp5fex37cFTcWsuni3YnDhjSdHx
	Ee76Mjj7AcfB7apLmg+YL08vEu1uSlIHzntSG1KJYg1KyOrdSZP6C4zOOotHzFT/ZFiFRn/psQy
	gUng6
X-Gm-Gg: ASbGncv10+5AwoB2W9gjR+ZIpWhH/JOgYaELq0jL09Tsp/Wxqf4kqDX72HCXtf2nC53
	1l5pRVQ4xASfHgSMEoosrec1BgZSj7rUAfpM+B2u98sYumpQ12C+3iJmHtSB1BugH+rgyDdX6bf
	lq7SJ1VrfHEQRmh8nnEIGYNlPezNZrM8FvU4m2NUg0kqARoblxWQOlcoDIXSyEB8KgEe+5tZh82
	7O+FD0FqTxY+clOkVN1FjqdiTg/IFU00DhwfOu2mG5KTyLnh1ex9kH6JlPfDvElCMb5jNMh4WKg
	HIxlToK+ItPNMHCk3RIOXc9lr9+bPAjwbGsZXG2a8eCG8D8STrpDHH1n64W6rTyhFa7ZhGgXTZY
	2lFz0j+X4QdsOKCNKPv7ggMFkFIhTitU+HgLBfeGGeaOlUAJG8ryBAnKZt2ca1K95Nf3J65RSyV
	cEt8hWWR9GA5uCoK8=
X-Google-Smtp-Source: AGHT+IGP0z4V00XKiXMmYp4l2/BZ8F0n9XtVTSemRHjCzKtJaTEABQJsm3CuVaPc7Far4bXVn0wIIA==
X-Received: by 2002:a5d:64e4:0:b0:429:66bf:1475 with SMTP id ffacd0b85a97d-429bd67242fmr59867f8f.3.1761839273055;
        Thu, 30 Oct 2025 08:47:53 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:52 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 0/5] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Thu, 30 Oct 2025 16:47:34 +0100
Message-ID: <20251030154739.262582-1-marco.crivellari@suse.com>
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

1) [P 1-2]  Replace uses of system_wq and system_unbound_wq

	system_wq is a per-CPU workqueue, but his name is not clear.
	system_unbound_wq is to be used when locality is not required.

	Because of that, system_wq has been replaced with system_percpu_wq, and
	system_unbound_wq has been replaced with system_dfl_wq.

2) [P 3-4-5] WQ_PERCPU added to alloc_workqueue()

	This change adds a new WQ_PERCPU flag to explicitly request
	alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

Marco Crivellari (5):
  ACPI: scan: replace use of system_unbound_wq with system_dfl_wq
  ACPI: OSL: replace use of system_wq with system_percpu_wq
  ACPI: EC: WQ_PERCPU added to alloc_workqueue users
  ACPI: OSL: WQ_PERCPU added to alloc_workqueue users
  ACPI: thermal: WQ_PERCPU added to alloc_workqueue users

 drivers/acpi/ec.c      | 3 ++-
 drivers/acpi/osl.c     | 6 +++---
 drivers/acpi/scan.c    | 2 +-
 drivers/acpi/thermal.c | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.51.0


