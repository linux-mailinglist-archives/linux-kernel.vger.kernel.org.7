Return-Path: <linux-kernel+bounces-772966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6FB299E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD72F1B208EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB9275B1C;
	Mon, 18 Aug 2025 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="etvIdd9h"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F08275B18
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499250; cv=none; b=aveudlbLoII26i+DHHrJrFdR+9dXqZBt84QHsNivp5RlYMHxpoaP2diF4+4aC753L1z87vyYpb4liNo1lNAY68mNWdKfGinNtc43uFWHUVxfBamUbI/vvJVuHwVRaI5A7SZDTYVLUTWO3RduDc09gQMePXFN0iJ8/cpgH6+QoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499250; c=relaxed/simple;
	bh=PqVtQltJJVPFzvDdM8xIl1JmjsoZKNqJCBf6AORsL0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXwkTWiLACupR7F9xmWwIgPXf6PzRBw5IKG0JwTFrNacksqzaLIRPXAYDzOObMAtkgpgcyD5e2PJjZJ5kjyjXMAeh7FBP3Axm4ML/hamp/+hLRLiy/+2OVLoTCXPSLonxliI/Nr7VktCmOmWxPQsiNAZ152iBxQp+2kFmWDcImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=etvIdd9h; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IP
	n1FN8sp4GGoUD3tpDW+Holf9bFEHra2JNM2nDhbAg=; b=etvIdd9hPkOSpqQObc
	R+rOFpoKSwuSj4KoCtweaiA89dHvrr89OvXFoXy/4cmqK2S4mlxIffSmwB/Vr9zN
	oUJkSPgIwdV28qzpQD8OGjPUZCqZWFk0xn/ttKhXJj9sqgeOS37E/J578YwH8d26
	R/uCzRdlrmVfuttG9l3X1tM/0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3v_qxyqJoi5PoBg--.55496S2;
	Mon, 18 Aug 2025 14:39:46 +0800 (CST)
From: lingfuyi@126.com
To: maz@kernel.org,
	oliver.upton@linux.dev
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lingfuyi <lingfuyi@kylinos.cn>
Subject: [PATCH] KVM: arm64: Fix whitespace inconsistency in cpu_reg assignments
Date: Mon, 18 Aug 2025 06:39:42 +0000
Message-Id: <20250818063942.1900014-1-lingfuyi@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD3v_qxyqJoi5PoBg--.55496S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4UGrWUWry7uFW3ur48Zwb_yoW8ZF4fp3
	y7tr1jyw48GF1DuayI9a1DX3y8GrZ5tr95Aa98AwnYyryYqwn5Gw4kGayY9rW3AFWxZa4S
	vF1UtF13WayUAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc18QUUUUU=
X-CM-SenderInfo: polqwwxx1lqiyswou0bp/1tbiYBytR2iivT-o3AAAsq

From: lingfuyi <lingfuyi@kylinos.cn>

Several cpu_reg() assignments had inconsistent spacing around the '='
operator. Some lines had double spaces while others used single space.
Standardize to single space for better code consistency.

This is a pure formatting fix with no functional changes.

Signed-off-by: lingfuyi <lingfuyi@kylinos.cn>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3206b2c07f82..cfe7a82730a7 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -232,7 +232,7 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 		fpsimd_lazy_switch_to_host(vcpu);
 	}
 out:
-	cpu_reg(host_ctxt, 1) =  ret;
+	cpu_reg(host_ctxt, 1) = ret;
 }
 
 static int pkvm_refill_memcache(struct pkvm_hyp_vcpu *hyp_vcpu)
@@ -266,7 +266,7 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
 
 	ret = __pkvm_host_share_guest(pfn, gfn, nr_pages, hyp_vcpu, prot);
 out:
-	cpu_reg(host_ctxt, 1) =  ret;
+	cpu_reg(host_ctxt, 1) = ret;
 }
 
 static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
@@ -287,7 +287,7 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
 	ret = __pkvm_host_unshare_guest(gfn, nr_pages, hyp_vm);
 	put_pkvm_hyp_vm(hyp_vm);
 out:
-	cpu_reg(host_ctxt, 1) =  ret;
+	cpu_reg(host_ctxt, 1) = ret;
 }
 
 static void handle___pkvm_host_relax_perms_guest(struct kvm_cpu_context *host_ctxt)
@@ -367,7 +367,7 @@ static void handle___pkvm_host_mkyoung_guest(struct kvm_cpu_context *host_ctxt)
 
 	ret = __pkvm_host_mkyoung_guest(gfn, hyp_vcpu);
 out:
-	cpu_reg(host_ctxt, 1) =  ret;
+	cpu_reg(host_ctxt, 1) = ret;
 }
 
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
-- 
2.34.1


