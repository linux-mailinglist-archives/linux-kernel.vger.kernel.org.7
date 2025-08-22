Return-Path: <linux-kernel+bounces-781717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65EB315C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D37622951
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404022FC019;
	Fri, 22 Aug 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGBb3j3L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2842FB600
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859782; cv=none; b=UWrQ2opUdf5xScWHuUa2ugqGigXPWKplnuAwBIk8qYS6oMg+bUx1RTMefvmZr2c5Os9GtiX14Bca6Pz1jyVEGmjaasf90uNP3+pK/G/sQA3qSPpub/vGIzMQNiTcGUmp+Q1SkV7USRIk5WCDeYJmFGYgkocQxMQcU/F/F7bsbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859782; c=relaxed/simple;
	bh=ZKAlgxst8/m0craC1V7C11GB9Q3nugJsZw+QLPl6edw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt8aYZQnSfLrn/U5q7DOXJq2mERGcrAU6LyCivEyfqkxn6D7JwfP/imdmerJquew/pRikCCllqKEsGq3zIoq+sQJYD0CoamvOTCXYeuvr0jCPD5JkRvmHhMvMjHx9FF0Jfk2CNbXt1oYbRndFe03WDEOu1wzykv7qCHMynQJ+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGBb3j3L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UTAE018096
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ITmsHBmmXeJ
	H+4FSSoYGod19htesPhZ3ltd5XDG2GGo=; b=pGBb3j3LEe8rzER7Oik/zqH0Tyf
	jPeT1pQ8yT5msGcifOR2Csn8zL0noadBg5zvJ2F5LfdCv/OZkEAwmR7mLZmhji8t
	j9iMdBPR6GNlRlkyIl5iL2AVOnT9BR0LJaDFzhs0SpMzl/v/jjS3/tisWOs2YwQG
	mdY/TQTJIml41iaymUHIyF3eH/Sfsr8XewrggE0M6jZZquNlI5RiZ3h2FscrgnAe
	2Ow69qOiGHRK0/gqda5OrxsRPRybcpLo/ZfQvW7dwGWniDWeMOL+8ZML1uLWkBVy
	HfNSyvNfC+Ji723BGvCsc7cDLsew944Hj96nch15uHCfhKD7tMTt3l4UrvA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52b0st9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d93f57c42so20736696d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859778; x=1756464578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITmsHBmmXeJH+4FSSoYGod19htesPhZ3ltd5XDG2GGo=;
        b=YGTXAakmRsa7JPCL9g6JfYnMPAH5sZvU86NCaSsFdfB/OFggDXR0B9CiF1IkpORcCW
         rQJ/wRhdwgFoGnU23el0MP1KrIkj/yndTHiu1XEatNZiwPhvGnv7MOlBKoJgAjJVbfrp
         Qxm5DgA7ZQNX+oASXQWi6uPcHlFoUBmQFmJ/sRSycUCK58ORXdJh7RXI5P6SC6MlEK04
         bwYSmEIHuBni/pevAVPkeVq7A9/yKcSyce6zbx2EW/e3sApgZOzCjxKMKhNcRpRjaL2x
         YLL8/Ts/F0O5GOxv/bqLEn3lIv6/bf25f6u3Ul2fYDCrZogX2HWM9tT68tSeOG76/+p9
         4ShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKDccVl++LrUsXx4jhwXaaRcebwJ7gBX/B+m5uCY+ere7QEv75H7tYRG//qoTc8qBJk6QXYEH/TeelgHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0joSSpBx2qeTcCq3x+7h8Ozh0LPAf7UObv4phcDfwy3qquhP
	WkYyEpY1l/dqWG05Pmmnaf2C1njznLmZNpKB3MIOFcuZZtCiI2elxUrT5OiPLneuuCSlUGdaGje
	+4En01Jmxzg4EdXVhMIzldFTS5OV78jU6zEJsi/4yU+3OmcA0tT2bUR+gOK+0d9LL/fs=
X-Gm-Gg: ASbGnct0QVpnb9rJsqlq9Hqws7rZ6F8Iov6zBjKA2hG9t42gqQBYzKwG4AHRBRvPojC
	L19ZnqmfOjFkq3Od6RSzTuc+jsLS5pGE7K0lrFweHtvUkhIdVxCpQOu/gQ/qXxBCk5ntL/fmfoO
	gdUE1i9ko5jEvD+ZVMp4G9HFIXx4YvAhIeghDIkWII60xPGSEM9UrsXAsrUgXtEgYXmKPwR8/8z
	QSWQo/BNVafbUupQMCoAlpWu3IcrvEtmckGRMmP+EX/S0pmiqM/FxZcSIvPlQy/7a0ixMYU+W5R
	6Hhro8ERbr1QIlYLmtchouL+jYoJcArDJkNe5yL6xIpjQWCczh8Yog==
X-Received: by 2002:a05:6214:4505:b0:70d:9951:32f with SMTP id 6a1803df08f44-70d9951052cmr21887246d6.17.1755859778142;
        Fri, 22 Aug 2025 03:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFriKc6/N6ckQKdexpGrJyZySwTpjJo/jdMFtdFzr5N1m+sNgwNkRxbxRR0ZytSIN41749mWA==
X-Received: by 2002:a05:6214:4505:b0:70d:9951:32f with SMTP id 6a1803df08f44-70d9951052cmr21887016d6.17.1755859777555;
        Fri, 22 Aug 2025 03:49:37 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4249bsm31367155e9.25.2025.08.22.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:49:37 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 7/8] ASoC: codecs: wcd938x: get regmap directly
Date: Fri, 22 Aug 2025 11:49:26 +0100
Message-ID: <20250822104927.2621866-8-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0WCvBG///kXv
 u9eAu2BSknxHb/xdG4hUT6Q5KKyg1jF+dr3r0F90HKeJNm2C3oK7PafE4/JNUUX8xfSXXLiLVpE
 Ld8Y1sVUIUNcOpN8TPKTPWcMe22i26pZvNQtt7VzEbHxkR/8ATWWSwNV+I6IkiPBMoYFhXIaFvT
 RkSgRcLNPMu9teEV49A8ykKLQWZ3oLdVcbNjW5FsAkdFUqzCRfnTkzqCzeXvFikjTV5bM+ubyC5
 /gAXksL4pDGANYtEI2qvGmyU1ixPxj9B9SkCxtTnfawqFscSp4AIf2T7xXXL7xOD6Y4XkYqf9iC
 2tK2++H6aQVl+b8OzP9NjANMjPWThYY3qUY3EcrP/+0/oAIWaTav6f9ZayFkWT0MumaTNKZ+jpf
 +gKP5Bzs5opI0ryCbVinyxafw4SWrA==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a84b42 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=AeW90Tct3s7Q8B8mPpwA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 0lPEYF64xXjsY9KexaYUVStrWbCOdciu
X-Proofpoint-GUID: 0lPEYF64xXjsY9KexaYUVStrWbCOdciu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Remove usage of dev_get_regmap, as this its more efficient to directly
reference the pointer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 678e4052a255..70302de904dd 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3388,7 +3388,7 @@ static int wcd938x_bind(struct device *dev)
 		goto err_remove_tx_link;
 	}
 
-	wcd938x->regmap = dev_get_regmap(&wcd938x->tx_sdw_dev->dev, NULL);
+	wcd938x->regmap = wcd938x->sdw_priv[AIF1_CAP]->regmap;
 	if (!wcd938x->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
 		ret = -EINVAL;
-- 
2.50.0


