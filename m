Return-Path: <linux-kernel+bounces-728467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94BCB028A8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098971899F62
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC31B0421;
	Sat, 12 Jul 2025 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ln+md+AC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F5192D87
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281918; cv=none; b=ozLyegzks35WGsdAvVDuotIfGXIHKmfPym6JyTAcYhf41R29VfW6rtKru6F0+W9+RjV6JHli9grSwRggYwK8l0Zhua7vh9TpbjHauflra2Y+snSVUweuxnyb2OE7Oao4BbefVxLlLmgjpynfTX5MaCeLYaRC8c7gcJ6pJ3P6h7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281918; c=relaxed/simple;
	bh=gq9e9YDqbV92vcamNHfqZWNsHHp6f5oF2jcxHG6pcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvyfW/u6SWx81IcQTpFwOIKMlzAAEDvL47Jb+JWrSfMXEklue/gdNhoQDUIamrjzC4G9UsY+3a4lOXp6Ye96/x5KGSgZeywXbMPwS9i1MI6GwOcoPaUbEmqGCSwTM6e1xzijqtyjK0WPRIR8jH3nAHjKO64ACEn7gppHmDGVb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ln+md+AC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBLUPi007975
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ryoqGXtctirqyVRL8pk0u/4G7vhZPMGpaQDhA5RozeA=; b=ln+md+ACLNbx7tt8
	wl+q6ie2LL5PSy+d8lnu92wvI7JGlTo4MnSkiUW1g5yyG0uNhGfpV5A/JQL2C119
	0xFYSgiOAxK3s22rdnEYP28TrO3ghZd4tbt8pXqy65sCzBTXnFCBVucoQoIsybin
	OQD9g6FrzsC+QAiPkykk3j5ew4o7ykyqCvLWFatoZEH8UChrnO3/uRVO96vWRW83
	ckbqR5s/ZVBSQBiSFCfKlga4X1Kdz8N98avMCItZ9yT3C/GcaC+oX4zU2WIrya4f
	RXoO0r7UGfDH9dRkC6WAq7Mh+YMGGg56nRDNxAh1YM9kJpCtmOfJ8V3iw+EbybGT
	qOE7gw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga6s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso4011086a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281914; x=1752886714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryoqGXtctirqyVRL8pk0u/4G7vhZPMGpaQDhA5RozeA=;
        b=e+HC7rZ1YvPU84dpNkGrXDiXzmofim+1sDVQHK6qHQqDjN0vEku0jV+399/BqAyf4+
         kWXSLMBLwEehufCmAmRPdN9S2fX4XqoJyIgjLQ67IOvMoGX5kKwlspUoU48efWKO8TK4
         WQQ5FZjPJq4oikOckfxyX6eT4wPWDXVVRqCjDL6MKwygNUMmcxCJYq03Cn4ChaWZAiel
         wiFQZ0BBcIDYk/e8cyVrOQtYSEs7M6HAtdEC75EG5IAV7qEGbLnUX1Zpv3qMZnjcd097
         iocJ07DZOYECeI5weLcyhlsFoOBzM1ikjNlaFOfo6GLxU/Ra06g9n9/NBY+IGHOdfH1T
         GLaw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ93/irjUVmR1I+pC6qmZ2Q+riPIrmthmisbtBNWuiu+DI+cqfc5899vuV8SKBFG7ACwCePqZQY/P7s5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL84ssi/nzLcZxJugIKAfkkUb7r9UzV//rPYdV9Iuov/xjL4zr
	vdWky6H6HSg4975rC9PY7PWohwlVo47Q9UsK2aKNEdV4RPUAFuaNxCiZBxN86j+2eBMV4CSNWef
	kAKE9atjuhjVQxVybKJjYxQJ5T93Pj9ZuQZEp46lzaKPiiJarvPjv0sEp+QVPW63bshI=
X-Gm-Gg: ASbGncs4/v742KfO7pFCR9IGWHl+KelDJipZyMrQAr2W8dni/A3QadHGCn0ikHrSE1x
	mYw6556/qswpW2hFVddljSx3JvP2GtB2ebIErXcxWzpAv9mkKnde5HOq0F2vimu3WtLOKn1Y3pF
	iBAv3xLFUrepb0C28eCMZIxKNT0zewGqqa0v88bieIriDf7YWm2fmFxQtm1MFSEDnkbDeplG2L1
	EVfpJCJdjtxAceXYUkZPBbmgGisVgyTfKSrYdZ5kFORHcF7JYakjQOiPLGlLTgqfJ8TPJpblVC/
	aU1eW5XO/4z7S/ZBZRMSEL5nC/hHx7TXr7iVkV6sGjy791sSJ1BOnGK9MfXpzM+3k0IxfDFJCi+
	8N8co/zwCqu3K5hT1wC2e4oAy
X-Received: by 2002:a17:90b:33c8:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31c4ca84837mr8607940a91.12.1752281914610;
        Fri, 11 Jul 2025 17:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHplGFsynCElwr1NRtQ/5QvHwKSH99tFLnrjAvvHtqqe/8u//qvLOUQmeienuhgOnqOhkIqZQ==
X-Received: by 2002:a17:90b:33c8:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31c4ca84837mr8607907a91.12.1752281914132;
        Fri, 11 Jul 2025 17:58:34 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:33 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:10 -0700
Subject: [PATCH 05/19] drm/msm/dp: Replace ST_MAINLINK_READY with
 link_ready in plug/hpd_irq handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-5-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1996;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=gq9e9YDqbV92vcamNHfqZWNsHHp6f5oF2jcxHG6pcRo=;
 b=o2J1CD/iJYB4JR8o4EtmsYoQnGxEJLKpSW1vYKOK4BgQyaSffbEkHRlL2017e/6EEIfJ6IANW
 u3JAechQ4iUClFgYrrrkrDHKDZa/pwyOZR09x0M0YAwc3yd0UZfWGJx
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6871b33b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=woXWnDdVNuNVtG6xiacA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: CPBvZf1ZPagMMh3bxoYaPcLLWFqvy-WI
X-Proofpoint-GUID: CPBvZf1ZPagMMh3bxoYaPcLLWFqvy-WI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX4d+G2/CAKKi1
 ORNSEQDqrMY8jfJJZQqnJwr58Iqt3ZUjEZixHEtALGcfC20c9g2PqJQM3ouNBsRI5R0FJ1dEs3x
 jk0jnP1N5APMikm05x9WvdNu9PD9/HL9twEF5xYF6QlbhN9gDPNbDj1gEwfsMH7VKPPL0OkKDpw
 VN33p5+UQ9BrYfbUVGA9kZILAyrlVqR8YkwPIKOMvtYXvF9owQndw9lI00fCgppmXhDozEtJakN
 RFCrc459beyhQCeHZabaUI7JhfIYmC+Xmclv35cfijyfapdc8YfaiHKK/fb8/gE+oOhyZzxeaOs
 fe7HzTzkyOytJGmkLJPnO08SVs1OW17YthhXsphN74heFnZfIwgLKXvPDxOiVJZfC8Gj3NyFm5t
 iQ717NqDdCqcCciSV2nFsdynb0pIml1QOPwIeupTL2MyfUg0yXwCkPVhFIJ9aTsa2+FhO0p0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=852 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

The ST_MAINLINK_READY state and msm_dp::link_ready both indicate when
link training has been successfully completed and the link is ready to be
used.

Thus, replace ST_MAINLINK_READY checks with a check for
msm_dp::link_ready.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index f93fbcff2cda..af3cc32aa123 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -595,7 +595,7 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
 			dp->msm_dp_display.connector_type, state);
 
-	if (state == ST_MAINLINK_READY || state == ST_CONNECTED) {
+	if (dp->msm_dp_display.link_ready) {
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	}
@@ -677,7 +677,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	} else if (state == ST_DISCONNECT_PENDING) {
 		mutex_unlock(&dp->event_mutex);
 		return 0;
-	} else if (state == ST_MAINLINK_READY) {
+	} else if (state != ST_CONNECTED && dp->msm_dp_display.link_ready) {
 		msm_dp_ctrl_off_link(dp->ctrl);
 		msm_dp_display_host_phy_exit(dp);
 		dp->hpd_state = ST_DISCONNECTED;
@@ -723,8 +723,8 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
 			dp->msm_dp_display.connector_type, state);
 
-	if (state == ST_MAINLINK_READY || state == ST_DISCONNECT_PENDING) {
-		/* wait until ST_CONNECTED */
+	if (dp->msm_dp_display.link_ready != dp->msm_dp_display.connected) {
+		/* wait until connect/disconnect handling is completed */
 		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 1); /* delay = 1 */
 		mutex_unlock(&dp->event_mutex);
 		return 0;

-- 
2.50.1


