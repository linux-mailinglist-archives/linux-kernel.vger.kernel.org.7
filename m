Return-Path: <linux-kernel+bounces-847825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE70BCBD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AA1E4E96CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8D26CE2B;
	Fri, 10 Oct 2025 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="k0icUu82"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2842AD16
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079178; cv=none; b=hghgzc2yIOjEmzpAKf8vacjfKPNedHAMp77uZgqdeM1HpUZsXh2WKnsX3cmmrr6yjucjcuE2A3UdQbTqCOot5bxv/VvW6JPGVvayLXOW9+0smN/vCia/zt9AfkQpa4ndTe7vUOHv2CB6mUvslwFspVkyHhBdu0i4JBxGiw85jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079178; c=relaxed/simple;
	bh=KX7lzwpNEotn/b3rUi+RyFrZRcNxyheFetbZlNRP9Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upRUZcQJoC5prEElvFJ166plz3wxd81DarckPwYSIS1neSk3rUW9tUQnrIugcuzXPmDRLmhhs6hGb0m2LA1WVJL0l+6Houd1lQgxQZLtpoVsBtu7/CkW+2bgBhzDIMGDoLP5ugwUIcrSwMgvsLtgNYhKGm7Uk+lC2ILKNJZAcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=k0icUu82; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 62403240101
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760079175; bh=4KtbrKcuo2oXPvw5UPLDbrYNrbLO1DC0VXXnWtEBq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=k0icUu82oj94f3xDEctZ8BFI0zN9i1518i4kI17HIHhLoXv40nnzWGHhgMUykv9MR
	 nGr5f7leOqanPPL0C3JXHR+5BgU8pB0PHmctcBqgdz/t3VILWMEOKwI7Rdugw+mLb9
	 dr7ZM/E5kxPuSEB1z9Tgj3FEYxHvChEPdfL7FVpkj29Np94OKcoQjswlhJix9g4QJC
	 sRf+vvKEE7QKVdk2qGW9/TY/xNE2nu9g1Tqqzxku28mCE/QRP2Rg6zDgs53ii7Smyd
	 +1BJnALptySWSE/VEa7u1dTIdB5RFIc6YlFcogj7qf4/sCSF8dnrQnQJzDsLOq18wh
	 SHw9PkSUpl1iA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cjcrQ40Vcz6tw8;
	Fri, 10 Oct 2025 08:52:54 +0200 (CEST)
From: Shahriyar Jalayeri <shahriyar@posteo.de>
To: jarkko@kernel.org
Cc: shahriyar@posteo.de,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: infineon: add bounds check in tpm_inf_recv
Date: Fri, 10 Oct 2025 06:52:55 +0000
Message-ID: <20251010065252.4377-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two buffer size validations to prevent buffer overflows in
tpm_inf_recv():

1. Validate that the provided buffer can hold at least the 4-byte header
   before attempting to read it.
2. Validate that the buffer is large enough to hold the data size reported
   by the TPM before reading the payload.

Without these checks, a malicious or malfunctioning TPM could cause buffer
overflows by reporting data sizes larger than the provided buffer, leading
to memory corruption.

Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")
Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
---
 drivers/char/tpm/tpm_infineon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 7638b65b8..0fe4193a3 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	number_of_wtx = 0;
 
 recv_begin:
+    /* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */
+	if (count < 4)
+		return -EIO;
+
 	/* start receiving header */
 	for (i = 0; i < 4; i++) {
 		ret = wait(chip, STAT_RDA);
@@ -268,6 +272,9 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 		/* size of the data received */
 		size = ((buf[2] << 8) | buf[3]);
 
+		if (size + 6 > count)
+			return -EIO;
+
 		for (i = 0; i < size; i++) {
 			wait(chip, STAT_RDA);
 			buf[i] = tpm_data_in(RDFIFO);
-- 
2.43.0


