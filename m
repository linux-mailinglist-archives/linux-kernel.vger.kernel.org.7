Return-Path: <linux-kernel+bounces-830972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119C0B9B092
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E83919C06E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BC313E06;
	Wed, 24 Sep 2025 17:20:51 +0000 (UTC)
Received: from aero2k.de (aero2k.de [49.12.35.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964002D9EDC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734450; cv=none; b=Pi3/4j77hlwWtpCEeeSIkwiqFRZg4uDkbKXhs1zLf120M2vDVIIQLlNxG+dCYXB/tS2pst5Zw940u2qupT9C9oVJOGPfvzmDh6VYwTKK+tA841V3LgA8HW98xv15HCG4U7yAl3vgnSMVd5aQRguQ2i9dm7yekWuKB/oLNJm74Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734450; c=relaxed/simple;
	bh=QYkHWOvZbZI5bfc1Ck6LlSyb6GLeGIgcuxrZwv/a4SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUzscGOE9JePynDMmyinH1NCI+i9S46KaAnRB6CWziiSA0P8Q9o2nfDySoAgWEP73qWx8Hjk17/DQbx4OqDBnk/vINXYfzAbZ4t2fqGdcKonVu60+c35jZo+oJo94oG8XV8tZtifZSmHiXKZ4coOsAUf2HeP60ZJWTnhbjOFvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aero2k.de; spf=pass smtp.mailfrom=aero2k.de; arc=none smtp.client-ip=49.12.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aero2k.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aero2k.de
Received: from [IPV6:2a02:8071:73d0:11f0:9c03:26ff:fe9c:2a6a] (unknown [IPv6:2a02:8071:73d0:11f0:9c03:26ff:fe9c:2a6a])
	by aero2k.de (Postfix) with ESMTPSA id 0C8F52242E;
	Wed, 24 Sep 2025 19:20:38 +0200 (CEST)
Message-ID: <aac1a607-946e-48c0-a1cf-acc9cff4749e@aero2k.de>
Date: Wed, 24 Sep 2025 19:20:34 +0200
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
From: Thorsten Sperber <lists+debian@aero2k.de>
In-Reply-To: <87bjn14g04.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

another stacktrace today (now 19:00:36 up 5 days, 23:04,  2 users,  load average: 0,00, 0,00, 0,00):


[Mi Sep 24 14:10:19 2025] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[Mi Sep 24 14:10:19 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Mi Sep 24 14:10:19 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Mi Sep 24 14:10:19 2025] RIP: 0010:intel_idle+0x55/0x90
[Mi Sep 24 14:10:19 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Mi Sep 24 14:10:19 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
[Mi Sep 24 14:10:19 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Mi Sep 24 14:10:19 2025] RDX: 0000000000000000 RSI: ffffffff9d210940 RDI: 0000000000000002
[Mi Sep 24 14:10:19 2025] RBP: ffff93c7016400c0 R08: 0000000000000001 R09: 000000000001e83e
[Mi Sep 24 14:10:19 2025] R10: ffff93c7016347a4 R11: 071c71c71c71c71c R12: ffffffff9d3b70c0
[Mi Sep 24 14:10:19 2025] R13: ffffffff9d3b71a8 R14: 0000000000000002 R15: 0000000000000000
[Mi Sep 24 14:10:19 2025] FS:  0000000000000000(0000) GS:ffff93c701600000(0000) knlGS:0000000000000000
[Mi Sep 24 14:10:19 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mi Sep 24 14:10:19 2025] CR2: 00007fff42aa7f48 CR3: 0000000108fe6003 CR4: 00000000001726f0
[Mi Sep 24 14:10:19 2025] Call Trace:
[Mi Sep 24 14:10:19 2025]  <TASK>
[Mi Sep 24 14:10:19 2025]  cpuidle_enter_state+0x81/0x420
[Mi Sep 24 14:10:19 2025]  cpuidle_enter+0x2d/0x40
[Mi Sep 24 14:10:19 2025]  do_idle+0x1e5/0x240
[Mi Sep 24 14:10:19 2025]  cpu_startup_entry+0x29/0x30
[Mi Sep 24 14:10:19 2025]  rest_init+0xcc/0xd0
[Mi Sep 24 14:10:19 2025]  start_kernel+0x74c/0x750
[Mi Sep 24 14:10:19 2025]  x86_64_start_reservations+0x24/0x30
[Mi Sep 24 14:10:19 2025]  x86_64_start_kernel+0x95/0xa0
[Mi Sep 24 14:10:19 2025]  common_startup_64+0x13e/0x141
[Mi Sep 24 14:10:19 2025]  </TASK>
[Mi Sep 24 14:10:21 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[Mi Sep 24 14:10:21 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Mi Sep 24 14:10:21 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Mi Sep 24 14:10:21 2025] RIP: 0010:intel_idle+0x55/0x90
[Mi Sep 24 14:10:21 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Mi Sep 24 14:10:21 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
[Mi Sep 24 14:10:21 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Mi Sep 24 14:10:21 2025] RDX: 0000000000000000 RSI: ffffffff9d210940 RDI: 0000000000000002
[Mi Sep 24 14:10:21 2025] RBP: ffff93c7016400c0 R08: 0000000000000001 R09: 000000000001e83e
[Mi Sep 24 14:10:21 2025] R10: ffff93c7016347a4 R11: 071c71c71c71c71c R12: ffffffff9d3b70c0
[Mi Sep 24 14:10:21 2025] R13: ffffffff9d3b71a8 R14: 0000000000000002 R15: 0000000000000000
[Mi Sep 24 14:10:21 2025] FS:  0000000000000000(0000) GS:ffff93c701600000(0000) knlGS:0000000000000000
[Mi Sep 24 14:10:21 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mi Sep 24 14:10:21 2025] CR2: 00007fff42aa7f48 CR3: 0000000108fe6003 CR4: 00000000001726f0
[Mi Sep 24 14:10:21 2025] Call Trace:
[Mi Sep 24 14:10:21 2025]  <TASK>
[Mi Sep 24 14:10:21 2025]  cpuidle_enter_state+0x81/0x420
[Mi Sep 24 14:10:21 2025]  cpuidle_enter+0x2d/0x40
[Mi Sep 24 14:10:21 2025]  do_idle+0x1e5/0x240
[Mi Sep 24 14:10:21 2025]  cpu_startup_entry+0x29/0x30
[Mi Sep 24 14:10:21 2025]  rest_init+0xcc/0xd0
[Mi Sep 24 14:10:21 2025]  start_kernel+0x74c/0x750
[Mi Sep 24 14:10:21 2025]  x86_64_start_reservations+0x24/0x30
[Mi Sep 24 14:10:21 2025]  x86_64_start_kernel+0x95/0xa0
[Mi Sep 24 14:10:21 2025]  common_startup_64+0x13e/0x141
[Mi Sep 24 14:10:21 2025]  </TASK>
[Mi Sep 24 14:10:23 2025] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[Mi Sep 24 14:10:23 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Mi Sep 24 14:10:23 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Mi Sep 24 14:10:23 2025] RIP: 0010:intel_idle+0x55/0x90
[Mi Sep 24 14:10:23 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Mi Sep 24 14:10:23 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
[Mi Sep 24 14:10:23 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Mi Sep 24 14:10:23 2025] RDX: 0000000000000000 RSI: ffffffff9d210940 RDI: 0000000000000002
[Mi Sep 24 14:10:23 2025] RBP: ffff93c7016400c0 R08: 0000000000000001 R09: 000000000001e83e
[Mi Sep 24 14:10:23 2025] R10: ffff93c7016347a4 R11: 071c71c71c71c71c R12: ffffffff9d3b70c0
[Mi Sep 24 14:10:23 2025] R13: ffffffff9d3b71a8 R14: 0000000000000002 R15: 0000000000000000
[Mi Sep 24 14:10:23 2025] FS:  0000000000000000(0000) GS:ffff93c701600000(0000) knlGS:0000000000000000
[Mi Sep 24 14:10:23 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mi Sep 24 14:10:23 2025] CR2: 00007fff42aa7f48 CR3: 0000000108fe6003 CR4: 00000000001726f0
[Mi Sep 24 14:10:23 2025] Call Trace:
[Mi Sep 24 14:10:23 2025]  <TASK>
[Mi Sep 24 14:10:23 2025]  cpuidle_enter_state+0x81/0x420
[Mi Sep 24 14:10:23 2025]  cpuidle_enter+0x2d/0x40
[Mi Sep 24 14:10:23 2025]  do_idle+0x1e5/0x240
[Mi Sep 24 14:10:23 2025]  cpu_startup_entry+0x29/0x30
[Mi Sep 24 14:10:23 2025]  rest_init+0xcc/0xd0
[Mi Sep 24 14:10:23 2025]  start_kernel+0x74c/0x750
[Mi Sep 24 14:10:23 2025]  x86_64_start_reservations+0x24/0x30
[Mi Sep 24 14:10:23 2025]  x86_64_start_kernel+0x95/0xa0
[Mi Sep 24 14:10:23 2025]  common_startup_64+0x13e/0x141
[Mi Sep 24 14:10:23 2025]  </TASK>
[Mi Sep 24 14:10:25 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[Mi Sep 24 14:10:25 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Mi Sep 24 14:10:25 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Mi Sep 24 14:10:25 2025] RIP: 0010:intel_idle+0x55/0x90
[Mi Sep 24 14:10:25 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Mi Sep 24 14:10:25 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
[Mi Sep 24 14:10:25 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Mi Sep 24 14:10:25 2025] RDX: 0000000000000000 RSI: ffffffff9d210940 RDI: 0000000000000002
[Mi Sep 24 14:10:25 2025] RBP: ffff93c7016400c0 R08: 0000000000000001 R09: 000000000001e83e
[Mi Sep 24 14:10:25 2025] R10: ffff93c7016347a4 R11: 071c71c71c71c71c R12: ffffffff9d3b70c0
[Mi Sep 24 14:10:25 2025] R13: ffffffff9d3b71a8 R14: 0000000000000002 R15: 0000000000000000
[Mi Sep 24 14:10:25 2025] FS:  0000000000000000(0000) GS:ffff93c701600000(0000) knlGS:0000000000000000
[Mi Sep 24 14:10:25 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mi Sep 24 14:10:25 2025] CR2: 00007fff42aa7f48 CR3: 0000000108fe6003 CR4: 00000000001726f0
[Mi Sep 24 14:10:25 2025] Call Trace:
[Mi Sep 24 14:10:25 2025]  <TASK>
[Mi Sep 24 14:10:25 2025]  cpuidle_enter_state+0x81/0x420
[Mi Sep 24 14:10:25 2025]  cpuidle_enter+0x2d/0x40
[Mi Sep 24 14:10:25 2025]  do_idle+0x1e5/0x240
[Mi Sep 24 14:10:25 2025]  cpu_startup_entry+0x29/0x30
[Mi Sep 24 14:10:25 2025]  rest_init+0xcc/0xd0
[Mi Sep 24 14:10:25 2025]  start_kernel+0x74c/0x750
[Mi Sep 24 14:10:25 2025]  x86_64_start_reservations+0x24/0x30
[Mi Sep 24 14:10:25 2025]  x86_64_start_kernel+0x95/0xa0
[Mi Sep 24 14:10:25 2025]  common_startup_64+0x13e/0x141
[Mi Sep 24 14:10:25 2025]  </TASK>
[Mi Sep 24 14:10:27 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[Mi Sep 24 14:10:27 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Mi Sep 24 14:10:27 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Mi Sep 24 14:10:27 2025] RIP: 0010:intel_idle+0x55/0x90
[Mi Sep 24 14:10:27 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Mi Sep 24 14:10:27 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
[Mi Sep 24 14:10:27 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Mi Sep 24 14:10:27 2025] RDX: 0000000000000000 RSI: ffffffff9d210940 RDI: 0000000000000002
[Mi Sep 24 14:10:27 2025] RBP: ffff93c7016400c0 R08: 0000000000000001 R09: 000000000001e83e
[Mi Sep 24 14:10:27 2025] R10: ffff93c7016347a4 R11: 071c71c71c71c71c R12: ffffffff9d3b70c0
[Mi Sep 24 14:10:27 2025] R13: ffffffff9d3b71a8 R14: 0000000000000002 R15: 0000000000000000
[Mi Sep 24 14:10:27 2025] FS:  0000000000000000(0000) GS:ffff93c701600000(0000) knlGS:0000000000000000
[Mi Sep 24 14:10:27 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mi Sep 24 14:10:27 2025] CR2: 00007fff42aa7f48 CR3: 0000000108fe6003 CR4: 00000000001726f0
[Mi Sep 24 14:10:27 2025] Call Trace:
[Mi Sep 24 14:10:27 2025]  <TASK>
[Mi Sep 24 14:10:27 2025]  cpuidle_enter_state+0x81/0x420
[Mi Sep 24 14:10:27 2025]  cpuidle_enter+0x2d/0x40
[Mi Sep 24 14:10:27 2025]  do_idle+0x1e5/0x240
[Mi Sep 24 14:10:27 2025]  cpu_startup_entry+0x29/0x30
[Mi Sep 24 14:10:27 2025]  rest_init+0xcc/0xd0
[Mi Sep 24 14:10:27 2025]  start_kernel+0x74c/0x750
[Mi Sep 24 14:10:27 2025]  x86_64_start_reservations+0x24/0x30
[Mi Sep 24 14:10:27 2025]  x86_64_start_kernel+0x95/0xa0
[Mi Sep 24 14:10:27 2025]  common_startup_64+0x13e/0x141
[Mi Sep 24 14:10:27 2025]  </TASK>
[Mi Sep 24 14:10:29 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[Mi Sep 24 14:10:29 2025] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.43+deb13-amd64 #1  Debian 6.12.43-1
[Mi Sep 24 14:10:29 2025] Hardware name: HP ProLiant MicroServer Gen8, BIOS J06 04/04/2019
[Mi Sep 24 14:10:29 2025] RIP: 0010:intel_idle+0x55/0x90
[Mi Sep 24 14:10:29 2025] Code: 2d 5c 8c 40 00 eb 47 cc cc cc 48 89 f0 0f 1f 00 31 c9 48 89 ca 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 a6
[Mi Sep 24 14:10:29 2025] RSP: 0018:ffffffff9d203e38 EFLAGS: 00000046
[Mi Sep 24 14:10:29 2025] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[Mi Sep 24 14:10:29 2025] RDX: 0000000000000000 RSI: ffffffff9d210940 RDI: 0000000000000002
[Mi Sep 24 14:10:29 2025] RBP: ffff93c7016400c0 R08: 0000000000000001 R09: 000000000001e83e
[Mi Sep 24 14:10:29 2025] R10: ffff93c7016347a4 R11: 071c71c71c71c71c R12: ffffffff9d3b70c0
[Mi Sep 24 14:10:29 2025] R13: ffffffff9d3b71a8 R14: 0000000000000002 R15: 0000000000000000
[Mi Sep 24 14:10:29 2025] FS:  0000000000000000(0000) GS:ffff93c701600000(0000) knlGS:0000000000000000
[Mi Sep 24 14:10:29 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mi Sep 24 14:10:29 2025] CR2: 00007fff42aa7f48 CR3: 0000000108fe6003 CR4: 00000000001726f0
[Mi Sep 24 14:10:29 2025] Call Trace:
[Mi Sep 24 14:10:29 2025]  <TASK>
[Mi Sep 24 14:10:29 2025]  cpuidle_enter_state+0x81/0x420
[Mi Sep 24 14:10:29 2025]  cpuidle_enter+0x2d/0x40
[Mi Sep 24 14:10:29 2025]  do_idle+0x1e5/0x240
[Mi Sep 24 14:10:29 2025]  cpu_startup_entry+0x29/0x30
[Mi Sep 24 14:10:29 2025]  rest_init+0xcc/0xd0
[Mi Sep 24 14:10:29 2025]  start_kernel+0x74c/0x750
[Mi Sep 24 14:10:29 2025]  x86_64_start_reservations+0x24/0x30
[Mi Sep 24 14:10:29 2025]  x86_64_start_kernel+0x95/0xa0
[Mi Sep 24 14:10:29 2025]  common_startup_64+0x13e/0x141
[Mi Sep 24 14:10:29 2025]  </TASK>
[Mi Sep 24 14:10:31 2025] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 11520027553 wd_nsec: 11520025207

# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.12.43+deb13-amd64 root=/dev/mapper/thecube--vg-root ro quiet intel_iommu=off intel_idle.max_cstate=2


Rebooting into 6.1. gave me:

# uname -a
Linux thecube 6.1.0-40-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.153-1 (2025-09-20) x86_64 GNU/Linux

# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.1.0-40-amd64 root=/dev/mapper/thecube--vg-root ro quiet intel_iommu=off intel_idle.max_cstate=2

# cat /sys/devices/system/cpu/cpuidle/current_driver
intel_idle

# ls -l /sys/devices/system/cpu/cpu0/cpuidle/
insgesamt 0
drwxr-xr-x 2 root root 0 24. Sep 19:14 state0
drwxr-xr-x 3 root root 0 24. Sep 19:14 state1
drwxr-xr-x 3 root root 0 24. Sep 19:14 state2

# cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
POLL
C1
C1E


Will now remove intel_iommu=off and see if that actually stops the machine when crashing again.


Best regards,

Thorsten


PS: @Uwe, gmail won't tolerate my mailserver, sorry :(


On 9/23/25 12:31, Thomas Gleixner wrote:
> On Mon, Sep 22 2025 at 19:33, Thorsten Sperber wrote:
>> thanks for your help. It's been four days now, I'd say above average
>> (last was five days) - and no crash yet. I'm going to wait at least
>> until the weekend before naming a winner, but that's already looking
>> pretty good.
> Thanks for trying.
>
> I suggested to try intel_idle.max_cstate=2 because these unknown NMI
> backtraces all originated from a MWAIT(C3).
>
> Can you reboot into the working 6.1.y kernel at some point and check
> which idle driver is used there?
>
>      cat /sys/devices/system/cpu/cpuidle/current_driver
>
> and which states are advertised:
>
>      ls /sys/devices/system/cpu/cpu0/cpuidle/state
>
> Thanks,
>
>          tglx
>

