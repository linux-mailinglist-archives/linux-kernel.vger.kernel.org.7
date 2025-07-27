Return-Path: <linux-kernel+bounces-747186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1DB130CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51A43B6C34
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109E21CC62;
	Sun, 27 Jul 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUMlALRB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8014A82;
	Sun, 27 Jul 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635533; cv=none; b=s9t38n4ghWXUCQP29JDrqJw3/RzfvsXP8TshWLpFU5WLNl9z/bQFEXulpfeVoCxQOrRompuswPsiXWzkZQnzpkfDicdYHaLtesVuY0uuPwn4B57jbWQIpXhzazTUJUfrvK8Q0obzYFNJd5BymcLpEteAWgMZCRzl+AjzRBd4Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635533; c=relaxed/simple;
	bh=EGTeQyYIo2lBMr1EcoM/VsZojTJKAE2dgjoKuB9ysAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNxdXq6cgn3kdZfZSyBApAc+CNWoUJiv3wACmEgq1nrnypQ4soORiSTBxpdXFhL3Vvy15o67CMbU6/qg4hTpAvRmuWhnw9Lu8imRScHGHwT/+GdfJSxEQdxaqBeylx2cJlLMEaE7+t3nlb5mNk1vM+U0kn9mFbt8lAO7/4QoNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUMlALRB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d3f72391so35342175e9.3;
        Sun, 27 Jul 2025 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753635530; x=1754240330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4E2OevupfQKVl0lcYB+7nYiiBvTadH7JVYN6RBSvCk=;
        b=NUMlALRBWxpxs9dL/m1glKkvOCfbppc6QY0fM74L3SA3cyOtPQDluHzGhOhDluGGy3
         6NGnJC7Y16Rumj8QaABuRGXYgURU+nN8cdR5Cl07PYYz8lzg8P7HwwVS6FztK97tll49
         rAjSgm9MRCom3Mn+VWWEpLIfrQtHNRtEp809Uq2KAJqKDkJIkzh4hc2QJRu+EHUIudZG
         3KbE6wc9Nq7kEPv22lqWjcB6AVgEiqbUxbfRLCrhd6KKfFHkr8WykszcZodvj5BvWhjM
         bGmGNXpqyIRdY3DY0dC99q/Ai1+aJWhKdIAkjFNLm4qoxMw0JELrKyfOhOw2skKLajp0
         XQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753635530; x=1754240330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4E2OevupfQKVl0lcYB+7nYiiBvTadH7JVYN6RBSvCk=;
        b=LYk5VE9COtyj+6h/5qrZ6qFQ/JjNF4Y8ry12oYLzQVYmgbC+WWXPK2hPSUANdyMtBJ
         ciZPM1GBZqdK+4ka7FJ8pV4iMjpZF72ijYHsxTA/QIjbP0byOabQvLoHmFh4JIIIEXhO
         x66dqQBa6XW22JrU3ZI6MspomnK+WFEPdWJwB+oZxgl5u0SB9GnR6zXl6rjpzdQQFYRK
         zzwVi13tEFg1jKZV3E6jkSe53U8kRzopH21WmQbA5niE/SoA3kjbECsCpX5ICerswNOH
         MIBYS9NrX1GOPWD5M34l18hIGy6dfrE94s5xfl8B+7SMcWhsi3DkOJdaSdVbYcoRvuuz
         V/8w==
X-Forwarded-Encrypted: i=1; AJvYcCUH1UYTu/S03GwGBshM8hIzq+zRQuuATvwhL/QTUitTAgJTZp/oq41NvE3bApYQe2n2jl1OX5P26biC@vger.kernel.org, AJvYcCWfmWctLu+Er15Hn2WVj/w8SejoOMklVO6RjpNZWv/Y/VExy4Agd9bfd3WiFBW81jRdyiC1OqEMLxd43pon@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YRsnHVzEM82IraBjDMVXbXra9Gb2b29w27IN/Awfpyb6kN45
	hjt5krSuj1zqghctJYj/SDobKvVF1Lsza509rOoecUczd44Z15p7Ivs=
X-Gm-Gg: ASbGncvT3EIfE5ebcDlrFDFR4KIpjajz7ncitMRdDbm7KsfeGHLV0eDZgxhBGxyAQ1n
	OQWRMgdKKAT5TdBXpOcRiHl52dTnLndw1r1fl6EsrRHGarZejUHQD/NOKO7EJde5hOWcmkpWe38
	bXFWoN+KuIMRWxKSI5tHB45SPUnaezYjineXL3BU+yadqzl3LzVEYTXiE7dcc/mq4AJNSVWT16X
	P2sD6lHTjJa5F0J8eKObdEwP9FnhqVcc1t9JzBeKRSpjjMfjKdF2L7rA0B/JfcyQjXrCU1Mg2yj
	+MZd078xDGvgdVp3b/1UiqDamCnwmXnrXIQ8fIyET8lY6NigPoZyGsjMrA+h/Zi2QY7BaOX+UEJ
	ehiKZskyKB3oDddw3yC3q4pbiC40Agn6kvyhW9Wsv
X-Google-Smtp-Source: AGHT+IH2MnqPI8ynh24vurJeF9f1csP4RuAkH1s2rFXLB9nATvHESor2pnIPxjgIKcm+9XP/1kSjUA==
X-Received: by 2002:a05:600c:64ca:b0:456:11cb:b9c7 with SMTP id 5b1f17b1804b1-458786424f8mr67554035e9.25.1753635530016;
        Sun, 27 Jul 2025 09:58:50 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458704aaf20sm128545745e9.0.2025.07.27.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:58:49 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v1 0/3] Add panels used by Asus Zenbook A14
Date: Sun, 27 Jul 2025 18:50:23 +0200
Message-ID: <20250727165846.38186-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add x3 panels used by the abovementined device. The laptop comes in
two variants:

* UX3407RA, higher end, FHD+ OLED or WOXGA+ OLED panel
* UX3407QA, lower end, FHD+ OLED or FHD+ LCD panels

At last all three variants were succeffully tested. Device-tree change
to take advantage of Samsung driver for OLED panels [1] will come later
via separate series once this one lands to linux-next.

[1] https://github.com/alexVinarskis/linux-x1e80100-zenbook-a14/blob/master/0007-arm64-dts-qcom-Rework-X1-based-Asus-Zenbook-A14-s-di.patch

Aleksandrs Vinarskis (3):
  dt-bindings: display: panel: samsung,atna40cu11: document ATNA40CU11
  dt-bindings: display: panel: samsung,atna40ct06: document ATNA40CT06
  drm/panel-edp: Add BOE NV140WUM-N64

 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml | 4 ++++
 drivers/gpu/drm/panel/panel-edp.c                             | 1 +
 2 files changed, 5 insertions(+)

-- 
2.48.1


