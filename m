Return-Path: <linux-kernel+bounces-875656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2DC198A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71393AC98A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C4324B39;
	Wed, 29 Oct 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXaDWScA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD52E172D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731803; cv=none; b=mSvMcSyt9jy6b/yULEsGB1/M6mJQwsjyskhzNKvFB/uRqzhfz/YKgYNEaU9fp7N8kwAo0OmAGyMTlZUxof4LBogjMiksR7jDvYPWh055Exdabe8xHTYnFHv73gVpShCZFFOdOYmUpQAe6eUDbAF93T7fQE/D/Ut90ua2Y6zid3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731803; c=relaxed/simple;
	bh=z1uLaITwv6OZ8DF9u4QV5lBWshrTEK2JRzlPcMuwKMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyH2ltbFuyzgl2Y3xZkMoD6NBovX8rnTx6IAyWfIQjJcOpOoQQF76AlNXiVkWvSA4TXmTEWKIS6s0rfI2u3aDHy8XIhyES889B3VkkNrYRzQPx3vTQ3Mft05IFmlAprg2/YBsS4rSkalJ2hTqcM/GP7cO3ueQdwlfnbTfe+qpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXaDWScA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso31776785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761731800; x=1762336600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s7KWq9egMhpju6VmS47tJFFQLa8l8OzyLbuvgsXNtQ=;
        b=FXaDWScA2/qoP9XYQPn8hPHBDyicZ0fvHuvKSp35/8ZKivSsySMPyCi1FTklaleSZn
         TY8da/bkAbkJyAmfCCzZcDrxr09o3LuYlZF8Vs25w6mWJsNx+qD4x8Lyk8FDpes4vch8
         jokHSRKIQSWp0vWEYxulEO8oiusJv5QwQpy5r8WXJRg21/v16r6zu8B+UYEs1ZbIci6v
         +bYR8tkKSHcSshzCxE1TUKh9Ow/rAp5vnDCg3ZVCNkyjtNOuyS0BKF19UVqyzydTpxHG
         e/KH2akh1PPF/Qima2MAHtnZOFF/VCJAmnPoBFKlSwpRsUxBQLOn6s5kXrB1YcG5254a
         Kg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731800; x=1762336600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s7KWq9egMhpju6VmS47tJFFQLa8l8OzyLbuvgsXNtQ=;
        b=Xq+BaJ5sVmDe62c5psoJcwEK9LLAih1l+SXfjqG/4A8C52PL0pWsYThtCtn2VgMEE5
         ZU71EXSLXe8CFMr2ocq4tEVdDMvV9kDJmSMYmnRRrrb28ArimMHIokev+FYPmNzxQxCp
         DI3ayrR5xwgc9KCyinPuvlUKdhKyyTmmKQd6GTGghhe9Ci8DwvfO9JxyOB0CVHFpNQua
         YVyVeFYKItPiGfILB1QkUS9xJgUGvgA0dx3jDLJFl9LUjXw8eV1jbkETHYPFVVAdgJrw
         LUHYBCkGBf78SY9f9LrFGVUsOjCOLGiPJBZC0EQugMYvtsNakem3N+XvV4ouKAjFc6WK
         YQnA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhiQ/9qN9YhiAzhesu8iEYZjKvKWh+tN6L2HEAxYmFG4xc4mmaQibcYv23DZ2pDOxow+Om5SqVAGSOGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5iO5xuHkmcx3dySS8YHImSJL07K3ZR3xBRgv/lKnTa6qcjsO
	h+HSsAjrZu83K4B8Emq+X54MQ+oczQrCfvfgKWiSuwU9kjM2y/IKZBuI
X-Gm-Gg: ASbGncsuqDVVZFJvbadJPlIzkAEvliHkT+363htqN1uFXpvQBQWrTEOgi1A/7y7AEDk
	G4n5+Iu1tAjaLSvMlHrxBdwYGcgGg5P4YMRGlSxoW9uS58MGepfGjMN/zQgvLnTYlbBVQj+iJDE
	MoHw1VywnBG8wThtdJQAO+wVTUXIBCPuumg/V38EAbDhOaxjKX0Wf9UQxMuc7VKSP961Jl8KJrY
	NtXvvxUoNf5vHghgmeMIVev5C4StXGT+RWp7Na7anESUJZf9ubf3X2laSOkXBYwMiAiQlcVDb+6
	h+JFodQOTIoHh8eRPawZc2dh42NM8oXCMeJm+agiJPY4AD7U7Yixp/eAMxAKG++fRN4tDnu4P7L
	hFlz6MAsBJDsxtqa5JitxCMdhjd/l9b6Eao+boegIqljaPIE4Pm87+sinvJYh7EN47Z4tEpIFoq
	55ORHH+Tc4Q4bzk8uP4D/0Xg0laxLnW6Hv7ZhEwmnlnw==
X-Google-Smtp-Source: AGHT+IEkctKeY07JwCk7+xEalAP0C+lDfSgs2w/Jivlf1TQ1m5CrOuGlk4bdk4A+9lTvmwRgzvxe1A==
X-Received: by 2002:a05:600c:524b:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-4771e1af06emr19235495e9.13.1761731800046;
        Wed, 29 Oct 2025 02:56:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477184ff5a0sm41654325e9.6.2025.10.29.02.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:56:39 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:56:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <20251029095638.06cce7c7@pumpkin>
In-Reply-To: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 12:29:11 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Josh, Peter,
>  due to another entirely unrelated discussion, I ended up resurrecting
> my "make asm readable" patch that I have had in my local tree when I
> want to look at the actual generated code for user accesses.
> 
> That is a local hack that just removes the alternative noise for the
> common ops, so that I actually see the fences and clac/stac
> instructions as such, instead of seeing them as nops in the object
> file or as horrible noise in the assembler output.

I've toyed with using explicit nop sequences that would be identifiable
as stac, clac and lfence.

At least that would tell you which is which.

Since the flags can be trashed there are plenty to choose from.
(eg all the cmpb $n,%reg if you don't mind a false dependency.)

	David

