Return-Path: <linux-kernel+bounces-786502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F405B35A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1A568419D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08468322524;
	Tue, 26 Aug 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jahjgjn/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE946319866
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206199; cv=none; b=jjSkwKHZo22p4DOz8LS3ObGMMmxxYZmSwFiLT2AFrh7VBbj0xjJxn4BZOk5dwGYCL/XVYUBP//YDIJGB1bPgBl5ktQvu+t0egP3qqZi0xf0xP2H803CDT4l2gKcV6+ThpYi6AZkDSOpigSRl81ng4XUJUMuCKK55c/AWH1ZycE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206199; c=relaxed/simple;
	bh=wjx9GMHTJv+sVXCnnpOXOAGgSyeX0KAgl8FPgsVCss8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3tC7vrm8ubReRpYvtaZYSy3ypmaM9u/BJAeXPG5yqYeK27tcDLkhggzARCYsKMAhmpOWiJSS4kEEe2eu/YHPx9RhrB0a4q4yu+XrKc/aWJ4K/68vxSpHckz1eDbrdA93WJB3hRuVjzoO7tKBUUaHIFTBBRZcdp+h/cv/E+lSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jahjgjn/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q3Xx4L022063
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+DPSOTrO4cYwZj0R18ru4Kcr+olXie/WQj6w6L3l2ss=; b=jahjgjn/kxh6JZTo
	n78k0lULURc8IHG/Robbj7CS9D6Ss9qepDv0yicP4w9Q1ahpv9UlZNb54wuGrtqu
	QUd0dBqXPJvHfP5MZTWZZIh6yisFRFZKXoSKQ153mLYOdPNHaM4Kfn0IMDZuOe9t
	idCvDWytRnisTRH+IhQJMG8a3IgYDmMvA9CbpCItsGw6vrtdAKsGUer210NkF/IF
	5sDZQxyL+tyN4Vu6k5OyBOeKBLER5C6KsbqO1zdA6vQeuygF9g2LZ2rfroTY/iAg
	j5SRGZIt/Q990yNdOHnxW1G+lWjEtGConyEJbv/r/WKjt0lect2qmm2rcA239SQ8
	bBFItw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x88jun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244582bc5e4so68277435ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206196; x=1756810996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DPSOTrO4cYwZj0R18ru4Kcr+olXie/WQj6w6L3l2ss=;
        b=hpnDE4ll+8/cYKsN5gWGsbBQ6OJADAi1Tx6gTnQCvR1oxo7h3kK1/5FmEpHAIJP1md
         6150V+0Wh4fpQ5m3ze05QCt18nm+QbjiBAJj/nD2zLgALK/WZktHZV1XvM/DJZMxk5Xn
         gBLakzUqJSGXismrZE2ENqrBxxd22XeP8hNS4yaObCAM0RIoRCLreIOclCQkPTIBK2Kz
         iIwDW+jvtzxqGIOlTxVdua4iHof66/LTUps/9Sk3bLCAKu3qFGhF1c33Nwvv5rvpckXX
         yqx61JC7x9m8puAUtISbLFFG5WQUCTNkC6eTCd5NuOKQIJfDnCHtz3gdzaxvN7B0r8rU
         SQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVFZpWsPnlH5mpCSt6zicEB7N54RsJz1/R1zj0TqV8no/lBa4wHswKpBaRpWNDsoRe19Ck0uiX7uo18hSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWv6g6omHPRZT3RnXUWgqoYzlU4BkypwA++abE11nUxHq7Ev4r
	AKRvlapbeEPun6erJolZvLHu69SCK6+rp4Um8773E06iELR2IkdQ/xMhLD4zTeFPSyrAK6Jdoww
	jipiUNmPQWI9UjVRqyeNxJ8AF09HOfA+dgguntm/5aYiZE/MLoUo980lucnTR5kpSmrY=
X-Gm-Gg: ASbGncvK6cnWVLmz9nSC3GnQxTHiPOpIxLOra2xoNs3gC25tTuULx6flrtg2xdYYpTU
	D/wdI9T7RIaY2LAZ062UIvS3AFhV5e6ZkwQw0uRDElqpFRxg1aMMXDYpEwYZEtBFt+ERWMhtGl+
	T//q1P1qsyFAGMhyTAMx2qwZXE8DgeibNhG+lcnQtGbFzQd1kM+G+J+KQZwKltkbQn2moID5MF1
	h/rHlS/+qGWzE0ykRO7hq2KEyu/QDA1jDvGnrWn+MdtMz7m5YVspkeLWza9TxgC+BW0bPDsyJqO
	0Y6z1W24JM/3E7jdPWb/1SuxLrfcMUJOokUgFbsGTLNIumTYxbF8zENFOLle1x5WMA8DIy1l/UU
	=
X-Received: by 2002:a17:902:cec2:b0:246:61e:b564 with SMTP id d9443c01a7336-2462f1d82c4mr184211995ad.61.1756206196103;
        Tue, 26 Aug 2025 04:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/AZx3XW6vrNMBVNQNlwghugBEj5Jl+a3IPk5UUCn6++1jKG/5K7QzZFQ/5XN3S+gDRMYRg==
X-Received: by 2002:a17:902:cec2:b0:246:61e:b564 with SMTP id d9443c01a7336-2462f1d82c4mr184211365ad.61.1756206195528;
        Tue, 26 Aug 2025 04:03:15 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a5e5esm93207955ad.161.2025.08.26.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:03:15 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 16:32:55 +0530
Subject: [PATCH v3 3/3] PCI: qcom: Restrict port parsing only to pci child
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pakala-v3-3-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756206175; l=1564;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=wjx9GMHTJv+sVXCnnpOXOAGgSyeX0KAgl8FPgsVCss8=;
 b=C0xBQUzGHEvIUVnt+TDkqiJDzJlJ3dBZwRdN3YqQCt7Cp8x8kuf2+DS17yh6DcNQNE0FJYI5o
 XBtet90TSDPCSMC2G8ETJoAda/ei6+0M0XJb054TozCWTN7TI3xe++D
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: wfO2LRBqhIyH_pAmXp6yzRrPKY_KjwdF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXxrlAnQ4SrIjL
 3+6PTXrMH7BGHfx6ePg/H9zFtn0rr2In1z/2crK9J057K+mH8G+q9jOaLnrL82f+rfR5sToCKcA
 3oXsISBcmSmheK3qrRnkLYEVNgLNDPzjqecvH5v1E/hUBvp7CiDaQcQ+8+bAadfyQaLjpdY2Lg9
 N6Vd7IeeAiXhGzQBs0F5eZTQxhBClPCBfSxzHlyw3hexvFoAz4ZsPNHl8Qa6qLe8S2ETOpEulq7
 AEmPd/q7Vs5MRq/1yEhBoZ9WbX/pWck70kUOunn4ZE/RVB7mFUOV6zT9fNnR6T/kR5zdL4I0TV+
 4ayR5cgNstAhu8SJ3DGvW+wz4HG9HDElN8ar1iHEUXZAdSeepxEWn1AP/P4vG9CR9pjTh+OJFpc
 Sg4i4FrI
X-Proofpoint-GUID: wfO2LRBqhIyH_pAmXp6yzRrPKY_KjwdF
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad9475 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

The qcom_pcie_parse_ports() function currently iterates over all available
child nodes of the PCIe controller's device tree node. This includes
unrelated nodes such as OPP (Operating Performance Points) nodes, which do
not contain the expected 'reset' and 'phy' properties. As a result, parsing
fails and the driver falls back to the legacy method of parsing the
controller node directly. However, this fallback also fails when properties
are shifted to the root port, leading to probe failure.

Fix this by restricting the parsing logic to only consider child nodes with
device_type = "pci", which is the expected and required property for PCIe
ports as defined in pci-bus-common.yaml.

Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..fbed7130d7475aafb0d8adf07427c3495921152f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	int ret = -ENOENT;
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
 		ret = qcom_pcie_parse_port(pcie, of_port);
 		if (ret)
 			goto err_port_del;

-- 
2.34.1


