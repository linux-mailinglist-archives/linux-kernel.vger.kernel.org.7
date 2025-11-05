Return-Path: <linux-kernel+bounces-885828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB27C33FED
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F543B83FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997482459DD;
	Wed,  5 Nov 2025 05:30:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62F61FFE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320658; cv=none; b=oY8BkOBD8OvzXxpbW9UIv0iNdBmmngO17iwXJkg1RGT2W3K7QKZEBY6NIGDUcICNp1OLC9KoL/RhSqTgLY0L4Ot56W+YPeT0OLbJRxGO0GzzQGxIWgU4kMBiaHRPegJdppYgpgApbscvxGgXaHvVhRQJyI//mXhU7EzTKWq0jUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320658; c=relaxed/simple;
	bh=PRVgeTloQ/TAqQkbtjz5p3/sPSwlYj6HYwL71a7QobQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chTIjmFX++Kf1whAaJCJZHnVZ/KlDG5mDEqf1isZyUglAHmuoLv2OUIfhhDU2Kh+ZUb0Twx3m6mpqSSDJ/y2p9mYumwOpfhefds9Xg4FdJVZOFa0Peoz/+9/IhVBM1zAH20rlssBBc32SWZR+rXZGVKap9jLcupZDwFexRpF/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC9E616F2;
	Tue,  4 Nov 2025 21:30:46 -0800 (PST)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D8C3F63F;
	Tue,  4 Nov 2025 21:30:52 -0800 (PST)
Message-ID: <f5dbffae-52a5-4992-95a8-d47c925e286f@arm.com>
Date: Wed, 5 Nov 2025 11:00:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop redundant extern declaration for
 rodata_full
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com
References: <20251015023609.427911-1-anshuman.khandual@arm.com>
 <aQofCMqxiqujZP-g@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aQofCMqxiqujZP-g@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/25 9:13 PM, Will Deacon wrote:
> On Wed, Oct 15, 2025 at 03:36:09AM +0100, Anshuman Khandual wrote:
>> Drop the redundant extern declaration 'rodata_full' which can be included
>> via the header <asm/setup.h> after moving exiting declaration outside the
>> function arch_parse_debug_rodata(). While here also drop 'rodata_enabled'
>> which is anyways available via the generic header <linux/init.h>.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/mmu_context.h | 2 --
>>  arch/arm64/include/asm/setup.h       | 4 +---
>>  2 files changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
>> index 0375ca3162ff..e4b3563e1d96 100644
>> --- a/arch/arm64/include/asm/mmu_context.h
>> +++ b/arch/arm64/include/asm/mmu_context.h
>> @@ -26,8 +26,6 @@
>>  #include <asm/sysreg.h>
>>  #include <asm/tlbflush.h>
>>  
>> -extern bool rodata_full;
>> -
>>  static inline void contextidr_thread_switch(struct task_struct *next)
>>  {
>>  	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
>> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
>> index 3d96dde4d214..902f1aab520f 100644
>> --- a/arch/arm64/include/asm/setup.h
>> +++ b/arch/arm64/include/asm/setup.h
>> @@ -12,12 +12,10 @@
>>   */
>>  extern phys_addr_t __fdt_pointer __initdata;
>>  extern u64 __cacheline_aligned boot_args[4];
>> +extern bool rodata_full;
>>  
>>  static inline bool arch_parse_debug_rodata(char *arg)
>>  {
>> -	extern bool rodata_enabled;
>> -	extern bool rodata_full;
>> -
>>  	if (!arg)
>>  		return false;
> 
> It would probably be cleaner to make 'rodata_full' static in mm/pageattr.c,
> move the guts of arch_parse_debug_rodata in there and then consolidate
> can_set_direct_map() and force_pte_mapping().
> 
> You need to talk to Ryan for the last part, as David's made some
> suggestions around that too.

Sure will talk to Ryan about this. But for the above suggestion - probably something
like the following (untested) should work.

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 0dbe3b29049b..ddb964e916e1 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -26,8 +26,6 @@
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
-extern bool rodata_full;
-
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
 	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 3d96dde4d214..fa77a7208826 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -13,32 +13,7 @@
 extern phys_addr_t __fdt_pointer __initdata;
 extern u64 __cacheline_aligned boot_args[4];
 
-static inline bool arch_parse_debug_rodata(char *arg)
-{
-	extern bool rodata_enabled;
-	extern bool rodata_full;
-
-	if (!arg)
-		return false;
-
-	if (!strcmp(arg, "on")) {
-		rodata_enabled = rodata_full = true;
-		return true;
-	}
-
-	if (!strcmp(arg, "off")) {
-		rodata_enabled = rodata_full = false;
-		return true;
-	}
-
-	if (!strcmp(arg, "noalias")) {
-		rodata_enabled = true;
-		rodata_full = false;
-		return true;
-	}
-
-	return false;
-}
+bool arch_parse_debug_rodata(char *arg);
 #define arch_parse_debug_rodata arch_parse_debug_rodata
 
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b8d37eb037fc..030ee4ba8a7a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1014,9 +1014,7 @@ static inline bool force_pte_mapping(void)
 	bool bbml2 = system_capabilities_finalized() ?
 		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
 
-	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
-			   is_realm_world())) ||
-		debug_pagealloc_enabled();
+	return debug_pagealloc_enabled() || (!bbml2 && can_set_direct_map());
 }
 
 static void __init map_mem(pgd_t *pgdp)
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 5135f2d66958..60d372c630eb 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -80,7 +80,31 @@ static const struct mm_walk_ops pageattr_ops = {
 	.pte_entry	= pageattr_pte_entry,
 };
 
-bool rodata_full __ro_after_init = true;
+static bool rodata_full __ro_after_init = true;
+
+bool arch_parse_debug_rodata(char *arg)
+{
+	if (!arg)
+		return false;
+
+	if (!strcmp(arg, "on")) {
+		rodata_enabled = rodata_full = true;
+		return true;
+	}
+
+	if (!strcmp(arg, "off")) {
+		rodata_enabled = rodata_full = false;
+		return true;
+	}
+
+	if (!strcmp(arg, "noalias")) {
+		rodata_enabled = true;
+		rodata_full = false;
+		return true;
+	}
+
+	return false;
+}
 
 bool can_set_direct_map(void)
 {
-- 
2.30.2



