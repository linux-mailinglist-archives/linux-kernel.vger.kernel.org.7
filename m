Return-Path: <linux-kernel+bounces-842445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5ABBCBEA
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8608F18909DA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69601C9DE5;
	Sun,  5 Oct 2025 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b="IrT9D2Yd"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93457A55
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759696958; cv=none; b=uLx99HzDtCSDTW19TaXXhDokVJu+/jRACYgjAm6iV4DSmTHkuPgF0sEw5nx+AtxfvlGIi16SBRwXIw/KUx5czdFWsYxwLEhLLzl6Ae8KzvSAioU+EaKWXSPOQR+seE6TEe7pAut+Vyg0r0mZEBljiGtVHWe+6Hw1HqfVZHRIIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759696958; c=relaxed/simple;
	bh=kcO5N0fw6BDZOQDJV3ICScgc48k1tu3gRxXUwqcucow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVvwzZs2Egcc7wcdfFw2i8zzUZ+hTU+U8tklD4ZDyw5/87R5TThlK61i2p+WkfFIs0aYAmGHVvqf31V42pwFofndZfe5QGbf/QthlvEG9uE7GmrEI9weDFp1+/YqoyfUdPxbutN+62njFSnIu06f7ZdXe/TEsJzh0K/+pVHsX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io; spf=pass smtp.mailfrom=kael-k.io; dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b=IrT9D2Yd; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kael-k.io
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cfvV112wHz9vWT;
	Sun,  5 Oct 2025 22:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kael-k.io; s=MBO0001;
	t=1759696953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yz7HBwzy6U3fEduFg2d74XWgZSSCYQaaI1kboP4fYM=;
	b=IrT9D2Yd43ekCFFeeGm4tKC8fHYjfMPSdGRjsP8+L/upZ6OPOCQbMDrB9EcXn8XmJuqbe/
	tAuWa72F2aW0MoX0G2PuWJWhdoZass8ipKeteiq2rJUqULO8gh/WtW93Au8XfXwEAmYKRY
	F8hVgqcth1edQnHYTAbDpGDJrFagAkx0/FMhvFzA0NLjV3NwGnOaLH1u5Jiu0Etberbr1Q
	OaM1LtBQdvk6h/kNO46qJjBKblfTyq41yELebJHZZxakyHrR0RPeboExbAj7KxUQNBHzev
	QsvwXOjXAT+vzY2cEKdXtW1jUwIiZbp5zTjfvLNxhR1Mxmso8/zUhdTu5hRJQQ==
From: Kael D'Alcamo <dev@kael-k.io>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/cpu: Fix kernel-doc for 'centaur_get_free_region'
Date: Sun,  5 Oct 2025 22:41:21 +0200
Message-ID: <20251005204200.191346-3-dev@kael-k.io>
In-Reply-To: <20251005204200.191346-1-dev@kael-k.io>
References: <20251005204200.191346-1-dev@kael-k.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kael D'Alcamo <dev@kael-k.io>
---
 arch/x86/kernel/cpu/mtrr/centaur.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index 6f6c3ae92943..f4c72402c284 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -20,6 +20,7 @@ static u8 centaur_mcr_type;	/* 0 for winchip, 1 for winchip2 */
  *
  * @base: The starting (base) address of the region.
  * @size: The size (in bytes) of the region.
+ * @replace_reg: mtrr index to be replaced; set to invalid value if none.
  *
  * Returns: the index of the region on success, else -1 on error.
  */
-- 
2.51.0


