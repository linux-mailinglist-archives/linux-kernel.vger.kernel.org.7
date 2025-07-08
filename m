Return-Path: <linux-kernel+bounces-720971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17484AFC2C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D31AA795C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B176221265;
	Tue,  8 Jul 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZL0nOi/"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA08202F9F;
	Tue,  8 Jul 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956251; cv=none; b=fn/sCCaaGSs5nxrEoyqM8bZfEjYLkqb6kIidgigYWpd0uEw0vdt4Z4uK2s4KYGrVadh0AhGZUZ8MV92y6B5WBp/vvwe32lFkmhosnBeSKo2mzaYUEeFIfshUE8tKQcXhwcby1k0WZHywnOAKvxcSoZDrdrb+ckA6YydQR4P8a2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956251; c=relaxed/simple;
	bh=1Zka75bNEvXEduKJP6vEIX1BbDz+ii0kbMA+uIdNB/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhZU0/wsgioJKN7PF0pFK7KdJixPEVoWaRAGu/ZsRFtevWP9+ESqlLOT6J1z1XQW1yzn3N8aaFuh0oAgtu3dTmIEGB8E5wWozz5tOGdtrXE7wsG6yU7SKcKZBRLNCKwog2+8uENI65McC+hN0FP610aHUYIA2k4u3ZEZG2r6RJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZL0nOi/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2102405b3a.2;
        Mon, 07 Jul 2025 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956249; x=1752561049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTSaPd2KsxbQLmtDO+kQIyiudpoUlJNATnX1VXPLxSg=;
        b=TZL0nOi/RTbusbKLj+B0crkDalFYGzKynSqV9lPdNZMLH8oKtsF9u9Gpl9igAOGnsW
         4M7XqUOxSC7q+MWaCbP7RtmIx46J7WZyuhEbujGb7uVGCIY4/RK74xR1NeSY26BjrnFx
         lhCaQ1waOp01Om56rjN2S8aLZtWqPDJ9KCey4hn1RemIJVuwipC5oR418JLycJEig/9o
         Xm5hi0d9RaaX/v2eQ/leFxkjehAzmw6Refg/I39Yu1H3ICjQKWMQZJtoRiY5ApjG71QY
         fYs+qGjO+eOOBxx1ya5x8O+SAn14FNh4aq1et2VbdsUOhDpmpM+VGZtdgmXVtx1ybINv
         MJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956249; x=1752561049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTSaPd2KsxbQLmtDO+kQIyiudpoUlJNATnX1VXPLxSg=;
        b=IdXH++FianoSbCEJUi3UBPaqHUEtdFVNa8V2SghA6AGL/gvYzKhXVn78lo/7eBnU+k
         ZHVZh4O9tabpIdyQvwJtZ5y+N/bbKmo2b5OGhN08Wmf5UPbrV4NwmF08tqU6Zvej+SJG
         dUNF3LzxYKCAQ62GvtnPIAnT6Lq+Yr/AzGtJNqNk+9BatvBVjuIJKE8Pa+RQsH9f7X36
         LagaRHjpgj1kf5PghHDLyZ/8wJJr36K+fIQZ1bVWQjHzJYiYvwqomZYPNBFru2ogX1la
         Ma9MbnXuXOg8kU43cbJPBfkHRp/w1Qyve7wXVfU7u3FFhWCiOq1Lc+O8JWMkrzaKIer5
         eAow==
X-Forwarded-Encrypted: i=1; AJvYcCVIztFKF/CszElK8+yjoxzxJmg78plUWFnwch0gOv+CRhA3zdFqRoBfrBV8kr8BSoT7wdgBwb/wpZHA@vger.kernel.org, AJvYcCVMogHvnpNlZTrmAt2FFY6ErGkOnJjHmm7Dn/5TAOaTiLE6aQ0fN0+w7ImZZF30dYjJbv0w+vMzi4H1rgbe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuh2DSjPOw7VqGnnH4ljDeRQWOxO5y8ieD9IGCfk3jkUBPLX/K
	kph31HABW2wPXQ5mc3l7N2pHZTlxfJV6GbpPh0iQ/x3c6B/HYPPqZook
X-Gm-Gg: ASbGncvomskT1w5x1CACP7MfIXeTvzdP0xREk4KPlvWmm1A3SLoYUAznOm7J0T5wgBH
	2R6yPwhGMsdVKZxQyyPFzNB7dHR+8Dfq4H5K+/rLg4SsR3TnhkJHE36KcSaB/LfMR4PyJFFEWTt
	dNSrf/qSgT87u6yXKPu3f257Kdz+wHVeY/VUNs2Oj/ZXHSChnlmwM1NbB7FlT0hMKbjtaar3ZH2
	x+z8bIGZRmZ1oWgL74RHq+ccuxaRZubr3Agh2ZIBBusI+raVP6HJC3R27bqpRVgN382g5znoXHu
	qNady1V4i5hWF+i9cnyeEASc0oCBEAwOuWolWygC+J/HP1476UQrYYvyf0vr5nGt8BfDmkJH
X-Google-Smtp-Source: AGHT+IF2gopwxM64FAD0FZDnw1lPgQORZkvtpUYpoRgRuNfklUmt4fK4rmjd5HBaL3Snj8yAGWBBoA==
X-Received: by 2002:a05:6a00:3cd6:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-74ce8acd777mr21400752b3a.20.1751956249103;
        Mon, 07 Jul 2025 23:30:49 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce42cc925sm9765276b3a.152.2025.07.07.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:30:48 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 0/2] riscv: sophgo: add USB phy support for CV18XX series
Date: Tue,  8 Jul 2025 14:30:35 +0800
Message-ID: <20250708063038.497473-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB PHY support for CV18XX/SG200X series

Changed from v4:
- https://lore.kernel.org/all/20250611081804.1196397-1-inochiama@gmail.com
1. patch 1: apply Conor's tag
2. patch 2: remove dr_mode debugfs entry.
3. patch 2: simplify the cv1800_usb_phy_set_clock function

Changed from v3:
- https://lore.kernel.org/all/IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com/
1. patch 1: remove vbus-gpio, switch-gpio and dr_mode properties.
2. patch 2: remove all logic related to the bindings change.
3. remove the syscon header file.

Changed from v2:
1. add item description for switch gpios.

Changed from v1:
1. remove dr_mode property and use default mode instead.
2. improve the description of `vbus_det-gpios` and `sophgo,switch-gpios`

Inochi Amaoto (2):
  dt-bindings: phy: Add Sophgo CV1800 USB phy
  phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X

 .../bindings/phy/sophgo,cv1800b-usb2-phy.yaml |  54 ++++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/sophgo/Kconfig                    |  19 ++
 drivers/phy/sophgo/Makefile                   |   2 +
 drivers/phy/sophgo/phy-cv1800-usb2.c          | 170 ++++++++++++++++++
 6 files changed, 247 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800b-usb2-phy.yaml
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb2.c

--
2.50.0


