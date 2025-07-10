Return-Path: <linux-kernel+bounces-725503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B8B00000
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43A83BD4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5082877C1;
	Thu, 10 Jul 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="PLiFXUxI"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038B13A3F7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145250; cv=pass; b=kYau+qyixRdmi4O+7g4YUwuHqMqAWtHZxNoh97pA+yHjZJqCQlgol81hhfGmIrm62KBkd0YbD2Tc9GOOgdauB72jCZSzsIaZX6oCSsf5Hj6jVE8np6hSP/i5pgPCwnekHT9BIyx598BCer005iDMj6cywN3CSxWEJZlhbcxxaP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145250; c=relaxed/simple;
	bh=WeJ7nLzzYX9w/yXG8eF7UcGkqRCD7wVgaxfg/gkT5zE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdjqnnJTpgx3EF5Ub0mHpfowbUkK98VjSscq1NScx6mq3FVOPmWS8SczTAr/HOiJ1fEdFe0sR66go/eQjSd4lVIP6fWbB4jKt/oZq28WjmifGtxlw0Y9pISACAIHhF9YKhjYcncXRz0hYhQTJXT/87yDWTtlE5L4zO5JtmYXQko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=PLiFXUxI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1752145067; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QPniWKImVzzTqJqASSXiLsuByMr6be2w0+B5LKqAWz2oMHrDeD6cAna/A1jDPc9oqbb8xA14dk2oCVjKQhZoNJ22sQVflPpApKU0RY00cJaRTar0/xH7sbaYqTKJTe0uUIOP5uVnVJZn62sMjhmuHz3yZLI730qWt/4Di/w7oUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752145067; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JZAqLf5C1ufJQ4vDDRf1XK8WtbRAUiR0MUD2YR45ZZI=; 
	b=XmByn/FiP58Rczl0MjAu8DspQCU30YgfjHt74KXFLDeL44muhTG1RA4QpYRg/EvGaTzfGk4Va3SKEYsqxDwrcjcqYTGry1KrJnsLgmtptOGIiMAV6L3PO2kvvv/3Nfx+xxj12zvpDV8aaVabCD8G87OmA0J/EYYlsV9FNXl6YAk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752145067;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JZAqLf5C1ufJQ4vDDRf1XK8WtbRAUiR0MUD2YR45ZZI=;
	b=PLiFXUxIhsfPrYY818SXcWjW06MyOFXq4Myf/5krDcnlzHTkxCge+eNbMhbGS//z
	ITI/q+v8YqLzeJnssSmGsp+GOXq3C8rstnCwaejdGITircGuE41ojAhhbrdM9Wfn8qn
	qGUJjmOaotf7nSnN1Abj5SszZC5GJO1Vtx7Zr7yM=
Received: by mx.zohomail.com with SMTPS id 1752145063904192.72775722438178;
	Thu, 10 Jul 2025 03:57:43 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Sohil Mehta" <sohil.mehta@intel.com>,
	"Brian Gerst" <brgerst@gmail.com>,
	"Patryk Wlazlyn" <patryk.wlazlyn@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Li Chen <chenl311@chinatelecom.cn>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v5 4/4] x86/smpboot: avoid SMT domain attach/destroy if SMT is not enabled
Date: Thu, 10 Jul 2025 18:57:10 +0800
Message-ID: <20250710105715.66594-5-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710105715.66594-1-me@linux.beauty>
References: <20250710105715.66594-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Currently, the SMT domain is added into sched_domain_topology by default.

If cpu_attach_domain() finds that the CPU SMT domain’s cpumask_weight
is just 1, it will destroy it.

On a large machine, such as one with 512 cores, this results in
512 redundant domain attach/destroy operations.

Avoid these unnecessary operations by simply checking
cpu_smt_num_threads and skip SMT domain if the SMT domain is not
enabled.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 arch/x86/kernel/smpboot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 309338033356f..33e166f6ab122 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -492,6 +492,8 @@ static struct sched_domain_topology_level x86_topology[] = {
 
 static void __init build_sched_topology(void)
 {
+	struct sched_domain_topology_level *topology = x86_topology;
+
 	/*
 	 * When there is NUMA topology inside the package invalidate the
 	 * PKG domain since the NUMA domains will auto-magically create the
@@ -502,7 +504,15 @@ static void __init build_sched_topology(void)
 
 		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));
 	}
-	set_sched_topology(x86_topology);
+
+	/*
+	 * Drop the SMT domains if there is only one thread per-core
+	 * since it'll get degenerated by the scheduler anyways.
+	 */
+	if (cpu_smt_num_threads <= 1)
+		++topology;
+
+	set_sched_topology(topology);
 }
 
 void set_cpu_sibling_map(int cpu)
-- 
2.50.0


