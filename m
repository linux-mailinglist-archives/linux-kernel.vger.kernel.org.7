Return-Path: <linux-kernel+bounces-749491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF15B14F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D1E3A6898
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EBC1C5F2C;
	Tue, 29 Jul 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmA0IHYh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AE1A23BE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797987; cv=none; b=LdWte51ZVKu1haN/cM3tXTWP1rKrtqKvGxJ9jsfY5wIzGUwfrerzwO61bZqDWZ7aKng4L1cVc+unvaHtINYNxeyysvnvl4373a3aNLCtjmpwsvigu4NiDP55IQALROTUvKXrcHS7rTO9wIeYsZ0ymgStNLiyIhvEcquB1DRR9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797987; c=relaxed/simple;
	bh=jQNcNjSHp+aBVrss+/aGKhx2UBYDpdHMmKhxP5/LN78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PL3gvuU4969bWkszKrMp0QLAUq5zW+yjizuHi1jtvimgZguzST3mkbxZaLgVF35WFPzoCk4qOxl9hJewP5go4adbgCFOyN/pqWw9CbaqYJyKR/N1fICn9TZoBuZa4YUqrsTelEqENBuGpLVX6YOrmgUXFHbddgDM5gxk+GsoVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmA0IHYh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753797984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QIgYf2vsWqDkDVYt9P3cGO1QNBX3mGMfTpUEie2O+uk=;
	b=DmA0IHYh0ukny4303mijQwSJMP6v514tm8lIVs+5k3+3jBMvfvEGPwpQsTCFcIKXmh4zTk
	JabrBiA7/m1DHCSr7+oyErpZUa6YDsOJ3BNmKg8qAbY6Q8yeWmwfEbVh9KOfEvvGqpPm1D
	GoNuClvEsYzqJBpUwFH2AVVCZ+4+1gE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-4VH2odnEOGuPcV1812VikQ-1; Tue, 29 Jul 2025 10:06:23 -0400
X-MC-Unique: 4VH2odnEOGuPcV1812VikQ-1
X-Mimecast-MFC-AGG-ID: 4VH2odnEOGuPcV1812VikQ_1753797981
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so35130195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797981; x=1754402781;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIgYf2vsWqDkDVYt9P3cGO1QNBX3mGMfTpUEie2O+uk=;
        b=KTe7JwfwK3JJQF/oiE5FySQVqzFT4EYsklap9WtYsdAbjBqVMdJlyGVC8IClm6RQwH
         uP3sgEKa+aAfy0i/IFQyU5W79tDaQTQbl7yRzF1y9RWdMuXnpLYKMs1QNZxoGvH4atAb
         kRy8z9aX5uAZ3wZZ95VAqpx9cZfYssHyswuZ8utF9zaVBuEDohXsik33mGf4i5nqTI0n
         ZhExujJzWHK7QmH2bc6x0thNnGu8oD/9y31BmqtOhlsrt9cetg9E1XdzfLEUradEGSpM
         kfZwdKD+qUIR7U56kbAyy/lyA1eGxnazPW+Kg0fNhk3leH/yyYiA9l8J5sRL8lzRnrUW
         pbVQ==
X-Gm-Message-State: AOJu0YyiA2iHvhsye3xbdLZlZXTGiqy1dcAnkhbdfEjkhml6WLcAIyZd
	ORTDYc1jUjag5mN5Sw0nFJSilBSK7Jc8zZ7NWFTH6ETz91ndoMkrCOgTwhQfPHXkwv0iQDcd0/6
	VESlRXrLUPQvB8+H59lsTFc2uMA+1q7OlShCsFkY3x/u9/tUYVTTTfR7REY35+/LhS0rn8UZX1u
	Db
X-Gm-Gg: ASbGncs9VuQdScw99H9DEXdQhSx/R2DIhby76eXb446hhNu/fOh6nZX327AxjWpMKGt
	9EUC7KdR6utYGTzANoReFNtzF4YZIpHvIFeN2FGwxn/Dm1dfIxGNNj6lxHylYYrSiAB2CzllLQ+
	7EE1iHEXWJ4s/86o5DpOlSifu14AXUHigomOTg8DHZobKKWGBHLC6SJG82318xPBxDrX0+NIAP+
	OYWwY1sSmxEtvaY98418gN1baoLF8BqKm+JsgvO7nVSPGKq7gSFvfPjCIktcDPepxkKe2E/xbPs
	5REwZIouVAoadwzxcIgHXmMkE0rnCfKW3hnh1GbieT5y4rDIJcPBVEfq6FGjF+H8sKEQ
X-Received: by 2002:a05:600c:6487:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-4587d857d16mr109316995e9.4.1753797980674;
        Tue, 29 Jul 2025 07:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxjXdEX/Zvad6HpbTya9ftqyz9bUQ8OagmI57aY0kUZL/2O6fcgIidQtrxq/dI7VwXkCwFhQ==
X-Received: by 2002:a05:600c:6487:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-4587d857d16mr109316195e9.4.1753797980068;
        Tue, 29 Jul 2025 07:06:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5df43fsm27300635e9.28.2025.07.29.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:06:19 -0700 (PDT)
Message-ID: <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 29 Jul 2025 16:06:17 +0200
In-Reply-To: <20250729093717.3AqIu_f0@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
	 <20250728135022.255578-8-gmonaco@redhat.com>
	 <20250728155332.sbkepHj7@linutronix.de>
	 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
	 <20250729092510._Hq3RWF_@linutronix.de>
	 <20250729093717.3AqIu_f0@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-29 at 11:37 +0200, Nam Cao wrote:
> On Tue, Jul 29, 2025 at 11:25:12AM +0200, Nam Cao wrote:
> > Kernel:
> > =C2=A0 - base: ftrace/for-next

I assume you mean rv/for-next ? The one that includes all changes as of
yesterday.

> > =C2=A0 - config: defconfig + mod2noconfig + PREEMPT_RT + monitors
> >=20
> > Hardware:
> > 	qemu-system-riscv64 -machine virt \
> > 	-kernel ../linux/arch/riscv/boot/Image \
> > 	-append "console=3DttyS0 root=3D/dev/vda rw" \
> > 	-nographic \
> > 	-drive if=3Dvirtio,format=3Draw,file=3Driscv64.img \
> > 	-smp 4 -m 4G
> >=20
> > 	riscv64.img is a Debian trixie image from debootstrap
> >=20
> > Test:
> > 	echo 0 > /proc/sys/debug/exception-trace
> > 	./testall # see attached
>=20
> I should note that this takes a few tries before something shows up.
>=20

Thanks for all the details, but I still can't reproduce nor understand
what can be triggering the issue.

I tried enabling sts and setting panic as the reactor (to avoid missing
it with all the rubbish that gets printed on the dmesg) and run
testall. Still cannot see the error.

What might help would be to see the trace with irq_enable and
irq_disable around the error, something like (not tested):

  trace-cmd stream -e irq_enable -e irq_disable -e error_sts -e
irq_handler_entry -- sh testall | grep -B 10 error

The problem here is not when the error occurs, but a couple of events
earlier (where I possibly miss something that looks like an interrupt).

Thanks,
Gabriele

> Below is the backtrace, in case it helps:
>=20
> illegal=C2=A0=C2=A0=C2=A0 3246 [000]=C2=A0 1020.132675: rv:error_sts: eve=
nt sched_switch
> not expected in the state enable_to_exit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8013231c __traceiter_e=
rror_sts+0x28
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8013231c __traceiter_e=
rror_sts+0x28
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80138aa4 da_event_sts+=
0x198 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80138cf0 handle_sched_=
switch+0x46 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aaf222 __schedule+0x=
4ba ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aafb80 preempt_sched=
ule_irq+0x32
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aac714 irqentry_exit=
+0x76 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aac1dc do_irq+0x38 (=
[kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80ab7da6 __lock_text_e=
nd+0x12e ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80a93e50 mas_find+0x0 =
([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8021ea60 vms_clear_pte=
s+0xe8 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8021f81a vms_complete_=
munmap_vmas+0x58
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80220706 do_vmi_align_=
munmap+0x15c
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802207d0 do_vmi_munmap=
+0xa6 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80221f3c __vm_munmap+0=
xa2 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8020be7c vm_munmap+0xe=
 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802bbdbe elf_load+0x14=
c ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802bc1f4 load_elf_bina=
ry+0x36e ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80264426 bprm_execve+0=
x254 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8026570c do_execveat_c=
ommon.isra.0+0x11e
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802664de __riscv_sys_e=
xecve+0x32 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aabf84 do_trap_ecall=
_u+0x1bc ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80ab7dc8 __lock_text_e=
nd+0x150 ([kernel.kallsyms])


