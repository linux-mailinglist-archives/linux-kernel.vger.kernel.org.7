Return-Path: <linux-kernel+bounces-893420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BAC47577
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B443B5E24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2B3148D0;
	Mon, 10 Nov 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQQLCJ9N"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D5313E27
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786201; cv=none; b=eBp8guDjocpzbNflAtIhbBlG41d+KBktdKRNgIk5B+Jgn3ftoaq4ChToO82rqBjzuEnWODFftg05p8/KJf84f0w8Nk0VrzKeqvYjlFlCdERZUUkExqQQGBFiEnpXLvhPlcyYgL6CA88DRuSzoB8FPE0ctlczdMLNnS/GNxKIA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786201; c=relaxed/simple;
	bh=Gc+O81ogEJ7jg6lTwk7sikDMYWSEoZ1JuGrT/rBhWLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB0wwydw5gLSzN3Fc2bj/vATWFZlq73BY+PRPjVRIMy72RVrUGYkxXkrBOgsZG58rgkhyBr3bd4yb4a7idj6cesHaHmofer8dC/4oHpWn4kfH0euCuou8yDeR/9o41uZR5KshQAwM9qk6Awk2Ax4wpMuAY0X4yCDHg41H+6+hUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQQLCJ9N; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b98a619f020so2750762a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762786199; x=1763390999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuV15cVIkOZ3osUBoMrFPeh8PgM7VFfcDiPWWGwwe8E=;
        b=CQQLCJ9NAKA+ZD8OwPCqIA8xwisIvvCFH+VmBCDMZF2CAnMhlh5y80dLr2TtE878BQ
         p8xP10qKYiUdp6sojMSh+F8P1psQI1ZE44vANvNd8EbJumgLo1x0ZpZ7cFmeDhipmfeX
         OwevkGMZ1u+VSnr9QsKZYW+Qvt2qg3l0FDz1Ow4ofUtkN4do48GnRBbFtZmRv56RkMT2
         rXubGJAWAR8fzk7GLbqm9DYmPpMOb4wUwmVKAKBoy63zGfCF68/5on7lYo/S47EEw4C9
         BYt7DZYd9XRli6J9BhpZdxFPSqkB08TdWMYKPDZlhzNQaArTctHHLvVzz6jWkK3WkKxJ
         /EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786199; x=1763390999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuV15cVIkOZ3osUBoMrFPeh8PgM7VFfcDiPWWGwwe8E=;
        b=XTiAg9CCHEZRpgT36C2TKRbgfpAm8NH/QlDq+r5xSlbJUzsBHCltGk16lnYTCbOpe5
         uhGQWvgHD6MKpojDGedpGAhWhtE9jtBEkoT/CnaipYmLXwIWIRd7y+mS+xn1bbPxhXp3
         3G+Z0XVRpWtGLyLc63w/YnwnmhrAaSse3LPa2GRnr7/BqsOev/22N1kn2b45vszBkYYh
         c1IliuWDABd0liOFVWxDoMkssY8VVAwnqJUsyxnKZ5F6IxvaKTj1do2WvlWScV61E8qj
         CvhjF9R8fB7t4j3HqNbgx6cMJ/GrcwnyZlBBx7AsvjjqRnIVPKMggt3ZqsYuVlqz8GbY
         g4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUOoneH8kMmjPogznBjWQvdKdwrNLO8oR+qqjJWYbys0hOaaVSMaSQY8K7oN65ZTsEPYr6c+62gDrlj8xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbDCJUfIyVT5T9AX8mLN6xopN7nK+q1px2C2eYCdofnMf+2GQ
	+KWugRfFuV59pgoVflji+U0yKN3Clqw9boHfGDpXDOddaC4xRthiIBaR/As5AAQEgpaHJw17g/8
	vnXYDo/XSPuzO6E00LkMHXCESqU5egNoIiy1rEnyK
X-Gm-Gg: ASbGncsNTBqBlbe3uXDoCs3G8cwzl25IS1VTN+ApM6C9qzBW79J96jzvHz3TTWIXMqH
	sg4/Pt8KToNjMLZo3CSMuQ5Nb3zGNkxJ0axp1WusR3IpSDtxpXEFEvnblK0Ss4lhCDDfYSiJPfC
	UfvDE5J4AMf2qYdfWSj2j35Im3WnHy+TUcQ9EvfZPEc4jd5NreHVgS8nuZy+tkTcpqSyei4+/dB
	IknQE3ZIquVCw1S/+7U42IgOJfRMYUH2FgriLpDbV61ApbMfSjChyN7yttI63dcOTUrhPVUWYSx
	IzH+wGmXAHk/g4sW5MwHUqHxdn4=
X-Google-Smtp-Source: AGHT+IFJrWpsYMgqYHxsl7TDahL4sWC/rojvNE8jvjvqAW1DXIbEkhegStBh6RAJqXTedR75u3LJC4XuuR5ASPiDRjI=
X-Received: by 2002:a17:903:2f88:b0:295:24c3:8b49 with SMTP id
 d9443c01a7336-297e56cf5bemr117461485ad.46.1762786198920; Mon, 10 Nov 2025
 06:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <81848c9df2dc22e9d9104c8276879e6e849a5087.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <81848c9df2dc22e9d9104c8276879e6e849a5087.1761763681.git.m.wieczorretman@pm.me>
From: Marco Elver <elver@google.com>
Date: Mon, 10 Nov 2025 15:49:22 +0100
X-Gm-Features: AWmQ_bltIHaW2m2Y_rXOjdB0rjwB0avPjx0FCrIDnvZhp3yD5E0mxdw5HHzg9_w
Message-ID: <CANpmjNM+ot5A-pRLhV6Esn=QvCeCStd9fG_pgwrVA=6pxD8aqw@mail.gmail.com>
Subject: Re: [PATCH v6 17/18] x86/kasan: Logical bit shift for kasan_mem_to_shadow
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, pankaj.gupta@amd.com, glider@google.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 21:11, Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> While generally tag-based KASAN adopts an arithemitc bit shift to
> convert a memory address to a shadow memory address, it doesn't work for
> all cases on x86. Testing different shadow memory offsets proved that
> either 4 or 5 level paging didn't work correctly or inline mode ran into
> issues. Thus the best working scheme is the logical bit shift and
> non-canonical shadow offset that x86 uses for generic KASAN, of course
> adjusted for the increased granularity from 8 to 16 bytes.
>
> Add an arch specific implementation of kasan_mem_to_shadow() that uses
> the logical bit shift.
>
> The non-canonical hook tries to calculate whether an address came from
> kasan_mem_to_shadow(). First it checks whether this address fits into
> the legal set of values possible to output from the mem to shadow
> function.
>
> Tie both generic and tag-based x86 KASAN modes to the address range
> check associated with generic KASAN.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Add this patch to the series.
>
>  arch/x86/include/asm/kasan.h | 7 +++++++
>  mm/kasan/report.c            | 5 +++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index 375651d9b114..2372397bc3e5 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -49,6 +49,13 @@
>  #include <linux/bits.h>
>
>  #ifdef CONFIG_KASAN_SW_TAGS
> +static inline void *__kasan_mem_to_shadow(const void *addr)
> +{
> +       return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> +               + KASAN_SHADOW_OFFSET;
> +}

You're effectively undoing "kasan: sw_tags: Use arithmetic shift for
shadow computation" for x86 - why?
This function needs a comment explaining this.

Also, the commit message just says "it doesn't work for all cases" - why?

