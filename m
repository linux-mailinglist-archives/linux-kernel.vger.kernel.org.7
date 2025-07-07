Return-Path: <linux-kernel+bounces-720070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3CAFB6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6573E1AA5AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F52E172F;
	Mon,  7 Jul 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ho/SLovv"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AD2D8DA8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900372; cv=none; b=lzLWaDEr1KOpwnxBEoAxzifBH6OVO9I4g/aO2c2UWu421mo9kvJ3RYBMjwbzWxD4CFduGjWfSMcFsL0L3/FM5c8G11+n5SagbrFpl3c8848rCJA9Bax+hTBrNYT4Gl00jlaoOd9llI3ZZp84Z5vWNvMrEwLohR6JWUlfk5eC1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900372; c=relaxed/simple;
	bh=5J6/q/GM8RZ99jS9z81cyaKyHg6P0FVUWfxHrUa5/58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG2X5HtbvIwKcp/KpIXW2z9U7JK486YVeN7a9CcpwnH4xdZJ3fqHIlUgru78rkv4VM2C8IdnMj5YGbEEpUuzgtydKhHxidQW45KqrllvvrVJ8P4wYUNGbCqzGhzjQDtmTU9JL/Ch5VHG/TW7ZfCLKUBhHlNOorVCU531ZyFZqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ho/SLovv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313910f392dso2621346a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751900371; x=1752505171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TQLxoKJTtnPQL66AOVz1qBZAurWsbbtmQ08gZuI+u0=;
        b=ho/SLovv7ZTD7nf26TVEZqkkJaOXDwFjpqiXUIT/mABz1JG8jIXNfwKzgyuOKoqpPa
         GjNHc+OF0/cykuCxakHldGkpfmpZwXnLo4N0t9tbfYp05nGkdH+WmWBl94BO5BulKe3O
         J2DsBKYVcU0wDeTVaSStyZ4YqAUZcbmt11q4v+IaAjZzrE21xoMzRKyQQ/sJ9Qo6u0RA
         Y3OOJmWqwmb9S9SC35B2bVbeOpShkTqrzwlHrr/Fm3R2oDGtK34o0yH/jb099G4Yn+mW
         Iq+is9JHTAzQx4LkvrI92DKSKk9AOuWa//YdW1a3boFCa5ihHOzTcvzNcSqaI9LjQvOZ
         cIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900371; x=1752505171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TQLxoKJTtnPQL66AOVz1qBZAurWsbbtmQ08gZuI+u0=;
        b=i/9hIsoADMUMA+wmxU74p7/QqO63WZHGugfU8PZ4lgXhdyUvuHQxIdujOvyJUfIsdS
         uKm/UHD+1PPpVlHrSqLeQe9V21tVeF60PyFTZQQd9z+kmH9xFcYfQet/vu9ZT6/qfPLe
         /n36ymdZwAF75HKWOMG70grjZWn32PGgLw7maKr38m8iAG977GDX3y/347BY8A0oZMw9
         /DFw6CdFRaCPnKvnBSGvK9kCBuUg+rRjmf6LrPkk1xVhlI9u4ZSEoG1hlHnzr1vNIeWE
         96kBgd0s957Pw4JmSKBPS1KNuZtcL7Fyu6DolWYBqJsd773Gqi85L8AORqMywXwS7ocx
         YZCA==
X-Forwarded-Encrypted: i=1; AJvYcCU1buktSxscNquitBxH3H/bJkm8T6MlvoIwiahf8CfSK/XiwIUYpecaesblIYbPPxPmTTBwKmTTLNFFNAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGemGVV/W4TWK5KwDZL6cIVeuss3eMQyb8/2PzbSj4o1P1Y20P
	weQiVsm6adMvoDYLplEhhWPuJ/6ByVS4AZgc+3kLZZj72anxRXG+0/xbchKgw1VRnseVgsTSW0Z
	WfbzyPk/idG9CXeN5jqTel2pdUUJKpnQIso3CA441
X-Gm-Gg: ASbGncvrHK1vTuuxfAdWoMlbjqA/dIviA7nlGJkPRsOk5/bSSZszzptW+8sy375TDnc
	S77XW3QpuGfPbqDmAFcuIePVuzrg+Kr+bUTChe5YvtbXbGNP5zrEegtrjzb5L/Zw4y+Y8XGDq2p
	BFtmS/eEtuLwQXjOkKQo0NkudSe2+mDs9Vcdtp5s46
X-Google-Smtp-Source: AGHT+IE9YWkTfOUxIPM2EzEa1lJ2gNYhmQvgWwWfNnfCuD/M3jrRM4u+/9ssAC3XE0kDqrvmOJaz3qcx79G+IEBBFhg=
X-Received: by 2002:a17:90b:3f48:b0:312:b4a:6342 with SMTP id
 98e67ed59e1d1-31aaddfc24amr20985661a91.33.1751900370388; Mon, 07 Jul 2025
 07:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com> <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
In-Reply-To: <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
From: Marco Elver <elver@google.com>
Date: Mon, 7 Jul 2025 16:58:53 +0200
X-Gm-Features: Ac12FXxNc7MVDdqbSkiHg-OPuizBzk24Lc8ThBNq8a8QxrLwekty4YemWnP4YPo
Message-ID: <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 16:39, Alejandro Colomar <alx@kernel.org> wrote:
>
> Hi Marco,
>
> On Mon, Jul 07, 2025 at 09:44:09AM +0200, Marco Elver wrote:
> > On Mon, 7 Jul 2025 at 07:06, Alejandro Colomar <alx@kernel.org> wrote:
> > >
> > > While doing this, I detected some anomalies in the existing code:
> > >
> > > mm/kfence/kfence_test.c:
> > >
> > >         -  The last call to scnprintf() did increment 'cur', but it's
> > >            unused after that, so it was dead code.  I've removed the dead
> > >            code in this patch.
> >
> > That was done to be consistent with the other code for readability,
> > and to be clear where the next bytes should be appended (if someone
> > decides to append more). There is no runtime dead code, the compiler
> > optimizes away the assignment. But I'm indifferent, so removing the
> > assignment is fine if you prefer that.
>
> Yeah, I guessed that might be the reason.  I'm fine restoring it if you
> prefer it.  I tend to use -Wunused-but-set-variable, but if it is not
> used here and doesn't trigger, I guess it's fine to keep it.

Feel free to make it warning-free, I guess that's useful.

> > Did you run the tests? Do they pass?
>
> I don't know how to run them.  I've only built the kernel.  If you point
> me to instructions on how to run them, I'll do so.  Thanks!

Should just be CONFIG_KFENCE_KUNIT_TEST=y -- then boot kernel and
check that the test reports "ok".

Thanks,
-- marco

