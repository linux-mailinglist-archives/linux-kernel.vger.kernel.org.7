Return-Path: <linux-kernel+bounces-734361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419DB0809C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC539A42AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466F2EE5FF;
	Wed, 16 Jul 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyO0ErHu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F423643E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705786; cv=none; b=T6JniSIxJrTzTaqzjO+wWQArIzXcQB9dDb1j0gX2pGjdnWvlXM1SrgFj7aqLB+vF0QOBiYDQVkyeb39pKfhlB44Qrs3NYKN+YZwn3CY3Msujx0PLeQVZ2s31qIurrA3+PnpvTcgRtuWQe19XCCGJqBIqFN+UzPssalgXimKwfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705786; c=relaxed/simple;
	bh=QGSG1zDzy+FiAfvcFqvFZcTAf3kiAzOmr7sGlxp5cIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvb/gLLGusF2ZxnBqmEtKDtFTb9zrhI+rMrhZ4N5Jw/1EZD5WwZMCOf3CjxIbbEUgvYiZUkK4k+P17KJlWIwH47U1DzxmCDA5l4/+vkFwwfey+o5jNYNKIe4mHa7Jrl4I7Jqv5iOx3/E9U066zMPs+hbssmsFfp6DSOzuAt/N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyO0ErHu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dd9ae5aacso29545ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752705784; x=1753310584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yqqHbMa/s+cK5C5oiRrHKnm+0gCY7ZLYL73js4DqeU=;
        b=MyO0ErHuACRGCxboTAQBemDgvLP9ysrrpF0aDPhMiIOIIW/cv6OiU/z5zmvaLbsMQY
         dtEpBWAN27Ue+W+3ZPjFiwzZuK7bp3db4pXvte9iVIFwzPreeDPvtAX/dVhdl/8ZkTgu
         amc+qqkCHmHsFbXKY72UpMSLPHtm+7v4a3/gfIaqorlf9cNKIrW5xtUxrNOuRUecByHq
         n76ivGDdPHDneQTzROojZEP6Xmtp4JWYBxLzdEe2tn0hkt0MoSO2+qjQWjcifJZfnKMZ
         HdniZ/6kegqM5wdY/s8WoArW/hQupU9ik5kLshGP04DiRNG2SO2TEsccVPlcIne7aqlr
         cnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705784; x=1753310584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yqqHbMa/s+cK5C5oiRrHKnm+0gCY7ZLYL73js4DqeU=;
        b=tLtvIey1/1V/pYnCRg5XzUf2u2LMMgv/SyG6iRVxIogsT1DJPBX8/Bah6JcsVFIGM1
         SG2hYbcc+iH8zJA5ImBZqzVYGphURJl95D+ft6y+vYDZCj9GQJqo5bYZMeY7E4Jc9Umz
         xqXzAF9+cF7Odk8jhKvJBtU/FfQJWRAhp5ym4mvsk1FcTvODECITxB+r61VkFHPr0dUD
         WUviOZ8Y+5pXC8FmG0HnGvMNJXemyEfvar4VxieQyy7RuVgjLwJ+qcxYVOGBzoRcoynT
         4rZ8OBAU/PKpzJpBOyHabXPTrpQyJ9l9Vtp5D6PIC+lElkHpYdHukJ88oK+3K+PAYwPT
         Y8ig==
X-Forwarded-Encrypted: i=1; AJvYcCWoCYzBaVcIOKaIK3q+vb0h8pPKgBD7GdKXRBK+HhxGBnjRGVKgxttUR7lFvl2/D3JhXfavOFO4LzI7B6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKpdBz5nmU7zchx3ytYycl6lvmVtAkfWK4oeeBSQFNUdGBujj
	wgcFlYdvzQLf/bo9gBVZjS0yHj37TIgS98Qqci02qLdvbkbVZKFbA5LemB0Gy/hrAg==
X-Gm-Gg: ASbGncupOCOkDZyHvmKJVqesYkpw7OBpNS3fVrZlrc6wszKyAzLEv4eSdSAdg4y0Tsr
	xf82vnTQcGVb75qZ0qlVrEUnrDrKutxRDP+WSoraxaLo76BWs4+dyokPTcs4rSmflJyMBmMDhLm
	UrzuGekj1eJaUQnO3hxfTZI2i+YGEA7CFbzvY5xwrrCYyxb646RYjpaZMdPLkkg1JHcazyGwdFN
	tJOwPG77rue5PTVPdrWadaBqhUnvF+nmAsDhU4L2r3WMceQdooTjzbK0g+CHEJi38ACrrwS8ecO
	5E04C0xsl5eU2ehBgOOFoQ40VbIp3XLPf6xALzaZ5VhJkxngkImAuRmsSc71kR9gmNGXdNxODYQ
	HoA0Tw90RaJTDYehgYCN8xl/leU7xB7rxBEeyMwujBUgO9UfBA8qksZ/sBXdzcB8=
X-Google-Smtp-Source: AGHT+IEH4DP66Y0IGgJhHWe9Fg54RKlzSO1QLwEYkYL9dH9+XXQwjB3OPR1iWt0s2yjq7dTSKQZGjQ==
X-Received: by 2002:a17:903:1b0f:b0:223:ff93:322f with SMTP id d9443c01a7336-23e2fdcce70mr1238505ad.2.1752705783607;
        Wed, 16 Jul 2025 15:43:03 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e14e9bsm14353649b3a.49.2025.07.16.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:43:02 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:42:58 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 4/6] binder: Scaffolding for binder_alloc KUnit tests
Message-ID: <aHgq8nub0DaIMPbp@google.com>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-5-ynaffit@google.com>
 <202507160735.C76466BB@keescook>
 <dbx8seiv4voe.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbx8seiv4voe.fsf@ynaffit-andsys.c.googlers.com>

On Wed, Jul 16, 2025 at 03:28:49PM -0700, Tiffany Yang wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > > ...
> 
> > I'm used to the "#ifdef CONFIG_..." idiom, but looking at the tree, I
> > see that "#if IS_ENANLED(CONFIG...)" is relatively common too. I don't
> > think there is a function difference, so I leave the style choice up to
> > you! ;)
> 
> 
> IIRC, I had tried using the #ifdef to inject test-specific code in some
> places, but that created issues when we were loading KUnit as a module
> because it causes the built-in code to be built as though the
> "CONFIG_..." is undefined. Consequently, I started using IS_ENABLED by
> default, but I'm not sure if it's strictly necessary for exposing
> functions with a header file since I'd assume "CONFIG_..." will be
> defined when we're building the module?

Right, IS_ENABLED() is the "short-hand" for ...
	#if defined(CONFIG_x) || defined(CONFIG_x_MODULE)
... which is what we need here.

--
Carlos Llamas

