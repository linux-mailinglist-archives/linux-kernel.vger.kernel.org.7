Return-Path: <linux-kernel+bounces-897877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CABC53D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D7EE343971
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CF34AB04;
	Wed, 12 Nov 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azw0oENK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B634A773
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970726; cv=none; b=TaLWCjIX1x9YzpMY9OqW0VO2LeBqZIFC1uW8P3nPjx2z0l19q29fdS1AnAMJXm5df46QN729P8Kjjih4y74z713v0XHADo7drzaOKygbDocWybGFUdpMUDmG82kiYBfYlPTnfmczlYVhOC1NqHe1xiJU8Z/mfmqS+u+Y2RvtFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970726; c=relaxed/simple;
	bh=JJhWuUfKjfoTdbEou2+vOHNBbjETqciPdS+JpKC+vaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gec3ADkrPlTO3Uh1bx1wJPwEBR4noXefz3pr67R88Qeo5X/TnVLwj7Zxsh7dtPp+P4M0S4F0QhxgZ/PErE3pqynbV/97hd7yQJdQ8Z6ldeWX6yeI0dga4QTe+2px8hKsouqHI7LriMHQpjxoqZinZ9VrsfGZhLDIB1ok0GgIHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azw0oENK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b71397df721so181653266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970723; x=1763575523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8esr479v7mgOcCz99NRYV5W+ZXuXwVhrGsFeb3DT1cA=;
        b=azw0oENKvsQraiZOpAc54ux1YUHTnyH8p29cGAgAlIqRqE2zJJNxQ4g0qP62jDF1rt
         0/toLDpsAS+Xq5On/PFkDky8JDI9gNfsvBz+EHJ1/5Alx9oURk84gAyJlI4YqcgnoJU4
         dvjKKY9FiT1JPZq7TWNPsNPZD0OWFkvQCxiEkZ5LKi0xTxk6aW+IiXREPzQH+tZ9bE2e
         PlsRvuclZtGdMKY6CWmACsH2rOlYuKVW9YPijbhiGfuw8brOO4HsEaKCKGpB8ROjpqQb
         EwiLgHcZHIVcYfmxZmF77Kq7z2UizxeaWVRsCIq11kCPgyflYEnQdnM3ciQEk6wlQhn1
         /l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970723; x=1763575523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8esr479v7mgOcCz99NRYV5W+ZXuXwVhrGsFeb3DT1cA=;
        b=XjmKlOv7l9aSkly0ZtRY2e3lD2L0c5P7vYqUMuYjiJjX5qZJGxT385eBe7HKI5Q/HU
         x/7Tphbvzi96oDFyjUY8ery+3TGbp6kOD7pzEG80aloYMYQNVPMBqNz52odBi7Bm49PH
         pfIzeCCCPttdScQr7TfBAm70GdBC4px2VFzM6GH7VV6npOGNG5kawo+52/st3C0dZAlq
         i9VikL83tFpmNjcMDjJQSf+iMYQFym/cthJTAu5HCiahtPYyfWZeUKKQf9ybz8FqSAdi
         VFDEiDyb+bUCWjkVzZg9osYRVMB64l3DrtLjJTrCZ1VWUg/Ou/IcCW51/8j80eTROhoH
         gf3A==
X-Forwarded-Encrypted: i=1; AJvYcCUZNJsWCccHm9Xjyxhy6p1c5/5Y4ODU0jHxsxx1zxOALtRO7L6AWqsCY7Dt/UDZHu9dtwPKwtfVf7iYMWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dNrzKwEa6TdxruLuDdMZQEcs4kT+op27IN5+81OJWhxAj/Lu
	DVCgbqt6WevnSA1qL7XKHe99WXb2c8/1jaLAKg5JshR1nwX8Hz+YKBy0
X-Gm-Gg: ASbGnctT3fVRtSTIDJD/r8K52HO3cr53qioZyZHYzDkSRUYe3PqUU109l9lHF6Gw4Mk
	qhwvu93hVs+XrtCImvN5DkOfGxGvFuENtsLLg0ZeiQOwVyRXgcYQEtKFqN6q8fmdnXZ6FX7QmEC
	E3hMThJ3aoy+fCqfE3MnTAkYekrenExhsvJzp1JrVZYU2MtASQ8Lj8acPS4LjfdYR5VQ36HHc6c
	nGGrkLTc7qdsvqeKgzxuluN2wPlhYN1SxT8Q0ivQP3UUv2gtaedSTseVaFLQCD4KAkiLzs+ot+K
	5WvQFT/D1hTY3Vg/ZdHclOmyHUH3CDi/gY9OWXMzP8PHhSD6e1HoFBpqpyHcKFhaa7rdGyGX/6i
	q0JU3lB0ng3HYe+F5WAm2pK3Ea87d2MisHtid/JG77MynLAuUrTNRfJ6k+noB35yo7ue2zsuCp2
	BmpSpn6NGBNfOUAkfeBaZg+qQoLYTDMKE=
X-Google-Smtp-Source: AGHT+IEXT//dXpcDJxe4AtKZmv0j5rtN+pgbbO2oyBV7KeFEF6EOR1apEsaOd2IUrvq2njqeDL4B0Q==
X-Received: by 2002:a17:907:7f0c:b0:b6d:3f38:2969 with SMTP id a640c23a62f3a-b733198f05bmr457882266b.18.1762970722645;
        Wed, 12 Nov 2025 10:05:22 -0800 (PST)
Received: from foxbook (bfd52.neoplus.adsl.tpnet.pl. [83.28.41.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd36csm1708471166b.61.2025.11.12.10.05.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Nov 2025 10:05:22 -0800 (PST)
Date: Wed, 12 Nov 2025 19:05:18 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Eric DeVolder
 <eric.devolder@oracle.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
Message-ID: <20251112190518.2056dab3.michal.pecio@gmail.com>
In-Reply-To: <20251111145357.4031846-1-yazen.ghannam@amd.com>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 14:53:57 +0000, Yazen Ghannam wrote:
> ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
> used in conjunction with the "Enabled" MADT LAPIC flag to determine if a
> CPU can be enabled/hotplugged by the OS after boot.
> 
> Before the new bit was defined, the "Enabled" bit was explicitly
> described like this (ACPI v6.0 wording provided):
> "If zero, this processor is unusable, and the operating system
> support will not attempt to use it"
> 
> This means that CPU hotplug (based on MADT) is not possible. Many BIOS
> implementations follow this guidance. They may include LAPIC entries in
> MADT for unavailable CPUs, but since these entries are marked with
> "Enabled=0" it is expected that the OS will completely ignore these
> entries.
> 
> However, QEMU will do the same (include entries with "Enabled=0") for
> the purpose of allowing CPU hotplug within the guest.
> 
> Comment from QEMU function pc_madt_cpu_entry():
>     /* ACPI spec says that LAPIC entry for non present
>      * CPU may be omitted from MADT or it must be marked
>      * as disabled. However omitting non present CPU from
>      * MADT breaks hotplug on linux. So possible CPUs
>      * should be put in MADT but kept disabled.
>      */
> 
> Recent Linux topology changes broke the QEMU use case. A following fix
> for the QEMU use case broke bare metal topology enumeration.
> 
> Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
> for guests and to maintain the ACPI spec behavior for bare metal.
> 
> Remove an unnecessary check added to fix a bare metal case introduced by
> the QEMU "fix".
> 
> Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
> Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
> Reported-by: Michal Pecio <michal.pecio@gmail.com>
> Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>

Tested-by: Michal Pecio <michal.pecio@gmail.com>

Confirmed to fix the original machine where I discovered this bug and
looks like it would fix all the others too.

My BIOS claims conformance to ACPI 3.0 and the definition of "enable"
bit was the same as in 6.0 quoted here.

> ---
> 
> Notes:
>     Link:
>     https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
>     
>     Hi all,
>     
>     This patch came out of the discussion above.
>     
>     A number of folks (myself included) understood the ACPI MADT LAPIC
>     "Enabled" flag to be potentially used for CPU hotplug. This is
>     explicitly false based on the wording in older revisions of the ACPI
>     spec.
>     
>     However, this understanding is used for QEMU. Hence we need a check to
>     differentiate the virtualization and bare metal use cases.
>     
>     Thanks,
>     Yazen
> 
>  arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
>  arch/x86/kernel/cpu/topology.c | 15 ---------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 9fa321a95eb3..bc99398852c4 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -35,6 +35,7 @@
>  #include <asm/smp.h>
>  #include <asm/i8259.h>
>  #include <asm/setup.h>
> +#include <asm/hypervisor.h>
>  
>  #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
>  static int __initdata acpi_force = 0;
> @@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
>  	if (lapic_flags & ACPI_MADT_ENABLED)
>  		return true;
>  
> -	if (!acpi_support_online_capable ||
> -	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> -		return true;
> +	/*
> +	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
> +	 * in order to support CPU hotplug in guests.
> +	 */
> +	if (!acpi_support_online_capable)
> +		return !hypervisor_is_type(X86_HYPER_NATIVE);
>  
> -	return false;
> +	return (lapic_flags & ACPI_MADT_ONLINE_CAPABLE);
>  }

Nitpick: IMO logic would be easier to follow if written this way:

	if (lapic_flags & ACPI_MADT_ENABLED)
		return true;

	if (acpi_support_online_capable)
		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;

	/* we should say 'no' at this point, but VMs are crazy */
	return !hypervisor_is_type(X86_HYPER_NATIVE);

>  
>  static int __init
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 6073a16628f9..425404e7b7b4 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -27,7 +27,6 @@
>  #include <xen/xen.h>
>  
>  #include <asm/apic.h>
> -#include <asm/hypervisor.h>
>  #include <asm/io_apic.h>
>  #include <asm/mpspec.h>
>  #include <asm/msr.h>
> @@ -240,20 +239,6 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
>  		cpuid_to_apicid[cpu] = apic_id;
>  		topo_set_cpuids(cpu, apic_id, acpi_id);
>  	} else {
> -		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> -
> -		/*
> -		 * Check for present APICs in the same package when running
> -		 * on bare metal. Allow the bogosity in a guest.
> -		 */
> -		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
> -		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
> -			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
> -				     apic_id);
> -			topo_info.nr_rejected_cpus++;
> -			return;
> -		}
> -
>  		topo_info.nr_disabled_cpus++;
>  	}
>  
> 
> base-commit: ed4f9638d905a97cebd49ecea85cc9b706b73761
> -- 
> 2.51.2
> 

