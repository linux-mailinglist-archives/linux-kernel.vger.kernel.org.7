Return-Path: <linux-kernel+bounces-789922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB328B39CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCB7BB84E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06F31771A;
	Thu, 28 Aug 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceoSp/Fp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B953164BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383056; cv=none; b=k/FRCqdjDBTPnakiN6JObCtdGSwwuWZvXE6+oyRaQNjJOiRyuZ41HgQq0j9er07r9PxdcjPrKV9A88IqfoIiBMES5j2YwankSUUVKWRsPP1hEAHowo/waWGktM5445AXgcUw6XOWlqJaWq/7O9Fxc6UZ616y4x+Tp2apX6xqfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383056; c=relaxed/simple;
	bh=9GiN2/tUl02eHBu5x+pmqTOtPVE1/FNwqyLaaSoZu1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/g5NFlE9UUMoOR1DEfxUZnpzSK8vs638sFSjzdYuJmNKh15i7UcYhL0ZpUMhVxPODNl/sQD58ayJBQQc61ztIviimQ763Htdc2R9KNpUGI+leIa0H+vt2i/F9Wm93ccAVMUIwng8grYyJB9kcDenDuuwUDvceTkYfLfdAEXc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ceoSp/Fp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6Rl8r016081
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tWFHeWBB2Z1DVoBR2DS7ksl09YtGQ2DsVW2EAUl813A=; b=ceoSp/Fp9vgYXEnd
	SdujOuKjRJYYH/R3AtzwKZc52D251SeEICqLQSv/FB8rm/YPTfi2ZuGG9KlkMW6R
	Lk47LN6Z9spDvtEgshwf1jpqwsFb+79j73mvMp+nLBmCDo+6y2abC7USZPRGM+rR
	n4Z32GTiiGdaM3zWk4bO2UQ6u6wXudreJdPMUkl2m83tPe5rK7CRc7MkP6WK/OOo
	t29uyEGWzt0Y+uIXOd+s1dclzVtVeEVoPw7l3Co+XyglLpS5YbDglzgxfix0t9Ag
	FgGSHvlLKX3RGt2nKDLNFyZRN3yN+5jlGDCEWQeHFO909/SpaBeeWnYfTVHZer1P
	aqWghQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf2dtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445805d386so10327925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383052; x=1756987852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWFHeWBB2Z1DVoBR2DS7ksl09YtGQ2DsVW2EAUl813A=;
        b=tpHC3wwujBogX1UeTifN8d1u4xxJhsDnUiIz/QYendXJPzF/PnXdWHYTfV9SW2hbca
         PDmR8iQgGjtExorwaLypn/20MAIg0VX+Avklv2O3OlJUW9yME3ZWcCl3fty+26bY0RAC
         Rcamp20GnT2r6ixI8H8k/H1vAuTY1HKOlT9dZuE2diBlgVXZKMSBgH2rrXUNle5Zg2Uy
         3s2BE0Rv0Ue/Agy0p0WRA0/4/tua0xsfykND0ovy26l8Eq2x4ygO2o7/qj0RgVwschwO
         XzvNON2eDoms7m2QV5Rb6vTVy6oq54lWrfeNPhT7eYGdVB3V+grLPUzw0qt+ubX3/pdF
         n+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXhogn7DLElsfarPPqYzc1Ni+dWZHT+FCWhUp19pMKDBGI6q3Qs1OyeyzZCUqHjf+5kTWzWgwbZ+1rguVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1b3J+/Ha1l3h99/B63DuLjOsPFJD3zrAy4j3lqOBX4ytqRy0v
	lgww15E7getjyg0bdcPTdsnOvJCNHPMTMkeUc9n72mRGADhKS4YpGDlfEctrw2WgRJTTtmDW6xa
	d1ZMsdrbJ8mM8clSJTKTirsu7JuzRqhAtA1GnzAXjJCzqApdYkvzFVOFoN8HYwfUdSN8=
X-Gm-Gg: ASbGncsnaB0ZpsxqwytF46vAanYjgLU2HjLfsTPlvX6DzJKoGDwX9nZsao3WC8m37EP
	6fiBdMwzJ3iH6W6cx0IyM8ekzQmx8zM+wRFelKyh4rxhUhWTTJBLIXRO8QsH20WcLbe3y5YQt/c
	rUvP4/zUFevi+TW4zdTVc57k2TKQ88Euo2JAbw+juCFemG/Gu6TI9qYb/4/azz4bBQ/1hbbpyeU
	LPovVLRdX1zy9P2oduRYktMj2ue+65zu+iJQRbTWVxHPKUX5FNnJOJ0CvGDOro2WU+7p+eXj8IF
	ZwDOHJ+TVqlRxTVY3ftSaq1e4CZmgyUFXuAYHytbsvbY2XtxLPgrxeKt6AvljDmQKn/jGgi7s68
	=
X-Received: by 2002:a17:903:388e:b0:23f:e51b:2189 with SMTP id d9443c01a7336-2462ee4579cmr306306415ad.17.1756383051568;
        Thu, 28 Aug 2025 05:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd0NBJm7wYUW87oKHBUWxZFqtYLB2Viy/kWKLH/ZpGsIecptUNfwMGjJrdNd7WqDcbo+qxjw==
X-Received: by 2002:a17:903:388e:b0:23f:e51b:2189 with SMTP id d9443c01a7336-2462ee4579cmr306305605ad.17.1756383050865;
        Thu, 28 Aug 2025 05:10:50 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:50 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:04 +0530
Subject: [PATCH v6 7/9] PCI: Add pcie_link_is_active() to determine if the
 link is active
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=6997;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9GiN2/tUl02eHBu5x+pmqTOtPVE1/FNwqyLaaSoZu1w=;
 b=7p67LiPjVWlf+ukePQQtECRvT7Hd+sOl/Q4ApcZA69A7MFauJiAm0LrZbq5yW50wMgpaXUdMB
 6spcJ8FbmB+BUEBtMyO+c5jGWzToR9VHc/hL1lDssvnPl9w6ZtEGfBm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: LW5PvV9gGK16ZS3vcilNODkyTGXVXO5s
X-Proofpoint-ORIG-GUID: LW5PvV9gGK16ZS3vcilNODkyTGXVXO5s
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b0474d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=DLE-xEQoUa54y48t:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=_AprYWD3AAAA:8 a=c8k0nbeVto6RhVnl1UYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX9w3gHECb79a6
 wNWp9FSUhKhEZczlCmV+p56dPsO3RBfOeAsQMygU3uual1xkEMTKiKNqhVhujsQuyiug+WaLIOM
 pDy2j6tNjttzqYOIOrww2u9PsZtxtLNxHX/0UiNkokDDJK+iUCxtkN5NjXeNMIg2k5EDkAV7+HE
 pSK4X3zXuuCIcIUneD2Ty2HVRRqixSFzgDIjY0YEGxr+EtoWoBYJH+gqJhYc6pPAqL+Orh2wlyA
 vsWOTG92Tm35CbXK1+OLJiQfubwQprumbDgOW4G2ddH9sootggicBY1PISjJQdOSl56MCDPycaw
 0TXBzi8twjYf5jhuUBiwrFL/PAwdvSLNg3eteTczsFdqOMRCqEbgkDcgpzedUwcGlGjQC4e4GQM
 R4KuMtht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

Add pcie_link_is_active() a common API to check if the PCIe link is active,
replacing duplicate code in multiple locations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
Posting this patch again as part of my series as I have dependency with
this patch.
---
 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 35 ++++-------------------------------
 drivers/pci/pci.c                 | 28 +++++++++++++++++++++++++---
 drivers/pci/pci.h                 |  1 +
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2c8e06aabb765e1741572685100b..79df49cc99463829f563db1dc8014a51ccfac0af 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
 int pciehp_card_present(struct controller *ctrl);
 int pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
-int pciehp_check_link_active(struct controller *ctrl);
 bool pciehp_device_replaced(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f3ddb301c1ec6b0bce0d7f9541658..6cc1b27b3b11a77678c24e464fbc61541a0bfa38 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	/* Turn the slot on if it's occupied or link is up */
 	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
-	link_active = pciehp_check_link_active(ctrl);
+	link_active = pcie_link_is_active(ctrl->pcie->port);
 	if (present <= 0 && link_active <= 0) {
 		if (ctrl->state == BLINKINGON_STATE) {
 			ctrl->state = OFF_STATE;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bcc51b26d03d53ef7cb22b8e5868aa25b5ceedaa..2905ae7c9bbf7f9f656ec21ecd2e6bf9f7b5be47 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
 	pcie_do_write_cmd(ctrl, cmd, mask, false);
 }
 
-/**
- * pciehp_check_link_active() - Is the link active
- * @ctrl: PCIe hotplug controller
- *
- * Check whether the downstream link is currently active. Note it is
- * possible that the card is removed immediately after this so the
- * caller may need to take it into account.
- *
- * If the hotplug controller itself is not available anymore returns
- * %-ENODEV.
- */
-int pciehp_check_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
-		return -ENODEV;
-
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-
-	return ret;
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
 	if (ret)
 		return ret;
 
-	return pciehp_check_link_active(ctrl);
+	return pcie_link_is_active(ctrl_dev(ctrl));
 }
 
 int pciehp_query_power_fault(struct controller *ctrl)
@@ -614,8 +587,8 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	 * Synthesize it to ensure that it is acted on.
 	 */
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
-		pciehp_request(ctrl, ignored_events);
+	if (!pcie_link_is_active(ctrl_dev(ctrl)) || pciehp_device_replaced(ctrl))
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 	up_read(&ctrl->reset_lock);
 }
 
@@ -921,7 +894,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
 	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
 				   PCI_EXP_SLTSTA_DLLSC);
 
-	if (!pciehp_check_link_active(ctrl))
+	if (!pcie_link_is_active(ctrl_dev(ctrl)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 
 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cddddd88e2011da09aa6719b738651..50b53fc4092ccb6df2dc801b76f70f9df08447de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4919,7 +4919,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;
 
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
@@ -4935,8 +4934,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		if (!dev->link_active_reporting)
 			return -ENOTTY;
 
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		if (pcie_link_is_active(dev) <= 0)
 			return -ENOTTY;
 
 		return pci_dev_wait(child, reset_type,
@@ -6241,6 +6239,30 @@ void pcie_print_link_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_print_link_status);
 
+/**
+ * pcie_link_is_active() - Checks if the link is active or not
+ * @pdev: PCI device to query
+ *
+ * Check whether the downstream link is currently active. Note it is
+ * possible that the card is removed immediately after this so the
+ * caller may need to take it into account.
+ *
+ * Return: true if link is active, or -ENODEV if the config read fails.
+ */
+int pcie_link_is_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	pci_dbg(pdev, "lnk_status = %#06x\n", lnk_status);
+	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+}
+EXPORT_SYMBOL(pcie_link_is_active);
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e9f61f0c489ec58de2ce17d21c0c6..5368a27f3a208ce95d39752459f1029beea2fcca 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -228,6 +228,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
+int pcie_link_is_active(struct pci_dev *dev);
 
 #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
 void pci_create_legacy_files(struct pci_bus *bus);

-- 
2.34.1


