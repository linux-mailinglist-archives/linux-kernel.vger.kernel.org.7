Return-Path: <linux-kernel+bounces-648250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BFAB7421
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22257A6B97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B827CB2A;
	Wed, 14 May 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1e9WSNG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFE1F0E50
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246425; cv=none; b=oYJA1JixhvezyfYdX7jGqhn4wDJvai74TghjkCK78H6URqA1zo6K1fnqRJ4bbOU649IBUR7H2YDqTkqOao7gNTIH0mrEOKCNS4KVJmDeXzUQpaWRjHpWpV1R45LWMxRqjBLyh7CrzTeSA0ZBcFg1Ryqmu18/JIe7yckTe2uu6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246425; c=relaxed/simple;
	bh=JvcXPcQhniFr1R5lY6+Xgsb6urQp3RJfetMTTolaShM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikUrf7yJxmzMhB/EbdPGhYaW3hRIemYpKQZyBKcB31Clv3GCZ0ytESWQ/KmQqt8Kkdx2uRuoVTWr3u+I2WImeFZXvM30CG7P6iDHuWhXyM9nmnOx4/bOcTq9538MROfvMq/6cInpDvPyvRVUkxhs8W4d/KkHOC53LYwawwhRvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1e9WSNG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so9884195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747246422; x=1747851222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+B8s8wOZcQIedBiHD/XZ4OoWoxkT58SsoJWO7KKQ5g0=;
        b=n1e9WSNGzf3nDiVYKMZYLofP6zibPVURFWrCD1GOS3QVAzStY+i9/7z0f3Q/qbgbFT
         PAmYUyrDmlZOZjkiYQ6+l4hEhnvFJ3qrgacn2sy1ystAZ4ab6WrTDSpUsILv7i7eeQ4V
         T/zeuINlLaqxiGoqFB2O8ccT1IwuN9px2xsEBAMfCRiPJqsGIM5Km6T7DvjwK43UtljT
         bUVPrep68wY9obWRgSNt3YAE/jPL0IE3YeqPWqFSKvkgYGy61d7AILaTq5Zv/3f0rI64
         KRxNxJ0MQ5ibKPSLm++9QVKF/NcMOh8rCd5qM3w0m5eTwu9IWiBYxi7Wv+mrVDPvcyhj
         z0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747246422; x=1747851222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+B8s8wOZcQIedBiHD/XZ4OoWoxkT58SsoJWO7KKQ5g0=;
        b=IRqRZJyyXbzr5v6HxAJ0kgbvqbEG8KNffCkDKTxkKgpBeehB5lgkN6wbusUvmzK6LG
         8AsL/mfL3vyq9ikGVrWjx5DgZwPpynMxhnvvusTM6bqdbc9cz98OcqSNDpXYbLVkhD4B
         4OO7Ju7AmkQyJeTGX0RyQB5gzXnTfSYqjMsmRTq5R4bZo2wHlYUsx9lyqABBorpV7u8/
         A41QvUnoYJNLADZn2L4pSApiPjjxRBgwTecBudvpCg4KpSKVOJMk9hPUNDeRPiyTLc5L
         fS0+RxwDVp46oTlBwQdyjLW4Ujs29IGQO+LYYSDzEDTIUGnKGQL9aVAeu95on8F7urzU
         t2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzHvg/7WRDwjTi00HweSJQjb57O5Jceo0G/9bypXce+9hRnKyIUZiwU4BgSM1rn6Kx2fUAGryle7GxK9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMggYlRoy4iN/J6p5Zq+DUtDM8F2le5hgNF181cdE04vfPXPcZ
	nrpd5qwG5XKtq5WCCqFXsD4sXlP5ajg0L8OBe6avg0ycM9ZjfEuocwyJYef9qw==
X-Gm-Gg: ASbGncsYhFHI90JekZgEyGtlPd54vWWoqQqddGNi0QxlHn9ebPO48Z11aHyXJqSF5Ah
	87nRhkCZeh69fSlEzARDRWwX6WPg8dDP4SbOx9qssC+xE81pRg7pYBCnhAQL4v8sXlQ5w7lomEZ
	qSISwVkMfZxCvaPJoM67hnItVH710dr/Tw+ASbogyZH9zp97nfS1Efn/lxXaGf2xABx6TJhvoYz
	03w39bW629Qyf0481nOEPFUgK1JReK4VCHsyHIaDh0jwzf+HzblffV8mJaHKZnpQKu+8tqIaggH
	3QBFq2Uu2V5RFC0CknBj/a0qCzK3JwEa2Tuv3Sb25IpS7nCcSqy4vU6sXRa6n1hWYMFKrjO1N3z
	QUJmtCqmRTsH/gGGT
X-Google-Smtp-Source: AGHT+IFvClXcCFxtSP5/BJ1lEGzPWMtAqCzL3KhR0NmFK8QG8YRN7XnOJzzYM6av7qHYsTG1Y8cp+Q==
X-Received: by 2002:adf:fcc6:0:b0:3a0:9f24:774c with SMTP id ffacd0b85a97d-3a3511e0b62mr327856f8f.13.1747246421736;
        Wed, 14 May 2025 11:13:41 -0700 (PDT)
Received: from google.com (218.131.22.34.bc.googleusercontent.com. [34.22.131.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf38sm20323930f8f.77.2025.05.14.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 11:13:41 -0700 (PDT)
Date: Wed, 14 May 2025 19:13:37 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/24] Tracefs support for pKVM
Message-ID: <aCTdUQRPjyhpYnmh@google.com>
References: <20250506164820.515876-1-vdonnefort@google.com>
 <20250514133815.78bc2599@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514133815.78bc2599@gandalf.local.home>

On Wed, May 14, 2025 at 01:38:15PM -0400, Steven Rostedt wrote:
> On Tue,  6 May 2025 17:47:56 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > The growing set of features supported by the hypervisor in protected
> > mode necessitates debugging and profiling tools. Tracefs is the
> > ideal candidate for this task:
> > 
> >   * It is simple to use and to script.
> > 
> >   * It is supported by various tools, from the trace-cmd CLI to the
> >     Android web-based perfetto.
> > 
> >   * The ring-buffer, where are stored trace events consists of linked
> >     pages, making it an ideal structure for sharing between kernel and
> >     hypervisor.
> > 
> > This series first introduces a new generic way of creating remote events and
> > remote buffers. Then it adds support to the pKVM hypervisor.
> > 
> > 1. ring-buffer
> > --------------
> > 
> > To setup the per-cpu ring-buffers, a new interface is created:
> > 
> >   ring_buffer_remote:	Describes what the kernel needs to know about the
> > 			remote writer, that is, the set of pages forming the
> > 			ring-buffer and a callback for the reader/head
> > 			swapping (enables consuming read)
> > 
> >   ring_buffer_remote():	Creates a read-only ring-buffer from a
> > 			ring_buffer_remote.
> > 
> > To keep the internals of `struct ring_buffer` in sync with the remote,
> > the meta-page is used. It was originally introduced to enable user-space
> > mapping of the ring-buffer [1]. In this case, the kernel is not the
> > producer anymore but the reader. The function to read that meta-page is:
> > 
> >   ring_buffer_poll_remote():
> > 			Update `struct ring_buffer` based on the remote
> > 			meta-page. Wake-up readers if necessary.
> > 
> > The kernel has to poll the meta-page to be notified of newly written
> > events.
> > 
> > 2. Tracefs
> > ----------
> > 
> > This series introduce a new trace_remote that does the link between
> > tracefs and the remote ring-buffer.
> > 
> > The interface is found in the remotes/ directory at the root of the
> > tracefs mount point. Each remote is like an instance and you'll find
> > there a subset of the regular Tracefs user-space interface:
> > 
> >   remotes/test/
> >      buffer_size_kb
> >      trace_clock
> >      trace_pipe
> >      trace
> >      per_cpu/
> >              cpuX/
> >                  trace
> >                  trace_pipe
> >      events/
> > 
> >             test/
> >                 selftest/
> >                           enable
> >                           id
> > 
> > Behind the scenes, kernel/trace/trace_remote.c creates this tracefs
> > hierarchy without relying on kernel/trace/trace.c. This is due to
> > fundamental differences:
> > 
> >   * Remote tracing doesn't support trace_array's system-specific
> >     features (snapshots, tracers, etc.).
> > 
> >   * Logged event formats differ (e.g., no PID for remote events).
> > 
> >   * Buffer operations require specific remote interactions.
> > 
> > 3. Simple Ring-Buffer
> > ---------------------
> > 
> > As the current ring-buffer.c implementation has too many dependencies to
> > be used directly by the pKVM hypervisor. A new simple implementation is
> > created and can be found in kernel/trace/simple-ring-buffer.c.
> > 
> > This implementation is write-only and is used by both the pKVM
> > hypervisor and a trace_remote test module.
> > 
> > 4. Events
> > ---------
> > 
> > A new REMOTE_EVENT() macro is added to simplify the creation of events
> > on the kernel side. As remote tracing buffer are read only, only the
> > event structure and a way of printing must be declared. The prototype of
> > the macro is very similar to the well-known TRACE_EVENT()
> > 
> >  REMOTE_EVENT(my_event, id,
> >      RE_STRUCT(
> >          re_field(u64, foobar)
> >      ),
> >      RE_PRINTK("foobar=%lld", __entry->foobar)
> >      )
> >   )
> > 
> > 5. pKVM
> > -------
> > 
> > The pKVM support simply creates a "hypervisor" trace_remote on the
> > kernel side and inherits from simple-ring-buffer.c on the hypervisor
> > side.
> > 
> > A new event macro is created HYP_EVENT() that is under the hood re-using
> > REMOTE_EVENT() (defined in the previous paragaph) as well as generate
> > hypervisor specific struct and trace_<event>() functions.
> > 
> > 5. Limitations:
> > ---------------
> > 
> > Non-consuming reading of the buffer isn't supported (i.e. cat trace ->
> > -EPERM) due to current the lack of support in the ring-buffer meta-page.
> > 
> > [1] https://tracingsummit.org/ts/2022/hypervisortracing/
> > [2] https://lore.kernel.org/all/20240510140435.3550353-1-vdonnefort@google.com/
> > 
> 
> BTW,  I tried to build this series and it fails.


Yes, appologies, I've started applying your comments today and I've figured out
I haven't tried building for x86.

I already have fixes locally for what's below.

I probably can send a v5 this week if you wish, unless you prefer to wait a bit
more for more comments?

> 
>   CALL    /work/git/test-linux.git/scripts/checksyscalls.sh
>   CC      kernel/trace/simple_ring_buffer.o
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from /work/git/test-linux.git/include/linux/compiler.h:390,
>                  from /work/git/test-linux.git/arch/x86/include/asm/atomic.h:5,
>                  from /work/git/test-linux.git/include/linux/atomic.h:7,
>                  from /work/git/test-linux.git/kernel/trace/simple_ring_buffer.c:7:
> /work/git/test-linux.git/kernel/trace/simple_ring_buffer.c: In function ‘simple_rb_move_tail’:
> /work/git/test-linux.git/include/asm-generic/rwonce.h:55:37: error: assignment to ‘struct list_head *’ from ‘long unsigned int’ makes pointer from integer without a cast [-Wint-conversion]
>    55 |         *(volatile typeof(x) *)&(x) = (val);                            \
>       |                                     ^
> /work/git/test-linux.git/include/asm-generic/rwonce.h:61:9: note: in expansion of macro ‘__WRITE_ONCE’
>    61 |         __WRITE_ONCE(x, val);                                           \
>       |         ^~~~~~~~~~~~
> /work/git/test-linux.git/arch/x86/include/asm/barrier.h:63:9: note: in expansion of macro ‘WRITE_ONCE’
>    63 |         WRITE_ONCE(*p, v);                                              \
>       |         ^~~~~~~~~~
> /work/git/test-linux.git/include/asm-generic/barrier.h:172:55: note: in expansion of macro ‘__smp_store_release’
>   172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
>       |                                                       ^~~~~~~~~~~~~~~~~~~
> /work/git/test-linux.git/kernel/trace/simple_ring_buffer.c:129:17: note: in expansion of macro ‘smp_store_release’
>   129 |                 smp_store_release(&new_tail->list.next,
>       |                 ^~~~~~~~~~~~~~~~~
> make[5]: *** [/work/git/test-linux.git/scripts/Makefile.build:203: kernel/trace/simple_ring_buffer.o] Error 1
> make[4]: *** [/work/git/test-linux.git/scripts/Makefile.build:461: kernel/trace] Error 2
> make[3]: *** [/work/git/test-linux.git/scripts/Makefile.build:461: kernel] Error 2
> make[2]: *** [/work/git/test-linux.git/Makefile:2004: .] Error 2
> make[1]: *** [/work/git/test-linux.git/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/work/build/trace/nobackup/debiantesting-x86-64'
> 
> Even when I fixed this, it then failed with the building of the sample module.
> 
> I think you need something like:
> 
> obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test_mod.o
> 
> remote_test_mod-y := simple_ring_buffer.o remote_test.o trace_remote.o
> 
> If the module needs more than one object file. Then the module should be
> called something that doesn't have a .c file and use that name with ".o" to
> add all the objects.
> 
> I think this could work, but this still had issues with functions not exported.
> 
> -- Steve

