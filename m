Return-Path: <linux-kernel+bounces-887394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAAC381D2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F4D18C7BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8DA2E0407;
	Wed,  5 Nov 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="Bq6IqwNp"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FE2DE711
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379647; cv=none; b=RdhUd/hydU1VTOMMeXAbVstSX8ASzVBBA9IvK5wcKWQSIYF3IAc/PaMiPtbEvBn/y2aU3SeB9WIkN0su8XpbYI8eT5WKQ+k/2Fxf+T5ihLs7XSsVbhyOqPkt1Uu/Lm48AlJddcxCjRDakNE/M0XfTpE0964QNs4EmCR4fUlEzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379647; c=relaxed/simple;
	bh=a0DMhlWxuVqBCN0KBqdowbn/CLsjJL49e5yevm+zPx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5yYQucjs7T0mWN5HF3xsGsiPehFYkChQ+xKAbsm2Ix795WC+z463fOzvD4QrmhAjC5WyE2gq/x6OZzLjv+OWa4MXdb+EWzaMly+65QTccpaY+VvjOnrtBzhDPLu+OVHzsuBw14ZAfMEE4cuyqhN5zvkl6KUiX4ZOzqGN19dUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=Bq6IqwNp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b997ae045b7so26360a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1762379645; x=1762984445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3NyO7+s0Q1YlVv+39EMFftmDuskfOkHuzdOZz8YwQ74=;
        b=Bq6IqwNpvkLU9d9NH58gSkILJMcVqv/EFNYedZWUfG4ZFDQVS4BYKP2E+U7VCX8qKz
         DpUZJMfjizy8+lxFwGLO/wkNnCPvwuJ68RNz28KLi2ub8kDMu7+CU1TpIKUrU1aXPJkh
         /iLNb9DMRPbj1qQ7baqXPC47Aaj/5IB7jFG290XrqWDjb46kL/5+PYZD0dPACrt2JIUY
         p86toIlTGhlWvkEWLy1epSYT1ER5tbEz/m2MxnJvKAS/eXf06AeLjXvQw1EUqezCIHgJ
         BwKvMekQMJANagYhGC46/cYU/RqhjzOBjHH1MSqsmN1JgWwbmaMKiK1Ox15ygqSYU49R
         rUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379645; x=1762984445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NyO7+s0Q1YlVv+39EMFftmDuskfOkHuzdOZz8YwQ74=;
        b=tnCMrMrTg5GssFwshmxAT+gtdwgq8yyKR0NtQqVVIk6k4GrPIcgMZOotR8Kk8W1lNe
         lbm1yg9LoW7hK2XpnPNO5oG4ZPhztU277Wf8jVAtXP2hoo/Hs5NKlbw74mLn16RBO4fA
         vO5VwWXojXWoOMLIItZFxBM8WQc5nLuqTu1ZVDWoppY21jzhqLYcxoV4q93w2JsrGnhx
         UK1IrbVTNdvwdciR8oGr4qDIxuZ/vkT4lAiQH7TlgsI/klNFYf+r/eaBVQNdfkBe9ZG+
         vbijSP0kTI0qp3fA78Ge+T8kSpmRhl7nOfcr48boLMMRfuch2lWdMCBaeUYrK9vfZNQJ
         L4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIwjtLwdmihQ5RbGTILlmit6YNc3t1LhsBJS5DuBzbJYBRRIsGj8AlvKo7c2bqG+aCspozrmfOBP5vSNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhkJpkWaLK5zIe6di1bUHGsCJeMP6dRCCIlA8Vfm/9oxr9MFQ
	3saxltukrYrhwqASfvTY5XpiNLqzyeOJuaUZc/ZuASpCkfdkuhyI4+JL1qkTUDLSL80=
X-Gm-Gg: ASbGncskwQo5nAtprCh+3Yk7p8flwh8cKpyTtUiOIyebaD2ErDghKss830oOAEYZ1rL
	BHLSpZqgU1uNMedPRaZy6SB9EFUo1ZLSyODdC+R34usM5KAGWUThsv3U6wGUEF8Aq5Ff2A0eZRz
	jWeze2ZDam6CjviJrX+44ffDq2DJN+Sa4vY+6upVR7uQbFA6OTnqcFFgy9TrPatCNc384ZiMvxr
	BeZUluwMvJjh2uPbMI5ZLd+mfvD6K+iDZOjDVLQc9ATUkQLylaK01ZJ1qglIj6Mr2V3PAcLwUhX
	Q1CSkTzmjwDPkusvwseQXwK8ix6yfFlisHfl7S2lrZB5zjz+Mb6LwQwUh/RzNHHu7S9VT5qxK6k
	8GR2tYznojrqyAC83kMYiA0fWjkT8XVZadEP9OnSrPfujFT1BWKGpu2GcLqYJ6lMrYxT/tw==
X-Google-Smtp-Source: AGHT+IGFQNfflrxSoXLFnSus/BEHD479ifwfdhVpXjNkWU1UacD8ijw1jHX3iuARmyJ9ksBMTvfybg==
X-Received: by 2002:a17:90b:1e0f:b0:341:abd4:b9f5 with SMTP id 98e67ed59e1d1-341abd4c08emr3186130a91.6.1762379645534;
        Wed, 05 Nov 2025 13:54:05 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::7:5bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm3952646a91.7.2025.11.05.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:54:03 -0800 (PST)
Date: Wed, 5 Nov 2025 13:54:02 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Samir M <samir@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, linux-debuggers@vger.kernel.org
Subject: Re: [mainline]Error while running make modules_install command
Message-ID: <aQvHehCLxrXGcH5k@telecaster>
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
 <20251105005603.GA769905@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105005603.GA769905@ax162>

On Tue, Nov 04, 2025 at 05:56:03PM -0700, Nathan Chancellor wrote:
> + Nicolas and Alexey, just as an FYI.
> 
> Top of thread is:
> 
> https://lore.kernel.org/7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com/
> 
> On Tue, Nov 04, 2025 at 04:54:38PM +0530, Venkat Rao Bagalkote wrote:
> > IBM CI has also reported this error.
> > 
> > 
> > Error:
> > 
> > 
> > depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> > prefix
> >   INSTALL /boot
> > depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> > prefix
> > depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> > prefix
> > 
> > 
> > Git bisect is pointing to below commit as first bad commit.
> > 
> > 
> > d50f21091358b2b29dc06c2061106cdb0f030d03 is the first bad commit
> > commit d50f21091358b2b29dc06c2061106cdb0f030d03
> > Author: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
> > Date:   Sun Oct 26 20:21:00 2025 +0000
> > 
> >     kbuild: align modinfo section for Secureboot Authenticode EDK2 compat
> 
> Thank you for the bisect. I can reproduce this with at least kmod 29.1,
> which is the version I can see failing in drgn's CI from Ubuntu Jammy
> (but I did not see it with kmod 34, which is the latest version in Arch
> Linux at the moment).
> 
> Could you and Omar verify if the following diff resolves the error for
> you? I think this would allow us to keep Dimitri's fix for the
> Authenticode EDK2 calculation (i.e., the alignment) while keeping kmod
> happy. builtin.modules.modinfo is the same after this diff as it was
> before Dimitri's change for me.
> 
> Cheers,
> Nathan
> 
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index ced4379550d7..c3f135350d7e 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -102,11 +102,23 @@ vmlinux: vmlinux.unstripped FORCE
>  # modules.builtin.modinfo
>  # ---------------------------------------------------------------------------
>  
> +# .modinfo in vmlinux is aligned to 8 bytes for compatibility with tools that
> +# expect sufficiently aligned sections but the additional NULL bytes used for
> +# padding to satisfy this requirement break certain versions of kmod with
> +#
> +#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
> +#
> +# Strip the trailing padding bytes after extracting the .modinfo sections to
> +# comply with what kmod expects to parse.
> +quiet_cmd_modules_builtin_modinfo = GEN     $@
> +      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
> +                                    sed -i 's/\x00\+$$/\x00/g' $@
> +
>  OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
>  
>  targets += modules.builtin.modinfo
>  modules.builtin.modinfo: vmlinux.unstripped FORCE
> -	$(call if_changed,objcopy)
> +	$(call if_changed,modules_builtin_modinfo)
>  
>  # modules.builtin
>  # ---------------------------------------------------------------------------

Thanks for the quick fix, this worked for me on a machine with kmod
version 28.

Tested-by: Omar Sandoval <osandov@fb.com>

Thanks,
Omar

