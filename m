Return-Path: <linux-kernel+bounces-776488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC475B2CE13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329974E3E76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9C343D91;
	Tue, 19 Aug 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8Uhmr/4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AE3431EB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635596; cv=none; b=XCRGYNKIf5KA3v34wu1tsLu6v+zY4dLodkRlrCpEPOWR8rtry5o3zX6E2sfHANTbeaEVcPYYF984GZz0DjlYsp7cgP6cH7pTHaZu0Yiqh20yTlgx2FNZS/5yPUZOnOdHEhsBPPxKfTdVXT2crImRh/SfO++CqaUtE/m8WjBEx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635596; c=relaxed/simple;
	bh=n7xaHZSSROB+2XdVsucGDeHL2qDsHnv9brWl2LaC/6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otE8kZwoTnHb0zzoXImnCRQ32DBN6KWKf9VdKEZzhIQNRIFYGMwAbeUWHZVa/NqPd55Clu3mZhKutBHDBUVRPvBBdjvw42tDDF4VgVoKMqLjFUb5d2oNnloJegLG7Qg4DarOPsryH1NTWCkRCU9oG/6b/ypnzrb8MEVe0kXAUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S8Uhmr/4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHIaE1000431
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uae42TaI8vGi2qGQ8bwNSeWnG/c2PiftWqaI8l7bbt8=; b=S8Uhmr/4O+nSPYIm
	2zKbhC/oDjV9DkZ26zlb6qdRRPz5Rnu4ww2ej5v0TmDFmkdYXv8TFVeTP/bGwxsb
	4ZxQ/2im9UB6JRhBSPPadrP6c6xKYOU/sHEkIlTyb59nZdRsVRfqUKazW2GxnS+H
	aaRQM4t55EbBdmsQ47OzwhMocAXF0XDTJo+mbWRGecA/e6GR7IKVMmJ2s4Jbj4fl
	ZK5O0LX5cytxx88P+iIVnB8iDHNFRFHTIUma/cchElwTH8ASfdFxrYbMrbaas43I
	WepbyRcoss2ENw0vXLUxZn+tJtkDSdBp0OkS0+lQaOo+uw1esXpqN1Z1fDiJrdB/
	Lbw0Yg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh079vgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f55eb56so131976276d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755635591; x=1756240391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uae42TaI8vGi2qGQ8bwNSeWnG/c2PiftWqaI8l7bbt8=;
        b=HpRlyyjcS7EpWz0YXu+lMSGeSKLbXzXMu7oEZ+F5ZVHwTfpnU/tfcjtUnmg+AHwi5L
         sNGfk7oMYtW7wB4cFl5RtXEBQBktCMwkFO4nDbyZ2TBpVc2wgzczHbeTpxzzrAWDH3pm
         33XleZ2GCcwF9wZAGQpCJc5NFcem2gQzD2RS9WMNtAXZNaV3TJ18i2hAYDTUQLq/R7zI
         zD5Y2pyR8BS0YpOGotlUNePAPl0+u4HiConyfG9dML+v2tUX097ixIjNvXIz1UCbordk
         Rs82L6YXPAFzPkHU7G/dGZFp01iyeaY2k12NfgC1cMaOaq4jaJSwJyGpKawbGVDyIymW
         NUGw==
X-Forwarded-Encrypted: i=1; AJvYcCUNHsFxGezyTZiL/8NCeMkIf/nZPffcTbX4FoJuBnfhZ0i0EKxEmRpPdZpOqpgSMlZseNvKIKcc/5MRS1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLcNxlILMwBOH3vt5CY3oaRb93ZCqNhgOWywh2hYVAaPNZoBY
	hRfTQrRhPbBLliOPz8aDAyTQ2HH57iEXEwnCwCEAWcQjNTGJYhTeNr/88vgM3mEHA8J0QLoQBLm
	4bMpPGJ1znryasPcH1q6YwU2wuoZ+xaQXgchkXhGI72XTxY1Z2awjWk1044wmlC0+lEw=
X-Gm-Gg: ASbGncs6kmRCnL9fkLzl8v75V4ZLFCDzVOI6pUWr2ndLAJjC9OCpXBGQgjwwOOIOVTS
	67mjq1Pwwll1n5H/OnA0jEG0xnNn9JB18WmGw5fRLensBSwqu7/fhAAxhNYBVwaN4RQIcd9D2Ww
	R7sxI3nWVf0Ig85A96J+nioLSkBypf0SnVfRKSUoK2I2b39Lx5OylVXGKPSK9HpM7os+VPy6YEf
	hneSyH8tRdKMNGtNfToYMits5MTu9gwFGehRt8IZL5RRV5hGHfZUIA+NwDeSDuOpgwBu0TLA5p7
	Ob6CexuCUshbBmAzlf/UJOIxsDNW6CeVy5Met3LZvhPnDq2D7H/vsDfMsJ7M4ngGX6nJhLDwV/D
	uHgax6KZXwZkV/JCBE5UfXdNfx6oaFwOA1kyBWSFVqk6mFof8ma45
X-Received: by 2002:a05:6214:40e:b0:707:4aa0:2f1 with SMTP id 6a1803df08f44-70d76fb03e1mr4791846d6.16.1755635590848;
        Tue, 19 Aug 2025 13:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjMUMGSvjeQdbIF0CDnT7P91YufaBD6waHQI6sRs/n+ZhEnj+eKGwawlgjU4rExarcr2ll3Q==
X-Received: by 2002:a05:6214:40e:b0:707:4aa0:2f1 with SMTP id 6a1803df08f44-70d76fb03e1mr4791326d6.16.1755635590143;
        Tue, 19 Aug 2025 13:33:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:33:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:32:58 +0300
Subject: [PATCH v3 4/8] drm/msm/dpu: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-4-b48a6af7903b@oss.qualcomm.com>
References: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
In-Reply-To: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=n7xaHZSSROB+2XdVsucGDeHL2qDsHnv9brWl2LaC/6Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN98gnguR5E87tGamvaP6AjPWdsyN4w0BBcCn
 Y3DFYviK+CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffAAKCRCLPIo+Aiko
 1cIrCACZlMfXC1ZcXwkARC5jlvs99j4JLrzEnSVtPScea3jfX6Xnp5Sy3egmpoSPlOFc5GNZuv7
 tqe8otrW1rgAZmoYKaWQPBtK/LzQYdu3u91oc3Ox3LhGbAIyK5c7Thl64ufZc5/XlENC8WsV34V
 q1Xb0pEDgNJdOAnN0d5l63dDxaacI912igs103k+ehliPAInW7DUdnmfFXdbnIQ7H45O5AoSTOM
 d7yhDfGWM68rDdlB9nvgMh/Tgra+l/algQswzhz+QQtwewmL8JTifw1PjO2q3eIAGUeon50Ldr8
 2F5d8cwAbCkKPqKEQsVJgrO+38orTXv/L+6y81c0EHhHs1E4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: XDV5L6qKYkigLGqhGqU_BONKY23jQ5BI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX+niHvDMe5Iea
 zqvPIh7TOW3gZdmGyIv0F9WWU3dQ1nzmhcd8frfdN4QPHIf1I8EIS9mrF/uECjCcqdLhaMrp6GH
 H31DxWGu62fHxbNzarX4XkuPOcg7EyisRrrLfuh5P91CRS4K4LaDTgj9eKfEOIF2d4a0jFfxGnL
 gCGlWOZz4ZNjtRH6raKGE3ZqE8d7mlHkphJIi9g+Vr193lR08nKBGzeJ4b51Cjl1kPh3XMsSHgc
 xhnjtcUqwWaqT/UDOtRpltNtrHS5GdFVQRXkXcz0pJndVCD69bezzdLLcarRpJvH2xJWpjSN1c8
 HoSKca5L08/+oDTrbhefSkjS/zUM/FZgL7w8p5x3jWWa1HHWZz3N83Bd+4fYPvVISHJz0iJy29Z
 m3gI11Dp
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a4df87 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=UqIHtJT1QCIVCAY24KsA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: XDV5L6qKYkigLGqhGqU_BONKY23jQ5BI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 8ff496082902b1ee713e806140f39b4730ed256a..cd73468e369a93c50303db2a7d4499bcb17be5d1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -80,7 +80,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 static const struct drm_connector_funcs dpu_wb_conn_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -131,12 +130,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
 
 	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
 
-	/* DPU initializes the encoder and sets it up completely for writeback
-	 * cases and hence should use the new API drm_writeback_connector_init_with_encoder
-	 * to initialize the writeback connector
-	 */
-	rc = drm_writeback_connector_init_with_encoder(dev, &dpu_wb_conn->base, enc,
-			&dpu_wb_conn_funcs, format_list, num_formats);
+	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
+					   &dpu_wb_conn_funcs, enc,
+					   format_list, num_formats);
 
 	if (!rc)
 		dpu_wb_conn->wb_enc = enc;

-- 
2.47.2


