Return-Path: <linux-kernel+bounces-831492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC6DB9CD06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5743BB361
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115D256D;
	Thu, 25 Sep 2025 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYOEXFlh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504014F70
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758748; cv=none; b=W4v/N9TXRPX/ubtaDutyS4NpYnCoh9fdEIrTWN4UmGg82MNwSZJrHIJujoVIvrTLujQNJ1sVOZidOk9zyJuwjLu5xn5cOG4tyVdbJV47nEgJeJ3JaOMhURMQ34zMLMyos58ttqczxine1WF5upEkbp5dHx3/ToiIgM4bsak2exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758748; c=relaxed/simple;
	bh=84sfm/5W0vz5KE7uWBQ9ONMN9BV4EYlFJgZlB0dicio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=sFq343rUoXsjkJiPEXxSh0qpiVJb8EyMwKs7ZV5o60uXYqbAVz2zHpuruvm7kjfHsQ/H8SQ+HE1FHOHukEDMxfF0tqSEb3YbFwDrT4FvDMsS/q9uTddqSDKwwz9RlAuaG0uA+tUjvRFut3c/4sTiJbJyM3YbCmGzaQgLAQVoQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYOEXFlh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OClqKZ025248
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wDvHFCIk75q9BEYp/XgaKaRHNA04bK0Un/n8JBOjDP4=; b=JYOEXFlhKxYnr7YF
	X95C6V5f3lDWSG3AZ/rBmQQ43lRrzKHdkGkwKbt7JRGO5Ny/Ua0J9tzbprU679+4
	imHpvLHZ911xy26W0ao+xvosoyb3W/bSBlEuw0dxRYVhjH5iJmntmoV3MgnKlrcb
	bb2rjmGVPDR5BW2roGkYDrHUeJO8y9XZBLBvWLFS6yjERMpDPiPWtx3PH1+H4Gl2
	07zqBxma6Z7uTvpG7FhzPdKi4Ob0ex5TGgHhYxsaAsXiZU2sdLKtm3pHnbqFTsK1
	j3izlGvGA4rEFu3yGy0tWaAWfSuuSNQYsmfPgwkhG271hriiG2WI3G7po1Rohejy
	NGOMWQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv1653c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78038ed99d9so538378b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758744; x=1759363544;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDvHFCIk75q9BEYp/XgaKaRHNA04bK0Un/n8JBOjDP4=;
        b=buLvKmj8tRDc8zXyLyTVHfTkQhiJ7xtXqBeZmvptTskuebwcpJ06HjFmDe22OY3Fz2
         t3k5jd4YURwjB/hcaRnW/5SJFE6kX/fNpQ5btpbfY90Pn8YOL9v0ZoJvWGs5dCzGt694
         wQCoqXI2W0O1uaBlqMUAujMvCAbDZJxb6wWEC4xs6xGHeMGe2g7GUbF6OJC4GnY6Ugrs
         thhe7LWmWRWhqe7LlSSovwh4oPLvVWef+GUasPiy9tKz/Zt9ppYiRqnITmo9Q12zn+bS
         vio7BphwvdDAuvOcJ+RtsWZMaJiIMujid0YsxJAIlSoyjr+ULGNdguy4l6SNnzuWz+Ez
         S8cw==
X-Gm-Message-State: AOJu0Yw+IDdMBCeFmLYkQrKLlK9aSJQtzFZusyZHnRDyQnxUDMfLLOCT
	+lq+H0TTP/Y3iNrf+iztuwLJB8cATeG1Xwrbb09Pz8bZAp1GxLGeYtpnWi9VSQpgBD2XIAcuoo3
	kJy/lLBGS2nv69uU/3Ct2RXAjn7GYbgwiU7ii94O6K8tjst+Hpa8lrIlv0qNGiMTSTKGZcOVEYr
	6uxg==
X-Gm-Gg: ASbGnctKaGyaqB0Oqn/Ml98ZzrnCISIdp4XcfLpiw15zE/Ir1LJWklkFj8xXrbVWOYa
	Pm8wTRIDdHZwf5GySGSLFKgR3jw5ytMRK/UOb27WGlksvU05juXBRebpuRUd7HgKW7qVCC8+sXC
	Ae+Fu8x4JfH2Fb+OgpbC4BzunT6KpuVD+G+5DdSocw7c+ztg53RQ7MOZE+0mcXsF9m4ZL7efImn
	a4oYJinDS3qtee96SPoGh0e7YB3ywmuS7UCYQy06yH6byTHPWXRnq6hFEsBppsMeb5EGDsxFaKB
	Kgxw3AW0xw6B2HjzpixeyufqehLgP8Os4XOJTJbnhLjxuIq9xz8twu0KCT9q3Z0hTq3Jj66u79A
	kcGW8rMdtTrNSaDg=
X-Received: by 2002:a05:6a00:240d:b0:77e:9ae8:c7d0 with SMTP id d2e1a72fcca58-780fcdee2eemr1710484b3a.1.1758758744389;
        Wed, 24 Sep 2025 17:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx9GOi6QxWnpBgRkbmkfmXrkti0jsoEp7mhtBlbpSvXE9VWjbxEYORGDxBA+SY3WBuDBFmjA==
X-Received: by 2002:a05:6a00:240d:b0:77e:9ae8:c7d0 with SMTP id d2e1a72fcca58-780fcdee2eemr1710448b3a.1.1758758743832;
        Wed, 24 Sep 2025 17:05:43 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b274dasm234024b3a.63.2025.09.24.17.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:05:43 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:05:34 -0700
Subject: [PATCH 1/2] arm64: defconfig: enable GCC, interconnect and pinctrl
 for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-config-v1-1-e2cf83b1932e@oss.qualcomm.com>
References: <20250924-knp-config-v1-0-e2cf83b1932e@oss.qualcomm.com>
In-Reply-To: <20250924-knp-config-v1-0-e2cf83b1932e@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758742; l=1398;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=84sfm/5W0vz5KE7uWBQ9ONMN9BV4EYlFJgZlB0dicio=;
 b=QHmsj7R7dMaHZppEHYB77bjRa63UJ+jvWbqFJBLGhecIEEaEafa1ckfU3elLj3o0hG6WtODdj
 4Y/mqwf2J+qBHbn7VAjwAgQU/7GHpfLPKIyXF1n14iWipL1YCt9Vk11
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: Ulx27bouGMO4s4z0WPnyY2UwihRkzuRt
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48759 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4duTJvkXs19Sp8meXgIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX/8BC5vqEdsqK
 UmrY83Fa+LlVxiIaMByTpeEhloO3fprXRjZ0NzKoGx2sJZpLJ1UgnGBS/ix8WcUxrzUEM6e+7tE
 XrRQM4im6FudWWfWwtxfIfJkI7wxISXjTk3yQsqZ/GgrmYs4gIUQV21zk3CzOqjg+v5W7WTo808
 PZlYJJBQ5kO9A9S0L1DlatoQKuVBrsNgO2ds5iMM7aDwb5q/33rAl0VWh9NOT0KxtpguZdmmqKb
 Fqw7iFQISLEw2CgIR3qNZT6HPwJq3RdQox7LC5pYf2HuyAmC9y+pB4mJSXMOgfd54a8m2Vux8Jq
 n2uawJPC271GY5O2RA0Qde/UTvR4b0P54vGsCC0vDKH4uq9U+zbX9fzlbSQ0AfSuZr1oD6Wj3f/
 a/hPtUBX
X-Proofpoint-ORIG-GUID: Ulx27bouGMO4s4z0WPnyY2UwihRkzuRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

The serial engine must be properly setup before kernel reash "init",
so UART driver and its dependencies needs to be built in. Enable its
dependency GCC, interconnect and pinctrl as built-in to boot Kaanapali
QRD and MTP board to UART console.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..a3767e2ce02d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -622,6 +622,7 @@ CONFIG_PINCTRL_IPQ5424=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
 CONFIG_PINCTRL_IPQ9574=y
+CONFIG_PINCTRL_KAANAPALI=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8953=y
 CONFIG_PINCTRL_MSM8976=y
@@ -1363,6 +1364,7 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
 CONFIG_COMMON_CLK_MT8192_VDECSYS=y
 CONFIG_COMMON_CLK_MT8192_VENCSYS=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_CLK_KAANAPALI_GCC=y
 CONFIG_CLK_X1E80100_CAMCC=m
 CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y
@@ -1718,6 +1720,7 @@ CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_IMX8MP=y
 CONFIG_INTERCONNECT_QCOM=y
+CONFIG_INTERCONNECT_QCOM_KAANAPALI=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=y
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m

-- 
2.25.1


