Return-Path: <linux-kernel+bounces-725493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D09AFFFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9417E5A6532
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AA2E54DC;
	Thu, 10 Jul 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="B7qr5mHF"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A52E11B6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145192; cv=pass; b=P0FpYszh8hPB8NuIM5ir8+hRj1qtI/V7Gtr/SeBpqHb3JFugWdmYOG5/GDTIyXB+TI2dMz8efYoCuI9rPpbKKxo48lEDEpldXcI4w2Ttf4DS/ETafV8tM+aQUE8NVdulyOv+Vg8tsGm6dmZLJSSUkPYMVoncd8zOLlkg0ZEZ7UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145192; c=relaxed/simple;
	bh=h9EYkzHtNDOmnM18XSlhyO9ckZKRO1SqUT9iLmhZXGA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNIZqziIq/xzp8UBInQ4yrOJUyTGfTL5FIxizp+p+Bj9pCmWOZ+7vC1QyQxu0aO6evKXe9SQ+qa7inJVBNXrgulR05vNzXPycAeVBiNVg3161i4fa7Ut8//0/PhfhGNaI9zigvWQfubBtN6UlA2tjsrS7l3fkJ+G4aO+qAkEjIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=B7qr5mHF; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1752145058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pe69LzQ5w8UObvZprD+M5gR47LBZFzJn5y5GRKG6wCTmjds22EKZIIakdZWOLF8XZ29GyJtH00LnTrWntBbezBKdw2gA7xOwV1A7r83OX4ICcm5DFOUt6FLieYSFwVHN9GfMvHEmp2Ab1LX7S0YR+N/DlTifz6q8cqP1TcwReFo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752145058; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=amHXm20+VUY9kF5uInegJd53eq5CHYGSBoZSobGAG/U=; 
	b=F7snErw9kya9RwLueLjPQcEeTWAgjncywHZFBYZFnrzFWrXKftb55jn6sePqkByZj+d9Y4TGPIeOtApkQgAjRVlJhlO7r/5pwlJLfd1oNpeotQi086dRwxeSI7nDL8UCwXb3FI1qcq+0qGqy41rY/F4eDbysGn45WNVytOwUnjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752145058;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=amHXm20+VUY9kF5uInegJd53eq5CHYGSBoZSobGAG/U=;
	b=B7qr5mHFqEqvciDZsEpaq8pcs1xZFF0tj9AnyoD8SlEzemVtTEhdCG6htM6uKEvp
	oX5Ka7i3tj91LwXVItBUxtysDx/tpR1hzeZkqSaTXawT8DnGDfzFLLVM8VaO+NwauG0
	NQn3YoyluV2WaXtl1b0rOSp2cuK+TIJNaWOTZ5vs=
Received: by mx.zohomail.com with SMTPS id 1752145055823336.76079326442857;
	Thu, 10 Jul 2025 03:57:35 -0700 (PDT)
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
Subject: [PATCH v5 2/4] x86/smpboot: remove redundant CONFIG_SCHED_SMT
Date: Thu, 10 Jul 2025 18:57:08 +0800
Message-ID: <20250710105715.66594-3-me@linux.beauty>
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

CONFIG_SCHED_SMT is default y if SMP is enabled,
so let's simply drop CONFIG_SCHED_SMT.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/smpboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 445127df2cb19..3d0f5737a157c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -484,9 +484,7 @@ static void __init build_sched_topology(void)
 {
 	int i = 0;
 
-#ifdef CONFIG_SCHED_SMT
 	x86_topology[i++] = SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT);
-#endif
 #ifdef CONFIG_SCHED_CLUSTER
 	x86_topology[i++] = SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS);
 #endif
-- 
2.50.0


