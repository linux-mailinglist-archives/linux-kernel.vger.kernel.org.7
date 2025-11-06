Return-Path: <linux-kernel+bounces-889332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF0C3D4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5FA14E53FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82050354ACA;
	Thu,  6 Nov 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEvelUD2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222253AC39
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459186; cv=none; b=FsPPMPYnzp1r4oKBC4y5XBUxzgHLo6SgGGdND4/4/wBAfORkSS6QH6KVtuSJ8vnQrbHph7b9C7RjV9G8oVKeMABbfZHMfV6fJvH2n4HytQRV0jBWCc8CrYOritQaTynL2g0rfEMvzP1ipI0f9SVlcpt/RAeKpLHCoJwTXlp6Rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459186; c=relaxed/simple;
	bh=t/qaprO29W8nNlhcn2cJ5KDh0nDpS8i3Bz2ryrAj1OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfn9rVGUZZua99s3gyjFtMa4ZiAYPUycEoutKbCyo9Ah7lSc948IFJRhmoF7WnJSEPTAJVXWPCEOpOg6CX7yOLoPw8Mqlsr5iR53uN4wt+zRau1/PyOkAZHUNPp6MUWJwoIbYF6TLmSv0fnJ91icW1kP34+SI5FOIKZDZwXFjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEvelUD2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754b9b050so47585e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459182; x=1763063982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXDqfUWM+p0Z7nN20QoGOJq1S+ZWNbFic52FirlUgMs=;
        b=hEvelUD2fKqsqGWq6zOADkOTob0aRebRw5TIo8LRb0lE36+ehErbdAbtkJFh5/HDHD
         GMycicSqYQGp5kei3Ii7IXLlfWwKjoKgrXglltBY1NKoTMrX3YFfbxmMhnPCuAOUjHjs
         ENGh1L3xU6QfoYWQELW66fIonXpmjSchGExE/X8Izb5AmEaakm2BRpkQwypgO4lrRa9r
         mnLjAsi7wsvQKer9bmvSxmEbJR8Lab5qUzDMANfRCYQR/2CiLpbX0wldplVo6whGCJEz
         pR2xcGSq6aBdH7B+5DoXdyOAvQCVUh7cO1U3Z4Ui2yydift71dz6oMg2oR4Vmvoxt1Pf
         SXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459182; x=1763063982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXDqfUWM+p0Z7nN20QoGOJq1S+ZWNbFic52FirlUgMs=;
        b=nlr/XKBTWfFk6AvH41jEIm8jMV36GkFRu98jDTe0GZsi13UOU1hOrDGJiz7KWPmM9N
         FDd/FZ58+4CFa5I4eRTh2IERyJ/LvJ8Tx6HSFNHS1xHOYxFwCW9o4zkRsCyNL7ZLiIhk
         IoonHi52PFd7P1v0xvH4neKANi04jpIPk8TTCUSXlZA3JSoUrYaoCvIOKdNHMHRbH/5l
         5o4cQJ1TP2O3JlkgAfjco5A9olxKUxwxiunugfJ4xSkINh+xBQywowPu6qs1HT+0RP4E
         gMRvV+b45nN3ylyqCLvIfvFQQEPBE+8zGs0O9U2nhhXiY/1W61q89lr4S3yDHPR1J6y/
         9NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV/KjfdN/vqPgiSfdhS3d9lqH5+Wn4LRLUXGuAvcW0jdFPeICvVyjrnaxPvghTjtQbWb2MYYHqse/NNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADWQPnXpgidKpwIdkl54SAcBgDRFz2uzCXTdJpGUVVLwYzkHD
	F7Yd5vwjkl00Pjo/ub1GIQ5SHByhETl3bDB2MJ2gRYr9kQVhHR/qa9hB
X-Gm-Gg: ASbGnctNaTja72OZz5jw2znL2J6fWNPuNQKqsrC71NNBA/bMEM9KJCfFlym5P4iVGOb
	XThjwqYZhyisJXKun7yWv6+7mZYlqSAIhGk1zljaEgfEnPfwBhxaotvmaZoVrd+snb+a1iYcV8n
	F8B7VEGFv6Tfeq3oM1Vzl6El2AFSEw6q+qkYaC4GKgaM/kt5b9f38h/AQVuqRb9ExYkZH5/i1Gr
	cvYZ3xYe3neBxE5oIkLarCht6TJD+C6xrK9IFSvW9RNxeWLE3jamx9M4Od7m+m9UXLc2YvLMms+
	xFZNWWSPIwI3V+cYtuc3BZzdM/3yytf1seIcHyiZQNAqfoz/QrvHl9wKzihLxrNNI8Ntjw7i7uX
	H3lsMkqEZSnRByyl4DvmXlGELlb3hMfxrlbroTZpNIJPqwA3SQZTCUXep0kZYTw1coEZIeP34dp
	K9sjkybneYdZGZ27AyusgGYT6tqfZgp/FEboTtGzJw
X-Google-Smtp-Source: AGHT+IH2zuNZAuG//FFua+3NFYrMOZHDAhHafYeLf7JfFRe38hh4R4scyQumglGX8PwDG+TuA7G4XQ==
X-Received: by 2002:a05:600c:3b86:b0:477:5c70:e15d with SMTP id 5b1f17b1804b1-4776bc1f08bmr6914605e9.0.1762459182268;
        Thu, 06 Nov 2025 11:59:42 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm990037f8f.5.2025.11.06.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:59:41 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/5] clk: add support for Airoha AN7583 clock
Date: Thu,  6 Nov 2025 20:59:27 +0100
Message-ID: <20251106195935.1767696-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series introduce some cleanup and support for
clock and reset of Airoha AN7583.

The implementation is similar to EN7581 but AN7583 introduce
new reset and more clock divisor support.

Also AN7583 require some additional tune for clock rate so
we introduce support of .set_rate in the driver.

Changes v3:
- Drop .set_rate patch (will be proposed later)
- Drop chip-scu binding and related patch
Changes v2:
- Add .set_rate support
- Rework DT to EN7581 implementation (clock driver is parent)
- Add additional cleanup patch
- Merge binding with schema patch
- Add chip_scu phandle

Christian Marangi (5):
  clk: en7523: convert driver to regmap API
  clk: en7523: generalize register clocks function
  clk: en7523: reword and clean clk_probe variables
  dt-bindings: clock: airoha: Document support for AN7583 clock
  clk: en7523: add support for Airoha AN7583 clock

 .../bindings/clock/airoha,en7523-scu.yaml     |   5 +-
 drivers/clk/clk-en7523.c                      | 543 +++++++++++++-----
 include/dt-bindings/clock/en7523-clk.h        |   3 +
 .../dt-bindings/reset/airoha,an7583-reset.h   |  62 ++
 4 files changed, 473 insertions(+), 140 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

-- 
2.51.0


