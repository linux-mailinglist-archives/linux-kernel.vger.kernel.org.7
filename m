Return-Path: <linux-kernel+bounces-877645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D74C1EA89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C5A1882C63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE51334363;
	Thu, 30 Oct 2025 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BT69XzCc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MtV8mZtW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4942C11F4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807635; cv=none; b=myYsSmsXgDmsHZHNCMhCjhua1K9qh8mePyvxNT5Hr4IzALbSZ1NT4vV1V3ZP2PzCRER0lLVPmwOaxJab76+c3ns0UBtap+zgfLhtuafjlHNeKO0gNk6O83bpukYQ4O8hXiat/FzQXlcSEjLtNcWJHoatkUQxurwpKGTI/MlNIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807635; c=relaxed/simple;
	bh=GapKOE4+busiV714F9uFp5ab/JEw0dio+e1KPd8/k0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BTNqmrrzZLLvLUEadAf0V+ZygpVttfxKtNgVduXcaZ6aajHBh/JsOF7vYibbusU0CkG2HdtS/viaeU/C9BFsD0wr93OCMOHjENMLu7cRtVFJsrCWPqHdQN0osB6s3Gf9RR/UM4GVVxgK298GlUJvyZkt8J0Lg6j38fVSSx3MOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BT69XzCc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MtV8mZtW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TLH1oR1656060
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zmr4ABqTmT0fflvPe/g1GS
	ogr/M5FHC7W2ETmw+4eNI=; b=BT69XzCc7xbtHtKbVZgQuDkAXG1bUK//s1bO1t
	LoxxIeLbwzwl7nmvKMiklW+Q1QceGIlm80lSLll28Gi90S4xPzVezt3JFiTEISXT
	gx/9u/UFyEfW79dwCF1HAuS9LDrXScvNoWVvrEu/5Q9lO2YJnFrY5/NC/C1PuMSz
	yHlubqgrep7it6eLexj/HXiBWeNHBDgzQDMSNpLya6soVxF73q9oKxpxktHCJmQw
	XLZr3oZvVJyIlYYO5QBagUefu/PiVogGaTHl5RMdG8V/pYpSiWbDlsom0g98nvGX
	dneEhCfvAOAHpNrRmSR0CukYTCczdBlwpCfJx3Jw7JTcnbxw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptsc4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-293058097c4so1757235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761807625; x=1762412425; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zmr4ABqTmT0fflvPe/g1GSogr/M5FHC7W2ETmw+4eNI=;
        b=MtV8mZtWKKljyBI1pzVI7QRN7XpjryFbHdxqMxhzLrI3RRmsS7+q1vvUZ5lApYgNYA
         DrFjBYFtVPBdxq5GHE1A2gWbhdq0LfYsouAXnamNIlzgxue8xhX/R78TK1OgfHDPFJEj
         9LCPkeo7e9mJuYVN3EjU+3wVRM/wmOzi+tBBCdbGsJSz4nbivk3wQawGnsHHz6MjrWph
         41kZ7YLZJktMSOgAIPU4luzYZw/m+az3Mt9axxaG+V9kHO3JpvU9kzGNNv/1/Fnp2+Ld
         AhLAPEercqSwdQIEee3BAyGg7QBgMtHtBa9QMvD2AwDKbj9SGC1UfqCS/A+vukM58q30
         XZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807625; x=1762412425;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zmr4ABqTmT0fflvPe/g1GSogr/M5FHC7W2ETmw+4eNI=;
        b=HtRtI+tubm687Z0R0w38/Zlq9ny7UXYpYFRGbqkR/pSmSYixjjFRKVv9A84Ok5OEyw
         YToI0ZO4uWH2JnnWIUCWfOdLf4eCErJjVPnbcNGS12jcU0Ue5jaHhhltuSU6i1dq1OVP
         jDgQHJyoksoE/fUexMnAEe238TIlUmySJeD6UJmEC5/PgpHXwRo1MZehzqdu6ElwUu/o
         ZYvVnHG6TA3MqNcyEh1gPoZKi+OmIplTVV31N6/45eLKS48OyrnCFnWC3NQdY50ACmUa
         v9t7VsbOpemjD7VpW1E7msqaIQTUqz8HF8rSOYNiHwAJ3yZ8wsjw4HhsuQUhh0zIHKrw
         UlFw==
X-Forwarded-Encrypted: i=1; AJvYcCUSLVuWMNmpC6g3R4LoGD5FZmfGYBPFAkRGMpQ5rvJJ/vdcgJtzdxVN1WIaSn6eOTfWniaJd7Xrc1ejXmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVouQWtklywXwkXjkz5+z8kel+9taaBpa5kN+4aIQRYDaZ0x0z
	1yGHDCZ3CyHr1dQOVgpFjMCfiQ2O7lkLvwGGItG4G3hCph5qOjN4zRnNFBe6PbBy7oseiIpx8Y3
	5YFFkXaRa3xZbE2+pzYIhSJ6HyCowDbxjG3UqJuL5aM+twvCQBUEu/M/K4kuyVjSWdoM=
X-Gm-Gg: ASbGncuDMCiThBxPhkACoy7fkkTw8G5psJ5weIhk5nf8X9iWhmQieSzSt6JKAdOzkvY
	aWtzLfPGnncP1NqPDCx9GoTe8HRRs2G7Dmwm9ZFA5g6czoc5skpGoayd/tbJkaGBIRufXTpDYfw
	bJEk4/99r9SxFei3LMaa9qvcuHNN9zG5n3dAonp4soYDkc2JSS/CoC/IvVwb1bZ4MIZECQ/LBnj
	mq/+f3sp4jV/q0oWGtpJTuHX3Fk/b3CcaUlaqlrWF8HlJ5YIIoexV+1aQJlZczKS/o+VbRM7aBL
	ZlnVboY+KmIA+yC0e56lpipV5WTa7Q2hzDZqrBLqa4hRsXh2Psl+Y69sX1iUathxn4k6hNTzV2z
	53jyt4BKRrv11wr978pXUFSFZLNU20j5/hH+0DWGxPYpCeFb6a4lusNLNH4I=
X-Received: by 2002:a17:903:2f8d:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-294deeedda7mr38933885ad.7.1761807624780;
        Thu, 30 Oct 2025 00:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFxON84t/qbpslipPCnA9dvN0NK5l7PBdah00jerzc6zVXjQlMFnp0Q/202nkv4xeS+F98Vg==
X-Received: by 2002:a17:903:2f8d:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-294deeedda7mr38933315ad.7.1761807624017;
        Thu, 30 Oct 2025 00:00:24 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a73sm177671325ad.74.2025.10.30.00.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:00:23 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Subject: [PATCH v3 0/5] Enable support for AV1 stateful decoder
Date: Thu, 30 Oct 2025 00:00:05 -0700
Message-Id: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYMA2kC/0XMQW7DIBCF4atErDsSAzEYX6WKogFmWqTETsGml
 aLcvU6z6PJ/0vvuqnEt3NR0uKvKvbSyzHvYt4NKnzR/MJS8tzLaDKhNAOqYz22llWW7nLuFFCU
 IZ0TKSe23W2UpP3/k++nVlb+2XV5f4z88PVUdcIReMi9Qammwxe8EPFO8MIyeKTk5otBx6ubJR
 2oMableyzqhswH9aEPSzGRjFrbOaDFeHHoaBsneWW3U6fH4BfYjwlTqAAAA
X-Change-ID: 20251029-av1d_stateful_v3-cbf9fed11adc
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761807623; l=8380;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=GapKOE4+busiV714F9uFp5ab/JEw0dio+e1KPd8/k0c=;
 b=cbGJjSXSFdFxqeyrjIBOnvmadQVbRnj9MropCQ5BfM1R7vjg8+xJmYxyRDBzF1Oj7e9Ly4EFr
 yCTRQeFS//bDfrMEdNDEmWRT8ehF5THlZCNLKW81fwdy2vRv0lPh3Fu
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA1NSBTYWx0ZWRfX6xCEwa8Qo/+d
 o/hnSSYkZF09+hRsKKy589xd5OkUxbXoYkcu+aHesSTqjlgcAUcJhgJOB2wvSqJ59VuaYn1jetG
 8F1690ZlHztlkMovJ1ku4Tu7+wyuNKctVugvH0t8KvWGbj+vUz+VbSlwPav1GgCNv/HQTf1PEfw
 wyh9V5FyLXVxZNCcsd0SKgGVt0K8rYMjWeP+TJbVSrGJf3wGa7s2O5KYypSkklH7r3jYPzWC4PI
 Xrew2L715so2fpQfxEibm7dhpU2ZlVZ3SvJAO5NyoBev5IeiezpXqp6qUyaCXdnicUIL9wOcdjd
 q4eu3L1MiLVxSWuLOsD3TEFBRMb1iemla7Xz3zsPHOErgsHKzkQaWcL84fKDySp3PY1j6R5OpwP
 ATW3IpL77wK9N7XDIvkcn/3Q3Kc/uA==
X-Proofpoint-GUID: vxAkR1wh6lFCQTuwZSmzHcW3rfTxSbKd
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=69030d09 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=e5mUnYsNAAAA:8 a=rSFLfVtXdW1OZ3NksNsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: vxAkR1wh6lFCQTuwZSmzHcW3rfTxSbKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300055

Hi all,

This patch series adds initial support for the AV1 stateful decoder
codecs in iris decoder. Also it adds support for AV1 stateful decoder
in V4l2. The objective of this work is to extend the Iris decoder's
capabilities to handle AV1 format codec streams, including necessary
format handling and buffer management.

These patches also address the comments and feedback received from the
patches previously sent. I have made the necessary improvements
based on the community's suggestions.

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
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  94 ++++++-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  11 +-
 .../platform/qcom/iris/iris_hfi_gen2_response.c    |  22 ++
 drivers/media/platform/qcom/iris/iris_instance.h   |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |  15 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 156 ++++++++++-
 .../platform/qcom/iris/iris_platform_sm8250.c      |  17 ++
 drivers/media/platform/qcom/iris/iris_vdec.c       |  23 +-
 drivers/media/platform/qcom/iris/iris_vidc.c       |   1 +
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 297 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h | 116 ++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/uapi/linux/videodev2.h                     |   1 +
 17 files changed, 748 insertions(+), 28 deletions(-)
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


