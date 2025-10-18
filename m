Return-Path: <linux-kernel+bounces-859023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A7BEC801
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A54E25EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BAC267B92;
	Sat, 18 Oct 2025 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gxRv7ar+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2C230D1E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764335; cv=none; b=JROk89H8uOR+wB4bwRJskOry6O0nevNv/E4cBbsZxkfNnhfXJJ/y5qKRoaM05lBTFJ9hn68iucChnLPxWIr/5T8fUpcMNkbFYLGsvGCdluCig6HZ1T82ShAdnncH/0Is7HXXGzeG6wleRA91IFMnu/CQ9G/i8HOoW+HdZ/fPzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764335; c=relaxed/simple;
	bh=JKlZ6mq1MHRF27crq/H/Z6OaHYvWdAyiTQoS/n8gsTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBRW6VEr7RDr9klxBYVCl5NPKY4/gkXRDeWp/a/y/YzgJtBo0Jwk9SCupf7iX+jSX/rt4BLTy7WlONKohNFpj4Mq9D8unNaIVi1ilTP9Uj5mQnHZMlKue5SCYei7YwIstFzpES3muoRH4Mf03ZL7JtMRqbCmfsPqhE1dh8ifAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gxRv7ar+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=G+XeId9fVeKy2mjwtAJkSYjpdvOc4ElmCgO/h9WTUQk=; t=1760764333;
	x=1761196333; b=gxRv7ar+1CjKeZ5cVPQqP9X+Pj/vVBTQul71L6Sr7cs36pFd58HCqNdfq+cQV
	fkDOYh1swuYcgOYpHAVGsrAhdFOnZMPEhn1yu2rN4zHOJMtuGA19X9uQoaDoFx4fUPuq6akPKA4cw
	QqScyNbLm0gzC2ZQ0k7K6+7VLjL6s+Pp58Q/ANpOMns6Ew3ktTpDqc7O32c8p7bus0XTbGKBqz4si
	mTGa1LRM/yqbpiBllgfrc1EpD7e95eui/ZrXw4M2tOyIUV9aEP9tjW/rmYhi0Nao6jBKV3/bnx6/T
	yNNDjzsYfZiPr+0+pOCxYkCGO0G3/WdMiyHIM6g/Qa4hQGHtlw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1v9zEY-0000Io-2k;
	Sat, 18 Oct 2025 07:12:03 +0200
Message-ID: <c1d395c6-2d3b-4504-befe-6e67c7ed96fc@leemhuis.info>
Date: Sat, 18 Oct 2025 07:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tools build: Fix fixdep dependencies
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arthur Marsh
 <arthur.marsh@internode.on.net>, x86@kernel.org
References: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1760764333;5d9cf6ca;
X-HE-SMSGID: 1v9zEY-0000Io-2k

On 10/16/25 11:53, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     a808a2b35f66658e6c49dc98b55a33fa1079fe72
> Gitweb:        https://git.kernel.org/tip/a808a2b35f66658e6c49dc98b55a33fa1079fe72
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Sun, 02 Mar 2025 17:01:42 -08:00
> Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
> CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00
> 
> tools build: Fix fixdep dependencies
> 
> The tools version of fixdep has broken dependencies.  It doesn't get
> rebuilt if the host compiler or headers change.

My daily -next rebuilds based on the Fedora rawhide srpm failed due to
this patch while building perf:

make[4]: *** No rule to make target '/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/fixdep'.  Stop.
make[3]: *** [/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/build/Makefile.include:15: fixdep] Error 2
make[2]: *** [Makefile.perf:981: /builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/libsubcmd.a] Error 2
make[2]: *** Waiting for unfinished jobs....

Full log: https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/09700031-next-next-all/builder-live.log.gz

Happened on ppc64 and s390x, too (and likely on x86_64, too, but that
failed earlier during the build due to an unrelated problem).

Reverting this change fixed the problem.

Ciao, Thorsten

 
> Build fixdep with the tools kbuild infrastructure, so fixdep runs on
> itself.  Due to the recursive dependency, its dependency file is
> incomplete the very first time it gets built.  In that case build it a
> second time to achieve fixdep inception.
> 
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/build/Build    |  2 ++
>  tools/build/Makefile | 23 +++++++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>  create mode 100644 tools/build/Build
> 
> diff --git a/tools/build/Build b/tools/build/Build
> new file mode 100644
> index 0000000..1c7e598
> --- /dev/null
> +++ b/tools/build/Build
> @@ -0,0 +1,2 @@
> +hostprogs	:= fixdep
> +fixdep-y	:= fixdep.o
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 63ef218..a5b3c29 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -37,5 +37,24 @@ ifneq ($(wildcard $(TMP_O)),)
>  	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
>  endif
>  
> -$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
> -	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> +include $(srctree)/tools/build/Makefile.include
> +
> +FIXDEP		:= $(OUTPUT)fixdep
> +FIXDEP_IN	:= $(OUTPUT)fixdep-in.o
> +
> +# To track fixdep's dependencies properly, fixdep needs to run on itself.
> +# Build it twice the first time.
> +$(FIXDEP_IN): FORCE
> +	$(Q)if [ ! -f $(FIXDEP) ]; then						\
> +		$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)";	\
> +		rm -f $(FIXDEP).o;						\
> +	fi
> +	$(Q)$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)"
> +
> +
> +$(FIXDEP): $(FIXDEP_IN)
> +	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(KBUILD_HOSTLDFLAGS) -o $@
> +
> +FORCE:
> +
> +.PHONY: FORCE
> 


