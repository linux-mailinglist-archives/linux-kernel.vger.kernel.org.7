Return-Path: <linux-kernel+bounces-836393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFABA990B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465A817D273
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44F30CDAE;
	Mon, 29 Sep 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG3qBCye"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BF30C34D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155929; cv=none; b=sJA7xKwXk5mcO4D+CyogYb7ulpsu5cNRFRlZmhvBAbkiyecRrYSIObdMfkcOvOVgeE0FcXMntF4RzjzsJeaXoe85tdlW0pfNUArQoyEDXCfbi1UG5G+bK+SGGRVaZ5Rl24seyBEVnelKda9tjIoz3XdZS/q0HlFdxcoAeoP/fNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155929; c=relaxed/simple;
	bh=9vZlTXASj0vXVJmJhzIUVkh9Z6pFkT6GG3bTu8l+BvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdLbbiUxQwbvXel3+hltqUQotCsnQU20mmldK3nNVdT8hzRVVg5ex0ftDaxmCyqDp6+LzZlU0RBXOkvj5m1s1M/+TXc6j+C6R5OZQhT9wKjufi4+5e2qsLD2+DL9eXxYh0w4fNjD9mS7GjgNW/h4SWyzeIoaFoR7gSjrkVeJMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG3qBCye; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3717780ea70so33122101fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155926; x=1759760726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sJS/3auvarpuuSF9ICFMHK8CoOId00igm+ctuXL+w4=;
        b=mG3qBCyeS3UHE2OwfEFb/gQeB3YpbZgL2xcV9mz9kako92tjQkuLNulmFPPoS56vqv
         5dnW3OP8hIsMwRBRBxanr7ym/TeXM0IQqB86UgAMV3ZjWf2ll3oBy0zfwwQ2h4FFc/Gz
         a3lsQS0oqLmWK8MNNNorVPK+/Mvjz6seo8jqiAQxxn3+YE8KM6xsjEigxbAIvhpWmqdo
         hbYOfWV1Dfbf4HRz8TQgI9u/WL/fsiMzyPnyN1Ux2W8wMc6SCmcc9SNd2VQOGDG2VSJ+
         a1SDtBw5dT1E89MR+NyG0AS3lgPIHmitesfFUudMCL2sM/ycRa7kVGEeSnhMjaYIGwrG
         BFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155926; x=1759760726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sJS/3auvarpuuSF9ICFMHK8CoOId00igm+ctuXL+w4=;
        b=W6Cw/5E7oUbbe43wgtUweZGyTKEOmTbkoxnO/+cE/4+W2ghonvASBd2bgBIm9tBrsK
         XL8wcKQqBqzZn5MKFuGBj/xhvJ+fJzBckaKT21eswEhZH9mKUbzCeLyQSrXEf8nBZq3p
         adWyb+7bW9oZXZo8P11bRk6fjcMMXxyPDN/qsh5HTqGZhxswBDkWa25oI1rgGfePiPzs
         oJSIUuz0Yvuu5c/DIiOexDdJzgCmBXR85jR/WB6zImEUe9sYTc6vJMFgJRn8kjKnBznM
         Bz5Duf/hncKL1EJ/rmy7Nlw1kJiPcfyPwYLQa7YTbu8n3fbdFWuqJ2nOnCiVHo0hKjSX
         zXmw==
X-Forwarded-Encrypted: i=1; AJvYcCWHIPLSyYLFpFyJ7HZOCIgzDz5vOM7T5O2DFngSFMlHoFAeHRa06ZWFF2JJLSFHGWYmT9e8JOgk5U8uOJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0liduPZ7MwiqlRzCATkEOz+bULgAfnfppMLDQ0TJFKArJXLu7
	Ef+orGXhqpf/00Uhf2qvnkKPzB0Gi1pOvYdGOs5suRy9WYmzq43dXDvH
X-Gm-Gg: ASbGnctmURa5LHy4Mo/wolxyu9OVFvImtz9HrYm6VP1cmd6J6WYutYOY7vV7wJl7IOg
	hZiJ/+xHB9srdYU6AStGj//WIcPIe1J6dqLy/Fk/0IhVDX8jPJyuE+YLJwOAeMypLdEPlPoBAC+
	+SLCdKiRwSY20QtLjw2viqvfQUeUGpCHU2R5sf6EdcMFO6QB+dDYk4tl8RDzsm0XIV+D+w++X0S
	UNClFVDHsfmgJoqWeF+Lpn32LaQtiNECi3ylv9BHQpaWTRBXmYFGIyWfOVkhD0GfdSDJBJh3PJG
	X8YmWALaJHXcXGzPPmZ8prkw+5vqLuJaCby9/nFzmoRd3s6qp3skRvEkcuXKUvF5lh4HjXZsw8k
	7uEr3+MavHV7lx1M05OY1Qv8K
X-Google-Smtp-Source: AGHT+IFs82V2KEASR9Gz909OBVFnhk5qy5a5uIoHbA3f3Al4eEo2M3QlGsWCwe13fMV/nwp2V7oEIQ==
X-Received: by 2002:a05:651c:4419:10b0:372:8ada:bf8a with SMTP id 38308e7fff4ca-3728adac271mr18360531fa.35.1759155925644;
        Mon, 29 Sep 2025 07:25:25 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3728c23e6c1sm13201001fa.52.2025.09.29.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:25:25 -0700 (PDT)
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
Subject: [PATCH v1 6/8] dt-bindings: display: panel: document Samsung LTL106HL02 MIPI DSI panel
Date: Mon, 29 Sep 2025 17:24:52 +0300
Message-ID: <20250929142455.24883-7-clamor95@gmail.com>
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

Samsung LTL106HL02 is a simple DSI which requires only a power supply and
an optional reset gpio.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index f9f1e76a810c..01ac0af0e299 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -52,6 +52,8 @@ properties:
       - panasonic,vvx10f004b00
         # Panasonic 10" WUXGA TFT LCD panel
       - panasonic,vvx10f034n00
+        # Samsung ltl106hl02 10.6" Full HD TFT LCD panel
+      - samsung,ltl106hl02-001
         # Samsung s6e3fa7 1080x2220 based AMS559NK06 AMOLED panel
       - samsung,s6e3fa7-ams559nk06
         # Samsung s6e3fc2x01 1080x2340 AMOLED panel
-- 
2.48.1


