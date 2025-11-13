Return-Path: <linux-kernel+bounces-899460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29826C57D10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB88E345304
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2E212574;
	Thu, 13 Nov 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NfqGLIP0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6MLVrb1F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NfqGLIP0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6MLVrb1F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990223AE62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042203; cv=none; b=Ry6xmXcbu3pFag/qxndURuLIfWVwHRDuFlH5HqbC9HxBcjS2d4xLmE1ZxOGDdJODpUJP5Kko/qgiIk+RInEwQMDYWJHvh0SaS+ksfOCeksx3EdsZjTxXcUIKyMIZEehyccCy40D5AIYQn+xUNG7QI0+VCmgty0T3R2rdSFpKFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042203; c=relaxed/simple;
	bh=XwD1YJLTQRU7DYLluydwUseeRjb+KRtpbieDcHlRcV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Muy26hR9oaBJas2LkUjg86w0eCDULk09g23ofkZo21S5xHZQB16TzlobMxBOPXTiiOYebgzfzRIdnHqlL5HvL0w7bkI3bkw5Ha0ABC2WuD6Z3Hj9dGLh3Y2kRZRK++GlX6FV49q3McvpyJI2gyXXwvrROG4X0ytFU3ibod20TfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NfqGLIP0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6MLVrb1F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NfqGLIP0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6MLVrb1F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D5751F451;
	Thu, 13 Nov 2025 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763042199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJihWS4w54QfjbnU9sQxaWaLhLGEz1OXZ/jtjdU3dUg=;
	b=NfqGLIP0enj6SYDsbvBYZvNeW3tJSLGRRkky0zrRi8eOsLHiojY27nOPH9RqesLoZDWLaK
	oxNyfjKw+KID3KGSxg9V74ymNqehcaWh/aTTYgW0xfmh73ApGqaZnskoKiOhz98GKjnx8X
	h8ZFJH2pdB1ezRFk9DIvhUhfHEGWWXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763042199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJihWS4w54QfjbnU9sQxaWaLhLGEz1OXZ/jtjdU3dUg=;
	b=6MLVrb1FvqGt7UCqGMbo8+LO9YjSUVaqlHxFVSBRgT/B5H6Id9nDuh9jveOIR3zTbQfHSw
	eJytEpoEf+crL+Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763042199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJihWS4w54QfjbnU9sQxaWaLhLGEz1OXZ/jtjdU3dUg=;
	b=NfqGLIP0enj6SYDsbvBYZvNeW3tJSLGRRkky0zrRi8eOsLHiojY27nOPH9RqesLoZDWLaK
	oxNyfjKw+KID3KGSxg9V74ymNqehcaWh/aTTYgW0xfmh73ApGqaZnskoKiOhz98GKjnx8X
	h8ZFJH2pdB1ezRFk9DIvhUhfHEGWWXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763042199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJihWS4w54QfjbnU9sQxaWaLhLGEz1OXZ/jtjdU3dUg=;
	b=6MLVrb1FvqGt7UCqGMbo8+LO9YjSUVaqlHxFVSBRgT/B5H6Id9nDuh9jveOIR3zTbQfHSw
	eJytEpoEf+crL+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 201F73EA61;
	Thu, 13 Nov 2025 13:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7xjSBZfjFWloAwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 13 Nov 2025 13:56:39 +0000
Date: Thu, 13 Nov 2025 14:56:36 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Hildenbrand
 <david@redhat.com>
Subject: [PATCH] mm/cma: Remove CONFIG_CMA_SYSFS option
Message-ID: <20251113145636.731a24e4@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email,lkml.org:url,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

The sysfs interface to CMA has a marginal runtime cost and a small
footprint, there's no reason not to include it in all kernels where
the dependencies are satisfied.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
As discussed with David:
  https://lkml.org/lkml/2025/8/6/371

 arch/loongarch/configs/loongson3_defconfig |    1 -
 arch/s390/configs/debug_defconfig          |    1 -
 arch/s390/configs/defconfig                |    1 -
 mm/Kconfig                                 |    7 -------
 mm/Makefile                                |    4 +++-
 mm/cma.h                                   |    4 ++--
 6 files changed, 5 insertions(+), 13 deletions(-)

--- linux-6.17.orig/arch/loongarch/configs/loongson3_defconfig
+++ linux-6.17/arch/loongarch/configs/loongson3_defconfig
@@ -120,7 +120,6 @@ CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
-CONFIG_CMA_SYSFS=y
 CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
--- linux-6.17.orig/arch/s390/configs/debug_defconfig
+++ linux-6.17/arch/s390/configs/debug_defconfig
@@ -103,7 +103,6 @@ CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA_DEBUGFS=y
-CONFIG_CMA_SYSFS=y
 CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
--- linux-6.17.orig/arch/s390/configs/defconfig
+++ linux-6.17/arch/s390/configs/defconfig
@@ -95,7 +95,6 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_CMA_SYSFS=y
 CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
--- linux-6.17.orig/mm/Makefile
+++ linux-6.17/mm/Makefile
@@ -119,6 +119,9 @@ obj-$(CONFIG_ZPOOL)	+= zpool.o
 obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
+ifdef CONFIG_SYSFS
+obj-$(CONFIG_CMA)	+= cma_sysfs.o
+endif
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_NUMA_MEMBLKS) += numa_memblks.o
 obj-$(CONFIG_NUMA_EMU) += numa_emulation.o
@@ -127,7 +130,6 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
 obj-$(CONFIG_SECRETMEM) += secretmem.o
-obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
 obj-$(CONFIG_DEBUG_PAGEALLOC) += debug_page_alloc.o
--- linux-6.17.orig/mm/cma.h
+++ linux-6.17/mm/cma.h
@@ -49,7 +49,7 @@ struct cma {
 	char name[CMA_MAX_NAME];
 	int nranges;
 	struct cma_memrange ranges[CMA_MAX_RANGES];
-#ifdef CONFIG_CMA_SYSFS
+#ifdef CONFIG_SYSFS
 	/* the number of CMA page successful allocations */
 	atomic64_t nr_pages_succeeded;
 	/* the number of CMA page allocation failures */
@@ -80,7 +80,7 @@ static inline unsigned long cma_bitmap_m
 	return cmr->count >> cma->order_per_bit;
 }
 
-#ifdef CONFIG_CMA_SYSFS
+#ifdef CONFIG_SYSFS
 void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages);
 void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages);
 void cma_sysfs_account_release_pages(struct cma *cma, unsigned long nr_pages);
--- linux-6.17.orig/mm/Kconfig
+++ linux-6.17/mm/Kconfig
@@ -981,13 +981,6 @@ config CMA_DEBUGFS
 	help
 	  Turns on the DebugFS interface for CMA.
 
-config CMA_SYSFS
-	bool "CMA information through sysfs interface"
-	depends on CMA && SYSFS
-	help
-	  This option exposes some sysfs attributes to get information
-	  from CMA.
-
 config CMA_AREAS
 	int "Maximum count of the CMA areas"
 	depends on CMA


-- 
Jean Delvare
SUSE L3 Support

