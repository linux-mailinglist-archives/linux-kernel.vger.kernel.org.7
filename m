Return-Path: <linux-kernel+bounces-899503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32AC57F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEC13AC85B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36380284B29;
	Thu, 13 Nov 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dcTbGm/1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34D204583
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044050; cv=none; b=VGtg323z414ToiyC9tWg2+JQX0WbjDRaQwlMtvO45sfrCB1eodCYI6aWQvAnS1cgZm2c9DAG7n1zujb6AYAE8jBTBuq4IEuoWnK0lQKSSThIrfUJsPrZhUwzy9OrnFVh0G2zy5qPlppRxbXXpAvrL5iWwXhkhdmE3nSBiLHcd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044050; c=relaxed/simple;
	bh=Ifb0Cj076tpWX2yvxsNpaJjmNCsTXeVM0kXB/rP9bgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C01IlIZ+qlXHiSH5FnhkpwMl4HYpSUwBgynMndOKN5GNkoj7rYbxQHwSpj2djt//QMVqPEIiNyzkEmYqHA0mZSSHIU/OqZF/yqT0MwUevofY52Gt56P81uHgRezgpoHMSl71pQZWmcwOn4VZnk/VF6o63XRQgPOd66tAUXcC9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dcTbGm/1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2C8DE40E022E;
	Thu, 13 Nov 2025 14:27:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yzauhrkjpnpa; Thu, 13 Nov 2025 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763044040; bh=Z7zpHoG2VXvquJsRrjkvaZlpyb+tgu/pAOsVrdaCBpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcTbGm/1JUl7uatRhwBxwWNvoT9e4WftKpROKx/lDYYztU19jmr2g4/cxn5Q2/t34
	 uf+PWGBd9OcOp5yzuAVnGCp7RUESzQrlZK1psxP7OOo4o1ErxfsBUpBS2La4BqFkZv
	 b/9qn79QNN6+myB7QSLPvg2W5kR8uv3L8CUmLr0jc1bOS87L8qRMLE8IJ5Kg2+q+pT
	 cGfVpz3JR0rU2lYuuAoVWHHcUQH/VIgiCp9xbu95zndATho/yHNTDEaqzziidP4fNK
	 NqXnzR4bHj9Ne6Yf1ZpnBQGyUqvzOO9cFT+z+HW/4BUTFusg4JsJAS6JrNmqb2lP+6
	 kdjTuGASG7xTA6OKfYAItxI19kChBHV9UrvgP2nnTLiUhNLyVrdDcBKYOs5ZOysuwc
	 4JJEXd/ZLieyXcd2vjN0d/nPymxa5Pk2urg2ZOgOlX8W9PNLjNQRRgHSAWig+2lL4m
	 EJLx5FFsDUgbWoWNtpO4HoMbKY7IJzV3PmZSXZQJ2S/EI+1cHHbIAPXIkCYoPMneOZ
	 lxneNO7LWsHBfcvv3ThjZoLqj2KTCBhv9YvaIIsDrVJE5sMaL4EMuRdCs/ejMdn+zw
	 SIdlGMAbI5jIoIQbmDx4MDvuOWSNqjzroB6y2F3pl3eelW1lqUUlNWz69ZxAn1lVWx
	 ajTzGGljbRL3j0ibCERNrYbI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6E7EF40E0219;
	Thu, 13 Nov 2025 14:27:14 +0000 (UTC)
Date: Thu, 13 Nov 2025 15:27:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
	Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check again
Message-ID: <20251113142713.GBaRXqweHEuZw1bjD1@fat_crate.local>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
 <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>
 <20251112172113.GFaRTCCfu2H6JpkZWB@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112172113.GFaRTCCfu2H6JpkZWB@fat_crate.local>

Seems to work here, I will run it on a couple more machines and even if it is
stable material, I'd let it go through a full cycle merge window so that it
sees more testing.

Thx.

---
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 11 Nov 2025 14:53:57 +0000

ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
used in conjunction with the "Enabled" MADT LAPIC flag to determine if
a CPU can be enabled/hotplugged by the OS after boot.

Before the new bit was defined, the "Enabled" bit was explicitly
described like this (ACPI v6.0 wording provided):

  "If zero, this processor is unusable, and the operating system
  support will not attempt to use it"

This means that CPU hotplug (based on MADT) is not possible. Many BIOS
implementations follow this guidance. They may include LAPIC entries in
MADT for unavailable CPUs, but since these entries are marked with
"Enabled=0" it is expected that the OS will completely ignore these
entries.

However, QEMU will do the same (include entries with "Enabled=0") for
the purpose of allowing CPU hotplug within the guest.

Comment from QEMU function pc_madt_cpu_entry():

  /* ACPI spec says that LAPIC entry for non present
   * CPU may be omitted from MADT or it must be marked
   * as disabled. However omitting non present CPU from
   * MADT breaks hotplug on linux. So possible CPUs
   * should be put in MADT but kept disabled.
   */

Recent Linux topology changes broke the QEMU use case. A following fix
for the QEMU use case broke bare metal topology enumeration.

Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
for guests and to maintain the ACPI spec behavior for bare metal.

Remove an unnecessary check added to fix a bare metal case introduced by
the QEMU "fix".

  [ bp: Change logic as Michal suggested. ]

Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
Reported-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Michal Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20251111145357.4031846-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
 arch/x86/kernel/cpu/topology.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9fa321a95eb3..d6138b2b633a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -35,6 +35,7 @@
 #include <asm/smp.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
+#include <asm/hypervisor.h>
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
@@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
 
-	if (!acpi_support_online_capable ||
-	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
-		return true;
+	if (acpi_support_online_capable)
+		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;
 
-	return false;
+	/*
+	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
+	 * in order to support CPU hotplug in guests.
+	 */
+	return !hypervisor_is_type(X86_HYPER_NATIVE);
 }
 
 static int __init
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 6073a16628f9..425404e7b7b4 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,6 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
-#include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/msr.h>
@@ -240,20 +239,6 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
-		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
-
-		/*
-		 * Check for present APICs in the same package when running
-		 * on bare metal. Allow the bogosity in a guest.
-		 */
-		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
-		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
-			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
-				     apic_id);
-			topo_info.nr_rejected_cpus++;
-			return;
-		}
-
 		topo_info.nr_disabled_cpus++;
 	}
 
-- 
2.51.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

