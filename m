Return-Path: <linux-kernel+bounces-862599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B861BF5B81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EB394EE4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20532B98A;
	Tue, 21 Oct 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJmXESqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30E2F3C1C;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041567; cv=none; b=pe7xCDQPzbwbZ0GZ/KDlZ1zE35ZCJByy7HVzxvttbq/HgkMHYL+TE3Nanb0y6UnkdIM0G4D/pE7YLjNXrFLYrqCVLTsjqer4NRmrzP7N2ocQOEMeSMYCwDkk9ZTTCV4sCyqwEIgJAUQVj9Ad6933E+VEqavYFT8qJiAZ8fYavR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041567; c=relaxed/simple;
	bh=XaFkDnIxFuwdKpw/5slO8Fg7rQXH3UlmWMTwwbD+760=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cbAdjw6QTXQDVwrfL6E4IF0EdrYj/kblFKLblIoKaBVQXOImSs0n5kkGKlOBY5EstPdw71wV/QBf9LQ5yyIqDitefTuiDU4iqcvd1Jprg2tfyJdh5lNjhi6Y2toXf8fZqsMkXsin5k/mPtpwydB+CR+e+rDGJYAl+OHHjDeicxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJmXESqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16C32C4CEF1;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761041567;
	bh=XaFkDnIxFuwdKpw/5slO8Fg7rQXH3UlmWMTwwbD+760=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cJmXESqTLrnGwRCJp9chrwKFouQExDj3BlMymjr4v82d0kMUF88hYXUWIPYlk6AeP
	 SDS/1pkGy5fCW/pLqenONlchjbiceq1K/NZEm7/vMzKEjOiupNAUexBBy1ZhB+rE7D
	 F0Q0bIv881tMkKSfA8P4cqrjnA9vdgdrpC7yFda7QYDvZfKGj/Zes/63ro3deqpe9p
	 WJjcD5YHeXeqqmLNxesP32IjZr2LuBra2QpvIBsrezHOnnnqq7xi4dFuN8J6HdbKwN
	 6RmtIFNM4+AWfw2QsPyXIvmR0uKNJFmevpDz5OHxXElEmPZc0hZuMI03IOg4yL0ok9
	 OBnat+xBwEOag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED0CCD1AA;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 0/2] clk: improve the execution efficiency of
 determine_rate()
Date: Tue, 21 Oct 2025 18:12:29 +0800
Message-Id: <20251021-improve_efficiency_of_clk_divider-v1-0-e2bf7f625af6@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1c92gC/x3N0QoCIRBG4VdZ5jpBjU3oVSKk9J8aKl1GkGLZd
 1/p8rs5Z6UGFTQ6TyspujSpZcAdJkrPW3nASB4mb/3srLdGPovWjghmSYKSfrFyTO9XzNIlQ83
 p6DjhHmwIgUZnUbB8/4/Lddt2fo1+E3MAAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761041565; l=770;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=XaFkDnIxFuwdKpw/5slO8Fg7rQXH3UlmWMTwwbD+760=;
 b=3ub3SZ+eS4ugMlITxvskq26g3XdQ/H+pdxTAON9nKGIhZGB9nxyJasrHX+yWKiE2ZN8DA1V81
 xFZLIjo5rloAmjP4mtI4dpQju04ScYobUvnvcI6JRt9bkrPcNzSbDcF
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch series aims to reduce the execution time of
determine_rate() for mux and divider clocks.

Although the core logic of _is_best_div() and mux_is_better_rate() is
similar, they are submitted as two separate patches to minimize
maintenance risk.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Chuan Liu (2):
      clk: mux: improve the execution efficiency of determine_rate()
      clk: divider: improve the execution efficiency of determine_rate()

 drivers/clk/clk-divider.c | 3 +++
 drivers/clk/clk.c         | 3 +++
 2 files changed, 6 insertions(+)
---
base-commit: 606da5bb165594c052ee11de79bf05bc38bc1aa6
change-id: 20251020-improve_efficiency_of_clk_divider-631fceb70777

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



