Return-Path: <linux-kernel+bounces-803276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A5B45CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019B25A64F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629C3728BA;
	Fri,  5 Sep 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HjY//Ajo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA252FB0B8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087095; cv=none; b=LkvGOVAOLLjSO1zKP9FSG+1qfqwX0O0KfRN3+EAhF/wVMZ3hnuwYLN5AhwxWqmZkhHHX0osiyINRRlI9XJQ75qGcwCrqy1bKmb1au1xa5Nv9fKE2+/klrYnnxffnPAm3vh1J2HOso0SxdH1OIh7QNDt8/na8eKc9TFzaLkkWwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087095; c=relaxed/simple;
	bh=/U9W3w4dsWi5IE5LjHFEmTpr8qAztaXo6eOJbgusxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCrRYGBkFffykN9dSwv9YxtUPu4ppv/kE1wwJopRSnHW8czH2ZUmsusN0XeX0l/vNCvVrYUn1IHoli90VDYb/Viura7lAjrbBEAD9Z35w78AJHCKtil1f+RSsmYmTzqukt+xQ0MPUrrh+wlI3BJ7jdn+8uPUuNSjvW1WQjwAlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HjY//Ajo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5858WYAQ018519
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LsCJ17/WHR/
	P2iA3/0CFtxLbSANoJEOEN/h40JqWb6g=; b=HjY//Ajor+K/hp0gZpYsBs/g62J
	JpYUd55yBAjbWpkzmDjo/ddA67RvUOh/egBlasYdSAqFfRVzMh1eLQ5dGP1Mdk2e
	EMaqi+g+hUYlqXqYNSR4UFeLoVsdE5LLdTR0Voh3MMHgTo/J8U40ZlwjSceaA5j5
	tsAp+IX8wyGGRQq7udkjHPrT76FFSRtDYZwh58DA7mt0Sy88A0cNFf5joSnb5YoW
	hFg9B90uG6m8q1P5tsUCaNPQK2xwbHkGy20yoJujTpCrm7KFhXjumoia0nvpEHHg
	SBI9RCX8dtZvjMx/vx11kVpRLa8kamYtCCNGmeTivvQpdFvEFUdwxVH4ujg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpkrc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b34c87dad0so53007461cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087092; x=1757691892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsCJ17/WHR/P2iA3/0CFtxLbSANoJEOEN/h40JqWb6g=;
        b=XysMoeR5DZF+UUsTwyamVvALwiFFQfT6xZp3Q8ZETd4mxmckw4tX/AQjM/vnoGIQ0Y
         +EloBm8R3x9HcSvHh+AixnJgvC0uNLRtdNMtP9nN3haV3aPtMOUCmXFirse7KXiCIUOU
         DkwGBIrHUxsaA6X6Se1rHY6qRL3+u+NIgHzqtuOqXOJMpnlrLUz7wot6ZyWh92MCubh1
         KV0gDENGURtAlqrOWW/B9klDpLUt2T3gIF9LFMtfAoNo2iJRdXNbiJ7hxlVYm3mp5IWo
         zbIsPeKISHSIAxi8/J9hiBW8ontq7kypP506Di0/fxA7zcTOSbjAdNcLZkIB5ch/d3EJ
         kFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT2cVDq+lQrHJvGNk3OyY37YmcBXWrkLMtmVvNL0PceEBwnxrop9V93Ith+gHICEps3GJSbuStnQ6xZPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPmd648sIjGfTxywKkDkiMnS1xUFvdqCXa0Z8s7fWjV2BVGKx
	6iVMmJggeky5m3TiYD1ra7sQ0E2vM6gxC9FkDdEooQN33kz/m4BjrnBEgT2AW7eQgBcsf+OT0ZI
	nCpyfHqek64A0Jhwls5EP4cmYWvm6x1bNs9BsakGtNS5Mqhi1AhfXhCtciBu+GtS8xD4=
X-Gm-Gg: ASbGncsiMBl62UsnMLjacFfqGQtbXXgdbXGlYUrIP/aJpHkwq3P2yDc7mbkr6A7wvZO
	tsf7MOb7tvMs9HZHBgKUSlqypPNn5WARSdG8lXxEtJSRCxnRRI3PJK6SZ0cFm8wLVjVxpUDAACb
	0g2DyzU6XxgnEnbA0/xJPmrf5CgVQ99+j5OPg1B+Su97bft6uD7q6vbI/QsQBU16WHZi1ZmqhOp
	yR516+Otu/yLGSIkgNqwQXP4+Vo4skQmelTt5l1szN7eNhmy/0Qh8Iw5FXD8Qy66tor3SaNqNXF
	389vbypGUvP8n6aiMbNd1wSd7ZsYoxO3MJVHdPVPCKsPL3f5I0Eg8w==
X-Received: by 2002:a05:622a:1f0a:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b31db65fa6mr319517591cf.56.1757087091529;
        Fri, 05 Sep 2025 08:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdhep6GikAkazf0l6t8i2x3f5Z70bfCZ3Bnt13gdUl0CJAAIC5jV9yr7/tdMQ8sW4u617haQ==
X-Received: by 2002:a05:622a:1f0a:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b31db65fa6mr319517011cf.56.1757087090929;
        Fri, 05 Sep 2025 08:44:50 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:50 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 11/12] ASoC: codecs: wcd938x: get regmap directly
Date: Fri,  5 Sep 2025 16:44:29 +0100
Message-ID: <20250905154430.12268-12-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: 2dDFOfZTC4_wn1V6xQ-eiUDNboxmNsXp
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68bb0574 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AeW90Tct3s7Q8B8mPpwA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 2dDFOfZTC4_wn1V6xQ-eiUDNboxmNsXp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX1P2T8raM58i2
 CWl7Iupm8cPlMsCk+ke2cPvjtlJ72bozsfABb1/OoCa5T5XS1DkpeUL37TiIQCy/bqxyKyxCcJ5
 MkwtHQ1o5Bm4k/e9C1Bg27h0kmvN3g9McFdyIkzTkWylK1dNnmtzVCCJjD9xmlG0x6lgSMSCqeg
 ps1VuW/7G3H2Ue9qpn4JcuUGgHs9qQhF3P7EtrLofvYd193I1O1XUWNV5LI+JlPTbTZcVsrzuFI
 2UdXMiE7FgteIIZ1bWzYlB+n/LgA0f0o5trWz9g8c4nDzdEGvw9BgR/b3i2K28w9MJaabAWurEI
 UbEW3lBeFwb6QZfGywcMVHgFXnPjwrEOvlpxo0vDHwjol+TH26DHLIfhhgiz2VS1Gq6ewqdtjIv
 2JaDVOwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Remove usage of dev_get_regmap, as this its more efficient to directly
reference the pointer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e495f98972f1..e1a4783b984c 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3389,7 +3389,7 @@ static int wcd938x_bind(struct device *dev)
 		goto err_remove_tx_link;
 	}
 
-	wcd938x->regmap = dev_get_regmap(&wcd938x->tx_sdw_dev->dev, NULL);
+	wcd938x->regmap = wcd938x->sdw_priv[AIF1_CAP]->regmap;
 	if (!wcd938x->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
 		ret = -EINVAL;
-- 
2.50.0


