Return-Path: <linux-kernel+bounces-775358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC09B2BE55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7380688376
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5A320385;
	Tue, 19 Aug 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLyPRw5r"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6D31CA58
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597594; cv=none; b=sPPGP1NVZ3vtsVDYLD5tZ3h+vonSclGe/RhdPJiFhH/7wtKK0Rt4GET8vqLQ29xH0IMXxmZ3oG+okDw/d1hjnM3uPGFYJgq/GcYqjsdoi0uJF4mteNvGij+cRy0F8cAzmPeAhmkboSkzZQ6jm5DUfjuYUdO5wCHES8978Jp9j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597594; c=relaxed/simple;
	bh=5uC7avEAroUHszmN3378fl0744kkJoutyK9Vg/4xQ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDkCUOEGJGiMwJcLZ4yJXv6b+yF7uYpHjZJYrDeVKyBa04tri1mqcN04zqWAmhFs0uCjPiVrkZEn1TUeNb45Wi88YwEv4K6/SeAjZOAV/G1Xc+ltL0Jhxj6tD0UFuJJzDrIMXiZLquLgS8tkKeJUr7FiVZB+DDxqTct9bp0fWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLyPRw5r; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755597590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApYXekxvMIeIP2temzcHX8ZqK3v75ye22TOwGTEGqr8=;
	b=TLyPRw5rgsZ5pQ05QxWd+0/EVWUUMS4WdOOTwxjmlL5ilB0nUMz5mGt6R2pGFTdSwL2OI9
	fyZ7JOFcDvbQXioB6rJciWmnSkVkOa36BcNEmRpRqHe3EJl5ts9APMPnvpwt61n3t1Q787
	WjycWsR7pren36s+CiXia0XTPsSDN8Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] kdb: Replace deprecated strcpy() with memcpy() in parse_grep()
Date: Tue, 19 Aug 2025 11:59:05 +0200
Message-ID: <20250819095915.711085-3-thorsten.blum@linux.dev>
In-Reply-To: <20250819095915.711085-1-thorsten.blum@linux.dev>
References: <20250819095915.711085-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

We can safely use memcpy() because we already know the length of the
source string 'cp' and that it is guaranteed to be NUL-terminated within
the first KDB_GREP_STRLEN bytes.

Link: https://github.com/KSPP/linux/issues/88
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7a4d2d4689a5..cdf91976eb7c 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -860,7 +860,7 @@ static void parse_grep(const char *str)
 		kdb_printf("search string too long\n");
 		return;
 	}
-	strcpy(kdb_grep_string, cp);
+	memcpy(kdb_grep_string, cp, len + 1);
 	kdb_grepping_flag++;
 	return;
 }
-- 
2.50.1


