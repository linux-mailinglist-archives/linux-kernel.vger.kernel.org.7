Return-Path: <linux-kernel+bounces-873359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6AFC13C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3611566D46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764F2FE054;
	Tue, 28 Oct 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RkSCx4Jk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7C3016EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643045; cv=none; b=gzxxkxCpmWbXmnu1KQwUzwILamHvaBv+XX0omagg79uS7b4SJE5XS6MSdi+e0WrZTcW+u/SZezYZBIKJe6DMLZvZYBDAJx5KMwp6K6E7DZIDEWHqh04cySZErK8Kx0ssI5xFpG97eREsgqWBTXlDU/2IPloArmvinYDY52TKNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643045; c=relaxed/simple;
	bh=//QBJKcVdfGqAssYU8JT7yXYBZT3MIx6+94MEhcclCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQugEm8vpZ92O6ctXdsWzG/nroWs0CIM3rPy7mky6bBbFO4Bip90uCYhqKplvg05Aa3ZSw21WvIj+jBUPxsDphBqFjpqyIIUkwt4Vgr1DOBt0/qiC5tOvKCJqsGB3zR+M49GjdWn+OEaGH9uRzpOWDuGXrHcKkf1BefZjBaaIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RkSCx4Jk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=//QBJKcVdfGqAssYU8JT7yXYBZT3MIx6+94MEhcclCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RkSCx4JkyF5lLQUNeM42rFHtDmCXVpviOOcGrnETa/0HpC4Zdw2nuYjdH/4PFl6LC
	 M37gJsTtA9t48ctKGxpR9J+cgERSI2OA89fLXif/TGCIYqkwtsOm90oGVGKh+3v7/O
	 FWcQuK43JhS2hqil05ihbYlwxNee1T0QddlgMNzU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:42 +0100
Subject: [PATCH 07/10] um: Remove redundant range check from
 __access_ok_vsyscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-7-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=919;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=//QBJKcVdfGqAssYU8JT7yXYBZT3MIx6+94MEhcclCI=;
 b=Pyl9VMqLf2pp8Ulil0iQPsRNz8apL+lyucc74Nzhhix207oGH6tlAC45ZUnY4VWNUjWWKJQcx
 j1dxaqoDJmUBaathXH3i6r4J3xVGEUN8K6MC7Th5us+FKD8hWjRUdLv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The only caller __access_ok() is already doing the same check through
__addr_range_nowrap().

Remove the redundant check.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/uaccess.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1c6e0ae41b0c..3770bdeee100 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -17,8 +17,7 @@
 
 #define __access_ok_vsyscall(addr, size) \
 	  (((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
-	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END))
 
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))

-- 
2.51.1.dirty


