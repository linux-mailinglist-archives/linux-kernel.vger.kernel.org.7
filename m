Return-Path: <linux-kernel+bounces-772605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87BB294BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 20:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1452001A3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07B308F00;
	Sun, 17 Aug 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFtw+0C9"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC38307499
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455907; cv=none; b=kj6N4yhkHeeMHhG5WHZp0u+0shpxg0oQBJcvSlrrpaIAKqJSTSXp1vNO/2S4dAMEjUkfIdW7Ksv18kOWXthqQB+GnI2LY3+tv3FY59xFhZJWVZPrcBgaZIiw29NCNN6D1aFh6UrMko8DGPWR30DxzQFPjgh0GTv99LNNoVebGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455907; c=relaxed/simple;
	bh=fJY9Hn5X6fwBj9qPOLL+zOp6B/KK39eIS+jAEZnHFic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKn7NjPh7kpMYatwrMn3s8ddHTVyzJKMqopZwW7R+1uFqMsSlKaeWmQWLfaGMCv5KfKiYRcrNNPshO3TCbFhrwpEhKJ31AmmlZF8qjMIntEGpghd5/wpbtkvPIQGbfhZj5J45pirDBVxpEG1Fo+y0ligPA7zHeMPgQQO1g0ClkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFtw+0C9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755455903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTLyVJdnJSqJzfv2wSB+GojMw8/ExsZgdVuGQVNhQ3Q=;
	b=bFtw+0C9UJIuIIKn2o7TTkf2Z0DgBS8CvvEv6f/rd00RTfAPFS3iDiHIXLksuZIbKOfsVe
	ADK2zNE679aYvrq1KaAGfGusI6X0w4jGUrq9lobgMnQkw4ftF98cN4RREFwq7Os/b6P4S+
	9yT7K0wgKpU9REA4JOmW8UDFMDOEHyE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] MIPS: generic: Replace deprecated strcpy() in ocelot_detect()
Date: Sun, 17 Aug 2025 20:37:18 +0200
Message-ID: <20250817183728.612012-8-thorsten.blum@linux.dev>
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
 arch/mips/generic/board-ocelot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/generic/board-ocelot.c b/arch/mips/generic/board-ocelot.c
index 7115410acb4f..59a0fb243582 100644
--- a/arch/mips/generic/board-ocelot.c
+++ b/arch/mips/generic/board-ocelot.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2017 Microsemi Corporation
  */
+#include <linux/string.h>
 #include <asm/machine.h>
 #include <asm/prom.h>
 
@@ -41,7 +42,7 @@ static __init bool ocelot_detect(void)
 
 		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
 			/* ignore all built-in args if any f/w args given */
-			strcpy(arcs_cmdline, prom_argv[1]);
+			strscpy(arcs_cmdline, prom_argv[1]);
 	}
 
 	return true;
-- 
2.50.1


