Return-Path: <linux-kernel+bounces-588425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93832A7B8C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 10:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA5E17512A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB20A18BBB0;
	Fri,  4 Apr 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="myv/AeG5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wHykj7eH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="myv/AeG5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wHykj7eH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06F1990D8
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755025; cv=none; b=Wlp2IvcTPsYDHi0pW9P6bc62x0D8XS+RHlUobZSySg6aB6hY/zy3W32CCPVvWq58I8EGKodHZdmI5fWYtH/gqEFXvUp2hEgiI1c31P98T5vE8hFholqZ7YcqIDQEiK5F7TTXZEYLOzoPmm9+lNGRs8o+dvWwk2K+09QsSof41JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755025; c=relaxed/simple;
	bh=8XquGULLcICQYyf9HOU+q24y7v025GgX6yuYaoaYW7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUlfbb2BPp4XL/69/88N1grcoCAF2e47dbrIDe6Fe/Da/4Ml3g15rC9Wiqfb8kMQbZ1smy9didio8Ci0jAnWQIurb3Ln2UiwW/P32Ona2vm7muPZxyJFF4WrimYgFY5ePadjCcHiiPMe2f+pNT5lDkl+w24N1JSWOcGa5Geu3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=myv/AeG5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wHykj7eH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=myv/AeG5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wHykj7eH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out1.suse.de (Postfix) with ESMTP id 13AF9211A7;
	Fri,  4 Apr 2025 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743755021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKspqlH24peNBIR8ojFJzzAyckzzD8GPL06yF65W9A=;
	b=myv/AeG5WNfkl+8HLcYELu2AaXMepeWOkq94TSRBj+oxYjVECmOuXknLwJeTpMQMFjIDZb
	KNW+dOfmbGl+j3M7Trx0hLpZKwuVgLou/aZ8Pi2WRdrO53fvVmiV2LqeHfTX0KXpvVEiD6
	PyorYN5KUrjC+OKvHF+D40uNTEfcdls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743755021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKspqlH24peNBIR8ojFJzzAyckzzD8GPL06yF65W9A=;
	b=wHykj7eHbmBvJZxqFTp7cDJDYjqo+GyeZhziypm+498Ere3o7EXwnrcWbK8QQnnmPZzROS
	03Kuh0b89JnJEEAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743755021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKspqlH24peNBIR8ojFJzzAyckzzD8GPL06yF65W9A=;
	b=myv/AeG5WNfkl+8HLcYELu2AaXMepeWOkq94TSRBj+oxYjVECmOuXknLwJeTpMQMFjIDZb
	KNW+dOfmbGl+j3M7Trx0hLpZKwuVgLou/aZ8Pi2WRdrO53fvVmiV2LqeHfTX0KXpvVEiD6
	PyorYN5KUrjC+OKvHF+D40uNTEfcdls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743755021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYKspqlH24peNBIR8ojFJzzAyckzzD8GPL06yF65W9A=;
	b=wHykj7eHbmBvJZxqFTp7cDJDYjqo+GyeZhziypm+498Ere3o7EXwnrcWbK8QQnnmPZzROS
	03Kuh0b89JnJEEAw==
From: Michal Suchanek <msuchanek@suse.de>
To: 
Cc: Michal Suchanek <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] tpm: tis: Double the timeout B to 4s
Date: Fri,  4 Apr 2025 10:23:14 +0200
Message-ID: <20250404082325.13876-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <4e4640bd-0313-4594-9667-82340ed9368a@molgen.mpg.de>
References: <4e4640bd-0313-4594-9667-82340ed9368a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org,ziepe.ca,vger.kernel.org,earth.li,molgen.mpg.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,suse.de:mid,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 

With some Infineon chips the timeouts in tpm_tis_send_data (both B and
C) can reach up to about 2250 ms.

Timeout C is retried since
commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")

Timeout B still needs to be extended.

The problem is most commonly encountered with context related operation
such as load context/save context. These are issued directly by the
kernel, and there is no retry logic for them.

When a filesystem is set up to use the TPM for unlocking the boot fails,
and restarting the userspace service is ineffective. This is likely
because ignoring a load context/save context result puts the real TPM
state and the TPM state expected by the kernel out of sync.

Chips known to be affected:
tpm_tis IFX1522:00: 2.0 TPM (device-id 0x1D, rev-id 54)
Description: SLB9672
Firmware Revision: 15.22

tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
Firmware Revision: 7.83

tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
Firmware Revision: 5.63

Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Only extend timeout B
v3: Update commit message
---
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 include/linux/tpm.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 970d02c337c7..6c3aa480396b 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -54,7 +54,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6c3125300c00..3db0b6a87d45 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -224,7 +224,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
-- 
2.47.1


