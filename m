Return-Path: <linux-kernel+bounces-854685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C2BDF1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A5319C3682
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3E29993E;
	Wed, 15 Oct 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmap6bsS"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246425D533
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539164; cv=none; b=btFTwAGnXAhpxJjh7JplGI2x5WFC8a8KrzJ94tCRC7Sh+SILbHdzSFW3NEv7D3K9RF4xS3WAxRCn4yHvijvHrXqaH1B5QOwIm6ilD9SzH6cTKjGj3EDe8pVYJTyVwr2Lrhxx/fQ0jTAXpPgK3JRjY8BL5KRWMBQxlOZbF8DRovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539164; c=relaxed/simple;
	bh=SlngsQQxcONRtHhTs1DZZ1H59SrvYbvg4ov1vmkq0Bo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZIIsMdDm5tRWq/Vj1rntPPTpKyypk1iYqDbp+bJGhV4hB/TSeXs6xsF9UNaPUuPgdJvVRrw7cUVwpPqUdJA0hghCg2rUTJpa8IBUwEJ6G9qrSdVGaJM3JLKoBorzNckxFsmdBqN1z6OsTQmwdWlFOucFpEZy2Rz9CHZBZvZbXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmap6bsS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so4242621a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539161; x=1761143961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouWcSpiIf9dLpvZnWLKHc0VRpVvUzoJh4rEYwTYJ/q4=;
        b=Cmap6bsSbEduzvqKUbRJ7ReOfm2ggBn1CjsW3lziVpTUQWA6KdQXQZjVglvy+p1goT
         PLtiYl/EFvqqVaBh+m4OtjnyHrTm6nvuTbuEwGrq8t5RHdhY/gSplg21LdXFVVnyHSQq
         AepLDKp7NBvAOHuz5U4r+oWzrbE+ZGAs9+GJREDFSkKNPTOwTo9ermOVXduwFolOXbOf
         op4CagDARqsRJwoUgOzd4dwnM2VFVluvyqsvJw1M60R0NL7eDP9a+zqlJAZnUZc18FZJ
         U6qETkpS8asy9Tt+A8ELFPErHKsYGW5Ue0xu6pAtoG6y6+Rd9/wzt5WIz0arHCb2Y0dg
         gcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539161; x=1761143961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouWcSpiIf9dLpvZnWLKHc0VRpVvUzoJh4rEYwTYJ/q4=;
        b=taIZvyVBbzNQjcVuIC1FrmiLaxMWOodIniHOPnPssXA5SujXgX9/sMVbUFWnE5F43T
         JLIab8RumiLgayx6biWxE1DWERsVKECcfCTAOrV5KWkkSQSS/uU5H686flQ0enyB4lpH
         DbNbwMNvRnBSHnzNEfV3GHaLWTSfJAvz4O+PTZPU/UJz8U6qTXyy0+v0nSMKRc33JuHy
         avQHuRFAb/uyqXMtBY/QyJpUmlZfZC0FEBc522BjV8zmJhA5JWYAYijRCzjsags3UaLe
         XMDMymtaPNIXcze1SQjaNuYnqEk7IivD1BuHNLGLljcm89Xiu7Y78Ebygu38azfnFxZo
         2XTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7swaZEiuL6bshxtZD3bImwUTJuFNGkdGbHofn91R3EMwjlJU+FNaKTMk7iaDTLLrctC2JbpxY15j2AeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphuAUDYOamX4DLKUZQD4zXb4zt0Pb1/An9xVlW/EeqAkWtSWV
	ZmXGl2pHs5/k+OEjnBnqdSzGqvMBnGNxPc/hgk/W5GAQv+GC40TAMASa
X-Gm-Gg: ASbGnct7ZVS/qhzxAQrqJS2Kwy9hSjvQP2TVXUito7UeBUGcBwmo/vM5gg0V0RueSgg
	qL2aNUCYnrlgOal29YDafkmxdFq1hE5BlW0ScGfR+REpV7N/xqy5hsEJ2clnLSjzYqKhZVVcLkO
	zBkBU+JcuMqjAy87/9WblrDSOslVPlfoBnU3OHnxMEXFTTzitz31bmEHSFfRrqOsQm4FoIjd7WQ
	0nzCR321cZ/0iJUbJJLGcmKcc8Td6nam31+QK6bg26Z5lBnYLw0p5H7yN/G+L9ahFTcXyJPWPRg
	OWy8u+lZIjeRO5zRA+Mjz2sc2tpqTY+DHkZqDF63NihhLSyc3sSfvSJpmFlFaoxb17GWnGkYMms
	tpAtZ/lGVskLsFfLWUr5IBE7ZGzpA+y8wO2guiFzLeFw9n7kFTisPako+xhk3sjmIYdgEJMAX1i
	VK2OoadUkDEKWRack3FO1fCdKGo8d83BB9jkwkkCUGhNTBJXdC+/1DYZ/jcM54jAkn
X-Google-Smtp-Source: AGHT+IE502KIN4tz1ZiBR1VS+4c/5BDktMXSPvvmFW+gOT8kNcqJukYwWerUdV/VaxRhOB3SKUHsgQ==
X-Received: by 2002:a17:902:f642:b0:250:999f:31c6 with SMTP id d9443c01a7336-290272b4764mr317255775ad.32.1760539160392;
        Wed, 15 Oct 2025 07:39:20 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:20 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Revise Meta Santabarbara devicetree
Date: Wed, 15 Oct 2025 22:38:56 +0800
Message-ID: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.

Change log
v3 -> v4:
  - add blank lines between nodes for readability
  - drop changes to already defined LEDs
  - add gpio name debug-card-mux and FM_MAIN_PWREN_RMC_EN_ISO_R
  - enable amd apml interface
  - add eeprom for prot module
v2 -> v3:
  - remove mctp node label
v1 -> v2:
  - add 'bmc_ready_noled' LED and update commit message
  - add sgpio line name for leak detection
v1:
  - add sensor nodes for extension board
  - add mctp node for NIC
  - adjust LED configuration

Fred Chen (7):
  ARM: dts: aspeed: santabarbara: Add blank lines between nodes for
    readability
  ARM: dts: aspeed: santabarbara: Add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Add bmc_ready_noled Led
  ARM: dts: aspeed: santabarbara: Add gpio line name
  ARM: dts: aspeed: santabarbara: Add AMD APML interface support
  ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT module

 .../aspeed-bmc-facebook-santabarbara.dts      | 919 +++++++++++++++++-
 1 file changed, 913 insertions(+), 6 deletions(-)

-- 
2.49.0


