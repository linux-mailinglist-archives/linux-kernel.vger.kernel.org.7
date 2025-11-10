Return-Path: <linux-kernel+bounces-892372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B9C44F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C6E4E359F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D772E8B66;
	Mon, 10 Nov 2025 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0vfPXfb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOUirTlp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7602E54B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751133; cv=none; b=mntMZ3jBJ+jH6BCJPdGTfgQ5rQcs5xR1rnVN22G7723/GuJ790aVTSyNdq9yKEx2Kb0pX7einr8RFIF7YkpQQ1uye3V9Fu+4kAcYIjGYOBIY9YVjwmpP9WiYR7wZyKeSYShF1k+ehuYlCIL8l1S/Ff53Q4gIkEU5Y5ZqrwUbJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751133; c=relaxed/simple;
	bh=ipOXdtGjKV0acIkxzAKMgIxcdIDcutwV8byhDh64ZE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YS+a4KVDp3WNXvS8l9Opjdh3BEiVw9xDwzoNj5/uu8UHutXK1r2ir1EUSNytXkHidxJy60g1FJ4NR88/1U9aXvw9eZG5tw3bhsDHRpw3oeHTOLFBTvq0Tg20aKHtPoL2TLP3v9NbH8ZyQC44GOTxa8BDJa4HmOFGfrnI7ZnEVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0vfPXfb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gOUirTlp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA3kgDF2548243
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MhBhkrgr4Lc7EC7NW8irJn
	njl+mTO/We/Jo1PtGaIzQ=; b=V0vfPXfbKprZ+DKQNpLK333Q0BgLNTIu3Dn2Db
	iGzLLitXNLPuwzuAatmNrQ14MiINHesY74Cp8LzJZsOMFncVHEO7edMTEYIpEVeC
	glAGyLZaXWixFfCQbmx/+4Dz1JwI/m91bR9EZnj7jO4haZbGGpMDJ+hx3sfyqFLU
	CDavsMiEHMUsiUDkevKvbcacuiLC9K2vmKxTnh+c2L6jun3qp1T414K8nD9eTnV2
	L5dQA0uN8w6ziuc/QOBs9d9xlCBS0mXEDVZuNIjILbneESPbux1kFlmeu8dWLjhG
	GeGrXur3wNRdEM7lanRYWt7GXEyTxEO1eopcyP4F2WI74u+Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea84md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:05:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3437062e4eeso669685a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762751129; x=1763355929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhBhkrgr4Lc7EC7NW8irJnnjl+mTO/We/Jo1PtGaIzQ=;
        b=gOUirTlp+wSTgqlBthhLaIKizpFp2kGOT7MfAOxflHSXK+9Ob4pCk3mUIwVlK3MOOv
         aziV/wcUEEIu79mtmQSGRcQANGR4zXt8mzUFaONGIjo/XjXLveXi9hM8w3Dgo4vE0JnN
         TZ7jSDMXJuqzvhksQTm76K6QhG2XzrTVGz3kY+Dn3RpUjeS04s8VaXCGZhW9dVjPgfWk
         ifEIMGcJVyxnG33sOPkjBinN4+y0qzMey1c3elE7StfXkd5WGQ/AccmnoTPGJy/HTKBY
         /b9PPD8QbQRODh1IhBLbwwgFhHYVS46C4TRcJdyHfrZLjv7gd85ds1ZR6LifqYIjyfzx
         De5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751129; x=1763355929;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhBhkrgr4Lc7EC7NW8irJnnjl+mTO/We/Jo1PtGaIzQ=;
        b=uIO5ZZkN+JLPeJCe7KodvZVVq/XwcX54slfJfpIfSfA9FS32Ra2KoYHuMEQsMMC4wx
         wWO5oYLy6goy51mfrGR+XRawBH7A4KBzMlavOrpZbCAcC2VP8vF9LyP8IjY+h6KGn04E
         fnv+T3N73X5BL+AXA5MFDFAeZcMuf8QSWzOEJF0Zxgeau6iRG1ZXzMcHtMXddw4JKMuA
         WiLhMat5DiO+vSJ//gkI66bTV1wXpGcyz/ARPDsO9BJ66A5OA5k0aKSl2lKFwaEZECY8
         lDEcpvqd4AY0vsoaif2tYIJhrjlBIPyjrgUP/DxDK5frjWgqFWsuJh6l4+9dogpPQmHW
         8K8A==
X-Forwarded-Encrypted: i=1; AJvYcCVyJP680naNTeypQEHPC3Fk7UnuOUCNY0Qa7M6z9rrHshwQhOsWL8d9Fk963sre/F7kc9VoxvuGRbwRxTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8s+Xxc5n3r/lri/raFNOef2JQ02DaUBnW+6Q8+I8jXQI78co+
	S+4JokBk1HrE/lBQLkF21LHAGGCL0SbBELf7Yg9nhZc7iaBXUdHqNzm12GtzWfo6bCk9AIXkOel
	T0cQWfRP2lNIYT2LH1K5YXZH8mmZ2fom9AzVRze67wT+i/hqmqs6YI6xt2KASjzdx/YI=
X-Gm-Gg: ASbGnctDmB21pA2gZUqZ9RCy3PV24jtNX+Dp8Ghob/umMlZIF8XYglOcLmiXPJiSHN5
	uKGtOg5lM5t8p5k8s3I7BFRET9d+GJcn/O5zsJRm2ZGuWpTFCCiG0yXqkEbys4ZYhzxc4IjkOev
	2efwPr8HKVOdB5zZW+EXrP9Y09EaBeCjb+NYaILetEkeSEb85ZDj7UlGCi3r1OQkS53gMC0qyVZ
	qk/mBsKbDnfpgZ6JFAA0RlkoTrRPghC4DGxnWb0yQOfb9sNCPKwRKe2aPlSgC81KPMY+HNlZnFM
	d3fCEhrYLEWpEpRR1wvFOvh4k3BR431M5Ik9pDmy5iBWHgSe8rsFkAUwPx/mUGcR8NTQuMiCyJf
	TDwF6ypiNKIOEFk4HjJ2eKDP/9FrJF4NZR6phKScSyavEa+/+S0/+6B1NLCU=
X-Received: by 2002:a17:90b:384a:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-3436cd1323dmr4792857a91.6.1762751128975;
        Sun, 09 Nov 2025 21:05:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkI+4af/OXKUKx0lkMAfRrMvjPn24pV4cLuozmpJRlnO1Foou5+gfniBoNVoq4hjg++jeb9g==
X-Received: by 2002:a17:90b:384a:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-3436cd1323dmr4792825a91.6.1762751128409;
        Sun, 09 Nov 2025 21:05:28 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343705c1354sm5913748a91.18.2025.11.09.21.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:05:28 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Subject: [PATCH v6 0/5] Enable support for AV1 stateful decoder
Date: Sun, 09 Nov 2025 21:05:14 -0800
Message-Id: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItyEWkC/3XPy2rDMBAF0F8JWldBo5cfq/5HKWEsjRpBEieWr
 baE/Htle5FCXRCCO6CjuXeWaIiUWLu7s4FyTLG/lGBfdswd8fJBPPqSmRTSgJANxwz+kEYcKUy
 nQ1bcdaEJ5AHQO1aeXQcK8Wsh397XPNBtKvK4Dp9wO6uigZrn6KnncYiJT92n43TB7kS8rgidD
 RoC6jbLme8wEXf9+RzHFqxqoKpV4wQRqs4HUlaKIKtgoUJjgq+sEpLNexxjGvvhe2ma1bLIWkq
 Jv6XKKVOAWnsyMjj92qe0v014mr/el2sxs346BdpwdHGUcg4IsVZB/uOY30614ZjZMWCN7FA3z
 m84j8fjB1zK45nPAQAA
X-Change-ID: 20251029-av1d_stateful_v3-cbf9fed11adc
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762751127; l=8937;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=ipOXdtGjKV0acIkxzAKMgIxcdIDcutwV8byhDh64ZE4=;
 b=sJ2rpXsmm1XUqLXK6u/h2nGeS8aaX+uGZGd4XSDxINDvw+0PfFnBpQR6zoovvYYy0E3AqJN95
 ELBxpGsQdeJBfss6NiJjTUdRKLrEg8qSu9w9wQy98h5fk/sVUyl66/V
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: oFOhcTHr2xzmOiS1h23aLyJzwQbpZgsl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA0MSBTYWx0ZWRfX+2k3j1fjVrWm
 b5P0Di4tq0P++byLZ/74aDpzyGWfboHwBlonqDTdn5SczsU8DheWyYM5RQcUVwHS80PWvLBXJsc
 sgBjy8QVQLUNPj+h5XV5Y2DDiKURQBRcVZVJpP7pSOSQSWa3eL2cY88WVMnpEYUTS1cJdwDfy/x
 R4ZuL+vq5XIA8n82sKF96ikcDyCmubPPCZOpMylUs20iQR8vVrR2VOaTq/pYFUmQOG8+CVjpz+C
 20bibbkKY6/7qhEAetfObnjJoe+T4xXEOxoBj6wTaRqtdNMlt4bStxvFPPn45CkVr8dvcYgg7ja
 c8XsaeoopFXoaxVgQB74AlvG0URquYa0uIRsMo9H9Dgq/IR0qTXOAj6v3BoH8rDDmST0WMOjm+D
 O9BnanKV68gOs+Zt67yrGct3t6OIJA==
X-Proofpoint-ORIG-GUID: oFOhcTHr2xzmOiS1h23aLyJzwQbpZgsl
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=6911729a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=e5mUnYsNAAAA:8 a=rSFLfVtXdW1OZ3NksNsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100041

Hi all,

This patch series adds initial support for the AV1 stateful decoder
codecs in iris decoder. Also it adds support for AV1 stateful decoder
in V4l2. The objective of this work is to extend the Iris decoder's
capabilities to handle AV1 format codec streams, including necessary
format handling and buffer management.

These patches also address the comments and feedback received from the
patches previously sent. I have made the necessary improvements
based on the community's suggestions.

Changes in v6:
- Fix for kernel test robot failure
- Link to v5:
  https://lore.kernel.org/r/20251107-av1d_stateful_v3-v5-0-351652ba49cd@oss.qualcomm.com

Changes in v5:
- Updated Documentation (Hans, Nicolas)
- Link to v4:
  https://lore.kernel.org/r/20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com

Changes in v4:
- Reuse sm8550_vdec_output_config_params (Dikshita)
- Add definition for 256 (Bryan)
- Fix identation (Bryan)
- Link to v3:
  https://lore.kernel.org/r/20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com

Changes in v3:
- Updated fourcc could be to match the ISO specification (Nicolas)
- Addressed comments and rebased changes to resolve potential merge
  conflicts (Dikshita)
- Updated GST MR
- Link to v2:
  https://lore.kernel.org/r/20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com

Changes in v2:
- Updated documentation to target AV1 codec, not just AV1 decoder
  (Nicolas)
- Updated description for V4L2_PIX_FMT_AV1 (Nicolas)
- Simplified buffer calculations and replaced numbers with relevant
  enums (Bryan, Nicolas)
- Improved commit text for patch 5/5
- Fix for kernel test robot failure
  Reported-by: kernel test robot <lkp@intel.com>
  Closes:
  https://lore.kernel.org/oe-kbuild-all/202510021620.4BVCZwgf-lkp@intel.com/
- Link to v1:
  https://lore.kernel.org/r/20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com

Changes since RFC:
- Addressed CRC issues seen during fluster testing which
  are fixed with firmware fix [1]
- Added Documentation for AV1 stateful uapi [Nicholas]
- Resolved issues reported by static tool analyzers
- RFC:
  https://lore.kernel.org/linux-media/20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com/

[1]:
https://lore.kernel.org/linux-firmware/ff27f712-a96e-4fa6-7572-a0091537d8ac@oss.qualcomm.com/

These patches are tested on SM8550 for AV1 decoder while
ensuring other codecs are not affected.

Gstreamer testing:
Gstreamer MR for enabling AV1 stateful decoder:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9892

Fluster testing:
Test suite: AV1-TEST-VECTORS
The result of fluster test on SM8550:
135/242 testcases passed while testing AV1-TEST-VECTORS with
GStreamer-AV1-V4L2-Gst1.0

failing tests:
unsupported content with bitdepth 10 (66 tests)
Iris decoder supports only 8bit NV12
av1-1-b10-00-quantizer-*

Unsupported resolution (36 tests).
Iris hardware decoder supports min resolution of 96x96
av1-1-b8-01-size-*

Unsupported colorformat (1 test)
av1-1-b8-24-monochrome

Unsupported SVC tests (2tests)
av1-1-b8-22-svc-L2T1
av1-1-b8-22-svc-L2T2

Bitstream corruption issue: (2tests)
av1-1-b8-03-sizeup
av1-1-b8-03-sizedown

Testsuite: CHROMIUM-8bit-AV1-TEST-VECTORS
13/13 testcases passed while testing CHROMIUM-8bit-AV1-TEST-VECTORS with
GStreamer-AV1-V4L2-Gst1.0

Following the RFC feedback, focused on only IVF/MKV content
as AV1 parser lacks support for below content
AV1-ARGON-PROFILE0-CORE-ANNEX-B
AV1-ARGON-PROFILE0-NON-ANNEX-B
AV1-ARGON-PROFILE0-NON-ANNEX-B

Unsupported test suites:
Iris Decoder supports only PROFILE0/V4L2_MPEG_VIDEO_AV1_PROFILE_MAIN
and 8 bit, 420 only
AV1-ARGON-PROFILE1-CORE-ANNEX-B
AV1-ARGON-PROFILE1-NON-ANNEX-B
AV1-ARGON-PROFILE1-STRESS-ANNEX-B
AV1-ARGON-PROFILE2-CORE-ANNEX-B
AV1-ARGON-PROFILE2-NON-ANNEX-B
AV1-ARGON-PROFILE2-STRESS-ANNEX-B
CHROMIUM-10bit-AV1-TEST-VECTORS

Compliance test for iris_driver device /dev/video0:

Driver Info:
		Driver name      : iris_driver
		Card type        : Iris Decoder
		Bus info         : platform:aa00000.video-codec
		Driver version   : 6.17.0
		Capabilities     : 0x84204000
				Video Memory-to-Memory Multiplanar
				Streaming
				Extended Pix Format
				Device Capabilities
		Device Caps      : 0x04204000
				Video Memory-to-Memory Multiplanar
				Streaming
				Extended Pix Format
		Detected Stateful Decoder

Required ioctls:
		test VIDIOC_QUERYCAP: OK
		test invalid ioctls: OK

Allow for multiple opens:
		test second /dev/video0 open: OK
		test VIDIOC_QUERYCAP: OK
		test VIDIOC_G/S_PRIORITY: OK
		test for unlimited opens: OK

Debug ioctls:
		test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
		test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
		test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not
Supported)
		test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
		test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
		test VIDIOC_ENUMAUDIO: OK (Not Supported)
		test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
		test VIDIOC_G/S_AUDIO: OK (Not Supported)
		Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
		test VIDIOC_G/S_MODULATOR: OK (Not Supported)
		test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
		test VIDIOC_ENUMAUDOUT: OK (Not Supported)
		test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
		test VIDIOC_G/S_AUDOUT: OK (Not Supported)
		Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
		test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
		test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not
Supported)
		test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
		test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
		test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
		test VIDIOC_QUERYCTRL: OK
		test VIDIOC_G/S_CTRL: OK
		test VIDIOC_G/S/TRY_EXT_CTRLS: OK
		test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
		test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
		Standard Controls: 12 Private Controls: 0

Format ioctls:
		test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
		test VIDIOC_G/S_PARM: OK (Not Supported)
		test VIDIOC_G_FBUF: OK (Not Supported)
		test VIDIOC_G_FMT: OK
		test VIDIOC_TRY_FMT: OK
		test VIDIOC_S_FMT: OK
		test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
		test Cropping: OK
		test Composing: OK
		test Scaling: OK (Not Supported)

Codec ioctls:
		test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
		test VIDIOC_G_ENC_INDEX: OK (Not Supported)
		test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
		test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
		test CREATE_BUFS maximum buffers: OK
		test VIDIOC_REMOVE_BUFS: OK
		test VIDIOC_EXPBUF: OK
		test Requests: OK (Not Supported)
		test blocking wait: OK

Total for iris_driver device /dev/video0: 48, Succeeded: 48, Failed: 0,
Warnings: 0

Thanks,
Deepa

Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
Deepa Guthyappa Madivalara (5):
      media: uapi: videodev2: Add support for AV1 stateful decoder
      media: v4l2: Add description for V4L2_PIX_FMT_AV1 in v4l_fill_fmtdesc()
      media: iris: Add support for AV1 format in iris decoder
      media: iris: Define AV1-specific platform capabilities and properties
      media: iris: Add internal buffer calculation for AV1 decoder

 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   8 +
 drivers/media/platform/qcom/iris/iris_buffer.h     |   2 +
 drivers/media/platform/qcom/iris/iris_ctrls.c      |   8 +
 drivers/media/platform/qcom/iris/iris_hfi_common.h |   3 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  85 +++++-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  11 +-
 .../platform/qcom/iris/iris_hfi_gen2_response.c    |  22 ++
 drivers/media/platform/qcom/iris/iris_instance.h   |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |  13 +
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 142 +++++++++-
 .../platform/qcom/iris/iris_platform_sm8250.c      |  18 ++
 drivers/media/platform/qcom/iris/iris_vdec.c       |  23 +-
 drivers/media/platform/qcom/iris/iris_vidc.c       |   1 +
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 299 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h | 116 ++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/uapi/linux/videodev2.h                     |   1 +
 17 files changed, 727 insertions(+), 27 deletions(-)
---
base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
change-id: 20251029-av1d_stateful_v3-cbf9fed11adc
prerequisite-change-id:20250918-video-iris-ubwc-enable-87eac6f41fa4:v2
prerequisite-patch-id: 11fd97eabf65d22120ff89985be5510599eb4159
prerequisite-patch-id: aea5a497f31db23a05424fe2cddedec613571f2a
prerequisite-patch-id: e3b10c34426c33432208e120a3e1239630893d88

Best regards,
-- 
Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>


