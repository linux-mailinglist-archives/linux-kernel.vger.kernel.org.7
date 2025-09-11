Return-Path: <linux-kernel+bounces-811358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3016B52808
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9A2C4E127E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F823D7C4;
	Thu, 11 Sep 2025 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="X4co1BvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwiLEaYa"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B4145A05;
	Thu, 11 Sep 2025 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567441; cv=none; b=lCH/8ehlrJHeQLHfvYNI/cNKxdYxEPi+BaVDAUqgQn1jIbVPZP61UhinoSlApYF6D27xEPbLjU2IsT7REjIZa8J8LOvkTuZpiKcylN3Br168OofXmjrZ+kvgZ7aiXUeBfCd+XmgM9JeftFG/aO8x1yvxOcPyPZB5ihwZvNnYjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567441; c=relaxed/simple;
	bh=RgSm1P4U0fT4Gjgx8mNfHIwGqEEoyPZYJBEmX1/tPdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDa5qnoflMFXacl2p0kuIpSzh45yhWy6TJcXDisDElcD8IjizKvYs90wCMbC4JzAHk+i7qM0Lj6KbJg1v9WhdmiVq3sREdDop/cGHJBDKahOLDFDKmDaFxFqS89yBtbgSv8ba8JrreMcXGB1/ZZQ8D9a1KTgSloGGJW2mrcd2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=X4co1BvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwiLEaYa; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7A037A0058;
	Thu, 11 Sep 2025 01:10:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 11 Sep 2025 01:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1757567437; x=1757653837; bh=gaoZGBVm3mGzgQoEGG09O
	yg+9a2qCQexgaNw5V5SpOA=; b=X4co1BvUqcXccl62w8HrWO4by3iZzqmmRnMGP
	v+1Nr/PAbw6aI/wFoYJXhGZieFoivmIB1xTTPEGBAd0g0kidAHDxu+h9jXFfsSEC
	o/BuhtyAy1mgSmcxATpTROtG/yRcJxFTIJ+8/QLi+7ebeIbilUIyX7Kv5vDnwGxZ
	Ekej56pG1U+7XQ7RrMx+lvuYfIrvWV8gQjFCJdFGNiwx8N3KOBDzFDlA+7L8Fpit
	snfAL6cyNTR7pJAA2hQHBK3YKvEn0iSdEYXV/2B5PQPIlPLT/DDu+zRc3PvO2qCK
	JdBtUTCTZxYlQbO8a9gJjaWIllTpwXMldZZE4SkEJw+/VHPVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757567437; x=1757653837; bh=gaoZGBVm3mGzgQoEGG09Oyg+9a2qCQexgaN
	w5V5SpOA=; b=HwiLEaYaRDf1Tb75MashswycBlfp6ngPG26sVxUHmZbGl8zHbze
	OUuGHz7JhmSRpgsIcBqZgshalNQ4xkEpbwQvqLBywBU6YhVFiGzC3jXVPqV4jnye
	D/MOFaegpWxIeoPCtBgjt7BMlN6Ooftr7IBjjH3vA6GZBLZJ6ukk5l/sNt98TL4w
	68f1CM1YkM3y3AP8Sm3wpn8Zl3xLCf+tB9r5m4KwCZwEKX8Zco6jxS9rPKWGQNG6
	ZyqbuccGJOrjqDlj/1ndcWDxLwGk4O5GUXmV+TLPtxA52Nn1LnKRouMORb4Hh1LY
	DSzEIK2kq82zexB0fDCyBWnFp6NJdM7Qmig==
X-ME-Sender: <xms:zFnCaA4dh6MhsOHOJPaloeKGNsm7erRR37Q-mP14-CFd3Pe15VHgLA>
    <xme:zFnCaBEOVcHuMGQWoGByHIeHTwtYtvbVZR_GYqCeNRhFEvWUSg4FHb_qJhCxJNnN1
    yPdsr3lbZxk8sdWCq0>
X-ME-Received: <xmr:zFnCaCKuty7_tw_nRTJyLtCs4y-_kt0E2PSZzhGV0ovYmsRG4OOWjb5oq5hn7LW2-8i3VIDJ037J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggrucev
    rhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrhhnpe
    euvdektdelkeeukefgjeejteetffdtudeiffefheevfefgveeulefghfellefgvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvggttg
    grsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    iikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpth
    htoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphht
    thhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsg
    hsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:zFnCaOjpULaNaq4e1xD_KLBzFF6NGwlPqRm7a0NltOzraA7l1XcRMA>
    <xmx:zFnCaAlFKFeBaiEP4bdxWyztaaz3kt8_r7lgcOPIjgSoHMPyTDvjcw>
    <xmx:zFnCaFURAgP4cAmYx2kVdgkktgAy3bpt3VpC9qjHyrOmYurF2-B6Sw>
    <xmx:zFnCaNuQzv6IWjSKUioM0tkxfbRm6QMhkypO0VVlj2EQ6U8RjCEaHw>
    <xmx:zVnCaHIOo2_TRa6BAKadwQcbQ9yS37xiHhRyilljsUX9gsh-C3p5bUn4>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 01:10:35 -0400 (EDT)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>
Subject: [PATCH 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Wed, 10 Sep 2025 23:10:03 -0600
Message-ID: <20250911051009.4044609-1-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
processor. The BMC runs OpenBMC.

These patches add a device tree and binding for the BMC.

Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 647 ++++++++++++++++++++
 3 files changed, 649 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts


base-commit: 7aac71907bdea16e2754a782b9d9155449a9d49d
-- 
2.47.3


