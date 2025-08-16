Return-Path: <linux-kernel+bounces-771833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF8B28C07
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C462C5E0CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C923AB88;
	Sat, 16 Aug 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2+xw3jm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735113AD26;
	Sat, 16 Aug 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334046; cv=none; b=o4k7N5CCkqKwOP8qw5kjnX1vvSIEgnZH7zGFzJN1sJSdG9rmTRy3m8iYctK+/S6uXwOhkkN5b5S6iax+ZiFmLD77I7w9WuWamlS3iq9vw/QtOdv5unaqccOGtaTR/KsQ83lNnU6KsKZdPZa0Q8pF5HwsOnO0GHHkX7SFcn9Zu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334046; c=relaxed/simple;
	bh=8PCZnzyRTidqnHyCuNwmg93j5EhJWu3LK3bWlpzsKUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dznkfeg+yRg4uXxjXP3ylFxzZPB1SNER2AHmoYQcXQqnfz7rJqbCLUI894QTMG6pBkB+f2U6PdZcj41FsdGSCjV7ub7XOhkzW8mzf+aqxzNNDZ5T86hXPuJtDlbAySNrjXhvRoyiPDyJz8EavsVg5poiiHqTyzQqyXNpmR/oIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2+xw3jm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458298aedso23742185ad.3;
        Sat, 16 Aug 2025 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334044; x=1755938844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n00OWL+w8sWdTdOAmEeus4NBoquiXkV9tCtbNCC3Db4=;
        b=A2+xw3jmVDSuaJYZknaB7XKeWx/jHAbh12qsYxj8tKWiiBU+BFannyrTeUOjuqg8Tf
         sMt+ZaLH0MY3u6Y17nFsURD0b2nxVPBWDkxFq3/CJyBnpFwBtDVE0duLo0F4juu/sBP2
         bvXwlj3oOuTt9UC3raySV10u+Kf5bS/2gMXFwrhvEnwYxCwrLfLDyjY2VrJrZ37OAiZh
         eQ4cfgrVYoe2pC5YkN0TA0+rj9u4NaUAkyoNfgLB7jTkvVxCulY4ipebJ8DQBuU1cliC
         wXwcGGooMIn0Jk7wPJ2nljUJA1TJXSLYJaK/3KScKNJbxjAz4WRTa5RqYLL8Mql7J4dH
         u0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334044; x=1755938844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n00OWL+w8sWdTdOAmEeus4NBoquiXkV9tCtbNCC3Db4=;
        b=PNGub+DIyvbQV+7hm7g1k03KcfmGonfA001AUklr3q5GIbhAo0ZSaIPhOE+0OY+LQU
         FZIpJOqbknIy6n2psu+GHP33M6hjDT3Gq0QBmUzW8mIORqz3fDofvn3hjaQ8sOi+snNy
         7YNCS9vl4n8Z0zCShfRauaHlWXLxGvpUhpcy3hjM/yU457bTTifhBxM+KfhUmCfUYp3S
         jKlsNul20UAy6DDiqeWf4N9myjlxWxM9szRRB3LlIO9QcFsGRPiNuA8P2/5wlVdkS7wY
         G47sHt20q91upu5ctxxEJL6JMTzjblh6KAONM2s1lqPf+CoVWw9A1Cyc6pBDB2y3p3AZ
         LX5A==
X-Forwarded-Encrypted: i=1; AJvYcCWF89AUQoPLGDwafeLueeaA35dserEigqF5B3Ay5yeb2qCnem6LOHuSF2FHc1LSrT+9pgM6Qv6Ooo8=@vger.kernel.org, AJvYcCXP5MAMIC/T8TJJMbIx5fCk5h93HfVhLl5usR8bp4EypAHmctdm+vXWjjAmTyQZb9gOuO9ij6sseBEix4KX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YG0ZvjCtSPDzqlKkN8uSumhWfQK6C4ucTTgw8AbTXA0sxUD2
	pZjw4YWlkDEUBhv3MVO9a39I4+m4ej85QU+zlZ2k+LBaTQg14oj7mayq
X-Gm-Gg: ASbGnctwCcsZXn9NIyJYft80cjfodVbRu4SCtPJA9aJGCHhf4yvi7utPUI+i8oDWuPk
	8RRc68zXQoDQKVhQuqtXDb39atCAAwconnhk77CBDHjjQBPlFGEi7D/iLDuABGL2APq6E3H0GPW
	CH1vYg4OqcngJT4Tw0UHA8gfGm8I5WJl1Lk++ILEtyHl39QXjji/RREUPFUssbcfJj5ki0zRXlX
	hgFKNF6RX/PdnksNN8qvjtvFVmLcZfUuYwzhDiOkk2YuP1WjdfhiRaMNBw5US8J9HqhkDtL1f3O
	7hchAmb5TjxW5OxL6sEHICI2B3KzOBb4MH8PHMqqTpNRPfmZCAl7RelVHmLSjbAIPGBmNCnGYWf
	dr90ZHjgtZYQ=
X-Google-Smtp-Source: AGHT+IHRLGNB8SYXmPKw81D1VOKbz4q3gvNOhwVUuxSt8mOuivVjupipoQ1fbt8d5uqOtt3TGwriuA==
X-Received: by 2002:a17:903:22c6:b0:242:9bc4:f1c7 with SMTP id d9443c01a7336-2447909bfd5mr31610805ad.54.1755334044121;
        Sat, 16 Aug 2025 01:47:24 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:47:23 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/7] arm64: allwinner: a523: add USB3.0 support
Date: Sat, 16 Aug 2025 16:46:53 +0800
Message-ID: <20250816084700.569524-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

This series is a draft and does not include patches for dt-bindings.
The first series is necessary for testing on other devices and
initiating discussion.

This series of patches adds USB 3.0 functionality for the
A523/A527/H728/T527 processor.Most of the code is derived from the BSP,
 as the datasheet does not fully describe this feature.

I have verified functionality on two of my boards, walnutpi 2b (t527)
and x96qproplus (h728). When testing usb3.0 on x96qproplus, I get
reconnections of my nvme, it looks like the port does not provide enough
 current to work. I have encountered similar complaints from users of the
  device on Android. In the case of walnutpi, there is no such problem.

Based on 6.17-rc1

Mikhail Kalashnikov (7):
  clk: sunxi-ng: a523: add missing usb related clocks
  arm64: dts: allwinner: a523: add third usb2 phy
  phy: sun4i-usb: a523: add support for the USB2 PHY
  phy: allwinner: a523: add USB3/PCIe PHY driver
  arm64: dts: allwinner: a523: add USB3.0 phy node
  arm64: dts: allwinner: a523: add DWC3 USB3.0 node
  arm64: dts: allwinner: a523: activate USB3 for all boards

 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  52 +++-
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |   8 +
 .../dts/allwinner/sun55i-h728-x96qpro+.dts    |   8 +
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   |   8 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c        |  32 +++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h        |   2 +-
 drivers/phy/allwinner/Kconfig                 |   9 +
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c         |  10 +
 drivers/phy/allwinner/phy-sun55i-usb3-pcie.c  | 267 ++++++++++++++++++
 include/dt-bindings/clock/sun55i-a523-ccu.h   |   4 +
 11 files changed, 392 insertions(+), 9 deletions(-)
 create mode 100644 drivers/phy/allwinner/phy-sun55i-usb3-pcie.c

-- 
2.50.1


