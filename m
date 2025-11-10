Return-Path: <linux-kernel+bounces-892665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D0C45946
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA3B5B86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB089301475;
	Mon, 10 Nov 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do95ZCBU"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE562FF673
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766132; cv=none; b=q3wwdsPTkJ8cb+zAV/uzfH90vRF6sMqd7FzrERwuX9ioKqHzQQy4SJ10iU8ZUmL7jLbqcfuVx+K0Ghh+czokAcyb01bjR/X+zCvBuOdr+nnRRSzcR7bINd1QnCapXFDGAosMuQ2aX3af2PYZwm7xAJOMgL7wTFHLtz8D/8evQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766132; c=relaxed/simple;
	bh=Ubq1KrUSxqn44bDKjL0Tglob05w52CADvwCDYj5e0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUi/nlrWs9TQI60LYWF9lKpVFJiFUGROtHCQg3Db0MObLGewoXhXj3BaxT5pF6HzHzBEdQp0NJN33EDM6nMpf8MH0fVCpCDCVYw25WiNb1I3ZvTrVS9Cz413CZcw4bECLx+18QBlXEC+lQQky9MTtjKyB4x2dYgNwAMHIyJgalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do95ZCBU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso2595890e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762766128; x=1763370928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NlbLfnaH1AYI1Kzf2XAYKDUFV4VkFnG/ReSb+d8FKY=;
        b=do95ZCBUgKdfnRF1yICsFR1eSv0ifgcM+yyf47RAnIecEPAB+Xdhvhx5OYpRUTdt3F
         GH7jD03BE6wdIuCrkJFg7SnlVxE2wwiR1KPF5E+lzOLfsgOIuPBNeRPPb0Tiz2EFTEcb
         UYa2vs1Yo11C7gg0/ZWYi+2bj7C1+aQXVHSbdWNra6TjdXh8yazJuwacXqHBtNK77PKF
         GmY54aHLz0Sk23Da4sxF2IEWMmxcWQWfjrbZxEE9giZY0J84TZ6MiuiNO++LlymKS9YH
         zIlzADt1WDZlbDHEu8GbwhkmVmAX9NNFvLbNLjlM4qhkzTCtOly7Yc2JYYMZCenAbG3F
         RmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766128; x=1763370928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0NlbLfnaH1AYI1Kzf2XAYKDUFV4VkFnG/ReSb+d8FKY=;
        b=bFmvWcXOV9COBD09sJE04XmeUMPyr7sc5Pg47LmceLuaaT/XOjjfa5NNCyWiFuG7ZD
         A6WGa2zXuNuWiD3UIKYqzvT1HDn3UND9lIxHaUu4o0CQWX6Ds66u7mcP0WBYl6MQP4as
         2Ch38n7lwu2Ex/SoFrmUj6KO1CqVJT0/eAv71GQ+r34aEmplDs1tLdOYvIVxaGfYVynY
         lEio3b/PjF9FcGtbCKbQnzN2S+eSxfTpJJ4JUu18tXQMtDo+JUGIJLVDA1Sy9Nnv6zL+
         BBD7AUw7XWAkTvgevwOcR8MGzJMuKkjAhoeCbFMxubynlBwt1PyrnoN0xRvQkSrAVqrW
         WRww==
X-Forwarded-Encrypted: i=1; AJvYcCVBhnwhqcL/4fqjmJyrleAnpxfudI8ZEqzj2IkfsfYUldAe5i++09Jtl532nJYMWtDhPbzQjU+f/zPwgHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMd8hbEspP3iQl4Onc5MHiz3Z7UyNj8qaJ/5+l1lyg9wrkcPCo
	QtSFu33D3Exef4JCuQEWCSqAgy4zdxGYTTWQhWPV7zO8kgvrDSek4GcC
X-Gm-Gg: ASbGnctaXKvc2KFKLFHVYvBVCbGrrdKLwTMvkcnLjUYpEvF9819egJzyrO/CV1FRGTv
	Ci3IF6fzV/cNPLAMG/O9dqt3mLR1Ojy3wHA25Bzm8a3siCSOoJWZ8wuUj8qs44QVVfCcIVu6Ffm
	R6YUIqb6q4RYVUDtRorxB0av+xXzQB7yitEJYXE+0bTWmLtA+Yh+bpo14bmGyE/U5zv+1oTZl8y
	noyLMOWP3ctndew7rmWCZ6ZZAsU4KZ2jb4a3a8OsDdyj2XW0feyQVDol+tZbT5eaD4xt4fhQJoT
	ACblvrbnw0/jzw6k4pwFmTEI7azxO17Swyr24Zwt/9YePDnjKpdkBzcLPQsPj1vB+cjbC5ikhoj
	cClnKIYtt6iqYOE/4Dn4+mrR64XZbhacsAyDbj6Em6in3x2MQxIPncYXttj4ZJF/VYOl7aEqxQ9
	w=
X-Google-Smtp-Source: AGHT+IHDS3A8pXlI+xOx72GoRTOq1E/nxmRQrFx2InRcqIyyMLoPJFpVA039XzbqYUYjEi5dGijE8Q==
X-Received: by 2002:a05:6512:3a8f:b0:594:2f1a:6ff0 with SMTP id 2adb3069b0e04-5945f1653c4mr2154809e87.9.1762766128299;
        Mon, 10 Nov 2025 01:15:28 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b76f4sm3852006e87.73.2025.11.10.01.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:15:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: [PATCH v3 4/7 RESEND] dt-bindings: display: panel: document Samsung LTL106AL01 simple panel
Date: Mon, 10 Nov 2025 11:14:34 +0200
Message-ID: <20251110091440.5251-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110091440.5251-1-clamor95@gmail.com>
References: <20251110091440.5251-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Samsung LTL106AL01 simple LVDS panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 4a5ca013d0db..adb244460a09 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -274,6 +274,8 @@ properties:
       - rocktech,rk043fn48h
         # Samsung Electronics 10.1" WXGA (1280x800) TFT LCD panel
       - samsung,ltl101al01
+        # Samsung Electronics 10.6" FWXGA (1366x768) TFT LCD panel
+      - samsung,ltl106al01
         # Samsung Electronics 10.1" WSVGA TFT LCD panel
       - samsung,ltn101nt05
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
-- 
2.48.1


