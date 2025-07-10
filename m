Return-Path: <linux-kernel+bounces-724920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C0AFF889
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597915A4120
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B972905;
	Thu, 10 Jul 2025 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVGMJl0a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD27284B57
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125687; cv=none; b=pfGWOmcg+bDPrARGt7TYz9xk/Hn3zfxwC7WMlpnt6cwBmfaBCcaza/CbdMUmwzYVwsf2NBSOF18cM/U1XdpyGbVbQsJ06ha1oNYEOSL/fUrAZREYxJ5EVUMawCCjdOhwb2iWOPvbo3OQsRR3fB5gMyR8/1jRf437FU8PXk42ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125687; c=relaxed/simple;
	bh=TdkwTNIzAwUJoAPXjj02yqITZherri+LDBhfwYcnBn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCp/Y5DGQ+R+EMXaxZfV2qemPuiLjvBUtiez47NuMM6K7ng+gG4UNAAlQwHZTmGRdmKbUdUukzdrCqZHq9QXavuACkD4Z7AHSF9j2xjbY6QQb31Wb+tCXlwEBfAzyMPkhoW4d2YLjp/JyUUS4hNSuVAlq9Tbml87qkH+8gK8FKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVGMJl0a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A13Z6R010019
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=; b=YVGMJl0aYIazx205
	TfnfO8Ym46e1okVefOv84OJvWQQA8baC4GICAU9TMiIbAdTeh8qhoAjSPqGv7Lcg
	5LO7ZKLBMvPg0hPUVbQa8ama5A56+ZWh16PQbaTaKVTRu2rHPsSynpZCnRD96xVS
	aDspfTGMAICzayWOxb/xS38ZjLiz1jUjGiVQBvr8H52QupYKjdsp7NFFYFblDLg7
	xaP0NCKRb+ws2b4vcydBHhUgQ2TIbno77wyMSz05VcupTPWWwDkkFxLHltJoEaTR
	RFhFaLeEa5nwh5q+gZoQu6/Dke6dStqweShwdzE6pHw2Qh/I9xw0lLcEmaZeMejv
	bVqWWQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9q3ks1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:34:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b39280167fdso607578a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 22:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752125683; x=1752730483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=;
        b=O0Mk/dHqccGoG42WTCJB+AJs76Jwi8Q8B2QUc34R3uGGcrTgxNccJy6sGXDw8pia+d
         31tUntTkNQHm12fW0tG3ro1A+2Lzqta9IwzBafq0UVBVcyRNu/j8yjeHY+wlJC3sTK4z
         /INZw7zr98pkKOwonSsV2J+wDOGijiyhFwrA+V+SQyH/4S7K348wqRhwWHgx94gWIYRk
         EP3+RIdnm16yoQlk2olMjqJWNP3DDWfaGfTOit8nRK97rNbpWWZenaqRY24uDxif7DH9
         84Wq4B8r11XxnsuV298VdwYzI04ZhDBYGVM2xaUlZdcsoJshxzcKyfJpOoS4NoAo/1kN
         CSEw==
X-Forwarded-Encrypted: i=1; AJvYcCUtjrVbJ2b1+vjqBgZ3tFmt4yKC7icqyhuQDLmvSHR6v6N1ACuLI9bXtJss6XZXD9MCgKGYAw4KeW6sbXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Pd6ztLOLX9TNSVTBjE/+6dzX2Clx2JwtgW3RSDzB3a7aes3s
	hhgvqv88iWs3XVGS2EYBEL893Uyl+JVLFUnoJKJFRZzB2SsV1TzEIdLuPRJ6Pd9v+F4x0O5Skmf
	X0zDCQYQrNK9R84nPZH7ylPVcsfKSOzh9HOxhmsBU3PgsYWAyScrRjj6xeWGjVZHLlc4=
X-Gm-Gg: ASbGnct5wjGlJlBVBtvam849UtmTuJU9F8zPnzXzS9yA0SES628JfyE0tW5HGNmOyqt
	mSi6vlgH37JgcRFdgAPKKBhXR2xhRmPLIfJY6fRUTqukTCV3fKiejsMKMywO9p1twD7aTN5KNPQ
	jSZVN1+pIjWyV4RkoyOESYiRIE//QggOY+awDglhUotUwDS681fHgnKKnPnZi7yDPHm+Q91AR/x
	mI4AynCnVy8LsbtEVhGYmp/zibwcA3j3jYi3GP9WHEyR0i2pqz9qhFI2eUgll4Fau5g4P3cuqiQ
	Q73MhTAgIy68jsT2KJ4/tYQRTzolYEIXBQtQCjoCtNFFTIquDyfjBSZfMjaLt7Srrb6HkB+0AIN
	9Dp3h3tR4ryTwAPFR0EYiSuQFemyEzW9z7QT7rZ7NmljUlek=
X-Received: by 2002:a05:6a21:33a1:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-22cd5bff24emr8481488637.10.1752125683380;
        Wed, 09 Jul 2025 22:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8seO7i6KNpDs6X6DiLrB9L4Yaf86lhSFTop+1D/GBVnAJAqrD2tlTFsRBoCy4upa5ILMxg==
X-Received: by 2002:a05:6a21:33a1:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-22cd5bff24emr8481453637.10.1752125682971;
        Wed, 09 Jul 2025 22:34:42 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0201sm1014043a12.31.2025.07.09.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:34:42 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 11:04:28 +0530
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: parse unsolicited
 broadcast probe response data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-update_unsol_bcast_probe_resp-v2-2-31aca39d3b30@oss.qualcomm.com>
References: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
In-Reply-To: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: eOMgwUcooNSGYXhPP7cFspW1BpDXj2sX
X-Proofpoint-ORIG-GUID: eOMgwUcooNSGYXhPP7cFspW1BpDXj2sX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0NSBTYWx0ZWRfX72vTruFdMiFn
 OUQZ4yjfqmkACWWXYBoku462H6XGJLZopZgQCwcnB+lDrXFVELV8sGr9rmQt8u3kFDYI16OgxQs
 04z2DLberIYvFwYMc3oNQ6fattR/s9Uv8a4KjiL2098+R440goJ6l8NIyjoQwf1wmduEGjiUSsx
 Mz4d+49OljNC4vLiG6EyPZ0J+N4kM8RedY7UWA/D7yDGUrTdmX0WvAiDMvFnfCVgJGUgigHDiYm
 tF59M+MAdJqcWzZ/8wnp3I3eMdZcIHZyt1u+CN8YPWI5EPPcuoI2yqXBwbfQPcebtWfVybutGql
 K5VGI9qjCXfcM3YV/oPAsH1BApqqYMdIb2aAE07LZ5XzDJZgNvNIlHYz4hqniYhXrMLQWUwkgPz
 4mjA5vy4S5k5Qat8+9s2Oic3SyyLYTuT7mOssfMeN/iyzaYKzVdfx+9uWcJuJHaamkUhmq4g
X-Authority-Analysis: v=2.4 cv=BM+zrEQG c=1 sm=1 tr=0 ts=686f50f4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GDPEl8sVpxXbRvpnLXsA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100045

From: Yuvarani V <quic_yuvarani@quicinc.com>

During commands like channel switch and color change, the updated
unsolicited broadcast probe response template may be provided. However,
this data is not parsed or acted upon in mac80211.

Add support to parse it and set the BSS changed flag
BSS_CHANGED_UNSOL_BCAST_PROBE_RESP so that drivers could take further
action.

Signed-off-by: Yuvarani V <quic_yuvarani@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed786c37f946f9c4af820c15b5922d..cdecda1bd07b31cb7d8bd76eed074ecc2a828eb1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4173,6 +4173,12 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link_data, link_conf, &changed);
+	if (err)
+		goto out;
+
 	chanctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 	ch_switch.timestamp = 0;
@@ -5114,6 +5120,12 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link, link_conf, &changed);
+	if (err)
+		goto out;
+
 	err = ieee80211_set_color_change_beacon(link, params, &changed);
 	if (err)
 		goto out;

-- 
2.34.1


