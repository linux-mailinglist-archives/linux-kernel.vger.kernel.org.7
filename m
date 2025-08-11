Return-Path: <linux-kernel+bounces-762831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A8B20B45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57192188ACBE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52B23B626;
	Mon, 11 Aug 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="VPeTNaNv"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B5231825;
	Mon, 11 Aug 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921107; cv=none; b=RZDFpB5BWHHnauP/LvVce2IM+E/QUefMUafXNTxohB9+MQq4UrGOBexRvvKKBcGyDhxhw1YoZiSuHd6WqCkqS8qS+E+0Y6UgKUtdmUHXkpexhiOj5wFiltsVIEmkbt8S+YNcOYPtM+DLvd7sUys6HH60BdDr2t7rhLPW7bv0Gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921107; c=relaxed/simple;
	bh=zplxlX8M8Ix32mf9GhxThytJEQARRj5h3yz1CZH/uYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sX8gmGrJEZYmsI7MqSELP0GM2lGvE6djnlgC1hBEkvdFARmpAZTArtJyVEuDza7py7J98t4B9ddukkUFhSLlZ8J+OQQuRh6gjpk3yj0GBtDvIZ+vaAfUJGlW/4l07BynZRn7x/8n9WHh7pgnvfB6vH6qTpO2SWEKjhunBNvksyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=VPeTNaNv; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754921078;
	bh=6P1D/ZrZD05cWpNUR0xzM5levw6Qt08PvmnlyU17ke8=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=VPeTNaNvxnhMBJXlPHubon/N+5ARXqDpP210poe3XlaU3aSLibA/0awKkI2ZjUedd
	 TIoyPddgnE4g72NwHJ+W0Cx+vT6Ki4lxmzB0dZnJduwWy3C4DcS1BTzMEcuCZcl3bp
	 9mD5Lq2B2z3w9Qzzid3gxrQkidOkLWYlqPTFA0Zk=
X-QQ-mid: zesmtpip4t1754921076t7e138ce9
X-QQ-Originating-IP: eTLoZc3p7oyCNC0JObN64YGwyJoMr/R24ZnHCNREhb8=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 22:04:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12834372004282179725
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v2 0/4] clk: spacemit: fix i2s clock
Date: Mon, 11 Aug 2025 22:04:26 +0800
Message-Id: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGr4mWgC/3WNQQ6CMBQFr0K69pO2llRdeQ/DopYn/IBAWiQYw
 t2tJC5dzktm3ioiAiOKS7aKgJkjD30CfciEb1xfg7hKLLTUhTxJQ60i37XEOlKNHsFNySAAVpo
 zoKwTyR0DHrzs3VuZuOE4DeG938zqu/6K9k9xViTJVl4XuBuY6njtuH8teRydx5On3A9PUW7b9
 gF8hnJZwwAAAA==
X-Change-ID: 20250804-k1-clk-i2s-generation-eee7049ee17a
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754921074; l=1959;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=zplxlX8M8Ix32mf9GhxThytJEQARRj5h3yz1CZH/uYs=;
 b=SX+mVoR/mVC5cwNpdmanNecKYAdkxQ5ek+Nhb1qNPL3qB5Z8mofIfNgzg42Bih6vN1QYSbeqi
 ObP9CxSzyyhCx8jozDp/fnHMXUI2VmGvCeN7UwFFYnzCH0c+cEeEKIA
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OGMw2CL+mwjsKdPCCQALXfVIefO859FOhyDPcn3KYL92gPYJnfLAIcSS
	6Vw0FECkbELWxyhcnX+Z9nH1zYCNyJXnIG+iO3nWflHHTJ+G8tYBkmeyQfOv6kJcfdx998e
	MW4sk404o+4OXGJuRAGWQ4ns4IACIMIWV3+e9kvV3eSZcgmmYi9eY2avEwlM+SAoqAyf6uv
	QIr6NFNvYNamQYzrR8iItZSo3NDBuAfTkUbZCGeVZ2hKtCFPAcc/K1sXZBIqxFqM+BYL5Xo
	lAiZGfJ+ckzgvoY95qBTunF0L7b82bh6ZeGQU5QcSAo7nvZWIzBCrsDW9T09J1bAoFDCyZB
	FbW6g7yNxkhj0riduQMc6OPR+C1nPowcnATrqPJX3qtuetzLFA/9KGk8oiijYK7pTTKllJb
	mxSfNneHRmq+X9w54est+oXgqIeHDOcCta0OOv7J9p/VCbglB2xmx0HL9jYwbZpuy7xa/tc
	FxyI6P92jdTm2hUCu1zp3sJAIN78QzY7vnLvm2ouCJ7lM2VX49affrdIkwg1QoPc8y7jvBf
	3Kss75zQc99ZoWx0LU+zLHqlQethcJv66PgQcRdMkxSkVTrv1oGPBpWcAHlolyHBn4BiKLi
	mnHwXpBmYQ0PGOSLO9zkAytDdVJ4sYluy6Ek/ckMJIvOW2LFr1A/R8/44N8DcJU0th/WSCi
	SuyYGKyMl7nJ7YUeW07/aDqL0kCxr2RAcXWagcLcemO1EtvX/JwXQPgZZayeYMO2VZ03bA4
	7W1ImR0lGQ5aQz6qIOMkFy/DXuALOsK0hlpr6n0MRSTc+6C138mj23KjbYpro4l4HyUprrY
	GHzb+0HseGthI85vVVxDpF46SnUIYtZLyZClptiqHS4Uoohm44Cnq62u6B61VQwNycyqBAR
	RJFH3zwY6ptmWutX0F/KKGNicn6cylmpCyCIDLSrS7BOFoprTB8C/rzAFhC9tolnH7ibWLR
	tVhYvMjZYjv37OVGjl0PbzSvOGW/Ne4JdAMPruG0/6y09yBocImPp5ZPkgQRVf0dt4Gzkvw
	67rGanjIwRTImU3gSjnKB6q5P2jLZZNYTWKL+/H2DgnWTgbelviMFEySuD21pMvnjhGfJQk
	jOgFbAZ18pkKng0786OMNVYVU+V9vgU4ViWDHLOPDCVBJyipg0XQceMTwO/zRB2qnNi7O9Q
	HVk8Ws2h7lAQoGUFes+Bot6axVZ/jeCr1bvU
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Previously, the driver defined two clocks for the I2S controller:
i2s_bclk and its parent i2s_sysclk.

Both i2s_bclk and i2s_sysclk were treated as fixed-factor clocks,
which clearly does not reflect the practical requirements for I2S operation.

Additionally, the original driver overlooked some upstream clock sources.

To fix the I2S clock, this series also introduces several new clock definition macros.

The I2S clock hierarchy can be found here [1].

Link:
https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
[1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changes in v2:
- change the macro for i2s_sysclk_src to CCU_MUX_GATE_DEFINE
- introduce factor for div clock
- modify commit messages
- remove CCU_DDN_GATE_DEFINE
- remove CCU_DIV_TABLE_GATE_DEFINE
- remove reformatting in k1-syscon.h
- split patch2/2 into separate patches
- Link to v1: https://lore.kernel.org/r/20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com

---
Troy Mitchell (4):
      dt-bindings: clock: spacemit: introduce i2s pre-clock to fix i2s clock
      clk: spacemit: introduce pre-div for ddn clock
      clk: spacemit: introduce factor for div clock
      clk: spacemit: fix i2s clock

 drivers/clk/spacemit/ccu-k1.c                  | 28 +++++++++++++++++++++-----
 drivers/clk/spacemit/ccu_ddn.c                 | 12 +++++------
 drivers/clk/spacemit/ccu_ddn.h                 |  6 ++++--
 drivers/clk/spacemit/ccu_mix.c                 |  7 ++++++-
 drivers/clk/spacemit/ccu_mix.h                 |  4 +++-
 include/dt-bindings/clock/spacemit,k1-syscon.h |  3 +++
 include/soc/spacemit/k1-syscon.h               |  1 +
 7 files changed, 46 insertions(+), 15 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


