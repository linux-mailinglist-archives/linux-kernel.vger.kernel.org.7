Return-Path: <linux-kernel+bounces-817831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D6B58737
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F8D1AA8590
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3982C08B2;
	Mon, 15 Sep 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fO+1hsr8"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A042C0260
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974390; cv=none; b=lN2cRU8JG6uujt4+vur8CGezmupmgm/Mqknoyf3drbern7dz8z9w1Nc/5PboPp90Ai0e8qCw2uLXAFEZZsGHImFdcJ/Ftw0TbxOc8mFR0Wtbe5P8LC037tv2JdR4ooiXlulnclGcNu78rkpBchxXks9uiqujww5pHUKq3nEfYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974390; c=relaxed/simple;
	bh=Gt+D5JLy3ozcBhQzUhmYd8Cf6BrGurM0+4yoWKYa6/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbaRKRsewGHRVqiH+uXeaXDguVN6iuz7Of1iv+4QVwDJPOGOjk+GbSfgpDxOelMEPeFieZioRSn/nauheRIccHJ3HPutaPb+NevudW4tOmWLRDR8xCekjbTaJbRQscTvPQYz9GT7uY/SgFJ5TQ1kOmr2f+3UX0DyNkUT9GAcu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fO+1hsr8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757974382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O2RzCbaONtBiLM2iRZ147oYVwmAWP9HBYzSDSYZlKkk=;
	b=fO+1hsr85eVLiPQloLb37dGetL1eUnVm19CG7cHyOjiI4bMRgM9nNhzo24OVmFFZvvTnZD
	oQN2B7+lBcnbuxmCHRhnpwnfRGY7/f22XcmK4CwvKGMXsm8LMwGwZjf/uDf2QMdR0pnSMm
	NrQM6RHtgaFtXThEsCCksq551H63Jp4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: fips - replace simple_strtol with kstrtoint to improve fips_enable
Date: Tue, 16 Sep 2025 00:12:45 +0200
Message-ID: <20250915221244.2419149-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtol() with the recommended kstrtoint() for parsing the
'fips=' boot parameter. Unlike simple_strtol(), which returns a long,
kstrtoint() converts the string directly to an integer and avoids
implicit casting.

Check the return value of kstrtoint() and reject invalid values. This
adds error handling while preserving existing behavior for valid values,
and removes use of the deprecated simple_strtol() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/fips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/fips.c b/crypto/fips.c
index e88a604cb42b..65d2bc070a26 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -24,7 +24,10 @@ EXPORT_SYMBOL_GPL(fips_fail_notif_chain);
 /* Process kernel command-line parameter at boot time. fips=0 or fips=1 */
 static int fips_enable(char *str)
 {
-	fips_enabled = !!simple_strtol(str, NULL, 0);
+	if (kstrtoint(str, 0, &fips_enabled))
+		return 0;
+
+	fips_enabled = !!fips_enabled;
 	pr_info("fips mode: %s\n", str_enabled_disabled(fips_enabled));
 	return 1;
 }
-- 
2.51.0


