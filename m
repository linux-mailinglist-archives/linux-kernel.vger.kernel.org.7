Return-Path: <linux-kernel+bounces-876517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B92C1BE45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD2645A2851
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E832AAC1;
	Wed, 29 Oct 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgjFDuIi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7C2144D7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751752; cv=none; b=CNofEgmdYVb0Hw4yWqyb2213K3XwFKQgv38P6rSs0wRTFMRTS3SHzZUws3qrG0dE9n02J7oeRJ+hohp6ajmA3+60sXWNhzZVD6qKTY3xROh70t5EO++/kwjMjfBWzlfUro1pWNJqsp2sEZVst5O3Ea8BD2mcrAwsqQnc6fkT7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751752; c=relaxed/simple;
	bh=WtXohkJCbWS4jbO4cmof6PHddRZcBco3Bznw9PsDWdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjWnn/1UaPYdshkPzV+4lC7IM5QLAi4KuzNZo1sb0c4cDHTaR4SmVoxq/3my0Zes1hKZ68qjpecXBSYPGHOX4QW1Pr6Y/JSbekHMG0J27zvSwEyc4mJeUU8BGA+b59BxTzfEgkmUBxCNoRmSlRNXflWpR6tdpsD3qub/+zVob7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgjFDuIi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so12926a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751749; x=1762356549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f625dWb+wusHB9zK0OBpFfEoYrOJJpBna/xRpvKUY48=;
        b=QgjFDuIinkogf9UkGuZSA0+qfhSDPx19+sh/JFBQrzCWijQQEkenLcC8xfSnNWzqni
         O08RYSZ7CQSzYayVtRETABaC2DUgxycjk13UbBTR6m80yFosjVi831+2Nfj28jBxYXxY
         WzHIdll/P9WP2cSmnff+AAs1ygDpKPEn7i2OvRyZqWSGyy571cam7rjR7jya28xfplpc
         /V7Whimxrba1gqUW2HjjnBHupHL10nHOFd6k9C/Mbv3BC/BEE/f3ejNbPBkrUNOSg39n
         f07f6/BtmO5Li9tyfpY/aGGNU0u77Lag2wkJR4jr0GHFhCiYLovOlzKcWICpG+rUlGBP
         KB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751749; x=1762356549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f625dWb+wusHB9zK0OBpFfEoYrOJJpBna/xRpvKUY48=;
        b=SQKFCAnldbHjk/uovOGIwcQpClpBjnzsvJV+LLFvmjDdjqU1NXbRcRTMmf5SZH6SJB
         bHj9RbWI9Z8tmteUkvlBw2FUBSRg0DXm6qFCbSw0MuTm+nK/vtkfunseeen5UPSHrLbF
         ZljGs+SqkpR9bTQOtiJlaI9cJDNjT846Hxv557HA0LWiRDnU4gFJYvQpE0vgiPH3mnV3
         8P/SRyLLQi4iW+SXWaW8lqT1EUe/ZddU/QNJMzqUSTB6oh5oKjFDjhU9eXNsVNMpwtYW
         4fNAwWEQfSPn1i7pvrV/6E/MsUJY8hSioxESoEYbLenorZkWEDTeat6gGcXzdz/YppPr
         kRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Msvg73zGvzE/QLt+DOFsiORFSU+EdUFwspRG5AHUmAMZPC2m50LPngCNeEb0oiRwAK80OEiIvCWX3KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6y3pwUOESbtd1EHqNR1qj/xuzSAN98eVgcSKN0u5NZvwM58CD
	GLr9CUJfBtqcy6spxHryA2WMn1q5aNevFUDCI1JwwIfsu7KkqNJcnv9TcfZQL3+wQZ6VoRsdObb
	L+kYJwmXmwWUGMABIWhUrKvUwV0KAFb+ZKpjwibk8
X-Gm-Gg: ASbGnctYmHXN/c4tSJlRfgwpJkceGyXzPEW6M/GRUL4Y/xRyy4oTN6XBLxkS+zfbJGB
	lPrbdvKrKtWx+SWFR4YuOxGT5ZV2y8jaSf50RkvczTzq1FaOrlJVY/LE7EBq12chw2WjAzfODzw
	sftqdqSIOfFumVg66EfNzNhL8LUkJrxxdf6svdkUxw/WiaT6HsxVYYq8NIQLIjWpw1EbxvIXkC2
	YHgSHuqRHXei4d29nWb343X2tvXwZniSdDIa/kTdfbEyQWDpqgx/37PqQ5uTB3pC6Nta3SG8EN3
	SZ7yG/m5XQ8aOA4=
X-Google-Smtp-Source: AGHT+IGJr15cLDbC+fbHSXbTnzvTz28tTliyWmFftwEcXMbXCQuxnWdN03oQ6RERl24adkiisnp+L7hn3wCKpUANYfE=
X-Received: by 2002:a05:6402:713:b0:63e:11ae:ff2e with SMTP id
 4fb4d7f45d1cf-6404519b54emr90964a12.3.1761751749371; Wed, 29 Oct 2025
 08:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-6-harry.yoo@oracle.com>
 <CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com> <aQHLDTwwEuswvNWv@hyeyoo>
In-Reply-To: <aQHLDTwwEuswvNWv@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 08:28:56 -0700
X-Gm-Features: AWmQ_bmezBnR6pc25_StLvVfGCVbr2qQzQa79QlxZjsxwYQHjSt8eI_UKHmKW6w
Message-ID: <CAJuCfpERqLpAkbK-+X32s9o2udOfLtqeoU5=9BykbucFePv7Ww@mail.gmail.com>
Subject: Re: [RFC PATCH V3 5/7] mm/memcontrol,alloc_tag: handle slabobj_ext
 access under KASAN poison
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@linux.com, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, 
	shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:06=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Oct 28, 2025 at 04:03:22PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > In the near future, slabobj_ext may reside outside the allocated slab
> > > object range within a slab, which could be reported as an out-of-boun=
ds
> > > access by KASAN. To prevent false positives, explicitly disable KASAN
> > > and KMSAN checks when accessing slabobj_ext.
> >
> > Hmm. This is fragile IMO. Every time someone accesses slabobj_ext they
> > should remember to call
> > metadata_access_enable/metadata_access_disable.
>
> Good point!
>
> > Have you considered replacing slab_obj_ext() function with
> > get_slab_obj_ext()/put_slab_obj_ext()? get_slab_obj_ext() can call
> > metadata_access_enable() and return slabobj_ext as it does today.
> > put_slab_obj_ext() will simple call metadata_access_disable(). WDYT?
>
> I did think about it, and I thought introducing get and put helpers
> may be misunderstood as doing some kind of reference counting...

Maybe there are better names but get/put I think are appropriate here.
get_cpu_ptr()/put_cpu_ptr() example is very similar to this.

>
> but yeah probably I'm being too paranoid and
> I'll try this and document that
>
> 1) the user needs to use get and put pair to access slabobj_ext
>    metadata, and
>
> 2) calling get and put pair multiple times has no effect.

Yes, I think this would be less error-prone.

>
> > > While an alternative approach could be to unpoison slabobj_ext,
> > > out-of-bounds accesses outside the slab allocator are generally more
> > > common.
> > >
> > > Move metadata_access_enable()/disable() helpers to mm/slab.h so that
> > > it can be used outside mm/slub.c. Wrap accesses to slabobj_ext metada=
ta
> > > in memcg and alloc_tag code with these helpers.
> > >
> > > Call kasan_reset_tag() in slab_obj_ext() before returning the address=
 to
> > > prevent SW or HW tag-based KASAN from reporting false positives.
> > >
> > > Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
>
> --
> Cheers,
> Harry / Hyeonggon

