Return-Path: <linux-kernel+bounces-800001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67EB4324F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631A41C24C70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88727055F;
	Thu,  4 Sep 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxQYhEYK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23226C3AC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967001; cv=none; b=hPjnUOCT0nZCatS9dy4V5YBcAgORhoxvm0uh+mzRhcdFgTmdrilod62IHSDIoZqvi5BdyN7hbB5f6v0ido81jXe0qadkrZNqV5ZR5rPN/FHWETYfcWiMx5qVpUlA9F8FOEFHeR+1dQcjk46c0dn58LYysa0L+U70CPvwbx6frcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967001; c=relaxed/simple;
	bh=Z59JyNXY1bhJzhN5VigUElth0S2Utp0rRQ8o37kZbzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOkALgN6Zxku9hgFlUp2/VDhCjHcncBGCFo4QLyLGom88RfhYVesQHfzgRP9NkXop2Gm9m7P5Zw8XYhaVOUUqjYS2JzKWAS9Pb/V/Eij4vqOcdCDvGX8SPckj9IdmpmbbwWwhasJ3stD3jLhObKIj42Vv3LMTQIzWa6OEbfWGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxQYhEYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841SXXs016739
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 06:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3aPHP/ZvWkk9g17nfgyfPgB0CX4dTinxdGvwP60Nou0=; b=BxQYhEYKIe6AfS3K
	limHMXVx6HXWNF9QoHGJKKFTZ4sjz8DGgYkc2x5eapJaZTzH0VdmEGh9EwYaRRES
	qoO2hZ9L+DUfMUbUETfwCeOK8XRDdyhWFp3UKtJI7Zwcmy+nMpXBU+vTejSJ6/P4
	1vLwrEy9BQRafmZPx/8WOtx+BE6qMlXTRuvOsGqmcXQaNouw5IRNUD8Ry5egXjy1
	fzJDnwp//099ITRxlI2r28/93uMCgH4rnblfNg3Dgc7MzVVQLZ1uz98qRX94jPo5
	3Lgv3GbDhBEeCxAKy6hw0nA7a1B74Uzr8VgfzOrSLngC6zosKvAEBJDo2nsOhkzP
	BYDztA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj2yav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:23:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77253535b2cso724091b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966998; x=1757571798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aPHP/ZvWkk9g17nfgyfPgB0CX4dTinxdGvwP60Nou0=;
        b=wPvKcowb5qe5ZKWOPBXfJ5NgtOSnX9faCxBKzpuADBa1PIZ5qEyrAZZ/qyCLvJrU37
         nprpb0wsp6mSqlwZIRgozCyCwc5rHcr6+JIHpNgGYqf8NKTjlqFUvPWWKAnxLwEgkQNZ
         Dm868aNCatJsWkO9lWLLaawipoH5JHRl7Rcc8Unapmis0AUGT0XuL8EmRCUEnyBJ4Ky8
         Z5GdmAGdva/E+DRYgXTt4adH4eVQqUILOmZKTEaPbePnf+WaqI7wmipPtX32ZgKWc8/D
         654bOiTtJZvTgqCSO1ZGSiWy3pyQf+Kjj+N00UxSl1ARo5Urk+260zVke90lFZdzQLO0
         YXCg==
X-Forwarded-Encrypted: i=1; AJvYcCXVPEoony4keDMRDKWAtkQhszaErE8QDX4/l9uF6n35SxE6hP1NqyR4PMGngecVRFHrxBltLz0jgTGlL4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8iiyT/AKQZmLkYiH6Q/2nlWgm/C312rvBin0zLapiQT4nuIgr
	IJoz8c5yF+NwC8835ol+F3I7qDw2mZnDUGJH3yqBb4i9cOVjVqLb2yvEGdjNp5StZZzwtlkHijr
	FLgTjnWIXxdFDG4xE7FtTPzd+hSbPMQdqZb+bynGVLwrtuGo3RvbDZpHLK7Veik6Rzeo=
X-Gm-Gg: ASbGnctyle27JKtltx8LzXMgkovQIdi3vSxk7fCM5pE69EREwt0ysKR+gnjr90W7k0w
	G+ujrguGaRJbSEUHj5SccySJxsWbf/W27OPylJcdKitguG18HfOkvlBPn7xHd387HR7jACsX+i/
	e3dF/FyYT7vBgETnwdXSs0rUhQABgUzt8gsFRrKSd//V6YJ8t7jcKYvTAjnFZpsfJUw5QT+qpN6
	n07lltHA4IzWMAE+CqnjPLECXWGQ7p+15sca7paufTkHgqa3sj9hdGVEgAHwGShuUvHROp5EWqp
	rMGLwNaQ2Cc1GmBhF4tADaSlrUzL696d7Eo8fg8hY4HBWLlNja9hOMhfAC4w2fQshZZxQQIjzuZ
	3O1Z/l/2QEHwC/4E=
X-Received: by 2002:a05:6a00:189e:b0:772:1fa1:be4a with SMTP id d2e1a72fcca58-7723e3077ccmr20997569b3a.16.1756966998355;
        Wed, 03 Sep 2025 23:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa4NYqRv/n7wy0CncjscwCmB9uKdLKscmRP3T4+uddra/JgrTA8Epohbob2gH8G3spbxydGQ==
X-Received: by 2002:a05:6a00:189e:b0:772:1fa1:be4a with SMTP id d2e1a72fcca58-7723e3077ccmr20997537b3a.16.1756966997892;
        Wed, 03 Sep 2025 23:23:17 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:17 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 23:22:03 -0700
Subject: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
In-Reply-To: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
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
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=1219;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=NNqB0T3SwC/nQPPpaZYNgmY4nF2H4V0Dr0y62les5Jc=;
 b=VwLaL7XUam8ITtZecUrYv1zURWlReeF/jvoQfCPKfREzjCQ2AE/890Zrfen7l/KBiZ2A7M5Xg
 Yj8l7EpYtyDDpdVPbtgjF6/jWSzANjOaVft5/RZXG9ozmAfzWuEL/pS
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX2OfZER5txERa
 DMAWqkI6qKllSyGlV+9MlFyh5U2LZmKos7tBqHEkcG+1Ye7DccEmG79DAxrEGATK0brcyrC3SpY
 qcBfTFpI7n/MJmGsv0ZAsqiRPTWjDyTVfv8XIWm2pUMnu/bg2Z2K3mTBwaT+U2nTPUBnuvV3Vml
 XDhxsUPjFC1oxIbirHdCrJbDh0pWEYfhdmfwfsZ9+BR2XU0Qq37VwmsGDLL+gXlOHZBX+Ijy3tg
 mtJ2naqGpg/jXrjT/Y55sgkeerXyygCcmTKF2GkWK6Ok0IUp4Ah7g2qMWem7L2Rg/+R1iTkaUy9
 HyTAnoYQcPVe4Dbt6GPhH/Qo35mOWHv0gxCuzsqO7LDXsE6ptZZO/nt8RvieKbbIXUwoklAwA68
 vUK7gkAh
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b93057 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=WgZgizuZlwTqGGW0kXsA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: F8BEio0-_w014xm84N0SJbMnfgnuj_pC
X-Proofpoint-ORIG-GUID: F8BEio0-_w014xm84N0SJbMnfgnuj_pC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
controller present on the X1E80100 platform. So document the PCIe
controllers found on Glymur and use the X1E80100 compatible string as a
fallback in the schema.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 257068a1826492a7071600d03ca0c99babb75bd9..8600f2c74cb81bcb924fa2035d992c3bd147db31 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-x1e80100
+    oneOf:
+      - const: qcom,pcie-x1e80100
+      - items:
+          - enum:
+              - qcom,glymur-pcie
+          - const: qcom,pcie-x1e80100
 
   reg:
     minItems: 6

-- 
2.34.1


