Return-Path: <linux-kernel+bounces-802006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB72B44CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08741C249C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48772255E40;
	Fri,  5 Sep 2025 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMA9ktnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4128E0F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757046852; cv=none; b=Vn46BlhMFk2Majh6ClJ2jkO2XHnmPmE2wZG8OqXlknb1t6urReXB2Ea6xmdJSTYUuQ5MSE4XaEyUAkD5BvHs8oqXhqJ/DNGacAVEiopiwEWoqNNU2zUHhvGPaTHpiLIp/Z+G51AsUm6JuQQrzNUD16t+PfvggYL6lA+raun8PQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757046852; c=relaxed/simple;
	bh=93eYOwzmhYqlVId6ScwG0fiTFyob9ZihP0QmlRDRW0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehuS5KDbunnnl031W2EIs3QjBkmQDXOCQuMy5VE7YbOYgkUaOKTUJVIjnSIZj67PIhcNaYqsMXeHBaDJiyzlZ60CVsS/8vGtKS0k90TBgx3cOCnLbJInvOSHFfMbcbUceUgpyItzq+OwbgC6RG5VO6J5TdOG3FLzDP1mhfsDYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMA9ktnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BADC4CEF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757046852;
	bh=93eYOwzmhYqlVId6ScwG0fiTFyob9ZihP0QmlRDRW0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qMA9ktnbRuyc9CxJoNhUOhr0XDdk8khX4Bb/VwkOgm+3qiC447l2CoT1FB+ZL3V8T
	 CEKUqRjUOXxx0Ct0ShTUZK3lR2uFnzm5Q+n8BTGneuc3CMv6kRMrRCU06aR3oqQT3b
	 C8fTG0laYAIqySsqtsEVXG+ykTDCz5KLHTjVFi/we5M+XJA/jB7pQhvkj7kUAikXdA
	 zudbG1A7+hlHIgZGNcdSay8hgLSoqB1IheyCk6Z2Hvvr5gigFHXSgONlLulezMqpH5
	 AkDcQx0piyp2DCSzAwwSb1yygpobmHetCANaZg7UW3HUUfgwX1TRzyVuXnY8uYNLLz
	 Ac7+SLzgFZvgw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cf8280f02so2541150a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:34:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3PMw15vV7Yu1eTEqgyzt3xBQGBrPhixMG7vdY698A/KsTeFd2g+XfKJyj+99ay5YbpNOUbmLrXF8iGlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJah+4Y/SoscewyI5JVt6BYGJydX70OvjKoxWyRn4yFSZRP5Ka
	zC2f0S9LyCXqrYmyGxcetu5u4SupGcaTvmTIHYyQfKeQcoMAJv+AxsPiYP2gLeBxu4XIfk94Ad8
	CMoDfHx0t3MUTF8LLF7VdSWMTFt7hp+w=
X-Google-Smtp-Source: AGHT+IEYnRnv6QyrFFLhU335oaNE1Pi7Pbzml+RbS5eygSj1BA3oxMC/GHg7k/yIqAzQswqXkSslAQ5J0kbs6d1oqdo=
X-Received: by 2002:a05:6402:84e:b0:61a:9385:c78b with SMTP id
 4fb4d7f45d1cf-61d26ecf561mr18232926a12.38.1757046850740; Thu, 04 Sep 2025
 21:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn> <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
 <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn> <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
 <CAAhV-H5u4xHcuLhyPe+a_YqPoCX2uVoqcW94i=HvU1NooL_efg@mail.gmail.com> <mqyjt5cabahlvezowt6plurkyrrbputvg776rhgaxhpwsqnuq3@onr5svx5heuf>
In-Reply-To: <mqyjt5cabahlvezowt6plurkyrrbputvg776rhgaxhpwsqnuq3@onr5svx5heuf>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 5 Sep 2025 12:33:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Cntwxo2XcPtB+zH0VE5J3N=Wb2Ad8RZ6DjwopGsXALw@mail.gmail.com>
X-Gm-Features: Ac12FXz9jRiihPx90RyWQNG9n-1NNt8T63C-bXFnz9VDkt98kudWbfYzJncG-SY
Message-ID: <CAAhV-H6Cntwxo2XcPtB+zH0VE5J3N=Wb2Ad8RZ6DjwopGsXALw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Josh,

On Fri, Sep 5, 2025 at 1:26=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Thu, Sep 04, 2025 at 10:17:11AM +0800, Huacai Chen wrote:
> > Hi, Josh,
> >
> > On Thu, Sep 4, 2025 at 3:17=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> > >
> > > On Mon, Sep 01, 2025 at 04:31:36PM +0800, Tiezhu Yang wrote:
> > > > On 2025/9/1 =E4=B8=8B=E5=8D=884:16, Peter Zijlstra wrote:
> > > > > On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
> > > > > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exi=
sts
> > > > > > the following objtool warning:
> > > > > >
> > > > > >    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > > > > >    falls through to next function __efistub_exit_boot_func()
> > > > > >
> > > > > > This is because efi_boot_kernel() doesn't end with a return ins=
truction
> > > > > > or an unconditional jump, then objtool has determined that the =
function
> > > > > > can fall through into the next function.
> > > > > >
> > > > > > At the beginning, try to do something to make efi_boot_kernel()=
 ends with
> > > > > > an unconditional jump instruction, but it is not a proper way.
> > > > > >
> > > > > > After more analysis, one simple way is to ignore these EFISTUB =
functions
> > > > > > in validate_branch() of objtool since they are useless for stac=
k unwinder.
> > > > > >
> > > > >
> > > > > This is drivers/firmware/efi/libstub/loongarch.c:efi_boot_kernel(=
),
> > > > > right?
> > > > >
> > > > > Why not simply do something like:
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/f=
irmware/efi/libstub/loongarch.c
> > > > > index 3782d0a187d1..082611a5f1f0 100644
> > > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > > @@ -81,4 +81,5 @@ efi_status_t efi_boot_kernel(void *handle, efi_=
loaded_image_t *image,
> > > > >     real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > > > >                       (unsigned long)efi_system_table);
> > > > > +   BUG();
> > > > >   }
> > > >
> > > > At the beginning, I did the above change, but no effect.
> > > >
> > > > The first thing is to remove the attribute __noreturn for
> > > > real_kernel_entry(), otherwise the compiler can not generate
> > > > instructions after that.
> > > >
> > > > But there is an argument in the previous RFC [1]:
> > > >
> > > > "From my point of view this is incorrect, this function is indeed a
> > > > noreturn function, and this modification makes LoongArch different =
to
> > > > other architectures."
> > > >
> > > > Josh suggested to do something so that the EFI stub code isn't link=
ed into
> > > > vmlinux.o [2], it needs to modify the link process and seems too
> > > > complicated and expensive for this warning to some extent.
> > > >
> > > > So I did this change for objtool.
> > >
> > > I don't like adding these workarounds to objtool.  Is it really that
> > > complicated to link efistub separately?  That seems like the proper
> > > design.  vmlinux.o should only have real kernel code.
> > I don't think this is just a "workaround", ARM64, RISC-V and LoongArch
> > share the same logic in efistub which may be different from X86. When
> > ARM64 and RISC-V add objtool support, they will also need to ignore
> > the __efistub_ functions.
> >
> > The other patch is similar.
>
> Objtool expects/enforces certain rules.  One of them is that vmlinux.o
> is proper runtime kernel code.  efistub is not that.
>
> Is there some technical reason why vmlinux.o needs efistub linked in?
I think so. For example, EFISTUB prefer to directly use screen_info
that defined in vmlinux, see the comments in
drivers/firmware/efi/libstub/screen_info.c:

/*
 * There are two ways of populating the core kernel's struct
screen_info via the stub:
 * - using a configuration table, like below, which relies on the EFI init =
code
 *   to locate the table and copy the contents;
 * - by linking directly to the core kernel's copy of the global symbol.
 *
 * The latter is preferred because it makes the EFIFB earlycon available ve=
ry
 * early, but it only works if the EFI stub is part of the core kernel imag=
e
 * itself. The zboot decompressor can only use the configuration table
 * approach.
 */

Huacai

>
> --
> Josh

