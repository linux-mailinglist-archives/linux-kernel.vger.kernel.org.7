Return-Path: <linux-kernel+bounces-823797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F6B8774D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DB13AA9DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DE1E0DFE;
	Fri, 19 Sep 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrSOBkQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B261B423B;
	Fri, 19 Sep 2025 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241217; cv=none; b=uZyyB4cX2s1IUoknEO36dsWY5ZvzdPvyin+FmNJQ0j745a362c+hQAmtOnXJWTGlFcEyadrJSlz8oEG0eO37VpsQrrAvaN6SYBBUU4Pix6H6eirAz9TNFt6d+PihjABmdA41Pg5Yv7nkSJVu4EHBQPpzuvvPBW3rZYksnkhvbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241217; c=relaxed/simple;
	bh=KNat9G+U5mHLxvNQl/KrmWBAEdqLL4t5uL9DjIO2hyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jcvxyd/2IYMs2pBjHkrNCdxxZijqP66nZsvLlAmrzuH7QUdgPCDZ6igzlmIAKCe4+fpUOoMP2imyJm2n5suM4KBLOGgPCkEGTh0jV4+CmIIQizjR1EgS6fQ+GwX6loX9qHrjAvYndYnfRPjuXKxsOVPzKs5zOMQccpYxKxa/H0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrSOBkQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380BCC4CEE7;
	Fri, 19 Sep 2025 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758241216;
	bh=KNat9G+U5mHLxvNQl/KrmWBAEdqLL4t5uL9DjIO2hyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrSOBkQTeylNQH80rL75q77fqhbMFQ/J0XXm4MGKnjSgvS60l9vaLGmEDaQBTyb93
	 sqoILEs82qDfq7x213XWVypBI/5s+c/dSvf1YCmD/GTJsVhP4ryVQ5pSCryr2YtP2X
	 jVzQzMvN6Bb4MuNoMGuX++p8LNyozQM5vLz5Rp0TfgzU9hkGW7g/USi8od6aQuUU0E
	 8HPxZjRFVZiwyaBuxQfg3jOAO/kRG0X+SFlU/jkCrrs8semsvkWrQMq2yaBccd0Nqv
	 1aa7XD6k7J9L8X0r1/T/Hr+CXZ7iLkMNpNVR83d07dB5yTqoUWl8+lVmpKQ49r8qi2
	 T+zRPZ1MtFs/w==
Date: Thu, 18 Sep 2025 17:20:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] objtool/LoongArch: Fix fall through warning about
 efistub
Message-ID: <pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy>
References: <20250917112716.24415-1-yangtiezhu@loongson.cn>
 <20250917112716.24415-2-yangtiezhu@loongson.cn>
 <ym3yf3rkxfq3sukfqbemmbpamjfsx4jjushqh3f54ah5ugamse@qqwabon64umq>
 <64530e20-9bc7-0c0b-d6ea-a4c7df3e85d9@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64530e20-9bc7-0c0b-d6ea-a4c7df3e85d9@loongson.cn>

On Thu, Sep 18, 2025 at 09:44:24AM +0800, Tiezhu Yang wrote:
> (1) libstub doesn't link to vmlinux.o, only link libstub with vmlinux.o
> during the final vmlinux link.
> 
> ----->8-----
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a3a9759414f4..919c1970ce14 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -164,7 +164,6 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS)
> $(KBUILD_CFLAGS) -dM -E -x c /dev
>  endif
> 
>  libs-y += arch/loongarch/lib/
> -libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> 
>  drivers-y              += arch/loongarch/crypto/
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 51367c2bfc21..c664bfb9b15f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -69,6 +69,12 @@ vmlinux_link()
>                 libs="${KBUILD_VMLINUX_LIBS}"
>         fi
> 
> +       if [ "${SRCARCH}" = "loongarch" ]; then
> +               if is_enabled CONFIG_EFI_STUB; then
> +                       libs="${libs} drivers/firmware/efi/libstub/lib.a"
> +               fi
> +       fi

Right, though I think it would need to be something more generic so that
other arches can have "post-objtool libs" as well.

For example, arch/loongarch/Makefile could have 

  KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a

which can be exported by the top-level Makefile:

  export KBUILD_VMLINUX_LIBS_PRELINK

and then used by scripts/link-vmlinux.sh (untested):

  ${ld} ${ldflags} -o ${output} \
	${wl}--whole-archive ${objs} ${wl}--no-whole-archive \
	${wl}--start-group ${libs} ${KBUILD_VMLINUX_LIBS_PRELINK} ${wl}--end-group \
	${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}

-- 
Josh

