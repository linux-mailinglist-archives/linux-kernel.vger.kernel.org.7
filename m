Return-Path: <linux-kernel+bounces-722663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD9AFDD80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075023AAFDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430DE1DF994;
	Wed,  9 Jul 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kf1+kyAj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E11A3165
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028541; cv=none; b=YFbNWVSzjy6KxEPxBsxCruc6MOBO3ndXY5CWSFXi7ht3tGu1aFAsW5/pNvt8/5NqtNayaJqAvyKwzjWXcz+MMYhWNRz5tUe5xxJcY/SUtOmMCbo8qp6nq5jyR/cF7e3rvGs8fT2ZV3n02ffLjm2H45eLzhBMbZ38BHLVzObWLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028541; c=relaxed/simple;
	bh=tSN6YxxeeIwfNVtJUqNjYCzWvla7VBhlmPBH/aqTAKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrYBMa3JXO9K6HAZukR2/MvQfSwRLldIrjcTvnTXXIUlJFisAxis8rI6cMwDJMGBiuUCBtihHYsXhf7MyYVGUY5EmDd4HaUUn7OaGI6P5wPWcboLxGqH3EIuSlRo6XtEs7R7161V3eV6/81cszFBYct2IP0dBLH6W2bTu9/RruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kf1+kyAj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JvZ3k008293
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 02:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LrC/7rgM5KIH+dR455FE6P08mwk11Z/ujo/JN/gT4BE=; b=kf1+kyAjDxkNDOMU
	kg6a4SruPw77esycZRlUOLQ6nP1pruOR+PuC2LNkv4DwlqACWt/2JAxNkBlFHYm7
	CfdlH9th4Ww+tXHvxXCA6IQnmTxTJV0t+/cuIMO48OJGt126h2uDzOlYhxwk5KH7
	qZL0ACh/ARBmHXoKoV1JzDsmmwE6eMJNZLm6L3F4VqaEj1XPglwkirbwZ3Oq7mua
	i33l518yhbgjm+n4FDY+BAO2d1mwGKs+rU1ZRNkGOilsC3yKkoY8MABvH7nnPFhQ
	jp4KxSto5Zp5FbYNVX9PZGKwgqKr5SnZG3ZK1R54RclvU0YBugTYns5ti+DOrieN
	VnEtlA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn2umy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:35:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b38ffb62492so4785219a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028531; x=1752633331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrC/7rgM5KIH+dR455FE6P08mwk11Z/ujo/JN/gT4BE=;
        b=Kp7VhTyMdzgGXQLGsbPbBAxtYRMjj6QFuOUIbERYRW7jg8K+B50Nz1b7axvfHGqy+c
         KeG56CAksHN14vIJbJUkF5o/fqCLOl4ZktNQSnML1q9Wbs2yc6PtkaWlYzsizbItA8dS
         bL0eb28uC0//JFUNqfvddBsANVLaknBZeOPk+SPwBZiUFzdrkPbb0MhvP4LeHU3fw3Ca
         +U0XhJ4KM/Y3S6kPWIC7JHparjFOiw0Wof05n9FevqqvYFwckmUjOkO7blFgf42cAMQz
         eQQ0dQGRq9WuHn4p6LUDYZLVv/F/ZJGXaf1cetqklahSHtf7S6JICkIquwAW290aStct
         eSPg==
X-Forwarded-Encrypted: i=1; AJvYcCWwIfPeCvtSitZwtbsv13iClGTJqY8VwDY7knvDNl/xpVaSt8AqcUlIoCx5MTCM7GuFW3JkCKpNTGgn9Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzykBa5P7NFrsx9DHzQEKUJS0p8S6MgdMPDVr7rxBOMmX1lbj1K
	GF8ookWFHO5D8ftAiVL70hwiTwmkWU/8gd5zOXJ+ewSGgvCcLonBEk7PYGDojTEpbfN5jN5pZ3b
	MX5CL9jgPRBwAVClwPi4fvLF/fk6Ut23l4floGQCksOHXgq/99btGXnZR1aPpAes5HLw=
X-Gm-Gg: ASbGncsjNFSF4HYnUtMR6P4DYdHxsiElkq7yuAGq0NL+ZtMkulu1Efdkdr7TX0KT5oS
	ehw1a9lEt7oFBPL3SoNcr7YEwuTco7y7IsTizJNuKDW+fTHNgV+Ex7iPyD0aM7G0s6vwpzCEI5/
	vDBAxym1Rvqi5rkaFXDBw9t0aVfS6IgBBPfDLSZhp+CccmfLl27fa5zS58v01tBD826bIeH7bxD
	6TS7NdDWGlt4cJRsXIsSs3fLA89rhLzi7PV6SGhiv26WEX66WR2eRAdRwKx5ot6kpuGN8b+44rA
	bUkrbG1e2u33vvaLBVJzhAVPrl9akKSvJBxpEWLHiqoedtmvY7fcI0CHf0HirSDXZomOcapg1a3
	WG2DfMBR31OnR47rJmMoZBx06uFNbsO2gfoVwrCZrRmOCb5g=
X-Received: by 2002:a17:902:db0c:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23ddb2f2c2dmr11512895ad.30.1752028530649;
        Tue, 08 Jul 2025 19:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAiXM0+YO7Lp5Y+AfPt1p2QIqNQp+OFLPNYizvEHO6VeMDTvLi20N2reU0NN2eXsOgIKyofg==
X-Received: by 2002:a17:902:db0c:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23ddb2f2c2dmr11512635ad.30.1752028530234;
        Tue, 08 Jul 2025 19:35:30 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ef2bsm133169315ad.33.2025.07.08.19.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:35:29 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 09 Jul 2025 08:05:18 +0530
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: parse attribute to
 update unsolicited probe response template
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-update_unsol_bcast_probe_resp-v1-1-d3323ce9a7b5@oss.qualcomm.com>
References: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
In-Reply-To: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686dd573 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=E4CoA09qZ1gvW9aZS_EA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rVZI21KQTnHoOcpdwi8mBnoee5zZpPms
X-Proofpoint-ORIG-GUID: rVZI21KQTnHoOcpdwi8mBnoee5zZpPms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyMyBTYWx0ZWRfX7EwQ3iJFUkKL
 VM3lC3Yshb2zqnRQm+gp0H+U5CLhdsBo1t9iLBNa3rZ+7D9TmG8Lj/TZsXBfhYBMwBnlEHxmD/3
 vFbvr3orBTvAOEfr7M2yOZxJP8u5SLT2Jl3sSRX8CyadbEyeulw2s7o9P+8g7F0BbuBJHYogWzY
 1OJYPt0c6sMAY3zi6RbcmL0h8DlPJj/v6YZXEpxz2LbnubknKKaGfH5zYLltEsDW7bfbjLkzp4a
 EvCS7Nn9ETo8X0cd3/RgssTnY7/6sNxkZ8tVRdtS84uGltm2DD/AoYJg+3oxtbteD7icfoThdwx
 JuZNvU46v6/fZJc2li8Ciu06qWYe0m1sP1p0JdE3YI5EUx4n4moxJNVgbEybKuE9dfyNK1qPfWH
 VMOuDjgFS0cC5QprYeOyEmKp5Z54mQNUN6mbB46FOUqDMTa+g/uZdaSkxIyFC7uI0auntYb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090023

From: Yuvarani V <quic_yuvarani@quicinc.com>

At present, the updated unsolicited broadcast probe response template is
not processed during userspace commands such as channel switch or color
change. This leads to an issue where older incorrect unsolicited probe
response is still used during these events.

Add support to parse the netlink attribute and store it so that
mac80211/drivers can use it to set the BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
flag in order to send the updated unsolicited broadcast probe response
templates during these events.

Signed-off-by: Yuvarani V <quic_yuvarani@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4a092da3a9de80df62e9c0e8792377a7bf65c739..0b903b4aaf877465c163fbf7ce9552ec9a430129 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1526,6 +1526,7 @@ struct cfg80211_ap_update {
  * @n_counter_offsets_beacon: number of csa counters the beacon (tail)
  * @n_counter_offsets_presp: number of csa counters in the probe response
  * @beacon_after: beacon data to be used on the new channel
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @radar_required: whether radar detection is required on the new channel
  * @block_tx: whether transmissions should be blocked while changing
  * @count: number of beacons until switch
@@ -1540,6 +1541,7 @@ struct cfg80211_csa_settings {
 	unsigned int n_counter_offsets_beacon;
 	unsigned int n_counter_offsets_presp;
 	struct cfg80211_beacon_data beacon_after;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	bool radar_required;
 	bool block_tx;
 	u8 count;
@@ -1555,6 +1557,7 @@ struct cfg80211_csa_settings {
  * @counter_offset_beacon: offsets of the counters within the beacon (tail)
  * @counter_offset_presp: offsets of the counters within the probe response
  * @beacon_next: beacon data to be used after the color change
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @count: number of beacons until the color change
  * @color: the color used after the change
  * @link_id: defines the link on which color change is expected during MLO.
@@ -1565,6 +1568,7 @@ struct cfg80211_color_change_settings {
 	u16 counter_offset_beacon;
 	u16 counter_offset_presp;
 	struct cfg80211_beacon_data beacon_next;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	u8 count;
 	u8 color;
 	u8 link_id;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 70ca74a75f228d27057d0fdf4b13bd2fba3f2536..6cb3c173343301835176206976ec2ff798ff1105 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10988,6 +10988,15 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
+	if (wdev->iftype == NL80211_IFTYPE_AP &&
+	    info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto free;
+	}
+
 	params.link_id = link_id;
 	err = rdev_channel_switch(rdev, dev, &params);
 
@@ -16790,6 +16799,14 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		params.counter_offset_presp = offset;
 	}
 
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto out;
+	}
+
 	params.link_id = nl80211_link_id(info->attrs);
 	err = rdev_color_change(rdev, dev, &params);
 

-- 
2.34.1


