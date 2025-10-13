Return-Path: <linux-kernel+bounces-850270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38189BD25F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1D189AF13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453E2FF648;
	Mon, 13 Oct 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA8ZmSqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223482FE580
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348928; cv=none; b=bjg6a0TVJdkc7usYS13JLLRUkavunDkYs8XSUflBIWFsY/+qhtY10xhDrhzAYpYGAuGERf/NtE5kv4jQUK2tOrTBNxuEcHYAhrmZz4MQhmPooEirndabbcXlQ/8B5vdwkQtm4kMs/HHw3A7UDxmxEUs3Pr9NpoNwZ44FiGEZrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348928; c=relaxed/simple;
	bh=EnQdu+PNxiBN5eUbwu3uRjsQYTdhGawau0XfupVj0pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxhdKKOyiAcehMQXysGd8WaHOKCUc8J0tnMdUrAPC0gr2mmg3urG4R05lJz/dpfk85W2NQiJchU/Q0Pw2S4a2yoAGHfZWDC5qhVzCuhOptyKjOgKamj7ACx8JqYxPc5aGOhuz7R9qu69r2w7GBpOcmgXDaxl9cIEDZKYXPp7qFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA8ZmSqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5763C4AF0B;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=EnQdu+PNxiBN5eUbwu3uRjsQYTdhGawau0XfupVj0pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CA8ZmSqGXnEh7RPOGFLfSW3SUIRSM5Q3Sz31jFXegNqZxUKt0IODLOCABl9CAUx8Y
	 m8THDgowcotK9gh3HjKCdF/PLSFofgkE8zttIt3o2F5KNTyhDx6cemWubWBVKRBpbR
	 hYIr6tL3e24eQBpSUJec2tCzHiI+WKHx+zq34PH5kaGNk99jTSfIa2e1Ydt+KtUT0M
	 8TzVW3xKyl1jXFGS+48Kh54abm8cjxACxfb7xAAZUW0m/t4VCV4Jslz5TeaJNaViC/
	 EhTSnI56Nfa41uhsWemR2iyP/+kcSUB9xVMOdtawN+gMbYNA8RUJbCWhfEKzdneofE
	 6JKR/AdiPyFwg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAa-0000000036c-0sug;
	Mon, 13 Oct 2025 11:48:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 08/11] irqchip/starfive-jh8100: Fix section mismatch
Date: Mon, 13 Oct 2025 11:46:08 +0200
Message-ID: <20251013094611.11745-9-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251013094611.11745-1-johan@kernel.org>
References: <20251013094611.11745-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callback must not live in init.

Fixes: e4e535036173 ("irqchip: Add StarFive external interrupt controller")
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-starfive-jh8100-intc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
index 2460798ec158..117f2c651ebd 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -114,8 +114,7 @@ static void starfive_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init starfive_intc_init(struct device_node *intc,
-				     struct device_node *parent)
+static int starfive_intc_init(struct device_node *intc, struct device_node *parent)
 {
 	struct starfive_irq_chip *irqc;
 	struct reset_control *rst;
-- 
2.49.1


