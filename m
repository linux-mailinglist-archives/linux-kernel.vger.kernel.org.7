Return-Path: <linux-kernel+bounces-780727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC0B30868
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08A11CE7D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE96299954;
	Thu, 21 Aug 2025 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7RxKKvN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFF27CCF0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811934; cv=none; b=HN+5qqnuk9mBBGsGCGxRQ2R7PDVPxGxa5WUgQX58XFVo2Fp+yoAsPCRETmOLGeaqtij6VCbsaaBXoNcef5UIne4Q/38iVlZM/3eYkPGEvjLFjnei+wCQruhhUle59xayzXGzCRloRZHqJioZ4MRhMlpcvpOX5TZEqd0amLihfKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811934; c=relaxed/simple;
	bh=MW3lkCmvK8P9NwCJY8vqKN6SlSWz3PG+SB2IfLvCbrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwvd4pssjZapgBJllHBSFOyEKKBB5ErLF1ucUVazg+Yfvt9/HlfkdZEfJMtLQCGNXovuPsprgWHcIzdYupJ/SnL8R6bYfO83Lcv1GukFWG1ni2b3BFWlFXCQK9SVRmk1VLoTw8fKGlQPVQaNbu8vch2/oahv8d3K0ZmPjZkkQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7RxKKvN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24611734e50so23925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755811933; x=1756416733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7RDdIAdym4j5xhdixGaxPIwJbWp2rNz7mv9bLh3G0=;
        b=N7RxKKvNjAFV0U1FZ5uc/mYZF2EksxUDFVYiFaY7rsW37xvfzSaz2fnVbhfIOmcRmz
         hTNnYyRkXt/+HCJLWNyNGaHTBmhdpPSTeeT+fL7sCBqa/AfMhdo7LZrwcDS8dnq2AoYU
         Mep/379+gvpxVnPZGaBe0sSC0W6Anf+mei07H44wvtbFw8CUpbienP+HPvpEzPTkREb2
         ilOfJAeBVljDgIk5seGbWGX3Aq6dsMcer1UeuZ85fHWvNSIixqcueNBcodFpIK5igeoy
         bz/gJdkQXGAzXXOD9gRWhD+aF+Csfe0ZgFJFqFYglYUMaBoCyopILNmuUVxqI1j+x+Sc
         cX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811933; x=1756416733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz7RDdIAdym4j5xhdixGaxPIwJbWp2rNz7mv9bLh3G0=;
        b=fAtCUbvCtX4K32sjVE5/POogSlssHh8vKSWwqCvQ1aUv6Iph/zqSJbj/aFHHJpbPoq
         8Amm0YTmVnG+hpgAn5ammwdAh0gvU59BKqH7jigPMND7swsvBMH+Dvz1Hh46ijqZS5De
         ac6UfYC++wsDRa/Oz8PXulFQvAJ7V3cf1jFb/EgpD53Pl9CysxRHP6EFa2r0yv3EvHkh
         H0hggb/lALZNGSh9JZ74BmJZUSJEZJeJ27PHNElpfcJv/VkAbr5tsANXkdX16DpBPG93
         3aFscop6xGsRyjUYbcK7Dvu5N9YZvhNW6gLuBkrW5j4vvkd0wpjuqXvJJacftuW8x3tG
         DWgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+WUqptt0VB4QcYMTga5EPROW3ys6Ku42SS7qZJxoWFiFbFWB/SiuKlI1svwKL/C52cQlFuJ8rd6b8wwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXL1exsMzEaF4UtSfCXLQZDms7ZfomQqLjdhm2QCgpUu5Jar/M
	1RvxVJHgkRtppNBxS+IEceKRrxmw5VFQBU4+wkSd1fhN73NQ7rRSGNn0Y7VeNXGMPw==
X-Gm-Gg: ASbGnctPCtk6XZjbDoOCFv/BhXDdSzgpHF5pxdeZ+mPYlFAELuIos12fjGC4Sd3Z6M8
	+w0z+RErI3IhnncDfuQ6D0sgSp8pMtMWftU9lHWIKNvJSqLuvqpRvopVnDjMYFAVe6Vsg1FOc0u
	jIqbkD5C1v+S97LIw236bqX+ARLudX01Lzk7UG5wXXdUvDbWdW9Kum/4mJ9Fs8vZc/yMfbmcs5K
	8xzFjGaQg7pEH/oxWQWqx6JmnOF4/aI13kQRp9dM52hm0pzERPPTTSRH0JgTpafiy0Xv1rsDJsu
	vbzIPUMsl8G9ZqsnelNXNfufQgDPS1zPIxKngslfz1hlKUtAvcqZYqOJIYvmF9hXPPvqGGPr2OO
	bFLtAmYtNRKS1IIo8mJNqV7zhctYnXxX+D8AaNLZTczvpqEV1rh8A8wH+qcMzuA==
X-Google-Smtp-Source: AGHT+IEjUQbjSOhgPioiI9ZU+wJJPwSs4HepY0QfCBtA7GumDrWid1z4G3QnghW1ZWO3O5vL9kL0iQ==
X-Received: by 2002:a17:902:e749:b0:237:e45b:4f45 with SMTP id d9443c01a7336-24639f24399mr417285ad.1.1755811932524;
        Thu, 21 Aug 2025 14:32:12 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090714sm5482103a12.32.2025.08.21.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 14:32:11 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:32:07 +0000
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
Message-ID: <aKeQV4EeNgfIsX_k@google.com>
References: <20250820201612.2549797-1-cmllamas@google.com>
 <peqczm4644mskitmvsq5b2t4r4rs3beei7li3p7uw2nhjne6h6@a3mztccaxfey>
 <aKZUy_XZxHKLQUAS@google.com>
 <v5j6nxynzvvlcxu3m3mkeyjv5dlozzp7ixkgc6u6hdzh7en6jh@zvzqm5n7njfd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v5j6nxynzvvlcxu3m3mkeyjv5dlozzp7ixkgc6u6hdzh7en6jh@zvzqm5n7njfd>

On Thu, Aug 21, 2025 at 04:00:33PM -0500, Lucas De Marchi wrote:
> 
> IMO the POSIX version is horrible. Let's add a xbasename() in this
> xe_gen_wa_oob.c and use it:
> 
> /*
>  * Avoid the libgen.h vs string.h differences or lack thereof, just use
>  * our own.
>  */
> static const char *xbasename(const char *s)
> {
> 	const char *p = strrchr(s, '/');
> 	return p ? p + 1 : s;
> }
> 
> static int fn_to_prefix(const char *fn, char *prefix, size_t size)
> {
> ...
> 	fn = xbasename(fn);
> ...
> }
> 

Sounds good. Would you mind if I use __basename()? I'll send the v2 in a
bit.

