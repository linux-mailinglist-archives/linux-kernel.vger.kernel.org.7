Return-Path: <linux-kernel+bounces-855368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4CBE1066
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8E1A21047
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDB2C3258;
	Wed, 15 Oct 2025 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NbnSpDOX"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D75315D39
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760570512; cv=none; b=BrUDbnhtq8XqazULHxgHVeJdqdl9VxNfD5EAcpssGXyqHDgdDR6LpNyxfFu6SdCpKauew5Ad8Ng8ac4dycHfbkWcV3w5X6mUMyWoH5Sbq/b5g6QbDW506s9z1VEvHdX3d+X+eXOw7n0yl6rq8oPcKcPGtMWgvpNS8FjzVpma8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760570512; c=relaxed/simple;
	bh=yWic66bS3VynQ/DlDLVXJvCD4KLELc71hnpgwtJZVKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGN5HYZwKNnVGXwDDiNxHKmi92SIQtdK9IogAVU3RTsO+jirl5VkpYoPb7naJHzwSTamKIJ/rIFCx9kWmP8AI3zz3QEFqioYXhZfGIvKx2hQesiuZbgnMHOJWbAa5fItPg/SZs7srA8nUOuxTLQ4KcT3T7jEHofwo2QpAdL+OiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NbnSpDOX; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760570508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I5xh0RH6Adw5rpUXdBY/V9hNljoQ73UVKA6h/cH9mIs=;
	b=NbnSpDOXfgB+2vXNaETYYzcZnRsvNYkp/oD8PO15y+dwLD/qd5pEYUVNUjyxHLR6Hjt1El
	7klBluFJmj5Bn05GWOfmQMpfYTPmOOmcd4GNBuak70EvFYkViDipUsjUAGIeHBo0oUChz/
	WplCn4rgsEg1j9AxIew0ofoR8DfswHk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: encrypted: Simplify determining 'format_len'
Date: Thu, 16 Oct 2025 01:21:12 +0200
Message-ID: <20251015232111.71276-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Don't unnecessarily negate 'format' and simplify the calculation of
'format_len' in encrypted_key_alloc() and __ekey_init().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/encrypted.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index aef438d18da8..d70f71d37f5f 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -581,7 +581,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 	if (ret < 0 || dlen < MIN_DATA_SIZE || dlen > MAX_DATA_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	format_len = (!format) ? strlen(key_format_default) : strlen(format);
+	format_len = strlen(format ?: key_format_default);
 	decrypted_datalen = dlen;
 	payload_datalen = decrypted_datalen;
 
@@ -704,7 +704,7 @@ static void __ekey_init(struct encrypted_key_payload *epayload,
 {
 	unsigned int format_len;
 
-	format_len = (!format) ? strlen(key_format_default) : strlen(format);
+	format_len = strlen(format ?: key_format_default);
 	epayload->format = epayload->payload_data + epayload->payload_datalen;
 	epayload->master_desc = epayload->format + format_len + 1;
 	epayload->datalen = epayload->master_desc + strlen(master_desc) + 1;
-- 
2.51.0


