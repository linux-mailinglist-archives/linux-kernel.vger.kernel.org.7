Return-Path: <linux-kernel+bounces-776490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998AB2CE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4051BC8048
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48C343213;
	Tue, 19 Aug 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pcI7/53i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD38343D81
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635597; cv=none; b=pr6w78dFbxMPm2oNLJGievnhS/NIefznGvFLu5BRSu4fo3Lb/sP5n6VIVXjQm0R3V9jGQAke0PwfaY+4Do/ueJ51x84rSSedk/lU5URL+dBq5m7v/Jwg0zvWVYBf+7+fHubR5KGA7TyWTJF3RfSa2nEOdo/WtHEAVV+mI2+USTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635597; c=relaxed/simple;
	bh=9kPXh1enzh44Jx+JV9Ql6fG94nEVIAR8Tv81e1DfnG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQR3ppESaY6l2ExecUKSX/H2RFZPqXWnHN8bDQ7+lA1B+xCIzqJr8z/4dvJTBN7GTQZwJtcERGwSDfpn7G++RuiGQW47tOt8grToih2TxM19BSJBp4JErGitlHTkzjB9+efelkvrO1nSGWdhLiNol5cPVivGuzberBXfBKR9fwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pcI7/53i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHHlUg032432
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndEz2xbpBNb9n5L2RWMR2nJPekvJ4u9Qsxz7tSzeQZk=; b=pcI7/53ilcL/mke/
	pFPxcZ0iyDVn+aikqejKPYNI5M4gwpQ7Tcs9PHfZQKBYdpBLpCxatL+NffQnrg8F
	QEM85eoyQmp2/gTLmZNXcEOY9VWDtXSCE6t33xwfm2whXkLX+BEVU+12pF0OtL6L
	au9pE5/8IRHhA6h1udBdAG1dKXRCIEpev9TM31QSDWxgxx9VcELviP/dOu3mMS5k
	lo6t/TZV/YEUFSSoaS2Y+Pd9eoE1kDWuoY6KAIsj2SHCTbaS8ohFK/3a+Jxgf430
	4YNNdUUPqTfKazvmDW9a1TF303UM+QQZnc3uqpkMdVxW1OdzDyK0peAv49EEEGgX
	v/i8tA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2uhxmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88de1e26so202824396d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755635593; x=1756240393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndEz2xbpBNb9n5L2RWMR2nJPekvJ4u9Qsxz7tSzeQZk=;
        b=WP1rma4jCpIpB16v/4XHVEwG+ppEC/1Imh1EtOzXu89XojpjY9OzfTfiLGmhUNxTXX
         m8vHnJImWcGxd33UZvWGCUNA2g/GVEq8YJDSh3YCtyLfDkSVF5Pvd0QumVrWXoJj08+j
         vMRtewIIfDrElXkOcp0UUZ7TDa3Zxhbz/Oj+RJXk4rs/c4emtr3HkV2KTxO6YNIGTGkv
         CXg7xwrjNUUZDhXadjhoCIN0LOyb3TYRtUafVKAZGOrCbM2MTFuFxGaR1oLj3mwIRZAt
         NF3VwozUiSbtWCzwRcOye3h2XZ9QPbxt5zJgu45D6zyZP356t3rp6rW0iT8yFXOpx0k3
         Nb8g==
X-Forwarded-Encrypted: i=1; AJvYcCWizUAqaxkJNqzBpZJm0N2xXmqOPLAgH7gkja9t5UBDUDiSb9+Bb8pFcLrmSFFm/ABFWyr1lvyTEh7ZCvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7eyLi0WqSCYVDhgF0HuydVRZXETMhcFnhb6T8OyUOy2x/42Y
	wG3xn/IOYlF+4Mc6VoNG3E21VlGjSGyUDOg8NuFDLUecAZ1PT95Tt883lYIQHGR0GRAbYwNJRXF
	T6CpUN72nqBM/abCNLMLj8cvgtW8hrig7ygiOVVrgA8uEyKmqkonbxWh1RUVpmJQeGAk=
X-Gm-Gg: ASbGncuUDibn7Z7Mn+fC5WRpjKpdZsAsM04NemSAD/W7XgXaDKtGUvpj8lfItNIqjyk
	6cjZ5LYTKjRpwKlTlwwDT99iWD5sRKpbSqCMLRMaxE02RjA2nkOFGxNNd1mngBwzqL+j8M83Rax
	W4yZIwj6gz2NId6/LbBVXQjeRIkk4SAxWUEsN5OCVpKUss2Z1l2pwBEpilhDWvWbwx7sOpK9fDZ
	nGY8y3nTA3Zaybj745oC+ENqTPUyp6D9g6DQL66U69foW7tmb77J0FX4lgDIuVG0DtF46yQAi03
	+nEgkMrTPxVRzTbSW9hirXX0QlRohLh2GqdazNA0aukUYyyvoicXWv1/Iu0ZoP3glOBCR+iVDJV
	4YdCDL8V5HdWplHgfnB8Pamt560Xvs9/jriQ1Izn/u/li/hsAK9Ea
X-Received: by 2002:a05:6214:2526:b0:709:90d2:4628 with SMTP id 6a1803df08f44-70d76f92bf6mr5416866d6.19.1755635593519;
        Tue, 19 Aug 2025 13:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxihLKXa7JhuwwkeFQ0p5zKqK7B3jNVOf3qZbLFjzpePpJRXKGGlC8e34zDhvw9cZPJCBDjw==
X-Received: by 2002:a05:6214:2526:b0:709:90d2:4628 with SMTP id 6a1803df08f44-70d76f92bf6mr5416336d6.19.1755635592861;
        Tue, 19 Aug 2025 13:33:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:33:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:33:00 +0300
Subject: [PATCH v3 6/8] drm/vc4: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-6-b48a6af7903b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9kPXh1enzh44Jx+JV9Ql6fG94nEVIAR8Tv81e1DfnG4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN98FeUHqsRMxqI2y7bSGcGGmIQ2ngHpJlEtt
 7qfS9PHwcmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffAAKCRCLPIo+Aiko
 1aEoB/0S0UbRv6Cn22F8M6h9l8cAG1g8kwox9gPMNA16YkeVOr6K95UiTo3MMjJp7r9L+aqIiYW
 4VY008h32adgxAl6T4rztlv/gbNcK6wpN5EIJcGDsFjXYG6mcjcx1tPbG9kOmBqd3reRp4s1wOJ
 KAz5KS/AtmLz2CYVi6vPsL1PZXzn0Uc9Y1E7/ZG52uZtIAvqY2e3ToYbYtmTF7RKaLy/uIYmZMS
 2VVTZTlmjclBLLn02HJiSZDsiFI9KByjQEssXDY1vWz0MOTsCsts7Jrp8LWNtE7St9nwsiUNJWz
 E+fzSaHhOeKC2+ykQjdy0xhRKprf1e1ISuEYVrlH7d6pc9Tx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a4df8a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=hRdDZflY9wZGYtDLNskA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: h1Hk5x-rQvX9Lof6Kabyr5yy8tjQLtxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX45UTSUWbtREi
 OYfkn8WJrI4kHkkHoqVCqre8yev0ne5nEm1VXvetBJiFUJAtOBAE6ppigQpD2tsQkpLi0Kt7x92
 Pqs30iVxGs1Vtx0eNmREI+AdEA9qw+0kCAK0xPox1xCriqRVPkPe0XXryzvv2eB/by1XnGCKZQX
 1tSQne7CMTxAYTkj6Bu55nVHq8l61dRWad+457HcasWWsvJ/+DagK+1fifrq5uKaU9AdhK+NJVP
 h+sljTolUkV7tfj76rXXfUSyzprHTnWZ1ng6PloZiesLKFsLHK3cSnpDV5JsubdpCuJp9kxOXoF
 kh1PU6jUo/WIEvpb5vBUNAFchV0FhuTMbgkxAwdAl/wxHuos4Lauaq9WpDCRFAjebQYdWCOb5Y7
 pSrYqA/d
X-Proofpoint-GUID: h1Hk5x-rQvX9Lof6Kabyr5yy8tjQLtxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/vc4/vc4_txp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 42acac05fe47861ced226a4f64661f545e21ddb5..fef4e4ee47cf41d40de47c5201f0349dc36c56bd 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -377,7 +377,6 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -601,10 +600,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drmm_writeback_connector_init(drm, &txp->connector,
+					    &vc4_txp_connector_funcs,
+					    encoder,
+					    drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 

-- 
2.47.2


