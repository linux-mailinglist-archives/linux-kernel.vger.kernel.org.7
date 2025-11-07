Return-Path: <linux-kernel+bounces-890634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 531AFC40811
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523EB4F25BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3832ABFE;
	Fri,  7 Nov 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MkZzb8ZV"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFE20322
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527727; cv=none; b=d+g9X8EaeMhVwOreZeUcDMXhyR6dCZSThhZl5BLDcE67iMjnqZUx7GASau95NGkgdkEO0HhBFdRbKp7XfKE5RPLZBcp/o+M9HtvV5OuIFq7E9c6XkO+bieLRzkQVloTiyoqqIeUt9wWDAy+KdEXxTBSiCkKGgOJOBo16GIB5UDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527727; c=relaxed/simple;
	bh=XC6uugmYTns1ck5ScAPME/ugmqQ79XugolqBUdQiaaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qgn8k+Qh6wWvtq1kF6ssi3vn0556NJtDjAahyCP8D5TXVgmDOpjBinuwJDMpKXK1CPejFIdt98YAdXaxhigYEEiq6v72q9Dvzas7bQAik91U+uLhYcryI+O3dd/PpgAo91EseJrDhdlm93LuJeOHVHFNluKw/rabqO2WS/Fgmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MkZzb8ZV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ece1102998so505943f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762527723; x=1763132523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBlq9mhdG4UQ7VoB/xIAxo028Yzo6gXak7ypBzFAJHE=;
        b=MkZzb8ZVrd0NvUaW4eKcCKi68gbhTZsLZ6viXxySLpBx9uTy2gSqYbO6bcq7A97bP7
         bWvsoCFkqhzB34ckd6j/GSwlchqvfNFoOyiKrEOBoEXNgR8CcwmEan/dbDnju9Uc6TUI
         vjyxDKrerlmCIw146ThUhG/d0vvYMfZ2SFp1IUZMlnOci8DTRwERIccg6jnqowZZI077
         pp/u4bZD8gplgfQ2S7QN7slKMNmNrvc9DbHmJyaEcxEOIO92sXOJkACbZ84kkOI2WRaM
         R8rC583Tb5uBT/jOiTjnBUExK0YjIxhGNdOx/jWslDmCL20xTfAVCKhNV19imXm4I7Cp
         nIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762527723; x=1763132523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBlq9mhdG4UQ7VoB/xIAxo028Yzo6gXak7ypBzFAJHE=;
        b=jEesgYOQvi30mKxjiZHs3c5yBsgqCl8uLewYMBWptVS/r+XokTS271/7tPdHI54oY8
         JfM0VaStCVPlNLaT8UaPtks519OixdEkQnTTmDORy8Rz9CqLWiHmxguuXysdZVMSnJaj
         u7mvfWQa972qQV7PNXeKrHACY4kslfxaeT1T6ppYXgyVxUkZsQJqn7VNuwg7MW/ksNMb
         hdDjC+IwZmmCfhg0T5xgaU6qu6N8SNrBWNMDZkbi8gScsHbHRgTTX++ORc3jE9LuTr9j
         FWA1QCzBcgl+L5dkcBPlgSqPglnXfYnGOSLdJKoBZc2CHprZY/B64favGsoCbm4HHxa+
         e/BQ==
X-Gm-Message-State: AOJu0YwVXenEamUwmtgmV3y8W7pLSiIrLpIDRBs78q+KKm698DVObrTY
	k1jTYTVkWDKnBifne20pAKGhLuQAeIfjiC/5WP1d0Em+3UCEiShlKB5sehSKNhN8eNj/eOChjAg
	HkhGj
X-Gm-Gg: ASbGncu1L08wzUNmKOaXcfv9KkREyaQPTwX4JzTF+sr6ngkP84q7MH3kGjOPLVEal1d
	4lMjU2hTdJsrfdHlvW1C0JPpruYg5deI+mDvyk9SyJiMu5C2uT4/r9D5hRpsicbpNmntfx2Gn38
	/p3Xkumctxc6zt/RjznP1snE/L06LvWv1imMY3Fo6XLNCNKI4s+badisUwSQ0JdHUPFWajN7rLd
	0v346C63HX/Fj2R3ROdIgatpKra0InvUNjW3LxgJI5UfY8YhvQfINWnPS7PRUG4SUq0Sij4Os/K
	6FJ1v929KcLvhzWPtgmkC72iSp1MiE9fxknYy1CT8EgFNAYfpSwqzQ8WEml4PKy3y1AaqDWzCeK
	wcasXdBThI622ChOamGwOXX/4H6m/ZVtBC/qrg/Iqu65MuJGQIOb2FnsuaW++Orc+ZbeNlcSR7e
	LHddfGGlWHcPFCuNuhp/4ACdwr
X-Google-Smtp-Source: AGHT+IEsAcAscbIMilLctf7rraQtAqjW9Tpt19dMghRK/QZBTtQ+e3byaR0eTc6m7h4AOrfKPxDz+A==
X-Received: by 2002:a05:6000:1449:b0:429:d6dc:ae0f with SMTP id ffacd0b85a97d-42ae5adf3bcmr2632448f8f.49.1762527722837;
        Fri, 07 Nov 2025 07:02:02 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca52sm5777830f8f.25.2025.11.07.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:02:02 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue
Date: Fri,  7 Nov 2025 16:01:53 +0100
Message-ID: <20251107150155.267651-1-marco.crivellari@suse.com>
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

    This adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
    to be per-cpu when WQ_UNBOUND has not been specified.

Thanks!

Marco Crivellari (2):
  scsi: bnx2fc: add WQ_PERCPU to alloc_workqueue users
  scsi: qedf: add WQ_PERCPU to alloc_workqueue users

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |  2 +-
 drivers/scsi/qedf/qedf_main.c     | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.51.1


