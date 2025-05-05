Return-Path: <linux-kernel+bounces-632474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6FAA97C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507EB189AFB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBA25FA2E;
	Mon,  5 May 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrifYXdT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077F25A337
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459932; cv=none; b=cpCt9vEFPPXzsXGnKnaSrzzfHFu7PZ74abYMXWO+BMY2qdCX/ZFfeftYvw2T0T9R3/p3qcXMnBvUM8hvy3SXGVlYKGUkrEZ5Z2VyzQ/dpftcwjF5bh0e+vTphRFpqatT+W4JhJUEszg3gE0Gjc2Lpx3P62y8Htqh8/NST/57zH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459932; c=relaxed/simple;
	bh=fT63Qjgxn2mmOj4nEoT8zNbpR7UCW8tfN5uQH3dFpw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DUMH2F9qvUSGQIsP9U0lEch6vno4hp/er2WAVMxTjsict5UzKxZCTf/qoE48iLyjTkRaF6/Nhj+NLZ8zd4+dbmhDdQZa41vU7vqx3Ez+hTEXOGmw7Y2FFx5NUuCDg3yISNFccNn2K2Cy+Ckz4G2DXUutFhqTbWmSxYm9uV3Cob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrifYXdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746459930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fT63Qjgxn2mmOj4nEoT8zNbpR7UCW8tfN5uQH3dFpw4=;
	b=IrifYXdTNMeJIHHKEFQUP5Xya0qimuKmSqJjQQQr0qrFCSW5XVMlCrJL3Q8cglTPJv/uKI
	IrIRP8o63MFPCW5hiY5yQ7o/xcFDaUtp87Zx4I6ZNKEQSnQXrRYujq5OaXJ7NcKq/qChQ0
	ooZW0m7c3aJ+p6ZbU3pjl1YUhfQ42c0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-7laUOaV4N-mnMGFlaqmodQ-1; Mon, 05 May 2025 11:45:25 -0400
X-MC-Unique: 7laUOaV4N-mnMGFlaqmodQ-1
X-Mimecast-MFC-AGG-ID: 7laUOaV4N-mnMGFlaqmodQ_1746459925
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so35895145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 08:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746459924; x=1747064724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT63Qjgxn2mmOj4nEoT8zNbpR7UCW8tfN5uQH3dFpw4=;
        b=d03rA7Iso7rfUkYGhiUfXOHCOcdf750IhKaygGM9q2MpTXDLn6dHiR76Wg5e1gB8UY
         2pS3HzGv6I+Ry6TgrShfkXHuPXm10Lb9cpow/6LmvdSAoxInC7g5a6UJmVe1Wsw9EDeQ
         IposZqDyuIEr6eH1xfXFHmQAEyQnV7Kkr3wYLGbwr/ZRgYaOC21MQEA55Iwb7D4uiRIk
         BcDnEn7plaJxVlm7ljCqoKGimQ/+nV1TucI8W7MOcptOFH84FRmb7ntj1DhBb6rsf3Tt
         g/yqsBS10ceNsGYcz8X/jVn1ILVIZtYvcmNNoFfVNKsNH/Fk8u63QdKi3QBjJMMMa5VZ
         9NhQ==
X-Gm-Message-State: AOJu0Yw3dVm90ngmqu+48x2jcHH7f4Ym3EbYqszqAowwGqI56ZyIkjAQ
	LVCbu9iDvC+EV4G5CNNqyK+LCZBshFM8k7n1SG5gUneaRiww4hO4TkgXqcScXbL1WnR6J5sranl
	+FMcnz806Lqk8TQC3Zok+0W3H/KzvC0dbWirp9qHUMXWt7pm4sqRgVz4u8KA8Wg==
X-Gm-Gg: ASbGnculGNX3y1CNzKvO3ZsSyoVtjxXdEywsYsBZzXCEp6hYRtCQXyuXd1uljLNeypi
	z19oKgjvIn6zVSSX9frDfhIKgxMTIaioKbMIBO/uD/DKOPiqiajB6F48SbYuaxu2Bp4gXspPfuu
	0xZWRgcqQYjW4+lhDHkWtmEWlOokFswbpFljOoF/c5KotNIuzT46vDpwWskyVHgc9ZGe5Fe9zx5
	BCVIh1C06ZgZGzO5QRUXMMIjl8Jv2RilyCz8bxY4m/Y737ljvRuH728qzLGKj7DiZz39/d6xTHM
	26cSMqwa8ywngcYvZnpCGS2HuY1GwuColWzOVsIl5Yza+ELF
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441c49340e5mr60613255e9.33.1746459924523;
        Mon, 05 May 2025 08:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbfW0Iv3UrCtUauOGIpvVxzFiIHYGFD4OyH1evLHyjz0zJwfLTvcXbPZ3pmzRKAXfEnCx79Q==
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441c49340e5mr60612745e9.33.1746459924071;
        Mon, 05 May 2025 08:45:24 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2001:861:43c1:5950:3e51:b684:9982:d4a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d1358sm138001675e9.10.2025.05.05.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:45:22 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>, Nicolas
 Saenz Julienne <nsaenz@amazon.com>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Naveen N
 Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rong Xu
 <xur@google.com>, Rafael Aquini <aquini@redhat.com>, Song Liu
 <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Vishal Annapurve <vannapurve@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <2c5d11cf-ad06-444c-b84a-42de7a10159d@intel.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
 <20250430132047.01d48647@gandalf.local.home>
 <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
 <20250430154228.1d6306b4@gandalf.local.home>
 <a6b3a331-1ff3-4490-b300-a62b3c21578d@intel.com>
 <xhsmhr0179w1i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <34535b8c-35c8-4a7f-8363-f5a9c5a69023@intel.com>
 <xhsmho6wb9de3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <2c5d11cf-ad06-444c-b84a-42de7a10159d@intel.com>
Date: Mon, 05 May 2025 17:45:20 +0200
Message-ID: <xhsmhldrb9i3z.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/05/25 10:57, Dave Hansen wrote:
> gah, the cc list here is rotund...
>
> On 5/2/25 09:38, Valentin Schneider wrote:
> ...
>>> All of the paths to enter the kernel from userspace have some
>>> SWITCH_TO_KERNEL_CR3 variant. If they didn't, the userspace that they
>>> entered from could have attacked the kernel with Meltdown.
>>>
>>> I'm theorizing that if this is _just_ about avoiding TLB flush IPIs that
>>> you can get away with a single mechanism.
>>
>> So right now there would indeed be the TLB flush IPIs, but also the
>> text_poke() ones (sync_core() after patching text).
>>
>> These are the two NOHZ-breaking IPIs that show up on my HP box, and that I
>> also got reports for from folks using NOHZ_FULL + CPU isolation in
>> production, mostly on SPR "edge enhanced" type of systems.
> ...
>> While I don't expect the list to grow much, it's unfortunately not just the
>> TLB flush IPIs.
>
> Isn't text patching way easier than TLB flushes? You just need *some*
> serialization. Heck, since TLB flushes are architecturally serializing,
> you could probably even reuse the exact same mechanism: implement
> deferred text patch serialization operations as a deferred TLB flush.
>
> The hardest part is figuring out which CPUs are in the state where they
> can be deferred or not. But you have to solve that in any case, and you
> already have an algorithm to do it.

Alright, off to mess around SWITCH_TO_KERNEL_CR3 to see how shoving
deferred operations there would look then.


