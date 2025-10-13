Return-Path: <linux-kernel+bounces-850282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90653BD2649
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAA4EFDB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC32FE570;
	Mon, 13 Oct 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrqhPctG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031EC2FE041
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349294; cv=none; b=mO+FjjxjTk/zcDNCCsqsW/vScsG3ezAsn5EsU5XV+UGe2SJOwdL7+6G4uHeM0XLnz/5nTGSDd+ZwHQEQMNU5AmReeFVLaLTSBgdgNZUbW+oEDEU8AZZ4RUjebt96k25G5RI3a2wKRC5nBYnwvjOqDrFlwYIRYaIUkjrr+7MxTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349294; c=relaxed/simple;
	bh=rj1wkoc6coBl0DL6hlOEV+BcH0MJgTi5WMsl7iIDvR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awOdUUX6PCZ9Duiqsic0f9Q9ndXgy/y8cewahTboB5dxu9lAHAksEIJsTsEKu5WbPtrEN+4GF8SmovqY6wAJG6qM08iJLdoEFuAaWOInF/Wpz9YkAA21r66FsFZQvAcGSkHqPanR/nvi90wzWGg6fCGBxX5zCy8rssDncTCYf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrqhPctG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A97EC4CEFE;
	Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760349293;
	bh=rj1wkoc6coBl0DL6hlOEV+BcH0MJgTi5WMsl7iIDvR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrqhPctGRFaXLXHC6Y80Paf8PSsEddLxzTY2N2XO2WWbvNpBpjU7Fe+lpxizc7FvO
	 UqQZXKTkZLI1jRty4yv2uzB7RsKo0iw5NDbHZUT6RsFlsZzG/zd0oWGLsYFQKCE/R0
	 9WJJLSv5/FcKld5dMNGntZanagqOLXohD17lzImc8i8RXbkY6OlBKZFYlYO6HhNC59
	 8fkrOWMOaHm6CFi5UCXrquRSgxVNe2XFRY1pePUW/eg6mPeaZGghehp3a6SXRZwNco
	 gDbXslJRQtHe7a7IAjj7GnMWCIMBwe3zUCQmr7WV0f1wJYOCUFrXcqHWwGHLrQ38qm
	 tQnrj0Yu9ztUw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FGV-000000003E6-145E;
	Mon, 13 Oct 2025 11:54:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] irqchip/ts4800: Drop unused module alias
Date: Mon, 13 Oct 2025 11:54:28 +0200
Message-ID: <20251013095428.12369-4-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251013095428.12369-1-johan@kernel.org>
References: <20251013095428.12369-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probing so drop the
unused platform alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-ts4800.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 1e236d5b7516..2e4013c6834d 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -165,4 +165,3 @@ module_platform_driver(ts4800_ic_driver);
 MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
 MODULE_DESCRIPTION("Multiplexed-IRQs driver for TS-4800's FPGA");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:ts4800_irqc");
-- 
2.49.1


