Return-Path: <linux-kernel+bounces-885324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC027C32971
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857174656F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F833F8A0;
	Tue,  4 Nov 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyj6uhan"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F552345CA1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279837; cv=none; b=RAxKHXLzX4G9082kbsI4NH/CB0Cw6yj/g3Q+wKx2A0fuYUITxuvLeQpKXeZIdgab0BazAqIyHMc9ScrBlkQ/wAes6ULdL5dQZ+pKCW7hq7GxGefoSc+NgwRshkUsXYlN9zdGFesybl1aXuw9gt7OcTZosjdYNl7aaZx7WaMYGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279837; c=relaxed/simple;
	bh=ye213JbTqvKJ7OHw/ZpY6LCcPpjvObWagFZelGOjlaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1XXeO0f3Z1sB1k25jMvjH5O5HFdrjFGX9YTMQo3lAD/PNQ3/usrxKOdQydBA2Uto7WF3o7be/HJ4NTZ9ayYISoHs2t5u6hIVuarkAsTs6qF7tezIcas4+suPDMGRX051qR6HzCBF8UpwgOU9nTu5j9Ad3BudpwmEufoVEmrnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyj6uhan; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117f92e32so47880735e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279833; x=1762884633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMq6+f8w/XMhRL94h1i6thbehjh3w3EiU9h31KM0Dlo=;
        b=Uyj6uhan9cgaJDyACAV7CwFe2fVKxndysy+MmVMaZXUqAztbMMcS0kTZRUt1dYsdov
         MKGQsWGk6rGUTv2mVjdx+EGcd1f0352P6uAfZKoza5zzZBOjG5y6rv9BlKx+rrsUtZRr
         QJf0DbvEnTwpoh6hRiL/UqbfpUdEKVOJAiqj83dSDgxjzH0aHQDsvyHkHs9YETQOk/J8
         gIXlz6VcNYH8yKy6CuGOLJgZdTdsBrnLMK58ARdks0C/AC61K6/6gNeg0cErjDStEEj9
         ZjsH8b7MtDODcg+wur97/ijJvZlShIQSQnzOMffS6y2vsMYbmF7hN33Hw+yusLv7PEMa
         fV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279833; x=1762884633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMq6+f8w/XMhRL94h1i6thbehjh3w3EiU9h31KM0Dlo=;
        b=fA8ISWOzlgPAbl4NT+3U4X81GXl7pmDbvmeSYO6ibTTXGVcd1HwlCS1LbvttigLnOd
         ok+9lwo3n02l946IzZSBP0i+G1MWSGY5q+4t1TsV10ONrE6aZ8tadq+sLWFY7kNi1PDH
         xwHa8MprSZE5oTG7+AeaxtrMvmh2+elLVx2aAuWdxD8xugUWC7kqN8JcUR/o9y1CFpWD
         k/1tkTVl/xYs15siagWrBZSr6ncKb8/dQCoB082SJ/b8QUFucqXsj3BP4dlc692ZHTMX
         lBxj6bb4qkt3f5msCEBQQIdW8XSMZ7bqCCr2VMoQMF//fCCQo7/w7qorfqdKW90ekqtM
         KO9A==
X-Forwarded-Encrypted: i=1; AJvYcCWXA6ON3QUYHe+/g2LZjEa0Q5sc3cnYiEwSdPAWRj/+cpvU/9knSflckgQHvwd1FM1Zt66dkRR+Wh5Qq+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pZQiopy+AM0ZZd8Ia/WECQu0DMLG5gOVju6ufslO3Pu9MFaI
	lfcGZQwcJbAd9ek1EPCCyYwwSACeCY9jP0Ui75w+Jk0GCKVm6cGe41jc
X-Gm-Gg: ASbGncsk5dHeJExVuSlWWnOl9KH68flVT6loqMEuTzUBAoBJV0+CL/tpgRSYxd5tmTu
	uMu73w7BB5mSJGoSQCPU2FRw48NsrYykmchvm/e3nA8FEx/LwuXBb5ak7fiZS3PIQr6z4Z1b2xh
	LAwtnNvGL5oMtafjVLrQjZyng+dq31C5/UuusEV7bVr2pRGwdznQvPnkjMLAhisvn+4KxM8pvhd
	B343zwGiQYG5P08sDa6qx/Yv6qBi0CAUyWL9pPs4tj2SS5tEMoL/ZUR4iQMnCElj3/BaTrt0zms
	yi+C11/aL9feRcSFVyJYXSymMSLpWjQaXPGnT8xHMz2iLmF9Abej20zv6t/oo9ck1rfY3ylW+eK
	yg0cWYHTu52r2gvLzlWrXR7RippukToOD9aBRy4yyHXNFLSQ2r843/m98qw7gYy70GoRqgtO91+
	H28ljlyqm97A+qwxoRCA==
X-Google-Smtp-Source: AGHT+IGAou+/VWjl/+havcgVpIaUje7S46iuTOTBDTJA+e9THTDoYyFzTPWTWOtjQVDGfLuUQylUOg==
X-Received: by 2002:a05:600c:1e1e:b0:476:6ef6:e28c with SMTP id 5b1f17b1804b1-4775ce23c7amr2190455e9.38.1762279833261;
        Tue, 04 Nov 2025 10:10:33 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:32 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 25/30] drm/sun4i: ui_scaler: drop sanity checks
Date: Tue,  4 Nov 2025 19:09:37 +0100
Message-ID: <20251104180942.61538-26-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They can't be triggered if mixer configuration is properly specified in
quirks. Additionally, number of VI channels won't be available in future
due to rework for DE33 support.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
index 2fc54dc20307..c0947ccf675b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -132,9 +132,6 @@ void sun8i_ui_scaler_enable(struct sun8i_layer *layer, bool enable)
 	struct sun8i_mixer *mixer = layer->mixer;
 	u32 val, base;
 
-	if (WARN_ON(layer->channel < mixer->cfg->vi_num))
-		return;
-
 	base = sun8i_ui_scaler_base(mixer, layer->channel);
 
 	if (enable)
@@ -155,9 +152,6 @@ void sun8i_ui_scaler_setup(struct sun8i_layer *layer,
 	int i, offset;
 	u32 base;
 
-	if (WARN_ON(layer->channel < mixer->cfg->vi_num))
-		return;
-
 	base = sun8i_ui_scaler_base(mixer, layer->channel);
 
 	hphase <<= SUN8I_UI_SCALER_PHASE_FRAC - 16;
-- 
2.51.2


