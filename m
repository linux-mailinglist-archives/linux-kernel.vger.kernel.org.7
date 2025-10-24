Return-Path: <linux-kernel+bounces-868437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B51C053B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14654015D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14829305E09;
	Fri, 24 Oct 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePRmMW7/"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E430594A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295740; cv=none; b=bkpb710TuzL8YZ7DhZvQUo6kQ8llYhAKFKhcD6MhNi+fQKjKbH08K1x5AMzcKM90Ll2LxccYc/CuEWTlg5pnU0Q93L6t+krX1FHgbT46iulLzQpNVpM0BypulKfY+5ABcdmqC49WI2j29z/q6y6exLLGXf1LPX3JDKvKthOjnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295740; c=relaxed/simple;
	bh=ztHIOhEiiaqBoopvTIXqOUqJUfk2HMRNxwUoONlyffU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k53Co5VsY/niypBdPD14kG/yHVipYSM8p6IsDbvJ5s9EehIlzC/ittOzlHOCkKocpR0G0fKnaoT7uR8kDg/myL5/6f5xmK2yBVNhyZs+i3L0rqzghE6i9R9C6NKL36+vE41dRy3PLMLwykt/c8sKXJvcoob562N7dmR6VI+TJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePRmMW7/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-378d54f657fso22124481fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295736; x=1761900536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4kJQLU7HkQQtlqv3b3bm8HqvzrF9H7Chbd+Noruans=;
        b=ePRmMW7/EJ3T5kaynQgUdTh/i2uC22RIqoPAFXDGZlwofd4XUy0p/6v3MQ+o0SInzI
         Cvp8KK6C48u5s8Dx1WERvhtxR9heJtx+YOXPK34AyRjNq/kEUbeoWX41PDrWIHI3yuGZ
         YANelvWiJcZ2qlIVlnuX41GmQ1yPGoOq8eFO3+FGK9uqfS235r7mg3uwtpsDRuATos+7
         04dNIw3OiMj/xeD4uL5cWCxyPbraVB6g3pLXyARo7AzDEPuDCOXWeCOy5USm+0sJXBgN
         r2+Rdpz9/cDwBogHV+a/Lul+j2Vd+KtNuaw/ZzZrcQZu90OHsUuM3DESbtMsc092sAzY
         dqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295736; x=1761900536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4kJQLU7HkQQtlqv3b3bm8HqvzrF9H7Chbd+Noruans=;
        b=mihc5wV0+vVJGg1VWPN9tlqSnk2donFeKh5SpZvEOAF9SQahRbuS82HRwYJscw2HDW
         bEsHN8A8Q+AXSRZWpLYunWmy+mXoMko2NbR0mPj87BgCWUZDNdBK7yd1+4v2RZDbNjri
         8kKFvAji2zRIFg4V9VmQxhmSQDmd16YCbrWWZvkI9lJQFxxa1OG4skP2DZoKQRKXiP/v
         TtcoJB1rP8k4ujsoQ1Tj6bJcUwS7OkdTwNreXKqX5M8GlN///bE/SFlogqqzKEQba0hC
         /IWWlkWLdXYtItg+5vpTqTA14De3jCGxdcNn8KqlG7nqEd7cXH1B+rX1R5ezcZyc9fcW
         hhNA==
X-Forwarded-Encrypted: i=1; AJvYcCVb2XKRporcgXtDNUaIdGYjiD2NJqLeogFmrywRW0TVPcLz2hVvzfbehKEJgIEifuGqmDk3sgkaxr6xD6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8SZNUQ5vy/Z9SO8R9LhiC4hHCyiMwUplOgFmrcNxznUuK1Jp
	vHK4FxAVncvzSfijSbRYzrDvTLdPAVMGAA43/czbDYV5BxGbdet9QlgW
X-Gm-Gg: ASbGncuyFVegAdmfDcac5vgbzA82kVIDSFt4iZpKTvm1+49Tpzg30976GYZIMcnhFfE
	IdRV53M8ocNMqK6FIh39H7EMAkNiZeQ5T9QLYRJQ/bd5rlpNFS9Dhqt5CH7XNfLs/iGOnDGMlTS
	oMtkIAi6XMJ4v7qftRKnxBwHhU79qubqjvPFWvcUxQ8qqFG+azK9UEda+4OYKYQFg2VJyht7JGE
	TCMDk8SxrjtWCcHMKxdBgpe0zFemWGGu+79S9s5/FWwjqBdez92tAUjmKhex2g+89mXP9hwJfg3
	NhTqFMvthCraDMQFcgsYmSRcbGQ6wQXZDLSQuClvB8d6Nn4m7OAXJImvZP8s3/jl2Jy08yR84Tc
	KWcyNRQY9ge1Ch4Xdg0L681a6NqTjd5/QryVvf9QXD+r1R15TGBkEGd4HAnE5g8NRhYHJTv0T/8
	oQbvduh8/4x82SiOzAYur6lB8a8pT2BEkGVhQRjA==
X-Google-Smtp-Source: AGHT+IESgU7Y4+mcfFfkHpukwGwbt1gtrw7F8TBkSlObe6I2/8SHRwyJCnz9Y0OqCyB02ZUjj1l7Gw==
X-Received: by 2002:a05:651c:1545:b0:378:d65a:9ceb with SMTP id 38308e7fff4ca-378d65aaa18mr14578941fa.24.1761295736186;
        Fri, 24 Oct 2025 01:48:56 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378e8b6d2dcsm769061fa.23.2025.10.24.01.48.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Oct 2025 01:48:55 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:48:51 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251024104851.4d3030b0.michal.pecio@gmail.com>
In-Reply-To: <20251023190901.GA840389@yaz-khff2.amd.com>
References: <20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
	<20251023202503.72987338.michal.pecio@gmail.com>
	<20251023190429.GB796848@yaz-khff2.amd.com>
	<20251023190901.GA840389@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 15:09:01 -0400, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 03:04:29PM -0400, Yazen Ghannam wrote:
> > On Thu, Oct 23, 2025 at 08:25:03PM +0200, Michal Pecio wrote:  
> > > On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:  
> > > > The kernel seems to think there are 6 CPUs on your system:
> > > > 
> > > > [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs  
> > > 
> > > I wonder if this code doesn't break systems which actually support
> > > hotplug, when some sockets aren't populated at boot?  
> > 
> > I don't know about other vendors, but we don't do physical CPU
> > hotplug. CPU hotplug, in this case, is there are physical CPUs
> > already in the system, but they are not enabled for whatever policy
> > decision. They could be disabled in BIOS, and so the MADT entries
> > will reflect that. Or they can be disabled by kernel parameters.

Thanks for the explanation. Looks like your patch is correct then
and we need to fix the topology somehow.

> Sorry for the rapid emails. Here's another interesting commit:
> f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")

I have this commit on 6.12 but it doesn't help.

As I understand, APIC ID is a bitfield of the form:

[package ID] ... [core ID] [thread ID]

In my case, per debugfs:

domain: Thread     shift: 0 dom_size:     1 max_threads:     1
domain: Core       shift: 2 dom_size:     4 max_threads:     4
domain: Module     shift: 2 dom_size:     1 max_threads:     4
domain: Tile       shift: 2 dom_size:     1 max_threads:     4
domain: Die        shift: 2 dom_size:     1 max_threads:     4
domain: DieGrp     shift: 2 dom_size:     1 max_threads:     4
domain: Package    shift: 2 dom_size:     1 max_threads:     4

So my phantom APICs simply look like another package with weird
non-sequential ID. (Probably not an ACPI spec violation yet?)

f0551af02130 only rejects disabled APICs in the same packages as
enabled ones. An earlier proposal in that thread was to reject all
disabled APICs on bare metal unless explicitly "online capable":

https://lore.kernel.org/all/87sf15ugsz.ffs@tglx/

This clearly goes against fed8d8773b8e and it seems to go against
what you wrote about AMD BIOSes potentially marking CPUs as disabled
in MADT and presumably allowing OS to wake them up with ACPI?

You asked elsewhere what happens if I online CPU5/6. I don't have
directories for them in /sys/, so not sure if I need any extra steps
to make them appear, or the kernel considers those CPUs bogus for
some reason and amd_nb could do the same?

Bitmaps from /sys/:
/sys/devices/system/cpu/enabled:0-3
/sys/devices/system/cpu/kernel_max:5
/sys/devices/system/cpu/offline:4-5
/sys/devices/system/cpu/online:0-3
/sys/devices/system/cpu/possible:0-5
/sys/devices/system/cpu/present:0-3

I tried 6.18-rc2 and it's same thing, except EDAC and GART don't work.
On both kernels, possible_cpus=4 fixes it:

[    0.072066] CPU topo: Limiting to 4 possible CPUs
[    0.072074] CPU topo: CPU limit of 4 reached. Ignoring further CPUs
[    0.072082] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.072084] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.072086] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.072089] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.072090] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.072097] CPU topo: Max. logical packages:   1
[    0.072097] CPU topo: Max. logical dies:       1
[    0.072098] CPU topo: Max. dies per package:   1
[    0.072103] CPU topo: Max. threads per core:   1
[    0.072105] CPU topo: Num. cores per package:     4
[    0.072105] CPU topo: Num. threads per package:   4
[    0.072106] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.072107] CPU topo: Rejected CPUs 2

