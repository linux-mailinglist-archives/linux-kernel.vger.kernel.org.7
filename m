Return-Path: <linux-kernel+bounces-856972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207FBE5904
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A742487D66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1612E0407;
	Thu, 16 Oct 2025 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haIP9fp9"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44497155326
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649866; cv=none; b=doc+RWQVhMdjPW6iHIIixLwYZlgjdzVcCkNsEo8fZ85M7m8M2YetVr1httYV6VE2Y6VCPnwm3DGH7egEcfkRCUkRqhMLT1cft3MTg2YW2j4u5YNbndbK094yz3GpVCGwT8gSexJ3TdzIV49gjVklUffAwQ0phCX6Zb3MDstR8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649866; c=relaxed/simple;
	bh=zkqdfx4BD5UyPEIxcbsOF2fQCsYMrVYuy2A9HeyQ5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riA7NLGSSB1OwV4jhWPGNzJdmU/iL43BmmcZUgEQ8OVUROvGxF3N9Z/3xg4+8JHixrbKHWsRVVmzYjzOSdER5MCTVSVxiu3VzqkTlXXN3dGX2oWPrD908T2/DuWZrC9tXpRPIrhzsNc80fxcunaIaqszZrVrOt9JlPwMjWuJlI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haIP9fp9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42420c7de22so662282f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760649863; x=1761254663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8K154kd8Y5oAN1bdoWfiouSXSOoD2DULkag1tX9qDc=;
        b=haIP9fp9o5/mIKKQkzlGEb+IFXzoH9wthWhgCNqasnLZBbtQGz4oc/EFbk2i00aH9S
         ko3EzlDa2456lYJydkBbbzZYxc/FoagYnASxX25TZY0GAkpxjm/iUNodqgkcj3V8U/oP
         XoiReuKUEdScOoA5E3jzWC+xJNmRCTkEXXwXoIzpDQJqpER/LJS17c23phX4QK3Xuax6
         jxJED/0J7ksIP7geQmpIitNZEils80XCwDB87SuMbvBrRIkvFSIVBC9JbZQ+qlCN3KnE
         4JuxgQA4vuc3F4XIWxGdkb79/+b44GSYfY3u+GbhrVWpnF66qjhcGDnCguXRjok8l+72
         5kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649863; x=1761254663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8K154kd8Y5oAN1bdoWfiouSXSOoD2DULkag1tX9qDc=;
        b=wQyekhbAYOP8mdl/32WjaCCRBVEbL8GJ09QQdmupP3Eygbl4TQpP6x43wGels2ZaKo
         s2lP+IN16afxavQJqdk21DzdZUlwpVIIl45ug4djR0GkSviwpg21CiaiK4ymqpv+/mlC
         KRpM4YWybOJjtPKB9DadvvdDA+tLDCONcr/tEF+dauE85mdpScqxUH8Sr5Owd3cDFUOY
         VQT5SR/C+5GaTq5tevh/bMiG2VcvqVEP5+oK20Tf22gPjKBirO/CakaBOAuZnkfn0+9H
         OBW+HK9WULiNWgBMZyze9s6g7lp4IdIBhdnT3scCHMnFDk7LaLrqGo2JPXKWpYkqFxXr
         PMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYm8XR1PaK/2K5x27BXQ/KgQc1OvnJOx79q93gYpfDvVVVTFvo/LZLQOTFLnVD2zuK5WDDyA/QG2q2JFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxu7DSk+KpJjLj3nACNZxkO4INRjCqya4mmsCDiuiQvI8kQGxr
	mRxtiCpUSG+aF3jiPNgvpP5Bg/6wqyEGXqI2CHFwcw5pRuPjVPTGxjbtkgcoSg==
X-Gm-Gg: ASbGncv6MBa5LHcUuy61/F6zc6tPKByLSQFi8P9P1nBlpsCBuvV5mNudJfAOeUH7Nc+
	veSEXUnspAot+IJn30q8ujr7fyZCsmfKEBlyQAXqH+4KhFuzZiPoHdyMHCGwRVkN0r/5Yeo6mge
	Ps+nUZ4qeMMhiciR3ZLTvLPcM+877UCuYSn8dDf9Mj905Ner3zZwTiGkpN3vzA1qhuNuMhiMx9D
	C4Kt+O5G9RDf1nGz5gbUodf2m8bOB+ePU1ajajcWfz8WxyIMlRV/sBK7fhk3lgGKoiEvTlKuBZJ
	hnRp36gNfF1dGLs7UJhLebqVO7AhcooH/tp1BqGuSesal0h/yAW7ob+uEwKWpVi/ieQg2UQk9wY
	vDYL/6r7yhlEOEvY/O8lomU+bxNqdI4bWVuNFDG4yCtBzYgPtu4EHWFVXYS/l53JQnNPPLrOes9
	+14Wjn5vB0Rc1Fnx/TeWwQYHwCRovcRvPTFoEN3/fcdsLRXVZXxVK+
X-Google-Smtp-Source: AGHT+IEuo+os1JCoNcOFBsfo7dbV+ulg6iVzPth7mYQXucYvD/F0/YBKb3eG6695x4HViUPFesLAow==
X-Received: by 2002:a05:6000:240f:b0:427:486:d96b with SMTP id ffacd0b85a97d-42704da0b74mr815352f8f.50.1760649863293;
        Thu, 16 Oct 2025 14:24:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144516fasm50876905e9.16.2025.10.16.14.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:24:23 -0700 (PDT)
Date: Thu, 16 Oct 2025 22:24:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, Daniel
 Almeida <daniel.almeida@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Joel Fernandes <joelagnelf@nvidia.com>,
 Ryo Takakura <ryotkkr98@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH v13 05/17] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20251016222421.512ca8d1@pumpkin>
In-Reply-To: <20251013155205.2004838-6-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
	<20251013155205.2004838-6-lyude@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 11:48:07 -0400
Lyude Paul <lyude@redhat.com> wrote:

> From: Boqun Feng <boqun.feng@gmail.com>
> 
> Currently the nested interrupt disabling and enabling is present by
> _irqsave() and _irqrestore() APIs, which are relatively unsafe, for
> example:
> 
> 	<interrupts are enabled as beginning>
> 	spin_lock_irqsave(l1, flag1);
> 	spin_lock_irqsave(l2, flag2);
> 	spin_unlock_irqrestore(l1, flags1);
> 	<l2 is still held but interrupts are enabled>
> 	// accesses to interrupt-disable protect data will cause races.

To do this right you have to correctly 'nest' the flags even though
the locks are chained.
So you should have:
	spin_unlock_irqrestore(l1, flags2);
Which is one reason why schemes that save the interrupt state in the
lock are completely broken.

Did you consider a scheme where the interrupt disable count is held in a
per-cpu variable (rather than on-stack)?
It might have to be the same per-cpu variable that is used for disabling
pre-emption.
If you add (say) 256 to disable interrupts and do the hardware disable
when the count ends up between 256 and 511 and the enable on the opposite
transition I think it should work.
An interrupt after the increment will be fine - it can't do a process
switch.

The read-add-write doesn't even need to be atomic.
The problem is a process switch and that can only happen when the only
value is zero - so it doesn't matter it is can from a different cpu!

I know some systems (I think including x86) have only incremented such a
counter instead of doing the hardware interrupt disable.
When an interrupt happens they realise it shouldn't have, block the IRQ,
remember there is a deferred interrupt, and return from the ISR.
This is good for very short disables - because the chance of an IRQ
is low.

	David
 

