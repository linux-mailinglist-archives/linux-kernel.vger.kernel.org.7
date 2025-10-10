Return-Path: <linux-kernel+bounces-848602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C486BCE249
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83183BC89A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72706201278;
	Fri, 10 Oct 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XfEYudEX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D186331
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118448; cv=none; b=pNI4Vif14+R9p931XEsfTrS/lKtAoCeJ+8KFVWp2ub6g+117AxWExt+sU0rkWbuIjKImhH16OCJnPuCNWGM7lBvyBak7btG/JqPzi8jRd5R5OcK04zYbrw/XI3I2YefI/YsBDBxo19yLXH7QtqTVGDxhjEhNBdqDxFVWDMsnnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118448; c=relaxed/simple;
	bh=WT9PyBwFI3VQ0ncli3+MFYSVbkzPanNbmACAPQ+bRUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LS5VHIxXE+eAG+mOvm/cD6QBYybLhNBNIkUonG1TLxUdB/UrNISJmMtTMtkgFOh8MiSE4fk6jrD/q0Y9GxNdGv0Eqy5dNmbyINRO5HEjzhsDVZD3Q/M2fejfZSnxdJzC2z6ixjm4h2OXFZh7qm86wgk34cBUw01lgPWq+OKF6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XfEYudEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFPpGe002113
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FwPo3e7OvqTd1NWuZ8apR3AKltDtOQ12L7y
	93Bhadpo=; b=XfEYudEX0tV5K0sqZ6/EVFZfh3UQ07D1IgzeJ5ZDxqEvBTst/EX
	ywP00rfGYi/dfemfB75Pnlrj0QI+hbDy8jGfNXuwsiwKJNXddDze9qhGr2GfR68O
	+DX12cITSMPKRAQa3KBFu6ppaZFphRD4u1/JLDxAfjXFt8J4qX+rXHTP9nZ6cw26
	SBH6eWhnQFGfiGggjCEUEFsq9emlqkntU+J7bEyqJXH9SXyc53VrD7YVBxv8Oevw
	NG4zvShXumdzEeYTys24rqW2pNwO8Nt4wi6H4BW3cdt2ANbaIVgIjF74igEsMwT6
	QY5GHd+Rffgv9TaTqR3javpREgtTOq7W0+g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u78ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:47:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fbaso58406105ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118444; x=1760723244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwPo3e7OvqTd1NWuZ8apR3AKltDtOQ12L7y93Bhadpo=;
        b=CCaZ0NAg5Z6nBcrNy0dACXT3pTn6YAq06IqIF8Z0zQc17Rum9q7ZJ2Ibb2BIOZlh2R
         O8Fyu0cCb0zH9TQhzZ+XvefU+kZHOu8TNhHs3E3Rprt3HqJn1eGXQgZc+heSnHtlOAgt
         L/99+HjxbFDpvYDaunrnuEBL9TcEijE1CdUnYuWtRRyY3QSQXTWuWM1zjBbM4z6ltkka
         QQMrKBmmNBBPdJhkqsPRjS15QMLCRBicfVukQGiB00lgvi19edHiZihQUaEZRRKtW/dO
         Q2ZRN//Wy6NjnjV60Dl3muVADQv3wXy40zIWZCUq234Gxu+fBRH/juXsquut9S8CO96s
         xKPA==
X-Forwarded-Encrypted: i=1; AJvYcCWRpUsxTCiaRzWxkkaI+QGT7Z1l2lkyqrlyKlwxuPIoiZMcjvLg1XzqdhEJBuz7wkphUibbcj2GIP1yl0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7hkAt2i1imxeP4rN4eDHdEh9Ri9rvbN4paUmc1cZzUTrJRCG
	yTnTaJhGODPZXvnEwk7HHHSnipWkrilVYKvpNXTI6f0cX9uVtngpPgrvIqGuFxgMZqo9hqpnqeL
	P6s1jq43WVFiYSFjAX9rnsQtTj1bStLsUYBcV39kMX9twcINdBQveTPukV6Faz8JYads=
X-Gm-Gg: ASbGncvvQG5+U703WLdYkgQtFKVDC4pjLuiLbGDBDqRQibrsGHB1RKM02tO+5myoBZ5
	x5lbTeLrsl1CbRGhBgysvh533IYxEI0BtSoeUAXojzYuxWN3D1BX6c0vdirjTDQfikJO18Z8b4Y
	m0Iiwdx5DHUnnOzo/ohEfBhNi5FwythwxiBrB8MLHGEHJ0ypY1wlRbQYgF7juBJ8pIGBkRAW2DZ
	vxjpZpfSUyHPhVvzmDNYmjndo8iT4NySPc4v90FV2bBFaxjbMfVtGgrv4phBkbkpd8+U9U48e2O
	MdQJncErbNGHpFVmPCARD/XubBchE3dFJ0Y8h5rKO3otXRL39VEGNhnblmYmxkN+EVU=
X-Received: by 2002:a17:902:e952:b0:27e:f018:d2fb with SMTP id d9443c01a7336-2902735667emr159110225ad.6.1760118444040;
        Fri, 10 Oct 2025 10:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyhIYzu2yvfjQTBTknIgm2OkThLL5tjUy3aIAha8LlsyWFfhUgj4W2Jq7D4Xj5QA9Zpu/bog==
X-Received: by 2002:a17:902:e952:b0:27e:f018:d2fb with SMTP id d9443c01a7336-2902735667emr159109855ad.6.1760118443498;
        Fri, 10 Oct 2025 10:47:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f4ad6esm62469435ad.109.2025.10.10.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:47:23 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2] KVM: arm64: Guard PMSCR_EL1 initialization with SPE presence check
Date: Fri, 10 Oct 2025 23:17:07 +0530
Message-ID: <20251010174707.1684200-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e946ad cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=sZYUSTO7CAmMIKym-AcA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 1SuIRYi0xbqBCoQeuJHRUUKDcd4Gnwpt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1H7ESIbPyDon
 UF3Ez6ZetNg7Qy2YSrqEUOklehMtacq211lA3GOC25CuNBe3/dLj9KYm0sFupo6AsHWRqt+Okqq
 IPPGJcR7c//0cy+3xm3kPJUqTQ8JU38iy42dbdLmg07axw4MM3qGGzOiU9+KxOZ4D650cGhNZTH
 tIEX7ajkHsBwbbkA7AadCydyuerNINTFQ75MjyglvRGFUq/ZL7oQOIV2H+HKxSD0TeznNokbhng
 Mf0ckfH49pszurRUopiwTXC4csrmL/7qYOp3NkW2hBf30Ss68gBo3eEfOz2S8OvvdueGoW7q39o
 eST0hZAxah9AZ+RdnaxMaH0vQDeYvldIljDPHgQ4nAxpsYqZYocldeUJq0Vg5Dn73o34LjgXYt6
 ARiki+JqFbC8pEVQhxwo102KZwmTJQ==
X-Proofpoint-ORIG-GUID: 1SuIRYi0xbqBCoQeuJHRUUKDcd4Gnwpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Commit efad60e46057 ("KVM: arm64: Initialize PMSCR_EL1 when in VHE")
does not perform sufficient check before initializing PMSCR_EL1 to 0
when running in VHE mode. On some platforms, this causes the system to
hang during boot, as EL3 has not delegated access to the Profiling
Buffer to the Non-secure world, nor does it reinject an UNDEF on sysreg
trap.

To avoid this issue, restrict the PMSCR_EL1 initialization to CPUs that
support Statistical Profiling Extension (FEAT_SPE) and have the
Profiling Buffer accessible in Non-secure EL1. This is determined via a
new helper `cpu_has_spe()` which checks both PMSVer and PMBIDR_EL1.P.

This ensures the initialization only affects CPUs where SPE is
implemented and usable, preventing boot failures on platforms where SPE
is not properly configured.

Fixes: efad60e46057 ("KVM: arm64: Initialize PMSCR_EL1 when in VHE")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
- Reworded commit log
- Reused host_data_set_flag() and host_data_test_flag().

 arch/arm64/kvm/debug.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 3515a273eaa2..4406ab962ebd 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -15,6 +15,12 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 
+static int cpu_has_spe(u64 dfr0)
+{
+	return cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
+	       !(read_sysreg_s(SYS_PMBIDR_EL1) & PMBIDR_EL1_P);
+}
+
 /**
  * kvm_arm_setup_mdcr_el2 - configure vcpu mdcr_el2 value
  *
@@ -77,13 +83,12 @@ void kvm_init_host_debug_data(void)
 	*host_data_ptr(debug_brps) = SYS_FIELD_GET(ID_AA64DFR0_EL1, BRPs, dfr0);
 	*host_data_ptr(debug_wrps) = SYS_FIELD_GET(ID_AA64DFR0_EL1, WRPs, dfr0);
 
+	if (cpu_has_spe(dfr0))
+		host_data_set_flag(HAS_SPE);
+
 	if (has_vhe())
 		return;
 
-	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
-	    !(read_sysreg_s(SYS_PMBIDR_EL1) & PMBIDR_EL1_P))
-		host_data_set_flag(HAS_SPE);
-
 	/* Check if we have BRBE implemented and available at the host */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT))
 		host_data_set_flag(HAS_BRBE);
@@ -101,8 +106,8 @@ void kvm_init_host_debug_data(void)
 
 void kvm_debug_init_vhe(void)
 {
-	/* Clear PMSCR_EL1.E{0,1}SPE which reset to UNKNOWN values. */
-	if (SYS_FIELD_GET(ID_AA64DFR0_EL1, PMSVer, read_sysreg(id_aa64dfr0_el1)))
+	if (host_data_test_flag(HAS_SPE))
+		/* Clear PMSCR_EL1.E{0,1}SPE which reset to UNKNOWN values. */
 		write_sysreg_el1(0, SYS_PMSCR);
 }
 
-- 
2.50.1


