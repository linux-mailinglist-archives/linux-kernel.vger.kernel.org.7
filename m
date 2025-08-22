Return-Path: <linux-kernel+bounces-781711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25490B315BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75AB622773
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B602F9999;
	Fri, 22 Aug 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoQLVjHq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79262F6167
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859776; cv=none; b=oKRhF/4BRNf/yBIwqKoP2K/4yLdQF4nZ+rXC7InmT/ZeVOcTP0AStNhZN8CgW75TA8Hw2OnMQjrE5RSOAFdbH6WYts5LEEzjWf3ArzPgC25+db1phxXBcSRY6eV0yT+jJvMpGf0kSOsO5BHDKJYGAqkoM8OezbL56KxgClLzF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859776; c=relaxed/simple;
	bh=93GrgaiWaZtCKjuG5PPu0kwmkEEb4zw1zaJIOqGGrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw7u97133epn2BszizoXR4fXFFTluTyeHghPhgChTM/PK7jJCTsYDmMRvjgNi3ZAnx8QlmMu2NmRY3fVyLdl0LL4ooLJKOzRrKRPlHi5iE0dGIz4ou8i0x2yD4censK8wRBNuf0BGQVCcKLma0BV2EqH3onzcPRsOOqdGcES1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoQLVjHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UIMN021761
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QvpftBrG1J9
	rWY0MKQPnpSUD1XG+6hxhXllVH2PX48o=; b=MoQLVjHqPjkyopWKBLC3dq1QiUB
	bjU++ATNVu/1tzImZ5zGWI889QWaBH9BdDTyrOT/PYzUfqCL4PWycN5unJzbZFEm
	H5VUGZV+hkdCfnmWxLD3rOawdXiyhMS5dXRfGHxwZXAr8Gl/StMD+FcBBoMXtgvS
	ug6+3MyNgBVx5puAA3hCTOeFXIEY61NfVWHcZPfqxuSqKvHIMHtt3wTMNGvSuBXb
	gZpyAue4ePnbXGZoxqFmfotWH371E+HQG4JgAkRMu22VXNP34FuSOMUTh4tAyoiF
	CuGnl4UIB0UWgGwhh3JIrGl0btQcI8x1QyfaM5Xl+kF5f+ETC5NxErA1Ouw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a8yjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109c8804dso56090261cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859772; x=1756464572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvpftBrG1J9rWY0MKQPnpSUD1XG+6hxhXllVH2PX48o=;
        b=EnJ1xbwutYZRqFXBgfXIt9bCjcT18XT0oYxZh4YYlbmlDuog9R8Ggc9y46zmb4bvGJ
         60RBYXFQ2byWrDybYgmiC7cfGyfPEOH+mV4YilZ3Dkx5xCHrcb9+7NYM8juu7tDp4op2
         RFnAnPWy5i28XzTvsiNvvXV7yINy6FHL6YDFaPrqb6CiQvfBacVek3YL2QrxaTqNkQTp
         Ow26IjIcVpmAROSnV7PwCmmK0fsr4EvA5Up1agpClUnNUB/n49v9yZf3L+g165kxrI0l
         e6+f+/WKBJXoY6l0RvFIbhS8N2AHrb/PLN49DiV6tsSKXWb4umjDr3TMHX72DvcdEabC
         80Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWjSaNDkA5w8NNsOA0RScO3D1eyR2UVHfW2s5nPXBLq4JtjgAHtO9DcCHBqrl5ND8PfbkGlS7lR1rOL3ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgJcb+9TOXK+6brUC2ixwB8drfiHpFHhhDAc5lAjJDNNO3gOZ
	5cK8VbntDwhEs5UOQeTa/aTizXn9mduncWSyLRsovR5pSkwmH3zbAOMbBCXcmBh28mcg9BN6c49
	U4jAslhp4XD20m66PvgnF5GQYqc7I1leUOlClab4fDCk+16g1htEWx4fJhvvOQ11lHEA=
X-Gm-Gg: ASbGncuHIp1yt85RalLqO4Kf0OVViWRiOwxDrhMKGnRZzEBLpxzrcYOTi1z5CbOFwIV
	NHwjqKaVTStGr+vomTocrslIk+28MwTtAe/vJ8G9zljDil6mY7kXgkQtOi5Zou7azP0ZV7JYKjK
	Y7oaxuo1CLDzyeYgWsHPmtTVvpJmTeYNiSsqyvXnmMCGT8MNFKs8LZCPEcfhH3bp3+0AZ2zJ1UG
	JkkMycK3bPFCItJnagJuJotj7ML2f1ndDdDFiyPULvrmbGVRf1xW1BHavsuu7Gm72txuSPzYxZe
	NNmBQbjseHl4v/odoTDut1Jnof3GD/EG4Gs3rg7eD+tF0JDjyKqSsg==
X-Received: by 2002:ac8:5947:0:b0:4b0:7f2c:b27d with SMTP id d75a77b69052e-4b2aaa2b808mr22572001cf.22.1755859771405;
        Fri, 22 Aug 2025 03:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES7Jy1nhGpx6D+85CwxK+Qgiqo2P4/BsEinxs93B/f9dsv/inAUbbS1wWDEuY9P9oa8wJ9Pg==
X-Received: by 2002:ac8:5947:0:b0:4b0:7f2c:b27d with SMTP id d75a77b69052e-4b2aaa2b808mr22571871cf.22.1755859770819;
        Fri, 22 Aug 2025 03:49:30 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4249bsm31367155e9.25.2025.08.22.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:49:30 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v2 1/8] ASoC: codecs: wcd937x: set the comp soundwire port correctly
Date: Fri, 22 Aug 2025 11:49:20 +0100
Message-ID: <20250822104927.2621866-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a84b3d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0i9YUgi2cL8IzqKwLzsA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: tdbk05PU4JDOT5fcMQw_VOPBORhqYQM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxji2wjICxnPs
 Jdatl5LirZvorg5WDmlHKRLX4o+2ClNqynflMErqz7uvwncrZEhCkjOeEnNiH+r+DGPSvtuinf/
 mmvCNvE2CQMOV8a9eBxAw/WYDBH5FNY7OPuKNZR+yrN9GVQmz8yhHBKykJz0UbmDN/gZQexXIX9
 Uz/M8kEqU3IPiERd4koFF032iJoaGXzG1b/Mw4bxRgG67X2RvkH9jQbjzpATguQbqrRpf/MfLJx
 F12bqq5N5b1yBbvLiGJlBNIy00KdDf7BQsM25NGCi3/mtnw6K+Ry9JdvUoDGFNmi5/TefMcNUqK
 lpqT3cV3/qIlkqc7zSY+qR4OR2hbqslcLJ1NXUptZ+1p6QxycGaSDXcf93FoKQLVGS5SAARMpoc
 DA9unav5fxTkdMp3ZeRFBjF1eWZDIg==
X-Proofpoint-GUID: tdbk05PU4JDOT5fcMQw_VOPBORhqYQM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

For some reason we endup with setting soundwire port for
HPHL_COMP and HPHR_COMP as zero, this can potentially result
in a memory corruption due to accessing and setting -1 th element of
port_map array.

Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd937x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index ccd542033967..b78f37c582ca 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
 		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
 
-	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
+	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
-	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
+	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
 
 	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
-- 
2.50.0


