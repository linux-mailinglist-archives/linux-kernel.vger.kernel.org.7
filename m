Return-Path: <linux-kernel+bounces-887393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173DC381C6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDE464E7739
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BFC2DCF7C;
	Wed,  5 Nov 2025 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="WYkRQoHm"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BB2DCF6C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379597; cv=none; b=tDPnCqJeoBMtqDxyvIgRXq6h2W4HKSeB0gFjLPS0vjpoENeVK7Qxw+PuhCPR2eeWPdlV55KqT9/YJpsZA6C1AyugwQo9H0EdlW7bl/i8JrEtElLg1zGtnOB/VOxCQSFipQS/y29BBASjFDEXw3qwlITaOF6nrfXAwQywqE1eb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379597; c=relaxed/simple;
	bh=roR+iHl5+yKbGXMgn+r+Uy/w3fFO0IOAH40xnQ+p/4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb7pPPSaW4Xcz4cJDYEvEe1fXho6LdX/jrKlxzRlboG3Ni7H9nOT+xIK9gqP8Smvcbk1e1IYeAFiryZ93d5+owKOn2VejWB9xhpwBh8NdAELvk3SNIxe5AFAUyVkP0BlMJMXxVyJ6olcjTd0ufNJHA4C+aGpBql8T8LPxXoPcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=WYkRQoHm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340ef0e6c06so48821a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1762379595; x=1762984395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXYPCL23ES9Iyb1NQ2+5KG+FblnpsKPGwtWMhH2bakQ=;
        b=WYkRQoHmw3VBywzUB+zNfAcc9p+MOWN27p9a0PCgMY7RnvfSuiX+fYrUSVMPvaGZ2P
         25pCinmce4kL4B5fFSs+8e9GLJd0BvRhAhg/my/UnkDxCeJwl0LHgg7W+L9L4iiN7jXv
         sh2sVKm/e5fkfUXXs24zjyfaRLmePqeoehCmhVrRI1qw7Mf/bKOaREPW3smOm+KDJzbD
         +Hf1TpEmOiO3cF7z/paR5SM5xPhB4HbxB2XN+XA3QCJHcSXq1WK3pk+2sL34Kldpw+Of
         TTgvGbvY9F+zWW4Y9dZSiQJk5LRwCwGVQcC17igMhu30jYUyyfPmWsdrZB4lzdCTALYG
         wWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379595; x=1762984395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXYPCL23ES9Iyb1NQ2+5KG+FblnpsKPGwtWMhH2bakQ=;
        b=nZ4ib8zSZP1QaXocRo2mD9gX59yr7sSv0tSrIAykic4aLiUHf3K0GCyj+2UA+brw0R
         1f/+oC9cSp+KvLUiJ2mPhWzPTJwgzLTjbWwbEkCoJeSOT/wy6eI6N/2WOjyS35PEuhi8
         gmFFQMb3+Lm6FAhxh6I1FTlTp0bbBbeDTf2DHGniGJKgSnRPUpyGsIgU+EkNJO+ubGbM
         vtsfNHa79sSmWpCcGn9YhptTEwmcSElqLnXxzR76XnOG2akKSM6AKPEQWmA8CST5OTdJ
         KWlpGO3CTIOQtWND0FGHh6Je/46uF25gyTB7bVQKFObNphxw6l0iDuMw+ftOb6XZ26ox
         0OLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVgO9JP8OqczL+ntl0GpQpr7mR8MFzVKTS6tpknRtKrcNIzQHOtxFYZw5fhoDjrhO3zycupnrJ+197eBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPrD86bZ2ucYHTf2bFDL8/5Es1H3RMJ7hQAsYUZGSzIM2eX+8
	giyd2a/OaiPUF3u298FvNu6GFxQqOoqAHcKa2GzXDk/8XNTCBStrFzrDtiUC/mKTTEk=
X-Gm-Gg: ASbGncvZmqgVsZzccwlHfWER82V/rQgrV874fZu9+D6RZstQVyJKblIc2SgB0goA1Wc
	ncdsI6NXe6T+iS3jxbs1UemMseiZSR4hp5TJ4bu+xo5U5EXSPg6BCSXO8vO+9MKWfLg3y0j1FQR
	I5l5KC4VXfHTqFH8PmGM6BALPRQYNe5ITZ2LmSOYqQJ/HSS8T3ttLmgpBjwrXVYj/a2Pq2DDmMC
	XV3WTaJ8EeXCKIjdo5SkeyC9NyiuXJwi4GNalA5hVHFgwoG47f4PFfw9r7R40PY7hIAhZoeontZ
	3RIYz8AjJsvT5VtJC+IQNs0i0mnlqnYZWwoAqTnF6tKua8Fc1BgMKb+jNkYHKN45gRKNcEPmNcB
	mXVA3QA6aCl5JjhIppQYO2G/A/2d8BsaIsD3KRI9OWUcz4QRoKW9C756Mew2vurP6w/AloA==
X-Google-Smtp-Source: AGHT+IGY0r/CwQ4uYP5m9fphBTj5UtPwNG1Wco2SGrHkrgNEwj6b42fgxZjgQDbYi9yCWcOKFr/ugw==
X-Received: by 2002:a17:90b:1811:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-341a6b0d5a4mr3477066a91.0.1762379595410;
        Wed, 05 Nov 2025 13:53:15 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::7:5bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d048e1d9sm221963a91.6.2025.11.05.13.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:53:14 -0800 (PST)
Date: Wed, 5 Nov 2025 13:53:13 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>,
	linux-kbuild@vger.kernel.org, Samir M <samir@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-debuggers@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
	Alexey Gladkov <legion@kernel.org>
Subject: Re: [mainline]Error while running make modules_install command
Message-ID: <aQvHSVXbOdiN_J5D@telecaster>
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
 <aQpCE_XTU-bZHFbk@telecaster>
 <CANBHLUhJ5UVsN4-JN2PG=jq63yGttB9BD6Qm8MgvYirTvg_stw@mail.gmail.com>
 <20251105011548.GB769905@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105011548.GB769905@ax162>

On Tue, Nov 04, 2025 at 06:15:48PM -0700, Nathan Chancellor wrote:
> On Tue, Nov 04, 2025 at 08:35:57PM +0000, Dimitri John Ledkov wrote:
> > On Tue, 4 Nov 2025 at 18:12, Omar Sandoval <osandov@osandov.com> wrote:
> > > drgn's CI hit this same failure. FWIW, the commit fixed by this bisected
> > > commit, 3e86e4d74c04 ("kbuild: keep .modinfo section in
> > > vmlinux.unstripped"), also results in ELF segments of size 0 in vmlinux
> > > for some configurations, which confused drgn until I added a workaround
> > > (https://github.com/osandov/drgn/commit/2a9053de8796af866fd720a3c8c23013595d391a).
> > > So there's some funkiness in this area.
> 
> Omar, could you provide me with a configuration file that reproduces
> this for you? Is there an easy way to check for this situation on the
> command line?

Here's a script that reproduces it:

```
#!/bin/sh

set -e

host_arch=x86_64
compiler_version="12.4.0"

compiler_dir="/tmp/arm64-gcc-$compiler_version"
if [ ! -e "$compiler_dir" ]; then
	rm -rf "$compiler_dir.tmp"
	mkdir "$compiler_dir.tmp"
	curl -L "https://mirrors.kernel.org/pub/tools/crosstool/files/bin/$host_arch/$compiler_version/$host_arch-gcc-$compiler_version-nolibc-aarch64-linux.tar.xz" | tar -C "$compiler_dir.tmp" -Jx
	mv "$compiler_dir.tmp" "$compiler_dir"
fi

export PATH="$compiler_dir/gcc-$compiler_version-nolibc/aarch64-linux/bin:$PATH"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux- tinyconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j$(nproc) vmlinux
readelf -W -l vmlinux | awk '$1 == "LOAD" && $6 ~ /0x0+\>/'
```

It prints something like:

  LOAD           0x1ef008 0x0000000000000000 0xffff800080220000 0x000000 0x000000 R   0x10000

I.e., a segment with FileSiz and MemSiz 0.

Using a newer crosstool version fixes it, so maybe this was a GCC or
binutils bug.

Thanks,
Omar

