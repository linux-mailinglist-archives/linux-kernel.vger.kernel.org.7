Return-Path: <linux-kernel+bounces-756182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C8B1B0F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA5D7AA926
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96A26056C;
	Tue,  5 Aug 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHo9CgpI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC545183CC3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385955; cv=none; b=liqMe6IcAMIErOloESptww/0NEv0yCivxL9wiR9W90rUgZT9novm68nWZ+JPJkFfigvwCASdCRc9tv7NEuOf6GMygeX3IvKFiCoA11V/BazCg2fbK/zoZfT2UKn7f7XqMTXB7TbPdAmHJmz6aZICAofhmbqehsEkgD2ymdmBm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385955; c=relaxed/simple;
	bh=cQTdIHf5Udxe4za40+bEJZlTM6tmWGn3FyfaCjjS3G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwjjuBvsObu3ffUw0YMc8LRS7xUdLZh+lbKuWxaLHqLEdhCY6glZBBRKUf4DFzg7C7dt1YddfR5ZqhhxzL38Scv9xacb/As45MsUzwrO7w+U350c5DmAw8c7gruApoVzcpVZrjtXhEsG0fM7yG71cIowl0NYqkv3fRgRdvQp6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHo9CgpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754385951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NUbNajW9+7Mzlutnh+I3YYq5LwnGqh5tFxG/qL2Ge0Y=;
	b=AHo9CgpIaqzEh4jypHJXVbGML6jlpRhIRuNmyxL5PbNnVuBPcA22lQDn3p4EUfbLXlp+9o
	DdIYX+eg3NEgKKddRbgf5K9hDCji0WfwP0pJZn9UepGnu/2piOMMd7+Eaiu7QX2XJLhdLK
	38HXfxIrU1f8auyu80lprhi2k2Kqlk4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-v_eGBvsRPZKLYzOSrCINCg-1; Tue,
 05 Aug 2025 05:25:45 -0400
X-MC-Unique: v_eGBvsRPZKLYzOSrCINCg-1
X-Mimecast-MFC-AGG-ID: v_eGBvsRPZKLYzOSrCINCg_1754385944
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 113021800343;
	Tue,  5 Aug 2025 09:25:44 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com [10.33.192.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C7C51956094;
	Tue,  5 Aug 2025 09:25:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH] sparc: Drop the "-ansi" from the asflags
Date: Tue,  5 Aug 2025 11:25:40 +0200
Message-ID: <20250805092540.48334-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Thomas Huth <thuth@redhat.com>

In the very early kernel 1.x days, assembler files were pre-processed
with the "-traditional" flag. With kernel 1.1.85, the sparc subsystem
was changed to use "-ansi" instead while the other parts of the kernel
continued to use "-traditional". That "-traditional" got removed from
the other architectures in the course of time, but the sparc part
kept the "-ansi" until today.

This is bad since it comes with some disadvantages nowadays: You have
to make sure to not include any header that contains a "//" C++ comment
by accident (there are now some in the tree that use these for SPDX
identifiers for example), and with "-ansi" we also do not get the
pre-defined __ASSEMBLER__ macro which we'd like to use instead of the
kernel-only __ASSEMBLY__ macro in the future.

Since there does not seem to be any compelling reason anymore to use
"-ansi" nowadays, let's simply drop the "-ansi" flag from the sparc
subsystem now to get rid of those disadvantages.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: I've only compile-tested this patch. No runtime testing done.

 arch/sparc/kernel/Makefile | 2 --
 arch/sparc/lib/Makefile    | 2 +-
 arch/sparc/mm/Makefile     | 2 --
 arch/sparc/prom/Makefile   | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 36f2727e1445d..22170d4f8e060 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -4,8 +4,6 @@
 # Makefile for the linux kernel.
 #
 
-asflags-y := -ansi
-
 # Undefine sparc when processing vmlinux.lds - it is used
 # And teach CPP we are doing $(BITS) builds (for this case)
 CPPFLAGS_vmlinux.lds := -Usparc -m$(BITS)
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index ee5091dd67ed7..783bdec0d7be0 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Sparc library files..
 #
 
-asflags-y := -ansi -DST_DIV0=0x02
+asflags-y := -DST_DIV0=0x02
 
 lib-$(CONFIG_SPARC32) += ashrdi3.o
 lib-$(CONFIG_SPARC32) += memcpy.o memset.o
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 2d1752108d779..e9d232561c82a 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -2,8 +2,6 @@
 # Makefile for the linux Sparc-specific parts of the memory manager.
 #
 
-asflags-y := -ansi
-
 obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o
 obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index a1adc75d80551..92db8bb4ad4cd 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the Sun Boot PROM interface library under
 # Linux.
 #
-asflags := -ansi
 
 lib-y                 := bootstr_$(BITS).o
 lib-y                 += init_$(BITS).o
-- 
2.50.1


