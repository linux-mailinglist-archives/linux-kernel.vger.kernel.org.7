Return-Path: <linux-kernel+bounces-727068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E0B014A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0373A5DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF301F4261;
	Fri, 11 Jul 2025 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACU1Fqjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D981EDA0F;
	Fri, 11 Jul 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218843; cv=none; b=ZKMDVQZaXi19uBIpP4Vvaf01fCEmfvpKRHl0ZmjAGH7epCXZYzJQ5FbWzv17W5QELjRtPBl7ZOUkWzd08kC8GaROXPVl7AnjAaHxoTANj4hyPW3IxVSMUN6u9yo7W5PB6uYIizyt0yOpc15vE77jzMuiGvOIldAFnD6AC7JJsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218843; c=relaxed/simple;
	bh=vQRwotoAgVJ0lAndow9DIf367RcCHh0hiNp7rDPCxCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YbZsLq5K4Lo6rlUeeyuccrvh8iU1qEvQUfwnZvSup0g3Y/G0KT6NzssfW9Ns4iZIPz+Cn1P5DKrQBCSRGafMTQwQtg3LnekB7DONSOrhtFk/FoTPP3CRxkkiifFRSRYT8KhueW2d7gAKgNQZ6yXsAjts2fdGt5aXQcaK/S9cwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACU1Fqjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4760C4CEED;
	Fri, 11 Jul 2025 07:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218842;
	bh=vQRwotoAgVJ0lAndow9DIf367RcCHh0hiNp7rDPCxCA=;
	h=From:To:Cc:Subject:Date:From;
	b=ACU1FqjryQZdlspB0+czXPZGMsrXQHhz2YH+gZf248YvYoJsMCyxW35hDx9toZbPI
	 jnSib3r7aQYwvRdQDCXvfvc4lSDhGamSygw4hZhsPIujW/7Fs3w70QTgm4pavArMqv
	 hlwPFithhgG9VuPHGanR0f01DN76EYSyysRazGf+Hjo0nnUsB7Ycku8FL/W/xhfkCO
	 YkYLYyuW72mAAoHqaDlD8NyXZ0AJMWlr4gT9Yqzc7dvPO2M52HGPybWwXx7/JkJxZp
	 ludpVi96N2HqyQCOBcGrHo0G+o5A3qW3bswdII0Qx52c2Jlv73IRiYCMfKJVU64mzT
	 JvzekYqdhDmhA==
From: Arnd Bergmann <arnd@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmt/discovery: fix format string warning
Date: Fri, 11 Jul 2025 09:27:09 +0200
Message-Id: <20250711072718.2748415-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When -Wformat-security is enabled, this new code triggers it:

drivers/platform/x86/intel/pmt/discovery.c: In function 'pmt_features_discovery':
drivers/platform/x86/intel/pmt/discovery.c:505:36: error: format not a string literal and no format arguments [-Werror=format-security]
  505 |                                    pmt_feature_names[feature->id]);

Fixes: d9a078809356 ("platform/x86/intel/pmt: Add PMT Discovery driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/pmt/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/discovery.c b/drivers/platform/x86/intel/pmt/discovery.c
index 1a680a042a98..32713a194a55 100644
--- a/drivers/platform/x86/intel/pmt/discovery.c
+++ b/drivers/platform/x86/intel/pmt/discovery.c
@@ -502,7 +502,7 @@ static int pmt_features_discovery(struct pmt_features_priv *priv,
 	}
 
 	ret = kobject_init_and_add(&feature->kobj, ktype, &priv->dev->kobj,
-				   pmt_feature_names[feature->id]);
+				   "%s", pmt_feature_names[feature->id]);
 	if (ret)
 		return ret;
 
-- 
2.39.5


