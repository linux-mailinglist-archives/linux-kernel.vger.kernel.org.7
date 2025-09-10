Return-Path: <linux-kernel+bounces-810996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87817B522CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44EE585926
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83D338F23;
	Wed, 10 Sep 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBP3A2xh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0093375D3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537092; cv=none; b=jmqR5IA8V2Vfge+lfTLPQVA0AGX0i6qCK1tQpcF+qdAO8xjx0zqa5CBrvz2rnMLHnCuXl1Mr8XABbSIrUuIKMvxpNmE5FF/2ZZ9SO2lX4tEdjUCcxW7ugbiZcHb460/JjtT+2ltsev9NwIVEaeP9MMxS6nNp6aR8RD1hcRW7QZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537092; c=relaxed/simple;
	bh=Cc+w7MVJQJo0DUQb98BGTv/aakQ6gRVawbdf+TbmC+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGmUjbOwYH5mIOoX3JFAUv5zZjOkNpXA+fJ1l2NsdilQz1VImIpOrBfPgvlmy5fe4SzxoG2r7gbXNV5CEXLA15MxbFRo7Qpi4GP5wEtojhmi1mGrwIae9JlGMjF3mXrhMvmHv9ivnAarutuGdbQRvAX4adRUnctHqXH2IYObAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBP3A2xh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgDl5020511
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zEFniw19gi8VanifAvhqImkhPqqb16gAdVe5GvYgBk=; b=pBP3A2xhm/9Vc7b7
	5XvUZa38nD1PWzIpkMiggd2k3I4H5/dUjVXSHb/Csi+n5GghLhFxRIf9yJFj2Pgm
	dDVzvSmugP6DC6MjPHamzvuHwEqKXVROzU0rgxULgwGVgdOCxa8yAGaQHDgtfI4w
	/IPzr41fwgT/BK02tW5cMZKoJ45x+szN1rVh/Itb6VZMWGRSyWW3sXDRBppKwMW3
	5QjdelzzVWzWzAqUM6tKBxq7qVWCqQ4QJ8A1yJer/L6z1Zi9eEKtOGcCkGzi9QNR
	4qZVdoOZxB+46vtJPPodVPeeMYy8tn8reprRI6w9TQeJjXWQzbkD7z4+hP5Zezkl
	4twIoA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc299rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3234811cab3so8373255a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537088; x=1758141888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zEFniw19gi8VanifAvhqImkhPqqb16gAdVe5GvYgBk=;
        b=WHBRsH4VFt8Yy2jzMl8K314PDokqXxEeoWL3UI6dg402bMLR/lhN060byfy6zitWGk
         aJEcRrXb1/tBIsWCo5hUWKWjW2i34deYkxA+Z8v2oH9qKteLVZi/bvwo6HhZdvQvA8CL
         PYNxftkSkHF/BcZK27Mq7vzMc4bJ2CeeBsM+WDKGgkLn/XwksFsYFEzX8/itJruJPVpm
         ShJrBMcjypXvqAXz8HwfhdbJpVKStqEAMpip16l0Szh0maxvdibuh5VCrbio9IOJ07zI
         SviPcq58ATnupISazrDGpALEeMti+bmw31LbaLyNqjaR/9UlYMXZE+lYWs83NXzDjSqk
         WfFA==
X-Forwarded-Encrypted: i=1; AJvYcCUHdO4xsrD9PP3iUU0pYb4Tic4koedlGC+av3Oub+beenvxmQhILoIIlwnv1lT9adeRRmdfYVQKz36Qj18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzM7rTZB4m4SCtlRWeUlQXHbCiuysgpX2zsNYa2qav2XjUfvER
	C4ukwrzNXhWSvfLHj5jRgFRh/fhnvDC16di6J1Bn/Wlkwxipqq2UmzD2TwjEAAv7fhXOwOo0Xyr
	O1TZwabTjyv9pfHPWeTM44JuL7DWjxaTCxwjnc2tJHmtik/g41BU6BhuZkd2PER2BouE=
X-Gm-Gg: ASbGncvAN2mQpZQHoV6+a+BHpIqxeLYzekFqFibYazQ1s6E1Fv4fBIFBhwSXT7lwj8p
	i/+3RkR1LOdRBvQnTv7csMgVX9YB09w9Nh4Y+wTVndfgOEyEyW32Ebn8jUS+o9W/xbAA/kFb/Fh
	2+j/OQZCw5O2uCkaeyx5ee5lSw2ejBbWam9S1GnqseDECU3cJ1z/gwtKu07aZjCsDnBHCz7hFAH
	IdTKDuktypxW9PQyLDR7XN89upvIdBlWJoGXJvC5fEcIimEhLwMc4G9WfMKnhgITix1pjo79Cy1
	U6UXjXZ9lTV4P4r3pEh5+/PoBkf/YVeZ9T4iIMuVXapdTUonIZn+u3EVvirZhqh9
X-Received: by 2002:a17:90a:da88:b0:32b:97ff:c941 with SMTP id 98e67ed59e1d1-32d43eff6b4mr23734446a91.12.1757537087777;
        Wed, 10 Sep 2025 13:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5JeaHP78+QQF8BxRzGsrY0698vqlF2QsnYTCp+u1b2tpPw9ban79zLcuyfYHCSYie5Erv5Q==
X-Received: by 2002:a17:90a:da88:b0:32b:97ff:c941 with SMTP id 98e67ed59e1d1-32d43eff6b4mr23734421a91.12.1757537087342;
        Wed, 10 Sep 2025 13:44:47 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm46771a91.5.2025.09.10.13.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:44:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 02:14:07 +0530
Subject: [PATCH v2 4/4] drm/msm/a6xx: Add a comment to acd_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-assorted-sept-1-v2-4-a8bf1ee20792@oss.qualcomm.com>
References: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
In-Reply-To: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757537061; l=989;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Cc+w7MVJQJo0DUQb98BGTv/aakQ6gRVawbdf+TbmC+Y=;
 b=xWRPiIINeFvdpTfSw32jFQ/B9ZRSd9C0TetdrhgEBC7bIXtv5wFHq55xcGfI/ke/rZBcT3KGu
 bc7geSlPkQwCgsmEfhFN1DFSV8/fZ/hsq4a7zWaKlTfbN2ZoQJ+3FtQ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c1e341 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=p01HAiXOVyKYB5BxCaMA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: w8mFJvo4Y5CLlZl70YlyH0Csy41XT05F
X-Proofpoint-GUID: w8mFJvo4Y5CLlZl70YlyH0Csy41XT05F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX9kZXyCsfTJeG
 +YlqSinABc3DenxJrAD6rxqKu3jJIyK8KsUDQBDSCojdxZYPnV3opN5QrwGBI9cQvj+7fvpPZ/v
 8cJJSVF86B2Ttmpxiw7S/Dy+0UCYCx/puRFqiM1dptecMfjrJAlch/0reF/3p2TxyVMs+IzzQf0
 uRnSi4QF7ZyyJB1pvfl2XU26bIlJBIqhsFbOcNGOFMlmk549A04qeDG+8wkjBuPzr122upfN5BE
 NcUZj+s3lbUkRTBriaEkuibTag6ftviD+wpvYHzUuB84HxUfxh3So+tBp+ivmr9nxYKjOM/tqsZ
 FgOcmYi2PwdP0LDofohc7qKRFGAjzjxJWM20hWrhW7Zh+02ZVAHkO8hjPaSept8asUb18AmjhaM
 yVuTDCv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

It is not obvious why we can skip error checking of
dev_pm_opp_find_freq_exact() API. Add a comment explaining it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 4c0510cc784864da990af8cad086176a5d92ae8a..f81e28fb6f2ac4b1ac15fe50cfb488572009003d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1695,6 +1695,10 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
 		u32 val;
 
 		freq = gmu->gpu_freqs[i];
+		/*
+		 * This is not expected to fail because we are passing back a
+		 * frequency which was retrieved just a bit earlier
+		 */
 		opp = dev_pm_opp_find_freq_exact(&gpu->pdev->dev, freq, true);
 		np = dev_pm_opp_get_of_node(opp);
 

-- 
2.50.1


