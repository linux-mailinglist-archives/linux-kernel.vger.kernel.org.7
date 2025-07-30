Return-Path: <linux-kernel+bounces-750922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607BEB162DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DC23B2FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95E2C326B;
	Wed, 30 Jul 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRWNVQCE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D638187FEC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885883; cv=none; b=TmwVejg31i8aPSX/HOCKRx75eQgZnqBFCpOLGtlt66S6Q/uKrWUdrY1vU6cy/EaRKay1N03rDD/rzh8/ioS+wqw+lGXiqLi5c6DebHWsNMgdwvMK/+I4q3C/sKPZy8cGJxFAwfuTY2aQobqDTmokInLYCEv9W6xcUxPAmknP2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885883; c=relaxed/simple;
	bh=bS2qx1gmX4rTXlznVDRT/ViuSl9zXtuoHBiML9oxlLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CkBQEPYBxMqefuIDvde5i6U0UtGHs6DPPG1iOKptkFx2lAOxqlSBbU9ARmAzRNZk1wSIhKrYWuvQl/0SglMhLH2vXXIMXuml0AI8vu6aVJ21cUROX71uF84/Soj8eSSFMFGvhP33DIWzmn0RgYxcr6ZlPejZzk77KXcpirhw9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRWNVQCE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb99V029204
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IOeotSDa9sAJWWk+JU7QUA
	OahqMPTXl9EkoBb7yQEcA=; b=VRWNVQCEj6ONysbJZS43fCoYh+UyLdua12P+Zv
	mJCE4Hcnc0humLdbTkymAmzUhHhaOXVK85DWORo3LBCD49Fg/0doBNZXeDgiiL+r
	wEvMZXJt6kyrQEHQ7nZFL7x89XzWILpcYdiYs2hlp4oq7o8TMsU4Q4E360q1dtGp
	mVBd7zu2i6dzyaRWnEYkCQWdBuN/3ncqWzDxc7YWTOavT95RGd7DE7AlSt5IggBK
	MPPscNGNQPW7Sn0qpmJbuCCwjDo+OIxhaSJyPO/TkkhGn8Hhd1A0mWiJ7nh2phr+
	sc6JNhzwxqSI4roMYRNoh5SwlOI7/N68pkF62koXCL7a7ikQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrc8g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:31:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-240607653f4so17488445ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885879; x=1754490679;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOeotSDa9sAJWWk+JU7QUAOahqMPTXl9EkoBb7yQEcA=;
        b=ig5Kvf04cn3RPY46UHVv+mtI36SkyL8ELEerxiZR28KxWV2xJPWHkQahqmi3Eo7iop
         X7B+rQymJMdCnSK9pk9yaG9RQcRQL8vMD0aYXYougMhRQce1kWl5Ha+cpvUbb+lhDfu4
         H34afLT2QTNXbsxz32QezOPiA5451RYN+d95LrSEXt8aFxgpL//sMfGF6MB15QLSWK3B
         Yi9SeMW1onqJAfXgLyBxzxD8k8ltqL1+RyGJZrLdgBGRgASNy4PaS5urfWn/C8JQol36
         tKVSsj/6gopETbmoPQtaT0sS+Bkjo0O/L/LCB1XymnJ85y1I0e2mTd4G7s4tM1btXe0K
         YVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4rMVG1AV4OC3gxjjKqDhmr/pGasDUE/aa84GMATnPHDA1f0J/I+e3d2/nR7Hpm4x4jijftiVzo1YB1UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7Atec5FoTjU/FTBeRQ5i/fz990+A73pzLRTyaVfftnrfHzyL
	yz1iX6AGxh70DKFUejusKHcwAXar62PspHHQdjk+sAq7V6/YIwiPFmPGYgeakkC/3JKgOn6VCJI
	x2IcuJtKe0UAqcyd46P/c+PsxZzmdIH1X5rTYF+QNxLVHFEvpXt8KJjOVXdVOWqkywA==
X-Gm-Gg: ASbGnctPvwVtyVZbfqkYsgOJY1bBuEpH0izf2UpEfLR73E66FU1ThhaitxKYuwwDSVu
	uTemT67w7u2joqZcCWna1X4BHWr42FcqlHjQ5zmS3Ds1VJOceOk9M0YA+2xbOZbBDiMstfYcYwt
	91gO1CH9ixsSS5bK2Xn4pl8den+GUwebCSWzP1IfhrIPrd1jV65LJBYs58Bb55+kGETBhY5QFNn
	XpiMar1QS3JKMuIpWZ2wFFvU8/3DNU0fV+qcR1uNW4qntxGSx6K3IQb0tAccT+DhF4Q8VcGBdzQ
	OfA9L8PKfCBH7TjDDZhcKjlkUpdjkdoMo7/f/nKCBguhmtNrT3LzgStVxRLqDS+qHg==
X-Received: by 2002:a17:903:1b67:b0:23f:8bcc:e4e9 with SMTP id d9443c01a7336-24096b103b9mr50543125ad.23.1753885879425;
        Wed, 30 Jul 2025 07:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsUTPJJLGBNeiJAu1ltEoNzfJVdZ4yRETnlLRHV+4sqfRaaJSO27F0HyDp34BZXEPCI5Pag==
X-Received: by 2002:a17:903:1b67:b0:23f:8bcc:e4e9 with SMTP id d9443c01a7336-24096b103b9mr50542515ad.23.1753885878929;
        Wed, 30 Jul 2025 07:31:18 -0700 (PDT)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401e95207fsm75090365ad.54.2025.07.30.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:31:18 -0700 (PDT)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 20:01:10 +0530
Subject: [PATCH] drm/bridge: lt9611uxc: reset edid_read on disconnect
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-lt9611uxc-reset-edid-v1-1-3ea4d5b16197@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK0simgC/x3MSwqAMAwA0atI1gZSv+hVxIWmUQOi0lYRxLtbX
 L7FzANenIqHNnnAyaVe9y3CpAnwMmyzoNpoyCgrqc4J19BUxpw3oxMvAcWqRWbKuRyLkSuCmB5
 OJr3/bde/7weB0WIeZgAAAA==
X-Change-ID: 20250730-lt9611uxc-reset-edid-cc03c5b4bc60
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Nilesh Laad <nilesh.laad@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753885874; l=1143;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=bS2qx1gmX4rTXlznVDRT/ViuSl9zXtuoHBiML9oxlLw=;
 b=Z0MGmNCuZpuFUkRw8jcSMRQlh1OJbHHfoebSoIfqMi9WbQWl1kKw16uvL63BnpjRDeSyI6FUg
 fK/Sy9WYjEqBNHf5XTUB93DmA/bGN/uOZpadNDX9uvw13ovvn66nfRP
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEwNCBTYWx0ZWRfX42Ct8hkA1in1
 yVPCoBuv8mjM6b/jD6cgi9AnDZPOJiPasdbXlx8XomAaMqm6AnBej0/R14XxYfOhqOZJNlXWJNJ
 2xRWjfCAzyN2pOvGrp9ujGH2VunV8tPM0MlCXAko1F4wb3Pyoc8U+tShDbasiJj/O9rRno/nIhC
 r9DAZ88QEIii1+OAz2l6GTDxcBZUNv6ujwuM8vOB+DTbL7xbPO58AvT1z1ZKar82uF7uX6s6G3s
 MpIXYa+dJCyDNWXrk82gnNgFYucPhown7VBxROdgymk0r5wc7Sdx96fKXUJ0MJOo75qPgErjyQD
 UEPjsPwQKDTW9EJeZREl0AYePtWeDPGIdFykVKUBswRpryfX0dmI2UAtonSA2yhJWd4l3ZHB7bk
 UiSr26TzIqNStPM4ILVNXdNkt4jSWXGttu7a4UF1oPbZfshXDJTpN5VqDXBjzgMdi70hFS2C
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688a2cb8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=epPyvgG4nFS5MlfyoUcA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: TFcx0Me1xoVaEB_2d102dZp4OlWGa61k
X-Proofpoint-ORIG-GUID: TFcx0Me1xoVaEB_2d102dZp4OlWGa61k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300104

Currently edid_read has value from previous connect session
and resulting in drm using older edid before new edid is available
in lt9611uxc.
Reset edid_read so that correct status is updated and correct edid
is available for drm.

Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 38fb8776c0f4..f5c887d126fe 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -171,6 +171,9 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 	connected = lt9611uxc->hdmi_connected;
 	mutex_unlock(&lt9611uxc->ocm_lock);
 
+	if (!connected)
+		lt9611uxc->edid_read = false;
+
 	drm_bridge_hpd_notify(&lt9611uxc->bridge,
 			      connected ?
 			      connector_status_connected :

---
base-commit: 85c23f28905cf20a86ceec3cfd7a0a5572c9eb13
change-id: 20250730-lt9611uxc-reset-edid-cc03c5b4bc60

Best regards,
--  
Nilesh Laad <nilesh.laad@oss.qualcomm.com>


