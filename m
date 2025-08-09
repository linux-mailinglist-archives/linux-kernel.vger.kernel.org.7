Return-Path: <linux-kernel+bounces-760891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863EB1F1A6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3A7B7868
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3F2586EC;
	Sat,  9 Aug 2025 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LV0hx5sa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C124DCF8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699752; cv=none; b=a/Sxjbm+E9WY/8gIrBljhjZZhRJ6CzXKZC4MNObmr7SK8x4+nIJP/smyiWWlRahA29PF7EOtdxJC/HRRl5itOXnKAzHfntfpxtK5AtNb37GzXC1OdbgMzgSQOLT9O1g82zqcH19w6PT2yleCjcVpm5UGs90LtgWcXQjPqUopLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699752; c=relaxed/simple;
	bh=4NtupbLbHXZJKW3LGWuziF6T3O+S2Clq0/ZFSk/f48A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hmj8fC8jmD643MBd4G2NEirjTnNvvFhwhIcdRX5p7evNm4V2lc+4gJ/MDxbLBsn2dudRAK7DNBV6GQB+Wr2RoKfcn/on6vqFIZLtvWCDODE/WSDbvEDlNhNfggBOMK7s+EJrJe6GqhhCLsNYT3ueMY9zIujF5jw+mky/yucCfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LV0hx5sa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FuskG022433
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PiZ22avjMQ6yPSDZ6+PmnqKblqG/QInLtG55ppMw6bc=; b=LV0hx5sa7UOFHmvt
	K4N5be3m9douJyU9YeYoEbgSBnU50CLRN5ntDb/xiGsPfn8yJUGFBGERALz3hXDu
	IGN2WkM5Xum8J11P/Nrs/3PSjpOjNA2BSBi3RXmYsVqeM9p/CWd4gcoOGLAjTrF2
	2gFoRFtMx3nq1w+dzF7KRKwjhnzcwnViqADzwglvcdViQTZrko6SZvCcMIJVoIfU
	6FS/hbVwxSKUWuQlmlmbl79+IrcDP0vHoEpzVtr4hN3uvtFB5uE7XJ5mH6KwOoyY
	xw79v6+7V9wPXwP98nkt4cGc2e+lPJmhTNMJaEgJ4y/qTme13nhG8rkcznFptBGI
	ObMVHg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cs5ndtwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3214765a5b9so5148463a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699749; x=1755304549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiZ22avjMQ6yPSDZ6+PmnqKblqG/QInLtG55ppMw6bc=;
        b=hqwaFUdfY9COw91jztoxDDPdPTaFyDW3gyK4ccMR3ScSs3ZH5znxRXggqcUKTybCqJ
         105WmlDKVz7SD6GgaVin6icusmJv8DN0XBqgXJ9HUbJDjqqtWNVMaERZH9C8RQ2KakCe
         hZRM6IIEcM5+LtK7pggUkW0945+bl6pkrIDEPI2W/KBFsdJF4BR3bdUJ5NgBMvIkI0Nn
         TVkllBweoXtY6UqRiyuyc3ReobqPJyDW1UQ+iV/xCNyibsM1JSA2JQq3MUK2Fd3HckKA
         /T0c7i4Q4dIDAzXgJpCr8TqJncVjqB9KyuVEIo8mFnJvmma13hhtgvAB0vF4c+maYI/B
         h11w==
X-Forwarded-Encrypted: i=1; AJvYcCUD3bhxBDyaXGBSlnMoq+HoC3yW6Tkz+BvZOYjRtoDyfPZo/5Cdq+ZK4/gNq56tSki3ECuZ4rtahlOm1oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ejKksr3niCMy0PHgYxD9IVvagPZ5d9pbRCyuh5DipsG1dZqA
	ByHXoExGuG6J1j9l7nr7l9QkJalCZj6FfPtaj+8TMDxNFir5nNOvolJK8f+rsl216u/PdW463PG
	ZwYvy7q7iRX7k3IZuPfCvSapAiCYOuDDFtFooMzn7qqnFwU4vwLqkeyFLCrR4WI76felZ4uid1B
	U=
X-Gm-Gg: ASbGnctqj490vE5/Uvr2DM7KPnqz6CIvWIgPop6Bx1hV+1pnzw7neBaJzaQLhI5mH5I
	OU+yFl/7FAYY0vez2r9Np9UXAoaQYKzlPe7HF4uGw9HwqLLUULk1SHsCa17xctf5KCi0Ldrw8mO
	eHhwVgREvfANWt1v75FUUmFXb3ukJyS9hxpuxryUhlVrfPndqnX08jX4VxUUFi4jMTlpOJnKci1
	p4mM4Bll7J7fUqMOvP2B1kXWqtfzw8bijmDv9wkw5FyfbD00EDOerV08bqii0CAPBWouijrzL8P
	XdgFqoKpQvOs65u7wRBSJ9MQNQWeVXXhviC4hDIWSgp0oj7+nrStUJAwELw4YEoikxLskVStt9T
	J0T0hcjJeyScM9arJ2I6M5RB3
X-Received: by 2002:a17:902:cec8:b0:242:9bbc:6018 with SMTP id d9443c01a7336-242c2277f70mr67504835ad.56.1754699749331;
        Fri, 08 Aug 2025 17:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRcmkdoPKn0Y/gtVgwKawEtn3XJx+wDXdjs6KbTeVW7Zyo7yLwrrGGpLbIydsVcXp/EeUE5w==
X-Received: by 2002:a17:902:cec8:b0:242:9bbc:6018 with SMTP id d9443c01a7336-242c2277f70mr67504525ad.56.1754699748876;
        Fri, 08 Aug 2025 17:35:48 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:48 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:22 -0700
Subject: [PATCH v2 10/12] drm/msm/dp: Return early from atomic_enable() if
 cable is not connected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-10-7f4e1e741aa3@oss.qualcomm.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=1258;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=4NtupbLbHXZJKW3LGWuziF6T3O+S2Clq0/ZFSk/f48A=;
 b=pzZTjzYITZ80tgTHFP+3PXCECEW+ccVzZNuZooIm+CrqIvDUL9LgrFJnwSPGcSTtpuU2/mngE
 3yJTVSVx8BHCAAqhjaPQm2i2nj4ByCXG0skte9RwSkKuNRukmpO0gIp
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=Q+XS452a c=1 sm=1 tr=0 ts=689697e6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=C9iwNz8zScVtocZF6eoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Eo-MfRPbIsfQIrx2zfHjjypQv04mbTJX
X-Proofpoint-ORIG-GUID: Eo-MfRPbIsfQIrx2zfHjjypQv04mbTJX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA2OSBTYWx0ZWRfX+4NVnGHa6q0q
 /Qibaje78pV55rYScH7I4en7grkhXVRjKXJu2pBN/0b2GNqVwnJeNkciPrKWklnjSSIQFU7z/Tb
 hvf869ta//myG+2FX7smA2B0/7Ls1jLPRlZ4KZdYCFjJwU1trFEDDo7j7hSZY7cewNg6vPmpE7F
 xnissj0Z/3IuNk6Z+qZWSAbsdYB7J9OKInaW8LEfYgPQXnQb0K4yl/yESmDUCJSnRefY8zTD8EG
 FvlVMWV5qrcMi8G+3gJ/iOI3n7y5ICAu5R+C6Vssd8T39ArURcLAuoUKXqYk6gm884n1Z0sobIj
 KCI835PCXjjtiO/xNkLUEaeEpRlA+VmdnLAJo4JujMSJqmgPiETATwgg/P55wVb1IOKReRKngBb
 8ne3N7zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070069

Replace the ST_MAINLINK_READY check here with a check for sink count.

Since atomic_check() fails if the link isn't ready, we technically don't
need a check against ST_MAINLINK_READY. The hpd_state should also never
really hit ST_DISPLAY_OFF since atomic_enable() shouldn't be called
twice in a row without an atomic_disable() in between.

That being said, it is possible for the cable to be disconnected after
atomic_check() but before atomic_enable(). So let's change this check to
guard against sink_count instead.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dd3fdeaacc91..82f0b6bdbf39 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1444,7 +1444,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	}
 
 	hpd_state = msm_dp_display->hpd_state;
-	if (hpd_state != ST_DISPLAY_OFF && hpd_state != ST_MAINLINK_READY)
+	if (msm_dp_display->link->sink_count == 0)
 		return;
 
 	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);

-- 
2.50.1


