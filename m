Return-Path: <linux-kernel+bounces-764184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E0B21F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A892C1AA5811
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDB2E2DE7;
	Tue, 12 Aug 2025 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdltTWNy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21D2E282A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983432; cv=none; b=kQ/M9stdLZNVEnKHlgXrycIrUnTWN+u2j4Sq6AK5hOY4p5H9y6bKHKglEEIJvhT8B+dkVUF3W3h8l6P3Xf4lTz7+HgHyRtqA7LGvVs9EjM8PZ1pXcjIh43efi1e8ApTewfD6pFk9owR/tGUb5d5Jskt4UkSGI6ny4JBFUR20tDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983432; c=relaxed/simple;
	bh=sXf/tzHPxiEkmS3fi5HIa7z0JKn7aB250VO7t0cEATU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rm7XOirp1HIK86YE0rXy6viJdwj+uWkQ0RFdRG5EkoJrNtzSDR3GwRyTttwvZwq+L5eyyVM8CZAYjHwkIaldwBfpIdimkuNTDHnAWwmEvUevhDkcQIvfncav40Bl3mhzGjED4b90kGYtmHY1Svxlpsd6+OO4STTf/16KnaR7OLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdltTWNy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BJRXNv026164
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGEZ67kEmAoqpjitMp3Ll7+BdbW0GOjiSQsfDHXAo68=; b=HdltTWNykpnMGAnK
	PMUVu4Iw/wQoJjMbHQogvgyAqiPWwL5e3EO/ALuhT91iIxj9qQnLq4nPHKHGp2mb
	A981Z/AvdtCnsCa29HwLyRiPcaEGQC5hY6NygmrTW0sY5U1lF4vC7hyylhJLfNVM
	idGe28OpW81/bg+H69Ud3Qbm2ebnhawCVMYdj5gj1zP0THasVPhJPUNcWGB+LkFg
	Mfohv8WJQLW4kbib932MFKEyj29qLol4rWsDIioULw0kCeWHGjQFpNcxZ439nsAo
	iZQvYhk70NzoGlC08CYHK+b6i5Ni/SBHwWPhLUEcYHyJNAQs6L5oEiWBuxR1joFV
	Opz6Og==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx5ddu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso5333366b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983428; x=1755588228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGEZ67kEmAoqpjitMp3Ll7+BdbW0GOjiSQsfDHXAo68=;
        b=Jzwp3LxIOJ48Rn1HBVXN3wORQzrE3Jw5Ur0/MS+/s8rhUCE68qfFNrdLDre5FD4evQ
         qjf+5ACM7q4+zCdpXyICr2liUS+CZ9JdgHUlQjPlC1UF6XOM7kwjOoaBA/p7p63zDbjs
         m547Kn55x5ng/fOJpqR4aDDi8hHtvU/wV39wko+Hc1tISjQ50ARD3YNDHiEpN13+xUXn
         45VRvM0ozJllh4RiypGfjazmheKfxDdTmzKg/NYA5epYLI2k+3E1A2Yanwxic1tqEOwJ
         d70zXcpBcdRyKJpz5td1TSzrbtjyr4auhFTLnYx2gfdN30J5v4Q3Ic8DayDY6+tX/2BV
         CnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVzCkt13oyONWR+l0ldvue4CZHVx2YJIGf/AbCkvPRKTTuYKY1ZDrX8CCoqrav0PDdUBnnafZxdABRTbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJt5FHnzYc8Uo76y4UwItZ7Ue+n7nJp3CnwO8XKUUBwirvp4qp
	ZewwmaLiFbuzsoUehe1WZlwzdCEx9/SRd6nudyOYKxewxq7CE4wLKbxBfWt8Wd/rR9eBmG9LDuA
	FeCCf3OWkWQTn8rq8pMTQtyqKsn0syuksXS/VfkTv8S0llZeM7twILLTZEJzDOtZYkxY=
X-Gm-Gg: ASbGnctg1uxtVjfAaYUjvKXVPiLv/zf9UiEeFcpN9Zjp8Vmbp5HCjs+CUHgZOXOaBrp
	kJRKWjbAlQuKJpM9mgeXsqN6jyEYJjbxi4rDiHM0YrUvfciVDFDYgtalGEqNpPApZEnj8KSitz6
	2A2B8esRZFF9Zb4ia20+yGFJUTE8WakgIKViAFC/lj2TPvhWe0t1HlyYSoUr8N/JShFD7FFq2ty
	SAeUFQVKp092LKDEgnstO1jAGnQ3O1LpkTpn1XICVdAqs/HPuCgHCHm5GnsQtdLnOf0ODePWqlp
	10/imGHzukGZ8aDnVOv8awQYZAEfld7g/qJF4vGLR5bEI6sUskQenv5TCgev7NxSZbAAbeZibbN
	NkrJV1vSshUmz5JXmjDCEvBQmjg44LzkWOX+Z97m9lHhkOYnGaUZD+1rR11zWTXbp
X-Received: by 2002:a05:6a20:a121:b0:240:1a3a:d7ed with SMTP id adf61e73a8af0-24055200eb1mr23629428637.41.1754983428027;
        Tue, 12 Aug 2025 00:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhSrnMBPSIIBJ3L8/BeBaB8z/thQRvfAUKzIFAMBHroJSoaanlapaoH1eJeKq/MvA30JdaOA==
X-Received: by 2002:a05:6a20:a121:b0:240:1a3a:d7ed with SMTP id adf61e73a8af0-24055200eb1mr23629404637.41.1754983427572;
        Tue, 12 Aug 2025 00:23:47 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:47 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:53:30 +0530
Subject: [PATCH wireless-next v4 3/3] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-3-383ffb6da213@oss.qualcomm.com>
References: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
In-Reply-To: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXwqQy6L8lCJJx
 cHmU6EQ6U0jJkcxbUUsynKzxWE8Rc+oxqCJK6cXq/RS2qDCQFsLBShe20DnEm7QrK1uFH9gmW3F
 tOIMZczP4ORoBueVASOA2kHiVuLTHNnR8OmmXAYcNHZmXMyqEV5ejUgZLmP3RBKY2NkRYehGzCv
 o5dHB26o6ZZaea4l++iJWxTzyw8SGM4p5OdJC7yhZSA9z5OhWnUHFimr18Z5IDKABZbYtrDT91M
 o6MdKfAOYu1UgnLFehqGKDQJT0Iznbb4nIVc1BKRgVnrqccHnX8YqOwAL7kqtt7W40u7Nbo71vz
 kkJWL+OG6ZTbd2MD5yW0enU7NURfBy7Jjj9wD0duouWXgtXomNDdh6dee3/k3UveZMGxEHQrs5+
 GevYklm9
X-Proofpoint-GUID: 0i2E4F7D4VNGcSaj7LtXMtBvUyKRD1WA
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689aec05 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dNCVw_J0pHFwvOnBF_QA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 0i2E4F7D4VNGcSaj7LtXMtBvUyKRD1WA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

Commit 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request
during MLO") introduced a check that rejects scan requests if any link is
already beaconing. This works fine when all links share the same radio, but
breaks down in multi-radio setups.

Consider a scenario where a 2.4 GHz link is beaconing and a scan is
requested on a 5 GHz link, each backed by a different physical radio. The
current logic still blocks the scan, even though it should be allowed. As a
result, interface bring-up fails unnecessarily in valid configurations.

Fix this by checking whether the scan is being requested on the same
underlying radio as the beaconing link. Only reject the scan if it targets
a link that is already beaconing and the NL80211_FEATURE_AP_SCAN is not
set. This ensures correct behavior in multi-radio environments and avoids
false rejections.

Fixes: 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d4100d046442a51a0baf42d6ab3b921302d307f7..fc39a5bc2ccbd0e6fd1128c6cd422f8b2c3c987b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3001,6 +3001,9 @@ static int ieee80211_scan(struct wiphy *wiphy,
 			  struct cfg80211_scan_request *req)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
+	struct ieee80211_channel *chan;
+	int radio_idx;
 
 	sdata = IEEE80211_WDEV_TO_SUB_IF(req->wdev);
 
@@ -3028,10 +3031,20 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (ieee80211_num_beaconing_links(sdata) &&
-		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
-		     !(req->flags & NL80211_SCAN_FLAG_AP)))
-			return -EOPNOTSUPP;
+		for_each_link_data(sdata, link) {
+			/* if the link is not beaconing, ignore it */
+			if (!sdata_dereference(link->u.ap.beacon, sdata))
+				continue;
+
+			chan = link->conf->chanreq.oper.chan;
+			radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
+
+			if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
+							       radio_idx) &&
+			    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
+			     !(req->flags & NL80211_SCAN_FLAG_AP)))
+				return -EOPNOTSUPP;
+		}
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:

-- 
2.34.1


