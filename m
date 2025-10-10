Return-Path: <linux-kernel+bounces-848514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF5BCDEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20310356412
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545282FBE19;
	Fri, 10 Oct 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4u622Eb"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A52FBE18
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112913; cv=none; b=j6Uo/vC7RIm5M6pwH8F9IFwkjrMcFDKVZDP5g2QZEYk58JVzy+aspBIQsnIV8+e2BTenSiHenNH+2vC01bZLpO9TmnjWxlg4BKiWZIsM73GWRaAaDnJ42zyPZgd3JA9MtIP0KksC9xdS8WPT8hwrhA/ByZY0mqc0kZ2kuvATv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112913; c=relaxed/simple;
	bh=Jm7FTEMnwjzg9jCDhP0RaeNpgQAQIuFpj4woyZcdomM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxwb03nRq+ODEix3EZiqpwEfS39EiwUInnjOtv9Yh+MWqb2EQ7n+/EPPJUEoRZEAF3iju3BJO1smy9BOmbhtSXE9nYOLWsEujc82QlmLbaAF8GnKWr6Yu7J18HN74hhZwVs4OG/AcXVf1H0BB0QYWG1o8r4USbPdhRj5uRcfGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4u622Eb; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760112898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hUesLH0rkewj8vRVTXAeO7f9nSxFyDmZ3Qc6OIr3lm4=;
	b=a4u622Eb4ZSvgArHIk5fPgdu1k17rOGmf/4fRPbQljU+fQxK/9fe/JiElatGD0zc1ARxrX
	TugZNrgFJUpOVXSGGOBbti5r0QC5UtTpOxRDjswqE2ml6gfesdsfghNLZBAWlRASbT/Ltj
	jxnf7W/XJiALR33Joa9uub0762lEye8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] keys: Replace deprecated strncpy in ecryptfs_fill_auth_tok
Date: Fri, 10 Oct 2025 18:13:41 +0200
Message-ID: <20251010161340.458707-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy_pad() instead to retain the zero-padding behavior of strncpy().

strscpy_pad() automatically determines the size of the fixed-length
destination buffer via sizeof() when the optional size argument is
omitted, making an explicit size unnecessary.

In encrypted_init(), the source string 'key_desc' is validated by
valid_ecryptfs_desc() before calling ecryptfs_fill_auth_tok(), and is
therefore NUL-terminated and satisfies the __must_be_cstr() requirement
of strscpy_pad().

No functional changes.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Improve commit message as suggested by Jarkko and Kees
- Link to v1: https://lore.kernel.org/lkml/20251009180316.394708-3-thorsten.blum@linux.dev/
---
 security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index 8fdd76105ce3..2fc6f3a66135 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
 	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
 			     | ((uint16_t)minor & 0x00FF));
 	auth_tok->token_type = ECRYPTFS_PASSWORD;
-	strncpy((char *)auth_tok->token.password.signature, key_desc,
-		ECRYPTFS_PASSWORD_SIG_SIZE);
+	strscpy_pad(auth_tok->token.password.signature, key_desc);
 	auth_tok->token.password.session_key_encryption_key_bytes =
 		ECRYPTFS_MAX_KEY_BYTES;
 	/*
-- 
2.51.0


