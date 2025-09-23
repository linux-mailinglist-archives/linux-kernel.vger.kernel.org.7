Return-Path: <linux-kernel+bounces-829482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED4B972C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4424C3172
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FB2FB096;
	Tue, 23 Sep 2025 18:14:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E423281370
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651267; cv=none; b=uUJDPa6306z9+s3UgXsFFc8lXwbt6nGFtG3Ik6XTeGUZtnCXGx9z+yjhZe+oFwZYtpkYw/uLoH2yaPy3J/Av81DYnjb0v9UUzjjCHe3IYTcEDGYg2jzD96c47t8UszjTgw1wYewqpHPn7W9cDSoQoJWtkwNHJPpHSBZ1r2ie7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651267; c=relaxed/simple;
	bh=u5CAF2Z9sP91EvXfpG+9jhGDFgDNJ7VUSVqL1/BVLXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YD+zW3FFm0rRIALCkztMhhL4xf+hB+nAhLODb0tWjTCTbid04zGOauIL5ggAkpNzmR6MVGykjnHlcbOG61Q5bn6ZvubJl9+63V/YnT7U+BO16+3yx3m53qwK+jEM7nhthzuDogPOffbICJjspGvXLXXKX0iGNpjNJreq5Rolz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2D5497;
	Tue, 23 Sep 2025 11:14:14 -0700 (PDT)
Received: from [10.57.80.141] (unknown [10.57.80.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D37763F694;
	Tue, 23 Sep 2025 11:14:20 -0700 (PDT)
Message-ID: <9edb5b8d-8660-4699-b041-bd74329a14e9@arm.com>
Date: Tue, 23 Sep 2025 20:14:18 +0200
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
 Ben Dooks <ben.dooks@codethink.co.uk>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
References: <3308bca2-624e-42a3-8d98-48751acaa3b3@codethink.co.uk>
 <d6abff7f5f9ee5e41f19cb1f9d02de29@codethink.co.uk>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <d6abff7f5f9ee5e41f19cb1f9d02de29@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.09.25 18:37, Matteo Martelli wrote:
> Hi all,
> 
> On Fri, 19 Sep 2025 12:10:34 +0100, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> We are doing some testing with stress-ng and the cgroup-v2 enabled
>> (CONFIG_RT_GROUP_SCHED) and are running into WARN/BUG within a minute
>> related to user-space calling sched_setattr() and possibly other calls.
>>
>> At the moment we're not sure if the WARN and BUG calls are entirely
>> correct, we are considering there may be some sort of race condition
>> which is causing incorrect assumptions in the code.
>>
>> We are seeing this kernel bug in pick_next_rt_entity being triggered
>>
>> 	idx = sched_find_first_bit(array->bitmap);
>> 	BUG_ON(idx >= MAX_RT_PRIO);
>>
>> Which suggests that the pick_task_rt() ran, thought there was something
>> there to schedule and got into pick_next_rt_entity() which then found
>> there was nothing. It does this by checking rq->rt.rt_queued before it
>> bothers to try picking something to run.
>>
>> (this BUG_ON() is triggered if there is no index in the array indicating
>>   something there to run)
>>
>> We added some debug to find out what the values in pick_next_rt_entity()
>> with the current rt_queued and the value it was when pick_task_rt()
>> looked, and we got:
>>
>>     idx 100 bigger than MAX_RT_PRIO 100, queued = 0 (queued was 1)
>>
>> This shows the code was entered with the rt_q showing something
>> should have been queued and by the time the pick_next_rt_entity()
>> was entered there seems to be nothing (assuming the array is in
>> sync with the lists...)
>>
>> I think the two questions we have are:
>>
>> - Is the BUG_ON() here appropriate, should a WARN_ON_ONCE() and
>>    return NULL be the best way of handling this? I am going to try
>>    this and see if the system is still runnable with this.
>>
>> - Are we seeing a race here, and if so where is the best place to
>>    prevent it?
>>
>> Note, we do have a few local backported cgroup-v2 patches.
>>
>> Our systemd unit file to launch the test is here:
>>
>> [Service]
>> Type=simple
>> Restart=always
>> ExecStartPre=/bin/sh -c 'echo 500000 > 
>> /sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
>> ExecStartPre=/bin/sh -c 'echo 500000 > 
>> /sys/fs/cgroup/system.slice/stress-sched-long-system.service/cpu.rt_runtime_us'
>> ExecStart=sandbox-run /usr/bin/stress-ng --temp-path /tmp/stress-ng 
>> --timeout=0 --verify --oom-avoid --metrics --timestamp 
>> --exclude=enosys,usersyscall --cpu-sched 0 --timeout 60 --verbose 
>> --stressor-time
>> Environment=SANDBOX_RO_BINDMOUNTS="/usr/share/stress-ng"
>> Environment=SANDBOX_RW_BINDMOUNTS="/var/log /sys /proc /dev /tmp/stress-ng"
>> Environment=SANDBOX_EXTRA_ARGS="--cwd /tmp/stress-ng --keep_caps 
>> --disable_rlimits --disable_clone_newuser"
>> Slice=system.slice
>> OOMPolicy=continue

[...]

> Hi all,
> 
> To provide some more context, we have found out this issue while running
> some tests with stress-ng scheduler stressor[1] and the RT throttling
> feature after enabling the RT_GROUP_SCHED kernel option. Note that we
> also have PREEMPT_RT enabled in our config.
> 
> I've just reproduced the issue on qemu-x86_64 with a debian image and kernel
> v6.17-rc6. See below the steps to reproduce it.
> 
> cd linux
> git reset --hard v6.17-rc6 && git clean -f -d
> 
> # Apply patch to expose RT_GROUP_SCHED interface to userspace with cgroupv2
> b4 shazam --single-message https://lore.kernel.org/all/20250731105543.40832-17-yurand2000@gmail.com/

Don't get this one ... you just pick a single patch from the RFC
patch-set '[RFC PATCH v2 00/25]  Hierarchical Constant Bandwidth Server' ?

https://lore.kernel.org/r/20250731105543.40832-1-yurand2000@gmail.com


> # Build kernel with defconfig + PREEMPT_RT=y and RT_GROUP_SCHED=y
> make mrproper
> make defconfig
> scripts/config -k -e EXPERT
> scripts/config -k -e PREEMPT_RT
> scripts/config -k -e RT_GROUP_SCHED
> make olddefconfig
> make -j12
> 
> # Download a debian image and run qemu
> wget https://cdimage.debian.org/images/cloud/sid/daily/20250919-2240/debian-sid-nocloud-amd64-daily-20250919-2240.qcow2
> qemu-system-x86_64 \
>     -m 2G -smp 4 \
>     -nographic \
>     -nic user,hostfwd=tcp::2222-:22 \
>     -M q35,accel=kvm \
>     -drive format=qcow2,file=debian-sid-nocloud-amd64-daily-20250919-2240.qcow2 \
>     -virtfs local,path=.,mount_tag=shared,security_model=mapped-xattr \
>     -monitor none \
>     -append "root=/dev/sda1 console=ttyS0,115200 sysctl.kernel.panic_on_oops=1" \
>     -kernel arch/x86/boot/bzImage
> 
> # Then inside guest machine
> # Install stress-ng
> apt-get update && apt-get install stress-ng
> 
> # Create the stress-ng service. It sets the group RT runtime to 500ms
> # (50% BW) via the cgroupv2 interface then it starts the stress-ng
> # scheduler stressor. Also note the cpu affinity set to a single CPU
> # which seems to help the issue to be more reproducible.

I assume this is the 'AllowedCPUs=0' line in the systemd service file.

> echo "[Unit]
> Description=Mixed stress with long in the system slice
> After=basic.target
> 
> [Service]
> AllowedCPUs=0
> Type=simple
> Restart=always
> ExecStartPre=/bin/sh -c 'echo 500000 > /sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
> ExecStart=/usr/bin/stress-ng --timeout=0 --verify --oom-avoid --metrics --timestamp --exclude=enosys,usersyscall --cpu-sched 0 --


I assume you get 4 stressors since you run 'qemu -smp 4'? How many
stress-ng related tasks have you running in
'system.slice/stress-sched-long-system.service'? And all of them on CPU0?

[...]

