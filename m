Return-Path: <linux-kernel+bounces-744848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32FAB1118D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F314316F159
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786D2ED14C;
	Thu, 24 Jul 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQkd14hD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D692ECEBA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384959; cv=none; b=Li+RQkj08J47RaeB9E4U3Q/qk2tXlEr3s7qSwhlWJUszwarHxPyV7dIBR09CDPkTw4HacnWPkd8yqOmaQgmuh+FOzPF96V4/G5B2b/Ru0I2BMYT4Uj6dC9K7qkM6b9YPkyDhtrXo/jL4WdwiyYWQAJBKB3LejS4VL8ESzRJICX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384959; c=relaxed/simple;
	bh=GO4jBX/Exo+HkYVRxzvlQJLy8J731Emvu0i9MjroxEM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nJj74PgFEFFqjh8nR+efip+Rn6Duo98M23TPqeozgh7FAAuTGq29KdScD8MT0bjObeB7l+F/WqxQJoREoBn+x5lXBHX6JFRHzE77NKdJU1rbCWOpjcsYEsLz5DwfJsyyD44M309b/CMpH98PWjyeoRGC8iU+xKrGNmxk97BKY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQkd14hD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753384956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQCc6O4K6GwjSu8rbWpy3ujYxxGOrJAsJR6mBrOZ4/M=;
	b=EQkd14hDfRJkrAVL3I/OtL4NevldehlTvnlvUpSl1EndW/i37JG4XX0ury47RaG1xEDhu1
	NqTF6oRmY1iAPzYwvfPsuPZyzR+1MVjirU0xVnR6UVr9xyiaMLdDGTb2CD9jHc+atP9Vlg
	kr3zXGtHYuztxyrJzxAbalB7ne/cJIc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-yV9VPrYEN5ufTyKxoiSNuA-1; Thu, 24 Jul 2025 15:22:35 -0400
X-MC-Unique: yV9VPrYEN5ufTyKxoiSNuA-1
X-Mimecast-MFC-AGG-ID: yV9VPrYEN5ufTyKxoiSNuA_1753384954
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e348600cadso241165785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384954; x=1753989754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQCc6O4K6GwjSu8rbWpy3ujYxxGOrJAsJR6mBrOZ4/M=;
        b=AdjfgkQl1nIXyGj4NQl3WMvFDB0RPppUZOY4lSMrx/yNnqFfe1j11A4OdiOytY8XkL
         QFTo+t2AghY/8pblF34X80DgVlX5ZDk+UdyGXDqTTkwKdDl7t5cyXJ5R+m2+p8G80cnR
         +/SjU5+xWbTkBnptlrlmduh0MpFF1b87M3X4vLRkbIScLCwZV+vKdGLQHdzfOpDmJosD
         bUCaBVFwyLe5FLLw2eBHTn56AtZ7rI8xfRnekhRzWFtnf2s8hlTwSszxQDJVYNAmGoJ+
         zDMJ6k7i8FWIop/H+xt+BcwGt7gSP35IP/lAvwZrVcAAlrQiBnkNZ+nArzeqBZ82JtJu
         JjBg==
X-Forwarded-Encrypted: i=1; AJvYcCXi+3zKDQHsTLz/cQFmkkjTeh5VLB8F2sDj6Kl9hmKSzB5NaxAfBW5hdwa/iMkD42WeugrDD+BaMr4GkOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbH6VX4NCMosuLgC0Wj+bQEN7Ihbf2AwHe5vxavhX6QKZ19hg
	Qj/xW6jCIjGl+0UN4pnUB/zjNqYJdYpB6znp2eZisw2HV3j9cm5JNWOTbe7ETuq3FJdmUSBs1zG
	jjLPkE8ZBzWIl7A9gXmCoG8/T1JDYNMrZCaVF0BK/ROsa9Yd+5xzos2C15iw01IM1ig==
X-Gm-Gg: ASbGncvtLwpzM2RyU0fkqXRHnUD7LV43n+APPk2JwCjEHDk2Du1FucFCSfuEOzEO+Oe
	SIebgPeDVj2WpIKbuALmmF+uu4jbFsGyTlLbGx+3r0JgeSrtYxem+E6a+HUsTG6mhWJJErXAj/N
	Io7XmbaW4WjMF2Po4pNxU4JbBAlTi0LEkQCulqq4bvTdF37C1UgZ4hOk+HzH/ENknjelvUgKory
	uG3+iK/X6DNkX3wqUeMN4//MSZr3lOMij8jWQyL1HlU4Xi5+UrrMe8BuU0X2G9lPBo6dB7K5MM7
	Xby5Y/dKqP5YB2q+UlM0kZPOp4QmAYYh2+nIsR2svgb1a08u59gIUUg4Wc1RgAs8zIR29WUgfZM
	pKR09wppFsw==
X-Received: by 2002:a05:620a:700c:b0:7e6:30ad:be32 with SMTP id af79cd13be357-7e630adbe78mr745025485a.5.1753384954247;
        Thu, 24 Jul 2025 12:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLW3hVWOk32fW509KpmBvaPpSmUmclsUeHIxsYZigB2jahzoGPo23FYwY5Ls+AdV5BsRol8Q==
X-Received: by 2002:a05:620a:700c:b0:7e6:30ad:be32 with SMTP id af79cd13be357-7e630adbe78mr745020185a.5.1753384953648;
        Thu, 24 Jul 2025 12:22:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632d61a38sm156361585a.26.2025.07.24.12.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 12:22:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6c5e70a8-2db2-4fa6-8a42-35033e480293@redhat.com>
Date: Thu, 24 Jul 2025 15:22:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: Pavel Machek <pavel@ucw.cz>, Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <aIKEfIjYBPzlE7y7@duo.ucw.cz>
Content-Language: en-US
In-Reply-To: <aIKEfIjYBPzlE7y7@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 3:07 PM, Pavel Machek wrote:
> Hi!
>
>>>>> Can you please decode this, so we can see which part of that code it is?
>>>> And enable lockdep so that we can see where the interrupts were enabled?
>>> Enabled lockdep and got this one. It seems resume with bad wifi signal
>>> does it on 6.16...?
>>>
>>> Is it any good? Any decoding needed?
>>>
>>> ...
>>> [   32.361445] CPU2 is up
>>> [   32.361729] smpboot: Booting Node 0 Processor 3 APIC 0x3
>>> [   32.361982] Disabled fast string operations
>>> [   32.366800] CPU3 is up
>>> [   32.370186] ACPI: PM: Waking up from system sleep state S3
>>> [   32.393904] ACPI: EC: interrupt unblocked
>>> [   32.396000] sdhci-pci 0000:0d:00.0: MMC controller base frequency changed to 50Mhz.
>>> [   32.409738] ACPI: EC: event unblocked
>>> [   32.470808] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
>>> [   32.687300] usb 2-1.4: reset full-speed USB device number 4 using ehci-pci
>>> [   32.758329] ata2: SATA link down (SStatus 0 SControl 300)
>>> [   32.758375] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [   32.762316] ata5: SATA link down (SStatus 0 SControl 300)
>>> [   32.764585] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   32.764593] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   32.771931] sd 2:0:0:0: [sdb] Starting disk
>>> [   32.777439] ata3.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   32.777450] ata3.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   32.782731] ata3.00: configured for UDMA/133
>>> [   32.786846] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
>>> [   32.858513] usb 2-1.3: reset full-speed USB device number 3 using ehci-pci
>>> [   33.026331] usb 2-1.6: reset high-speed USB device number 5 using ehci-pci
>>> [   33.662583] psmouse serio1: synaptics: queried max coordinates: x [..5472], y [..4448]
>>> [   33.810033] PM: resume devices took 1.404 seconds
>>> [   33.841597] OOM killer enabled.
>>> [   33.841808] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: docking
>>> [   33.843280] Restarting tasks: Starting
>>> [   33.849066] ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to dock!
>>> [   33.852744] Restarting tasks: Done
>>> [   33.888306] PM: suspend exit
>>> [   33.941831] Bluetooth: hci0: BCM: chip id 63
>>> [   33.944910] Bluetooth: hci0: BCM: features 0x07
>>> [   33.961985] Bluetooth: hci0: BCM20702A
>>> [   33.962628] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
>>> [   33.970094] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
>>> [   33.970993] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e6.hcd'
>>> [   33.971410] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
>>> [   34.032198] Bluetooth: MGMT ver 1.23
>>> [   34.838285] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>> [   35.166235] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   35.167828] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   35.206578] sd 0:0:0:0: [sda] Starting disk
>>> [   35.238578] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
>>> [   35.240197] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
>>> [   35.278928] ata1.00: configured for UDMA/133
>>> [   35.613471] e1000e 0000:00:19.0 enp0s25: NIC Link is Down
>>> [   54.283825] wlp3s0: authenticate with c8:3a:35:f0:ad:f1 (local address=a0:88:b4:62:a7:30)
>>>
>>> [   54.284095] ================================
>>> [   54.284097] WARNING: inconsistent lock state
>>> [   54.284100] 6.16.0-rc7+ #305 Tainted: G S
>>> [   54.284104] --------------------------------
>>> [   54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>>> [   54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] takes:
>>> [   54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: console_lock_spinning_enable+0x3d/0x60
>> The lockdep warning just means that console_owner_lock is acquired both in
>> softirq context and in task context with interrupt enabled. That can leads
>> to deadlock. So the remedy is to always take console_owner_lock with
>> interrupt disabled, i.e. with
>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
> So you suspect problem is in the printk code?

This lockdep problem is likely unrelated to the IRQ flag problem 
reported in the original email as it shouldn't affect the IRQ flag.

Cheers,
Longman


