Return-Path: <linux-kernel+bounces-847900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D739CBCBF95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925AD1A63B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58124276046;
	Fri, 10 Oct 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="WIcJYTg9"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE74275111
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082604; cv=none; b=E3I+oMcLwQlUmXzQhJW8ZoW0nPjZx+vvP3sBTDmZztERmQEH8mQ6Egaw+551RQUJif+w8o3L8Tb+Ctb9lsAnqnIua5HcjgrzJ5vRj/6lkseRT8pEvCj+Yu/H6VSg2s3kwViL1TZWY4N8g0i4/6WYq64QqjrGulWbHzYxUcXE28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082604; c=relaxed/simple;
	bh=nWfBJc5B5wABRBWXLCt4WnYkfqomk7df5BLYMujxSd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUjHOCCRyV8Y5AMo8tSKGEM2N2/BNBAqBbTe5THB05On9Nn7pyqGzgHINMjlzlWeqy5DJwfBCSxmr302y/e4tFgDt3Gg+OMI6ns3EPdRd4RTXgODhHU+fBHsr0YQaOdu0DsWBDSjqH67Ruvjx5goTgZFD3WyOy8fObvxbpl/0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=WIcJYTg9; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 02DEC240104
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760082600; bh=U3yQSyvNq+LILqZiJHgKdf1FbljZv76FRIUyxVP3WOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=WIcJYTg9mmj7aPgDg4pOk3F9b0uCscXCSpwytC/7lgwY8UqoEsfySqGmzNQMBKqxr
	 61OSIah8ivmkB6WubV1Kprz8sI5gtAQFGDG6pyYrQm5gH7qqSguun2ZCj747/nt7ae
	 XsrDYMztHo8Vs6d6SN2MwgZw/xx8SP3KckylEPAykut/+0scTZeF2zRsMlGLWQFv2O
	 DnQuPyHLhZaD0PN4BSJ9gvYVE34xXLBsLlNqcJTGTx8N6nrDZXPdPCEi/YQY6yn6iC
	 4aXcesLtXvS1mclOtKnne31JdQwJIu6dMChsGKI88B5+F/NDc6PvslsQCbxXDzVC9r
	 i3jdczXBpBEtw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cjf6G6fXJz6v12;
	Fri, 10 Oct 2025 09:49:58 +0200 (CEST)
From: Shahriyar Jalayeri <shahriyar@posteo.de>
To: jarkko@kernel.org
Cc: shahriyar@posteo.de,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] tpm: infineon: add bounds check in tpm_inf_recv
Date: Fri, 10 Oct 2025 07:49:59 +0000
Message-ID: <20251010074956.6862-1-shahriyar@posteo.de>
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
Changelog:
v5:
	- replaced space indentation with tabs before the header comment
v4:
	- removed the curly braces around one line statements
v3:
	- removed dev_err() logs
	- added missing "fixes" tag
	- described header structure
	- fixed commit message length
	- removed use of local variable as constant
	- fixed check to account for off-by-six bytes
v2: 
	- added complete changes in the commit message
	- dev_err() logged expected sizes and stated operation is aborted

 drivers/char/tpm/tpm_infineon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 7638b65b8..d76aae08b 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	number_of_wtx = 0;
 
 recv_begin:
+	/* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */
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


