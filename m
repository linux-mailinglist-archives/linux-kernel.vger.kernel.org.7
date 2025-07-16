Return-Path: <linux-kernel+bounces-734065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FDDB07CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F671AA5611
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7729A300;
	Wed, 16 Jul 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6IwQGWC"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA335949
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690091; cv=none; b=eZXXhzPftPWFYAD3sjHlQ6FIV53oBw191DMuJl75bQoXpLoMr54EUIHmweVYX8whW3fyqoIK2BfqjQnSZTfghe0YqWcMrDK+vtmZ7dLRTpApgiZUUhlbSnWYJefrmw99aISFg0FCgjwHFCtq4HAk+zkZqsu9MmvTF7Pdg6COu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690091; c=relaxed/simple;
	bh=aZRLE1RK5cffLZAs412eXdw+U5HQb0XWe75KFAkS14s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzrJjv+gthyNw8AI3NY5kKdijhDHkxl+UHFech0hv9QqqWD5X0KiBgpWGlSYhVfj5To+tLrA635AEEQHbtBl5ynSYDUStNfHSuTkGIhakWvdMWiZOuIkOFq09Oe5JKEenFmD7lDsmboSExuhppfDPwwydB38FIKF0KJH7JEkEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6IwQGWC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237f18108d2so28415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752690089; x=1753294889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqYy+Dz+71twI0him0hUjZk/6GLWJWbYmCSfdczxwFc=;
        b=p6IwQGWC+rw3gk2LaWxeC1IMtSOeqqekT+7iyKjHAh/rNsnjLvm8eziJ2LhHkeRNGf
         QV9k+6xHTStMyXlIExFK5w7QoYpjJ4CApmTw4zLHipaBIRdwAklY9XfXutc0EpOnktzz
         m/af/wj/+iLzJt7xFLCfdw6C9bp+7199eM3IqywB2inoVeIe9cxicOw+1XI/LzXkAlBz
         uNnwQz7tPWxIgxqPk0oiThD8D9Rr2w5UKlsqClPxxEKtE+MCB2yGVfFo2akWToE+aIn/
         ZhmmJF2nhcwaa+SCKgvfXjV43WR6F5mEw9kWFvVcWfHW4c0ptNJ5v3+qnHumuJp8HphG
         GpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752690089; x=1753294889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqYy+Dz+71twI0him0hUjZk/6GLWJWbYmCSfdczxwFc=;
        b=iz3lYwjRNKM/MKVIvbjmwf3A1Bve43sCmunpOL+ZkSuH87wfxO6dtmsJhRqDLaRa8X
         22O+uZ3A2IJiBqK3Qg/tpNsxqQrYG5jItVKeKScdXfh8V4/GJqJcQLmAzdBVVci2Z4bT
         FaRNQMSaNrgJj9OgF0kKV4WoRKunoKQNJGfBTII6nYGPRGXJsHcT1z5kbfs08PgFIIMe
         DnLYR5Qd4dIq34NQ8YsJ3puRn2XtPFrelex+HG/sQ6xAZCtTOnOU/wMFsAFIga8fAQsd
         jzXR71Z+YmYGlLDshcAF1NrUYPH6xyMCQ3nzndLObkkniC3mrV0HK5x/3nB/7gfz/uw2
         KEhg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ccUmyr+uAPI2jgtEMu1QbzbBDqA5+GRPAYK+qkK8N9pljHO0RQ3G2KYviHSP1gTe6gSDIF+N9FjbrFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JG0JHEstNGavgX/ZoxmDAswPGnj3jowXovvepPPSbK8vGZC5
	LzPCweWFHVYLLhnKbLyk9mYvBTMrd01VtxSJ7BPF1foGLZa+dUeQx05bVd5itc7Wbg==
X-Gm-Gg: ASbGncsNRftZtBnnM6DS+1IrjeQXPCnhuqSvirjsMsAuCXgNUhCRCLwEOEKn3jEkarm
	vNWJODNuUWDBcOdyp5hAZseOozM9t0WDlr4FScHIs42vk5C1vNvNHmzLHjaRmI2sJT3kBfCbrrF
	RatE+0gLRneOBegRLqEQzRNgXaifRq4uLaVk0DamkkHn8U5cHeuVxtDOpAZFl1EHMxFYDMsHych
	ntjBhs0PKYb/m1qQPIb3w0hbVvTRmf9PChIZrfJ29XhHYbUmpS/SRLPAfSWz9nqbMXfkKaBu1Ji
	BJKKkKVwRaEXh48bIJUu97Kshe6rE7B3a8W3zR5Bpi1aWeFYtaxmNnB9Qk7LwZBAnRTPZlZFGLG
	tb7K1zFyX3lfzkodJixmAgn7iO4uBOeZJFe0aNuBvnFGgjmMW8yutqFLQROVwrv8=
X-Google-Smtp-Source: AGHT+IGlMcCW/yVhugE6YAY332fyg5msAyrVkd1WM6bK1ZITZ1zHK/NiN+y5Y44tdPQTE58o+NEh5Q==
X-Received: by 2002:a17:903:3b8e:b0:231:ddc9:7b82 with SMTP id d9443c01a7336-23e2ffdd014mr186685ad.13.1752690088747;
        Wed, 16 Jul 2025 11:21:28 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ca786eac1sm1153352a91.48.2025.07.16.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:21:27 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:21:21 +0000
From: Carlos Llamas <cmllamas@google.com>
To: =?utf-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?utf-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>,
	=?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>,
	=?utf-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?= <lina.yang@unisoc.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	=?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Suren Baghdasaryan <surenb@google.com>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Message-ID: <aHftocnJcLg64c29@google.com>
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
 <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com>
 <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
 <CANiq72=v6jkOasLiem7RXe-WUSg9PkNqrZneeMOTi1pzwXuHYg@mail.gmail.com>
 <24e87f60203c443abe7549ce5c0e9e75@BJMBX01.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24e87f60203c443abe7549ce5c0e9e75@BJMBX01.spreadtrum.com>

On Wed, Jul 16, 2025 at 07:01:29AM +0000, 刘海燕 (Haiyan Liu) wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > 发送时间: 2025年7月16日 1:51
> > 收件人: 刘海燕 (Haiyan Liu) <haiyan.liu@unisoc.com>
> > 抄送: Miguel Ojeda <ojeda@kernel.org>; 周平 (Ping Zhou/9032) <Ping.Zhou1@unisoc.com>; 代子为 (Ziwei Dai)
> > <Ziwei.Dai@unisoc.com>; 杨丽娜 (Lina Yang) <lina.yang@unisoc.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; rust-for-linux@vger.kernel.org; 王双 (Shuang Wang) <shuang.wang@unisoc.com>; Andrey Ryabinin
> > <ryabinin.a.a@gmail.com>; Alexander Potapenko <glider@google.com>; Andrey Konovalov <andreyknvl@gmail.com>; Dmitry Vyukov
> > <dvyukov@google.com>; Vincenzo Frascino <vincenzo.frascino@arm.com>; kasan-dev@googlegroups.com; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Arve Hjønnevåg <arve@android.com>; Todd Kjos <tkjos@android.com>; Martijn Coenen
> > <maco@android.com>; Joel Fernandes <joelagnelf@nvidia.com>; Christian Brauner <christian@brauner.io>; Carlos Llamas
> > <cmllamas@google.com>; Suren Baghdasaryan <surenb@google.com>; Jamie Cunliffe <Jamie.Cunliffe@arm.com>; Catalin Marinas
> > <catalin.marinas@arm.com>
> > 主题: Re: Meet compiled kernel binaray abnormal issue while enabling generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS
> > on
> > 
> > 
> > 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender
> > and know the content is safe.
> > 
> > 
> > 
> > On Tue, Jul 15, 2025 at 11:41 AM 刘海燕 (Haiyan Liu) <haiyan.liu@unisoc.com> wrote:
> > >
> > > The commit changes the fragment and diff is:
> > 
> > An Android engineer should know how to handle that, but if you are reporting upstream, it is best to try to reproduce the issue with the
> > upstream kernels (e.g. arm64 is not in 6.6.y) and provide the full kernel config used.
> > 
> > > Only two rust-related global variables in fmr.rs and layout.rs have this issue. Their asan.module_ctor complied binaries are wrong.
> > 
> > I am not sure what you mean by `fmr.rs`. As for `layout.rs`, that is in the `kernel` crate in 6.12.y -- isn't there a single `asan.module_ctor`
> > per TU? Which object file are you referring to? I get the pair for my `rust/kernel.o`.
> 
>   NSX:FFFFFFC0800A7C94|F800865E  asan.module_ctor:   str     x30,[x18],#0x8   ; x30,[x18],#8
>    NSX:FFFFFFC0800A7C98|F81F0FFE                      str     x30,[sp,#-0x10]!   ; x30,[sp,#-16]!
>    NSX:FFFFFFC0800A7C9C|F00240A0                      adrp    x0,0xFFFFFFC0848BE000
>    NSX:FFFFFFC0800A7CA0|911D8000                      add     x0,x0,#0x760     ; x0,x0,#1888
>    NSX:FFFFFFC0800A7CA4|52803D61                      mov     w1,#0x1EB        ; w1,#491
>    NSX:FFFFFFC0800A7CA8|94233816                      bl      0xFFFFFFC080975D00   ; __asan_register_globals
>    NSX:FFFFFFC0800A7CAC|F84107FE                      ldr     x30,[sp],#0x10   ; x30,[sp],#16
>    NSX:FFFFFFC0800A7CB0|D50323BF                      autiasp
>    NSX:FFFFFFC0800A7CB4|D65F03C0                      ret
> The first __asan_global struct value is 
>  ENAXI:FFFFFFC0848BE760|>FFFFFFC082EDB180 000000000000005F ........_.......
>  ENAXI:FFFFFFC0848BE770| 0000000000000080 FFFFFFC0836DC431 ........1.m.....
>  ENAXI:FFFFFFC0848BE780| FFFFFFC082EEC780 0000000000000000 ................
>  ENAXI:FFFFFFC0848BE790| 0000000000000000 FFFFFFFFFFFFFFFF ................
> The address of the global is 0xFFFFFFC082EDB180 which value is '/proc/self/cwd/prebuilts/rust/linux-x86/1.82.0/lib/rustlib/src/rust/library/core/src/num/fmt.rs' and its viewinfo is 'vmlinux\Global\__unnamed_357'
> The original size of the global is 0x5F
> The name of the global is kmalloc-2k
> The module name of the global is 'core.27758904ccee4c80-cgu.o'
> 
>    NSX:FFFFFFC0800A7D4C|F800865E  asan.mod.:str     x30,[x18],#0x8   ; x30,[x18],#8
>    NSX:FFFFFFC0800A7D50|F81F0FFE            str     x30,[sp,#-0x10]!   ; x30,[sp,#-16]!
>    NSX:FFFFFFC0800A7D54|F00240E0            adrp    x0,0xFFFFFFC0848C6000
>    NSX:FFFFFFC0800A7D58|912E8000            add     x0,x0,#0xBA0     ; x0,x0,#2976
>    NSX:FFFFFFC0800A7D5C|52800961            mov     w1,#0x4B         ; w1,#75
>    NSX:FFFFFFC0800A7D60|942337E8            bl      0xFFFFFFC080975D00   ; __asan_register_globals
>    NSX:FFFFFFC0800A7D64|F84107FE            ldr     x30,[sp],#0x10   ; x30,[sp],#16
>    NSX:FFFFFFC0800A7D68|D50323BF            autiasp
>    NSX:FFFFFFC0800A7D6C|D65F03C0            ret
> The second __asan_global struct value is 
>    NSD:FFFFFFC0848C6BA0|>FFFFFFC082EECA80 0000000000000020 ........ .......
>    NSD:FFFFFFC0848C6BB0| 0000000000000040 FFFFFFC0836DC431 @.......1.m.....
>    NSD:FFFFFFC0848C6BC0| FFFFFFC082EEDA80 0000000000000000 ................
>    NSD:FFFFFFC0848C6BD0| 0000000000000000 FFFFFFFFFFFFFFFF ................
> The address of the global is 0xFFFFFFC082EECA80 which value is 0 and its viewinfo is '<&usize_as_core::f..vmlinux\kernel_9a6cb9fd7c8dfd66_cgu\<&usize_as_core::fmt::Debug>::{vtable}'
> The original size of the global is 0x20
> The name of the global is kmalloc-2k
> The module name of the global is 'kernel.9a6cb9fd7c8dfd66-cgu.o'
> 
> > Cheers,
> > Miguel

We have KASAN builds with android16-6.12 and haven't seen this issue.
Can you share your entire config file, so we can try to reproduce?

Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Maurer <mmaurer@google.com>

Alice, Matthew, have you seen this before?

--
Carlos Llamas

