Return-Path: <linux-kernel+bounces-761115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC9B1F490
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556871C201CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C9298CDA;
	Sat,  9 Aug 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MK7xTAnU"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B718298CC4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754742553; cv=none; b=ERzreHKzUgp2EEKWXSJv0c61xb9hT2VckgKcOG0mD0Hgo4K9k5o6ENwJF347oVe/LM8guAYQn77YyA0kvUuVnqnnw5gSd/jkMiIUovonjICUJdRHizkdRxNQCVaRenINzd4j77LqUBN+dVy6ASQJVKJvedLDRjYg/7mrFRJ3V4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754742553; c=relaxed/simple;
	bh=RRwvM09qeDecLH+dYSOmlHPhvo17VziRN9IUQ98/X90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDnG5+PaKZxwZSfl0X/9PIxOc0h0qaSgwvEEucTRYhQTMHe27r40CLRYIGMXY52aEnNlX7kNTuwKhy79dMN+8Uz9phei3/TJmxI1JJe5z0P78o/DyQchOdB9HOZzOzeA9bdchjskZ2eH44x3R23gdNgC/3vW0oQKIfhiIpdBqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MK7xTAnU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754742550;
	bh=RRwvM09qeDecLH+dYSOmlHPhvo17VziRN9IUQ98/X90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MK7xTAnU4w+gj8jq57ptOwo3ln+cQLxC12vhch3Drqjs0iHWaLbXo6jpgbw/fEDiN
	 ThRNqm+Pjp6rs8sAZLHb9ZWgvDIc7AyHh8QaV5+OoNvM8AjPVfzLpHuFuXOvZGE2nC
	 wwfOA4OFkTxbJs5/4Y3M/EyQdlcnPb0iO9cGLOSQ=
Date: Sat, 9 Aug 2025 14:29:09 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Palmer <daniel@0x0f.com>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Add target for lz4 compressed vmlinux
Message-ID: <d7974cbe-41b3-4994-8982-30c8f660e65f@t-8ch.de>
References: <20250809015529.373693-1-daniel@0x0f.com>
 <5dd0a031-dd7b-4078-b1a8-6b760248390b@t-8ch.de>
 <CAFr9PXmF-AOL8yj9FntHw+b1A8HWKNeAHU=rx7Dk7pfi1N_4fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFr9PXmF-AOL8yj9FntHw+b1A8HWKNeAHU=rx7Dk7pfi1N_4fA@mail.gmail.com>

Hi Daniel,

On 2025-08-09 20:35:39+0900, Daniel Palmer wrote:
> On Sat, 9 Aug 2025 at 16:50, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > Splitting the vmlinux.tmp creation into a dedicated target would make
> > all the compressor targets simpler. It will need a bit more disk space,
> > but there are a bunch of vmlinux copies already in any case.
> >
> 
> That's true. I think a target for vmlinux.stripped and then use that
> in the compressed image targets.
> 
> How about this?:
> 
> vmlinux.stripped: vmlinux
>        cp $< $@
>        $(STRIP) $@
> 
> vmlinux.gz: vmlinux.stripped
> 
> ifndef CONFIG_KGDB
>        $(KGZIP) -9c vmlinux.stripped >vmlinux.gz
> else
>        $(KGZIP) -9c vmlinux >vmlinux.gz
> endif
> 
> <snip>

I would continue with vmlinux.tmp. It might not actually be stripped.

quiet_cmd_precompress = PRECOMPRESS $@
ifndef CONFIG_KGDB
      cmd_precompress = cp $< $@
else
      cmd_precompress = $(STRIP) $< -o $@
endif

vmlinux.tmp: vmlinux FORCE
	$(call if_changed,precompress)

targets += vmlinux.tmp

This will also correctly handle CONFIG_KGDB changing.

(Maybe the naming can be improved)


And for the compressor invocations we already have predefined commands:

vmlinux.gz: vmlinux.tmp FORCE
	$(call if_changed,gzip)

targets += vmlinux.gz

> > > +
> > >  CLEAN_FILES += vmlinux.gz vmlinux.bz2
> >
> > CLEAN_FILES also needs to be updated.
> 
> Noted. Will fix for v2.

If you use $(call if_changed) as explained above, the "targets += ..."
will make the CLEAN_FILES unnecessary.

