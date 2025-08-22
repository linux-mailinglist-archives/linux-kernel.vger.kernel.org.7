Return-Path: <linux-kernel+bounces-781718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B6B315DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1751F9E3D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068B2FC02C;
	Fri, 22 Aug 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEAQ/hzc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3C2FB63C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859783; cv=none; b=KX/98GDb3ogzTFt9r2c4BWUkDVo+lDCuJs+6oXJHVom6wkMcH0tKfpa9IdmIWDOPPG+nFslCVGy0OSWPOAcPdC+iEmK5hDvtN3nZ0o6JS+Q5PPHoS6dnEPcRrz1EB3TDE11nJJMR/R0pp07SSXqjN2RtM4+FdrJUW8n7VOM0m6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859783; c=relaxed/simple;
	bh=/5tS1Na4bhQKzK4q//dUm4k/XvEXFSaGVZ5qLzvaXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qcfkmvns0hnMy7yeyx8r3y+3yRVZZN3uoBiZmLczcbvP9YKav9SFqzSs0Zrcn39y34FXJP94mqWojZO1nWibMWE7yt+4KdYwqbVawHpM1IJq5nabr+nc2mtg/NZYYGhgGW2ZjZPgPcb3h28T26GYqvXTZChjmCfmO8XjzlnZGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEAQ/hzc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UbxN006819
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mTLagKpBc2r
	L9dFOYPZ/ZlF6mHj5oBgr/ydkac/ztb8=; b=DEAQ/hzc5IuuC1J0CWynQFpe+K6
	GfZwe/49TGEvWBu9NmyRhCVeiL1zHStnGwQ541DwTVKBAfYPQo1mkk5T7TA8H5a0
	JWeP5SgXQnoF84nJ1WuI9MiQg4m91hdthwqSAox8kC5Wo4ms7F8sQpM9/W/5kn9E
	t+2d+zCgJQnyP0FAJyqsS9AVGFqiMNmZEbj2b/ViSVl3qbXZOxWsk+PfTXVcqUlk
	DlyGOzExVIVJpp/i/ervIIuMJbB3vjeiDj3JAWGPmaXEYo+/Dh+1R2LKmEZaF4Rm
	wei7ShHDF1KWjpegQLkYYn5K+NPydZPF3b/ktqrYtSoiZ3uq3e21OmVDigQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290wrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d9eb2ec70so2490906d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859780; x=1756464580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTLagKpBc2rL9dFOYPZ/ZlF6mHj5oBgr/ydkac/ztb8=;
        b=XUyuZFn7l09XwKtOhbCkI0dAs3O+B5sdkqbwIeCJVxpxdZaiYCBmOC2IK2vyGIViA0
         w5MwpyJUEx5C40j0whSx70SzITVRZRt81J7LFrxfSkf0RngMrRioJJelyzSdno+TrxAr
         R873Z31xPdEGgGTwtrcDJwLV6T4ANsfAF9/47muAS0RKXVw+ErfA2PVbqZgGTBpBvmE7
         0/2qhPvqO3SLjeDbW91ZU7oHeN5TnaGmOmIgpMzEDkg7Ti+iOhVOzp1DetlAU2xqTlBX
         mzFnWp0UY8kEkdA0fINdE6ZP8LJjUyFrTuqOY0rv8jZS6lVyc8YNZzgGg5HTA2cQKsYP
         4i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlAzGPrefVWFDYGTOpwRpjDSaPzAb9zaTuHw3s0zt3Uh0SL/IiOBT9UkDuTKa+WoNC1astUr7Dlrtz5AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIFxutgwVyoRTFhyerN+v5v4SNOKwqWwYyXfvrGXgRZ5qAa3/
	njCY1SUEweP+7FWPeoVMjlWpzLGawMqjpSU42/Cr/hyejvSTn0M09kaca2x5vAideVOWM1gzT8s
	r/rV/xmbsTZlMXl9/KEni5ln51FHt+8o1xYqlrS4zUfSsxRW5SE1Txr+z1DFo8jSmuow=
X-Gm-Gg: ASbGncsBwTKEDmoTe2d8fyDalfWzGoWicKSeiI4TtGK0eDSVuETiuX8yJ3fIOVcyps0
	w5NjpGmunh5gbIzfUFTmHgm3umzXe9lTXzQxuHHL7WNk64pQWhtcO6papfx2Wwo0DxbSPYe9T5L
	8xaNeSnXoMmZH4ow5FVe9pFkv7OSr0eze8v4f5K/yS2tsoZ+Jx8sv8bBZ4qoJIXfprxGWZLxFWS
	1yVxUI4SDH+XEf3RuHieR6FNTrfUsbijkZJUZ3ezobf4lseowHaLX/SF6EteqLJFW541idwcClG
	Tp3S3xfy3Xt06ueea3wBXu5SIiCd9dLVr8OQf9qOqS4xML5mOxZvoQ==
X-Received: by 2002:ad4:5bc5:0:b0:70d:749f:177 with SMTP id 6a1803df08f44-70d9738f13cmr22244186d6.33.1755859779919;
        Fri, 22 Aug 2025 03:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq8uCn1ut3eJy6YOI6AW0csMB8mZIwD16SLQFg3+7MgJapILlN9oofWVuaked14v2/lFDKjw==
X-Received: by 2002:ad4:5bc5:0:b0:70d:749f:177 with SMTP id 6a1803df08f44-70d9738f13cmr22244096d6.33.1755859779504;
        Fri, 22 Aug 2025 03:49:39 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4249bsm31367155e9.25.2025.08.22.03.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:49:38 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 8/8] ASoC: codecs: wcd937x: get regmap directly
Date: Fri, 22 Aug 2025 11:49:27 +0100
Message-ID: <20250822104927.2621866-9-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a84b44 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5pqs-Pqnn3KeH4UlXPsA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: WtiEd3lxciCe5zzHTnSwqgPMTavzjXEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX66morVH/nbS4
 /xeiKz+zT8NVMBjL5/3Ad1SvuHA+KkvET85/46KWVTuFOKDN6LBooeItZTFll/3Sb8aUJEeHHpU
 e/jtHPCCb37umMjHNCRBlgAepYqt2OUGEZec32Bme+4l/eSZeaJ31fxsYO8o/lRkjdvIPvHcgUH
 XQNQELYOI87uBFtwdRwMV1RG2US9DNacz28k1ttkyHCQY5vzlkSsSB6hAmLDk8hZoaL7hvn6ZSw
 rVnS2uC+pMHYYhx6yCYYa78R4zaTqd4ji5DAtq3no9ziEQrmxM0pAqzpNDditUsobOPpdD+SXZ3
 4P/6USEUmHwfEqXktRytZclBszdubUDbQlMxAwUjSLcrp5uAyPOK2qdHAyFPNpxy/E2uP+KjuHO
 psNGqvA72lyrPzcAm/fwzUPWn6pd0w==
X-Proofpoint-ORIG-GUID: WtiEd3lxciCe5zzHTnSwqgPMTavzjXEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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


