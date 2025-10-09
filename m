Return-Path: <linux-kernel+bounces-847529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F76BCB1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA723A881D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6B286D66;
	Thu,  9 Oct 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q40beSaX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C0280A56
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049322; cv=none; b=dcDlA1ERuILX8xdGs6cRvh1GkhbJw0urCPc0Wsf4fDJy36+7s9Q6gyHgthjEXJBmXC5tIr11ABlARP757Ia1Gji/+Zr3h59qzNsUrsR2Ez2765dZaKHz46YED6wjikxM5r0+mjscWD1Yob661ejb4VbcX9PFMHnO3rq59UVUu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049322; c=relaxed/simple;
	bh=cxpNA5DjQamcNftEvxB6pspok56jCqqNj0uUfOooVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfYLWJ2NSrgrC61Fl3DxGXDEtnYNbJRrrt/AtBsYqBBaNjpLYs/TDSHY9+OrWZ8S18Jimye4MxfTvp7Xjdx+XpfZhrg6NW6WH187gNS1gwOGRm4JtOSIBwdNnhxozoT72eTkty4nDAsevFKtJrBBIi96nbg5s3bGwsivv0XG4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q40beSaX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b463f986f80so330420966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049318; x=1760654118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWTu8TQiZuRHgB1GXUGo29TcN0XiMZ7bJ/R8fZdV4D0=;
        b=Q40beSaXsjflZrKuB2jr87ylPDSrrzVSzNtuHGZJxEs7Q4+nblSjgd2TphVgHP0Moz
         f+CAXf72l+qa9tECGhzCFdUH0zFIzbNtfuvy1DyEIga+BKAe2Lv67xReOj+2lhboZB8Y
         W7wbku0N4QXU/Lc1HAYdXp4mjLXLCoUBbT+TdYwRGxVi/nGanKpEd6eVZc4cwBIAIyD2
         TWDDz0+jVtl6zVbfxnZAvjACd2cHs7VvobV3NhgQCyrudRDf/WFu0yYUjk+uNZG/0Igx
         pkGlGgmTWKWt0YcgSM/KXvAJh9wyI+KMmcP86AOOupWm3XOdKEDcDgRkx1fpXXssgka1
         oB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049318; x=1760654118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWTu8TQiZuRHgB1GXUGo29TcN0XiMZ7bJ/R8fZdV4D0=;
        b=eih4DapOgh8lbX+Q9/tcBI4KDbhIZYbOSSnSm+fvMes4ysboXLcSdMuxjcAYDXN5iE
         BKAPirx487VIh15pfvTWvuBl+SbDfQ9De+XKrkmSE0p5pfRuXGPweyRZ8zn1GkDb8ls3
         NjWsAAkIZhUHFs9+d5IDRLJ7ugPt7P83uEx+Qm9cMLuByaZyihNul69TyD/zVr+yusjs
         NdGCcyu4xFXHCHugY/2V2S+Mb01VTutDpj+ggw9Mvz89uL3VYsn9jgswB2TSSuk7lILn
         MMYLzVxJY4EZQklSRGvQ1laYz7aZiSeQSwteedWax5RD4FfDfaZnMESXhkBFyTS2MOLO
         WEoA==
X-Forwarded-Encrypted: i=1; AJvYcCWpU57p9+2W4MOro9RMDQJlb+9DDUAA+Yy5XHsRVzyeNhy0FYtc7rOIjgWDZA9CfyRCCEmii5/28tIkzh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyck7dZZzzFK5CHlaVe8+Pk/qXiNNiHVtvI3Rn8ELuYduX3OkkK
	mFUQ5k9kz+CHpDwjX8H5EJBq8J4/v5SLTxhdO7PcbwsgWCpiRz6WnCb8
X-Gm-Gg: ASbGncv4dpjJ1LXexl+lqS7UFa87oTyrSV1lMIkdfFr6dZ9Eijp5M375TUNXoHDgO3j
	NCEJy1ljilWXyTElQLb18ng4MU1wWhPuv+dt8qnQEqBiFcm01m9Ksw/poR29b0DN/8riylPxiWa
	nLDIO6dRbOFxcCFGTMBGwvtGEbqzOmHWL9K5MJ9VsIpaGhR0bjeKEca2MwurX0y4QsB1NGwFoox
	oq/tsCykb37x2VfwopOPz6fdhh1wh24RFCgSHt6sM1KWkkODQQDVOL3w+rcpEUaPHYzZ3HKvQ6g
	6xgrcb4WrXArByrupLWG7B053dw8YAZx7U0gOPNB8RuNFoaYrmGDnOkd7PD1cmIVHM3DirX24dM
	1DuX9QSLs28cvPl2Wd9wSVOGjN0deL1C7G4ujfFbt/WG51ozQ2A==
X-Google-Smtp-Source: AGHT+IHAbkVf7T0KiGC5vS8hyWfQ+8wkd5YDjN9kv+xf5lsOzv51+LjDmnqyTit4TD5wYPvsNvnZtg==
X-Received: by 2002:a17:907:2da3:b0:b3e:e244:1d8 with SMTP id a640c23a62f3a-b50abaa44c8mr956762566b.34.1760049317698;
        Thu, 09 Oct 2025 15:35:17 -0700 (PDT)
Received: from builder.. ([2001:9e8:f121:c116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad80bsm74383766b.16.2025.10.09.15.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:35:17 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [RFC PATCH v1 0/2] add support for splitting GPIOs
Date: Thu,  9 Oct 2025 22:34:59 +0000
Message-ID: <20251009223501.570949-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hereby I propose a new type of virtual GPIO controller and corresponding
driver for splitting GPIOs using a multiplexer for different usecases.
Existing drivers apparently do not serve the purpose for what I need.

I came across an issue with a switch device from Zyxel which has two
SFP+ cages. Most similar switches either wire up the SFP signals
(RX_LOS, MOD_ABS, TX_FAULT, TX_DISABLE) directly to the SoC (if it has
enough GPIOs) or two a GPIO expander (for which a driver usually
exists). However, Zyxel decided to do it differently in the following
way:
  The signals RX_LOS, MOD_ABS and TX_FAULT share a single GPIO line to
  the SoC. Which one is actually connected to that GPIO line at a time
  is controlled by a separate multiplexer, a GPIO multiplexer in this
  case (which uses two other GPIOs). Only the TX_DISABLE is separate.

The SFP core/driver doesn't seem to support such a usecase for now, for
each signal one needs to specify a separate GPIO like:

  los-gpio = <&gpio0 0 GPIO_ACTIVE_HIGH>;
  mod-def0-gpio = <&gpio0 1 GPIO_ACTIVE_LOW>;
  ...

But for my device, I actually need to directly specify multiplexing
behavior in the SFP node or provide a mux-controller with 'mux-control'.

To fill this gap, I created a dt-schema and a working driver which
exactly does what is needed. It takes a phandle to a mux-controller and
the 'shared' gpio, and provides several virtual GPIOs based on the
children nodes defined for the gpio-split controller, each with a
mux-state which is used on access.

This virtual gpio-controller can then be referenced in the '-gpio'
properties of the SFP node (or other nodes depending on the usecase) as
usual and do not require any modification to the SFP core/driver.

--
Jonas Jelonek (2):
  dt-bindings: gpio: add gpio-split controller
  gpio: add gpio-split driver

 .../devicetree/bindings/gpio/gpio-split.yaml  |  77 +++++++
 MAINTAINERS                                   |   6 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-split.c                     | 210 ++++++++++++++++++
 5 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-split.yaml
 create mode 100644 drivers/gpio/gpio-split.c


base-commit: bc061143637532c08d9fc657eec93fdc2588068e
-- 
2.48.1


