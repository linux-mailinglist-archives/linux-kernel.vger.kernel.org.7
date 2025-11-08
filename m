Return-Path: <linux-kernel+bounces-891313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B5C426A1
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C32D3BB940
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF62D97BC;
	Sat,  8 Nov 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWf4LCWh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AGtM29M1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00C2D1F44
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575855; cv=none; b=kMM6GfLyHb021pBjm0KuPx5wiolrvl1z71Adphbwr10OGFQ1znKZNhLLntcghKhNRLHAtQgOK27DvYOByXg2nFr7BjnP9fWTc6epiyRBm86tfd2A+pIUff2rA69XaBg9Gl4Xj/A/bhXRCYFfjX7RY2iw1c+pBHOfO6HoVtNAWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575855; c=relaxed/simple;
	bh=RzruQ9wp8ycOBWczy25ujS8bJ+hwcf0vs17Xh670YBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=renDiE4C5HEk6Ho7eQITA/tlg3IaWvznXQf/56obbkr363s1jgHARShwuhM8PQZRqzrJHnuSrYkGQujJSjzFgiRUb+SGbenX3+XENRVTgttxbXgVna5+21FHGsLp1M1voi7IhmWlMWcoO4apgOFEmavpkgex3H1H1mCbOzpMtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWf4LCWh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AGtM29M1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A84Jxr6817397
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 04:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=; b=QWf4LCWhBIetda7E
	ZKcMJbQ8FNl91ZJPKvgGK6wPVrsmXmxyXdCOEaVYERQuQhNzcmrfzWPILYarNtNx
	ySqQNUv/QTiKIR2G0o10WSh0UgH31HfWok6mjgiMcjMUVc8DnXb2dYCTVoQz/fJX
	XVNZvJTyWin9leu4LCrr0aN9k7NZkYffmXdQv4VK53wi8Yk3H3qZxquJQO0xGZ1A
	njPCXA9FnW/cpX1TW9TVO71CzNdPN61Xtl8mOCkMIefvlyIxeAN85m2hTeerJcAN
	gjYqrTNhVNPM2BqSmm1FMFTcM0tBcDwnW2TJPTP0BhWsVb4goalHpTIQymCSvCGW
	HUcIdA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xr4r078-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 04:24:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2964dfacb68so3995105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 20:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762575851; x=1763180651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=;
        b=AGtM29M1qbtwrliiN097ZILXbarAA+Q52ri9OyGEf5XGYVAJsAXKjAHMgCf1xDYGu2
         YlvbPeqhQ4pjItGeYFJpfj2HJ8yMm3jr+zp4k0se+VEbwTgw6BZw54+9Rf8sXf1c8kxj
         gXY5PkXaAOm+bSTe5d731K6kld492DS18HFsShoOsDRd8NHk6oidLfBSUKTWqojmmLJc
         Fh9siSO/qnfG8YMKyb24jxu+pz+X9tGlcEuIKKe1tVK2d+Cfs734VLDvBqtOnUaZgY6r
         24TaThuYtqL3ZzWH1PMeGBXsl9eazxNB01PTxieaqzHXQ/ARpcW4Gt/C+Pw4UB1nx1uC
         zzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762575851; x=1763180651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=;
        b=Sjh6ycme8d60v6djarxe+MgkVdoO7Cn61Jlqgsc1RGz6qSMbEMiK1YTZs/+Zq7O/qD
         EXTondxlBy12qrdjXDIxr1yPuGkMhbcxwUisD7n1LIK8iKeNIfDAOyvzNOdKXAqgQeeo
         /C196A9ySDqT8BYtc8/K3e6z8t6dFDxiQzsqyXz7cujSXDgXlRGhX14IqIKG/67La/a4
         p85YSEHkADG9oqGpgUgHTi+sSIHsmupe4ozkF2LgkAZVZXkyFbbnol2OeC/cHFJ9YVk4
         xtMDZh4nMY/+NshgXta/gQk7wVsR5OQgqt5cZk7Sg87bUoy9k5FpD5DWf0VXaUW5xDCG
         emOg==
X-Forwarded-Encrypted: i=1; AJvYcCWPc4+SI9LTmDAJpLBoJ04L/Yj8+uWjQ7lChVBd+SYIih6P6BCFOM4356gsUPzqxUIcNIHJ1JKJ2pszB9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/InF/8iw5t/v/6ToX6cKCeQiRaVPWnbsMqlk7ZGGbPPKfs56K
	q2XiINHb4pl+2uD9eq4zZR3dIt+AIfD3uFn8vIaT3OovSVuVyrZpJZR5SfyIxyIsBDRaZCypmsA
	qjpbiWMIBUqGHxyJhaiD+UjzYDSyiVH62ENHklE5gmdA9/SnuN99TObT2ZcCsICcW+F0=
X-Gm-Gg: ASbGnctMo8cpBas3MX8FnIz0qqMSsneZ/Bhg5VnULMLKjVMZPGzaeovYIH0Fin5zlD/
	BehmmvfmYze/3leMzB+EpSwyJ+qp/RG69ZZQqr4mnySNx6xiclp6GXNQA02kMil4BPfAY3JcJnC
	gGNEJMVzblTJdIHJODu/713AgMyw2uiVaY/l8IuHzgm1YpBNlFRfAmUBFTi/19WF4+I25iF2L5U
	FG65HDRPM4uLLgVpk7jbKRuehPXUiYLRZ2iUP+V0w2BAXcnrOKd8YO/pKaY95yYapr/HEE4GMBs
	K4daizr3d1wbq9wClutAxyGVonQh+V2IEvzHFY8n4YmQ8ZWv+IY4bMEG8FYQ5pe0OFFKG34Z0X6
	DWTY+O/zOOnSTbPhfW6GBmby8bkcFVCqAvb/zfLyBltCay4LQ67t/dbfe9TQ=
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr9475685ad.7.1762575850809;
        Fri, 07 Nov 2025 20:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc2T4l9Pub60u4mvuoxZoKdhoytBYJ9DnpI+jGuvhEiD9MFfksqlH6xBEpa+ahRhwh8csX/A==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr9475615ad.7.1762575850343;
        Fri, 07 Nov 2025 20:24:10 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm75442235ad.23.2025.11.07.20.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:24:10 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 20:24:05 -0800
Subject: [PATCH v5 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-av1d_stateful_v3-v5-1-351652ba49cd@oss.qualcomm.com>
References: <20251107-av1d_stateful_v3-v5-0-351652ba49cd@oss.qualcomm.com>
In-Reply-To: <20251107-av1d_stateful_v3-v5-0-351652ba49cd@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762575848; l=2537;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=RzruQ9wp8ycOBWczy25ujS8bJ+hwcf0vs17Xh670YBY=;
 b=cg1QpdXQckjwYuFtNcqmfDOWzTBpBbqjyOZC9kzEChBsuKtoYoRbh6TiEpY/G7s8JKGIoxGc/
 wNrzzoWrykaAOeSu7ikmNZodXOq64+3BKZTbFA7DZgYs9anMh5ldRN0
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: fFSKApe_M4e_spMOm0EVzFmcXP2ud9XQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAzMyBTYWx0ZWRfX9TO4SpaDW+90
 ZDG7QVivPzq2msafDms4iGLrqQ4aTw3qQdksajr5/FaG6mkmLQ2IRCf4yARg6R3P+5d/8jkQ2ro
 OqkQ7CeiaUjhP+csRJBtNrhtE1JkgxWO6OZG16DaxsEzUSCTQ7K6f5YX7p3pPq3xdPMgunAqVKM
 mtDqD3UN/HfXejzgIkiG3wpIqY77yW8Gf9Myr0uc7emVkSJd89zFD1hyM/rPGruwjm87XdOxgKO
 zDXyAinPQ5RZZNXVqvRTfzUz3Ek7RPCi8zy8kTr0LeF64CMUbgLdo07lTY8OayCrvqTSxkZuRzK
 MojuEGqS9rNPVDzAOsxwcun5jVDe+8mg+eFflH0gAUOw7NzRYbD6BQAVDwjU6Siy8CflWwGMdwy
 ZRc5FfrEyuyT4fHbqMbvahZmvzM8Ag==
X-Authority-Analysis: v=2.4 cv=AuvjHe9P c=1 sm=1 tr=0 ts=690ec5eb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=5q8hE9cQKCNJD2usWYQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: fFSKApe_M4e_spMOm0EVzFmcXP2ud9XQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080033

Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
Video4Linux2(V4L2) API. This format is intended for AV1
bitstreams in stateful decoding/encoding workflows.
The fourcc code 'AV10' is used to distinguish
this format from the existing V4L2_PIX_FMT_AV1_FRAME,
which is used for stateless AV1 decoder implementation.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
 include/uapi/linux/videodev2.h                              | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index c7efb0465db6480fe35be8557728c196e0e530f4..6ca63f35b801b8aae142b69eddfaa549a5568a3f 100644
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
+        Temporal Unit per buffer from OBU Stream.
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


