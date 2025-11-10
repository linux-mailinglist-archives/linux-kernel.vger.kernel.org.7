Return-Path: <linux-kernel+bounces-893707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33384C4819B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB40634A6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126A32ED5E;
	Mon, 10 Nov 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfb5RfcM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoIYBQy+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247D285042
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792845; cv=none; b=su8JvaMqRnDv9GqVxjnvK4O4Vge8prJaRF3GOQk5EpxuYxs1BH0MoMW/Gr1HmqUGX8ccDFRFvoMhV92edG0wSPID3rs6orWnZkJVV+Lj5TF4x9AtxhF6oJA6ylHrd99w2kg1QfeB+LSl752PCcbOixvVqACeQYZ4mC0SaRAzMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792845; c=relaxed/simple;
	bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkNV6n0jVLWMpFFkJbUKXvIkTbWOImTSoEhIfiCMxraHLEi8uXZosnkQmpZZ+05n+2/tc/V/BzTHz9xWurPTdcerilqhNvZWp0atZcWNqkizFlUwDlfEunJgPY91FxNwGFIvWJtIa/NL1WjWY7891Pyjjj22zmMNt/JiaBFjgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfb5RfcM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoIYBQy+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFCCQK1808874
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=; b=mfb5RfcMzuKHoEwN
	bE/7sAthi6igUtT7/JkWPEeev5XN9rHHFoloGCk0VSPlSTJG/dFXReEi9t/AFBwF
	rLZOEj5lM0LS5lQodxix27ElTFsUVSWdWpfmnn0RI2jvTQB1wyMIgul1RZmgYMNX
	9rP9bkQNkRJEz4VpaQgvOBKccWu5MbtL1J8lX2xtbaws10fA2Zng1C49+WajOKC3
	ZghEAo8v/AcssjoShvDRK9kH66nbQ+SZsP4d71kPVOoCbMlwdNpKrQC3jhjDbrRs
	M+y7S8EKKJQTlh7J1QFtJij2Nhtgxngc65a8UVrLyawJGF4EKvPz7jU8rxty20MU
	UvZ+hA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1jm50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3436d53e990so2095052a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792843; x=1763397643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=BoIYBQy+xeS4j/gLdjlch7JC4YKpDIGr+DajJE7xuWoT/hiNHWgmMZllC24jBjlvEq
         ym28J0c1QhTuPLptOb9LvADOrgZpog9VNJMyNJ5+cS3zsVLc6U+0NhsAV12LbX/a+akk
         r0Su+uIK2J5Jo/WdQWGYXa1LzkOz6/sZdALvLIrswCIANVYUV0TbSfJBxEsZCQDblAIY
         /LAftkwRPXR06uXf7CvlhS3vVKJ38B0fjzJwEN1b9D9H2JU3EVOfqYn5JLhbD74azjZt
         EE+vMXBtSjtijsKaS6szBcHZnVfCwkrw2zlYQkmx+tpJesopmmynlRICO4I/6nhckyxk
         rzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792843; x=1763397643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=a3c/7Uo6wTdoCg4He35T2TNgiQUPJ6E2BGWLJIaAWilJ6OKgpUJYNiWiN+ibQ2u1BI
         pWKDSJjtmBBj8moViZjyj/EyIYbOV5BiV20b0ZdULk+3VDETuRD7Ej0z81AQVvbW97rB
         /EJ4aJhXaMrktJ2gnFTCEk+22kY1yYdlc33/PA3CMjobdlOHfmhLFRUub5fngZUSfx+L
         dPJD5EP9U1xmJ/xBdgCm9mfZSM32qm6oWx2mtL546VGohbiTMxT2njq7yGp1bwXlRNHQ
         3OAZpPtsSvD0PV7az6c0Cj8TXBr8hOXTRCK9/nbV2lw70vk67dpXb/1YH2qMwp9yhdF/
         BkWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdVKII7ssBMWVDX+Pp7fnIvRv4TTJmihXretd4CTa3/a/Bq+kfJ6Hw7ZSbJaMW4+4g04XK1fbDqfQhOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9G5CVxO7Gw30dvNSLy6wFo9DDYDJ4HP2Y+HXx9NtyTgpjOH+
	G9DcxuUmxjm63GphLuKxQGyuqWVfMKNbzb+9PJQInDtLxp2xzjGrfdTyvCHQi1Ue5Mp07mT1P7Y
	2uhBoX6zxUG//W7IRjN7zAqkC4h7qRt66ML74G4/qmjc2ZmBq41RXy1TAL2qQ05H8AI0=
X-Gm-Gg: ASbGncuDrPrCUoM9ocS86SeeawNkRIMzorv9l/kLcSfmaHxubTuwF52jiKWDjznOVtj
	Aqx21KmlTJa/JlcS/IDR+JO41SRerO1RsWTMjZUkFkEFKXJ2bu638z8cTZCh2CqjqYcThqNbOgs
	NbEJweBKARN+PLOsgeayAZpC4N4AZC33nXjZSiWomrdkA+FovbBMRxxJ5JrpwYbOATJOK+XH1qv
	tgq3/uifBvhy4yVkcIt5g5rDl4+i/+g70WDKY3PpP9Zr8UM7C9lutktBzNesl0s71TRo5HY22bM
	z2yxWr43bJZr09HY/uCIH0lgU9o3a/2Jymr2N7XGwcKUVk8A/6J9oJfoqKkdTvPpSDPaoyIsRzE
	0ZQE3oXBOiW0ElaejYaTjp4c=
X-Received: by 2002:a17:90b:3bcb:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-3436cb91d57mr10342260a91.11.1762792842920;
        Mon, 10 Nov 2025 08:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKgiLlV4ge4N7aykjwSwNvV4o0Enwd4Uv2Fhb5/BsT0fXjzUdfmFl0uh16HkMMpYGhsNkY5A==
X-Received: by 2002:a17:90b:3bcb:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-3436cb91d57mr10342217a91.11.1762792842430;
        Mon, 10 Nov 2025 08:40:42 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:42 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:25 +0530
Subject: [PATCH v2 19/21] dt-bindings: display/msm/gmu: Add Adreno 840 GMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-19-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1792;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
 b=eQNZUxkw5igOzSHswIKdod1+5/8HKSYuY9+tGDZhsMU72Rcrco55Fm5uE0tPCMdIF2KWAnNZM
 /YOiz8V/KyiDqaG+09P3D1DWGc74RvvkXZCpIovZE2CAEjx+EVlVC6f
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX8ryQ0rqPkzBY
 M6SxTFR6pmxCzn5KrEm3BePqOumWdWmVzGu7Lq+5+EaQapQhJUydCYIFC+276ohQ+wEOoef5Lic
 r8UHcC7djYdTD6Jy9uziIiINSPferkjWd098LbSv71PDDykfHHzuH9EMbx/SbOZvQ8X5NYUqKyn
 NZ/+i5+qyYuDf9U+tyCEEdsEUQLayZ63na5pQccVdZQX42toahW5ELDUgUU6DFP0rsnBr+ti6pF
 AokstPfN/X0aURqwG4I1+NQItBio2d9IfO75RjXUG+DmxiE7ULb2UOEYjhf+qiyjK+r6Le87QE7
 nwAWzUymQPX8sTXzqq8KBIvDP4CkGQSROMpUma5ex8XqQqmIamfIDS8aJoQZly+w1N9+nacz4Td
 IbL/i7x/MVYL9l47SYwZQUhoDq6iBw==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6912158b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=e8idWDajkKX97RI96f4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Z8ckxARcizRwzS_AlD5UhYjV98P3Jk3u
X-Proofpoint-GUID: Z8ckxARcizRwzS_AlD5UhYjV98P3Jk3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Document Adreno 840 GMU in the dt-binding specification.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index afc187935744..2ef8fd7e9f52 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -21,7 +21,7 @@ properties:
   compatible:
     oneOf:
       - items:
-          - pattern: '^qcom,adreno-gmu-[67][0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-gmu-[6-8][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
       - items:
           - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
@@ -299,6 +299,34 @@ allOf:
       required:
         - qcom,qmp
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-840.1
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
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+
   - if:
       properties:
         compatible:

-- 
2.51.0


