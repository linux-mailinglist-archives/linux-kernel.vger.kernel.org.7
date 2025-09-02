Return-Path: <linux-kernel+bounces-795497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79BB3F2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 461C34E024D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D902DF6FF;
	Tue,  2 Sep 2025 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9WQ0yxk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAB276046
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784916; cv=none; b=BDTW+VDOIU38EzoL5ouN53ZYPy/MBhAkXGof/TnnBnWGmslRyAEE+NbdeOB7DdZJzQ4Xck8LqiiZePEQBW+OmbxQeb/VYCfpUYjwZ9hpjiYCp2r/bwuVp5hhbsGzv2iIAqMMLx4SfcZqJxo+3CcOwYyZf+7CPKrRTWxH4uczn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784916; c=relaxed/simple;
	bh=pomve51ySnfeym3a5NacsGQMLiUMbbW2nqwOtU9Q3SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f8nv8vVQG8cfmjP8JY0K9zpBXUri0XtFzeNwZBKOVrvipQ8WDfLvkd7PGi7A6/NSSPbkvu6YfujQTmdmmXrpyy3Ssd4VKysm5o3wiI5ssDfpY+lqx3yPGAOK0VEnR2ht+SxKsMSOrqTS60lLJIWoEE+K6/mC9/ScdC/w64MFhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9WQ0yxk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RoKE024999
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 03:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yKa72tAMaYiEp5QU2uzmYr
	LEiYq8WJdxdN4mi1XQFe4=; b=V9WQ0yxkytlWbP/SkTsiQKHrLJW0XQxHQeGOc3
	AHm1VbemjWBjeBCgQWX2+CiwMilJ1VHzH2tSAViGZ+WbxC6oCDb5A9euLdw1JXoZ
	oaB+yImSicqjw2TtuW5hMe1YJSt/chIT8nUTF0O9tN2mp1+kp7XsASDU4AwZqvVE
	MNxpLsebgy68Hi3rGTz46dZ176jhFMDl8nMSrsn2xCMP5WvZtYRg5aew6Ap9B4Hc
	yUwIY5ho9Z+7SGGGKo9X9s38NYcrOBpUgELZ4372vYpmAlEbdrD6FoW01fcRgIpv
	U8z60PVIzZIbz6sGKi33NuykUnPtEkVYK9UaYQRHWPT9shcw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxe8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:48:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2492ba07d11so25636665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 20:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756784912; x=1757389712;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKa72tAMaYiEp5QU2uzmYrLEiYq8WJdxdN4mi1XQFe4=;
        b=rOJ8Mgo5a83fPhk1QqgnfUaIhKuxbRHDi/x1veRT0xHXMRUwxzzcqMw0bhQYnLvEAR
         lRi6eDU/MWTTrPN4xK64UWyScb9iHQwSw6KpoJx4cTHfxO47H0qFrBlG2V79p2MyPron
         l4IhP57BqEo3HCChckWHj2zRKffluXHLDika/YhpcYz0fu2jX8mgG8XNFvff4kWVapZH
         AXarJMGHhqLfh+acHXcHBTu4e3TjKDSJrIpBtp8zr7FSE/tgSlvOZKcXhU+owTyXQaDM
         3E2f0XPwP7xW+LYIsLB49VnVdXZvxSQ2+K3+OR9SxkF+GsauTwf50G/PcpJvfLUS14rw
         tj8w==
X-Forwarded-Encrypted: i=1; AJvYcCXRHq9ec5hhdVIeSp2iIbf3A7gHo+b6fsjlOjOj4hj/cHHJ6mT1kXN+ryCZ8u6WJCwtIrnHljvqrd0CisY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdvLGKxbgR8OHGgRKM2pEhcihQSsSg7boRMDX9zdomM56mHAl
	YaQfY6UKflWQ+blSPLQfssTy9XMUWsjW1S5GmNgm6aktdmg7ctqZH/BAa4wokn5HMJudQvg9lvV
	cHmxOJH8xJWQlCYPHGvC59zL5s3vsu3Rc1T2btmdRDwBie7JG5phehocb7qKIDp6gYls=
X-Gm-Gg: ASbGncuJkZdWmX7/NjB4OxqMZQ0txs+LelBmBYBR4ZngSUuUVfKioW9o6sz49eZmJZS
	m3ewID5iTZdNFaWrDWBWXAHXv+kmtJJcxXC/do6cujHazetiUzjoSPAH+XxBv+gVfJu9sBU8fV8
	wp2W1oPL/2CX5uqeMA2BudKSAWWHkJog3pPn+w4W8nM4fej1rYg5sVq56wFE7GuIDP+2NI64sdY
	HJVEiHq1YCZNBhVHcVMCUnaIicayWOkK1jZGH5fABgHZloNgxGRK7arl7iKPTs+9hjeNFCRkid0
	bfzya/aqNrma4pCHLu44kXi5dtkd5UjZELveqE9k6+6XOwN7SeN4a1AixjSypjahLa8Dwz7+HfP
	8CaLQaEmLph/T5OMCspZenZuaYZse3erWl6fq
X-Received: by 2002:a17:902:e80f:b0:240:968f:4d64 with SMTP id d9443c01a7336-249448f9c33mr135634205ad.11.1756784911735;
        Mon, 01 Sep 2025 20:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAbd7KtHY902tMepR979+mkTIDMW7M9jw2QHkr4Ls1PNDX5hM4GxNt4OPOJy08c/0mSNzYg==
X-Received: by 2002:a17:902:e80f:b0:240:968f:4d64 with SMTP id d9443c01a7336-249448f9c33mr135633765ad.11.1756784911264;
        Mon, 01 Sep 2025 20:48:31 -0700 (PDT)
Received: from jinlmao-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b168157b6sm3467515ad.13.2025.09.01.20.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:48:30 -0700 (PDT)
From: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Date: Tue, 02 Sep 2025 11:48:25 +0800
Subject: [PATCH v2] KVM: arm64: Fix NULL pointer access issue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-etm_crash-v2-1-aa9713a7306b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAhptmgC/5WMQQrCMBBFr1KyNiVJkzZ15T2kSBinNmAbzdSil
 N7dtFt1IQMf/mfemxlh9Ehsn80s4uTJhyEVtcsYdG64IPfn1JkSyohaSI5jf4LoqOMCsVYFprT
 A0v8tYuufm+vYpN55GkN8bepJrus3yyR5OigLWRkhjbGHQJTfH+4Koe/zFKv7F6grqK1srXai/
 QsELA1qDbKo4BNslmV5A95872wbAQAA
X-Change-ID: 20250901-etm_crash-0ee923eee98c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, quic_yingdeng@quicinc.com,
        jinlong.mao@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Yingchao Deng <yingchao.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756784908; l=2434;
 i=yingchao.deng@oss.qualcomm.com; s=20250901; h=from:subject:message-id;
 bh=pomve51ySnfeym3a5NacsGQMLiUMbbW2nqwOtU9Q3SM=;
 b=bb5AIneQZyVNy1w/19DaiOY0pRfZROqaFONWQ94N/D2KTzx4Qwhkqa6plCGU5jzJpmtAP/dLg
 2aAiLb7LhkMDRSfnmZt1hgR8nWzcT8mVlW5YJt4j6mL+o+/77IbjXhq
X-Developer-Key: i=yingchao.deng@oss.qualcomm.com; a=ed25519;
 pk=xilq+l2r3MI2IvgF26j2OwmdNb/TQNeJMQ3VdJi8C4U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX7JtXdB0vsqhl
 5obY4TTj7cDryiICgZiIIZtUlLol59lM9N4YusstyQFYmycZGM6MzqGXoL11TLez9xGyJJaPTb6
 PMgQ00IUtkbBKr2+7/z1EouWJgveZiGX74KUGoFqmzTivQ8PMwxMLP6IFgUR3qpOoNFxN36peb2
 jmVpZQ3W0zK0XWEuWdhwEKj477w/yeR/ZBtQ2YjCWijuWbgoN1dpyG4ZW9IzZbdP2ZGgUTjMy8O
 8AVOXu2lhJKblUtjlx/tDTriTW5SrHRiLqpds431toYxTVCjEXgROjRwKOiCCxLYIJLygrPPrn+
 qXO/H70eO4+ZfWr+OIvAI19tTJMDex4evKuDcSNU+IpUd4uhEgSnmNmjZW4SQVoW5q6pMNecVwj
 NHKzLa7c
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b66911 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=ZDfnslOjjdbEBvoarX8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QXwLP0kifVDw8rUm0VGMltXWuAyw0XAa
X-Proofpoint-GUID: QXwLP0kifVDw8rUm0VGMltXWuAyw0XAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

When linux is booted in EL1, macro "host_data_ptr()" is a wrapper that
resolves to "&per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)",
is_hyp_mode_available() return false during kvm_arm_init, the per-CPU base
pointer __kvm_nvhe_kvm_arm_hyp_percpu_base[cpu] remains uninitialized.
Consequently, any access via per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)
will result in a NULL pointer.

Add is_kvm_arm_initialised() condition check to ensure that kvm_arm_init
completes all necessary initialization steps, including init_hyp_mode.

Fixes: 054b88391bbe2 ("KVM: arm64: Support trace filtering for guests")
Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
Add a check to prevent accessing uninitialized per-CPU data.
---
Changes in v2:
1. Move the warning to the end in order to improve readability. No
functional change intended
- Link to v1: https://lore.kernel.org/r/20250901-etm_crash-v1-1-ce65e44c137c@oss.qualcomm.com
---
 arch/arm64/kvm/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 381382c19fe4741980c79b08bbdab6a1bcd825ad..593fcbbc7c014335c5999b774f9bfa367e709cb5 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -233,7 +233,7 @@ void kvm_debug_handle_oslar(struct kvm_vcpu *vcpu, u64 val)
 void kvm_enable_trbe(void)
 {
 	if (has_vhe() || is_protected_kvm_enabled() ||
-	    WARN_ON_ONCE(preemptible()))
+	    !is_kvm_arm_initialised() || WARN_ON_ONCE(preemptible()))
 		return;
 
 	host_data_set_flag(TRBE_ENABLED);
@@ -243,7 +243,7 @@ EXPORT_SYMBOL_GPL(kvm_enable_trbe);
 void kvm_disable_trbe(void)
 {
 	if (has_vhe() || is_protected_kvm_enabled() ||
-	    WARN_ON_ONCE(preemptible()))
+	    !is_kvm_arm_initialised() || WARN_ON_ONCE(preemptible()))
 		return;
 
 	host_data_clear_flag(TRBE_ENABLED);
@@ -252,7 +252,8 @@ EXPORT_SYMBOL_GPL(kvm_disable_trbe);
 
 void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest)
 {
-	if (is_protected_kvm_enabled() || WARN_ON_ONCE(preemptible()))
+	if (is_protected_kvm_enabled() || !is_kvm_arm_initialised() ||
+	    WARN_ON_ONCE(preemptible()))
 		return;
 
 	if (has_vhe()) {

---
base-commit: 8cd53fb40a304576fa86ba985f3045d5c55b0ae3
change-id: 20250901-etm_crash-0ee923eee98c

Best regards,
-- 
Yingchao Deng <yingchao.deng@oss.qualcomm.com>


