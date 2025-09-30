Return-Path: <linux-kernel+bounces-837225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18CBABBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65221C805C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60D222586;
	Tue, 30 Sep 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="udZD/qBx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="udZD/qBx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F710222587
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215867; cv=none; b=Pv8UTGtuD7zkQU5mAUbKyIM3W/mrzJScxviqeWO7gbhbZxmssiG1uC4PlxKOQnnpfFX06gX3OQGtbjs6RGCHsV/F1hiTu8k8UnYNY7bA+5sFxNa1oV8QOTRe3/s7qWS5jWHvLKbZVaG9fhnronLMX4Rc/7AQNvRjxmSr/+xbg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215867; c=relaxed/simple;
	bh=3vHsnR/o5asb5SnnHb/R17GZ2vgaoCxPRAPJMkAHAMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNGdIpWgZu8uny13aeFWthSnVrIoTtHpPFvLOwV6IdVRGcwlDYQ/JETzujCP5UOMz5w49Vem30lj1Oo46JA4lQI/lfeVvfXGACQ7mbsMdnbd1jupDjU1SRIHcBTjDiYFhZJ0LoGFKc8IiaQWENjo5hX1uMZW7iczodlH66V+Ly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=udZD/qBx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=udZD/qBx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03217336FF;
	Tue, 30 Sep 2025 07:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dyoxqlvmHpNQVL6a03vU/ea7RhvB/xZzRJIaBbmmRM=;
	b=udZD/qBxL/btw9GcCnfcUZONgAQB6c2RRR0WnPfMAbEgaAX80wQl7ja0JF0RBIF4SCEYFI
	kQIApESthheWJFHgLn2K0y8A+OW6rjSjky01hDCpkx4ZkSkpEIFRdL3PcZ0ZWtxja19hBZ
	DE9hVqtpdLYbp8T3OoVq6TuA4KxM1tw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dyoxqlvmHpNQVL6a03vU/ea7RhvB/xZzRJIaBbmmRM=;
	b=udZD/qBxL/btw9GcCnfcUZONgAQB6c2RRR0WnPfMAbEgaAX80wQl7ja0JF0RBIF4SCEYFI
	kQIApESthheWJFHgLn2K0y8A+OW6rjSjky01hDCpkx4ZkSkpEIFRdL3PcZ0ZWtxja19hBZ
	DE9hVqtpdLYbp8T3OoVq6TuA4KxM1tw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 982C713A3F;
	Tue, 30 Sep 2025 07:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jYV9I/GA22iPRwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 30 Sep 2025 07:04:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org
Cc: xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 03/12] x86/kvm: Remove the KVM private read_msr() function
Date: Tue, 30 Sep 2025 09:03:47 +0200
Message-ID: <20250930070356.30695-4-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930070356.30695-1-jgross@suse.com>
References: <20250930070356.30695-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Instead of having a KVM private read_msr() function, just use rdmsrq().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- remove the helper and use rdmsrq() directly (Sean Christopherson)
---
 arch/x86/include/asm/kvm_host.h | 10 ----------
 arch/x86/kvm/vmx/vmx.c          |  4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f19a76d3ca0e..aed754dda1a3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2296,16 +2296,6 @@ static inline void kvm_load_ldt(u16 sel)
 	asm("lldt %0" : : "rm"(sel));
 }
 
-#ifdef CONFIG_X86_64
-static inline unsigned long read_msr(unsigned long msr)
-{
-	u64 value;
-
-	rdmsrq(msr, value);
-	return value;
-}
-#endif
-
 static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
 {
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa157fe5b7b3..12bb1769e3ae 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1288,8 +1288,8 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	} else {
 		savesegment(fs, fs_sel);
 		savesegment(gs, gs_sel);
-		fs_base = read_msr(MSR_FS_BASE);
-		vt->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
+		rdmsrq(MSR_FS_BASE, fs_base);
+		rdmsrq(MSR_KERNEL_GS_BASE, vt->msr_host_kernel_gs_base);
 	}
 
 	wrmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
-- 
2.51.0


