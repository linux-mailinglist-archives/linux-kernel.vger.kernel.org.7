Return-Path: <linux-kernel+bounces-883973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B5C2EF50
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952514E2249
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB223A984;
	Tue,  4 Nov 2025 02:22:20 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746711DE2A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222940; cv=none; b=ORLrr2USaP91kdGYVdnz9xqNuMAkv8ODtP1/Jgy3Zvdjv4vtJvS3PAeeRkreX8ILLq1FekC4V7AMf2xEdyDzmlCftgVh+tFXusDFYaOkq5T3DDWZTApWjKPn5XCZKnIyPGxG2R+Pe3Fz8+u7TcJp/WY4Qi5eLZXX/pgfsVi3KAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222940; c=relaxed/simple;
	bh=tFgeIE59jc/HFVOKmy9Ljs9aCmo0o12HJX/v/WhEX6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDVlQA3moRhLrQQZU0IX0Fin2XC4Jg9G7vvjKRn5SjvCj5hI2W2yDiaBiepMkmFZnzPe4N9gQN7dOVgMdPxkUB9MNT3oRThILK8ZA7GOBADHxgwr5MMApmTKVI3JlHTjUhkDlJqhHjlmHkVqKRb6aTykKDItmGNYHBwQFsZxQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: zesmtpsz7t1762222925t2995d897
X-QQ-Originating-IP: A3/odC16aftFYDtQULxGfhYeoNPRYDA1Ks1BQJ6CPbs=
Received: from [169.235.25.74] ( [169.235.25.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Nov 2025 10:22:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18013488585438763342
EX-QQ-RecipientCnt: 13
Message-ID: <0BF8B2E83B6154B6+f17f32b4-f6ff-4184-917d-4b27fb916eae@tinylab.org>
Date: Mon, 3 Nov 2025 18:21:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] dce, riscv: Unused syscall trimming with
 PUSHSECTION and conditional KEEP()
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 i@maskray.me, Zhangjin Wu <falcon@tinylab.org>, ronbogo@outlook.com,
 z1652074432@gmail.com, lx24@stu.ynu.edu.cn
References: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
 <33333fdd-2aa2-4ce0-8781-92222829ea12@app.fastmail.com>
Content-Language: en-US
From: Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <33333fdd-2aa2-4ce0-8781-92222829ea12@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NktOKkB7nvaJqiY9zLenzlfaHPREjDigFG+hwAFBdTIDtWJ5Ng1groXF
	oqFK3cyCfs+7cc3yStXnFGLhyAqnCfvW6nu5vNmfmE5lW/HAKgVP935pQc9cNY0YLVZapf0
	nQBaq2r/0dq1mSwh5LHxRhWGiwWEvA2xZGmk6rpQ7kQTcGjE+h1249nkwabTDIgzcLnwa26
	eugpoeGKDQ87o+9EZGWEe5dzDUYsqu/d3G1scM70DH38dVaRjtEYNvJ943a4JykUkQs9W7O
	6FlVAZgqqzU4cVyD1/suc0FwDNNReAOSMNa0eCsNamlK/U2ci0uXOVoUKVzIcKyqQT5oh/5
	i1ocmQFrMs/0aicgQNX2BGVjX4X7+uFi2jSJQCdW2m83vzahmI492PepeT07LggpaLX3G3o
	kfXPCB0EcvUvvj2hfuXMONoVAV01Uuz2qd9g8jbgM++FCzTDjGkmOcq+qjbR85QmlswmvHd
	4CTTU2Wajr2NTLp1WuYluf7AbVB3CqLUB15qhVcSeAA7JppKdIbcPDbLLUHfend2XzNBBpy
	K3e9DZ0WiBVVRiU18bRBi+77Jnp5qiRnlteLZrvw7tXxOVJQx/whrQU50XbcIfdh4Qo5jUd
	icqsJMNmv01oe9fAspcSR8SaxK7c7G9xaf9u9wYs7xRilhopGCGroVVtyOfGn97M7WiJvqr
	fDoG0+8wX6SWf0NQ9tFYz5x20iiHBbelcYxNcd5n6qoPlpWZzuHVCNIid9LfK47+hyME+S/
	uA4XwNsw7W0tuGxiv4/KK3qgQmVU+2rtPZ1MK/CvA+25pDSfwUyLtpnHGEMAKQRDgMAulvv
	s3llur9sgh/QQFehBPZlIuzqE2xn0t7wIv6Wr5U9Ozoc2hHY373OKV+CtQUdTrJexe6dlMx
	+P2edWwby4RB5V0h9Svj+DSHxwRoNZB9SLuXRUo6mHIvVU9W6cTtYpCgeaKVb3UwkEIMyOL
	Hzi9PnEGR/qoDqqRbKSUpvt6gNYZGxq6OyLLmDVut1v4ajVR4mdsQr9GLhlDhmd89Ym6uxt
	j3NJbtpwL5GVtYBBS70cHFOYo5O/f9NeIbOF0mvF2X+8QgTF0/rI40XX3wTooKvCc5GdNSw
	6/epSML2YuWKUKMjmvU+Fc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


On 10/15/2025 12:47 AM, Arnd Bergmann wrote:
> On Wed, Oct 15, 2025, at 08:16, Yuan Tan wrote:
>> Hi all,
>>
>> This series aims to introduce syscall trimming support based on dead code
>> and data elimination (DCE). This can reduce the final image size, which is
>> particularly useful for embedded devices, while also reducing the attack
>> surface. It might further benefit specialized scenarios such as unikernels
>> or LTO builds, and could potentially help shrink the instruction cache
>> footprint.
>>
>> Besides that, this series also introduces a new PUSHSECTION macro. This
>> wrapper allows sections created by .pushsection to have a proper reference
>> relationship with their callers, so that --gc-sections can safely work
>> without requiring unconditional KEEP() entries in linker scripts.
>>
>> Since the new syscalltbl.sh infrastructure has been merged, I think it’s a
>> good time to push this patchsetTODO? forward.
>>
>> Patch 1–3 introduce the infrastructure for TRIM_UNUSED_SYSCALLS, mainly
>> allowing syscalltbl.sh to decide which syscalls to keep according to
>> USED_SYSCALLS.
>> Patch 4 enables TRIM_UNUSED_SYSCALLS for the RISC-V architecture. With
>> syscalltbl.sh now available, this feature should be applicable to all
>> architectures that support LD_DEAD_CODE_DATA_ELIMINATION and use
>> syscalltbl.sh, but let’s focus on RISC-V first.
>> Patch 5–8 address the dependency inversion problem caused by sections
>> created with .pushsection that are forcibly retained by KEEP() in linker
>> scripts.
> Thanks a lot for your work on this. I think it is indeed valuable to
> be able to optimize kernels with a smaller subset of system calls for
> known workloads, and have as much dead code elimination as possible.
>
> However, I continue to think that the added scripting with a known
> set of syscall names is fundamentally the wrong approach to get to
> this list: This adds complexity to the build process in one of
> the areas that is already too complicated, and it duplicates what
> we can already do with Kconfig for a subset of the system calls.
>
> I think the way we should configure the set of syscalls instead is
> to add more Kconfig symbols guarded by CONFIG_EXPERT that turn
> classes of syscalls on or off. You have obviously done the research
> to come up with a list of used/unused entry points for one or more
> workloads. Can you share those lists?
>
>       Arnd


Hi Arnd,

Sorry for the late reply — this patchset really wore me out, and I only just
recovered.  Thank you very much for your feedback!

Regarding your suggestion to use Kconfig to control which system calls are
included or excluded, perhaps we could take inspiration from systemd's
classification approach. For example, systemd groups syscalls into categories
like[1]:

@aio @basic-io @chown @clock @cpu-emulation @debug @file-system

and so on.

However, if we go down this route, we would need to continuously maintain and
update these categories whenever Linux introduces new system calls. I' m not
sure whether that would be an ideal long-term approach.

For reference, here is the list of syscalls required to run Lighttpd.

execve set_tid_address mount write brk mmap munmap getuid getgid getpid
clock_gettime getcwd fcntl fstat read dup3 socket setsockopt bind listen
rt_sigaction rt_sigprocmask newfstatat prlimit64 epoll_create1 epoll_ctl pipe2
epoll_pwait accept4 getsockopt recvfrom shutdown writev getdents64 openat close

We've tested it successfully on QEMU + initramfs, and I can share the
deployment script if anyone would like to reproduce the setup.

Also, I noticed that there haven't been any comments so far on the later
patches introducing the PUSHSECTION macro.  I' m a bit concerned about how
people perceive this part.

[1] https://github.com/systemd/systemd/blob/main/src/shared/seccomp-util.c




