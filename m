Return-Path: <linux-kernel+bounces-865684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A8BFDBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0451883AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B22E172B;
	Wed, 22 Oct 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="BOkEiU9S"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B435B131
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155913; cv=none; b=uKzWh+SawDJlAcvE21zmhKZVPQDQ8Mz8EWiQ0O2Ep4M96X0iaMCMEG1b0RMpky7yMfm4qs+DtXENrVcBGYf8oBrTh9znEd1anNxesiDnCaLEsuwaOpBRoQ1S7vCF1xYTOWjl9I0An0TF4Q7C4AHq6GR3/SXIoe5LXejWtzRCrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155913; c=relaxed/simple;
	bh=raByj2r3vIwwxSp7+IP/V+CHxsKlI600hg/F84dPsW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EHhtcP9Upty7XT11SypB4oEEpWqPttaIswSRsMLtSOt6gpFn+79DfZbbaO1MkrpWydhY7O60Ew4Nzp+Z9muOjiXpUa9eGFCYuMRPM2k5lFkSzGkaYPXQarXiw9WC1AI0QEAG9HEaIy/i0y/vhG0bhmtnoh2hOFEL9+sJONy+JSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=BOkEiU9S; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc; bh=sIWFgO8Rltz79CgM+UgOewkeeLOyWGC+VnTTl647K78=; b=BOkEiU9ST5BJ0DQyoZx+yz
	11d//Gnp2fPCcv2FKOFNv+Dl8s9KHNRtiQ0LZIikvs1CMKgNf308SBwEqWHM9Fbsne/CxVKoU+g5f
	6W98GwSWANF0by29xsxQPZvAFEAFT8aLuflQ7h8HPv5LwISe8ZZsO7zjkXkVxt4j04RZBOZy5lmtE
	9WpSw0LKFUcGfBNd8RHZAUsc3phjCnVPsk02RHGqf725wFfNRcyszSPptN1duAPWboX4E6+/EGaR2
	TdFBbChroUXZeHo1/ylqdPDPCEB5gJE3KMxOTTSKXBvgVe3FWXN2w8jORNXDKytAG7K6pIG3GZYkc
	XLu3EwyVNJfg==;
Received: from [63.135.74.212] (helo=[192.168.1.241])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vBd5z-0000NK-Ap; Wed, 22 Oct 2025 18:57:59 +0100
Message-ID: <4543c563-acc6-45d4-b3a3-44448881be3b@codethink.co.uk>
Date: Wed, 22 Oct 2025 18:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG/WARN issues in kernel/sched/rt.c under stress-ng with
 crgoup-v2
To: Matteo Martelli <matteo.martelli@codethink.co.uk>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
References: <3308bca2-624e-42a3-8d98-48751acaa3b3@codethink.co.uk>
 <d6abff7f5f9ee5e41f19cb1f9d02de29@codethink.co.uk>
 <9edb5b8d-8660-4699-b041-bd74329a14e9@arm.com>
 <d6fcbedf0daf259e2f96a1e0cc666cff@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <d6fcbedf0daf259e2f96a1e0cc666cff@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 24/09/2025 14:10, Matteo Martelli wrote:
> Hi Dietmar,
> 
> On Tue, 23 Sep 2025 20:14:18 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> On 19.09.25 18:37, Matteo Martelli wrote:
>>> Hi all,
>>>
>>> On Fri, 19 Sep 2025 12:10:34 +0100, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>> We are doing some testing with stress-ng and the cgroup-v2 enabled
>>>> (CONFIG_RT_GROUP_SCHED) and are running into WARN/BUG within a minute
>>>> related to user-space calling sched_setattr() and possibly other calls.
>>>>
>>>> At the moment we're not sure if the WARN and BUG calls are entirely
>>>> correct, we are considering there may be some sort of race condition
>>>> which is causing incorrect assumptions in the code.
>>>>
>>>> We are seeing this kernel bug in pick_next_rt_entity being triggered
>>>>
>>>> 	idx = sched_find_first_bit(array->bitmap);
>>>> 	BUG_ON(idx >= MAX_RT_PRIO);
>>>>
>>>> Which suggests that the pick_task_rt() ran, thought there was something
>>>> there to schedule and got into pick_next_rt_entity() which then found
>>>> there was nothing. It does this by checking rq->rt.rt_queued before it
>>>> bothers to try picking something to run.
>>>>
>>>> (this BUG_ON() is triggered if there is no index in the array indicating
>>>>    something there to run)
>>>>
>>>> We added some debug to find out what the values in pick_next_rt_entity()
>>>> with the current rt_queued and the value it was when pick_task_rt()
>>>> looked, and we got:
>>>>
>>>>      idx 100 bigger than MAX_RT_PRIO 100, queued = 0 (queued was 1)
>>>>
>>>> This shows the code was entered with the rt_q showing something
>>>> should have been queued and by the time the pick_next_rt_entity()
>>>> was entered there seems to be nothing (assuming the array is in
>>>> sync with the lists...)
>>>>
>>>> I think the two questions we have are:
>>>>
>>>> - Is the BUG_ON() here appropriate, should a WARN_ON_ONCE() and
>>>>     return NULL be the best way of handling this? I am going to try
>>>>     this and see if the system is still runnable with this.
>>>>
>>>> - Are we seeing a race here, and if so where is the best place to
>>>>     prevent it?
>>>>
>>>> Note, we do have a few local backported cgroup-v2 patches.
>>>>
>>>> Our systemd unit file to launch the test is here:
>>>>
>>>> [Service]
>>>> Type=simple
>>>> Restart=always
>>>> ExecStartPre=/bin/sh -c 'echo 500000 >
>>>> /sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
>>>> ExecStartPre=/bin/sh -c 'echo 500000 >
>>>> /sys/fs/cgroup/system.slice/stress-sched-long-system.service/cpu.rt_runtime_us'
>>>> ExecStart=sandbox-run /usr/bin/stress-ng --temp-path /tmp/stress-ng
>>>> --timeout=0 --verify --oom-avoid --metrics --timestamp
>>>> --exclude=enosys,usersyscall --cpu-sched 0 --timeout 60 --verbose
>>>> --stressor-time
>>>> Environment=SANDBOX_RO_BINDMOUNTS="/usr/share/stress-ng"
>>>> Environment=SANDBOX_RW_BINDMOUNTS="/var/log /sys /proc /dev /tmp/stress-ng"
>>>> Environment=SANDBOX_EXTRA_ARGS="--cwd /tmp/stress-ng --keep_caps
>>>> --disable_rlimits --disable_clone_newuser"
>>>> Slice=system.slice
>>>> OOMPolicy=continue
>>
>> [...]
>>
>>> Hi all,
>>>
>>> To provide some more context, we have found out this issue while running
>>> some tests with stress-ng scheduler stressor[1] and the RT throttling
>>> feature after enabling the RT_GROUP_SCHED kernel option. Note that we
>>> also have PREEMPT_RT enabled in our config.
>>>
>>> I've just reproduced the issue on qemu-x86_64 with a debian image and kernel
>>> v6.17-rc6. See below the steps to reproduce it.
>>>
>>> cd linux
>>> git reset --hard v6.17-rc6 && git clean -f -d
>>>
>>> # Apply patch to expose RT_GROUP_SCHED interface to userspace with cgroupv2
>>> b4 shazam --single-message https://lore.kernel.org/all/20250731105543.40832-17-yurand2000@gmail.com/
>>
>> Don't get this one ... you just pick a single patch from the RFC
>> patch-set '[RFC PATCH v2 00/25]  Hierarchical Constant Bandwidth Server' ?
>>
>> https://lore.kernel.org/r/20250731105543.40832-1-yurand2000@gmail.com
>>
> 
> Yes, I was looking for a way to set the cpu.rt_runtime_us param for a
> specific cgroup from a systemd unit, in order to control the max CPU
> bandwidth allowed for a systemd slice. Since systemd depracated support
> for cgroupv1 I picked that patch to export them via cgroupv2. To my
> understanding, with that patch, setting the rt_runtime_us and
> rt_period_us parameters via cgroupv2 should have the same effect as
> setting them via cgroupv1. Of course I could have missed something and
> that could be one reason for the issue. I will better look into it and
> try to see if the issue is still reproducible with cgroupv1.

We are still seeing WARN_ON() due to the tests at

static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned 
int flags)
{
...
	if (move_entity(flags)) {
...
		WARN_ON_ONCE(!rt_se->on_list);
...
	}
}

This seems to be due to the task_group's rt_entity tripping this under
load. I'm not sure yet if the WARN_ON_ONCE() here is actually useful or
if we are tripping some sort of race condition.

When moving from one stress-ng pid to another, it should have enqueued
the task-group back with the on_list set, but it seems not to? I've done
a quick trace_printk() after moving up to v6.17, however adding a print
of the rt_se setting seems to have stopped this issue from re-appearing
on my system.

I'll run some more tests to see if this comes back.

>>
>>> # Build kernel with defconfig + PREEMPT_RT=y and RT_GROUP_SCHED=y
>>> make mrproper
>>> make defconfig
>>> scripts/config -k -e EXPERT
>>> scripts/config -k -e PREEMPT_RT
>>> scripts/config -k -e RT_GROUP_SCHED
>>> make olddefconfig
>>> make -j12
>>>
>>> # Download a debian image and run qemu
>>> wget https://cdimage.debian.org/images/cloud/sid/daily/20250919-2240/debian-sid-nocloud-amd64-daily-20250919-2240.qcow2
>>> qemu-system-x86_64 \
>>>      -m 2G -smp 4 \
>>>      -nographic \
>>>      -nic user,hostfwd=tcp::2222-:22 \
>>>      -M q35,accel=kvm \
>>>      -drive format=qcow2,file=debian-sid-nocloud-amd64-daily-20250919-2240.qcow2 \
>>>      -virtfs local,path=.,mount_tag=shared,security_model=mapped-xattr \
>>>      -monitor none \
>>>      -append "root=/dev/sda1 console=ttyS0,115200 sysctl.kernel.panic_on_oops=1" \
>>>      -kernel arch/x86/boot/bzImage
>>>
>>> # Then inside guest machine
>>> # Install stress-ng
>>> apt-get update && apt-get install stress-ng
>>>
>>> # Create the stress-ng service. It sets the group RT runtime to 500ms
>>> # (50% BW) via the cgroupv2 interface then it starts the stress-ng
>>> # scheduler stressor. Also note the cpu affinity set to a single CPU
>>> # which seems to help the issue to be more reproducible.
>>
>> I assume this is the 'AllowedCPUs=0' line in the systemd service file.
> 
> Yes, correct.
> 
>>
>>> echo "[Unit]
>>> Description=Mixed stress with long in the system slice
>>> After=basic.target
>>>
>>> [Service]
>>> AllowedCPUs=0
>>> Type=simple
>>> Restart=always
>>> ExecStartPre=/bin/sh -c 'echo 500000 > /sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
>>> ExecStart=/usr/bin/stress-ng --timeout=0 --verify --oom-avoid --metrics --timestamp --exclude=enosys,usersyscall --cpu-sched 0 --
>>
>>
>> I assume you get 4 stressors since you run 'qemu -smp 4'? How many
>> stress-ng related tasks have you running in
>> 'system.slice/stress-sched-long-system.service'? And all of them on CPU0?
> 
> Yes, with --cpu-sched 0, stress-ng is using 4 scheduler stressors all
> running on CPU 0. To my understanding each scheduler stressor forks 16
> stress-ng child tasks [1], this is confirmed by the number of stress-ng
> tasks running on the system. The test itself is not particularly
> meaningful, it just reflects the setup I had when I found the BUG_ON.
> 
>> [...]
>>
> 
> [1]: https://github.com/ColinIanKing/stress-ng/blob/V0.19.04/stress-cpu-sched.c#L66
> 
> Best regards,
> Matteo Martelli
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

