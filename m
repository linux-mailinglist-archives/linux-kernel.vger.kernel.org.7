Return-Path: <linux-kernel+bounces-758508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD089B1D013
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 861A74E3100
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB4199385;
	Thu,  7 Aug 2025 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Q3NgA8OL"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585724C6C;
	Thu,  7 Aug 2025 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530239; cv=none; b=BzdN3Y00YQTYvbEgx0TbrRoSzS7OcMZH1pqY9PUIVB5UPa4r0noH/6h1IdKSBgVo+HfwgIszHC7n5FV0w0kfWqnIoPsnWQv+SE++wBpUkGyO/hxKLnLNLn//ARj5jeCbInkRnmH540qbsIMPOzj083EHCfNv6MnEAtbLvQlqY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530239; c=relaxed/simple;
	bh=Zsnd2yhm0e8Z7N/XbjGsxi9+PjwfVA0yvEOrhmxO1r8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UBwTEvMFTiUPF9yTjt0kFhz6mEp3Umdzg28r6G+nRzApVanOekC5Qp/77qOOBVR/I4faWX23T+63RE5Zb2wKxEUK4PW6okeQ0EQYw3gKgU0jK4Y0s2PvN6MwvCN0Nt0tBiyXuck41v9oAIto90PPlzUct1UR22wqzQi7ZrvI1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Q3NgA8OL; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754530213;
	bh=R55Ce30YMHeTG1lDNGUKrl/+gpE/GNdMkbzIFbY7bEI=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=Q3NgA8OLeYRV5iBUy+2dGz2qBTQU8LjhtidAZdKz/Vz+rbIhH7Up/tfdfzVmnO+hS
	 /hSiHa/ivVVwDQW+Av93e6h1kVUwvYlgHlaEbpLvVgotPGE/NGPu2ixRCgugBB18Tb
	 B90jKWVQz0YTTk68tYoOHMT/RvecvwgWMDDMOamA=
X-QQ-mid: esmtpgz16t1754530212t66e66a1a
X-QQ-Originating-IP: 87YQa/E+l5byIBWQdG0icPTbS7PxkSsJP/II3qCKtys=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 09:30:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5881493761293327476
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH 0/2] clk: spacemit: fix i2s clock
Date: Thu, 07 Aug 2025 09:30:09 +0800
Message-Id: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKEBlGgC/x3MSwqAIBRG4a3IHXdBpeixlWgg9VeXwkIjAmnvS
 cMz+E6iiCCI1KlEAbdEOXwOUygaV+cXsEy5yWpb6UaXvBke943FRl7gEdyVBQOoddkCpnaU7Rk
 wy/N/++F9PyMipt1nAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754530210; l=1573;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=Zsnd2yhm0e8Z7N/XbjGsxi9+PjwfVA0yvEOrhmxO1r8=;
 b=0y4pPVuvzy8we9mgGSoUWCZEz15xMZi/SA/847+BJGpcTkqgMsSMohCJM+mYV7GLAqMsRhOle
 LXLTBsvHm+6Cxooaj4TmFAcWbbyM7yOuDY9ZtiUXZegifGLQyE6s7is
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OPv1v8QuUFDkJsuwDqEIRadsHqLmzvDVecahBjMLuUPJ0NX57+fmdXMx
	3G4Jfk/vA9kMJlkz6r+ENoe8rLKQ9MCXsjx7WOqQHKd796JvgvtbaLxeE3I/QUqj8B8RLRj
	wNsDSanul2lqSo+Xr1Pxi6QFWu79vzgdBRRobArxj6ix3Zb32mTs7qvhO0H46OIr39iNj1r
	sa57hH8wRgHhgFMfe9j+J7TQ97Bp+SwvkTnet6hcRSTNROfR7Ilu8y/paTyhtdSIucTE+x8
	KiM9gj9nli2zGh4WAmdWubh2efivCRS0lMbACUkoZtEdBCfTHYnxv0gy106PhpEek8Y6lcS
	ksvT8hwSHbha7NWCcVKzVunnXyt5reEw6UcNKF1/nZzpuDEz4CPfK1V7n+ce2Afj39B+WJB
	RminYSU1yjnQBBfsaCkVJvleKcCoHb1T2Ze6gxgIJ9AZRMwBFSfc5uhTTJB3u2Yc3alGvvF
	BO6iEQ3dcW7g2VxwYA/fC664igyaeSRD9sFBbrKV1GRqYh7MFTC4XAjVzfni/5b+C0g6ojB
	vH0CNLGDEmzEBNUf+3vsNjhIa7crJGP222OZzBI9hElTBzwBUsW0n9JQjAzFyzvwrHljEEN
	MOaR2Ox8CpQxxfFIOFsSOjtnD4Zn+4v+pUSQx1FBj1kWOUhD+VqPsWl7hNQqV0PqO7p01DH
	f5OE8Qnd1FfqgUTk+gXQ15SrsC3T//4b45pD0uuvLx8AreCh/ng0mgrGrFNMZjCgXmzSYlD
	wNS7s91KZV/UhSnxnjpEBx+rLTLJUKQPYp8eN96cu4EYUZ/ryDQrju6sCpfkFQWrKXBbHmD
	vRTJuS+6u5BfcsVnsEaR/fRI0OILezRtETcrLwdwylS0pzAl4xOxr2ANw8GBuQOGdw3X3OF
	oZBt615UVTu56sBt1bHhmyU6sjKLLI2/Z6oJ/qqnjlWyu+7onCkcgNTU3I4UxKfNETbz8n7
	9xq7AepOWpDeRWNWolvCUEoo8/DMUIdGA4rwaKpEyDOAuRdOEvqLU1mjThqdqOoXVmz1H/+
	QRoNZJI+u7ZHBdWpHvWv0onLLNC2sowiwB6KSrmt3aywhtwsM5fAmwgYBtYL/NBp3fEWWPE
	pLn53GFduAXG3/B7Bo/t6bn8DnD0IMt0FxIVwjmyGNGkzMUQmS/WS+WdBsldfvjcw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Troy Mitchell (2):
      dt-bindings: clock: spacemit: introduce i2s pre-clock
      clk: spacemit: introduce i2s pre-clock and fix i2s clock

 drivers/clk/spacemit/ccu-k1.c                  | 34 ++++++++++++++++---
 drivers/clk/spacemit/ccu_common.h              | 13 +++++++
 drivers/clk/spacemit/ccu_ddn.c                 | 47 ++++++++++++++++++++++----
 drivers/clk/spacemit/ccu_ddn.h                 | 25 ++++++++++++--
 drivers/clk/spacemit/ccu_mix.c                 | 47 +++++++++++++++++++-------
 drivers/clk/spacemit/ccu_mix.h                 | 26 ++++++++------
 include/dt-bindings/clock/spacemit,k1-syscon.h |  3 ++
 include/soc/spacemit/k1-syscon.h               |  7 ++--
 8 files changed, 164 insertions(+), 38 deletions(-)
---
base-commit: e991acf1bce7a428794514cbbe216973c9c0a3c8
change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


