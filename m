Return-Path: <linux-kernel+bounces-769897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BDB274D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DB41CE26EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D84288C38;
	Fri, 15 Aug 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fd03oLg3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16072877D9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222328; cv=none; b=kEdT5LEl2TbZlfLrG66Aqb8KTj8UiOwcgek+0Ra4OmJPNviek/PScpMxV0V5S/jOhb2b1vyYOrii+GLuQfi3fwQ0lLC2Tz684eyItb7Ib1Cn1XtELGG+k9Vnk5SRumVAEdLJiUyAsVNYkH71NJw/v4h6zVLnw4l9ykHxg5fdInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222328; c=relaxed/simple;
	bh=rlydFC+d2bX9ULKW8mN9KviQO2RPvRtnZWR6YiURGYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mv90nwQccPMQvUerdwIKf72sIDgkzBHNgpYGRglLZ6yI8n6KowsA7MGnJAqf+XNX5vddeFb7YiZylMDREefWaowWIIgej7IV2svO/T190e46Ub3ALuAsi58jCrwHl2/TfadTW6CMU7NzXg0pSmntpjxPoRmHpR5Y05MTO4YmSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fd03oLg3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EIRGEI012963
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zlsOJK5oVN3gW0ovDjkscdY5GxIZWuWXxKFxu34qXhg=; b=fd03oLg3y6Izcc+W
	BLyxaO7osrOdVreAQhjHOBb6GhsBuVA4cWyhIk5ocH0aY9b38jRJlIFJkxTuJG6P
	Ee2MKkKfvg2GA0t4Iqkl9/vqJ2K5YvwAOoBzs8WQl7Gl4+i6VPrljH8BXk12iEL5
	xdjBO/ymfts83GSNuHuPILo2TRkSfAzq5+/2s4QjJmxNZ+vIe4qkVhkkgxIE13IA
	KXdh4WxKoHoijmCOME0VmuVRQBhCB2789HTEXBxFZR3X5p8jzSLxJwDlLjXHt5M+
	DSO78aXZBxlYv2pUyuek9y38NV0C2iPJsaKAuOBY4LFbT3QobQruNIJWf8EF+JhL
	bMK+KA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6whpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4716fc56a9so1844397a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222325; x=1755827125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlsOJK5oVN3gW0ovDjkscdY5GxIZWuWXxKFxu34qXhg=;
        b=aKZbo8KqnbyxTkgGun+U50meCMnQjmJFSnLbEHgsvw7qEYvDqAApqJyX5k517j28FA
         ScW4LTj689/mnbl9mmcxkPXy6OZqUyvxA8bvVtL+pytFpKKqUFOxDMGboOtLHuHlaTsW
         QQv/WRUzxSaioVk5CZMh+73U2MNhvGVb//sShL+Ajcz135PCf1WLhIQPI62bLX62dGKc
         ZVl9NCB/NdA+RXEiqnPdBJt1iKyAyCd8Qp1F9oaXbakp7v7F3sk/eWdVurDRCHZ/ZXic
         U/6R8Vk9pL015fC0Ys7zsXlilR2aiAtrI34T43SC3nfRFfbp6sYEPyiSO0MSzLXGlv3t
         Kb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnXosSaEn4XFrC8MPLjYGLJ1jvFiqQCk7lZHlmFPLSxnaXh8otFDFctzIa/l2+0589wwVV9D6QDp/lyQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVh5DAVOBY8blubCR2GNc7uz9GllVEX7+CGHkqLZvXX6UlybWC
	MZlcgDZAaswJphRCeu5F0Pmk6be2QM1pZwxJEQed9i+W95YJMxXPFNat2jfcwZF8v2B5Q3hlmdE
	uufqQ5QiAVXv5lhsekJNhtQbDG/O3qfJVML2D6LRy7Dl9gjhChk3+bPQF1pDshNdaV6o=
X-Gm-Gg: ASbGncvlQn9WZghiorfJWSP2WqptYyqKm/ByKIWHCsFbeS++OJX09VZLsQ9p9Tm78Y9
	O80cvAf480oupkJJWYN0mq+PDEBt2fGa0ANGXeC01ilzsE4LHLuZznRQdEF8DWVww6WQm1ZJtwM
	ZIzOZgSkOIvN8C//NdOr/Zvh1y6MjHeHIm3rjOUofGfXoX4MYxNOXQp96KOjhIX93q0QQJAhbrL
	C+6X1d83Z4BNJ5aMyZ6/yVicJKS+/JHgoK+8/P2ZTqA6YKWv/lAlbkRPMxen2rB4HukJe01FH9u
	E8uwPSi0nimUWVZirWHfiyi0v8MORRAf57ZsfxVpRJqsUbv6bC4xlkDCsRUrJCQzyJeBawo+pHb
	MEOWjswMsktfTUjiI
X-Received: by 2002:a05:6a20:430d:b0:238:351a:6437 with SMTP id adf61e73a8af0-240d2f3f71bmr628324637.43.1755222324999;
        Thu, 14 Aug 2025 18:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAx/TsRQqAm4kbPDgVI2KzEGpjPVvzLo1WQbeY5Z9fq04iIy5aj3QYJ7X0o5DKPHyKP5YAQ==
X-Received: by 2002:a05:6a20:430d:b0:238:351a:6437 with SMTP id adf61e73a8af0-240d2f3f71bmr628291637.43.1755222324516;
        Thu, 14 Aug 2025 18:45:24 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:24 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:44:58 +0800
Subject: [PATCH ath-next 3/3] wifi: ath12k: downgrade log level for CE
 buffer enqueue failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-3-f955ddc3ba7a@oss.qualcomm.com>
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX2uYtjphLEfF8
 lPkHTikKELPNg1O2m2hDcFtAwG7zhOdfAPOGIc6otLSGiyeYuAKHYAqhzAppKc/153oDROIBgMh
 XcF9i591V33IB6G3oVicDg/00ojz/OzuyOp+zoZmmPbMn9QFMRfoQopsMykiOy5ir91P8sj55Px
 C6QP7MgMzSMdRRpECyfsxeu+LNhkfDQIew2dhE+dMErzsggblpamzlyF2sO5zBbgn0DBTpED51/
 9NvQ4ha75AGB+HiMCHvzGr0Oe5ruSlUk/yjYHWgiGtLC6u2ANRwDPXX7o51kTc+ZeiemXln5ICp
 celc19AIMnIJQN5J2VK9FGm00UFrwj16TNYccdlv42eJhJTv/myda0zmSZMhvCWmEopA9L2l+LN
 TUu0YgVr
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689e9135 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4avV6w9vhD41MOPHW_EA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: XQGAguEeSBE4_yVe3eqOP9CenoIr0UlS
X-Proofpoint-ORIG-GUID: XQGAguEeSBE4_yVe3eqOP9CenoIr0UlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

There are two rings involved in the Copy Engine (CE) receive path
handling, the CE status (STS) ring and the CE destination (DST) ring.
Each time CE hardware needs to send an event (e.g. WMI event) to host,
CE hardware finds a buffer (to which the tail pointer (TP) points) in
DST ring and fills it with payload, then hardware fills meta data in
STS ring and fires interrupt to host. Please note the TP of DST ring is
expected to be advanced by CE hardware before interrupting host. While
handling the interrupt, host finds that DST ring buffers are used hence
increases rx_buf_needed to record the number of buffers to be replenished.
Note before that, host compares TP and head pointer (HP) of DST ring to
see if there is available space. Normally rx_buf_needed simply equals
available space. But sometimes CE hardware doesn't (for whatever reason)
update TP timely, making the comparison fails, then enqueue is cancelled
and a warning is logged.

However even enqueue fails this time, rx_buf_needed still records the
numbers of needed buffers. Later when TP gets updated correctly, the
missing buffer will be eventually replenished. And there is no doubt on
the late update, it always comes (or lots of such warnings should be seen).

Since this won't cause any functional issue, downgrade logging level to
avoid misleading.

Compile tested only.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index c5aadbc6367ce0d18080bb0e15a88d3ddf2e34ff..9a63608838ace31587691dd53c1d4aa8f081cb6f 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -392,7 +392,8 @@ static int ath12k_ce_rx_post_pipe(struct ath12k_ce_pipe *pipe)
 
 		ret = ath12k_ce_rx_buf_enqueue_pipe(pipe, skb, paddr);
 		if (ret) {
-			ath12k_warn(ab, "failed to enqueue rx buf: %d\n", ret);
+			ath12k_dbg(ab, ATH12K_DBG_CE, "failed to enqueue rx buf: %d\n",
+				   ret);
 			dma_unmap_single(ab->dev, paddr,
 					 skb->len + skb_tailroom(skb),
 					 DMA_FROM_DEVICE);

-- 
2.25.1


