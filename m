Return-Path: <linux-kernel+bounces-850954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA0BD50C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27FD482498
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAF266B46;
	Mon, 13 Oct 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tcGN4Eb2"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CD1DDC1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370647; cv=none; b=FvW/AD9obvQaUWcSwWYYDEYEe8cnwA/v2yMb7CHHgBbXgjX9AsYCytSMrM74lttHbQ4s0vI/z67wcnb2OVgsaJdn+TIVgLPaR0ykwrnx6mmz9J3drhwql8fAnEdh5FU1lNFWhAjgVRxzNi8deqNR07sehz9sg82T/CttBVuXgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370647; c=relaxed/simple;
	bh=Gt+D5JLy3ozcBhQzUhmYd8Cf6BrGurM0+4yoWKYa6/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzEWgei78kZm/WJnuDF+VPgL7yagrFNx1MpiPdnFGyzCg1pBdCWhQYMJ2/ODSaNkgcsAXZNcq575glnUbMlXWtsL+r9/B6ESdop80qiOXQcFtf209RQgzg6xQxIxaJSkWD782h5JX7y7wVGFKPjk47Gc8hyWjiX20YRtQa30Va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tcGN4Eb2; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760370631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O2RzCbaONtBiLM2iRZ147oYVwmAWP9HBYzSDSYZlKkk=;
	b=tcGN4Eb2YXqsq7mZLXDahdz+e/V8yLyv3vKBn7/GQVFyM+X+2OFCoJ9FwwOSXWIsuSYhqU
	Pps0JLwVfkgwyy2A2Bap27DsHg8mCxXKrSPazvS7cH4z9E6mhfNdM+MZSMJj5oG/jJUS1j
	eKlzwzlcVxufQCAUbRJdbB6q/IIWrKg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] crypto: fips - replace simple_strtol with kstrtoint to improve fips_enable
Date: Mon, 13 Oct 2025 17:50:17 +0200
Message-ID: <20251013155017.98725-1-thorsten.blum@linux.dev>
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


