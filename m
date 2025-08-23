Return-Path: <linux-kernel+bounces-783279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F7B32B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1A1BC3247
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169082E9ED0;
	Sat, 23 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZxagSBcl"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11ED2E763D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755969748; cv=none; b=bdAzy0n6IliiaJQnaswbcqNikQDlwH/ZE7TdVJTiXtKOjjd7VFjiojpiV6T2rBWDaiibd/dTuE5c5Qv4h+MbI1QZzfwJDw0P/F8H1JGBDA/3L6yjJK5U9nuUO6Ak9AbQS7CEw/RAMCx6cYfeKO/hecXiBdly9WpZ4g9ftOerukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755969748; c=relaxed/simple;
	bh=afEhyXcerRxJ2pUFrVuQ80HLCcLlpdreIpO7q+Efovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp6H3lpt2rD/CaujDfqALUxid5/475b4G9Uldf0fHyd92/hg3FFo7hSxqtA7/TzbZa316T56Sslj7f2HLFI0H15XtIuuG1X6p8qU1gON9X5sS/QPRimqR+09ImpGHykU8+CEEl1NgMztGe4Tl4mR5Klk7CntNGgUlGopa58QBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ZxagSBcl; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250823172217f04991a4fae9961175
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Aug 2025 19:22:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9B4yx0Y9gMLMy4+y7N4u4X2Mzh1VO2RHXLHiQLJZ9As=;
 b=ZxagSBclbuvGNfJzD3qK4Az0lXmSg4Oao+t6Jo/HpLOCDcPGF75a/DTYS7pKicTCR5K3kl
 rJkXRrWh0gUG9eSmEsVW5K8QwVfXG/Y1ZWoviGHd/F9Hb2bZx18wP4iWXgkGAxqyd7K20PuV
 KZ8t8Pks6Xo2NvEMaJrsTFk5B0YechsLDi693mjtvFO27UBXZJtUDBDPIx5RRMx90jZdTbfy
 3Tdcp5zOK1dkfs3TPAEcXj8UXLhGtaQk9zDqeTrmxu4kDIbeDQtlKAPe6JZtvttUA7mLSIKg
 oQDBe8AVnCb5km+bGatx15bkmxk+PDmMwn+GmNz73YJsXVRJ6CY55Tqg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 4/4] efi: stmm: Drop unneeded null pointer check
Date: Sat, 23 Aug 2025 19:22:14 +0200
Message-ID: <19d1806d6f8b16b77dbdbb0e3ebf5ccae8389fac.1755969734.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755969734.git.jan.kiszka@siemens.com>
References: <cover.1755969734.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The API documenation of setup_mm_hdr does not mention that dptr can be
NULL, this is a local function, and no caller passes NULL. So drop the
unneeded check.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index c2bc8467b099..65c0fe1ba275 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -185,8 +185,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func)
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
 	var_hdr->function = func;
-	if (dptr)
-		*dptr = comm_buf;
+	*dptr = comm_buf;
 
 	return var_hdr->data;
 }
-- 
2.43.0


