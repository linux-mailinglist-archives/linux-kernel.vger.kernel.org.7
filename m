Return-Path: <linux-kernel+bounces-852403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FCFBD8E01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D4C424D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506662FDC50;
	Tue, 14 Oct 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e83mDdrq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8B2FC027
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439780; cv=none; b=R1WSe0xskKbaAJg1kAdGVf+c62MnDzaUBCzX1GuNQcqpDstT7YRUx0jeSSx1ksLOXesx/xGC6Ww6JxCFT7j68nc1wYRdQ/akjfl/ZbsM0UH4leKg1CsGTnkraWVo8mpXYnaBg0jcg6OnS5kdlt7NsKF/Faz8o+KrD7s0oGxOajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439780; c=relaxed/simple;
	bh=/u5e/qJ2sRdwo1224SVU8XP3U/yMMEn1jbJARlu70Tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7bugU8ahEDUGiYCq0JfY+S2Kvz1iIsxMH+NhUPUlsg2clVkW4W52KbuDXde1LlLzSyNC/nLcAjj9pROnPcfMnbzijDgWfXNHy+H5g4DRsmtl8ka8l0MLOmKgBr3X4sJ73V46LpXBxj7lk4ovOpi9t48He4fb3B2w1T1oWQrSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e83mDdrq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760439777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s2r/L8/q4C9e2I164NDxUGdYhK/0nvlG6dMGzaNBqVg=;
	b=e83mDdrqUjDTuwZOBUhrBr3TEQ/TkIV8qTEniGUfnpBREMz0qkkI/uMbWOP4Dgm+hIdaNX
	3moPEZQkkSVDIOsXJulDC95g9GeF0uOMCE/NtlX2T1xrFCJhz6UsRK8B9MFTOQy6Nw9qvD
	X4lXGxiqvUIynZmtSwM0Hy9XFEWA4EI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-Sd3r-l62NF6qnDB0lAmY6w-1; Tue, 14 Oct 2025 07:02:56 -0400
X-MC-Unique: Sd3r-l62NF6qnDB0lAmY6w-1
X-Mimecast-MFC-AGG-ID: Sd3r-l62NF6qnDB0lAmY6w_1760439775
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cc8ed76so28386505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439774; x=1761044574;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2r/L8/q4C9e2I164NDxUGdYhK/0nvlG6dMGzaNBqVg=;
        b=UA6qgGmpujrU2qTmc8/fqkLbeRHU3lPGelkRXnfadQldvB4UgzmdUJOkcsKTzgWOMv
         G9JTB6pwwl9IesVFBrQMh9NgBMzy7qTQpv3DZAm+FiAWNativBUNosgFSaxTlWUDi8YH
         idTpL1yJK7ShrxD0FgsnZCNMOl9hMYN3MzXM5LATsFdZ+QJwBCNTI6Sz2zQlPzWD5kUF
         ezJsGXyzBXJiVIE8/bQI60JRv82RCvJy8q6R/vTnv/hk6gXN+hyAYTYGwc4vhVm600x+
         rKmQD8/TuPEMaWrm7v/HpSg7bJ8nJMEjZi8PzkW6hCz2Kf5qmGryspWhnSxtpNSG6T56
         mE3Q==
X-Gm-Message-State: AOJu0YyRFHXOq7GHcHJVfcnLLpJ1F8QxCo2VDjBPVa0smw3C4ZnbfVb5
	+KGHrCktVqq0YmlpYkl8ycvqM7fwdape+VY4jrhLJhWpilDoCB/tnYkCn6tIYh8+tG9nk2KhOCp
	KWBnonSFUz/hLqUTYbSn9tCKz3pIYNppbro6cq7z64UtHielT7CSOsnh4mh7hkEAnMg==
X-Gm-Gg: ASbGncvjGRf3mOOk6OtVLzb87a1o10eoriIy1XEidR99t292XM14j+ibISr0B6bHll9
	yPw9NNwweKK3xreltna3/AuN2XE+IjfnwVegrLqbZ6vvkcEPAx7KfF3tTQb7+azekdl2F6qq4YG
	q8epQwuxDZH9piTq/CAD6E0zr2jsc9EVjkZCwiWpl8T/xtfqUXp4AxwEMAtIsSPGb8yixxhxN0J
	4fl7vOdWTnaii9TQcdo4uV7j93gI3uO7uS1ZwB/mHpGCBad3rYnqw2fv/y6swEfW4L1uT0B4978
	rX6NUNWZ4UHELE0gphToh2BgsIfVNQqrQbrB42MmhjQKkvwEbj/0n215IcdYzUgV7xaSzP1qTqb
	0ltiW1Dv7EUAgTt1+E/PJy2ZAYw==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr181929365e9.17.1760439774562;
        Tue, 14 Oct 2025 04:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCodl08uTX0ubswP5nTiGxebtIpD1Qw4JnrqS3e+W7M5qhx4w6eQs0AuIjitoXX5t0l6/vwQ==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr181928825e9.17.1760439774097;
        Tue, 14 Oct 2025 04:02:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm1737515f8f.0.2025.10.14.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:02:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 19/29] KVM: VMX: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
In-Reply-To: <aO2S3oZwOW_UgAci@google.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-20-vschneid@redhat.com>
 <aO2S3oZwOW_UgAci@google.com>
Date: Tue, 14 Oct 2025 13:02:50 +0200
Message-ID: <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 17:01, Sean Christopherson wrote:
> On Fri, Oct 10, 2025, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about static keys being used in
>> .noinstr sections in order to safely defer instruction patching IPIs
>> targeted at NOHZ_FULL CPUs.
>>
>> These keys are used in .noinstr code, and can be modified at runtime
>> (/proc/kernel/vmx* write). However it is not expected that they will be
>> flipped during latency-sensitive operations, and thus shouldn't be a source
>> of interference wrt the text patching IPI.
>>
>> Mark it to let objtool know not to warn about it.
>
> Can you elaborate in the changelog on what will happen if the key is toggle?
> IIUC, smp_text_poke_batch_finish() will force IPIs if noinstr code is being
> patched.

Right!

> Even just a small footnote like this:
>
>   Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
>   being patched, i.e. this is purely about silencing objtool warnings.
>
> to make it clear that there's no bug/race being introduced.

Good point. How about:

"""
Later commits will cause objtool to warn about static keys being used in
.noinstr sections in order to safely defer instruction patching IPIs
targeted at NOHZ_FULL CPUs.

The VMX keys are used in .noinstr code, and can be modified at runtime
(/proc/kernel/vmx* write). However it is not expected that they will be
flipped during latency-sensitive operations, and thus shouldn't be a source
of interference for NOHZ_FULL CPUs wrt the text patching IPI.

Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
being patched, i.e. this is purely to tell objtool we're okay with updates
to that key causing IPIs and to silence the associated objtool warning.
"""


