Return-Path: <linux-kernel+bounces-805315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96857B4871A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E91917AA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F22EAB88;
	Mon,  8 Sep 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2xuWFxh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2632EA74C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320058; cv=none; b=rMrzi6Y6rjQZ4fMAw6kiqktc1X+IWXUm15kouztaGeRRs5MD8iQZuPZkhe/1aMxwtEHPzCI4Ne5tSY88BjOu5q5KZQkxXvjpfRHt5pLJwP5RvTpFmzqsBa60nGQhrfBXCouiOqdvSsieb301IYZ8ea31YaZHVV4XO8gA2cjdcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320058; c=relaxed/simple;
	bh=35cpBSeGBdUH66FC4H+UsUPYwwGJgjYHwRMkfK+RjKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/N4RXgPQ7W80PB+Vik0IlqcC8Y7FQho9Q6xbLHaNusUDeFmP17C6SjZ2u3A6rWsqA51AQqAND+9mLmWPHrphcfZ//hMPiHSnsKQyf8SPpE+c+CzMdEgRkR2aOc3WDl8GA+tukKIuFcEOmnQ1abxb/c5LAffYF8L6q9dOleOjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O2xuWFxh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883kpXK012579
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MdRCXOUq+VTaRYE/Oa3hlCeqy/ZqfVMBxdnUcOZZReY=; b=O2xuWFxhv/JR6w69
	PZmQtW1nP4pMRYuaVV5+Xvp5xipHHGW7Rn24NcppvNrFjdK9xLbez3DH5eQmLQ4M
	g8pVXpvuqLOnwlOBY10A8XxswqfNMy0D/cpNuR+mmaGrZHCYydwquC71H9nYjT8x
	3GbN8eJRxkcUcWFIpEmkRcfv5lCSJGIIzaDaisvJFiiwRpVIl9LBH6osof8f1fM7
	Qq/zpXXKamka1KE01hcXzrH1DewQ1/vkNaS7hOUUE/JjwQrhIjEbKVcXalMXvvUG
	m+vVm6yzGo39//ObPqdyt/3hE2ZoIE9P+5qulFP8R00gdhFyseauUmb3lM43qBik
	p5o6rA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdrnax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:27:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7725c995dd0so4085323b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320055; x=1757924855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdRCXOUq+VTaRYE/Oa3hlCeqy/ZqfVMBxdnUcOZZReY=;
        b=gmUpyxpiwSRs3/NcOT26LazN/vvjXdQXLv3HBCsPcj4XthvO3Wb5iGEeLEKYjeReGH
         QlEtU9rz3BPONJrIUS5xp581qazwQEwQhOJILL/yrGJnnUSm6HC7bXVv6/ONJT5MURUx
         5S0otIBOA2fQV93YpfAJsTSNH2v6CNqFR+eCXMHdlZ+4yhJarOXQqhWGM82f4mpp90pC
         N1SIryNd2demJsTnFl08JRbqlBz/znWceO2eo240qyhmv4kQyHZqOYsjAWAkassGMNu1
         w3fJ1CIuvyqdPcJ7hBUInqGpM7tRrw0C18L+34OOzS4N/tyUZbEzpSIESbSMOZ4EsQdW
         OhBA==
X-Forwarded-Encrypted: i=1; AJvYcCX+DLtHx7f0yAvumhT245ngLwWYyntHalKRCJPm1QWi4d1eI6wRGxINMv5ptOHSSvCvwBuuNJxRxy/VOBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyyr5IB4yJixHIqEtueuUMhC6iiNBIMsg/4xV4uxOobjahuaY
	n6ounvYTJh5zpJbXKGXHPGsHPGVQESY8FVeLHh73vfr8xITy4KdFGymMNK9cVaslQSUwhSqn3ga
	rgyi7IUwjGp9FcFaR3nJqSH9W4vO2j6GHQY6mvPXDu3TqgSBWJSbWiKESX3kuCWbZrQs=
X-Gm-Gg: ASbGncsWFEWGynUu9BJvQc1vEzEHscj9qMo1Z0r8iFmVsQPLKG+6xaePF9uFrFgmW5i
	Y+n5r1M5DchwRagwXkIlqIfI8f+0MCUcCZ54kDqbIPwb+bmKIiHlX5IOp6QYq6LoFdETp9KlMLj
	Y3pzv5xud2luLADQJftRnf5NRAuPbKCfCxZwmGHXnMj3yexhz/GBXMvI3NR9rKW2QRbNq5lfnl8
	WwCdY5eEDQczUzLQPdA1GAuMEeTUz1TNmoWVu04MMO31YHMz9DDx2/T/EeYMPj3DuVnn1Dh75p6
	JCjralKETzAiIntCav2SNt8r+NXisVN3/9sIIvlxC+eRi126XkP9rsCswGkqeDlS
X-Received: by 2002:a05:6a00:4fc1:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7742dde571dmr9634389b3a.18.1757320055052;
        Mon, 08 Sep 2025 01:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoa7rPmKEoXy5bkSRtHuEIinaQc06jt7tvsoCi9S+fbJrxZSLSkUe3lj6xgSq9+7CmJWvh0g==
X-Received: by 2002:a05:6a00:4fc1:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7742dde571dmr9634345b3a.18.1757320054591;
        Mon, 08 Sep 2025 01:27:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:27:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:56:56 +0530
Subject: [PATCH v2 03/16] drm/msm/a6xx: Poll additional DRV status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-3-631b1080bf91@oss.qualcomm.com>
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=1605;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=35cpBSeGBdUH66FC4H+UsUPYwwGJgjYHwRMkfK+RjKQ=;
 b=OZU+SZ4r0JqnOoFtL4cOXGhnhsKN5lr0wigU0s5og9yKoEQ8G/GdA8oV20D3i86tpktTOK4RU
 6ZfUfUEkIU4BOwAhLWMVNE8XB/6fzyhgC1jU6Rn3QsW8rvaqWHNa7VW
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 8fXiKAR0hHKi7IIOA2fuY6CIpwveqak5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX6FxqCaLvtssA
 0rOVRrFGb05cB/z0KE56yAe6uSXN2b2iO0SpNowGp4RrvE0qfx60NPUM0VRVNv5E3c8i3iWLQBV
 yUG8lFhafPjDmY8yFcmqNFj9xCnKd87T+O4C1dq0kWKTil2lfSCgpOi7EQCInF9SKbauU3z+pjQ
 p9LAaik17RzGttAF4TsRD6EhFvoNrtaAgORqdEzo+LD6mqCAzXokbFn16az1eslyYf0SPtOYbP/
 0XkB3T1BJfTJSjTwONMtveoLuyZ2xnhfMRgCyy8UeL5ly8HbJIzADFgQMFkGTOCg1A+cARQLD6G
 Zx92Cs47wno+JENdlpdId31j6QWJfholsTZscrrr+i5jcet6sRSQaXcuJDMaHlJps2lpuoz0qyq
 dwUXkPDY
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68be9377 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jdX7vir1BwPwhWCwAicA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 8fXiKAR0hHKi7IIOA2fuY6CIpwveqak5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

A7XX_GEN2 generation has additional TCS slots. Poll the respective
DRV status registers before pm suspend.

Fixes: 1f8c29e80066 ("drm/msm/a6xx: Add A740 support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bb30b11175737e04d4bfd6bfa5470d6365c520fa..06870f6596a7cb045deecaff3c95fba32ee84d52 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 		val, (val & 1), 100, 10000);
 	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
 		val, (val & 1), 100, 1000);
+
+	if (!adreno_is_a740_family(adreno_gpu))
+		return;
+
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 1000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 10000);
+	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
+		val, (val & 1), 100, 1000);
 }
 
 /* Force the GMU off in case it isn't responsive */

-- 
2.50.1


