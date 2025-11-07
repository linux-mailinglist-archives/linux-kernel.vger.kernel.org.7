Return-Path: <linux-kernel+bounces-890580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60EEC4067A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F933AB6FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB1329C4B;
	Fri,  7 Nov 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VDlLkj9U"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CC322C98
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526327; cv=none; b=YtvmWcnEgoL1nyX0kY/qFxTNbJwG1l5TKupXqUDyNfix+uio4GIzOstb7uRJpfeEZV1QqSM/mcSfukURmimld4V12uFBiRJGvrTRXcDwR+3nGNNGlYcWmQJMbwbYhkE3os4e45FxfbigX0jta8iTKiM5uIw1uxDbSg7Jtx/zqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526327; c=relaxed/simple;
	bh=9Eu3yarqsEXMS8lVYC67u2tBOt3nsWm7YB99GQ+qa3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jd+pfR9NDrLQch16NkvfZ1uRs/8ERJMQCMuuJuvDR3Wr94i0FDKS9iZl4NYirMsC1rYCcbvJEQ4j2aXpzP1ftADWyu+f5EjawSNzKdrFWzydmY3EofVRl6+0u0a1kl2m/WdE3yF3D2qNor+4Pvg6JMdGrF6Jp8I8EewgNgtipn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VDlLkj9U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c82bf86bso430940f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762526324; x=1763131124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+M2nfWocWAp3mZ4tDZ/NECiHNbUMiwpyH/iW4S7LXgE=;
        b=VDlLkj9UEgiEtajcShLdJTpoKnYWzuUjxXIPD2/ybqpP2LkrNFPbLuMLSgjR7zqLe7
         vFB+6XP/BIdeQrBXihiAPWkja1sbzWv33bpYoKxo6V/0Zdow5aPeSkX8cGX5SJrV4Cl9
         Vylq+dKMT0HaEWDgI6KqYMEhb6BpLN28ZxZrjS3G3e1QOpQGK4s0eFqnkvq4zUrGpqJt
         Rl0Ikqs5Tko2p599W+2BqXaerA2xsZH1o2PAHqidKN7vRKkdn6Fyn7tvNqLtq+iaCFBM
         OXca6hTOA5HBoWfX+5yg1IlwbgQkm1ckkapK5PGyuN3zibdlnJGkOPxQXabOVlxgdFqq
         GAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526324; x=1763131124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M2nfWocWAp3mZ4tDZ/NECiHNbUMiwpyH/iW4S7LXgE=;
        b=oWGW6fJht5d7kd514Hoc57H61Ukfg/P5Nh5UQJE6yqAaCD//6SdYSricDoR8xgrnmz
         1mOKTQpEc41WbU3mV8BnV84aaocPHHvzGQf4/n9bvy7GVczgbrjYp6Xz1HjHDEdPLRuw
         7u84/P7zVxll2+9iaPPH1hjfSLHcvzR1di17EYDzotmmO2/QUQIHL5pmWVhdQPY3SM+9
         chFrpUI6sfeWJu8iViDNWs9VyZW/RqJj1fKytM5oIGWJk+HPXpCUo+tkGYKwJG+LyGQs
         gcJfI4NrB1uv6MT5gLikdrQ0R3ruR1/GKMaw+LxY14udp/X3XwU2RLOYiuZAJ344dsjP
         lCUg==
X-Gm-Message-State: AOJu0YxxNVGBFAH0dl24FTkBUU1EbS5XUKLNjNLE4RMk0cB/8IOlX0tu
	7aIbeOFkCdK+bgSi/bCweBkPcXVG37O3ow7vB+JpactdmU7nJrrmrlyupfL5Rf1/bwQFSD+Q8J5
	nyGrG
X-Gm-Gg: ASbGncvev6jr38w9QdZGP/ycy3CADwMTvVtstwycsAnJJdZYWLmLk7cTsJBflX4DdR/
	9fk1hssBjeg0DOY9PaiiQahXCd6+wpZS7bcJCM22sxJxVYj5ZM9iO8HloT5hQMABGYuxGTkyMcq
	x8mObrHqqIMiiYfEuVVxbZNrL2e6IxphoFvIXCMjhjO8NK2z9esb9GpNCrZPvwwqanwF+qa4LLs
	qKYUjnOlia5hM0Jcqph8b6yJlRzGKGaEcP3ARDUD0c0jPVNiNsg1oGBlNYBDE4VdbxGuE7q7gxv
	Zm2b1BIfYL51Mu+Ryrd2LKjDx/LCbOsPOaGpMb/p36qyufx8rCORMkLEEN1yjsInfCsN+Hd9cVs
	JA6E538y5Gk5wOECbZ7ifLyBoTGMm1yWEGMHrCjxRRd3/MRRcS2YRQe7m72y3N0/OEPKc+VT8Pw
	cqNfO/yQ8yZANIIdfdwBn3fpZE
X-Google-Smtp-Source: AGHT+IErAG7umGXc3Q32btkC2X/NwPm9eeE2SBi6Qlb6E6Dsctm3C4mBATHE2WTygUj7Gi1bpdmGng==
X-Received: by 2002:a05:6000:178b:b0:426:dbee:3d06 with SMTP id ffacd0b85a97d-42adce35cffmr2917437f8f.22.1762526323850;
        Fri, 07 Nov 2025 06:38:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63df69sm5798411f8f.13.2025.11.07.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:38:43 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] platform/surface: acpi-notify: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:38:37 +0100
Message-ID: <20251107143837.247085-1-marco.crivellari@suse.com>
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
 drivers/platform/surface/surface_acpi_notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
index 3b30cfe3466b..a9dcb0bbe90e 100644
--- a/drivers/platform/surface/surface_acpi_notify.c
+++ b/drivers/platform/surface/surface_acpi_notify.c
@@ -862,7 +862,7 @@ static int __init san_init(void)
 {
 	int ret;
 
-	san_wq = alloc_workqueue("san_wq", 0, 0);
+	san_wq = alloc_workqueue("san_wq", WQ_PERCPU, 0);
 	if (!san_wq)
 		return -ENOMEM;
 	ret = platform_driver_register(&surface_acpi_notify);
-- 
2.51.1


