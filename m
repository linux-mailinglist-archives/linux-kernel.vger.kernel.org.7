Return-Path: <linux-kernel+bounces-875031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290ADC180FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FB01894D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E61F12E9;
	Wed, 29 Oct 2025 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fn7SmH3V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XjZbCL7J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D54315F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705103; cv=none; b=HnBzdozSJjwrnAjvyTDKWH7Ph74JWEB4JVMRmdk4gvEX95IOkVcaBKkwrOctEFdCz1rYZifJcRZSOmNeWXnizWlYXLxMV9rRHJOqewYCIlczhktZiL08C9tA2xvso9KIXHuu1WnrYmt2zfwW5lWgKPS0hl8m6it9e++5VQiW9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705103; c=relaxed/simple;
	bh=g7N28kFHcXcwHBlOAWcJiAHR4xwx/pSur+aW4iGjL6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgB6es05s49jASeUl31xk0JYQqp5nRMwTPgPLOeyt4ffVAqfHcoW6cMhSFMzm6O73e0XRQLxELepWOlWJo32Ww0Ti/Dr/qVODyQM+9I9N5AA7Dc/pGhO+H+epfOm4HC68L5ANgIKUsglhz053JiWbCQhLkHZSCepQp9Lc5JcEC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fn7SmH3V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XjZbCL7J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlIVD2554244
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RCz1pudWlWhAvVjENZQZb1b5kECSVZ47OjN
	VesESA0Y=; b=Fn7SmH3V3ELDvJaSFgHFh91wRDp0bROyf2S5xfV5QUZUC18cR86
	UdyRR7W3uQBmd5agw1VoxjTuG8IOMsQkqDCobygkPyvSdDeV6hwV/hlNEElK7jAt
	bi1/rl+DwA+mSl7VITcvi414awyuxi4d2JMxGntZzyXNQnwM2kpM2jlFJZw38Hm9
	2VTLCh9Aknj+OK27fyw4947WxRu8sepJL5/4r3z4ob8RqBxKVwRaxTlsJ68e9510
	m9Kg7VgBJaVgYHj2Bp+Y4QDbBGGT88DWJ7w5HHE1/akVsqWla3hKCdlhYb90a8hq
	2UPqL9yFEPKV2C+9Fr1MMsZ6WlXZ0mwTUOQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a10w37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:31:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso10770781a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761705100; x=1762309900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCz1pudWlWhAvVjENZQZb1b5kECSVZ47OjNVesESA0Y=;
        b=XjZbCL7JJi4TF8it+wc5fHRQ+OMy3Ej3EgBVof4JHf7ZRsPyuFfLSTE8YbFFA5aEA2
         bs3oT25CQMaKE/Nz0iq8KsUNrdxeEzwmfJU2obBVO9mzO1h3opbPTtDelyrJ82CUGlwl
         sO406fFX/LI0X+/Ehb5fy0lgxnq453yen6+ZzBQC6NbblYg+j/c00xkMIFbKKcw5aC6M
         vMceKOmEBGxx85RI58niK1fDAsiQEJN3eWwiKMN6sAjGzZQuDydLIALGyF8S1ZwJUU+P
         1uEg56CK9R5X5LIPM3ulEiE6+UPrFf9hWckrM0QAQ8beS/qnzgCDqFdIasDMtwnaqwr0
         jdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705100; x=1762309900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCz1pudWlWhAvVjENZQZb1b5kECSVZ47OjNVesESA0Y=;
        b=kyeiIILOz08y2EimTUtivQ+Z31Pgi0wlW+TZBx2rt5g/OJQRlsbmHYPAf1BKJLxOjX
         hQn6w0emMu2YwIrEQTsRdXY+JpSzIGWourtAKRqdNDCVh2OOl50eR1l1qYWvEpltW18S
         bo10mTjFQDZlJhPajBedrOHXxNc37dhd8H1Wj5fF5XVmVWjlskLNRkV6uxBVLf/6ym8o
         B8Hi1uChmvAP0y3zDujRmpF642Tat9W2Xt9/Tx5eB7VaTtJQ4BvHhSHmBmhkPfEuui47
         rX69ik60AGQ+H0krJhCPXPhyz42APH0wvomK20iU+n/gtedNH6SjhcHzTVFP59X0//W2
         dlXg==
X-Forwarded-Encrypted: i=1; AJvYcCUi6s+r/uvdD8xB2Cio2jy47YoIASqeEbIT4ypwTU5krHBuossVwIDAfnQG9xnr9sQ6IvGp/UDDpGsIPHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYVCvrQ0UdzJe0rx+B2pca5XBsJ5FvCIjn5kPxLleURY03RgY
	dOAKb7KhgvB1YzovHx2WbIXQmw0V90NcNrE0NYpH+8nOo2NAIEJdlOdckGeshSAuawQ70jRUGel
	djVOoY/1dTRPXeq45CZBeftrj3z/C4d8AnVGOXBKSpj2ZKB+Mnw7lU5kITnSdOBAwyfc=
X-Gm-Gg: ASbGncuSe1rPP3FsvEJFlqn9CxBEmj4s9eCiiyPZQdMxZYT3hx74kkFTHA9qRJ9GUMo
	Xis9sqq3RY022IMtwJB+RRusJG/S9oq/fOubBK5SDZZ2HM6Xet02mEnPa0X/lczSwo5Q/A04/wj
	AJ98KnCKlMm+p8pJmxnz7NxHH3spKC6XERZHdPMHBChy4phKSq1Es5a7Wmk3e8tzYeBnTA0bCd3
	xFBs5XdgZ5zDJlvBS9Qh89bbVFySnnb+KUddB1bWCKwUcf+hQDlKgF+j4gyIt67rUyQtAcPpsqH
	uxB9l33+ub0YwFkACII7kRqytzp1AcBnzeGnwjrFj4Zr6JTUH+tTrJnLLovYpLQs1NutmH0HOp8
	JlXEbeEgJUGAWwL6Fdpl3P2yOlWYyW+ZzLWI5NxaPQ4YE
X-Received: by 2002:a17:90b:384d:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-3403a15844cmr1480548a91.14.1761705100414;
        Tue, 28 Oct 2025 19:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd0VAQmf31SXQY4LxoHngpjy8YiK3tt2nlnsdCIY2Qe4hB//DaYRNWlZoiONNgbDcIgRqpTA==
X-Received: by 2002:a17:90b:384d:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-3403a15844cmr1480521a91.14.1761705099904;
        Tue, 28 Oct 2025 19:31:39 -0700 (PDT)
Received: from hu-liuxin-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm13488875a91.4.2025.10.28.19.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:31:39 -0700 (PDT)
From: Xin Liu <xin.liu@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        jie.gan@oss.qualcomm.com, xin.liu@oss.qualcomm.com
Subject: [PATCH] arm64: dts: qcom: qcs615: Update 'model' string for qcs615 ride
Date: Tue, 28 Oct 2025 19:31:35 -0700
Message-ID: <20251029023137.381386-1-xin.liu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAxOSBTYWx0ZWRfX6BSVqBxWFdTJ
 EmYWCfiBHYiXuFZynqwfnuHJONSP5FltLnwxpEt6AaN0/A89H65SW2yXb0SagCeHOa8NdBYh0Nt
 vVxMET8DlbUYEoccuLtGK0yj3Ze6iWlyA0ki4MGbM2ht0JO9+sE+yZo5qEwi/xk/tlRaAW55Vz1
 sM/YaqC8uVEnMS/jrgFGNFTXYNEi/VafnDupjiB85e6d7wsp6cAs+hfmPR/6xXzr6T424noR9Nr
 bKzgP9BhfV+oM01kgxxK+jGGWPi1WDeuSaNs1n02fQXQn0UsoYWgSvSTcqXH6PXDQGz45WHICpv
 hGbYNhRj0YxQeyAHo1nVbN358L6Rt1BTX8yDHQ7SRxZTnx5DOXLbsBTLq/zsCd35AAv4iwQz/NC
 6PtgqS76UYmM5IjBDhQhdEK0C6E6aQ==
X-Proofpoint-ORIG-GUID: skI9XePM4EmToX-_P-VANKyiC7sAPEnQ
X-Authority-Analysis: v=2.4 cv=EKULElZC c=1 sm=1 tr=0 ts=69017c8d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=a1m0clyzLRKmXXX_jUQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: skI9XePM4EmToX-_P-VANKyiC7sAPEnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290019

Update the 'model' property in the QCS615-ride device tree to include
the public board name "IQ-615 Beta EVK". This ensures consistency with
official documentation and release notes.

Signed-off-by: Xin Liu <xin.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index e8faa25da79f..047ba656f67d 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -10,7 +10,7 @@
 #include "talos.dtsi"
 #include "pm8150.dtsi"
 / {
-	model = "Qualcomm Technologies, Inc. QCS615 Ride";
+	model = "Qualcomm Technologies, Inc. QCS615 Ride (IQ-615 Beta EVK)";
 	compatible = "qcom,qcs615-ride", "qcom,qcs615", "qcom,sm6150";
 	chassis-type = "embedded";
 
-- 
2.34.1


