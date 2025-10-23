Return-Path: <linux-kernel+bounces-866519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C46BFFFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B09188B608
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475E2F39C9;
	Thu, 23 Oct 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NacakziX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF93019A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209090; cv=none; b=rtH41CaLSrQOtY/+FbVQ24LijJQS+7w7INuWJa+gaX9JwudKtBpi0L1yPS7RtPqHXDvlu8Jzesa03MDl2khQgTyQl6U0zfC6J4hn7ERXDc1bR4fUwCV4UzJTpxEHxVPd8Xjh9EHUBEar4qysWJj6E+svQcUqIwVnFJdGfgTBI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209090; c=relaxed/simple;
	bh=TzxMEAEvBvay0xnUwiJ4rg2i0h0+YPV0RGQEHFd6Xsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B0y1kgo2v1p35Cq2zfm1FMMNSottAyIYPcX5YzFVzANZKWB+I+nOAE+UOTuRopNXrJhjU98FebCChh2yPJRpsCSYqzL5oAxU44MogO+XEGjZbeJINdeZKNRdBwhp0SkcH2YWtRaoYQaSQzB+8qjzMutX3BogIHMR3IHC3qDENKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NacakziX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6UGt6018586
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eAilDezzajor08e+n9AuRt
	0YHOook8LfrgI0jRV38Qc=; b=NacakziX6eeQ/vHN2PjYgKzwr7Dfv0bBDI2Sqj
	yN5f3mKZdDRmf2FWbQzPCAKsKTRE8ZCqWoXtIuwBrRpfJNIhhH7kVz71wlTFO7MR
	gfGDmt+rTYBhhEAMW/tI/TEBrlo7tekb3f/QDGCWOfHUID9WMKuMm9RFheKx8nbL
	KmryD+bB29247LS5m0f1uagsp1Z3MLc/jqliCN8U3b2d2HJ1s17BhnxqAdbMuJeB
	AdUOcz9+c6+a2EUtA4Orm+7/ZyYKCG08sgvJorJg/dbRszd0c6Byuuo008+J+0jo
	yUmZokCWG/U1Aqrr9FhhO5QAAyr291fbPBJA2UEU1rwTHrqw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pqwje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so449649a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209086; x=1761813886;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAilDezzajor08e+n9AuRt0YHOook8LfrgI0jRV38Qc=;
        b=p2Hidi7ZbF7umM9dAfZEtZBipKFqr55837FdKkvqqEB0Tq3/1ao3BRBdGabbrZOGw1
         hB4QcQ9ohOegeRnYCxXKxIG4TvRBtGYiduFyqr6mUdZMMyz+mpsLs2PoieagD46mavCB
         0pKDqL9MXxYBakNFOCihoOMshASJWLryxsFl5C6BR9N+DEA+FeNWYc5cfvGc146oOW1j
         u/LBCfojALOYI+GOVWKDbIIBXNibNZmfd20FQA4MITVTlbNskS+79u6f6I27CxPhj49a
         MwJAaNxdqwhZdXxQjLAkBISFqrxFK94u9xMJQ6bSn9YCtVj/4J/+IxLOENaQRau7MXfR
         3MZw==
X-Forwarded-Encrypted: i=1; AJvYcCVj34jIT6F6+xHaL+LNskOkZ+RhOTPAeotOr2Uz20DB+LqTmtFLJwT8f60o5O39gQAr4XTqswSrS2Z/yyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSOaBllCyo1p1DLJr0Uiy+CgLFr1RvNUR4ZBIqC66oZZjj+Hl
	FYJwO/+5H9btkh1HAe4k1fokXKdIKAk9sp+TCR3LS15TU+bY8Wn/+vsdpgEIzt5B56crQqEE5d4
	yckMKlq+1idR56mZN8Ko92XUdX1MyjupfvT3ThnBCY1WuYw93qBCb6TAG7eV+qihdTezeEUm2fI
	g=
X-Gm-Gg: ASbGncvTuNAeawRg2BcOUpl5DrurcndzO3DjBAGKFIvnNqC8Dg4lkNidrJgO0YXBZhq
	qAgZ+vwmAp+s7oJbjb+yHI3mq9Mqs/K9pmNx5uYGNRSeoPqb0BvFg1gdOh0Id1qOX7UzTRjqdyH
	IJ9xwV9/A8mndRUtA3d+SopgP6LQOsZcahEGm7NUGft5VmPjR44mE80B6oprGtmqjO3eSzyXrSO
	Qp67+C7hZDSIYHD7tCO7on9vHXgPLu2v39ChQhKcoCP9aGHomBzjWbD1R5bL78NmYbSuDwHlvUS
	i/ovkis56+UACNjs4Ysx227i943pLep+JBb/XLcabuM9VUTI7TJXNGBG6/aozu1l0Zhg6/OZBry
	stVwEhKySf0tOLpYFSHqtoSGsleKED3AoaQ==
X-Received: by 2002:a17:90b:1e08:b0:32e:f1c:e778 with SMTP id 98e67ed59e1d1-33fafb9755cmr2113278a91.3.1761209085817;
        Thu, 23 Oct 2025 01:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhmMIxVjdwZwB+RL6W4zlRgSWTS+YxPr19/elZcrqqzsvZ7foLK82FOM3+gPdgpiajIHnRSw==
X-Received: by 2002:a17:90b:1e08:b0:32e:f1c:e778 with SMTP id 98e67ed59e1d1-33fafb9755cmr2113253a91.3.1761209085336;
        Thu, 23 Oct 2025 01:44:45 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c056fbsm1391414a12.17.2025.10.23.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:44:44 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add rpmh regulator support for Kaanapali
Date: Thu, 23 Oct 2025 14:14:35 +0530
Message-Id: <20251023-pmr735d_regulator-v2-0-452e1b28cd38@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPTq+WgC/2WO3WrDMAxGXyX4eir+SZu4jLH3KGV4sZyYxUkqN
 6Gl9N2nJRcb7EbwCemc7yEyUsQsjsVDEC4xx3HgoF8K0XRuaBGi5yy01HsltYEpUWX2/oOwnXt
 3HQmC18GFSh+UCYL/JsIQbyvzdObcxcxn91WxqJ/tSpNWl/A1TPBLWhRI8LbxaJ2tXVm+jznvL
 rPrmzGlHQ9xfm4GwsvMZa+bRiTM2a1lj8XrRlc1tP09zQQ0pe6PxVNckGWGZaouG2kPVf2J5p/
 sjW3Pb0ytMOkiAQAA
X-Change-ID: 20251023-pmr735d_regulator-fd2faf72613f
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        jingyi.wang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761209080; l=1248;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=TzxMEAEvBvay0xnUwiJ4rg2i0h0+YPV0RGQEHFd6Xsw=;
 b=FMd18hiG+bzBkvhzRSFZlZ2mE3mYIpBjvVp3VRQdFwP4wrEovlSF7XYCV4RF5wR9KwBHbUjMJ
 7gqqS8lCcRTD5k97sRZbXs55k8+QKekmE7d+8cLUjyHZ00tbXnwHbiA
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX1p/3+g67n/Fh
 sRwy1KzcAcBRqATJ2Zyf2D3oC/nqE7SC3agrjxfYIQnC869fdvegj9Fq4dU3SGzwuB5tBAV15I5
 rgkeylsXHxFpSpuF4F+uKTiITj6TzT47oGNBcLPiD39fr+AQbn8iB4CU/KvtC70A9zHpLHwQuqQ
 bZnMXWVvxeP79vVa8cGxTwgath2nleewK7YdueyQVRiXOpxaOicIfmRIr3EXactJrA708qG7YBp
 vN2FxgUoDqfdTpF9wpR2hP/jdZETWSwpjUblbiWOzhFN/pc22h4og6HAR47C5t4bA3+aSaIL/SS
 7eJiOHHYgDL/R0W6xq8YT00+aEipqJuh+hIrr1+MdYKu5ZPN7uam+gyVVcL0bIcjoqIAecv8zv3
 Yrtq1+Eo/K0gvPLcWyudxjmcenXYLA==
X-Proofpoint-GUID: MBdFyrn0FrQNlh59L7owPHDsLZEN7SLL
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9eaff cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qzm-_OucbfTBZaCAGHUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: MBdFyrn0FrQNlh59L7owPHDsLZEN7SLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add rpmh regulator support for Kaanapali by adding PMR735D RPMh
regulators.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes in v2:
- Rebased series and updated dependencies to fix merge conflict in v1.
- Link to v1: https://lore.kernel.org/r/20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com

---
Jishnu Prakash (2):
      regulator: dt-bindings: qcom,rpmh: Add support for PMR735D
      regulator: rpmh-regulator: Add RPMH regulator support for PMR735D

 .../bindings/regulator/qcom,rpmh-regulator.yaml           | 14 ++++++++++++++
 drivers/regulator/qcom-rpmh-regulator.c                   | 15 +++++++++++++++
 2 files changed, 29 insertions(+)
---
base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
change-id: 20251023-pmr735d_regulator-fd2faf72613f
prerequisite-message-id: <20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com>
prerequisite-patch-id: 3f755a759b681ac610fab3a3ab78cc50a82996f8
prerequisite-patch-id: 7f1f8d6f460a3032a7696290b5138da7d37bc6e0
prerequisite-patch-id: 264b32da8d734e44e6833d3ad5e7807f5fb88b59
prerequisite-patch-id: 0ebdc2319e0615065e1a0fe44008f2473e4bdb24

Best regards,
-- 
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>


