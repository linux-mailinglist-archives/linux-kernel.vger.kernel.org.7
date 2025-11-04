Return-Path: <linux-kernel+bounces-884218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE76C2FA46
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBF61885B90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126930B504;
	Tue,  4 Nov 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TINRY+51";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5+G9GpS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E19309F0D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241776; cv=none; b=Bly2lphfK/wOrw0tc9YAnisPFuj5iRjfTdpM7SmXotjlEKaQ/dLtx1+arxzYiTsiEHvNytSpFiebOAGOpKcHYMxdW9SUahKOBCeHSWCUQ3xgdLwfAT6Buqd8Vly34MZhzSuZl6i0w05m1d4d4zui+19cd7kRByj6f5jBIw2/3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241776; c=relaxed/simple;
	bh=5S7bewqa2P4aC46GNTPc3Wfn3h92qyoaFLzlTIsn9fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2Ei7TBhEUoKUSzM1WTrpZn4nrM+/EdAEAzPwmRT+IFXAajmC82PvC2juEOdikTINZbjLeYCQudxLE8DOqtUNETRYWBtcal1PD3QO+6KzdB33B+iwJiNMuWZ5YLaDrq0+bY+W6JyP5FsnqQETOXLU3CLTEdj35DanxN9nAuUMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TINRY+51; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5+G9GpS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43Th3B3667744
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PFM8hA0K00Qfpbxy4GnLDAkU4MBb9gQY5AMWZmJe2JE=; b=TINRY+51DS8ZAnwZ
	JF6RQKbEZySryXEXzT2DjsgP1CViNFrQcOyK/MQrTWFua9MhAWkXsQetgT4wi7uF
	8pDKnnknniLxOJjOvuH8tz2hm59jykuCKZ7R1ABvo9Dp50MSDP8M0h4Qmqg/4x0K
	5pNJXdOsSRIASdqVSrNc3QvIjcSLR68olUsvN7rrRpJLgXIOiriIaV+2k2WfeC02
	znDKf0POfOLBCzpDlueJMdGbjE9b5GIa38uoLKAvHEGwOHRh1bH7vx3mbG4PW7qM
	fGTZ+v/ptgKwBIHnGjheqY5e425SrTFv1m6BAlLLlUy7vq8krbleG/rO2vXbEdEh
	8AaC6Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70ffj3dv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340c261fb38so3332720a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241774; x=1762846574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFM8hA0K00Qfpbxy4GnLDAkU4MBb9gQY5AMWZmJe2JE=;
        b=c5+G9GpSNC5uUsvbmfhgK9cIUnpmZ4W3bEktla7QNMDexRJHtQ8kSZoqxNr9YD/1E8
         9mED3SXGI5sWslH+mIdKxl9iNNj8ru5gT0dOPG/4PjCB6pAiBCDjzCVoSzJJ1udXyGk6
         wEZRE+9SZgPR5B3wdZOFzm+zwwNK+ypV60bybh2k+hr2UPP1zxAwJSCiIvEC3/V+qJNr
         UARO/IXdrINJoikzBdwmiujAdHGxQYfwAxksxqHHCTBcAMPqpskjy4p4HRkt1BIfLFzC
         gymspcSltHlv53VDgQk2bKcEvgvdXJZW1h0N4Cg1wXsxsPms42KcfQ+kUrzRl2+i265h
         6dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241774; x=1762846574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFM8hA0K00Qfpbxy4GnLDAkU4MBb9gQY5AMWZmJe2JE=;
        b=doLJcL1Qo5uKaxXrwsshRj4ENJHuoprYy7AZfK6AZmtVVwuNaTp7Tpdpvbuex8VZKG
         w5QUxXNlPjoGrOv4XzIubZevviX0rRFdcaMoIBVcccu5oYmFNJU/Vs21LZ8ZciQmEUQm
         Mqty4D1uZNI9PI2E7+5Dpr1DphHdESJnMaN6zQJH0vMGXd+I3SQYfdhYfUTM1Hfv7H9L
         XsUZ90OxC6t3lPnSdjn/HiSI3KYH8aoVFOiuQXrcwbK24jiDSfwWT0OBAskAX+Is9KK+
         WrY8RQAUPqHQ8LVlj/C6TIxqEOSawlQFNn1FAA4fkUrlUWhnL3TGQFrIpHiI3j7qCUDI
         KVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXswjHdrz6raKoofxegZuH5oGrBV8Tt4jzzGEk/OxsDIG8q78Zqj+NXtwUUWPgW++tr3G0cnidBv2my+z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPvd7nUKCvrmEEdxSzJwdMZSjCQPugGXiy80x1V6cZud8FRST
	fLhkHo7QLcgBCJ7tcT8/GHt/5bmSq1vWLPTL3K+3XD84oGyoQykuArcS272qpePo8Zk+synTQ/7
	IN3wm/QWCVwpLwzOt4BgWrLfPNi+uo/W3pE1w1YCifViBNeE6nKWji4wdICmT1Bf8gBM=
X-Gm-Gg: ASbGncthcE88Y/2ray99ddES819UMu+gaNiu14S0w2fUCAMeePMIJdF5D/Rrv1Pm6YR
	Zzb23SQxR+Oa9Uoe4T1LueUiBc+DQGzKZE6DEgxjzf6ryAVjyAupQ26sf1XrM8zvAhckkSKpzQ4
	m0pmDS8p+wHSe3znfHQiOiSFP+AMzWDUO1GFhOm6LDY2tgf+l5rg/AL0aEo+3bnN6j+KJKtvdsL
	Bv4TbWXjG7khZ652RyuzDPI6GHHi0kxy59LGWcX2MyMtLTqhK3o7yPAYiGfP/7i40h+C/JarXfU
	oKe600bfjfMQDaUXhxwRGi8Mxuce8FeVeSh5yCloVeJeOIotKcE+zSd9E2zUH/9KPmbcFIMo8fU
	RpRJdksHqi0UVVc2vlwYe++Lk9w==
X-Received: by 2002:a17:90b:4ece:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-3408307ea8fmr17567606a91.22.1762241773557;
        Mon, 03 Nov 2025 23:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzBEHTkjPgdkIwUI7lWkEQRpIDa20jvrpWkfugq5bytrrXQmYVQgd0I7u9hQ6Go4ioLIm17A==
X-Received: by 2002:a17:90b:4ece:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-3408307ea8fmr17567555a91.22.1762241772931;
        Mon, 03 Nov 2025 23:36:12 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:12 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:41 +0530
Subject: [PATCH v6 01/14] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-1-7017b0adc24e@oss.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=1163;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=5S7bewqa2P4aC46GNTPc3Wfn3h92qyoaFLzlTIsn9fM=;
 b=xmcHbhegIJZig8VyD7U17RKCKojxbLdOTD7/frVeqLBpUy8FgnYDoeV+4fh8p9om1T1Yn8YMf
 oL0YwuEoYhVDiIFOe++KpSNVufWoimeI/nvKwW9tcFWOOeWyda5pp3S
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=6909acee cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vdhzk_XxDewY554Buq8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Uh8T3ncG54EW3wczB2NqcdyHBlZ5v0xm
X-Proofpoint-ORIG-GUID: Uh8T3ncG54EW3wczB2NqcdyHBlZ5v0xm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfXwc/0CayClyqI
 h0qMODTouGHxgTxd5NjlGWE++E69Td6BICnGhZUAZ4aqVLB/SpkzfMJpV4Be5ge8k8igoSbJ2uw
 7pqnB2rQV4cNIIWQXtqCJZ45ozWQu9E4txEymqIvq/P7l4+7mdQwfBdZ5glmaWIVVEr8WAVGmPj
 5Pq6JrWi31Qc4dpFMjgCkZwn5USZxqVuP0aUZ70LIzEx8hlp8YHWtx9ZiRguHTIm/NghoOWs0mG
 TJSJcKGOLfiQ4rJVhGotEDrKx7W53J9R+2RWJQlT4cTAByHLunDyD0s9eplSUoX1Mw0uWmapNku
 skwfuIeRvnnSw19gTSs6SbPNjJrsEsD5p/aMFBtfqGifBGZ1xW7lFksDknuTrOuEA3jDBDfDDsM
 8GnPXE4pod7Vrdn2u2QTdaNScB2uBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040061

Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
configuration for remote processor and when it is not present, the
operating system must perform these configurations instead and for that
firmware stream should be presented to the operating system. Hence, add
iommus property as optional property for PAS supported devices.

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


