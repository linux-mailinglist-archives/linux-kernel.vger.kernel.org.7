Return-Path: <linux-kernel+bounces-585471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C7A793BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6553B41AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557135949;
	Wed,  2 Apr 2025 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xet3QQAy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SZ3HdaK3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xet3QQAy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SZ3HdaK3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E67194C61
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614506; cv=none; b=aNKDZRm6AZovTI4cZsAr/I+bk7kYonK03krv9DicqX7B+em47qNY4Y4UXn8itXNu8tuiKFPqpJPrSBilRchmVKy0cADj5VB3EXf4hqUES9n09XLKsL5UBvu+OOgYB051Vjnhzw79/1pK7nHz8wDO7NkEZ6ZAeQKpxdhPUcpYmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614506; c=relaxed/simple;
	bh=pPvUVx8w3534AH26P8xfZUy/BS8igRvD669kpXh/0jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKmeOG2HLvekQQ2r+2QbnvyHE5QnaSzkhwPYc1mRizUDRhqh9Lgd05mR+hQ8uABIo/KVCAEeowB7C1gfEFINawRz4cL7XMyrEp8sgTC3x2ZfbQah6Gi3DpIlq3q71JLQfwHd6FFdqMs1vXlbcP+BCHHAQK3/7MJuRVeREPZc0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xet3QQAy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SZ3HdaK3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xet3QQAy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SZ3HdaK3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out2.suse.de (Postfix) with ESMTP id 80AB01F38A;
	Wed,  2 Apr 2025 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743614501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CbZNo4dyJrIgS4/ORAw10xdILQG863hlxScew89HxRw=;
	b=xet3QQAyx1rzfh7DGyedYEnaCWfJ/Gcu8tG4pb2NAvFBDB2/+IShFmzk5f00SW/E/QM4bw
	segYhmoFKFXX6mcRYlgfgii09ruwJuU7+QcNNJGFTb/4w1ac+wmHRaoX1Tt5gkTKgUfhv6
	iddb6yYzx7PjeB8V+phzFEHOTgQSdXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743614501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CbZNo4dyJrIgS4/ORAw10xdILQG863hlxScew89HxRw=;
	b=SZ3HdaK3U5eYBciFrzbZ79TaFBGRFlnlbGCrrtnIv/KZp3owjEWB8fjN3xe3EddztK+gmH
	qWK84B5sLU5pO+AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743614501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CbZNo4dyJrIgS4/ORAw10xdILQG863hlxScew89HxRw=;
	b=xet3QQAyx1rzfh7DGyedYEnaCWfJ/Gcu8tG4pb2NAvFBDB2/+IShFmzk5f00SW/E/QM4bw
	segYhmoFKFXX6mcRYlgfgii09ruwJuU7+QcNNJGFTb/4w1ac+wmHRaoX1Tt5gkTKgUfhv6
	iddb6yYzx7PjeB8V+phzFEHOTgQSdXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743614501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CbZNo4dyJrIgS4/ORAw10xdILQG863hlxScew89HxRw=;
	b=SZ3HdaK3U5eYBciFrzbZ79TaFBGRFlnlbGCrrtnIv/KZp3owjEWB8fjN3xe3EddztK+gmH
	qWK84B5sLU5pO+AA==
From: Michal Suchanek <msuchanek@suse.de>
To: 
Cc: Michal Suchanek <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] tpm: tis: Increase the default for timeouts B and C
Date: Wed,  2 Apr 2025 19:21:30 +0200
Message-ID: <20250402172134.7751-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org,ziepe.ca,vger.kernel.org,earth.li];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -2.80
X-Spam-Flag: NO

With some Infineon chips the timeouts in tpm_tis_send_data (both B and
C) can reach up to about 2250 ms.

Extend the timeout duration to accommodate this.

Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
An alternative would be to add an entry to vendor_timeout_overrides but
I do not know how to determine the chip IDs to put into this table.
---
 drivers/char/tpm/tpm_tis_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 970d02c337c7..1ff565be2175 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -54,7 +54,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 2 sec */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
@@ -64,7 +64,7 @@ enum tis_defaults {
  */
 #define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
 #define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
-#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
+#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_C)
 #define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
 
 #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
-- 
2.47.1


