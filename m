Return-Path: <linux-kernel+bounces-629543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D1AA6DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555583AA878
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA822F164;
	Fri,  2 May 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b="w84ioxnZ"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF01E883A
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177682; cv=none; b=dYK6WY3Qm+SeakaYJ/7Bp8R3Z32/GKGoFBh7HXoQKIzsD2b+d2aShfrOoEoZqS5QBbansVGUDf4ANvn08E+chkB8n8NN8pb8jjvReqHCulLLdNpB0oYVxzuxwGQknyEDSOZXoQ8pL7fW1MYEZKkz09vO4G1XwfLY//ivbMUah0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177682; c=relaxed/simple;
	bh=z41DDBbJl4TIvbOFCLPOvC2bUtA8XyTHiBwdchWGrpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOFUpb1VaPKdXJ72Sced+pOA+TPYb8FuBeWeQGkfZ2/WRcc9N8ZIhhErhT3EZd7zrS72zroBk+ZSRLXADf7lfOs5wes7ZFQt/rRe0xIKvs+cn2k+7E0fop0f/5RY5ZdbZxi/gJN4xKX1vsNjHyeJakETCy70IsDZOV1DBqhkUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com; spf=none smtp.mailfrom=immunant.com; dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b=w84ioxnZ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=immunant.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e732386e4b7so1719855276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immunant-com.20230601.gappssmtp.com; s=20230601; t=1746177678; x=1746782478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyHCon4vU91wPH4dyinNdOyq5hW82Gz0ZN1lgTbU0wg=;
        b=w84ioxnZ5Z3LX1m0K6csiO9s/Ljcc7kswR/yXpwhua1hikMzvhha3JjGf9XUGtEPq4
         iJojjnnAOvY9fERDJGmmTHcy+gN5CpI8Y5vsEs5Xgh9y9gf44ZX6cVPbXL64sgLD+DYc
         p61xr4F0S89b/NWineMq81M8hxC7VVRc7CEbmJXxhbio0bfqDxX7c/L6+XL84p93gqvp
         uAOKQaFKqXwDJeQvtxo/hkE5CEiqfs5b9U7E4Apmmoncqj5NfTHLOgGcs3ljXD9zAlmC
         rSg2vvGO4k1t7ks0H0E7ZkOYPU8HVNPczghbhX2mmy6CxUBn1kxkg+JljAjcuHc1u8TA
         jAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746177678; x=1746782478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyHCon4vU91wPH4dyinNdOyq5hW82Gz0ZN1lgTbU0wg=;
        b=c/WJncqEjuRAyJfiz2A0DaTRexdzTZ4PDhYLpxeHEtTZasVbMvx21ORQrrZg5cta3h
         C8vLSTTZFlp5acah2a2OspGYbA6HaW92H6CNExLL3p4ySpKcI/xs69tJ26diyu+/89qz
         v7iaarwtI2lz6T3Hp90TRv3WYEqu3sqArpPJ23EY6UjExOtVOxFwSzjb3JZF3gi778yD
         YT67tM2QBdEDP2G41KeV4pUtzxnXRlKxpJOEDvk580MBk+vmB30UlyDT9CMNBLv+dxlZ
         GUlcPDU8CxUCUS83rh7gIOXgqNN9zfCHeZEu057IAJbO3fRnKqle6Ar06rJkDVfmW9rR
         k5ng==
X-Gm-Message-State: AOJu0YydYUpvspRN73UfdFjDMojQ/hbjFtCc2g+AHEezrD0Yqdhxwx6d
	UAjd5z42i8FaqjuXoE1sf19aR6Dw0lwex6RN660m+GUzoTmYjp4gP4MJ/S6LsM4Ak8QKU2QQGZN
	6vu0=
X-Gm-Gg: ASbGnctc5wt64e+tMjglM7VmnH6aIdOpsmfAuO4EATGRBTc6u35XUMyntnaMOJGXvpy
	e3e2RUFp0MajcuqwNpqKIdPnarCQ/SeifW7LpeZPfHxe/WTkU5pwjpja0eaPRgeMV/jfnArSUhI
	GpcK6qrZsknJXo0RSJmMeLvSLiRY8R6JXsGhKsZYob/rCSAnnbRIwcTu9uTCOkqoHXwMUSmxWPr
	rJ4WtDM51b261Ca6DFnfMxtM6eLNKk9kjfrn7UVn8lejwt5xrggva0zYF26xqT3Mmbm50Dp/mGn
	nKBZjapu9gy0ALIHun/EGEf/iM7mq6YaW0adaArEBA==
X-Google-Smtp-Source: AGHT+IGp+ETgvJSd9lvf2Hm0u8cGNqnSHJMy0WS2lG3WhWOOaG2gaDXYIeZ4OWRo041mgp+lOQesMg==
X-Received: by 2002:a05:6902:1885:b0:e72:a584:bea0 with SMTP id 3f1490d57ef6-e756556fef7mr2617975276.21.1746177678568;
        Fri, 02 May 2025 02:21:18 -0700 (PDT)
Received: from donna.immunant.com ([12.9.190.3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e755e7d92d0sm556427276.55.2025.05.02.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:21:18 -0700 (PDT)
From: Per Larsen <perl@immunant.com>
To: linux-kernel@vger.kernel.org
Cc: sebastianene@google.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	jean-philippe@linaro.org,
	kernel-team@android.com,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	lpieralisi@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	qperret@google.com,
	qwandor@google.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tabba@google.com,
	will@kernel.org,
	yuzenghui@huawei.com,
	armellel@google.com,
	arve@android.com,
	ahomescu@google.com,
	Per Larsen <perlarsen@google.com>,
	Per Larsen <perl@immunant.com>
Subject: [PATCH 3/3] KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ2 in host handler
Date: Fri,  2 May 2025 02:21:08 -0700
Message-ID: <20250502092108.3224341-4-perl@immunant.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502092108.3224341-1-perl@immunant.com>
References: <20250502092108.3224341-1-perl@immunant.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Per Larsen <perlarsen@google.com>

FF-A 1.2 adds the DIRECT_REQ2 messaging interface which is similar to
the existing FFA_MSG_SEND_DIRECT_{REQ,RESP} functions except that it
uses the SMC calling convention v1.2 which allows calls to use x4-x17 as
argument and return registers. Add support for FFA_MSG_SEND_DIRECT_REQ2
in the host ffa handler.

Signed-off-by: Per Larsen <perlarsen@google.com>
Signed-off-by: Per Larsen <perl@immunant.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 111 +++++++++++++++++++++++++++++++++-
 include/linux/arm_ffa.h       |   2 +
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 8102dd6a19f7..d8c066f3c5c9 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -79,6 +79,14 @@ static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 	};
 }
 
+static void ffa_to_smccc_1_2_error(struct arm_smccc_1_2_regs *regs, u64 ffa_errno)
+{
+	*regs = (struct arm_smccc_1_2_regs) {
+		.a0	= FFA_ERROR,
+		.a2	= ffa_errno,
+	};
+}
+
 static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
 {
 	if (ret == FFA_RET_SUCCESS) {
@@ -89,11 +97,26 @@ static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
 	}
 }
 
+static void ffa_to_smccc_1_2_regs_prop(struct arm_smccc_1_2_regs *regs, int ret, u64 prop)
+{
+	if (ret == FFA_RET_SUCCESS) {
+		*regs = (struct arm_smccc_1_2_regs) { .a0 = FFA_SUCCESS,
+						.a2 = prop };
+	} else {
+		ffa_to_smccc_1_2_error(regs, ret);
+	}
+}
+
 static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
 {
 	ffa_to_smccc_res_prop(res, ret, 0);
 }
 
+static void ffa_to_smccc_1_2_regs(struct arm_smccc_1_2_regs *regs, int ret)
+{
+	ffa_to_smccc_1_2_regs_prop(regs, ret, 0);
+}
+
 static void ffa_set_retval(u64 func_id,
 			   struct kvm_cpu_context *ctxt,
 			   struct arm_smccc_res *res)
@@ -127,6 +150,29 @@ static void ffa_set_retval(u64 func_id,
 	}
 }
 
+static void ffa_set_retval_smccc_1_2(struct kvm_cpu_context *ctxt,
+			   struct arm_smccc_1_2_regs *regs)
+{
+	cpu_reg(ctxt, 0) = regs->a0;
+	cpu_reg(ctxt, 1) = regs->a1;
+	cpu_reg(ctxt, 2) = regs->a2;
+	cpu_reg(ctxt, 3) = regs->a3;
+	cpu_reg(ctxt, 4) = regs->a4;
+	cpu_reg(ctxt, 5) = regs->a5;
+	cpu_reg(ctxt, 6) = regs->a6;
+	cpu_reg(ctxt, 7) = regs->a7;
+	cpu_reg(ctxt, 8) = regs->a8;
+	cpu_reg(ctxt, 9) = regs->a9;
+	cpu_reg(ctxt, 10) = regs->a10;
+	cpu_reg(ctxt, 11) = regs->a11;
+	cpu_reg(ctxt, 12) = regs->a12;
+	cpu_reg(ctxt, 13) = regs->a13;
+	cpu_reg(ctxt, 14) = regs->a14;
+	cpu_reg(ctxt, 15) = regs->a15;
+	cpu_reg(ctxt, 16) = regs->a16;
+	cpu_reg(ctxt, 17) = regs->a17;
+}
+
 /* Call SMC64 using SMCCC 1.2 if hyp negotiated FF-A 1.2 falling back to 1.1 */
 static void arm_smccc_1_2_smc_fallback(u64 func_id, u64 a1, u64 a2, u64 a3,
 				       u64 a4, u64 a5, u64 a6, u64 a7,
@@ -681,7 +727,6 @@ static bool ffa_call_supported(u64 func_id)
 	case FFA_NOTIFICATION_GET:
 	case FFA_NOTIFICATION_INFO_GET:
 	/* Unimplemented interfaces added in FF-A 1.2 */
-	case FFA_MSG_SEND_DIRECT_REQ2:
 
 	/*
 	 * FFA_MSG_SEND_DIRECT_RESP2 is not meant to be invoked by the host or
@@ -709,6 +754,20 @@ static bool ffa_call_supported(u64 func_id)
 	return true;
 }
 
+/*
+ * Must a given FFA function use the SMC calling convention v1.2?
+ */
+static bool ffa_call_needs_smccc_1_2(u64 func_id)
+{
+	switch (func_id) {
+	case FFA_MSG_SEND_DIRECT_REQ2:
+	case FFA_MSG_SEND_DIRECT_RESP2:
+		return true;
+	}
+
+	return false;
+}
+
 static bool do_ffa_features(struct arm_smccc_res *res,
 			    struct kvm_cpu_context *ctxt)
 {
@@ -882,9 +941,47 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 	hyp_spin_unlock(&host_buffers.lock);
 }
 
+static void do_ffa_direct_msg2(struct arm_smccc_1_2_regs *regs,
+			      struct kvm_cpu_context *ctxt,
+			      u64 vm_handle)
+{
+	DECLARE_REG(u32, func_id, ctxt, 0);
+	DECLARE_REG(u32, endp, ctxt, 1);
+	DECLARE_REG(u64, uuid_lo, ctxt, 2);
+	DECLARE_REG(u64, uuid_hi, ctxt, 3);
+	DECLARE_REG(u64, x4, ctxt, 4);
+	DECLARE_REG(u64, x5, ctxt, 5);
+	DECLARE_REG(u64, x6, ctxt, 6);
+	DECLARE_REG(u64, x7, ctxt, 7);
+	DECLARE_REG(u64, x8, ctxt, 8);
+	DECLARE_REG(u64, x9, ctxt, 9);
+	DECLARE_REG(u64, x10, ctxt, 10);
+	DECLARE_REG(u64, x11, ctxt, 11);
+	DECLARE_REG(u64, x12, ctxt, 12);
+	DECLARE_REG(u64, x13, ctxt, 13);
+	DECLARE_REG(u64, x14, ctxt, 14);
+	DECLARE_REG(u64, x15, ctxt, 15);
+	DECLARE_REG(u64, x16, ctxt, 16);
+	DECLARE_REG(u64, x17, ctxt, 17);
+
+	if (FIELD_GET(FFA_SRC_ENDPOINT_MASK, endp) != vm_handle) {
+		ffa_to_smccc_1_2_regs(regs, FFA_RET_INVALID_PARAMETERS);
+		return;
+	}
+
+	struct arm_smccc_1_2_regs args = {
+		func_id, endp, uuid_lo, uuid_hi,
+		 x4,  x5,  x6,  x7,  x8,  x9, x10,
+		x11, x12, x13, x14, x15, x16, x17
+	};
+
+	arm_smccc_1_2_smc(&args, regs);
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
 	struct arm_smccc_res res;
+	struct arm_smccc_1_2_regs regs;
 
 	/*
 	 * There's no way we can tell what a non-standard SMC call might
@@ -940,14 +1037,24 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_PARTITION_INFO_GET:
 		do_ffa_part_get(&res, host_ctxt);
 		goto out_handled;
+	case FFA_MSG_SEND_DIRECT_REQ2:
+		if (hyp_ffa_version >= FFA_VERSION_1_2) {
+			do_ffa_direct_msg2(&regs, host_ctxt, HOST_FFA_ID);
+			goto out_handled;
+		}
+		goto out_not_supported;
 	}
 
 	if (ffa_call_supported(func_id))
 		return false; /* Pass through */
 
+out_not_supported:
 	ffa_to_smccc_error(&res, FFA_RET_NOT_SUPPORTED);
 out_handled:
-	ffa_set_retval(func_id, host_ctxt, &res);
+	if (ffa_call_needs_smccc_1_2(func_id))
+		ffa_set_retval_smccc_1_2(host_ctxt, &regs);
+	else
+		ffa_set_retval(func_id, host_ctxt, &res);
 	return true;
 }
 
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 5bded24dc24f..4d541cf12ceb 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -268,6 +268,8 @@ bool ffa_partition_check_property(struct ffa_device *dev, u32 property)
 	(ffa_partition_check_property(dev, FFA_PARTITION_DIRECT_REQ2_RECV) && \
 	 !dev->mode_32bit)
 
+#define FFA_SRC_ENDPOINT_MASK	GENMASK(31, 16)
+
 /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registers */
 struct ffa_send_direct_data {
 	unsigned long data0; /* w3/x3 */
-- 
2.49.0


