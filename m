Return-Path: <linux-kernel+bounces-818819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CAAB596C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BDB188EAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044E3307AE3;
	Tue, 16 Sep 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="peECV5IZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2E2E36E1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027576; cv=none; b=dJz8JiAZ7anrYj9/NawTg6+4K7OaydDZlzZX67aHbu+K0BeumHm39PVUP4TeSHk/QpI7LwoG8ymSo2ijAvD4NzOu+GAK8q+XHyN+/Jr8JgRn+aobwfkGEUl0y/jZjQEBsq9wJz1qx8DaqSqq8AYI1fCsyCcsDf5xq7ZWSZu5rOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027576; c=relaxed/simple;
	bh=DVbPWj2tzFTRpVphPskCm+T6kOu6ZEksP9RXF1CryGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=En67/183BPhYcKynFCv0Fhphzkpj8DP+MuX6/h8uqzrDzGvbc5CL7zo4yTgnQCkTaOhjE+et7xaEENGvDaIfHNXd3cFDsWRsfOP7S/xKbPAMWyvRqTI7xnKkOoTapCmi8SaFBcNhpP9irVsVXZ+wYgXGt+pHqccW/87MiYsj4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=peECV5IZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9evTO007324
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+mLsRe9kMqiLPQdcorklY1L1kTPL+tbykpHDs9LwmKs=; b=peECV5IZaAdzaBAl
	NePZMMthewNi8kAkCB78FAjo/R6L1hohEQV/RFFax5dzPCKksvt37zWZkneTdKJ2
	Kad9iAarbhSwkeAPgt+a8t80Lhf4AAhxC3L5PLCU5dlIt0WyZCyxQ+pexjaBm8Mc
	AbHklPsNOfd4Kc30NVGOk4eiB64rbC1l3fB+m+3IGbTq5oWFfmLmdAcMpfaZUg/l
	6Ojgxmw+b/1xjBIK33z2nsu74qmSE8cQJYxv/Ljf0FAZqvLd0vS4SM2+/NF/oI58
	Kx8JFDaA6J7K6a4RKAcREKEHs+oZW/9bAXEQAXe7f2+WINdFCnVp2FvCgtIU0dIs
	zUyfog==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4jj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54d6a67b5fso1273000a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027573; x=1758632373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mLsRe9kMqiLPQdcorklY1L1kTPL+tbykpHDs9LwmKs=;
        b=f8o7jqoPqsAutxqaFM6lKs2qiXt/kp+cl541DLBD+8llK1+0bIpxFVRVVSovS/YVfu
         WcBnvoWjK/BzNBfe+/T20yruEu+5+PW4671Mh03EJVVPM/NPumlhgEzPVO2dinJSHfxf
         HiPJJcWeYKrWZ6AM7SYgmOE+6kMozGEk8KVdZjxIUffWUBfLXz6KGWVKmUcuf6uoeKu8
         exzrbwbg80772x5DbXCQ7R66tiLuqdYSOgpPyX387tFWVxZ7oq6xdXJbe8KIaZAK6Twc
         agdrs2K0/liuKRh7Zx9+jDWb6PdfOT4zSIMg/iJAP0f+y/wA9h1zaun5eIgV4KRnZTW7
         QYOg==
X-Forwarded-Encrypted: i=1; AJvYcCVV3mlhidgc7zf4ctoW5zYs0obyw83J/k9r8347Z9HI3l3JvPR8kBSJkLcefuoYXuaEAjasi6rKSa99f3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbgYz6/P/NEFGhil+Ve/UvaVppMjowNTzwK/zCAMcElB6nt0b
	rUOTj98V+mFepD/N3l6fcgtB/fn8udkpAv+iDsGN2a7aSmgaoP9uFDZ2sDMyoDCu0jYtNoBznoh
	2eT9JVOxga91IZKlv85p3FXDjcVeBrxaEh4K9KKbWyY9/su18Pk0rcG69u42UqbRizfI=
X-Gm-Gg: ASbGncureRHmWpHlwY2RBhYcumliQE8P+m6XYhfAOmO98hCkvyJD/qSl6YMabn4MDL3
	P2XleQySGmhiWoIu44mPM5zzxGM1RBU+idjVXhVdYIYRyTJRqiAZmV4pMxMmR0j6Wciy7sikcaj
	oQRrQz7zqVbhmC8AzklSXJnSyne/C2iPDaRgiskAdz6yak/Lo6LNy21R6paePh+4oMWLQHKnvhg
	XeLWjBiRASB3xJR+OXYS/N2X3wOnF5qyy3pYDhGpKk+OfYwDTFVjpYuHN1FhWNaReC7GmiWLGNW
	vPx9yEyP/VF59Mg5bWhum6NmBMUSgO+hvxacwPB2ltZK4PcG98V2gWJf3g1Vz7gCQ3U5YcPZp+z
	55uAhodVWQhEOYuSa6Y4W0gquhQ==
X-Received: by 2002:a05:6a21:3391:b0:246:3a6:3e64 with SMTP id adf61e73a8af0-2602d00f0c6mr21846773637.58.1758027573375;
        Tue, 16 Sep 2025 05:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RdLHaNL07xBwx94L8QfLO/pai//e4+r6maxtQ+HYFVzCNITHHJ7Kd42jZ06d5d8xZ8OrnQ==
X-Received: by 2002:a05:6a21:3391:b0:246:3a6:3e64 with SMTP id adf61e73a8af0-2602d00f0c6mr21846717637.58.1758027572870;
        Tue, 16 Sep 2025 05:59:32 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46b7asm16057113b3a.22.2025.09.16.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:59:32 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 18:28:53 +0530
Subject: [PATCH v2 2/4] dt-bindings: rpmh-regulator: Update pmic-id
 property description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-glymur-rpmh-regulator-driver-v2-2-c6593ff9b4be@oss.qualcomm.com>
References: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        jishnu.prakash@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758027561; l=1387;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=DVbPWj2tzFTRpVphPskCm+T6kOu6ZEksP9RXF1CryGY=;
 b=O6hVdlhzYecc+aTt0sQAbh5PALuldhyzASq8saxD9OyUXUPhZza9Vv+Zzub48ItT3RbxU0TZD
 HNZmpf/lnvGDAVrOvlA39mfJO+2EoXMXtq0cEQzBz8QPuq8f1DUTyqG
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: -MVB5-JZY7MB5ABiDp0nfurX52bpNo9i
X-Proofpoint-ORIG-GUID: -MVB5-JZY7MB5ABiDp0nfurX52bpNo9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfXzKmsWd1R0Mkk
 B+IGNbkzGzypP7vD4F/TvcJpU7yOV6ATBvmEUWUqLB44JZdvABnMMMPpgVUf9wNr43UR7HUaTg3
 70fjbaNhoLLHJ4HrEDM+QWSnCWxZmZVFisypfCZcvEpRPQ+9vrEpnSqquaiYu+HjrKAUI0OuWTQ
 Pm4lBmT5UMC8Uh2U2K7CKmDLVSJMJ9bRzJ60HS4afesBTXvnWpByhtt30c3CE0mnapESArkTvg+
 aKiSPFRUgZziTYgGFuc4vXTMJ8SWhHO85sCMOuM8BQ6yK+QuV7x3TqzRe7pqyMq6GHQ6UHfv4qd
 taMc/itCY9rzvNilrJH7caNfbHcEDWR5hTG4oqwDJP1poGegwn+/CFrVh1DpocKaQsq2IwCopt7
 VQwuVPIh
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c95f36 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kC17J5x1v2BUAMpV_zAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

The `pmic-id` property previously accepted a single lowercase alphabet
in the range [a-n]. However, on new targets such as Glymur, the
property uses a new format: `[A-N]_E[0-3]`, where `[A-N]` represents
the PMIC ID and `[0-3]` represents the BUS ID.

Update the property description to reflect this new pattern format,
matching the updated driver implementation.

Note - Old format [a-n] is still valid and will work for existing
targets.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 40e57b10ebbebeff130871b6d978df64111b6f29..40ddc64577e78b5c0dbb7b4e8893a08e8b37c92e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -108,7 +108,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f, g, h, i, j, k, l, m, n]
+    pattern: "^[a-n]|[A-N]_E[0-3]+$"
 
   qcom,always-wait-for-ack:
     description: |

-- 
2.25.1


