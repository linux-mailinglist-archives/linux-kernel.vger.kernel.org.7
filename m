Return-Path: <linux-kernel+bounces-877648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3EAC1EAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F21885FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D663346B1;
	Thu, 30 Oct 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfM1D6AB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ikp/Bxoa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68C2F5318
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807638; cv=none; b=unkgSHW/9hLb+rRBZyIpSUK9VZMbc9a1lXJEntEZIaoExyDCmO/ermwUOgfO6KxSXHS9Mn05/TQfQ5CQi9szVcwk05yii4Spr36LnJJLoIdCAhpzdGP4dForFgJvdp9vviLE4+OUrYPRD2J8C+OMgTH4RapdoopNkHp+ubZm5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807638; c=relaxed/simple;
	bh=nkMTv+cGBneu9mDQTjTqBZI+GutDvkdMMD3WodVls7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRd9T70i6AMvzy58HcYug3ZK+Hdw6WFcj5RAJiXqlN7bSZmEBXOw1LUMwpTdfmiGDdS6vtk/itDboHaI64Dexc4C4Q+fT0Mjide67anHZYigIkRvhho4+iTVpwe4FNqSKczgdYj75ygb36fwn2H33XWlZuc5fQkJy9tzbwpXodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DfM1D6AB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ikp/Bxoa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U2Jwj24135755
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	79IsCawl82bQEifBPmUrGKC8kwHl1F6WlaHBtQQ3mx0=; b=DfM1D6ABnHE4WEUe
	LeZgbuARWpYQUalLf2pc0NzV5rITck/EefYiYkOnw14B+fHjDYPm0jQSU3GQ0v1c
	I28kUj4+nSGxZvGynUjdOlNIbLEuAS3mFNywAzOTaCh2HXkN0aZCtZ4ANyPIZ4FZ
	4CACgtu2+VwLXPx7ZBkqHyNcMS0xqYGmHkV6+IVa3kghux0aO2ab7c6uyuK/d3fr
	gmSthIrr4MS1JQMD7ittlchEmbpT/MoJHkS+QiQ1Ot1NkWRAx4bkDtn38ctI7Dcx
	8wDxC6yzNJyCDjhlKgt0Qp0ksfzk3dWrX+WQa2XW+5CtWsuwiG+ZXUoecMIcyNxw
	o52c5w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9unq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-293058097c4so1757285ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761807626; x=1762412426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79IsCawl82bQEifBPmUrGKC8kwHl1F6WlaHBtQQ3mx0=;
        b=ikp/BxoaeQNCPu12sGpsu7Ic23J+t/g0XFPJOCxnbYZn4ydu5FoTZ99tiQE0dYJ688
         E03LjtlOULwpyYjvzVxS6XwnChAkdTUCVwYn7piC7aoOkaYiVFrt+VsVtvk85Lp15qDJ
         8xTEAjwrWPD0IZxB/xSMzF/QdT/XHAyo9qOfszs91qiZCWCZll2/4hOOzJ5qNme7ZHH3
         JjX6HBdzCohdwp6loKImpOFJksaAanwwb/bU8VlW7Hf9epveoUyP7+gFyo7766tYMV2X
         J73rT5/a6/CD2bn2Aa9Uenqb0hGkeCHBiVCZoX1oSXKvdwdQto8ia80z7428wDBoPiVc
         zWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807626; x=1762412426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79IsCawl82bQEifBPmUrGKC8kwHl1F6WlaHBtQQ3mx0=;
        b=YZTcdw5QN0TBJS5dUsEBW3N4PScU2dexvyseA/soBHUL3i8yFYqn0azxePhqnt2Bbz
         6FtsSSrRvuOawFFI9uYoCpfN28pwbV9WZceNckQVJo5e3hJDsCKn4HGeTCGahXgHmnBd
         8ZjD6yhHl7v6oG7sXRgm7bM2WuHJLq5gZcXEYRcdY1yxxB1no2BaZDNBA2M4hTWueQIc
         h1Ej7+ruCgmEXtR6rJB4nk2W/btuZBvZKGDu3CjCVuGRUMD2ywu+9o6A8TRZ+Hk4b1pl
         RZsI6z/xhmUIQHCk7n/lKLgt0A6UBBjDdv/NtYy19ICzS+ikx+3nVN5fb8ZhUSxsvM5K
         nFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVABEzGEvokqHLy4Y/4PuBgQgiR3KOMjXPGd626UlUIPZFn8Pfj+W/NGsFBa6OhqD4HJXxYA8+S3MV9qTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuOAfPOpY2e8mGvi7GcreBF0raZSDVDTeCMaXvX3hZAlrYNwm
	T0/U05yLitNrXpFyI9s5CT9ZP0BGQuowTygg0P0+JR+PavxB4bTU+9wEfFJ6EzD13HVi2Xx4eIA
	I/c0RBj+jrauAMw+i4RIOpO7eoCgDGdPAsMnpTcYrWez7MHSjGHzhro2kyzur1BuiJyo=
X-Gm-Gg: ASbGnctDgVm1/6fqi3oOPdVonJGxWzioSoCcRioWHv1jGpRODsEiW9ZHT2DYLzJ5cLO
	u73pJHBG1VGVJC5O+sRk4nnjEqB1v42qkgAvK5MSAS5AZ6U/iOALAS+2xd4W/aWBRdrqSEjOf/s
	lDxTWBALZSFoLBiG03OopEElt+HCq0geN2rQfCsSIksn644TyJpyB0Hhi2xn5yyF0MCL6+32DAA
	lOqYilJkWXY8EabLGBPGnNYRsgT9kKAj7wJvy20wFA0Ft84z+/3GmitjF08Uz4wEOumLTOlEfBu
	jXL7EwZxcVUCByAgLyb8euo/eZaA1DAMd3tLfkS7ZPwDh/HfQsT52tHimAUIbGPfEI1+l3ETsJk
	BDBjKOo8ZaHotTez0l4xxfip0Btr+Y6S0KZUm34TbnfIKPk1CEiz4aGPVt9I=
X-Received: by 2002:a17:902:8c92:b0:294:9847:fbfc with SMTP id d9443c01a7336-294def6c333mr25632195ad.11.1761807625614;
        Thu, 30 Oct 2025 00:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGasTEFUNJtE+G94KtjRffyB1Voc9iYmdVLTZXDt6lCPlF0AJJNQDh4vq/aF7zCXdujtbxQ1A==
X-Received: by 2002:a17:902:8c92:b0:294:9847:fbfc with SMTP id d9443c01a7336-294def6c333mr25631925ad.11.1761807624956;
        Thu, 30 Oct 2025 00:00:24 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a73sm177671325ad.74.2025.10.30.00.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:00:24 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 00:00:06 -0700
Subject: [PATCH v3 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-av1d_stateful_v3-v3-1-a1184de52fc4@oss.qualcomm.com>
References: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
In-Reply-To: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761807623; l=2423;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=nkMTv+cGBneu9mDQTjTqBZI+GutDvkdMMD3WodVls7o=;
 b=YXg1T+6exolovBIvmlpqgpeHmi+0zn2Pmy4thtiJSXAp0j6HTJrXOM/YQbZc+4P6CcLABv4rE
 q2MIfsrUPaXCg1YK7dZpsV59L/HyCErY8nDeVeciPW1QNp5dTQbYeLK
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-ORIG-GUID: 1TCXgc4J1ICx1vxS5kB1UgjYOxXyw6nQ
X-Proofpoint-GUID: 1TCXgc4J1ICx1vxS5kB1UgjYOxXyw6nQ
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=69030d0a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=5q8hE9cQKCNJD2usWYQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA1NSBTYWx0ZWRfXzz+/U/45SvbF
 92qIP2ZXdinXNaqf4xdVM6VpCkCGNL4GtM820tzL+yDdzNOdiCoewzN+thClU6NgDMxJvQqOUnh
 Fg1z3YfxdlaJfO+cmtHKZslywzn26lhk1bzfVSaBQdpG3wT+YotuCGPKCbnPVGtJ9LJqTR0JbNd
 3xQHaKP2AQZybLvLZwzAjeyvCWdZyaCpJ6ZGs1ZsPYvs5VhgcxANMkgMWUiKfCvh2DS/2Gc1eK2
 CzNjJs2gJaGIQtUFYNtDBNoEJFgeL1rsz0027n85SMoa86apv9iWD3kB6W1moAP7OS2D+XJEned
 ADzYlSrCzu9F9w9YvTExUbmEE8tf2gNAohkEE+kE31+Fki60946sSKu0/Vm0WYRHKGdTNXkMC6a
 6ZVgEwKnGC7gR5wzuo2wePrXxy2sRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300055

Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
Video4Linux2(V4L2) API. This format is intended for AV1
bitstreams in stateful decoding/encoding workflows.
The fourcc code 'AV10' is used to distinguish
this format from the existing V4L2_PIX_FMT_AV1_FRAME,
which is used for stateless AV1 decoder implementation.

Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
 include/uapi/linux/videodev2.h                              | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index c7efb0465db6480fe35be8557728c196e0e530f4..0c70410ffd4d58e0719d3cf13ad336c97b454ae9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -275,6 +275,14 @@ Compressed Formats
         of macroblocks to decode a full corresponding frame to the matching
         capture buffer.
 
+    * .. _V4L2-PIX-FMT-AV1:
+
+      - ``V4L2_PIX_FMT_AV1``
+      - 'AV01'
+      - AV1 compressed video frame. This format is adapted for implementing AV1
+        pipeline. The decoder implements stateful video decoder and expects one
+        Temporal Unit per buffer from OBU-stream or AnnexB.
+        The encoder generates one Temporal Unit per buffer.
 .. raw:: latex
 
     \normalsize
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cf0b71bbe0f9d397e1e6c88433a0fc3ba11fb947 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -775,6 +775,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
+#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '0', '1') /* AV1 */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
 #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
 #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */

-- 
2.34.1


