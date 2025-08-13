Return-Path: <linux-kernel+bounces-767106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF2B24F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05EB9A440C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BA2C9A;
	Wed, 13 Aug 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8N71Io9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9301D54E3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101368; cv=none; b=So6MK4NxgeFANf9BMk/JuVfM9APVFsb0F0VvGQ4LDgS3mz4Oxwq4g5TwGjT/nqHEHEsFLsAacfGvBDTZPsgI0Bo9MBxBtoa8cuBbW+OJXYRqTvkFDZu5YMzI95VP76j6TTOcIxmJImdnqaq6OHYYfZDU/zvMRA/hkRpMLBEmjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101368; c=relaxed/simple;
	bh=Uy6A1KjToQeuPtCwKUZJZ4cLUf1rEWIY+Kkfeixj5H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rBSUoT4ZBdIo36UMgw1zx1A6UKEkJp4mOFM6jfzCKAksvivV9BJHqe0iHTsGfuYOVeDXwhq3JMxgha49ssUesJDr1fhldih4Pfyl6IYVdtyyN8IFhfWYyN1wOI2ze5J2lT1zUYgNYSvbrHD5MFW+SQjJuD0KvzlHd8nwKwUp2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8N71Io9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBM8n5013514
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RJnHt2WOt8A8a4LkxzStewQR/E1AD06cu3+
	bt2NvKB4=; b=P8N71Io90SZtmCHdnWsKLsIswT+xf2vzlJOu1VQCCFGgxwE2x+a
	gCY1XGEBt0HvE6MOoXqwysnM2OZVuzs17NC7LXoLgYbCuDFRcJNWWVACU9h2S0z/
	P67z+oyatxBcFjTQAeHQ4EutFYFZYCM8LPVJQYJ1bgeXSY5Bhh3xMNiSWlJsBJKg
	M6CALiIRxkLypd22ixuwnVY4xj6mW3U3hhXFXQrGOBmmZgaKdrPUgqsYRz2kVOMQ
	ZS4QUvBStVA2rxxLKfxXNn3/hE38sV+bx5yZjCp3lGQba2L9xXOhNDwSM+6/5HLu
	6ulQgAuyliYdYUzACZEd+SDMfsHWfwFDPnQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxahq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:09:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b44fdfe7b8dso2797062a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755101363; x=1755706163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJnHt2WOt8A8a4LkxzStewQR/E1AD06cu3+bt2NvKB4=;
        b=SVFoNS601aifBPy1M9TtyOjeME6MuD4EuI7GUifXdYPTRtwufw7tLtRRWkQiTnLhyY
         LNTNRrOqcVAXzxsHEDUYe0W4CP3Bzx8xxN6z74xFzU6+6yWBawI7Kj2rMqxuKoLxC/75
         wE2AfRBcwO8sVVlob5yXPfX8XnLv9CL6EkjPfvtUYdDJ1OFWBgDFnJYwDogZd5lmuGbK
         8KeByyJBt2teHDrzZmjEjvGSD6mtx69/neW/XqWr5+uBZpnLijXanE0nbFdb26s/0159
         t7b1RF3X1mIKDqFJ+c5J3/VIX0RfSVCjD3BP3wM6lvwu+TyflfBchHnB4EdwgAkhgsEM
         vuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr5ReTpQhZ+uM9QqmHLvMx8T3fr+GXpzjPdCZubxR32JHF2i2CS65SFcbjABpT8K6OqxrGCMQEGClLYfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVj6BYqQ4omRzUnEyf75MVGO2j4dLO2yoDzpxJUWYYTuEP4Oqg
	y4nGryHY8V8Fqv040vQstocQg0625D1HiXvYW4PfneSwiDMuQPckVx6+jgzbRadVAbqGha1ahSR
	2ShKW+isP1UfY2dEOgNucbTLGqNpS8TrpKidy3z6XaOVTqdQ8qR1XnA8B3MALMJpTG/k=
X-Gm-Gg: ASbGnctKGKMSDvq9VZfNPWWUtF2JmRFQyELt33pTdFQJ1/vI+5zWzI9T74TIrjcZhCs
	i2EafvmZ9oi5w1tkAnEjiR/ujtq6qQM8S1X79ZR2QvpbL2it7QECdZKKju8uAWISduviqrTwXb4
	sVgQYvhika2+EWLm+BUfgqa4JngefBWK7E/n+NO0NYhFnuXxS8azUzGxVkDSuSASSbTBwEE0fvi
	cSzpHCJK1o0jDGt6+ygi56XD9cga9hlHM4JJ1vEujlZ9DDzF6ofKhd418xp+P1DCoNwK/iiW8cu
	FPG/SCq+11fdHqd7kGZzy+QgIepZ1WQUhST5ILqxkNp/uEDtcM8bw9nq3asB3T1xFA7AJpwgDbP
	/rw==
X-Received: by 2002:a17:90b:1a85:b0:321:c27f:32c with SMTP id 98e67ed59e1d1-321d0d7aa41mr4832990a91.13.1755101363287;
        Wed, 13 Aug 2025 09:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUhAHu45JXTTza9oZ9jQJjuAHePnoX7/+XsDAfE0WLyU3zlaWDR2Rp//MhJ0Zzde0tPKs/Sg==
X-Received: by 2002:a17:90b:1a85:b0:321:c27f:32c with SMTP id 98e67ed59e1d1-321d0d7aa41mr4832918a91.13.1755101362717;
        Wed, 13 Aug 2025 09:09:22 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323257a85c4sm529456a91.22.2025.08.13.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:09:22 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8450: Fix address for usb controller node
Date: Wed, 13 Aug 2025 21:39:14 +0530
Message-Id: <20250813160914.2258033-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX0dwFo2lk9jGs
 KZwPTxIZ3z5JryK1vtr7jRGG6RqfdSNvVggiuhbGJUv4FIYCi2IMJUoBukVKWw+8QUp0i4ePEEz
 QoT2+/N0Px94Qj+851v7Vq9P4nQXQlFVSLnpVG5ipT1wuUt3QMRZYME2U8UyeUhRNXc5uvcvM2O
 PU9COvz4seDLxz8ylDDN56f/atmn7U26nQi5Vyu9L8HZkyyYCM5QGjSxc/vCa0eDQ3Bh/m79WEV
 smIqLUTAzE7rJZuQGKml9B0n47Rx0J1LIkaPFMUW7+vjtgs4EP9zpJUbL/xFrUl/gycl3RUZYT3
 vEM6QRLdSenHE5UG7zxedH8p5GWXDELRhjJJ4YY3Vvo/pqMjyHW37Ea9DbT/cjV/eSRyYxRtOX9
 Ej1Kq96+
X-Proofpoint-GUID: 4XYse5be4f0AJAo99MFFywZ4lkctSTvZ
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689cb8b4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=6BaAAJH1LYH1urCC52kA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 4XYse5be4f0AJAo99MFFywZ4lkctSTvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

Correct the address in usb controller node to fix the following warning:

Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
format error, expected "a600000"

Fixes: c5a87e3a6b3e ("arm64: dts: qcom: sm8450: Flatten usb controller node")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508121834.953Mvah2-lkp@intel.com/
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
This change was tested with W=1 and the reported issue is not seen.
Also didn't add RB Tag received from Neil Armstrong since there is a
change in commit text. This change is based on top of latest linux next.

Changes in v2:
Fixed the fixes tag.

Link to v1:
https://lore.kernel.org/all/20250813063840.2158792-1-krishna.kurapati@oss.qualcomm.com/

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2baef6869ed7..38c91c3ec787 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5417,7 +5417,7 @@ opp-202000000 {
 			};
 		};
 
-		usb_1: usb@a6f8800 {
+		usb_1: usb@a600000 {
 			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
 			reg = <0 0x0a600000 0 0xfc100>;
 			status = "disabled";
-- 
2.34.1


