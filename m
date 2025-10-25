Return-Path: <linux-kernel+bounces-870115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6695EC09F64
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616321AA14D1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F43081A0;
	Sat, 25 Oct 2025 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b32sJJ/i"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A112D3A6C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761421720; cv=none; b=ALMaBgDueRmLTfffeUib09ggwuRrAQUG6fT8MA8Uog9vt3E/swWTUXzwgIs7/3vxyJweDGupvWkmgq3mYipOu6s8+Gdy93iDfAxKE1jxuOho22GOzCfqttF1dkUQSz0Bpnqm5BroJz8cms4kBvrbM95kPKXqN91139HLA3bJ5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761421720; c=relaxed/simple;
	bh=eIu5VGf9Ux9Lz8A5nnc5d9uDui4YAb+7z8Ix4TYxvxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqHWrEcpJRF/7i0xQDPWcobSsEHehLUeKsAf3rL637KZHjCOlxvUICD5wy5i5uc57P0oHj7l6e53IdG6ezjgw41eT2kW/vzylxYIE5+Hw/7nUph2vwpXQdL5s1l4wy3atXH8xRrnomaQAPdbBuDVWgG937aUgt00X5g+LR8XdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b32sJJ/i; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89e81dff0d1so177451385a.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761421715; x=1762026515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=slZzEvvYHI2HJSgq4+doS7m33ZiiEaOUaqEnAONTo2s=;
        b=b32sJJ/ifl+JMRG7gXWYBSSui9clizvQ4aFt0CiTco8H1Eo6Rj1zNv6vHIPa8aGnC7
         kkJ+M3yK0NSa6vUYyzoVF4IOM4sWiOVK3XO5m9Wim4BeKFYQ4iC8IFhSKLaG4onxHplb
         qzmYE1Z/LwAwWtMpLtnqCSQ8+H4oTDhnnGd8FrVFEjyPMpDlTU+edVO+Usa+xMWCNsXH
         89LzycljBWPhwQC//Z7mcEor0PCg4/IzukGwk7ehMJg83ywlWWFBOP8V+Mdht6OxIP/k
         3ao5N2tD9fz0n/aS6VaRGVQeXJLxT4Ga9glf5xTsSyfweYNZ+YF2QTp+/DNbNwVoKPq8
         b84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761421715; x=1762026515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slZzEvvYHI2HJSgq4+doS7m33ZiiEaOUaqEnAONTo2s=;
        b=Zi8Zhs6zI0IOCAz9R83RkvRkBlHnTS22OjQPy4GctKxHIIn1kY+69oCc7OqUwQG4Ba
         nBPfS4qw0Sv2XCy+fJqJ7r/YlX0ZMuP68dDd+NUhPi/OEhg28k+hPyV54zaBqyqcfcVP
         Yaoc6Fj72QCWVkUgWuyALF/Ne9aX+RsM3PVx+bB1zjAFWm7cktQ4y8lqYjzjOCzdvQ0V
         PcdXYDcSgboMZVMOENUZ+OCih3YH4ETMu+Q4Xk2Z2SiMmysosypUnsNRqWhx0M/06wxL
         7kJhE8W0WCEM3i6g4h9tBpRJM+3o7VS5cSwahZXxX5klMIdQsDhdS13hoTc2bAxq/Dbw
         Vyaw==
X-Forwarded-Encrypted: i=1; AJvYcCVC0FLw/MZarU2DXKiMeNpUwjthWO9SZM1M2VlLjFo8AgxJ6Q+wvWuJU8JGBK1iNsUsFj4mARLmm1ZLJ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOtrR0aLIw4LT4eYtF28FmEG5je6TJCbdsrnn0/eTH4tQS/Yn
	WAUjjnkgPP6K3NfUFgN8S6oZDRX9spvMu02/ziQ/DMlpSaRYpHast7MWeA8tq4EmhQs=
X-Gm-Gg: ASbGncu4xcfdffSIHRij/FvQrrK0GYENVufaXaTHUx7Q0BmvPsAVE4viHdj4qAJGqW7
	vIq2BlmxG9HNwsISiIFEfAosJ2QBYU8chfrRnJSxj3NwOlU7C4OIqiQNmszT57wbX/miZ4M13Ja
	+ghpUn6pKC36pBJgk8hnwFwuCTRnfJVfO+GfPJrcMdaykdYkBbYCvKaHwOyDZputBfO4r4Gz1O7
	TJhntbu35Sujl8dG3hayKPZflBWow6gsgvhiFkfazgRbkMBQqzOBcK2Yl/C/OmD+GiNruOIowF7
	RtmHnDuIY6L3DUm82FuNuvGTC+Vklaq/G4Hnb/M+RrlmrznzDvzrkUUiXkfQo4/oFHPG6enmuH1
	bahwkKscsUPnkuDGeJ8PpQYJZ0jh68uWfFx93EihpAtqYQJxfIELOG7iTC65jCsYMp3/ytnw2ZL
	jUdoGCE0F1okhTosLHK/EEjuC+2bd7C1IMjcN8JWihzNdsVBr5srp5XhRA+ZSah97GYX9V8g==
X-Google-Smtp-Source: AGHT+IGlUdkEI2GL5hEWUnvDQdH13n2ayn3tMJGadiPYyXtloG4hb6wJ3eJoYQps4bvf9kx3J43WRg==
X-Received: by 2002:a05:620a:394f:b0:892:4f6:7806 with SMTP id af79cd13be357-89c12543ab6mr1601880085a.60.1761421715401;
        Sat, 25 Oct 2025 12:48:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25896d52sm200581785a.38.2025.10.25.12.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:48:34 -0700 (PDT)
Date: Sat, 25 Oct 2025 15:48:32 -0400
From: Gregory Price <gourry@gourry.net>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: John Stultz <jstultz@google.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	Benjamin Copeland <ben.copeland@linaro.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <aP0pkFfHcl4gA2gj@gourry-fedora-PF4VCD3F>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com>
 <20230705162830.GC17440@redhat.com>
 <20230705215008.GD17440@redhat.com>
 <c4b9f02f-3f6a-74b4-4e0d-3da314f90aa8@linaro.org>
 <20230706102823.GO7636@redhat.com>
 <CANDhNCpxw1rLj-PkD-AihnkNoeTu2a7_xSM=c0qs9ugyZCgJeQ@mail.gmail.com>
 <20230808072835.GT7636@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808072835.GT7636@redhat.com>

On Tue, Aug 08, 2023 at 08:28:35AM +0100, Richard W.M. Jones wrote:
> > [   21.375453] Call Trace:
> > [   21.375453]  <TASK>
> > [   21.375453]  ? die+0x2d/0x80
> > [   21.375453]  ? exc_int3+0xf3/0x100
> > [   21.375453]  ? asm_exc_int3+0x35/0x40
> > [   21.375453]  ? hrtimer_start_range_ns+0x1ab/0x3d0
> > [   21.375453]  ? hrtimer_start_range_ns+0x1ab/0x3d0
--- >8
> 
> Yes, it should be fixed upstream.  You will need these two commits:
> 
> commit deba78709ae8ce103e2248413857747f804cd1ef
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Thu Jul 6 17:55:48 2023 +0100
> 
>     accel/tcg: Always lock pages before translation
> 

Apologies for reviving an ancient thread, but I believe there is another
corner case for this bug - and it's an extremely narrow race condition.

Running in QEMU pc-q35-9.2 - so w/ all the fixes from this thread.

We first noticed crashes in poke_int3_handler() stemming from stacks
that look like so:

    __kmalloc_noprof+0x7e
    __kmalloc_cache_noprof+0x34
    __kmalloc_node_noprof+0x98
    kmem_cache_alloc_lru_noprof+0x37
    kmem_cache_alloc_noprof+0x3d
    ... etc ...

Which lead us to static_branch code and subsequent this thread.

What we're seeing is QEMU/KVM are injecting the int3 exception with
the int3 IP address of the instruction following the 0xCC... and the
int3 has been removed.

   > address_of_int3 + 5

poke() code then Oops because it can't find the int3.

We can't find *why* the exception RIP has been incremented past the int3
instruction - nothing in the KVM or QEMU emulation code immediately
suggest an obvious bug.  


We spent a good amount of time inspecting the fixes in this thread,
as well as this thread:
https://lore.kernel.org/all/20220423021411.784383-6-seanjc@google.com/
And this thread:
https://lore.kernel.org/all/20250611113001.GC2273038@noisy.programming.kicks-ass.net/

We tried building a reproducer (guest_repro.c below) that simply
hammers on static_branch in the guest.  This did not work by itself.

We went off to test/validate other things:

1) our guests are not configured to VMExit on int3
   svm.vmcb.control.intercepts[prog["INTERCEPT_EXCEPTION"]] & (1 << 3)
   (u32)0

2) svm_inject_exception DOES inject int3's, and we're fairly certain
   this injection is what is causing the wrong RIP.

3) We attempted to get KVM/QEMU to emulate the int3's by executing
   other instructions prior to the int3 that we know would cause VMExits
   (cpuid, inb/outb), but this never caused a reproduction.

4) We finally traced the int3 injection to a VM exit for a nested page
   fault.  After the fault handling there's also an int3 reported in
   EXITINTINFO - this causes an int3 injection.

That lead me to think this might be the result of swap or numa
balancing causing a guest page to become unmapped in the host, where
the next instruction is an int3, which would cause a nested fault.

I wrote a script on the host to migrate a guest's memory to/from a
local/remote node, and finally got a reproduction (stack below).

KVM doesn't support emulating INT3 in protected mode, which means
that the emulated INT3 and subsequent issue must happen in QEMU...
and that is where I am stuck.

So ultimately, this bug looks a lot like the one discussed in this
thread:  An int3 from a static_branch is modified on one thread as
another thread tries to execute that int3 - except now we have a
Nested-Page-Fault that produces the subsequent race.

Any thoughts on where we might look in QEMU or KVM to make further
progress would be helpful - but I figured where we've gotten to might be
of interest to the folks who originally fixed this static_branch race.

I appreciate any cycles you might spare to help,
~Gregory

--- reproduction stack
 <TASK>
 ? __die+0x77/0xc0
 ? die+0x2b/0x50
 ? exc_int3+0x41/0x70
 ? asm_exc_int3+0x35/0x40
 ? cleanup_module+0x80/0x80 [sbint3]
 ? looper+0x29/0x80 [sbint3]
 ? looper+0x29/0x80 [sbint3]
 ? looper+0x1e/0x80 [sbint3]
 kthread+0xb1/0xe0
 ? __kthread_parkme+0x70/0x70
 ret_from_fork+0x30/0x40
 ? __kthread_parkme+0x70/0x70
 ret_from_fork_asm+0x11/0x20
 </TASK>

-------- guest_repro.c   (heavily truncated for brevity)

DEFINE_STATIC_KEY_FALSE(int3_branch_key); // initially disabled                                                                                   

/* 180 threads hammering on this */
static int looper(void *data)                                                                                                                     
{                                                                                                                                                 
    while (!kthread_should_stop()) {                                                                                                          
        schedule();                                
        /* nops produce 5-byte jump instr */
        if (static_branch_likely(&int3_branch_key))                                                                                  
            __asm__ volatile (".rept 40\n nop\n .endr\n");
        }
}
/* 1 thread hammering on this */
static int toggler(void *data)
{
    while (!kthread_should_stop()) {
        schedule();
        static_branch_enable(&int3_branch_key);
        static_branch_disable(&int3_branch_key);
    }
}


--- host_mover.c

/* 
 * basically this back and forth between node0<->node1
 * 1GB at a time for each chunk in /proc/<pid>/maps
 */
int ret = move_pages(qemu_pid, chunk_size, pages, nodes, status, 0);


