Return-Path: <linux-kernel+bounces-858599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA6BEB41E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C91AA56E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186B330317;
	Fri, 17 Oct 2025 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MdFACgCJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD52FC034
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726558; cv=none; b=ELg7sP09CaK++iR5EW49NQk0uOaBoQCDrRPIbboXb/Rpr4TiF+kzDIdSBfmdkMDnIrQePOuJ2woPZO69zsMRPLVi84xmQERS8pbk+vr1rBqRiIK2NWU3p+m4WOvqsKjnL45/kbOvLxccTrd3b7G1Sgkho94mxKe9gmmpd1qm090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726558; c=relaxed/simple;
	bh=0hCN7qCXSLUAZXIjLrkyQ5Q9apLRdYKGIeQ8hEqHEvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyRrtczpTpungA+JVTx8qxmTq0JNhG+tSaCGg4HNqE5jxLueNQbi/qP4TJ5R5gWFtqvPkNofZ4D36oWKxQzKAna5/du/3zUQlm48HnWwggPoVe20mMpIIws/4/L4qPgdT39cqYCLktuceGFSiAyr+SaHTTtHmOZ+lUQ90k8OREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MdFACgCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HIavFD008297
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K5dffV9vMTN48/Ti+Eh3Xd6lFyWq3KjwFHmjYc0NovU=; b=MdFACgCJjWVuvGZS
	QeDh2WcNStf5QQtGSxMxdm7zTRaxYS7JmFXP8Cefe5rhET/VQJGGUv53RaxaLdix
	JbGRTDUQ90gMVFQpKR8I7hreuWCNgqvS3y4g9ZUsnp3UFtCf22T2Cnss7+9szJ3k
	eXwz4LJVi1GsA92gwcHgHPHz5JMa2xUf//It/O3R5FMnK1U8yvTFsq8Z4Ncv113w
	ArlJ7gXeTK3+B9kYFAXZJ7PAf3zJkhj1o2s7m5cWQZSfB6B6WgVJccwiTnht8H1x
	LvEdCB47fFBn4z1Ne+vWB3+MI/NsRot+D4uTm4epYcLrpwu96kLx4LBZ8T8MgXIV
	iQyUJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9deav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:42:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-890c743a001so38028885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726555; x=1761331355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5dffV9vMTN48/Ti+Eh3Xd6lFyWq3KjwFHmjYc0NovU=;
        b=SU7iAr1WZHl8c8lLz2DMSJ6BmA9P/GEXhue/6eq/tYHf+7X+bLnsBEsEofmjPBKWgI
         f/mIn/dNA048UBsmNbiRY2V1zO38jAvX+wO2F+k6BK4xLBVypK//nJ/7wjJLI8gKn9b2
         XDwNesG1w0yQXiwmKm5y6zZTAfq5cbHP8QhsZ5oUIXaMOIivHEZxif/Qk1on78PvL5V6
         dg8KpKr3hHAEo5jq1b9TdZ5rSNon/A2zAAyScMxzAlqERdf9nH8OG7nRtaFWns3vp2rZ
         TiHwScDlE7ZRZXhSIahN5xxzKxZp07CeydffPjQYcLTr9DRBkSkdMrPO8kF0vOuLKBe/
         x+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVOUVRJQSodZyrbaXxOqpDbWMKueeukgS8BP33hZ1ZyJW5+DqS3SwIhanKsASBFu7BqtRrbvE2wmXz0ooM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzev58PZVbUTelQgAFIKt5sE/aTZ3YiN5xdYl9hUq62WmRi6RD
	4jADk/GD0Ndjm3LV95S2itgiCp4ub0+JjF0NHTT9RfXhdgCjlErfcFU9+IBBU0Ld5HEc6dkEuYb
	/0v/peBBl37MC4wRVFy1OMvXAkMIz1hzUzla89iWH6uGjxyOqXrJEVylPRZHkEWSNgic=
X-Gm-Gg: ASbGncvC1/sf7m37Evic8tCOFn6PESk3ewMvwe18IBNkERANEVtI8immGRNJh98Uhrz
	ZrDKk6BdNybJ4qWW+QMOWtiutEEUCSxY4qI9nqyIlR7t+0HsGoLkVOwjlEYEBb+MM7tFczvNBBB
	SJaUww5v0xMAJLee5ZxRMRhTY7v1qL96FgkHgELr2cslUi+4xG/dOvZ5riZ+8f4KWlPpQQIEN+a
	weyt6JfpBTaffo1PLtqMm4ztsJLzh6eXdVuOBGXjO28Rjp5PACHuWbbuNKIpascyR+5jk3JOP7d
	YtZNsUEcJm7CW18f+Xpdxn13oYu+st/p5TdsHUfhEjAhHHOi6z4HBH1TLPFB+pKFpece7qXUBlx
	AmyBLgTo4M4aS3xl3+AHRh8DXYDyL5D9LtTsT2RvUqn0GW3eJl2G5Jl8uJkw=
X-Received: by 2002:a05:6a21:32a0:b0:334:8d22:f95d with SMTP id adf61e73a8af0-334a853656fmr3755222637.2.1760726126651;
        Fri, 17 Oct 2025 11:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmm9s2Z9CdP5xpjHJUp8p4fYTpy+mkia0Il4jJ8DvJs8HvC0urRpa3rj4KvgvAv1rY/sYxCQ==
X-Received: by 2002:a05:6a21:32a0:b0:334:8d22:f95d with SMTP id adf61e73a8af0-334a853656fmr3755198637.2.1760726126104;
        Fri, 17 Oct 2025 11:35:26 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24fasm245487b3a.42.2025.10.17.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:35:25 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 11:35:15 -0700
Subject: [PATCH v2 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-av1_irisdecoder-v2-1-964a5478139e@oss.qualcomm.com>
References: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
In-Reply-To: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760726124; l=2423;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=0hCN7qCXSLUAZXIjLrkyQ5Q9apLRdYKGIeQ8hEqHEvA=;
 b=RGUIsMsESqBt6hXY0FtwCgHQ3CTacRhs+L+y0gnVmPeLhBqSoeivguFT8nRn9HVtwghv0nqUv
 qy4LpmxRUlqAQf8W0eYj+Od9Nf31cocgjG9o80jfH6I+NCqMwt91laD
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-ORIG-GUID: ffwmo6SYrUmbQi3yvApiTrn9zzO8NKHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX4OKqUOUZf5mC
 m1TwokUUbfmC0sxyEEg13xnq0uT4VhVJu2J/9W2mNt7H4vnDI8eI2Aabtk2Vvf2cD1MO51IRPR1
 s4oRRzBN9254ltvDjqmmGD3YVndAuvaXmbt+ZbHZYpGGc4tncnYDXEhtkHjs6Z4LikuIZEHRTg1
 goSbubmLTmm8g/5BuWoFiOav33WLlqsvsoLOic8JuQP+vQPm9HPJc6WN20K/R+i2oxFF+zU7Q5S
 12ujyQ9Er6rf535gYgVKVDi0Y6+N7noKRja3TTr94eNa4KLRf+Ty6ooUwsXQtgyzE3fvMUIseVP
 UDyDGontbxRHpp1fLD6AWWFdwNv/gX7Hl8NRuNSt7284AhONWpBE+qHX/9Gd/dw17q4kGvlCArV
 W5dZlTUn8zBO6aQRbI0OjOt6fMHkzQ==
X-Proofpoint-GUID: ffwmo6SYrUmbQi3yvApiTrn9zzO8NKHG
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f28e1c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5q8hE9cQKCNJD2usWYQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

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
index 806ed73ac474ce0e6df00f902850db9fd0db240e..d82557a6ac30851b4fd432a5ceab969abaed2e25 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -274,6 +274,14 @@ Compressed Formats
         of macroblocks to decode a full corresponding frame to the matching
         capture buffer.
 
+    * .. _V4L2-PIX-FMT-AV1:
+
+      - ``V4L2_PIX_FMT_AV1``
+      - 'AV10'
+      - AV1 compressed video frame. This format is adapted for implementing AV1
+        pipeline. The decoder implements stateful video decoder and expects one
+        Temporal Unit per buffer from OBU-stream or AnnexB.
+        The encoder generates one Temporal Unit per buffer.
 .. raw:: latex
 
     \normalsize
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..e03cfe0a5ae830595f0bf69b951ca16beaedab72 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -775,6 +775,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
+#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
 #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
 #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */

-- 
2.34.1


