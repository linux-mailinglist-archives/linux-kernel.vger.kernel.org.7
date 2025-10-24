Return-Path: <linux-kernel+bounces-868581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C37C058BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8834E1721
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04630FC1C;
	Fri, 24 Oct 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S6Kr0ZCM"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68630F80D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301163; cv=none; b=cbE8u9KfGkekbKKiYWidk35zZeT2D/Z4Avn4Z1d9AAZpWZRJCZWZFFFqg+PERJlDBPfiR2BoR/5UPw2Fzkm1HTh6AoQcftCK1h69T2NP1s1sXfinG1wc87l4mZ9c090r7Ojxs5eFEdm1zFPojZT3bc2XZpteS1yr7ic2KagI0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301163; c=relaxed/simple;
	bh=jpi5tUNvqAPbAh5rAmI904fmrzw/1XWsnEHfvKBSGkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFZQ9HmEqDBWUqedJnwEQJNYDOK1u6VzKA2lUM8XOE8rk/PoqdS4sm10rtnSlDMdFndTbpvgRlHSkkvdGos3Ov5fl8HqD93bQjPj4rrUoy04kb2IdolZT52AZG6hvZ/NmNPYG4Boe3/21i56Fe2Qcd4HDF9wLovAl1egqccLmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S6Kr0ZCM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bca51so1673451f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761301159; x=1761905959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgEp3/LToZp/GosNdi2umrYwYTn3lhTPbryT777G2DA=;
        b=S6Kr0ZCM4DTkODJAo6kbSjUft+/+j0UUvbCo9489g7hDHdObwgO/ScFERTjk1Evfch
         /cgiaAVfaUGHZwyelCIvjD+aH4h/bztb8NnYeOPm1RJ7r5OjH8MUrLaqUvHb8LvZzusD
         tKbxPdmxoKNPLdzIb4h7mgUNh9VcdB2H4IX+97xVQRxgWjWd/qJr9KxLNYl4P9jGaN8K
         +B4jEXc1zOdkCnz3R8inw0O1f+2V+Y4qaQ5QZYjbidtE7PYg6dV5LXBuQfK10GHs4z+T
         J7rvFAbpUQ7vJ/9kPLDtyCk5Kpms6PhkSe1O68wCUoQw/tisiBdfamxKqTjbxyopm+uS
         Ikrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301159; x=1761905959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgEp3/LToZp/GosNdi2umrYwYTn3lhTPbryT777G2DA=;
        b=to9DEx/TeJb2Ak2UaTLdSXfXnL/hbGyIY7tF2c8L5reCxoXqSbBnZTDt4aEfrzbRAY
         WbKb1scEl/UB5Tg11wkVvo82LF1SCBw/x+DQwwo6zEnkQG0fdk/tKTSSKpGxvgMhKwrg
         iN/tfQkDagOLepdo4RjdYOlwktRfFh7Aot/SLeDtzqflu/0cEMA+3PWy5gRf5vEVZZg9
         WPK1K7dxQEu4H+YNeufkQ87phXPcMuRMC9KDmzH1rLDOuNtOCVwTAYUk179wlYMZ3/Py
         O/MFQKqZE6EaNigng+pz2rPG88KOfbG3BK7fTomCV4xCUxl5q7DNL9y3oCoONGmRz7dq
         D2zw==
X-Gm-Message-State: AOJu0YxowRqmzX5qH9uW5gQZRzBAQY/7gudHZD4T4xPFPxbyr5NFiqN3
	HxCsSNxrpCSb7om2Ydgnkc73gKfJNxKbEy8Qok7FVxOKEusNRvOfssk47/puRiEtVdquywB8Q+v
	dEMFV
X-Gm-Gg: ASbGncstxXtuj5pjasFU+NJSs3n+CX9jXNdwMP0UPbS/mHMJerQnxHkjv6GYeUywwfA
	HTAQFMPbGIzQfjSIYZUyV6+qkviIBGFLH7sbMZAlSO2ZLi44Ic0Ry/jnqjQ52LDCMFpMzl3ZTei
	doojUKRAKkUoSNYMuBM2rbU+CX53NxlbGi4z3UmqcIwzF3DjN6XBbcEjBDXzyyaVwDleF7EG63i
	CoNLB0oMEGtzdCL4iZuzRRnLQGYPtjrk/hjtiaQBus9sqImSD+6AP2lUk4Q1go3NRDXmwn6GBzA
	017beavRf0+BRELtW3ABQSE7+HGhyLfhUYiHNIxawqzLXAW1FvMOt7V6vd2JvELdd73+/U/wj2a
	fnNjM8ymYbJRWJM5fneCk/MMFB/H7lFbe1NLeDPhrAJkf22bt1diklfLJs7iBlBhEw08vMFHvkr
	ZiPgIV/Lc7skBT3MuaowQ0O13Z
X-Google-Smtp-Source: AGHT+IGQpV1nXgWUlK+aUmwPbmSGQ9jLdeak9riJ4mzv2VCGIG/iv58P/57281TgiEumWRkhBlYnxQ==
X-Received: by 2002:a05:6000:2411:b0:428:5673:11d5 with SMTP id ffacd0b85a97d-42990750034mr1588911f8f.38.1761301159385;
        Fri, 24 Oct 2025 03:19:19 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f52aasm8372695f8f.12.2025.10.24.03.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:19:19 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/3] driver core: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 24 Oct 2025 12:19:04 +0200
Message-ID: <20251024101904.146351-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024101904.146351-1-marco.crivellari@suse.com>
References: <20251024101904.146351-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3c533dab8fa5..4dd264207a82 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4138,7 +4138,7 @@ int __init devices_init(void)
 	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
-	device_link_wq = alloc_workqueue("device_link_wq", 0, 0);
+	device_link_wq = alloc_workqueue("device_link_wq", WQ_PERCPU, 0);
 	if (!device_link_wq)
 		goto wq_err;
 
-- 
2.51.0


