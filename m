Return-Path: <linux-kernel+bounces-772600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814DEB294BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790B917F3E0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5573302CBD;
	Sun, 17 Aug 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kvQ49TOE"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFC30102D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455898; cv=none; b=IoqkS3ovVZwapbvHFrGcKasrLA1rZGBYEI6HQ7EthgBsYfdLFBiuSTH7XF0ETrk5xah+Xpt8QqtWHF7RHYQj9+dvIcMBpCZs0bBMj3CeoIDGFeCpmmeEty0bavS87R0CP6fzZsLASPiRQeF5U5m72mYZP7ymkfWxoSLJ/Gq0YtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455898; c=relaxed/simple;
	bh=MIPEmkj8ov40oghApOnZj6uHa4v1TUsDCFIbFhrjr00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYqGr/2QO4pZqUbQqGn5mAMdj6bp5pWWbqWLe9SS5NBLtlnT0OWNhM5CAopIRN8w7pcmJHB2foB29PgP5fIPEbPqbnVd1XODiwNbzk1Meyl7HnxjycM0hKVorT6TxSR1Ejp2Girr1tKelwQjyxZb3G4dUkPqd6mnFLgjUrJPgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kvQ49TOE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755455894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQd3fjTE0bv5k0utUixn7f4BcezD3BFIk5BYH/5tHhc=;
	b=kvQ49TOED4OS6VPH/JogC1VSquoWosgYj5mPa0rt2WeWkLAKR4IhFGpDPXKylHtjURVU03
	myo8tCZtt64f8aISDgoLjU32+AH1HZqQnQv3syRQQJIwrhCNNawOcs4DCmy1moB4dbUfWy
	CA/SJbfirsq46ON/4nLHG5Mftn6TZC4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] MIPS: txx9: Replace deprecated strcpy() with strscpy()
Date: Sun, 17 Aug 2025 20:37:14 +0200
Message-ID: <20250817183728.612012-4-thorsten.blum@linux.dev>
In-Reply-To: <20250817183728.612012-1-thorsten.blum@linux.dev>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/txx9/generic/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5dc867ea2c69..03f8a3a95637 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -200,7 +200,7 @@ static void __init preprocess_cmdline(void)
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
 	char *s;
 
-	strcpy(cmdline, arcs_cmdline);
+	strscpy(cmdline, arcs_cmdline);
 	s = cmdline;
 	arcs_cmdline[0] = '\0';
 	while (s && *s) {
@@ -270,7 +270,7 @@ void __init prom_init(void)
 	preprocess_cmdline();
 	select_board();
 
-	strcpy(txx9_system_type, txx9_board_vec->system);
+	strscpy(txx9_system_type, txx9_board_vec->system);
 
 	txx9_board_vec->prom_init();
 }
-- 
2.50.1


