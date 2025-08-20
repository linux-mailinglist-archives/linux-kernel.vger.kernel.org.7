Return-Path: <linux-kernel+bounces-777096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A08B2D527
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393977256C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238592D8773;
	Wed, 20 Aug 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jE1pS826"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400A2D8DDD;
	Wed, 20 Aug 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675804; cv=none; b=n7IKz55ji9iq75lif9rrXl+2NNK/j+UiwHwetpfQggh78KMDL2Ib+ofenxKNOFUo1Dc8bHaUlAQ97gsHchXC9fqJgpieh956/BIO3eBGQY8Fyg+L7eVMzoHoYQm/lzcQvXRBS/rnsMrP7wdWcLFmiI0UKPi+UyEZoTXlcz8DnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675804; c=relaxed/simple;
	bh=Im+oemJDXWL80mEoHEC/AYrA40M35zJiJWeGpLm6Pjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdftZhULuotSLsYFttCT5dro41frQlAet7IwVfZ84KcA6yXH/S0IJoxAFs6kiRDjqSVgPw9SuaRJcmwP84kF2hRusRLlf4Dv8vpMNSuns1s7PbqZfXmd6wpI6YT0cE/EtzWzkNW01tFnkRl5Wxndoqs33/8eFDsgfb6+S3oKlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jE1pS826; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9879320D9F;
	Wed, 20 Aug 2025 09:43:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAWoSrNxQhzA; Wed, 20 Aug 2025 09:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755675799; bh=Im+oemJDXWL80mEoHEC/AYrA40M35zJiJWeGpLm6Pjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jE1pS826qnrHeJew7gQ5Uci75z55bkn53V4TQ07BBr6WL5l5ScF4AtWIfe4kNYSvN
	 H7WAu8z1V44qJbG4+Rl1ShJqaQL6oX5Yln898RzQA7AVw6HNRk3i/EfdJrNpPizHU+
	 4gkMoHqxl5DuoSlAV7Wo063TK4usv1offxnkF9Z2oyjYPM4EdJlQp43nmeQdcC/KKk
	 Y/H34MOxBQaobpWLMNVhDZngQxPIIG0ZAaefsgrZBHBQy2gJ3CujlNYirBAMs3N0l7
	 uomlqn9r8z2oNPQRkpmUtHkjkWzaOk2egOWt0DCVS+QxbFLfKuI7qIy2t5r5ZZ3rm+
	 iieguHInu0mdw==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 2/3] reset: th1520: Support the new compatible for VO-subsystem controller
Date: Wed, 20 Aug 2025 07:42:44 +0000
Message-ID: <20250820074245.16613-3-ziyao@disroot.org>
In-Reply-To: <20250820074245.16613-1-ziyao@disroot.org>
References: <20250820074245.16613-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset controller for VO-subsystem is previously described with
compatible "thead,th1520-reset", which is misleading since it implies
control over all reset units on the SoC.

A new compatible, "thead,th1520-reset-vo", has been introduced to
describe the controller's scope explicitly, while the old one has been
deprecated. Let's support the compatible in the driver.

Fixes: 4a65326311ab ("reset: thead: Add TH1520 reset controller driver")
Reported-by: Icenowy Zheng <uwu@icenowy.me>
Co-developed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/reset/reset-th1520.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
index 14d964a9c6b6..4c8ea35b174e 100644
--- a/drivers/reset/reset-th1520.c
+++ b/drivers/reset/reset-th1520.c
@@ -154,6 +154,7 @@ static int th1520_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id th1520_reset_match[] = {
 	{ .compatible = "thead,th1520-reset" },
+	{ .compatible = "thead,th1520-reset-vo" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, th1520_reset_match);
-- 
2.50.1


