Return-Path: <linux-kernel+bounces-824626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65720B89B18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BE87E7435
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710032FC03B;
	Fri, 19 Sep 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cflv8X1X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D119DF4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288902; cv=none; b=Hv6uNP0P4YGL9TxWhPkc8O+j6caqLCywX73t2iLn8qjTWls/gkspDRI+VFttCBUPNmiYk6crjnJSNqhpUUx8xXr9sT5Tc26fJa6HPfdIf+Gb/C1pEYYmi4oVq66Avjvb8Ds7MhGNwXuQZa5BKFwrQ1H1sjkBHuytVaCUEv7gkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288902; c=relaxed/simple;
	bh=v1yecXK0KbtNUMyqkZ4phjSC/lp23KqCyTR3rxB5ioE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vtu9HzKu1F0Yp8c106SeUfWLsNe6Zb3mx8Uzp/kxzOwrl6Og786V0679k2jPBKcbNnzOa56uiNuy2PXKrhOsEU5rU5QL19JJ2E7UfnFMInFBNta5boz60CpadQ51ZfOncJGPKcD4PYKXcnwGTAqJujVjrHOunMVP09xcp7HnCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cflv8X1X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JA8W80003340
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LsohKq/Rcry2lOpzgsvKWq/Zyk6Dbf/1HfO
	9XNIHJ/U=; b=Cflv8X1XBA878cmFDyF8jMcedeFgezI4IJyz0GSsHrNhRxpzuq/
	XHBzVq9AyotS7Jp2Pw2PNjCwUS6C/1kB8O3zUXNelc/pCwK4Ak2rH5KhrFNIqTji
	204TOCgdXJOzJp6Azb9Txd6V0oXhejzRKENVT/A/71Mqzn4aRI7X2Hbz2+ZyIdGf
	D8TTOx27O/gN/sQ1LSLDRBaH7voMd/ILyisBmFsjegY6Bq37zmUUOgxBsaNwSJbh
	ZIR3HIYObO3oPpmT8cIdPh7PeZ2M+0zpIvY//Lc9EpVHyjt3L1jip3CV1OgsEItE
	1cx3f4qsSsRRkaHim8Q3zG5w0Je/S6OwI0w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqh040n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:34:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so3214259b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288897; x=1758893697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsohKq/Rcry2lOpzgsvKWq/Zyk6Dbf/1HfO9XNIHJ/U=;
        b=K5FrIL7yso5YKhWMcfSwpCEk9LkOHU4EGC/GSB8RcW8c4bVQ+uIHt0r1qAPZx8nK7y
         T+UWUDXWzzEcHbef/eCaQ0mY8WfNNOrQNHZI63QTAbgH+ayMZ401YbKCBgoLpW4DwKaR
         MQlJll3t8gTY+hTbDBGrtRdhJ8eLO+UBy8dw5oXbpwVmGCFi/pXbF+ktKILvHUg6viXv
         bsMfAq0viBuM+91hVyPLRW7MpEnxf0/ukUzxFR50HY0CUQuzWf7AfI9XMlyOKM6dEhTb
         Z2ipXXtFmty4kQQH0RDWcnKjq9GMRldTt5iAEJE/olJuKax0zoaSX9SajsR2DYipb84Q
         tY4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7mslQ2ahcn2X3W5+1IC9+25MJOdhgw/KzkjieGOdV5aw3xiTRLWJanb/yjLI+Nco5bqJ+HZWHm0DC46g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS58plI7TPQ6x1tOQ05Znv53ABlXppfDmhMmW3paeRUc8g/Nek
	SAyDu5j7D62a+H7N0pxI48QZjF+amycrwuTMykmLxP/c/NMTe+OAT4avE5yrofr29ZamMWHeN93
	EqRt/z/qZZQ+0JwSUZG5CPd/KLAoWZZpL8hWLp93JFlWsZIavS4Im/31qzOcrd4eNnDY=
X-Gm-Gg: ASbGnct0CfvB7aoZSWPZ84ffYY5SiZO/65NgRdhs1T++H2hsQmoLrpn35HmkaJ/vvv8
	askBC1mWonVefiAixPI/r8v7NVgtKysLoPOoFK1CkrOvK4WrDHnx7rt3p5/gOPpKhrX3mE1xEsS
	StpmnfBoA72JCPLrGYbiM+asTNFT7aXS7po5u7aNBuxqiXxlfyoSmKTv+N6S8C2Zb6iHHenXW/f
	otdjS3Dy1R0OwpNXdzG7XOmrBC5pUPspTMt39/KfiTvYjV1p1PxgpWlHbTxngsXTdBCEnVkGa6O
	71EY5EczKNtukKmQsqtaqID1MhtNr9K6okrWVLOiXGVoEC+Ow+/LTef/k69A5htZiflBDo7MDEz
	lkYys7tXaHGsnEqxsnYUSPuuCNmtIon64NRCkCagrMWyLRYq0S0D6Y2ANIwhf
X-Received: by 2002:a05:6a21:6d9e:b0:283:8139:b613 with SMTP id adf61e73a8af0-2926d9da17emr4653046637.35.1758288897376;
        Fri, 19 Sep 2025 06:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO2w6MVcEvV+deoS3kv/zg7PSgK+W96l5OJ7rnwVpM9/jXjSZoCX9M+C/TvZkhd7xzo1aF5w==
X-Received: by 2002:a05:6a21:6d9e:b0:283:8139:b613 with SMTP id adf61e73a8af0-2926d9da17emr4653017637.35.1758288896951;
        Fri, 19 Sep 2025 06:34:56 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55219e34d5sm1558940a12.7.2025.09.19.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:34:56 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm-smmu: Document Glymur SMMU
Date: Fri, 19 Sep 2025 19:04:39 +0530
Message-Id: <20250919133439.965595-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WXyPklEaej8wy12NX1PosDLgw7Nm7Gxd
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cd5c02 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8Rycb7W9lGZI8AMxJXgA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: WXyPklEaej8wy12NX1PosDLgw7Nm7Gxd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfXxNZFRQGLKT8I
 AyOgH1XPg9E8nKZkOoGhazei1t5KjpA4FcHbzifbddKcewTOygDEQAEmoNxQCulFlwfi9d8PLd/
 k2oBRYj/xUieXNM3UT2M6f/fmXHpctdLlLgo8X+51y/C7WO+5HUn6kT7F0Fpm+NHnOOCIBYfKz7
 z2kri1sc/cnymJNtJ4erNWkudebzlJJbHd+BijJUNy6HsgiDt1N58fjTtdRqPzd1iP8d8Rct7I1
 LThIlT3jm7wqWfJhrBs6/zSgUvSXHt3G8QHkYcc/FET6KDk+D+mWv0DFQrldXfwnL9a1i6g4Q+3
 bodo711YrXX3/5ALfTRUMkZPEtaRtaAqf47Jgh2K9Y32Z6/WsIyS2XOG0l2pDBqc+bqKxV07fx0
 DGAWyPqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

Document the compatible for Qualcomm Glymur APPS smmu

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 89495f094d52..6543fe68a819 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
-- 
2.34.1


