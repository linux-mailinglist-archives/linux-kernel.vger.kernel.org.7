Return-Path: <linux-kernel+bounces-741659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814ECB0E75F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64975479E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998FB28A40A;
	Tue, 22 Jul 2025 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIxxnl8u"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E5289E32
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228474; cv=none; b=YNdkRuRdVgYrVzd+/6/IhtXZ0vfkz+2AqbAFcniUXtXmB40Gs3gjpmy/ke/oLsxptD+DxpRALUxQ3MDCTH/lzwHRS5Z0D1RFPNHIU4ck+mSne3pZcpDZcDKvPRiAbkv2AgMnGBXGcHdoSgJMKuUbjLghnh/1mkYznMZddw4kdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228474; c=relaxed/simple;
	bh=DiQZ/wNiJKNg3ADVxls0TBAIxHc7I+HZNhHlwunIeeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DlsvXgjkWd0zfWxz/C01WIWXA9y35pblAB4z6n5MkKDaSbXzGce9Vv9LewDZri86BFq525hNmekgObVvdI1k/7MouMTVPhmU+IBTVQh1fS32MFk6mYwNOMZCwBdccrBz5KFoRNV5esQwub4YgAZkG0Ldtz8zpKaZORfJ0bvneSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RIxxnl8u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WBfUsq0OHevpjf9kUk/g7aOlnMfLY7EIMCGRJqvaSmk=; b=RIxxnl8upS555BeKL4hoiM3/k/
	GoLOlqw64Z63qUUgGDQUM+V2WjT+Fmpe40IyGkQ+drgfjlpyj/GN6iCrF4oIKvIDoXVwIOoG20mto
	3Z0mYkirDZ5JY8VespZfpzoEq+S6KDs4IVI50+vHPMoZ0lYxSTV4Y95CqQqPa2uMaM+e/7S2PNZFU
	K8v9vQ5Wxta9L1yk2gw3mkHpiD8t4q1EfjSxbHs7TrIMlppYeZGwJd8IsNELbwu/4sX9DF9MBjq9x
	IdILuflBz7AFz89b268iSra9UZm/oEM0qvzwivuWanFTtGZFqacQfMX2IIhzp/G8scMURvKxnJYJs
	0avODM6g==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueMoZ-00000003hLn-3eAO;
	Tue, 22 Jul 2025 23:54:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] pc104: move PC104 option to drivers/Kconfig
Date: Tue, 22 Jul 2025 16:54:31 -0700
Message-ID: <20250722235431.3671754-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the PC104 kconfig option in drivers/Kconfig along with
other buses (AMBA, EISA, PCI, CXL, PCCard, & RapidIO).
This localizes PC104 with option bus kconfig options to make
it easier to find.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: William Breathitt Gray <wbg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: add William's Ack
    remove Fixes: tag since this isn't really a fix

 drivers/Kconfig |    6 ++++++
 init/Kconfig    |    7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

--- linux-next-20250722.orig/drivers/Kconfig
+++ linux-next-20250722/drivers/Kconfig
@@ -10,6 +10,12 @@ source "drivers/cxl/Kconfig"
 source "drivers/pcmcia/Kconfig"
 source "drivers/rapidio/Kconfig"
 
+config PC104
+	bool "PC/104 support" if EXPERT
+	help
+	  Expose PC/104 form factor device drivers and options available for
+	  selection and configuration. Enable this option if your target
+	  machine has a PC/104 bus.
 
 source "drivers/base/Kconfig"
 
--- linux-next-20250722.orig/init/Kconfig
+++ linux-next-20250722/init/Kconfig
@@ -1914,13 +1914,6 @@ config CACHESTAT_SYSCALL
 
 	  If unsure say Y here.
 
-config PC104
-	bool "PC/104 support" if EXPERT
-	help
-	  Expose PC/104 form factor device drivers and options available for
-	  selection and configuration. Enable this option if your target
-	  machine has a PC/104 bus.
-
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y

