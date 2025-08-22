Return-Path: <linux-kernel+bounces-782512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944EDB3216D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1411D189B431
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02900278E7B;
	Fri, 22 Aug 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLGWl0EF"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F01A0BE0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883232; cv=none; b=C/6MxMIajiSquYG8dSTu/wwz6D90yyDPiCGakNHnRGFW/0PQyig+cSZrzhJySGkLY5wkFnn0EsA+U8bT1fblV+9GQv/lL36AIWU8QKE3pKUoHYbncAyqe3sRwYMiRBYhQKYUtREgSGG19GCPWwsdmTkqaB7pYuSoL2249vAnlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883232; c=relaxed/simple;
	bh=X4Bwa471mvdLFgQpjwEvYNyvuNvBAos1wzWCBTWg0tA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ryzSjpYc8X1LFA3X7qSqa48519zbbpORdxEBe/3X7Pix4nAf2PmAj7WYuON0I+cZTL5htrUaXmSO2NS/SWvq2Bx7vfr3C9FuvDNs5k7GQCG3fCwNn6k6trNBtov6u1AzdLwjCn9HjVk3CIcIG6aJHNQevPqiaE4/N9/pXcrN2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLGWl0EF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso12235865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755883229; x=1756488029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAIfYRgGwZxY2d+J+2Tw9OQSooCUHaphp7wteQwPLhs=;
        b=mLGWl0EFgBGLPJiv+wuVYSvl/Eq5RdUvCUbNhMIe7DBhAlYCY8tvoimpw6X4GNUi6G
         JJ0M+gJ/V8UykM8ZRQ8atHAc6ATKap1KSOX/cwAW6p3VSe5gDfDQhCNWx1nsh5RcJRDc
         kldQgksOxZjP9tm482pO2CuBtiLQdgw0VONlF/8dDU338FxqKD7Ic3sRhhA4MRG4mNNi
         JwWbxNO6v8Abqf7OEYnMo8gKtzvDpmErxQhVTW8aK1ySBNU7WP+3Zm/Vx6al7VksfOwg
         5iDJy8RBW3kkmxlQhqT1eTJ0nGBQ9NF5xlGymrd5UxE5qxXY0T455xz6aNgJPQbYpQEK
         e/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755883229; x=1756488029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAIfYRgGwZxY2d+J+2Tw9OQSooCUHaphp7wteQwPLhs=;
        b=JPrUU2l40/K/VaJ+au3IlTiw+rvDtXAlE9qpBSDQcGbkQyyFORM2h3w7RV874cB1Se
         soBKNt5KLe6mo7YBDYD46cw1Fhm9DH27vEDC+oBw5IO4NMQzsXM1Gx7gCBhH6FvSfaiU
         9XknDJrv0fvazWi7xQ8fgGwUtHPk7ie7Mj+C7tFRUot0yv7O0n8QeqFNP+vBMi+RogXI
         OF/8pqw3HIIRUCtwCl5ZZvCIBoITlx9NqzK3MnZOHyns7qU+bdCrgsejl3Oi40j4j9IW
         dLTAltiTaQVR9d0qTRjSQJBX+iMsfSkqzjbz/vRbDRjja3amcom2V2t2KM81TR/6gadG
         hwZg==
X-Forwarded-Encrypted: i=1; AJvYcCVC1aFxiMGdbgWB94SSyUp2TOskhSucMX3Ku714yx2lj/TH0nQqO7MZDPhdet7LXoDo2nCY9rdZ5CLBbQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GObZ/5re/z550ZC7CvfmJ4AMvL+HitbgLP5DXTMZw3ra7qEk
	wb26c9s2m1y6M62krudxfqCLTYkHa9Fl+VLXObTDl4R6/44VdUZAKdaBVrfWtQTaCkZNjR1MbY+
	PPLBZ9xmlyBwzbg==
X-Google-Smtp-Source: AGHT+IGAQ3nKBaK3QO/Ktb7KuI028hAduXrZ22Qu6Xo0zqvcqENW+BUAAlbLyqUJ713Bt/ANAuJrBwMOcBFf1A==
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:459:db77:fc89])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f95:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45b517d903amr28510805e9.29.1755883229001;
 Fri, 22 Aug 2025 10:20:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:20:28 +0000
In-Reply-To: <aKihQv8fWzZIgnAW@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812173109.295750-1-jackmanb@google.com> <cdccc1a6-c348-4cae-ab70-92c5bd3bd9fd@lucifer.local>
 <DC83J9RSZZ0E.3VKGEVIDMSA2R@google.com> <aKihQv8fWzZIgnAW@pc636>
X-Mailer: aerc 0.20.1
Message-ID: <DC94NN6SM15D.3DQVRLO2E282W@google.com>
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
From: Brendan Jackman <jackmanb@google.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, <peterz@infradead.org>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, <yosry.ahmed@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Liam Howlett <liam.howlett@oracle.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Andy Lutomirski <luto@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri Aug 22, 2025 at 4:56 PM UTC, Uladzislau Rezki wrote:
>> >> 2. The ephmap implementation is extremely stupid. It only works for the simple
>> >>    shmem usecase. I don't think this is really important though, whatever we end
>> >>    up with needs to be very simple, and it's not even clear that we actually
>> >>    want a whole new subsystem anyway. (e.g. maybe it's better to just adapt
>> >>    kmap_local_page() itself).
>> >
>> > Right just testing stuff out, fair enough. Obviously not an upstremable thing
>> > but sort of test case right?
>> 
>> Yeah exactly. 
>> 
>> Maybe worth adding here that I explored just using vmalloc's allocator
>> for this. My experience was that despite looking quite nicely optimised
>> re avoiding synchronisation, just the simple fact of traversing its data
>> structures is too slow for this usecase (at least, it did poorly on my
>> super-sensitive FIO benchmark setup).
>> 
> Could you please elaborate here? Which test case and what is a problem
> for it?

What I'm trying to do here is allocate some virtual space, map some
memory into it, read it through that mapping, then tear it down again.
The test case was an FIO benchmark reading 4k blocks from tmpfs, which I
think is a pretty tight loop. Maybe this is the kinda thing where the
syscall overhead is pretty significant, so that it's an unrealistic
workload, I'm not too sure. But it was a nice way to get a maximal
measure of the ASI perf hit on filesystem access.

I didn't make careful notes but I vaguely remember I was seeing
something like 10% hits to this workload that I attributed to the
vmalloc calls based on profiling with perf.

I didn't interpret this as "vmalloc is bad" but rather "this is an abuse
of vmalloc". Allocating anything at all for this usecase is quite
unfortunate really.

Anyway, the good news is I don't think we actually need a general
purpose allocator here. I think we can just have something very simple,
stack based and completely CPU-local. I just tried vmalloc() at the
beginning coz it was the hammer I happened to be holding at the time!

> You can fragment the main KVA space where we use a rb-tree to manage
> free blocks. But the question is how important your use case and
> workload for you?


