Return-Path: <linux-kernel+bounces-786692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35463B36341
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C4B8A80C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64B343214;
	Tue, 26 Aug 2025 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaN05jrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481423431E7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214341; cv=none; b=qItC53+QwL0hs7Tx26PCPE9TlTwTbt6Wup29EM0iDiWuOVULhJy4fRI1o8gzMJlukCmAONTv7uAYz+N+0V05Ku6C/5yKgAqo8cQwbdjJlOdxWHzESuxyAFUmLdyOY/b37bmjSXU5SYHTzUCpZJFUQm25V4q62JsvsGEy6YjC0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214341; c=relaxed/simple;
	bh=ApjG81rInNjF1hqd0jas1HuWqCbxWWM3TdhQAfyik1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHB0hZ7wtA8r4nexS4t6Rw5sDcOFAZAiB5rdhvUoA8liojVNFrmONKO6Lzw5q6DjS/xAsTyAs4OyVmbsQMAP9nrn5mcORaT/8WB16tRvgREJ9d5rSY0yssfWS2TURwMHSWzwKpr1AjqW0i2lEbUBG4jyRvl0HjCULNdn8eTqp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaN05jrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131B9C113CF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756214341;
	bh=ApjG81rInNjF1hqd0jas1HuWqCbxWWM3TdhQAfyik1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OaN05jrq4bi1inIfwZLBoKx3WxbZFy61nC/Ox+qKesHiHM6B4L6RWfQ64JcvKeHvv
	 /EqU5YKXp5d7VS83bfrTVG46y4RQnGER8zHlVVkVoAMMDpnrCl8cNAwQorbMB1xixn
	 toSpYUzly+7E+/79KvJcMe7eBFMDvQAWahfshq9YyxeKfdXyRcIgD7Lkx9MusAEDsA
	 b+c1ti+XfMLpGeR427/4gdcTNL5sl+jVKEIxIGF5BR8c7Z+Hf8UhemVq91qqos/UDP
	 IV09e6418LoxBEv7kdyUg9iZMSSHy7xrYZr8utXhtGCZ+sx9WDQBiUrsDMAw1kBpBV
	 suB+kG/vNWNFA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f4410f7c9so2283100e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:19:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj/5uDxGsIYL0EM8fSYEBOL0wIpSB3VY9e++3+AuHhp7XNfQDa6xkGP/rNXkHbjewDBgqUuqIo5IHmm1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m30cQj0SLNROihq86M6tjZ8Tr0C2jZ7+efciz6Vgq/ePYSPm
	Zyx+oUex1sArKtaq5qWlAOwAZza3x2YAfiHXqJwNTcJe11Cgm0LDEJTC3wO0MZSiLhIKIBP6/hN
	COZl1K4jDp1jr9vHHt4t71ybAudVeqmc=
X-Google-Smtp-Source: AGHT+IHXfrp3kCO8WaAYTKzmpHz9Y3xyqEAYoduTi5fzZtjnKLnhuV4OCEfMD69+6cml/MqmaABjcDK3g2CbLyEpMrk=
X-Received: by 2002:a05:6512:61d0:20b0:55f:34e8:b1b0 with SMTP id
 2adb3069b0e04-55f34e8ca18mr2581628e87.15.1756214339485; Tue, 26 Aug 2025
 06:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-bump-min-llvm-ver-15-v2-0-635f3294e5f0@kernel.org>
 <20250821-bump-min-llvm-ver-15-v2-3-635f3294e5f0@kernel.org>
 <35178205-7cff-4b4b-abdd-b4cfb9e69dc2@app.fastmail.com> <6b2c0063-1523-4644-a32c-6aa918ad9dd8@app.fastmail.com>
In-Reply-To: <6b2c0063-1523-4644-a32c-6aa918ad9dd8@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 15:18:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEOmvUx8f=_v7_AFhMLobtauSw20t76sEDmzays4NLQnw@mail.gmail.com>
X-Gm-Features: Ac12FXzs5STcbVyw1zGnE4IpQ5_3OWRNRisWxOHjyZfN8oZRJqnrrFNRfifbWv4
Message-ID: <CAMj1kXEOmvUx8f=_v7_AFhMLobtauSw20t76sEDmzays4NLQnw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] ARM: Clean up definition of ARM_HAS_GROUP_RELOCS
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, 
	patches@lists.linux.dev, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Aug 2025 at 22:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 22, 2025, at 09:05, Arnd Bergmann wrote:
> > On Thu, Aug 21, 2025, at 23:15, Nathan Chancellor wrote:
> >
> > Would it be possible to either change the macro or to move
> > the overflow_stack_ptr closer in order to completely eliminate
> > the CONFIG_ARM_HAS_GROUP_RELOCS symbol and have VMAP_STACK
> > enabled for all CONFIG_MMU builds?
> >
> > Are there any other build testing issues with ARM_HAS_GROUP_RELOCS
> > besides the one I saw here?
>
> With some more randconfig testing, I did come across a few
> configurations that each fail with hundreds of errors like
>
> arm-linux-gnueabi-ld: drivers/crypto/hifn_795x.o(.text+0x99c): overflow whilst splitting 0x10a61854 for group relocation R_ARM_LDR_PC_G2
>
> so I guess we'll have to stick with the current dependency,
> at least for ARMv6 and below.
>

This is due to LOAD_SYM_ARMV6() (rather than the ldr_this_cpu_armv6
asm macro), which is used to implement get_current() on configs that
use a global variable to store the current task pointer (i.e., non-k
v6 and older). It eliminates the first of two LDRs, which would
pollute the D-cache otherwise, as every occurrence of get_current()
emits a literal into .text carrying the address of the __current
global variable. The D-cache footprint of each such literal is a
cacheline, which never contains other useful data.
(The second LDR is needed and always refers to the same address so it
does not impact D-cache efficiency)

The LOAD_SYM_ARMV6() sequence has a range of 256 MiB, which is
sufficient for any ARM kernel that can be meaningfully used in
production. However, randconfigs may produce kernels that are larger
than this, and so we need the COMPILE_TEST check if we are going to
keep the optimization, and I think it is meaningful enough to do so.

