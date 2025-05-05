Return-Path: <linux-kernel+bounces-631585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7FAA8A41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 02:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C741893D52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 00:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F536194A6C;
	Mon,  5 May 2025 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mn23ySEZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A3189BB0
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746404114; cv=none; b=ddxIkAIpa2GdNuwT/lR9sw9yo3V54CO02Kz2z88dMr8rKOM24WSKZx/C6PhjBM+OoNyUcJnVZvE6L5t68JbKPVrAD48vJqyraN2IeBfY86j+xXvO7q7TBFX1E+7iWdiIhLXuGF8uXEvoV7D1P9h6fzfI6TH6hJJs2j5KbCYISyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746404114; c=relaxed/simple;
	bh=p1LSDfh039EO9QiKvv3+87Ir+NZhG5XF0kZCfEUI8rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYcCW9IfAAGZsaz81xuGuN2k/dyq4/1DaIkrKYi91uPynuDucVnGQA4PwM5VDtdUxfxQR9rkLJrn1lSmy0u3ihSnKumM+Sty+phqDXJ4uh467mbZY4jzrQTP4tXY5rprPcyAT7Gv1mfT8/1HVfK3Z47uQQxS3/usXHKVXerbJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mn23ySEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544NxSpv000547
	for <linux-kernel@vger.kernel.org>; Mon, 5 May 2025 00:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X5c1T2okNkBRPy3LP55P7/c8OhgWI8CTU4FhNq9qA4o=; b=mn23ySEZ/pXl19HG
	+7YA8VJNFSYz7kXn9vsxvpHYPUpm6e+g0diYAoj0YCUR6XTbKEZu8dWBs8cOu0q5
	wmc1yXobvHKpopc6dBau5/0IZY6pj/m+h4RVigbZ7qmug6GuyCzMNsOPy34rfCOe
	KRO/ER1QoyknRcIohyzH4QlZ8nIaoV+z5FuYmAyhehzS0+FxVwRmG5Ahenx34lVO
	ki+HwOsBUF4uPU7kRzdUCMkPazignGzzdGkEvaqXnCgLUKnB8ybi3E6a+SvbquJ2
	M/5MykGZv+bhx0eo7vOgAXf+gLHuIoOmR+/wAV0xYbyOC6thOHwY7HaNHngN8fVT
	t7n7NQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dce9ahjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 00:15:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c9305d29abso759162785a.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 May 2025 17:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746404110; x=1747008910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5c1T2okNkBRPy3LP55P7/c8OhgWI8CTU4FhNq9qA4o=;
        b=kzjW86Q+iVIVnjk2f3m/U72t+pZibEwOGNGWjdhkHBTLZ8ilOOKMQno8RB92lNXYJl
         8PPjUiFLvFb62rOv0tzS4LBzc7mrt2VfonQHHz3TxHKdWQUD0ofuPMThxXghbbnYpQFJ
         BqTeQFHf5TrY01rvBVEBnMVQurB086P/03p60waCJV1XEIURmeBgH5hrm//pOtNNwu2z
         6dJRowNQOghK7K1tRqkZR6nb11FBQm95UHoJjnWkrcARflA0ihMbkULiNkRLcPCUbbYk
         3cOw6xW+yTm0uE6nHlTc05Sd7AY9QxZlL/IzgfIX/RM3bEorf2xJeLrvj+bwIX+CbYWb
         6UNw==
X-Forwarded-Encrypted: i=1; AJvYcCU72Uj/OZ9nW2Uhvgi5LETq3JZ06HqqRL6uRGSFfxicWXfRdTK9uWeoPmlOXIQry0I+QGSRIwPcxinAIg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCvtaCUNduho91OQA88vY221RhQhyhvFjT0ZM2PPp1CQa+IXt
	uGH/2kZanxD+pN3cd8ugOsj7cQudCLbaAwB62uUR8yyKTqBGEgVcPPuXdHWD56I/JP3LaxlUjQJ
	F/XdkSESn8hoOT7WG2zfiiTxhptUieYmY8aHeW2tR/k8exh+V3lqZkQ2k6QauuR0=
X-Gm-Gg: ASbGnctNiLiTwx2OfREw/N+y8qXaokKbTJBIwiL+xkamDqn7RPhgprnKw8HjM8T+U0W
	inou8skELZMvQRWeUK2Kj/C4Qpipioii4pW2F4JY4faNTLx/Zu+d+1mYJ3RzdkHWsHgKxunTZ9d
	X6VBfPzsY1lW1YI+Zs4ehmCyJHlv/xY1WA4Z43/VUsunrIpScqB1O/phD7PHegVhWZsKBygQgA2
	OF7sblpcPe+jdFWVCzL6bypkB+5VuzvAx/6gEOa6I627puDWW/qfLTc6aQif0H/YJ4vNUWroAbm
	C+YivTkYoczAQfXW/kTPzsmpxYTm5gbgnFTzSiU+u8x++U4gzfyWecThbkiFBgmI+HEj2hvSFUN
	MAEJhJAxTowz94q210DjUbHqv
X-Received: by 2002:a05:620a:190e:b0:7ca:cd43:e46e with SMTP id af79cd13be357-7cadfea82a1mr1176854685a.36.1746404110490;
        Sun, 04 May 2025 17:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQhfFbqpZslO2eWr4LyRzSnWS8Njh66IBcHVpnb9J96WelvVwOaL7E7JvQ4d0L3KLXii73DA==
X-Received: by 2002:a05:620a:190e:b0:7ca:cd43:e46e with SMTP id af79cd13be357-7cadfea82a1mr1176849985a.36.1746404110144;
        Sun, 04 May 2025 17:15:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94ce656sm1454066e87.105.2025.05.04.17.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 17:15:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 05 May 2025 03:14:49 +0300
Subject: [PATCH v5 05/13] drm/msm/hdmi: drop clock frequency assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-fd-hdmi-hpd-v5-5-48541f76318c@oss.qualcomm.com>
References: <20250505-fd-hdmi-hpd-v5-0-48541f76318c@oss.qualcomm.com>
In-Reply-To: <20250505-fd-hdmi-hpd-v5-0-48541f76318c@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WW4ls3rpXG1GIIqJFaRsd5YlkFmkvDhOcZwn0x64Row=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoGAL82x04Ldn8u0VpFSsk00EMCwD9Pm1yAeD5b
 ys5oLHbZ7uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaBgC/AAKCRCLPIo+Aiko
 1WmsB/sHPPAf9NychOLipLaNxz2HhgodbrgZJWqKAWrZjaD1lVAT7NmeDWPl9qIV1saOMtOU5lr
 wVowfYQ399VVJQq2/C26DQKbVs8j4NxaEOJNTfJbOnoWc/6OlCBe01vp28OrqdjzDnp+vPPJln4
 JYK7wO+dvBtHfERYjMhTyUKsBzR8G/GReWfTdL9oug+KvOcMytfwahFaxQXH5UJo16spstBcpiW
 5xVK8bJgepjs8phsyTDqNNta2we+VYBqxdJd7BArrtlYmmdCQC+HPJVzuf3Myr4rMQrVmDNtj6A
 9CC+Cv8ORrYXG2FbKrevADexNzYZvs3VBeEbuYf1gDkC6n7m
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDAwMCBTYWx0ZWRfX5caicPPnHT1f
 6wtOTJ9G00FnvDHL5KcQnCMLIin1JbU8eenbbEkpiixvngp4lGh0tthhyvXj7Z9tBfpL96buRLd
 l5pMY7sz15Z/09NE6jlyWbpO89T6Tx1QhjAypSs1ilEd0gMhOfArr0KU+baHMw8+Joz+wRZMND1
 IqkOY9m/jFKwTD9f+J7oiXxvyerI3Lv42WFpUqH3a3DyfyaSHgK2j6oI9x7d1yQ1kg9zkuIr+aB
 U8NNaaGLrdkHyLKL+xIXMXGnJZd/xHreA4HI5mIDdFiS64PYXdYoPcN79nadz/g5RZUydLBA6U/
 Q9fe4wHDC152iN8sXQu4hQCSVSbXxzFXq31LRNMbF6qEea/H5tGnp6tMf9IExelYIUH+s1i8M+t
 CsAFfbwszeU/GJXuWmES3NaxPa/sBeEykbs5HYPdvIx4SJfFaea86iDtWvHWE5TzHyjZKCyJ
X-Proofpoint-ORIG-GUID: 5bkpx5GQYp-hDOXHgeyo5PA-MD9CzkGX
X-Authority-Analysis: v=2.4 cv=Qope3Uyd c=1 sm=1 tr=0 ts=6818030f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=F7atGr4GHeWUWaFcoCIA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5bkpx5GQYp-hDOXHgeyo5PA-MD9CzkGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_09,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050000

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The only clock which has frequency being set through hpd_freqs is the
"core" aka MDSS_HDMI_CLK clock. It always has the specified frequency,
so we can drop corresponding clk_set_rate() call together with the
hpd_freq infrastructure.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c     | 2 --
 drivers/gpu/drm/msm/hdmi/hdmi.h     | 1 -
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c | 9 ---------
 3 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 104f9cefa14834d04fb957eb48777e605d1e29a5..6f09920c58190a9c195de0407e4c2dcc3d58b30f 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -234,12 +234,10 @@ static const struct hdmi_platform_config hdmi_tx_8960_config = {
 
 static const char * const pwr_reg_names_8x74[] = {"core-vdda", "core-vcc"};
 static const char * const hpd_clk_names_8x74[] = {"iface", "core", "mdp_core", "alt_iface"};
-static unsigned long hpd_clk_freq_8x74[] = {0, 19200000, 0, 0};
 
 static const struct hdmi_platform_config hdmi_tx_8974_config = {
 		HDMI_CFG(pwr_reg, 8x74),
 		HDMI_CFG(hpd_clk, 8x74),
-		.hpd_freq      = hpd_clk_freq_8x74,
 };
 
 static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 3314bb8a09d6bea7e34ad9050970bf43c64d1558..e93d49d9e86936cb6c1f852a958398de2e134ad4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -93,7 +93,6 @@ struct hdmi_platform_config {
 
 	/* clks that need to be on for hpd: */
 	const char * const *hpd_clk_names;
-	const long unsigned *hpd_freq;
 	int hpd_clk_cnt;
 };
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 9ce0ffa3541795a076b433566a3cafe156120b15..7ae69b14e953f0ee6deea8a216bfa9d3616b09af 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -68,15 +68,6 @@ static void enable_hpd_clocks(struct hdmi *hdmi, bool enable)
 
 	if (enable) {
 		for (i = 0; i < config->hpd_clk_cnt; i++) {
-			if (config->hpd_freq && config->hpd_freq[i]) {
-				ret = clk_set_rate(hdmi->hpd_clks[i],
-						   config->hpd_freq[i]);
-				if (ret)
-					dev_warn(dev,
-						 "failed to set clk %s (%d)\n",
-						 config->hpd_clk_names[i], ret);
-			}
-
 			ret = clk_prepare_enable(hdmi->hpd_clks[i]);
 			if (ret) {
 				DRM_DEV_ERROR(dev,

-- 
2.39.5


