Return-Path: <linux-kernel+bounces-780468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4FFB3023A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DFFA21652
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401E343D62;
	Thu, 21 Aug 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYSycIEm"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381E24677C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801622; cv=none; b=XxHm4GKN1gDOO+FPQUOZm8buAvaoqYs16/kn7SVUYZrgHA+WqaqG33rhOl3wDxfPrBXry0vif9exbTY8Geoa3KlSDOGwvVhxEmMw8UhiM7UIVfrtR8d//KL+pgR/Rad+rches2GTSJr27VrlyFcLzl7WPFTULn9fBc9u/ddopUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801622; c=relaxed/simple;
	bh=nDK0ZcWageZif12HNVptkW6uLrwCCYhU/Uqnb9pbUCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9Hc2CwK623s/Qq1eaw+EpncTWKX1em7lCd8d3qUnTd++VHcE1im6fejP6pLZSYyMSyWY/+M7JrdYX/N3Xnaqr+YN+t6XC2UU2A+LYC8hiWb/qjLzG6c/RjyZLOxsVxFG6LPL/+p7pCwWj9vB0vB5OUUdVu7h63epmJfOMRh4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYSycIEm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso1022296f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755801619; x=1756406419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EJFUbAFx8jPWT2LuRuozcCZv7qHtbh5f6F6dR/mulk=;
        b=fYSycIEmvoVJzFZ6Di9C7sstFcw6EmCMuwJZ+Y8KMBF1FRB8lbYUyuoMFqU+sBQaQr
         qtJ4OFx6kvAuYCXttMF+LkvrTM7QqTkCDudEagbUaYsOT42o+d1xoRv2KNwH2YWbonDg
         Xysg0nAJd0BR4aPu6vWb/NwdH03XfS9KmtXQWStbKHTGgFPJdSp9mSbK11pLm2E5kzV/
         xwYNAMwbsX7AvX5xcqQPvTxC/X6DHBaj1R0w3C4xj1qyCb8KN3xktLMEjIg5vHgg2t0P
         YjWlQBcjkbqHGc8RIUjdlek50wxstFMl+ZBcyL2+4I0onCyFANn/HJWq4c9FbNk665X5
         SEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801619; x=1756406419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EJFUbAFx8jPWT2LuRuozcCZv7qHtbh5f6F6dR/mulk=;
        b=RZ3qr1UDiR+AMIcfuDyk4JMlKLjtUF2UJcZtJpBMiVQrZicJQGLwjALAh3N+n+khQJ
         T5q3szgtmv09yPZBNyRCbin7Vn7qbm64/m3YzvssPx6AsVGutJEidmWjW/TFU5PXCCZu
         qADAPJvNc9H9Jte5j7y4ur6UQQocsa4c8gMAc3VyPe8vW3UMfdll0/Dye2f7svHRZlPN
         grGPN+2kD1TC6RjviNda8/oInu9SPaxG40dli1bcsX96uQLuA+sn4BdQVayWVvvce6zU
         jz+NX/6St7bEDl6utazn0AdDxSx1QsMrmEUKSJbneC0kDEEy5AUDpntUgF7Sd3iAD2GY
         DIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNZUd6/JRDBlobvyq23/Jma2Qd0LQDHjwypgAMSWkL8cbUGN6U2mFA1nsXTvWAPU2nmR2jISNC2eVNWKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WxOd/NbRbOGFRFxUaPn985paRQz8RgU/ONMZzZ6nwjsYWM/P
	DmiCHVq/UE2Py0MKsmOJfEb8enNgmGyzp9D1hbU9bKF56G/Qvg/pvbif
X-Gm-Gg: ASbGncux9/c/C2x3N2jB3SKEvGC5LYCCULDojoSpXXkcoafb/hVfgZYUXkZnfkzU/HN
	ddP/We0kta9rpVHpc678iSQ2rxI/4umxrgfK08fbHhvEK3uZWItAh4psT0k1YcnGW00pEUWgYzE
	scLrxIyD1+Yy1AutbItnPdE4qrfg9hsCp/WP3QeJXcR39NE/RwROvSzmnSbrtPRbfM4MZ7PRVIE
	xVMxiFP1zNg4n2IgOGFidbM10bFtdISxDYWThvAlMIOLP+sBMB7zbVmpMP+lA8YaSLPwEQTptVG
	AAG29FPNwD1paFCrxJwkhpLhQU94lUHEIMX4r6g3tXTNWDUa2RNDp6/TxCRf+YLsmoz6G+1xYi8
	0c3Y4jZ6oAnqTFyvLirjtiz+/4CFh5XZhL3Nwg289MMa3PpwBUqQPev4bVQe67GFKlupZCw6Uqn
	8=
X-Google-Smtp-Source: AGHT+IFqGj53ZdUXevzNpXmq8o1Hqpb6smTO0MmxfObPRFu1DLKDX0MJhD+ui5UdijfGjOnE2L5+Kg==
X-Received: by 2002:a05:6000:40c8:b0:3b7:908e:e4ac with SMTP id ffacd0b85a97d-3c4ae74eafbmr3323294f8f.2.1755801618516;
        Thu, 21 Aug 2025 11:40:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c52121313asm2306558f8f.57.2025.08.21.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:40:18 -0700 (PDT)
Date: Thu, 21 Aug 2025 19:40:15 +0100
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
Message-ID: <20250821194015.3c56964c@pumpkin>
In-Reply-To: <20250821124659.GO3289052@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet>
	<20250820090733.GJ3245006@noisy.programming.kicks-ass.net>
	<20250821132807.0a898dfa@pumpkin>
	<20250821124659.GO3289052@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 14:46:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Aug 21, 2025 at 01:28:07PM +0100, David Laight wrote:
> > On Wed, 20 Aug 2025 11:07:33 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:  
> > > > Hintable NOPs are a series of instructions introduced by Intel with the
> > > > Pentium Pro (i686), and described in US patent US5701442A.
> > > > 
> > > > These instructions were reserved to allow backwards-compatible changes
> > > > in the instruction set possible, by having old processors treat them as
> > > > variable-length NOPs, while having other semantics in modern processors.
> > > > 
> > > > Some modern uses are:
> > > >  - Multi-byte/long NOPs
> > > >  - Indirect Branch Tracking (ENDBR32)
> > > >  - Shadow Stack (part of CET)
> > > > 
> > > > Some processors advertising i686 compatibility lack full support for
> > > > them, which may cause #UD to be incorrectly triggered, crashing software
> > > > that uses then with an unexpected SIGILL.
> > > > 
> > > > One such software is sudo in Debian bookworm, which is compiled with
> > > > GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
> > > > on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].
> > > > 
> > > > This patch is a much simplified version of my previous patch for x86
> > > > instruction emulation [2], that only emulates hintable NOPs.
> > > > 
> > > > When #UD is raised, it checks if the opcode corresponds to a hintable NOP
> > > > in user space. If true, it warns the user via the dmesg and advances the
> > > > instruction pointer, thus emulating its expected NOP behaviour.
> > > > 
> > > > [1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
> > > > [2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/
> > > > 
> > > > Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>    
> > > 
> > > This is going to be terribly slow if there's a significant number of
> > > traps (like with endbr32), but yeah, this ought to work.  
> > 
> > Could you patch the memory resident page to contain a supported nop?
> > (without marking it 'dirty')
> > Then the same function wouldn't trap until the code page was reloaded
> > from the source file.  
> 
> It would mean cloning the page as private. Yes you can do it, uprobes
> has all the code for this. But it has non-trivial memory overhead.

I was thinking it would be safe to do this change without cloning the page.
After all the change is needed for all processes executing the code.
That might only be easy on UP systems - but I doubt the affected CPU are SMP.

	David


