Return-Path: <linux-kernel+bounces-737691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB1B0AF70
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A817C888
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993F222560;
	Sat, 19 Jul 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LfJfo+kU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65371204866
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752922699; cv=none; b=ezPQVFcp40GpJxRAyDkSq6Zdu5f5eXZOyWOoA6BW1qFDXbI5nGTdfzURRn6YqSPL7lBpeQ6D2GIIva+M4Sm/DVK9OAYfiP84g/3/llMZZeYzjWDl+3/bd2WhJmABCIQduHb+pGQ+A5TmuGdeNRe8uIlNNa4DbP79G6QXvm7Ye+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752922699; c=relaxed/simple;
	bh=8lSraB1kCKp6zUtc5twvZ/O8hG+ysE1xMp6SG4owxpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NkMaeUBeyJi36E9E9eTVM77JK+/D7g01A5SD231I/MdV+3D1sqHPESIvoaNgZ1gLPeZK3vvaGy2d/S4JlvqTjkybttBSPKjtWdnnRbW61VlZXqKKRm/LzVywwtl+jCU0eB+pdj9IUFrgdDLECiDxGDBFWIbrDF4Crv1vDH5roOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfJfo+kU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4F3VJ024820
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TLTt+Kgzxpnjy4kQuQffEI
	bf+wnIGYH4UxSlHglzY1s=; b=LfJfo+kUy5MO8WMEi54kJwS/pUpeyHOOi+JPg3
	k66BvGATJtKnxbH7JcvO/XY4LTGF/8rLpilBYpaF128Df17cWnU281NAjM9eToDi
	upXUb+1Ul8OFJruvidT/Aa72oqhsQM9Q8f1ZZyRbw0t1Z/+L2EzmPp4sb7uKRXUg
	Qd+qs+oaFBl9hm30Xj/h22i/AdhWGJ0ZjMf0LDJ8I7bNdCNp9oGqKf6y2UAnAdyL
	EzzP4aebhgzZ1pkphhIEaJjTInVbnxuDNVPP/BLjx+DT7HK01pex48U692ukRIQ/
	EdXEFXtghiQplAjjO3iIIFL9KYcQYxHrDDF8pkGKaxz+wMOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vrgrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:58:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e2e237fb4eso509679285a.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752922696; x=1753527496;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLTt+Kgzxpnjy4kQuQffEIbf+wnIGYH4UxSlHglzY1s=;
        b=fiFyJv4Z6x2pIFeDcHPNdoRclAPUDp1O8nMAUCF2YUpxDpiPodGFfklAnbQnEQrv/E
         +aHL/rW5FVK2EQBHvT4Nk0xf/FkchMXCb29dMI8JhRYEDSJejNPUyV/MmscAWBjmW+As
         eNE/GbINjI9Jry52yvHcYTFYla1Sohuwt2+qQ8Ecy3u9yyfTAtoAgJi8aNrmeSrYpk0w
         alqDZklnxg0XKio+j2vDFYYxqW8uYOpl95fP4waSAQX5/uUoBYpxfVy1RXAVnY7x9/H9
         ji6UDmmIzdOIEeQYPUHGnvtfeu/GZMbmNAyCngGjfKW9216COPEsld3jZ0pQ23NtOrfQ
         +Rcg==
X-Forwarded-Encrypted: i=1; AJvYcCVPSgUIm3SN0YozkKQSOfp8LANSjlCPcfYgrIhZzvVfDv7MKn8p8tMzm2Hf+XJz3CaETkcvtC4vDmgP2XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPL6AfpHmwgC9xqnekgA8z9POK8wa7jkyE8WIqMazuT7ggh/lf
	TWwKac9tFtztF0v2WdxNzhWemZ3V9yawOx6A1FHFRaNCeL8r3Q/UBMkOoMEd36EVyk/izV033xa
	KV9zPS6j57IOoW0EMo/WEJ+l4AAG2Zb5sW8WUL1pXvM5hkSeuy+NzEEoM3bawe3IUm34=
X-Gm-Gg: ASbGnctUcnTJsNkO0sqehAJLPUdR/vuZCpA9JA7IBSJr6Bik1MeWWda1g/hyQqbIIfp
	P7yXdxBLMgcyHDCua1RbuNctjakW3kjPqRnjIqu79rzYionIc2UVyHXHCUwo44jhu81DdFSrQJM
	i+PpUJjbdo/fgPwGwmfTavsV04NIei85AtFhsg0pfpOI4+UHHu+RmqLK2Uhjsidvio3843k3vIs
	1EU8fG1amc4oRb5law9fR1BaK/I4GUoZxD8fYJ5zz8luzJd04S6nmFoR1J8F/T7HAwQD+nn2MUv
	w4piji/Das2EDy4IhKFCnoeidoZWLGa+nz+xTc4APqBy9kUznogYX9EMhi8VbcKSX09bqZoXjsJ
	SXFUGF8ok79st2k++AGbFIYBotNUV9E8Uctm9ku911giGgdfJBm4G
X-Received: by 2002:a05:620a:6284:b0:7d4:4d55:98fb with SMTP id af79cd13be357-7e34d8bfd12mr1478665185a.3.1752922695859;
        Sat, 19 Jul 2025 03:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY0BHGOUuRUEUNYu555xldgxXmsl3zB0WiVhHizMQZ5e5kr22rMsp4Q/6NKtVVaCuJYMoqRw==
X-Received: by 2002:a05:620a:6284:b0:7d4:4d55:98fb with SMTP id af79cd13be357-7e34d8bfd12mr1478662585a.3.1752922695382;
        Sat, 19 Jul 2025 03:58:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31ab0fe9sm676876e87.80.2025.07.19.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:58:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 13:58:13 +0300
Subject: [PATCH] drm/display: bridge-connector: correct CEC bridge pointers
 in drm_bridge_connector_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-fix-cec-bridges-v1-1-a60b1333c87d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAER6e2gC/x2MywqAIBAAfyX23IJPjH4lOpRuthcLhQjEf086D
 sxMhUKZqcA8VMj0cOErdZDjAP7cUiTk0BmUUFY4OeHBL3ryuGcOkQoqY4PWJmgnFfTqztSV/7i
 srX3qnAwgYQAAAA==
X-Change-ID: 20250718-fix-cec-bridges-245d334d3712
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
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8lSraB1kCKp6zUtc5twvZ/O8hG+ysE1xMp6SG4owxpI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoe3pFCOEKIovqef4ooqEXsqP2R6UNGa6ufod0q
 Oro9jU0JAWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHt6RQAKCRCLPIo+Aiko
 1RtLB/wLKH70sl5ZQ72UOzH4bw8bJGnyUEqW471tIUtv3DgpZjr1XUHLDBZ0R/8ePIo4M7nLh4d
 ojyuXRZnESUnK8NEorvFsLzwrpcZoaa/rokSw7fCc8gPsh64T8aSqqqm9PnsbNkSOx/JF6736Ta
 WNU0SIUq3wFqfT/40GfaJIkjJpdVxUvyWTG/+CcX5ZXRZFd11olOQ4isPjOHk0PtBywnb1s+KPO
 EqtUmaJkRAmiGbppXX8zg4vceSUiN0qXTRIQXw/Veq909jz5IC0Hcj97pZGhS/so8Qt5+V8zmaB
 BeZwyCf8vl6VvB/wFy6kMxCAxHLc/pFj44SIEMLzSN8ftePx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687b7a49 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=BxX408-PIYz4yfsoHs4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: S8tvxwaJmPoHVt3OdGLTnJ01TbFyUXw5
X-Proofpoint-ORIG-GUID: S8tvxwaJmPoHVt3OdGLTnJ01TbFyUXw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwOSBTYWx0ZWRfX8XyF9RhR4505
 0LT0Fttil3QPfE7iXbSHBd4WWHZt0N+QG5ImbwxaDPO7jXcFNhh7XGO7gTvciji1FXjczvi/E84
 ZREuxOyA4VUmQ6jBlDHuuFLgL6jmErxG2ZMqLVzE4cHN96LkB3rYEuzAk+eXfzwl9Jx7Joa8tRH
 y8PH9HFQ0MGOjZE8kBgFGCp3zEKZXiDSXqS4ODj9yBa+TPb/mQ8f9OH9tCYxwOablS6mwPqsw+p
 AYOuz3U6XJyW70uFUZmq7Yd4f+W/RZvdPSnuNsh3A0e80mbZipcILhTiZCopkBSZjA3/dRHP+qe
 HF0s3dnXTNn6qza6K2rEpO8q7d3oeAF72lBlbMsrQyjnEPJnfoR2b8KrWSzETzxCdli37BEGc8m
 lyPlewXL65MR3K7/jte+vGki4VdCf3/8dYdBznH+S89UDamm9SqvWdDuVmJPxwB1RONk8L68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190109

The bridge used in drm_bridge_connector_init() for CEC init does not
correctly point to the required HDMI CEC bridge, which can lead to
errors during CEC initialization.

Fixes: 65a2575a68e4 ("drm/display: bridge-connector: hook in CEC notifier support")
Fixes: a74288c8ded7 ("drm/display: bridge-connector: handle CEC adapters")
Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Closes: http://lore.kernel.org/r/20250718164156.194702d9@booty/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 5eb7e9bfe36116c9618cd3773f1c01e7ebb573be..8c915427d0538435661d771940efe38b462027a1 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -816,6 +816,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	if (bridge_connector->bridge_hdmi_cec &&
 	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
+		bridge = bridge_connector->bridge_hdmi_cec;
+
 		ret = drmm_connector_hdmi_cec_notifier_register(connector,
 								NULL,
 								bridge->hdmi_cec_dev);
@@ -825,6 +827,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	if (bridge_connector->bridge_hdmi_cec &&
 	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
+		bridge = bridge_connector->bridge_hdmi_cec;
+
 		ret = drmm_connector_hdmi_cec_register(connector,
 						       &drm_bridge_connector_hdmi_cec_funcs,
 						       bridge->hdmi_cec_adapter_name,

---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250718-fix-cec-bridges-245d334d3712

Best regards,
-- 
With best wishes
Dmitry


