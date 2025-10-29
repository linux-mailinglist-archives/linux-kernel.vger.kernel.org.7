Return-Path: <linux-kernel+bounces-875497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38018C192F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11C23BCBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224431D37C;
	Wed, 29 Oct 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ey8pheSq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LNklXqc4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75802D839F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726456; cv=none; b=mMF6Yshzne3SzA/n8uk1QU0//E6MzlVt0E1oC20QkAfkxVS/BAUYQm6zmHgIjtnLyIdpajlmdZez2HIlCCkvfdput4eWY/PBbqQ1uJrgL0CtlMPT3jBMh7IimyxIyT/Y3Ujc71ljMz9vxnqtCFAODOxSDldTTGCz/IdwFbA/Obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726456; c=relaxed/simple;
	bh=K2LoXFp5LEsul4Dhs9SgA/B6uZWNPqsF0H0RJ9W3v0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCw6Arz4mVI/C2qSJHAmHbOAyutHUZXqmXBvUqOvw8MmlxvYTF5Sd/BLgjKj/QCBu867bO72awNiSF3Yy2kb5Li/6C9U/xIGAGp/NmfXIk0Mv0SEWMB06M6n5NX0Jexvyz0n205qektJAwDTGpiDUSSNwxZJQBj6g95hpJNEiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ey8pheSq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LNklXqc4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vCFI3664309
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdjZgcVhb+CKLTqPGYpWJTYAfCGN0Bjw2rKq/3wysL4=; b=Ey8pheSqW3hcRqTq
	5dPoZ7fPzXDerjpe2mqVCKyksBvqB8y5GFC7kXO8JtrNdg1cwXqLu/lTCHmXFbxe
	04uKAOLDcqGwwQg78bHNVfGKxanlA5Km06wOYPpT2oCW6BY1Wj+AkvYDD3Y4cb/v
	p4ELU2Si4Owkh6kK8i3IveaFn6dzquah5j+uA1C9KzA2Lpwih8kRN/m9FBvP2mj7
	2px/mwh4JbAVuaozppJ2bS5zA2sDEaes5xVpNEKb52/bCNusE4TrrnJEr8GySLZm
	qjfqQqkDKMY+od2D3c7yglm/o6Rdkx1/HxXVim1JBO23nNSEsXNMIZQKzGU/xlV6
	wV5YRw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1ss8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:27:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c247591ddso167715286d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761726453; x=1762331253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdjZgcVhb+CKLTqPGYpWJTYAfCGN0Bjw2rKq/3wysL4=;
        b=LNklXqc4vzmlCe1DrkvBYbTf/aB5f0M7NIcYc3AcO5Xnc70XLlV3B4ZtixwEvhWf1K
         z6UrJEImq+uZYWobuJlJ5SHorZMnSB07DFrNAcZDqyt6lkq3Hwu5Kn6MWNr/vOE/uK7Y
         Af2Q7l7jnjt/Nq90z5Q65z01tQCsdEOrDdW/qONOAkGcVTOpcg6ZJTGnGLV5wHY/ABos
         hVgiE9ZBsvcWzqUdRlUfV9sG+qx9rpuGvVXU5hP0ddZvfACaA9dsJUfsRwDDhytwTISz
         xMxHW52A9CwKdCRDgzv2NJw6dTNif3/hW/ovgjbUnl5d9KpTk6aWcAt3JX9sLxTHpu1s
         lJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726453; x=1762331253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdjZgcVhb+CKLTqPGYpWJTYAfCGN0Bjw2rKq/3wysL4=;
        b=fWKlGz66xTQKfZvVp1zPuo36mMyMPrlpn4QQmu18AO17+cUrARDLkcOwuIUpGHsp++
         dyHNySvSn2lVx3I0oTXLWcpE3eHJe4KOiqjlw72kgRr0en1lTgrXFfX1e3t9tTqagDiY
         dZbWuIwSf+C9BLnlF3Lhdyw72JVOsV2lCf7C6fFX7/P+QkNdXXu7RFQ51yjFZtT699l8
         XhUc8jeKkv4UoV9I1L72Vm4XMLX89lvYNAtebxkBy3DCRzW8bVOOLcYOZ6faluzq28/C
         zpR8dFiHmOxTVJyCXroJu9qfYFN9U45dEUVIS5bTYitpfQNOAU9f2zoNS62aMmUTfGzn
         JpcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNJ2STh40oo9FcFBylV1DvkxTHsCIT64SxI1Y8+4+D8wTZQL4nuv5ObHJbhZ3A/vzOomI6LTCd0bQhOnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUlRGuw/okxVogqsvTvDHWRoxHfn8BpWUUnUkejGeqWK0SJhJ
	RdWcbrh17urtqu1/YplPAmZQ7SNAKf0APsxzycHXIiff4BC0bQmbIuUbH43G8t/SeJ7r1mxpp45
	8UOuNluIZLg/Xv0UuJ4F6uUnW16RHg74sH9k/kL/ni4VpE9vaL06JEfctWgjAaBInIW8=
X-Gm-Gg: ASbGncuuQziiCvDDNWAGA8cF+PSoOfcTswT8TDjQi7TeY5tnQAimwBMSlRRoU+Pomt+
	6j9VWC8vJunD+qQEWVUo0nNof3ogQNHDJjSguImfMAT5kfKvXNA4MMlafWg3QAnl0pSq3Be4ULk
	Bp4I1d/iiLJCXVv3f2HNgy0yDxBklSSafwXpYHiri3STZIDJ/iIx+KVYdrDMlyUZaEsvT3zK8A3
	ghHVYo5TiFF1MQVSEesOnQYXI+mNeZbdNvJiq8Tdwv79CoqHUN0kg4REWk24kM2emHk5Sk6K5mv
	4i3r5C/cOHh36RkY2IydOGiWPpdrpViFpklhwKhthaCJ/ilhtTcjcU1WsFjtFASoDTtB+266got
	CTufqyhgiSOhm9MQEzqJDJeQ/Zogf9SZsyAufmUirUHk0kENZiQ==
X-Received: by 2002:a05:6a20:3d1c:b0:340:15c1:61be with SMTP id adf61e73a8af0-34654ee8cb2mr2526705637.32.1761725721677;
        Wed, 29 Oct 2025 01:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE64M7wk+Oj9x7dht/3Pt3S0ux+Hf/sJAuE1OfAONy3A7MeAzwrn5DrOGPUQ2PkjXoO2Sx/Gw==
X-Received: by 2002:a05:6a20:3d1c:b0:340:15c1:61be with SMTP id adf61e73a8af0-34654ee8cb2mr2526675637.32.1761725721142;
        Wed, 29 Oct 2025 01:15:21 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm13187901a12.5.2025.10.29.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:15:20 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:15:09 -0700
Subject: [PATCH v2 1/2] dt-bindings: mailbox: qcom: Add IPCC support for
 Kaanapali Platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-ipcc-v2-1-8ba303ab82de@oss.qualcomm.com>
References: <20251029-knp-ipcc-v2-0-8ba303ab82de@oss.qualcomm.com>
In-Reply-To: <20251029-knp-ipcc-v2-0-8ba303ab82de@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725718; l=2948;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=K2LoXFp5LEsul4Dhs9SgA/B6uZWNPqsF0H0RJ9W3v0k=;
 b=51ZgfhEAcqJjrryURu66ZHCinO3k9oxAoDIDwm3K+2XDq6ZUaS7bBz2Jqm0pVUICfNTeZGtN5
 hCtk+PaGlJlCuzkMTPbqbeetIXLeEWk88ueTrDi4648bvXORP2nZCWb
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: IUv6kfsBuOHMU_nPZxdor81lf_gzA9ao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MiBTYWx0ZWRfX+hwSL5Gl5U6Y
 fLNZ0EDXicbmd631BCJrJIrsbLEsbxFjcAJqVf10f95D0yIfVOS9YKpS3pQj16n4vN1+ag5XDXj
 WM4/XnZ76AobpPP28nMkIrzw3Ze5+88jfXaN9zKlNfpvBqQQ+7HkMVOIZo7S2KlrbTO0AZzKRUl
 gAE+PunF8mB5LdFKqlP3eiwiyO8yJaqx4aPibf4lycp5tf9U+lW29ygdkkZx5ORgKy9hdKqisnR
 KaxY+Guy11q/H/h56bPshUhM9iTVCRVnm1r7Mwu9ZxiFQl9n3ImR1YArPmHGSVFTjL+x8qJySPk
 1tcr5f2dSPmOvsNU2CeMk0nRF1j5a7NuE4kOjEqsBzj46wZMh/ElZs+ar2h0BrrTDhJ+fFRPtMG
 8FKggMOya06IWu5DugsNUWwqb5yddw==
X-Proofpoint-ORIG-GUID: IUv6kfsBuOHMU_nPZxdor81lf_gzA9ao
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901cff6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-s8QFGE_8KqGwSZzAHAA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290062

Add the physical client ids and binding for Kaanapali platform. Physical
client IDs instead of virtual client IDs are used for qcom new platforms
in the Inter Process Communication Controller (IPCC) driver as virtual to
physical mapping logic is removed in HW.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  1 +
 include/dt-bindings/mailbox/qcom,kaanapali-ipcc.h  | 58 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index e5c423130db6..ee3fe093e3ca 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,kaanapali-ipcc
           - qcom,milos-ipcc
           - qcom,qcs8300-ipcc
           - qcom,qdu1000-ipcc
diff --git a/include/dt-bindings/mailbox/qcom,kaanapali-ipcc.h b/include/dt-bindings/mailbox/qcom,kaanapali-ipcc.h
new file mode 100644
index 000000000000..b6208ad155ad
--- /dev/null
+++ b/include/dt-bindings/mailbox/qcom,kaanapali-ipcc.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_MAILBOX_IPCC_KAANAPALI_H
+#define __DT_BINDINGS_MAILBOX_IPCC_KAANAPALI_H
+
+/* Physical client IDs */
+#define IPCC_MPROC_AOP			0
+#define IPCC_MPROC_TZ			1
+#define IPCC_MPROC_MPSS			2
+#define IPCC_MPROC_LPASS		3
+#define IPCC_MPROC_SDC			4
+#define IPCC_MPROC_CDSP			5
+#define IPCC_MPROC_APSS			6
+#define IPCC_MPROC_SOCCP		13
+#define IPCC_MPROC_DCP			14
+#define IPCC_MPROC_SPSS			15
+#define IPCC_MPROC_TME			16
+#define IPCC_MPROC_WPSS			17
+
+#define IPCC_COMPUTE_L0_CDSP		2
+#define IPCC_COMPUTE_L0_APSS		3
+#define IPCC_COMPUTE_L0_GPU		4
+#define IPCC_COMPUTE_L0_CVP		8
+#define IPCC_COMPUTE_L0_CAM		9
+#define IPCC_COMPUTE_L0_CAM1		10
+#define IPCC_COMPUTE_L0_DCP		11
+#define IPCC_COMPUTE_L0_VPU		12
+#define IPCC_COMPUTE_L0_SOCCP		16
+
+#define IPCC_COMPUTE_L1_CDSP		2
+#define IPCC_COMPUTE_L1_APSS		3
+#define IPCC_COMPUTE_L1_GPU		4
+#define IPCC_COMPUTE_L1_CVP		8
+#define IPCC_COMPUTE_L1_CAM		9
+#define IPCC_COMPUTE_L1_CAM1		10
+#define IPCC_COMPUTE_L1_DCP		11
+#define IPCC_COMPUTE_L1_VPU		12
+#define IPCC_COMPUTE_L1_SOCCP		16
+
+#define IPCC_PERIPH_CDSP		2
+#define IPCC_PERIPH_APSS		3
+#define IPCC_PERIPH_PCIE0		4
+#define IPCC_PERIPH_PCIE1		5
+
+#define IPCC_FENCE_CDSP			2
+#define IPCC_FENCE_APSS			3
+#define IPCC_FENCE_GPU			4
+#define IPCC_FENCE_CVP			8
+#define IPCC_FENCE_CAM			8
+#define IPCC_FENCE_CAM1			10
+#define IPCC_FENCE_DCP			11
+#define IPCC_FENCE_VPU			20
+#define IPCC_FENCE_SOCCP		24
+
+#endif

-- 
2.25.1


