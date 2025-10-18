Return-Path: <linux-kernel+bounces-858916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE427BEC3C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 867EA4E5C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339621E47B7;
	Sat, 18 Oct 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="It2rF1oX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83242147EF
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751234; cv=none; b=sURciSphVjlZtAoy7Ltot5uAiYnZsutcOgSHs2Vyj9Uuj9lYV2rN8dbZnLwUqOBgWCZZK5yIuTtqfhCj/+mSlnTge0QKLtvdumyiJVHKYdNEZQe6Ep9yCGLPDA08Kf9vvqIviYf4e6Qev6t81cmrd2Ya4f9Fjj4AkDvtzHJL9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751234; c=relaxed/simple;
	bh=dRqJWz7OIwNnKTzn33y4BQaTa8oSs2p8RyOoVIfWlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ceaGN58650W8PTXVu65HpX0/1mlje6RfddvnubPCwf9KPsVZE8gyomloL+VL6XITRt5iFI5uh1Tfdapt2uLAy6JqHgzMoXBeLqJ05vY912KR3gGcVpilL7sl7C4kY3D0gwXQ4W410L6ChY1cZa3GdAKi6Ex594nROnitaZ8iPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=It2rF1oX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJG7bU018419
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LnqwEheiYw4eMqGgagIbYYTEmFr59FG4+mnaf+XhjEI=; b=It2rF1oX3BLd+TU8
	kyLXZGWIHND7ASt9uuxNpKpZ8T1giFdsKSRKC8aurqKTNe7rwKvPZsKYi4RXVJCg
	LscNR5QKdkAq5lzGhXmy+rrKfPexXmdwuSbIIBJJwq0+0L7J+BuI53MOrsgv/+vF
	y3zHJukGY2LaAwRUxd2fBofswTT0Q+6bi4rxWqfExG0DbjoWDiJZZiD0dNWS9fhK
	pBII8wo4S4wrc4ECnmJyobe109ARn4sWQDX/927a0RXQebgzvB2ceTzDQDb+HLXl
	C+Jmff8EO/Rms7QUv5uLQv+fM2WMnDxzE2RZnnCmvMl00WG4CIW9UL3Jktgn+mpG
	TPl6ZA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8p5sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290b13c5877so47567945ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751231; x=1761356031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnqwEheiYw4eMqGgagIbYYTEmFr59FG4+mnaf+XhjEI=;
        b=eq9cJ70/zSGS10Gm6yH7Pwsi1kGuriUjXBk+HXXR3gPreakpNuQmcpJ6ZgTIT6/N2c
         duxB5+PYKz5B9xwjJG08lo0Kyarl+7uIJBz0TRaVBlDRu3+/QIIAMNctEMH3rexu9BQq
         7R9hwZ82ZIXnKGwAApvf6wy5uripzDkOEyUMHXh623i13gkdUK5SWS1ZACXm71ca7VaJ
         tOVUqHFeeo8bbJLXC/PxaMdr0KoK2ywPhw8hMMsZwsK/uBgsMRTJMJLAvgoJPcdrX10S
         eOOcfGESitQKTj80Up+2FbHLBOqu0hWebyb8bkqKV/Mr/16BXfF41GdPXZ0anilkRQjM
         QIVg==
X-Forwarded-Encrypted: i=1; AJvYcCXC+fwxSbQFNRBqzrPQJk2mNw1XEh/9ZVAJJbHZOPOSGtRIbfHR0VEftCO0KnUMRGZQnO8KZK/6XeIcjPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBx3gZXfmi5KN+GGQhSY8EAYhocaWQjV/dAe8Oi34v+kOpucqa
	e8PqO2U9aOY1272LKqP4ILBej8erWwVgAntNSTZaT5x89jtbPA0K3E2LFw9zqwStRFuhOAxpIX7
	RlJz8qjsXbr1G+EuEBIEbW8DzKNTK2bhLNAWwYzg7Tk+H38GEsSuYeNI+phxFBJ3AHbs=
X-Gm-Gg: ASbGncvonPz5gz21VzeqgmllWdIgegCcGLs0IawqxQgNmMYHq2yB9o9NIlCmbNSzrrG
	qJ1Jyrkf79edxjXrzgfMWLfEFr+W1TgUSUxmt6MbO+vfVyp4KA0qI56z08v69fyk8hbe2y9MpyJ
	8/QV1WSUN1AJKs1wc7bvFB8+cfwkSm+PZw7BYpQDyg9SbiJmxPMgeULUPof4e64zY2wVVj08UfJ
	tBhPKQ3dE9zaRXZJc2bshKOEr6KHh3KwqpLFksaaQuZMrm9lrKdWRhm6Ey8/thtDIRW1MnbrBhZ
	GBJ0cVXj8UYmYoH8+IV67FVLgEQVFp/kakcyA+eqsov2gvmNoK9Xx09K+/gtd54AxwDgmOXMkEW
	29Aod9VEA9+/0WOoGZeOD6vacxFrLQ3eBtaDCTrVFKutWNA==
X-Received: by 2002:a17:902:ce12:b0:26b:da03:60db with SMTP id d9443c01a7336-290c9ca6b1cmr72784835ad.13.1760751230585;
        Fri, 17 Oct 2025 18:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyqTnRrVLfri2rPa2KLlfbixfUhrUK3J0pAbGviBCAqZVoD1KHQxtnhlTVe79JwMAh+DNsIQ==
X-Received: by 2002:a17:902:ce12:b0:26b:da03:60db with SMTP id d9443c01a7336-290c9ca6b1cmr72784485ad.13.1760751230159;
        Fri, 17 Oct 2025 18:33:50 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:48 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:41 -0700
Subject: [PATCH v5 4/6] phy: qcom-qmp: pcs: Add v8.50 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-4-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=1673;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=229Z+uA9EBUjxLvNJs5f/sN8K/iZsIa19KeM+KZknsc=;
 b=FMk3XJnpt5L5oYFyTSeIgwj4netRzGwWjSHT7VYRPORe2EsVKTIv45z1fdtp+YHxJZXiYEfIt
 o7Izq7Q8MQVA3O4tO25fm5D025He4SOrT2R0UiSf7mQ4ss04x+4OsSF
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: jHx_CkzR0Jq2Dv2AwONDwxLpeC5ZuD8S
X-Proofpoint-ORIG-GUID: jHx_CkzR0Jq2Dv2AwONDwxLpeC5ZuD8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXyfRWsavWo2z4
 JRDuu1Y2CeoaqmvobVRZC2X0auMsDoQQz2CxUT9ee1MK8L7EYrI4v8wePJBEzNq6DKRI/0RAv5N
 bQlWnTf4Nst9FiNGWWAfqd1oDMn1siQ96eZpGe0JsJjr/F8ek1n+y+yj2FpGrM+pcYgIiNeBER1
 UWS/9n4igzVgPM6x8pOFv5AQ283/HUagiQ++hvREMe7Lo0DvzZaezOGNpDn3jBfdnC0oHxFsUgm
 zh0h5DpG9DxfH592dm4imVb3nZNdvt1bsYhPOcaqSZZeQlHKuAIH9wXrlq9IOH63nrrx6qeV1Ab
 RCyZdR7rVgQjbxIKqvpUq1vdtdK7xQp3kS9yoV5LNPPZbFgvD3buYOpNm1Fdc1uwLRZ2k0dFGPM
 /OoOB1U5W00+OHAf0R4rhM/Tgbe9ew==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f2ee7f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=MyfKwbsdfMS_-thd9JUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
g5x4. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h | 13 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h
new file mode 100644
index 0000000000000000000000000000000000000000..325c127e8eb7ad842018dce51d09a6ee54ed86ff
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V8_50_H_
+#define QCOM_PHY_QMP_PCS_V8_50_H_
+
+#define QPHY_V8_50_PCS_STATUS1			0x010
+#define QPHY_V8_50_PCS_START_CONTROL			0x05c
+#define QPHY_V8_50_PCS_POWER_DOWN_CONTROL			0x64
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index f58c82b2dd23e1bda616d67ab7993794b997063b..da2a7ad2cdccef1308a2b7aa71a2e5cf8bd7c1d7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -58,6 +58,8 @@
 
 #include "phy-qcom-qmp-pcs-v8.h"
 
+#include "phy-qcom-qmp-pcs-v8_50.h"
+
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
 /* QPHY_POWER_DOWN_CONTROL */

-- 
2.34.1


