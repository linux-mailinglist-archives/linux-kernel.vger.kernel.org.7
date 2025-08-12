Return-Path: <linux-kernel+bounces-764182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D288B21F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA41B2A6E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE92DEA90;
	Tue, 12 Aug 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UMH6I2FI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7A2E1C65
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983427; cv=none; b=MtzE/pkGPt0Ug6ptPFlHWYTwoBPQEuUzHhUmeB7UaqUk5bggdpvpBQ+p3Jq5c7aO9hubH2OGoNbJ6TgBK6hsHyjKMYa+6ZL5PJumDwCR18BpGtMUUh7AlxnyCU1llNGUSWzW0L/PSQomJJTlJZKuHUAWypyYJWf2OZbYNmlGTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983427; c=relaxed/simple;
	bh=DtC2OsVOKnqsrqtLTXkC7XoJUJzmg1JNdxss1XeeorU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPKPdrsb6MtQTB95ghHcF+T4f1loigKX1C2XtLlHb7w2h6grAPZVVHoY1YV44hwp8XFqgHTjaSvhMPzILLIMxIWWBiOQvsOY7yOqmXljQ1pO8/zg4zZ+UGZXb+a4en9Ndyo2yjhOVi5US91xLpl80g1gXd3QJfydIYX9R+eXgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UMH6I2FI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5XG9K021498
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0B4qMvpNIioMsMKLoBwgy4Arte0jfm66EiAkWrIKbZY=; b=UMH6I2FIBpyFFOvy
	vneN8KqKcvVyI8iDEKY2o5cXUifVY1gLOWY/KhXUFOAliSsQs4OmyYwo+zIHCroy
	fxdSiw8Q68ZpjQDYLxVW9Uq/K117ewRnj6IfvLSCN8bONOmpIu+pH56gEmk2d2dm
	H5bZPZE0t25ow8xjzeWztwQoSYbarH+qGxdEskurXGcj3TGVp4GdCmNaxNcYOGcm
	lQN8xe0/GginY418adxI21zmhpuTnz0eWEm29/IbLGbypCYnHvvk9s76mC3V1eNg
	gajP/iazq6N36l4eo7kQCjctp2oKo4upm6vHKayF1ZJ+IwkCj0T0F7cvFSzRUlQM
	H27NvA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vj34k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b423dcff27aso8851743a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983424; x=1755588224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B4qMvpNIioMsMKLoBwgy4Arte0jfm66EiAkWrIKbZY=;
        b=lTyYtwhzqleH+vN/H1om9zNezj6R0jr/e6GcoQekgR/C6RoiCrHTy+y1QRdDD55gac
         VuAH2E0Yv3+UT1dW8dwQSixC0RwxZkZ9K+ltMx7q8GFb5ANNfbBtG93EbWmcF45tFabo
         ChJuM2BUx/NOGODIHVM5lfKYsUSgMFsHjMXPh9rxsm2uPf6/v6CnD7bZNZbI8SXkX7xr
         jJRUNQP8/cDR7bvdAv9y5LqUoI3ET8MiICbEbApC1amcHBQ9+t9xJrLWd6ZdIUdi+luZ
         f4o3BS10sud9vu2beYu9O2uqyLEKowSixvnfcTTUEqNDMe6q0pvNiNT1tJjz2idKwKYA
         13MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaCROrupB12G5QS5fNR7jM3S9bAs1T6cB9y6knLzYth1xqxkutZ4SUtrR2eUyIC7WfAlp95Jcy5epP6qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbqRUJ0AaeBxkIzubEKskpUOemlfcpgPsYByRhUy1TgV4C43s
	jkTkQm4DiHYCwfEnZYvzYqdjkQuKIhDhAS8SEcHErxyFmRfPIEuV47nqAG/wJmg6tDNN30HrEVx
	jO2PHpJG/94OZFUH0VulpXyLHGH1nao7JJRxoDHKdB++4yM4WV8u4o+LoBpROPt43HUw=
X-Gm-Gg: ASbGnctvBnjK70TGmf1m1GwbmHVkGWa2n1FXhMllLWc6VMguk7qXYCZp0YjbE0+5lc9
	3u6KYFD3rij0kNaYwVHlfDFwlQ7OT0oWOVW8ORV1Go+SSuM5bBwyDN3FIQXX1iSUn0OEX3B5qYh
	GqPi6SGVTuHO8lNOX4GvOB0ZZPpuJfrKUu7DVbk+Xn7Swc/evhrE8rzAmm/16dObRnKr7IPdzeU
	+guRCvJ2ETFbSLvY+aPPXpNwpME90ZjpkzCh4+5S7469LsgJ7c3r3dOwNImcjL6g8yCkB5v3f42
	3XN1K12yxqNcwOVfzw4wwif6sn6OYdKpux4jsJMjFQ8ilSk3bt6FWinCNdI1aCvVLdzyKwM+lM/
	WI1v6hgBGGLXDBP3ruS1PGA4FVb4EAqD/0tHkXRWl3bwgs073FH8LWl5XXKwH3CMz
X-Received: by 2002:a05:6a20:548d:b0:240:2421:b912 with SMTP id adf61e73a8af0-240551f3000mr22882661637.37.1754983423721;
        Tue, 12 Aug 2025 00:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGccrCLKxIJC3TIBr35+6WgaVzfukq44h2Rsk86RhNLOA5ZjFQm0bJpPgTKOY3SrfRO7bcjkg==
X-Received: by 2002:a05:6a20:548d:b0:240:2421:b912 with SMTP id adf61e73a8af0-240551f3000mr22882632637.37.1754983423271;
        Tue, 12 Aug 2025 00:23:43 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:42 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:53:28 +0530
Subject: [PATCH wireless-next v4 1/3] wifi: cfg80211: fix return value in
 cfg80211_get_radio_idx_by_chan()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-1-383ffb6da213@oss.qualcomm.com>
References: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
In-Reply-To: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXz02WRv0jkvKJ
 ir0JO9HxUYo1e/hvBg/NV9Ks4BOVzItdqXHWqZ5JlELzXx2nfC2JsAFggVN0zrXHwWQojcbKSpL
 41YlTmQKBOXj9bB6GZb9d/0dBe2bZLvMaYWdHRCXjOhMgphNUju0CHGjjTLjBAKdJwMcU1obyI+
 W0yRKBEhsU0fZzAWw7/PTCB1yf946u/v3IJq6wHfPmwD3YgVQCQO/B4sbnGnx5bMdlXrzW8p4D6
 brAYcJZgl5q64OlezArmKUZBKLbSjsw40w8DcjfYp8n3klbknPsBQ+I0KaDvv0uQPK80KGNyH0S
 25VkXh577km8VkTGygHx9CaPn8LNCHIFOtS6t9lf5rd79HZZfC3Q86xM+J2Qluhr0yMnPa+uQrt
 tX+7m24R
X-Proofpoint-GUID: t9_jjjwn9JhUWxs63xTHWGAsbzUXGTMU
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689aec00 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KvhtT1cOtCMy9zCwnqwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: t9_jjjwn9JhUWxs63xTHWGAsbzUXGTMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

If a valid radio index is not found, the function returns -ENOENT. If the
channel argument itself is invalid, it returns -EINVAL. However, since the
caller only checks for < 0, the distinction between these error codes is
not utilized much. Also, handling these two distinct error codes throughout
the codebase adds complexity, as both cases must be addressed separately. A
subsequent change aims to simplify this by using a single error code for
all invalid cases, making error handling more consistent and streamlined.

To support this change, update the return value to -EINVAL when a valid
radio index is not found. This is still appropriate because, even if the
channel argument is structurally valid, the absence of a corresponding
radio index implies that the argument is effectively invalid—otherwise, a
valid index would have been found.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/util.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc89df4df30e6e623403b4d9ceb6cbd..cb1c36be27493bc0b356497cdbc68f1be7b4a94d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9548,7 +9548,7 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
  * @wiphy: the wiphy
  * @chan: channel for which the supported radio index is required
  *
- * Return: radio index on success or a negative error code
+ * Return: radio index on success or -EINVAL otherwise
  */
 int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
 				   const struct ieee80211_channel *chan);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 240c68baa3d1f71a80a36af854acf4aa7ce75d05..d12d49134c88159f19c2226517d129f74f3ce764 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2584,7 +2584,7 @@ int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
 		}
 	}
 
-	return -ENOENT;
+	return -EINVAL;
 }
 EXPORT_SYMBOL(cfg80211_get_radio_idx_by_chan);
 

-- 
2.34.1


