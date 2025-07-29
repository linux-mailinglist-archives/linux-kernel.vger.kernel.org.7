Return-Path: <linux-kernel+bounces-749840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4FB15380
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA85D16D90C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FA1F09A5;
	Tue, 29 Jul 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gzDn3xtY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKaVkRm3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CFF507
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817780; cv=none; b=QMClDkbyqkd7Sor1HumStj+FIJNk5AkVLH2LdJVNp0NbqhgEFDSjNvhPKpZS5L1U8Os8T3GDxmWJqKhB6AOPeZe5V7kNXH/LCpqSZzAB0IWM0vz9Bf2tb1y/46GZucod9qv/OqqFK2iKhn6MkFrRXhxk0pJ16D8iyB18y0A3wHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817780; c=relaxed/simple;
	bh=W/6GpMRvp7r4zKqbYsAD5P54YdktEvwlmdqniXGtJ3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+aISUiNlmPWVhJiqKnosYGBN7fMMiXy4rY5R2PPdjnSq7R/4Ax4+UTf8G1jWPwnap7UvBYxuIjAPTWq4koxLuFq/eGOBa7g90eNXpijqHoLj2Kcy8Ve8jJS0J66jSVUjMGtY07j+hywnxcMG5T9hJpVpEtuu1Rq3b5yZT3yKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gzDn3xtY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKaVkRm3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753817776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c67dvKwqlAeEuJEgZ3sDHdX66s9mGP4J8q2TqKuwAnc=;
	b=gzDn3xtY+Qz6e/FB9KJkbR0EvMT8AnYBRjiGJuabQQHX0cRb69iWX7ia3stMRNMSKWshJJ
	e4wOaFosWUJ9QaxHj47JcGBs87zu4wbAE+XAa75H0RQrLVW90Px0sz8Ga4Wcyhoa1Kw3iN
	ITf94mlO/kI5i4yUFE8w2LoQquu0i7F/YTR7fQUtM1PTCkWYfoPFK5NK/gBcS/HQz+FAGC
	DO3OIvPsEUUHeUI3bv1KLbLhGZmibXW4vNr7VklWQM6MzN7gVmJsN16pu/Bwn6b/qX/KPV
	77M/C13M8VrPCNyF5NMelI57Q1UKyvC8Bg4hgEZBhpI3kEM2L2YtoYd65F7nZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753817776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c67dvKwqlAeEuJEgZ3sDHdX66s9mGP4J8q2TqKuwAnc=;
	b=gKaVkRm3eE7eNxgYnSoeP692NrDCJHiM7FbmdiKh1/Kb+sP0s84iacxw/rfldmoPuxZn3w
	dWuesLPak6Nof6CA==
To: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [syzbot] upstream build error (23)
In-Reply-To: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
Date: Tue, 29 Jul 2025 21:36:14 +0200
Message-ID: <87cy9ikcwh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 06:43, syzbot wrote:
> syzbot found the following issue on:
>
> HEAD commit:    86aa72182095 Merge tag 'chrome-platform-v6.17' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=171674a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3816ffa0a2bab886
> dashboard link: https://syzkaller.appspot.com/bug?extid=5245cb609175fb6e8122
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
>
> arch/x86/kernel/setup.c:1251: undefined reference to `efi_mem_type'
> ld: arch/x86/kernel/setup.c:987: undefined reference to `efi_init'

Cute. So the code has:

        if (efi_enabled(EFI_BOOT))
                efi_init();

in the CONFIG_EFI=n case:

static inline bool efi_enabled(int feature)
{
        return false;
}

efi_init() has an unconditional forward declaration:

extern void efi_init (void);

This has been the case forever and has been optimized out because
efi_enabled() evaluates to a constant.

I haven't checked which sanitizer option causes GCC to compile this
into:

00000000000000d0 <efi_enabled.constprop.0>:
}
extern void efi_find_mirror(void);
#else
static inline bool efi_enabled(int feature)
{
        return false;
  d0:   e8 00 00 00 00          call   d5 <efi_enabled.constprop.0+0x5>
}
  d5:   31 c0                   xor    %eax,%eax
  d7:   e9 00 00 00 00          jmp    dc <efi_enabled.constprop.0+0xc>

and to keep the call for efi_init() as a symbol for the linker to
resolve, which obviously fails.

If I change the efi_enabled() stub to __always_inline, it's optimized
out.

Disabling CONFIG_KCOV_INSTRUMENT_ALL makes it go away. So GCC confuses
the optimizer when CONFIG_KCOV_INSTRUMENT_ALL is on.

The kernel is full of such inline (not __always_inline) stub
conditionals which evaluate to a constant....

Thanks,

        tglx





