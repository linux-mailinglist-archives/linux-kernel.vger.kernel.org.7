Return-Path: <linux-kernel+bounces-882972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817CFC2C0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3251899FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099926656F;
	Mon,  3 Nov 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aK1VDKeB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I2Fs9IUs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BE261388
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176262; cv=none; b=FmCq8E7FSRXuieCRCpj6mP5LtbKrz/LyGdt2HjQSS+H1FDmlA5fCPih2QVEXV+833OUnn5a9qgBfSd/N7AR3SB8zBXWarU+nFw7cpDeGPDDodIwkqYfpK//A0ZPagZIM27CEE7Ux9Ckl/7dqTJYBwhJKgnHDSVR9dVpallqqKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176262; c=relaxed/simple;
	bh=SZrZjo2s0yDcGXFZCdWPCh5Pkm0hk0faJ9y/OoFuzs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASWpAcsGzKGHo6biVqkM1G44StuR1fArdxLZuItuZ86DZIi78Grop5+opf2bEccvywvKXLB7mPOaV877Zu2NGDCQrfsydiH9wt8O3g+cFsFWxayCt4v99rI+0ijdojoY7p4gKbEeOJ9QOY22bpc93cxSx5otvz8kU+Hsv9/X3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aK1VDKeB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I2Fs9IUs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3CQQYh2247295
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w0bUAQePG1bGRaZhHjmNgnU7WKw1Px2yFxgVwokQWVU=; b=aK1VDKeB78Ft5zFt
	xrEHENj0XydNvyI3rfkNEGLsdT+b+/Ic+HfbcaeRhlJa52v3QIKIhJl1bHHn11ta
	QBJbtCV7iTR7LrcWgcA76pOW1aKugPySeQeRtF9h7n/9MjQGMoHV8ZAtzL3m+q6I
	ofY2in/j34uY5nvn7hWzknVRUu1L6j8/FVmiIpixmf1zAt1sOMD6EK0AEOyEUdue
	2zJXcxrLj0eYXzigVxM0xxEL0+ncArDUqVjEfGcUK/Ymqmxn/F0o/FBKBhgGeMmD
	bkoHcPLlPR2Ba2iRwkgHbbOPRXWl6v7NE7jfucHwgRBR8SXP2TJ2/e3kF+4SU9Lu
	gGysNQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6q0yh812-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:24:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3413ea2c342so287432a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762176259; x=1762781059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0bUAQePG1bGRaZhHjmNgnU7WKw1Px2yFxgVwokQWVU=;
        b=I2Fs9IUsB85hEv8p3/sbqT9VNUp7PB6R4/hbD0hj0PeMq6UOXmbUrI5EbI4CCQjFrV
         +x6JhCRlD/L5137qXY7QReIsStL9NvZmUQIs+T39gG/gjfxvKgnBDk06ZE3KahwmV9LW
         CpbQBO3b2uI5qIvfB8KOrCsGULBxIySfJ1QWpF0JzVzpuE2Ic/QHl3OWHfafTk1Bjv6o
         JHBTOI4YiWI4fRg/l13OVqnZ0OlfwghynxUnDSYW8T6RZDL+4zVipsPABH310YuF9krx
         H9IvEk+h6ST/6xsNw/ZRjiXIEZTKjhOIG/eUVkaof//E8P+MUQk8497Ou2kOaVgdVriY
         9Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176259; x=1762781059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0bUAQePG1bGRaZhHjmNgnU7WKw1Px2yFxgVwokQWVU=;
        b=rSW3o9IwiD7NYnqIpz5CCC3FFjMhJAlSZKfDViIW4ogdmeR2p+oD+A3F3sskFEvRKs
         7NgkKyQFTOp5xmoU9SwHYD9eLfqr6f+r8Ywk726LYvltJA9V2vflxxUCRxcR8fQbR9T1
         Jf8DWUR71lB/CtdSqeQCrQDjyx+x7KPYFarCk+bnr64CvhsMkZ0zS29WIGEQRh7UEGSd
         ksf7lc0OpA8r+trSDAVZyqv9Px/IUCkD9zu1aeSKCLO4zYEiAllOd4PxrZ9AqPVojdo8
         aUt7fTYmGCkcquEcgcx5ivjlNwLCQjyhO7tg1GfPBsOdM4wmnSR1v3f8NLUdpDNOwVII
         R5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWBcymNpckUOcLzDuuDFQmbKJhPV1AomY7YL6dIVN+f/dOK/YMmirL7qKeOkJZBtrJ2Ccm2gchCuYpn/XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbP+rgxbof/P++yvbJJadgmfKOzzC762rWcRdI9Blfau4rra/4
	0z+BTGCeDI/iWmZFatcTrAlunrqWG33Y1s0+uwBpVf7pUs/mQA/lHQ/d95PqxpKqH8UjS7VlqMP
	Nob91ZM6jgG8H6I+DVCGiLsH8RWw+gc+qvHbbnf5aLPDToNivr1qH+BvUoVO+m61JKMg=
X-Gm-Gg: ASbGncvDR4QZI7IcHNH1awTR5A6tPGSbaHzXNICvepviEITRAfuSnN1rLi4tMd1qpq8
	rh8WWX731L5Tx7WXsVnZfgDd5hdWfgMX8Kw30bTBR3o1OzKBGtV64Ah1SMM1ZSdBiTKcKLMtmLU
	5oT3RlfvlOolVcgSUj331TO5BAjvbsjsNDLFdNxAtgNaKvo+QvRAIVUHZOilKrCUvzSO2xdM96+
	gkDI7K+Agd33lSyerkSCPSGbvV/z/7+i0Ujqacy5cvu3FZlZdubAOYo63Jy99vJMJ/MxrugKvth
	exwyxeH+2EvQm9f+qMo04rpI4lh71Q4iyn6y0TPqcmz6Wno2aWUtNRWdOgaZxnVDhq5zNRlvXlb
	YySW8VJmB9Hv87bIJ0e60o9R3nibZZfZkR8XkMLAXcXjGTmR+zuVs1u5Hfvg=
X-Received: by 2002:a17:90b:4d8a:b0:330:6ce2:18d5 with SMTP id 98e67ed59e1d1-3408309f105mr8891839a91.6.1762176258872;
        Mon, 03 Nov 2025 05:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyIW0BH20ElS3Fhbf25HVcEUlDUuxxvJCKXdoilo6wy+7B/fZedx4edNGgyTNwUTrV/xSiOQ==
X-Received: by 2002:a17:90b:4d8a:b0:330:6ce2:18d5 with SMTP id 98e67ed59e1d1-3408309f105mr8891817a91.6.1762176258343;
        Mon, 03 Nov 2025 05:24:18 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6614812a91.2.2025.11.03.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:24:18 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 05:24:05 -0800
Subject: [PATCH v4 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-av1d_stateful_v3-v4-1-33cc1eaa83f2@oss.qualcomm.com>
References: <20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com>
In-Reply-To: <20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762176256; l=2547;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=SZrZjo2s0yDcGXFZCdWPCh5Pkm0hk0faJ9y/OoFuzs8=;
 b=xSuETWOuPoqI9D+MZWk5uNiBkn43qGqWDa3uSgo70INpcWRAUANQ3xtkRbzI+KII7cm+NG62e
 +94auhPzarMAsqe/rvCC/wce1tvZ0f2cwQxCKu8JtN8Xoda6Pq7iyYU
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Authority-Analysis: v=2.4 cv=NYbrFmD4 c=1 sm=1 tr=0 ts=6908ad03 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=5q8hE9cQKCNJD2usWYQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: iSMFa1IfNbjjiCioIAdyiIJR7f4iGZzh
X-Proofpoint-ORIG-GUID: iSMFa1IfNbjjiCioIAdyiIJR7f4iGZzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyMSBTYWx0ZWRfX1ysOz0/9H/dT
 7kuuUIbsDDW78wsS9kiaH9u93/YY+gk5/yp4g7mSjiBeSxMpuq6M5cjS1+qfMO0ydR9vKCdfl39
 VuyW+SGKlUh1AN4FjFEs+p0+j362bhjszB+cXX0bHL8zs3w/nmq0jP1Q55XNH3HhO72j9uPx98l
 +nC+tBU60R33EtdQRbHriddvslR02yxTAsQ1T76ZSpoRLIxWqUnBC61vmFS0PP8EvMvCNIp3Y19
 Z3Yuydd3KLHwnnhr50zi8uxkNIsQFJPcmJBBOtnjfQ+HWms7Ls0Z06hquun1y7YCA0N0y6BMpKT
 PjDCCB2OgNEh2CJuNKtg3CoNFvJt9qU1LTJaaPYMr6z87TM505ey0QIu70Pp31POa5wGWBlC0e7
 XsaElkLAV7Hp7CgvtiM3aA1lBm2CyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030121

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


