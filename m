Return-Path: <linux-kernel+bounces-893744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BFC48395
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E2AD4F1E61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9E288C34;
	Mon, 10 Nov 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bWPnIpBd"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F2274659
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794238; cv=none; b=gttgM2NKytPsj5AgING9jgwEEaptc8cu6Xcb0Ae69mOlyUpC3iBOm8B1j2sfz094FR7THR6fYBB+aJF3mBhdwvbqXFj5osaWUgHRZgUXHfFFHnvaITOPrRKfadQ2FzSm17pa+qGshq3cT4BqgcHPz12TeDb2N27AJSix+6nCAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794238; c=relaxed/simple;
	bh=+tY8ajTGsdfVprogUVgBgahiqjs/5CliHkEuromOBe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpXmY1QXYxj4WW1jJlehVtfXrOEJ7Rr+lE0VrpTcYQZeolOPyVB/j9vIIasvU0vDTzCrAjKKsIXCAmxWUd8Kfl/6Oa+DlO5DLFg75+KaIksjFLV/0W1F2zZfSAh1DaALFXRtlVF8QkyRkVa29ga7o1r2gDxlxbjLVz1uKNuglNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bWPnIpBd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47758595eecso17218275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762794234; x=1763399034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gFHvO+n9sMrAMLMW/QXb1k76q8yjA0K6xccwNAkj+U=;
        b=bWPnIpBd9rIcZAlDM6n6EmmHXqqlPXn5bIqo/5gwJb7nPFRxnpJAaI1JmQ98B+ddTc
         UxERHzehRkG4wNLzK6kAuvnWTtR1Acz9h2nCJsGwDFJ9AhCJLDdjImSHIby7gThk6iuf
         v5/+XB1fmpyvSspupj8mPOApsGslqM3yogGVTxrFLyGshXs85FCt1A40mG+7V6d3VSmG
         ELArasToIGoUfwBWb723oFM82+i+9Jdiaj742min6Gn0c3Cx8Fw7IQPNKYwOqVmELmS+
         sKhVo3Hk9b+mh5dcYQhqAIOOc77KATQSgEko8lL76VtRL3b4qL7xMPY0wg410cpV67+l
         bjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762794234; x=1763399034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gFHvO+n9sMrAMLMW/QXb1k76q8yjA0K6xccwNAkj+U=;
        b=RrFxP/bQYZLuabeY6LuZvWJQT+bfLgDqRMoHXXGQerFuntm172o2PK49BF2RckMEkh
         jfnOGdRbEsErxc+zVlmrlQ6OQpKGm1krg8EvOPks+ZywbCU9uGwI9el2oFP4eonlybRm
         NFdvmvQW8CsnK6J0v+Lo7JyDrOOrN7ZiU3yvv++SRyb+GgEPLiqLpFa4bp1NNzQ8mYbE
         ysbYF3Jf3gXRtWtaWHFB1Bu3viQkHPhDMn6oeJagdYISjsfyj++/O+DRQ2W88e4Vp4zq
         7FN7ls1LtMn4Bww2iLCRy8gzn9wUP+Q1t1nbhuWTPE785KQ49cqMG8OaRNch76SZyL4r
         04/g==
X-Gm-Message-State: AOJu0YzqUrxuYkuiG/HYR8znlLWvueoLcw8igjUkBNC2lzO3CKfPsK4u
	NGrbev4Ikp+Oc1OHd1ltxKhXms3FSnduJPRcTnrJGWbOFEoIH6ylMmlRuBeXeArnmGaAnU0NF3E
	OK8+o
X-Gm-Gg: ASbGnctAyBYMtgy02YjI/tio9BV47k7ByuedD6R/is0sZdOsZxoWQ8r/XEzahmGje1a
	GCMGagj20iwhy6ES8hQqPsQLDdLYzBO0vxKn0IkhyRivjH/2Rd9y4ksRDT0PBk7j5dY2G0Icjq2
	/b7j1sRZheyXDTwrV/8TIitu2dmEExMsnPPZ28NAnDUhWfAi1u99ZBEW6VHwFrrzGNh8slMPktX
	37zUQSkkCwutpCYzULTtVg5J6HTPcHJkOH3c9L8WmOgsxkSITL7riCN6KvRN5JLLB+9PKxFRKIp
	Nc3+zgBYNSp33lERZhlnuJMBF9bYUhBH5zwp4dyny2jmd4vA1slUFiI9j9lD57qlWBLUoLgOFTX
	ELnmMc7/EZ9Rj6ZPbCTTgvB1L0c5vejrv3SWttCTPjZbCsiXjNllKG6fSVO1O1QYUYcj5MZMRHK
	ld6KWtVDs5QuyiLsI=
X-Google-Smtp-Source: AGHT+IESkTEBC2UzWqY1nejxEi5370S53POBOtATASnavLFdkH2yFlosCIE+wbGP+P36sR8a2vfpKg==
X-Received: by 2002:a05:600c:1e88:b0:477:7b9a:bb1c with SMTP id 5b1f17b1804b1-4777b9abc9amr44093465e9.28.1762794233840;
        Mon, 10 Nov 2025 09:03:53 -0800 (PST)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm337557305e9.12.2025.11.10.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:03:53 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] smp: replace use of system_wq with system_percpu_wq
Date: Mon, 10 Nov 2025 18:03:32 +0100
Message-ID: <20251110170332.319314-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- improved commit log
- rebased on 6.18-rc5
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 02f52291fae4..496358eae37c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1137,7 +1137,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
 		return -ENXIO;
 
-	queue_work_on(cpu, system_wq, &sscs.work);
+	queue_work_on(cpu, system_percpu_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
 	destroy_work_on_stack(&sscs.work);
 
-- 
2.51.1


