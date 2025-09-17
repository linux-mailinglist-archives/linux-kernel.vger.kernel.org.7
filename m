Return-Path: <linux-kernel+bounces-820111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC9B7C5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9961B27848
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850A2E0B74;
	Wed, 17 Sep 2025 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMGvC/8/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2BC199920
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093150; cv=none; b=qYMCDNsE+79e7oCyZiJFZjVGvCp/8/x6Giy2r5I/TEHhPztpT8XhkQqiFHjRdIVNsKLxrHVjKRDB081RwAArdT6WiZyQ7zyXSzrtZZHjANe3BNrnYDpv90/+rTjmyJinL2IoZ9p0Gu8dIR33ulxuoDG6No/mE+M7s2PWSFzsn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093150; c=relaxed/simple;
	bh=1v/2XmWqGwM2u9PLWsCYIkpcOJ4SUG9gSs/onElCEW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sw7IX3k6szMWbjM2T1ID4dez3JqH+WM5wntX/6FWbobYCeq9h+yvkdg8peoWqfTNv9BUd0WJ4p8q74ioTAS7NTjerDbEKjWpK3roSOD7sLfVuYX2k50wniYPbp/LxxMITuSMY4qrJdi/y9FLg+pxqxpEN1dsYARdVHIyPbco6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMGvC/8/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5R0aJ013937
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=J66hhgFImcuxqKmHSOmYrm
	l7vtoJyywpC9SEBjrvC1w=; b=PMGvC/8/SgrzE5tFBYKwU6fBmm5Wbqdac62gmB
	9rJPpaalhJK1eml27Tek3AN7BbsYya0GpuRRAcBvn5DIPH5d6s+rMk6bRLvio/ll
	c4U9/oGIH0rZbce9GrWQXTtJScg9UYLvg3WEXBdfsv0BdZ/rS0se/gmLphOfmD79
	T3YmKT5SZdYsVb+DbEXBY7N2/4Gm22vnLm0fA6r7ahnGkM6hH+zMox3X8yTM5ePr
	mO1+NTgXgDM7HR4UK3S7ky5222WwF9AunW9V+Z1yVHievg6lgusOTn76FSLodNlV
	i4rOcWqeggKAUmh56mlZIOwGLBTnYYGdnSvzN/shOW8jDXUw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyhbnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:12:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7723d779674so5536341b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758093147; x=1758697947;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J66hhgFImcuxqKmHSOmYrml7vtoJyywpC9SEBjrvC1w=;
        b=hfRW6zClqMm5U8QPaaa+GaR+2s20vt3KWiWsRIFyX296lt0MMiyC9bK5QsnlGSTZh9
         mPHV1abwe31KDBI3hwTIsB9SerN+ck64RGJT8dOuFJs87m6il+oewSI4haCUqXbf/N2a
         DvpVkOvCsR32fGluOfjQDkpIAR0zPHiHDE319nhGJAJxh4agpZMjgnFIlyxoGXfqAact
         4Zag/RsAlLjXHjXnZja1oDEbiubPmlxVhpz9NvxkqHvJ8Hxd0mcq3/SnSM4ZcwB3vYlA
         86qtZDw5Wn/NjGY0yrO4lbn9ya9iGgCIvhFQv3kh45nAghYBB5JCKesO8zmzKifzv1aE
         2d1g==
X-Forwarded-Encrypted: i=1; AJvYcCWxZEFHd3KFdFxAvSFI41yIj1FHgmifmMzV3DP6ZNz2PwerEEGjEGwpkXQ1SKTKQZvrdocxrGj4tl2DARA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzL06GgTLdiF7hfKg3/6+dNTpMKNNb3MZVuOLChzI2w2IGUZRB
	OalxhXsro33up66mlAnn1YdRNjjo42ugWkP3uDSbISMjmE1F24X2z4TqFqyhHKCSqAoOgV/vRAb
	DCSjH40kCOgDnc5FdeYy+OiSh4nABrMcDfJGEdbo6Mhm+gAitMCxpsEGoMqMslgt3ZbbtoAmy6I
	M=
X-Gm-Gg: ASbGncvc+UFPloFKir/kB+QmBGqJn8Ku1Nic494DC819bkLSB0VcR4cGvPH0G+9Nkqn
	V1t5JHrAjpyFcarS2pktdwSE6fJPRK2D8fcyW19Vsdma9NzxHVIod/plKoViA4ZiAeURRGsYCHM
	EkrytlOgST/H3+yWcAuVg5pN9gUS5+GovMiEGDEa/jDfcALxFPKKwlNpFY+AZEbdd6LvAvp/Ddd
	7izRy7zDwO5M9LQDDfIlmWwkPM5E9HPG6vWZWY4jJ51SW2/8TnomlWoax8vi6L9so1WoWgWJRQZ
	h0Fo6v1zlgsMSqaVAVlozMrsz21JmDlohJPPl8yXKBRIXe2OHSjSjvT+9Hnqqz0tL27WR0j1wi4
	oQLh8SK3Xm9rWo8KcPMKVQImpcGTVoAedn8RyIEVnrW0p3wrHt+7S0enQiduSXf5W
X-Received: by 2002:a05:6a00:3c89:b0:772:823b:78a4 with SMTP id d2e1a72fcca58-77bf72cbfacmr1204832b3a.13.1758093146290;
        Wed, 17 Sep 2025 00:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7JBMaCmWienhM3LJ0ua01BRfpXCCurcfLSQi+p94eow2PfjpS459E5bm+Gdb+zftvXBTOfA==
X-Received: by 2002:a05:6a00:3c89:b0:772:823b:78a4 with SMTP id d2e1a72fcca58-77bf72cbfacmr1204779b3a.13.1758093145788;
        Wed, 17 Sep 2025 00:12:25 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c49fe4sm18323639b3a.101.2025.09.17.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:12:25 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 12:42:03 +0530
Subject: [PATCH wireless-next] wifi: mac80211: fix Rx packet handling when
 pubsta information is not available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-fix_data_packet_rx_with_mlo_and_no_pubsta-v1-1-8cf971a958ac@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEJfymgC/53OzYrCMBAA4FeRnI0kUWuyp30PkTBtRhtsk5qJt
 SJ9d0NPHrzsMjAwzM83L0aYPBL7Wb1YwtGTj6EUcr1iTQvhgty7UjMl1F4YYfjZT9ZBBjtAc8V
 s02QfPre276KF4GyIdrjXlIFXVWNQGTAoHSv3hoRlebGO7OETdkjEA06ZnUq79ZRjei6fjHIZ+
 gc6Sl5iK85Gai2hcr+RaHO7Q9fEvt+UtGCj+gCk+AugCmBU7Q4adK138gswz/MbxeSCCVkBAAA
 =
X-Change-ID: 20250909-fix_data_packet_rx_with_mlo_and_no_pubsta-66c9e29a9e1d
To: Johannes Berg <johannes@sipsolutions.net>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68ca5f5b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=rm_eYm1gv3371dOiMRkA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: MUTY9_Be4KWumPnJpUgeof5rbO15v8D-
X-Proofpoint-ORIG-GUID: MUTY9_Be4KWumPnJpUgeof5rbO15v8D-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+PB/su95lCS1
 goppTx7RuM78kzAgq9vYBFdHxTdzEEMexfhDmR5B/pXCGTWXGZBt8BepAnWblD28yoID6HHdwAx
 np6CVy/GvgCXIP3rJ36pvy8gZe2DmzneAtXq5WBaaKjW0HOMq06+kZ1IQJQQm/QcPZ2ISAoUK1b
 FcMYyda0JyODYzxqznC7TxtGClpI77BQH/6Ta3+Y7UQZeKOeNHL293h5M25Vd+qa3OHgA1oahUR
 9CJ+J9qsO0pMKkmX5jsT7k73f90Wnh8uAAkvJnR/VWdVNSo1DOwZy56SNnq3wJFNQC5cF4im20H
 OpzMlimwj0U2HxsNfvGkM8uxcNmhzUqcol+CEBA7Kp36tnqsbtO/W9fN0tRIwRSG2YS/QB2ImHY
 qnPT04Mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

In ieee80211_rx_handle_packet(), if the caller does not provide pubsta
information, an attempt is made to find the station using the address 2
(source address) field in the header. Since pubsta is missing, link
information such as link_valid and link_id is also unavailable. Now if such
a situation comes, and if a matching ML station entry is found based on
the source address, currently the packet is dropped due to missing link ID
in the status field which is not correct.

Hence, to fix this issue, if link_valid is not set and the station is an
ML station, make an attempt to find a link station entry using the source
address. If a valid link station is found, derive the link ID and proceed
with packet processing. Otherwise, drop the packet as per the existing
flow.

Fixes: ea9d807b5642 ("wifi: mac80211: add link information in ieee80211_rx_status")
Suggested-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/rx.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4d4ff4d4917a2564cdc109fec8ddd605a3b677d7..59baca24aa6b90212b739839e49714308a6c8fc2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5230,12 +5230,20 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			}
 
 			rx.sdata = prev_sta->sdata;
+			if (!status->link_valid && prev_sta->sta.mlo) {
+				struct link_sta_info *link_sta;
+
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					continue;
+
+				link_id = link_sta->link_id;
+			}
+
 			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
-			if (!status->link_valid && prev_sta->sta.mlo)
-				continue;
-
 			ieee80211_prepare_and_rx_handle(&rx, skb, false);
 
 			prev_sta = sta;
@@ -5243,10 +5251,18 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 		if (prev_sta) {
 			rx.sdata = prev_sta->sdata;
-			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
-				goto out;
+			if (!status->link_valid && prev_sta->sta.mlo) {
+				struct link_sta_info *link_sta;
 
-			if (!status->link_valid && prev_sta->sta.mlo)
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					goto out;
+
+				link_id = link_sta->link_id;
+			}
+
+			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))

---
base-commit: d103f26a5c8599385acb2d2e01dfbaedb00fdc0a
change-id: 20250909-fix_data_packet_rx_with_mlo_and_no_pubsta-66c9e29a9e1d


