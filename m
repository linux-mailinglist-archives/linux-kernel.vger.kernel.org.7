Return-Path: <linux-kernel+bounces-850279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F9BD2646
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254F2188C80B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B02FE07F;
	Mon, 13 Oct 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN2328wF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A762246797
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349293; cv=none; b=lTH43qyVW3D6syaOCL85kGpg8bFyG0UormMLfGxozetKWGlj+5Gadx+kPDuoJBfJgXVdwBDcTBYMHYYILZRWYaf8r7UkToYkzPUji5jl7zgHMVaPRM4rc6IU07Lhe+Hh1O6lyrnMCH+rjVsmaDntorIwUvCZ4tPsslciMU6S0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349293; c=relaxed/simple;
	bh=6ubixxiLzpZMfagM4nbyLYJTwgiuYPx9z7Yh3UzUbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwEIx2plC1N+n0YafImgyInxvyplsbk1bR3LYKm3oA1IGWwD0mE1EvaWUYT8vt5us/cTWVUk3gfM4tVUWXNl+jfCrpNNeY/3jmiR8dGVHHLcsxTPXOqr1ovAEIq3PFATBykhiPQIpvJTR+vF+LWzBZr0Ph9GD7cGGzGpL13MnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN2328wF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBA9C4CEF8;
	Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760349293;
	bh=6ubixxiLzpZMfagM4nbyLYJTwgiuYPx9z7Yh3UzUbHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN2328wFsx0mVr1rFhSZe0UATDX6kJoMVqiuHAOCFo9ZaQ4j49X9mLBjQCyjEAUTA
	 gd8QzPQBM9+G1CODYsunAw15qZ2TI2dW2V2Kxw75NAjPyqe8xS+sri5sWLHTYnhlwC
	 8xycBeYFjjMzm8tlkaFxdP4FppfYED/Gwvlk6Ag6z9DeD/YL0KYo5IgG3TFQF50C3y
	 Sdj0WAPbc1hibokWv0ZcKdeoTO+kWEQix40h3j1HeJG6CDkJb0XtLI1GdoaMINX+t7
	 C8PoGKiajS9pT8j0yR/hS/vU2t0LHjeBvOK/kM8xU1h4n9Ce9kY+dcF40spCQSW/oN
	 qT6Xrwpp2clcg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FGV-000000003E4-0jdZ;
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
Subject: [PATCH 2/3] irqchip/mvebu-pic: Drop unused module alias
Date: Mon, 13 Oct 2025 11:54:27 +0200
Message-ID: <20251013095428.12369-3-johan@kernel.org>
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
 drivers/irqchip/irq-mvebu-pic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index cd8b73482b9f..10b85128183a 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -195,5 +195,3 @@ MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell Armada 7K/8K PIC driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mvebu_pic");
-
-- 
2.49.1


