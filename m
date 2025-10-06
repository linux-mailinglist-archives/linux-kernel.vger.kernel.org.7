Return-Path: <linux-kernel+bounces-843432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F7BBF2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434EE1898945
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D2221FA0;
	Mon,  6 Oct 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtcKur9i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051119AD89
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781938; cv=none; b=GlbASgdxIuXWzojkgAy5b+rgdJg5U5g6uNtU6u9qneLW/VI1NrH7fiPmtoFvYSaruLqR93w+yzWilaqky2ep001tPSINMA0AFMAf4vqPzQWOcgxuiBNyITkiBEFRIgsz3LPvm3cJa0N03/jLWYgCDWuBFkBF5/4iXXx0SwhRb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781938; c=relaxed/simple;
	bh=5eQEIeNJ5EZYkPz01gAZjijISqu7bO+HYt1McJx8mUA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MK66VqRR5LUWBQTutJSAZ3/E/drOPQVI3zLaZL4Ac64xPJ9jhJjkLjJx6+84SdVp7Tmo3ZqbgX8KLI+faSkxSD+a1TWvp2MNwNq/DYLd45TQ15m0HONcYjtxvfD0bMqfPxbQlnWe4R2cXxg96rulZ6FbsWsdfoo7UZMe8tutfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtcKur9i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759781935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRDjOk2UJBNY8OM4uijGV6YLvmoMX0A5enzMiF12TZI=;
	b=AtcKur9ilgwSd9XJKCdARuQc6TkCezG3btHWhwv1O4xpnopdoByr4TuP9C+8OgKL++7HNh
	ZJe3izFbLOVxsIF8WB5RStV62YrlBVPepZwUVPurDTcUNKLOI4FK5H+5gNukQ717CbCYRP
	P2DovNWBx+8ukIbCXRrF1veVVyIzqug=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-YoQzrUW6NSKjrvUx4QaY1g-1; Mon, 06 Oct 2025 16:18:54 -0400
X-MC-Unique: YoQzrUW6NSKjrvUx4QaY1g-1
X-Mimecast-MFC-AGG-ID: YoQzrUW6NSKjrvUx4QaY1g_1759781934
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8635d47553dso955414985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781933; x=1760386733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRDjOk2UJBNY8OM4uijGV6YLvmoMX0A5enzMiF12TZI=;
        b=Ms40R1+TDve3rbxfu51qBNp7yaXgaeIzYO5Tj9a4zpBaZ0yPUFB10vOKtXam2GfpMc
         9mIB8VXZas6qT00l26MW54HY5hU+/GA4A6VMXuHo6yXhecHTOwBpNu3Pqn8NyVzVRW5s
         5eR0o27R8bRZIznQ26+1DOFfCQNuo+pf6KNKyys9CEQBSLu/6h2q6VZ8c9J74ncIt6eC
         lr24gTwFUA8ZaDla9wZQ+A7SDIM1HmBXmYlsCD2xlxrKy1I755+4MVqy6LM9ZAEy5XLS
         CcvhqqBXRMI8+81O5wzvMnkIxGUF0liGTYqZ42SIZeKLwYfrEdtum8IaNAUY8rfDZTIy
         yCGA==
X-Forwarded-Encrypted: i=1; AJvYcCXRjaMXVvUA66+JvH093ItNCQI6PuQgwoT9MsgGbKUgWpzF6hyo4rCGgu1wUyl68T3yoqEmeejlrcvW0DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsq1iSVaGdJqPMQLe+iNeD0/m7s7SnntkFZZhMnyOthCAoFl9A
	K4BzYPM8IANKhjMB+nFBIjp064/I66Kx4oX3z8Kfbl0pHM9REyOFRmwc7f/cTkruGY1l6t8BmQi
	0URHaOYIMxWGQBuKQuWf1hTIhyYyYwAl3E4cOXkDox/RJx6tw72Dt0UcH1nYfBCmrrw==
X-Gm-Gg: ASbGncsCFlukN0MyazMJoMxzQy0W7cKsdI74ymUlf1LwhlrmrNzLouhM3EBSC6qqDuw
	aojetF5muuEjOlLJpPXUWF5rGy8phujARgaL8bxIVFHMIjv7ZFo57456gIvhmEAdoosgVGDE99b
	yI4yyY4v+Hhvx0qqscmFa0PtR57B9HY3x0DyL6q03SjhodLq7jSTAOeaRG1c8tkmWZ5eKMGc5NO
	/WyH5t/czvye2RMLmJ0qFhsXA1ozFmQe0PE5xWuYEc1/36zHh0CGUKmqLIN8mufBRuzAt+Yxpxq
	vG9XbF0xSIt38BdmJb0/nZTKA4jkXHNQmP2aXX8nTc45gHq6nz4Ba4tqcz37xwt3yJxMCr1W760
	/TRf1YjlT24Au+X4W
X-Received: by 2002:a05:620a:1707:b0:84b:ebcf:56a3 with SMTP id af79cd13be357-87a34aa4516mr1588124785a.21.1759781932761;
        Mon, 06 Oct 2025 13:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1dgJjNLxpPDAd6SOq/4Amrbct/qwou5kIt8RniF4E527vSqzwcPOgDR30Aenfez80Nn+SaQ==
X-Received: by 2002:a05:620a:1707:b0:84b:ebcf:56a3 with SMTP id af79cd13be357-87a34aa4516mr1588121585a.21.1759781932301;
        Mon, 06 Oct 2025 13:18:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550b3sm1380084485a.26.2025.10.06.13.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:18:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0bfeee57-d0dd-4480-8539-0ae5d7d4ea04@redhat.com>
Date: Mon, 6 Oct 2025 16:18:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Account for lockdep hardirq context in
 irq_forced_thread_fn under PREEMPT_RT
To: Guangbo Cui <2407018371@qq.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 2:34 PM, Guangbo Cui wrote:
> In PREEMPT_RT, IRQs are forced to run in threaded. However, lockdep did not correctly
> account for this case, causing false-positive warnings about hardirq context violations
> when analyzing lock acquisition in such threaded IRQs (see function `task_wait_context`).
>
> This patch updates `irq_forced_thread_fn` to explicitly call `lockdep_hardirq_enter()`
> and `lockdep_hardirq_exit()` when PREEMPT_RT is enabled, ensuring lockdep correctly
> tracks the hardirq context even when the IRQ is executed in a forced thread.
>
> This was discovered while testing PCIe AER error injection on an arm64 QEMU virtual machine:
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

data->lock is a rt_spin_lock and pci_lock is a raw_spinlock_t with irq 
disabled. So the data->lock => pci_lock sequence is OK. However, 
inject_lock is a rt_spin_lock again. So you can't acquire it with a 
raw_spinlock held and interrupt disabled. It is something that needs to 
be fixed not worked around as if it is OK. It is not a false positive.

Cheers,
Longman


