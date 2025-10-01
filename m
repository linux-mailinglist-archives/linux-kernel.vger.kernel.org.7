Return-Path: <linux-kernel+bounces-839396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDDBB18C2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A7D19C0E28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6CA2F1FE9;
	Wed,  1 Oct 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dITpJMdS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3A2D373E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345221; cv=none; b=NGg7Y1g1ChQyF1WTuDSaxtLIXsT7IguUq9rwcWJY3rZSggJb0Q24u9gSh/YPRUueR23PjGA0RiVMuk0i+wRQRJ41naN0Xf5NRHSwg+t/4NSgh1IC0JFIEywj6nbnheI4oCMNi86qM4yxX6mmkJtXf7OhBbWT9VAErJHVf1OcfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345221; c=relaxed/simple;
	bh=/rm1Y/tRBwPrsxYpaC+lx0uQgFufvlrB5k6kOnop6/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVSQWJiOH95yvHGJocunK1bQjjORvnIWE5v7xw2wYIgoaQN0ktFxq4wZIa2xODrl98NRouyLFIHL3bwOfg9BHTBHFhBCvOdeyZvEUi7eaiLBUoxV+PhDvmplN+5Ml09bdlpyjmkvbmgr3lsxp7M7lPYU0cvw5ZKRLHpmGQeFV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dITpJMdS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbtRB023326
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 19:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UOM6pErh4JXh+pgCFCh1VyiU3BioiWvX5lWpX48wx/M=; b=dITpJMdSXPG1KLvF
	q8Aq2T4ihnWDcO2QZN7Pv+lDrEqr64Wr/kK0fPhXn7FqgLRSt5ToxbkNIxkm0xO0
	jBu0Nw2QwJ5htDTZR0eFHwG0mQsxrYxSDacMqv0P9EzWTdb4WG8g9NnMMXdfxQrk
	Gl1UJ4ySBSYcufajwu87fzFgKxDa3S1ppbmnZE5FnrrfGJO0bXFYVbSE0tCoJA4z
	E6WLIBFTCdS+MkzQbOCwBBtzOUSYs1rHe4bIokDt11NDd2oa8kJ2PE8VZyAmwOk/
	+nR8a2wxS4CTImQYIKc3jv6IvDM1JJgr3Bc4Yt/lQ0hHa6b3BfYqWfx30Ud7wl6g
	f3jMEg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a65n4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:00:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3306bae2119so86997a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759345212; x=1759950012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOM6pErh4JXh+pgCFCh1VyiU3BioiWvX5lWpX48wx/M=;
        b=MrkhzgMRdbL35cBC4RuD10NuNdXiN68l1uFX534FbdOhkGd+I1bUyrqQ1Fi7sy9PK+
         YJAf+UkBejUISi0lOsWFEJgoTZDQB0nXYPe5LOrty4TwZD1Y5I/BcaLWUFCoZ/6/V/h8
         9czO8aUGqy2mefYi236qnYsH0lXUO6vf7Ris5Pw/AcHPt2YXl5gbpCU5ztTLcOOajuZ+
         xyEbS0v6Kjs9E05AKSc+MgJ4HGfcSqcoFP+XL3fkYW9l3pDcapL8+8KNAGdeuoOO/8Zp
         R184l9d2/RKrta0mah53M1ji9QBh9WKkMuKELjWbqBSmfpbi4UEWYQBJvGm/ygDZfJIu
         6ZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtAwstFwRypFHSPFHMB5ad85fhax+YGGP3bVzTg5A3N7B0FcPgs6p2Yw9nAxOmIcCrbxkIaQl6nHW78B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzemoUXKgrwBlegdATYID3dkgCqIdLnkla9REBt4sDimvShSPMn
	Lgz5TOW1BMWvZbVzgcAu/m+axudanWCFvJT2zypio1KBBBapqsFyR0trhs6jjYGZ+IiYjSg0H75
	ju1LyzFoCqY78wMx75HuqjQxR5bg6yugDFsCTGunuctoQxuGJhqWz03ulPeklgfe49iQ=
X-Gm-Gg: ASbGncthG2+62db/eTl41gaBAB7m1xWDdtq2i7M9Knr2wgdsRxNBVx9DHrb95CkLrKL
	RjOPgenOmO1I9BPvHMrCUTOL8dbpVc8GaJ28m5bgpBPfxhXJ9d1bjTX6XFuMCVXk3Q0F+rFqPwd
	IelVGu4wO7nQyxAatKe+5LVRfB2180Qb9ePl6v89U3bJiFDO6aBgoWeHYyrG6o8poh+6clSQ7ZQ
	H8rwqFBHB5zLEr/vGqDDZtEvYdzZ9NYM6HlYbdKw2N3kteRq0WoGphJoBpX8tth3qQTFk2Yw4w+
	YLRGI4L5UWAYp4NgLE1pjfKmE1t4jS57P07smdxgeh3v4G+S4z97WhIglGhuecI/KG753Sk3CoI
	rqbu+BLvCZuYrFcjZmS6+F8mUfDsWFA==
X-Received: by 2002:a17:90b:224c:b0:32e:74b6:4ef9 with SMTP id 98e67ed59e1d1-339a6d425ffmr2697913a91.0.1759345211624;
        Wed, 01 Oct 2025 12:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOya6qECNpJ/6SMsAf6t/f1E24fDwdtbmQv0sCvjkybfOLZCjjsyzeop/XkBa+HD2orVE21w==
X-Received: by 2002:a17:90b:224c:b0:32e:74b6:4ef9 with SMTP id 98e67ed59e1d1-339a6d425ffmr2697884a91.0.1759345211040;
        Wed, 01 Oct 2025 12:00:11 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701cbffsm2950074a91.21.2025.10.01.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:00:10 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Wed, 01 Oct 2025 12:00:04 -0700
Subject: [PATCH 1/5] media: uapi: videodev2: Add support for AV1 stateful
 decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-av1_irisdecoder-v1-1-9fb08f3b96a0@oss.qualcomm.com>
References: <20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com>
In-Reply-To: <20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759345209; l=2422;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=/rm1Y/tRBwPrsxYpaC+lx0uQgFufvlrB5k6kOnop6/c=;
 b=FwUQJyOxBbml7pw9V/Ys5GVnoZdTtkEyEOGQk0Uuq8AhzLh7ZnUQ5p4zFEGKUJILkfwMAb4Lm
 bPdsvL/RRqFBI5PUHQph+15o9hqW8aKW9BXY7qK3FLFXygM3XQpCLrx
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dd7a41 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=5q8hE9cQKCNJD2usWYQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 9fm8WtVkoGqZ8un4A13wNFS0PGIayWMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX3jequXbLitlg
 WfKjcjzUPtQ1AleiaP2TkVfVvJXzrFqkNLWg9XlGuB3q5M+aDQRtHtyeVmjLvPBVSkhQ4JNu4Rn
 pTR4acOxmJpF1qBCxBvJIMlL49RKcprZ6rCIp25AtcqN6qD6LSIKNEzaMWhFcxdutpkikN7pyi8
 Yw7Q/NQw/NoxOGffM7cLIo4pss9c233DsGTzcqWF/p4a2PolH2iqfyb+FvN/N4rrrm9zHZmtOIh
 Lq0HdJajEe4R2rU+KOwEbTRGOdiavc2t2KMe9dDDiVPj2ZZvYEM+5MpyQRIViv5uy57Rx93QCGf
 /OiDDfEkfQasp+4BEtk5asiYHJpFnM7ekDQzZ6np8WS2jYh4Ctjhet8zTPp20xcCCkrq56P9kOr
 /QGbqRJNZZlj1V8F45c67glBKk5bGg==
X-Proofpoint-ORIG-GUID: 9fm8WtVkoGqZ8un4A13wNFS0PGIayWMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

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
index 806ed73ac474ce0e6df00f902850db9fd0db240e..043ec57d7d48a36005f2a0121a5bc7b733d06590 100644
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
+        pipeline as stateful video decoder. The decoder expects one Temporal
+        Unit per buffer from OBU-stream or AnnexB.
+        The encoder generates one Temporal Unit per buffer.
 .. raw:: latex
 
     \normalsize
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..4c07ad6afd45d6a56d19d65fd25f091d81725823 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -775,6 +775,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
+#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 (stateful) */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
 #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
 #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */

-- 
2.34.1


