Return-Path: <linux-kernel+bounces-852920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1066DBDA38A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A2356399
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784A301022;
	Tue, 14 Oct 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCqU7POk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE93009F7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454298; cv=none; b=B/CKlg/SE9OUdOUl66RXziZHlrbfP389gFoiwojz4ZF3Ax3nO+oBdZudKTQSiHIwdKf0l3fAsnhQXmXeTRTtKvWvKvJlQOWoG3toodKl7B1KnrcKwS/6EWh2ehKKUijfhpCPRlaij18i9Ie64imLoqfu9OpkYcc4/Z6c+KFd4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454298; c=relaxed/simple;
	bh=LUTF42ROOv9lWR+4KsOLqtJZDON2mQ0ehFAdOL90kEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ti3NIfbVpRNroWhAfSPqnCnnUvlfH6yYuGVNzPQiyIEesrgkjN/fNO3mP5ZK04yTE5GmPeyi7iIFivw0LpbQ57lAiLj7ajNujDulXLmyXNykr14vM2zHv6m99llyfqa27oGlboIN4omYACNUXh4rC1fU2uBGAFtst9tTD16cmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCqU7POk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so5347539a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454295; x=1761059095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW/u6QKovqkYoXjfaaQ4q+qjIiyLs7/vzeRi0yEodtg=;
        b=MCqU7POkIth5pqk25ZI4nqhGiqVXWA7kcRQ8W0hsN4znygvnlVZ5heUPt2/+Adm91b
         PWE7mkHUNTVJ3ZJhkGhcay9bVqhL0c1IDvKZyJi7OLQDPFmjSZns5+ZKmwX5wk6lzhN+
         cNZgM4IxnM4WORRHuineYiR9qDJaiG4t06Wzuh5dxG2mBPknxQ6gFrX9ad3FlVa6lAD/
         Az3qT6hVRKKP4RsCECM/EGrkl2Aoq6qUoRRj1kw//IuziMYauyQ0eJfBaAc2LBh61Kpl
         Hxmmz3ofU+8KOS0o0iZSKLIXXDh4oS0SN2cb7F4KgN3TsdyVvSlHUN0mJH0ExMK8QuS/
         wNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454295; x=1761059095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/u6QKovqkYoXjfaaQ4q+qjIiyLs7/vzeRi0yEodtg=;
        b=K33rgxrHuXAeLurfEXsi74K9w4nAyWDcYDDXj+W2AJ70CmMvMRgkDKoX4m/ziXWTqC
         OeF1q3cuzBxORk07exLrIapotcbVC8xZLwFTqKezOVcEVq1A7njO6ITxDBAiewP9XTd1
         7QmAW61GTRaM8HYxW8ZNf/Ff8cu5K6mTfjccnr4Oqwd5V5wF1yTDGFEE0ujOKLa7Ao1p
         PkyEr1F3Dv9BFMrhloJBrQ1uaS37FnTBNR7XOQJGTC6UanRoBFGMLSFZswUaFDdaWi54
         xdjoeqU8ZXD+M28/w0tSz2a6iUcU7b1FdGXJ/J30cFipm/+7uK1PAZLemKvcM6WcZKJq
         14BA==
X-Forwarded-Encrypted: i=1; AJvYcCVKad/L/sa6LxnprHuVZvXzsm7yfBEogcaEOi2hVD+ItV4JQn6EihsLhNQXvtvzCGjzpYlfUp8fHebtJrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03HeT62ZTfOh+7yBW4mM8eylPz/g+8aLPHq2kjjXBbgJm85Ar
	qmvxX+PLovMNVDs+fPKZoJ43c60O2MO9cfdT6xc1/5NIy4EUUcvsUNy4
X-Gm-Gg: ASbGncveNqr9/ctdIT2mNMA8m4UKqmbE9FYUEXHzUiLOXMpRZlXOWVMaGPU0xLS2NA6
	pWxS2h2KhYGq6Y9MH7qsZ8iVd7mVzTdCNhYdEtlOn1S14V8WYt+VZENDmVEaoG1qKx/bvMNq8oN
	NxIeKF+fMONCn7NcDeOcZxH7vc/n+wcO95vitJyjytlUleiLXYY9l6K6Wsa5PrVrriCppJWGjc2
	om6o99NwIV4A8N0SxeGAOmTVYTehDpYIOlWWQIFLfIbP9b7YDWk+LxbdAJjxgM9wtzzbmj9DYf6
	wu/h3w8JJSRRik5hHGzdjiDba1ZGgkmc9D8hYIyac2LVOCf6L/Qn5zB0ntEp0bRoH9eiUd7uSCm
	soYUHSyfwvXEAnyPCJUpWSSd1P2otiqG/Mi79KB+kVTuYIGSoB9Uq5g==
X-Google-Smtp-Source: AGHT+IGWEYfz6S7fBW8hYoBfI6lrDbXyJBW7+t8uQ+PjryqFALRTMaYLRekN7tr5rlO7RGXjszMx0g==
X-Received: by 2002:a17:90b:17c2:b0:327:734a:ae7a with SMTP id 98e67ed59e1d1-33b5114ac35mr38359206a91.11.1760454294937;
        Tue, 14 Oct 2025 08:04:54 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:43 +0800
Subject: [PATCH RESEND v8 10/21] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-10-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6996; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=LUTF42ROOv9lWR+4KsOLqtJZDON2mQ0ehFAdOL90kEI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZtec0PQOYZIGiMTtpefUJyY3aDExejo7wKe
 M0ogNW4vKKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbQAKCRABygi3psUI
 JFenD/9yz/diCSxayNLMe2twXM9qZ21WmlERVHszhj72MD3z5IsUSKkKdc8zEp4smMU/c1o64HE
 2Suh+l17Xx6+QzywU3a4kcA7Dw0r3OeQkiBMDFsjIa/51tUkrBBzGT5tEi8KuqPIzu1z/HsaL+1
 RP5GJSD5tH+fNC2IcXw+6YvEi8L6JawK0nbfnZB0c+tLYjEWGqwJJ3hNgUdgBkWzJoNAxyeiDp2
 yJKPaHvjOAzAFXKA8xZ9mJNCc6NVmfNrBrT5yLtpJcLLUuUYAEgazvdP+9o7hXa1Jz4eSVQ0JE/
 Eun6hWVWIAODbXQiwyT8hlYuW00xCw1yavep35bURjjS9QPc7MNklls4F2A4vqoYQN6N8gyrhbk
 0xiTB8gBYLtUya2LMtqRoLzzUgcTPG1ns80/g1pdIt7DaHFVqPa1XHE2dRTwba8YbsCKB5jQc2x
 9kjUaQlzmv1ZdGCVdRswcEsdB+aU8BsUs62cV2mQgu9K0qXsgAOHPpZ10kgixb5u43hWGnSxrIe
 hsLnHnZE5S2FxKVqWE7Xgnof6EYKFX+bQORWTjUkI7ir9DYJW5luhWb6rXuVTLP/6RZKIrMrTPY
 a1szlmkWAg/kQfLZ4VB63o7nD7nTxDZK0y3My4QxVu74FEI68dBanZ0TrJyeBP5b3t88m9tYjlS
 0/L5Tug+76MBAiw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 121 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index a95f4b717857b30284470487827954dd4b139010..bfaf926fd47b02a7d77ac31cbb97779b5ebedec4 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -289,6 +289,109 @@ static const u16 a8_pmu_event_affinity[A8_PMU_PERFCTR_LAST + 1] = {
 	[A8_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_3_5_7,
 };
 
+
+enum a9_pmu_events {
+	A9_PMU_PERFCTR_UNKNOWN_1				= 0x1,
+	A9_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	A9_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0xa,
+	A9_PMU_PERFCTR_L2_TLB_MISS_DATA				= 0xb,
+	A9_PMU_PERFCTR_L2C_AGENT_LD				= 0x1a,
+	A9_PMU_PERFCTR_L2C_AGENT_LD_MISS			= 0x1b,
+	A9_PMU_PERFCTR_L2C_AGENT_ST				= 0x1c,
+	A9_PMU_PERFCTR_L2C_AGENT_ST_MISS			= 0x1d,
+	A9_PMU_PERFCTR_SCHEDULE_UOP				= 0x52,
+	A9_PMU_PERFCTR_MAP_REWIND				= 0x75,
+	A9_PMU_PERFCTR_MAP_STALL				= 0x76,
+	A9_PMU_PERFCTR_MAP_INT_UOP				= 0x7c,
+	A9_PMU_PERFCTR_MAP_LDST_UOP				= 0x7d,
+	A9_PMU_PERFCTR_MAP_SIMD_UOP				= 0x7e,
+	A9_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x84,
+	A9_PMU_PERFCTR_INST_ALL					= 0x8c,
+	A9_PMU_PERFCTR_INST_BRANCH				= 0x8d,
+	A9_PMU_PERFCTR_INST_BRANCH_CALL				= 0x8e,
+	A9_PMU_PERFCTR_INST_BRANCH_RET				= 0x8f,
+	A9_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x90,
+	A9_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x93,
+	A9_PMU_PERFCTR_INST_BRANCH_COND				= 0x94,
+	A9_PMU_PERFCTR_INST_INT_LD				= 0x95,
+	A9_PMU_PERFCTR_INST_INT_ST				= 0x96,
+	A9_PMU_PERFCTR_INST_INT_ALU				= 0x97,
+	A9_PMU_PERFCTR_INST_SIMD_LD				= 0x98,
+	A9_PMU_PERFCTR_INST_SIMD_ST				= 0x99,
+	A9_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
+	A9_PMU_PERFCTR_INST_LDST				= 0x9b,
+	A9_PMU_PERFCTR_INST_BARRIER				= 0x9c,
+	A9_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	A9_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
+	A9_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0xa3,
+	A9_PMU_PERFCTR_LD_UNIT_UOP				= 0xa6,
+	A9_PMU_PERFCTR_ST_UNIT_UOP				= 0xa7,
+	A9_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0xa8,
+	A9_PMU_PERFCTR_LDST_X64_UOP				= 0xb1,
+	A9_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_SUCC			= 0xb3,
+	A9_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_FAIL			= 0xb4,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xbf,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xc0,
+	A9_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xc1,
+	A9_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xc4,
+	A9_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xc5,
+	A9_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xc6,
+	A9_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC		= 0xc8,
+	A9_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xca,
+	A9_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xcb,
+	A9_PMU_PERFCTR_FED_IC_MISS_DEMAND			= 0xd3,
+	A9_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xd4,
+	A9_PMU_PERFCTR_MAP_DISPATCH_BUBBLE			= 0xd6,
+	A9_PMU_PERFCTR_FETCH_RESTART				= 0xde,
+	A9_PMU_PERFCTR_ST_NT_UOP				= 0xe5,
+	A9_PMU_PERFCTR_LD_NT_UOP				= 0xe6,
+	A9_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	A9_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	A9_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	A9_PMU_CFG_COUNT_USER					= BIT(8),
+	A9_PMU_CFG_COUNT_KERNEL					= BIT(9),
+};
+
+static const u16 a9_pmu_event_affinity[A9_PMU_PERFCTR_LAST + 1] = {
+	[0 ... A9_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[A9_PMU_PERFCTR_UNKNOWN_1]				= BIT(7),
+	[A9_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[A9_PMU_PERFCTR_INST_ALL]				= BIT(7) | BIT(1),
+	[A9_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_INT_ST]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_INT_ALU]				= BIT(7),
+	[A9_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_SIMD_ALU]				= BIT(7),
+	[A9_PMU_PERFCTR_INST_LDST]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BARRIER]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_UNKNOWN_9f]				= BIT(7),
+	[A9_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_3_5_7,
+	[A9_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_3_5_7,
+};
+
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
 	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
@@ -796,6 +899,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return apple_pmu_get_event_idx(cpuc, event, a8_pmu_event_affinity);
 }
 
+static int a9_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a9_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -985,6 +1094,17 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_twister_pmu";
+	cpu_pmu->get_event_idx	  = a9_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -1034,6 +1154,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.51.0


