Return-Path: <linux-kernel+bounces-838454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBBBAF333
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AE4E1E03
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B71B808;
	Wed,  1 Oct 2025 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vl3rKhlq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503826CE02
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299295; cv=none; b=MfWfGLG3rPDbxVabHFRGDPkdAAncUriSWKykKK2MPFEl3HjO3O0ywPQbxVoLIOnX9AJaX5b0nFyQ8VqBEN7tG9zgDIVHtyBf98PDrTe9CmkR0qMY4rlGY5gGFr/OUiuXuRU9OJVLkpsdfrA9OFrmogkvCibzBzmUx6awr9JIjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299295; c=relaxed/simple;
	bh=UIGaDFJydBwC+exWcXL16jDqQ+NQjFNXTvXcG12uN2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mwPQ0dnvwkTxSgeiN2WYWaLoJo5weHqNnKg6thMVvmtiOoQGGdSSktHakDN9i/kO5qgdOCI/ex66vREikIHWr4CFqpIfy/oP0mVoEOgTMXMpNBCFo87GQ5let/7ieFLuiTQPnwPNlanAEcRssqwPcKimCsEvAcc0sVDykITpcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vl3rKhlq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UM3JhJ031467
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 06:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n5umdDdHc9CY8UIANZXMpe
	JdOMLKPrPjBDN7gFVcYZk=; b=Vl3rKhlquDcNSpnR9C/ETh2E8j+vl4PDTi79mf
	D6icnBZ1ys5wIaaKIW9WcsYElWH4qVE7M5WGRuoQYUNcwTA5BpOytQwVHyovF2lx
	7NVokCwT5IHM/EecizubZf4YLMFspMbxyh2X7jpcyViiAnZ07r7gIXTWOVOO7+aE
	JbRk9LAHsyrsujbIvQ8djY639yVV/b9veqj4qo3pytOI1CC7SwUWDztjIRR44uJO
	0OioOeHNJ2DBNj/dEb5zttF3PJbiQcLTDf52sW2liytf22JWumc1/rdxOHGMi5Ra
	HScc1Zj2CMH3TwllPQTHo1gjuNDqbz+RXzPyXtsURHk+nQig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdk9f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:14:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dbd8484abbso83521191cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299291; x=1759904091;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5umdDdHc9CY8UIANZXMpeJdOMLKPrPjBDN7gFVcYZk=;
        b=Iup7wMaAgo1YB96F2TufhlLiMtyrIZWcC97YdjlAnptv1xLcmRGTmlFFAfu/FBbIzB
         In7oeAt1zLc5O6K5c5rIWJry+Dgl4+hIXQ25lgN2LTZz9XvgDHxxRzmUbfYoFMEoxHTE
         64o7bNcmcp/NtIoGMdPGi1W76g6gnRqgMkAaTAHOlHnKKU/iX+P84Wb5JKYloHXR/Kmm
         QBliapSh9eg+Qr04dpT+8e7yE1zn9pTPmtpwx1Fs9dDhMV8dHGUKoGUSbNVgL7jTTReV
         x2x0ICgDrL4sT+8hdUfsYoNoPN7SkMsYY1xjastFJny6HYpLIpd7ehEtvgCvUtz6tzfl
         egzw==
X-Forwarded-Encrypted: i=1; AJvYcCUcTZgn4vEcVDeU2xzHw3MBIkwbBydYmSXkhpeMNz9Eiq1U5GUaqPgXQmHZCNrFf1rd7c+/hviPIvmFJtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpod1mDmLBzqCrLydXNxKiwlxpu8svDhpxwlhWJQTzJ9QlDwRD
	nuh/RP388Ifjd16aTvxPWAEJ5fGkIHwhCxINHDomvAkMUQxW6Ht7FGIsrmSN4+Wxy8gK7CSiwA5
	1nck7jPVl6MfLF3zJwuowKoULIN85XupFXla5SRr5FtsEV0hTb5KkeigqIww+z8yZoYY=
X-Gm-Gg: ASbGncskkVS9yBIc2owbe7ednabKZH1/pG/iLG1Ul89T12V6C9YNLx8BZ78b7VsZ9Z5
	c1k5S8wXhBovMn/rqc3i9blFbJkFbJL5znGqH4ryRaxRgMVF3jqBjvj87gpAOvgHmMN4iGvd3ZR
	jS8xolOA4IMpfT/l0U/f2e0i1QZUyQu1Ve/CL8tbE9KHA+ZFn1VcRzWeGnRkuiCS/8yXOKOn1TX
	KgyNlYLrAPySESdGXuA6MGeoLZOSugtEUova/wSLhCn/AuYFHiVV4V0D4MVnV0nBgkMoyljrkrL
	Ovg2LK/4xgcICk2CXGuB5/p5w+AmKyKd7Gf+xeiS5dEmgdZ6+JRcOG7bYicHIGWcxYa7X1D8CSN
	1LawM3N+AhyMX2oLy4yy5VN0200yp1nX41H7yjlKlhkHtCjcCSk+CXZBkVg==
X-Received: by 2002:a05:622a:1e8e:b0:4d9:f929:1531 with SMTP id d75a77b69052e-4e41c9242e5mr28802661cf.23.1759299290841;
        Tue, 30 Sep 2025 23:14:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4e0YRPO81W/CpiiD+KlpHYUytUQG96m+1u1Lgj6YphtU1NzQ6flSLG2tPHZj60wyULeR4xg==
X-Received: by 2002:a05:622a:1e8e:b0:4d9:f929:1531 with SMTP id d75a77b69052e-4e41c9242e5mr28802361cf.23.1759299290191;
        Tue, 30 Sep 2025 23:14:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5860c76287fsm3331195e87.30.2025.09.30.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:14:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Oct 2025 09:14:45 +0300
Subject: [PATCH RFC / WIP] drm/display: add DisplayPort high-level helper
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-drm-dp-connector-v1-1-ac54fa4cc667@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANTG3GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3ZSiXN2UAt3k/Ly81OSS/CLdRAsjI2OLpBTTJAtDJaC2gqLUtMw
 KsJHRSkFuzgr6CuGeAUqxtbUAO7v2LG0AAAA=
X-Change-ID: 20251001-drm-dp-connector-a82238bd5b81
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thierry Reding <thierry.reding@gmail.com>, Imre Deak <imre.deak@intel.com>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12485;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UIGaDFJydBwC+exWcXL16jDqQ+NQjFNXTvXcG12uN2I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3MbYA4Ob3PluFO5aIDEfft3MHfx1bj+hw+rJ9
 HOKQLiLs/6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNzG2AAKCRCLPIo+Aiko
 1VMNB/0Zp3/PccuM9lUwEDkPAYGbqO/jgiy/XlmGF+FGzZUviCLdo56x/C2vwefs4Cve63LG4KK
 FAgNHWjFyCJtJUhbh50Q+/INeOJ2JKf2v6NR6X4iiynUMgEYfLTpfLjQU23ortBXEwGSX+Whnu/
 h6XB/QDp9YaJlv5IWyqgR4eC0spgAKu5JnVOphjrMd4vEgSf5SFsWyzGqiyMw8wqsyc0+MRzHTl
 4UR0qlMWibxPG1WJFuMGkV6pYF/nKpkOYRIHjtBEFPJv0PbwdXdM+ZD1GSWWxpizc/BpVBwAiDI
 hRUYFlUTpSpcNtn8iGfbci8SowXuMlryCmxSpS8MtboK9dd9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: azyNnLmnC4Ty8OQtLRqUngVtZKrd8DSu
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dcc6dc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=gBhEkUvOPZmXN5-cvzYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: azyNnLmnC4Ty8OQtLRqUngVtZKrd8DSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX9xKNpKAQ8AKw
 igcIaNaEJO1YDAhDE3xGyz6bmxJduIFESa5atQhrstXe/5gpR1bqBNNJH2HJcVXIL/55pxoCXVD
 Txjch7FLqLPQi7d1xgnsqftnUR3523rdKDsfhWafzlaX4sGJN2dnfpP2B7YcdjWOGKoYWDM/Y3j
 7Ld3odSBsgODaQ/jMm0w2RfsGNb4aFWnsZtJ7lOhWOGFg357P28jw5E3nPf5AuQDeyZymJFyfmE
 iZCSW/YSJUTeY7xKKhW2TDz1LJT7REcTYAPQX5HjYQ2ks1Hb/vZd6XuouDSvbp4L4Jmu+NQqsjo
 OmM97ljXHc7hd2iEwSMUPeCr7+OfdH10VWp1GRnaih+y0JNQwbb2Qu3Y038N80xW9Vx++xL0uAG
 1+xzQnoCbclL7wasEIn91lE2qaa8tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

Add common structure to drm_connector and a set of high-level helpers to
be used by DRM drivers to implement DisplayPort support.

Note: this is currently early WIP patch, sent in order to kick off the
discussion and the hackaton at the XDC 2025.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/Kconfig                   |   6 +
 drivers/gpu/drm/display/Makefile                  |   2 +
 drivers/gpu/drm/display/drm_dp_connector_helper.c | 184 ++++++++++++++++++++++
 include/drm/display/drm_dp_connector_helper.h     |  33 ++++
 include/drm/drm_connector.h                       | 102 +++++++++++-
 5 files changed, 323 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index df09cf9a8ca19ea894d6f2fad68c0b191e81e3d0..e042a2b7a666e71f5eac748dee8bc506e725533b 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -40,6 +40,12 @@ config DRM_DISPLAY_DP_AUX_CHARDEV
 	  read and write values to arbitrary DPCD registers on the DP aux
 	  channel.
 
+config DRM_DISPLAY_DP_CONNECTOR_HELPER
+	bool "test dp_conn"
+	select DRM_DISPLAY_DP_HELPER
+	help
+	  DRM display helpers for DisplayPort.
+
 config DRM_DISPLAY_DP_HELPER
 	bool
 	help
diff --git a/drivers/gpu/drm/display/Makefile b/drivers/gpu/drm/display/Makefile
index 0ff4a1ad0222078bf495175915007f1b1f903296..ee7a09adf3baacbbd7ad251ba92dc78458881192 100644
--- a/drivers/gpu/drm/display/Makefile
+++ b/drivers/gpu/drm/display/Makefile
@@ -5,6 +5,8 @@ obj-$(CONFIG_DRM_DISPLAY_DP_AUX_BUS) += drm_dp_aux_bus.o
 drm_display_helper-y := drm_display_helper_mod.o
 drm_display_helper-$(CONFIG_DRM_BRIDGE_CONNECTOR) += \
 	drm_bridge_connector.o
+drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_CONNECTOR_HELPER) += \
+	drm_dp_connector_helper.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER) += \
 	drm_dp_dual_mode_helper.o \
 	drm_dp_helper.o \
diff --git a/drivers/gpu/drm/display/drm_dp_connector_helper.c b/drivers/gpu/drm/display/drm_dp_connector_helper.c
new file mode 100644
index 0000000000000000000000000000000000000000..1251a25af1a65d05255e763385eeca24c0b49292
--- /dev/null
+++ b/drivers/gpu/drm/display/drm_dp_connector_helper.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Based on Nouveau DP code:
+ * Copyright 2009 Red Hat Inc.
+ */
+
+#include <drm/drm_connector.h>
+#include <drm/drm_print.h>
+#include <drm/display/drm_dp_connector_helper.h>
+#include <drm/display/drm_dp_helper.h>
+
+static void drm_connector_dp_init_lttpr_caps(struct drm_connector *connector)
+{
+	struct drm_dp_aux *aux = connector->dp.aux;
+	u8 *lttpr_caps = connector->dp.lttpr_caps;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	int ret, nr;
+
+	if (connector->dp.caps.forbid_lttpr_init)
+		return;
+
+	/*
+	 * First access should be to the
+	 * DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
+	 * otherwise LTTPRs might be not initialized correctly.
+	 */
+	ret = drm_dp_dpcd_probe(aux, DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV);
+	if (ret)
+		goto err;
+
+	ret = drm_dp_read_dpcd_caps(aux, dpcd);
+	if (ret)
+		goto err;
+
+	ret = drm_dp_read_lttpr_common_caps(aux, dpcd, lttpr_caps);
+	if (ret)
+		goto err;
+
+	/* FIXME: don't attempt switching LTTPR mode on active link */
+	nr = drm_dp_lttpr_count(lttpr_caps);
+	ret = drm_dp_lttpr_init(aux, nr);
+	if (ret)
+		goto err;
+
+	connector->dp.lttpr_count = nr;
+
+	return;
+
+err:
+	memset(lttpr_caps, 0, DP_LTTPR_COMMON_CAP_SIZE);
+	connector->dp.lttpr_count = 0;
+}
+
+enum drm_connector_status drm_atomic_helper_connector_dp_detect(struct drm_connector *connector)
+{
+	struct drm_dp_aux *aux = connector->dp.aux;
+	u8 *dpcd = connector->dp.dpcd;
+	struct drm_dp_desc desc;
+	int ret;
+
+	drm_connector_dp_init_lttpr_caps(connector);
+
+	ret = drm_dp_read_dpcd_caps(aux, dpcd);
+	if (ret)
+		return connector_status_disconnected;
+
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		u8 value;
+
+		ret = drm_dp_dpcd_read_byte(aux, DP_EDP_DPCD_REV, &value);
+		if (ret < 0)
+			return connector_status_disconnected;
+
+		connector->dp.edp = value;
+	}
+
+	ret = drm_dp_read_desc(aux, &desc, drm_dp_is_branch(dpcd));
+	if (ret < 0)
+		return connector_status_disconnected;
+
+	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
+		ret = drm_dp_read_sink_count(aux);
+		if (ret < 0)
+			return connector_status_disconnected;
+
+		/* No sink devices */
+		if (!ret)
+			return connector_status_disconnected;
+	}
+
+	return connector_status_connected;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_dp_detect);
+
+static bool drm_connector_dp_check_rate(struct drm_connector *connector,
+					u32 rate)
+{
+	for (int j = 0; j < connector->dp.caps.num_supported_rates; j++)
+		if (connector->dp.caps.supported_rates[j] == rate)
+			return true;
+
+	return false;
+}
+
+void drm_atomic_helper_connector_dp_hotplug(struct drm_connector *connector,
+					    enum drm_connector_status status)
+{
+	struct drm_dp_aux *aux = connector->dp.aux;
+	u8 *lttpr_caps = connector->dp.lttpr_caps;
+	u8 *dpcd = connector->dp.dpcd;
+	u32 lane_count;
+	int ret;
+
+	connector->dp.rate_count = 0;
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    connector->dp.edp >= DP_EDP_14) {
+		__le16 rates[DP_MAX_SUPPORTED_RATES];
+		int num_rates;
+
+		ret = drm_dp_dpcd_read_data(aux, DP_SUPPORTED_LINK_RATES,
+					    rates, sizeof(rates));
+		if (ret)
+			rates[0] = 0;
+
+		for (num_rates = 0;
+		     num_rates < DP_MAX_SUPPORTED_RATES && rates[num_rates] != 0;
+		     num_rates++)
+			;
+
+		for (int i = num_rates; i > 0; i--) {
+			u32 rate = (le16_to_cpu(rates[i - 1]) * 200) / 10;
+
+			if (!rate)
+				break;
+
+			if (!drm_connector_dp_check_rate(connector, rate))
+				continue;
+
+			connector->dp.rate[connector->dp.rate_count].dpcd = i - 1;
+			connector->dp.rate[connector->dp.rate_count].rate = rate;
+			connector->dp.rate_count++;
+		}
+	}
+
+	if (!connector->dp.rate_count) {
+		const u32 rates[] = { 810000, 540000, 270000, 162000 };
+		u32 max_rate = dpcd[DP_MAX_LINK_RATE] * 27000;
+
+		if (connector->dp.lttpr_count) {
+			int rate = drm_dp_lttpr_max_link_rate(connector->dp.lttpr_caps);
+
+			if (rate && rate < max_rate)
+				max_rate = rate;
+		}
+
+		for (int i = 0; i < ARRAY_SIZE(rates); i++) {
+			u32 rate = rates[i];
+
+			if (rate > max_rate)
+				continue;
+
+			if (!drm_connector_dp_check_rate(connector, rate))
+				continue;
+
+			connector->dp.rate[connector->dp.rate_count].dpcd = -1;
+			connector->dp.rate[connector->dp.rate_count].rate = rate;
+			connector->dp.rate_count++;
+		}
+	}
+
+	lane_count = dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
+	if (connector->dp.lttpr_count) {
+		unsigned int lttpr_lane_count = drm_dp_lttpr_max_lane_count(lttpr_caps);
+
+		if (lttpr_lane_count)
+			lane_count = min(lane_count, lttpr_lane_count);
+	}
+
+	connector->dp.dprx_lanes = lane_count;
+
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_dp_hotplug);
diff --git a/include/drm/display/drm_dp_connector_helper.h b/include/drm/display/drm_dp_connector_helper.h
new file mode 100644
index 0000000000000000000000000000000000000000..a15ae1a4b1a5ef038e2cca3966f88ea1dafa9c13
--- /dev/null
+++ b/include/drm/display/drm_dp_connector_helper.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Permission to use, copy, modify, distribute, and sell this software and its
+ * documentation for any purpose is hereby granted without fee, provided that
+ * the above copyright notice appear in all copies and that both that copyright
+ * notice and this permission notice appear in supporting documentation, and
+ * that the name of the copyright holders not be used in advertising or
+ * publicity pertaining to distribution of the software without specific,
+ * written prior permission.  The copyright holders make no representations
+ * about the suitability of this software for any purpose.  It is provided "as
+ * is" without express or implied warranty.
+ *
+ * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
+ * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
+ * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
+ * OF THIS SOFTWARE.
+ */
+
+#ifndef __DRM_DP_CONNECTOR_HELPER_H__
+#define __DRM_DP_CONNECTOR_HELPER_H__
+
+enum drm_connector_status;
+
+enum drm_connector_status drm_atomic_helper_connector_dp_detect(struct drm_connector *connector);
+
+void drm_atomic_helper_connector_dp_hotplug(struct drm_connector *connector,
+					    enum drm_connector_status status);
+
+#endif
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d83dccd3e820a444fbf74fb6c16f2..953affeff0d6b7ca574d2b70fc1117dc435a97e8 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -31,6 +31,7 @@
 #include <drm/drm_mode_object.h>
 #include <drm/drm_util.h>
 #include <drm/drm_property.h>
+#include <drm/display/drm_dp.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -46,6 +47,7 @@ struct drm_property_blob;
 struct drm_printer;
 struct drm_privacy_screen;
 struct drm_edid;
+struct drm_dp_aux;
 struct edid;
 struct hdmi_codec_daifmt;
 struct hdmi_codec_params;
@@ -1882,6 +1884,91 @@ struct drm_connector_cec {
 	void *data;
 };
 
+struct drm_connector_dp_rate_entry {
+	int dpcd;
+	u32 rate;
+};
+
+/**
+ * struct drm_connector_dp - DRM Connector DisplayPort capabilities
+ */
+struct drm_connector_dp_caps {
+	/**
+	 * @forbid_lttpr_init - forbid LTTPR init and access, e.g. on platforms
+	 * with AUX timeout < 3.2 ms.
+	 */
+	bool forbid_lttpr_init;
+
+	/**
+	 * @supported_rates - array of supported link rates, sorted in
+	 * ascending order
+	 */
+	u32 supported_rates[DP_MAX_SUPPORTED_RATES + 1];
+
+	/**
+	 * @num_supported_rates - number of valied entries in the
+	 * @supported_rates array
+	 */
+	u32 num_supported_rates;
+
+	/**
+	 * @dptx_lanes - number of lanes provided by DPTX
+	 */
+	u32 dptx_lanes;
+};
+
+/**
+ * struct drm_connector_dp - DRM Connector DisplayPort-related structure
+ */
+struct drm_connector_dp {
+	/* field set by the driver before registering the connector */
+
+	struct drm_connector_dp_caps caps;
+
+	/**
+	 * @aux - pointer to the DP AUX instance
+	 */
+	struct drm_dp_aux *aux;
+
+	/*
+	 * fields set by the drm_atomic_helper_connector_dp_detect(),
+	 * protected by connection_mutex
+	 */
+
+	/**
+	 * @dpcd - cached DPCD registers
+	 */
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+
+	/**
+	 * @edp - cached eDP panel version
+	 */
+	u8 edp;
+
+	/**
+	 * @lttpr_caps - LTTPR capabilities read from DPRX
+	 */
+	u8 lttpr_caps[DP_LTTPR_COMMON_CAP_SIZE];
+
+	/**
+	 * @lttpr_count - the count of LTTPRs that are present and initialized
+	 * in a non-transparent mode
+	 */
+	u32 lttpr_count;
+
+	/*
+	 * fields set in drm_atomic_helper_connector_dp_hotplug, protected by FIXME
+	 */
+
+	/**
+	 * @dprx_lanes - number of lanes reported by DPRX
+	 */
+	u32 dprx_lanes;
+
+	struct drm_connector_dp_rate_entry rate[DP_MAX_SUPPORTED_RATES];
+	int rate_count;
+};
+
 /**
  * struct drm_connector - central DRM connector control structure
  *
@@ -2291,10 +2378,17 @@ struct drm_connector {
 	 */
 	struct llist_node free_node;
 
-	/**
-	 * @hdmi: HDMI-related variable and properties.
-	 */
-	struct drm_connector_hdmi hdmi;
+	union {
+		/**
+		 * @hdmi: HDMI-related variable and properties.
+		 */
+		struct drm_connector_hdmi hdmi;
+
+		/**
+		 * @dp: DisplayPort-related variable and properties.
+		 */
+		struct drm_connector_dp dp;
+	};
 
 	/**
 	 * @hdmi_audio: HDMI codec properties and non-DRM state.

---
base-commit: 457f4393d02fdb612a93912fb09cef70e6e545c9
change-id: 20251001-drm-dp-connector-a82238bd5b81

Best regards,
-- 
With best wishes
Dmitry


