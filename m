Return-Path: <linux-kernel+bounces-872659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D6C11B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7705640B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35D2EFDBA;
	Mon, 27 Oct 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uMyl8VTG"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0272E5B12
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604427; cv=none; b=WZs4dzLpH7O2VftRqRuQqLjWiU58TTJmtjZ9CbF/dtaiyrN3FhEYHiYVLNjtDxfiuCc8/HM4BwcQHwN+YLY6Fh8MmyowBNTXEnk/DzefB3JIMpxczPGF2oSX6t8OJU6U6HQzrBWTpIzffN3S2c3ewEPWXjZPxutKYEUM/dQWt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604427; c=relaxed/simple;
	bh=oSl6XxwG23+IDZ+qeuPsSWZMvKhnBUnSCRxaDztoGdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfwiKvvfNbTY7v2e0KfvqNfw5FRuc/7sJHmW+/xKJhpETin8iWhXOq3XKjWSdv8o9x4FD4VLielnQ6OuQsACgRQkTqnQTv4tqOwVa5/sBvNLpkMcZt+7IldjDqiEcY/W/JMJJnA1AuRcfOnNEyWJOpdByUIUSktj0dQIcVJbD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uMyl8VTG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761604413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rz80D0a4L8SFtmWZzMuQItK6P07V66/wgh+8udb40jQ=;
	b=uMyl8VTGHvzeGx6FaDa2se7MruK3zMsDW8oCVqqCQ9gfF/BzOp7f172txgpR230ih3y6Rp
	w1Kz80336t5SyT0i729O84U6BOACA6DoeVBQl5WSDZB1uh+MeDYegYCaaxv0bNZ347dDlT
	/9GvWEtB+/o513j7ksvsJuRxYpqF0wY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] keys: Fix grammar and formatting in 'struct key_type' comments
Date: Mon, 27 Oct 2025 23:33:00 +0100
Message-ID: <20251027223259.190625-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/it/if/ and s/revokation/revocation/, capitalize "clear", and add a
period after the sentence. Fix the comment formatting.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Capitalize "clear", add a period, and fix comment formatting (Jarkko)
- Link to v2: https://lore.kernel.org/lkml/20251025095519.84361-1-thorsten.blum@linux.dev/

Changes in v2:
- Adjust the trailing '*/' as suggested by Jarkko
- Link to v1: https://lore.kernel.org/lkml/20251016123619.98728-2-thorsten.blum@linux.dev/
---
 include/linux/key-type.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 5caf3ce82373..bb97bd3e5af4 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -107,11 +107,14 @@ struct key_type {
 	 */
 	int (*match_preparse)(struct key_match_data *match_data);
 
-	/* Free preparsed match data (optional).  This should be supplied it
-	 * ->match_preparse() is supplied. */
+	/*
+	 * Free preparsed match data (optional).  This should be supplied if
+	 * ->match_preparse() is supplied.
+	 */
 	void (*match_free)(struct key_match_data *match_data);
 
-	/* clear some of the data from a key on revokation (optional)
+	/*
+	 * Clear some of the data from a key on revocation (optional).
 	 * - the key's semaphore will be write-locked by the caller
 	 */
 	void (*revoke)(struct key *key);
-- 
2.51.0


