Return-Path: <linux-kernel+bounces-796707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC565B4062E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790F35666F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392B30DEC0;
	Tue,  2 Sep 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BynYITuI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4933043AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821679; cv=none; b=FhUyMRME0RcHeoYQhtNUL5zQcfBET/ihJZIWihSC9Y7LTMUoyqE331rhnQUregoIap4D+h74paLZIHyhTbzAJQBQhOi32upbH4VjUO3NRwu0QJ/KC2njPQLok++AInzEPcMlQDAnWlNkPNKIOAd9jHGw4rYAs/jP+yYbTfquwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821679; c=relaxed/simple;
	bh=ZCmYtXeOLiKF/8J7Ii2M8E18kXf+ruqiaITuaaqiq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK8xufvzZI9HfjV9WcwCEqTbU/6eigffu4llUddX5z8Wj6i7tmxA2yNb48fdwlcY4zmoH8pRfnNNaWn/bCamTVj8jiiQZUXrboGPAfCTgvPvmdvUECye9CNhg2QpyxP8++z8A6lU+ycXMCwR17AdSiiL3Jpy88XLkU3/p2UdYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BynYITuI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Aqqbu021885
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nmnJ45KeZoK
	mJHcfZsLs3+FV2VWNH0u9h4uDyk73m/k=; b=BynYITuIn6Os+8yQvZhtg4mBQ/a
	A4omgyulKqSCPbtJe2nWNr1z3Mm6yq/gpH38zH3qdxRFp8zY8aNOeQ3Uzinb+pZR
	ggccV3RLlJqmqC3YGhyAOo8Z0VLjE3CslNzCxWMOxHhPDtZfKrHZen6qZjj2bqjn
	ditn50QZJ+HdYsIbUprUIaTqvWwq8lKDz73iCKWXnsUIYFY5vDsV79hg8Iw4/87Z
	xHPMmTcvXV1SC8QkBnOaXAAjN/FT3x2JntCM+8nDt4x6FvH9H5k3hX0qHnlqqadD
	btS2kQgOtTIyooiia4GeE290vr81maV9ZgqoeaXKRd2Wuh49uhykaZabkwA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s03uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:01:13 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7454aed7eb9so1946793a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821671; x=1757426471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmnJ45KeZoKmJHcfZsLs3+FV2VWNH0u9h4uDyk73m/k=;
        b=rmzBUmgXLdOVziXZ2nXcA0s9z/j2aCMCsZj7nFw/M5JC/AkmlaVTKr2g+eFniLfDx0
         3mOmKLkrhV/5FbEzmRi29IR/7mMuhoKeX9SwAN959SZFN+sILyF0o9eoIxKUEQziOQIC
         Tn8p+3+WxDE0VKnsJJ4Kr37NV7viMPM3TC8B3ojt7c61f0HMJLLF0/NcyMkhBefXDSQt
         x4rY8T+1UX9FYBa8c60NclNCVGjBK34t93QciM5J4o0SfRLUeMoWsiTJURiMmRiwGWxw
         WNE+u6Z3jsq5YtGFk2sHfhKq89qTAv5caraSASlU5E3FGNxY0U6IodFqBgyOTCrgWUve
         0GRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFIyS/bh4UA5OcCD9Db+nyHqSS39r7xJxmwl+dFcEEcnM8zTHYd4pX4ATuTcp7uTlQp1Lo2cwmQPP4iYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWCWSTMQY2QbethFTm2nCVkylperBdlOPOROI7Jjp8LgczcQK
	ykJjQpMFHwyd6i3szLO3IWafwC6bDZr87O0RNBIugJ1x9obeOnXGW5L6ngMhmPDVjdEbrF/nFdd
	tdt68hzyPxiOqpkb8rLQKnMSJ/CDEGPev9PAo5nfPY6vQJPf+CRQRF24aRgUWJFr6g1Q=
X-Gm-Gg: ASbGnctC6Z5RSwjxQlqAAuFqcZLyJw11RNc7ao9qo3D/JGRLA6pP+Hqv+EUFdqGiWbR
	G7Kfu/tyo2qw5Ns9J9zJKcEOV1vfei5aZ75/iOESJmtMnWPmtSBcSmRFyDEa/+sdyfGNy/70Cri
	DzVdTeyYWqx5H9ScbL0VPhjOco+qld2Kew0e0CjNXS0hVFwK+kI6s+knYBDmkG6EYNiVKUSdzpn
	apMJDclWhrBAplGtYXKXSHsRCEHrzqTnTh3sjgsRA34yG5J1GR/pIWJeoqV4bTo6j8k48HaXEdK
	Yn1ORpsXHJAWzd20TN67Axm4eToosgEyIym+93ZLW7aOPROOdnE8MA==
X-Received: by 2002:a05:6830:630e:b0:744:f08d:15fc with SMTP id 46e09a7af769-74569ecf0fcmr6903321a34.34.1756821670766;
        Tue, 02 Sep 2025 07:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMw9YT5rkoNZ22kEloWpSq9TQIAdQv5X+Iy54NEzqWo60ZTF+TAlJf3AXt2PwZZsGYu12l/g==
X-Received: by 2002:a05:6830:630e:b0:744:f08d:15fc with SMTP id 46e09a7af769-74569ecf0fcmr6902363a34.34.1756821662010;
        Tue, 02 Sep 2025 07:01:02 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:01:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 5/6] ASoC: codecs: lpass-macro: add Codec version 2.9
Date: Tue,  2 Sep 2025 15:00:43 +0100
Message-ID: <20250902140044.54508-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5H1C8VkXv12K9n3loB6iN94dPheikerD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX7Fg+H2VajgBW
 CTzO4xZvZrpy054wglzX63pkGNmvccKna1JZ0rqZYnqiRN+ZoZbInNLe8mmlX4HCNPhj/0O64me
 8XRTRY6lkDwjrimCdiG8UQ1NjYEkP0/QGbPRxA8xOkhmJ7c2BY3kGSUY2iwwDnS2vCgeUlmsmC+
 AR842rAqpEWtOEVdsTNmi3jpbCIidBuDQ1GLn26ML8NGPdghFXwsjcKOuOUCYyOLprr2WLy051D
 s+e8LkU+ywKjirwhw9nIJxcv1CzuvAqw/WMwM7gVYWu3rlFTNKvWrMpTrHZPtC7NEMWByzNd56h
 vX+1wtf7Prb8psEZYc0
X-Proofpoint-GUID: 5H1C8VkXv12K9n3loB6iN94dPheikerD
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6f8a9 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5KERvJ6N5coBvBd-fXAA:9
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508300019

Add support for lpass codec macro version 2.9, which is available in
Qualcomm Glymur SoCs.

Its compatible with 2.8 w.r.t register layouts.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-macro-common.h | 1 +
 sound/soc/codecs/lpass-va-macro.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index fb4b96cb2b23..10ad682019fa 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -29,6 +29,7 @@ enum lpass_codec_version {
 	LPASS_CODEC_VERSION_2_6,
 	LPASS_CODEC_VERSION_2_7,
 	LPASS_CODEC_VERSION_2_8,
+	LPASS_CODEC_VERSION_2_9,
 };
 
 struct lpass_macro {
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index a49551f3fb29..2e1b77973a3e 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1485,6 +1485,8 @@ static void va_macro_set_lpass_codec_version(struct va_macro *va)
 		version = LPASS_CODEC_VERSION_2_7;
 	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x80 || core_id_2 == 0x81))
 		version = LPASS_CODEC_VERSION_2_8;
+	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x90 || core_id_2 == 0x91))
+		version = LPASS_CODEC_VERSION_2_9;
 
 	if (version == LPASS_CODEC_VERSION_UNKNOWN)
 		dev_warn(va->dev, "Unknown Codec version, ID: %02x / %02x / %02x\n",
-- 
2.50.0


