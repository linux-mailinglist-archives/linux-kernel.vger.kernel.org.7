Return-Path: <linux-kernel+bounces-728468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EEB028A9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B8D16A5CC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5E1C84D3;
	Sat, 12 Jul 2025 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZxbK+gQ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89813C81B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281919; cv=none; b=CgTqCCB7JDq3lnobrjae689MOCwHqyJyaLrIQVoWtFaoGXGTAGlp8QqeZZUA38nKXnEmnj4a1qVWjd1cJBqojqvmhJrpCUZ0Ea8W/KT90Ys0LQ82zmacT/0eCvYyNUD0aJTARphPAKgiiN+UM2nnSaoZ3axI1/q1Z0opoYKl+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281919; c=relaxed/simple;
	bh=48wdgPtyNZwMd6sZV3ZvvtvNWOvHLwkNGaRnCDc5QMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8Znt1fDI6Y83Zm9XjJOAmUSgWRdG6iyDdEhpgYqtgSCJLKWE3zh8oQPLzjnJJUugRDssusxosmgLKQNRjowQVhs+xuJw1nBloRyrRzAQQz33ICpgJdzHk1bnDbFKoT91CiWvEBxqJEEG0EeDn2Q9v/aLRtb2GWnrReboo2zIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZxbK+gQ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C00HIw000664
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ztg4BCYx+5l4ffFBXcfolxY/m0CGJMjBeYa+I+72rCQ=; b=ZxbK+gQ3o7Lg9I6o
	tW32UyfO1cE7hcJZNK52s6E4qCyyLXtZD3NlGUJWVHJIqQzMaW+zR5FJDYshzoZG
	WGfyr4GJr+7DGenQlUAyffo2YMu+unknAwcPrtgoYskZ4CNKf1r7C1GsuAAozurz
	7UCHEyr26QK04gctvrweQeOMfyvTd6BFhYHdyzdvTZv9jVVQJftY5txVtGa6H3Di
	kbP7XhYsakcEgOE4sgWQyqqXgKz1WKitp1dXXxOhcKfuqlJq6dJsxUSpmaUM+d1r
	gv1bs5iry7WxdWuTv66MZ6UW8B2+sOimH1zxdHYGAyK7spoS+/3qUJeMuRkHmxSr
	Vu5yxw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbet97r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31366819969so2729678a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281916; x=1752886716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ztg4BCYx+5l4ffFBXcfolxY/m0CGJMjBeYa+I+72rCQ=;
        b=fPkyc/O74a8K4FdgI5z1ypLGhT+Pk8pRgdBtCMbMqt/nM14aybxiWFvzxubQK1I1wp
         fy65Khnum7hwiLGCFiL6H2OMBZNOswNURNsCNuN8G3tkcbkBlpohVoEL/ZTRvoZkdHsE
         x2zujnJMah1lmRuQQ8Z/LHuyEzggkI4U1ZlHbcJ7zpu/KWQf2gyiw/hPAdKf00L7S7p2
         nZakeXu97tuozTyBMLw4hQTWSkImnsnfktaWWXsiRWLb0Xv7HcqtE/yvngPZiwGmhofu
         6USKgrqy4pYJaRvbFCaHmpUmgIfJcLJr//A81KeVHBoiUTnyjdUMKJgY0/epJdgNFkD7
         9jLw==
X-Forwarded-Encrypted: i=1; AJvYcCWrnN0SVrseqlGMcLdVCSJQ4l1f2ZDDq4N90RwbXvRgoz4uwAlo//pr2SIr3cM6nAkPGZfRj2J3G/drWeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUkLzZD6huvW9vexesSl//XHVXvgDQzAjlXSwXZ+oadLXIiIY
	4oposoOEa+5Sm56z+UCCK47HsbMjxJ5oRx8hPFHkdsVz3XkyfTQJd6kMWgS87OSRfxqToQq5owa
	0ZoJdy4p+QAb+Pd2EpwjpG7OBDKYvZgxksSbkIGLTts5G2g5X8SHJ6+Q4zjs/0p2mN8U=
X-Gm-Gg: ASbGncui3nP4EwwgkKgxII76tOOC0yxFEMhQE9mP85rlNPIgF1rRzqRkZoKTAwVYn8g
	TejRlzkWeZlolTiiEZJzC7E4bD1wRsv33U4PGJeRdzXxDTX1zan92egzo0o/AOKDTypRw5PPEyw
	xWv0bFA+z/Fa5bil0SpANGFZzTcBIanDCA+0Lrk2QXrALHGXt+JepaOlPjDCK9cuyeLXfcH85xL
	j1krNzIWO34cNAtUshg2JAvdqxg2ZccNF8JJO169yM2v3ncLQ29QBDsCi3ymSy7nsi7kajWanDF
	9DsbgqtbDeUe84Yp7BUZMhRjLpJlBh89ISiCtlnsZKboQwE35V4wFfEl5JFHUle4sYgSm8VIgRH
	paNTGxxKn18f3mGPdRQrbHOCB
X-Received: by 2002:a17:90b:4b8d:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-31c50da140amr6038211a91.15.1752281916041;
        Fri, 11 Jul 2025 17:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYEyWKARo/kBpo3bdZrLz9C/cBJUuLVhrx+I5Awn+rzHrHkONY97ZQteD6SKGI0oaeUyzVHQ==
X-Received: by 2002:a17:90b:4b8d:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-31c50da140amr6038183a91.15.1752281915603;
        Fri, 11 Jul 2025 17:58:35 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:35 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:11 -0700
Subject: [PATCH 06/19] drm/msm/dp: Replace ST_DISCONNECTED with checks for
 connected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-6-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1974;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=48wdgPtyNZwMd6sZV3ZvvtvNWOvHLwkNGaRnCDc5QMk=;
 b=dzPxfM43mTJa1032ZbcABoClTN8ieb2y7bh9ZE8auswDZJG9PPyvhrjmKx0NoQMg2/vNJ1lx6
 b1y9e7Ioc0RC8W5E2bRm2Avg76t5A142aCXiryZaYeU+RfQsDfZp+6v
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX9SlFCjsL7ean
 ySFTNvZByIIYJsGLLc+/VAlsC1naiW4ZaEGQSdvkPciqclcMs9AOVYJSaDROnr6wNb/ylfRzfmw
 5+35+rcz01+JJpVdZ9HmM9RLh1c1s7bWBs+okSMjat+nHkNlXkRsT6ISI9cWMhT19I2zhvjgPCb
 EGbYw7/iq3kL/0g2IAzzGHATyaw0SuFyaB/fl/fMORhh0vox+k16s4iPC1S1i0ymXcwhrS3QX5l
 5eaI9rNKMSNZRn10/TV70BARQ5F3rBdYkqsQ3kr/BDTZGiUBMLqRr9fdiUVzp0wRbRLEBQY4PfC
 2Sy96KCfR4G+6ZkK/k7meNTrj50YFVRWcecsDlf79s3YKD/At8cfEJloKLiZ5y8c/FdRCICrFOY
 NS8a+acL62ueZgwX3u/wOUix0DZG+2zrlrgDXVqs60TUzSFXCH8abjwaW7ReLOHCYqHQVQGM
X-Proofpoint-GUID: dZgptggVqVb64DJK87qx-mnQhvYYHcgo
X-Proofpoint-ORIG-GUID: dZgptggVqVb64DJK87qx-mnQhvYYHcgo
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6871b33c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=iO33u3U-fp8Dsq_J1c8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=931 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120005

Replace ST_DISCONNECTED checks with checks for if !msm_dp::connected as
they both represent the DP cable being disconnected

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index af3cc32aa123..0f1c1fd2b1b7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -521,12 +521,12 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 
 	if (drm_dp_is_branch(dp->panel->dpcd) && dp->link->sink_count == 0) {
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
-		if (dp->hpd_state != ST_DISCONNECTED) {
+		if (dp->msm_dp_display.connected) {
 			dp->hpd_state = ST_DISCONNECT_PENDING;
 			msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
 		}
 	} else {
-		if (dp->hpd_state == ST_DISCONNECTED) {
+		if (!dp->msm_dp_display.connected) {
 			dp->hpd_state = ST_MAINLINK_READY;
 			rc = msm_dp_display_process_hpd_high(dp);
 			if (rc)
@@ -543,7 +543,7 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 	u32 sink_request = dp->link->sink_request;
 
 	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
-	if (dp->hpd_state == ST_DISCONNECTED) {
+	if (!dp->msm_dp_display.connected) {
 		if (sink_request & DP_LINK_STATUS_UPDATED) {
 			drm_dbg_dp(dp->drm_dev, "Disconnected sink_request: %d\n",
 							sink_request);
@@ -666,7 +666,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	/* unplugged, no more irq_hpd handle */
 	msm_dp_del_event(dp, EV_IRQ_HPD_INT);
 
-	if (state == ST_DISCONNECTED) {
+	if (!dp->msm_dp_display.connected) {
 		/* triggered by irq_hdp with sink_count = 0 */
 		if (dp->link->sink_count == 0) {
 			msm_dp_display_host_phy_exit(dp);

-- 
2.50.1


