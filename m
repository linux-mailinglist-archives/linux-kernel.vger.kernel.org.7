Return-Path: <linux-kernel+bounces-886961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994BC36D91
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EC4A4F4CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD03385A0;
	Wed,  5 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn68VZJz"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E428316919
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361561; cv=none; b=fH99zLa51zl4OMv/jt33ePJ/lgLa3OeRgyi1umvYAtiaqBAcaI6PnsMjLggqw3Ntgzlj2ooG34Qhv/5WxbzSAS58jZS9cIgtRBUljxkco9nSTw2kmxBisJxafG8BvTHaMiND5BJ89WmIDwymUsN+5CEPghe3bpGscjW00wk+VXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361561; c=relaxed/simple;
	bh=6wlmdmjnSpQU9fRc7lN675cJD65XkkBg2XnCXVvTink=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1tUODd9kOIg273qrRe4KQzlj3n2uBk4PUVzQssEhtJjLepM17PZSdXjYUj8HXRBH67bUtI++75QaJS3uVO8jdSz4UpI5IUAXP9DNgywSoFrfbkuHjfMzm+6jX+6IIZ8az/3PwfxnEVWs87a4Lw2jiD258lS9iDXmkLBXnrF3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn68VZJz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7930132f59aso141304b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361559; x=1762966359; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=St/YlSF/6HVAUWQqHTUl+fK8jNSN2VE1+U7dKILtNmc=;
        b=dn68VZJzJ5GP9rJXzmNvjgEyPN89FdMLJJ30b9qsVrokmj/Wu5fU/tEsXhVPxcjdEQ
         dJJygETU28Ca+DBzyaWH8aWABsi8kDYyXXkIcnkc0VQNhhwUSkcZ4rZnhHjX4gT1LgBe
         F//Q/ELK6ZOeuJ3bealosxzX4K0AxMxp5ofQIhhAYBV37ffQv3JD6rRtzYV29pNGObd0
         8eQemK8/gpsC12AEaWcgtfN4m0tmiPrsDcnNqHOhsG8XFrHc6+QeqeTH4b9hnGGQ9gU8
         kBx6lhILl6PZOVsx2Cy867fZOsvwXde1ahMzZOqrJ+TykPmeyUq1Xy+gPpYh4KPfZQ7s
         yqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361559; x=1762966359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St/YlSF/6HVAUWQqHTUl+fK8jNSN2VE1+U7dKILtNmc=;
        b=MXw6ybWQy0C6LLAOwbNGRG/oyXOXeQ9mjzdWcrSK3s468Z3hJ2jX7W6Hc4+q1wKUSN
         YcdwuAxmdit5K8XHVYHDp1bO78DkezywrqNSE5RuiyCBs4aiooP76ZxujT795E/7cbGy
         T40HUhW3Rc5ZeG8Lauk9fc8KnwbxZZlSIUS0SGwkiu9XzbkTKXEXMxOzFc6LozuvBGqC
         OCD0CUmjinwlZeDE2iN6y01GP9lMbjb/nS3NSiYaUBGWTuxxFj0lUBKKFXJCgorWWOPF
         SlQE7+f6pjPmWVT7UsNQEo6KY1JgXQzWyVVEELrKvUt31y6JkFH3h6R14AsotGCBdmS3
         mjug==
X-Forwarded-Encrypted: i=1; AJvYcCUcvFptC03i+PYjBA/7qAs8RMYJkrRz9oOAYk/Ul2Z2JSGubK36YnV8weDu77WuxNq5584pZYNhny22ntw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PXajUEGODdegC4kJQCsGsUnRMG4AwiOnARia/AYvKxwS88Hg
	ERdAHlY3e4blf6GIQvErris8Kel2xlFql+rMVre6tsQvXSwBd9pRZOiI
X-Gm-Gg: ASbGnctfwQwrL88gQXlsu7tMykbcS/nKVb5N06EIOLR5Tucat58izKeLJ8ADBbozSJv
	BTRWiA4UBA6IJmeqNEp9HSHBDvaXUaYaRkOtPjMBc4yGtAuw1aCe4s6HlBlt4uDldAXFg+OOQl+
	MQPvjPE9cK2UFcGpEpLItXJYkxS88st9o5s/ck21c0hZp10qmSgGsYiBqBwNpdZxPMzwLH8kHFK
	IXCVTg7aeynD8A8c6E4dsPHR0igiwt7PotgRbDxFkVdlUNiwe/Gn35FYURaDyBxsGaEM1BWx+/g
	6l9abb4UIEvZL3fu7z6pzqAor9UA+PEkJP775noF0NLerfMMNolV8mRZHYu3RSRDxFaEBkUBaZZ
	HgBErslIkVnMpzCvWrj+quhfYRr9Gdfar/yIwXm75cmyC3JtOTDKyjnI5rzrIe8V0ouIOkqkDc8
	6TVLUlJ8C/Db1NtSsy31WVWfZA/99TImdwXnA=
X-Google-Smtp-Source: AGHT+IHR2B6DtDaHzOI4A23z85FIW2164BTIShW+IpjXW96KXD/wdqkXo75vpTMPhnVKAlOTsJ7Iyg==
X-Received: by 2002:a05:6a00:3926:b0:7aa:a8b6:73fe with SMTP id d2e1a72fcca58-7ae1f8804aemr4060602b3a.25.1762361559242;
        Wed, 05 Nov 2025 08:52:39 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586f857sm6958895b3a.45.2025.11.05.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:52:38 -0800 (PST)
Message-ID: <f6b2596eadf032516b81c19c6f9a8fd85c8ff195.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Wed, 05 Nov 2025 08:52:37 -0800
In-Reply-To: <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
	 <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
	 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
	 <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
	 <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
	 <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 21:48 +0800, Donglin Peng wrote:
> On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *=
btf, __u32 type_id)
> > > > > >         return type_id;
> > > > > >  }
> > > > > >=20
> > > > > > -__s32 btf__find_by_name(const struct btf *btf, const char *typ=
e_name)
> > > > > > +/*
> > > > > > + * Find BTF types with matching names within the [left, right]=
 index range.
> > > > > > + * On success, updates *left and *right to the boundaries of t=
he matching range
> > > > > > + * and returns the leftmost matching index.
> > > > > > + */
> > > > > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *b=
tf, const char *name,
> > > > > > +                                               __s32 *left, __=
s32 *right)
> > > > >=20
> > > > > I thought we discussed this, why do you need "right"? Two binary
> > > > > searches where one would do just fine.
> > > >=20
> > > > I think the idea is that there would be less strcmp's if there is a
> > > > long sequence of items with identical names.
> > >=20
> > > Sure, it's a tradeoff. But how long is the set of duplicate name
> > > entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> > > with high likelihood will take more comparisons.
> >=20
> > $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | sort =
| uniq -c | sort -k1nr | head
> >   51737 '(anon)'
> >     277 'bpf_kfunc'
> >       4 'long
> >       3 'perf_aux_event'
> >       3 'workspace'
> >       2 'ata_acpi_gtm'
> >       2 'avc_cache_stats'
> >       2 'bh_accounting'
> >       2 'bp_cpuinfo'
> >       2 'bpf_fastcall'
> >=20
> > 'bpf_kfunc' is probably for decl_tags.
> > So I agree with you regarding the second binary search, it is not
> > necessary.  But skipping all anonymous types (and thus having to
> > maintain nr_sorted_types) might be useful, on each search two
> > iterations would be wasted to skip those.
>=20
> Thank you. After removing the redundant iterations, performance increased
> significantly compared with two iterations.
>=20
> Test Case: Locate all 58,719 named types in vmlinux BTF
> Methodology:
> ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
>=20
> Two iterations:
> > Condition          | Lookup Time | Improvement |
> > --------------------|-------------|-------------|
> > Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > Sorted (Binary)    | 19 ms       | 909x faster |
>=20
> One iteration:
> Results:
> > Condition          | Lookup Time | Improvement |
> > --------------------|-------------|-------------|
> > Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > Sorted (Binary)    | 10 ms       | 1762x faster |
>=20
> Here is the code implementation with a single iteration approach.

Could you please also check if there is a difference between having
nr_sorted_types as is and having it equal to nr_types?
Want to understand if this optimization is necessary.

[...]

