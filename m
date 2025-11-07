Return-Path: <linux-kernel+bounces-890454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8FC40178
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CBED4EEA57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FD2D9EF2;
	Fri,  7 Nov 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="adeku6QE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB827AC31
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521898; cv=none; b=cSAgiL5p2L5lEifyzgLEBgA1UYTIE6vIO6ShmnGdI4Xl90PoBNnFDKlgJfpp3rWrPVUwDqQ1xQh1QANWjNTcnDeyq6f7l51ui8wyJyFZKNg5iTxG7M4LDdDpmr2Y3Vm2oadEwvWmEe1lPMLmaZfJOihAN48D3PxlUHC0jrS9y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521898; c=relaxed/simple;
	bh=CorlC2x/QGbVc5MqkpMnq36sDBoV0+JfcYBM5ofKy0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EoR26G5HwDKj7zQwRCsj5C7fOuxr/LLufOnYGeJL2MC7Ej1zXRw29kmtNxWsmizJCC4nshrR3x2NAGobjhfGTz2jb9XS552hmZADanzIWThg0yADNWKhGaDqTYKboZl4HZIa8MVqzP/VIInTXk0bxqcWHqL8Gv32ysN0lnBOzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=adeku6QE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42557c5cedcso454318f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521894; x=1763126694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fu0ShniKzlfX+F38wOCJrIRo+AA6QvYIzBpRF8Rn2q8=;
        b=adeku6QEJNy+FyB5nVeyk2cwAVgGmTZEPKcTMomE4xf0VO2AEdihnX9NNa7uzN9nEv
         EwcE9CDNo4dk8DGLi+ovZyahLKGBXQVCa3Ibi1S0LCWD/eHAk5u6+XOG6ezbL+Olmzu8
         k1zdFN9zVnV11LK9KQ1yGy82vqzA3Iy/pFlrGh40c/rFZhR6cL3OYnA71Pzy2q6xxC6M
         yaDTZyeuw/A+ri0CYeKwznXwzIp4NtHVa6c8xwNj6HCT+szY6N7Sf1AblIAfGpAfn+O4
         AJ1pH3ncEQ6nLa26LacKLcpzmYCcPMjhNLTK6j3Yv5I51tdKtiI+vbKlSsYAF9Cc07AN
         /9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521894; x=1763126694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu0ShniKzlfX+F38wOCJrIRo+AA6QvYIzBpRF8Rn2q8=;
        b=SftVp9X4w4qksIjihhT0vlE1QmQxkU/u59lRI077CCvW/x1glveOfMMQmsYU0eXkx+
         YWr7/EFKtg1TZo8mbjZweDoz0g5D8EtxgUpa3jHHOVb6AhnIbE6GIzD0rGc6QxLF/5RS
         QJoDVfOjhIOdiwHdf/hgWp6BPoARXlFxUAxziBsbSHCIKKDdnB9CdfOB8vgVaH7H5Zmh
         Cj6E2rinfRvu6kkGCUMbS+Ju4KSk998ahPIrm11W6f6CzSNrplxtFFopPDpIBc2IyZml
         EessuLtwUp1WLrpjp41744kRt6jugDdRgHJOj8hU+yCl/GbNdhAaiIUXRexIa8gGX2JV
         1Aww==
X-Gm-Message-State: AOJu0YwTlJHtmKY3nx/BgUy8BVU5auwCuyZ2hCa+DsBjUW8kb1V++K8I
	YgYl01ldiCFVeKJfXEk1yXxSVXElievzmczPLPmkJluUvPGvz8MHf8lqqBkYxSo47OpTmPNX0nN
	RphAg
X-Gm-Gg: ASbGnctER/FFGmFigFzyxuR0klvDMJ+ScB9F+Mk2eCbJcfGuSlXK8SPKX9ccodXYuDS
	6pdnPrLynHOTDiMwupHBka0IE63m9CblYAXcFMW3nGmQoW2BfoPfgiLTv+sPxamzBogNidPfq5h
	OK1J/bX8t35vamvWHSzyhC0HhdLsD9MY+Vh3nmzDHQrDZ5RY/dY9HIS3EPdPr4ML4qC9LYwtYwr
	BoxIS1QcRlSbY0X8aQ8SeP39T5aZw1Fzlz/a/G9jz9vfKBh4vSYIARDrMJyxTm3+76+m33mqHo4
	9AMEmExHwPvDZINiunTneFwE/G98EbqGKPwj7FI0RZVDM1H+KXILHy1fV7AmDBaMggx021bys/r
	jbn76jpJGHIbfGX2UZE6nNAQEThYAHhIsJ2Xn0uIn5nozLe/C8nQMtdXK8qmopfInoF22ErZXcb
	NTu9hO1SCyTrs/VTd28xsQU/Yv
X-Google-Smtp-Source: AGHT+IFnon5300BScc7FhmG+zbAjkt82S2MuNCGlqr3ja2OS6GNjV+p26DWVXJNPI0pKBCpLjCtSng==
X-Received: by 2002:a05:6000:612:b0:429:9501:c9c1 with SMTP id ffacd0b85a97d-42ae5adfc80mr2760918f8f.46.1762521894289;
        Fri, 07 Nov 2025 05:24:54 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e126sm5323280f8f.16.2025.11.07.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:24:53 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Daniel J . Ogorchock" <djogorchock@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH] HID: nintendo: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:24:43 +0100
Message-ID: <20251107132443.180151-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/hid/hid-nintendo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index c2849a541f65..bb088a066dd0 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2648,7 +2648,8 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	init_waitqueue_head(&ctlr->wait);
 	spin_lock_init(&ctlr->lock);
 	ctlr->rumble_queue = alloc_workqueue("hid-nintendo-rumble_wq",
-					     WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+					     WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					     0);
 	if (!ctlr->rumble_queue) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.51.1


