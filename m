Return-Path: <linux-kernel+bounces-832532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2191DB9F99B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC1B1B26576
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4B2641E3;
	Thu, 25 Sep 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="AQcvE5Sk"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BF2727F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807309; cv=none; b=WCNuMolTBcAjEMC15sD9xRXr5f5hpbQaTdDP9/GTghZd0NHfnsNwyo6X72xtOeBm5tO7pw2lQhcEwVPps7pwCzHWRMTnUOtaCc7yAJg8/sCHDCNsk5j4KJE4HGxACplt5GdEHzCMkOiyAx7A5qF8WR7Ny0p4UxHOEXI5vSn34eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807309; c=relaxed/simple;
	bh=h12CI3LhqEnnJ14K0/pyFToyUvRdrEm1G9SfLC+Iejw=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=XKgOHeFyLZN2xNkDBlkkcG0K+2zTtIyfOxk3hY8gvCgh+7iWHiuQ7uo3zIFK5E0rZgJbG3lRK1x2n+nbA0yLVaRg3qG+jweY0sRCrSKdJYxOaWSorWqxGgsfZU2Dv5G71jhqeZShHij8uBhZzX0Pmsb9Axe3dY2yypyUE5tO1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=AQcvE5Sk; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pN98YwKuO3/ER2jGnj4i6/z5WBU/8bdLjoP7PC7INDQ=; b=AQcvE5Sk1Oo7KhLd3/FBfohj01
	YbrDEyX8B3SA8JfCY/0p+W/aJ3+L8InDYZXGwiBRoAhMZSlIdYa++Hfe3TESlqq9TFy+9Q7VeDBZr
	aQbXXU1PeKdZM+uKbL9c9jnEtcmgyCxt1sAVSw3oQ9oqYFzZ7IAMRwmw+pxkz8Yrp42P+6i9jwS/S
	5y0lznaHAYJilO55d3c6UPsHf9J8UHdOcM4P/wxJRb7y6bWomDjrVN9GOCVhA8ZKUFvXfHxFC3TM6
	QpSn2q5VjcqVNGIvyS/kViuw0o+IZ0WsAiHW+mnySQ12mwPU2KUcNceIeAoc7eveCm8HuC/GyC5uS
	eP58Tv2Q==;
Received: from [167.98.27.226] (helo=localhost)
	by imap5.colo.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v1m6d-005xVG-GB; Thu, 25 Sep 2025 14:33:55 +0100
Date: Thu, 25 Sep 2025 15:33:54 +0200
Message-ID: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
To: Aaron Lu <ziqianlu@bytedance.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, linux-kernel@vger.kernel.org, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
	Michal =?iso-8859-1?q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <20250925120504.GC120@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
	<20250910095044.278-2-ziqianlu@bytedance.com>
	<58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
	<20250924113354.GA120@bytedance>
	<db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
	<20250925092938.GB120@bytedance>
	<72706108-f1c3-4719-a65c-c7c5d76f9b1e@amd.com>
	<20250925120504.GC120@bytedance>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Aaron,

On Thu, 25 Sep 2025 20:05:04 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> On Thu, Sep 25, 2025 at 04:52:25PM +0530, K Prateek Nayak wrote:
> > 
> > On 9/25/2025 2:59 PM, Aaron Lu wrote:
> > > Hi Prateek,
> > > 
> > > On Thu, Sep 25, 2025 at 01:47:35PM +0530, K Prateek Nayak wrote:
> > >> Hello Aaron, Matteo,
> > >>
> > >> On 9/24/2025 5:03 PM, Aaron Lu wrote:
> > >>>> ...
> > >>>> The test setup is the same used in my previous testing for v3 [2], where
> > >>>> the CFS throttling events are mostly triggered by the first ssh logins
> > >>>> into the system as the systemd user slice is configured with CPUQuota of
> > >>>> 25%. Also note that the same systemd user slice is configured with CPU
> > >>>
> > >>> I tried to replicate this setup, below is my setup using a 4 cpu VM
> > >>> and rt kernel at commit fe8d238e646e("sched/fair: Propagate load for
> > >>> throttled cfs_rq"):
> > >>> # pwd
> > >>> /sys/fs/cgroup/user.slice
> > >>> # cat cpu.max
> > >>> 25000 100000
> > >>> # cat cpuset.cpus
> > >>> 0
> > >>>
> > >>> I then login using ssh as a normal user and I can see throttle happened
> > >>> but couldn't hit this warning. Do you have to do something special to
> > >>> trigger it?

It wasn't very reproducible in my setup either, but I found out that the
warning was being triggered more often when I tried to ssh into the
system just after boot, probably due to some additional load from
processes spawned during the boot phase. Therefore I prepared a
reproducer script that resemble my initial setup, plus a stress-ng
worker in the background while connecting with ssh to the system. I also
reduced the CPUQuota to 10% which seemed to increase the probability to
trigger the warning. With this script I can reproduce the warning about
once or twice every 10 ssh executions. See the script at the end of this
email.

> > >>>> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
> > >>>
> > >>> I stared at the code and haven't been able to figure out when
> > >>> enqueue_task_fair() would end up with a broken leaf cfs_rq list.
> > >>>

> > >>
> > >> Yeah neither could I. I tried running with PREEMPT_RT too and still
> > >> couldn't trigger it :(
> > >>
> > >> But I'm wondering if all we are missing is:
> > >>
> > >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >> index f993de30e146..5f9e7b4df391 100644
> > >> --- a/kernel/sched/fair.c
> > >> +++ b/kernel/sched/fair.c
> > >> @@ -6435,6 +6435,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
> > >>  
> > >>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
> > >>  	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
> > >> +	cfs_rq->pelt_clock_throttled = pcfs_rq->pelt_clock_throttled;
> > >>  }
> > >>  
> > >>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
> > >> ---
> > >>
> > >> This is the only way we can currently have a break in
> > >> cfs_rq_pelt_clock_throttled() hierarchy.
> > >>
> ...
> 
> Hi Matteo,
> 
> Can you test the above diff Prateek sent in his last email? Thanks.
> 

I have just tested with the same script below the diff sent by Prateek
in [1] (also quoted above) that changes sync_throttle(), and I couldn't
reproduce the warning.

Here's the script (I hope it doesn't add too much noise to the email
thread).

---
# Copyright (C) 2024 Codethink Limited
# SPDX-License-Identifier: GPL-2.0-only
#!/usr/bin/bash

script_path=$(realpath "$0")
wrk_dir=$(pwd)
kernel_version=fe8d238e646e
kernel_dir=${wrk_dir}/../linux
kernel_image=${kernel_dir}/arch/x86_64/boot/bzImage
qemu_image_url=https://cdimage.debian.org/images/cloud/sid/daily/20250919-2240/debian-sid-nocloud-amd64-daily-20250919-2240.qcow2
qemu_image_src=${wrk_dir}/$(basename "${qemu_image_url}")
qemu_image=${wrk_dir}/image.qcow2
guest_pkgs="stress-ng" # comma separated list of additional packages to install

run_qemu() {
    qemu-system-x86_64 \
        -m 2G -smp 4 \
        -nographic \
        -nic user,hostfwd=tcp::2222-:22 \
        -M q35,accel=kvm \
        -drive format=qcow2,file="${qemu_image}" \
        -virtfs local,path=.,mount_tag=shared,security_model=mapped-xattr \
        -serial file:console.log \
        -monitor none \
        -append "root=/dev/sda1 console=ttyS0,115200 sysctl.kernel.panic_on_oops=1" \
        -kernel "${kernel_image}"
}

run_ssh() {
    local cmd=$1
    ssh root@localhost -p 2222 \
        -i ${wrk_dir}/id_ed25519 -F none \
        -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        $cmd
}

setup_kernel() {
    echo "Building kernel ..."
    pushd $kernel_dir
    git reset --hard $kernel_version && git clean -f -d
    make mrproper
    make defconfig
    scripts/config -k -e EXPERT
    scripts/config -k -e PREEMPT_RT
    scripts/config -k -e CFS_BANDWIDTH
    scripts/config -k -e FUNCTION_TRACER
    make olddefconfig
    make -j8
    popd
}

setup_image() {
    echo "Preparing qemu image ..."
    killall -9 qemu-system-x86_64

    if [ ! -f "${qemu_image_src}" ] ; then
        wget ${qemu_image_url} -O ${qemu_image_src}
    fi

    cp ${qemu_image_src} ${qemu_image}

    echo "[Unit]
Description=User and Session Slice
Before=slices.target

[Slice]
CPUQuota=10%
AllowedCPUs=0
    " > user.slice

    yes | ssh-keygen -t ed25519 -f id_ed25519 -N ''

    # https://wiki.debian.org/ThomasChung/CloudImage
    virt-customize -a ${qemu_image} \
        --install ssh,${guest_pkgs} \
        --append-line "/root/.ssh/authorized_keys:$(cat id_ed25519.pub)" \
        --upload "user.slice:/etc/systemd/system/user.slice" \
        --chown "0:0:/etc/systemd/system/user.slice"
}

setup_kernel
setup_image

echo "Run test..."
ts=$(date --utc "+%FT%TZ")
out_dir=${wrk_dir}/out/${ts}
out_log_dir=${out_dir}/logs
mkdir -p ${out_dir} ${out_log_dir}
cp ${script_path} ${out_dir}
cp ${kernel_dir}/.config ${out_dir}/kernel.config
trap "exit" INT TERM
trap "kill 0" EXIT
export -f run_ssh
export wrk_dir

while true; do
        run_qemu &
        qemu_pid=$!
        sleep 10
        run_ssh 'stress-ng --cpu 1 --timeout 60' &
        for i in $(seq 1 10) ; do
            echo "running ssh $i"
            timeout 3 bash -c run_ssh #launch interactive ssh
        done
        run_ssh "systemctl poweroff"
        wait $qemu_pid

        serial_out_file=${out_log_dir}/serial-$(date "+%F-%T").log
	mv ${wrk_dir}/console.log ${serial_out_file}
	grep -e "Kernel panic" -e "Call Trace" -e "Kernel BUG" -e "cut here" ${serial_out_file} && \
            echo "${serial_out_file}" >> ${out_dir}/panics-warns
        grep -e "rcu.*detected.*stall" ${serial_out_file} && \
            echo "${serial_out_file}" >> ${out_dir}/rcu-stalls
done
---

[1]: https://lore.kernel.org/all/db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com/

Best regards,
Matteo Martelli



