Return-Path: <linux-kernel+bounces-897336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8DC529AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA188665A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD426461F;
	Wed, 12 Nov 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TA+CK6Aq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBF22541C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955803; cv=none; b=Un+5Tbug3RJ9nbGppF34l00iX3O1z9lkLq01hVPD5bfzggjE/1XZusCU1YS6MlJp8JahberQDWJicuKeBM+ATyQVZ4LqffJrcm5Z34usJjk/bv+UqT8S+Ns0gUhI5G4A0OWP5lOZ5RS1VtRU7PKHctO4dqlwyIxH90iCn8r9yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955803; c=relaxed/simple;
	bh=4lZpoytd9wMuonb3dOFE+PolYCa6fsoCL8ozB+NSSA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2zGR1+TlVQyXsZp/AfzqYGdnBC4p8hngQPTQs2G/vINAuUB7SxOpihU0PTHeMQb0i/s0aVbXZwDki3FCbrLqWHbWyzqnXQ1q9uU+oVWsaXMff8mo7av4HnUw00vguWSzyWaP8AkAwA05EOId8dlumhv5nXoZ6oFLgZXWQNs4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TA+CK6Aq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 24CB440E016D;
	Wed, 12 Nov 2025 13:56:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E2gcQI_fpAGv; Wed, 12 Nov 2025 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762955792; bh=Xl/6uiiKylR7vdTOGphJLlpsVNvUiH2+aj0Fvk2RcZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA+CK6Aq2fEnI7rH/PDmku/Cn+cdt/Dq5rPKRQdC/R1UnT+xz7oNFXq3QlxUqZ6f9
	 10t/Y8snO0JucJM7TXbcdH+0OaQpXbhrHu6v7sC3IOaMIk7HMefOuTE/dwH3DmnDUS
	 DgNMksDpVTLEn4OkHLU0TSm1zTu+EyWbC1052vYZ7dIRpArpuKhQql2b236J7e0UcE
	 KPihiowkYRyszVHDWx+2w+4XndN25eajwVbTWyo+Ivq7GVXIK+bSYX+BveBjoICKQv
	 Blkijsnk3sA8y0MURJZTxkDBPRh3T1quQRGlDYYyEJp6MMvt+Y5X6YXMBj+S9kjUXJ
	 UPLkLP2GywJD8U9CMpesBqcRQIz95KOOLnMwpdYwL+3OThiVPzBRt500kRAPggKGV7
	 e5/WcCj+S0tgJA1qT5WuMnHk16l36l8qSG5cI74vF+Y4/fo6q34l08B9iL7nYsRTAS
	 xkfCuIbm+5DyizI0kHM/pdaNYUxew1qzr8SOAmSAjjDNpSoGniy8JnaurLr0eSyuT0
	 HduQKZIXj8fYz/DX+0c1x+rEulvy5VZ3SOl0KseCTWf7feaN3qtbNq5+Djf8BugxwT
	 aBi5Z9Fv4064rESTWEj+IWy7TMA6YpDoWH83uemwP+7ErAdpWNc+5rbRS6Av48SO3D
	 aqO548m5zbkVxB+2tfQM9zHo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CC4A440E01CD;
	Wed, 12 Nov 2025 13:56:25 +0000 (UTC)
Date: Wed, 12 Nov 2025 14:56:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Michal Pecio <michal.pecio@gmail.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
Message-ID: <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111145357.4031846-1-yazen.ghannam@amd.com>

On Tue, Nov 11, 2025 at 02:53:57PM +0000, Yazen Ghannam wrote:
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

...

> +       return (lapic_flags & ACPI_MADT_ONLINE_CAPABLE);

Superfluous brackets.

In any case, yah, I'm going to queue this soon but I'll give Eric some time to
complain before I do.

I did play with:

https://www.qemu.org/docs/master/system/cpu-hotplug.html

and that works with that patch:

$ ./qmp-shell -p -v localhost:4444
Welcome to the QMP low-level shell!
Connected to QEMU 10.1.0
 
(QEMU) query-hotpluggable-cpus
{
    "arguments": {},
    "execute": "query-hotpluggable-cpus"
}
{
    "return": [
        {
            "props": {
                "core-id": 1,
                "socket-id": 0,
                "thread-id": 0
            },
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        },
        {
            "props": {
                "core-id": 0,
                "socket-id": 0,
                "thread-id": 0
            },
            "qom-path": "/machine/unattached/device[0]",
            "type": "host-x86_64-cpu",
            "vcpus-count": 1
        }
    ]
}
(QEMU) device_add id=cpu-2 driver=host-x86_64-cpu socket-id=0 core-id=1 thread-id=0
{
    "arguments": {
        "core-id": 1,
        "driver": "host-x86_64-cpu",
        "id": "cpu-2",
        "socket-id": 0,
        "thread-id": 0
    },
    "execute": "device_add"
}
{
    "return": {}
}
(QEMU)

and dmesg has:

[   33.281150] ACPI: acpi_map_cpu: cpu: 1, physid: 0x1, acpi_id: 0x1
[   33.289650] ACPI: CPU1 has been hot-added

But man oh man, if this ain't wagging the dog I don't know what is - we're
fixing the kernel so that qemu can hotplug because, oh well, "but then there
is this thing called reality^Wvirtualization which ruins everything."...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

