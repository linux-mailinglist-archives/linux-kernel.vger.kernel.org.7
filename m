Return-Path: <linux-kernel+bounces-775340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C55B2BE21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872C3188CD70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C29320CC6;
	Tue, 19 Aug 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3aZM1X4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE81320393
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597170; cv=none; b=c//Qc+pBlI6yaOJov76SGLWWBVKDiIQEYHr1QQmDEwaLUVETdy3Rme5rm1i8J9iujykO4hPB6ufvOGfSeQzUBm0H95aJYICPEo2xUcYWL6AkF/1TkDFphLqiMULg65zfKw+VDYtE9k7kqLsUuVe+4gFIA28PNUhJuSjMe812c0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597170; c=relaxed/simple;
	bh=OYLGPSROlM94Y8YMfz+cAy5T78h70o72gHxUfKcZJ3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIrS6qD19XJsgcscqlmwf1mvhzOcj4TYZMLuBtzrU0sQBQiTgCb+tQMxqusFuVhg3I0tVhqgdL65PP7DjAaAkRiAaz4XGf3qU2k5Tu/oetyVgpG/Hc23oZNqK/WCK/dbzXFkN1/W4Y94WaQ9C34d9WvqeMqm+7hHRRRBSn8EtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3aZM1X4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90ZA9018046
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=; b=D3aZM1X4B+HF/L/z
	KdsFIuNEcRM8a/tWk2IWn+TNS7sPwOBYXWwMMnIhoqF4frlheK3Vw8EFA5G3nBfP
	/oTv+FierlwtsDUhX8inf+frGxFiVp0wscVHwuVwBCiI87YcV8mnVHw52R2erMcB
	SgdzCOKpreAXtIDwIjm5QrUQhTYPbj+ynliQIkBOtgSxdVvXMZWAfSSqEp4b5W42
	GBtHFkkPMN1RyHc0b3HrKRDn5cQq/tpf7lOjuTqQBpm1en3qBIDKF4mhm8WD5v05
	6swlUG0cjB6DMOEbOmZfum8jidMEJd5T7ORy+QDDufAzito3Iz7NROtM/82EKs1C
	c/YK4g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhah00k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47156acca5so4192520a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597167; x=1756201967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=;
        b=tXuBv5CgtBhYw9ChFk51z9anZIrSGp77buBnPxSxEE++i2SXtbqbQt+rPTIW8iHRp9
         xSqFQ9ynjG/oGQTfixDrcpHPrJNkCoBFpMRvu0FHsqrVvnj1CtC6HmQBOQDkdI6yZQrW
         JrGeVSlelVqYnbOKAQpA+zEOh9zkgVHMzVrj4ciTZt42u4OHHHEcCgyB74JvJ9dWxvKs
         vibxfGny4ZJ/saRO1EWK0fiWRYCBxr8k9WeK7U8X6RgIEyNmOf7yg84qfg/z2JLbkS5U
         qcd8mAfz+c40uX80uO5oBuh2N8P/AdcKlyH6hPRf4r/guvEurB7WCVynBYhUQFe0ayJi
         TWlA==
X-Forwarded-Encrypted: i=1; AJvYcCW0lQJioeHz8aRs0CHyYTotqRVhGo0cK5+w1bpXv7fWqQfG2NECntxudQjHe+p6iGYusJdiUWCoAdKSfUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mU/X2l3mFt628yKnThXgqJnDhY4Q3vFRGsoz81OJZkbDhKUb
	nWtVRfQb71hzP5pPikpjQWWq6Qd5346BTqh79BN8GFpRIwtudSXuH6Gr/zT88qLqZSMJdAVKtnX
	4dPn1I2xfqI0GQhMaMesuagaXBeKAmF/NYAYxiqXvGyi9fa/K8fBsT5Q+ldmpOdxbkkg=
X-Gm-Gg: ASbGnctY0pO998SiQOSZNDm7Qum7Le16GZ3WP1LXVurApu6TjJh3/OlXrrOV/22Uwbu
	E0Q0j/C9qD0JHjBWy0N6mzhBzwv7dYJWQsdDnOZQZ7OKPQDoAfdIi5O4McQLcqmONQxLjUxg53U
	c/6Q2US2bfyDCAj/fGO9SMIlr0Gd7TowaSds1w9/7zQWugXXXrXd5S92Dcwa+kKzC0Mon3/4G0y
	cNqfhge0nXaUaCxLPlKi7OaVqVObaPw6PAbpDv/1cfCR/mi2bs1jBNoV09F86khRywN79AQYwZw
	nJ0y2yI4Caq49mvsiM8+VTT8oj9sw7cJ5epYsv0fdAeV4IIjBWv7OOM9qArhmeIKWfyft9Sj0TT
	QRs8+rgiCj1iwLVw=
X-Received: by 2002:a05:6a20:9143:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-2430da566bemr2343300637.6.1755597166613;
        Tue, 19 Aug 2025 02:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK98AH04v86DoafQcwelaWJ3iL3gQkWuwwa/UBd5s9Smm42EVUfqRGbSC923jHrqHy28a7HQ==
X-Received: by 2002:a05:6a20:9143:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-2430da566bemr2343266637.6.1755597166153;
        Tue, 19 Aug 2025 02:52:46 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:45 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:05 -0700
Subject: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document
 the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=1596;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=5L5bgft0hY3UL+GD99tTktGev1AZdAzNOUPNY/hYCs0=;
 b=iSxkRvwPR0upKVd4VfCSpydV5AIWuhTgF5bNTgzrmAQMKSGHkafm6fwJOSYukO+Z8sRfTNEnN
 zVYCLHdo1m5CkxFG3qY7uMnOpRWEnekdHJPHAK5A2R3t7B4Hbw1jPjd
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a4496f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KsSlednxysWCn5KmKhhur9MS77h0XmP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX4cUR79C4z5J+
 WZaIDXduY2mEsx1Nsa49XSjdRaFag/jfrw/JUjY77+0syMkoAmDRVAs7qFyz/0s1DQDLZGcuDB3
 jzsb+rfBP2vG6lBcLiZDr27JNf0u3N4aB1yeEmDN0qV9dLKfo/m/DPBHf06CTJ/Gn0sveVkSi2L
 OnDdJARp21SV78YHAn/xP2dGy+mFX4s9b+jm13i0946Wgrx9qXBBPo32B/ypFKafQ7Rg9XenOzg
 0UM9MIG2EH921CLUAjHxFNK6hD8YuBYwxewhtrT4iYc7BUkVAO+6sMnyTjmmZrk6JHR7Ev/uJEK
 v3fsmIvLbRz9J07Y1eTiu6uZ3DW8jNN9k0X1JcO+2i2pCyQCBfJx9+093IX2pqwYemtfYaeB2yk
 AtS/vdmH
X-Proofpoint-GUID: KsSlednxysWCn5KmKhhur9MS77h0XmP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index b6f140bf5b3b2f79b5c96e591ec0edb76cd45fa5..61e0e2f7ec7f9cb08447e4cd9503698c0a2d383a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -176,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -211,6 +213,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1


