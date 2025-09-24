Return-Path: <linux-kernel+bounces-831415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C013B9C996
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35A424E3355
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBB2C11D0;
	Wed, 24 Sep 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRfSLRFd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4B2C026F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756810; cv=none; b=MreUFKs3CtoyWGCxXG8Uvm7o/DpjQ9Y0DkE1iaoHcKbwAHl85B57SKNpcm3iZS4WhPIJSNFNpFeHIpGy1P16v/XJKjmR5wD2xlmYMhmYonz9RtSAv2+XbMi9g1IJsQ11v0iqLfEBl7H8AcfTcS3EKRdGeurdsFq71ZmvfY+Qdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756810; c=relaxed/simple;
	bh=O/HsehNhbUKU+HifRVasrfQoP2B7YYk5FbQ/Y3t9EKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gaxt0DZbl8vT51p/D1d+6vewgF8x2u6+lBV1qHGvHYd5yQRic/aIOYxm2doPaFqTFaM0Ac5K6LmK0FDPLAvphggi23V2vGxdM5ZU4pZF2bB5dWoNJpLDylTe4jQ9+LmeKcioisVGIwsImyXt5nMKMXpfo/r8DDSLoakyEMbDKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRfSLRFd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCZomf002789
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZ7mTakONhQ5MdNM3TgNyHD/Jxj33wLx1vuBQG2ozxs=; b=bRfSLRFd8+s0STCy
	GHxlzxIuhN5Hogkfl/ff5dz9WBUwp3sv5lJ0isd72tyWT4nNOQ0Fog+0H4MZ+pyf
	AZA8foW55TGdkucu4CmYwpK6O4mAxIhX0H7IHz9x/hbsLqJXPslkUl1p412efYz6
	2z7y7Xjb5y9y0gzXZ7eqIspdri23Q5RELHJKT3FIPq31cHJ+xEyEMeRB7DGfktGo
	FEjD6PgmrJadc78QQ6wTkmjFFy36c4dUf3xPTCNuwUbWETUPNOCZZ1NtyoSFPy2V
	0ZoSmgFU848OReIA1TIHon6dBaPtpdevWLnTT0PCNSaFd7Wy74JRmK6Zmu9Uw4Qr
	asaKLg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0kks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f3aa0f770so559306b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756807; x=1759361607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ7mTakONhQ5MdNM3TgNyHD/Jxj33wLx1vuBQG2ozxs=;
        b=qUT0K6AbLWM5UjIVdcDCxpYasr66444XQmRNbP8fMEmoYecTfFtFJdzy+wILjFO//s
         B0G/AYdKkH+Q4oU9s0mq07fbARAbRpgrtN/QmueI3/nTpPjCXJlGsjAjN326PbL9Ic9H
         WQ0tfnwbo8TTLQZ+cPNBWRNpgosereuZFk9v6OyNYZdrdMWVhW+wPN/GscdZ00nzmSae
         ZfeglhK9WcbbTrR45HuxS1JjsBWRJYWbYt4KjdB4cu4dMbEDlOOydvOl4NdPgsDJAkVu
         iEVtkwYEUKfgpoy7NQ+1pyaXbLeuPtI+fwpFGXCNRN5fs2UzmmGq3nZh7bvjaLmqJ1WT
         tDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAishOUdBFitCfaB1OO10j8T5ifidu7EUEKZnY2i4aamiAK4+DL69iKu2ANZOYxn0nlcpadhRgQ91kyEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzosKRh3mvz2uNeWPYKhENS7fjGQ3rcu+ERLGT8Se1FbRWLfAq3
	6nFHDDy9ZRdDh95DPbF0kfTHdKstAfcoPATwzKfV8UOG2nnXNRQjNLX7J7c0KE+FlRKKE+tEFCj
	wtlsNw4ePlUPODZs86+vhaagYHfSHgOojORV2ESw4denorQ8lzKu/zqZyhMjUXhg/J1yCGUWt2C
	Z3ew==
X-Gm-Gg: ASbGncto0O+63zHmMRstPHssZwRCzSY3w6v9Uo39n6C6G46zhQjybQ62SxJ5cmIgWRf
	LobddyJvd+V1hP3yYTAbfZJP/mYD1A8tG6A+pvirqjsfxJxZmb8czH/7rsKSPA1eoFnyC9gcmkw
	arMF3LCVov7GMkYnreKru3Cu9CyuGL38MIEHKKDc3rASaXIob2Z6l91Tr7oNPoOYdwQRlriq6U3
	Dh7I1EPuamFNKZKJVYYp+A6JKUE0IGjz/qRWbJS6u4q+s5dqaxmPT54FtQvvpQ2NiSdWC1HKtcZ
	BlK2IMG8DUmWqbGAZei/mmcXTlP/FjylMG7ckA4HjWbAtm706gb20NMZtY6zcjMquNouhkf1hS5
	VdofvlksjQMZTsxE=
X-Received: by 2002:a05:6a20:244e:b0:24e:84c9:e986 with SMTP id adf61e73a8af0-2e7c79c5ac6mr1705028637.15.1758756806981;
        Wed, 24 Sep 2025 16:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEShs+t11pe4EXtyJY7eq7SxJOc0SFTQM620l2aSx6ms55iEGfKttzOhfcvzJfsawotCzSxCw==
X-Received: by 2002:a05:6a20:244e:b0:24e:84c9:e986 with SMTP id adf61e73a8af0-2e7c79c5ac6mr1704997637.15.1758756806571;
        Wed, 24 Sep 2025 16:33:26 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:26 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:33:18 -0700
Subject: [PATCH 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Kaanapali compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pcie-v1-2-5fb59e398b83@oss.qualcomm.com>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=1501;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=VBW0kDv69D5tBQeRfHdrmnRiouQM+MGW2Y5Yg0f+6nA=;
 b=NL8BNAGHotEw5Z8jTwt29kGlC7TPmvyCyt7uA2v5QZBwSr1NNNbXHgBi0hJ1RrPRJppICeJ6H
 tnVxRt4czLHAAovxAHOk2m22FOAjgZP97+p/XohA8ec3N6cNZtU7gUc
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: ZgilZieicRbHXBiw4fBLa55jOi9FVPsD
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d47fc8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ZHoeG76OixanZ4sGZTsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXwQt73hgNPYet
 ZUJ2YU5tzg7LJLaCJ41jwZE7D4JeVfNaZhUYv/B7dV0fiCMcn3+GlQUVDKGhbAOCtIU0e9XNRTD
 WpAstBXQhpMvsXFVuozE25cCt/EspCX6DmUjdwGQpPQdRWB2bDjk1VTmI6j60FfCfNa74bxRLu+
 EF59tC7TJ2f0PLzJ8n40ZQUrfO11iPWFge6eKRvnuiuU8NKxN5fKzbdEqFGpc6/liu2SJ6lBBXF
 otQX73rwb0O03geZTDTbZQNAqDsrc7s7CB7tqwllYhHLQzPjzyvNcgVZpymVUEZg+GhBFbfviRL
 LUsBV3LL6Ke7k3yaC+EdUln5ap+1Hif+DqAwCns136uEIs+X1XZGbNlSTIqhsx7oCMQZrSDiytz
 IzJvtSF6
X-Proofpoint-ORIG-GUID: ZgilZieicRbHXBiw4fBLa55jOi9FVPsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Document compatible for the QMP PCIe PHY on Kaanapali platform.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd..9f7a276a84ad 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,kaanapali-qmp-gen3x2-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -146,6 +147,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-qmp-gen3x2-pcie-phy
               - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sar2130p-qmp-gen3x2-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-qmp-gen3x2-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.25.1


