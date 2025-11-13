Return-Path: <linux-kernel+bounces-899139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D5C56E41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B373BA5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9E333725;
	Thu, 13 Nov 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyUek2PK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyWvpCr4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B932ED31
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030177; cv=none; b=iUwC38HKawDo1TUz/gD8j35O7db/CRrD6eujihJNiXOAd57E9+OCk2OyxhUESyl2BJRzpfHRXFqetz/itFXmQ+MhQLdvFO46yUBfrkGFINurprK+0+L1botUrLs1m+7Xy0ArexzZGktIe6hK2nl+b5xy1heZtPHcH9LlxTRuCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030177; c=relaxed/simple;
	bh=fkI0IV5pKXD+Z8pE0/I4omqNa0GvsOuaX0Z626kXB7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ns4YkFJP+VsJLVb0cL4A5mk8zRD1bJHlEXG4JaACyudU0PyUekyb+xNZFNNtJZGevQpi4seEKnb/j3i9LYuQ4opL6J7GTT2l1qGT8P0aJXjmCeSdLfGwy0tefoBUXCPVuPNkfgrzMmVKb9pY7ceuxvjJOdXdihdm5tuESonkQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyUek2PK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyWvpCr4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8d6qV2993501
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QAPzsylvQAf0leJxcPm7SZsbOhaaSA1OJ2ImRJF3POY=; b=SyUek2PKr/5RKRoh
	dK+MfEFkIuFN6p/hmQn1CqjeSl58Imvau8nK8/s88R1Qqqk2mfauBchhgm1edBOI
	0nxdVgYuxUEs9SkHSAfgJD/gFMPlGxkHfzRn70dYLtOz1whvrDcikKKtZWuzIVIP
	Q6vzsMA3hHWDbWBB07Ri6CPS8j12VUpDQPdfmKZxrVfv/ZPut6ilrxxtiAXjkM41
	We93YblO07qklWwYFENro6ww/Apv7a7Rr9MJnsNU0dxVV6xY1xCamcVdnf3Xix7j
	nmH8s5QEZ9xHOS6ub8yrgDGktfMfD8cWDD1bCKB2MDmaQh2o55CtDLUIUBBVmWFa
	AROzAQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jhvrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:36:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a153ba0009so1448139b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763030173; x=1763634973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAPzsylvQAf0leJxcPm7SZsbOhaaSA1OJ2ImRJF3POY=;
        b=AyWvpCr4bvNrMZ+fdX/9WAOMBB/JtizGNNL2SzWgghL1k4UZBzipwk+h1qyUF3Ar9C
         D2qLpWpx0TqFGME3TFSiPMKMSGwFUomCugGQIR2OPW1H1V9r9nzhhBkYNTM3x8VHjeaY
         4h7KA2Wq5HvXkazESRP9YMPAmI2EhFQ2h40f+WsCQbs/K44jAiTlL8h0VRJ1bkj3L66W
         VpDprbMgJKMg+LAvdMN2j99iGGNLNzmvRP1KdJ4m4MbTbxxKFoi9Jm6b2SedJ5ZXxJCq
         PEDt1UM+Yuax67jKRazHDGgMe8T0JmEfU/bpcSIjbL/Hz55OhgYpi9X5XlGrDHVjFAJf
         WuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030173; x=1763634973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAPzsylvQAf0leJxcPm7SZsbOhaaSA1OJ2ImRJF3POY=;
        b=tmxZ3jPZ3qAi2yRZavY5nXMojT/3o49P1vKelW2Yd/Luab4ws+BF8kaaPWl4t43tCG
         kARSBscjGlR1i2te3lGvHQIXAqdd3eVNvnw7Jirz5blFlPn5MjHrvJBlnJF0hL6YTvnx
         U2k2qzDuY2G92v3wFY8/kLhSKOfJVP6tsp1W+PgN8uvVplympQp36fns+ylJgPwgS2j2
         irtHh6wG4QmAu/noivo3Q8FfpKmH/Tg1pv8k4+GAcNdkN4CAtZIsiGiWpynY4SoIRlGa
         ttGKNW7uSc2eMfZ8Db4luzIMlIGi0wAOSwpbmdSZDVQXbFmuWiXYwZ+gAi+GpJ5GMLf+
         52Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVfrm9gJWvg80qTUh/nBbNI5PchhXpnTV6wWr/mt5BeWSaGgIZhXTlIZqixO5C7/neMeVnksRBTA9qGiUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOyjo5pq5RdHOK4b8DJmUZ3dPI50i2OnOx80VsEXhHKrBjV/V
	XNOTht82cCkU7xtwewZe2bmtYzaAIJY3drBhDH69tF4DBJH6n7kDQuUMLN+Lb5KbSYQtP337jWS
	hgFEJZ0uHXXZkRPcEC3Lf5tlnAcdpQXY6/846j4PURs1jNtjrTcnBVA2DbuopEPqWHqU=
X-Gm-Gg: ASbGncsLNQqS33pbRgs6TUWD1iPUSkTKlQjvv+RyrIOcQg+yfyTns+GjEHH8zspB6K6
	b4Q8Fbtf6B2CBk4WZ74CWfm6LOxL8SJ8LGMu/7UEUWEwYD/Kr7n+npZR/N4IGQc/KEruv4CYN91
	9Ce4rVt5UWJL/VVWq5hxWT0dvxBjbV3HU/FXFIhLJNWcMinfnynOgb7BElir6SSEYtL8zHQZ7/A
	ZVmcvpAXr5bMIQ4uZ71EUS6blwUIf4xXYCaEb3m47oaU6FKeQRerrXt1A9DS5yQOjNdb7Uhl56o
	diIUcyJRj57ZVMpXAFs1w7tKcHI/El0f/YIV/uFdfsOosgtQ6oW5tsGh2djw324cBk6PeKd/u+2
	EsqYAZ93LOMQSSpl/NS3ySaSUGw==
X-Received: by 2002:a05:6a00:3a07:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7b7a46ff5ffmr8505601b3a.18.1763030172643;
        Thu, 13 Nov 2025 02:36:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdWLsFxzN1Qeb7Ay7FtILT6BOrn+z9PA4q9aNMwHkP3I487Ru0WW9RlwaWtIoOpnyunhqFCw==
X-Received: by 2002:a05:6a00:3a07:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7b7a46ff5ffmr8505547b3a.18.1763030172006;
        Thu, 13 Nov 2025 02:36:12 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm1886922b3a.22.2025.11.13.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:36:11 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:05:51 +0530
Subject: [PATCH v7 01/14] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-kvm-rproc-v7-v7-1-df4910b7c20a@oss.qualcomm.com>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
In-Reply-To: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763030164; l=1346;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=fkI0IV5pKXD+Z8pE0/I4omqNa0GvsOuaX0Z626kXB7M=;
 b=z9edZJO08bBDewte2/znOlY4lNVMe64h7yw0x7TMliKqjw9A/NcCqwVM2ocm3j0ihXnADUzPw
 zaylC4D4E+xAYdxMiQGeSYdAlrbeP/fDaWUjLTvelWPtNvB4JjRZPEs
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3OCBTYWx0ZWRfX5W8cEvKn7Fsy
 hywHqGXBjJghBx+6TzaSuaarpFSAFTBGilhsZoSPOTZaHAwP4ZTiZ0iPmfGqyjv+5PEgHe4RtBe
 SnURF1shBFb5kVkiLN0QP3RuW8p2KztMUEzFyw1RSVOUnUc0uD8FatTFEFSLorNPmBXrj3E4c2v
 hgLm7F+Gd5x4tVhtMizUgX7O+z1pF8rHGl3Rq0M/iFCEnjCqn5yaKu9MIkXJcF6ldnydzYVhi16
 LAYokSKYQJhcQhmmZwWNUhCzpMx+5lPWX+u9zWEKropqTiMR+K+rhSyuv2z2sNAtNuMhHbIBmuN
 YuMzH6bOx4IHyaK8w3JcxY9FGx/W//YZeFiLrfK3ZGGxSa6L0qfHXb1ql1H761EMR/8NMUiAy3q
 sM9WsOOKOAHNjuzhTW+ikSSUbiCwGg==
X-Proofpoint-GUID: bD6uDzr2hayUf4TpmKa6ceNsGXD11EeO
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915b49d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=nDsJnkO8JLPJ0mjf3QIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bD6uDzr2hayUf4TpmKa6ceNsGXD11EeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130078

On most Qualcomm platforms, the Qualcomm Hypervisor Execution
Environment (QHEE) is either used as a standalone hypervisor or
co-exists as a module with the Gunyah hypervisor. When QHEE is
present, it configures firmware streams for remote processors.
If QHEE is not available, the operating system must perform
these configurations instead and for that remote processor
firmware stream should be presented to the operating system.
To support this, add the iommus property as an optional property
for PAS-supported devices.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 63a82e7a8bf8..68c17bf18987 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -44,6 +44,9 @@ properties:
       - const: stop-ack
       - const: shutdown-ack
 
+  iommus:
+    maxItems: 1
+
   power-domains:
     minItems: 1
     maxItems: 3

-- 
2.50.1


