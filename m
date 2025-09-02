Return-Path: <linux-kernel+bounces-797456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669BB410A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D0A5E8298
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5D27FD40;
	Tue,  2 Sep 2025 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az1/1oX9"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84C27B35F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855132; cv=none; b=AX7bAHaqIGb+vXr+ol/PVUHTuWtTcwwayh2MxF+grkdqo+X0Dd6uLAiaG+o7UvKaXHH2f37pyo5VDZi87BBMqweqLrjGiK1Fm4INaTuattHNvMjCmz6boZu5pVVflolTpQuBAqmhyKiujy6moRxks3anim9sZamngV9orBqhEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855132; c=relaxed/simple;
	bh=vFIjj8PcQO0fmwg/NKv78IJzKns4Mrc6m4rBB2pz6h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYH+Pv6nqPNt1Zt9RX7ocTD5SX0Kbk2H4D0waGro0OItTVu8o6hGSInkL7zQNixcbz/j4gVuH91tLRrKGOE+rBtruDswO2Tyqjk+9a7o7cXugYQm98oFTXsoi6KmSNxu4f706+Kn/na/jYDVyn6cfukXiURd2cG9NLt6IFAT3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az1/1oX9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f76277413so3390879e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756855129; x=1757459929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HZ9pl638NqdNSfS3FpV9M0vR2wmTDAt4Oy5y7M+jVE=;
        b=Az1/1oX9p3C4APEkChIP5HHmfPverz3TusKJlmr8+/qwUWw/ff7hxOFWTdoXmaA/Uw
         xD+VdeHIHVj70Jnchof22Le9EkEenMXwcJ/cKRzUfA17hLGAsEJMVfMzcidPG26GN/zi
         QhINJnf8sldW/kN/Ff/y0zU7vBbqyXrtvMmSSBxl1go3wpxyIMMvp4wOc5po4rCO6mTd
         xLjSTvzxbA3+wzPmIKoEH3jPCE7bBofu3/nNGBlZnEI48kLtTMaU8ogV+xqG8pHqlQM6
         QURFrTx3nn0n7MISUiL7oAsmiKkLQHeA9xu6eBWa/+sOeDQWelE3g4LAIgZhDtyMETOs
         YumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756855129; x=1757459929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HZ9pl638NqdNSfS3FpV9M0vR2wmTDAt4Oy5y7M+jVE=;
        b=ja5x+f4+AzOua9wc9gdmVM5fuqZYZbE2jVhAE2BmOb6ZHwQM8PxuLY6+PHYYxWqLpc
         dJXj06Z3jFDLi2PX2u6Sv/vccIcfa6l1JJwj0C2bbr5yn/OljEQlocQ19hVhawld9Zhz
         UB64Vej7naj+H+B2qfU9j5AF+ifGJF4ub17sl/793JBKzoGAghu4pzBCyGUeoKruQBrt
         4vG05EuLlE3+7y6NAoXcZ3CX6PBlSzHpab1zMCsWWMybJQ3DUGTHuH//P2c/mxkt+xWn
         N0BjEMVCw8nU9Z2sSoakkurPQCK9ozBEvM7oYj3jH7fYomWvH98eWfmUEDFLUBWwxVpP
         J0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWLYsZ/T1yjR8QoLzUjK5NrOMjdrNK0zkoqD4tD/w+A6nDXyklP00dVW+eQjc+VI4fkk9ubsUJBsqKKJ6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqGurglc84YqyituG51aYvRtLf4pwlSac4zk98y0imFQ88T4C
	MI9wJYYNTTibxwzqOMbSI4Fiez+iaywNPkhv9iCt0U/NqoJjWOnX5JGW
X-Gm-Gg: ASbGncvjmm8XoaaTEgplOH9JMz9+96kYf5vE0OZuKQjb+eyJla7KOvw5PsveDzlo/CI
	ku1Qpy5/QdCpVowjKkXV91QG5aLyEjWJAZULm3fQU2pJE1ums5hNK/GMFz3pRq8wH22STfxZd+P
	uzbAWEjMKyuGeNwf/6HtxOBHE0U5nvpGfSx+ChaWBT7/kBmHMAhuBYu7+6fHgtLOrSMv6czlyo1
	LRRfcH1iyArLvFekkzM2dziXlad1QnWLP6t3QNxTTSI7Qoispu/gzKyQMd7pUnF/TVniXxe8YCJ
	ejWHqT5L63ony4FKCX9Y6fnBxOwLXHw+JyGTw3bC7WB7GV8JiE4+mw3ACPf7IxhoYXH0y/ti3Jg
	eg5zhWmetPN6+WC2qb8YVTp6NgTGIQmfeHrgPLBAt//g=
X-Google-Smtp-Source: AGHT+IGQGeBa42NAm+6M2nTSShnW1+q93X+RFEs5yrNEy7vwja1uyxfC67M5zlsU7C2tl4x0AYQKkw==
X-Received: by 2002:a05:6512:ad2:b0:55f:46cd:2c79 with SMTP id 2adb3069b0e04-55f7089c53bmr4106697e87.9.1756855128455;
        Tue, 02 Sep 2025 16:18:48 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608ab5e281sm105674e87.18.2025.09.02.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:18:48 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com
Subject: [PATCH] drm/bridge: lontium-lt9611uxc: use reset_gpio as optional parameter
Date: Wed,  3 Sep 2025 02:18:21 +0300
Message-Id: <20250902231821.2943-4-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902231821.2943-1-vovchkir@gmail.com>
References: <20250902231821.2943-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems the reset pin may not be used.

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 5051cdfe2fee..1aeb5b29704b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -179,6 +179,9 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 
 static void lt9611uxc_reset(struct lt9611uxc *lt9611uxc)
 {
+	if (!lt9611uxc->reset_gpio)
+		return;
+
 	gpiod_set_value_cansleep(lt9611uxc->reset_gpio, 1);
 	msleep(20);
 
@@ -460,7 +463,7 @@ static int lt9611uxc_gpio_init(struct lt9611uxc *lt9611uxc)
 {
 	struct device *dev = lt9611uxc->dev;
 
-	lt9611uxc->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	lt9611uxc->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(lt9611uxc->reset_gpio)) {
 		dev_err(dev, "failed to acquire reset gpio\n");
 		return PTR_ERR(lt9611uxc->reset_gpio);
-- 
2.34.1


