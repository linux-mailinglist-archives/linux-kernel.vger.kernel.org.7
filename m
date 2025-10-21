Return-Path: <linux-kernel+bounces-862968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C1BF6A96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D50C8355BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553E7DA66;
	Tue, 21 Oct 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xd6pG1eD"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4D2F2606
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052014; cv=none; b=n3OZJKlIces6+ZBdqrdoxq/FxQhmhDUzGoRAUGdrbsO/k5fbcwgTLDSHYkZS8Rb7TjCFU6ZGpqZ+e63XUjrD6UipZ440hUEQTr5aGFqOvpS/c8DaJFHgnjZz0FMo6hOBNCdJrTxk3LnM8EfFfbk4S+rRgH358ze5m5uMH77zwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052014; c=relaxed/simple;
	bh=hscfUleXInkjfy7hd7tdmwZngxO3bR0028e/tHVvvPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R5282K7AHTs504EKEWT2PhkJSyHvi20hBEjAuR71Bg2ep6jynOYqe+TdO0MGd8Wh4cZXU0KsOYt/o4eMBupkbfvAcIkDvQbw4t5h2GG7D3hAa2JZFbegyVK3cW6XyxW1Wsjqu7wr4Kd08WDEhAhnZkuiAiGJ7WE5fmKdS8evlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xd6pG1eD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4710c04a403so58748125e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761052011; x=1761656811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vytLTdIwa+WbtX24vkTZ/PerhXM2X8ctk8Nuy74R66I=;
        b=xd6pG1eDI88rC+diF7c1q7X2PdWvXSIs6M9J8X0B+UQAnGVOcrRy5/V8Yi2481uZwQ
         x2Z6PTBGQ9xFJLxSzD+mCRGUZ4QeTCPW4NIQJjEeqpVxxl/TSzTN9eKFCPnsb7UyOasg
         87La4fJAoKafsOQlJha5aXf4eVRfnY+MzTysRlWNFTUn4AV2HZIqJsNcoEeVR802U8GX
         GgPxxaE72YBwcJD/FzS8Thph95WwOb3JapMnnt1BO95N3pzvsZvCiYHWQFXPvF2G83NO
         xI3YJSd4c0NxqV5r1X2HNLUO+dUcQgU20ASEztIYJ40JOOKfNePKiYqODRmgtUABT766
         HD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052011; x=1761656811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vytLTdIwa+WbtX24vkTZ/PerhXM2X8ctk8Nuy74R66I=;
        b=b8Y1P/0/jE1caygRL4bXgfFyemGZRRTOMwe6bgFiRGlUT+WWi8PD/vQ+jUo2nIISca
         LIcbULR40pH1X/IFS+DsgIlL2K4gSq3s/EopdqIi9LpLQuL0C5cTRacQdJu/jBkWkCR7
         pyQhliOfGh6SWELDXczQRQFFpGRUhQQD2nRZGky8b7Vl5JtXVmB59ku4203KpVg7Xgy/
         lZTvLEDxoSZUMpKDLmib4aB1QJz1GpTuPHI/T/T/M8tSU8H7SoaXd8oSIsMONtpPICD7
         yKbne3gpW2Y8oZsIrPly7posjkUIo3CThK0dBIUeXZgqqb0OnyvdGr/iP/bNr9JtUOqs
         ZLkg==
X-Gm-Message-State: AOJu0Yy/wH77KCbVBu72HhzbLesNzjrtOEn01tMTBVVGt/BPbqfD3Gz3
	7RIgGqXGal2f3n6GW55Zxyuls7uFxFoh/7UUDegL2mXBnbYNlsAsi3waWSs5WJScaqDpBixvs/V
	pnyNKQF3bDCPe8Q==
X-Google-Smtp-Source: AGHT+IGSzs7iMqYPLU0YiHOe8puE6jF7fJT/LuwZuqToX62az6sZMIwqFnCidiR1lX4NWk3y/UexY9EKcN4gHw==
X-Received: from wmaz8.prod.google.com ([2002:a05:600c:6d88:b0:46e:2f78:5910])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8f:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-471178b123fmr129426775e9.16.1761052011576;
 Tue, 21 Oct 2025 06:06:51 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:06:50 +0000
In-Reply-To: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDO0U51QORMC.2UIDZU10FAFH0@google.com>
Subject: Re: [PATCH 0/4] x86/mm: some cleanups for pagetable setup code
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri Oct 3, 2025 at 4:56 PM UTC, Brendan Jackman wrote:
> Per discussion in [0] I'm looking for ways to refactor this code to make
> ASI easier to deal with. But, while looking, I found some little things
> that seem like just straightforward cleanups without any real
> refactoring needed. So let's start there.
>
> The last two patches are closely related and could potentially be
> squashed, but I've split it in two because the first half is trivial,
> the second is more tricky and likely to be wrong.
>
> This applies to tip/master.
>
> [0] https://lore.kernel.org/all/20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com/T/#t
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Brendan Jackman (4):
>       x86/mm: delete disabled debug code
>       x86/mm: harmonize return value of phys_pte_init()
>       x86/mm: drop unused return from pgtable setup functions
>       x86/mm: simplify calculation of max_pfn_mapped
>
>  arch/x86/include/asm/pgtable.h |  3 +-
>  arch/x86/mm/init.c             | 19 ++++----
>  arch/x86/mm/init_32.c          |  5 +--
>  arch/x86/mm/init_64.c          | 99 ++++++++++++++----------------------------
>  arch/x86/mm/mm_internal.h      | 11 ++---
>  5 files changed, 48 insertions(+), 89 deletions(-)
> ---
> base-commit: 47870f1fa057a411519108f0833dd2603179234f
> change-id: 20251003-x86-init-cleanup-0ad754910bac
>
> Best regards,

Hey, is anyone able to take a look at this?

