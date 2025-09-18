Return-Path: <linux-kernel+bounces-811432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF48B528FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E513B5326
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52832797B1;
	Thu, 11 Sep 2025 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iIKZ32IN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iIKZ32IN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825832773D3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572548; cv=none; b=VLkpGIA8SBbKH6p5b0siQWOJpfLHYfV3CdEC0cqHyvpp8Oq1zZLl+aOAEynh5b9kUR8zQwPWlA3HogwGJK3ZR3m1B5WVUlehOv3VJLx2CLfkASg0mbxQ+ewUAgywnK8Gd0Aevg5WORhudzbAdkxGmnj01w/07KN+GY9pjMEmLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572548; c=relaxed/simple;
	bh=6c74RcFkRKAPxcRIBdDeqQgeh5jmPS2HZrzw/4mmbp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU839FGRnxOe7HHvqwWjaIYYfctnmHetDpp0ovHoBWNElr27AOsgrBuS9k9k0mTvgm+fzoqvxbg9S0FRWwLQ9o46GdeeGQ/+h1BpvYa35BvGQe8HZi8lZAD8ABc/cg8sxPBGmjqnQHB7DgDMecNHHpTQD0rGljNUrC3+3THg5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iIKZ32IN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iIKZ32IN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD4D03FA7F;
	Thu, 11 Sep 2025 06:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757572544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwbRHLALg5lwBc9OgVUB+3usz/LNGiagF/bxFj43cyE=;
	b=iIKZ32INl/ZYXAkpgDfbZ1kv7upRSYUWCbvcI02xFi4NYMTYL6p3WVeZpIILKEMMWX/ulI
	lW2wbz0/I2wRtO2xLTIH49uobGMLrdjNBpB/PZq60XmRSlaf4/Fy8/AbTHYfp19QOJD8xR
	/4leIyIhyow/2KKDzj1HsLpCJnTwI+A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757572544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwbRHLALg5lwBc9OgVUB+3usz/LNGiagF/bxFj43cyE=;
	b=iIKZ32INl/ZYXAkpgDfbZ1kv7upRSYUWCbvcI02xFi4NYMTYL6p3WVeZpIILKEMMWX/ulI
	lW2wbz0/I2wRtO2xLTIH49uobGMLrdjNBpB/PZq60XmRSlaf4/Fy8/AbTHYfp19QOJD8xR
	/4leIyIhyow/2KKDzj1HsLpCJnTwI+A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 416601372E;
	Thu, 11 Sep 2025 06:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w5NADsBtwmhHTQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Sep 2025 06:35:44 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 11/14] x86/paravirt: use common code for paravirt_steal_clock()
Date: Thu, 11 Sep 2025 08:34:30 +0200
Message-ID: <20250911063433.13783-12-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>
References: <20250911063433.13783-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

With alol archs supporting Xen now having been switched to the common
variant, including paravirt.h can be dropped from drivers/xen/time.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig                | 1 +
 arch/x86/include/asm/paravirt.h | 7 -------
 arch/x86/kernel/paravirt.c      | 6 ------
 arch/x86/xen/time.c             | 1 +
 drivers/xen/time.c              | 3 ---
 5 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 07bf67b849b7..0f8abf96cc39 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -784,6 +784,7 @@ if HYPERVISOR_GUEST
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on HAVE_STATIC_CALL
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 491cb7e037bf..37d7494ce146 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -21,10 +21,8 @@ struct mm_struct;
 #include <linux/static_call_types.h>
 #include <asm/frame.h>
 
-u64 dummy_steal_clock(int cpu);
 u64 dummy_sched_clock(void);
 
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
 void paravirt_set_sched_clock(u64 (*func)(void));
@@ -39,11 +37,6 @@ bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
 bool pv_is_native_vcpu_is_preempted(void);
 
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init paravirt_set_cap(void);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a3ba4747be1c..42991d471bf3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,12 +60,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
 void paravirt_set_sched_clock(u64 (*func)(void))
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 96521b1874ac..e4754b2fa900 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/sched/cputime.h>
 
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 53b12f5ac465..0b18d8a5a2dd 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -10,9 +10,6 @@
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
 
-#ifndef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
-#include <asm/paravirt.h>
-#endif
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
-- 
2.51.0


