Return-Path: <linux-kernel+bounces-746403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC040B1263E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3816545C35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB407DA6C;
	Fri, 25 Jul 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqEc1J5J"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C12E3719
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479988; cv=none; b=aLBFJUEaMh2VzKVEsL0W67y1sgnCr0abkJH1ivEZhyB+QpRBVlNmXQC5w8P0uYipbbuPhSLZC+fBegGMzG4Qnfa/71FuDtBZz1QiGAlvn4FofqVQ7qNl/JP9cvDN/4AyjUwS69qPo5YxM7EykpOlUgDM98L7TXn9b1PiqGxrMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479988; c=relaxed/simple;
	bh=0btOZmv3xOMch4NMZi9nCN3MVJ7OULZqhtcA5UAScHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulAj6lKQaOc2S4VpsWjpKTcAcZh9ANmAwZIweyEEBdrjPpVEdC+KyqpgUJyXOKuYtj2GSflqEaytXPy/8f2xr3ApHmFxbmg+biVyHjx0Cvy8W91EbL2Wu9L/lFxQaue/754yu3C7ZiTYcGzolTFdu3g4m7Cfkp6bjh0lAAtz8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqEc1J5J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b77901b4d2so277321f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753479984; x=1754084784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6X0Cnr0OsdmlUIarj6Z8348d39+RkJURZdHAvpueQI=;
        b=KqEc1J5J27jHffq/IQAHUCQEEE4Ze3XAoqeaZ3frMx8MlorYo5vyTZKA7rFyeoEb+e
         /nELXfnBgBQzuCgZqxutnk7AOYHxwUnHQHp+Cg1pEeaurAsz4dPM/Dvv+sl6huaTFK+Q
         81FUS4Ue6eJMZevctc8w18wVYI5UoHcCTWgcDh6OiIvNVRBVRv3dB3WEFFjlGsd2IZYw
         tT4kOVzbjbNZ89Sw/S/TKuxxd07UN9T4lQp6lfvjfMsI2W8PSCzpG1+mZxfP9b4Y7UCl
         13+IieD2pkMolMPE158mwExbaGs6KXID3L0Qo8cRFlOoeHnTW0Fg1lvw7+u79tcdr3E+
         /ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479984; x=1754084784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6X0Cnr0OsdmlUIarj6Z8348d39+RkJURZdHAvpueQI=;
        b=JexZxhShUx+fIB1DDfVZ3midwnb0NfD7r2I4RqXevWk6FtO78uo7Njvc5h2Y4wwUAK
         qnKHxNm/ay9re61zNYPJklzrnOo0fLKd221VauOWIdp049Nspcj+5IhmXDfbyVOV398A
         b42ag7y8mqrFrugaROzzGVUZCvmlzzOSM5ZWRNF3fF1Is/5CO+8+3d56TSeS06vfeG0N
         jy/qKSs9nPrusgdIvz1/fb85LgN8wrOeYJ5kBtpD+RmG5KjJPqGghlPQ/k3GrNOq3MZy
         9jfoC49rmoMtv2lKhCUIPLdvHp8Ar4nlkQW3lpqMuJqvPkiwlGtG/O+o0hT0K698r32b
         PNOw==
X-Forwarded-Encrypted: i=1; AJvYcCWbpVrpauL0qtNHaTIwbnaamWptIpAAL1pNvlDisd58TfG9oMCbVum1edq7ufxtc4TiIfGvBIGZZSwZFBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2YrZOsBas3/nTXvn9mbiMRNOCO/jnim+OK+640LNqe0u/AFq
	5270Wy8oQJ5WscON3EOTLJ65e11ZJax1G2uy/+4AKcddLti050geel1I
X-Gm-Gg: ASbGncsozYVxoHa+dzS1CS/k19ns/xUTDgtSYKORjRFvn2B/6Ea2RLkELOQ9oz1r3Bw
	ZFL5TydgNl30AsxyjsGOBYJdONpbdmFLdf44lWWZzuT1L1SYk7ysllSlhTcS7pTjVsMWguh1/us
	J4WttFddtcQ5uty/M1aChvclmvVPmy5n1uC2b0nHp3GJmheazWNDcJqt0LY1UXXZrCpStv0ZRbZ
	n6abuhc0RZI0L8Q+ZKnhaLM7KA7uc4+l/9BNz+6Sg91pPzQPwgi9AFU+jai1mOHKesnELDzIP6Y
	y4zoJo0zA1+yuSoO5eW6oMolO1Vct9KHlqB+nduZuyvtn5LVDQuLZn0IndfEy9SCi3eyAfYx+k1
	G/PuEN9+Cw/e/cgN/gIKcLzMM03q58Kp34zyTMaTYC4sB85FK+G/r/pnQbKhW
X-Google-Smtp-Source: AGHT+IFE3N9Ep+3jJbrxv9ADL61kg89xfua+c/o9yaR+jau6xarwlqDh72VNkw00oPlnJPRFJHsupg==
X-Received: by 2002:a05:6000:40de:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b77671c5fbmr3334447f8f.10.1753479984375;
        Fri, 25 Jul 2025 14:46:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04546sm867730f8f.53.2025.07.25.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 14:46:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 22:46:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250725224622.2d718f12@pumpkin>
In-Reply-To: <20250725101201.GA8700@redhat.com>
References: <20250722105034.GA2845@redhat.com>
	<20250722130947.0c97c96a@pumpkin>
	<20250722132147.GB2845@redhat.com>
	<20250722230341.5a1cc5e5@pumpkin>
	<20250723093825.GA12884@redhat.com>
	<20250723224831.4492ec75@pumpkin>
	<20250724081125.GA10980@redhat.com>
	<20250724082547.GB10980@redhat.com>
	<20250724111426.GA15444@redhat.com>
	<1225B7DD-BF29-4091-A956-FC312679E9BE@zytor.com>
	<20250725101201.GA8700@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 12:12:02 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/24, H. Peter Anvin wrote:
> >
> > On July 24, 2025 4:14:26 AM PDT, Oleg Nesterov <oleg@redhat.com> wrote:  
> > >Finally. If we really want to optimize this function as much as possible,
> > >we can add the CONFIG_CC_HAS_ASM_GOTO_OUTPUT version as Peter suggests.
> > >I guess this should work:  
> 
> ...
> 
> > >> Forgot to mention... Not that I think this is a good idea, but if we don't
> > >> use BUG/WARN, we can probably add EX_FLAG_ and do something like below.  
> 
> ...
> 
> > Seems good to me.  
> 
> Thanks, but which one? "asm goto" or EX_FLAG_XXX_AX hack?
> 
> As for the latter. I took another look at asm/extable_fixup_types.h
> and it turns out we don't need a new EX_FLAG_, this version
> 
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		u64 q;
> 
> 		asm ("mulq %2; 1: divq %3; 2:\n"
> 			_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_IMM_REG | EX_DATA_IMM(-1))

That should be _ASM_EXTABLE_TYPE_REG() with an extra %%rax parameter.
It works because ax is register zero.

> 			: "=a" (q)
> 			: "a" (a), "rm" (mul), "rm" (div)

The "rm" should both be ASM_INPUT_RM

> 			: "rdx");
> 
> 		return q;
> 	}
> 
> seems to work and I guess it is the absolute winner performance wise.
> 
> But to me the main question is: Peter, David, do we want to add
> BUG and/or WARN into mul_u64_u64_div_u64??? If yes, then this version
> won't work.

Looking through the code in extable.[ch] there is actually scope for adding
an extra EX_TYPE that is the same as IMM_REG but contains a WARN_ONCE().
It would be a 'global' ONCE for all such traps, but that probably doesn't matter.
The easiest way to make it 'per trap site' is to modify the 'exception_table_entry'
itself (eg change the type), but that might not be acceptable.
An alternative would be a special EX_TYPE_DIVIDE_OVERFLOW with an explicit message.

Probably best to leave all that for later.

Perhaps more useful would be adding an 'int *overflow' argument.
If not a compile-time NULL then set to 0 on entry and -1 if there is a trap.
That would need the 'jmp in the normal path' asm version - so two copies
of the entire asm block.

Another one for a later patch.

	David

> 
> Oleg.
> 


