Return-Path: <linux-kernel+bounces-831402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9127AB9C90C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B35B1BC3EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63932BE622;
	Wed, 24 Sep 2025 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERR71+PS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330927E1AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756548; cv=none; b=YbYlJjmxtBGEyB6ldcsM+UadRQQ/ZQJ/js44QQEw4704iszQpJIpuM1OjdYdn/NGW/SRsIBn9qqtssMBkAugEREJ88uWv9+dx/qD/xvSeQ1wh/n1Gtg2kWnVO0Tdg27mkcCTdc3jdFXF5X2BAQfZZP6O3bomW0vCZUlMtEmqZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756548; c=relaxed/simple;
	bh=jWd78DT0Fr8BpiI3OytKO/eCMLUF09XL9ggxo61EL4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9k+dj9Qt9MiKQjxSH3JoEmh36fr0TO6Y697yM+DFzWjLkuVxJbXTRB6fMSRM1BqDnTo18DVV5VtG5OFGTPY+mBtWnLbE2WNoPDiSAdvJT7yLxoq4Q4Ij+hc2StQ2BhOtfl0hGdoUuoPC6ZprtXGc873TlVsugQeaHoGzB99vMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERR71+PS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCeTV1016436
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8pW0sZS/QufsY4Bkw7D4M7tAZ8fJtgfaJSDVfDSVr74=; b=ERR71+PSYocz9mPK
	Bj6PQQMyF98CuJxkrPJ1Pc+k2wMNbxkum2EIBqoowSjaL8+koG3HJ88uvST+X5MB
	c1DP4Wf2Ha9i+uUKLaCbBfgY6qPewYPOnJ9pLIkckP0xPMLQqaH9XX5m7NYOblwx
	9o+2e+ZUqUPUBEYSAicVG5NLU4DfcQ82XQkd7/Udu1bF6UGGQPi7iavrPC8owJW7
	QICJPQceWasjXk42wsLu38MxX/0VHotvCm0aLU78a9/JXpyZNFHwmbEhrwevfmFV
	bKjldap3TvXpzUpZwRlXc2snM393yLzBbMsrC3F5Zu33wJ0ZivUkwf+dLMVsA9k1
	4rNuQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhun4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268149e1c28so3160625ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756546; x=1759361346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pW0sZS/QufsY4Bkw7D4M7tAZ8fJtgfaJSDVfDSVr74=;
        b=TRxXudfOlPm55dZEXGy5CylgxeEfmZ8rymcJrc1NPngQaA8xQ2s7Ts05G+WaIVRd+L
         zjtg5sUDSZNVAkZQXfuyvsf1M+X5g4JXN/oHLeGmIf+a6UHg0Lea3KTI8lgatsNuFd4H
         /gtoSL/LjGMJI4UIIMKnbMcNUtq3aRv7zJdbi7yJVQR9+Vk6wjZiHTxErzG6N/HTjf5J
         FsUSEKGK4P64qGA53DwfnQ3wR5fjK07m3QzPFDdrJPJ3BOs++g3i/9kRiZUUvkmtrjw3
         bDdF6EfYhqwPAjuF8eAD0ghhF4AtJRw0FjRiQQVK5SJA08hHocIS1n6G+NnKnQiKK235
         ZyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgk8m7tACmwkgucUgQPhjSEBMTiwtpLhwnUvb2jOHsjJVrtoOEDElzivVPeHVRFEvvfxOZx9IiAxIY014=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13CVWAK/cNLKCeJI2B52+HCmpg87mIOKeA4QTJN+RlEqP/3tL
	3wOTBJw6E8QqiEp+2qM40cOg8SzOMOfskH7COQe98TeKY0T34ztqmPF4/9KTrx/8/fqPFOn7Bg+
	iAO0dT7+rDOha1emickcU0F5790DP6DVpDiuV3JkgsQIeFuGu1OWLySUGbdd54hw9CFE=
X-Gm-Gg: ASbGncv0WBPtI/fte8jEqb7c6ic+e5EtQkuL6Do0oldroh9e1CBx2L2mELcdrPGhgIZ
	UL7fMHIsGQSRzGeYUFoypQtfyYoyAZnsYtyHrCHOAyqceLtfW/KCMECy6IsOi3fc82VdqB31P5Q
	qjBAJNiMef63yYfW8MJ5sVIYAfFdOhncsv6WbGx8lW5ouP7SAkMSsT4VDNTvwmccEjpYNwbYvRB
	lHM82aGBJ1DlSW1ZXsC9ItMznvkqJ+bV/gCz43h7LbwKjTLu/3y00mJDER3fMOMhu3HkVv8YP1h
	1yEYIWIzbau6MTqx4ULqScqSg8zu3xVVOmqVdnUl4AaLMMWFvYuGrFQ2dpZ2eWwYd/W6LEKhh+E
	v8knsmlHqQizWNDo=
X-Received: by 2002:a17:903:334c:b0:27d:6f49:feb8 with SMTP id d9443c01a7336-27ed49d2f57mr11599725ad.16.1758756546158;
        Wed, 24 Sep 2025 16:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxjctrlKrupwMa7wpsVyrsKMoSCGPHZ4ZD641kuuwi66f9z3YNEOdmo3Cj0DuJRXVNnpmF+Q==
X-Received: by 2002:a17:903:334c:b0:27d:6f49:feb8 with SMTP id d9443c01a7336-27ed49d2f57mr11599475ad.16.1758756545741;
        Wed, 24 Sep 2025 16:29:05 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm4292825ad.30.2025.09.24.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:29:05 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:29:00 -0700
Subject: [PATCH 1/2] dt-bindings: ufs: qcom: Document the Kaanapali UFS
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-ufs-v1-1-42e0955a1f7c@oss.qualcomm.com>
References: <20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756543; l=1012;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=pm/rXrJyIy7XydqwV6FEZ9WPS3qV2+bd7t1bjxFXOAk=;
 b=JwWRgROgUEpSUj6UpssTKoS/1MyfEY7uBpbjqPNCyj68/xra0OlfcuEiDWPV6Of9aGUgY/84b
 +4p9VK5nutBArNoK4nJDG5akkvvsxan9LprulGdCmzNS4GrVxuFbmao
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47ec3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dkR0I6OD3irOzcp_LXMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: -1rNyyQhLidq-e8omFmZomx_qYOeUQnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX3D/AImkI94pf
 gWttHKG0Wtz0Kj9RKoBshHkq1B+/uTncMiaIU0Hx+TvV6EKkQLnztMehFBCNKYJhDWx2Ryky5af
 UNgbOTTosrHmHHQY7GhObEuy2l+qlfdb5bmUJznVYFX0pm5Pd/E5OliVQgk0X1S+7mr4vvPTPnK
 jA8BKtYzmZQkEcvrXesiUMyNs9yy6RrRvG/XlKeyG7GfJFI5N2VINMlyCN1FGNNEx1f+39Khp4J
 Bx9meVcGbs/37MNsLL89goKCriHxlekQVroyVxrFj4Sscjd2tJKB0j/PGhzqhyy+nHl+BM+FGH3
 K8FPB4koG97UP1mhOcXQcGiHs4rDyIK8wS3FR+YMc3L1MjoX5FCxqc7LWjilpF7KImlbT/R0Bpv
 U61b6aUi
X-Proofpoint-ORIG-GUID: -1rNyyQhLidq-e8omFmZomx_qYOeUQnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>

Document the UFS Controller on the Kaanapali Platform.

Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml b/Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml
index aaa0bbb5bfe1..cea84ab2204f 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - qcom,kaanapali-ufshc
           - qcom,sm8650-ufshc
           - qcom,sm8750-ufshc
   required:
@@ -24,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,kaanapali-ufshc
           - qcom,sm8650-ufshc
           - qcom,sm8750-ufshc
       - const: qcom,ufshc

-- 
2.25.1


