Return-Path: <linux-kernel+bounces-890669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA4C40A14
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA2188801E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F732E14A;
	Fri,  7 Nov 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e8Iq7WP3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970732B9BA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529869; cv=none; b=J4dG+TcId/gH+vbzQdOYLzdTQTU4ZWf2j8sEr6/LTnkfghvW1hl8jmHWPLdYLCqKuDiH3yQr/oKMwiq4BMS8JQXkguxKrccWqFHqVfQfzZeBDlq4QsntprRAJtkDz2l2fdze6mW5EI83YakOQZkYOgSnaY7nLx1tS9ZD1M1zWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529869; c=relaxed/simple;
	bh=fENo0AEoHS8vjdzodw8//Ervf3XX6q9wCb0EdrAP1gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=al+KfacPzHoo0K4qMA6WVgos9VM8papkDI9vG86iGpCrI/z3bBWaaImlAj/IuJIPhSRryN5TL/FwjV1OmBX2c5kgEWvdhwJmJ8ItTuobNnPtxEM4Xye6ZUyrbhOsh6e7hVo9KfBMd8+QSplXGjbNJGcJsQYcl+/Yyo8u8YYOUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e8Iq7WP3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso529291f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762529865; x=1763134665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMQZzS260QJiBrEG+1HgRiScApWFFVAWqrxceNoP7lg=;
        b=e8Iq7WP3T9Mf4RMfY54naY6KdTQLuAQn9oK/+2yBNOhIelxmXhjG/qTqjwsqGR8PdD
         S+YKVcJJdL0gXH1IomC2nCnTqPqSrwvPLqFkvEAaTJ5lZITBUoW65A9olZoU1/iOdeuh
         2/oclyebwYrmoGaxQpJ8RQ62hssirgUw3ils1UhdiEmkAav+KYjskhZWlUvC1JZqj0sJ
         TaFNJf42Bdgd5pAy4L3l2IHsDrS8yQGiXvuhsV3sj4yrHh/TQmjrwRTYmk9y4uPrRglp
         pIZJzcWaCceR4/j60jQfhqOso6AaplN7VqICYeb7LPEzDIC615Hy3GZE1BWOF8MaA2+w
         sXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529865; x=1763134665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMQZzS260QJiBrEG+1HgRiScApWFFVAWqrxceNoP7lg=;
        b=UomGUPMlydbc4UNXlqKTLBvPENKUhIESK3up/vTQ/ecZ9Rba0VkU50bs/W5LVOXxBi
         3vwSgPks6Tz26zw3CKIoPjnGgsT7nIYmVhthYxX02wvRViyztamiEPsaG9NQ2N13yXc2
         ZlEDOJ3uv6KFcFbxfOIYgh8uuNQOfUA/S8y9aHI0cM2j1qLdcg+YSSsmPg/MMKK+hLfR
         UeTfh0kl2Rk0wCTn5w8bH6gMHICawWtsSUvOUjbQ3LacE8SpaoSeEee16pQx11PnXHOs
         zw6CyMwLfZc+d063Ay35160+Q014idbLWLa8pyC+7kH1cpyvizw+i1jzKrMLy/2vIF+H
         ASyA==
X-Gm-Message-State: AOJu0Yw+bcHI1zH5M26mY3+ALYURkS9jSCOHS0TxWwvstY/wZtIx8ZjL
	2s4gWIsQEHtbJON1jgJZAiuBVsT4NKPsFd02aeKs4MO+53wrkeCu0jZ4moHtsLtE1IKD5bIjAzK
	ppM1W
X-Gm-Gg: ASbGncsWF/ek+lO7+qI5UqJ4+H0wegwisjKUzYwf2NNpeJFxz0JCIab6qlPZ2zpvvP3
	WlJnwTEWmNK/5ZOJ1AiHE3hyIWibIIQyQWI0SO4m6EpB5AMroKxCTBUIpoot+gepwy+D3Sv/BhN
	pv6O7Hms2S4MRu1VMzjTSi3JCY2rB66Wvd+8NGAWu9QPLqi64EF5lLGMYa5njWTAe3veNMgR7Sz
	iAM5Tk02A73os6J42HH/zH+ZOKdqWE+0HIUXJHJ9hI224I4cDCqy/H+4F8WRDMwbZMRNYqFk1kv
	lHtEHOzg+N/Ut42S1fp7zN5C1tHKDQBKDy+xseO/th+QmepG2zqz0pVnhYnaWi2zCwRHo7Ihycj
	u2L+JAjbrFuMUj/MOoPqd9EiSrDCIEZM5P2VbBYTW6Tl2ovMs2Rj9xGGd5n28AE80htvb/FuV0z
	xkPG6ZZ7+nnTe/foglS+nUw8/S
X-Google-Smtp-Source: AGHT+IE3PZ5ZmHu0Bu9t7eLJHCk8qo1WdCOpE0stMx67TG3l6gYq/N8snpXPCiDobpiHGGYG3mCmNQ==
X-Received: by 2002:a05:6000:268a:b0:407:23f7:51 with SMTP id ffacd0b85a97d-42adc68843cmr2621604f8f.1.1762529865278;
        Fri, 07 Nov 2025 07:37:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67845ccsm5763460f8f.36.2025.11.07.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:37:44 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue
Date: Fri,  7 Nov 2025 16:37:29 +0100
Message-ID: <20251107153737.301413-1-marco.crivellari@suse.com>
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

1) [P 1-2] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  USB: add WQ_PERCPU to alloc_workqueue users
  usb: typec: anx7411: add WQ_PERCPU to alloc_workqueue users

 drivers/usb/core/hub.c              | 2 +-
 drivers/usb/gadget/function/f_hid.c | 3 +--
 drivers/usb/typec/anx7411.c         | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.51.1


