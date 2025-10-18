Return-Path: <linux-kernel+bounces-858913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C3BEC3A4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 552484E3E16
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859D1E00A0;
	Sat, 18 Oct 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZFkYHsT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E61DF73C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751228; cv=none; b=DZaTJEWpyYn17g7M6fkZVxxP+MfP34HHxcnYgrh3lta/ETAF+ibQGTyNGg8Ps259b3dW59YUX1FFMIJOQhkBWPbjd+lz5D8q1ZNj6NNBfYUPE/yizojK3gVQfjc9jH8vqBHafssoUThEhaIHnxCJDEzs43ZBrAh996ptFsKuIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751228; c=relaxed/simple;
	bh=buXpzzB6V8sEDjGSLlS3HLSwcvy9LS6XrxQaYUlSJAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtEXzVFdeaN/DTZGbffbaDV/DpZl4TEK+gMZKLBn8uSG4M8ieoE8VhDj5O+++iZdTFwk/I5veJu3idvz/9/6mQPculC6F6A5yzzIohJjleEt36bVYF3NwR1cqdHeYzMUYCp+uxqaCP+Rci2L1XqJp8pKotgWvl8oYlt7wKyhEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZFkYHsT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJG7V5023275
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nyHt6+e//Wm27OxUhgiz4v3Hh8EOKz906PnWuB/Ipos=; b=WZFkYHsT1Yal2fvx
	D1iFhNbGt0819LtqmCDw2K0E/LG0hlK/4iL/pDtyOLcd+3gGNN0V0XOQ/DvuM3fD
	AMmV4m8kd3PJwmma8iVl/b9bWPiOk3Czxf6q+y/LDrZj+l6CbruIkR4gCgQt21le
	ecTpR4CGjc6ga2x49j40NR9eRyCOJWQEUJ9b2XLqe7oSneE2Gw4atkm0SzrODhkA
	82Dpl7BBtSKOyD1nRRBz4S2i6rLaJrsLisrECY3q5ubTQaHxvydolPkKVp9gsYx+
	oTGsvUfvKjex4s+iRBC+/tzSPPNhCEeJG6uBO2OR3Qhknajy5fXSqPBkDIYudodn
	FDleeA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpqkdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3304def7909so2130734a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751225; x=1761356025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyHt6+e//Wm27OxUhgiz4v3Hh8EOKz906PnWuB/Ipos=;
        b=Ab47TZfTGbSHgFSTT5BrklQDcA6aKk+4rn9LlrmYaA8YvW6lnJvdSc9mWM5B8Og4Xc
         TcDVu7rJUXmivbBu1oTlNAZiRv0QCEkbjpaNr74IHydszH0pYTw/HgnRcg8KbCfIqAfc
         +pW4ngsTrhe0cPmmOmr618vEI8Grtn9c5gd7z1z1Hl+Oqqp+wyPHA/yqrc2Pilv6fgi4
         9zVJ6QraBcylVDdWRHBszp1AG3IKoFeHtN+MVctk6L2tGXQ+PYqmShe22IQGmg+VV+oB
         BzPQxMgXgbhMoky7kdlQ4/YaUiQm4thCRlxyP4Roiiln8/Qd1JRy27B2vhA0hrCREF9q
         fRXA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZHw2bHE7lEDhPePE5cacD+xXWgQmvE4fDD9Rp80LZwIgzKg9Z37mxMB4YrcREeGX/HA2kqUmvqegoQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nCFX+jVWD9BnuoMdlTfzpe38nsAseZ134GbJtm9kEQRoxWRo
	oQUO1WJPcXkAEqvR1B/sBdQathuMoZZYv6Hr6/b0FUyE4h8I9ZHtcvp7J5RwFA0Mr91l2b1R806
	ah3hBLGvix3mG7S9an42qF4fBRicekndk0j+sCXK5/cSKNuKF00kTOlwvzaY688pJJ0s=
X-Gm-Gg: ASbGncvI4B/miJaSyF285kjWjOSoh8WBG63SVcSOVYS53BjCwfpbJEZxYVJrr2N2EsL
	pV2BeT8t1BhZ5ujuC/sIAXgrPUXAjczxDh3xs/iYNuKqWSKpokQl65moURccZmrZZVk1WP2WslN
	wwghVo5wAshmGupcmyX/0Y2jtxSpnVEhkn5cJjFh4kN4cDX6zYnV1r+Kx/aTHiuzX+ur8isKNnc
	UPEVVC65yCAWU39avL2NAwV3zcqZbkE4u+3GHAcStz+weJK0EJ7+eL4JfsV13E27HzkajcAvdtb
	/FudyzLawFPnjDKMJFU9KpGhPTYoT2WENAxetHPRF/+YMQqDzrV15YIjqQ/sFv3n9ebLl2V4yma
	6GzJ2Z9VvyHw6hzK/S25Ijmx5wdBGDZvrEi/TLMP5cnCrTw==
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr6171153a91.32.1760751224676;
        Fri, 17 Oct 2025 18:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIKBsbjRuVOEEafzTskcxI+RIZweN4v3yg7SFBNeHWuxqa9Up6EUtbI6hu7qPV7UnkBxYrVg==
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr6171120a91.32.1760751224239;
        Fri, 17 Oct 2025 18:33:44 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:43 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:38 -0700
Subject: [PATCH v5 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-1-82d0c4bd402b@oss.qualcomm.com>
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
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=1696;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=ORqLDn4tPxAJKBqLDSOiTLOmLrdC5p3+AUzGMEo0jrI=;
 b=CX/0QSCszI3KvpDNAdbz5w/KezYYoQGSTW/BMRP/Y/UANFpHNaQ7g3fYwWTse42LYKhiCnKtk
 yMwkgU4A+l0A3wrq190ZEWJwbKdWxzkI3EjKDLU/hS1jJtPSuaOGu6T
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f2ee79 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=prgL3jgsdPShhDvlN2UA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX4yRl5eHnVIGF
 16rAl7rl3vqGCRX2yLyZd/t73NXqg9X3FFqAHqw67MWBanKo7d2Qqc/JYuioF+nX68o2FUCWNMm
 vV1mFNvSTGc3DhnHhUBcuC3WC8i5ti1bDRdGH3t4cpl9Luuc2NB/AQjzzveUcBQ+AOlnqjcVgYr
 /SSVLYjeJml5uiS4M/KQW4ivYWetCYXmWYNH7Varzig0LB7LQvuIIwprax49fpBpM41Kp+iCEVy
 q4di81x3eQXdOvKu+xYduDHoTLLVk3ZZEyUjBnZsSwbNG7coWvGK35v6oV6CQoEBK/UTdPpxDCt
 qwcMcHFkr06I6Kk8LOPUF5wSSNPtDOvlZFE+2ot2Am5Jo9RaGGIgja8B3UzV974OuyFfYYZKtUQ
 yB/0m/iR1FKrh9MwGn21m/i3L7qe0A==
X-Proofpoint-ORIG-GUID: tzxI7Q_LtsVPVVPf0BJ_vspjyhvceYid
X-Proofpoint-GUID: tzxI7Q_LtsVPVVPf0BJ_vspjyhvceYid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd66fe59d91c377449d27d2f69e080..3adeca46d9aadce103fba8e037582f29ff481357 100644
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
@@ -178,6 +179,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1


