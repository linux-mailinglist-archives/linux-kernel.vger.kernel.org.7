Return-Path: <linux-kernel+bounces-878577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD228C210E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D031AA2139
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5E366FBE;
	Thu, 30 Oct 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="euOyBBWw"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565C35970B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839279; cv=none; b=mUWj/aB15cb1+bG2qMPCIEqGL8RkskE7kXdBE3po8CrYqwgabug3RmddwDkIwBHWM64ZKDr8HPbhu4MWLf3OUi4eN6Hc4pKMvVVbgpFTYz+6gklU3FKnzMTpEqkdPKRrKLD/ulrpT6YJOdk/AueuoBRhNMXhmriNScx3vJDwVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839279; c=relaxed/simple;
	bh=x6Jmgz7kV0VtWAu8fu5Me/0BmZbSfEXouiezE/Fn2eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX/JgedlkwU8P6IU1SmbTiWqdR0FNf50lJCqaN1ssEe8N4HMjWkLUXfOPJ/Qqbo3EZ5M6Rtiq7cN3Xryubz9/t3Fi546Y3HVya/djd5oiBf9xq9GO9rpXvBeWNb5ogyUy9rW5K4iPYX53elDwN9nd6/ZB0uQ8DOkvqCHx8DrZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=euOyBBWw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429b7ba208eso586582f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839276; x=1762444076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXy7dakDLCk8jvSrBK5+P+LY5BhZuaHlKUiBvDFl9N8=;
        b=euOyBBWwCOvZyAJx04ToCfke5r355HvV0/89KHupr0ZoBV+SFK2/YwpB9eQK1fPohM
         GvwXRt/6B58ESmRliNt0cPq6dqtZeJJB12HQ1h0JMBGOH9pc7EiE2szr4v+MqmyZfFKX
         gotkNmI6xCkMiCqNsfpj8YbKQE1diYUVdW9AymYKXSfCt/MB+bLiP5gwfr2hIh3MfJQ0
         F1B1O+unzUweXTRlU1eMFfQBi87jWbIj3pvFk/OyKYOx5xsO7L5VAlaaiIwJYWpEFGXc
         y6gs8tbm31oXXcm4qUMKCOXNYvM2Bi7BO/Y+9qotvdhrbUg9IvXxsnDNUUFUohRNsEKz
         c94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839276; x=1762444076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXy7dakDLCk8jvSrBK5+P+LY5BhZuaHlKUiBvDFl9N8=;
        b=tSbMIRtcxtYu76p/jcCogtn41DFc7wvMjVEy+h3XbTl+u5hkWIJTJGOFQu+Lh9TZtp
         Q3wdrlIr2sC5gl3flix992vofcl9fldXyxC+tZz5BRUudi0mRutJJ8d11ipoqI/SDRLt
         IGwREFhbPNZ3TdOq2eB2K7S8AEM/4WbrWBJIBGbiRoZ0E1yLO/XZTUVXIzGcDtnVllWq
         6uCWdlNjNzSC83vULZaooZZ/yCvuAz1O7FISa5ARxWN+vsYrVcbeFcLj8CGZ0EUT5wLF
         rVPP2AKgq/3808KcEkgVE1gc8esLjrO8W4752QGHpDE2Unn29+vJoO07wAC8ImPYGgTl
         Z/JQ==
X-Gm-Message-State: AOJu0YyY3s2wz45kMjeubpsYyuEWou0Hl6nHMr+t/MgpwxS87RFmFctV
	Jcv2xN629RV7SuKw1DX+ANL4k8IOma9Bw7iMGT4WQqeWFYhYdMkzWxPVusNmJuLTH+4ZzCt3EQj
	U39rJ
X-Gm-Gg: ASbGncvEnqicIPeiWgYzRMS9I0UtTdwnz2LIY2XHLvMmX44UTuvoUqEcQQbapw3kDck
	0MmneTmJHFYBXYn+3skvKuDRvd+CaaFQWad8nk4VQPcbpOKbEIokAKGJpfcFw73TQpOhob4F/4s
	SowAJVAm7/+O9/rvnA2JVRd7gpz+D20DE2dhy2TMsoO03Xby7J0zyy30RfqHSUgXAsvRM4fUlC7
	SVufDnNjv352WZNGFvC8pJIRukoPtwouzQN+OrXvh2kk4NWO/7R+mMpYaQ+qGJFsk8Q+FjQVMEs
	NiarA4O9jfPBKbhlLQ78MJGJzHbj3uNQ4UNep3SiK1wbCUkfVRBhUzf9Ozif5KyEtuaCn/Cc9mc
	eBidy3XZjKysIwvvChveZBNyaIuDGMbX+CZg4yueBA5xttA8k4kPnLNhjq3fZmoQPcZbARcVV3P
	Idd7vp1zfqMc7AIVA=
X-Google-Smtp-Source: AGHT+IFpbJXmONDXqy8URpoDE2bukqEzjx2Yz0ZfSH27dYfjypq+STqGcJyBnSPnqHPqYEfzLHpSvQ==
X-Received: by 2002:a5d:5f43:0:b0:427:7d5:e767 with SMTP id ffacd0b85a97d-429bd6ac817mr32343f8f.42.1761839275608;
        Thu, 30 Oct 2025 08:47:55 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:55 -0700 (PDT)
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
Subject: [PATCH 3/5] ACPI: EC: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 16:47:37 +0100
Message-ID: <20251030154739.262582-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030154739.262582-1-marco.crivellari@suse.com>
References: <20251030154739.262582-1-marco.crivellari@suse.com>
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
 drivers/acpi/ec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7855bbf752b1..59b3d50ff01e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2294,7 +2294,8 @@ static int acpi_ec_init_workqueues(void)
 		ec_wq = alloc_ordered_workqueue("kec", 0);
 
 	if (!ec_query_wq)
-		ec_query_wq = alloc_workqueue("kec_query", 0, ec_max_queries);
+		ec_query_wq = alloc_workqueue("kec_query", WQ_PERCPU,
+					      ec_max_queries);
 
 	if (!ec_wq || !ec_query_wq) {
 		acpi_ec_destroy_workqueues();
-- 
2.51.0


