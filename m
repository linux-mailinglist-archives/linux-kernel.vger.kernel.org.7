Return-Path: <linux-kernel+bounces-677132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E853AD166F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 03:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D07716A51D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1155A1F61C;
	Mon,  9 Jun 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="RiLXG88B"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DE1FC3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749430923; cv=none; b=mUoYWafeS0536cV4Mhzc21qIruGf7MZEhL0fF+acpzo64FMHqu44MHBFELzbVmOjPUuElniEJwcsmO036gSX7U2Ym0ktnE26Ao4bvp44s1soPn6EYxp+1DmkQcBHa+Vxhzb3/11roeL40ttk9K1fL7/jGrJEJQ0Hlf144wKIWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749430923; c=relaxed/simple;
	bh=62QbUzFjx64g5vfBud5EFb1qLPMajBupVcx93RCvacI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u38+PHq1vgqAxllUD9BZ6+i+pVGu04yxYmZvbHNRdO43e1RL3mWcISg6+oIZVYwKJRaD6bHAqmnxwUZqcnJQtDJGRdwGfIjTWEunSCAxQPGlZWTosLtcUwoABma2/ktS7HHXCcPXl5R+pw5hBxQv9E8GwkpjHQFFUK8lsp9qdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=RiLXG88B; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1749430919;
	bh=bM1FuAwutJ/XU9U3yqDnYzeNLS1EQ8LX08NArNTlPK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RiLXG88B5CZwIkIRgwxz09WFiVurrmWE2P+aI7lZn5tRpb7TAnmWoze7e3eTwO9Ru
	 jBAU/Ach//d6vDOyUZCtn9qwfUz3fBuGQsFShpgZrfRfBP8ZkMnTPiSjxvzg757f9Y
	 BO0uPE/Ts36SE1uW55Ehh9l+Uzt7YI9FaDgqeLE5F/WorkD+rUsftJoL5C+SXHj+gs
	 +bYwOM2QLO2MLs4xhOB/tBrfw/p9zKasmPkT7H0YGhkg+iBwT5XmJuMlzE/GnX0lfB
	 BhbKUfUzWz9hx26cF3RsY7eRz6KSdFP5w8DhcpLaDZsAuEVGS3XbtShVscQhIHuK2j
	 EqIZAxDyb8ywg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bFttH376Lz4wbv;
	Mon,  9 Jun 2025 11:01:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: use always-y instead of extra-y in Makefiles
In-Reply-To: <CAK7LNAQvRFVOeQhVos1T-R-Uq9ekY9Fo7HS+D=TCZziLo5TpHQ@mail.gmail.com>
References: <20250602163302.478765-1-masahiroy@kernel.org>
 <3cebc3c4-dbaf-41f6-b98d-1d33bea2eeeb@csgroup.eu>
 <CAK7LNAQvRFVOeQhVos1T-R-Uq9ekY9Fo7HS+D=TCZziLo5TpHQ@mail.gmail.com>
Date: Mon, 09 Jun 2025 11:01:56 +1000
Message-ID: <8734c9wwvv.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Tue, Jun 3, 2025 at 3:50=E2=80=AFPM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> Le 02/06/2025 =C3=A0 18:32, Masahiro Yamada a =C3=A9crit :
>> > The extra-y syntax is planned for deprecation because it is similar
>> > to always-y.
>> >
>> > When building the boot wrapper, always-y and extra-y are equivalent.
>> > Use always-y instead.
>> >
>> > In arch/powerpc/kernel/Makefile, I added ifdef KBUILD_BUILTIN to
>> > keep the current behavior: prom_init_check is skipped when building
>> > only modular objects.
>>
>> I don't understand what you mean.
>>
>> CONFIG_PPC_OF_BOOT_TRAMPOLINE is a bool, it cannot be a module.
>>
>> prom_init_check is only to check the content of prom_init.o which is
>> never a module.
>>
>> Is always-y to run _after_ prom_init.o is built ?
>
> The intent of "make ARCH=3Dpowerpc modules"
> is to compile objects that are necessary for modules,
> that is, all built-in objects are skipped.
>
> However,
> always-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE) +=3D prom_init_check
> would generate prom_init_check regardless,
> and its prerequisite, prom_init.o as well.
>
> With CONFIG_MODULES=3Dy and
> CONFIG_MODVERSIONS=3Dn,
> and without ifdef KBUILD_BUILTIN,
>
> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-linux-gnu-   modules
>
> would result in this:
>
>
>   CC [M]  arch/powerpc/kvm/book3s_xive_native.o
>   CC [M]  arch/powerpc/kvm/book3s_64_vio.o
>   LD [M]  arch/powerpc/kvm/kvm.o
>   CC [M]  arch/powerpc/kvm/book3s_hv.o
>   AS [M]  arch/powerpc/kvm/book3s_hv_interrupts.o
>   CC [M]  arch/powerpc/kvm/book3s_64_mmu_hv.o
>   CC [M]  arch/powerpc/kvm/book3s_64_mmu_radix.o
>   CC [M]  arch/powerpc/kvm/book3s_hv_nested.o
>   CC [M]  arch/powerpc/kvm/book3s_hv_tm.o
>   LD [M]  arch/powerpc/kvm/kvm-hv.o
>   CC [M]  arch/powerpc/kernel/rtas_flash.o
>   CC      arch/powerpc/kernel/prom_init.o
>   PROMCHK arch/powerpc/kernel/prom_init_check
>   CC [M]  kernel/locking/locktorture.o
>   CC [M]  kernel/time/test_udelay.o
>   CC [M]  kernel/time/time_test.o
>   CC [M]  kernel/backtracetest.o
>   CC [M]  kernel/torture.o
>   CC [M]  kernel/resource_kunit.o
>   CC [M]  kernel/sysctl-test.o
>   CC [M]  fs/ext4/inode-test.o
>   LD [M]  fs/ext4/ext4-inode-test.o
>   CC [M]  fs/fat/namei_vfat.o
>   LD [M]  fs/fat/vfat.o
>   CC [M]  fs/fat/fat_test.o
>   CC [M]  fs/nls/nls_ucs2_utils.o
>   CC [M]  fs/netfs/buffered_read.o
>   CC [M]  fs/netfs/buffered_write.o
> ...
>
>
>
> You can see these two lines:
>
>   CC      arch/powerpc/kernel/prom_init.o
>   PROMCHK arch/powerpc/kernel/prom_init_check
>
> are supposed to be skipped when "make modules",
> but actually compiled without ifdef.
>
> So, I added ifdef KBUILD_BUILTIN to preserve
> the current behavior.

OK, that makes sense.

I don't really ever build just modules, so I wouldn't notice, but some
folks probably do.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

