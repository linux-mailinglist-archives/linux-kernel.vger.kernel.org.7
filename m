Return-Path: <linux-kernel+bounces-882333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D10C2A33A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46909188B6D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D03296BD0;
	Mon,  3 Nov 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="g4XitNNG"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CA2309B2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151903; cv=none; b=gc843GB1uLADxm7ZUXU667dbMt1vbOhGwTMp/W3NHMUowwXmJZeixNyxKtSBgSJKkdv/LKdvuTQhY2yCyNpjAsnLP+P7VQBxza/yXHs0pdg9whU1qpNK0lR7rzQro4VcldcKeX5X6keZw9hWgWBgpgp1oJC1qjCCD89lKGk0K9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151903; c=relaxed/simple;
	bh=3GklO0QDDgTdK2chMO5iB95qoX8BAqga/LprqmirvR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dqS8yfQDKQHqY3c/7UGIlmltqljZuyKMeMgy47GAht098qEml3Mm+H/AR/ETfQEad7CtvCKMH24C/RRlqiGjZknDIY8p5lvonKAoZ+S9PElSaFHpGccivsJh8o9PbBui0f047xO4tE9liSVLp6Gw74P/f7BVX4ahQ0U36rU7quM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=g4XitNNG; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151850;
	bh=DY2dArnD0Cu8BVCBvrBWS9vSV2bQ+jdhOZR1uo+ET+s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=g4XitNNG7eTfvT5OBEHSY3gbkXQcFo0F1+99RQk2GUyl9rjOy06QfTAbM5rqfLCrN
	 /Ia5/qCmiJg+gynho00ySlrcD2P7NW7SlANPbA+NfjForBe7aPINgH5GK7Vi1P5Odk
	 bXjwVuqZCkVXx67bsSgyHj05L5cBJYtGrwuASbME=
X-QQ-mid: zesmtpgz4t1762151844t542df229
X-QQ-Originating-IP: 4YP6YfPHkqcY8K0enlj2wzW1FmKlfN/L4RJwp0UKItk=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:37:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4381373873010361249
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 2/4] kexec: add kexec_core flag to control debug printing
Date: Mon,  3 Nov 2025 14:34:38 +0800
Message-Id: <20251103063440.1681657-3-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251103063440.1681657-1-maqianga@uniontech.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M3uTjkO5QXGx/WPEvJQh4AmYvMNatvxgUBSg3Kd1IyO4dsKMCNZB5XeY
	kvbo53GvUqtSDrgUNHD6xb35yuTt9lCcqqU0LD4RUA8KAyPSQ42g/johpAKPvsmsPilj4qL
	XM1uGaAFvPfaKcy5ZIzrXt4tP68aPz5GHXKteVWyF5iUi6QSr0Sy6JSzohtCDn3CcTER/jf
	sGkb27I2dNGYTzCb+szsMP4Obvssej5H915z+tW4C86qpnUDXtGfoRmdEOqU6rwP3I5cnW8
	VdyMnuMtwhC9NCCklqAVyE/kBQBFRdougdxGlwljeAdX84BiKXM7sK7IFlUlFTMxge/yve9
	FypnDdAryYrie3NYl2musEXXaWJqPP9pmZT5LBS70vmVW5UNytjQxBuKNDwYK1tcZoT9+9t
	MYh7/NeTF5ompY2DgzHo6iNixSDBgZPMtBsUZWrTXJXyCj0lWYCN05pIi1TfD4k3Rl98+Fi
	kYekS/nFRsbssnLcXOARlfky6NkfH24mZbz6EiYhEYD5jPtwawuVZoKfYtXwpdhbgBDneOJ
	eTlkRTm2ehzifJSYyDtSzAYrF3xoLYX0fu41O1shBB6FklEb8gel5HtPjp5pkMNU9ypPAq/
	qW9hzGPBg6hPwwhB/hAghOW8blhshsdXAZcGPW3eSiHW4+yFMz0KVyIb65R7zvpuZCKqOH1
	9QsOp7Xx/7cyv2byUFiYf0yMQvE6iZwy3HolOxDLqCJ1goWTcALauRoZXh3HLOqSyqpWTZf
	+bOucHoalv7TWup99nYcMdTnhbbcOsF1OqdvKZLHHA3C5A+GMG1hX72AelWyCrSg5BLXYtz
	FOe6dDP0M68lXU6NrmVkEijLl66HKL9tyjUxbflAwZxBkIVjJc/E6P8ZHYOM5JI0wfmNtfd
	QWACT1095REFslkleHe76e2UHwqQB5midnbjWcNLfeBm/YM0uiPWdnENuvFFnyhv/uWoixO
	MtwqODK8Gz3Gq8kHPAp1ICAlNhb4TYJ0t0n+19PRno/cF1EDWzYt5Dhf7QV2CEAYZeUf4rk
	KdvxNz6ZdxVPVFVa5L2jutlpTnPZmsZH3htckmM9/ciYcrgTvC
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

Since kexec_load and kexec_file_load are not triggered
simultaneously, we can unify the debug flag of kexec and kexec_file
as kexec_core_dbg_print.

Next, we need to do four things:

1. rename kexec_file_dbg_print to kexec_core_dbg_print
2. Add KEXEC_DEBUG
3. Initialize kexec_core_dbg_print for kexec
4. Set the reset of kexec_file_dbg_print to kimage_free

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 include/linux/kexec.h      | 9 +++++----
 include/uapi/linux/kexec.h | 1 +
 kernel/kexec.c             | 1 +
 kernel/kexec_core.c        | 4 +++-
 kernel/kexec_file.c        | 4 +---
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..cad8b5c362af 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -455,10 +455,11 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT | \
+			KEXEC_DEBUG)
 #else
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
-			KEXEC_CRASH_HOTPLUG_SUPPORT)
+			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_DEBUG)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -525,10 +526,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
-extern bool kexec_file_dbg_print;
+extern bool kexec_core_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
+	do { if (kexec_core_dbg_print) pr_info(fmt, ##arg); } while (0)
 
 extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
 extern void kimage_unmap_segment(void *buffer);
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 55749cb0b81d..819c600af125 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -14,6 +14,7 @@
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
+#define KEXEC_DEBUG		0x00000010
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9bb1f2b6b268..c7a869d32f87 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	if (!image)
 		return -ENOMEM;
 
+	kexec_core_dbg_print = !!(flags & KEXEC_DEBUG);
 	image->start = entry;
 	image->nr_segments = nr_segments;
 	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..865f2b14f23b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,7 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-bool kexec_file_dbg_print;
+bool kexec_core_dbg_print;
 
 /*
  * When kexec transitions to the new kernel there is a one-to-one
@@ -576,6 +576,8 @@ void kimage_free(struct kimage *image)
 	kimage_entry_t *ptr, entry;
 	kimage_entry_t ind = 0;
 
+	kexec_core_dbg_print = false;
+
 	if (!image)
 		return;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a9794242..4a24aadbad02 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	 */
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
-
-	kexec_file_dbg_print = false;
 }
 
 #ifdef CONFIG_KEXEC_SIG
@@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!image)
 		return -ENOMEM;
 
-	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
+	kexec_core_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
 	image->file_mode = 1;
 
 #ifdef CONFIG_CRASH_DUMP
-- 
2.20.1


