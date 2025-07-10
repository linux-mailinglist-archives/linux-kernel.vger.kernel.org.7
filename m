Return-Path: <linux-kernel+bounces-725495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21AAFFFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019325C04A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84252E5413;
	Thu, 10 Jul 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="JCU4Sy9D"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB9248F55
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145220; cv=pass; b=PyDh5rNfLnl7jqX5DIEjqjmSTSdmIrUXKOsxeSnzqFmvJ7L/RaQdwb+fVEOobAYXewhN94vglf/pzh4XDKlIAeNbXbsZGtCh+4b7Wy1wlQ9DYATv01z4RoBtTaSWj8/63w0T37HZNrgfbFol/F+4oUkVb5qsGimpdgZeco/W/kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145220; c=relaxed/simple;
	bh=Wdc1SEXegXKG2z3+7sNJXlp7oo3GeKiNUFMXNK3IZQ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7GHK1Kt+JGNQ4TnKnT14z3gnrJ7+dqCKaxXKBtXJUOz4TITe2MfhagH9OWtw5BXGNIACbB3Zcn7YumQkse6jGZqfOig9lT5zh0QPDEj2iTTgyFF6HiQpyJbE3+FDZvRQRQPnTRdrpo2yxKjUCrve7smuPmpZFBF0pm/oF4FDs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=JCU4Sy9D; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1752145062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IUVdpZ9hJlQnyjnuEuXoRWDNPy7og9UfQy9yMPlxBefnMQZMT5FVbrkJqb5jh2+/wxbKMLGdqRvJtSoV8nq+rg7L4gysjsDPPeYV+HeEZLeDQr96VyCGu2j6TbHsd+CjBC44pNdue4dfmea4lfWgsybNeAdEzeWPyZbK7R9P2D4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752145062; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=bnYRiqvlzbdb50scC/9nYEdxihLR0vRbahpOwqmwAmw=; 
	b=hGNbrGXKuiI1r549JBlUeQinfqKo87IpeG92tJOjJKy3v/+b7E7NfERftvpk84z3lJ9qTEajKXgYkBJvoIFakrpv2Tq/snjdyPd/7X/+EhbyE+3cvEE0SPqnqCDiYIOfB7PDRejxQpElHrLWQ5U621YpckZRT5jYL3VjBpxrtCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752145062;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=bnYRiqvlzbdb50scC/9nYEdxihLR0vRbahpOwqmwAmw=;
	b=JCU4Sy9DTtWc+SK+0I3Mu7t8c0ibWGc61ork+bLDnjd5nG7DyZTbwwUaSoj/W/Yq
	Q87MzQ18oUJFFHlPDQHaxfGCClmdMKSOrmxfoJ2ZOegePXSl7UDomAquy66Eruogkkw
	g91yM2OiYujpA7dYaTPSIS3vNMvq0Y8Etay402Wo=
Received: by mx.zohomail.com with SMTPS id 1752145059913404.6420273722525;
	Thu, 10 Jul 2025 03:57:39 -0700 (PDT)
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
Subject: [PATCH v5 3/4] x86/smpboot: moves x86_topology to static initialize and truncate
Date: Thu, 10 Jul 2025 18:57:09 +0800
Message-ID: <20250710105715.66594-4-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710105715.66594-1-me@linux.beauty>
References: <20250710105715.66594-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

The #ifdeffery and the initializers in build_sched_topology() are just
disgusting.

Statically initialize the domain levels in the topology array and let
build_sched_topology() invalidate the package domain level when NUMA in
package is available.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/smpboot.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3d0f5737a157c..309338033356f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -478,32 +478,30 @@ static int x86_cluster_flags(void)
  */
 static bool x86_has_numa_in_package;
 
-static struct sched_domain_topology_level x86_topology[6];
-
-static void __init build_sched_topology(void)
-{
-	int i = 0;
-
-	x86_topology[i++] = SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT);
+static struct sched_domain_topology_level x86_topology[] = {
+	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
-	x86_topology[i++] = SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS);
+	SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS),
 #endif
 #ifdef CONFIG_SCHED_MC
-	x86_topology[i++] = SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC);
+	SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC),
 #endif
-	/*
-	 * When there is NUMA topology inside the package skip the PKG domain
-	 * since the NUMA domains will auto-magically create the right spanning
-	 * domains based on the SLIT.
-	 */
-	if (!x86_has_numa_in_package)
-		x86_topology[i++] = SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG);
+	SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG),
+	{ NULL },
+};
 
+static void __init build_sched_topology(void)
+{
 	/*
-	 * There must be one trailing NULL entry left.
+	 * When there is NUMA topology inside the package invalidate the
+	 * PKG domain since the NUMA domains will auto-magically create the
+	 * right spanning domains based on the SLIT.
 	 */
-	BUG_ON(i >= ARRAY_SIZE(x86_topology) - 1);
+	if (x86_has_numa_in_package) {
+		unsigned int pkgdom = ARRAY_SIZE(x86_topology) - 2;
 
+		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));
+	}
 	set_sched_topology(x86_topology);
 }
 
-- 
2.50.0


