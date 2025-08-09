Return-Path: <linux-kernel+bounces-761042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E9B1F3A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7921C2274B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DD27FD48;
	Sat,  9 Aug 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G990jUwY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00E28153D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754731000; cv=none; b=VYU8yZzb/D3cjfZPuLstMq8zWulrWDW4T9I8PulhZKSZI3f8qYHRIFw/58eSC4aDu+1Cb3U9BVD4xjhrNxbgtGrbTWZ5g0SYsARvueBUVWB/v4Y5rpjYfrFwYQmD8fNZN9F9vlfivRzLG5CiEh3vg+iOhSaddFR7iJXHeYQeTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754731000; c=relaxed/simple;
	bh=Y2ogXEDYHHH32US4rqwrs2C1gO2dNoRFZhWAu0HutnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hy21yxS2HsdIzYkRei67szoP6Aa6GeH5kvqtJMh2lJcEjRrV2B9Ttmi6NqDrzH+hHXtCltWyqxHCpbGW9KNygH0bEwwikTvR8B2UWZgZKjtVODakQPNvuIQdWXJ+3ez+FX5NfmansPxBY26pwQ7DJiVggWCgC9HZk14CeEuR02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G990jUwY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793k5OG013151
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0noH+yy2UERIjrtWf5Izm7M0t2Ukl6cXD864r/H8zL0=; b=G990jUwYOiDDudtd
	r4gVI6oxixWCOPueRj9wNaanyiif96w1GQVDBJBcxUpWflyftokVllhR/fSpSL9U
	L2NT3QeuDkBUCqCXOq5UhDBreKVb9tmRWEIrdHi1ko+tQg2Vs6/3+bkp3cG8oTD4
	lPRdJD32jVh9bJkosxFgH68ypEfUoC3czpa6d8AXExYLhXxCNAU19PvL0lPq9IwM
	8i7Hjtjds/vd1Rtn1sfabhHK70OqF0jPkOblcanEnqPoJkO3YmmF0YlsduzYoxmO
	yKdhqe8p1MbeXEH47d/ZHR/rw4rPqhBjBr5ONsFIshlrCRX6/5rqqE+KgCoulA7i
	mWyDUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6rc8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:16:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b061ad3cc0so84900891cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754730994; x=1755335794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0noH+yy2UERIjrtWf5Izm7M0t2Ukl6cXD864r/H8zL0=;
        b=axQfQSo94rOhHdMJD4mYnuQabeerRzDJf0WQhNhd65Fvi3LNqTpzN/IMY130of1BTz
         biTy3uo4lE3jCQax+2ohBNHIfDSuo8udcV8P0sn/o8A8UPwxGEbMJUnZf3ZZasu8dh/o
         Ad3h/JmZcGC+KLFRttaW6q84pcaKGyR0O/h9CSL9E4itLjRN56zW9bXD2MNym0RbVDzx
         /M8H6Jfzy7v091PHKFG2BNBWT79ivl26Imzvn5rnrCbTOe3paUe0b3ImpWouCEdT4Xmq
         nWNZJjkCooU8HGZ6MWZb5tyeU5azeVoOtn723Gn0JXctouQfsBdj/aKfUbwmJENuRhuZ
         m6lg==
X-Forwarded-Encrypted: i=1; AJvYcCVBW8Gka3rFZf4FLlbgsPZhIfsRdqzhnUDe/Qi6/Is/vaK0sOzGXbW3bJSypDUMW/4MW2r/gpfNt1BvDuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufxUykzdQ+xN4cF7CnIMpuczGAqycOnG/OCl8ePP5fhcGxQG+
	7WCfs6RvdOEy/0PptJqqcn3hwMURkyjUN5ojeDJdm/Pp25pXaTtL0G1IEKdmDWcsxQCMAN6JMjQ
	3tMte+qMBjcEmtkMyg5xe8FcmD1UQ8v1FskKItr/Hm8qnWVcZUbOG1V2NUIIKeQOXwjs=
X-Gm-Gg: ASbGncs/0GNfRjVw0LrvFTStZTANfRV0MAwhH8XPMUKIK58d35f85yTSP2yj6hPXWtu
	0frjwKo/QtOEXGD+ht6Vj4bVOU8bMnuF6xqw1IeYkdwcSKbe8peONazdiuQjj4Hn3of7m77HRtL
	Pw7Whn67HS1I+4HqJBsAbwWYA7Wwk2/+NDzfS7YBxU9PPmSLqH74gstB1ytAi9yDKC2rGny3R2p
	1ZZbimQP8VzrWv3ASw8mvs9lyKwxqJRyPGgz0GzZ9ChKVybpuXvZoM7pzFJPywhJF2eiVQQi8PN
	C75rMLpYzx3Q8TejQcQKoxyebrpXoi0Z28gS407qI4x7YLpvJJdSNDOF6bxHj4Ggd2o+WiTn6AF
	OgnkHIWIMkQJwHSTytxVkTMXTRNYboxuXOKFp9JgyA53iPD8oFgOC
X-Received: by 2002:a05:622a:20c:b0:4ab:ab85:e54e with SMTP id d75a77b69052e-4b0af4deb29mr64422421cf.8.1754730994499;
        Sat, 09 Aug 2025 02:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTuAHWg77g8yKCNLQrHsumlaHWKglPw97e39HIagDR9lBOoXatyWgxOgrJqJcA5Il5SmF1ug==
X-Received: by 2002:a05:622a:20c:b0:4ab:ab85:e54e with SMTP id d75a77b69052e-4b0af4deb29mr64422021cf.8.1754730993965;
        Sat, 09 Aug 2025 02:16:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm3361989e87.30.2025.08.09.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:16:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 12:16:18 +0300
Subject: [PATCH v5 4/6] dt-bindings: display/msm: drop
 assigned-clock-parents for dp controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v5-4-b185fe574f38@oss.qualcomm.com>
References: <20250809-dp_mst_bindings-v5-0-b185fe574f38@oss.qualcomm.com>
In-Reply-To: <20250809-dp_mst_bindings-v5-0-b185fe574f38@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rRhj4oU1JzHT8f9jk9qa6uf5IjtK4GGvxWKFr60GaGk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolxHiEFvgBRJsk5KkiJQFXppAIto/VIfQ5SOXt
 VqN5ZRglSiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcR4gAKCRCLPIo+Aiko
 1XK2CACzD+zQ/EjzbEYN+rBU1Lom3FBDCKw4M1WqHgNidxsjZ0bOO/tSxCS7Dbk7eTDE0GWCKyl
 ExL0VmK7YCMitPwaEU48kku+VqeBbb3EvuxyWT4Zq+IVEgQvAHqyL3QXc8kyTEeSFt2jldWTOKw
 tQ9C2zXxJAreFrios+humWBuV1bmlq/apeHsAczJHXLIkwGH/MRB4puqxGEmPraqDbtixbn8DRh
 8phpf0+fJ38MV9PQkC/qqGXY1w1mMPF/+3M1uN+gk4MY5F5PSUknf297kvbBiBUoRTWt2bSn0f8
 DsfvC7AuvwSYlDGT8yFg4HCPowud/5eSx/7xG9UKuULxOWPQ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX9/hJREGKE3Ib
 iLbNcXGIaINGr1zBLh5IfTes4455/TDMRkwICKW7kh6SDso5ZgvYi7uwmuJGckfPyfHYO9Gxm2k
 XgUskoGCMyyLC8UjyAeYfEj0aQ6X308oqpmDctZvjArFiB+g7qTqzX11H4IE4JiyX3RYIStBs3m
 O11+nlkaCKixcUlvk86z/ySvgOYeuIXMI/8NDCQTLLByUJjhoVRdjc1Ebe9FNmQljImgRNiJfbD
 Kbec5ONR6RWuz8O+LBfkKmhuXKJwNyUUJST9P5qUyB67fZec98BNgmgTg6asMDhGOlOBtTPKXm5
 sTjrvcBwlKrhZHuzTwG5Nj4ZTT6f4pOCm00GlUn0i0BTYzioUFFQrVv7GnV/Fdqiy8fvYy/rQYp
 xuhBApHZ
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=689711f6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VjVaSBsDX57WhQYIrYsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wIytDAvvQJlJn6N4TUNyHfhc09-5qRwq
X-Proofpoint-ORIG-GUID: wIytDAvvQJlJn6N4TUNyHfhc09-5qRwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

DP controller schema documents assigned-clocks and
assigned-clock-parents. However these assignments should not be a part
of the ABI: there are no actual requirements on the order of the
assignments, MST cases require different number of clocks to be
assigned, etc.

Instead of fixing up the documentation, drop the assigned-clock-parents
and assigned-clocks from the bindings. The generic clock/clock.yaml
already covers these properties.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 55e37ec74591af0a1329598f6059475926fdd64e..352824c245224d7b5e096770684795625fc9f146 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -73,16 +73,6 @@ properties:
       - const: ctrl_link_iface
       - const: stream_pixel
 
-  assigned-clocks:
-    items:
-      - description: link clock source
-      - description: pixel clock source
-
-  assigned-clock-parents:
-    items:
-      - description: phy 0 parent
-      - description: phy 1 parent
-
   phys:
     maxItems: 1
 

-- 
2.39.5


