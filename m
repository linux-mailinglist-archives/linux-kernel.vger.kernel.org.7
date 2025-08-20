Return-Path: <linux-kernel+bounces-778648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D958CB2E870
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5D1C87E71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81ED2C11CB;
	Wed, 20 Aug 2025 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPtDcdCP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D22652A4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731157; cv=none; b=aUyhyNT1GkJRetvYCLIfZQ1m8G6mGGP9z0KAj4Q//2HQDn7B8kd/oszG87paFjLtk9kQPAKgQ7MbP7Kb6LJZTSDQF75wq9XL7d1RIG2PibrLRZC1njfwm1qwDe3y1PMMir3wK6efZeYVY0AxoWPQzLRGxn96+Gq2bBiKxyjja0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731157; c=relaxed/simple;
	bh=1Sl6INGac/LBs/iz+Ar1IPe2mXXgPDv3iAnJ0mNH/XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3mxNwHvb/sWwWEuXrWqRjTYp2beMX7p8TIc6hoPDaTKc4kCcxOLau4ELNL0SpKBT+5R2gIk2j3YZvp3R2Iiv42kimEvRBtCzezllpia7kim6pFa6hEo5M0Mwj+MXWKPDWzOZl5bSEJ345YvcrkGoNRbIOEmItQznnLi/TcU054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPtDcdCP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-246013de800so24015ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755731154; x=1756335954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvRXBj16l2lFtX1Fgv2CXPi4lSLryaOac8dNXUMfY34=;
        b=vPtDcdCPkmNo5h+YatmmW+uauseQbAuXdCE8xpTbeNEfC/CgHyGokCtYAG/pC9mt6U
         OscLuj0WWiAmwPCUocHeYAPVTvfy23AO6iGbbiK5HuZJLeVRtjtN7kKgTCdY4HepuWWU
         p/fGtJYb4kVNfrvZopNLiZVmmDpX2feBqDp6DEhWxaVctIPV9iLQTxF+F3Gszg2g4owv
         YYVACoix12E44Z0TDmEOkmDusAnp5cU7Mfu2YJ2aJ8sCHZKufWRHsI0nQ7hUA5ajrEqp
         UquDvmt9zJd/FSYVZ4YqWgejSbLcezegOTc3v31phVeyeIcTCBi5Pat0Q3eLTFwDUh21
         1KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731154; x=1756335954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvRXBj16l2lFtX1Fgv2CXPi4lSLryaOac8dNXUMfY34=;
        b=SHVJ5v1qStDsJnwVcXaA8Wvvpc4fhc5cDOzcc5ZScz22MKN+8LRw31pd27z65Vzhj0
         c/wPcKoRZIWq95v4XS1cwsVYUgqZzDi7Z78LZ2Ur3Uj2KYAgboTuAnX4QmHTkGbxdW5n
         vq1k2Q4QPXiwP6npd8ce2qOAZ/gToyI4evCFRY2gqbsHL2W8O5kGD2B81ZmhP4Vkjqz2
         ObxP1rhzaI+KFWv8uwJUMVTENKCGIf4f1o7saGL/y+ApIB9WW8F6KNXrZxNMVvPTeNM3
         j5/nLWRcCaQzUyTQMt69Qk2OSXDyOuGlGzQ/lP17h2xunFK3MgLnJADypD1RDCLTVyw+
         dR9A==
X-Forwarded-Encrypted: i=1; AJvYcCX4tzSp+uR5rbw3wwMxDmjX3UBT9lfSqgnazJ1gx4Ed5+nFOCBQIX/16J3G7rv32ok666bESkvBja0HEtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8ZTuMlDb4JwcfeJa62zviU9HuyRu1hjCn6dlHLWGCA/e1sY8
	UJJFFpjsXQd33ZwqrnxxeLlOr3jgatj5BCIPn/cAGzJdMDRvqKRXSlgdbP53vpDF4Q==
X-Gm-Gg: ASbGncuiO5FV/Q/OwzAvasNmOBt7pZMneALMyrwvCNOQ6EwCH6UpXrRg4IYfLBM/fh6
	SrvNgwVNLtUey4PXWmjLSs4m6kXTfONmVZTG52hBW31/gXLCvUDbCqW14GN4BiILGfAd/bidSXy
	ngunpvxCIvpVmi4KjujsnymooYURayV9aOhSJ83fNnJPsgDaEBdWmAIeOMQ6bdr8r27id1+Sav/
	ExpzgEGBVaMfSIannW9Qknp5EAo8SrrMXrYdbOm9elQJCy3hX5AfikyBHhMW/5s2eARa9+nIEB8
	KY1M67wqhiBexqCeCIUCETX/FAvuy6QsyggJAJYv0wm+Ql/3jbbZcOnRvJ4y7LkKzVWV7gquBjy
	VVwNS49/I+5FO2ncZEX7hnRJ89+BnMDjrSgMuzfo0BJI8A3/44uX/V08oy9fpaDR5lyXmCN/rAq
	SR2Gql3Us=
X-Google-Smtp-Source: AGHT+IFvkzWLi+5u8K5l7RVeBnffe0urg17dz2IANRHLwSGsPtlIsg6h/lQqrYlNKOX+8CuI2OtkaQ==
X-Received: by 2002:a17:903:1a08:b0:240:2939:361c with SMTP id d9443c01a7336-245ff98e26fmr752685ad.4.1755731153531;
        Wed, 20 Aug 2025 16:05:53 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4cc26dsm36830535ad.75.2025.08.20.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:05:52 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:05:47 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Atwood <matthew.s.atwood@intel.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:INTEL DRM XE DRIVER (Lunar Lake and newer)" <intel-xe@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/xe: replace basename() with portable strrchr()
Message-ID: <aKZUy_XZxHKLQUAS@google.com>
References: <20250820201612.2549797-1-cmllamas@google.com>
 <peqczm4644mskitmvsq5b2t4r4rs3beei7li3p7uw2nhjne6h6@a3mztccaxfey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <peqczm4644mskitmvsq5b2t4r4rs3beei7li3p7uw2nhjne6h6@a3mztccaxfey>

On Wed, Aug 20, 2025 at 04:15:47PM -0500, Lucas De Marchi wrote:
> On Wed, Aug 20, 2025 at 08:16:11PM +0000, Carlos Llamas wrote:
> > Commit b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
> > introduced a call to basename(). The GNU version of this function is not
> > portable and fails to build with alternative libc implementations like
> > musl or bionic. This causes the following build error:
> > 
> >  drivers/gpu/drm/xe/xe_gen_wa_oob.c:130:12: error: assignment to ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
> >    130 |         fn = basename(fn);
> >        |            ^
> > 
> > While a POSIX version of basename() could be used, it would require a
> > separate header plus the behavior differs from GNU version in that it
> > might modify its argument. Not great.
> > 
> > Instead replace basename() with a strrchr() based implementation which
> > provides the same functionality and avoid portability issues.
> > 
> > Fixes: b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> > drivers/gpu/drm/xe/xe_gen_wa_oob.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
> > index 6581cb0f0e59..0a94a045bcea 100644
> > --- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
> > +++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
> > @@ -125,9 +125,11 @@ static int parse(FILE *input, FILE *csource, FILE *cheader, char *prefix)
> > 
> > static int fn_to_prefix(const char *fn, char *prefix, size_t size)
> > {
> > +	const char *base;
> > 	size_t len;
> > 
> > -	fn = basename(fn);
> > +	base = strrchr(fn, '/');
> > +	fn = base ? base + 1 : fn;
> 
> I think just a xbasename() helper like we've added in kmod would be
> preferred:
> https://github.com/kmod-project/kmod/commit/11eb9bc67c319900ab00523997323a97d2d08ad2
> 
> Alternativelly add it somewhere that can be shared across the userspace
> tools in the kernel tree to fix the mess that we have here:
> 
> 	git grep basename -- tools/**.c
> 

This sounds like a nice idea. However, there is no "centralized" shared
includes/ across the userspace tools that I'm aware of?

> Some dup the arg simply to be able to use the libgen.h version, some use
> one or the other on purpose, etc etc.
> 

Yeah, and I can force the POSIX version if you prefer. I just personally
think the strrchr() alternative ends up being simpler.

--
Carlos Llamas

