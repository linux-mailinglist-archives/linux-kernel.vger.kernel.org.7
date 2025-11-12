Return-Path: <linux-kernel+bounces-897349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A93C5298C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5CF4341A16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDAA247291;
	Wed, 12 Nov 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjS32SFB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688B22541C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956169; cv=none; b=pO5QlS0e91hbCDdlVmyLdUV6djNt/5eLlPKSB6tPrFHW2hWrAwnGB+yoRWtAQmwzCVpmniteTaeSKOcDsaMrGkt7zNiUWIp6V3s6rPZixcHjz5QdF5dLIP4+HenBvKPKPxllbeydV0qvAZOMPLXSiFohvFVAxq4SZZh47KEJcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956169; c=relaxed/simple;
	bh=tHJOhNS/6u7uEkNaEtbiVXZYwmle7ISnqeBqpq4Kzqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhJ0Ni9DtwtRQehkv5rxbLnUVgd87EAS7pu5J9DOoLQnNzwfx5gh4lJExn3r9yvCa77fkXlSCYeeZ190aYjXaqOUPlThFuw/2ypu0Hf5YDlPiBe2hghdEiolh7Y3q9onEFnCRQoWPgiufwOSi3ur6XaEZbyZ3b45ZHFDBEaA8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjS32SFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C367FC4AF1C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762956167;
	bh=tHJOhNS/6u7uEkNaEtbiVXZYwmle7ISnqeBqpq4Kzqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EjS32SFBYen9eAiNQDbTQjnNUt4y+hR057IIkiS7r91b6IW0aRUG1RHrKBp6H7CGp
	 88Xd/LQF37I8D+AVU0xzh6iVABD5lNIZcMO9+zeNvVa7XjlEIbL3WyEjV8oKBJGeYk
	 vGHHiVTSUHZAq9NiB/ZsCCxiJXI58etg0TWjnqnUt4UQ+yWkXg9AEtUV4a68Hb+jNz
	 ggqmUBijGEXbZRNPXbgRTIfaTOqIwNky4wIg2CE7MYx7UlUyPd2HjDKmt6+v2EvLOl
	 +QK/CZ6+eZ5nWXG8N5Zxfb7n9v/4ge85Af+KY6UBRTyTWG3ewERO6n+a4LVnOrqngZ
	 lzc6bfp6SmhoA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b96cbd875so3493181fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:02:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW92lQ/N2sLkfoDlWAuNyOSMLGRR8/3A2Lem6V4Nwvu4Q1s9hL9/03ou2HM92vZqGvsNzMn93FNlTAnLAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBC3KtwHmyJ4HYJHOmaCml8iw+bwsvUc06Ena+7QCiNlaygUO
	kxpR0Vx3xp3Sm8zIiBvxNqWOt6O2WQ8jf26QQ2hiiCB+PoJkVNSKODMxPp9MndMHO9dpbDT7bLj
	iYlv+obByTW32MllAUT2J1c7YCi1nWlg=
X-Google-Smtp-Source: AGHT+IGXAF4rUi9O4+ZXVKR3NNYktKS/FyFWJQfBYe693cP1LOAh54szQzCs9X+fzOsFf3NVrgtQ+SBmqveiSr5SGIo=
X-Received: by 2002:a05:6512:400c:b0:595:765f:a5de with SMTP id
 2adb3069b0e04-59576e653aemr992791e87.42.1762955827202; Wed, 12 Nov 2025
 05:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
In-Reply-To: <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Nov 2025 14:56:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
X-Gm-Features: AWmQ_blXGWjy7m-ZL23HpefUvy7djJ90ttXhT8zFrf_zvGN5o6-zn9r3GtsUR7Y
Message-ID: <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 19:15, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> Hi Boris,
>
> On 10/29/2025 2:03 PM, Sohil Mehta wrote:
> > +/*
> > + * LASS enforcement is based on bit 63 of the virtual address. The
> > + * kernel is not allowed to touch memory in the lower half of the
> > + * virtual address space.
> > + *
> > + * Use lass_disable()/lass_enable() to toggle the AC bit for kernel data
> > + * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP.
> > + *
> > + * Even with the AC bit set, LASS will continue to block instruction
> > + * fetches from the user half of the address space. To allow those,
> > + * clear CR4.LASS to disable the LASS mechanism entirely.
> > + *
>
> Based on the EFI discussion,

Which discussion is that?

> it looks like we would now need to toggle
> CR4.LASS every time we switch to efi_mm. The lass_enable()/_disable()
> naming would be more suitable for those wrappers.
>

Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
runtime regions into the upper [kernel] half of the address space.

SetVirtualAddressMap() itself is a terrible idea, but given that we
are already stuck with it, we should be able to rely on ordinary EFI
runtime calls to only execute from the upper address range. The only
exception is the call to SetVirtualAddressMap() itself, which occurs
only once during early boot.

