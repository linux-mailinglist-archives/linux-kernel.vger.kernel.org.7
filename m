Return-Path: <linux-kernel+bounces-738739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A1B0BC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123643ACD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878E26E700;
	Mon, 21 Jul 2025 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDooW2Wu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B226E712
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079193; cv=none; b=nENUdhmu0GgKT+1vrJ34Jun1YDaw8Om48IKc87SdP291MuMkku4L5EGQrhB7Ihc1ZdqWMgcTWO8whadMY/Rgm6lqFdn+xF4XlYtiYdV9z3dVfi9R/LId6/V8iE3Ty5LKWOJvkCEtgiShXJRPSdxgEqtM4LViWQ7LCqaUWCRSufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079193; c=relaxed/simple;
	bh=IttXMNtr1al7C9VfUoTKm7sdnSxztJ9FUc8B+/m66ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8/6qENlqsXMXN2cVT5gyQmbPL55MAQEjL+zx6bFlhEcgafygAS01TNVZkNCYZkgDobeYnffW9vW8Deh/a5XpYuxt+AEL5XEPJ9GvRVNrtaCRHPyvRTE0KjvT0lP+ny+pCuNgORT5MP6mHTd6VWr7swCetXzhmEWGCodoawZFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QDooW2Wu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n7CI29ixTGrTDOBbuLnjGagda6wqfPEORxmasN2D7Vk=; b=QDooW2Wu2I3nssUiQ8jIkFRKY4
	HL21PLVlLImj8ef38gnglHL5PyarJd66Gmm5zmxSrt+Msz9Y9tmnMhpzooKCYABIMR684SBX3zONU
	5o/sWw8sa9SS2kbMd17j6hSYEySXvfkVU1tjJZGjUrc1GQDr417rG/Bawu/Y+UYd2HwO46XvHyvX4
	c1g16BayEQO6iuWMnH4SMLRIhoHZEK4ow1msdgisGnUrlNOw1bwvw+6PrT6yB5Er2sTnhCL45R7mL
	Bhm/JXBpVHLMXxuQZNmWcRpzjf+vZeX5XmrfrZAD1WFBONx+p/rPHAByMla4o8SNcSM10HOMJzUpJ
	3Vp4B5OQ==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udjyp-0000000GMaR-14MN;
	Mon, 21 Jul 2025 06:26:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] pc104: move PC104 option to drivers/Kconfig
Date: Sun, 20 Jul 2025 23:26:30 -0700
Message-ID: <20250721062630.3905668-1-rdunlap@infradead.org>
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

Fixes: ad90a3de9dd1 ("pc104: Introduce the PC104 Kconfig option")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: William Breathitt Gray <wbg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/Kconfig |    6 ++++++
 init/Kconfig    |    7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

--- linux-next-20250718.orig/drivers/Kconfig
+++ linux-next-20250718/drivers/Kconfig
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
 
--- linux-next-20250718.orig/init/Kconfig
+++ linux-next-20250718/init/Kconfig
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

