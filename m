Return-Path: <linux-kernel+bounces-764183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E8B21F70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49CB628BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF92E267E;
	Tue, 12 Aug 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HU0K5DgF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE02E2644
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983429; cv=none; b=apHnMPgLxXYh9mlxvVRxn8PfE79SbbkuJGHKedY6ARYDBE/21svHgz2f4U+AOEUzWIwf/8DzODadAEM5Zhkg/6ts0sKGXWHgJKxpWrUoZBMwmSVjuUNhhC1rievXqFoZazV3hjOlYC8OB8ZMwcH7alN66+bhysLJUxq/Ag1ZMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983429; c=relaxed/simple;
	bh=dlXqNiiTKDdVHbbv9I6JqgnIh525x+Ab2rqKF3BF3eQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfE96coMhxEiIv/PGliIcB6dYHlXz0n0bSb9iaYu5UZvLzcPTjWsbVQME/1RHpBaH21cbWMFDFI42CkO52V0qy4YEChsSx1IveSWttDJDFeSMjnbLC2mUVWVGa4iTdOJyobIw3TSIiYK2wkYeUoeZTrLBJd/+RC6HRwBMzqImJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HU0K5DgF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C36sjh005801
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M07C5PvjL2mzdd0lFp/tl49J1J/XjIm7qCAeGhKu034=; b=HU0K5DgF4tQyHvDF
	DfSVU79+BqO/8EYK9o6N4G4eJUCLbGP04yN38NTEmzeEro3NdiY9SpNFW2ncHxZF
	q1JpBLuwuajHIgpHknpZ3deRL6Q1VSotkdxodjsCG4EMBqHij+u32Q8Y73Oi0Ifi
	MhBokXMRqCyPG/GA+3K2IX0w2LEuTRm0tl6hL8VhbE6vYDFp/Z13HFmz2A4ThVAO
	3C/LTSMo3usoAatMdllZtxSvjL4zN2VvGms8TWs/MCPAP2v+lV5c00vkjyUYXfbs
	SQHrKh/9TRMfg/RhhrOgrcg4XtIMCN5I5VlSF7bCawzSQ3rcDZ6Lqb4fSroZHfxK
	o1PlQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbabbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso9791603a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983426; x=1755588226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M07C5PvjL2mzdd0lFp/tl49J1J/XjIm7qCAeGhKu034=;
        b=iV9kNKPFNRTJ7GW2Th/sBI/K8WnDXbPqP2OcknzVfBm0LiMIBuXsypsBNrdNxc88ue
         jzQTxL4X28BODv8+KJJdi/lR9hBChQbNdKLJ9R9/8wA8qFNu13covEXRBP3X1X+wRYS7
         yAanuwQZ7lPge8MFFo+jq5S1nWNgSHowivfriQinggYa4txJknbmUqplhmhr5TNtD6tp
         HnZ8nE8X7YdNuphC4kd9gaEQabYYn+EKlbhKDauTIjYTb7s6i/tEWuf6iprmtuxt8zja
         ObWZDReapO75ZmvOx8hlVO4QWUUWXcaKcAhvPlAZ1nZIudEXEZb9MkMUN8CAYVZEGfGd
         GL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvLGl7t2AUEbj2B2gV9QgaIiJTxAa3g80ZYT0YYxI2Eq7xgrquigKOYuigUzr/Y8j5LTLNn91v69JSrP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjrAqOQ/rv5w/bnNSQvfeuyHEnF7k6oo1kzIoHASQIByhqK2F
	jvXOEggctfMmublg8m/8bKvbUZ0krOK3sq3XNnmGEcZIP0om5OdFmTCkBNVe1D9bDlSeRee53Wk
	1Isd467Mdpsr7Ir8uSxGwG20/z3BAm8B0Go4/gC+HoTwfP0lq6mM1nnM8dFYBO5RSYso=
X-Gm-Gg: ASbGnctE6TMwZXNdWB+jcV7qeT50CU2EWbgqxKoHRrpAk2DSlmACRjD2i6TPdaH9nWU
	KSpIupBhNDyrTdYEHSA6qezvgFQK/DV3eJps6wX6oHD58Tu62UcWREzUofaGvath4kDVcU0npyh
	0jMetzxLYdZxatsIMJF7R4cbe351pKxejDMuTqSaEIT+H2Amh69kxETGZqXXlDOFd75MrJnSeh8
	6aEghEQ2Ayu0oZA4n4UjsROjmXzvA+YmbW8WjnoUNUPXcH3UepNvrJoN7dyEHEhxdOCMnTB4PRO
	zm6q/XY/1m7/MUZHsPxPQ5lYVe0GdSI2PjpFjy/ectrn68se9tL1+TJ77rVUOXSiRJkJD6IDABQ
	YSBbG4lw96LqwgnY59HngI2x2gt5D4uL1G5rDwXDXhG1I95v0NTa84a8CiFRH1bT+
X-Received: by 2002:a05:6a20:3943:b0:240:1ae7:d918 with SMTP id adf61e73a8af0-2409a9ed58cmr3795762637.45.1754983425819;
        Tue, 12 Aug 2025 00:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1xXCu5aUaNjvzm/8zEPHcm0APCLCLG9HjMswe88gdDOplMJhkGlfUk+xwl7iu/ggw4yNLw==
X-Received: by 2002:a05:6a20:3943:b0:240:1ae7:d918 with SMTP id adf61e73a8af0-2409a9ed58cmr3795726637.45.1754983425385;
        Tue, 12 Aug 2025 00:23:45 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:45 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:53:29 +0530
Subject: [PATCH wireless-next v4 2/3] wifi: mac80211: simplify return value
 handling of cfg80211_get_radio_idx_by_chan()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-2-383ffb6da213@oss.qualcomm.com>
References: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
In-Reply-To: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689aec02 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=JbWyVvrk7yFLVdDgZQ0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX8olHr2XcYsOy
 Qtl4xJ+Mo/k75k0f2jNnYPVjmfw+PZc1457E9sWwxTF4SdRzTj9fyNq55YSwiSJwk8NGNqNbOOF
 YZmpd4gpzO5XJl4/+1dG5KfhKVozq2elzAqZvOzJ5yT4n/TeG2WPVJVah6E2fSmyZlbQDAr/kWx
 RawykL13JMXff70mV6+F8IluLZlOP+UOD0lk0MmgCW5e9/iZ1V2P1z9JLY3fe3TalF9p29rzZtT
 gQvdSXF8aIg/j9eNokpz6EXnjLQ0Ct2qrV7JPIJLOLv2MJP4LFR0diTzRY4CEPUO/l4HbYO3e6t
 X2t2UKVkQ85Qd781R8mH3aRIOD5R5hCGsYDq5IcirQ9Btnuoacq/aJudkPQWcobcPLpQZKnfd+x
 AjGaFBdP
X-Proofpoint-ORIG-GUID: NhSQLeJnzYzeGCrIkyPOHGYKEl65VPv1
X-Proofpoint-GUID: NhSQLeJnzYzeGCrIkyPOHGYKEl65VPv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

In several instances where cfg80211_get_radio_idx_by_chan() is called,
redundant checks are performed across function — such as verifying if
wiphy->n_radio < 2 or if the returned index is negative. These checks are
unnecessary, as the return value can be directly compared. Moreover, the
function can be safely called even when radio-level properties are not
explicitly advertised since in such case in each call it is going to get
same error value.

Therefore, simplify the usage of this function across all such cases by
removing redundant conditions and relying on the return value directly.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c  | 13 -------------
 net/mac80211/chan.c | 11 -----------
 net/mac80211/util.c | 15 ++++++---------
 3 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2ed07fa121ab73d3afd2f841eb53e6cdc0be91a3..d4100d046442a51a0baf42d6ab3b921302d307f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3677,12 +3677,7 @@ static bool ieee80211_is_scan_ongoing(struct wiphy *wiphy,
 	if (list_empty(&local->roc_list) && !local->scanning)
 		return false;
 
-	if (wiphy->n_radio < 2)
-		return true;
-
 	req_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chandef->chan);
-	if (req_radio_idx < 0)
-		return true;
 
 	if (local->scanning) {
 		scan_req = wiphy_dereference(wiphy, local->scan_req);
@@ -3701,14 +3696,6 @@ static bool ieee80211_is_scan_ongoing(struct wiphy *wiphy,
 	list_for_each_entry(roc, &local->roc_list, list) {
 		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy,
 								roc->chan);
-		/*
-		 * The roc work is added but chan_radio_idx is invalid.
-		 * Should not happen but if it does, let's not take
-		 * risk and return true.
-		 */
-		if (chan_radio_idx < 0)
-			return true;
-
 		if (chan_radio_idx == req_radio_idx)
 			return true;
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c9cea0e7ac169839f883f73186b575eacfe55db5..57065714cf8ceb5e612705ddc913b90c1f296e2a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -659,19 +659,8 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local,
 
 	for_each_sdata_link(local, link) {
 		if (link->radar_required) {
-			if (wiphy->n_radio < 2)
-				return true;
-
 			chan = link->conf->chanreq.oper.chan;
 			radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
-			/*
-			 * The radio index (radio_idx) is expected to be valid,
-			 * as it's derived from a channel tied to a link. If
-			 * it's invalid (i.e., negative), return true to avoid
-			 * potential issues with radar-sensitive operations.
-			 */
-			if (radio_idx < 0)
-				return true;
 
 			if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
 							       radio_idx))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32f1bc5908c571416df905bdda1ba54dd7b41f33..51e3e3c913f7f9faa4a0283c0aa9509efc805391 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4022,16 +4022,13 @@ bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
 	for (i = 0; i < scan_req->n_channels; i++) {
 		chan = scan_req->channels[i];
 		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
-		/*
-		 * The chan_radio_idx should be valid since it's taken from a
-		 * valid scan request.
-		 * However, if chan_radio_idx is unexpectedly invalid (negative),
-		 * we take a conservative approach and assume the scan request
-		 * might use the specified radio_idx. Hence, return true.
-		 */
-		if (WARN_ON(chan_radio_idx < 0))
-			return true;
 
+		/* The radio index either matched successfully, or an error
+		 * occurred. For example, if radio-level information is
+		 * missing, the same error value is returned. This
+		 * typically implies a single-radio setup, in which case
+		 * the operation should not be allowed.
+		 */
 		if (chan_radio_idx == radio_idx)
 			return true;
 	}

-- 
2.34.1


