Return-Path: <linux-kernel+bounces-832778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C701BA0606
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C004E7617
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575812E36F6;
	Thu, 25 Sep 2025 15:27:38 +0000 (UTC)
Received: from aero2k.de (aero2k.de [49.12.35.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90D18FC86
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814057; cv=none; b=a24CrN+AH16gosoxd7k07e6qQFoF2atqkkqVEA38UU98C6kFmiKPNKL7cE++IYgqBbF/7/pphyfLPRe1EXjR7SnKPin/UZ/Xxr35NpGG2/poWYb8HHDg4yCOtwRE/U29fMdd/qWkvMg2bL246Uf2i1hlST9DWjZiaoGMN5T3eqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814057; c=relaxed/simple;
	bh=4NBqgQ1bhYEcly6wjQJ/lAU3raOD1x4xegYBVPk7pQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWAVdikWhchJ9eM9wkeO+VSw8TCX5rbdTMKglzZI8WetzyJC9CzEUa5w2YYWEuwRjrxEYckKmV5yYu285oUGNFezTCmY9jJZw8QOs5pO9q/DpQDOMIQMade+TNw00W7vZ0asQnRYYeoERvw0svDHh78dtxvDQjera/XOtGSrUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aero2k.de; spf=pass smtp.mailfrom=aero2k.de; arc=none smtp.client-ip=49.12.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aero2k.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aero2k.de
Received: from [IPV6:2a02:8071:73d0:11f0:9c03:26ff:fe9c:2a6a] (unknown [IPv6:2a02:8071:73d0:11f0:9c03:26ff:fe9c:2a6a])
	by aero2k.de (Postfix) with ESMTPSA id 6587422435;
	Thu, 25 Sep 2025 17:27:21 +0200 (CEST)
Message-ID: <4a55b5c7-093b-4246-88ed-5d83da1973ed@aero2k.de>
Date: Thu, 25 Sep 2025 17:27:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: 1111027@bugs.debian.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
References: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>
 <2pdp3kq4qebdxizprbnaq6omh4dvxdlktokvr37b7nlkf4po3b@fxzmgmi47wxx>
 <60c824f2-667f-4957-bfe1-145a79e01ac5@aero2k.de> <87bjn14g04.ffs@tglx>
 <aac1a607-946e-48c0-a1cf-acc9cff4749e@aero2k.de> <875xd74i3a.ffs@tglx>
From: Thorsten Sperber <lists+debian@aero2k.de>
In-Reply-To: <875xd74i3a.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/25 00:10, Thomas Gleixner wrote:
>> # cat /proc/cmdline
>> BOOT_IMAGE=/vmlinuz-6.1.0-40-amd64 root=/dev/mapper/thecube--vg-root ro quiet intel_iommu=off intel_idle.max_cstate=2
>>
>> # cat /sys/devices/system/cpu/cpuidle/current_driver
>> intel_idle
>>
>> # ls -l /sys/devices/system/cpu/cpu0/cpuidle/
>> insgesamt 0
>> drwxr-xr-x 2 root root 0 24. Sep 19:14 state0
>> drwxr-xr-x 3 root root 0 24. Sep 19:14 state1
>> drwxr-xr-x 3 root root 0 24. Sep 19:14 state2
>>
>> # cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
>> POLL
>> C1
>> C1E
> What's the output for the above on 6.12?
>
All the same (apart from the cmdline of course). Btw, error appeared in the morning (without intel_iommu=off), still without halting/crashing the system. Bugs me a little that I can't exactly reproduce the "crash to coldstart" situation again. Just in case someone sees something new:

# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.12.43+deb13-amd64 root=/dev/mapper/thecube--vg-root ro quiet intel_idle.max_cstate=2


[Do Sep 25 07:15:50 2025] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[Do Sep 25 07:15:50 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Do Sep 25 07:15:50 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Do Sep 25 07:15:50 2025] RIP: 0010:intel_idle+0x55/0x90
[Do Sep 25 07:15:50 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Do Sep 25 07:15:50 2025] RSP: 0018:ffffffff97203e38 EFLAGS: 00000046
[Do Sep 25 07:15:50 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Do Sep 25 07:15:50 2025] RDX: 0000000000000000 RSI: ffffffff97210940 RDI: 0000000000000002
[Do Sep 25 07:15:50 2025] RBP: ffff9a5b416400c0 R08: 0000000000000001 R09: 000000000001e83e
[Do Sep 25 07:15:50 2025] R10: ffff9a5b416347a4 R11: 071c71c71c71c71c R12: ffffffff973b70c0
[Do Sep 25 07:15:50 2025] R13: ffffffff973b71a8 R14: 0000000000000002 R15: 0000000000000000
[Do Sep 25 07:15:50 2025] FS:  0000000000000000(0000) GS:ffff9a5b41600000(0000) knlGS:0000000000000000
[Do Sep 25 07:15:50 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Do Sep 25 07:15:50 2025] CR2: 00007ffe16efe098 CR3: 0000000103a60005 CR4: 00000000001726f0
[Do Sep 25 07:15:50 2025] Call Trace:
[Do Sep 25 07:15:50 2025]  <TASK>
[Do Sep 25 07:15:50 2025]  cpuidle_enter_state+0x81/0x420
[Do Sep 25 07:15:50 2025]  cpuidle_enter+0x2d/0x40
[Do Sep 25 07:15:50 2025]  do_idle+0x1e5/0x240
[Do Sep 25 07:15:50 2025]  cpu_startup_entry+0x29/0x30
[Do Sep 25 07:15:50 2025]  rest_init+0xcc/0xd0
[Do Sep 25 07:15:50 2025]  start_kernel+0x74c/0x750
[Do Sep 25 07:15:50 2025]  x86_64_start_reservations+0x24/0x30
[Do Sep 25 07:15:50 2025]  x86_64_start_kernel+0x95/0xa0
[Do Sep 25 07:15:50 2025]  common_startup_64+0x13e/0x141
[Do Sep 25 07:15:50 2025]  </TASK>
[Do Sep 25 07:15:52 2025] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[Do Sep 25 07:15:52 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Do Sep 25 07:15:52 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Do Sep 25 07:15:52 2025] RIP: 0010:intel_idle+0x55/0x90
[Do Sep 25 07:15:52 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Do Sep 25 07:15:52 2025] RSP: 0018:ffffffff97203e38 EFLAGS: 00000046
[Do Sep 25 07:15:52 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Do Sep 25 07:15:52 2025] RDX: 0000000000000000 RSI: ffffffff97210940 RDI: 0000000000000002
[Do Sep 25 07:15:52 2025] RBP: ffff9a5b416400c0 R08: 0000000000000001 R09: 000000000001e83e
[Do Sep 25 07:15:52 2025] R10: ffff9a5b416347a4 R11: 071c71c71c71c71c R12: ffffffff973b70c0
[Do Sep 25 07:15:52 2025] R13: ffffffff973b71a8 R14: 0000000000000002 R15: 0000000000000000
[Do Sep 25 07:15:52 2025] FS:  0000000000000000(0000) GS:ffff9a5b41600000(0000) knlGS:0000000000000000
[Do Sep 25 07:15:52 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Do Sep 25 07:15:52 2025] CR2: 00007ffe16efe098 CR3: 0000000103a60005 CR4: 00000000001726f0
[Do Sep 25 07:15:52 2025] Call Trace:
[Do Sep 25 07:15:52 2025]  <TASK>
[Do Sep 25 07:15:52 2025]  cpuidle_enter_state+0x81/0x420
[Do Sep 25 07:15:52 2025]  cpuidle_enter+0x2d/0x40
[Do Sep 25 07:15:52 2025]  do_idle+0x1e5/0x240
[Do Sep 25 07:15:52 2025]  cpu_startup_entry+0x29/0x30
[Do Sep 25 07:15:52 2025]  rest_init+0xcc/0xd0
[Do Sep 25 07:15:52 2025]  start_kernel+0x74c/0x750
[Do Sep 25 07:15:52 2025]  x86_64_start_reservations+0x24/0x30
[Do Sep 25 07:15:52 2025]  x86_64_start_kernel+0x95/0xa0
[Do Sep 25 07:15:52 2025]  common_startup_64+0x13e/0x141
[Do Sep 25 07:15:52 2025]  </TASK>
[Do Sep 25 07:15:54 2025] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[Do Sep 25 07:15:54 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Do Sep 25 07:15:54 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Do Sep 25 07:15:54 2025] RIP: 0010:intel_idle+0x55/0x90
[Do Sep 25 07:15:54 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Do Sep 25 07:15:54 2025] RSP: 0018:ffffffff97203e38 EFLAGS: 00000046
[Do Sep 25 07:15:54 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Do Sep 25 07:15:54 2025] RDX: 0000000000000000 RSI: ffffffff97210940 RDI: 0000000000000002
[Do Sep 25 07:15:54 2025] RBP: ffff9a5b416400c0 R08: 0000000000000001 R09: 000000000001e83e
[Do Sep 25 07:15:54 2025] R10: ffff9a5b416347a4 R11: 071c71c71c71c71c R12: ffffffff973b70c0
[Do Sep 25 07:15:54 2025] R13: ffffffff973b71a8 R14: 0000000000000002 R15: 0000000000000000
[Do Sep 25 07:15:54 2025] FS:  0000000000000000(0000) GS:ffff9a5b41600000(0000) knlGS:0000000000000000
[Do Sep 25 07:15:54 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Do Sep 25 07:15:54 2025] CR2: 00007ffe16efe098 CR3: 0000000103a60005 CR4: 00000000001726f0
[Do Sep 25 07:15:54 2025] Call Trace:
[Do Sep 25 07:15:54 2025]  <TASK>
[Do Sep 25 07:15:54 2025]  cpuidle_enter_state+0x81/0x420
[Do Sep 25 07:15:54 2025]  cpuidle_enter+0x2d/0x40
[Do Sep 25 07:15:54 2025]  do_idle+0x1e5/0x240
[Do Sep 25 07:15:54 2025]  cpu_startup_entry+0x29/0x30
[Do Sep 25 07:15:54 2025]  rest_init+0xcc/0xd0
[Do Sep 25 07:15:54 2025]  start_kernel+0x74c/0x750
[Do Sep 25 07:15:54 2025]  x86_64_start_reservations+0x24/0x30
[Do Sep 25 07:15:54 2025]  x86_64_start_kernel+0x95/0xa0
[Do Sep 25 07:15:54 2025]  common_startup_64+0x13e/0x141
[Do Sep 25 07:15:54 2025]  </TASK>
[Do Sep 25 07:15:56 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[Do Sep 25 07:15:56 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Do Sep 25 07:15:56 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Do Sep 25 07:15:56 2025] RIP: 0010:intel_idle+0x55/0x90
[Do Sep 25 07:15:56 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Do Sep 25 07:15:56 2025] RSP: 0018:ffffffff97203e38 EFLAGS: 00000046
[Do Sep 25 07:15:56 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Do Sep 25 07:15:56 2025] RDX: 0000000000000000 RSI: ffffffff97210940 RDI: 0000000000000002
[Do Sep 25 07:15:56 2025] RBP: ffff9a5b416400c0 R08: 0000000000000001 R09: 000000000001e83e
[Do Sep 25 07:15:56 2025] R10: ffff9a5b416347a4 R11: 071c71c71c71c71c R12: ffffffff973b70c0
[Do Sep 25 07:15:56 2025] R13: ffffffff973b71a8 R14: 0000000000000002 R15: 0000000000000000
[Do Sep 25 07:15:56 2025] FS:  0000000000000000(0000) GS:ffff9a5b41600000(0000) knlGS:0000000000000000
[Do Sep 25 07:15:56 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Do Sep 25 07:15:56 2025] CR2: 00007ffe16efe098 CR3: 0000000103a60005 CR4: 00000000001726f0
[Do Sep 25 07:15:56 2025] Call Trace:
[Do Sep 25 07:15:56 2025]  <TASK>
[Do Sep 25 07:15:56 2025]  cpuidle_enter_state+0x81/0x420
[Do Sep 25 07:15:56 2025]  cpuidle_enter+0x2d/0x40
[Do Sep 25 07:15:56 2025]  do_idle+0x1e5/0x240
[Do Sep 25 07:15:56 2025]  cpu_startup_entry+0x29/0x30
[Do Sep 25 07:15:56 2025]  rest_init+0xcc/0xd0
[Do Sep 25 07:15:56 2025]  start_kernel+0x74c/0x750
[Do Sep 25 07:15:56 2025]  x86_64_start_reservations+0x24/0x30
[Do Sep 25 07:15:56 2025]  x86_64_start_kernel+0x95/0xa0
[Do Sep 25 07:15:56 2025]  common_startup_64+0x13e/0x141
[Do Sep 25 07:15:56 2025]  </TASK>
[Do Sep 25 07:15:58 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[Do Sep 25 07:15:58 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Do Sep 25 07:15:58 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Do Sep 25 07:15:58 2025] RIP: 0010:intel_idle+0x55/0x90
[Do Sep 25 07:15:58 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Do Sep 25 07:15:58 2025] RSP: 0018:ffffffff97203e38 EFLAGS: 00000046
[Do Sep 25 07:15:58 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Do Sep 25 07:15:58 2025] RDX: 0000000000000000 RSI: ffffffff97210940 RDI: 0000000000000002
[Do Sep 25 07:15:58 2025] RBP: ffff9a5b416400c0 R08: 0000000000000001 R09: 000000000001e83e
[Do Sep 25 07:15:58 2025] R10: ffff9a5b416347a4 R11: 071c71c71c71c71c R12: ffffffff973b70c0
[Do Sep 25 07:15:58 2025] R13: ffffffff973b71a8 R14: 0000000000000002 R15: 0000000000000000
[Do Sep 25 07:15:58 2025] FS:  0000000000000000(0000) GS:ffff9a5b41600000(0000) knlGS:0000000000000000
[Do Sep 25 07:15:58 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Do Sep 25 07:15:58 2025] CR2: 00007ffe16efe098 CR3: 0000000103a60005 CR4: 00000000001726f0
[Do Sep 25 07:15:58 2025] Call Trace:
[Do Sep 25 07:15:58 2025]  <TASK>
[Do Sep 25 07:15:58 2025]  cpuidle_enter_state+0x81/0x420
[Do Sep 25 07:15:58 2025]  cpuidle_enter+0x2d/0x40
[Do Sep 25 07:15:58 2025]  do_idle+0x1e5/0x240
[Do Sep 25 07:15:58 2025]  cpu_startup_entry+0x29/0x30
[Do Sep 25 07:15:58 2025]  rest_init+0xcc/0xd0
[Do Sep 25 07:15:58 2025]  start_kernel+0x74c/0x750
[Do Sep 25 07:15:58 2025]  x86_64_start_reservations+0x24/0x30
[Do Sep 25 07:15:58 2025]  x86_64_start_kernel+0x95/0xa0
[Do Sep 25 07:15:58 2025]  common_startup_64+0x13e/0x141
[Do Sep 25 07:15:58 2025]  </TASK>
[Do Sep 25 07:16:00 2025] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 7623994708 wd_nsec: 7623993107

Guess I'll remove all customization next.

Best regards,

Thorsten


