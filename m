Return-Path: <linux-kernel+bounces-737138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F3B0A839
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FA13AE0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62252E6D28;
	Fri, 18 Jul 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBFccEd4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C42E62AC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855243; cv=none; b=t1C+VM7/Qi4RWjEG+QetJF4xXeLr7gAzDQRsaLZP8a7P6heQV3VtY1OGCS1AvorztaH/6AfX4aZ2uvmqWOBPIW23gbh2/hnvRzSRmaBEEB+NlOTnhcxWV/gnnoVt6HsHl6rm/G/T64L4Mc98Ar+4dBZYQW/0ub1/2+3dSnIfsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855243; c=relaxed/simple;
	bh=GS8W5OKhX5k/3MQCghSpRV/kbVATVCRf5/YkEeA5moE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbe73M6RxUavgJjagNXQlrtzzBULXhJ57ivPngKKeJzlqOSTgl+b4n+oJtY25YIGjYs/CoQR9sZXly5/fGiFNpt0cy1QlI1N6SpDGPxKGBOst1mMeMlIXL4gg1L69eH/JyDgbavDX9ByhL7RoG3SC+X1oiqrVzhoa5KSWeFwq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBFccEd4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ICL4oO029884
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/MegsDezoJ79tZFpGw1Q8AeYWxrjPn3HT2ydHvhFydU=; b=pBFccEd4Wx/lh3Bx
	0baDdpJrAVlSPbsVtEeTH7+PXy100+0rEt/+u1MKhY33ccl0/7NSMXBoGblR/ZPw
	S35ODjNp1M+nxORrVKJxGpY3U+LqsQtU7TPH1ICKHFPwHTszqrgU6QPX9J4COuXR
	7KVPc3CH98nvAWGAvY6lwzsGZ8gicCBIBNLLO3w0sERs/c3MEWkb7zqHIv3bosvE
	eD8qRavQ9U8Oeh5xuL3rCz0Q+95zR6o6faiMuXUR4lppSAoXZlqvdk0tgKkfBV5F
	o4rc6JSQcCOOzE9Hrq2zk33sG5KA7AsMSyQswbuLk3D4QPLtmdFUyU4XgDX/+oEj
	QX7vYQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7s2fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:14:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33af599bcso376079885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855240; x=1753460040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MegsDezoJ79tZFpGw1Q8AeYWxrjPn3HT2ydHvhFydU=;
        b=VIuO1RgOgCu1aHfTI7geW8QFzQlNdRw12eE3Slg0i2mTziRgmgVWEs73L4TnUNTmbB
         R28kX0PnvK/hkWtaQ8HuE06B8QHnr80DHdgvq+k9DOtw6WOQ/XxrXgYu5amGEF7eexfX
         mzczfD8Rl7rTu64hjKG/EEPdvyFQ/29I89Hf3VTc8PyLbZZ2mlMWZzztnoS6knHiMU6S
         Kv9MsAhCUBO8icI2Noa5A6oasn7/f9WiD/RFdE07VM/ssD13PTIHI7AZy1XVNPWfdPu+
         M1ydLO6/lBAsvn5hOckwFLdVeUlfQldKzl5ZNwrWn4HlFkTJVvovoNoM4L+L9hoJQL+T
         n5jg==
X-Forwarded-Encrypted: i=1; AJvYcCW2xib2w09ezD8a884tfWw3zFLjXC7dvyrQKvlimjeDm10B4kaipLbWxwPYQhUdWLQ8H6UsxVqVB32wsV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1RVg7MuzvU1yA7GWMM5Y5Sh5EasRzK+Ebn/qDVciXYa0JJJf
	auHlwk3Tssd2XROYQiBy99cUrmrlM5F5DqfYPnUGqd3BR80wJP6G1axvK17iQmUeGlx5JYpvXgo
	G4kmSQX3X/FHbug5rNexUivg8hRspaSw9fiOIPEyeqfR+0bCfbUk1+xdltRjDqsqaOPs=
X-Gm-Gg: ASbGncur8ldW3RiI5ZugavVprOG+fiICzUeqsnNxPOjwq7jENnHyxiPRwblP/8NP2q4
	FiVat6Eu8SgloGQkRct4gTsFT3yLrKFpEqQLfmF3CeeRYXpmTi4W+NYMlwI492/Dlb+UiuPJKSn
	/hXg+mlNymLFvEoCS2wBGnIF+KAvLmkKWoxYIFC/O8bQp+dWqKU37t888d6xra+Ixwj0X3A2yfH
	pqk0G/sspxTIkJcaL9X9g6EJqbV9JECX28BOxN0DkDHZ1cuGJeJHLgNIFIwk+TIRBRT/0pbLq0W
	gVEGLRPE7Oyf+BzDLVWvlKZdZV1FhMcahglKdnCPjjYqU274dWtt+tZWQZRuhQTsIgK/YQNsLru
	xfjHnngcuUOWCg65Qele6Y91vqyQ0s8JCcbOXMihmfbK+VuvcZCHC
X-Received: by 2002:a05:620a:1357:b0:7e3:3e32:e620 with SMTP id af79cd13be357-7e34d9ab6c0mr981680885a.36.1752855236350;
        Fri, 18 Jul 2025 09:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEETTxoYHaMo2UupceBlHL0TBQW5LinpfSukvtJjEUlWPT/+Pekf+q78KOdNgHFAAMem1ZIkA==
X-Received: by 2002:a05:620a:1357:b0:7e3:3e32:e620 with SMTP id af79cd13be357-7e34d9ab6c0mr981675285a.36.1752855235755;
        Fri, 18 Jul 2025 09:13:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:44 +0300
Subject: [PATCH 6/8] ARM: dts: qcom: dts: switch to RPMPD_* indices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-6-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GS8W5OKhX5k/3MQCghSpRV/kbVATVCRf5/YkEeA5moE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3f9gT0zERUZec9/hsBUQ1qPK6ZuGLIOve3
 S3naw0SXUeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1djfB/sFx/Qa/dlaCqhOszPGddW0LxXnXaDbnVtsqUwKL5xI0ckxf/GOxTrGWqrY6/FILTdFH5h
 oTXojXp6+aH0hpFTkkuE8VbllnDMSMfyL1nd5e+JfiPCrVdyDhmCh4C0CtkJlY+Hhj9algdfCIw
 VeuKF8rlqI4NqBXqaVrxfshNf9ZJQNNjMnS65dw+gk43Hi5gyHSvW84+Fq+IO9glI5JGyGxuv+o
 aj/WTob6RDLb7elEQY3tjCnqRaRjPbbjMI+JsAc8SPC2whki3e0chNnC7+ylne/j7Wg28LsE5gY
 zCWfNlRACRkqr/apeWH7J0kXYp14+E7m5d0DguYjMEq/myqE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX9bGvWlSuBzJc
 Be0lXWTq4OpokdEJvqR+PnHAvdnTTlE6C74RHY9+BHbCU6GRF0Fp50/E0Z0KnbsjDHFBbnq+EDx
 Lq8uzl9ZEulsBVinqwGtLxt8B95xPE2mmLD4aw3ur6nfmlDgOswYB0UD5oPuucJOy+YYETgORbk
 QN90u30bIf/SLOibxLyP4oEZb88L/kji9vy6b6kXRvtdXKKRYN8cqJelIExidFlBx2fqvFBSfor
 kc3JAld05ClXy+IyQKssyWwDlxq6/zMxa+Bwsr7rYKeJNO5VZFMhS/dmRoAQOLDjUyAeYmmZgl/
 XiqGK8JICg6Rgmx++yEnTW44i/RCFkbtkFlNHQz1IjmlDJWR4dqgeUSUUFeKdNSPaqBL1xRhzgs
 8oRw3cShNFgRmYJpcv4Mzsx0xbWIfyt1nWeSvajfBcDsApGmlCcCsSCc1IrIj15qfCdJfSP9
X-Proofpoint-GUID: 93jgHe0PvTY19iLVzVzfMVmGnS-7aNgD
X-Proofpoint-ORIG-GUID: 93jgHe0PvTY19iLVzVzfMVmGnS-7aNgD
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a72c8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AJhAjMZ01lUAXvDxW_0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=935 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180126

Use generic RPMPD_* defines for power domain instead of using
platform-specific defines.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 51a7a3fb36d88eeb8dbccefbab672aceb1e46428..bcf14a3b13a1b4b3455ef4069df2f3d9c5c7f9ff 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -959,7 +959,7 @@ modem: remoteproc@fc880000 {
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			qcom,ext-bhs-reg = <&tcsr_regs_1 0x194>;
@@ -1372,7 +1372,7 @@ adsp: remoteproc@fe200000 {
 					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;

-- 
2.39.5


