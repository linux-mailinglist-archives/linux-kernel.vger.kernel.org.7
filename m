Return-Path: <linux-kernel+bounces-738539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F1B0B9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FECC17639D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F1167DB7;
	Mon, 21 Jul 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="imExka0Z"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C38460
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062014; cv=none; b=UEPYk4fOjp2BjKBvMDON0ve9YPZlWLm29lXYrJ7lDGvwOupyY2LToK8LDxODgFbX0qY8Q8iGKVYo4K1W4e6UlcJCXaMU/VABgzDMVdhExkckvIODCOpRT6pPWgyxB0CxkhEMWwgYrkmvPifrpRUkKeAAZzInibPKaEISl9HJvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062014; c=relaxed/simple;
	bh=N3wW2eu1qyMXQF02kZGDahsn2QDAVDyABmOZ9np5SEg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NYBdlmljdsbhNqq74Otl5ZORPl3+KBGC8GIzBnz94UPGRlgfwXtVZKLHxg4+ZgSP72Ky4zZhnh20L3PQpaOJq0xWnkOPEXXrg5mSvKu3D0UOBSHTn3LXZAn7MBzprenw+g+iYZ4WA4I44kOgjREgSaNL1G48kewXLnOrkZS4dLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=imExka0Z; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1753061935;
	bh=YokeowYOqN0bv823NJO2f+EodILAT94bWPiCamJm/ws=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=imExka0Za52l8qpT+5RiJSHKs+HgJ3OEPBxuBGMj2GRSjUI45UcgCiUy3fminSRfg
	 SeZGwevs+UBrqhglu3GjuOFOmV/jAVbmlQAgnW76qvRwScpoLAxPzDNDxww+2cU/PG
	 YTly2uQFfE2WcN+o24FGz0l2yupBSEljUfFHiWj4=
X-QQ-mid: zesmtpgz5t1753061934t970ecd94
X-QQ-Originating-IP: vUMC8Kz68tcwL1srvSMh7dmZ33wUuQQ2PmPHX3RZfkk=
Received: from smtpclient.apple ( [202.120.235.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 09:38:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7993707601274274376
EX-QQ-RecipientCnt: 5
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: possible deadlock in smp_call_function_many_cond
From: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
In-Reply-To: <877c02vejr.ffs@tglx>
Date: Mon, 21 Jul 2025 09:38:39 +0800
Cc: =?utf-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>,
 Peter Zijlstra <peterz@infradead.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D7CEA60-1893-409C-A332-F965D48D62E3@m.fudan.edu.cn>
References: <758991c1.13f67.197f9cccf9b.Coremail.baishuoran@hrbeu.edu.cn>
 <877c02vejr.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MKDkAtdvnNvY7YFjTY8Gno6HrSagSbNe/zAjGDknpnlhqPJyRcrKYgT3
	xPDVNOaqsrZ1T3DQUnp/LgcePW5Kk2xdPLoM7MdGHiyc39CSMEqvBF1rFjDwf7VQHz0KL6e
	7WzJrueIvgtE/44WZDDgLprsKk04rM+IHF2g1A+pMB3pUgOZdMxvOQKlQgguQmpwY3EEkMY
	TNf5ffqWpJQbQHK7Kogn5rWhuxafKsY9V8uuxCZ2Pn+nMwpmjLuFKS9mcVtcLjJZ0KNCf4p
	TvL8y10E3C1P42hxx7e/bYhZgM8CWpqF6MAuIAZqy+LtToaCKurF9o+WIzI1phiWeUyI/Aq
	ItE7AVM0AQLq2m8NBFRb/1iDWZ4KaxSp03bvJDzj6rJir3aKTfhW768YB/C/cng6tJBeAq+
	B8z7NORGN3zEB/zwsybvmmpdXPvE63nqxKyhiqUds8X6syCehSL8QBUtKU1+pvUYwMPiQj9
	e91WSG4J4Ov1BqAC3BIm9EIE9Bc0i6CtfLYKT7yLsi6Vj2tzfc4dcp/o95k8GNp9X2CXiqP
	RFrtlzRvU5uW3nRYPAoOHEogOLYJIG8YyARbuEqbhh27EYTHjK499Ebl3w8UP5NXPB9ZWTB
	6tjHpcYOO560gJgG/HSqqr1zt/0ZAZy8xYYqqiEq4obqWmvwo6PLqPWnSXj4OxLs/QskP+X
	V0WS+Y8AyAt/mYEohWEW2HyKXrn9irRgD9r9rFf2NWOPZi55QiprfmbQJJn1AEQKb74ukHX
	2rAPM+GaaUwT6hcDDQA/m9tbgHl5lL/zyJgUHbfPe0JGX86NOLNERUjG2DuZ5hnGH9hLELj
	cdRdBy784JhKnyf+i52UIKSC+SDD0Cu7Otl1Wr7CDVr3x40VdoKQqu2ZR85qRDvIamdrl5s
	UANdkCvXQOCsN4anKMXRXvRYs5LkT03vwHQ83kZNelG7eHWJ/KqjdPISHRFXEekm9p05DRQ
	UZ97HHUTt0XPDVe31ScY8nRt6q2xoFxawCCKLxU8/nxabqNdeByJF8zoO2lmT4a6dn2tjC6
	X6T9zRQ0Ii1UIj4YAk8yuA8PCvLt3umVXd2Qu3ZQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Thomas,

Thank you for your valuable suggestions! We will rerun the tests using =
the latest kernel version.

Additionally, we appreciate your tips on enabling these two options, as =
they will help us capture more useful information for further analysis.

Thanks,
Kun=20

> 2025=E5=B9=B47=E6=9C=8821=E6=97=A5 03:38=EF=BC=8CThomas Gleixner =
<tglx@linutronix.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 11 2025 at 22:03, =E7=99=BD=E7=83=81=E5=86=89 wrote:
>> When using our customized Syzkaller to fuzz the latest Linux kernel,
>> the following crash (122th)was triggered.
>>=20
>> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
>> git tree: upstream
>=20
> That's not the latest kernel.
>=20
>> =
Output:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/INFO%3A%20=
rcu%20detected%20stall%20in%20sys_select/122report.txt
>> Kernel =
config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.14rc3/config.=
txt
>> C =
reproducer:https:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/=
INFO%3A%20rcu%20detected%20stall%20in%20sys_select/122repro.c
>> Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/INFO%3A%20rcu%20d=
etected%20stall%20in%20sys_select/122repro.txt
>>=20
>> Our reproducer uses mounts a constructed filesystem image.
>>=20
>> The error occurred around line 880 of the code, specifically during
>> the call to csd_lock_wait. The status of CPU 1 (RCU GP kthread):
>> executing the perf_event_open system call, needs to update tracepoint
>=20
> I can't find a perf_event_open() syscall in the C reproducer. So how =
is
> that supposed to be reproduced?
>=20
>> calls on all CPUs, and smp_call_function_many_cond is stuck waiting
>> for CPU 2 to respond to the IPI.  We have reproduced this issue
>> several times on 6.14 again.
>=20
> Again not the latest kernel. Please run it against Linus latest tree =
and
> if it still triggers, provide proper information how to reproduce. If
> not you should be able to bisect the fix.
>=20
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu: 	2-...!: (3 GPs behind) idle=3Db834/1/0x4000000000000000 =
softirq=3D23574/23574 fqs=3D5
>> rcu: 	(detected by 1, t=3D10502 jiffies, g=3D19957, q=3D594 =
ncpus=3D4)
>=20
> So CPU 1 detects an RCU stall on CPU2
>=20
>> Sending NMI from CPU 1 to CPUs 2:
>> NMI backtrace for cpu 2
>> CPU: 2 UID: 0 PID: 9461 Comm: sshd Not tainted 6.14.0 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:__lock_acquire+0x106/0x46b0
>> Code: ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 ec 35 00 00 49 8b =
45 00 48 3d a0 c7 8a 93 0f 84 29 0f 00 00 44 8b 05 2a dc 74 0c <45> 85 =
c0 0f 84 ad 06 00 00 48 3d e0 c7 8a 93 0f 84 a1 06 00 00 41
>> RSP: 0018:ffffc90000568ac8 EFLAGS: 00000002
>> RAX: ffffffff9aab9a20 RBX: 0000000000000000 RCX: 1ffff920000ad16c
>> RDX: 1ffffffff35692cf RSI: 0000000000000000 RDI: ffffffff9ab49678
>> RBP: ffff8880201aa480 R08: 0000000000000001 R09: 0000000000000001
>> R10: 0000000000000001 R11: ffffffff90617d17 R12: 0000000000000000
>> R13: ffffffff9ab49678 R14: 0000000000000000 R15: 0000000000000000
>> FS:  00007fa644657900(0000) GS:ffff88802b900000(0000) =
knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f0fa92178a9 CR3: 0000000000e90000 CR4: 0000000000750ef0
>> PKRU: 55555554
>> Call Trace:
>> <NMI>
>> </NMI>
>> <IRQ>
>> lock_acquire+0x1b6/0x570
>> _raw_spin_lock_irqsave+0x3d/0x60
>> debug_object_deactivate+0x139/0x390
>> __hrtimer_run_queues+0x416/0xc30
>> hrtimer_interrupt+0x398/0x890
>> __sysvec_apic_timer_interrupt+0x114/0x400
>> sysvec_apic_timer_interrupt+0xa3/0xc0
>=20
> which handles the timer interrupt. What you cut off in your report is:
>=20
> [  321.491987][    C2] hrtimer: interrupt took 31336677795 ns
>=20
> That means the hrtimer interrupt got stuck for 32 seconds (!!!). That
> warning is only emitted once, so I assume there is something weird =
going
> on with hrtimers and one of their callbacks. But there is no =
indication
> where this comes from.
>=20
> Can you enable the hrtimer_expire_entry/exit tracepoints on the kernel
> command line and add 'ftrace_dump_on_oops' as well, so that the trace
> gets dumped with the rcu stall splat?
>=20
> Thanks,
>=20
>        tglx
>=20
>=20
>=20


