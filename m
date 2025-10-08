Return-Path: <linux-kernel+bounces-845077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FBBC372B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7122619E1486
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A62D3EDF;
	Wed,  8 Oct 2025 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm/NHsEr"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA242A8B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904134; cv=none; b=Ic+Wm75CFmEcHX7DmZwi1lYXYLg7tKg2HY5UeTWV/kFs4PhLeedDVqBUuVJDh72eRApOzQHu2fAg7+dBGvUJnZB7KAaPWvx7MzXjJPbrcwnINhYUobXFk9SNApvlaoaRWNxiA6625FmfY5bGoKQ8JPm8IgTDrtoXQE5BE++CSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904134; c=relaxed/simple;
	bh=uKCxhwmwY0Ji0CDl09f49JOa6JF3kmVktdq4VvynfEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFTjtYpesHdGxk3UAJ0rqB5b4P5KbUlSVmN+Ee1m02Y83ra1geD72KGw4/mDCH0JJY93VJu0kt6pihQf+H7CwoLofLyvCsm9GXCxv1pu+sKvqiDz4xnFMsUhwVYPr6BY31EHirTCLpExGhvg5YFHAJ+A39wnYueMYe4a3nX6rb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm/NHsEr; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781db5068b8so5889683b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759904132; x=1760508932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WDMjYNVDGB7nxB23mvy74axT0H9whIV+VVsLhh4xxk=;
        b=nm/NHsErBvRkgmDd+0qv7LcXmCSLMV7V3kGGbFaGdx+Q+J5Lu3h4n9sAmvvVi8gMDW
         BKNYUj1wQkUIaiYfcuuY8Wh2lEKySQDMOxgV9GP/wIfwDkutppEYY+fj8910medXglQL
         YCkwfLfysrMOK77Zk2i4UAYBu06ZALR7El3Khi2gfuq4gOlaN3/llsH9cvxx7G1pNZir
         ALuhp9qIjsJDJcPDwoGr8cPGF0TkEUtJyCuehu4lARJn8xXB+xdQbjEzCJwEHSCVysL1
         9VRAUjQzq1CLNggurqwSSbiTahViq/dWAr5qm4Cs+pfE2SnNQaVjn9ADgyBNidyvHizu
         J/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759904132; x=1760508932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WDMjYNVDGB7nxB23mvy74axT0H9whIV+VVsLhh4xxk=;
        b=G+m/g82lmURhpaSI1KjyQnVPYgsOin6vJTzS4EqO93rwoYR4QBINT7H6DLiSioiY8H
         xzLfmzzVhlNnZdN1l6c5zywveGaE3ASbsUuW2+QQ2Y+QwIjk1OQkBbJPuFssMiLuKm7Q
         giZLK2QEveTaLaihtjrhlTW8/tgWJFOYvK+pcTWR90p378j7IE5EqpWewT9P9ijLHmED
         OECSpyIw4M1cbHG2fzxH9DvvivQq/zDL7Z+PE/b4fjnjPYxiL7qb70kw1NUcjznpPzoT
         CHpObbpC8nrLdoNXgTa4eulJ966doYeLHg6vCDXLhaxzF9jBWLOOj2Je/M1VL/HGACx8
         zvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ciRlxicjthSBrmr0SZ9opcQbpKw0Gpokt77OBWTbwE80xjs90wm8k5bHfgzZ727fd9E7iWgoOZMwjuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzAybdlEBJw86hAqdOIyse13mwOV+8ZHcoY3+9Wgusm5ul6gV
	WAolnWEcmXCfDmuFPgm9OYIBfY/tdcXgIzN1AsAtUjYHIWgSVFE9jZg=
X-Gm-Gg: ASbGnctsNGWSL8jKVdcldcKbF2BFx93omV6aKStxNu5/xXxf9oBygyq/HfyRqlmH61j
	i9k62QmFCEI43w+GiCCl9NXwTysJdWseGv3CXnT4UNbMRL9GF4HGlBLE5hqYGl8QahVT7fd4LdF
	XFZmUdES4P1EPLWqoTNVZYTa3iP1wVWZJ9wFemqwMTtHBrHyQ1yzdm4qU9TwU+yebpGbtJEiRvr
	6I7eEFd9sKTCQfi3FXHa31ff1pq06K/NzaqgFgYxp8cWysMikmZ0N6v30qz0s/PkEfEeLWHXKL4
	E+J1QEzagcyfYCG0JhB5mwGOkFCOfNyETZ7Y4pO5gYHHC/Br2e7mk+BgIHOi+4cpeo2SSEwwsgm
	bV67X9DGFtJ8ZFYPtIuAeof6fgqjEWfGpMQ1XvvxKpOB6x1o/XBtsO3XvAv9TRO5c4A==
X-Google-Smtp-Source: AGHT+IHVOUFBQzcyHHC2300S+MTlQPkVnUZmXbxHmKEFYJYegXscv3bRUT1/yEoYhhrLX7UroRd5+w==
X-Received: by 2002:a05:6a20:7351:b0:2a2:850:5605 with SMTP id adf61e73a8af0-32da8130f75mr2873766637.23.1759904132236;
        Tue, 07 Oct 2025 23:15:32 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a2522asm481872a91.8.2025.10.07.23.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 23:15:31 -0700 (PDT)
Message-ID: <d2a58601-f458-421b-8df3-b11cf2aeb5e0@gmail.com>
Date: Wed, 8 Oct 2025 14:15:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] x86/pci: Check signature before assigning shadow
 ROM
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815162041.14826-1-tomitamoeko@gmail.com>
 <aKGkrSWUA8BTYniZ@wunner.de>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <aKGkrSWUA8BTYniZ@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for my extreme late reply...I didn't noticed this message
until I searched this topic in lore.kernel.org. Somehow it didn't
reached my inbox, or maybe I deleted it by mistake :(

On 8/17/2025 5:45 PM, Lukas Wunner wrote:
> On Sat, Aug 16, 2025 at 12:20:41AM +0800, Tomita Moeko wrote:
>> Modern platforms without VBIOS or UEFI CSM support do not contain
>> VGA ROM at 0xC0000, this is observed on Intel Ice Lake and later
>> systems. Check whether the VGA ROM region is a valid PCI option ROM
>> with 0xAA55 signature before assigning the shadow ROM to device.
> 
> Which spec is the 0xAA55 magic number coming from?
> 
> Could you add a spec reference for it in a code comment and the
> commit message?

Sorry I am unable to find the exact spec as PCI-SIG only prvide spec
access to their members. I think I should reuse the ROMSIGNATURE macro
mentioned below.
> I note that arch/x86/kernel/probe_roms.c contains ...
> 
>   #define ROMSIGNATURE 0xaa55
> 
> ... and a function romsignature() to check the signature.
> I'm wondering why that existing check isn't sufficient?
> Why is it necessary to check again elsewhere?

The check itself for accessing the Option ROM is sufficient, kernel reports
"Invalid PCI ROM header signature: expecting 0xaa55, got 0x****" error when
an invalid ROM is accessed.

However, the issue here is that the VGA BIOS region is always exposed as
PCI Option ROM on the primary VGA device, even when it doesn’t actually
contain a valid Option ROM (for example, on modern platforms without
VBIOS). In such cases, exposing this region as an Option ROM is unnecessary
and results in misleading "Invalid PCI ROM header signature" errors.
Checking the signature before exposing the region helps to avoid that.
>> +++ b/arch/x86/pci/fixup.c
>> @@ -317,6 +317,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
>>  	struct pci_bus *bus;
>>  	u16 config;
>>  	struct resource *res;
>> +	void __iomem *rom;
>>  
>>  	/* Is VGA routed to us? */
>>  	bus = pdev->bus;
>> @@ -338,9 +339,12 @@ static void pci_fixup_video(struct pci_dev *pdev)
>>  		}
>>  		bus = bus->parent;
>>  	}
>> -	if (!vga_default_device() || pdev == vga_default_device()) {
>> +
>> +	rom = ioremap(0xC0000, 0x20000);
> 
> There's a code comment preceding pci_fixup_video() which says that
> "BIOS [is] copied to 0xC0000 in system RAM".  So this isn't MMIO,
> it's system memory and you can use memremap() instead if ioremap().
> 
> Since you're only interested in the first two bytes, you don't need
> to map the whole 0x20000 bytes.
> 
> Instead of amending the if-condition ...
> 
>> +	if (rom && (!vga_default_device() || pdev == vga_default_device())) {
>>  		pci_read_config_word(pdev, PCI_COMMAND, &config);
>> -		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
>> +		if ((config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) &&
>> +		    (readw(rom) == 0xAA55)) {
>>  			res = &pdev->resource[PCI_ROM_RESOURCE];
> 
> ... you could just return on failure to find a valid signature, i.e.:
> 
> +	rom = memremap(0xC0000, sizeof(sig), MEMREMAP_WB);
> +	if (!rom)
> +		return;
> +
> +	memcpy(&sig, rom, sizeof(sig));
> +	memunmap(rom);
> +	if (sig != 0xAA55)
> +		return;
> 
> May want to emit an error on failure to memremap().
> 
> Amending the if-condition makes it messier to find an offending commit
> with "git blame" (more iterations needed).  And returning early reduces
> indentation levels per section 1 of Documentation/process/coding-style.rst.

Got it, will fix in v2.

Thanks,
Moeko
> 
> Thanks,
> 
> Lukas
> 


