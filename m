Return-Path: <linux-kernel+bounces-878762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A012DC2168F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1F21892978
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F3368392;
	Thu, 30 Oct 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPfR84kD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jQiD+y/V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95E368390
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844444; cv=none; b=MvP/7ScU7IRdElpcfaO1E77N90mNuO2Kz3l3R/jDoJub/UyWAftvgifGDR214nfZlsaeGf2OR4N0hGy3/3qi6BvysMlAYA0oIqNVEZUh+g1frZv7YT7JLvbBKJizb1g1fiTOSHftx+bp7ZmR1fQJYjjgbEL1mhTO7qf4a8zAbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844444; c=relaxed/simple;
	bh=x1bq9e/8vSl/IQyTeBe5hfVi4MXOMNBVCCVJKwGiIqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oW0PxedgnpvLqrFhrVSjwQd7yZvMdgh1X6iKfteHxaPWuQgEojawCFou5lMBkdZdzeqhu6QherEbhqHNWO6n7V4ptaoD6dPuxHvZlm/ouzk4l1ZRWmP2CI3Myf825Ec2DYF7i3ZvyL13hn44GNbCNMD//o0yRy91jxsBg/e/MLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JPfR84kD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jQiD+y/V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UCbFAk2623042
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NlY3a59EnWw3W2m/Cy/69xB1sonk2B+SQck
	emZEPLyU=; b=JPfR84kDBqqOqrtah+KBZ+ac5QJggVG3T0WsfMQkfbLjnViz1p+
	VLbH+oWcBAtl8RB9dGBABWLC6kXX8D82ZtMSV2/x2mI7de0/VawAR9MS51zRH3H4
	BCFap9J4Y19UYq/l21AaH2uVqnz2RoV/4J/+NSo4Y6Jq65sf3tTGdTpgiiD5hV7M
	RqwcNVtKg6Ayg/wzcZlUB3rcP3WuC12Q5QJMa4sE5pZagMsFmQf7qa28v4xynVgM
	L2h1wz6HpdFXDNOpN0pwx42UcVlBj7De7peYAAT9/kBoPOzX/xKceGpzChh3iXw5
	ibJChknSqyA4tAGymBU1fROa5/W+PPAEgjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a41fxj37t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:14:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2930e6e2c03so13030695ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761844440; x=1762449240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlY3a59EnWw3W2m/Cy/69xB1sonk2B+SQckemZEPLyU=;
        b=jQiD+y/VBysVa+Rc9h1NY0aOg2eMpNq1DG4mP8mDhwXk/2JGL2rygsDgkBXyp2YlIh
         FttNgApuh41SCMizqi1SM4dD2Z01KGqSEa5B1ePt9ta4Yr2BDbE15gcXc3k3oEXXa6xJ
         w78bpF16Z4PQY7evMFYy8wgAcoLGstenmqK3s1fT1X0EkTn0fhjYOZSN6ucMmxJPDhM0
         gKlCLPemdR69Ek0sGp7ALmOngLRoqfxh8G8coqGzuozP6Tqbgk1Vg98LZ/MKG1pw3jFr
         uRiXIZw0ecPG81F9M7HWtcEeDPWuXpIYZ4WTQ8ZsfdjQ2AsIRjSVtwaktqFR6Q5zOohW
         NvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844440; x=1762449240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlY3a59EnWw3W2m/Cy/69xB1sonk2B+SQckemZEPLyU=;
        b=QXleUzef0OWOQwUKoelibODdWohoqG8r4YBS04nwhuA17E/oKVbWE2McxrNtAZQA1n
         oJ7J7uo+eexhBjoU9AcQYQXd8oZPFsUGidSIBKoM5bfRG4jmDqboBqRiOdYcAJDMMaNr
         THKvalEE6qtzLuHtlIBoLBNxJRXOGam9KRB3TH8bfqVAswEqkFM3Py1s+VBFVmXsgCfT
         mG3ramQF5bebkBpjd4BRec2FCGyXG4xFj3JU+F4LdkDeKqmYoCbgw/hc7O3KATc3mhOM
         2Nzbygh/+Cfzc333LV6nwmkTeOPTXELcxP+SvrfCSVpKSjpHEqNFNV+8SEcD3iEQBfkc
         S6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgjBSFBqo2HUKTcdjHM1ceIVPhtdbrTRatNci31473p1Gq1FDjiDTwZzGRKGJ/Zfcpd2JjOWXZ/PqTSjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0bJYPhIBhFCTtZ4JX6DGt4gHwn/T3tKp1BqOrqe1XPe3DB9J
	5M2sJdzuoFVZzp1fOAGXD9AqMrVGrEINsaPTPnwz9SiWz7ImxnYp+5d08Eoc44Rr/g4OVxRueqK
	MfuTKG4VqfPv1Qik6QVrMrg00+71EtCko9zI7dzkJzCp/3axuq2TeIz24kAAHaRWu7FSLO/dGPN
	c=
X-Gm-Gg: ASbGncsGLqBEElVgAl69335lCxApRHzBuYdyslZlvp9OXMPXihYA//6vLEJLkF9unfP
	sZpjSsYKatcM0Hgml68zmC0j4t6RmV+0psn6gVQOE+D9TDdagsUhYNocqkC3vuA1HJhj5ZFS3Eu
	rbnF4hh6w+4Uc9yymimOtq2WUg20GCrTtme8GdkrczPnlZgM4pBLh3E4t3SNaCFkc3MP7zGXtaK
	dFK+sLm/mX7qKS8eNMYKRNgLUjKrtnY6ecg386OU/Pn4MdtVoJnfr/KOjs1fkH3n4/zVNAMyTfV
	o+6CwuONmga0NIwaKdwsHUh6KZ9EHK7I98lU2bpDvp1oQOHRqV4eG/g5xEdCdeHMapTIwG0fD9D
	5EL6AP+3hYdQqkLgh
X-Received: by 2002:a17:902:7482:b0:240:9dd8:219b with SMTP id d9443c01a7336-2951a5c178bmr4250675ad.49.1761844439919;
        Thu, 30 Oct 2025 10:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmMUs2l97mAKIXFLVXYeAWdkf2cmNSszxRKGZZkKWPQoJ0qntyY8SF/8lvySuaW7WFHz+CrA==
X-Received: by 2002:a17:902:7482:b0:240:9dd8:219b with SMTP id d9443c01a7336-2951a5c178bmr4250235ad.49.1761844439311;
        Thu, 30 Oct 2025 10:13:59 -0700 (PDT)
Received: from work.. ([43.245.136.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm191872475ad.107.2025.10.30.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:13:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@riscstar.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] PCI: dwc: Warn if the MSI ctrl doesn't have an associated platform IRQ in DT
Date: Thu, 30 Oct 2025 22:43:46 +0530
Message-ID: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oNQEWzzOh5IyWQBIKcohD3ek5oylj5WB
X-Authority-Analysis: v=2.4 cv=UJrQ3Sfy c=1 sm=1 tr=0 ts=69039cd9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=roF/NyajnXB/+763NCkubA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-kslcIDk85T_T1zYC5MA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: oNQEWzzOh5IyWQBIKcohD3ek5oylj5WB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0MiBTYWx0ZWRfX68sNQDYukM6i
 N83OvzoBH0cJwhNEWqillU2yUYKg0yStXv2iK+XcUoaBL3JVzFoWirJzWY0eBIkmvS7AZ69MRbg
 yEJj/DlZ/+aLDMUe70EW3cT1PKQjF6eu7dh9/YZ/ALC/3ulLsaiEzMSH/Xf9Km3YPqK+TjDJE4+
 HrAiuTS4Yvnvr2UPFkOun6jAHq/s0HLXuw2YyagHvCnOhWdotgnEuOJK+hCZS28QcOepNgsbALY
 bI3Q+hijgGrb2Ss8gdNckKOKWoHoOyGsUAilynK3OQbuhvC1nM/Ucceu3dYnqE1FpMh0YKo6vf0
 W3baezLX1Sb52khanu1hqdH0AqvnVgdWKZqaV5UGCtIb0NsGUS3PsXnlZRqeKtObnNx7g4db6PE
 MsZdordrP/2fMFxG++1tuEdUEKbA/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300142

The internal MSI controller in DWC IPs supports multiple MSI ctrls, each
capable of receiving 32 MSI vectors per ctrl. And each MSI ctrl requires a
dedicated MSI platform IRQ in devicetree to function. Otherwise, MSIs won't
be received from the endpoints.

Currently, dw_pcie_msi_host_init() only registers the IRQ handler if the
MSI ctrl has the associated MSI platform IRQ in DT. But it doesn't warn if
the IRQ is not available. This may cause developers/users to believe that
the platform supports MSI vectors from all MSI ctrls, but it doesn't.

This discrepancy can happen due to two reasons:

1. Controller driver incorrectly set the dw_pcie_rp::num_vectors field.
2. DT missed specifying the MSI IRQs

To catch these, add a warning so that the above mentioned discrepancies
could be reported and fixed accordingly.

Fixes: db388348acff ("PCI: dwc: Convert struct pcie_port.msi_irq to an array")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..f163f5b6ad3d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -357,6 +357,8 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
 						    dw_chained_msi_isr, pp);
+		else
+			dev_warn(dev, "MSI ctrl %d doesn't have platform IRQ in DT", ctrl);
 	}
 
 	/*
-- 
2.48.1


