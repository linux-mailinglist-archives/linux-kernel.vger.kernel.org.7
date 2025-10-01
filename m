Return-Path: <linux-kernel+bounces-839394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47479BB18B3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C463A69C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A12D7DCC;
	Wed,  1 Oct 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVqwTQ6d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7EF213E89
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345219; cv=none; b=cuoGb9Bou+XjA7GT4h6/YNv2a7WtjG73LWP8ZJKDYR7PED1WAhfEYVj7lFvGaEmIFAfswg/sWdtEBPkwo35cgvyiRxqFsV6eT02ZkRkQksMg+jZl5zdZj6CGKtB1aqvP6M4h9k1n6zfnWGxTBFkgFTKa0lwesxnCUW7bYx9vI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345219; c=relaxed/simple;
	bh=cbFzklju0t/aOVK5k/0N5wnkX1i8mrIAk81GbJ2UUBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3+EjGkiLrgJ+ako/TZv86IJPzApcrOw06++EczNzTMFC7ebo9M8eqW/sYAoObc0F/kOVcau+7ORh0Z3X4bMY2dsagk8eyGEMgTS9EtB2qTS9hOwZyNR6BuHp1VZbknXXiDduM7/TTMaxGSq7Wx+MqW4yg9KiRxKYsttq5/BxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LVqwTQ6d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcDkE012562
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 19:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fzbb6D7Bmwkuw9nm4Qwnfa0A+U7kuzPysVdaz5i1AsA=; b=LVqwTQ6dah5qT0J7
	iu1gnf/4ZqD0yvmZOm90gnFKMhVicCryWeB/FDOJ9J2AI7YK3l373qjzBaLGuKKk
	E21wnmShjN5ULj2MA89qKq0aNQVpIZz5ORWGXGHdQC69OFGTks5mr6fqBcaKwl4s
	H3DVY+i6vWzKPbhZlafs1MIro47EB4tq2gG9aKmxrsFdU4Y4qRb8cFzroGO5C1yA
	FH1TBbi1TScTpmS1o9UR/FvWnY2j5vUBydSXEtqDP3r4hn6tywWKIFcyotFsUsRA
	QzGNtphmrwSTWfdp2T97caOL5yHstxrVWH+by/QjeCTxqWKvHIe3x9+AVUsjszg6
	GOOc5Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80twswb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:00:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33085284badso32565a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759345213; x=1759950013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzbb6D7Bmwkuw9nm4Qwnfa0A+U7kuzPysVdaz5i1AsA=;
        b=YoS0R1uC53ObHKrMQhX8OwGE9zmjOJDRllhtToKAJ6lba83bflU6s1wFnLSAWb3Z5B
         VIhglpKN0oKNHTNg7Dlp/fI7vlUgFIjs8MFHFV0NSnsweC3oNp7pJ0f10hJqPqaQDdvk
         GVPk9MsBXV80DZH5qTOTNH//hEVH9ksOmcH4B/WultZni9gBNE2EojeCVDmxxQ+9+85k
         HbR6jP4NamgRYuhI5+2PPTaElGWZZW+hMaUZCK1gUQ+Om1G2RpIqyheJby5nOXaGeos8
         Six0LvSvkY46sPFirilKWiNxw9xFkOgNZI5l697Gix9SUBVMX8bjPqeFMXUqeKNpRR0W
         gayg==
X-Forwarded-Encrypted: i=1; AJvYcCWK80Eb3pesHQG5z1K8NHlyg4GGX/M+m45NgbB13dunlbtEm7BgWh2J24ytEXvZcKmEHNE8Bil4pimrH9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4WSsHDeUJqvg2kjFlp3woS5hzgxzd48Nz0QOyKuCNPPeFq8t
	5UZYVmPI/bSJMym4iJqiL0dkgjyX+S1sqdvY2Wsb0rNu3Cu0vdfqR2/E0wytlIg+kC5TqzY/OLO
	fXa+7P3/BUkXAx4qs1fhJUJznKRB4A48sj/FOY71ZotV73yrenLgqAXvRgQgzpQMPSpw=
X-Gm-Gg: ASbGncsYoIKsUuecQwcKHMyTF+/7mFPSObZn8ZrhQ5JVOINrzVGbzSfj3dH75E295UK
	VFURQQzM+87Gw2fC2dL9ECiKm2Mkfq4PbJDAiTXSYOQ6bEiFPaBnSCqU7a5qLs3015Plw10PFB5
	XmpUU/cP5w4EQ6RLaCCjbHIc6e5InJgd77K9PgbJ58vMZYhBnDk9vvc2WttdAnOd2UtJsjecULj
	7JhOfC4IocXB1eC87sKkpXCURqrWpBGmAlxzrP0iWVXtGxu4q/tiQOkYVF7aI4L+RJolszpAMVa
	Ki3cLKywUXun/zP2kWEPsiEDRe+Mux+lXXHjyjZPPNRyeWHnE45bJgSRPtkW4C7ysayNEORnLEK
	9Nt1YweQiGeTnX4+ePaNJb6BoLPsVlw==
X-Received: by 2002:a17:90b:3b8f:b0:330:3fb7:d874 with SMTP id 98e67ed59e1d1-339a6f9bf1bmr2810439a91.8.1759345212625;
        Wed, 01 Oct 2025 12:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU0c19fNY/PyxVHOgSgPEi+CF8xRjUV83am/qs0geCdBh4+DtSYFpaDP7KREYcLbWT9Ez2mw==
X-Received: by 2002:a17:90b:3b8f:b0:330:3fb7:d874 with SMTP id 98e67ed59e1d1-339a6f9bf1bmr2810405a91.8.1759345212108;
        Wed, 01 Oct 2025 12:00:12 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701cbffsm2950074a91.21.2025.10.01.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:00:11 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Wed, 01 Oct 2025 12:00:05 -0700
Subject: [PATCH 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1 in
 v4l_fill_fmtdesc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-av1_irisdecoder-v1-2-9fb08f3b96a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759345209; l=1143;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=cbFzklju0t/aOVK5k/0N5wnkX1i8mrIAk81GbJ2UUBs=;
 b=gi+ywM+w0EdQ3OS8oxXQgqMEfOBg8jKv02Tn24SC664SL8J0QfJWrjPb/rz0K4Bj0WwgE79WE
 BkKL8HZfsjEAjncShaEcdrUN66HSq83Vcqf2ALeEn2oUQew0yG9HIV+
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX7bM50O1s3WiR
 gOFqHrjrweBpn46iyCgsbXXAV+G8gVrF5aPa0OY9FlSJoNS95cp/1MdgBSdgwoV3tb1/ZG9LL3I
 kHEc/cOcfPy3qkueUIcvUy3EjYp+6Ztc0OWxTUsfSkPDI5WwevpjtvYIZULo8cXpei2suvbFRlc
 WkBO/IFPcMLT4jGOaiZ1rsF274f6u9+lJkIyHd25Cpd3nYKfuhs4fDGdDWjSe6IW0ZcUx6K3EgI
 uQ61FbzaBPVEvxZzper2Aqmf+XTO2blTRaAZ43KIIDXTXg1yi+v+6y1CVFR9/ZLUze3lsrlG8mA
 aj7dHfUf1FcC6beVKh3P9h1vv91ZF7b4BjZy8af8qvWYwozWlL7vbpAPWWP7nJBT3+FCShd2ftz
 2/fyf5srK02rrJ9G8d+DOEVodYZv7Q==
X-Proofpoint-GUID: yOyFAI21pZRtWqUjf9pCzymz0W3vu-Ub
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dd7a40 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=3VFMuRvh7oFGMF0ZDtIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: yOyFAI21pZRtWqUjf9pCzymz0W3vu-Ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.

Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..d3ee7736b74b0f277d3208782e3ac3282eca1e6b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
+		case V4L2_PIX_FMT_AV1:		descr = "AV1"; break;
 		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
 		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
 		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;

-- 
2.34.1


