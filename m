Return-Path: <linux-kernel+bounces-873097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C28E1C1314F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6CD84E4F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF17229D29C;
	Tue, 28 Oct 2025 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkbX2dtG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D71C5D46
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631775; cv=none; b=l+LQkgllx0YZO0UQxO5bda77TVxaW93NnYuECMxS2sSEBs+tIbzSzYo8NKDQRN6E7TqyJ+soERQLuIlfZdaui1KSP26bLquDzeW/YbWvvv86cyhvUGqSjfeXJp2SeNAXrSax4e1CAIyuW7XQmEeNTinaD4peAWetsxsWzeGWr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631775; c=relaxed/simple;
	bh=7tSMPskPiKe/boXjgCXM8U4kjX9Rmu5BHSaKJRhAyrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A0hVhG/Oqd85he4wGcei09NTyBXlEDu/1pa1IfSIDW+XPA5PBtVU/OuBVKMQEHO1Jj8qVmXS/y+8wwqTY6ZCJ6sczgxh1ynNPFV+BD+Op09K9jF80UHHY3Lc3jattkkG1+XIHZ1SsRlwuBr+4H7bYxQ9Q6Ja8t0+DH6AThntz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkbX2dtG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so4213159b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761631773; x=1762236573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxCaZgetgi7vR+cOn85gSzckFRkwOHE6DdvavzMKaQo=;
        b=AkbX2dtGxl2sf8gLRLDSn9oK2vmeAPa5gOcC9fkdtCnAc9M6SbNxG6Ge+owznUttaO
         UIYwqFtYzC5KfR6G0Sd586Onq42NCaQ8snrmhAYM71/VIvQevgZWHXOXkDzjZtiaBJSx
         JosbzoBwpm5wNeoeAnCNbWm1EE9m/tNnQTyx5vGphjoXKVKIL473QGayIGrjWMYJoqaR
         2K5sKMWHA3l7SrBD9sISKAB38fVPgXVU0DIKS7uVLSUSO7thDbqQpHRMSvE/x7zYH446
         BturuGNxStPJczjlQDpotYbWjZpP4RcurcNux864a9gFR0OH/CoF2Lruk/KSACi54QAn
         BqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631773; x=1762236573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxCaZgetgi7vR+cOn85gSzckFRkwOHE6DdvavzMKaQo=;
        b=NGWsDeQql+ru2qKMheog5VGKnRUP8pHfkibV9lz5KHrgAzeqSQXFvug9pJEvCFGRol
         0uk7eEm7FU2UUqCld72DvHPck1bf1zbMmOyq5zYhm5Fge/oagzqV+tWehEaIvuhZqEX4
         zpiawzoZ71WTydO54R9PslpBrNXW3OiV2r+bMzLwGmcLVLUkkd6kddk5bURevQ35Id7M
         JuS86A+2wqUhnc0k6PQPX4mzX3u94Roxt4wJLHUSa6meozrqWFQbbM4kvte4x/Y9IZzh
         RM2yGFJanWMZePke2xPlAcDCVlCIKYIoCPDKdI7xEQkVb6FGRZVnOs8dbE9ZPcidbTf8
         ghBw==
X-Forwarded-Encrypted: i=1; AJvYcCXcTfp8f6KidaIEGUP5lOzwOL6yFEaP/sKjRPFUkhAvUZ65z2U51FglgnVF/oB7bshFGKPW4hzweAx66m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDWkr+I98RZRFT+t7E01CKoqAaI7GwXArBIrQsk0uLrt3biDE
	w7UGeSjVtwPxuTn8PyJEBA6vFnGmf5WbmQZLq4cWFrum/oTFq6oZ58zn
X-Gm-Gg: ASbGncv+MQkPavoKjwOyDOQ5sDOjx9+EmHsCKiDOtC83WjOJCLpiPpInFBYrfMSqylJ
	E8iOjyHWQj024IZ7vDLL/NVSTIor17FGG7VCFtoQ7X42qNyEGi7tbQ/bLj4QmNRQmZW1q3bi4Yz
	JIwuBsePp7lMMIKWCS1i0WtPe0cn1ZtXOCcUSRkY4vt+PSxdxJjPEClFtUXSlqsLUthaW5WchLA
	I5jb+bHQYrU9iH7hgN0R05nKhgstQWcgYgItzrcyP3KANzzxfqbMn1OKKC0Y8Z+UrY5ETR7KpNu
	P1MT3fke7qje0Yi52YLYXV0ZmSIKo5I08+Zz04nXNgAoKy8Zi7KGw4vwonA8mY+IJSZmMve+9qS
	dQ8q7M01ZrT6MIEp9yCwrREJFFZ4cjjXKntczIiCxsN8i17zYrzpeRmVdCZYLSNgNRpeVOeAmUu
	w6vgPOVGymHu5I8fjsyIbRvQ==
X-Google-Smtp-Source: AGHT+IH1+F3wRNfLwu/JVjiQE8TzFdjDfCqQgZpgSMYvuq3FzyuWy/Ro1wdBKzwG6QcCND8qtflldg==
X-Received: by 2002:a05:6a20:158a:b0:341:c255:7148 with SMTP id adf61e73a8af0-344d345618bmr3246377637.28.1761631773211;
        Mon, 27 Oct 2025 23:09:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm9382533a12.6.2025.10.27.23.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:09:32 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
	Philippe Cornu <philippe.cornu@st.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/of: Fix device node reference leak in drm_of_panel_bridge_remove
Date: Tue, 28 Oct 2025 14:09:18 +0800
Message-Id: <20251028060918.65688-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_graph_get_remote_node() returns a device node
with its reference count incremented. The caller is responsible for
releasing this reference when the node is no longer needed.

Add of_node_put(remote) to fix the reference leak.

Found via static analysis.

Fixes: c70087e8f16f ("drm/drm_of: add drm_of_panel_bridge_remove function")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 include/drm/drm_of.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 7f0256dae3f1..5940b1cd542b 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -171,6 +171,7 @@ static inline int drm_of_panel_bridge_remove(const struct device_node *np,
 		return -ENODEV;
 
 	bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	drm_panel_bridge_remove(bridge);
 
 	return 0;
-- 
2.39.5 (Apple Git-154)


