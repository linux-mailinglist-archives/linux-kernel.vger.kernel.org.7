Return-Path: <linux-kernel+bounces-660680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B3AC20B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42463AAAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A62288EA;
	Fri, 23 May 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWwpApxw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3202253A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995278; cv=none; b=e+gJwa3A4nfpx0JG3UohKmmx+bu1vseac/MRf2fYkjPZbzGC6vFHAE1O70+GBQbHvi0a7wOjhWvbVl8hGW8FGYzwqkolpPsT1vGV0FJdowgOm1mHD/Ag+65PlpkqHITSodHoplWXmB6B/RyHBpa2bL4hJAUaDdi6Hs9OHKo43M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995278; c=relaxed/simple;
	bh=YXdLngDcBO0vJC/gQveHdfBkHJCl1Zxhg7Yjupm186U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OUaCFs/ZbkH08ALXtooif0RjlI0cevOOAszxp1J3ju3raai8X1J4Bz91A26CTzY6+BFey8OZyV4mRYF2B49R1rhgGZWFzSAAAE+3vUxNvahbs5XKnjek1Mt06YxqXZ4PHtSTniKIuf2YRulqFgQ9FWXHAMzVLzaDrkFq0+WqYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uWwpApxw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so75009075e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747995275; x=1748600075; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zKQCNztHs5vaJkSM9hQ4RIOUwHXJN4g4lZDHbYkUTE=;
        b=uWwpApxw8cIlBK4Za3QWpp/TxifMmRA6fgvrWuj1p4XcVFQVM+gsPKQLe4ehVQazM7
         FRDRY9FLeoQ07teM142zy+pizzYgbv7ea3j4K6TILwlgmR0J1hne6L1GFkna9OCralwC
         lmhN/mSDCscFJLd6lwNaL7opgEIx1A0SO46s31aH2sVWOmkhLVRA2eJGsGgK9oCdRDtl
         jrvdQ7kGvYK0WV1PTa4b6NVO2Ut0vyWYLHh1vzblAAFK10dHVpS29UKVQrHqYTPyMjuq
         cn+V/T3QLgdBFtHXzxEzi/TEXgxHN9CBcc5nu6TH7EjvlIICXgfMnJGN2skWkCtMQ7Bx
         tbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995275; x=1748600075;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zKQCNztHs5vaJkSM9hQ4RIOUwHXJN4g4lZDHbYkUTE=;
        b=w+tSgZJ1aEU7ownv2P1MW2fQmYlFuXpc0vZV6iOb/Qty1rU6MHcN3rdG27zocwnOKA
         9yxj+9uV3qGOgz3TXbaigpj2T//a0GfuBaQGDTUqX5KzJ5CeF94Qiu4NjVns3/dQCF0w
         SzgYk94bvFVWaIC8Fk9uv5Sl7GWBKZQt/XY1rX2ZKEvs5jKob3KhjHpgSpxFng+0pXCO
         brdVKHXC23TrMDXKum70ljQponzo8QmRHNCFvrXXMMUnJAWet+DoDvAzWN5GOvvF5H07
         M5vA209D7f0sFzVpDk3v6GWY6HdTyZ0OnvkQ0gst5GH0B1QXm9nJvbi9d8EDKAtMN4iX
         lUXA==
X-Forwarded-Encrypted: i=1; AJvYcCXzVtEkp65/gPgd+qXt/MQ5/koGAD9Dk5dXmKCcRlszsnT5fS8IVuuvbEsljR73Ci/YROn7AvUGH3U2TtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMM9jnIjgMoCPQv/VifS1k9MW96QVZqHS0Y5dBOIp7TdaVxil
	pTCdgDpcVWvvtVv7rqs95hxQT4ahDE+iKEa3qaM70x2vEjP9z1BulncY6tDAnl9hlmQ=
X-Gm-Gg: ASbGnctru7ldlYL7Ev2qfLyjwc3spa3yaWTiEzKKQfla6BlpRv39U3yi2nR8ctnM4K1
	e1k2r8iLm7CQ33489UX/ViH9N+9Uu9mVk5C82OHB8tfUXEFfxR825hkWF32PFhflwXT5VRUo69w
	pqo71p70rHeNqd3sy49dHVyYQwAkW95vsYUD8J0HHzKIrgkKuxCjPFYqsfCeqmk1DQTGbb6qvXb
	WKcEBLU5aetpJr2/l7ALQKmouB8s6EuPY8qA3QFuiqJFXAKTUs3FXgd1kFSSVSMn+L66kay100/
	JIZeY0LcVj9loAagMZt6SwYyswLsfL684vikVkyMoMUUGraV5g==
X-Google-Smtp-Source: AGHT+IEuf3bBObzgG57jYGNQDtRTTrbOqj54r9Cq5DQk2zMU3kmt458sE//vS5giTUD8U4YoKDV4cg==
X-Received: by 2002:a05:600c:1f95:b0:442:e03b:589d with SMTP id 5b1f17b1804b1-44b6e85fae2mr26950875e9.24.1747995275216;
        Fri, 23 May 2025 03:14:35 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f05581sm135208955e9.13.2025.05.23.03.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:14:34 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 23 May 2025 13:14:22 +0300
Subject: [PATCH] power: supply: qcom_battmgr: Add lithium-polymer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH1KMGgC/x3NQQqDMBBA0avIrB2ICbHQq0gXiRntQE3SSZCKe
 PcGl2/z/wmFhKnAsztBaOfCKTYMfQfz28WVkEMzaKWtstpgLgd+57Shd7Vuq6ALAT+cE1KsciA
 9rDeejDJ+hFbJQgv/7sP0uq4/SGJidHEAAAA=
X-Change-ID: 20250523-psy-qcom-battmgr-add-lipo-entry-e75b3be303b6
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=YXdLngDcBO0vJC/gQveHdfBkHJCl1Zxhg7Yjupm186U=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoMEqEne0ttuK8zTJJgKWMRPGQweMwniKprXSkI
 ZvK4gMoRIOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaDBKhAAKCRAbX0TJAJUV
 Vh9oD/4t/Ab4odV5IIvMkEp6oVEQR9VxC87MzrQEfmviZd69GIZYd4wR2MNejTEfmbChZaz5e54
 X6+ic+swqbVVzyp0pHjamdccJIRnpBT9C2pCx18KFONjY7bCMyvZ41MvrHLPkEljltER+4w/cly
 SSBhVDzpBZ5Lf+6HNH98ckFL1ZoFCroqDBQJrf10tCzcXHPQtRp3Zed2eDpwgFP+V06a7GOJJYj
 yVFS/gAvESmywT5U3NEVnOu4CE4zbuOG/vnMdaoLP4b2Ll4cn4wxS//Z8GpUEyr6Jq0/agqxqY6
 eiafwoU+eSxE96b7Dj8AxypUVxlCCkslg5xMs619u8UZ4FwWfWRtjF7ovuSQI7HIMZD85gEJTjK
 c2hGNBfXlsa4unReDCpfXgKw9OL3XA1iLwiX8qff1ojCsViBHwFVs1rJY1q0umqW7XxGvgTo/xl
 aGNwQKWCMWffpR0nxthiAQscEd28+vyvaQmHBqIh8AcpDtcAeAsi3W60skFRcV44s4LfXelzgOK
 SBeVfDA5cmHZbxQD9lntkUb+zFf0OVQUmiIhkB8pb/DGOo1zB8sV63iqGHRbxe9RXgrkFwo6h56
 b6M7fBKlo74u4q5lupA1biF8/9FcZVueB0yPUfJFmTMY4AONUGNf2nWwxrc0Ky6SCnt90KmgA0R
 CA94md15gdr02Ag==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On some Dell XPS 13 (9345) variants, the battery used is lithium-polymer
based. Currently, this is reported as unknown technology due to the entry
missing.

[ 4083.135325] Unknown battery technology 'LIP'

Add another check for lithium-polymer in the technology parsing callback
and return that instead of unknown.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/power/supply/qcom_battmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fe27676fbc7cd12292caa6fb3b5b46a18c426e6d..32c85939b8973422ee417c3f1552f2355658cf06 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -981,6 +981,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
 {
 	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
+	else if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
+		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 
 	pr_err("Unknown battery technology '%s'\n", chemistry);
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;

---
base-commit: 176e917e010cb7dcc605f11d2bc33f304292482b
change-id: 20250523-psy-qcom-battmgr-add-lipo-entry-e75b3be303b6

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


