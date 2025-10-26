Return-Path: <linux-kernel+bounces-870680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5DDC0B70B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572583B8285
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E5301005;
	Sun, 26 Oct 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8rRVLUl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407A3002B5
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520702; cv=none; b=PxZxq9fLM/TD9yNFzGm8ui2xasQG7HN9hAp78kFadXxOhocd6syRk4CJ4Ss0w3z7yepcdN42Q73aZ274VBEw6AqSP6U4JEt/0IAX2MnhLDJCWYM2JirodMujpEE3z9eQOUbXudgwDrFHqHQsV52HR+MfpqVTF+hbVN5okoai1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520702; c=relaxed/simple;
	bh=JHsEeE3pg+pk93bhI32FeDi8yrKJtA+0+klnpUJJiVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOSymurBiOuYGTMX261o7M2+gt0yyL0rdTwc5gGzlfQe0hJk6EFNjinheHZ1Xxtu/A10KsAknSxZT3Mxnne1r6J5EzOmMu1I7vTgYs+7Xpgg5Zb/shltOs3+UYRV4IRE03nUQG/yji0o3YrLDjJiPfYfoYGSCVUbJliV2+NwvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8rRVLUl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso8771983a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761520699; x=1762125499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DocXilQpznXlXdgq/uQ2JTbyqpF07pq6DJZ7s3t7nQ=;
        b=K8rRVLUlwfko0Ie6r4lXMPmpm8sabUXHMyr+9AahR+tAW1+FtXWD9PLmi3PaeA83/v
         DKEMI5q+rMGgtyzpmbtFDlNKsscusm8V7xXcbNLPXUHR+1L9CxZB8MlEQyCN5ivE9Re/
         /up75cwZOLQsmniAmBOvQoDLzfTTHSJ+ri9jcNxPh/yFKQpihljsN3tZ5+5RxY9SUbKR
         FWYrFMU9wjKQ6yRBGFmSLhKAO2OfsqlD4NHegxjoqSu3gsW1fJ5AKvhgYH1R2tCQqn75
         CLCXtJn/NJEmuAs12unqTkbtNzzbMbTVlFSh4SIHNeM9rLum9Vd5dRgxu6CekCAb5MAf
         nQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520699; x=1762125499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DocXilQpznXlXdgq/uQ2JTbyqpF07pq6DJZ7s3t7nQ=;
        b=aIcYP/WRPnzSmtdUN4mP/0Ve4X6e7PBHXGuXgf9KlWx3LPAwrDKEhQJQdJZKEstxkB
         xuwHy+sZkdMgUINeR9343I3/T7De8Ze2SG2sk1DMn9c+S0iNi6VtVGE/EdRZHaujjzQ/
         ubcxMJGEAr7dZAYe7S5rf6MmwFdh3LBREimyC9Uw16Jq60ZT/dgttCL28ODqkVrAtJQk
         RRk29tjKNAzlt0kFzXiVxM0+PQMo5yO2JAJD2U5POASxyHwukQCz10O8AbGRyXNMDBKY
         BBKX3F7WwUyb8mmpWxgi8kmiOK6/f8DQlqQglluM7JatfSY5KVN+k9M4WswOAmPP2+bb
         ow4A==
X-Forwarded-Encrypted: i=1; AJvYcCUvpLsT3KymjwCkBKBhma/KnagsFqQwEjTGEvvurr+nf811l7JY6JCuhnOD+3Kwbqj2hlfCngp7JceHkQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlSJpgMaVIytfR11ysGztDqH1S9SvwihlY8g75cOI8mBodD51
	b8En94Mh+zRg1aEz5RyBap11D1G6hpi9DEbyh9m5mppfu1pBT922w9et
X-Gm-Gg: ASbGnct92DTgSv1czzthFDi4PcZhEh2bYiq104w4CcQFHL12gBDOR205UA4VQteuhku
	n/Fmf4KWGDljyWko1Cw6Zx73NxyFUwvA1jMOyeXQox5o4EVKC/ge3To9W/QncS8OENAkRUBmXa+
	NBuFOI/gZrk6lLO66ZbUD3dxzg+9i+9/isPFF+rk5ySCeHCyKWaWMmAeTclJf/22TX3iySGZK/e
	xPH2bBDguwhNI8kR6LSebwYnhWzJsesQuzcgBT6sgf+6QFKGj8WTPVa1d4xRyjPSsYr8h2mtCTM
	PEKtxdwMDyJtCJ2fJRKArzRacHeYC+J5ER/BTIfl38TwFMcX1o02b3wawMWkgyuOf9Y2MnK6pTZ
	WI5/j7OaLPYcHtkzAGIwfyVU09cEGbh3BcNyj3EZf43eOyIojSAxEErbg3ZKtmJ0bGYRobe9DPp
	ANOwM=
X-Google-Smtp-Source: AGHT+IHmSbbl2y8sC1EHLXiOU46A1OkkBC+CvSb7Cdnfsyi6aRrsfPGnDWUyfaHNDA19Cl6oaDIzyg==
X-Received: by 2002:a05:6402:210a:b0:615:6a10:f048 with SMTP id 4fb4d7f45d1cf-63e3e597e23mr12696707a12.33.1761520698712;
        Sun, 26 Oct 2025 16:18:18 -0700 (PDT)
Received: from builder.. ([2001:9e8:f109:5716:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82865sm4847379a12.9.2025.10.26.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 16:18:18 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v2 0/2] add gpio-line-mux
Date: Sun, 26 Oct 2025 23:17:52 +0000
Message-ID: <20251026231754.2368904-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposes a new type of virtual GPIO controller and corresponding
driver to provide a 1-to-many mapping between virtual GPIOs and a single
real GPIO in combination with a multiplexer. Existing drivers apparently
do not serve the purpose for what I need.

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
gpio-line-mux-states property.

This virtual gpio-controller can then be referenced in the '-gpio'
properties of the SFP node (or other nodes depending on the usecase) as
usual and do not require any modification to the SFP core/driver.

---
Changelog:

v2: - as requested by Linus:
      - renamed from 'gpio-split' to 'gpio-line-mux'
      - added better description and examples to DT bindings
    - simplified driver
    - added missing parts to DT bindings
    - dropped RFC tag
    - renamed patchset

Link to v1 (in case it isn't linked properly due to changed title):
https://lore.kernel.org/linux-gpio/20251009223501.570949-1-jelonek.jonas@gmail.com/

---
Jonas Jelonek (2):
  dt-bindings: gpio: add gpio-line-mux controller
  gpio: add gpio-line-mux driver

 .../bindings/gpio/gpio-line-mux.yaml          | 108 ++++++++++
 .../devicetree/bindings/mux/gpio-mux.yaml     |  30 +++
 MAINTAINERS                                   |   6 +
 drivers/gpio/Kconfig                          |  10 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-line-mux.c                  | 194 ++++++++++++++++++
 6 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
 create mode 100644 drivers/gpio/gpio-line-mux.c


base-commit: 897396b418d1720aac39585b208aada708b5b433
-- 
2.48.1


