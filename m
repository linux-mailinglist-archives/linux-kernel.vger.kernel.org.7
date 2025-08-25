Return-Path: <linux-kernel+bounces-784920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADBB34384
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73FF1A832FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930A302CC1;
	Mon, 25 Aug 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hn7sQ+IW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6248302CA0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131546; cv=none; b=B+7Z66gkerQ8zo+GldChZdJCi0d/UYjuJqjULEO6YcDsbhvHFlJrxyem2yZ6uI15ltfuGdTkjPzMDWEh6i4ftZ6EiD1jQg7gEps4Fl0dekmwkPbIJllIoTVaml/VI8cD6KH7VBTJU3L42WJKzSq30C4ttWxZuUakaDIFQIbjQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131546; c=relaxed/simple;
	bh=pTkO5lrOCRU2az1iDakadNH2filyq5+0cOxmM1NYfG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEoXZ95XiROArtsvY7myP5DnC4fqpJi3Vb5n4akflrxux6UYBYdhY/gg34+L+gZUv1Q/wbQdyGj4NoS2EZg9nlw8DQ31BWGn7oCIBC8/abmTvhv5eyieZqjsYBdjZEUpUiwvmKYLeWnICFFmAuxzpeoJ4QlxWWd3ZPxl7wzcyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hn7sQ+IW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8fic5029424
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rAhM4RTVeSeD/Y6Dbpn0SMNYvVqhAEKxN2xxqLLpF3U=; b=hn7sQ+IWfBj2jg8E
	HMgZxSbjSW88vsHP6pfIWCVgFSP6ELlszyyLF6DAzUxZNXSLxIoxSu/X7QHEd9cj
	S6Xedbwbe3aMAKRqBBcM7gGTnb2fvNul/w4iDGd+/icl/7TA+bf1ZOFfJ426B6xz
	D3IbU0jwHyneq+sgJyF6GHUAnCEo2WQzRonngsZTSEeG9rbUbW0/31d4MmH9y+uF
	aWkoVuT3X58zGlOm85m0GCeK+OQN05aiDj/6oy3w2wqfnTx+SnAy2O3/ugQr3DaC
	Uv7rbphZshuRd87s88YVgwRzQ0HzauZQwLrjB6inOhivHZbQHjSRu2WsrztkxgAd
	lhUdzw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6de5dqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-770562b1ed3so2549085b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131542; x=1756736342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAhM4RTVeSeD/Y6Dbpn0SMNYvVqhAEKxN2xxqLLpF3U=;
        b=gMs4I3dHpkoRX13tf5D/gvnU4qs9h3Tj42mINquwkWvKhge9pb+CGxXNB3x4skdhc/
         qav977Qo2MlXhxfnR757aVBWo+aKSZvrSPztodf8EJrx6FzJ5pLMF8f70+7gJD7KuAYv
         x6iROW68tsasEtH26C44w/6DKPwCHCgmor4h2JMJOiWrDJTWODC1EChOp7/MT15vUU93
         OX2JYkvL/QYhBFUt84FH/RsmBg8FA7NDg2tmMSN5FBkTBekeMgbk0Mz/LxmClBHaRUO9
         7ajPr1rZHEABvkbG7UuJQR3EOQjAACfBkVCVWDFFCrDMwOD6gKijqoJd+LbdfbINxvnB
         dUZw==
X-Forwarded-Encrypted: i=1; AJvYcCWbfmnsADP59Zv0otv9Iqo7qRoM7OIch4A8p3UzK/f1RZ9G7NYGLqXfiv7eyz4dBwkwzUs1b/0fgnY15Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnNhlDyWFQ344H1jC0M4jMUdY3gGqHcoGXrbHOKXykz8f5MkR
	3NfdlFbIIjeSLpIo/0qupn/a+Xntaj5Cqu5h+TRsB67W3WnaxUOLDcEAENEwEMEvFVAhIMK2fwh
	NY1NTAEob2sSUz6f9VZ3681Hx2VcusSdgD4y5/XJT0WpTc/F+ShnDYQAE0i1BwJARgtA=
X-Gm-Gg: ASbGnctIB6qNHWAM8L917EVzywzsDwEPTY10yHixHNFolGWIhfyNvL47Qq+SH3fxg6I
	c2E8dzn6sHGytm4UJPYYA7bcp9egjFdFTlusz2sVnuzDoTDT+wDwi96ou4IfZyzceLiACcN24kT
	YtjDU6RsX17Oqgvt0zrivWw9FnE256P3nZMGgEL8D7Ird0yGxbcbB8OqsbuI7txjcBZ73p3s93W
	exErIUdcygIWh9vMG80Nw9+gJlv6EDCtctTtAKcjhcAwxQ/DdLczxEfrAmMUGbel5p/ncw3TSVK
	7+A7fIDj2BsolqVPAR5ffQvIKYwDsDkkbeyAJV3TTgBa4U3XbXuVTVuI5ISFXQuCikFmajM=
X-Received: by 2002:a05:6a00:a94:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-7702f9df069mr13576465b3a.1.1756131542176;
        Mon, 25 Aug 2025 07:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSPY1HtSJ8tKKojzOATDlJlkBa+IcBpDR1Y1au0tLWU6lqQsO/HxxDw/4m60LXZ6fiBBdK9A==
X-Received: by 2002:a05:6a00:a94:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-7702f9df069mr13576414b3a.1.1756131541613;
        Mon, 25 Aug 2025 07:19:01 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:01 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:13 +0800
Subject: [PATCH v3 27/38] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-27-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131423; l=2282;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=TSQ0bYxvwSdSGTKkoBYhDKBWe3uInELiHmXnk72zRV4=;
 b=duMBgo0ElFERIwAsvUqi6eTSil8TrCpytGdMUtwvdCYzvbKFkhAt8aEGrEl9QJIdII6AXu1ut
 3dsERUkZHWDCiDyny5YNcGzsI0szfwwtzR8XmZ/2ISS4ozrDZKG7WH4
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNyBTYWx0ZWRfX/y1cpleGXpUB
 aUx5wtUu17Y77Trb5QVok45Sb97O5mkD2a4LARAvzGEz7KbGD6obEFuA+Vhuwm3/bNjcXS91Qxn
 LIYOUeiHppQyREdCdChbI9foQndJ+XLn9AzCNRlfXifOpeTB5HBNYv7a+hlDwhT4YE9ef6Km3ow
 IewPbhrJHaQ2ykrJbDwtM1VLhPeLIGw2llBpusOT5otc+647izu1VqTeBhspVXnMloKrpAVOaR4
 NZw/LLqjM0reDBKDWW2aVZIMLADX+mOIVUx3/KCweuffK1uOzD/clwevjMzG4LNJ7Ch4y5SY+1o
 aBgwglVE4cbdwZwVylyWNVjbTL5W5fFN/BsueBJ5RkBH0L+BGrKEsrXZC4h+cSt0oKyU/mJYjjK
 O5xMz6rP
X-Proofpoint-ORIG-GUID: HeH8NUoSaXsCRspMLlF6SNm-IGWY60Sl
X-Proofpoint-GUID: HeH8NUoSaXsCRspMLlF6SNm-IGWY60Sl
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68ac70d7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=6cFZRJIsygQ8aEszaMkA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230037

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add an API dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 84df34306fb557341bea288ea8c13b0c81b11919..abcab3ed43b6da5ef898355cf9b7561cd9fe0404 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -632,6 +632,29 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 	return 0;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+			       dp->link_base, dp->mst2link_base, dp->mst3link_base,
+			       dp->pixel_base);
+
+	if (IS_ERR(dp->panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	memcpy(dp_panel->dpcd, dp->panel->dpcd, DP_RECEIVER_CAP_SIZE);
+	memcpy(&dp_panel->link_info, &dp->panel->link_info,
+	       sizeof(dp->panel->link_info));
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index b1ea027438d952c94f3ae80725c92e46c631bdb2..d5889b801d190b6f33b180ead898c1e4ebcbf8f3 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -65,4 +65,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
 
 int msm_dp_display_get_active_stream_cnt(struct msm_dp *msm_dp_display);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display);
+
 #endif /* _DP_DISPLAY_H_ */

-- 
2.34.1


