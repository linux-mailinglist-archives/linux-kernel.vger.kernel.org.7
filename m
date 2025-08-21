Return-Path: <linux-kernel+bounces-779735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21716B2F7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCD616EC61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E030E833;
	Thu, 21 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsXC4KbP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADC2DAFD6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779292; cv=none; b=ZYzyxSMUkz8VSigGktZN2lxu1HqPtE/KRkmwgUlhCvJJRKsDN3KRQZIZ0/jr8AGtwg+OcVyh9RM/1xJqOptxBCDeBkYmFSwa51DnatS66iiziIZjos0Sd+0qwi7rhiKcgC/yohHN9lW6YGg6qQ1oyvsKlLffae0aoD44gVv9II8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779292; c=relaxed/simple;
	bh=RX1jZ+4YIQviBTMBjt1bufwqcrH5YhFu9gOeTGI1JJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIiMQdZ3RU9suz397tlQ6VsNQgskRG2Zu0qbkq9xyZK9tXhhBHxxlQdmQjjMECQi6KdybM0VhWOL903P4RrG3jTAXH3dh7ahcgsDdXV/t0HVgAHrm6d4543kjbvCIQxKtLOxLyrgO3EdVpFaCezxXfZfD7z3RSnk0FV8pPhwSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsXC4KbP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so6846555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755779289; x=1756384089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmylNyO4bRsuIljbSRSn8RZ0FllMvYNVElArjG1eb1k=;
        b=RsXC4KbPGVAUn/7rw91hHk9CVUlffeMJJiAAA1fhJPTuLM6LzQONrwrLYsBW2lzPlc
         8CwzVXDYrjfOj3oBvAfk3AdsLtYrZMTvtbxWInS8DEnXhcLBrDlCHVhe0UomL/jodH9Z
         raBm4DHvOz0OWHbNZC49jvExnpW/3DtJYgQycvOEA7Z2Pfd9qCERs74kGxyiQ2exKwC7
         JcfmbeqFucq28/TSXkt6ZZe3LBcRVntUaNCBgNceAem3ejpauJBgcxex430DQjiydmf4
         lvyRpoYpNet6EKPuw0bIrRrB1ggp/VcMjfrFMHc7vjP0yP9KQy7m/Is7hp+eBYIoRkrk
         HSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779289; x=1756384089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmylNyO4bRsuIljbSRSn8RZ0FllMvYNVElArjG1eb1k=;
        b=gFbRBza3hbYtsh6Tez3XSUq0PfWgnAFBP6FYjpmGF8Y11LxGlN62wcHPKskwdWvfzW
         kLfFuffGPkID89F1Ku2fo8t03xA+OazzCLlQ6r4nMheCEmM4/uxHoB9RAyMfkotqdiDy
         dNMnIfay/1iqqggvobHzkvBYsie4DcLILVQI4H0iFZfDZnW3hQY/M5lrB1AhoDehW5hC
         6xHtKlwurM/Q8geLnhaObjI4nf732nBJu6SXgnTMY7Wk4okK926jgZfcPXaKCp5xSXA+
         /WoSZy4YGMKzYC1x1nuXBIMBeJk+ChRmdPGwzhsidfk70LOs7/lhpeKSViItIRm098TT
         s0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGWGVkmv1dtn2lkPfgj/ZjklwRboTwxagCC5hbjwJBrthpD9rfpTrfrm06L+2fJhh0EXK/PgxS8pHa3fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKUNb7JMOySpP/nvWlqRcahz55MySVvn7BVdoZhoN5iLdQ78b
	CXlZAHT9rU4SupEsVWVMN70LT/0UfmQvy7fMSgCnuvZ73ffQH2izAuA1
X-Gm-Gg: ASbGncuz8q7nsBqtHDuS+J/hSHk6hKYX5O+3hggp49e3XvatXlSz7XGhtX9jVR2pVWB
	g2xNyyfPNEBiU5wODRAzPxMTqBTeK9di+0n5UNfPI1/CAqf2xFC2nB8n1LfeDgCESpjO23dYS9o
	ulMVZYFo0ZxHUA2vyRBrPwAUnb5JM7jEaPLhnqWeH64ZoC9oLWSNitNlfAJ8kFORzlqzAXYNEfe
	+SXYjpIFq4h1REZm6L7138xdZH6exQOecHZCkj50fDotgKhttCnZ2C2EqU5EiWOq+BXtsok4ulq
	3K99AG1V8pdCnN7QMRWgZkmxwzbiWpHyPTvjnLEJMV47qcX89ZgA14tChTUNPpVNCggDohypAXn
	HiQESEghLnQ2Uca9ayDG7MmSwKSByKS7aPjIsFcOGSOsiVg1bhVstr+Bk5Di8S85F
X-Google-Smtp-Source: AGHT+IHKaS+fjotFF7B4dOg7iRfoeCFk9+WwvKa35vjogCUBNjiIH5r2Ow230S8v7WAPbWiYMofBuQ==
X-Received: by 2002:a05:600c:8b10:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-45b4e6acfbemr18366935e9.33.1755779288810;
        Thu, 21 Aug 2025 05:28:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e8de85bsm10376175e9.7.2025.08.21.05.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:28:08 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:28:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marcos Del Sol Vives <marcos@orca.pet>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst
 <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel
 <ardb@kernel.org>, David Kaplan <david.kaplan@amd.com>, "Ahmed S. Darwish"
 <darwi@linutronix.de>, Kees Cook <kees@kernel.org>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>, "Xin Li
 (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250821132807.0a898dfa@pumpkin>
In-Reply-To: <20250820090733.GJ3245006@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet>
	<20250820090733.GJ3245006@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 11:07:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
> > Hintable NOPs are a series of instructions introduced by Intel with the
> > Pentium Pro (i686), and described in US patent US5701442A.
> > 
> > These instructions were reserved to allow backwards-compatible changes
> > in the instruction set possible, by having old processors treat them as
> > variable-length NOPs, while having other semantics in modern processors.
> > 
> > Some modern uses are:
> >  - Multi-byte/long NOPs
> >  - Indirect Branch Tracking (ENDBR32)
> >  - Shadow Stack (part of CET)
> > 
> > Some processors advertising i686 compatibility lack full support for
> > them, which may cause #UD to be incorrectly triggered, crashing software
> > that uses then with an unexpected SIGILL.
> > 
> > One such software is sudo in Debian bookworm, which is compiled with
> > GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
> > on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].
> > 
> > This patch is a much simplified version of my previous patch for x86
> > instruction emulation [2], that only emulates hintable NOPs.
> > 
> > When #UD is raised, it checks if the opcode corresponds to a hintable NOP
> > in user space. If true, it warns the user via the dmesg and advances the
> > instruction pointer, thus emulating its expected NOP behaviour.
> > 
> > [1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
> > [2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/
> > 
> > Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>  
> 
> This is going to be terribly slow if there's a significant number of
> traps (like with endbr32), but yeah, this ought to work.

Could you patch the memory resident page to contain a supported nop?
(without marking it 'dirty')
Then the same function wouldn't trap until the code page was reloaded
from the source file.

	David

