Return-Path: <linux-kernel+bounces-836395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B9BA9917
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E517A541A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A630CD9B;
	Mon, 29 Sep 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1qyMvmD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571730B536
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155932; cv=none; b=mASVfqXltfqRnKyFAddiFZP6TAFt5KhW0qGj6FFa2a1gbCv1VadYcGTgOP0Hp0r6WSs7ko8RyGNcZgc9Nti+8GoxHpx2CpZY2xm1CKWojWjwevw1Z892gxoedk/edkk2DtUVUBPCwmpo/EBqZ/X4wWmQHs6fzSa9sX04PxLV+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155932; c=relaxed/simple;
	bh=ljrBd5OGddd2yzGqohN5FRIpAWAajBSqIFjspUtmZ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn6PBAononohVQ8J7NaHXDY4xi7CPpr1FLA6y1taSBJ49ehitAfcw5PFn9NxiPp8Z9hd6vmo6/oDbSqLlHYym4P2PdqhUnU6C/hYKFZWtjFk2V2A1rHKStZmYrYI2gwLJEjWh8LUemwzRwljL7V2zXvlKaHaByiMGrhOZH3TGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1qyMvmD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-579d7104c37so6569332e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155928; x=1759760728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmXPjuryXSqRr8DS4zExlYZnJGP8SsHdroCjEncRXpI=;
        b=k1qyMvmDqkdL2tClPLo8AzRJap0/h9oky7Ldgo3fD6jsWG1Kr2+P+rzSR3d2rMv5zN
         2H2tfgHD+iUdIlXJ0fQwSx3cXeilmYUPh/BUrcZAng1OOMroYzNls1QdZVv8fhqzmf37
         i+Mj8TAlS3RYSyeq8fhf/mJsuTAqT9m3LjJkWqB/sot7K+6LYgTy7kEnS7YAAwYaD76c
         dOathoQfUlCEfp8vYtFI5lMjvXameqAeP1TDmwT2vy++Dhnt+sJl6oDxeLkduQzV77TJ
         nuqo0xF+SPcbCSDcuemqc4cbQz3jk+O0xt5ok18qZHH4ejpltIOHZXZl5fs+nfuiyc4m
         93eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155928; x=1759760728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmXPjuryXSqRr8DS4zExlYZnJGP8SsHdroCjEncRXpI=;
        b=BXitQTcYlYa+yvV6/UXsdhGj+yiUknBXcON+zy05U4X89ZmZE6cj3CcX4yrOZLvWx6
         yHQ6QDySn5uOjNqe8SCJMNs7sNdy0U6PRM6LPF1vvHDD/DXrUROFC+S7VW5bzhxCrif8
         vQikY1kst8FZowWljkJGgmNOfQ5kmPVapWtONie9uSECU2/63k2gRHQRjJdQSkTYbLdh
         OUCv/LnF0XWPf232yLHtfwdAlsnnExFw4b4GgIVU0/TeRvPxbxqit5W2mXC85wJxBVR6
         0d2ugSoxgcbBoApD6J7JtQFluUwnF04CbWzdYiLUWhSVK7rRpQSCEjU13zk/K8Vpk4zj
         iQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5otatEG+r0SfGj0kPUpXtO5d4wHENSDis2U2l2yAwqNQRxL32Sz5R5aK/PYNqdi9FNt4c9i1RBJ9k5l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCjbmUDNgVZfyCC477kpeMCrpt/xVruYCC1tgE5cHwQDVm3oJN
	MDTrdmxXxOheSkPNdaxP+rZqcYcWWEIOEdjPQZs/c3hg9SYz0x50KE9u
X-Gm-Gg: ASbGncs7yGzlPf8sVNU9w37NVfJJkomBc7K5e4G7sbPEvJtje99/tRkVAGRx5PsFvPT
	xoS2uN1qdxiaCAhxf0veW+6QrzQQFrIa6kSlrW0W+fXNjBamg0f/mIYhAnaCTGa7Oy/TPKb2yt+
	E5EUpqA0X142UkOxaor3qn/nIHiAUkQ7VxFQ4BMQo6SqL3r2YlWMduIwqjieNDJQAV6Kwbc9UQV
	w6Ngv5UJOz7+qfA/WMREOOLG0xEdsGVnOEFNpZsGtmT7wdtGRTGYWfL382J2DWQEB7bH2KVRSbH
	fI2w6YPTKXYle2ecdBku8vG9kvQ+tsZS4uFOWXn2S9IQfcuonjMFGcwFC1lnYxQ9g1n68DruUMw
	xMGCfxy3CzZSZb5lxTkCnSHoCwQSGoHmzMrI=
X-Google-Smtp-Source: AGHT+IHcGLKbQ/s13YElRimx5FsWcbtSM3Vf0+G5+6fyUYRzlFXaqPvOerq0bMbZhupJyyuu2WrS+g==
X-Received: by 2002:a05:6512:1189:b0:55f:6b4d:85d8 with SMTP id 2adb3069b0e04-582d2b4cbfdmr4907344e87.28.1759155928244;
        Mon, 29 Sep 2025 07:25:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3728c23e6c1sm13201001fa.52.2025.09.29.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:25:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 8/8] gpu/drm: panel-edp: add AUO B116XAN02.0 panel entry
Date: Mon, 29 Sep 2025 17:24:54 +0300
Message-ID: <20250929142455.24883-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929142455.24883-1-clamor95@gmail.com>
References: <20250929142455.24883-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an eDP panel entry for AUO B116XAN02.0 used in Lenovo IdeaPad Yoga 11
with Tegra 3 SoC.

The raw edid of the panel is:

00 ff ff ff ff ff ff 00 06 af 5c 20 00 00 00 00
00 16 01 04 90 1a 0e 78 02 99 85 95 55 56 92 28
22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 12 1b 56 5a 50 00 19 30 30 20
46 00 00 90 10 00 00 18 00 00 00 0f 00 00 00 00
00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 31 36 58 41 4e 30 32 2e 30 20 0a 00 f1

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 90e8c154a978..f01c11f7b59a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1865,6 +1865,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x203d, &delay_200_500_e50, "B140HTN02.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x205c, &delay_200_500_e50, "B116XAN02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x208d, &delay_200_500_e50, "B140HTN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
-- 
2.48.1


