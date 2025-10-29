Return-Path: <linux-kernel+bounces-876323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C3C1B315
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553D11A21706
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57B42AA6;
	Wed, 29 Oct 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2H5B+Ra"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C71B87C9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747247; cv=none; b=IcdgEoRTqfXu7VZiPEDJkNTU/h6wW1WdwyCwkMGcrfM9q9pAkWH0Ye8YDChpKz8HIi0/WNqglHJmXrsCzaREf/+ncwCYv7z624VnzfOoEzjYVp1Sx7Io5P7Y/r67aZzxB4dtlQq3BD40gcWjcjk5GpOatUvztcKrP/oZRZGcSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747247; c=relaxed/simple;
	bh=qHSXiqraPjnmJYVHtWW/ojXbtxwSOyBwYtqsjFFbB7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XyUNPodnZwg3DO3vzXzJC9N3lpSPKhBJpWEN8fj9f7WyzDnFFMBSyNc2o9QhzhVEpaMwprpfe5Wwb18ZDUjPr4Y6uh7fs1Ak4W6Cwt2F4VJIgkXZTJr1sOuEB+ViBUR/7QFLPefTmLfziAdzV6TPmDxUGF33JauHUfB4yiaMLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2H5B+Ra; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761747244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYXy/T5OYgT19DHuKKWwDf9vfL9WSRPLsc+nPGT92ds=;
	b=U2H5B+Raksn2ENNzszCQHAJa0BQQ8W0MyXG23Ao25C4Vyd3rZW9Ig0X4nEt+34TyN8cuYg
	lFEZQtMvF+FbZirhwMM3/ybr0u0OnC2PNRT/Yaf/8u4KNgQz6PfykvE7if0WtsAO3qQwxT
	y+ABm93UK3w4w1CWN2FMae7h7yZ+yCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-JF8tCHNIP4K7uVqxyhBEVg-1; Wed, 29 Oct 2025 10:14:03 -0400
X-MC-Unique: JF8tCHNIP4K7uVqxyhBEVg-1
X-Mimecast-MFC-AGG-ID: JF8tCHNIP4K7uVqxyhBEVg_1761747242
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477171bbf51so8469145e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747242; x=1762352042;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYXy/T5OYgT19DHuKKWwDf9vfL9WSRPLsc+nPGT92ds=;
        b=U9Gc8OUlA5fSTOp1WJHfemQoRHHQqnhWLkLJJ8pdDXqEZHS+AzetBvBU62y+kMO4Te
         0RYD3m9il0c+VemVgNSXVFOcO0M3TLykLxGenMiU5NHmvdUxoq4nT7fzZOtsmfW2kNn7
         a7hVztFVBqMbVtwwRGveHh99DN+DFUkv9aJ4PcYQ/lDP6KiwUaTofmvp0YYjmMAKKhbX
         PbiaG+SnSOYNP0aR84JQ7ze9QfF89o91Uo0kSKNLD2ZgjkBZI0nJUzhaLjP61kcWXydK
         QSTkWJ+TNJSDjj+RGxpaoL5g3PDma+mzEtKeGXcrYvgJZFNQTaNdi1npAK7YJztomeZO
         5O4A==
X-Gm-Message-State: AOJu0Yw6VD9+GBRQ9Blq3KB500Qq0pzAd9vmpsAz7zegB2BRdWfSz1SR
	z+9H/xsp0rbhK98g0RNAlzf56YsPwBiwbelbKWYFgRgv1GZzH81igDldKh4cI6/b8A8JHe2R2W3
	QTebjfkySqQqPNMyHsXfj27ZDCgRgkavlII1VCaLwM/uBLktR79Cfuh7EXhz7pPDZjg==
X-Gm-Gg: ASbGncsHnEg1ueKvE9Od+VRJN387qAtCsKLNWXj9lAw3M+KnQUGhZvTwdjwCuSZjD2j
	SJJ63yW+4wQrI8yFiJueZaKqtmQX9ZrNoSxchYwTNfjsn2/hVllvmCbbUTcY4A29JTMeCGlsKS7
	n6+iXuG39C+yIqL2P/3fMyt0ILaW+aosb/Fyaw4XGQnLuIlIgoOEZbNIDIhXofL7LFJeHoSHDSz
	ZtyxvXFCIygdWjDju1PGQpaVkXjLsfsJMUrcvJxNH7PZIe3dRw6qUjGeqO6gBfYMy9PpeURddfQ
	h2TUFs+cqEfLX91vfJ29uNUlYeg5+5VRVT0OO3BBY7Zt7+juWyp/Gxv0rK9+k8zLWOG+lJdfi9L
	7fIu5Kk4AvgPHBu01Q6eKeMUMrP5/2Lra/eJilRb1biCuouzFVoFDvJkS2uuf
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr30985955e9.8.1761747241992;
        Wed, 29 Oct 2025 07:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ZXdnOISpERgBiJ9ZdxsqH+M706mFK4IVywCP8xRKb07Mt6iBAhayCrF0GEYoqONAFcNsMA==
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr30985385e9.8.1761747241429;
        Wed, 29 Oct 2025 07:14:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47719004d79sm45516125e9.5.2025.10.29.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:14:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQHtBudA4aw4a3gT@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQHtBudA4aw4a3gT@localhost.localdomain>
Date: Wed, 29 Oct 2025 15:13:59 +0100
Message-ID: <xhsmhwm4dpzh4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 11:31, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 11:16:23AM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 28/10/25 16:59, Frederic Weisbecker wrote:
>> > Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a =C3=A9c=
rit :
>> >> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - k=
ernel is built with
>> >>      andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
>> >>  .endm
>> >>
>> >> -.macro COALESCE_TLBI
>> >> +.macro COALESCE_TLBI scratch_reg:req
>> >>  #ifdef CONFIG_COALESCE_TLBI
>> >> +	/* No point in doing this for housekeeping CPUs */
>> >> +	movslq  PER_CPU_VAR(cpu_number), \scratch_reg
>> >> +	bt	\scratch_reg, tick_nohz_full_mask(%rip)
>> >> +	jnc	.Lend_tlbi_\@
>> >
>> > I assume it's not possible to have a static call/branch to
>> > take care of all this ?
>> >
>>
>> I think technically yes, but that would have to be a per-cpu patchable
>> location, which would mean something like each CPU having its own copy of
>> that text page... Unless there's some existing way to statically optimize
>>
>>   if (cpumask_test_cpu(smp_processor_id(), mask))
>>
>> where @mask is a boot-time constant (i.e. the nohz_full mask).
>
> Or just check housekeeping_overriden static key before everything. This o=
ne is
> enabled only if either nohz_full, isolcpus or cpuset isolated partition (=
well,
> it's on the way for the last one) are running, but those are all niche, w=
hich
> means you spare 99.999% kernel usecases.
>

Oh right, if NOHZ_FULL is actually in use.

Yeah that housekeeping key could do since, at least for the cmdline
approach, it's set during start_kernel(). I need to have a think about the
runtime cpuset case.

Given we have ALTERNATIVE's in there I assume something like a
boot-time-driven static key could do, but I haven't found out yet if and
how that can be shoved in an ASM file.

> Thanks.
>
>>
>> > Thanks.
>> >
>> > --
>> > Frederic Weisbecker
>> > SUSE Labs
>>
>>
>
> --
> Frederic Weisbecker
> SUSE Labs


