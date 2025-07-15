Return-Path: <linux-kernel+bounces-731294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64BB0525B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D14188C8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9CF4A21;
	Tue, 15 Jul 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6di1us/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D61A5B84
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563024; cv=none; b=EUtDdTvf86fD6RtPdRJqp/2KvyN5+OGmv6s36ABPxPHNXfep4vz7WyZReQr/AfNYKkss14vln3ChrjfGtmRtJ/zRU4gcgFw4ORJZYkpzHz8xvHvFOL44OyjQt+uf2oh7+8pH7DzvmYHyH9CjOn90j5IZ9KeneD2sW1rDmFEANdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563024; c=relaxed/simple;
	bh=jGIHWJIRk9i2hR7tXdegBVyUzLtZws4m098Ez8HCiu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMBiebjGzqXzI7ht4YolwGD1FvYVcxf4tjml6uQKiEZNkModP9LekYOG7p9i0jZu6SytcjP2qoFernJ3QbGGuHOXPYWozYIJwqVvM+NzT/98R1l6vt9titlgt+qnbiq/w/TlKG2+jInjRJaG19Ra6e57d3brJ2XuiDjd7sWcTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6di1us/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a51481a598so2573976f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752563020; x=1753167820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt/6M57mZgMPhITvF8HdLS12vV1vFn0N4xhHPTTFoy0=;
        b=p6di1us/YOoA1lZHdJKciAn/weTVp3gueuCxxgxq0vox0P1weH/XwtFqEzh7VG8rdE
         z/8Ok3qMaemxdgDCx3iENLGbHdvgZD8fsioGrTK8eWKyVl8EXeXjT87ZyNXwOgV0xjr/
         1ptF1Bzg65wX4mYOInpU7lCCH8mgq1sWxn9UB2X8VvhX2NmQuXyPja6UF8r+sJaUyaR4
         Lsejui+EiNRyPQDOtDghE81neDRuCYhPB/mp71EX3Ne7pCdRiqjyCItgH6awQjiTqH0S
         0seB7xl69ukokxhyGUBRrOnW7Zw+qODHBzgsbnqdy2qrnnYqCMJCtSpWF5aa0MnT5nPu
         edGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563020; x=1753167820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt/6M57mZgMPhITvF8HdLS12vV1vFn0N4xhHPTTFoy0=;
        b=gON6RVhYWBF63avtSJD9rGkdwsEPNY5G/buQNNoN6Fc7EN0FnK7+bCCKBlHEOazp1P
         EEE1XkWjXMxkUE9yYauG79X/mqLN0/h17Ve9bcohlkdN2tKz1e6MjHzTTLiGsfp6dlKR
         xRI7Gzp1M5PLT04oyU0loXyxUV9+zT6xbGLwIR5DBobWu0/AW+0lSrrfz+BkdrajFLUR
         nkIb/MuygCeR8SoLBo9xdVYt3hH9p2ypY9wDumTehbqBuBjos84HSudepJAKv+k3JBpF
         INrYneY9DgBKBl2cL6o99CuwYli9S6mmQbkic+zFfCvTwz/W7/biwrMeJ4zLzlKiuQPy
         8/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWuSz+ZUSuhsbP8ReqGa4BaZFNnW3RD8P+JjeA/BA+yghl1brlLTXS0jVWFwqSrNsDARSNkcH+r6o70W1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcui/nqQlr4Zh8l3JiCbcS9lMpIPHM62PegXPm4tBvLi3UhmG
	N1H86us4Zgo7nRrcoV0BqBoUOCdNZbhNK8p/S2jhyHchxE6ls4/fIcA37Zn85Bvg8lLJB28vkib
	hCOBDLEjwGj0qUgdcfVIGOy2gFaJu7qLP1DpK5c+q
X-Gm-Gg: ASbGnctvwni1c3OE2kGh0QP0jou4flcXhgJ0WhqEO06DOXl06ghTGmIUQ2McTn+x1Cz
	zjeymzZbiP3r7gnEeDf5uwyy0kcQ9NnySMTpV1fTRpTHBt60Kz8f2wABLnN2WjG3ikOXrW72lss
	L/Opwadsx/O70M0EWxw3PhH+1vX+zzTd99Ybv0PDL+aYO6U3Cw+y5ZrY6u2m+KdP8+OfEYarNe2
	x4qeK6+
X-Google-Smtp-Source: AGHT+IE1/MY0RQcecLFoHvQZdO+7sZGnb0kcJHS9oa/ewG1ZdNmenXVcPC2k1yhTjRTUuDq69k9FOq7rxEcXnfgllNg=
X-Received: by 2002:a05:6000:1a86:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b5f2dc216dmr10969220f8f.13.1752563020324; Tue, 15 Jul 2025
 00:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172441.1032006-1-vitaly.wool@konsulko.se> <aHDSLyHZ8b1ELeWe@hyeyoo>
 <5bc89531-ab09-4690-aae4-a44f9ddb4a68@suse.cz> <3AD3F7B5-679F-4DC8-968F-9FE991B56A5C@konsulko.se>
 <1dedcee0-c5a2-47b3-ae13-315ad437ae1a@suse.cz>
In-Reply-To: <1dedcee0-c5a2-47b3-ae13-315ad437ae1a@suse.cz>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Jul 2025 09:03:27 +0200
X-Gm-Features: Ac12FXx5pgrLnvLVllVwWAxwc6ktT76M5E8OvULeGL7H3WltRDY_yqdMh5SmBiA
Message-ID: <CAH5fLggV2Y+N7k=+b5z=Hy5a556VomEZEa3bGhufvKBU+Fd=Ug@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] mm/slub: allow to set node and align in k[v]realloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:14=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/12/25 14:43, Vitaly Wool wrote:
> >
> >
> >> On Jul 11, 2025, at 5:43=E2=80=AFPM, Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >>
> >> On 7/11/25 10:58, Harry Yoo wrote:
> >>> On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
> >>>> static __always_inline __realloc_size(2) void *
> >>>> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
> >>>> +__do_krealloc(const void *p, size_t new_size, unsigned long align, =
gfp_t flags, int nid)
> >>>> {
> >>>> void *ret;
> >>>> size_t ks =3D 0;
> >>>> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size,=
 gfp_t flags)
> >>>> if (!kasan_check_byte(p))
> >>>> return NULL;
> >>>>
> >>>> + /* refuse to proceed if alignment is bigger than what kmalloc() pr=
ovides */
> >>>> + if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
> >>>> + return NULL;
> >>>
> >>> Hmm but what happens if `p` is aligned to `align`, but the new object=
 is not?
> >>>
> >>> For example, what will happen if we  allocate object with size=3D64, =
align=3D64
> >>> and then do krealloc with size=3D96, align=3D64...
> >>>
> >>> Or am I missing something?
> >>
> >> Good point. We extended the alignment guarantees in commit ad59baa3169=
5
> >> ("slab, rust: extend kmalloc() alignment guarantees to remove Rust pad=
ding")
> >> for rust in a way that size 96 gives you alignment of 32. It assumes t=
hat
> >> rust side will ask for alignments that are power-of-two and sizes that=
 are
> >> multiples of alignment. I think if that assumption is still honored th=
an
> >> this will keep working, but the check added above (is it just a sanity=
 check
> >> or something the rust side relies on?) doesn't seem correct?
> >>
> >
> > It is a sanity check and it should have looked like this:
> >
> >         if (!IS_ALIGNED((unsigned long)p, align) && new_size <=3D ks)
> >                 return NULL;
> >
> > and the reasoning for this is the following: if we don=E2=80=99t intend=
 to reallocate (new size is not bigger than the original size), but the use=
r requests a larger alignment, it=E2=80=99s a miss. Does that sound reasona=
ble?
>
> So taking a step back indeed the align passed to krealloc is indeed used
> only for this check. If it's really just a sanity check, then I'd rather =
not
> add this parameter to krealloc functions at all - kmalloc() itself also
> doesn't have it, so it's inconsistent that krealloc() would have it - but
> only to return NULL and not e.g. try to reallocate for alignment.
>
> If it's not just a sanity check, it means it's expected that for some
> sequence of valid kvrealloc_node_align() calls it can return NULL and the=
n
> rely on the fallback to vmalloc. That would be rather wasteful for the ca=
ses
> like going from 64 to 96 bytes etc. So in that case it would be better if
> krealloc did the reallocation, same as in cases when size increases. Of
> course it would still have to rely on the documented alignment guarantees
> only and not provide anything arbitrary. aligned_size() in
> rust/kernel/alloc/allocator.rs is responsible for that, AFAIK.
>
> And I think it's not a sanity check but the latter - if the following is =
a
> valid k(v)realloc sequence (from Rust POV). The individual size+align
> combinations AFAIK are, but if it's valid to make them follow one another
> them like this, I don't know.
>
> krealloc(size=3D96, align=3D32) -> can give object with 32 alignment only
> krealloc(size=3D64, align=3D64) -> doesn't increase size but wants alignm=
ent 64

On the Rust side, you specify what the old size/align was, and what
you which size/align you want after the call, and they can be anything
including that combination.

Alice

