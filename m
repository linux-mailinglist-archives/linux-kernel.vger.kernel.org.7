Return-Path: <linux-kernel+bounces-886728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD5C365A3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E691A41C3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8911335577;
	Wed,  5 Nov 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="g0GYqfba"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF32D0E6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355995; cv=none; b=OH50M9swKmVqt98MOHMl+TCREv1170jStjW74JzxI1bJZDoYnwPqcQNouAxtBJsfRsqRnsYzrxwCrkha731NBPsIVND508NHw7Py4d6x7QlNERvFJw0Qir/2QxUKn088wA+hHVVyYQJ8BO9bDlBkTeR/vbk0ipIeNPsYU2vicxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355995; c=relaxed/simple;
	bh=kkdL7v3YAP6XLCv+U9jczlcfBggnB7IXWl7ug/fXnP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC2ipTu2L8vflfZA/0yHCsucrd/DvkPcua7Rj5oPbayrQJtd/MKd0VJaOtz8loBMm3+GVjW6gLMewmXJbY/o7sv/pLTY4prSqS1kGhWfZeWT6+nBuKKaENnVZZ6NsTaLaLc5L7hHZHuxUC2twP5TJP8fkn3MeKwJwug3YDmWiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=g0GYqfba; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1762355645;
	bh=vuq4wwSZPF3fCx8t8TtyfEuKJiFZoSD6IIOc91CADfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0GYqfbaJa9thB962lWv+7s+wIn8wg1xJvRNruRSRwQvg0DnbX9EMw6jPKvm9PqE+
	 JnmgvX7DsprPuNx5RK13wSsx4nqaXF7F540WGxflABqpuEBhShwUMBXn+Dne/msxSl
	 LbnB7zDTj324U3MrMJhJyiqFRt4y4B9R7t4twKlA=
Received: from stargazer (unknown [IPv6:2408:824e:302:e8a1:c427:8c70:2426:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 5FE5C66A4C;
	Wed,  5 Nov 2025 10:14:02 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev (open list:LOONGARCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] LoongArch: Select HAVE_ARCH_BITREVERSE
Date: Wed,  5 Nov 2025 23:12:53 +0800
Message-ID: <20251105151257.148530-2-xry111@xry111.site>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105151257.148530-1-xry111@xry111.site>
References: <20251105151257.148530-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without HAVE_ARCH_BITREVERSE, the architecture-optimized bit reverse
implementations in arch/loongarch/include/asm/bitrev.h are not used at
all.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 5b1116733d88..a672f689cb03 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -115,6 +115,7 @@ config LOONGARCH
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
-- 
2.51.2


