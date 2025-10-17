Return-Path: <linux-kernel+bounces-857232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F490BE643F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5911A64E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C130F55E;
	Fri, 17 Oct 2025 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNZ7fYCZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034030EF72
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674100; cv=none; b=rOoitAij18K1Jj/K6mKJOOPlKUFatFNE8Z+bUbm/z34grbSzw7je/wC23GfIaY4PRqF0uHRCUJtbd7EoJ6/E49a0p8Zur3lLHnHu30fXTqcPOkfViUXqXLmXh3qas1Iul754d0W+dj22IiKvtNAen2Cd/o5lqvEI3/tsu40WYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674100; c=relaxed/simple;
	bh=sG8S76iua8wQxnfu5QaKX0Y54Ntq78nz2q5CLpehoEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/Mca+H5CejYxnMzqXSstUO0fs6nPYgP3xK5B5LJOjPRGw0+yTd9VSkYG222BVWXZJcP5T2EyeMsaU/zamMTmwO0JhfwSMuUZJTm4smhp560NsFLcAARJMPhbG6+yJS06N2kuXeEseEEuu7hV3IxOmR/TnGkgnbLXJj7EVkftWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNZ7fYCZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLg0u009754
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vOd1s0xzTmHuz/VFeRFh8thGs7i2iDojrILESN1HW4=; b=PNZ7fYCZUyFWvIxC
	G+9AwbYhG9fNjJFSTCkmYOyOxxWjniebFiC+APR6v3mtRJa3UddeKu5ufax3Kv/j
	ycuAOgOm53445tUY84FH+pSVMsWSMYgXiN36MhOzcuUgxUexII19ya4eAhKJF1WU
	0yBoW8PvYCo/ZM8FKs8hAHhqfw3mWEDn1xxRTIHdRDrcQis2j9gm/QqGKloUyrWx
	n9M4otOxgTXoUh+fDQg1ueTe406MevikMw8a4Lokg7C2tIQf5U7lvQy9Sggz7cYo
	GJC4dTsJFJdCWzBug62BuCG5xHsMUpIs4CReULPbqk/7KsHow8+f2r1t5cxzTXjj
	iwJ1RA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1aq19p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b631ba3d31eso1077002a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674097; x=1761278897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vOd1s0xzTmHuz/VFeRFh8thGs7i2iDojrILESN1HW4=;
        b=ai6G/S/dojJpp1V1bG5lbwXX+PPTtEMY1UlnHl76Vwjv3cKk2wzF9Cld1RSvW+ELYX
         l0QGJ2uxrzmy1z/YrIDrYqBWs4PZbtf68gN8tUNb3E1ApShJDTThv0HuB7VRyVC9ASDp
         zzlHonsPfHT0Nz7Xi0ihzpq35AfLqlUaOnUg/6ltdmuRsZpXsv7mvB6PS8ED1B59XG6y
         6iVrmjX9QgJ7ASX0l06KBC0KUCJn/dh9kNfffntlAh9Fph/dgAAMDxThvpnq9u0a77+r
         VjIFlUJ3Ca1kNDjwEqN0hww3nYUbzun+iixSiM0sp/qG+iFiygdMhdfbdrfT5DiVY1wE
         EIRg==
X-Forwarded-Encrypted: i=1; AJvYcCVT3SaXzFnlbHorlYeAdSDV+9u5qjSHLJXgjX9NRti54GpxiLmyx6lzFVwbsDOSacandQr3oZNQTAOxo2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/s6Ph72bG8QVMt/0R81lOFdfvBQUS7itSUKTP+P70vNlZb6cc
	VCWPQCIZGx0iYlwq0q7IIGG+eAUlpwEcG8yQMOGsnGe9BuTI1RC47MILmsKZ5yVZ+E+bTPLwIbU
	M6yri5ZdN9jyCMkBEBJcrHXosjMTseopLJd/oE226gLD6Jprw6PoapyjFDsNTP7J5X3s=
X-Gm-Gg: ASbGncuD9Nwhkvs0mN1ZLsTAk1B5YbBWhvbnlOeVsqadwbPpLYn8FKiaC543SrJ/pcs
	lBKOQv7fWkNlYB03WqVN04MM6usN4XvXXF7/SQyfRsxHCWUWdW5TMdY+tTAjm98fMgs/omepKSJ
	E+1biCEr7MBb8KMrS+gxOrp9xfhTJvAOBfZ4++2Q8bpSOUVScK1lAwGOeKNHzPUIVDoleli9btR
	CGYQEz47cgljAf6cwBVIGpomCVXUuybo+kv3oteJdxkhqR3pHU8ol7hKuJUq9AC7RUwXWe9JnLs
	RJPWerj8tCUAhPIQn9S8Bnc1P+SYMeAvCWlgYimwfKuF7+dY+PWM10vFq2j/RoSkIclz5MQqm+1
	kqbCFJo+0tnCK0SC3H2qysBv2fPO3KVe+mOnrO7KdNSHgpWjhUte50MCoAubAczpsVzCBtBlJRx
	PWbVcUzV2s4HNV+YrUo1pijCg=
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-290cc2f83a5mr28436125ad.40.1760674097426;
        Thu, 16 Oct 2025 21:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiN7L2yUjdFr/LpdDmY+/QiQ3okGiPKE7r38tveBTIAwYhGCdTLa2YZJcf7W5up77l+rmgIQ==
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-290cc2f83a5mr28435885ad.40.1760674096991;
        Thu, 16 Oct 2025 21:08:16 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:16 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:38:00 +0530
Subject: [PATCH ath-next 4/4] wifi: ath11k: advertise
 NL80211_FEATURE_TX_POWER_INSERTION
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-4-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f1c132 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Q_Yd3DzVMxYqS39AGnIA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 9BnTUQt8pGjX5I0WTnDN0A27YLHs_fbF
X-Proofpoint-ORIG-GUID: 9BnTUQt8pGjX5I0WTnDN0A27YLHs_fbF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX9SSDXCOz6wjK
 qn65lO9Vpk0/ZkDXC0HdEluh2pat9rJuEF8PwWCotnfPJJjrGswIi2LkFNyT1nMM7s9inqEw5N3
 1n/r/4vMW8Sh8fxgO8eqHfBvCmoM+bROde/112PX3bbNN7nT8mBnQE7hN6v+evfCVNoXL9U4Thf
 f8o2OcIUPepbRAsoqRRpdY85AgnD8B3jug5oF2q5dNAiMYxwmB0maoukd52camFcpy4URb3efx+
 MY+RXRr6LuGFI0x8ExibXtkukmQxwxNTNvTIPGKFy6AuUKfMSsdYxR+E1evvf+TUJNs2jnd4L8p
 jYWWFFHFqakk4qiQE+8nHTDi65mtdPXC4sPBtcu98E24lgdQ1/BqtXrc4rXVRatuni8VxRHlwut
 BJOjQWCYEVId3JaB/7d0Tczlvlq1gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

Now that driver is capable of inserting Tx power, advertise the support
for the same to upper layers.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 773ea1d4b358..23b02e505099 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -10543,6 +10543,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
+	ar->hw->wiphy->features |= NL80211_FEATURE_TX_POWER_INSERTION;
+
 	ar->max_num_stations = TARGET_NUM_STATIONS(ab);
 	ar->max_num_peers = TARGET_NUM_PEERS_PDEV(ab);
 

-- 
2.34.1


