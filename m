Return-Path: <linux-kernel+bounces-742233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316EDB0EEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C7F3B04F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529728C2B9;
	Wed, 23 Jul 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwam1cvc"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162E28B4FB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264533; cv=none; b=FMVpRFeAsIdQ4reAiJvKvcVh9qxJ6y9BxLsuexvo5nB+YeF/NW++XGfK7K0Cpsk86/TEM7zy39WuWZTkbr8JGgx7YqmakDw0GxODPttcOtKgEEupH40L54IiRIleg3Yq6GNLXEVX7SWm2W8n83XWuSnw5amJ4vwFFp54dRnuL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264533; c=relaxed/simple;
	bh=0vvfPXGHEFG98Ag5o31G1s1VYGibi2w9+aiyWj1saOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTw08pp2kN7FLNKXJOtaeVHyrEqijctSgR5HvXAR9E+kTiJMzsJnOoPz9o2d7j18f7WZOdgHuKU6DwXkmLE6jdBfCk+j7d1PyvI8lKbQQh4GDPtPw+vTfmRWDPWd0bPpy0nIDHYNPfv1OPHY2z+HYaK7ersfV5CZxnYZvr2u4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwam1cvc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so5519477a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753264531; x=1753869331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hd6rXiOBPeBRqy+UZln4kdfreIy7HXtQe2f2tk4TaUs=;
        b=Bwam1cvchztYNCbdhkWjNlqrJMUd1VeFoQZ92v1s/47kDxc6u7rOsUseVlGIB8ffaI
         5UT9icVc4h07HEo+d6DKunVUCLK3ARvoSlVV5EFptaIv4LxveEDMz2NTTbN5LYwlHIkl
         YYYw6eufZ9oMtfR2IW/bfQHGJ6rtcfyqocCApBuC6q5YDq5sGeOWiA5At35JfrwfvHAs
         rwZ2ipxSWXMfPjGexO+kvVNHy2VYXeofMOYGvIE6IytU83grt/Kr8S2SG+8bOYzHwRBT
         h8oqJy32yrgiH/xFw4I3eo3YdwVNwUISGGXsGChzJF0SN3FmZ8UhcWPHMugAiZ7SEALH
         +auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264531; x=1753869331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd6rXiOBPeBRqy+UZln4kdfreIy7HXtQe2f2tk4TaUs=;
        b=l1TvYubqdkldCbJSHmqqsOjy7cBdiMLE+Wxp60SFVurrRxjZqfehHtoPAtE0NuF21b
         xMUTrf8DIk0K8fMNNeH0mO5ZQYbJqwvnoEKCr3FAgCh9Yew+/TiN/zfc5xaWv6BL+RFI
         QtAbTFIA9xWcNGUEG+oXQe7IJ9hI2bKq0w6PskwOzCpwvbxuyyTLAhFQkiuUzcBGGCAX
         KcM+btdGPbfNttuPJOYOx8J5cuYIw6e9usD+BUJX8XBFXjXuzWQKxU/fiDzpES1zz5QA
         7MyVDXFj9Id7Cnvg9z0uAN/Als05IV2XJL+b7tewjwRRAx6ViFkc6w4H5mYJ/g0GEf4f
         kNxw==
X-Forwarded-Encrypted: i=1; AJvYcCXYDye5g2xPeJ25EMiMgSHx6HTNKDoEyBlg3zCFNaUIKs6LAwPaq6Y+IvApDpUr0yRt5m+KHqjKlwGc/5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhCTMVdybiVPNTbLG1ONtzCwCKkSdWIVNlUeIToyIVtNoADDS
	utPX/gTBthYChG/RKlwRC+y3bZby2Y2P7NtQfqrXemvea/rfEcE7Jctyfbzcd4TRFqE=
X-Gm-Gg: ASbGncvL1tM4jCA0DnJWAk/2keybRtkB4ocPGd6arpI/9cTpXld3VP/0+zrhh1Xt4uu
	FxIFtDtdzfcNNmxtpx0K2Pu9N88/6SSi9DlCStcTKvQ6GnC7Au4G7Eel5HZrNbFox9CNWpv1gX/
	YQ0MHYKBCUUKBDIjAKV9I54LujzFluc92FDyGRGvEeLNyCwRa0iG2Y+pA83Hy97IYJ9kw9qpzQx
	3Syv2NKH1CA1wu4EytQs4YS6BTv4wKJNzK7pBJGJXSiKGTwHjkogo4MIeh3pLV/TBC4nyfkiwVf
	xSwrAYB7waKEvBAVSrCznRiBys4SdWBgEpJj4UL9sclSnl1//l4qoWRWj/r1YBCXgVlAoeINLyp
	fa41XCQFERZDX9mgaOOG+9Gbk/TDmVA==
X-Google-Smtp-Source: AGHT+IEy80RkSpEFCjt6dLV8dYRTl7/n58WYY/PKqcH07FaexSQyl0nLPqJIfP2mNhzanEi+2lmnNw==
X-Received: by 2002:a17:903:2412:b0:23d:dcf5:4803 with SMTP id d9443c01a7336-23f981cd401mr38148365ad.38.1753264531191;
        Wed, 23 Jul 2025 02:55:31 -0700 (PDT)
Received: from localhost ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d239dsm93835205ad.155.2025.07.23.02.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:55:30 -0700 (PDT)
Date: Wed, 23 Jul 2025 17:55:26 +0800
From: Weikang Guo <guoweikang.kernel@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Ensure phys_to_ttbr on pgdir for
 idmap_cpu_replace_ttbr1
Message-ID: <20250723095526.GA1992810@ubuntu-virtual-machine>
References: <20250722082117.1777570-1-guoweikang.kernel@gmail.com>
 <aH-mlN88NrTzahfM@J2N7QTR9R3>
 <20250723024923.GA1884099@ubuntu-virtual-machine>
 <aICh9Z3dsEQj_79y@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aICh9Z3dsEQj_79y@J2N7QTR9R3>

On Wed, Jul 23, 2025 at 09:48:53AM +0100, Mark Rutland wrote:
> On Wed, Jul 23, 2025 at 10:50:55AM +0800, Weikang Guo wrote:
> > On Tue, Jul 22, 2025 at 03:56:20PM +0100, Mark Rutland wrote:
> > > On Tue, Jul 22, 2025 at 04:21:13PM +0800, Weikang Guo wrote:
> > > > Commit 5ffdfaedfa0a ("arm64: mm: Support Common Not Private translations")
> > > > changed the contract of idmap_cpu_replace_ttbr1, requiring that the TTBR
> > > > argument passed in should already be processed by phys_to_ttbr (i.e., in
> > > > TTBR format, not just a raw physical address).
> > > > 
> > > > However, the current map_kernel implementation does not always convert the
> > > > pgdir/ttbr argument via phys_to_ttbr before calling
> > > > idmap_cpu_replace_ttbr1. This can lead to issues on systems with
> > > > CONFIG_ARM64_PA_BITS_52 enabled, as the TTBR would not be properly folded
> > > > per the ARMv8.2+ requirements.
> > > 
> > > For the cases below I don't believe that this is actually a problem.
> > > Since commit:
> > > 
> > >   453dfcee70c5c344 ("arm64: booting: Require placement within 48-bit addressable memory")
> > > 
> > > ... we require that the kernel Image (including any trailing unallocated
> > > bytes accounted for in image_size) are below the 48-bit address limit,
> > > and so there should be no difference between the PA and TTBR format.
> > > 
> > > We could probably test and enforce that in the early boot code somehow,
> > > if we're not doing that already.
> > > 
> > > If we were going to change things to avoid accidents in future, I think
> > > it would be better to enforce this with the type system. e.g. we could
> > > have a ttbr_val type that's distinct from phys_addr_t. Even then, for
> > > the idmap code I think it's better to avoid the phys_to_ttbr() dance,
> > > since that has runtime patching.
> > > 
> > > Mark.
> > >
> > 
> > Thank you for your detailed explanation.
> > 
> > As you mentioned, if we can guarantee that the kernel image is always within
> > the 48-bit PA range,then there is indeed no real difference between the PA
> > and TTBR formats in this context.
> 
> Yep.
> 
> To be clear, I'm saying that there's no functional problem in practice,
> and hence the description in the commit message is more alarming than
> necessary.

Okay, I understand what you mean! and this is clear if the image is always
guaranteed to be within the 48-bit address range, phys_to_ttbr will not change
anything.

> 
> Since the conversion is trivial I'm not against applying the conversion
> consistently, but if we do that I think we should enforce that through
> the type system so that missing conversions will be identified by the
> compiler.

For a function call it should work.

> 
> > In that case, does it mean that the conversion of `reserved_pg_dir`here is
> > also redundant? (There may be other similar cases.)
> 
> Yes, 'reserved_pg_dir' should be part of the kernel Image and hence
> below the 48-bit limit.
> 
> > If we already ensure the kernel is always mapped below 48 bits, it does
> > seem safe to remove `phys_to_ttbr`here as well.
> 
> I assume for both instances of 'here' above you're referring to the
> macro below.

Yes, I meant the `__idmap_cpu_set_reserved_ttbr1` macro.

> 
> > .macro  __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
> >     adrp    \tmp1, reserved_pg_dir
> >     phys_to_ttbr \tmp2, \tmp1    // This might not be needed either?
> >     offset_ttbr1 \tmp2, \tmp1
> >     msr ttbr1_el1, \tmp2
> >     isb
> >     tlbi    vmalle1
> >     dsb nsh
> >     isb
> > .endm
> 
> Yes, the phys_to_ttbr conversion above isn't strictly necessary today.

Thanks for confirming this!
> 
> Mark.

Mark, finally, would you prefer that we introduce a new type to ensure we
always get a properly converted TTBR, or keep things as they are, or perhaps
explicitly state that we do not support kernel images above the 48-bit range
and remove those unnecessary conversions?

Weikang

