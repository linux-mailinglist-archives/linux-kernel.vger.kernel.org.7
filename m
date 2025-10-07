Return-Path: <linux-kernel+bounces-844631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F9BC2604
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DDF4F71D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41712D5408;
	Tue,  7 Oct 2025 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ppVZ6P77"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F77128819
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861453; cv=none; b=N8njzFZa09W/1hRTpkSx3w953GWGLNswou+a8oo24VszrhEI/t1Onc0mi2/gH5zoan2E7lZjJQdrB7QUOj5GiVVCxHNiemRDhxINoo9vC2wQj3jQQo8w8VUKMiZ1zTa9Ygr0vfSIuXha6lgebCcpYf46g/rGNaouPhGBAcGfto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861453; c=relaxed/simple;
	bh=PhbegbaMd1qZ+6ZHuLSkaTFKK0U2ZhDS1zI+8IlM3Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxPzY5s4M0iDCGllRxtDaiY4QoBQAIPLe2jsVLHyMOivxxRgeo84COlJxB4DNqiAeDILFMGESyhanTQWp1Qv4uCAnaSGp3j7+BD9miw6T363R1yxXhLkyejsmHrECzsKtD/mK0x3Hq0sdgpeUCzStnE7OJhtYQez1ndWW0shcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ppVZ6P77; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ET7kV020319
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 18:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=v7gi3ANU7eGwAeHBm/VtX/N+PelGRzkkDBF
	dO15qWFo=; b=ppVZ6P77exkgaA75jAnjZYSEF5MqFITHrr/PWEI9ACIezmyMyj2
	zzjWpb+VMMlCzE61/Ivf19Se0guYAjqfSXdHQUqHExV4ARrYGTTycIOUb/mTXOn5
	Le9STcQ4pBVMOswJHRWT+/lsXFFFaUawGwvVtMjK9V53Ts3auymk/8uhPTJJgceJ
	dLY1cGAxxFi3tPeY4T42WLt5Sxb8aTVwSjzmzum1QbvBDc/LDGLRoqOzKifA39gq
	1UBpT7jTzM7qnqf85J3yhXKpslYElC0KMqWKykH75AFE8PT556xP77pyCCWXdQ3Y
	QMEhu3mZ27ahxtEA0OACVb6GDZc9N12eAgQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e0cvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 18:24:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2699ebc0319so62790035ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861448; x=1760466248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7gi3ANU7eGwAeHBm/VtX/N+PelGRzkkDBFdO15qWFo=;
        b=sK2VOnSzxUTW6OcmFyeMJpVIwcsVPKQRdjHfaH2E1aKEmbAW9PHnD45Zc25Kmq97zy
         Sv1dQOOugFygZcWtBW5UtcMniGC0ibahQeuZs2wOIxF9kLVY49rI/zMOtyUmAjsZ+WcK
         ZNCq1YW7uRW3l3OMFgF2tG7ddHZPJrDxSvIKDvuZPItGfpfY0Ih/ct+9ooXinmjh16qH
         ZJcxYBD8eBJrRDHLcSnaHIlyg4wsR2Lx5Frw3ICrj97ESGSwIjFdleGiTa3i6MhN5qyj
         b36ZEJtV0aH5jq8OUWsGL/pNqQlHgvYZp/xHb9u2y0NDmENyJrKyJLExoiP+wOy/eJuy
         S5NA==
X-Forwarded-Encrypted: i=1; AJvYcCVmd10zSfWF1/DvbDrlEc9El6KpTSlKHdBl327ygvWif/6pIMYdeWl/B1JgPtMTZmFfv/s5rxNQr0VWjKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxO/IcEK4N50VbjyTjGRvanC8URlzm83Mqz0ryEPbtdX11ueRP
	J6+T2vCJ4P8R/Sdium6YOG9DCm+XFVb+ZBQZSQ1jJQ4fxC/Wz+4RoH4E1YCxKf+iq0GsOkKXHtx
	BlvAC3XxeBkVpOpnJ9gyWTlfldsVQRZ/3UJesCk7EQkyznpLJLOlv6eJdprfIhT4Uk50=
X-Gm-Gg: ASbGncv9vXmPP/x+8BjSZYZxixqDAEUzXlEdUOiaszUA6fGLK1tIVSJ99AG01JjVoio
	QK6tgN8ddob+TQ5USxjpluQlDKIfEkPUBOIujiKkoIBBxEng7/gveNcMM1dIQdaiucbHOfcpXr3
	7CvCfvUKaiSC3HO8o1t9Q88wL5qQqLc88wqZKE/ADwqXohKOVT+pl0VfHZ/nsyT7JV21/2ooSYW
	f15iarb59sUgVR2+RY4pQcL6mSjKlD1ESp+MAY6uazhIzJfjnfiukJH1hIF/MhMPJKOGfzlBV3S
	svDmTWCpvkzK/AjsO2YK+14HsCRhjDTvJSRmAB1LKWfBIVy4FP0wRh4JANNr50U3dgqFROMN
X-Received: by 2002:a17:903:90d:b0:27e:d7a4:cd32 with SMTP id d9443c01a7336-290272ff5a5mr8818965ad.57.1759861448169;
        Tue, 07 Oct 2025 11:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk+kGnyBGf3KfhdZk/5b6XJ+HDJE6ygty3ucqB0kfKr1z7QKyevL86q3VUXkPE7iIuJxra0Q==
X-Received: by 2002:a17:903:90d:b0:27e:d7a4:cd32 with SMTP id d9443c01a7336-290272ff5a5mr8818625ad.57.1759861447505;
        Tue, 07 Oct 2025 11:24:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba25asm172984505ad.87.2025.10.07.11.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:24:07 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
        will@kernel.org
Cc: alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] KVM: arm64: Check cpu_has_spe() before initializing PMSCR_EL1 in VHE
Date: Tue,  7 Oct 2025 23:53:56 +0530
Message-ID: <20251007182356.2813920-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e55ac9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=YElTaCpYnbo2m2hzBnMA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: -RqTpnziGldAaScYmatYdPeQoeef8CGv
X-Proofpoint-ORIG-GUID: -RqTpnziGldAaScYmatYdPeQoeef8CGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfXy1Eu2nuKQwtV
 Z5PMX6FukIoFvPSADyDkK4uiPEmm7sNOmwTY8F6HK1ShVBWCvG04NX10/OkafNuk6DWfAsBeSou
 zs5V+uBmMnHYCAW3lZK+r6UHOC6Dt97a7VJhV6LN7BmcWGwd9PKnptiBIjjpZr0XQvfSdKWBZ3J
 vev7zSXx0WAyU327nl7HuPvzcUNLC7nxMs/Mxn1ktLxpWVnG85Gx4kRFHrHNnxOjIOklwbvTZsj
 LWxLFM2MZl20ppB7Es9Y6/JE4CikmsUA09YXHBRrnm6Yu6iHy3yymOg3TUcB3+bdFs81NShO22X
 UFz1080taYr8W1D4E/tE/R9+5potknQWNXSon0i3jB7fSKEIbiluOkm0jdVZUUPULCPpX4AkKxo
 uWAjTAKNKv1iEHN4mr7R6OABg/zrfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

commit efad60e46057 ("KVM: arm64: Initialize PMSCR_EL1 when in VHE")
initializes PMSCR_EL1 to 0 which is making the boot up stuck when KVM
runs in VHE mode and reverting the change is fixing the issue.

[    2.967447] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.974061] PCI: CLS 0 bytes, default 64
[    2.978171] Unpacking initramfs...
[    2.982889] kvm [1]: nv: 568 coarse grained trap handlers
[    2.988573] kvm [1]: IPA Size Limit: 40 bits

Lets guard the change with cpu_has_spe() check so that it only affects
the cpu which has SPE feature supported.

Fixes: efad60e46057 ("KVM: arm64: Initialize PMSCR_EL1 when in VHE")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 arch/arm64/kvm/debug.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 3515a273eaa2..d9fd45f0db9a 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -15,6 +15,14 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 
+static int cpu_has_spe(void)
+{
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+
+	return cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
+	       !(read_sysreg_s(SYS_PMBIDR_EL1) & PMBIDR_EL1_P);
+}
+
 /**
  * kvm_arm_setup_mdcr_el2 - configure vcpu mdcr_el2 value
  *
@@ -80,8 +88,7 @@ void kvm_init_host_debug_data(void)
 	if (has_vhe())
 		return;
 
-	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
-	    !(read_sysreg_s(SYS_PMBIDR_EL1) & PMBIDR_EL1_P))
+	if (cpu_has_spe())
 		host_data_set_flag(HAS_SPE);
 
 	/* Check if we have BRBE implemented and available at the host */
@@ -101,8 +108,8 @@ void kvm_init_host_debug_data(void)
 
 void kvm_debug_init_vhe(void)
 {
-	/* Clear PMSCR_EL1.E{0,1}SPE which reset to UNKNOWN values. */
-	if (SYS_FIELD_GET(ID_AA64DFR0_EL1, PMSVer, read_sysreg(id_aa64dfr0_el1)))
+	if (cpu_has_spe())
+		/* Clear PMSCR_EL1.E{0,1}SPE which reset to UNKNOWN values. */
 		write_sysreg_el1(0, SYS_PMSCR);
 }
 
-- 
2.50.1


