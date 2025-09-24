Return-Path: <linux-kernel+bounces-831394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC355B9C8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB33E325B91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7829D27F;
	Wed, 24 Sep 2025 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HpFtAJ5Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34827E1AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756335; cv=none; b=OHdCSAdfnvBztg37m9n2fTZ1pgJoYx52VNJn8wB86a/xTkrDn4jCJgQ2pZbqydG2NwThYoIRlJrXdWNqy6Y7Y/+mTjpq7JkQvLTVxI/009M8Y++IKHuaQf3vPx6s36rDchEuEop2tbjDezRO83xPpS2IlcSEjDlea/ZDamgrnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756335; c=relaxed/simple;
	bh=grnL1nW0aV7OR935DYA9RYWYKNMAc5uMkWKRAdqqSkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YuL4J8OEz52F1ZpbdHJbO0S/R/wCyu85SrBDLp8BM8Sm0NyLxp+tTkHCYlG3SDGNhHh2SEyH3m9UQ5whKjwrTvzMVa/GENTaMfSyGniVyB6ONRc+GJhEoQUIACaPDhBTI6/6QfCd3DejnIHffAmhRSKv2e69R0HCLplY3acdb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HpFtAJ5Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD4ZgO017453
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V0ebCVkmE2Ghy+Rd1cTtrj
	/n09jBrOewJlCkIQnhGlI=; b=HpFtAJ5QDXOW1lrdXKuYyQH+237PfYAFnNF4Jt
	5hL+w2lyrtSEdMWprFDAbNgIT4KN1RQ42I1m5rgZLTS6aaHmbzSTktZRNGGYkP38
	jz9dW2kv0Lc2Z2QZPnGoFVouaweAcQLUigl9By/MH6WJf6cy55126FUu1aYSLOgp
	OxBgMMBdq6ORFkeDGqt4d7affJN3gu01vhRFlbRdXfkXVKD9hDMiWbCc9iQ5tDMW
	cNxGc13L1B3isH9FoNNgSBS0QK2WajFgZ02TgoshiR+XWRqJPpNwmagMvWchwgZX
	EIEtSFC2TRAqx62TxVeHKs8l98nhEMAiq5PZswl5Jbqieb1Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjybxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54df707c1cso210572a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756332; x=1759361132;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0ebCVkmE2Ghy+Rd1cTtrj/n09jBrOewJlCkIQnhGlI=;
        b=kJLZo89ass8DGQTZWBqRNaunjWTu4mlN/3aEMga3O7//dByqhd7UY9MJhOcu+Wv4wx
         BIq5kh6w4hIXvo8utWld63TE2xU4xajVmPXaKsgpuZM6Zm72YSO5z8lX6hFPBk4gPd6U
         bt9h+nPQmlJN3tTPQz9d3olBrUTGuxiRPSjOFQ/FtjMpbrTjNxoOLuiSOcRQ91gZxWZb
         FSX5JA9cbtccyyeauv8RaGtS5aDTUy2iKJ5CV6IQNMs4Dn5T/tgxPzKdk88cddNLyKh6
         mdmkfBch/W1/3UqSjPZKOIMMXtHW7qOg07BDWd6UhNAHd0ip9TBaB4yoBX4VRlvYk8f0
         E/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWu7o7W0CoRU9U2YmuCA/T1MaA+exDXGe5v3GJdBffPzXqTU1OTfkytnD11/TmVvOVoEbAcGisw8owmrOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl8d10ejpiVp9BmgzVSO3ma6aSNYfmMggu0exAo0BCFTjPFpj
	M9Ao0Hn3Akv6qZ/pIORSXj0tuIQCUhoDqsjLS4Ojl7mMdpwy7AYVzImshaJ2Ghv3MvFboQTmX58
	Z/MvRJ3wq050mmHJMmwhwE3vHVhiEF/zNNo0b/F7G8DyBJnbbKmQFMLIQRJcEyui3n74=
X-Gm-Gg: ASbGncuJ0SmEvkeFPg+HwDkJ9TEJhEmpBniCwCjYZdWjHQuLB6kKrpVBbSrD9rC05U2
	xljxAzy12882tznoRPpDIGTofauL/eELelTA0qTO/bTTwqa3ESh8uy71AGZp1ldwYzYZYGshM2e
	2oGZWsEclNd611JnjwDoTpDH+KCy4kZxzj7YqT53+tl0hXpzO3BX77moG+ML1TvcDTuGW9lSIVh
	Ib8KActbNJ1I7qANXve8bBGBZ1ZawPdLqR//rl2Cdwya1/R+QBa7HSVnX8SkY3mERmdGrzQ1mz5
	+J8rbyJM7cOZCqa8ladgWW9r1rKG8QxoBcOjEin6GqwNqYxz6nqoMEkF4N6ZBbI95Yd3IQbVmoh
	8V0IIvBCvavHbDmE=
X-Received: by 2002:a17:902:ecca:b0:269:8d16:42d1 with SMTP id d9443c01a7336-27ed4aac32cmr11420105ad.50.1758756332042;
        Wed, 24 Sep 2025 16:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ6J7fDY5Pic/eRJccWKxjHx2Ra6IqcBRO+w4mduPo4gLOtd4HvrD/wBGFrTmoXvb2WGJbmA==
X-Received: by 2002:a17:902:ecca:b0:269:8d16:42d1 with SMTP id d9443c01a7336-27ed4aac32cmr11419975ad.50.1758756331606;
        Wed, 24 Sep 2025 16:25:31 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d2fecsm4313305ad.12.2025.09.24.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:25:31 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:25:27 -0700
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Kaanapali
 BWMONs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOZ91GgC/x3M0QqCUAzG8VeRXTc4Ghn1KtHFznHpCKdsooH47
 q0ufx8f/x2cTdjhXu1gvIrLpIH6VEEZSHtG6cLQpOaSbvUV3zpj3sZJsTtzrKlQmxPEfzZ+yef
 fejzDmZwxG2kZfoWRfGGD4/gCOUmNxHQAAAA=
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Amir Vajid <amir.vajid@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756330; l=1131;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=NasTWIQxtuAN2SnlNbGqk0YKf8tGhQVZDl3ik55ZSSk=;
 b=Zpga3xyX8vht81SRVnZs0Lmfn6J45kM1HVjHjv85pOrRQi4r2F/rkDWH5g96qCSWaekSmoDbq
 FbbhMr0lv6ZBGy8dvjvJAkPjurOa+k4baBH6aUR7UOMY9/D+FQtbmkb
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: SabGuq1vWpKZ_chdDNEtlqyIuMGHiTy-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX1JbHX6V624sP
 j7J3+ivYd1V0o5tK3zudmeHO+PLw0UEpwY+q3ovT+F+/RQDtIiOiVY0P2ijCLDX1kakFbOtwCRz
 6oaaQlszWfnjolhKHxGBp5r2UKTW7/rn3eb2+gMtoMa4EAQjEcvV0hIj0IKQ5aDQ6RKuja5bPLF
 BgvG94499lDyUTfKoJ5Nz3PXqXeJm5Q9xpzCa2k+F+lKlx7K+Om8vZiqI5XcZaIVoBjeAwSRGwO
 r+qyhnwTfB7jvjcypdzu2pPhT+Ks8Vd5zMXGRwxIgZ4jjUwbzWM60pWBxvExctnkkm+1Evuj9bW
 bGYWPZ/tMjKclsCAPceWeJsAsvVrQ1yrJ46n31+TFT0JBVu3/RnkScwpDpmm09ykCJkRPEwzKEb
 ir23rZGb
X-Proofpoint-GUID: SabGuq1vWpKZ_chdDNEtlqyIuMGHiTy-
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d47ded cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hqsPwQ9-5byHO2hE57MA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Amir Vajid <amir.vajid@oss.qualcomm.com>

Document the Kaanapali BWMONs, which have one instance per
cluster of BWMONv4.

Signed-off-by: Amir Vajid <amir.vajid@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 256de140c03d..0d1a268db921 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,6 +25,7 @@ properties:
       - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
+              - qcom,kaanapali-cpu-bwmon
               - qcom,qcm2290-cpu-bwmon
               - qcom,qcs615-cpu-bwmon
               - qcom,qcs8300-cpu-bwmon

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-bwmon-d3e2020ca6b0

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


