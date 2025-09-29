Return-Path: <linux-kernel+bounces-836387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CBBA98CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F4418969EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241D0306D5E;
	Mon, 29 Sep 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jguj4Su+"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81F2F9D92
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155922; cv=none; b=KR0G71IBXqKqbHBYjbNpdetkzZUnyHfDAtgv/EkbYymmlWZTO/yelJAVs9qdPY0XRoHQz2w6FMl6ahpiWNj9yxEJ7WEcEAVWroMdtBLnfO+45ysmfJlWRbSRWr42qRKLQme5iQp8EU6/YrBi0STVhuC2KS+7MOPdODE4mhBOHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155922; c=relaxed/simple;
	bh=K85rkuCudYsXP5pYW/dzKbInwqXPQwsVrWQ5iHSeRC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wj6azpi83XPQEiSkJOfbqU7wkWv5J+m/GO93ufrEPyicPSoJP8+od0rzR7uzPXkO+Pb+j4Y0vt5CQoliJKarhN3/80K/2MrdbGjGY3GCtCufckNeeiq+hNQiB9dHAJlfNIMu32/RYQMl/cFL6TH8S7NVGxFN13SMllVwdNouWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jguj4Su+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3652d7800a8so37294281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155919; x=1759760719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DPPg9TIoZPnzthQd8E1VwdjwIEaEjaVDMMssW2mg+cY=;
        b=jguj4Su+0loOcNAxNNxH55BAURnQfg2SYpHWQNmmQkSF0DVfime/13OeHnO7IWK5GP
         4CWHbvDOwHLKk5ZfpTkQ8rrLJUat2Y4PRZZSPbm8739wIAbWD8KgAiLns96yYFtuBcTj
         +H3l6deLYG5MTMzy8wJkeYPzJFCc+4Jumk2r0boyTpTkX+tWyzBmj8vQsIMJqMIgNyxW
         nlumtuDXW6Zupae6ugyBlfQ5vc74x9IKxVv02sxaITPBAh1UsYZVgsXSK+wHyn9QZcGj
         laXn3e+7WwJWrW7K47NwUSm0FiMMYI0H0BqhHCXkEQs7fyhYd2uKoAlUnqQ2eZCMSlgu
         Uspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155919; x=1759760719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPPg9TIoZPnzthQd8E1VwdjwIEaEjaVDMMssW2mg+cY=;
        b=HJixtFGJUY7qamXPsTx+sJPQzQK40eP4XDqz0jdTTfexhaQi9MAHa3qjizpHzSyelA
         uUelPTBoMj1NV0w5HIJRZJAOd/e4ACKHmhggjaDbbmkMq5gC+bZQswDxJ7wps4isL6n3
         +YUetEvCL5IeON+morYoDEdx/S6qAX3jcBq0l5gBl6UqtpH1D77Dnc93aYoiQSwXna1F
         kVYxVZ9oLpUry3hB5WxF4EbMYYcSPY7NtWdZV0kTQ4XBOOV30wUIVrWXrPhgk4CGdeJG
         A+FKS3oK5V1oSKRgra+ddB/96HMj+ExUq3M+dAIcMTLfmiWSJRnDXKZ+cXC1FKscNi+a
         pYGw==
X-Forwarded-Encrypted: i=1; AJvYcCVvAIz8KAdLBmmLNUhtK/w4Um1GnoDAoHdkBPFuTQIxx6p6vP9O1wG7WnnzR3xuKVmvPY338nSqsQWJsyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4HhJhbL9B7Fln7BsMTa7HQ4SF9RBD5CV3/tVU6iDBwkZz+NJ
	6ho9jbcrhYc45wxo9EUeBqeLk/5ZlA4/3MU865RZC+aXsge/QlpJbKCi
X-Gm-Gg: ASbGnctIJLQ+i8acTD1IGqbJS0I/z/qzxGAB9yzDp87i80vsOJVKrQh2VJjcz0Kk5I5
	IfCpklywbTSeawSS1dyjHw9JDmF1LmmjSLb9yheIwJqT79Yp/g44SNzu4aJN8PrpfinDXqKpxcR
	XVrH24e9KpZhh3az4+C7Ytf+jDQAE+eYWvjUbrUAou0HenSV4ly5p4MKZUU315DGGOgNq+tIG9e
	FPvHOfottGbhue8P1F6Nu5qpCdvPHtUdhf8c/89QmZsznrmtRRVSSAjnfDQtbeS+UoqGXwCUURY
	jBLRGE+UWE9FbCZrZsQpwn5cclSJq1JhXsdSfuj0+YJ5ZbOvs2x8CMRREqHtTXSGkP8Cs+5tkaM
	KgcVfJ31XPuAy7NYwats4HPSNAn89lBgXCb8=
X-Google-Smtp-Source: AGHT+IHxDGpQBwuQkWcBRlcxN2mP+i2I0/l8+XNF8RRMmqOhDyFCD+mEDRiLnbhKmmlYr8NSnFokUA==
X-Received: by 2002:a05:651c:1986:b0:36d:755f:a6d8 with SMTP id 38308e7fff4ca-36f7d2cb85cmr46262991fa.14.1759155918449;
        Mon, 29 Sep 2025 07:25:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3728c23e6c1sm13201001fa.52.2025.09.29.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:25:17 -0700 (PDT)
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
Subject: [PATCH v1 0/8] Add support for panels found in various Tegra devices
Date: Mon, 29 Sep 2025 17:24:46 +0300
Message-ID: <20250929142455.24883-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for panels found in various Tegra30 and Tegra114 devices,
including panels in Tegra Note 7, Surface RT, Surface 2 and Ideapad
Yoga 11 T30.

Anton Bambura (1):
  gpu/drm: panel: add Samsung LTL106HL02 MIPI DSI panel driver

Svyatoslav Ryhel (7):
  dt-bindings: display: panel: properly document LG LD070WX3 panel
  gpu/drm: panel: add support for LG LD070WX3-SL01 MIPI DSI panel
  ARM: tn7: adjust panel node
  dt-bindings: display: panel: document Samsung LTL106AL01 simple panel
  gpu/drm: panel: simple-panel: add Samsung LTL106AL01 LVDS panel
    support
  dt-bindings: display: panel: document Samsung LTL106HL02 MIPI DSI
    panel
  gpu/drm: panel-edp: add AUO B116XAN02.0 panel entry

 .../bindings/display/panel/lg,ld070wx3.yaml   |  60 ++++++
 .../display/panel/panel-simple-dsi.yaml       |   4 +-
 .../bindings/display/panel/panel-simple.yaml  |   2 +
 arch/arm/boot/dts/nvidia/tegra114-tn7.dts     |  13 +-
 drivers/gpu/drm/panel/Kconfig                 |  26 +++
 drivers/gpu/drm/panel/Makefile                |   2 +
 drivers/gpu/drm/panel/panel-edp.c             |   1 +
 drivers/gpu/drm/panel/panel-lg-ld070wx3.c     | 182 ++++++++++++++++++
 .../gpu/drm/panel/panel-samsung-ltl106hl02.c  | 179 +++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  65 ++++---
 10 files changed, 495 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-lg-ld070wx3.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c

-- 
2.48.1


