Return-Path: <linux-kernel+bounces-824496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A93B8965C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962715251D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9230FC02;
	Fri, 19 Sep 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="cOvmr4dw"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797B30FC2F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284118; cv=none; b=b/mIm4pLZHxdwAzIRfItRFFtsVwkZHL+N1EddrP3h7e3df6gSdYtcXi+WLSceDNi+TfbJcmKSO/59KMljV9HaD9+V7Gxx36o+89tv3plGVQzzSrCoJN7+9G6hUDZ4CYbnbfW1I7xBg+eg8hOnpiIiftVeGv2qtpXAlo46BfFSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284118; c=relaxed/simple;
	bh=ssJLOHTfv4vrnVWFpTFzqBamLlN/sY0S1mhKk81DFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzShAoqPKchFoI49S+snqo4DHC6xlFkS/zOzYG4SVBCOmPW8g9Q02DjGYQYEdF6k/jiwmYKLbYzRMOr42F6AqMMhpUGQmiJzSLg56OnUveE89FMkFX1WgziH9YT2Wno9yic9m/uRGarrUdNce2mXlIJH+c/8rPKTejI8tHfo60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=cOvmr4dw; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250919121511a0d88e9d900002079c
        for <linux-kernel@vger.kernel.org>;
        Fri, 19 Sep 2025 14:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=8U4MhoCvYzcsvxu74c2qr8Quw80+5E5+N9Y7pQSVLd0=;
 b=cOvmr4dwT/Z6UVcHjFlJkCJztR/Uae2vZNVCx7PY6gJPhDQgdiUNAYJuDrK+s3cfYJ9aPw
 CkgpimGqfTC2aQbHxWMHn5tdGzeTMiqtGueG9OC9pPVoBch23K4yMMnykmEdZ65I+rn5J7YQ
 fCA+iSzMnsjnbs4XFG/aY55fBaOngAxhsT4mf8o2E3/z4OqfImuqVvrjRXnGBeoKgrZ8qHwg
 tsu75T+rplW8si32hfgP5zoa0oXtvK2qJIKl1EBxzrtxIXlG7F0KeGVdyqxJOHHKi9kQc57w
 QTnFGLUPXhn8J6jDS+OV4h13KUuGHn/Zxu5AWhpIh7hUJN+k7rWm7+TQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	Peter Marko <peter.marko@siemens.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/Makefile: use $(objtree) for crtsavres.o
Date: Fri, 19 Sep 2025 14:14:12 +0200
Message-ID: <20250919121417.1601020-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

... otherwise it could be problematic to build external modules:

make[2]: Entering directory '.../kernel-module-hello-world'
|   CC [M]  hello-world.o
|   MODPOST Module.symvers
|   CC [M]  hello-world.mod.o
|   CC [M]  .module-common.o
|   LD [M]  hello-world.ko
| powerpc-poky-linux-ld.bfd: cannot find arch/powerpc/lib/crtsavres.o: No such file or directory

Fixes: da3de6df33f5 ("[POWERPC] Fix -Os kernel builds with newer gcc versions")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9753fb87217c3..a58b1029592ce 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -58,7 +58,7 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
 # There is a corresponding test in arch/powerpc/lib/Makefile
 KBUILD_LDFLAGS_MODULE += --save-restore-funcs
 else
-KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-- 
2.51.0


