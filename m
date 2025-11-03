Return-Path: <linux-kernel+bounces-883413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A0C2D5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EBA1881ACE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4531A545;
	Mon,  3 Nov 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UJH3Dbd3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5A30C357
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189581; cv=none; b=l+62fhjc4TGsW/oJctjo9T3tocIwDyPsKRVGhUR9k0GbXmULDa3wYG9RX+pF4w4fN+eF162B+2GMdm31GYENRaefIqHmOwp3JdmwSZ1jEnfm9uJtfzdVKytvslH+/51BfO/bKTLUa4Y3yWXTIivy5LMjfYPIz5CD3BB2VUFTv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189581; c=relaxed/simple;
	bh=UDxYgWrRaPA4Qyf+iSo73/k6OiDnxaJIpGcPUGCKKuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OH06JrLX9gvVrZdnQv9B0GBg1pAERvSZBOvJ5tHc3n0Ugt+U8RLQyPK6nwIsZdjnLA0UJsbAE+o37ZDhsdstlt7DnlLVvbaSsu3XbwtnyELkQAbqRPerG7AFM+IGDk5pE+4uFgKTdpkQVSxJK/rArrl9G+iFLl3ko6sB3jSCPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UJH3Dbd3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477549b3082so1026195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762189576; x=1762794376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=db/7hGwufLFvyVtkkwX69hd9DmSDiSZf9aITV2l4aKU=;
        b=UJH3Dbd3kWHn5gmCQFdzFIpkc6nPPK0nuAswwHDbBUGkpxi+TAwPK4Q8WWd6SzTsfg
         F0/u1LHOuU9ZXiPdNs2GiSos9oJaojPkdYyZ1AoIPkHKD2jZLqa2JuMsSYLp4/eG1250
         Mr5Y601ipAahWcBr4lB6CzSnb7+je79EgnN/la7KgrHeQUx1yY0x11wmlI1KYMu9AcUj
         0gcAZ/jtJ0/3YYsw1JpbNOCDky5H2JRIusLGUU9d6D9u9ppDHnZ5ZpeM6rMlBdSJrYsA
         7AZ0PP6BRy8Lde8VODGbrEia3zJ/FH3BqAwZ5PKzDigf6Q8j5XjqUSNo0NSjso1vP9P6
         kbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189576; x=1762794376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=db/7hGwufLFvyVtkkwX69hd9DmSDiSZf9aITV2l4aKU=;
        b=lIcJGoarqS7/k2RFGYQKcckeQkuBKLmjM4n6OR1w12O5GnPErBshNHGPhHhKKQ011T
         O3E19UNZY/ki3qOdIHVtTpNFdr4+buS/IPkIwSNznLXMs7UVwcu1QTahcCQXEq++PmQj
         3X2HMQW17bhQt9ugPP/drOBuXIgY67a13ZAeCUPPt+BbNS2RlWw6HmLYzxMMmKkzNG7F
         JHqxfMB33BV0XGOWvs0mj/dkBFI83gz19JNTn4jgbLLZYKfkxZ7QtoEga+nTQoMjjQEm
         alMKCFgiBnC21i6p7UD2zagkjdCdsdyMszf5w7bhdArvYAAPSpWWjSLtRY+yxBXpRz4K
         6aFA==
X-Gm-Message-State: AOJu0Yz6whoz4oRNiUpfiAnzYhh3ItpQwesue0nfBAwl9AzoZZoRl0Hi
	vm5w1ZYrDK4MUgwENWrMVoBGXiqxW/fYiEiB1Z/7jMXJEh29R2eqVmuobC/Lw6u8YXUeoyWWble
	frqQC
X-Gm-Gg: ASbGncstdFqbH1DC/tPaYx1y2xTTmD56fAFCZ+9KQfIEWC99GlXWoVim+Yyn3opyIis
	AxJfsBHziu3YuhC3jpdSQz3WPWGUQ5/DrIruDvSQLTcKwVBR97jmUz++DHeyMja6AxVnEXDYd/r
	SvoIcvRzLGOusDtsmD2XQ8Bb3+TG7XUEXt5hCUgHWrkfSxaFQ7EPFTdH56YYIyd7kWJa8tt8Iqu
	DFyNY/v9wVhlme0U2VPNoif3a8kyne+2RKq6ayVVArrvicMv2iZRFpvuROeyZs7NTbkkQAqZWoM
	SWmkvSDxIxso6jt8HkZyW95MrjXddpaCPJhM4zcOlyyHQtQ+HzVhvS0S0g8Ceeb8QLAuRnnHKCN
	KhMAy/s/qK3WN+zuZspYoKXHeoBJHLLspR5Kq3bAbZXY/r9umkKQKXifQBI8AJ3/tKiLJ/b+Lf7
	SdPWnsvaf9Hp1ooGTIMYzo504On1Gci+RS4/I=
X-Google-Smtp-Source: AGHT+IE951GkqsPPwEMA5npQFHvSg+BMrpL+lZBjzW9UnWXAvu8Mr7+YniOEEhVFUQcXVS31YOTVgw==
X-Received: by 2002:a05:600c:530f:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477307e3d3cmr111815725e9.10.1762189574115;
        Mon, 03 Nov 2025 09:06:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc524ddsm89799895e9.7.2025.11.03.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:06:12 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/2] replace system_unbound_wq, add WQ_PERCPU to alloc_workqueue
Date: Mon,  3 Nov 2025 18:06:02 +0100
Message-ID: <20251103170604.310895-1-marco.crivellari@suse.com>
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

1) [P 1]  Replace uses of system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

    Because of that, system_unbound_wq has been replaced with
	system_dfl_wq, to make sure this would be the default choice
	when locality is not important.

	system_dfl_wq behave like system_unbound_wq.

2) [P 2] add WQ_PERCPU to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

	The behavior is the same.

Thanks!


---
Changes in v2:
- rebased on v6.18-rc4.

- commit logs integrated with the appropriate workqueue API commit hash.


Marco Crivellari (2):
  drm/xe: replace use of system_unbound_wq with system_dfl_wq
  drm/xe: add WQ_PERCPU to alloc_workqueue users

 drivers/gpu/drm/xe/xe_devcoredump.c     | 2 +-
 drivers/gpu/drm/xe/xe_device.c          | 4 ++--
 drivers/gpu/drm/xe/xe_execlist.c        | 2 +-
 drivers/gpu/drm/xe/xe_ggtt.c            | 2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c          | 4 ++--
 drivers/gpu/drm/xe/xe_hw_engine_group.c | 3 ++-
 drivers/gpu/drm/xe/xe_oa.c              | 2 +-
 drivers/gpu/drm/xe/xe_sriov.c           | 2 +-
 drivers/gpu/drm/xe/xe_vm.c              | 4 ++--
 9 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.51.1


