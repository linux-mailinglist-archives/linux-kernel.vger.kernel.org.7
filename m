Return-Path: <linux-kernel+bounces-722664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456ADAFDD81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB656838A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746EE1E0DCB;
	Wed,  9 Jul 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NKy61/ff"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542171D54F7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028541; cv=none; b=kOJRCM+Io5CY8csh02EWwWx/tXJPSnbIuQKLMFcruuu2eIvzExgH6JEC9ol6NUHyjhb+gs0Suh/ipU8Uk3lGBYhgwfrkKGca7QNSwbLrpp+LntgmZvbaGHvJ3TqkubSUCUgujak7pL91Bly9zSEaPbuV8OT0Tdhnd8dxmXYs7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028541; c=relaxed/simple;
	bh=TdkwTNIzAwUJoAPXjj02yqITZherri+LDBhfwYcnBn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7ePgEnHikVGlkfuNUrPWo1r/NL/gBfWysRqHZ2qEjs1vUrECAsCjg7YdqC5tzkmS6tq6PWhHWgeWexwmeES87fucK50dv2tsl37s6LAO0Ea3WYyZ82mKpO/aAHgrCDLnu3a+LBU47+RjL0rquvOlYvkXBbo7VpVwlNk/c2V/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NKy61/ff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Id4aQ025450
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 02:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=; b=NKy61/ffodXz8EMY
	vqgJm0nwXS44TdphYdA2zc+x12LwpfbBn3UsMVnMESocqYjb6QuwPLHIR5LCJ35J
	YYZTbPlHkTc6HeMKsj6g67Bw2NiJx131Ene7UOIHPLdv8fAHMcAe9kf0FxrHGz7y
	UWAIL8NSylflfZ0JXf+7uJ76Xom9A/YdMsoYAxyKJ81VJQZ1scyO1i1Ot4L+o2VQ
	glCvW57m7T2wRXaZrxm3AxY/iaR1XCo6X0vaJpECMWlztMYhf7tb116K50PCVGAt
	BW5MYPlHWSdE9rKPINmsUU3EBfEGhNblQ0ACPUbKi4YNngFe503Cru6wMbP2TXVI
	CSgzUQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wj7js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:35:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313f8835f29so8074689a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028533; x=1752633333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=;
        b=M4SmRauCNeTekMY3GrqDweVSBYfTnpESbmDsTwepGUX4Qr1+dExjzrwGC1/A0deZUU
         02da79qhx74xudJgFDAjGfh9arLk6XoccPxUDKPQ/oyH/Ik3gQo6RgZG6DZscqr4ek8u
         /A4dbdUWn4hdVcbwnrC5WvyZdxwrHyUEKFVjmUfMPTBiopyehVxX1bb9lux7G679pp8I
         dRQImyzEcJgOI8la5mKJZDrShynRxnNjX12IlI3IM38M2KZ0bF63t3M2vNWuoRaGWbHy
         K6EwgTzklT1SwFgpV2npmKDLDPsLfgsbPaKsFnb9JKkMIR9iYqWt5+dJzcsq1mz82MrN
         hnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDPTGR0J8cel9SGtdyCctrObog9nFXDXZ4FRTLhGgtdDPjRH9aHNd0MPCnJDfWh2wMZ0EvX3X1R4iWvjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3A/V6j/ojIdyCo2N3PGHQkEsysHpIrRKuuFd6io1xi94rZ/Pu
	LonyjC5Hch1N9Y6yzevyAr0+SwIAxoc9hrBZV/DjhPLjtmaa6sxc67okRK6QvYCxNd6Xqx4MSZC
	XBwMJUal8fXGP95NFPEMgKMDnyk41s3uSfpAmmQBEfowrxBJHwNHv09pHRySimHCJaYU=
X-Gm-Gg: ASbGncsptJp7M6JBFZlXPITha6soRAR3gIOmA7XOl/9j2mSiD427dfTiH72iJhhEE7P
	HFRbwIBo7YONfh3Wgcmg9ub/MEIwHiYX0TPM594QjHvVxjR/8brLdfHAere6M+VznJFNytwZdNb
	xvinKlxwVnWw+20tEW/boNcjb7kyknBLVes4dnHOurWaLvz+lSKCQB9ao6cY6s+r/TZjR9MP7NF
	eduLSWByInQrrJ9dk6aXrCRt1w5B7f4IpwzIca/jNvcZ/AlBM9mw6FJP3hPmd164JOJTur+EA4u
	wULf8Lmgzc76rDmUOMtGp4HPr74UG/2LlYg+OYFeAw3uZHlD3HV9m7Unjn2T4TicDbL+LhlJL8U
	iz/wyCNSK7xgwQRj5YWcgULnRXq+DCBxTdu0wzQOEpTuHG9M=
X-Received: by 2002:a17:90b:3ec3:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-31c2fce1e72mr1527310a91.11.1752028532740;
        Tue, 08 Jul 2025 19:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF099tninrRE01bhqR4B5YPR57K8M4RtHfAmPQGM2zE5xavw2PxyYuLVylNvUkSK44dy67aHg==
X-Received: by 2002:a17:90b:3ec3:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-31c2fce1e72mr1527275a91.11.1752028532290;
        Tue, 08 Jul 2025 19:35:32 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ef2bsm133169315ad.33.2025.07.08.19.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:35:32 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 09 Jul 2025 08:05:19 +0530
Subject: [PATCH wireless-next 2/2] wifi: mac80211: parse unsolicited
 broadcast probe response data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-update_unsol_bcast_probe_resp-v1-2-d3323ce9a7b5@oss.qualcomm.com>
References: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
In-Reply-To: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: tFs3nPe_21raGfYi-xav0Vmlz9jZbH6W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyMyBTYWx0ZWRfX4eGbnI6spQqx
 xseOCChNTlLkZjnRRxjQh253wO3qr9QndAZkny9JLWxqxcOPHImnt4bIbCbUIFZA9nByP9eEAg8
 MfBEl6vsl+L3dVZ5yhaVkwJ2zL5l9vMKDtU2nmayaFc6q5wB2k3WxkmsiHdtipPJiD2G9oJiy4F
 HgglQK6+nE8rFOXFUFuC+3SAMMlVfzpZDn7jHh2BMc0Sr9jRLBJTWQscEp0UBKw8JX02D3lQfoi
 qvhNisaL5EFlRsK9N8QxJkdNp2hW+8cUaUXOmeUHga8OAPvs8qAhGZHN5nxnHePsv/sxdoyB4AH
 kk1uh2fNbkGYESMpK80TR/DQjff3bgIS9S1JdEfdSbKIWfbSPQWiR2PPKNLJfIGCcY2mwqK3Dph
 J75pOS/EWARYnFNGbXTFXxYRPU8hDWS9Bw+Gvn2CIq47OVMY4wA3c4fhDvUq0ftTb3iknRCY
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686dd575 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GDPEl8sVpxXbRvpnLXsA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tFs3nPe_21raGfYi-xav0Vmlz9jZbH6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090023

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


