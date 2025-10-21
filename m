Return-Path: <linux-kernel+bounces-863641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF2BF8AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C7A19C5295
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3334274B5F;
	Tue, 21 Oct 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="Fb4KkOv2"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7516366;
	Tue, 21 Oct 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077732; cv=none; b=MWGPMvSNtk497lEKUX/aee29LNjCU1mGXYOMH/faB0dT80VUAPc0UwTbASLW8qbnK8bFO+JBigzbGNmUze9e1s+49upgoFqtvp29dcWU39iCIOE+g3iI/9F0m07CR2L5h+noZ5oUiFCjNZJ73ffNMGHMcEbibLplzEMjAo2hrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077732; c=relaxed/simple;
	bh=uiQE3F6PNrH2qUqlwFl2M0IAS6OtWbqRebDnn5BkzHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR1kxZjPMeWrpU+wQtf1z9gw5jsdnntu/4EiEOdd+TWA8BskTRXwsM4/FnRnn7ODvhg8lEFUOAJD2nh56vLlc8dZxJlLO3xDTnE84xi2d2kf45v7vSzensIqwAWZsE0Ltz4zvC3maRuZ4sMEs35TXzJOi+M0SNiXmSATyj0/hiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=Fb4KkOv2; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=af2q0eyIVeKU9fcGvNX/nR6ZwHN1BAkM9i1dSmiJRBQ=; b=Fb4KkOv27NT9ibbJKtuIYmC2cu
	FvDx2pHnmouhKkw8XWoxexNGk2OIjYLkK0oIFE4IqiXeLQHiGkQvkOGgzJGX1Af7gN8hbWrQE7r1h
	LuN8hqhHmCg04MVvm4lHMJ4w2GSiiGLt19kz/3IUNpjeHqdCpxoPODq1EhmdVtriNNcj3D9x9LgKo
	EWoO7/uVqnq/qVR0I2hbwX9LPxeCfLrv65Ez/Pjpkdper+LhKb8MIvfEqMr6tpyYwbdI0qJC2p5vj
	rnQi+VIq7Csw4XkcDFDjSaiREiZM+mPPbgDV3orDTPDsr+KHAYDdLMNoh5a3ovYnPe+Tczssl4+Of
	WI7Lwk0A==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vBIl8-00GWoD-0i;
	Tue, 21 Oct 2025 22:15:06 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE:Keyword:riscv),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit)
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH v3 2/2] mfd: simple-mfd-i2c: add a reboot cell for the SpacemiT P1 chip
Date: Tue, 21 Oct 2025 22:12:00 +0200
Message-ID: <20251021201451.1013640-3-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021201451.1013640-1-aurelien@aurel32.net>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
v3: no changes

 drivers/mfd/simple-mfd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 0a607a1e3ca1d..542d378cdcd1f 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_config = {
 };
 
 static const struct mfd_cell spacemit_p1_cells[] = {
+	{ .name = "spacemit-p1-reboot", },
 	{ .name = "spacemit-p1-regulator", },
 	{ .name = "spacemit-p1-rtc", },
 };
-- 
2.47.2


