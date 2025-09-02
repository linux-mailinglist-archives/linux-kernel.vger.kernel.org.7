Return-Path: <linux-kernel+bounces-795526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8CAB3F3ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5711F7A8CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1A2E11C5;
	Tue,  2 Sep 2025 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqOKYmKe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB52DF12D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788976; cv=none; b=NxySDxJnkBGKIwsJPUAnioNtyQBGQ/y6Rk70+xIITvILYm9PnRm59x7bZQFZJMpFfDvjymLy14KfAfYFWJ9xaxwhlJjgsn0Q8WP7DGp9pohxWwM5i44fzOGlqj4Lbf/Rx4k5jym9wNcEk/u1IV0Ej0H6xjiHw6gL0a3J46r6lbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788976; c=relaxed/simple;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dq17VKDzXOk53jsfmpxerLp7LTKKLkCJVfRz4MUUYFMaJ+KFk/ZYC7qFdSoC/WSmLZv2uMphojIXQDqXsyKNLYuhWrhGcemVSGVjdAUGzym8czb6SZQA0iWlyr5+LpyIxNKN5MWspkkwbl6FZt6TWGPNSpodKTL6pkiRqVbT+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqOKYmKe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RpOI015197
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 04:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=QqOKYmKe0XQ+cJer
	S7yxq/GR/a8nz2SpXqpPS7AHVNwRYITkRQoGmkfvB/adUqPOkFq+yQCKXN/giXly
	8ExalnQXrlVApG7T/ZJ+3YQl9jeCmpe0EEx4pUZkjk9uAIexpTBlq2IW05Ld27GU
	7GEHAfKwBSnzfaOd0hofr9x7tam5xHVceVvAaEBO/aDzXc/QxR7qkLjQkYCrv1cu
	wd6xto8mmM1dLy9UV9y+ZNpS7meuP5zX2gKpulzdYyXWAsz4UQLPl+f+bFRIiJtF
	QnVcOIAXlZwX5QpuYE+a04Od7X/cexzX/sN94rYVgs+HNDv4IB7+bauLgSw1OnIv
	+Htl1Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxhps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:56:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24919af9fc7so24682865ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788973; x=1757393773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=ICG+n5/in+qYKPm3qNneshPYYJPwKlmRvGsqcOge8y5JXc/YtUqQNdbrSPgiYCkdbp
         7li/xK6ZrVJkmuk5MP1mYHvP7VoX+YMGd+UXaWI/6DWGTYFE/dfxzRugmNrrIj2YknNH
         7sw4ocGy5K6pcW8OJS4H+k925jtm1q3jU2T/J/9bpQlscOSg+U7hd85MnTHb1t/14efz
         B089rSmMA0AZmoKai43iCpgCStETDNahHcAEOIm708yX5WK8zlY6UmeyeMV2TIpqwTRt
         ZxYD3rnF0nQhsqH6fgkQz9oTPhlAUEVpUbN55nRM33cd8LXvC6fa+sQ+LVI68FKZS/t1
         v6tA==
X-Forwarded-Encrypted: i=1; AJvYcCWwLth20nndgaS5gMVe9f6gLwbT3y6M9Gtf/pqStxNEmkwKoiWlbP7tsR/6Jrkfc8HbSY22m2TuzDb4uoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllOWh1gm4YhvC6XHAOvyZPy9IGb+bApKNu3YryBauqdcfOZRd
	bexTvQYy/1fC9xbttHaq0M3TDbHBPNKx1F71BUZ0HG77fU+VNUZPIKLhErU92Ljzl8L2SAq353J
	fai4sNt1UTpkgTF2MKrUEbKIYHOU+gvBylWWAZvABAfdV9KNtzMccu0xfr7klS1pSCg==
X-Gm-Gg: ASbGncu084U1qXmXOSjkqu/n3f4hYoc1Dqt5peAo1t6+00k8blLfuBEUHvUHVaNymRD
	On3MbSGoJ2uY2xAjTgzc7ysz7IhWkORS62wkxICVuk+tNH56ynDYKZn06cfK5CLTwejPT6F7WSk
	fztkqBtylhR24vYC1JDG/9vQ4cMkUIJrpn5HG+/XW79FJLV1YD41gddnPq8AyUVoGMGoNa8H0i4
	AqgA8Vqenh+VXIDdRsVEqGi8nucJ0C68nKrd0F5T2wVZfKM1mlfq5a96X+XD6LgOgbldu8p/p9c
	bcomg4nSuVAPGz8Bl/NCSwXItIHNQm/68e2JprncIQhCEwzy0yD+3dwK2gMzdqyQca2E2vNeR2A
	+zu5CTQasN7y3Ld/T7WnNXqU=
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr121474635ad.55.1756788972823;
        Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvJn27s/WB6VKXSdt4GGDpr0OsZic3u0pMEKyv76QDPWFnyOWUl96Fri/gUJz77+TBs2FX6w==
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr121474415ad.55.1756788972346;
        Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:11 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:48 -0700
Subject: [PATCH v9 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-1-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: -rQ9vqG1stWA50dTnu8q3EEKOLB77s_u
X-Proofpoint-ORIG-GUID: -rQ9vqG1stWA50dTnu8q3EEKOLB77s_u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXzv5MxBN5RkCk
 kLEiYfED0bsafBtM6WVI0m2uayzaV5ntceGrZGF9x//0ZVdrm2eAMs1NSg0sXvr4X7bzCBOScnm
 sUwcBR1po4JSb159lLTz9v9q3EtdaTXRgMk9Wsvbt6sRffPeTycfSftGUVKqYFwufs3v4LM0BSi
 fzlwqm5vw1hCdGnuOaU+ZWwdmBEYri/ILYBWpNxoerXqNeObukzftZNqjTb9ovD4FLiwWNM219Q
 Ej0m4fHbq9VXIkmjlEe3d93cej4bdDeXPYsLyIYfcOf9cOx1BpBMdZzvSs7Egti4L+aAwqH6u/r
 v7cgS2ASUimJYDVnJeeG4VEt3t+CgLHvZqJYPRn2qWk+ZfLZsVq3qHRSACo+QEmKC0nk7GeQtJG
 f925CEKV
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b678ee cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index dcd40c26a538..33091aa21be0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -852,7 +852,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


