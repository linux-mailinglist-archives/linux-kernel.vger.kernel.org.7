Return-Path: <linux-kernel+bounces-776484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB76B2CE04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B99D4E42EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C99322526;
	Tue, 19 Aug 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFhDYcXl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E43101AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635587; cv=none; b=M2LcvymcxdvReI7Byv77bc1bSwsCxqKWmVQK0byi8Yg7Vn8zqYAQpZy9Rgz+iEVOPMQoCUDJ8Ks6uns8trpuM4XNTPbkzhBZaCzHQrPHTyNSAtnY35f2sJOVGzpZ8nu8+u1ikXKX6dw1+DFah+uKOJIQzxy3EK9YFu03Wrowg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635587; c=relaxed/simple;
	bh=Aa58E9QetYLLT5CJBrAOu0YiguU4bRwcPCV4OnIkTHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z41SWLInCmA6gKltqmuEt5axjpLeBBYcmiaDKgQyZvDtDVbmkdKgdyb8F2Gh6bVyps8aHotZPYGpxzCsHo5MMZG2/57Hdnwcf3XC/MPs6XKD0m08wtFYeULlnwQLy8I6MfwU5Od/hjEkdAXE9cLkAzfPQFvhB7lVlGglaeUq1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AFhDYcXl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHWpC6026990
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u36+WUg3Mc3swJSKHYkMll
	irkkX6BUSLAF6TGZRcL4s=; b=AFhDYcXl/vxBRjQ0K9Ksh5w0QZ4HO+/ItwLv75
	CwkSAmzB5RuPhPksRO2s+t8zfojqHFAAPGEWXmu2jrr2LhUy3u1+SAla07zV6P47
	d4Ol7dpYnEzFsvTZVrw02sAJ0w7yfzi6qngeZxDQ00BgIfAJMPrsTJgT5zNss8Wb
	O7hkGmMG7S6YbytnlTvcP9+8GgPHU1oLDndI+eBTU3CVJl6BHREau3FtehmhSaip
	cU6HXgjMgiCRm7jO25/QwmksiRcDW59j01+g7NvrPOUL/UBrlnQUskThbJhxxvrS
	6Dfg7p8PWVRN4NspUFzTJHcAnryupN+bAtcrLrYyN8/QOVrA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyhvqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:04 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88daeb18so126743046d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755635583; x=1756240383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u36+WUg3Mc3swJSKHYkMllirkkX6BUSLAF6TGZRcL4s=;
        b=XsJ/bbgAO3SSCgP7wbWx541XMZHfHwjdxs5DNG/u82JmPAfZJX1+k0mjzxtOZzaSIj
         6mO0YKhO0I8wi7RLCO+2KtXuq1N2Nwe+6CJxwaQepAex0LTAoM20QQftimAdbESWjPCf
         uElasbWA751+Q7K75gYyFG7BFlmYdyWToldkfJgL60rifd/AnwgRcSqNVARoPU6rrOFR
         YpxO9HA764vxiH2MKDIoBVLqIszqjZZK9WBkIO95g3Z7kN/VCZvi40WR8x6ommOaWLSz
         wiBsYk9IG5EAq0WVLgNFt2zZDa7H2U1RYwCAWO8PgNqftJHjPvr71Y1pSEJ3qv4XvvM9
         u1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWI/68ltmgzpscuHyUD+egaS1Kz0UTvPm2gf+BtNSDhJjnxi5vQLh4biGj53KTGrfUS3aAsgdqul4H6pug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevxWTqezSrfJ7EEeiOG6FU/HZ+jaN2xwJnHRzP9qB0Eo+HojD
	U3YCy3SQWpzs0TT04eolcp9cHYwHP37tosHdfg+4cj5Ck57g2Zt6SOI5sh4W9NnbmxQCu1fAJqQ
	KQDNu8TkWh6iPu2Awktc7cSMGugs6Ycjuf9oSjMgzAQgC7YZnMu3sHIe8TyvwN8/+aB8=
X-Gm-Gg: ASbGncu92v/Ulza3LsTQiEBeUqLf/JkC+OlLoyNl9Uq3yG0pklg4sIHn+JtNqxyh2lJ
	o2RwzreHxWSjFa91XCYZVUerxRSPcy8LgFUQxI0eHqVPC3ueyPUxFd61Gp3e61WVQlg+B6ZflRW
	VybUM5y3PGOC5XpiJ1Abk65pI7ezJw3XRwNzIDzYe6VxQTYl3/52EgHeWmKTHzU+6KTgEcQe+ma
	nh7KlOddFTF1c78IzuDbX1DKi+WhvC5qTGkIET6p1ioalrYg1/B5GlK0shSWGHMKrcPi+03N5Ay
	G2h/kXxMEuSr8G0mf76WUUwOXqJ40NoU6RN4eVh8t/jMMHctlaUHfKsTqqmZoz/fVY4W70V0i5G
	bb5DWaTLu3bAJS8Ak2Qj8Tl8HzeVkd6ihav0G0t7IwKr9u+/osT6l
X-Received: by 2002:a05:6214:2a8b:b0:70d:6de2:50c3 with SMTP id 6a1803df08f44-70d7722ac12mr3783966d6.64.1755635583348;
        Tue, 19 Aug 2025 13:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAnp1senRVBtFPBwRjEhWsmFdCBol2BtP8U6B6xBW6RH43qAjRYF7z+Opwyhnt+adLP/Hnpg==
X-Received: by 2002:a05:6214:2a8b:b0:70d:6de2:50c3 with SMTP id 6a1803df08f44-70d7722ac12mr3783586d6.64.1755635582666;
        Tue, 19 Aug 2025 13:33:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:33:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Tue, 19 Aug 2025 23:32:54 +0300
Message-Id: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbfpGgC/3WP0Q7CIAxFf2Xh2Sog29ye/A/jwwZFSdxQYDiz+
 O8yjYmJ+tL0Nr2ntxPx6Ax6UmcTcRiNN7ZPYr3IiDw2/QHBqKQJpzynG8rg2oJy9gzYS6vQQVU
 2VJZ5q3JVkuQ6O9RmfBJ3+6SPxgfrbs8Dkc3T/6zIgMKGi0IUVHBdqq31fnkZmpO0XbdMhczIy
 D8wrPjG8ITRVc4UUqGFrn5g7q+oDi9D+jm88pK28Qjzkgl1plwHnfFy9W6gxzEk6/0B7Q7XzjY
 BAAA=
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Aa58E9QetYLLT5CJBrAOu0YiguU4bRwcPCV4OnIkTHU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN97fwBvb/Aik+XkYHZSwBiiuPfEQA1DGz3dJ
 flwtoG76ZuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTfewAKCRCLPIo+Aiko
 1YjxB/4paCYzN/KLKPzZ4YPkvDeKzFqHUnCvsWyzuoY816hxdZdIjD0TjuJ70yL9Z8yg9TjelxV
 aJ5Wyezku3fMWBxN2+cusfQUKZM6NTNTCXyuJS2MoP8/NIsExN+7TXlmIz0H6IlO4YcwxA/fjMF
 b4gU1HZFju+y58XOm2/SIV7XDx2hEwWCIbYZS7noxxHgws3tY+QOjjvnSXBVV/PT0mrZriuxIfk
 y/rjbPBSoRg8nYiSNwHEk5QwQqDPMfBapHa8nHZiwSomT8o7u3vnucIdIy5gAsggZcdJEnUf3Hm
 nEgEQ1j1JRxaBTwG65tJWl4khOBj3THsYqNzreWKeZ3h6rSF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: QIRulcuHSdgCN69lmT5s95kV6bBvdWhr
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a4df80 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cFjmsF-WLDi_aLc5EnEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: QIRulcuHSdgCN69lmT5s95kV6bBvdWhr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX6bWlADBjK2bR
 SwBKVozk0o6hnurWGclQ0BReaHP266Y7k0xpuvrgASEhNwzL4MWYI+Rxzqyg9B8NwpBqpFkbMqa
 ydWBGtBYHngeb3+7nL72eUuCVeaorBjJkyWgApMug+Kze5flXn4SNNgWJs1e79jb7ocnYRi5ppU
 0fxM8sduZhBT9BUW6Cz0nvBvucRaUIFuS2aprrzVHsQrnRYIlcSNQOFB7p3iVGZLkswQ1ZxHCab
 hlUq/m1ymdnLVb+/v8pEBAqoGCv/q+36Ytn/yKZzgjcEIbIUCo57qclNZgAAyVieztg6Uf5SS8M
 lQDwCwnnsyrzdW/PXaYcRLnMG3CXyB4Hbxleis4clz9Zn/pSLqvqCuCeqtUxHdCm9ehwZDXgIYH
 VbRQe7lK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Migrate all existing drivers
to use drmm_writeback_connector_init(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
(it's unused afterwards).

This series leaves former drm_writeback_connector_init_with_encoder()
(renamed to drm_writeback_connector_init as a non-managed counterpart
for drmm_writeback_connector_init()). It is supposed to be used by
drivers which can not use drmm functions (like Intel). However I think
it would be better to drop it completely.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Fixed subject prefix for the rcar-du patch (Jessica Zhang)
- Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com

Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      drm/amd/display: use drmm_writeback_connector_init()
      drm/komeda: use drmm_writeback_connector_init()
      drm/mali: use drmm_writeback_connector_init()
      drm/msm/dpu: use drmm_writeback_connector_init()
      drm: renesas: rcar-du: use drmm_writeback_connector_init()
      drm/vc4: use drmm_writeback_connector_init()
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 ++++--
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c                    | 25 ++++----
 drivers/gpu/drm/drm_writeback.c                    | 69 +++-------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      | 10 +---
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++---
 drivers/gpu/drm/vc4/vc4_txp.c                      |  9 ++-
 include/drm/drm_writeback.h                        | 22 +------
 9 files changed, 77 insertions(+), 131 deletions(-)
---
base-commit: c8cea4371e5eca30cda8660aabb337747dabc51d
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
-- 
With best wishes
Dmitry


