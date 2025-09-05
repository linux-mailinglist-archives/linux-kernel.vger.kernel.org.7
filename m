Return-Path: <linux-kernel+bounces-803277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BFB45CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F5A5A736A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00273705BA;
	Fri,  5 Sep 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SExit0Tb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48C302166
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087096; cv=none; b=D4LmazzcFBivfK0I+g5s4a4AscqZGAOozG9F3fsygEdpz/S9yslEYsvJVabjOLgkS7wWGKvG/UmvdLA4bLecROPuE87GifWOtkpKKIPf4ECGqpDKV3khTt/gbz+HyVZJCv1SEfje56V/bevLrFFeO729aCBbjL2e1oJj0oszt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087096; c=relaxed/simple;
	bh=/5tS1Na4bhQKzK4q//dUm4k/XvEXFSaGVZ5qLzvaXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6mSW11VsukgkzysF1v0LNscMH9X8Xf5hkJ48SXQMnFPdLKvL6uajoyfKRr+bL55rJi6M/4dvbbLADiEfuT32C3ix4LPbL1XPtSyJlSzazgg/MVmJJ/gaBKQMRXwN8tyvU7BbXMF1GUPhQDwekq2P+8XjTRy6KgpOX8CPS8ClBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SExit0Tb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857K1ED007609
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mTLagKpBc2r
	L9dFOYPZ/ZlF6mHj5oBgr/ydkac/ztb8=; b=SExit0Tb+n8lSToMlcDLLokZP/u
	nk7QXrzUVMxnKsqKUC51rQgeHqTohoAPqOk1ZIknTxdwxFNQxCq8Tj4DrXGKxuOx
	aiRLouO2APKuJu3DGnLdi+7u1CyKljrzUw20rR0D/y1HA8RXFmCd2VUOf12+DsqX
	/NCC04/Q2NpWWGCVNQ9ZmYkHw06CprVC2ZWuT5FLx3p+xBMrBFWfcg3XoTC6Yjkk
	qUjvYFdjwUbo+0gq5i0l65ffVmvI/hvdaaMExRD04wIcjQmXSOHvzvNjDSIH/HLb
	i56QHD37Ms03boC2uhDB9aU2JWM7wfUJklGbQCAaVsQMpxb3+Q5yTAYZbhQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura93fx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b47b4d296eso52456341cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087093; x=1757691893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTLagKpBc2rL9dFOYPZ/ZlF6mHj5oBgr/ydkac/ztb8=;
        b=FgDos7xkGAhgfsUKtitPLd/zVtGdRLtsK4Djp5iP/93DLGocck4oafkbrwp1202SoK
         QU/ycNo4OF9iS97nizTFUvXawt3qa6JeBwRVKvY+HzYgle2YfI+aNt6ekYBkz7VRb7of
         bLGF5J9qv1vMs7j+CU5gJJNdq5TfZ9iwO2gSqpD4OevtL/2v8qShh4dL0cCaG539Ypom
         6BXOwxEZ8hxZDmCv66/1Hc1eyhtuIB038NGhPzX8GO8v07x/VELw0a+Ixm6d/PnNYT1d
         j1SMVXfZlZFP97cEJ7efw/YJ16g19FRb5QY8l9/shFDv/6rHE/fgqRXb8LUrD96T0CJ6
         Jqaw==
X-Forwarded-Encrypted: i=1; AJvYcCVXopDBEq/ezg/HXuPkIyz2ccg9isoMUgiyAooi6OVyNGmGFMwbapTKEjb4p3dlNFYmgdMqyzPdjYdhfus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLu2ro2z9uRVCsUimBvkQFwDR8V1CM3GKUOzFEyPZYVcc3dcfq
	7uWyMarI9Fp7lmg/h+vZdXOhjVY7+q+Hsx1Snc4NCrGLDdG+9zQC1Gt1gLjDbeAvmrk5qbf0mrf
	sDaFM7OcU21h5jx8oW9LrMXyNSXa/GY7IXNL/sT30ujgRAWmVQup7+g1h2iNGpRphqVQ=
X-Gm-Gg: ASbGnctusVTZSRQNo1dzzFB4d0RPh4/w9GeiE109IAuMCSZSkuU4yIf46wJRWtMWi2h
	v+R8NsNQhY1CGnzR0oGc4dEUk2zBlQdz9eYMl6BEeMCeNOLcQqYYuorgt7Z30gsB2LbDr9Vhsmy
	K2UXKTt7iJX/Uhi2Jn3HsQJQKkJbB1MMnX3EjmUtnKJhtOz97rj3naiae7ouQuIfYs8/MVRlWX5
	jLKkeVjIIgImbBxlyvu3TxkBol9Gqy1GJcrqqx7e8KO/jq8+JZtnESX1YEmt/c17zxc6ZE/PJSV
	RPGkoZXQGgMaBdhEd7JhxcBjidlpovJ/1p8oHxY4zOENEGIJn5cJbA==
X-Received: by 2002:ac8:7d02:0:b0:4b5:ee26:5367 with SMTP id d75a77b69052e-4b5ee265a2emr30882541cf.76.1757087092584;
        Fri, 05 Sep 2025 08:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaXM5xYiTB//e6nEVW8d4V0nDzBo53JeNS4CwOwWnvV1IpsnA01PjZg8fUI8yb7yuS5+Sj9g==
X-Received: by 2002:ac8:7d02:0:b0:4b5:ee26:5367 with SMTP id d75a77b69052e-4b5ee265a2emr30882001cf.76.1757087091954;
        Fri, 05 Sep 2025 08:44:51 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:51 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 12/12] ASoC: codecs: wcd937x: get regmap directly
Date: Fri,  5 Sep 2025 16:44:30 +0100
Message-ID: <20250905154430.12268-13-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5U_7__djnUEFyQYxrtLzfzyzX1xFXFaG
X-Proofpoint-GUID: 5U_7__djnUEFyQYxrtLzfzyzX1xFXFaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX+m3n7A2+m0rx
 uaP11UqldeJYcbyQHvlnhmVSpO3KS94rc/PYc/ri0kHTES+d1C1ynHP56SZ9+SlbmnTAyJ6cbxB
 MpIM1SiMJsu9o07B6kNRDpSyO/bFa1NWBiBVZx7kyFp7TzXSjmpriw8VMhLgE48POE0ZCy3ceb4
 X25YWXZXCda+15aQ6glNvkkui0ocNoaggfh1vhvgpkfa6A5nN6cmVbmZDKxE4rSDapauBgbks/m
 ZAuezlpLA4tz00g71NzbvaF4iFV2sAf0dQguMbyzz2XQgFRT1d6Vz7X0Bj06TGbrbOLiMe660Bo
 0tXZ6DJVU7O9IHo3AswxvOoltRr1RByvvllpz//jvG6YVjgRn9lW6a5ryRmTlCd9I92dht7uDLY
 LkhrwO/P
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bb0575 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5pqs-Pqnn3KeH4UlXPsA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Remove usage of dev_get_regmap, as this its more efficient to directly
reference the pointer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd937x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 5c8faff3976d..2064d707ab0a 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2790,7 +2790,7 @@ static int wcd937x_bind(struct device *dev)
 		return -EINVAL;
 	}
 
-	wcd937x->regmap = dev_get_regmap(&wcd937x->tx_sdw_dev->dev, NULL);
+	wcd937x->regmap = wcd937x->sdw_priv[AIF1_CAP]->regmap;
 	if (!wcd937x->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
 		return -EINVAL;
-- 
2.50.0


