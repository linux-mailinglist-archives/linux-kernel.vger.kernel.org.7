Return-Path: <linux-kernel+bounces-664755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E8AC6021
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 05:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D6B1BA3705
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0111E832A;
	Wed, 28 May 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wr9C/wU9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAB3A1BA
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403153; cv=none; b=emTMrbKPiI1DafNeYo8nL0Mo6xXt3EdsTrYrOwu1j6E9/6QYbFnc5Mk1jGt1k89vozha07KOBXSMHEjYlCDYRJqnaFmSWGMHIdxhnHQcIe5OSNfL3EMZSRHX03b1lQ2U3m3l+x8KlnYhmOjhMHjgI+Nj2JE77DRDpzw34DrZvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403153; c=relaxed/simple;
	bh=y9I+VUzODRvBRA5WweOQpXpT9tuwcpMLwNn2R5w5vFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HmrhphLWcPizmO7Lvc2HfmfKt0z7AeQybxM04kSLs4Uuh9JSZSeqdc8MJzIpANTZ66hg3BirwLTJ/vdymt8eveFBmttSH7E1B/eYUf8CH/0wzyZFRmTkUk6xV9k8Crxdf/ACluFuG2hkC4FNmN5fggzC79N2o73gHMQ2U8e9Z0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wr9C/wU9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RN9174021578
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GJPyarvUiq0Ob9ltlJBwHG
	cmpF7HAdIkHEXVqlsQF1I=; b=Wr9C/wU9KAKkrxdvZRRAZ/8K/99zUEOJ8wMuM1
	PvQU+KEAkxPPFl+orHR2EHIx+BQKYgyN9ri5vLlcs5PKdcc3ULs23vbxk04OQJew
	Wbeofdl/1bS49tL1dWSiPU7IF5tCizJz06fXwX4NH4LRrY4zkV2lraMdRZ/oNJ9Z
	iQNZto3iWI/lLw2GQZfBXTF/HqEVq74zSnP9Od8LHmMqWn/WblEdz70Sudp/CXRb
	YM4h5ADQE8n3UuzGE08R1ijnjSi3XNdvimezl+SJCj4ED4gzI5VDFc+bQod2vo7c
	2ijaLdLGbwRdMYbiyVZM0lFXGMocNk8WU7QbTgynHZTjRF1g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g90wdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:32:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22e3b03cd64so31526125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 20:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403149; x=1749007949;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJPyarvUiq0Ob9ltlJBwHGcmpF7HAdIkHEXVqlsQF1I=;
        b=Qc/YDASx8ReMyxd7uUpOYQQOsM3feHxIfwbrv8GQal2NmpndyabAwMIuyk4tpOtPGC
         auV64jXTZFOtUURdAJlD4f/ibAQ8MqLlvQX1AKWhhg9i+inMqkaXAODBFTMT4grMtJZh
         2ACx/vms1XhVbdadqPTyVF5ToJ1UbJvr/Pz5sAkHKmHVLEeqZNKOzmV4SU/7R4nrvmkc
         oxK6eZh7Tl7ZEUdKHmja5uoE2GyFihyKKgn7+wuoSRZN39jmzNc2w4s99t4dQEa0yGbN
         JQaJ3bVaeviAcqsBGHRctsW45Bp9vFkrhka7Hy/ZdcYtUlqvQSbyjsUkQLq2JxrfDh5R
         5MaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3g3KycyAqVUAvV5QUyRc411n1VEghXlWfO1o6y5emcbBxFI72JOs9x1d5XitnObKXG6Jqff58UjOURA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3NRJj/sRuPXnX1m+NeuVbG+GX4xa78CG+NzmWJE4TpGH1U7r
	3qJCR2HT7MebWP/ydIrD4dkgU503MCPf6Ncx/oKLVqwuId7QJd6q1nYT4RPLzCdNNmf0ZtCGh8D
	nk9qu987c0lVrVSPnzKfXcOHIwV9VKNBg+FjxNvu28+F9aP4H2oXj14yMrGtbFSZLT14=
X-Gm-Gg: ASbGncsbm8cYheLZqMzRZbMNXTqnToNzdRg/dgma1VAV5VWVDiKd3fL5puQhaBpvKVw
	3uivaFQnvQ3g4LA90Pp0hXhKKcmp8uyu7lXiPPsxOVc0oWVEexVQu66PnKyga3/VrTJoeGaP10T
	vYHmsZLw0KC+OxWn+eCvqoyGeDZixMTPh1W9L5glNvBwXnS9kmbO8yvwoIAvQTzHfzBqdVH+eYp
	lJwUExA/NIfVAnLSJbU0i9JybxZgEzywneqorl23xdmv6LTcJum88VjZkFVcrXhP3pZaPyLvWIs
	jr6wT15z8d2Kbvr3PwXPxlJTWNqpsdFnCRcSMhcLzF6AXCC1eeIu0fp84RITKO0cLIFRxaHmNVB
	OE6hbiuxgrzlCW0YdxCfULBbGNWD6fsjgIda5
X-Received: by 2002:a17:902:e5d1:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-23414f7b0ffmr202926515ad.18.1748403149014;
        Tue, 27 May 2025 20:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE20F/sRAMhYMagwLzeH9rQlfeIaQz38zcN2oKQia6phMHxJCVdv8sevsTUUNTW8jgi8Uj1hQ==
X-Received: by 2002:a17:902:e5d1:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-23414f7b0ffmr202926305ad.18.1748403148602;
        Tue, 27 May 2025 20:32:28 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fe1ea4sm2015235ad.88.2025.05.27.20.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:32:28 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 28 May 2025 09:02:22 +0530
Subject: [PATCH wireless-next] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-fix_scan_ap_flag_requirement_during_mlo-v1-1-35ac0e3a2f7b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMWDNmgC/5VOSwqDMBS8irx1I0ar1a56jyIh6lMD+WieWot49
 wZv0M3AMN8DCL1Cgmd0gMdNkXI2EH6LoB2lHZCpLnBIkzRP8vTBerULaqUVchK9loPwOK/Ko0G
 7iG71yg7CaMe6qmmRN2VeSQ6hbfIYotfSGz4hoJGIWdwXqIM8Klqc/14/Nn6Z/p7cOOOsuBdJV
 laY9U3+ckTxvErdOmPiAFCf5/kDEh44Q/QAAAA=
X-Change-ID: 20250527-fix_scan_ap_flag_requirement_during_mlo-d9bce1b859a1
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=683683ce cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Zr3TjlwJAZfEZ8iIeDYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3QVHdYc7yZBD44yJNPX9khAmBylWHVn-
X-Proofpoint-GUID: 3QVHdYc7yZBD44yJNPX9khAmBylWHVn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDAyOSBTYWx0ZWRfX0De4puV9fX4W
 28tVN7Np/EROgAFgCcEhbQJOqxhDBeu6LfNDOidUHmo318jM9ILWPSrrii8DV/jFYbN3aCipXd9
 6MHMrT9RDEUctnE0Olw2efiHO3ar1gJk8wOz+ldgrhF9vJfvUAydQJzjasN+YAJg8a6Ph9PusqP
 BBwxnWrNAuh0UZbG3dL1tqRRDddBLXoHmOSHlVMgjmQEscIH4qwuZ/Ejhht/gE+98FzOoLPLLV1
 I2gTcZ0XbuIneqNWP9Fa6i1EEz4OaMUCy6wVu76vcQcEwoPpnuscLkruYSCXKqJTISsUzVxn4GH
 FzlZ7V6ypfs6BC3wC6tEGF8kHP1HsW69qen/k7/01YgQ15Fj6VvU2mWSaRJvEYo2QCcwAKC7Q0F
 STubBV4wF1JBUpUo41Egvlcua2FAJkNXVsQuDkzo7da09lstzwrSAMB/N/jKIraQx5IehMQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280029

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
a link that is already beaconing and the SCAN_FLAG_AP is not set. This
ensures correct behavior in multi-radio environments and avoids false
rejections.

Fixes: 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
Depends-on: https://lore.kernel.org/all/20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com/
---
 net/mac80211/cfg.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f283120ba366401d3ac546e59d8c61c21..22bbe1f4bfc3e2248e6c376c8a465da924180e0f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2897,6 +2897,10 @@ static int ieee80211_scan(struct wiphy *wiphy,
 			  struct cfg80211_scan_request *req)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
+	struct ieee80211_channel *chan;
+	int radio_idx;
+	u8 link_id;
 
 	sdata = IEEE80211_WDEV_TO_SUB_IF(req->wdev);
 
@@ -2924,10 +2928,36 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (ieee80211_num_beaconing_links(sdata) &&
-		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
-		     !(req->flags & NL80211_SCAN_FLAG_AP)))
-			return -EOPNOTSUPP;
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			link = sdata_dereference(sdata->link[link_id], sdata);
+			if (!link)
+				continue;
+
+			/* if the link is not beaconing, ignore it */
+			if (!sdata_dereference(link->u.ap.beacon, sdata))
+				continue;
+
+			/* If we are here then at least one of the link is
+			 * beaconing and since radio level information is
+			 * not present or single underlying radio is present,
+			 * no point in checking further and hence return if
+			 * flag requirements are not met.
+			 */
+			if (wiphy->n_radio < 2 &&
+			    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
+			     !(req->flags & NL80211_SCAN_FLAG_AP)))
+				return -EOPNOTSUPP;
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

---
base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
change-id: 20250527-fix_scan_ap_flag_requirement_during_mlo-d9bce1b859a1


