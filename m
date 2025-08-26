Return-Path: <linux-kernel+bounces-786026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34629B353B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7811B62FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E92F4A1F;
	Tue, 26 Aug 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AF71+VjF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAB2F3C18
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188190; cv=none; b=CQ2QKwc6vFFXi6a2fBs9z0xjoFvL2Qc8uLarh+9xx4AH3W0e2CnGUZ+3fizS7Zzz3YS0yw6xMhW0uOn1BKPuZNBagm64pZ+8ZokwCZtKSw1QLOGG0rfSvD+cfVFOg2/Gfwnw5ECAy6I0sMIs3ew/b89W9vRPyYQqwUxLAlXjKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188190; c=relaxed/simple;
	bh=bK7IjrY7RIF7sDIzpn8NtOwFgdMSpX3iA8qa1hyDEWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a53TM9L0VE4CP2p0tNg34pjLvZMcTaFUaj3Xdc+SomKwVASKumL8Mwaa08Ei6pttcousB0nPqzuUrp2z6f2nf8Vya7ZA4UFxcMosE80QSrJ5Ezmrzf5RCmDd7Gv08xJaLAN3ZMXbPoKykjhEX47fQYGDG7pPRRh3Tdh+pN2QzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AF71+VjF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q3krgl010519
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c7vY6EzZz6OX3dW8SAYR/iSAmvLfxB0jaIKM7TBpzz0=; b=AF71+VjFxN7xHoaz
	Lz2GeGUquY7+D1RICUB/r8FvWNlKFs50iPVcTTXCnwYK2272zd2dWYgvKlhvlkje
	gIcZg629Kuj3qw1CMYuwjnsCj1865MDeAVqadSV6vpKgE7BeqHMv6OSsTtJYcI/w
	yG8keS4q7YGQ7D+fWnZp2ZmG2gX/1J8OJ2hkcjTqAerUFilP/vo1xTcl3UEUEN9Q
	9QaqAmoKUhnEMcQqyMvdRrrJV0wYiITOIpD6cayecKeAIvPI7bpaOmQox0h892qo
	u+jjuRX/BrJ9lHsxh9kt0eebdXgRlrqOpchnBupz4Pi8rPNMQg4lqAU2ufOargNL
	TQ/j6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thyne3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24636484391so41514775ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188188; x=1756792988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7vY6EzZz6OX3dW8SAYR/iSAmvLfxB0jaIKM7TBpzz0=;
        b=JHG9ppO9TazAR2YNiqXVoTlZHJzKvqy9QdO5RJr69HKiNNeSmc9r3mMZytz4opQLvk
         G5pib25Eg6oC/h/e3W6LnAHRS/5YQ7au3wddB9fOvicdQFYLnpFHA5EN9pQjxkENAFme
         PUmDGVlw88HEvlFSJAiXa6DP8mPMj9KgEvBia5lS0q5jUKhBAbQR5bxUdB6L7miHDra6
         TusKn4DS1BeytGM551nv1GSdcP7LdYThRVlDlHW1jkCOXHH65bNjt2NRtXhAuZ5yHGT5
         H7P+C5tcUnGdSqqnNuksRgdScYmG/3FvOCaKudIZELKQBCzJGfeEfPVMHLnBJ5lJd1oB
         KAGg==
X-Forwarded-Encrypted: i=1; AJvYcCVerytWL4jLo1Mc/gd/xp4z4TGyrSlV9dbMbKtUihn07jNWOJzOg2jZmlij+8lHIdaFjNe3l3qcxfbFY2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfbm4IOG6HZnQG0vMAl/+VwDVwa/iSB4sCPJdcG9G3G/rajt7
	xilJSMWSz2qSWQVDDr6GdlFeYtDKuUHtxCwgEDjLHamKKl6QVGO+GUI47SJ07YxgUaDprOfXhlt
	r1q4DbO/epPHpRRp2vRqmbmeW1sIj7p1HppUW+C2awkkMUuNgLsn7HBEuhnc7FL/G2gQ=
X-Gm-Gg: ASbGnctk98YVEcxi/WqGo2ZHpO5s7HIEu4kDVZ/2WkvB9nqt3313OnQKLZMjgZdsy4X
	ueompfqRCbIiNuQd10q4QKnqoFkORAWWUiwOS5ZD1Hd0PX0J31dUVVO7933NRFa2rKkYBsJ55sT
	YgVirD72fzgAvnbaH5L/gem/JFhUeJNHnkPsbvECHEaNkhypDQj1U2FJfSc0Dzm32IExggXlVcf
	aPTtHgYohza1vusRaC+fVpNyQxU3N0SSG4/p4m3FOAdQgTeqrdPdXVh7NcLxX32EeHctdfkt4Z1
	yCnNq6N+Q6mUDH1bn5Neso28Ed/KPgBeBGSSqdA7e14NCiRa4Q8az228VyVPBFcnSjRVmkQ0qXh
	XITIXuuvLRsvO0wE=
X-Received: by 2002:a17:903:1af0:b0:242:460f:e4a2 with SMTP id d9443c01a7336-2462ee54a58mr173688195ad.23.1756188187826;
        Mon, 25 Aug 2025 23:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm4pbzLBk/0e4mduEsQN/9isTON0Dv+q5J0zKrA/VOOs5zXfa7ktJR6RMVvs1bvXxEGMj10A==
X-Received: by 2002:a17:903:1af0:b0:242:460f:e4a2 with SMTP id d9443c01a7336-2462ee54a58mr173687795ad.23.1756188187330;
        Mon, 25 Aug 2025 23:03:07 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864431sm84989705ad.93.2025.08.25.23.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:03:06 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 23:01:47 -0700
Subject: [PATCH v3 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-glymur_pcie5-v3-1-5c1d1730c16f@oss.qualcomm.com>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
In-Reply-To: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756188184; l=1643;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=oxNK7rpfuxJFlxeq6m4yP+Aq+2bgn1813OA7/GzY/5Q=;
 b=MZ8ddF79PBfDlVHSJattDrGGBwdp99PB0M+w5COnVmkky0eJV2DGL/c2eFVLP5DdTGOrbvOOY
 8oF5DsRhWCFA7Plr5/q1FeyT9puSqYtWLsZ6O9oWeFKcFVYFh5a14aj
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfXxoCVU6rWk1UQ
 Z58aVuiHIJ8k27bmb5d7mxHcMw2Ydnv1JbbaZ5GdXOMR7L/pTmesWUWdvsgTeiNdLo3HWKOie/J
 53nJ+tBdFoF0bkHhVzt75+JXpcig4cOU7MTE7loNc4BAkg5eTJF57o1fdI+yZybY8KH6eySqvZe
 div33fz4V4S7j6c4gduduDHLSrDLWVrB2oHQB1NkJFqdRwZmmn6qkvLoy+9+Xd5KszL3kf3b850
 u6m3a9FZ28dQfcybMOh4HE80b9gQ/SzUhYXbMKQUFm/bxaTy38dgq4JVx6uZoC1F/hXAbpKuxTf
 pA04r7x74Hl7OoVHSpMDTacFmJHd1x6tO2ek9wyI4XbT+CI5czECIc0mf/47s/l02ZBXGqef69W
 AHF6o/vb
X-Proofpoint-ORIG-GUID: kBFAqI6q1p6g942VHdZ2JYzmhfX4atK6
X-Proofpoint-GUID: kBFAqI6q1p6g942VHdZ2JYzmhfX4atK6
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ad4e1c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


