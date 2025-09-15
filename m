Return-Path: <linux-kernel+bounces-817367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C7CB58152
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FD5202BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD192376F8;
	Mon, 15 Sep 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQHdawWU"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34E230D0F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951599; cv=none; b=ImgolrP/NbZ0Lu+yKbc4if42rdYd0CaeckMt7J8uQanUm5CbUkfrZrIe36ZoPPkyGxdx33FSMkQpE5mI2nhkSKszEmFw+VJFfV72ZK12+rAe7hbluqFtGaEMFwX4EDe45mqqgE3dEsrvWNs7TxERjzOMBQRR76pZTAaTRRE41yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951599; c=relaxed/simple;
	bh=F6DTZWr2PPXJc9MSABBtybg5z0j9nOtTokHsabCL6Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oj+BfHxe7rRtIfQekXFuXP4aQZldmt6+vQHIYBNva07ZwMehyRffoEKSmlkKpHJdlpLKPGzsL1CdREEoclptY8EAZyL/muj2+N+p/nHR4Q5M3y5/KwcS1UdZ+tOfluEGl3IqhYWkwWw4n7d1Oeoj8CHxpoemWelaWt5JRqYWzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQHdawWU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea4032e406dso1517608276.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757951596; x=1758556396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0XiNoYxd5ucucDApZFb2O43+1fOasgyAKcEaecxkgQ=;
        b=VQHdawWUwxtUDsnf2OzYeoOPiUSRylGj41rMeufU3tH1ig5U4ms5rukuBjhMB3iO6G
         ku2ekowbU1bNKB3OJi3STK7m7v4swUXxXOBEPYmJvYdnMPvvBaRY4g59PXBAdXyfAv4f
         iYaSGjp1rOTuHfPwt0axVvLoNSY50WMMxqh6+KBhO0eHkg6XDEnnCn6Stntg+wNC4Ygl
         zSLW6ZeMP/Qbmc5ome+hs7m2MoCF2GDCgIj2hcaBCm3jQ8P6e5nKJmktksCaa+v2T04c
         otewqvBv7sfCDz49Ar0kCx1+UPix/PGUsTWJZfxcK0DTVgr47egaYRoUl/t9FV7xmOaa
         5FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951596; x=1758556396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0XiNoYxd5ucucDApZFb2O43+1fOasgyAKcEaecxkgQ=;
        b=ftDn/o2K+F0+3wWcqmSMPOF2atFs/uUaC+B9Th0dnV1tTbNTd+R6IrBfY/WozU+y0O
         QmKQXuUM3taYwlfzoNECgIsXLJ59k3Y9w9TIWpXzhBbU0NDXdVaYGK4Et3LmdBdbDByl
         LQ8G1EAtNroHd6OPrJ50J82fPEefe66kHhVp1UTtJChF6lPJQmgk/uzthNbZl3IO5CRD
         Cq87Sre1V2BhFsemr7773UA8vVZK5TKKklgn5kG2OQS21oTwcx5G8qpZOX4G9VvO79GE
         DFwSb4BQMEx7jBafxjEC2prHADRUCejFtC/ypCdBXqOptgCEWn02LgWZvga2BxyigWQG
         LnjA==
X-Forwarded-Encrypted: i=1; AJvYcCWJV9YAlX2nAaWnUJbbpY4ZGf3OMxheNQNMpol3n6DOdpTci2KnWUdSa0cLU7k/QA1glTk9ACOuoqTvXrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnknH9NkLS2RaxxfMbRyYW7GnmfYEdpIGSsIXqiFxTIiiQ563
	+73n3CNflSDMCWP7KPjIqBhncNmya+lnb53nBHnDYCFLR0BpamQVu9R4v4hl8kz9xZDIzBnHBmZ
	vEkZhyD4KuuLGXlLtLpvuQpYhrRKn7Lpjw7dd7Q2F
X-Gm-Gg: ASbGncsjP7+cK9i0MdOOuMQfLMuXa4RzHE9q9GmYotAbO9d3tMF8VAp0qGw4pwKS4zg
	9Vi0FkDp7kMrgOvCwySQpIYGKyaBkoZ/S//DJtZbofsi0nz+ujcVcNFMPi8SVafxuFqbJcseFl7
	IyUlr+WTXpueaXgQLm13R5McuFbEz4qvpvJdzyWwDHQYu0tevJDTE+0SqrwQRa1xZ5vAOSK/QM8
	gX8p7ZGrs1aj2ewcmkc3+I6xdsscQvzsUngCBgLVkM=
X-Google-Smtp-Source: AGHT+IE83V2dgjtVWnGJmHoDlRMTL2myBzrkKJXkq0h5ZUezl7kZ6j4oqJ7P5qXzlNuzOLFywsL004XyX2O24GgrcM4=
X-Received: by 2002:a05:690e:251a:20b0:62a:e5e3:b1f with SMTP id
 956f58d0204a3-62ae5e30d34mr6904794d50.18.1757951595803; Mon, 15 Sep 2025
 08:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com> <CA+OvW8ZY1D3ECy2vw_Nojm1Kc8NzJHCpqNJUF0n8z3MhLAQd8A@mail.gmail.com>
 <409ddefc-24f8-465c-8872-17dc585626a6@suse.com>
In-Reply-To: <409ddefc-24f8-465c-8872-17dc585626a6@suse.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Mon, 15 Sep 2025 16:53:04 +0100
X-Gm-Features: AS18NWDFM6GFUPdftWx-folpVmUzea-hrwoyneDC89H80_fy-yjv_PiWu2wlc2k
Message-ID: <CA+OvW8bhWK7prmyQMMJ_VYBeGMbn_mNiamHhUgYuCsnht+LFtA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:09=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
> This sounds reasonable to me. Do you have any numbers on hand that would
> show the impact of extending __ksymtab?

I did performance analysis for module loading. The kflagstab
optimizes symbol search, which accounts for less than 2% of the
average module load time. Therefore, this change does not translate
into any meaningful gains (or losses) in module loading performance.

On the binary size side, the on-disk size for vmlinux is somewhat
inflated due to extra entries in .symtab and .strtab. Since these
sections are not part of the final Image, the only increase in the
in-memory size of the kernel is for the kflagstab itself. This new
table occupies 1 byte for each symbol in the ksymtab.

> > The Android Common Kernel source is compiled into what we call
> > GKI (Generic Kernel Image), which consists of a kernel and a
> > number of modules. We maintain a stable interface (based on CRCs and
> > types) between the GKI components and vendor-specific modules
> > (compiled by device manufacturers, e.g., for hardware-specific
> > drivers) for the lifetime of a given GKI version.
> >
> > This interface is intentionally restricted to the minimal set of
> > symbols required by the union of all vendor modules; our partners
> > declare their requirements in symbol lists. Any additions to these
> > lists are reviewed to ensure kernel internals are not overly exposed.
> > For example, we restrict drivers from having the ability to open and
> > read arbitrary files. This ABI boundary also allows us to evolve
> > internal kernel types that are not exposed to vendor modules, for
> > example, when a security fix requires a type to change.
> >
> > The mechanism we use for this is CONFIG_TRIM_UNUSED_KSYMS and
> > CONFIG_UNUSED_KSYMS_WHITELIST. This results in a ksymtab
> > containing two kinds of exported symbols: those explicitly required
> > by vendors ("vendor-listed") and those only required by GKI modules
> > ("GKI use only").
> >
> > On top of this, we have implemented symbol import protection
> > (covered in patches 9/10 and 10/10). This feature prevents vendor
> > modules from using symbols that are not on the vendor-listed
> > whitelist. It is built on top of CONFIG_MODULE_SIG. GKI modules are
> > signed with a specific key, while vendor modules are unsigned and thus
> > treated as untrusted. This distinction allows signed GKI modules to
> > use any symbol in the ksymtab, while unsigned vendor modules can only
> > access the declared subset. This provides a significant layer of
> > defense and security against potentially exploitable vendor module
> > code.
>
> If I understand correctly, this is similar to the recently introduced
> EXPORT_SYMBOL_FOR_MODULES() macro, but with a coarser boundary.
>
> I think that if the goal is to control the kABI scope and limit the use
> of certain symbols only to GKI modules, then having the protection
> depend on whether the module is signed is somewhat odd. It doesn't give
> me much confidence if vendor modules are unsigned in the Android
> ecosystem. I would expect that you want to improve this in the long
> term.

GKI modules are the only modules built in the same Kbuild as the
kernel image, which Google builds and provides to partners. In
contrast, vendor modules are built and packaged entirely by partners.

Google signs GKI modules with ephemeral keys. Since partners do
not have these keys, vendor modules are treated as unsigned by
the kernel.

To ensure the authenticity of these unsigned modules, partners
package them into a separate image that becomes one of the boot
partitions. This entire image is signed, and its signature is
verified by the bootloader at boot time.

> It would then make more sense to me if the protection was determined by
> whether the module is in-tree (the "intree" flag in modinfo) or,
> alternatively, if it is signed by a built-in trusted key. I feel this
> way the feature could be potentially useful for other distributions that
> care about the kABI scope and have ecosystems where vendor modules are
> properly signed with some key. However, I'm not sure if this would still
> work in your case.

Partners can produce both in-tree and out-of-tree modules. We do not
trust either type regarding symbol exposure, as there is no way to know
exactly what sources were used. Furthermore, symbols exported via
EXPORT_SYMBOL_FOR_MODULES can be accessed by any vendor module that
mimics the GKI module name.

Therefore, neither the in-tree flag nor the EXPORT_SYMBOL_FOR_MODULES
mechanism provides a strong enough guarantee for the Android kernel to
identify GKI modules.

Only module signatures are sufficient to allow a module to access the
full set of exported symbols.  Unsigned vendor modules may only access
the symbol subset declared ahead of time by partners.

In case such symbol protection is not useful for the Linux community, I
am happy to keep this as an Android-specific feature.  However, I would
urge you to at least accept the kflagstab, as it allows us (and
potentially other Linux distributions) to easily introduce additional
flags for symbols. It is also a simplification/clean-up of the module
loader code.

--
Thanks,
Siddharth Nayyar

