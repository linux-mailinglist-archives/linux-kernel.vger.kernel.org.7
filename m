Return-Path: <linux-kernel+bounces-594099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC1A80D16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C6316F083
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB81CD205;
	Tue,  8 Apr 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJxbn19t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093ED18E025
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120472; cv=none; b=VBbeFzIvnE3N2aipTETYC46Vqym1zqAkD9KWi/8j+10+WDAuoF9wffohsslv1OtaWe/2J+Ny7+TFgN0CEqXPpZasIkr1VZBjmCdHzwg88Qx/JG8VNfBuNSceWyqEugHI79aYBb34BwWNFkj35dO+ZTfAnapcCT2BA1Sqq9cjhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120472; c=relaxed/simple;
	bh=L9IQaB3dZM8dKuhg+AsdFe7mI75+GiJLHeHw0KwrydA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwAwutXy95MLI7NNHxDmlKOULk3bhO1oo2n2j7F02do3J96ucI/s9NEXupCwcGUbhb7TksN6IxHsWjRpa4YC/yyPi4p9PUIkm2czMDavV2/YqLTNap6V4PSd3MHV3+8dSWbM5MzFeS3smgd2+NMEMRLiZKpeKBcOcApKpVk5O6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJxbn19t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538AvDQW029678
	for <linux-kernel@vger.kernel.org>; Tue, 8 Apr 2025 13:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/guJuXHc+xbVtqg30cV1caMVZPLpuUM7s5OuX3mLwWc=; b=CJxbn19tadAm/bEz
	LH3+vbTc+ijjitBSHC0rp7D5KTuFp4jpyxm8qTw5OnCU0ONT/H372ft2Bbj8Rjz4
	iv55IQKoyDYH86J7OLX3Oni77wU/cAFkk/2NdD1Ychv2qqC8N1WnA9IvWran+sYp
	Jr45Aqgx7kBRK2fZDNOzTuZDFQz0UYacLrgD/vU/gWfO33WnRPtseXgJ1OghWzJ1
	JoEJbc8JtqqpRKkmeY0uoiJ7Sdj3e0BroZpUYYQVVTE/RuMvYvcXMI7vB0brPzh1
	YtTZAF4K4yVzDbCKGx+4NMmCqbYcPbvPnVP3CjWuEWUWYlfe3oSJgFGyRYkcKk0Y
	4BW8Qg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrfy89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 13:54:29 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ecfbdaaee3so99310596d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 06:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120469; x=1744725269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/guJuXHc+xbVtqg30cV1caMVZPLpuUM7s5OuX3mLwWc=;
        b=wATbh5MuBjmy5Fr+iDuK9L9LweRYARGyjh3Acz5duf1D0kVJ2n5fZM3bIvxOWlvIHt
         Gegq945ikfajYAhv0rw2d2q5fJqUR3CE2yxZsk0zbDHsIh/Z9fEI7DT5bM92QOnvfxLx
         kscXqbPVMoTpu/3bNJEvopYMutvbr86L6RkiJyt+8mbjaSTB89TeeuWoXETjeThfNCAm
         n8qp/LIB4wq51pqsH/FNaR606HAXBB9iUcdwnoYK1aRrwFY6BJC5POMDX1zj6zz5iAPJ
         iRWKvPC6rR8QfzavjuZ1HwsGYyTkFrL2DExC+SFchol/NJoWyZaCZsZI2DGLD+w/OmzJ
         XEwA==
X-Forwarded-Encrypted: i=1; AJvYcCUKAjf+tBTsJvhOkDyKDYUM5T/Jtk06DeZ6S+/YQjaKbzS2ug/oqncaQhTet0EWnnZ/TJxBS6BUG0YcAYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8ViMa8xID3HH5OWBVKv2HGcDszUAKgezbFdpQBGpaGanG1hJ
	V9CqRy0cw72lNf3bcpliX4+436nRdixSMJAGxMtRwfVVi7ELAMv4co7dNpZo7JH0YeQBgM8h5kz
	Pd+Hf6G8dFe8rPqfW90kapk8HEx71DfPQwtcwCKTa7jMzFy07PEbgwqD/z5kyI9g=
X-Gm-Gg: ASbGnctLIQOYXjst+lEl/+8hZd3Px7g/UytfoVJy7JZpRYMXpF362l33LGK7KDRjQhc
	OrU/f5fFBANNeefmQWFI92IteLGG2AQghhrZGYForbTSgfTLrbvMb/tCY/g+M0m5UkEWK4qODr7
	E5XmEiVQJlQhnUcGVgyrARMJE+p2BSRSrxhK5+MonJEcRhvCMHgIfrzxEjoCyE9/1H97AWdIp+G
	hs+PA2AiAHFIJfqvxKXkjlNi5gMGkKl+k/ieYtF5ZIP+1WKj32O2uKsIaiksU9VwrAl5lMlguyP
	Owtf/wLkMrim2WNGB3ot/zMhhlRCo1hDK3858FueGYLfExB4eS8vbn0lWYowBBRE2qHUcw9LIpT
	y2SkFTRsZMREHmD0oGdQZ7rEzc7Y0
X-Received: by 2002:a05:6214:248f:b0:6e4:2c6e:7cdc with SMTP id 6a1803df08f44-6f0b743ae6emr206622136d6.25.1744120468843;
        Tue, 08 Apr 2025 06:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfEAtI/HIsnFwdVEpeu2yqHw/yNUl+z1lo/BcHgGXYSd0REcEptjTzaDcXI+ZTJ85YoGoPMA==
X-Received: by 2002:a05:6214:248f:b0:6e4:2c6e:7cdc with SMTP id 6a1803df08f44-6f0b743ae6emr206621626d6.25.1744120468380;
        Tue, 08 Apr 2025 06:54:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672306sm1515306e87.237.2025.04.08.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:54:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 16:54:25 +0300
Subject: [PATCH v2 1/3] drm/display: hdmi: provide central data authority
 for ACR params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-drm-hdmi-acr-v2-1-dee7298ab1af@oss.qualcomm.com>
References: <20250408-drm-hdmi-acr-v2-0-dee7298ab1af@oss.qualcomm.com>
In-Reply-To: <20250408-drm-hdmi-acr-v2-0-dee7298ab1af@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7377;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=L9IQaB3dZM8dKuhg+AsdFe7mI75+GiJLHeHw0KwrydA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn9SqRE3+VLZtt/suKQpQbzQkVjSZTwoWlOTfxs
 JE0jHBCwdmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ/UqkQAKCRCLPIo+Aiko
 1WgiCACuLnOGgBnCPgnsWgdKKU99slAetDuFrOEvnolV+XF9DnF+LETgJAJtzzSwR4ZBYpo9hR4
 uKFM5j/tAQqPxO9KrEii6pgeh5tzbQviJl76bjrSn0OW1pZwbvZTnRAYzNZHmbJe3WrV+MO3EeY
 ztUlnunttbrw27UAB+XOZbY5jU75/qWi0HP6xjrW2/XiBCY+augv8bAoeI+8VRFLXjbBq4oXvYq
 t6d+FkxpuIWevkl8QUndtIkD9kkXee/xFiacQFO1bSpaUiQinC/o4ieuCfzIcC1h3M7nq7iVhyi
 JT0j6f2zW/gHChu1se8HRG8FmpC0w1PyyMpz4W22mIr9a3+N
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ZhwKy8FDdUbvsTdoeJ_mkm7Pth86TbXa
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f52a95 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=80M1J1airvQ5joFw3aUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ZhwKy8FDdUbvsTdoeJ_mkm7Pth86TbXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080098

HDMI standard defines recommended N and CTS values for Audio Clock
Regeneration. Currently each driver implements those, frequently in
somewhat unique way. Provide a generic helper for getting those values
to be used by the HDMI drivers.

The helper is added to drm_hdmi_helper.c rather than drm_hdmi_audio.c
since HDMI drivers can be using this helper function even without
switching to DRM HDMI Audio helpers.

Note: currently this only handles the values per HDMI 1.4b Section 7.2
and HDMI 2.0 Section 9.2.1. Later the table can be expanded to
accommodate for Deep Color TMDS char rates per HDMI 1.4 Appendix D
and/or HDMI 2.0 / 2.1 Appendix C).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 168 ++++++++++++++++++++++++++++++
 include/drm/display/drm_hdmi_helper.h     |   6 ++
 2 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index 74dd4d01dd9bb2c9e69ec1c60b0056bd69417e8a..855cb02b827d68fd630b13fe34f3b4d49645a380 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -256,3 +256,171 @@ drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
 	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
 }
 EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
+
+struct drm_hdmi_acr_n_cts_entry {
+	unsigned int n;
+	unsigned int cts;
+};
+
+struct drm_hdmi_acr_data {
+	unsigned long tmds_clock_khz;
+	struct drm_hdmi_acr_n_cts_entry n_cts_32k,
+					n_cts_44k1,
+					n_cts_48k;
+};
+
+static const struct drm_hdmi_acr_data hdmi_acr_n_cts[] = {
+	{
+		/* "Other" entry */
+		.n_cts_32k =  { .n = 4096, },
+		.n_cts_44k1 = { .n = 6272, },
+		.n_cts_48k =  { .n = 6144, },
+	}, {
+		.tmds_clock_khz = 25175,
+		.n_cts_32k =  { .n = 4576,  .cts = 28125, },
+		.n_cts_44k1 = { .n = 7007,  .cts = 31250, },
+		.n_cts_48k =  { .n = 6864,  .cts = 28125, },
+	}, {
+		.tmds_clock_khz = 25200,
+		.n_cts_32k =  { .n = 4096,  .cts = 25200, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 28000, },
+		.n_cts_48k =  { .n = 6144,  .cts = 25200, },
+	}, {
+		.tmds_clock_khz = 27000,
+		.n_cts_32k =  { .n = 4096,  .cts = 27000, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 30000, },
+		.n_cts_48k =  { .n = 6144,  .cts = 27000, },
+	}, {
+		.tmds_clock_khz = 27027,
+		.n_cts_32k =  { .n = 4096,  .cts = 27027, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 30030, },
+		.n_cts_48k =  { .n = 6144,  .cts = 27027, },
+	}, {
+		.tmds_clock_khz = 54000,
+		.n_cts_32k =  { .n = 4096,  .cts = 54000, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 60000, },
+		.n_cts_48k =  { .n = 6144,  .cts = 54000, },
+	}, {
+		.tmds_clock_khz = 54054,
+		.n_cts_32k =  { .n = 4096,  .cts = 54054, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 60060, },
+		.n_cts_48k =  { .n = 6144,  .cts = 54054, },
+	}, {
+		.tmds_clock_khz = 74176,
+		.n_cts_32k =  { .n = 11648, .cts = 210937, }, /* and 210938 */
+		.n_cts_44k1 = { .n = 17836, .cts = 234375, },
+		.n_cts_48k =  { .n = 11648, .cts = 140625, },
+	}, {
+		.tmds_clock_khz = 74250,
+		.n_cts_32k =  { .n = 4096,  .cts = 74250, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 82500, },
+		.n_cts_48k =  { .n = 6144,  .cts = 74250, },
+	}, {
+		.tmds_clock_khz = 148352,
+		.n_cts_32k =  { .n = 11648, .cts = 421875, },
+		.n_cts_44k1 = { .n = 8918,  .cts = 234375, },
+		.n_cts_48k =  { .n = 5824,  .cts = 140625, },
+	}, {
+		.tmds_clock_khz = 148500,
+		.n_cts_32k =  { .n = 4096,  .cts = 148500, },
+		.n_cts_44k1 = { .n = 6272,  .cts = 165000, },
+		.n_cts_48k =  { .n = 6144,  .cts = 148500, },
+	}, {
+		.tmds_clock_khz = 296703,
+		.n_cts_32k =  { .n = 5824,  .cts = 421875, },
+		.n_cts_44k1 = { .n = 4459,  .cts = 234375, },
+		.n_cts_48k =  { .n = 5824,  .cts = 281250, },
+	}, {
+		.tmds_clock_khz = 297000,
+		.n_cts_32k =  { .n = 3072,  .cts = 222750, },
+		.n_cts_44k1 = { .n = 4704,  .cts = 247500, },
+		.n_cts_48k =  { .n = 5120,  .cts = 247500, },
+	}, {
+		.tmds_clock_khz = 593407,
+		.n_cts_32k =  { .n = 5824,  .cts = 843750, },
+		.n_cts_44k1 = { .n = 8918,  .cts = 937500, },
+		.n_cts_48k =  { .n = 5824,  .cts = 562500, },
+	}, {
+		.tmds_clock_khz = 594000,
+		.n_cts_32k =  { .n = 3072,  .cts = 445500, },
+		.n_cts_44k1 = { .n = 9408,  .cts = 990000, },
+		.n_cts_48k =  { .n = 6144,  .cts = 594000, },
+	},
+};
+
+static int drm_hdmi_acr_find_tmds_entry(unsigned long tmds_clock_khz)
+{
+	int i;
+
+	/* skip the "other" entry */
+	for (i = 1; i < ARRAY_SIZE(hdmi_acr_n_cts); i++) {
+		if (hdmi_acr_n_cts[i].tmds_clock_khz == tmds_clock_khz)
+			return i;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_hdmi_acr_get_n_cts() - get N and CTS values for Audio Clock Regeneration
+ *
+ * @tmds_char_rate: TMDS clock (char rate) as used by the HDMI connector
+ * @sample_rate: audio sample rate
+ * @out_n: a pointer to write the N value
+ * @out_cts: a pointer to write the CTS value
+ *
+ * Get the N and CTS values (either by calculating them or by returning data
+ * from the tables. This follows the HDMI 1.4b Section 7.2 "Audio Sample Clock
+ * Capture and Regeneration".
+ *
+ * Note, @sample_rate corresponds to the Fs value, see sections 7.2.4 - 7.2.6
+ * on how to select Fs for non-L-PCM formats.
+ */
+void
+drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
+		       unsigned int sample_rate,
+		       unsigned int *out_n,
+		       unsigned int *out_cts)
+{
+	/* be a bit more tolerant, especially for the 1.001 entries */
+	unsigned long tmds_clock_khz = DIV_ROUND_CLOSEST_ULL(tmds_char_rate, 1000);
+	const struct drm_hdmi_acr_n_cts_entry *entry;
+	unsigned int n, cts, mult;
+	int tmds_idx;
+
+	tmds_idx = drm_hdmi_acr_find_tmds_entry(tmds_clock_khz);
+
+	/*
+	 * Don't change the order, 192 kHz is divisible by 48k and 32k, but it
+	 * should use 48k entry.
+	 */
+	if (sample_rate % 48000 == 0) {
+		entry = &hdmi_acr_n_cts[tmds_idx].n_cts_48k;
+		mult = sample_rate / 48000;
+	} else if (sample_rate % 44100 == 0) {
+		entry = &hdmi_acr_n_cts[tmds_idx].n_cts_44k1;
+		mult = sample_rate / 44100;
+	} else if (sample_rate % 32000 == 0) {
+		entry = &hdmi_acr_n_cts[tmds_idx].n_cts_32k;
+		mult = sample_rate / 32000;
+	} else {
+		entry = NULL;
+	}
+
+	if (entry) {
+		n = entry->n * mult;
+		cts = entry->cts;
+	} else {
+		/* Recommended optimal value, HDMI 1.4b, Section 7.2.1 */
+		n = 128 * sample_rate / 1000;
+		cts = 0;
+	}
+
+	if (!cts)
+		cts = DIV_ROUND_CLOSEST_ULL(tmds_char_rate * n,
+					    128 * sample_rate);
+
+	*out_n = n;
+	*out_cts = cts;
+}
+EXPORT_SYMBOL(drm_hdmi_acr_get_n_cts);
diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
index 57e3b18c15ec79636d89267aba0e88f434c5d4db..09145c9ee9fc0cd839242f2373b305940e06e157 100644
--- a/include/drm/display/drm_hdmi_helper.h
+++ b/include/drm/display/drm_hdmi_helper.h
@@ -28,4 +28,10 @@ unsigned long long
 drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
 			    unsigned int bpc, enum hdmi_colorspace fmt);
 
+void
+drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
+		       unsigned int sample_rate,
+		       unsigned int *out_n,
+		       unsigned int *out_cts);
+
 #endif

-- 
2.39.5


