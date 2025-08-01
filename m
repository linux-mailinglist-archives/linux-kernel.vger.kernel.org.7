Return-Path: <linux-kernel+bounces-753090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCDB17E83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF4B1C80D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825E2264CE;
	Fri,  1 Aug 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUX87Sgb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24948221F03
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037943; cv=none; b=qsuOFNbGgTjbt/hPHXKC8ENLlOqfFxEVIaAUxRfk2cwZqIFn0U7FvZHX21S1rsHNz4htbjXfHuuuCaxByjeMxmBBx9r3Ra20Q3goYKUKBJRkBXwEFc//zZXPdyZUw01rHqSNTwMTWpGYOqsXX1r5COSGfYKAzyuPQ3BuxBdz27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037943; c=relaxed/simple;
	bh=mErEHekBTnKVAx87It6XFqvTlhjv+gnhwhUgGAie3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+bTKU+OGiqEnGmgJUNELzbwd6VXTU3t1TvC+k4DYHMMUVUNtJ3b7gZXjORsiS8WLQHcPqOrOm7rHmD62D6s+GFQOdjg3ZlCKY17qHGyux5TJduAV699FaylnCHnPW7bemO1hoRPSs7sgzWWZ8wfBznAYYFkt+ckSR73joY3JOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUX87Sgb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754037940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OMDFLsJa+7WoP3pFG+QjuosRKNifY7eB+BWLzO6ziM0=;
	b=dUX87SgbTcEfENZx7ZyJ11vp3B9rniasd6XOWNWoU9d7QoHqRZ/gmXRuukYg7eES1lu0d+
	0lRIqsWyD7QI25hMQcgHjylWW6a4H6ZVNsyVy2GWVwizG36bgiINJlI+dQtJ5qfQrW3285
	mv7MnSxk/taA2T+tO/1Y8qyQ5z6fios=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-I4_KE8PiOL2V2VYhwxYURQ-1; Fri,
 01 Aug 2025 04:45:38 -0400
X-MC-Unique: I4_KE8PiOL2V2VYhwxYURQ-1
X-Mimecast-MFC-AGG-ID: I4_KE8PiOL2V2VYhwxYURQ_1754037937
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEB1619560AF;
	Fri,  1 Aug 2025 08:45:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B9ED1955E89;
	Fri,  1 Aug 2025 08:45:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spdx@vger.kernel.org
Subject: [PATCH] x86/mtrr: Remove license boilerplate text with bad FSF address
Date: Fri,  1 Aug 2025 10:45:31 +0200
Message-ID: <20250801084531.34089-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

The Free Software Foundation does not reside in "675 Mass Ave, Cambridge"
anymore, so we should not mention that address in the source code here.
But instead of updating the address to their current location, let's
rather drop the license boilerplate text here and use a proper SPDX
license identifier instead. The text talks about the "GNU *Library*
General Public License" and "any later version", so LGPL-2.0+ is the
right choice here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/x86/include/asm/mtrr.h        | 15 +--------------
 arch/x86/kernel/cpu/mtrr/cleanup.c | 15 +--------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 15 +--------------
 3 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index c69e269937c56..76b95bd1a4058 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*  Generic MTRR (Memory Type Range Register) ioctls.
 
     Copyright (C) 1997-1999  Richard Gooch
 
-    This library is free software; you can redistribute it and/or
-    modify it under the terms of the GNU Library General Public
-    License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
-
-    This library is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-    Library General Public License for more details.
-
-    You should have received a copy of the GNU Library General Public
-    License along with this library; if not, write to the Free
-    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
     Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
     The postal address is:
       Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 18cf79d6e2c5a..763534d77f593 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.0+
 /*
  * MTRR (Memory Type Range Register) cleanup
  *
  *  Copyright (C) 2009 Yinghai Lu
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index ecbda0341a8a3..4b3d492afe17c 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: LGPL-2.0+
 /*  Generic MTRR (Memory Type Range Register) driver.
 
     Copyright (C) 1997-2000  Richard Gooch
     Copyright (c) 2002	     Patrick Mochel
 
-    This library is free software; you can redistribute it and/or
-    modify it under the terms of the GNU Library General Public
-    License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
-
-    This library is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-    Library General Public License for more details.
-
-    You should have received a copy of the GNU Library General Public
-    License along with this library; if not, write to the Free
-    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
     Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
     The postal address is:
       Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-- 
2.50.1


