Return-Path: <linux-kernel+bounces-753025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA56B17DE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EDFA81640
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC002185A6;
	Fri,  1 Aug 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDtDou3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F721638A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035126; cv=none; b=ilsKmHMyqnMyTaK0+GJjoM+MbvqobfWGN83i5mEZgabwkm73AAiir8NXhV3HbUh5mSis0pHy817B7bpon4tMVScpGj84MAL2FcDEbugiM2XrgJWvmm/elAD0mrGoL8lI4ZzVCpsFm/xJOWpKiD53779a0iFs7A9fxo0JvbgFA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035126; c=relaxed/simple;
	bh=rd8uhK267CHyby4vwT8kjROd6FNXsXkTCVPHV119wCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFCyYTUUOHPvSzTvL71DBA+WpkSCg+V/pjcUjUZhQzuPDj03sXylreETnArUm6Wp0m2W3Ti+YHATCNI4oxCjoUC4vW+drB/z8bSIPxM/QyAJ60uwnK+ftRjRFdkKwo5nvdSPX0NpI0jnlxEvgXlbjik7iYeYEJtasR8pjoWt2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDtDou3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF0C4CEF4;
	Fri,  1 Aug 2025 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754035125;
	bh=rd8uhK267CHyby4vwT8kjROd6FNXsXkTCVPHV119wCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DDtDou3GSdHKVOn/Grs8mhyGSRXzuCP77/pv03mbdFjHBGVXFH3IE/JbZHboP+p3R
	 57tsHF+osST0uJyFMsx3seXYvGsMBpD5zCZalpsZF2roy81w83t7b1YoVqngUB5OvE
	 bjiVcrL2gFGS6KEKoGfvsPOqe/wwM9trV9GxofKJSvs5agCa789fyiMp6I6+/6RqkX
	 vEH+m12EAbFU8bZpJ6kx0Q6L8AceQnBLDo0X+5JcTcI8oTObMGamdoARmcZeM56Xdr
	 CyJp43/RG4tf5Z9ahaivXcXpA6wU6Pxvf3HrXHScHZvm7exJoXohLaSJDJNOl0U+Wx
	 OwfkAh1lB7g1g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 01 Aug 2025 09:58:19 +0200
Subject: [PATCH 2/3] irqchip/gic-v5: iwb: Remove module boilerplate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-gic-v5-fixes-6-17-v1-2-4fcedaccf9e6@kernel.org>
References: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
In-Reply-To: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Timothy Hayes <timothy.hayes@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

The IWB driver cannot be compiled as a module and is as matter of fact a
builtin driver at present.

Make it explicitly so by removing useless boilerplate and by using the
builtin_platform_driver() helper to initialize its registration
functions.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-iwb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
index ad9fdc14d1c6..c3a3b30e9f4e 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -263,7 +263,6 @@ static const struct of_device_id gicv5_iwb_of_match[] = {
 	{ .compatible = "arm,gic-v5-iwb" },
 	{ /* END */ }
 };
-MODULE_DEVICE_TABLE(of, gicv5_iwb_of_match);
 
 static struct platform_driver gicv5_iwb_platform_driver = {
 	.driver = {
@@ -274,4 +273,4 @@ static struct platform_driver gicv5_iwb_platform_driver = {
 	.probe				= gicv5_iwb_device_probe,
 };
 
-module_platform_driver(gicv5_iwb_platform_driver);
+builtin_platform_driver(gicv5_iwb_platform_driver);

-- 
2.48.0


