Return-Path: <linux-kernel+bounces-764335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E841B221AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468461894499
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE22E62B0;
	Tue, 12 Aug 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hq2rRye0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81A2EA46A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987912; cv=none; b=HeqdBunsOFIljuNhkuTYug3PlAPigT0N6DKoulIcPNLdNN11OnCsVabnZcd+oCqJUljALPjINItjn7vPxhBCyARnKoIAqZZyHWh4UU1k/xalHd1iHAxwnAo1RtVB1A1EDdXORWGb3QxA0U16xB1yvP+L+meaUHWFgNd1yutS9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987912; c=relaxed/simple;
	bh=QuD88quV2+ZZSG71H8tKu1kO0ROT5crAafRmiD8dmdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcpkxtK8qSreueRa8tsOs9myMS88Sci9B4PzurTyFZnZ7h97vj3oDDk9JlFygfi25ox+pEs3TAuElBfGNu29abx9EEmdp5/KbL/SVbfiDYJuLgNQUL90QNVWUGsKWS1j+WGfAKqRUrlPjwUlYUpEEmhdBkoGfH6YGT6yPWyFb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hq2rRye0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C6V59J024514
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xKWmqQzdMPq
	FddVCcAzQVRWG47+T57+MG8ITHFHowHo=; b=hq2rRye0T9cHP5DKcQeKgSDynMa
	EIhBIA1peD1eXbwpJmswOQ/xwm6Zh/jBe9zEO6wsitSXbDaLF2ZPj6YAaV6XHiuB
	7BNumW7iEfGa9OecXDNm4hYJ9wJ62wzMuAr39Wzejii/DWm3XH1Y3FJGhaldTHJY
	QYKX4bMIJKmCSQVpwljOb9O4XamLVrunA+Po5xxKayWqvVKpC07iVF8Um6uBjhpw
	UkBkFhfak2DSsIzwQf2i4okw/zJ32SASrOuJpnR8UEyFYYT6KiSXGA8PNr8hZCb4
	pxSZ3yieZMhJr3cKjZa1/q1YNFn2llKsq5n05vE9VbKD8OcT41tqTl1xdJQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4beex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:38:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31ed9a17f22so8798291a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987909; x=1755592709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKWmqQzdMPqFddVCcAzQVRWG47+T57+MG8ITHFHowHo=;
        b=F2o55sHF+FkzrAus3oXR2quQiAYNjHbW0VktBv5+ZwR3wJjVX8CidHTaNIrHdYypw1
         nb+X3ppaeNfTVbRfi8roZMdBlanCdEmEootrZoOMO4+bbTNGvbhA1zn9qDrVDaj32K3v
         i5yIzbA2NhwWFqmf8nFyeDOlWoL9JhkVKdEvtqwDTBG3qQYDdYqYDtHEhefRiWNcLeNY
         KM56xFUQt9T6+T8Bcd/6Q8buVuXONkG1XI0B+jO4ULJ7culTg2BONPKb1lwnjAfTYxUy
         YtCcaetJ18Eee8l9zthaaisvj4ReC7DrwItib/1OjU4vkE1ISGlE1c+rxv4eaAErpzJl
         r7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn1b+WQpcE2w4pgDBg1UG89DOOkVMthxsxYDyhxpuQhi5t8FpQvj1vTZdoueKvQk9oKo0MvZIybb8/qNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNG8zDdXNa3dXkh1C0wYcDp5nIiwOrPvi7jRKZ9TPtSAf1FbA
	RKDE+HupDJhHySKm4mIbdktyvafCqcJBhtpWsMFS/qxj8ZmJlgNbCPedcPBk4Qn7tTZd4trIYq4
	BDkWAMhMPtnz+8araVsfjM3KCNgqsTLQ4ZkLae1JHwGI26UZ0eIp4B65QFl9oln5HzPM=
X-Gm-Gg: ASbGncuhTeOzg4tJyDjCYxWpB0P8NL7F4+NkVULAMbxC+FOmqQvfBVGqzszXA3/t7Hi
	DfCoacwVoC+IFScuRh+ezBGT36a4wWO4Od4UDIFBonUNSpQhSGlNKjOwktoCrqM0udrynk2b8zz
	FN4usTere/qfnGqA2tebVKnRcyQ7DlVsr0vumwKfe6VS3uCjdEFUSDFspPxQrGVHF/bm212DOGs
	UazZy4TY+FQ6GtaYErgNneGNwL8ffgqIb5aLHWWU/eWkiT+JaNHvXHA1Ov5uQsQm16cQ6+dF3qW
	1bHf14NzKSR2csKNlgfKrHgttM7coTGoedZSuQ/Lvqtk3kUrlHl+JfNZRYNSwjXsrczkNfBelUz
	gSRh8XmAIPqfK0NLg7SY=
X-Received: by 2002:a17:902:ccc2:b0:240:99d8:84 with SMTP id d9443c01a7336-242fc38ac30mr39407855ad.52.1754987908699;
        Tue, 12 Aug 2025 01:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoUSP4uUhj7WlazCHA59ecFxrurDGloo1nWYrazR2qhQPlOy/gay3zElJWlYEMBfhndfzVmg==
X-Received: by 2002:a17:902:ccc2:b0:240:99d8:84 with SMTP id d9443c01a7336-242fc38ac30mr39407435ad.52.1754987908254;
        Tue, 12 Aug 2025 01:38:28 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:38:27 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v5 9/9] arm64: dts: qcom: sa8775p: Add interrupts to CTCU device
Date: Tue, 12 Aug 2025 16:37:31 +0800
Message-Id: <20250812083731.549-10-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
References: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kZXuFuJnjvUWh7V_X1h6N_ouGKn3OKZl
X-Proofpoint-ORIG-GUID: kZXuFuJnjvUWh7V_X1h6N_ouGKn3OKZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXyUsRcT0VgNA5
 hb6itJqpUqeSOL0V8GP7z47UyRGqlUOTRx2jpBCxUQFYN/aBvtxaBKLRQziNhwxKDMMcGezG0QA
 HfQ1HR2Fu9CeReOAD3JA8pxk+OenFsvlF0e1L633H52FqcLH99FUh2QBd1TBSfYqvapal6oP64i
 B1Fo5JCswBEDSJhdOxWi5+qHL7w/ttpen3sZD4BKCDEGNwqmhLviUbqBQguGXFtGBRQrKSsanW3
 taO9tUB5M2MtmHOMEHmzJEqtU/CCCiekCsbgoGKGOB/fmr79yjbspGOzwO5D53FKXaNEPSPs2nZ
 5RuBYoUbVqYoRWknAScTAPTW2Ur4edUDUMvkCPmFiPf//mdPp7ZqLnSFuc4IvcebHlv+3i7aQps
 DRJmBAob
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689afd85 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gBkj9RZkAcI1HbXH1KoA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

Add interrupts to enable byte-cntr function for TMC ETR devices.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f5..4e6684a6d38e 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2762,6 +2762,11 @@ ctcu@4001000 {
 			clocks = <&aoss_qmp>;
 			clock-names = "apb";
 
+			interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "etr0",
+					  "etr1";
+
 			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.34.1


