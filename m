Return-Path: <linux-kernel+bounces-890463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC04C401C3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597E618891D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396922E22BD;
	Fri,  7 Nov 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fjst45OB"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7222DF140
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522046; cv=none; b=nO6GO4f0OtXiyGNnKew8PGJFFVN8Hp1LGtoiH4yRaWaJA/6LBHFILnM/bO0fXH+p+USExE2YWbKXSpc1RV7pvSxVM5sNjqeQiyc0qA8mNv2jm8M7UkJcYA5PcHM+Q7uSlFYym93KKkhVQQxdf0d+0DcBr992zofPEvyVKkLf8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522046; c=relaxed/simple;
	bh=xOgIgUMI+BwDiOq38R4O8HSLT6TrQvpp/zCzKFcAC5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GDMV9e/tDzS/5JIM4qpo1H7gmwK4uHDLduJRLZQRX8h5BVqQPJpQ6xtahRQw4B7cFTn5hT+DQ2WYnxSKZPzKl698D3mcrnNGN8RJY07cHLpiii9mUo45etyV2mXDWTq4EuGI4lr3TKVArDO83bjc9+Pda0nqxyAxd/rJWJlw0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fjst45OB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426f1574a14so460290f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762522040; x=1763126840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpDBdHac69yHdTxfS3btmvWgT1JTkvIR7tXnz5+sQMg=;
        b=Fjst45OBz35+4Bm29+PhAJ7YQZmD2SYiwbQ/UXlJDFH30ESQ2Ao83E3ervY7mhqzLD
         CIiKqEQ1iZq6yMKqUwtmUEfknXQxMs/3ZQGzLgqsVBAGKfUC4CtCc0U2GQCg+ntn8hLP
         8GNQe0SdW00QkMOhlAKEWPymraLckuZarBm3lBlRVBx5ttT75/hHe8Qwv5/vpehTD2lJ
         7jTrIR78ILxK8zULOBRDB4capkWnpXH7kzrNTwfrDG0+yR+Jv95NOtdOh2Rai8SnrSyC
         Cb8AIVQ3q+vuegvMPTl09EBIaH8eeqb+Xqo2OQTKtaCNmcUJzU0d59lNhXaTQtb8eAzH
         2ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522040; x=1763126840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpDBdHac69yHdTxfS3btmvWgT1JTkvIR7tXnz5+sQMg=;
        b=Wuomr10HmPhk5KDhZPK87ZFj3EGM7sEokhkd5eLJitEXe0Cqre3hA0IL+S2mNb9Oqa
         1Dn6/WuRG59SwVIImyD1yqxGtbzmB+TcIkpMGQ+61xvJiP/riaEoOHvMZdcwQrio9XrY
         N/nyWVB0TtY4zouvGHPC/JnTwA5clxN18/rwh6iph3zkngIfqQtv8pF+1ApZGJSiKqhJ
         Vy3wCyVabm0b9nmrPgjE0epU6b47S2calt31V9sMMIO4xdm1zTDzFTziLgqsDuLlCVSN
         jNUE1hx8smcVAvDd7/v2Vo1DrhgbPvc7tW/kNnRP3ywalbCC4Mz8/SQqp3/gEwIkV+qh
         +Rvw==
X-Gm-Message-State: AOJu0YwQ10Qdm+PpSdXU38MP4nu/ddeuRb+MwrzXRIa8f2VV8ElXSjmA
	QpqfBhPyvgqBvyKXlRoWmR+S3beAPh5mrKeyglriBEOtvJmwvwpYs4MscDQL7mPTs3OeCkwvC3i
	5zj3m
X-Gm-Gg: ASbGncvLh3armgP2iXD/lhUDTlIlsLXi1zBeOXHBAXPbQBrkcJ8WA9CR3bcDNrpWGbO
	UV5/Yc6P7hwq81tQykZXmgSq8rcBDz46wB5gJpL3fLMBAdzL6XWjFtijy0GUR9tedsPF0wwtlGQ
	TfwpoJ2D5BHDZ2A5brBvv606vnR0tob/Jhz9HfdsOTLLyrN7M3aCg2vu2FOgZAUshZgkkqI1I7v
	nVuw1FAi5xvl/aQsIKPSTgil0TbLYmAanUorr/vr5KYkpxB4v5PoiMhufV+TYbUd0dOy3QnBNWD
	r4s+SUoOWnRGV63FYg7M6PVqzXIDUk9FuHKBwe4DBxxKr+0hLMWutRPalpF463X7gp9XsxBRaDy
	W0RfdqmVkEPzfHRoURYmKQrtcGlKH/iwE8iExzqqbIidaXdOq3pZj4rB56v2vFFLoEEFNJ//9hM
	MN1Cpq7Tu+QTAIcXDzzHIzFmIA
X-Google-Smtp-Source: AGHT+IGXoQU2aKwjfhm9zFbD1wEw86QWRNpD8ObJ2BhZ4tbaRurd6UaGdy791fVPME62ucuMSvHuLQ==
X-Received: by 2002:a5d:5d06:0:b0:427:921:8985 with SMTP id ffacd0b85a97d-42ae5ac206bmr2453743f8f.40.1762522040253;
        Fri, 07 Nov 2025 05:27:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm907220f8f.32.2025.11.07.05.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:27:18 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] mshv_eventfd: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:27:12 +0100
Message-ID: <20251107132712.182499-1-marco.crivellari@suse.com>
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
 drivers/hv/mshv_eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 806674722868..2a80af1d610a 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -592,7 +592,7 @@ static void mshv_irqfd_release(struct mshv_partition *pt)
 
 int mshv_irqfd_wq_init(void)
 {
-	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
+	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", WQ_PERCPU, 0);
 	if (!irqfd_cleanup_wq)
 		return -ENOMEM;
 
-- 
2.51.1


