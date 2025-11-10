Return-Path: <linux-kernel+bounces-893762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39166C484E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA5E54EE663
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADA29E0F6;
	Mon, 10 Nov 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtT0D/fg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyG9/KOc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90529BD9B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795270; cv=none; b=Q51EgiAbn7LDFLyjo/3fLIY/x+cYAe3AnfJm3MBNmtjw9ZKvPf9Ek4N2eDxpKw4sIoFkiJMbpOTHKf23iJVQh5avyyGpWsQH25QM+Jh6kwbOc/fhu9pRxi+IrhIdDhYhLOjE2qV7YIfmw8ogrn8fDg3pEG27SkdTb1ZjkjdsCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795270; c=relaxed/simple;
	bh=qhbIdRggLRpMFNEU5UvyclByRdCjN29zV1MHtYRB1EY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiqwgDljqPIk9xJLdeZWW4wvcsYXSTGR4driEFhkO748lOs9XTnyiAVvyTjZOjJBldBwYgc0d8R3rxzu+1nVnWeO70cRaihW7fUuiDYjRhr72FKDwnilk3FoVsoTNbipuUrbMpaITJSGJgECHm/+z9XtiWtrBUFH/Moi+ppL63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtT0D/fg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UyG9/KOc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAH3fTi4166773
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckeiWHbZKEbeCpeB1+Xf6e7Acf5TIweUwRV6O7fxvMM=; b=BtT0D/fgnrRrPOIA
	zr/G++1yZOh71VUCOF4eIUqdCIj6Nl3BjeLEWpydbdB/xzsoTkbqcm0CoghvHefr
	vvM1wgUDpqSRNPA2B+HrOodsRQtpTnrbAYzCzxy4YjD8tW9mZlv52QhR8w5deKwX
	zIHONV5OVZtx/sQA4BGrQ3J0oF/42A8knx8iJ71Lu0MWdnzK3cATWT7ACWYkBQpk
	zU9tArshmjcei10qEQkMwy6T7e82BwMlzjdIPd0Si7MxS4vO+91wYbD794kb3m04
	sJyk0msH7vkC1mA6DgwL3Bt3knSkaOgEdBDA6PXfDuZQA7sxEEnez4ZMksTOZgDv
	+Ps1Fg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abm4a01tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7adf205afe5so1084832b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762795266; x=1763400066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckeiWHbZKEbeCpeB1+Xf6e7Acf5TIweUwRV6O7fxvMM=;
        b=UyG9/KOckUacYioQYCcc67XP32zZTMOSSvJ8BYHMJSoHvZJbqt6aVvhK3Ghs4SHXsW
         QKv8FWG+iCng7nWOSZmkEtPlUm94jTDnVRGJIev1P4NrwAc31r9rjLzcySRVJ/IHXVDE
         a+IQbQd/LUM2+oSucKPUu8vh1CEe4aCgTre/yy6VmmFLwRPumMLRx444lYNEsb0DBCDl
         48upfDdlTND1yaAe9h/zbsg4+ScOOm+J2vehxq6gXrw0YGCaXJB9TFwRzR0r4vXupmHW
         OQXdfZDxPbBy+YcIDDCqS+HCOVlWTuU1vYAb3zvFY0g3QXldR+99PaWtGynGiRVyGg1o
         7ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795266; x=1763400066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckeiWHbZKEbeCpeB1+Xf6e7Acf5TIweUwRV6O7fxvMM=;
        b=ZEPVSa7HOrMqSLzAN63ac9m4Wq4ojFzvyg9E0UTre/kXI+mowPN8Iv3HU51ZdGUWjU
         lydm1+0Aqk3E+m5811aO4fNC+ZGSoKTrXFYISW+WWlV96CqAwaPNAjsDN6Q5Q7QgVeZG
         rJuWZOdBNv8wynX7yd4UBopLOWM7COq52t3OKb57KmXxwY8chdeR1Y42tx6GShF/omUH
         mMNSiu/LIaUiDWO1gh3G5mXLHC91twiSf+bw152QCJID1NgkRtpDtVvZVkfje2eh6xzf
         jwhvgiwnwdFa8NqSLMZQAfABoklhUWJzPfwP4amgEWp/Vhyye6W1bzGpV+/GdbArIyZS
         ArKg==
X-Forwarded-Encrypted: i=1; AJvYcCUF/lDpBYnF96zscE/MY3m06rVf4o7JjRr81eJjYH8c5xSJkfQ8tHdQxm+UaDT7XRFDnmIkjI0w7ufqzpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJOd663jfcafiRLTwrUHMgaNj9O7IXnTer5FvrJ6DEkoad/D5
	/kwaKMHVL5DIgdlyF47mjBtAuJHe+d5f3gT0wZI/RYg1PhTe0XRHHx8TiRnVwBP3lSw4sjPIEOS
	REHzFWzGHD5W9GoBSXBCkntQtIGEfRzUkweo3vTbjKaP18VNH19dz3lp+VNu+KsC1yG8=
X-Gm-Gg: ASbGncuqi/yAqcZHFN0e8jn0wA2+lydFPVJJwwsoEAeRP7pg49WYV0ZkjBzFrBVjOuJ
	ves0VwNUmIlXI5aO9kfsjZorh13xTJ77q13yjYzRxeXn3qI5zSifBKaQgl6UibtAAuqtiokeckD
	2kefL/GJmKGFKvoqWA9/DrbI8cY15RvkjT8RAhnig+LmS4IbdOrJbS2wv2wKIc0x7YympoVxpK9
	zFn4Q5QTHDLQ5Wb9DxkgqzV16Iw9gqpO1sgxm9+0x6OfkM3JgyitE88RP1Kjav8JDL1rnlNV575
	8hMWlYO/M10wwwhbfoIgNJPn+9rD5TIuuq0ttJupHcHtWRqzwa3deplHBNp3Fegh8UNs32ivv9E
	9mZJqM0JTumeqjmf4OwJoFikNiDx2gcdZWkX4ESCinaeM67KVSURbKdu+UEQ=
X-Received: by 2002:a05:6a00:a0e:b0:7ab:4c7e:a9db with SMTP id d2e1a72fcca58-7b61d282dfamr136293b3a.4.1762795266418;
        Mon, 10 Nov 2025 09:21:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEELUiMijyxZMN4E92SLkBrNPzgtUVRyR0hamAnPatOCyPCqUcuZTxdqcpVzOgQ5TviKL+IA==
X-Received: by 2002:a05:6a00:a0e:b0:7ab:4c7e:a9db with SMTP id d2e1a72fcca58-7b61d282dfamr136266b3a.4.1762795265746;
        Mon, 10 Nov 2025 09:21:05 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm12643064b3a.47.2025.11.10.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:21:05 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 09:20:57 -0800
Subject: [PATCH v7 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-av1d_stateful_v3-v7-1-9913a15339ce@oss.qualcomm.com>
References: <20251110-av1d_stateful_v3-v7-0-9913a15339ce@oss.qualcomm.com>
In-Reply-To: <20251110-av1d_stateful_v3-v7-0-9913a15339ce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762795261; l=2542;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=qhbIdRggLRpMFNEU5UvyclByRdCjN29zV1MHtYRB1EY=;
 b=xOqrKV91ytxWmgJqtpfHpKoOWMa38A4VgDc7frjOF2yze69NXKkTlo37lp2Df6pyduvEQ2hQ9
 F4HrTDQ8TTABgIO5b4z//KijYvp2FEgjwmnmHiJBm1ULir6uf3L3kVd
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: Iu3on70MzxsSLa2dHih1fd1SWegSteXw
X-Authority-Analysis: v=2.4 cv=G6kR0tk5 c=1 sm=1 tr=0 ts=69121f03 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=5q8hE9cQKCNJD2usWYQA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: Iu3on70MzxsSLa2dHih1fd1SWegSteXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NiBTYWx0ZWRfX8nXxnWnwOsMf
 GmXFhh4d1Q31fmDcdp+j1D/J7HxUKuVjPVKrRoDuDHhjYFQLCe9ohTibtaMFOvV0e+2jg80AR5j
 0P1me3CU8/C1+LdpAO7mvONeGjdBecnMWv4e5Q5Dfh4cWOWoLkth0xhePrD75r60a48BQtJ9wbk
 RaDiLXsG/Pi2r0W+lJ9/g/Xf8Bj3yYcuwo8t7bE7axMA05ZOseLBkXZLDH2xWwT6TJuIARrvM+9
 csGQvwFkfHALSCtgKy6V3ISwttaxwB8GEtcBnOGGphhDaagEOBYyjc5h3fLCs8rkzcUhPHh1Bxe
 RbsbkzNLaug1Zr7YqWK2KHcu4d28L1bBAsyhKMlECsH3Fl2HuB3g1OHBOAPnboR8OQOZ8FuWlTX
 xuX0M8VlFXyOFKpwsh845RkP9alh/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100146

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
index c7efb0465db6480fe35be8557728c196e0e530f4..235f955d3cd5cfc83b0d3d424e6625b14c07266c 100644
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
+        temporal unit per buffer in OBU stream format.
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


