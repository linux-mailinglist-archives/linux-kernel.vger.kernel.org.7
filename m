Return-Path: <linux-kernel+bounces-831090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA14B9B844
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9751798F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622EF3168E3;
	Wed, 24 Sep 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cX5D/B7o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950231A55B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739084; cv=none; b=WHISgi1+kFttFHGxsrxqBNqcuZF0usuGcHrQ2q8dI7JMTr1av+m0xOybBNGYf00Pt2KCn6apeERgQVjXZAXqixPtEJhXvrBTUrnggX8WLyF8WpL04LQzmfKXtKJmpA7sO2vxNljU9Pz7d6xKKalRNKM69OXqzTEMKuI5K452qVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739084; c=relaxed/simple;
	bh=x/yB3U0JOrNOZ2V9rL6+/azkb/Ffu+YJQwvpcwVJLj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZMdtt0edGYb1c44w97Mr278rXqSNczY5p+NGgcVT3h9vyhPWe9qFSvhVDSHjudPS606gyc7bEGcaJQ7ZFr8UJVfOWh8HN5ycQmfKE/1V5sx4oPA/O8NknZFbCw1JI2nAn8O2WWO3zdtjkXJW5c+xf+nYkrDgHB76VdDZ1s2caI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cX5D/B7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODMF7T019931
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9RNW1M1uDCL
	xCSHh9UIK713brM5SN9OdS/M6VDwK+XM=; b=cX5D/B7o/uCfC4dHhPFpLHqpeEt
	ezYPkmdcqQBHHuuvo6JTlQotW9CQES8jhMUnzIarfPKGzt9RXmcDdtKXa3v+r8xw
	hATn3jqd2XHpcj6JJKwFy/J1aQ3Tlr0EXXsbJ9eckymWqbf6KubVhMWrQy47MLpZ
	fABS32iNjRoF1YECqTyZi1BxYcKB3BFeuwmPjRsDkoNGO+/E7dZeg1HmFOdUWZC4
	hT7K4fTZ59sT6ffiZIRuFwbq+sUHyikuvVD2mo2K6QdgV1rvUYqazYpjZm81Iaho
	0gSz5TOvX8sVgf3Rbuoro2uyxuPeqqr/GmdqVRLCzRK2JmglWt5HHxUwtzw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdxmmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso116201b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739081; x=1759343881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RNW1M1uDCLxCSHh9UIK713brM5SN9OdS/M6VDwK+XM=;
        b=n1KvgpcV/zMUkYgUOW300bCX6y1sadlcEfRCf3M5P0JvrLM88aQGPp6Lu8eakE9JxW
         IVpR8iXyvo+lJb3FF0Bn5AgvuT4EEGQ8q6as7HvUHi41DUDRfh1r8SmcDCSXCEDHzgqt
         xgsON6qc0VnWpJvanOrehxji6LmtWm36JHFZ+6focuMQ4S7UyJTFbTlCvwzhgNCNIKea
         5WgJxtmZwGwvLQW4d/QQaKszmF6m0OeuBPetMpOqcj2wm/RiZcROGC31nVge87+/pJwt
         lQvv7GV9wDL5tQd5lneUjKw0PJXzplhICIEKdog1GYWO1JSV88gxKFqWpV4CGPSmTPdc
         tiCQ==
X-Gm-Message-State: AOJu0Yw0V17v4ySdVOhCm3h8eQrwpiZYNWnccvMKRHoYboiX8RtvXoNb
	tUmIHI46qee7qd41kAryTthJqAHCTWFP929gUcmU4yksXTc9DpKZP/+Pp2j0esbt87hF71LsPvH
	+737kiy4fVaxxURSxd5pWfV3gYYQhDWsHb2qKYNTr6oodwgdI/+Ftx6uLms+l3EzRGh4=
X-Gm-Gg: ASbGncsmG9fMTEPoDYOsyjiyN9Ys97bakDYANiraz35Fz43t6R9UKlHpuYAzuCdbeEJ
	lFDy24wVXQwFY+3Dihk1zIilx2dI/BDxu+Z0pvfmg4IQVijDNnCvwZkaQJuXy+2d3IfkPH0dYHL
	RX6tRaJTjt+4+QX56/lirj4/yaGeP5Qvp8OvJvYRGlAt7wQGS+EE/nv4NXIlF6pJ7rYTuUwSjWw
	gi7apgq1K5LcpzTWOInYBesKUOJWaxlwd7Pl6HIStJ6JwhXCCxz0nLUg4v0nYKjRXFXtUGhx+On
	RkHZ72RaiBHAJPEuqBNDs6XcRrmsOqTlwolPaunugRHN2ZUjC4XtdoolhDKC3y1r6+dcspEKfjs
	3FY65m2rktbBLCNAz7wmStxjy+WQLA1ETVsoLwT3kutVuNzeqsQbnDU4=
X-Received: by 2002:a05:6a20:a127:b0:220:10e5:825d with SMTP id adf61e73a8af0-2e7bfc1d570mr754836637.8.1758739081487;
        Wed, 24 Sep 2025 11:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQozrNUM5/5vTV2ruPG6yCF0B0PeRf3UGyZidkCzWFRA+CJQBk6NhKsxQ/GiS8C6ISg1ZxLQ==
X-Received: by 2002:a05:6a20:a127:b0:220:10e5:825d with SMTP id adf61e73a8af0-2e7bfc1d570mr754806637.8.1758739081070;
        Wed, 24 Sep 2025 11:38:01 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b555adca754sm6523412a12.16.2025.09.24.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:38:00 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: mailbox: qcom-ipcc: Document Glymur physical client IDs
Date: Thu, 25 Sep 2025 00:07:23 +0530
Message-Id: <20250924183726.509202-3-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
References: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: adgzgP3YUc8VP-vVp7mNI_5MN70oCV1V
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d43a8a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QlhcEh-tmJ1xmMBebrMA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: adgzgP3YUc8VP-vVp7mNI_5MN70oCV1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX3IrJQ1HEeqRT
 9Ef/5n1+fSaR2dE1+ckNNQB/5fq12G4mL9X4m8wi3wjVnSBXNAvfWpEASyHfvz3wqtSA25geLYG
 mHF4fJveNHb8jp95AL85D7lqc8peEX9RWSNWCdcnnx7Fs+4p9g91EUu6MnmOrGl/SBAhjr/xVBD
 YDFbI4YTAQGkDSbp5iJyw5YWQOzXujAVyNwixgFh38wHnZW3pAkFdIYhb4Fw99nF9zRf95yFiDQ
 5foVuqGALeO96F3JmnGOxxZ9a9ULBJF4rxRXuGraN9nnXx/NQvcGfrgS9Xz0dl/1GD2c68ubIpv
 qq4c3pvknjBZpfg3i0p2nCX6Vijq6mylCUEs/PQ5KETTZ1fQRPocctHQ+USufZJAqkraj0gYKTl
 Qc48K935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Document the physical client IDs specific to Glymur SoCs. Physical client
IDs are used on newer Qualcomm platforms including Glymur, since the Inter
Process Communication Controller (IPCC) HW block no longer has the virtual
to physical mapping in place.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

https://patchwork.kernel.org/project/linux-arm-msm/patch/20250922-ipcc-header-v1-1-f0b12715e118@oss.qualcomm.com/
^^ patch seems to assume physical IDs are common across SoCs but it doesn't
seem to hold true on Glymur.

 include/dt-bindings/mailbox/qcom-ipcc.h | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/dt-bindings/mailbox/qcom-ipcc.h b/include/dt-bindings/mailbox/qcom-ipcc.h
index fd85a79381b3..61cef29e43f0 100644
--- a/include/dt-bindings/mailbox/qcom-ipcc.h
+++ b/include/dt-bindings/mailbox/qcom-ipcc.h
@@ -36,4 +36,65 @@
 #define IPCC_CLIENT_GPDSP0		31
 #define IPCC_CLIENT_GPDSP1		32
 
+/* Platform specific physical client IDs */
+
+/* Glymur physical client IDs */
+#define GLYMUR_MPROC_AOP		0
+#define GLYMUR_MPROC_TZ			1
+#define GLYMUR_MPROC_MPSS		2
+#define GLYMUR_MPROC_LPASS		3
+#define GLYMUR_MPROC_SLPI		4
+#define GLYMUR_MPROC_SDC		5
+#define GLYMUR_MPROC_CDSP		6
+#define GLYMUR_MPROC_NPU		7
+#define GLYMUR_MPROC_APSS		8
+#define GLYMUR_MPROC_GPU		9
+#define GLYMUR_MPROC_ICP		11
+#define GLYMUR_MPROC_VPU		12
+#define GLYMUR_MPROC_PCIE0		13
+#define GLYMUR_MPROC_PCIE1		14
+#define GLYMUR_MPROC_PCIE2		15
+#define GLYMUR_MPROC_SPSS		16
+#define GLYMUR_MPROC_PCIE3		19
+#define GLYMUR_MPROC_PCIE4		20
+#define GLYMUR_MPROC_PCIE5		21
+#define GLYMUR_MPROC_PCIE6		22
+#define GLYMUR_MPROC_TME		23
+#define GLYMUR_MPROC_WPSS		24
+#define GLYMUR_MPROC_PCIE7		44
+#define GLYMUR_MPROC_SOCCP		46
+
+#define GLYMUR_COMPUTE_L0_LPASS		0
+#define GLYMUR_COMPUTE_L0_CDSP		1
+#define GLYMUR_COMPUTE_L0_APSS		2
+#define GLYMUR_COMPUTE_L0_GPU		3
+#define GLYMUR_COMPUTE_L0_CVP		6
+#define GLYMUR_COMPUTE_L0_ICP		7
+#define GLYMUR_COMPUTE_L0_VPU		8
+#define GLYMUR_COMPUTE_L0_DPU		9
+#define GLYMUR_COMPUTE_L0_SOCCP		11
+
+#define GLYMUR_COMPUTE_L1_LPASS		0
+#define GLYMUR_COMPUTE_L1_CDSP		1
+#define GLYMUR_COMPUTE_L1_APSS		2
+#define GLYMUR_COMPUTE_L1_GPU		3
+#define GLYMUR_COMPUTE_L1_CVP		6
+#define GLYMUR_COMPUTE_L1_ICP		7
+#define GLYMUR_COMPUTE_L1_VPU		8
+#define GLYMUR_COMPUTE_L1_DPU		9
+#define GLYMUR_COMPUTE_L1_SOCCP		11
+
+#define GLYMUR_PERIPH_LPASS		0
+#define GLYMUR_PERIPH_APSS		1
+#define GLYMUR_PERIPH_PCIE0		2
+#define GLYMUR_PERIPH_PCIE1		3
+#define GLYMUR_PERIPH_PCIE2		6
+#define GLYMUR_PERIPH_PCIE3		7
+#define GLYMUR_PERIPH_PCIE4		8
+#define GLYMUR_PERIPH_PCIE5		9
+#define GLYMUR_PERIPH_PCIE6		10
+#define GLYMUR_PERIPH_PCIE7		11
+#define GLYMUR_PERIPH_SOCCP		13
+#define GLYMUR_PERIPH_WPSS		16
+
 #endif
-- 
2.34.1


