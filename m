Return-Path: <linux-kernel+bounces-774703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F210AB2B65C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67181B6334F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62701233D7B;
	Tue, 19 Aug 2025 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="pnjb9g6z"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32622CBC6;
	Tue, 19 Aug 2025 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567347; cv=none; b=KosB++vD2r+lCNCyxY5v0QovDpatW08sfii2/Mq8RB+xjhb95MRtm90xLS5ACqcMePDuFMp65p7BnKEoTKFPoO+3W/t3BangmKWFmGa3MbNxB+p4ReidTt+EME4fnM620MfTHfNyAoi2OMjwK7W39DjnVGuBl7TA9sp7W2LYqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567347; c=relaxed/simple;
	bh=pamPdcLkAHEwcJieLVVPDrjs6dCAOZbbBGJViw4KgTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fJGgHFud2lIOsuQZE/kCPRICrZ3fHdNRzlh8d5NJTD4ZJqdoayuIGMMTMoqQoAPOt/QV6aSUgPokCG1jyLWS8pBZBXlPuzpQ9DXp6y5fqQ9PdiPLTITWg3qRTna4LBShogl10zp/X/e5Iop1k+B8DbxskTK98N9890G2WGkLh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=pnjb9g6z; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755567322;
	bh=Hc611bFREEVwvZbaVjAI17ruHO58wqYPJVG/MRwzuf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=pnjb9g6z9QVGVCMJI2OyiA3VuVfcuIXRLBzr3DrWzwd7N0OL2yxrUds5hC7Uf3cKL
	 melWpp3rQ+E5mW9RdBSEavnRTyaashLb8Zzk8tyqyUNvwHIVM6LGkE+ZbHLUfK+bEt
	 AfMaie7VdlF3u3EIPanNT8TU2A225WHIrQaUiBSs=
X-QQ-mid: zesmtpsz2t1755567315ta02933b0
X-QQ-Originating-IP: 8sub925GgEvAw2guG1Oq/dGU6xOjrxkgJZaLfrTpwqU=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 09:35:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4166385471962844417
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v4 0/3] clk: spacemit: fix i2s clock
Date: Tue, 19 Aug 2025 09:35:08 +0800
Message-Id: <20250819-k1-clk-i2s-generation-v4-0-80174edd04eb@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMzUo2gC/3XOywqDMBAF0F+RrBvJS6Jd9T9KFzFOdfBJYoNF/
 PdGodBFXd6Be+6sxIND8OSarMRBQI/jEIO6JMQ2ZqiBYhUzEUxkLGeKtpzarqUoPK1hAGfm2KA
 AoJkqALg2JHYnB09cDvf+iLlBP4/ufcwEvl+/oj4RA6eM6sqKDEoFqpK3DofXkvrJWOhxTu3Yk
 50O8ofj+RknI5dzWZRCmPhr8Zfbtu0DIdeAnRIBAAA=
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
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567312; l=2247;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=pamPdcLkAHEwcJieLVVPDrjs6dCAOZbbBGJViw4KgTg=;
 b=x3HNycUPRE3D57CpTFuMcdTiGP8NJAMZiZ2fJGRbw/GkxSJH6f7umT/jjIF3SeIT0l1UW/ve9
 /9yGVNiI+HUBoMJP4S8P/lpUjpXzrru5Ln0VGKnfjPHuHsog7fkbPdK
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MtZUceor8KoRlC6aInv1PlrmpbVAj1wsMWKCYpR4FydPNaaZPTXjmYPA
	7H41+CqHGBvPiG//8G4A8tB7gYoKZwY0sEco392kouTaAg2hAlPuFUBoOXS2wwd7FiTxU3y
	BlXduSMeEgSHYrLJmwzU9pWuOG63lcXQtwuY/RyXls6WUbNuWvyqMQfNWwn4/lsZFH4kuVl
	XKGYgIApU4/smN9EP/HbxodPwzUJkVdvxk1obO1cQm3syzx0hPCyjJtIsN7+LPXAuENaGOH
	emBQoDey2DL/X2nYKSe7jjoinGQIsmXnMUPgJ88D6qMZ+aHEntWwD+sqyyT8rKQBROeqTp+
	lvvlTNaWwjK/b7oFzWQIWXizEOXCZJiOHkSMAi517lVRVB3IaObDBmPxsuRyRz2AO1Ji4oa
	92heMxhcqwMsKLYUy/RDAsyToI1h1jwmTmDp0SlFaOJ/PqQQ8ftOr8T0FgSvgtx9ZEWWBBk
	77CrKq5zEmOk2cnqnzVe2C3TgMSYkY6qAvTg3A/bU5WMHEwS5M0KdJKvXOOCe1FLt9ENldZ
	U6G4RWdWtT0+vITbRHmrkz15Fx8b3JICWfqrVUYKj0ODSxQRcxRNy+7nJDQxsYGcomVrn3U
	Fu5EBOVUuVy0keutq97SiDiUPDsoNnJw4+utZpPQ2tgJZgVmMzYoegOKJLs8lnUCYt0oLAW
	s8p//Vy7anR0UE8Lp78+5Sfay3LiTeoEdSOncDPKndSn1QfRxlNMoEVS0nKLbfWF+0taoFy
	VZl2W1cXO819R43ivfORxLTnVXNNgMTRxPIxV3ZSt6YIVNrQ+TxvtuDxR52xnhR4evXYvNK
	XkxzbcE1aNM/0urPrHP9NQAFlf15Jw59PdYXX6LbOQqc0X9Bf2qFkvBbQL7FnjY0/zyO++y
	66XZ7QReQ0T2G18pShHiVh2J9KwA6p2mjJI8lu1hVJ0DzEQGjyKkuq6228oL/jHveCcr5Wc
	PiDqPOcpOdoZezZ4zYn5FbN9iux4DwqFmWHkVAz/yw5lyWrEgwzCcT4bKC2Y81dqmZGUse+
	MqpPzDkXv0KX17E+eunoXcfXsVJLHaB9DhatICbJGlQWmCveplHgbrD3uDbBUEmJeXjKAr5
	0OT8RB65anvhyjqhOjIwM9IiOTTBcl4bBJ3HvcHiJ5vMEDv61VKIbMPWxoVecaWI4oBm630
	5TUo
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Previously, the driver defined two clocks for the I2S controller:
i2s_bclk and its parent i2s_sysclk.

Both i2s_bclk and i2s_sysclk were treated as fixed-rate clocks,
which clearly does not reflect the practical requirements for I2S operation.

Additionally, the original driver overlooked some upstream clock sources.

To fix the I2S clock, this series also introduces several new clock definition macros.

The I2S clock hierarchy can be found here [1].

Link:
https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
[1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changes in v4:
- drop the erroneous change in ccu_mix.h(patch3/3)
- modify comment
- modify commit msg
- Link to v3: https://lore.kernel.org/r/20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com

Changes in v3:
- remove factor for CCU_DIV_GATE_DEFINE
- introduce I2S_BCLK_FACTOR as I2S_BCLK parent clock
- adjust consumers in patch2/3
- Link to v2: https://lore.kernel.org/all/20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com/

Changes in v2:
- remove CCU_DDN_GATE_DEFINE
- remove CCU_DIV_TABLE_GATE_DEFINE
- move gate of i2s_sysclk from DDN to MUX
- introduce factor for CCU_DIV_GATE_DEFINE
- modify commit message
- split patch2/2 into separate patches
- remove reformatting in k1-syscon.h
- Link to v1: https://lore.kernel.org/r/20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com

---
Troy Mitchell (3):
      dt-bindings: clock: spacemit: introduce i2s pre-clock to fix i2s clock
      clk: spacemit: introduce pre-div for ddn clock
      clk: spacemit: fix i2s clock

 drivers/clk/spacemit/ccu-k1.c                  | 32 ++++++++++++++++++++++----
 drivers/clk/spacemit/ccu_ddn.c                 | 12 +++++-----
 drivers/clk/spacemit/ccu_ddn.h                 |  6 +++--
 include/dt-bindings/clock/spacemit,k1-syscon.h |  4 ++++
 include/soc/spacemit/k1-syscon.h               |  1 +
 5 files changed, 43 insertions(+), 12 deletions(-)
---
base-commit: e3324912fe5a05a3ea439df476625e7c8efc2b9a
change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


