Return-Path: <linux-kernel+bounces-845600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B8BC57E8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0994F4EADB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E302ECD20;
	Wed,  8 Oct 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpR31PHb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF62EC559
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935491; cv=none; b=P5K7d0YEGb++YG7H8Swql9sz4ODeq5YAF3izNyjzx/fkHE8nVmQDtHNA1x5JZIBhgTOk1HBrJdCqO3VLg/5H8ZCBBfudI0DnnnpK5h4OWbeUVKCd5l43wQOSuEZsPsfA8LjjmNJBegtyb4BHpcxOH58y9ijX9nhirjbCoMHOM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935491; c=relaxed/simple;
	bh=5V4FY1lGCPXLwOcBdDx/5qV1DoJAfuAXFe8DMG4W87o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeMWqLccXH+kU/c9UNGhW8VWDKnqs/8m1++IP9uktYvrvF5eAOY89mCoXuK3O/3MEYI3+4zxOBT0Off4Un+E7sx0YpCFu9LktfeCPCdG31RxQgHH5wI0ZBzM96edpgLBN8odcHXegi9tZU1KQM4EbQVSkSX6nsfZ4wjtCGX5hpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpR31PHb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OSS028792
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 14:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gg2XGw954hw/rNzVk11kaod4ZGuB5Izji2/
	QJiTgN50=; b=fpR31PHbNQFaoP0jHLmGl4/ob/VfzSwr+TexkvmZW/2LsaesVKc
	hVcEvVpFm+Wqi/dKj/jCiyAeF6mhOGyOhw5Wh63RjkWS0Bd5Ma9xERWrQ8GvM2O8
	Ba5sqwCOyLiampeTHEPlVJ/NL7cWjq72Ywab3Mv2MrysAv0420r+FVyd7n82S1Fk
	TBTQ8nlXsgHDOw8kJjoejrAau1NJPEAsxwpsG4BUhceMYZuPk9XWQkfmCEprelx4
	59PPG2TkYgaz5+1ZkrjNLgg5Hi7AO13oQHPmuz8xrnAR8bD5M6oTA54ZAszkO/1Q
	8tXKbnEBcFEaWpGg4Y/1Kdab/CzWNcnOYBg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgtyqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:58:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-782063922ceso7005281b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759935487; x=1760540287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gg2XGw954hw/rNzVk11kaod4ZGuB5Izji2/QJiTgN50=;
        b=YodaCVJwMUBqIak8kgIERKKJtVWRQqqM3g0q3OGSRfyPP6EA1CTSno9kmfQc9BP+LX
         MmCU6+kThJsJDHqQtuuAayIYtY6bFSHmOcaID4ergKcEot0TylBolkrvSlPecuk4U7tn
         xAeHWbfyPbtBfBLmGp5wCFv8lWht0oRzX8ktdcDexICISk1KuCusxceuWnlt7gzLqJ2f
         B/BmZh/KnzKgxGFm1hoXM7YQX1jeVBPz3zPKRT81vrGCkxI9RMml5kn0XmelbMjYEkZw
         KjUk2n9z9AhV8KUYeYcYusTN3VXJsoinwb4qyXk3FB+7paHHGeTtK0/ofNEu5Z41frOz
         Jpwg==
X-Forwarded-Encrypted: i=1; AJvYcCX66RlwCXFzeXLL/egIlAwW/JXm6w/2xi4E0Ml+r8yOEaqTIO01KFgJg7BMoBr8o8jxWUCyFsX3aH/7yQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBh+E4a1Veh3qP0L0mYVg95puP8mDJmPTVH1Bak4D1WKQW1wBf
	vW0uvT9zKkgibyVOic7+ja/dzRb83RrYgl7y+HHkJ9cNBfsMciWz4WGSxpxDg53hKd6lzSVQfYW
	4La+upi5P9dGL4a2rxhf4ZYarn7Soj3tHFJm0bSh5Vqzs7FuikbdNgqj28n4otUq29ls=
X-Gm-Gg: ASbGncuaaCoaS7cN+bs+dEEwE9wryfi+cWrTrO5KVYtocPBQHODAgTx6zV/HXBJb2xL
	p9SmLsI3O+zlr1f7zDygMLZuw55RGL4Zhc3fCQpmMJyrW6yloGyRq0biRDsVIP5qEzwLr/+0AvA
	5g8NuAl7DdhpSfMSlqdL4ZBs41Lk8u64TLww1hJTwOVHHSkzFKpm0+cvcSXlbHG1Bye4fAwHxzB
	Pmy3ZALt3JQDQ7+7zglPmrULo/QuToFNz0o85ZWd5ovrcC27RGqaSAzZbGBt/OvYqrxuVHnxNJd
	1AxS5abufArKI5CRlOEw3aJLhqSRI5fphUK63znnSQRVSw37xmSR0JKWDaO+cCTZdt7WHsDtJMc
	=
X-Received: by 2002:a05:6a00:3911:b0:77f:3a99:77b1 with SMTP id d2e1a72fcca58-79385703346mr3825678b3a.9.1759935486552;
        Wed, 08 Oct 2025 07:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW5q5j+m+RGehMEdTTXNFPYB2WX/itVnHJwVii8g/LY0p0ro5CAl7jexOkZcXjHDnVYlqG9A==
X-Received: by 2002:a05:6a00:3911:b0:77f:3a99:77b1 with SMTP id d2e1a72fcca58-79385703346mr3825645b3a.9.1759935486009;
        Wed, 08 Oct 2025 07:58:06 -0700 (PDT)
Received: from debian.Hyatt.com ([192.210.17.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b84sm19068892b3a.53.2025.10.08.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:58:05 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: srini@kernel.org, perex@perex.cz, tiwai@suse.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH] ASoC: codecs: wcd938x-sdw: remove redundant runtime pm calls
Date: Wed,  8 Oct 2025 15:58:01 +0100
Message-ID: <20251008145801.3479-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfXxUgxiZ60qdLB
 4AWxhpHcb6hJfcblenguk1jZGynvsQS8LsG31VEMOxbDZFu1iRl+uSScfQlfRXy5NWISf5z9K4+
 R3UocUrpGt3ikZhOch9GstCEe7mrKD7UPUv9Tp+RaHFPqGu32QHSXqmwLvHIhNaSGTpsMqNSJIT
 I+3LTgvaDMvtIYwTNe40QHRlDGelu+eFYzLcTJpjHZc0E3jzsqHvBVbpxLzDSIU5KOlditELusG
 Ji26KwxaLIg1GXy6sKMujJVI7p9QU8p7Ciac6uCU4lpXje6d5dqdLScRIrWF9t3Olg+yljBSyq1
 NY3PrDp929DEY+RHU76DufFswAdG150eBaGunJMVaE3bSIgLQ7R01ES+xbg6M1qWaCyWhUvcemU
 RVi70LyRDYQ2TAlQ6ie2e5mWk/HNbQ==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e67c00 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=3CSVYe8HblTQFsWiJzwA3g==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=J5h_BI_um8seuJrpCkEA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: MLA1lcXUaQB-6L7al2YykILcgokrPB9P
X-Proofpoint-ORIG-GUID: MLA1lcXUaQB-6L7al2YykILcgokrPB9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

Component bind callbacks already does runtime pm calls, soundwire codec
also tries to do the exactly same thing resulting in Unbalanced
pm_runtime_enable and disable calls.

Remove the redundant calls from wcd938x-sdw driver.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: ebaf88c0546d ("ASoC: codecs: wcd-common: move component ops to common")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd938x-sdw.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index add907cb2706..8c8f39d04972 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1207,24 +1207,14 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 		regcache_cache_only(wcd->regmap, true);
 	}
 
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	ret = component_add(dev, &wcd_sdw_component_ops);
 	if (ret)
-		goto err_disable_rpm;
-
-	return 0;
+		return ret;
 
-err_disable_rpm:
-	pm_runtime_disable(dev);
+	/* Set suspended until aggregate device is bind */
 	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int wcd9380_remove(struct sdw_slave *pdev)
@@ -1233,10 +1223,6 @@ static int wcd9380_remove(struct sdw_slave *pdev)
 
 	component_del(dev, &wcd_sdw_component_ops);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-
 	return 0;
 }
 
-- 
2.51.0


