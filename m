Return-Path: <linux-kernel+bounces-830003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E68B986E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5263719C5BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D1238C08;
	Wed, 24 Sep 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCzLnuvd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15071FDD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696554; cv=none; b=iKw6w6jL4MoXJZ/GP24HB+xAQLtBud67tixS5rKIdiRv7HRga/QE0duRtph6At3eRbxNgXq60Buh1k0fVgpVrgYdt6b9nCiHkyE4KzcPexet1n0IeMt++TeHCOO7mkNYX8TXeQesuWWS64X5XXaGv6fCDjpXQnl78G1R6xqbg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696554; c=relaxed/simple;
	bh=j1rkPtI+mxfQMoYjMdVfulSU2cd+VMUnx/n8t7/I2Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hf74uTjlPGd9mbsONiT+zNChOFyfBjtlpFYeQQYz64cDPtTgos8fDDXelZMKXedxvAc2F35EkLQ6oiuRsmAAbGzhkUdvY3eu1jMzCyKd4r6/rohpLpdhua3dP7w2RuAmet6v3Z3ANXCWbvY2Aa2bgSRM7aBEaozHB/0wUV+IYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCzLnuvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iIY1016453
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3GoFlgJ5g0Dx0YykwX8eXzYBSwZlV7r9oQF
	h6hFuZis=; b=fCzLnuvdfhX/Y1kvY/wP9rhKbgoKquM84HF80101eMAv5+LVSrq
	NSsJG8gPrQjLTeIQOPTuLKpSS9vitjc6jfHJ+SXhz7LANrvgKPPpYsH1JYn8kTk3
	bEPJOpeJvxvtMq+5DBMuJAsGxd9yxFfaXAClAJyGf826xgCEDxNM+NApwOEFxWBR
	mIdCKDpVwe713Mp1+iC3+gbUfmLDV7n/AqSWw1VdaXOo8MJ7r/0wDsuQ961Tddid
	V4y5CntEIYmouZ127oQYuy/8FzNQFSGV98h5CcoOea58WhYpuv+WdDiq7ew5rihS
	xvEwrKVscfK+Rv/ynqW1yUQeMv3Ymp5Pnlg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyf4vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:49:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55153c5ef2so4147058a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758696551; x=1759301351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GoFlgJ5g0Dx0YykwX8eXzYBSwZlV7r9oQFh6hFuZis=;
        b=BPF+miaP30P1JyLE73dtwb/8eprna/XbPhglx7/L6rETjSXzgJsVka/7g7UPhQ6/Nx
         VM+ic+e3zpzVhAtcKfMShST2RWwzyYiFy+orGH8TDpXoqQUnSkmMT2DZKp3D/+lL9vWh
         RFZwh899QYW7w7ZZBM9JNS7ZLVX6LCjGZSt0H0hyzZ8pYBUO8H5SfYTd+4juWCuOqoql
         EBAxpuejzYbM4xU242P5G5OCE+8SFdTE2FP58lnitQPy15y+fFgpbjB75ZvruS0UqLEe
         /QkRpeQQPIX1MdK7gHgrRMRD1yHz7l7IhXPiYCS5CbjhKmv3zzEoe1P3uW5WSKUekzSB
         kxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUNXhP08vCVZapofQrWstxdP6surMjMA1yiUuuT04zsjZ8CKTg5ibXlkzBadOieMN65RJbGQwQaxAKuqyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPJIz2AHiu2/EOiFf+Pdbjp8rIz0U18sTV9uqjN/Dwileyl5f
	5cK5HkK0KgNEaeIUftyJxP6hD2q+q2iKFvOSevT027rxL8hhMx5HjqzzCUjmWLJjgiWdbFkduO2
	egtnfwsIZImZg7KsA+/4ceyvxBp2QZAmHQmQ7kdTHCtQ3ztlv/nDqOuPLvSAcCm6Zo4Q=
X-Gm-Gg: ASbGncsg2MSB3WtLGeTT5pkcH5WLTsFbPvocUxX5/bLLwo+livXeobswt4qsBSQKiFV
	F7X7N8xlNwef0rBbSlrhnZ4N9hwfi+tQN8rBAoPl8zyCS9cFHxAJo3fR+VnfIHQ33LdSe4isSpS
	zKWvlPHHsdBt+VPbGjspdIWFyVFUeDzefNPjyGDvlIx4dLd2+cLZt+7nD7wWWWujh7pgrVZM1iP
	gTInSELnK8tg/2TvDxXzX3EPW4wr7CPKYKprTq5cmHvDsmP6eSzeRSOmbg1oKAv6ioZhwsmrvmJ
	SijvTY85q0FFus49FoJqQMmO+uum203PHWyPCUeyv5BF1hDor3sCd6gmtERT
X-Received: by 2002:a05:6a20:2446:b0:24a:8315:7f3 with SMTP id adf61e73a8af0-2cff159a557mr7392875637.58.1758696550850;
        Tue, 23 Sep 2025 23:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnMJ9uAg1E/SfcqCIjWcL+nCjzCzowENgefXLM/l70qoWKFxb7sR5qB27rRKVXFwchm1fu7Q==
X-Received: by 2002:a05:6a20:2446:b0:24a:8315:7f3 with SMTP id adf61e73a8af0-2cff159a557mr7392856637.58.1758696550441;
        Tue, 23 Sep 2025 23:49:10 -0700 (PDT)
Received: from hu-wliu8-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm16283356a12.54.2025.09.23.23.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:49:10 -0700 (PDT)
From: Wei <wei.liu@oss.qualcomm.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        gatien.chevallier@foss.st.com, linus.walleij@linaro.org,
        namcao@linutronix.de, zhiqiang.tu@oss.qualcomm.com
Subject: [PATCH] Input: gpio-keys - fix misleading GPIO number
Date: Wed, 24 Sep 2025 12:19:05 +0530
Message-Id: <20250924064905.276174-1-wei.liu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d39467 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=rTggg8t9TnRoL7-QV3gA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 3WXyVvVtSp6nRNuBZj8dGac_-JYl19l9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX0skA0rnkZ7gw
 4+CBGOwNzA2KmlrXiYCCsm2lz44dwMRz/ChAia7yBJIk+P0iMftO9EMfJgHV8Kou21ov6CF7fpv
 WRAaSc0vgcHdL6Z58HldTwkddthKzNvr5X8hYGCRxtvmLAq4jtl+mnLvBM6SjLikiOWt+sTSwxj
 v1lHITE6cU9n9zXaKkt1zYU1jzHVOmMH5i4R4xTbz4TFmw7eRUHCotIr+jBFbQ1NvcReXz7iTNX
 7mybWoWAyEjZFU1L4bN5bUT2krBGIRjaWEx2KmGniIaJ/NllH1DeeDQJ3OL+vDNU1b8tsCODA2v
 wE/+HV49CcY/9SxLu8Pc2BNOC0ZVNzd4dpGMus5PrFIaRWWGVppH2Ap19FIVNP86Z5xs8SPzWaX
 z06DJ70F
X-Proofpoint-ORIG-GUID: 3WXyVvVtSp6nRNuBZj8dGac_-JYl19l9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

From: Wei Liu <wei.liu@oss.qualcomm.com>

The error log prints button->gpio, which is unset and default to 0
in non-legacy configurations, leading to misleading messages.

Use desc_to_gpio() to report the actual global GPIO number.

Signed-off-by: Wei Liu <wei.liu@oss.qualcomm.com>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818..243295a3ea1d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -584,7 +584,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 				error = irq;
 				dev_err_probe(dev, error,
 					      "Unable to get irq number for GPIO %d\n",
-					      button->gpio);
+					      desc_to_gpio(bdata->gpiod));
 				return error;
 			}
 			bdata->irq = irq;
-- 
2.34.1


