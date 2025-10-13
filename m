Return-Path: <linux-kernel+bounces-850601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7DBD3444
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB53B8F54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74783081A7;
	Mon, 13 Oct 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lLahi/At"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C333081A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362996; cv=none; b=Mbu+//gSOPt5bMKuG6tVwE+ZbFlcLFtwnvDepHXCiOrCR0CWYwRqHp/ltX1Ho14GleRgPxH0FlHOuV6BVWdzaPZfHiW19O0nnDmuzzbrQYnjLBu7LNpBu1PCYq4Wx88nWrN+4jDxgiLIT5FX5uIc7xqChAR5CBDa+d5obvuFyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362996; c=relaxed/simple;
	bh=6yIFNmfLwhPfUULLEFWAgXeo3uOQXMtTH80Sfc+mC1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrp39oWBPPU1YQX9zMgU02lK6Os8ARtGhr1yUhJfe7lwy7ZlG3yYAAFy+Q79HNTJlwHIVmDq5eLi2ujoIjxiwU6FaHDkJvfBijD7BooABRptTDa/OrkP8KuZO0oCC4dHqR3ioIig29WYmMDcl9kKUxEyn4lU0rWuYcztdZX45qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lLahi/At; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AD2FF40E019F;
	Mon, 13 Oct 2025 13:43:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XAqAQ6iWCoXQ; Mon, 13 Oct 2025 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760362986; bh=gQxOnHl5Pe3zYv+mLTpAa+LHml1po19BZ/3R70WeGlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLahi/At+Tg7HlrUYyq04vZkEInB5OXCnwjCw9QvVJvtBPnyjD0rv9dnB7u5qfUbA
	 3QpRmCMl1LhYgxrxuslIMarp6rPs99rBDzbP72zg5UGmJYeUOgtlrW5b5MTuL0XcGS
	 +N0us5iK3eBdexhRTMTuAEc7gJCP2hS5D+0njfCQQFo2NdtqfK4x6fCNup1/aUfI0g
	 WAGyOnubOkvQRMYOpF/WJs34HdqZx8+Afn4S/FcMs5LPWoRdrknh038MpyiB4LTVyG
	 Ej9Cj7WcmRdmTq1t85rxLhi6v8yw9P9XpWbdUyH4PLjy9vzwMXcD7/LDyhiZNGrj3x
	 QPbXpFx5vLeRXUiUlvm2HMKMXRr+UJUcxqxjGhRLsMA8H2TA4o/cXSB6M0Q38OFsNG
	 VeAqvwBymfKT7cZ5KeLaAw6VzqyNPFb/OuTGWU/ROzYGw4Wgnwhz3F8Gy9L1f3lZt1
	 U79pfic5DU1BbzlE5xPrCmM2YqBQGHGo4mZ9nX2TryhwqMHaYN96uVxI/j1PnSgQyp
	 l+j6BiP0TaDWDyubNgp0neNlN4yOO1wWsupvcDY9SD0ytyfBNh8YKil3TPN0F6PLtG
	 EmpFS37VSo1YgHfKQI6O9gX10V6nDSyt6YRKkD6GPL9UFz6wvnGooY0fHYG6kLiDJE
	 ypr4O+zfKOam6VFSddGnWMqg=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4553040E019B;
	Mon, 13 Oct 2025 13:42:57 +0000 (UTC)
Date: Mon, 13 Oct 2025 15:42:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de, tony.luck@intel.com
Subject: Re: [PATCH v6 3/7] x86/microcode/intel: Establish staging control
 logic
Message-ID: <20251013134250.GAaO0B2rb_smA83z32@fat_crate.local>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
 <20250921224841.3545-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921224841.3545-4-chang.seok.bae@intel.com>

On Sun, Sep 21, 2025 at 03:48:37PM -0700, Chang S. Bae wrote:
> When microcode staging is initiated, operations are carried out through
> an MMIO interface. Each package has a unique interface specified by the
> IA32_MCU_STAGING_MBOX_ADDR MSR, which maps to a set of 32-bit registers.
> 
> Prepare staging with the following steps:
> 
>   1.  Ensure the microcode image is 32-bit aligned to match the MMIO
>       register size.
> 
>   2.  Identify each MMIO interface based on its per-package scope.
> 
>   3.  Invoke the staging function for each identified interface, which
>       will be implemented separately.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Tested-by: Anselm Busse <abusse@amazon.de>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Link: https://lore.kernel.org/all/871pznq229.ffs@tglx
> ---

Fixups ontop:

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index daae74858347..216595a45564 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -315,15 +315,18 @@ static void stage_microcode(void)
 	int cpu, err;
 	u64 mmio_pa;
 
-	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
+	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32))) {
+		pr_err("Microcode image 32-bit misaligned (0x%x), staging failed.\n",
+			get_totalsize(&ucode_patch_late->hdr));
 		return;
+	}
 
 	lockdep_assert_cpus_held();
 
 	/*
 	 * The MMIO address is unique per package, and all the SMT
 	 * primary threads are online here. Find each MMIO space by
-	 * their package ids to avoid duplicate staging.
+	 * their package IDs to avoid duplicate staging.
 	 */
 	for_each_cpu(cpu, cpu_primary_thread_mask) {
 		if (topology_logical_package_id(cpu) == pkg_id)
@@ -337,7 +340,7 @@ static void stage_microcode(void)
 
 		err = do_stage(mmio_pa);
 		if (err) {
-			pr_err("Error: staging failed (code = %d) for CPU%d at package %u.\n",
+			pr_err("Error: staging failed (%d) for CPU%d at package %u.\n",
 			       err, cpu, pkg_id);
 			return;
 		}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

