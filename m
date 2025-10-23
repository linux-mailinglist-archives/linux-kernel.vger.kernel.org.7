Return-Path: <linux-kernel+bounces-866452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB5BFFCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9760C3A43CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A722EC08A;
	Thu, 23 Oct 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PkKKtOpI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA382EC08E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206869; cv=none; b=PAKZ8Rg3h/L9JUp2YXxuO9za/2dZkv+jxlqrgk2AW4iByvlxEgMt+/qGdZe4/RfwYu0mEnuTsYddyuXmU+P9szYlfB+tdL+P4IyXmXfCVof5vhysXUts21NGENjqcJYP6hCgfHXDp0BXhqt/GfKTxnVl1kwhCJp4S7rKpYXgKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206869; c=relaxed/simple;
	bh=df1ZsrK8gVaOe7J2+CuDQdRh1tegzMfSLcKb1Y9LTME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGTW+vFkH9xc4ckFPE0grGmff3oHkPrI8pl+SPEA3ThRBTpH6zFXVL/uLNmANtRlD0fc7pbr+XAH6z6izBeF8uvCuUqwRbXHkpcDpYVs66eT77cCsuUb9xRnrNRWQd2oa7mijjmbavmqbiu071n51PUNEq6P3wUc0EMJ9kCphEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PkKKtOpI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6nj0k007434
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j1IIJSrPTfw
	ivQCAHihRszXwyf0kfSMjdUDkP6+21Yk=; b=PkKKtOpIyQLVTGsRai2jXSJzHkE
	8A0G2xLZ1PYKj4BRtH4q2geggWIOzrO0xWu2zGuWap83DvfuVBY5fZLedqNvlKUr
	RKHG5bvBTab2IwasBUJ+pt0ih5ovCCj2AP3uxEznB+rmzVZLSZl/NtrRIkr4AtPS
	x1sNWeVLLwGGshDDp+OP9WH6Nke+xFjS7AvrnqLACHbIpZXWp9Rkg/EhKRfe2s9X
	Evb5UbVFzxLsls84bApSHgfKtgX1V6AFRBbTTGMc8CV7v2i3AUG/mktp2jj92O2U
	rzmwR/gZU1fX6tGpRd06oe0s1e+6j2rmWvPFW9Tf7I7GBumY0avAC610HMw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3447mg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781269a9049so1216232b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206867; x=1761811667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1IIJSrPTfwivQCAHihRszXwyf0kfSMjdUDkP6+21Yk=;
        b=rdzlylHhIL2797GA1Yoz2iijt0Tbl70T1oCBUPs7m5tcBEbs2tBJkpmxFAWSoqYBqv
         BWE/JbaZb4OffsfHvwyCim9bkpVrAkR4POYiTl4CtW15g8ijE4390v4cO24hgKB38Q5D
         8/SqM8tybgay/53QEeE3P6qd+y1GM5gUaLcZsx2FBZ2r9G7svlES47CKdHux30vm85Ah
         289wU3hZHSdwsMCIf/5Gm0xxOWE5X/xGQ4oIeXrjHIOeDbpRQECyuxtU9Sw6DRF838R3
         KPMH83pl63E9sH5tEGBI1J1CTJ/zqwh2vM/70g+PNlhuYCXcvYbhHH9FhSmSuAq2tPKQ
         ByPg==
X-Forwarded-Encrypted: i=1; AJvYcCWKxrcv0wI8cwygp2QbkmmAs63A7MVo+RDfEWnrF8CiRmom9yN7dw1rPHdpUlQ2TDdac0frndIJDtObTK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH523C2twkqPRxd3q9u3rYtiEzCNEqJhr4viZT4f5bnhW3kTz3
	GWBO/irPeEogjHtHmCHIbpcBBDLr41RpaXITpcogIi53R2d83MhCmE9YqEFGfUDSXcdLVG57H68
	OxB43zblHr/OSJrfW6UjrtSmjGw+6zR4sRpUCzN+pkTdqqyO6MK1NWgr8yHBSIKm9Wa0=
X-Gm-Gg: ASbGncvuStEyBLJFbEnK2VYL+kkpgS08Z7td27AyUK2tH3ECMtTklhAF4jQ1BRK0ZMG
	YbNzAczEuTIZg5f3nRJHNgHaBlaaXrsqzXHuppAqqib+z8iwKNyFv4NsoKGxM90vf17vFlEaqy7
	2p3Y8jZSZI+Dd5J37++g2ji/oyavYldMPOQygqJ5cXjI3aXP8xqmSx+SCLOKBzeY7gkFuzTXpZS
	WrmkCAGcKdWbXFFYc+INjwUQz62dzPEWFn5GexKILPhyZSXHw73b+2FrR8AakuwfSJ2Vj034etY
	pAu5SGKRb27dL3VvwTHV+lk7ci22McvaPS/I7+Lv6AOyYj/IlkmKzON1L6W1iG1ysrDBT6JgRa+
	F9oW2LwsJZGfg30ogzHRvQJdkhhd4kmioB0apU85Xc7Q5yU65Fg==
X-Received: by 2002:a05:6a00:1707:b0:7a2:7792:a47e with SMTP id d2e1a72fcca58-7a27792cff9mr1270493b3a.8.1761206866584;
        Thu, 23 Oct 2025 01:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm29AEfViqZ/xwI8Z4NkviSg6rNCA4U/hY4ny+YB6ujwOOvByBjS3fyeNcsd8nDzK1JHj/mQ==
X-Received: by 2002:a05:6a00:1707:b0:7a2:7792:a47e with SMTP id d2e1a72fcca58-7a27792cff9mr1270451b3a.8.1761206866100;
        Thu, 23 Oct 2025 01:07:46 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9cec5sm1676410b3a.20.2025.10.23.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:07:45 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 11/12] dt-bindings: display/msm: dsi-controller-main: Add Kaanapali
Date: Thu, 23 Oct 2025 16:06:08 +0800
Message-Id: <20251023080609.1212-6-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: c37Too96b7-mFflQkdwItbtIa-2mC2WW
X-Proofpoint-ORIG-GUID: c37Too96b7-mFflQkdwItbtIa-2mC2WW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX4Wf75pKuXr8w
 z9QSyXVsfeWcBT0hBXgXNUgeYlYrxr9IWkk4P1qyBbmKYOZaezuz3Szud9lSRLlIk6H9Oe/lRqy
 OQtVThU7YpnvPn4cj6VBzwObSmUYdsDahjuHUmV5pWJLzyD0ZXZ6X5SbRF3TonjxS83w7UQt5ul
 EDZrdJvV6q6X8oBhIGHGd7kzwJq7xBNa3/h9msaWpDHmgCCzOCnVsXX3xT95f6JvXiQNKi4B2V3
 DkBraq98fFNujpHq3kncyLy9opi6qLAO/Qq8Fp8JxKwz/AgLREfqimNuW0TX1rZpUooGMWnW2wI
 u2d6hWpp1satIU7vHgS3S9Tn46VXdtefR9sz6ZB9uP1w7s+kKrD8nGUpIlRTJEgtQ6haFv+AqRc
 BQQRClbN+UKl7wWXPIO4vnn9D4kokg==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9e253 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=NRHHWUy0EX9jfUzwrTwA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add DSI Controller for Kaanapali.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 4400d4cce072..536ebf331828 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8064-dsi-ctrl
+              - qcom,kaanapali-dsi-ctrl
               - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
@@ -369,6 +370,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-dsi-ctrl
               - qcom,sm8750-dsi-ctrl
     then:
       properties:
-- 
2.34.1


