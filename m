Return-Path: <linux-kernel+bounces-899516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030BDC58018
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE233A6536
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748D2C11F0;
	Thu, 13 Nov 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2At/eqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C22475CB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044649; cv=none; b=g7nJPZrQDB9Vm/BfKDxOQnL2BiVp8gLWflZkWt0195opS/ZzS3jysaW4N5SMPzLWR81V4RXnkTpDQqrFuhP345prh4ADho4x2Q2TlOUQF1JaHsLUxDofS6rB9ZYHliyxPi8I8i+Ktm/V0pEiWLHqlDXaoR/MifsoAtFB7MboGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044649; c=relaxed/simple;
	bh=bSqCvMnzDhYpcqi95ZUAs1bPKU7LWlJ9rFTMuSTn5Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEiF9e6Wmoi1kr7MxO/jf0H/BxXvPfga4EfCBwF3Ajvec6cmN5LcT1Vijzy1qgUVGeWqXIdjtwFWgKlglJfL5tOQtdnTFtVefE/uaovF0JqBYkFW1bepIbwaEUBapc+tEHr8kPoceX02JrAZKnD90yj6wGpoba45MrvNYrjz8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2At/eqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763044646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xyO3LCI/Aek3V4cKVVMHCFT0RNVpL89onTNIli5da5I=;
	b=a2At/eqX+pSJqBE/bU25GajhYCzwJWiWbW6M6IzDgqGj2Y08KtdbEDLTrKkMaG9nH6I+O1
	KqgRgT4EvL8/rngisQgqjHceaAIGHOdLsZJiUrY3XsRyabxzMtiVfUFPq8xRELZvD+gd4z
	IePL+kfeDTqQ4VXa3tKgZFKr8XmD3OQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-AO-UOBxTMYenY6BUV8XmqA-1; Thu,
 13 Nov 2025 09:37:21 -0500
X-MC-Unique: AO-UOBxTMYenY6BUV8XmqA-1
X-Mimecast-MFC-AGG-ID: AO-UOBxTMYenY6BUV8XmqA_1763044637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 353991954B18;
	Thu, 13 Nov 2025 14:37:17 +0000 (UTC)
Received: from hp-dl380pgen9-07.khw.eng.rdu2.dc.redhat.com (hp-dl380pgen9-07.khw.eng.rdu2.dc.redhat.com [10.6.10.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C167E19560BD;
	Thu, 13 Nov 2025 14:37:15 +0000 (UTC)
From: Tony Camuso <tcamuso@redhat.com>
To: ning.sun@intel.com,
	tboot-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	bp@alien8.de,
	michal.camacho.romero@linux.intel.com
Subject: [tboot-devel] [PATCH 1/1] Disable CET when calling tboot shutdown procedure.
Date: Thu, 13 Nov 2025 09:37:14 -0500
Message-ID: <20251017073619.547993-1-michal.camacho.romero@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>

From: Mark Gross <mgross@linux.intel.com>

The tboot->shutdown_entry is effectively bios code and CET needs to be
disabled before calling it.

It resolves TBOOT shutdown failure bug, reported on the SLES (SUSE Linux
Enterprise Server) 16.0 OS. OS power off, called by the "init 0" command,
was failing, due to activated Intel Control-Flow Enforcement Technology
(CET).
Disabling CET has allowed to execute OS and TBOOT shutdown properly.

Closes: https://bugzilla.suse.com/show_bug.cgi?id=1247950
Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Tested-by: Tony Camuso <tcamuso@redhat.com>
---
 arch/x86/kernel/tboot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4c1bcb6053fc..932c2c44e743 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/e820/api.h>
 #include <asm/io.h>
+#include <asm/cpu.h>
 
 #include "../realmode/rm/wakeup.h"
 
@@ -248,6 +249,10 @@ void tboot_shutdown(u32 shutdown_type)
 
 	switch_to_tboot_pt();
 
+	/*
+	 * toggle off CET while we call shutdown_entry in bios
+	 */
+	cet_disable();
 	shutdown = (void(*)(void))(unsigned long)tboot->shutdown_entry;
 	shutdown();
 
-- 
2.47.1


