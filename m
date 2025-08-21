Return-Path: <linux-kernel+bounces-779636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7362B2F683
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBD77BF46A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E91311C21;
	Thu, 21 Aug 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kwufe1Tg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F33E311C19
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775518; cv=none; b=s9QR7tw5TS3QU01QxuD6bkw+7VKVPf6v6l1IPO77U18tWtX7nWFN4ZB1Gx5hPXsGoSkO+0JMuoA4zMldKKI1LrAdAB+KV3+3+OxcohpX2ryquCCjIEwKq6PuLOgtehZfgFX8hLsXr5odoF3uEVUd4Nq+3uvuXChBKTif/eM3t20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775518; c=relaxed/simple;
	bh=9pNcbOr/t5znsqk1yELfqWRWZ5Kb0hIeMOc2+a66FkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tfZK8TuX3w8LInsqDGCxlqvOrojtlprZDXNAOK/ORbDRKfsfE+d0S3ISiK7YWCdwkAAxc17nXVd+9jOwXJIkNWbRc8XTBFCq4f8UoY/qJSRMEffGLAkv57YAds+8IhSj9+A5tOHEy54BKKCflMsL8sjlflnvX6OG/q+mGh/9eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kwufe1Tg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b7mk030555
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K5bFmBCY/LeA6pTwVZP6+I
	KrEIU/bbWARlNfUXNazJQ=; b=Kwufe1Tg574GGRir7NZrcYjVXLEsjFQdWpRW1O
	rG5vVLrTSIdnHH1jrITYXRRfdjF3vzuJJaQ3RCmQE9E8W3++0IheV7VtrGvUPmsJ
	uS/mkZDDjj5QIAbogUqpl6b787FH1FzZhfZtQAyew8cU4tFsuykXfAU6orupFCCg
	7b7ij0u6BFlUnHp64rQZaV7SM+lJDy8unCYi7pZOujmWZjShF+jWYmV81YCj/Ykl
	iUGDI65SMKI0Yqh2hoAxkpEeA6xvK0PPKqKJOcHcRYPOaX5eN8HgYDdj2olrncFp
	zixtzpSbd4m6tsgnotQrMdAfIGeuCEsIi8nAOAKzydb6s43A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a5a7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:25:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88d99c1cso19672046d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775509; x=1756380309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5bFmBCY/LeA6pTwVZP6+IKrEIU/bbWARlNfUXNazJQ=;
        b=SMQt5U5y1ijpfWo5Cz5IaNQv16XsDY8NIfLecPdqT3bwb2fKm9IeBIPGur6fhY5udn
         0dFcfIM1SjtV4ck2uAmMZi3iMXQOgPTHd9ENhWfNwDMK4UnfWg7w+SBRc0oQqqKILtnH
         fqiQICKBu56U/dDjeTAHlr3plCyjMuNIFDXhOunORwUSDpmo0JzSNTQTmNofi+deEGqU
         j/66JhiDU/AxXg9Q7jvoLvpbuHyYAE9JHhVmyxLMKkXcLkuCRscOYyVzmvITS5Mjbt+a
         1c6xUBU71Ez5U6yzcYlj2urUE2KvwTbXCvGfDLwj0IffCQH0PVnVPZ2QySC3MWZKJuZ0
         j1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl7VsFgdiyHQbPGQYtJeJuG5gkiOacx4Wbal6WvANt3P4Bd4hk4aVWCUsAeFqjFw58s9pRHh759ilSxNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymqAZystCevj0TFN9eiZ/KqbTyuuyk1q0mKstj86TS/GoRb4pq
	MaxI0mx3UFxyN2pDEfn4z4BH3uy9LCJ09jg0OrX1UHG9oAVruUNRWfjVS/pfF9FWDALkNQkku3i
	/wJiThKI07sxzQrXGLcNByzu0COwIYjDysXcoBUwxQB6S5UVdNVNIdTFvkIezfL/R2Fg=
X-Gm-Gg: ASbGncuWKzHt3zxG7N92de0xE5gNHXR2J22uXI7tp9tPHvhrQ7kp5sBP3yCTB7KrbMY
	1senC01aB+sg8NYPuTbpdOMTuYQx1IVSZ7jvGIc0DAuYHDQ2BaL2R4BJ9McW4OqyhRh4ZUXi4h1
	3cFaLBIguULSZpKbZrEwN+TGoo+o6o+lfohMRORmqE6oG/CDMc4fXsSsetMWG2EOLwrdYd3UlDC
	qA1y8TfZw6YRzOkNRCdMLxLdwQJLnOt+/0154SXU6ddH0goC64VKiZveUEZgd4AHuDhynwaxCiQ
	ykl4TycdbKefKx/9LZJd7QOK+cnZKdNZcBVd0JH0BFftATLta6pZGXcr3E+ACVvaczool3hsvq8
	t+vr1YMxoeBqWGaNorylhhLRtnaHGXnlesI6RS5pyyrw1GzAIyLuu
X-Received: by 2002:a05:6214:5b13:b0:70d:8aef:8d0a with SMTP id 6a1803df08f44-70d8aef8e39mr14441046d6.59.1755775508620;
        Thu, 21 Aug 2025 04:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFodSb08ta1eWH/VHLUq6PuKUZ3A+ZaIt2Sp/dt1JtT73SO4rzYoR9Belx6Wuxth+OnDD7Spw==
X-Received: by 2002:a05:6214:5b13:b0:70d:8aef:8d0a with SMTP id 6a1803df08f44-70d8aef8e39mr14440566d6.59.1755775507940;
        Thu, 21 Aug 2025 04:25:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35163bsm3055405e87.25.2025.08.21.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:25:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 14:25:06 +0300
Subject: [PATCH] drm/tests: make sure drm_client_modeset tests are enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-drm-client-tests-v1-1-49e7212c744a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABECp2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyND3ZSiXN3knMzUvBLdktTikmJdYyMzU3MTY6NkQwNjJaC2gqLUtMw
 KsJHRsbW1AJunTRJiAAAA
X-Change-ID: 20250821-drm-client-tests-32657432c103
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9pNcbOr/t5znsqk1yELfqWRWZ5Kb0hIeMOc2+a66FkM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopwIS3zQpbiuKMTHmp/gqkdHVus3vmXbJLIQkF
 vt4Kf7CrnmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKcCEgAKCRCLPIo+Aiko
 1bcNB/9VFpvMlWtKFzlt0JVYiQpSKWeIWhsj6mkvIA0pgxgxZXSwoGUbI5NNP/NAgSgLEqH4lDh
 iK2cpLZwkrTpV4cJtfAVBul9sjeOS0PvwKWxT75JxktCz6xw12FIHWB7PKDG0++icuPr+MI2zKL
 MfRmbwE84PwJrIdn33I50EET0TnTcgbr+g9oBtTWsG2e9Jq7tKPSXlDLHwXuHakSNftyGMRzP7a
 koHnbN6BisSmzigTuSMtaVfgD5lRBeZQzDkU1K/xhiHGuuvgVusoW4FSDZU3tSoFtJEX0q/qRqQ
 78TK8VyGnPOiR+3ioRFGdcGlmF/7QUBdVzC1LXs7iOWykv+Z
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a7021a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=RgqmURRhr6E-9W_eTqwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: QlnCwKy4HkJNmlCulJvOVnupX8_mYuNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX548RWFEL+XoY
 Lq4sWnVYZmqyqGLEwjBAH9DImazN8DDlNXe5JipKv56C3/9aS4/ethWLEZSxlgf7Zr60A69qzeE
 +NtCrcwGrY7ly2Q0x4RhLcNn7bgGQwxqpW3Qgbbmr6tRBUab+twLwLfmmzYfjFMyC8SZKoxb9AL
 t/gSHIroJnbT9pIXrso1SotMEG1unkTyuh3AK/M+/ZkP8TRCdAUgl04jUlnje+whepOuV7mvFIJ
 pRtXr92TtBemiS2ZjNvYfSkfYfhlDo9StPvZlQebjzFS63yUbwjsbmKctkhVYKP5t5+WisHW1L5
 vKo8jX33cWd8OiUGtiZFjUQaWt+rQ/8ZXLcnO/dAV2SpF9WDL9jDtJM31zG3z2cUemInKG45A/L
 YjJF4N2+ER6knsRLyX+PEQYjzUKDEg==
X-Proofpoint-GUID: QlnCwKy4HkJNmlCulJvOVnupX8_mYuNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Default config for UML (x86_64) doesn't include any driver which
supports DRM_CLIENT_SELECTION, which makes drm_client_modeset disabled
(and correspondingly tests for that module are not executed too).

Enable DRM_VKMS and DRM_FBDEV_EMULATION in order to be able to run DRM
client modesetting tests.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/tests/.kunitconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tests/.kunitconfig b/drivers/gpu/drm/tests/.kunitconfig
index 6ec04b4c979d45a082a5fb078b81346e1f60b0d2..5be8e71f45d5c3588ca67f117e4c44b995153f63 100644
--- a/drivers/gpu/drm/tests/.kunitconfig
+++ b/drivers/gpu/drm/tests/.kunitconfig
@@ -1,3 +1,5 @@
 CONFIG_KUNIT=y
 CONFIG_DRM=y
+CONFIG_DRM_VKMS=y
+CONFIG_DRM_FBDEV_EMULATION=y
 CONFIG_DRM_KUNIT_TEST=y

---
base-commit: c8cea4371e5eca30cda8660aabb337747dabc51d
change-id: 20250821-drm-client-tests-32657432c103

Best regards,
-- 
With best wishes
Dmitry


