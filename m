Return-Path: <linux-kernel+bounces-882403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD6C2A60C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5513B51D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220E2C0F81;
	Mon,  3 Nov 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9bhxGfR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468832C0F73
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155630; cv=none; b=YFqifapPZu9IyyHF79PVzHp+6qQQ86/vFY6TzWrVd4MsIpi5Te+OC8TRr423rxTjZalDxGpbuPqXAXXvlnTrPijkjm4jfAGxKu/rSQmR0dXpt6McKp9xkZaHP1jhTHnqn7xWfHKdPRjY9mAL2+4d1Jt8PstydWT+x9h06Q7bgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155630; c=relaxed/simple;
	bh=SlYci0dHrICe6IYWx0Y+e0NJm66MSzaFWjZ4oIwtkgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lbvwl8KEgMk09P6PbJi88bLoUhQ9QPK7enxyjZ1qqecY/SPoEIE6pYRivAhaw9Ox4VALj/E8+5+LPavUjN3tvbcGwWcFbVgF9Ze/g9pKnbvZvcXQELs/qpCpTyRQR7A62G86pcZ18A5yLyLbjo7xfXw0K/sRZk6zvAZ8Fl9JTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9bhxGfR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b713c7096f9so51849566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762155626; x=1762760426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2AFHpbxsNUgkkbbq9RMTdgycoyfFsp4yUttyYC4IbY=;
        b=i9bhxGfRytoa+8P67zy5qKnoV+M4B/nJwKWsp89XkE4Gc3/IF15NtPFYFJC0J9rFiJ
         UoLT/gekVSfPJUQe7OZSqBM+kDaJOphcEQH3pm2YrHuu8UtU5gxoaQN03DfwBZ8RoOxD
         LWUNoI08sp0ZVSp1hQuM0eCWlydQAeoYsaaJausQNUfoQijpNG++KF53wz3vepZjmdXu
         GPsRiwyzMM0JryLhZ2dBGIZ3lOblMIPOUM+aujhMc6HPRC+6w617Owdgz/ZW177ZCYad
         P3moLp6s2XbSrHqDd1dEouMJhGsrtWunRVYALiqKleBjRgFq3AdoiD4Mf1X8AbnV1Z6g
         XiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155626; x=1762760426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2AFHpbxsNUgkkbbq9RMTdgycoyfFsp4yUttyYC4IbY=;
        b=PeYyurr5ZjdQ1gEogBVvE3u7Kag+ohMahmAlrUHgpz9Fk1eGZmmn8OYibI6CEkUjiZ
         w09wCQLoWCCSSobVfSkBIYSvR8iNOnwoc7JBaJwB1C9FxXGkXlEeuZLPAP+nCbUUkRVe
         4hkJvBxUh2XWOwz1exv27j8owsl/eI6ax23Wds7fSs4F9smK0ZBvGV+0ZdGIg18F3M7t
         lPjrM1mvMEP+jnxNGEy+VFU7UFagVo/cJ4qKsD2rynWKSVU9adhMELdMhxya7OZZe3bz
         Y25AYxy1zmagmWcssiV6xi9FEyJ6Jdjqp/gYrHz+0mh0FPUFYG+5X4FaRNx5r9txLr1F
         ka6g==
X-Forwarded-Encrypted: i=1; AJvYcCXCP+9mFRTsopC5rLAtZRF5zh4LUi9E95YRA3aNTBLxQiudCPkmtKlIqEsvbI10VIj+STOGwDVmEMMAmm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhozg4dhCjmkbL5x/r+s246r85aNImN5lG8JQj23JyjCGIO68Q
	SP2fPXQAxcXMHA1VQE5+2u5n3G59xrpyz/vPtHtrP+dAZehHI+ezkLF8
X-Gm-Gg: ASbGncvn/aRlNBCF7uQiwp9yVDaIHT4DVtPfkXiCeNFkwaS7BWlWlx3i4QDeDfFmEMY
	z3/0cYNveJ51rYwGyww10O2GQXdB9Kyiq2SH+ju3/5WyNOMuJpXQe2KgGWzlChOIvxULcSbQpQD
	8aQ9XiAovI0Xjjgbd4AqS4kTWbnjnOUmunggyvLys3Gb1Op4nK7QMYHP89J/joqvVro3/r1EZWr
	ZMnuu68N5OE7gOc2USFsyNEPQvNzcDqqr++NvVP4xxrxC6Iwtn/U5ua3NblhXkJygkH2JfvwdaD
	kG9S5lYlCDOxW07YvBxsbLASn3ISQ8x0kaJQ0rk+Se4krJIVu3Eg72I7GVaDTd61zBeTBphe19q
	DNO6dJd5dQ5hmS/0jyQSBOd5hwOpF0pUGqTLs0Bc1zUacu6Gnrmk38vh6qIoAzrPV/mElW2khYe
	5q9TVonTFc3FAteTUO5WLbM+I=
X-Google-Smtp-Source: AGHT+IGKT2y7pvRw9Ei6hvplikIPDxCl0VQxMHigFaaEnt+tk1MLnjtl0oCPOkTCngJEh5b5IFkpeA==
X-Received: by 2002:a17:907:7f0f:b0:b6d:536f:ada with SMTP id a640c23a62f3a-b7070627837mr1069754166b.43.1762155626262;
        Sun, 02 Nov 2025 23:40:26 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c3ad94sm963280266b.47.2025.11.02.23.40.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 02 Nov 2025 23:40:25 -0800 (PST)
Date: Mon, 3 Nov 2025 08:40:21 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, regressions@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Mario Limonciello <mario.limonciello@amd.com>, Eric
 DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD topology broken on various 754/AM2+/AM3/AM3+ systems causes
 NB/EDAC/GART regression since 6.14
Message-ID: <20251103084021.61971a89.michal.pecio@gmail.com>
In-Reply-To: <20251024213204.GA311478@yaz-khff2.amd.com>
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
	<20251024213204.GA311478@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 17:32:04 -0400, Yazen Ghannam wrote:
> So far, I think the way to go is add explicit quirk for known issues.
> 
> Please see the patch below.
> 
> Thanks,
> Yazen
> 
> 
> From eeb0745e973055d8840b536cfa842d6f2bf4ac52 Mon Sep 17 00:00:00 2001
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Fri, 24 Oct 2025 21:19:26 +0000
> Subject: [PATCH] x86/topology: Add helper to ignore bogus MADT entries
> 
> Some older Intel and AMD systems include bogus ACPI MADT entries. These
> entries show as "disabled". And it's not clear if they are physically
> present but offline, i.e halted. Or if they are not physically present
> at all.
> 
> Ideally, if they are not physically present, then they should not be
> listed in MADT. There doesn't seem to be any explicit x86 topology info
> that can be used to verify if the entries are bogus or not.
> 
> Add a  helper function to collect vendor-specific checks to ignore bogus
> APIC IDs. Start with known quirks for an Intel SNB model and older AMD
> K10 models.
> 
> Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/cpu/topology.c | 52 ++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 6073a16628f9..704788b92395 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -219,6 +219,45 @@ static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_leve
>  	return cnt;
>  }
>  
> +/*
> + * Some older BIOSes include extra entries in MADT.
> + * Do some vendor-specific checks to ignore them.
> + */
> +static bool ignore_extra_apic_entry(u32 apic_id)
> +{
> +	u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
> +	/* Allow "physically not possible" cases if in a guest. */
> +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> +	       return false;
> +
> +	/* This model only supports 8 threads in a package. */
> +	if (c->x86_vendor == X86_VENDOR_INTEL &&
> +	    c->x86 == 0x6 && c->x86_model == 0x2d) {
> +		if (topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map) >= 8)

Looks like possible functional change compared to the code it replaces,
perhaps it should be a separate patch?

> +			goto reject;
> +	}
> +
> +	/*
> +	 * Various older models have extra entries. A common trait is that the
> +	 * package ID derived from the APIC ID would be more than was ever supported.
> +	 */
> +	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 < 0x17) {
> +		pkgid >>= x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN - 1];
> +
> +		if (pkgid >= 8)
> +			goto reject;

Yes, this works. The excess entries are counted as "rejected" rather
than "hotpluggable", package count is correct and EDAC/GART are back.

But to be exact, the known case is (apic_id >= 0x80) rather than
(pkgid >= 8). The latter assumes not only that there are no more than
8 packages, but also that their IDs start from zero.

I have this AM4 system with some proprietary HP BIOS:

[02Fh 0047 001h]               Local Apic ID : 10
[037h 0055 001h]               Local Apic ID : 11
[03Fh 0063 001h]               Local Apic ID : 12
[047h 0071 001h]               Local Apic ID : 13

domain: Thread     shift: 0 dom_size:     1 max_threads:     1
domain: Core       shift: 4 dom_size:    16 max_threads:    16
domain: Module     shift: 4 dom_size:     1 max_threads:    16
domain: Tile       shift: 4 dom_size:     1 max_threads:    16
domain: Die        shift: 4 dom_size:     1 max_threads:    16
domain: DieGrp     shift: 4 dom_size:     1 max_threads:    16
domain: Package    shift: 4 dom_size:     1 max_threads:    16

It seems that pkgid is 0x1 here, which is not a problem because
it's single socket, but dunno if HP or somebody else couldn't do
similar things in an 8-socket system and end up with pkgid > 8.


By the way, do you know what's the reason I don't have /sys directories
for those phantom CPUs (before this patch) and should I have them if
they were legitimate hotplug CPUs?

Maybe there is already some check performed in other part of the kernel
which rejects those CPUs and which could be replicated here.

> +	}
> +
> +	return false;
> +
> +reject:
> +	pr_info_once("Ignoring hot-pluggable APIC ID %x.\n", apic_id);
> +	topo_info.nr_rejected_cpus++;
> +	return true;
> +}
> +
>  static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
>  {
>  	int cpu, dom;
> @@ -240,19 +279,8 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
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
> +		if (ignore_extra_apic_entry(apic_id))
>  			return;
> -		}
>  
>  		topo_info.nr_disabled_cpus++;
>  	}
> -- 
> 2.51.1
> 

