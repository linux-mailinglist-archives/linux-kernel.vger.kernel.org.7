Return-Path: <linux-kernel+bounces-831491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE9B9CD03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E941BC4B32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997B190477;
	Thu, 25 Sep 2025 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RLy1EQ/o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F661A26B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758748; cv=none; b=AV2B2FmNgxlodmkEAuJA1Hi5fXjI27qO4S0zLgFa4u5fPGZuQ6rHm9lNYnyxxqafW6EPoAHgphTc7e3tPBycsaOJAdA+GL4t2Ziz5KkPkS5Aq1Oj9N6OO3KGU9vxkzCx1tjopu4YYc+IuEmb8uO/udwl48e3Qmu8U25YtXR6fgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758748; c=relaxed/simple;
	bh=KtRjkfFWY2hjUkbnX6tvIQMo0crwvb/81urK23gMZFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0XSUkIZL6RSW3hIFgvOfICn+vBGtcIUiVbWchvccdkR91hBz7/m3wBRGi4WwomB7PbZJR2Ymh0HuUQdZ5l+r1aGQnihb/DzoDsvTtgogspS8VOZj5JemZxchaY2Qs0tv40kJbV1YGQwSXpjgX/Bd6ALuYm3zW01m61G/q5pSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RLy1EQ/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODGO3M017437
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yffI92lXpd9McXifWskueQtwbSrpEzv7OcI+c+nrmhQ=; b=RLy1EQ/oWIxUzAGQ
	foy3OjI5tiWeOjlomhoXos0jMLNQo10bMBB2p6EF+4ldsnvUmY7fKjVufTkq/DE3
	6u5658qXxljTUHROOCe9BFjN76kI7XSavcUOMM/JcF+3b7dfp0P5YJhWjxg4fIph
	/FKo9+94bJx3SxG4UovaB963FNFbCQitjscPN6a61UJqtcI7LbgWGmwUAiknI7I6
	aB4WIMHu2/LnxH4gC5zM/jsUYMINmaMOCV6OhcOGhrXttHiK5DoARZ5gU+AvQUdf
	UWiiebHb58X3x95Mzq3imTKKISouo+tNSj7s73QkT/H7Ic3pbs4XzPhFOpfQXxUr
	uyyidQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyeyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2f0c3e62so266712b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758745; x=1759363545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yffI92lXpd9McXifWskueQtwbSrpEzv7OcI+c+nrmhQ=;
        b=hmoDMUaicK+fLsnWaYBNn8S/4tEJ6o9HAOzSNKBaJrhl42w0odHEmJ+nYDmRE41ELb
         ugr789LBCIJGsC5GF57QHlgPDq/Ny9Y2F+jiszIIud+KFubcn/OfAEudoYfadoBs3zd+
         xHcmT7hDA8uMbKlpXfr8+XcotujqabbVQYM3lhwOSS1sTYZS1WIpO6iGj3yXcesJhz0n
         pH/9It8MclfL74rrVLKTCIE+UzgDe9nPnZ5J6uDfikYzKOCfqZib1nEtPXb0fqwCpXAh
         xxKODAiL/wuZLyLVuvy+gbutMY5oVBEcA42NqCHmIvCqfWqN8UV9vg+r1GtJPV5lhxr9
         Gl7g==
X-Gm-Message-State: AOJu0YzGJ6EzSwzPRmOBmRrEpT1vQ6TPGp9lu1TsCJmnhTCWaTMMl5RZ
	JMA/GXWjEKblzGcFS8NtX2ttZoVJscIbLfpf7khHsa0Qa7SS6vp48OuinFjcoNZSsXkwruPI9rB
	6tLiOERSjIhRzK5CPdcdz95GbAB0FKH9TG13xrPuSOKbhQf37CDpEJAu/Hf1WDyHVN9AxRu13x5
	qqkg==
X-Gm-Gg: ASbGncsY0ZY08QNUIdPIILWXcYXh3AECrfcV4doU/3dNSXZEHruIKltmkj7TCeGFyQR
	pJi4yR7rHl5JPHKGCESPOZtjsl/tnGu3BaeLSiQ50VfN+/i2V1eZXAm8donI8NKrbu9dsHUzniZ
	iQP5WZHlrCPVJo0ngnQc/0rXxLW+9cspTg4tkuokRuQAItjJ1/DFp0DEDc2giDTWODS97rykQaa
	c7///h6Xyg6ZWsw6Iq0Aqz2aSFjHIKuRbAqdMr/4CBO/syA+vpuBVOGwuDP0njWM1fHHNAc7Cxo
	4kS1LZe7fXeMknowcOAdf3Hi8bQTiRlHvuzm5NPfR9BcMn2RRlmkykstR86aOBioIsuHXhM9gNh
	mQOR8RxxmqubpKqo=
X-Received: by 2002:a05:6a00:148e:b0:76b:e805:30e4 with SMTP id d2e1a72fcca58-780fceba315mr1890264b3a.24.1758758745195;
        Wed, 24 Sep 2025 17:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbdwznCRcmLMd72OPFyzHTPPhUvdYeREKBB2EaYt8fPbd0Nq5gDVLxW36CxyXAkVUGU0snhA==
X-Received: by 2002:a05:6a00:148e:b0:76b:e805:30e4 with SMTP id d2e1a72fcca58-780fceba315mr1890235b3a.24.1758758744808;
        Wed, 24 Sep 2025 17:05:44 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b274dasm234024b3a.63.2025.09.24.17.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:05:44 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:05:35 -0700
Subject: [PATCH 2/2] arm64: defconfig: Enable Kaanapali clock controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-config-v1-2-e2cf83b1932e@oss.qualcomm.com>
References: <20250924-knp-config-v1-0-e2cf83b1932e@oss.qualcomm.com>
In-Reply-To: <20250924-knp-config-v1-0-e2cf83b1932e@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758742; l=951;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=aMBeijjGEEeoppP3enr2dOKjxXvOU7V2ItVTYcRLl2A=;
 b=/jaK34zdECdzfN39/ZVS5rUCbCTTxHpoUJWhJDE7hJAWVQ0t14Cz7ded2YIjCnZtKmn0rWD7K
 1uVJkXjm898A96uXJlEA6AIM+/otRFJAWoLPey6UiKOvnFzS+2lXvLT
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: mEAB3qa8009-Y_ISoO_v9p-dVt_QgW9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX47JW++9HDy00
 7AWMTQUFwbE7aX83JJRxyPYf2w9okOcOeztCu3/UCZXMaxVh3bVybE+AED610qEB1ppMSHyRvBO
 32zlAipudj6YdDSxZ28yTrtOfsfpTpfTXzQaTeGDsbGqvyCp6U8XYX8HAVBKWGkkAikLeuITt4E
 lLYAe1Gh4MbSUUVzk4t/DpX1/dygBqHUrYQm6AwYZa5/nD8+CZOmnBnl4fY4DWIrwhd4APXBcy0
 DWLbye1GIB9MjyuO3J4JwDpswucenJWCAxlYWriWNUuGpP6/C8RmJ8RhIAwetRmoz2rzQfR/xpg
 O4UymtGiDPYL0mL6rA41UzByftEK1UdbEUTHwk47lKhkPuQir4//AurHMI257yVv9XiKRldWOxK
 ELzZvFVH
X-Proofpoint-GUID: mEAB3qa8009-Y_ISoO_v9p-dVt_QgW9a
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4875a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VnGTKYAKMpk4jy3Q42AA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Taniya Das <taniya.das@oss.qualcomm.com>

Enable the Kaanapali display, video, camera and gpu clock controller
for their respective functionalities on the Qualcomm Kaanapali platform.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a3767e2ce02d..e67e8ad323de 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1364,7 +1364,11 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
 CONFIG_COMMON_CLK_MT8192_VDECSYS=y
 CONFIG_COMMON_CLK_MT8192_VENCSYS=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_CLK_KAANAPALI_CAMCC=y
+CONFIG_CLK_KAANAPALI_DISPCC=y
 CONFIG_CLK_KAANAPALI_GCC=y
+CONFIG_CLK_KAANAPALI_GPUCC=y
+CONFIG_CLK_KAANAPALI_VIDEOCC=y
 CONFIG_CLK_X1E80100_CAMCC=m
 CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y

-- 
2.25.1


