Return-Path: <linux-kernel+bounces-748208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE3B13DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716EC7A3844
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120526F477;
	Mon, 28 Jul 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YsXIzZvM"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4C237163
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715324; cv=none; b=fNX6z8YBRIyc/mEFAePlZq9XjJwMnqXtM92cJCn2wydNg8iXGghdNcnFZDHBW7bZH6ZjIZS9cpIM1Ksfpk5pXJ8B3FhQRFs8ugxvP9AT+aB4JFsQP1q5fn507C8I18c2BgKocF98isDbt8ILuEulNSpQZt05DuVoA0blneqso0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715324; c=relaxed/simple;
	bh=81lb7JhdkNUJiRGoDCraiiNmLgWiBQkVHxlWlQQbjpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGuGn+iylLQKH4uvbZdsHR4VI6tWlRDyB0qkZVMUPA6iEAcRWPqlTqfr9+A1T2B+pv85N4wWzpyi6BKz1A6xhOelQ0q8YITpHXH5hyKSNyHAM8lOQdmteeVFHMf6R1Nm1MauieMaQvg6N0YlfYShvN/kRQ7ot86JH1Yvv0i8XlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YsXIzZvM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HIeh66fvqevC2YKpYfC5ton1/7+U92lXMTA4Rc9xuHg=; b=YsXIzZvMG0ey0I8wKR7Aw5hmJd
	hKk1B6MYHLgvvq74pedKKS8U3O2YnWL2IJCuiDPWhqw3hShrt86kbcvxQqqTxGXP3DLm2Xy73UHfJ
	6flVW93oa/pm/5WYHYcnA9KtSPnMv0mJzLRAJLSbtT6HbP6vvo4kJJMKSY6d0QCCmNpeRwfKcYm/L
	4JTuUHru4Cm1WKMVmLMa4AqvsIvIkXfZiJe0tnFjH/ysnmCcTg7Q5iNtHgOy5hrButRO41iXN/Opa
	5X3g6u1/jFNOCfP07cabOwp8G/0zLo0mbpieAoGbgtw/XXn9f9edgiGOIsCePjWKjiuZ1DxnfILPU
	7ed4Bz9A==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ugPSu-004xby-OC; Mon, 28 Jul 2025 17:08:36 +0200
From: Luis Henriques <luis@igalia.com>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] regmap: mmio: Add missing MODULE_DESCRIPTION()
Date: Mon, 28 Jul 2025 16:08:29 +0100
Message-ID: <20250728150829.11890-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were already several commits to add module descriptions to regmap
modules.  But this one was still missing:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-mmio.o

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 drivers/base/regmap/regmap-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 99d7fd85ca7d..29e5f3175301 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -609,4 +609,5 @@ void regmap_mmio_detach_clk(struct regmap *map)
 }
 EXPORT_SYMBOL_GPL(regmap_mmio_detach_clk);
 
+MODULE_DESCRIPTION("regmap MMIO Module");
 MODULE_LICENSE("GPL v2");

