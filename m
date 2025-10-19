Return-Path: <linux-kernel+bounces-859584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34863BEE038
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A814A4E305A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032022F177;
	Sun, 19 Oct 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jWH/HZBi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945431096F
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860939; cv=none; b=ucfVTC9g1K9yvhOo/z5rUn0+DhchLrOFRyLOGJ1aR16qDOmIqEAqV+7jEcg4bbYYC128TqKHMRzF2+yutpuIiTojv9PUvvRyUqA7+NQpEExR+gWQIeBVpfZchbA3lxFLX7Jqgf401XiR7jBYy7VZS8P9Pk8SJFUm1PIBBi2WRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860939; c=relaxed/simple;
	bh=IhkNdhV1hTAXKq74opsigwyH+OgEAhY4flHRuC9QW9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB4XHI/ky5qr+pfGmK7nEPWnGW94UVy6blIhRdN+Bkx6fZ3gqsQgeiZdfYuIVB6A9Sv7q6bGVagtH9Fis5QBpLuuUBQ5qIxTiO7iO2yjdWsXPtCRalgfd/MJz6212vMngnP64Jb9tdqKLRt0uCmx5U1jJ3mMZFwEUzh6QOYBlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jWH/HZBi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J4ulcM031595
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PCu0f4HoNX7
	caVYPLTD2PG4lkgiTCB9Bw+ris27XvNs=; b=jWH/HZBioTNnNbZLKnZuw6hhCP0
	7cHT8I5DO1jk/q4JLcPhxPEzYbIcwbW6vMT0XDrg1t1bpaOZzA9909N1dl5Xz9mK
	0hiBVwwvowpmaJGUXF9aGklsSrowfN7c4BQ6R7iipwWGXUTD2eVD/j4/6IHrB++G
	0JlDNiLNx+cWFSyXWpPm4/tTXhXA4ocitX0kLnb3VIEsV19oBPRFrn0rhoPleWJn
	APvwwOnYMquD3JHIiFtcWizTVlSoIDRBrhLNwymKgTSzTk0XYaRk3Xx0QTUlt3Dh
	B9awR4tIohWO+ExAnjP9PvzvPNptlhaUYbL+OrJrlpC+w2il/ZSDER00tOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdt39c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:02:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-871614ad3efso1214330585a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860935; x=1761465735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCu0f4HoNX7caVYPLTD2PG4lkgiTCB9Bw+ris27XvNs=;
        b=cGZm9sUrEmK4W+KDF99edp7rrAJ9Yt2HyYrJh+lVxKvO1wAhBUJXaliDf1LGPu5+Fm
         eqrJlJSQ16zkHzWTrC7lDeCXSyRkrE++QjPM64ooHVmGBwQZ8bDaSmhnrvRUwdxl0KyY
         ky/bRupJ8rqUv6vxwBZ2N/KXJbfKsN2gI4YsZKtraCzt/TcizgTJR+f2mnhtTu0Iiqoa
         +f4d4tI+fVcmDP7ONXHLL8ZUW8fVW0WxPkNrxPfThhm52EGQniBlOLRHX9Hb3L+dTkvV
         GBGKg2nIzc8v71K4ihPQ38gyuuQ3+nAbSCBB35qNKewvay4h/9t6/BuHGAkd3UvYw8lS
         l+FA==
X-Forwarded-Encrypted: i=1; AJvYcCUmkRLOGr0mOcOW8rIvH1PpgI6IJo/4v/Lq6ZZfKh7QP3zbzDea7qlwGEmpudT7hgUZC7fIJD12+o1EpyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt98tvooP3ggKMb8xEJ3Oxn6xQhq3xCHVq88anrrm0QCuQDZF7
	o6vaqUuSNqKZPgQn596szRZlgat1LxiVV+lBbEXSg76rqh4HaXZKWaPCz8fEbD1hxzJC6UC4uOS
	pBMdI5e+s6YKNN7HTn5gR63Hnj08KbO/+ITkKjun1a5+f2Yhujy71k7Ry4Cr5MmvT8gA=
X-Gm-Gg: ASbGncvFNKlTHOAVbArloJ/iXoncZypX5vvnt4LCAbEhK9MUKTtvYTtMgICuU8sdUES
	quet8tuWqFztrbBEHsTzPi2n8IYXtuhI7ikt4zcfX1iRfTv+R65KDbb0DooCWoPcL0ye6m0kogT
	nrsqJsbSdM1PiOIvtKX+CENQGieRFIPial2UahwrButThv/4z3BlbaNU9wuj8dU5EhSgzXUcHu5
	m4jUjWxpEVvA8R4cOuBs9m9ZHz0vIS8N09HBJ/sOXyqbnQGEpIv+nzpcV2F3WzEiOj321M3RlHG
	sx2xJDhgMohP5VOZiqLMnKoIFqghKalctv7Xx1fxLP7Ew1InXWd5iQjDKe3+5Tq4tYMH7N+7K5i
	6RkzKSP1kVZ6kBfrQJ9Hx/8ngPPDLD3eeFr5ekL6gkCW9B6GanoCFys/waQHUn6tTqVZLFccunM
	s1JnIGjHZQ7vI=
X-Received: by 2002:a05:622a:1a87:b0:4e8:a359:b798 with SMTP id d75a77b69052e-4e8a359be46mr88922511cf.67.1760860935530;
        Sun, 19 Oct 2025 01:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1eVAe3sKqBxqT4zkB9fpGbudrcKFbHhI0WnnRPaKtVd0Wn3A5JdSj2juSSn+NQSfKGzlVYw==
X-Received: by 2002:a05:622a:1a87:b0:4e8:a359:b798 with SMTP id d75a77b69052e-4e8a359be46mr88922131cf.67.1760860935059;
        Sun, 19 Oct 2025 01:02:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1695fsm1353170e87.61.2025.10.19.01.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 01:02:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH 1/2] media: iris: sort out common register definitions
Date: Sun, 19 Oct 2025 10:59:01 +0300
Message-ID: <20251019080212.142623-3-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
References: <0251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXyX57/l5To9+b
 MoRq2QnTbaWI66/6oMb/30ArJELuEi0XuaSCCIyB13RdIHNB/4YG4Wooz0W5p0Oym7UdekIV04c
 EyGke1fiQKf59N0F0jzMk5tnA2iST1j0IiZ0yV4RTzno8IAqMFJin1cGvY7eCP4foczpjwhBldm
 Odl5v1//bx05rIYLgeP1STYG7fMedwjzdsbloueC1jKhN0buQD3KY+dpT3Sp1In4HWuICyDZReY
 tIBLizhmpw2W2RKalMhDrfJrm9zUiQH3VKCy+RSrjE9LBFgT37d+vQPhgr/bFx+YWmx2r5aJ12O
 eGUfL8wReVSGmWZ2kD5d1lF7YALQ1IE6NYIydX2LJ8ygfliX6GiTHiVGUN/FAnZ1rMEYQmbE72/
 e9e5XJk3tSpn1teKPpGLLdla3ynbZA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f49b08 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zaoXWFKIo8GWO-w5zvgA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 2jTyTAETBetuEwgAEkUmMdUYECthC09L
X-Proofpoint-ORIG-GUID: 2jTyTAETBetuEwgAEkUmMdUYECthC09L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

In order to make it easier to modify the file, sort the definitions
by the register base and then by the offset. Also move bits definitions
next to the registers which they describe (as it was done before).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---

Vikash, I have dropped these patches from SC7280 patchseries as they are
no longer required. If the series gets resent, please feel free to pick
these two patches in or to squash them into the corresponding patch.

---

 .../qcom/iris/iris_vpu_register_defines.h     | 47 +++++++++++--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index 6474f561c8dc..1c3ff6cab343 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -7,40 +7,49 @@
 #define __IRIS_VPU_REGISTER_DEFINES_H__
 
 #define VCODEC_BASE_OFFS			0x00000000
+#define AON_MVP_NOC_RESET			0x0001F000
 #define CPU_BASE_OFFS				0x000A0000
 #define WRAPPER_BASE_OFFS			0x000B0000
-#define AON_BASE_OFFS				0x000E0000
 #define WRAPPER_TZ_BASE_OFFS			0x000C0000
-#define AON_MVP_NOC_RESET			0x0001F000
+#define AON_BASE_OFFS				0x000E0000
 
-#define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
+#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
 
-#define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
-#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
-#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
-#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
-#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
-#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
-#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
-#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
-#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
-#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
 #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
+
 #define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
-#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
-#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
-#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
 
+#define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
+
+#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
 #define CORE_BRIDGE_SW_RESET			BIT(0)
 #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
+
+#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
 #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
 #define MSK_CORE_POWER_ON			BIT(1)
-#define CTL_AXI_CLK_HALT			BIT(0)
-#define CTL_CLK_HALT				BIT(1)
+
+#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
+#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
+#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
 #define REQ_POWER_DOWN_PREP			BIT(0)
-#define RESET_HIGH				BIT(0)
+
+#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
 #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
 #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
 
+#define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
+#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
+
+#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
+#define CTL_AXI_CLK_HALT			BIT(0)
+#define CTL_CLK_HALT				BIT(1)
+
+#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
+#define RESET_HIGH				BIT(0)
+
+#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
+#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
+
 #endif
-- 
2.47.3


