Return-Path: <linux-kernel+bounces-764181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F9EB21F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A86283F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF52E1C55;
	Tue, 12 Aug 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blKQY1wj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725762E11D5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983424; cv=none; b=Gyh62nhUoLqZL+AC6gML9VGaoVNFH26o7UlCMAMSbc6PAhfuymBk5RhV2OZw/FaiMHA0JEsmtoGZDHSviCgLCF2WQOrKiAJQZtg7Mv3fjFd0r8PY21yczcudQHQEq1jG9+5D3iLDQSmciQALncRfjWD4QOwjYLiRbA1Ty1QR9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983424; c=relaxed/simple;
	bh=UYcadRYXr0hB/LpshbSCa93NcV29IfZ1uCinKQV590M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KHn2t4FB6k/f9hHvdaRO6bBV5LsZPoC1V631ffn8vaUaxZm7BaY0A0HW3TMYjvWL0AAjNnRbIJ1j9lLANzEE2Bci+2ikftcKiOJyWuIZYoMZD4XciljT9iUw7pLKZ6UhKh9cnS2Ho8rUzzkdm3ueGYSlWJV9GZURxPiar1WLp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blKQY1wj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4Tu6e028799
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ExyA3JycNIOLJWXoCiZjpy
	At0MiQqaN81Bzc07dZh/M=; b=blKQY1wjRimyXk0ApoYXYeXu5u0BvY2OeEjgP9
	y+Ef8XuE6psqDc3gjeqYjG/JLNHZPhCS5kEXdk2njEH1BZ6+PewjCARUGS3fw1tz
	/JWnlFfWby+RriuwQ9kKREOvOTh7d/PHDg+AmQQo1BTw6FrhY8u8+ebUOfN2p4ce
	6yL5Miv2hlm23rj51s258XfsDvlVu5dgWsBs/FgKBWQtDUd+PrhdzhpsxYso4np3
	F698KVmKqtPPilQ0TgLRMqAKDunyGylvysPwAuz4dxWx2AyB8s/1il6FGFtJPt0d
	tXFLumUC87w/mHz3bqzEWVGWFTKJQeOxVSQJoqeBs95hjpdA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sqcjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:23:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b46e381d458so3090298a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983421; x=1755588221;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExyA3JycNIOLJWXoCiZjpyAt0MiQqaN81Bzc07dZh/M=;
        b=RFiJsB1O2EopO73Ub5cUd99LqcKtjWWK/ENx8QavbdVHWRztr53S9SpNnWw8HacDaN
         OjDu1AyGRzImhyur12LcqSBHM5O/3AKQyHkHbGWRpvWWuU0jofUdXUBsmVQ4I+M76dm3
         Runq7n09DnExuWxD1orkYycvMjXp0c7QS2EOQul8UJ5OkcU/+VXxPn5M8hkUynIyxjlE
         5I4Dn7deJIfxKZG7Ot3vbCBhtZIBj2vEhLJmLOJcQEDr/+m+oe+EbYl/8Zyywh9eSWq+
         Ngp7yOS9xwL0SR9Wf4H6gqdHFlJOB/iXLfdy6a/QQ93k6+gfBfRYpXKvCtvb3txyWd7l
         Vy8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfNsFZjOChMdV5wmZGX4rvfFpplVOKUZbH/9bnKKb7sSlgZgpzbBHBUv/F4K5Nl7Hrgylbt3nEBihfDfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYymB9Y7+V0NXEOspf/OOh3lu3uifD3+idkU8XeYnk5TL1TY2W
	UQll1RCgZodi7tBDiyUjbGVqMxT9bPmNvNNtK70RqOiHgXJn4jjcI2tGtOoBczKCrh35tvfk5yu
	q6cHigdO2jJyIrZ57/TleVmEigasWgNVrJZ9RCmf4zOsnGaXgKRY/B0f+a2lGDE1mQ6lt161aqh
	U=
X-Gm-Gg: ASbGnctOBjC9upuu0UfOM7OZyvm/lh2cToKxpoM9f7gDXhX1hOVLGWKRXG96DNaof5I
	lqhkzfTo7Sx1xMC7bW1zdLhDiFtumxPtj0wiZQSXM1KcRSVHdNkbfbng1cf4nanRfT4Zq3OsqAM
	J83YwEPdIWhWURqCt1BOv47kFGUhQG8IKJUTHH6ePapqH4ImdilOpQAq8onAtRFZYXvbv4DGRtq
	J9SHZW++qgweunrYDb8TOZ8l8ByPx69IZus22zRng8vOF/8893ZDzKxK8g8rJ7d27vtWfkL66X2
	P9XJFWWgISFX19WB0ySlmrj45ZPj/pbDAab/qBN1UZ7xYjmT5kQL5wT91Ujc2P33rxKZye7BaiR
	e6fSywX0EWRbYd2dZ5aITSgG7AlblmnNwcdaK1RnjB7U/LsL3cR9PBhid9TUf401Y
X-Received: by 2002:a05:6a20:3d8a:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-24055067b6dmr26284947637.11.1754983421565;
        Tue, 12 Aug 2025 00:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECMaDoSR+HNbdU6hRZJAwBpo6pxvVLPTWj8VWdVQmf0uK0fTdJZsTr/bSAYdWZyhv04DVc6Q==
X-Received: by 2002:a05:6a20:3d8a:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-24055067b6dmr26284927637.11.1754983421177;
        Tue, 12 Aug 2025 00:23:41 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:40 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 0/3]
 fix_scan_ap_flag_requirement_during_mlo
Date: Tue, 12 Aug 2025 12:53:27 +0530
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/rmmgC/5XPS2rDMBAG4KsEraugpx9d9R6lCEkeOQJbSiTbS
 Qi+exVTaKEtJJuBYTTf/LqhDMlDRq+7G0qw+OxjKI142SF70KEH7LvSI0aYJJLV2PmLylYHpY/
 KDbpXCU6zTzBCmFQ3Jx96NQ4Rd62xQE0jW01R0Y4Jyup26R2dy8IAOeMAlwl9lPHB5ymm65Zjo
 dujp08uFFNciYrwpgXujHyLOe9Psx5sHMd9KfcgX2zzHMultgS4Zq42v9n7Dxb2nbpi4nGeFd4
 2pKo7AkAd+YfnP3n5OM8L31ktSGMoMVr8wa/r+gl9062gCQIAAA==
X-Change-ID: 20250527-fix_scan_ap_flag_requirement_during_mlo-d9bce1b859a1
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689aebfe cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8YmMewk-oKCO_nzgKkgA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ZiT_1LrNEZ82LOxf_48Bu1OtCsVp1D_r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX2gpuj18mOrK7
 wASLKSTq7PiBtGKCUnFhnLF+9uoThZWbIrGeOq/hNteC5dguo12kpKJbJQmCY8i4zh1GsYp3RsG
 9pUa7zU+nkaXSRMi1CezHxOUHSlkU6IioAvG/gOBUiXKgMu8Y14RCFqUGrPm3tTqp8xBnNlqOEr
 Tbfseq6MXI2YLqlwODC3pypsKBXAaYh4odvmafNWCAKE/sQW4kXU5OLAEPaolFwPac6DvvH8ik4
 rFKWFOVEU+6tOhd81/+FfDrRi6RwnY3XRXY488se9ox1QCV4ausyG5oQN4sewFg7wgdfi5Xb4MZ
 wEI+ZjI2Nv0BOHRvPesMBaWdNVSdgPfIWizkcjSy9tLnr8LrmiqOFKmfzIeQ2RSfM1GuNEeQfyF
 VsBlW9m7
X-Proofpoint-GUID: ZiT_1LrNEZ82LOxf_48Bu1OtCsVp1D_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

Patch 1 and 2 are clean ups.
Patch 3 is actually fixing the issue.

---
Changes in v4:
- Rebased on ToT.
- Handled get radio idx callers properly and simplified the logic overall. 
- Link to v3: https://lore.kernel.org/r/20250625-fix_scan_ap_flag_requirement_during_mlo-v3-1-dca408b10ba4@oss.qualcomm.com

Changes in v3:
- Rebased on ToT.
- Fixed hwsim warning issues.
- Link to v2: https://lore.kernel.org/r/20250624-fix_scan_ap_flag_requirement_during_mlo-v2-1-c8067d0ee1f0@oss.qualcomm.com

Changes in v2:
- Rebased on ToT after dependent changes got merged.
- Link to v1: https://lore.kernel.org/r/20250528-fix_scan_ap_flag_requirement_during_mlo-v1-1-35ac0e3a2f7b@oss.qualcomm.com

---
Aditya Kumar Singh (3):
      wifi: cfg80211: fix return value in cfg80211_get_radio_idx_by_chan()
      wifi: mac80211: simplify return value handling of cfg80211_get_radio_idx_by_chan()
      wifi: mac80211: consider links for validating SCAN_FLAG_AP in scan request during MLO

 include/net/cfg80211.h |  2 +-
 net/mac80211/cfg.c     | 34 +++++++++++++++++-----------------
 net/mac80211/chan.c    | 11 -----------
 net/mac80211/util.c    | 15 ++++++---------
 net/wireless/util.c    |  2 +-
 5 files changed, 25 insertions(+), 39 deletions(-)
---
base-commit: d9104cec3e8fe4b458b74709853231385779001f
change-id: 20250527-fix_scan_ap_flag_requirement_during_mlo-d9bce1b859a1


