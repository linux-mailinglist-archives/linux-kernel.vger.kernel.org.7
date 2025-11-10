Return-Path: <linux-kernel+bounces-893708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6792AC481D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863A9188E903
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECF31AF3C;
	Mon, 10 Nov 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LqDjD+Ax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SoZxktca"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8C285042
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792853; cv=none; b=F91cgFn4JoBoeH7gDbNUs73J3IldJ4hN8O2z13AMMSDWeTpWuEIQ7sgNhlyFCWD8lpWw91CPl0eqUq67/ySeSG0qCcA4SXf38SG8kOgQx6JwNQMwUF7wVTessGNLF8xa5Q07KLgcdHBZM9pmQbA5Cp70mFjR9vmoHYftI+s24XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792853; c=relaxed/simple;
	bh=i/XuvOyeT2JCaHOlG1NFL84HKMryUVDsLqPOa9zMe8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxf9efno4Ere1qbcOsZxwwI7Au/r1biadXgWuzTR3ik+756mkj9BTJoLFOZlrg0UqqlbLAE9nwOa53A0L5M55CvCOh7v6lHpOpsCpvyqgtvsNzup4/PTfRVDwLcdy9hZBAqFgzOkNYxCd4NIZXdn54jlVa1bV61hCYAcG9Qutb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqDjD+Ax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SoZxktca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZrdE3271859
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YW7kalD2buUlilIlPcd/kOSgkuR2289vzcuRgzPf1Wo=; b=LqDjD+AxC0ozDLV3
	DZesPF2KWyNxNUxlnx6q8UyFS2ZMJU28gRU0nLSP0MoiEEFfbh2eao9SZtrUl0sd
	e8DgOZAVM3ynTyOaFIwBkTrjN+Soh6oYgFKKnunmsBUnnhv0/e1ytARgQU7DRV5d
	XhgK1sZJ9eME5jmY0pDBXVk8ovbQnPmosf//dauSBmhReO5lV/BQwBpRzAdvK4sl
	E+G6+JJ3/DKp2R7kefUfAshI04MU9P5vViXA+Xm8TgUopVg8HURmMPcprBMEYbnf
	Mbbzlv4t4Y+4YzwquiDoGYYFTMfRk12JjwwHetWzIdsPxs2H1WP+gbNHRjezsgXm
	AlhY1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafrvv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso7923477a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792851; x=1763397651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW7kalD2buUlilIlPcd/kOSgkuR2289vzcuRgzPf1Wo=;
        b=SoZxktca45KJ1lehE5Iu5AEIbG+N6IAQ0JwP4d8Uiy9ORADd0gPrEHjsfuJj9nWOu4
         PRhWGtY/2pU+P3MfGrIc4rfvou0fxQXj03Th0pMn4fJ1B9ky76a3PpBFPVFmyNJV7zrm
         XmIS8LJImuqncjCApvxBvYDnVsO/ccAD1a6VICwpbo4HS6+ItvlAzvL32W2N0rBjupkH
         99oY3ch2C7t/b0m/Mb73Ob0mmdwhwrdaiUlTLDTx6rMOJEkKGmNoMwxu5tYuiBqmzfwr
         twpzpF9fIprkWrfG2IDMJhxKxMJ0Hn2C92Zs+TkUtXRAMLXVklm/VwXHu0bmLBYvnWMI
         5S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792851; x=1763397651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YW7kalD2buUlilIlPcd/kOSgkuR2289vzcuRgzPf1Wo=;
        b=eGM674fMQvMRPR0YGx+kDVlhF0XzHj28oyoar1XtUk+PEKt9ZUBbL5Twrt/n4rfHL0
         cj1TdSWctFg+xafMeJe3EUP+M8N4hrLvMOxFbEtAGN18mowP+ae4BgAgryTOkGVZp8M0
         iAAVnn71yqbqo/561Efknm3M1nFwI7PvpCqoE7vMq+OHzc4YcxuQSa6ca8k3TknXOq53
         QyxHHEnEY0Rj8VTlTvkZnPCP7tNnwDpDNo/c9/cdDvWpaV+ErvOm3V9XAfCZQCeZTZ6j
         raWNwBujgd//81fTG00DiS5p3DZ22zjcIRJ3o1r0uL35fzzAdJiQf2TFoAhqwLC07/Pu
         KSMg==
X-Forwarded-Encrypted: i=1; AJvYcCWufKpchraoZ2GKiDDspZvUs759hRSfkLEI5+HGn0qEoGCfAHat2OWXwxoSghhfZCb4r/wBrKmwV3s0IUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylBlqA/VF9xt+66AtLR79GLHYDiP4m148uqfyp3qMRvAou74As
	9hmQUKBaGQnCnDyfgbY+sNFB6cnRNDRLtp38VnXrSo7MA5xm/d+m/HsVvtE8TovFX7ejqZeUolu
	AKqttcaiot2/e2H8FpCa5pOead3+RnguRBULhnJhD7+/rrKwtMTIRLusZsqi2lORAcz8=
X-Gm-Gg: ASbGncuJGR63JkggdNlJ/5FcNckkIEIzkb+0YNPOQErfEEHMabDDwT8bXwDdDC+d788
	2FoXa3y64XDGYZh3KHqSyA7ASCQxeVSRP4xeNYXIjSBCy/Tc8lwuCxziONz8P15WQcMmae8/zfn
	offKaYn652c717D46+4C0Qy+E+h6gkTHpIBJxrug/zfw+8WAheTFi3pZD5Jz5W75M1VylyU39B+
	VWkF4sqGkHZCmNPdKXL289nYVuyCmSohHrFYT/Moq90wP5Q8BecYGMDrQq5c4MjiCFan3l7UmI4
	wParsOH4mUxpRVmgwMNtmkpIHZx8BeKsV7zoDMc+kV1fE+gXDpuP/JzH78swkJUwCoFcuzJJcsJ
	BkUoiNiAtvXdrIld5KsyC3tI=
X-Received: by 2002:a17:90b:3145:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-3436cb118f4mr9615761a91.8.1762792850882;
        Mon, 10 Nov 2025 08:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9pMY9BOOQfsUqFBoMftON8+gbyhMo9vgaZeaC/P2wd397OdPBRxrPP6VrHlsLz8Ax5SqN6w==
X-Received: by 2002:a17:90b:3145:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-3436cb118f4mr9615700a91.8.1762792850322;
        Mon, 10 Nov 2025 08:40:50 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:50 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:26 +0530
Subject: [PATCH v2 20/21] dt-bindings: display/msm/gmu: Add Adreno X2-85
 GMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-20-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1613;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=i/XuvOyeT2JCaHOlG1NFL84HKMryUVDsLqPOa9zMe8U=;
 b=Rl0fX8fht+QUdLlWazjj2MS5zkr170ArJ5QP1nziu2DVWhQTh/19rZUXUtypkQfxsojWb1Q2h
 Ei7iatRwVopCf/T2t6JmwEaKOde31BcZ5fbInGGq30cfsAbYCW1oUR+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: z_mpuZUJqss1pFNyG7JIFJBxBtW-W5j8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX80y12M/9bZdu
 LA2TzgXmXecy4ZIOOEoTPLrJTopV3CohavcW/Ghv0Oa7b3c59QMzNvqpPSvMw8mQtZdd7CWVgt5
 +kx3uR72d0oWdPEapmk73NCpnz5CfOLBV90okEFWWjjY3AILkROJ73RalpWN5Y+MzQbsWOYvKZ8
 UjjfY7EP0pdcUX65PcHHISzdTVBHlgghd0m9pykYPfmEyfhP3Id1gjZV8qInYmFrYoVL1SRET4a
 BTj+WOK4GIDV9ErLOJsHBmixfC9bh8CIAjEJdAD+VgOrPcT9RDfk4P2CfpVMZ6MkLpFpoRBYlji
 rPVo8Q/yH+Mjzcn3oPFqV+RVHqCpvqs62hUTZXaUvsSwueWtXkpAewn9AMGCEgFFntN1ANv3/uU
 WWOD3vZQLdBmynRfqypjbWD6M2ASLQ==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=69121593 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_Uo5JhhLEGw40-SN2AoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: z_mpuZUJqss1pFNyG7JIFJBxBtW-W5j8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100140

Document Adreno X2-85 GMU found in Glymur chipsets in the
dt-binding specification. It is very similar to Adreno 840
GMU with the additional requirement of RSCC HUB clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 2ef8fd7e9f52..e32056ae0f5d 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -327,6 +327,36 @@ allOf:
             - const: memnoc
             - const: hub
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-x285.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+        reg-names:
+          items:
+            - const: gmu
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+            - description: GMU RSCC HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+            - const: rscc
+
   - if:
       properties:
         compatible:

-- 
2.51.0


