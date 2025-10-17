Return-Path: <linux-kernel+bounces-857631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D531EBE74EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E54D4ED8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420AA2C21FC;
	Fri, 17 Oct 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SDgeaNcx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB229D279
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691385; cv=none; b=Ry948T00vCRVwUwoLv+tfN/TZSqx7WK5cxEDIBapsfYF2IGvQCJEMdFaZMS/WvRFYFf+1A+D/jw784L3hmiTnHhNz3FpHTiN8ikgC2gQmVY+WKg9EewYqs1682R8NNUowsv/PehWBFZ+Dc+r8IMRx0cCusq0QltlmPDK7U3D2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691385; c=relaxed/simple;
	bh=ENO3YSOfTnciWFB7PA21ZeJ+n8gziqAO4GtBW3dwPPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8oSrpr+ac5TGvoK7ECpq1Y7L2AqCuiAcqrlsOEI0uaqXZ5SVLj305DXYsb+AizoVND9+euRi9rnyn+HadWqY8lZwHJUMtkysYw8R2bPP8OJCjkKWxqW1uFP2tSy1AMv4RrJdBoyjCx45cuGQjbEL9CrsKD6UqUTg3I1r1XRT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SDgeaNcx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8695m028652
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2qk5/cDXnMl
	tBmhvmLVh3pUHcYmEfXQKc8nHF57WqJ4=; b=SDgeaNcxQnseZaDUnIlewILulX1
	e3ImkJv5NOHHSQxWYsdl4vaZtvuXLh0CHik8QqjWWgDWTlWiqJvKjmMFqyQTj8uL
	hj6A7dWvEm1JPhuI9YIy9czvFKSHi4jwePTo5Qy1XywqaVD02RFAkMffN3VHz+W/
	fDlOEtq9TTlRFz3hMk5dvbhK3c24Mgkfoes2eG3bTZ4kw+MbfEuWZRCpwJ2r+eSf
	v4qjg32mGj7QyXrB4mANy0VCqt9MDOyeXjknhjwRPbG1VHYUYl4CfBBErUK+LXig
	nbcYb/qBA0vLEA75gz6OoWSWDYosJJ8S0tMsD2ZIUvBBkvPvQctauw4s2ZA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0u715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c08308d26so59424776d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691382; x=1761296182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qk5/cDXnMltBmhvmLVh3pUHcYmEfXQKc8nHF57WqJ4=;
        b=ciya7rPlQOeatfu5MK6poRGeXVsyLnLKMLdRcZDmxHVzlEp8M8h26qGaYQa57/I1pX
         ny9iH3L2HNQB1TTJ8C4RCm3Nk5vWpAmGRYrwFw4Y7pUd+sM4AkLkgOLpyLnDkuv3NlSe
         RPt7i0x7egXbKNiC1dWwx0b0wcdhzsu5eNsEDL1bBxMjtT3L2y/r626A9xnr8mhZuAi1
         4nxrwR3GC041S/5MNxqdxCPs/JSmJCxsJ8spipwiBUH2RHLcW913x1YZr1qTXjUTqgt0
         jDqkQJtHHwyXmtdfujFLWqmJzRpGBLW0oNrPbJ+alkjwRqgoKsOVhBK3ihOMiSHlakYe
         cYiw==
X-Forwarded-Encrypted: i=1; AJvYcCVG5WN3SsMVFwJTydwHJ1soTO8eQ4US1MiMnuH/L3q+67Cdvh0tkMYDiD3uEPevmgk8wLbzeMH0hF1geaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGgRv7WMkrkRo5M/SPVJFGU9u3UyG7TlKpcfl24ivei6mWF3k
	+sSJcqCBqfV5yQNtZrca6WjHTTiyDPovCzp2mqPA+hgDf7t+z6He2zHYfirpMW2ntJt/Z0Or5Ps
	DP/rlvxceuIQKOPrxlYq0Xs4ELojYSGNCb1Wcwf7X80BLVamMjlHIfycjvsNUYAFH6z8=
X-Gm-Gg: ASbGncsa7G8z+pukY4//JaZQfoOsRCuXQKL/ZV0lkcTZeyNtF0TtByhPMXS3JWSKhGj
	4tJREEGmE/oUROVai7sFAIPOebfFk5S2e4RYUUHMiuOaS0Y1ZR41mpbUJ4FKnyhk3He+NB1d24J
	+oMvZhalJdtNY4LZ1BFJuTLovAWiOUepVZMwGrW9v/iX7sSxwy232R/LYC2zQ8oJQF5w2OPxDuv
	4nPU6SHSOzIq2By9/Oe2qUOJS7QTgCi/9sKPAKs+nkbSHgH8ytnQbseiSDfLg88tXAUJzb/tPS0
	v9Sl6FUvxi+BKVMm2fT7lWWv8005K77sU/4j5ZcCR2GpIY6EAZjR9POJljWBMMzph8l8CWmuCIs
	znamiJUScBzky
X-Received: by 2002:a05:622a:310:b0:4e8:9c58:3282 with SMTP id d75a77b69052e-4e89d28b3cfmr45995021cf.29.1760691382167;
        Fri, 17 Oct 2025 01:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXmaWELNHeA4YfO9bK7KKaN2PbiUIZEHrtDSzzKi76qlVj6r6Tyv+8YGZWV56bOI27CdHbfA==
X-Received: by 2002:a05:622a:310:b0:4e8:9c58:3282 with SMTP id d75a77b69052e-4e89d28b3cfmr45994871cf.29.1760691381758;
        Fri, 17 Oct 2025 01:56:21 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:21 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 01/12] ASoC: qdsp6: q6asm: do not sleep while atomic
Date: Fri, 17 Oct 2025 09:52:56 +0100
Message-ID: <20251017085307.4325-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f204b7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=cAUPnWn_dBUFebge008A:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: CkM0He7xYbsgtM3WSBak2Avdc81d8nX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX6LM7RUzbTLBz
 tr+qrxGDmfiVTvDZfQapITCkMI8dV7x8fpNQvpj2WcyaPUc/9WOeN+k70GdApT+/BZbdO8Jkd0v
 h9xV68e/C/JFBDs5HCUuArlBtO1reOzZXE/gtN+diirKsQt8tD+yzjH3JRdoDNKmCm9ZhX1KXGB
 VNIOLcNjCxFXLevQDMJ5yzb3kA2N09gzaftQDEDX6GYCOXha4QIP59GppPsfpwIabSyKHg/puxW
 C0QERieC9nCLpXkbTQ3NXS2ZVr/mtGf1X3oLYZ5gb5k2IGInlgjSv3sdcnXnWjnamBM95DCnP/b
 wuI2xqMLBOEpn2u3bawavJPydu2IxYbkW7q/qzRuIHdLuXmDx77CEQ+RX9Zt8+qttHMQKCgVyXK
 pbZdCSSRRYQtlXVgLqz16B72a3c34g==
X-Proofpoint-ORIG-GUID: CkM0He7xYbsgtM3WSBak2Avdc81d8nX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099

For some reason we ended up kfree between spinlock lock and unlock,
which can sleep.

move the kfree out of spinlock section.

Fixes: a2a5d30218fd ("ASoC: qdsp6: q6asm: Add support to memory map and unmap")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 06a802f9dba5..67e9ca18883c 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -377,9 +377,9 @@ static void q6asm_audio_client_free_buf(struct audio_client *ac,
 
 	spin_lock_irqsave(&ac->lock, flags);
 	port->num_periods = 0;
+	spin_unlock_irqrestore(&ac->lock, flags);
 	kfree(port->buf);
 	port->buf = NULL;
-	spin_unlock_irqrestore(&ac->lock, flags);
 }
 
 /**
-- 
2.51.0


