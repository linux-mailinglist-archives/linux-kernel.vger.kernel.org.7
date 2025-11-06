Return-Path: <linux-kernel+bounces-889007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D29C3C7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D254C188141E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4462C0294;
	Thu,  6 Nov 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EMWAvVSo"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54F27FB37
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446490; cv=none; b=RBclFX5H2/R/S0WOhkyucwOkSjcKMUChuYeRXpASmLVOjc/6mhdv7OACT6imu5kIdTvoD+SFetlg36Kj+dPpfXzJi0qQjBUBpsy3ajnohU9b6xvm5ltLH0wSSQTtQ66EN6sbt9jN30RghlfnAf37BzDbqJM5sCGU7fZkwvcBQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446490; c=relaxed/simple;
	bh=NxDsSZFL8xp8CNCIpuxRzByCgFIhMyI3+Xgm52UXPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJKfhtpMoCCBuYI1AJMGjzm1nY0FxYxJ3OdzdnK7h8DN+gICDHqjgLnozZ5H18m52nZf6z+/JUpZARJSDlTpRZX2Kqj9jRufGrBrECLumz583iUpi+A7HsQqtxSM7o5Xsp/fBnGXL7iF+BDte/hSN2lgiTV4U5CBlmN+Y6g0SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EMWAvVSo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1170786f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762446487; x=1763051287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPiFUP87SgjGnyl9xYsEHrafdTSjoceBL1CQjrWm6UE=;
        b=EMWAvVSoE2QTm5kMrRX0ACJm93lClxghlo2UWgG2xfRlhLT0DnUFjCWsLjENn+jbzu
         Jz5165e0ges8Z7dQcDtk0252ghaDfi1uMkf19eKU896CYmz+sIsNetwG90/tiERnwj/r
         tTW32outsEasAXSB+3f4/utBGLK6sl0PU3ERnkKgJfZMesX0coXVBbMrOk4wLC+2eXQf
         QMP0z8Tw0Nk6wEJ61QB4si0Wasm5w5e4tjGyujkQWynBz4knRi1rUivG7cwJam9+ZFWv
         Hi2FmFEwkOeHRMfXPp9etJOXTmQ/ufb2w2sLbLjDFAE9hizTtNUOFVZd0u8vYCsWWKfw
         YM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446487; x=1763051287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPiFUP87SgjGnyl9xYsEHrafdTSjoceBL1CQjrWm6UE=;
        b=FMN/lO+igVBLsEMsyljVySGAF2NRLP1vWGNqm/ddHn5K/vtIGsJs5FKNjHv5mxJvbM
         g45SpRtdgYviDGWbu70fsSJsEt9axu25NYNBf3pwL3hW8d+HW08+wLdnoHKeeelkVN7k
         K7it2n9fpGE0jDgkqB04dAI0fcS2k3pdNUmYtv2pj6z7Sj5+PegEBPxEKYShWsIl74sI
         pTv7mKJX7l0iRpG+7rQT9MeHRS1N0Yzp+VL+LpLCZQWhYy7kaKRrwKQcp2L/TKb5iznV
         luk+pQ5sf2H2Mg+PXHay6JSElqqTdvGTuJTYYLGlISKUcicxW3qi0P04Sy0Aw2zO9bS1
         1yqw==
X-Gm-Message-State: AOJu0YxJTHcSR/eo/suUb0yyztOvF8gszQjUh+09HFpgxOLfb05vbYap
	upau6KfcZ4oxa0k7fXffNlv3RhyvytTmor3AqYQyLMtkebDzhE94K7rUppb5aG3Ew5DuG8eqJIX
	R/15b
X-Gm-Gg: ASbGncviqSXfY4z0ipzOfd8kgGVHhCwJvdyyAMgddnWWxInJkOYXAOc/882pPRWjsbd
	SVNxAQy1Yb6CJZueG3yYvZHAYMhxEsJioOpUmPytRNiI5snRaLeCfOYji/n6kuUVqlgsJR/eYLw
	JwjfPX7uDEaKqraYtqDmJ24Ut04j+EHDOmi2h6AlH7J/xHhYn9Io46/aWs5OeNLLfvkDlitzr1a
	YJEE6D0RliQsYvjIoxJ7kbc7npjbL1X3dC87BYqmcvmaiaruBMesSHeZdYK6ohlB1Z3CeK3AY+8
	ougqU9veARtvXwoOqYHvfsP8y2KL//vJLxqN9Vy+tKeX1EuPr7LyXk3akZnMXIwRCMLpt/lfK/d
	AgwljJF2szFT8uCrie50JcIR6xIwQ724uDW9fXEM38ofZlEe+8B5SoV3Q5Diag6xwTt3z7Ahe2y
	6oQf+Y8Bmxpc6Yl+pALGHh8hU=
X-Google-Smtp-Source: AGHT+IEnCMR/0gFgC+aRgL0DQFaOpikSi9W1p59m6FuSKz4Wza1crlEKVQ0M3IW4PxvjEDVxvulglg==
X-Received: by 2002:a05:6000:2012:b0:427:a37:ea3e with SMTP id ffacd0b85a97d-429e330ae1emr7388139f8f.52.1762446486625;
        Thu, 06 Nov 2025 08:28:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf4bsm11047f8f.8.2025.11.06.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:28:06 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:28:00 +0100
Message-ID: <20251106162800.331872-1-marco.crivellari@suse.com>
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
 drivers/char/tpm/tpm-dev-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f2a5e09257dd..f942c0c8e402 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -275,7 +275,8 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
 
 int __init tpm_dev_common_init(void)
 {
-	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
+	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				     0);
 
 	return !tpm_dev_wq ? -ENOMEM : 0;
 }
-- 
2.51.1


