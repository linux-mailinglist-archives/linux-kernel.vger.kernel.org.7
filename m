Return-Path: <linux-kernel+bounces-840668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A089FBB4EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB08188E647
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279127A44A;
	Thu,  2 Oct 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUMrSvKv"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39812C544
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430910; cv=none; b=sri1atYW5nXxV02Y6eygR/8lV3E5w79/+jqRwoRBYtXt88IRa2kokaExuAE+4JPv28Gfji71Ds17o06SGL3COvdxP7ZjFSl2P/Fq0yZn4YYZqoFK/6fzKss10mLcJaM1hO5Qhv4fxRVcwc3DWOcQq1xTRWP2s+0hUqsk9KIPTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430910; c=relaxed/simple;
	bh=doOvg/9J4AUYwzmUXltPYDkCP5ehIFVQlI77JtYdodY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIXD0EvowPucq+wlaPO9wITCHH/czYZFSBRrQ2lBjx83ExMbd4xhCKKYJt6qiNG22xSITT0XAVo1m3rfQKEqJqSrCER2amamgQ4sPIrYiUVQq4EwpBB28Dv1TRBC5MVn9pQGFjuEse3M6JOHBYNetUCod+w/3EoOMcLqFY62juI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUMrSvKv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42420c7de22so845709f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430907; x=1760035707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgjf4Q8TmMxBgFclVgV3Hi99Hhu3hDBuYkmCSxYCGGs=;
        b=VUMrSvKvH42kNeYxO3CURO3jIlY+hKi5ZVACWW0HOxw8sMp61LVIQzM3vFNTY9s9ns
         uNspZRAb5hWzaHMugEmjLMKauzhoseYEG6MvWENkXZ/dDvgIi+y1aDKUMmmzrFDozJwO
         YrS7yDwGbU5KhrxT+Y+YTHEFhfHTwbBOdBc68EjzNryhjRExhJnQ9KYrvovc40yCEvJ8
         mYvkdUE0uWAiN+/WKqwFzhroI0bxR39mCddIFsu7OGpZUTXSBFKO5G7F8VDGdW50csHj
         CWLfIqmGKWxp8ISTUFniitcJegdmmvpMk7SVESOOzJ5VyFYyC7/pzzBGqxI0Q9Uph0Kr
         iaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430907; x=1760035707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgjf4Q8TmMxBgFclVgV3Hi99Hhu3hDBuYkmCSxYCGGs=;
        b=ZJI9o9+VNH5VRK5/MgL9pG+bf6q8noHIndQYb7Qx9U4HgnNZJBDZz/3WTsZTWT386L
         lSZo3wIYFPryCSoZhx/V8i+s2TJ1fjc+UwCaDPS3+FLhPUTvsg0vvqXANvKpVYbwbG4k
         Q9MSj4m3JY0r6QAQQQJ16Y2b4hnsy+5qpJG/0QlQCcMr1VctZwnX5vw2o51AWT2blqtE
         1v8PIvhLkdgRRQhQXtU+UTsn5Qnnk3Jn5+6iV46ET+1B7p7XxLr1j1t+zEFVxDNYVDo/
         HNyUSi9G2/DUJnASPNGPX7DZYeqNXeykD/Bc3XxUhsMMYl7KPIyQnVItNYy6t9j1Hwf5
         nNug==
X-Forwarded-Encrypted: i=1; AJvYcCXj5M6bBVyLYJY5LP5mcw4aug3cMzupwxb691m3muxW788zhpehDmd7LOXp+6h8Ip07KVCIa5BvxmyUjp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynXHLQz6FZhdIEqwmcD+LTwluAEONsMGVzMUiDoBQK2X1pzwnA
	cuPmEmQazfv52TSwO4jPRKpeZpUbEj/qScONdlQyKlqVD/tWEyBXNZ4g
X-Gm-Gg: ASbGnctBTFcAskn2fT6vhKra58AH9y9JRIbFJG80r1HHJp8FJvEMDX+o3hYSFL65eUx
	vKIi2aiHuFEv6k2E+xSXhTW6I4e1UVnfAQlUvmsRsWDKVLQQ1yBPbPzndu04md/cv6HO4GcJv7k
	Y42SHwEAlcFadyDVZeiEErYMfX6Xn085BEh/UHzmZCMT0GumfUaqjCU+GKNWig9T9Dp9AnjwBSp
	v7EywyUe89ot+7Jvdjs6NMrccMRFSwu+40OefIzUOdbyvcM9xORS3HBBMeubTEzTrtt4Xido5so
	Zgk/piHPBOWfQVcvs5gn/cYq8LUyY0B9/M6u+ozqRwOqdf1nmNvNBf2npH9mYaygr8x7/OrpbW7
	WyYvqi3YS2D2jE2LtPmQtBJie0Dl4Xle+SS+XemGqXJ64e1rL+LiqZrmWQQMc0lyVYr4EZoJMcT
	muL08uR566Dika
X-Google-Smtp-Source: AGHT+IGPZyy98EunzVJ6yivTxgcZu+hh+n+arOejBmpGA2ZRyOHrbEnCoAuwnsGkUwYPhwrqhwXocA==
X-Received: by 2002:a05:6000:603:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-4256712a5dcmr209162f8f.4.1759430906615;
        Thu, 02 Oct 2025 11:48:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm4640243f8f.43.2025.10.02.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:48:26 -0700 (PDT)
Date: Thu, 2 Oct 2025 19:47:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Nathan
 Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel
 test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?B?QW5kcsOp?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang
 < version 17
Message-ID: <20251002194734.7cb2be8e@pumpkin>
In-Reply-To: <CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
References: <20250916163004.674341701@linutronix.de>
	<20250916163252.100835216@linutronix.de>
	<20250916184440.GA1245207@ax162>
	<87ikhi9lhg.ffs@tglx>
	<87frcm9kvv.ffs@tglx>
	<CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
	<20250929100852.GD3245006@noisy.programming.kicks-ass.net>
	<CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
	<20250929110400.GL3419281@noisy.programming.kicks-ass.net>
	<CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
	<CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 08:53:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 29 Sept 2025 at 04:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >  
> > >
> > > Ah, d'0h indeed.
> > >
> > > void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto(""::::l1);return 2;l1:return 1;}}

Should that be 'void *c(void);' (with an extra void) to avoid failing because
of the K&R function declaration?

	David

> > >
> > > Seems to still finger the issue on x86_64. That should build on !x86
> > > too, right?  
> >
> > Thanks, builds fine on arm32, arm64, riscv, m68k, powerpc, mips, s390.  
> 
> Ok, I just applied that fix directly. It's clearly not a fatal bug
> since it just falls back on the non-optimal code, but it's one of
> those "silly and subtle code generation issues" so I'd rather have it
> fixed asap in the upstream kernel.
> 
> Geert, thanks for noticing.
> 
>              Linus
> 


