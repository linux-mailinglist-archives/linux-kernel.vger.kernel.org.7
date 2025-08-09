Return-Path: <linux-kernel+bounces-760886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A1B1F19C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D27BA04FFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B92405F6;
	Sat,  9 Aug 2025 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFkS5kGJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9E23B63A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699745; cv=none; b=lRagouL7A9cfC08XPbEAdE/vGWa2kEG5dQ9Hm5ZHPDKsBzqYZEDs81I53ho/RlPQyhpgXGL8EnIu4ObSXr+gwcg0o5U8fGc5OG85bM091oa6ka4XZb6/frWNy257PNHvNF5lIxNyYqgpGLqGaXZtq3zRhbex/ibuoWkEcw4gI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699745; c=relaxed/simple;
	bh=0luC8UsEHN9fWfXH6p1zip80kT4QBQaB8aTLon8BdOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPvytitn3n7M90KrISjfZg5qH4fqCOQ+tYDoeAXBYen+a6p1YjTbDDVs4djkbSzLErGjtJqsmt0uVg9FfEDdRp9t22ER5o59BL9chEIp81wXwRMs8PQFuc+tduknrgRWLojvHMw2iYpObhOjb9AR2rur1RPKQ/Gdjjv0j6oQS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFkS5kGJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578F9klg007961
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AZ2xPxZ0aADglH/NNiPMVpiBOUDybWneJMhux20a+5g=; b=KFkS5kGJwoLDxjp8
	bC3AjVCcdw/tfdFuNHCF+IhBgmBBehYl/9I6Aa2o9maWBN3eXY+tZhfVzIwaDuRE
	zJHZ6ZlMk4YgKGGzmiVpo0wo7D+gZYL51sPqdj37qzE7GIAJiOt69limnIx8k8FH
	L/ZReglf9rxUYsV8y5tFGqlOVBDTeoJnz/QMDzSMHrXrTCa1ssX7z6sxASFsDC5s
	9QA7Jxaa5cVkW+t2vU2IvbcTvkjNCSdzH8r3c/06QPHhlWQpSjUHzOGSTSLX05wN
	6B7WikKnFbqAwnMkLloSdKDK48NU961+pWBd/CCDlDDp6Umo0u9pD2+6jwyXWNJw
	nTfPHQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy73h8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-242aa2e4887so58314815ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699743; x=1755304543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZ2xPxZ0aADglH/NNiPMVpiBOUDybWneJMhux20a+5g=;
        b=nBfK5wWLAMNwWkNhC+iqoE5rQvKdBL3e/N/hBNa6e5f647IAsul1xY3r0a+9cGwxr6
         kM7hh78pMxo2QYeUAsiH1FqoYuqFa19vwEeaCjI2lQUHeaQs8LNaP4i5gr3WuC9iMjnU
         L/5+LH6Nw+59nvKpRPjJTV7V3N53pHOjUPIlDR8gJxA5MgciZr13MCHlIMPNhWlnd9gE
         /Zdf8Ld8Kt/cVbjmurIiL5P4kGk9ZnsdTYGuTWPPGqc/7n1M+e1WhNbeqertM/00AITf
         mfp2HlDPpk4lHDkVymHD71tJRgfwxjFi6yAvVlgs8LIzqoLlFWsqVAHk5yXxFl5QpiuK
         +Uew==
X-Forwarded-Encrypted: i=1; AJvYcCW0+M6wftZKBEL9oQhNuqhSDAk5uhuvYqe26TdXw9n5FuDdUm7wa0xeF4SFsiDSij7QWPR+GjDwgfO01pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDrjh7x7ehOTahBYqRkbzq1tifB9NWDZSd2PTuMlk6VIRs1M5
	d+14AEgYHZ3zYizfini+gv8vOCPl22tVqia2G35mtwCl6Sxholfme2rjQzfXSTIvr1EwJyYcb+X
	X6NEr7/DaKPB5EF5Ujhhz6YAYQs/b2IhhObOMHio8ZpOYiaAXH+Xh7imG9Vvv9jBPoK4=
X-Gm-Gg: ASbGnctv9kla5w+60C5US1gcoh1LKs4CRWNlWU6tOa1+n+OFtb2s7xIe0X3KLoWrydK
	GI2jvjCscDZ6mJZ+gKn/3bdKnG7Xz29NhLfDK4h1Qs8cDxwhdKqlj0dlzd0UN8jwgqhEzTzPEPq
	ghZ2dXohwGdSt8Q1WYSmoUB18SvOPR8yv/iq/eIbXNUc4XLC3ZcwZgCx/7YBk62EOSYV5tJQzm3
	hn7HTOUVSWzPkqP44M3yq+DjYsUa/G/oIzfkB7Q911sBJpN33O+tq2/zPiiGsqMFmTHWVjacwSQ
	rB2uO+IcH/Vodap06E8C+LmS7Ak59aHBjhNQLNbVqBRsGMHzLDEP13W+4ydT4hADE0uw1yxp/lq
	SiZrDU4iQ0I++YsvN/gp9gted
X-Received: by 2002:a17:903:2987:b0:23f:8d56:b75b with SMTP id d9443c01a7336-242c224116cmr68534875ad.41.1754699742720;
        Fri, 08 Aug 2025 17:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAEqIzA4w/9X4in72ZzPva96ldMzCraSZJQFVFPIFyVWnAUhCwow2pLKBe5AzUihPqywBT1w==
X-Received: by 2002:a17:903:2987:b0:23f:8d56:b75b with SMTP id d9443c01a7336-242c224116cmr68534535ad.41.1754699742334;
        Fri, 08 Aug 2025 17:35:42 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:42 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:17 -0700
Subject: [PATCH v2 05/12] drm/msm/dp: Drop EV_USER_NOTIFICATION
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-5-7f4e1e741aa3@oss.qualcomm.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=2134;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=0luC8UsEHN9fWfXH6p1zip80kT4QBQaB8aTLon8BdOg=;
 b=KNHcay1Gz47I5v9s9LO4RakqENVxCn6/IpqtvSmuQPh6gYrJ4N3079g2LhjPpuzGoc1HhXkfJ
 VeSdBpztAebC7a6u6j0IrGagrIck7UzQwpogYuVlmzDmeeGdRJ5o8hg
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-ORIG-GUID: otcpU0L9FPiYfF6ZS_mEtXieqmCAmNGb
X-Proofpoint-GUID: otcpU0L9FPiYfF6ZS_mEtXieqmCAmNGb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX0zJ11tk12bi1
 8b9OMfvmRbwkkkPdY+juutVi+/JxNakIFzSpZgklZC4ixs7i6zh7Dwzor3/hRzTeaXDLypsp3g3
 yxwBUGjlB7UvnUobzY1ilxy2axokF7GK/QO/O6kFIp/e7+CKd+ZjhETqCumhwgSi0qvaLcL4cVO
 NqKMNE4c8lSLePXavBGZ9CbDm0RvQJqZqMmTJvKGf1APhYAA68dlkRWCwlSFKxpq1zFAivxL6Hr
 7UO357b9orqAe0kTTUox7EjAxTKmSGmBH0woUSSgzpBQ4vuwOvGdZTUsk1wzOVaON/urtclY3bG
 icUkKlr85yTgSacZk6um0oadaHJrpC8iZlKI69TBtQqUtUV+0xH27yZ/KZ4wD8PdeeL0x3HkUFg
 8aWiJ8/z
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=689697df cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=isfJdaZdMnE_RitM90UA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

Currently, we queue an event for signalling HPD connect/disconnect. This
can mean a delay in plug/unplug handling and notifying DRM core when a
hotplug happens.

Drop EV_USER_NOTIFICATION and signal the IRQ event as part of hotplug
handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c849befe58f0..55fe8c95657e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -58,7 +58,6 @@ enum {
 	EV_HPD_PLUG_INT,
 	EV_IRQ_HPD_INT,
 	EV_HPD_UNPLUG_INT,
-	EV_USER_NOTIFICATION,
 };
 
 #define EVENT_TIMEOUT	(HZ/10)	/* 100ms */
@@ -428,7 +427,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
-	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
+	msm_dp_display_send_hpd_notification(dp, true);
 
 end:
 	return rc;
@@ -497,7 +496,7 @@ static int msm_dp_display_notify_disconnect(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
 
-	msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
+	msm_dp_display_send_hpd_notification(dp, false);
 
 	return 0;
 }
@@ -518,7 +517,7 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
 		if (dp->hpd_state != ST_DISCONNECTED) {
 			dp->hpd_state = ST_DISCONNECT_PENDING;
-			msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
+			msm_dp_display_send_hpd_notification(dp, false);
 		}
 	} else {
 		if (dp->hpd_state == ST_DISCONNECTED) {
@@ -1112,10 +1111,6 @@ static int hpd_event_thread(void *data)
 		case EV_IRQ_HPD_INT:
 			msm_dp_irq_hpd_handle(msm_dp_priv, todo->data);
 			break;
-		case EV_USER_NOTIFICATION:
-			msm_dp_display_send_hpd_notification(msm_dp_priv,
-						todo->data);
-			break;
 		default:
 			break;
 		}

-- 
2.50.1


