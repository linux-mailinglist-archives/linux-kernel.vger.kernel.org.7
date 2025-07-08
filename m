Return-Path: <linux-kernel+bounces-722159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CDAFD606
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DC0585C14
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774252E92C5;
	Tue,  8 Jul 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAJ8n/Pe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283142E889F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997947; cv=none; b=b1hcQoBn/+1o8SvorrKZK4f3+71BkrbMDLl9mrMm7FwreMc9cxFJmi+9hmrLj65DNlBEzGs78u4PXvZ0g0GKy0WZFuro5bzx9abSiZfvoJ0FGJMPgrA5Se5gtqhwvDWYgh6We6yE7oR9ZY5Eqm7fj/DlQBmgeoGY+pEe2H873FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997947; c=relaxed/simple;
	bh=RPrPvvEpNn/ARuaVNHd+GcE7NgZFHqSh8tBOt5Jynz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJTl8DjN/oX5OjsyLLwZj+M0Cu49zTI4FFKBygvxgqcdIXd6vMkvKQPBq+6B6YPUCSfxHVrbdQ8w0PvpnNFWoMzwwxh5w+1sDFAFQrrwEhkxyRSs/6CWVLbo0lYQG1FMJ9vV2/aZORKCtpsvyE2MM9ud9oeydI3pDwbDNe2fJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAJ8n/Pe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOGq003433
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 18:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=r2hsmPxmoR8
	OiP5n8eICcy6+qgLvWLU8g7rv3qplVvA=; b=VAJ8n/PebHUOICgWaqXYRy1FrgO
	IifyNrEzjnMEJvLZsGp8doM4P5JjV2sMs2NDpLlnKR8TgPg5T9Xh/hFAZhOD6QTl
	qAtkRjfh2N+bGa57TUFJpzg0DcfCJHjqPLMwL6+s8Aks3Sl5NrGDCzWb3TYX23oM
	m9tJVkRW2Un5LiR7GATqAhaOIusPHRzqQw4ETwV3ta1cxmnMRGIvHrm33yEScAR6
	+Mp75q2SHFzZAJLlp4tYQrGD/WQEkjHr9NWLsp4PeElf6dk80R1eEstGXO9kXFnF
	4jx11rm5WlWDXq9e4QMbQymhcFJu0G3NrS0moYpZFh3Pdm8OVDz3yN5Etfw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefh2ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:05:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a7bba869dbso109386521cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997943; x=1752602743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2hsmPxmoR8OiP5n8eICcy6+qgLvWLU8g7rv3qplVvA=;
        b=CzmQgKUzickRNNQ+SLmcHDrmstcaHh4/L6u3alfXeB/ckyFzXLpj65CUuGpMHwBoZS
         TwDTfrdOoyFsRBRRcl/0L7TZLir1R5UBs/X32C+YsjRC0bHL1iYYuiSiUC1sHO8hCZsJ
         2635PXPpkvtHmlMTwHOjoZ1xx/TUTS+8SDHz84oqgRrk74U3Wr96Jn67cKglMMKsHesi
         BySOF/tD3rAJvVPmXh0M/HkLh4ah1v604z479xkZpOJBTd56usRKEWqGeWq2DburCklC
         dKwDMQePM4+N54DPNz7kBmPl/h3gxtsFdG3p7VnKeEZCTxfKOYPqEegdCLpf4e8+6V3m
         bTAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTHZWLZ9yJNv0sNzJVwxfqW/40zRfA4/TTUphImv7CkI6RBqqsAeuxNg4sz81LiEST1hjR/AyB0Z50EFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcj9XGYIkQbHldK13+JB4QpdfunfmjYVIu35CFW+yeYVNy3lEY
	l1PwnX/ZHii9eo3GMH+cDqNvvRU2S65+723Z+CM1WH6LspoeDqa/cIOwrTGtar3mpzm6Ap7yVqu
	NZy8ovZ2nnhZO/lCD+8QJTetBGWbbYHQjoQGi4aH72P/d+8+gXec6InCplBMMC/+d8XU=
X-Gm-Gg: ASbGncsgfoUemeeEOVUabNPBeXA7IL5hr/fTYVrvTSrObtQGKGo/7azWN50vBX9oaMD
	IUg+vJ/lHxiIj0R2K9f3k7v74hgK1gmhIH9HUC9W11VtU0V9KGbdQ9X+4a7CZNf1BE28YWdW6xY
	s2e1cKRyVwWy6Nms0yqH8XQgAWWHP8n1bIJtsBEuQvsgzQYxh/7E+9Qne3Zs0FXOgBRnMU0h5ZJ
	7wv720xeBrdg2RoCadiOAAM4sCnTkgdlMhrd5/bnoQns6FdEoczqfFkyduzlKeS6gWQH7mdrHer
	R6cYPOuJSeDYVDXivmnuB8yaJozP6cRHIBDtl0qkU9vpyXGvTW4xU9aNqYsUbwPAM+5E4uuW+A=
	=
X-Received: by 2002:a05:622a:134a:b0:4a6:f9e1:a84d with SMTP id d75a77b69052e-4a996441f05mr309754671cf.4.1751997942899;
        Tue, 08 Jul 2025 11:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv0wlk9nG2jOvTn6rDn/l/iOokos6fbGBQdNtNJ3P5l1AaP2KORuCAmzTIijEe2L0D1zba5w==
X-Received: by 2002:a05:622a:134a:b0:4a6:f9e1:a84d with SMTP id d75a77b69052e-4a996441f05mr309753541cf.4.1751997942139;
        Tue, 08 Jul 2025 11:05:42 -0700 (PDT)
Received: from trex.. (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0a5csm13394906f8f.29.2025.07.08.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:05:41 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/7] media: venus: hfi_plat_v4: Add capabilities for the 4XX lite core
Date: Tue,  8 Jul 2025 20:05:27 +0200
Message-Id: <20250708180530.1384330-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MSBTYWx0ZWRfX2v8tIvnYk4nR
 yrhgV51MKLzfQWgHFOXMVEpfFezfzy8XDSK+hhZI26MutewQbRgscITRpl8ns7uFcVp9EZ0darj
 7A/2M9pV3qC0zcK2NeeqBohOz2cfeh1tFufArXQqK7HS83vplrEa6QEZAOmDuXGRKqdiDZGiGOY
 hTOjruN2As3AmFFKnUrniMZ1Zg5BMgPt3LIQaRJW1KJClpoWo4CtgwoCIuo+Ugz3rjYpUQ1EJDr
 xeOTRoF3cvh3xzD5GR8OLqd7aRrXVgC6CjECXvO8iYPih68PQZpd7zIA6buhODjLeRalvhTDblb
 hUMEx3nrPwu4ZCVB7dsOl/NRlLfMnWhy8la280uzELJBlfTKoqDgf6IVH2Nu5A3aZm+p+7gl5iG
 spxXcKm1L2GFhRl7k936ZCOrq5XepLbsk7+CgtLNOm5GOQZBDZZfjlZrPY486j5RrwYFqA5s
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686d5df7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5l9M9ejOZEj2P9uvktAA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: WiyCRWtyrO1og5flzjp9qsWFz0jJP5aW
X-Proofpoint-ORIG-GUID: WiyCRWtyrO1og5flzjp9qsWFz0jJP5aW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080151

Populate the HFI v4 lite capability set used by the AR50_LITE video
core.

These capabilities define the supported codec formats and operational
limits specific to this streamlined VPU variant.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 .../platform/qcom/venus/hfi_platform_v4.c     | 165 +++++++++++++++---
 1 file changed, 145 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
index c8e0f8040649..4b7271468ec4 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform_v4.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
@@ -245,25 +245,149 @@ static const struct hfi_plat_caps caps[] = {
 	.num_fmts = 4,
 } };
 
+static const struct hfi_plat_caps caps_lite[] = {
+{
+	.codec = HFI_VIDEO_CODEC_H264,
+	.domain = VIDC_SESSION_TYPE_DEC,
+	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
+	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
+	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
+	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
+	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
+	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
+	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
+	.num_caps = 7,
+	.pl[0] = { HFI_H264_PROFILE_BASELINE, HFI_H264_LEVEL_5},
+	.pl[1] = {HFI_H264_PROFILE_MAIN, HFI_H264_LEVEL_5},
+	.pl[2] = {HFI_H264_PROFILE_HIGH, HFI_H264_LEVEL_5},
+	.pl[3] = {HFI_H264_PROFILE_CONSTRAINED_BASE, HFI_H264_LEVEL_5},
+	.pl[4] = {HFI_H264_PROFILE_CONSTRAINED_HIGH, HFI_H264_LEVEL_5},
+	.num_pl = 5,
+	.fmts[0] = {HFI_BUFFER_OUTPUT, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[1] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[2] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
+	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
+	.num_fmts = 4,
+}, {
+	.codec = HFI_VIDEO_CODEC_HEVC,
+	.domain = VIDC_SESSION_TYPE_DEC,
+	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
+	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
+	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
+	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
+	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
+	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
+	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
+	.num_caps = 7,
+	.pl[0] = {HFI_HEVC_PROFILE_MAIN, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0 << 28 },
+	.pl[1] = {HFI_HEVC_PROFILE_MAIN10, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0 << 28 },
+	.num_pl = 2,
+	.fmts[0] = {HFI_BUFFER_OUTPUT, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[1] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[2] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
+	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
+	.num_fmts = 4,
+}, {
+	.codec = HFI_VIDEO_CODEC_VP9,
+	.domain = VIDC_SESSION_TYPE_DEC,
+	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
+	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
+	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
+	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
+	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
+	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
+	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
+	.num_caps = 7,
+	.pl[0] = {HFI_VP9_PROFILE_P0, 200},
+	.pl[1] = {HFI_VP9_PROFILE_P2_10B, 200},
+	.num_pl = 2,
+	.fmts[0] = {HFI_BUFFER_OUTPUT, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[1] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[2] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
+	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
+	.num_fmts = 4,
+}, {
+	.codec = HFI_VIDEO_CODEC_H264,
+	.domain = VIDC_SESSION_TYPE_ENC,
+	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
+	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
+	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
+	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
+	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
+	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
+	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
+	.caps[7] = {HFI_CAPABILITY_HIER_P_NUM_ENH_LAYERS, 0, 6, 1},
+	.caps[8] = {HFI_CAPABILITY_ENC_LTR_COUNT, 0, 4, 1},
+	.caps[9] = {HFI_CAPABILITY_MBS_PER_SECOND_POWERSAVE, 0, 244800, 1},
+	.caps[10] = {HFI_CAPABILITY_I_FRAME_QP, 0, 51, 1},
+	.caps[11] = {HFI_CAPABILITY_P_FRAME_QP, 0, 51, 1},
+	.caps[12] = {HFI_CAPABILITY_B_FRAME_QP, 0, 51, 1},
+	.caps[13] = {HFI_CAPABILITY_SLICE_BYTE, 1, 10, 1},
+	.caps[14] = {HFI_CAPABILITY_SLICE_MB, 1, 10, 1},
+	.num_caps = 15,
+	.pl[0] = {HFI_H264_PROFILE_BASELINE, HFI_H264_LEVEL_5},
+	.pl[1] = {HFI_H264_PROFILE_MAIN, HFI_H264_LEVEL_5},
+	.pl[2] = {HFI_H264_PROFILE_HIGH, HFI_H264_LEVEL_5},
+	.pl[3] = {HFI_H264_PROFILE_CONSTRAINED_BASE, HFI_H264_LEVEL_5},
+	.pl[4] = {HFI_H264_PROFILE_CONSTRAINED_HIGH, HFI_H264_LEVEL_5},
+	.num_pl = 5,
+	.fmts[0] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12},
+	.fmts[1] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[2] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
+	.fmts[3] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_P010},
+	.num_fmts = 4,
+}, {
+	.codec = HFI_VIDEO_CODEC_HEVC,
+	.domain = VIDC_SESSION_TYPE_ENC,
+	.caps[0] = {HFI_CAPABILITY_FRAME_WIDTH, 128, 1920, 1},
+	.caps[1] = {HFI_CAPABILITY_FRAME_HEIGHT, 128, 1920, 1},
+	.caps[2] = {HFI_CAPABILITY_MBS_PER_FRAME, 64, 8160, 1},
+	.caps[3] = {HFI_CAPABILITY_BITRATE, 1, 60000000, 1 },
+	.caps[4] = {HFI_CAPABILITY_MBS_PER_SECOND, 64, 244800, 1},
+	.caps[5] = {HFI_CAPABILITY_FRAMERATE, 1, 120, 1},
+	.caps[6] = {HFI_CAPABILITY_MAX_VIDEOCORES, 0, 1, 1},
+	.caps[7] = {HFI_CAPABILITY_HIER_P_NUM_ENH_LAYERS, 0, 6, 1},
+	.caps[8] = {HFI_CAPABILITY_ENC_LTR_COUNT, 0, 4, 1},
+	.caps[9] = {HFI_CAPABILITY_MBS_PER_SECOND_POWERSAVE, 0, 244800, 1},
+	.caps[10] = {HFI_CAPABILITY_I_FRAME_QP, 0, 51, 1},
+	.caps[11] = {HFI_CAPABILITY_P_FRAME_QP, 0, 51, 1},
+	.caps[12] = {HFI_CAPABILITY_B_FRAME_QP, 0, 51, 1},
+	.caps[13] = {HFI_CAPABILITY_SLICE_BYTE, 1, 10, 1},
+	.caps[14] = {HFI_CAPABILITY_SLICE_MB, 1, 10, 1},
+	.num_caps = 15,
+	.pl[0] = {HFI_HEVC_PROFILE_MAIN, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0},
+	.pl[1] = {HFI_HEVC_PROFILE_MAIN10, HFI_HEVC_LEVEL_5 | HFI_HEVC_TIER_HIGH0},
+	.num_pl = 2,
+	.fmts[0] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12},
+	.fmts[1] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_NV12_UBWC},
+	.fmts[2] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
+	.fmts[3] = {HFI_BUFFER_INPUT, HFI_COLOR_FORMAT_P010},
+	.num_fmts = 4,
+} };
+
 static const struct hfi_plat_caps *get_capabilities(unsigned int *entries,
 						    bool lite)
 {
-	WARN_ON(lite);
+	*entries = lite ? ARRAY_SIZE(caps_lite) : ARRAY_SIZE(caps);
 
-	*entries = ARRAY_SIZE(caps);
-	return caps;
+	return lite ? caps_lite : caps;
 }
 
 static void get_codecs(u32 *enc_codecs, u32 *dec_codecs, u32 *count, bool lite)
 {
-	WARN_ON(lite);
-
-	*enc_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
-		      HFI_VIDEO_CODEC_VP8;
-	*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
-		      HFI_VIDEO_CODEC_VP8 | HFI_VIDEO_CODEC_VP9 |
-		      HFI_VIDEO_CODEC_MPEG2;
-	*count = 8;
+	if (lite) {
+		*enc_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC;
+		*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
+			      HFI_VIDEO_CODEC_VP9;
+		*count = 5;
+	} else {
+		*enc_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
+			      HFI_VIDEO_CODEC_VP8;
+		*dec_codecs = HFI_VIDEO_CODEC_H264 | HFI_VIDEO_CODEC_HEVC |
+			      HFI_VIDEO_CODEC_VP8 | HFI_VIDEO_CODEC_VP9 |
+			      HFI_VIDEO_CODEC_MPEG2;
+		*count = 8;
+	}
 }
 
 static const struct hfi_platform_codec_freq_data codec_freq_data[] =  {
@@ -277,14 +401,21 @@ static const struct hfi_platform_codec_freq_data codec_freq_data[] =  {
 	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10, 200 },
 };
 
+static const struct hfi_platform_codec_freq_data codec_freq_data_lite[] = {
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
+	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 440, 0, 440 },
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 0, 675 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 0, 675 },
+};
+
 static const struct hfi_platform_codec_freq_data *
 get_codec_freq_data(u32 session_type, u32 pixfmt, bool lite)
 {
 	unsigned int i, data_size = ARRAY_SIZE(codec_freq_data);
 	const struct hfi_platform_codec_freq_data *found = NULL;
-	const struct hfi_platform_codec_freq_data *data = codec_freq_data;
-
-	WARN_ON(lite);
+	const struct hfi_platform_codec_freq_data *data = lite ?
+					codec_freq_data_lite : codec_freq_data;
 
 	for (i = 0; i < data_size; i++) {
 		if (data[i].pixfmt == pixfmt && data[i].session_type == session_type) {
@@ -300,8 +431,6 @@ static unsigned long codec_vpp_freq(u32 session_type, u32 codec, bool lite)
 {
 	const struct hfi_platform_codec_freq_data *data;
 
-	WARN_ON(lite);
-
 	data = get_codec_freq_data(session_type, codec, lite);
 	if (data)
 		return data->vpp_freq;
@@ -313,8 +442,6 @@ static unsigned long codec_vsp_freq(u32 session_type, u32 codec, bool lite)
 {
 	const struct hfi_platform_codec_freq_data *data;
 
-	WARN_ON(lite);
-
 	data = get_codec_freq_data(session_type, codec, lite);
 	if (data)
 		return data->vsp_freq;
@@ -326,8 +453,6 @@ static unsigned long codec_lp_freq(u32 session_type, u32 codec, bool lite)
 {
 	const struct hfi_platform_codec_freq_data *data;
 
-	WARN_ON(lite);
-
 	data = get_codec_freq_data(session_type, codec, lite);
 	if (data)
 		return data->low_power_freq;
-- 
2.34.1


