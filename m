Return-Path: <linux-kernel+bounces-866448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33FBFFC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB151A051AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAF12ECD14;
	Thu, 23 Oct 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRJs/DMe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444832EAD0A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206839; cv=none; b=OnragOaEvjazXc2fCt++xRVHRvnB849yuxZVEsi7Is90lXHEir6+6nEIVMRJeg7gB3r8h71Xxq7p2h9Em2TBdYU1YlKc3mIbURfCJENmn0+fF9A5/AQANgTEnPnhob/UhimMH3NISXgNjxBvzeEB86N72sIyEIXw4qd1igwJH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206839; c=relaxed/simple;
	bh=ClEao7QUrypc5h1ofIg8T8mt6ryQJd4aiFVEJim4yLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQXowjgqBaDOXygoFF+S77JJNciy35NeKt9eafiYpz2msN5EGuAbMYG6Mk+kO2tD1GfA54qhoi3dao4q6aRczF2fErl6NKjDPk/HFC9n0HuqafmuEcWRclnxUC1r3FLygkXBB3AuVQMrNw7tCvR45JGKnWisk3vLBdbM4lqavt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dRJs/DMe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6io0P014657
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KgSVmbG0CXT
	s53n44YyJiTznjurS7MAlfi9QKa58wbE=; b=dRJs/DMe/B2FAT5FnYpZzC1r7CV
	aN0SffoHW5d32GcH4bIL/wb3J87BwN4UA50SLQR4H952UwreSlK6qgScQtXem4Ln
	yWWb3q/jRqVjmdUTTX1ecYy8u7AdW6sOxGt5JD60mYxC/acZTlFIr7mcLIdyCnPf
	sU5oy4jvBxDPPthLj5CtKdbHifxsRXxB9IsW3sXU7nRRuLXQLKRFB2HAAV+Qgss3
	YOSWWxjkSmj49jTSf9bmQRyXChS93sk7m6739DnFn0ylZnOXvpIRQSmvxCMlHccW
	WE61PieIatYguwZjLwJwdUzSvOeCMWET40SCpNcwKdQxlcClju6f8I8gk7w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0nf52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78105c10afdso509850b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206835; x=1761811635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgSVmbG0CXTs53n44YyJiTznjurS7MAlfi9QKa58wbE=;
        b=mOZhnuIY+ve2rrQglijhHtXqHdgbRkTRxebShQ2tu/NUJ5Lgc17Fk9APViAGKMYYzp
         4UxOW5JavIWp2Id0uCo5sypaepJ6B4h6lbuXnZz/p5mbwc9LUx34dJ7YK3u9pJjmeZ71
         FQLFZpXv6eYS63Emi+im0MexXOCM1rqgNo/rnhl0rUE81rdJL0rt3p1DXRhpuBMCnrwe
         TZZKwlCLfZqd4fZcdAJ5McpyIQ36PPM91awHhtLBegy+B/iGedNumbpDNy5794bqqOI5
         0KZZNxqt11hZjkHoYgEFQ9G4EoYi2qHyt1TlFFEzW7QEFnZE4doHhhgrR7HBQBXng2cl
         qjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDaZ7N9phEvmiOBhgTsdDPoqpUo415lLvJfhry8Z8Ij48OR31db/IcW0YY8GgY+0SNPvje4Us+PY+hDUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6HRLUXnbO0e2jDE4xT4H4kDLvEFGbm+P663Ii8004FMbhUKsj
	uQ4ljwtI6Sa++HD5Q8HbzQIQeJOm2n3tLBpyswdu91vHsXGMT+KqNFthB2KXFOgGV0lfTYhmWsx
	Tq6bJQ10OrxjUnl0wSnEOZTYiQdzvprBzqX56mEew89Padej6m5+v8jHl43lwqg6siWY=
X-Gm-Gg: ASbGncs7PsZAVSqeFb5v9eAN+M6Yt1MgLhf9epSLhwbVzz5znM11+nv33GNVsIHFe+y
	rETM3UiY/DuJU2r3lU6ocJR7sIT7JFKeY5iCmTmBmiJzkvJ/Z0ZFZnLtxgl8sSquqiao8sg3Rj1
	BY0/U+mDcFKOTTif0zB2RaqcHAouWjuCrPhan9fq2eqCbv3HMWcvdBH3fE4TszS4SiEn2WuaBRI
	sxWWCKToNmk/wBEianO1FpHfcNY58DNS9/T6Ijzoygns5uWW0D0YqsIqFOUlQ6zvV4tQcKC2yTB
	QhuLMP0ZeJrz5/dovKrn0zGmDeLJNNU21HL/bQ5BlaFfQZ/GGrY4SEXpRDG2zJbq9BGhSExEqCt
	Pl161LT94GXx+yqSlARnGli+otuXjY3s6pE1zitKsVq3b+c8SvA==
X-Received: by 2002:a05:6a00:2182:b0:781:1e08:4459 with SMTP id d2e1a72fcca58-7a220ab550bmr33261088b3a.18.1761206834392;
        Thu, 23 Oct 2025 01:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQU6DsEGqLwTWykfWX9a0n5WaLRPXfiL2M9UpRfxSjYlgMKuoDnFRY1LaCZvZ8nIr2wQVy2w==
X-Received: by 2002:a05:6a00:2182:b0:781:1e08:4459 with SMTP id d2e1a72fcca58-7a220ab550bmr33261043b3a.18.1761206833922;
        Thu, 23 Oct 2025 01:07:13 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9cec5sm1676410b3a.20.2025.10.23.01.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:07:13 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Date: Thu, 23 Oct 2025 16:06:04 +0800
Message-Id: <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX/08VUkWPGCDI
 3xNso/8qdWgQR0bd25LCE+9hUBrxGJ/77k1eAmIHRsq45055HX4GCnDGuyU8S0Td1FP2ijbjE9l
 43uGOTilz52MFca4jwp+hlv1KK9tNvse+AWUQjJfeu/p2IScb0ptD69Oxv+CDcpS3vkUKnHpuqt
 /pmQyIGbHvUgCwwuQTOGYqMxw7wP61/PJAUAmVRodp5hCgnOPtH0Fxo/0QrNhX4rM/lKphlA4jN
 qsoWyDIA7L67jMYYbMef9yARcEZchZYJxRAxTnw6+gX2PsBXXKOS4wPl6vm1+bZYpaoO3cYc6ru
 zKyT1EUvYcrU2X6hFYvOK2xubFtDRtdUGIXacFMCvpCSQEHDm7UwMuHiDQHYPZlgeMugJY+alXD
 /HRIAHsIUui2I7qM1vAjOpZfqOcO/A==
X-Proofpoint-ORIG-GUID: HEC7_yyjeGlnJLhe7A8y5YZ0xXljtuwL
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9e234 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=L7xdKIvrZdzy1bmArRUA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: HEC7_yyjeGlnJLhe7A8y5YZ0xXljtuwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
index d6a37d7e0cc6..7eda16e0c1f9 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
@@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
+	ret = regulator_set_voltage(ctx->supplies[0].consumer,
+				    1650000, 1950000);
+	if (ret < 0)
+		return ret;
+
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
-- 
2.34.1


