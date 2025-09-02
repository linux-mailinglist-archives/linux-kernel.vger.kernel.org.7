Return-Path: <linux-kernel+bounces-797439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7CB4107E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C377B04E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE72BE048;
	Tue,  2 Sep 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+r5uVgi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806B280A35
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854030; cv=none; b=DQBDQH7uH7by3apQYRqXLMZJOuH/C0touyuE/Tp6H/NVLjfQhF7jZFR2Mxv5QhUaCMia0hz7bs/FitD2MtG+TjHu7AGyFh+SqbYFkk2/pEFfncDPowFrohzzThCnUsnoBW56lnDBibltM1Gs3ZjiG5Q6eiP5miSbxCl6BprLYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854030; c=relaxed/simple;
	bh=9diWrH9N5RpjQbMIIxnIo3abYGeeRjuqJqXrS6LtQxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIOW5kQzh/foy/J2BT4UgQWCOHVtICJZvytS8gpusZWIaxNSeTg6Zp4z2tKsDXenG0O1y77L4GPsQdHmk00NNJcKk1vWTtEh0DLYfSD71wtAqD/W6tN9RrRFSWlEp5t0A9XEDM7VWxsQBwzSOxIF6vi7F16sZQVLAXCHAlGrHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+r5uVgi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqHrA004234
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 23:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CCw3ORap47qQKnFVauULRJUyOyxsuJlrDTo0PhDqr90=; b=S+r5uVgi8/MGFIe9
	aIX3D6umeEUtSwvA78zjyPJWOZEadCnC+CnZmRApeCKiwSeMAL8j61kPcEKryjpT
	MC+qYk80FqfCxrnIMF+9vWQyS9ZANYxnKf68rCZJ2bJzOcLyBzEkIjaxK9aNUjOq
	u2CRdSV/08uJQZmDZgc0c5WuQy2L4mKQSsJhH23noyBK3BuFnVg5rdWkHvPe0wBN
	3QDfOhmImmKgZ39IITDCkbqesU7bCOJJJXq7J+OqmABjmPScJnd7ADi+WK11apKP
	XRwjhRiraaxPMd1zpMFySX5/Dy3ZGp1YM1WpLpbHewciu5TVEDtvDyMGNRR+Wa0W
	MqafZQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjherm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:00:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32b5cb0809bso68111a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854026; x=1757458826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCw3ORap47qQKnFVauULRJUyOyxsuJlrDTo0PhDqr90=;
        b=D34rnujtGXMUkXi4GTBefVbsJiHxpWlj5UMQhhwc9zw4Vam0vMuF1BRnTTBTrvwnqx
         m5+In4M6905NyUUGHAJQ1kSA0rubZBBakX7wkvJ/AI78PhUWQl9kzcHV/8v+EJH2pAVr
         utn4Uya/utgpZ2ivXgbm/qO2GToSdfeb5VyvuGnAIhG0kvWkW/d5tp7uhkQnOL2yQ+qv
         f8ESGb8KD+HNJacIs+KUxZq1dsSpRlmI1zNYj3nlnWZGTqsbVHqDndMJ8d0ehpp1nNSJ
         gxjs24ESwbirwbOnAj8IQj0NsTt0iEXR1R8dhS/xceTf3DsTtOAULDVHGnTET1HrFVBw
         MPoA==
X-Forwarded-Encrypted: i=1; AJvYcCVguravjsV04uv+/N4Oouml69dlH4/tb38mNcYW0cJyA/FJ4Qrp76qM7wwtQvjKCM44QCUYax4Lw0RL0qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UtQ5OSKjTtnI2AMHzx1exxy4YSvg2BWVL+qn0/O2zvY4HBZC
	wLMBU3d+XxzzF4hz94a44DYqdkD3ZLBzUsZmfJl5vOWymfH9pFtjigzwRuviyKZ8SPj1t7eVdP4
	uCJ+bKnDwHZK7XH6FXZa3RwWiGWX6MpsuXMIThH+R9JUUHlROE8bdyagC2+cNQovPvWY=
X-Gm-Gg: ASbGncvlx+y92iHHVYTgNMqhJhtcmv8OKvsa9PE+HO27sQGPmxa9cR7SDQN8nhEUt5x
	K25oFVMncMFgjBHNonBXRlu03QpzBy7hdL0TSbrxXTw9XNJJTqm5YBmpkEB395i6qLl7tnDQGf2
	ta7CovswS2ZqgnenRf+5HgWNfWhJV4iIV2kFYSiPVOnlst3wfTo/p3DMEQ1pZ/9cc0cFGJz4pd9
	6fhhT1DZsXSNIZo7NCdGumaLjkivS/qGrZ52/xqRqGbcBgJIsGeaZZ1WJrPsxmTdWuHbl/XUyfe
	bhU4x60s8C/Dog1R4byNqSH0WT6nxUBI5a0gcr+n3ndiyU85/wtWLcPnzr4nNB90YmUF4wrcEjw
	DcFE8POeTf7q6U2avDmwW2OaR
X-Received: by 2002:a17:90b:1d92:b0:327:e34e:eb01 with SMTP id 98e67ed59e1d1-327f5b87d56mr11825701a91.1.1756854025181;
        Tue, 02 Sep 2025 16:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLbK9GKHTqv4TSKj+0jyilk7UGtNTf6q1jyKulxJ8Dmky8WNPadxdsp3LF7sbj7bo7YIDVMw==
X-Received: by 2002:a17:90b:1d92:b0:327:e34e:eb01 with SMTP id 98e67ed59e1d1-327f5b87d56mr11825665a91.1.1756854024340;
        Tue, 02 Sep 2025 16:00:24 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32a698ad4c1sm1875866a91.5.2025.09.02.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:00:24 -0700 (PDT)
From: DEEPA GUTHYAPPA MADIVALARA <deepa.madivalara@oss.qualcomm.com>
Date: Tue, 02 Sep 2025 16:00:03 -0700
Subject: [PATCH RFC 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rfc_split-v1-1-47307a70c061@oss.qualcomm.com>
References: <20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com>
In-Reply-To: <20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756854022; l=1406;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=9diWrH9N5RpjQbMIIxnIo3abYGeeRjuqJqXrS6LtQxo=;
 b=S/rVnIQnSXBlMIwhSoKVKh+SSJ4WhN7bPVyO4tyCvtJ4Azh5w/8zXTzmXk3tGKXHuL/BkdfTt
 y61Mczn9I3kA/7rjvUwC/91aBUTic5oT9aySCENvh2aFKeA0EjtrSJ7
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b7770b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=azbmn2n0SzSwlCbfrkoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: sn-rkpaE37cxKaEnfUC_IWLkH6aEXfhq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX+brBALHNxiq6
 IwEgd735Oy4965eiYAkYpIyQBj5NamRAEDQNIvSSlO+n8yYpCHy7jUWEVYwUA1aZESdI7jDeNao
 dtsXjmeoNwYKWlsq2KLkaO3GxMLYC+5apvCd5b2QuL/JIfEX7Jl3hHymMzsRgnDARqF+HQdY1qH
 ThwY0I/LLAdRrAed1NDL4pxpdKGuz13Ey/KGKg5SbahwbVIMQl8/JwM5lSYh6CsBGuTbjVZnBgt
 uh1OR5K4FaFZOdGk0GkxQy1OBbgx2ug3ZPEx5elxu60bNeNou5agBjPK6EAWt9mQAm7/yL3yhLj
 KmYjlsNJ09kPiQpilvdkvwGOyyF/hYqpyLF9IsZ/QE8J10+6wEbdQIf/CdA/D7NptFndjb1zHM5
 Z2XKK8Yl
X-Proofpoint-ORIG-GUID: sn-rkpaE37cxKaEnfUC_IWLkH6aEXfhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
Video4Linux2(V4L2) API. This format is intended for AV1
bitstreams in stateful decoding/encoding workflows.
The fourcc code 'AV10' is used to distinguish
this format from the existing V4L2_PIX_FMT_AV1_FRAME,
which is used for stateless AV1 decoder implementation.

Signed-off-by: DEEPA GUTHYAPPA MADIVALARA <deepa.madivalara@oss.qualcomm.com>
---
 include/uapi/linux/videodev2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3dd9fa45dde1066d52a68581625a39e7ec92c9b7..bff42a71c67b3f4b570dd6f3d250f1bb482ec8ae 100644
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


