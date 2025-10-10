Return-Path: <linux-kernel+bounces-847705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBFDBCB757
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C60A4F0BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775619C542;
	Fri, 10 Oct 2025 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3W2G2ot"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7761A0B15
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064748; cv=none; b=d5SBKDsuBkKrLASxja5GQO5sRSP/tDMhj38mggQpRw03UbzJg5xtXHSAYE+sj0b3vBL+PNsoTwvrX85SUGW2g+RrAPPhbgI+ij4WjDtv6d0ATyUyRF4ik9bXAykFJ13JZysdMFgIHqBk8U/Ob5pKlD57WXeR9eXqk8Pyp8z8yL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064748; c=relaxed/simple;
	bh=BtPGX0SCKTWOO/2pmFrKk9ubExIp15TCY8Ta2rehDnA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HgpH69YueyuqoA8yuaDZHG8gNqxm+66B8mvQBhfn42LQ4ee6LosEdnUwpLVJBQfmeOsNJHSjP7/bRXxn1gp9NahfaNYxTUeLYDcoaYyvYF2f3jnNltagPDpQuCVmwnM31fSyq7hLJLu3L85lMBxuL4eXhDPnWqb4/AfAsvtqtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3W2G2ot; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760064745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p77JZb+Mdci5/KEMJK1kpt1QjxLJZnP83075vW8bdvw=;
	b=h3W2G2otOek2e79fsAMahCn4y5ymGHc7LM0BK/DQXBwaUg3fFQo9WT0lAuIL9XQyXoPc8N
	EDcJeSK4U/DnYaLvdNY4jdtmo4cKoQFgByYxxJKJtG1DCnDSk+R4fQ82SR0DeIhYFioBle
	9PjSm2+4uVy/JGhfQPKcZ7oQneltX30=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-o31lBna-MnGLP0OSVA3xUA-1; Thu, 09 Oct 2025 22:52:24 -0400
X-MC-Unique: o31lBna-MnGLP0OSVA3xUA-1
X-Mimecast-MFC-AGG-ID: o31lBna-MnGLP0OSVA3xUA_1760064743
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79e48b76f68so73323176d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 19:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760064743; x=1760669543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p77JZb+Mdci5/KEMJK1kpt1QjxLJZnP83075vW8bdvw=;
        b=D3VPFs7TowzvrPG9051l1/ORoaQrcs3u4x696Lv0rBrgsDrv/9QTp57iQQ7e2FCBnJ
         ChL0gW4s+bzxMWknAyZyCbKbit9AAp6iquYPvNfDCKbHvrkn2+7nNYue51JFDcU2CHYu
         fDsrtK8P90eQsn0bBV1DU2fSw+5rRfNAwUYwCF/fRJ87O36N13P/2u5u/e/BPkCAtST9
         urPz/gT48pjVL/66K9vogUWER1SFcmZNfZIScLaeOLAv3KPhphuve8R94vf0SB4t2MO4
         gFZzSCTQONkVdc8gJ8sIG6RhKHG2VGxxpvQpu9sC5b+4e6eUEDaD7c3hK8f7MielQx9c
         RORw==
X-Forwarded-Encrypted: i=1; AJvYcCUChavcSQAOyVkULVolHR2xH20+NmTQUQPE7ontcnA/t/pGwJPLvWecpWTdDznYDv/0Klu2m4R6UFQl7Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlCKKNwEbh1ybRlt9yuNwRGXeT2VUuNP2U4VVkoSNkVeGEyBd
	92nmZuusq0CwBLCpG0Q5Q0dFeAWhspf+aRUCTH0xw3Al22K7FU+5ZQcm76xqwG6EnXr1zO0WPV4
	DBONV8ISTHSQeJdoaNJ/nv8gzpQIPp7mAUvFkBDu+2h2qkuu6561L3negiuNk+uQkpQ==
X-Gm-Gg: ASbGncvS9FW0pNlHJy+PPgEOsOD1hbAB/bPesVmBdNuSfJVG3HJZsrcUBUMurLrCrwZ
	XtvWI7AWkIuBwPcsQDP76jB43oCRlGLG9x6Jt6REKECYp6JmPUtqb1SpblhV9s0JEktMY2ReF84
	fRcha2z3i0ckDGP3QDkRGxA73QzE6UDHYRgE0Bh/UBZsHBqLEVWwEFHGWyBTreJyl+ncUfE33WB
	/20Gsji4Z+5DCqXFRjysS3D9kigu7ToUgAwxSne21H1oiMQ/g3x2zNPuGn54ojQZw71JQVfea43
	gtvtsctgx/UIWEAU/O9OT+otp9T/oPs94REXh0ivERPj+80A04wAEUFWmotZwg6IXKvrrueLCLn
	Xk7xTcy1QIMY=
X-Received: by 2002:ad4:594b:0:b0:873:f6bc:abb8 with SMTP id 6a1803df08f44-87b2101d5d4mr127529116d6.15.1760064743565;
        Thu, 09 Oct 2025 19:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0lkCcjXQD1DjvauUfSkRJqcrLhOc8z33VBbhKdHXGR8krbUUptEp7lztjXHaRk4Wn9gpyaw==
X-Received: by 2002:ad4:594b:0:b0:873:f6bc:abb8 with SMTP id 6a1803df08f44-87b2101d5d4mr127528846d6.15.1760064743131;
        Thu, 09 Oct 2025 19:52:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345da68sm7842246d6.13.2025.10.09.19.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 19:52:22 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3c20a451-ebc6-4057-be77-2caaf6d2317c@redhat.com>
Date: Thu, 9 Oct 2025 22:52:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to
 raw_spinlock_t
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
Content-Language: en-US
In-Reply-To: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/25 11:06 AM, Guangbo Cui wrote:
> When injecting AER errors under PREEMPT_RT, the kernel may trigger a
> lockdep warning about an invalid wait context:
>
> ```
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> ```
>
> This happens because the AER injection path (`aer_inj_read_config()`)
> is called in the context of the PCIe PME interrupt thread, which runs
> through `irq_forced_thread_fn()` under PREEMPT_RT. In this context,
> `pci_lock` (a raw_spinlock_t) is held with interrupts disabled
> (`spin_lock_irqsave()`), and then `aer_inj_read_config()` tries to
> acquire `inject_lock`, which is a `rt_spin_lock`. (Thanks Waiman Long)
>
> `rt_spin_lock` may sleep, so acquiring it while holding a raw spinlock
> with IRQs disabled violates the lock ordering rules. This leads to
> the “Invalid wait context” lockdep warning.
>
> In other words, the lock order looks like this:
>
> ```
>    raw_spin_lock_irqsave(&pci_lock);
>        ↓
>    rt_spin_lock(&inject_lock);   <-- not allowed
> ```
>
> To fix this, convert `inject_lock` from an `rt_spin_lock` to a
> `raw_spinlock_t`, a raw spinlock is safe and consistent with the
> surrounding locking scheme.
>
> This resolves the lockdep “Invalid wait context” warning observed when
> injecting correctable AER errors through `/dev/aer_inject` on PREEMPT_RT.
>
> This was discovered while testing PCIe AER error injection on an arm64
> QEMU virtual machine:
>
> ```
>    qemu-system-aarch64 \
>        -nographic \
>        -machine virt,highmem=off,gic-version=3 \
>        -cpu cortex-a72 \
>        -kernel arch/arm64/boot/Image \
>        -initrd initramfs.cpio.gz \
>        -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc earlyprintk nokaslr" \
>        -m 2G \
>        -smp 1 \
>        -netdev user,id=net0,hostfwd=tcp::2223-:22 \
>        -device virtio-net-pci,netdev=net0 \
>        -device pcie-root-port,id=rp0,chassis=1,slot=0x0 \
>        -device pci-testdev -s -S
> ```
>
> Injecting a correctable PCIe error via /dev/aer_inject caused a BUG
> report with "Invalid wait context" in the irq/PCIe thread.
>
> ```
> ~ # export HEX="00020000000000000100000000000000000000000000000000000000"
> ~ # echo -n "$HEX" | xxd -r -p | tee /dev/aer_inject >/dev/null
> [ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
> [ 1850.949951]
> [ 1850.950479] =============================
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> [ 1850.955932] stack backtrace:
> [ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
> [ 1850.957039] Hardware name: linux,dummy-virt (DT)
> [ 1850.957409] Call trace:
> [ 1850.957727]  show_stack+0x18/0x24 (C)
> [ 1850.958089]  dump_stack_lvl+0x40/0xbc
> [ 1850.958339]  dump_stack+0x18/0x24
> [ 1850.958586]  __lock_acquire+0xa84/0x3008
> [ 1850.958907]  lock_acquire+0x128/0x2a8
> [ 1850.959171]  rt_spin_lock+0x50/0x1b8
> [ 1850.959476]  aer_inj_read_config+0x38/0x1dc
> [ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
> [ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
> [ 1850.960454]  pcie_pme_irq+0x44/0xc4
> [ 1850.960728]  irq_forced_thread_fn+0x30/0x94
> [ 1850.960984]  irq_thread+0x1ac/0x3a4
> [ 1850.961308]  kthread+0x1b4/0x208
> [ 1850.961557]  ret_from_fork+0x10/0x20
> [ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message received from 0000:00:02.0
> [ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> [ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/mask=00000001/0000e000
> [ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (First)
> ```
>
> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> ---
> Changes in v2:
> - Pulling kfree() out from the lock critical section. (Thanks Waiman Long)
> - Link to v1: https://lore.kernel.org/linux-pci/20251007060218.57222-1-jckeep.cuiguangbo@gmail.com/

As PCI error injection is mainly for debug/development, I think it is OK 
to change inject_lock to a raw_spinlock. I think you should also mention 
about moving kfree() out of the lock critical section in the commit log. 
Or better yet, break it out as a separate patch. It is just a nit. So I 
am fine with the current version too.

Now it is up to the PCI maintainer to decide if further change is needed.

Acked-by: Waiman Long <longman@redhat.com>


