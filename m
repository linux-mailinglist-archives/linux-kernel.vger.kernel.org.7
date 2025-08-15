Return-Path: <linux-kernel+bounces-771388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83043B28650
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAE7B62CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E829993B;
	Fri, 15 Aug 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Xq1eH0Ft"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D10257841
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285777; cv=none; b=dtwtR5YCIFG67KytZO/OFvk6SR9SrteHz3RWfKHS5dZoTHy9XYuYl5kDd2QnlnKTKnbJjy/O2fNE7eDtYPsPZZN3q+hUzeuue02P2RSiIV/4mU4fWMELZgv0WpS8tTPvckoOmRu3d7ya/yHxGih2Wzc0vKlLKf2mZROGCaZuhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285777; c=relaxed/simple;
	bh=SUHzG+YVz6tmPkt8PbQimgyYEQxXh/By0+v+cVDhWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzhCHEMN9dmG804Afur5nIb8HFohJJxaPW4+3Ip2FGqMjD7BgdOubDj3mmYky5N7l5nFgOkEKMDK840bRbWWQb9z7BAPhcKXUQwrUw0uwD3BRx7M28r8JNnWsRSWc+ExjhjV9co5qZbvj7qxeLkDnfhdTPdJ3My4bW/LDi0F41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Xq1eH0Ft; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025081519124302d58c9e7046475238
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xXGWVd566Z2K+snOqQZoB1IZL8d8mK8yVfnQMaQkZF4=;
 b=Xq1eH0FtgCVlzwt28fyg9CI33tndT8+pLzS2oFUBQTH5sHmaSpMc/Vgya+ojW93JrDNQ5s
 I9rVgEnn/nTSJYuoTnA8ZcJFgV+VYFZzYViF2jCCgcVTtx0NwzbJdpJo8/835XUbln6UUtNw
 yH5fNy5GcPRd7+WeFfaL0T0QjhaZwFoLrlXj2d71ilFatdfRJWrR0rlYOLWFWQk/Sj236tJq
 SXnfPqF2QideN8H+K+6tXbiT43dbWoR9YBWGDYjlTelApc1Ro16iggJgGBWDfKvM/wFECB3t
 C3zAXwQe9WA8hbQy5IeBJW55KnpjS0kH5w5vfGzQlTLiKngz5kJ0xEDg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 3/3] efi: stmm: Drop unneeded null pointer check
Date: Fri, 15 Aug 2025 21:12:41 +0200
Message-ID: <8b4aeccbc005087ead1c261745877ccdb7dbb9d5.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755285161.git.jan.kiszka@siemens.com>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
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
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index bf992b42be70..ff41667b1005 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -191,8 +191,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t *nr_pages, size_t payload_size,
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
 	var_hdr->function = func;
-	if (dptr)
-		*dptr = comm_buf;
+	*dptr = comm_buf;
 	*ret = EFI_SUCCESS;
 
 	return var_hdr->data;
-- 
2.43.0


