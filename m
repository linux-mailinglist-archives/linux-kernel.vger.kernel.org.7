Return-Path: <linux-kernel+bounces-885634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7601C338A8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7091F34E726
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF96242D9D;
	Wed,  5 Nov 2025 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT9vdIsc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820B23D7C3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304057; cv=none; b=X6ioqY8iorOt/alm7JQL6T3r4WiEOPz3N03xnvIFqRMGf9E9f6xBBWAP8ZNebKeoC//jqIBs4yAGnX8XTk15JmwSKiRJHA/qn87rDqnXVKKBW6TSp7Os5hSc90ToPCzaNWFt5lRRhJQhkUMfoUkO5rnCE133cS9uug0O0/zWI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304057; c=relaxed/simple;
	bh=VV7eBKzuMpuJRr2XIgNa/X/7vqmqZ08LzVtCckGyb+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHwyu2CVadsNOndq39zCQM81bJaPRpzaz277UOdbcDyZriVgbfyHmnE786VxPJ1cRkhtZ9cXieO6eBHpZcigneMj3YaDd5GBOSLhNXRtURVKEnn92hmJm+d0v6zPx8HBTrAu9cGha12v1N1KsrqF6BmQjidK7E6jRGGoVFTh9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT9vdIsc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2952048eb88so66688145ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762304055; x=1762908855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai8mvMssYGesI1bFVdjZPVSaZhnJPK3ohpheYvjpakQ=;
        b=QT9vdIscTUWB0RNlGFhXfFLLqI1QStHkdPiZe5dBkef/XpYWPJdZVEdRunwKvZqpxz
         IGOIDCI3iVL6zW1Th08U8Z3bGOVVPky1a1noHCtL6ppGQshRD8Ujw+trNMuA9d1BLTET
         DHW17c2yO6PJr79izKiRB9oqgYxp/Ft6xDC7bEDNyjvA0vZQIEVk3plGT0kkvhIF3dk/
         DDvLYbxf2wvM1lFFO7F/0U/wg+0/de5mdOsQiTXsa2VZK673M9OhO88E89ZaV9s0RYyf
         uIAmjTtEwu2hjU62CFBTE9imewTwBK7m4Xs1MW8Xonih5w4u78RvRBp9dEX5oe7jBsV1
         j8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762304055; x=1762908855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai8mvMssYGesI1bFVdjZPVSaZhnJPK3ohpheYvjpakQ=;
        b=f7POaTEg69wxSX9DaD9NGpvn4RBprkei5Qx4duy4IVASZOh0LrnKuq+IphVZsuzXlX
         6EDEenn1TCgItAW9lTjtLRTvE0lW/+1fjuw4jL+u8PLMw7QVh90pRMcLXc8C4puXkari
         6ql1GxrAnfd4NbyljtaPm2C7orhKoZ0DAb3zEgnCi9pJYBJtOzpSI2X0UO/KuRecJXBG
         xTOq2vImuAzpnDfjispZiIoVYQ0vovR2VU+B+KQQZNlNqOZj/dZEWmF40spyEqfPc/an
         jlPPzp2H9TEc1ywDG3nX5jZbkvxRj4v3k4VFO3ckNI6nPtuBDTfYd+D+fFdLW7lmwSkt
         ENCg==
X-Forwarded-Encrypted: i=1; AJvYcCXKZGrZaKd/r3yV8/kZLdbXQp0HrJ0bmRr0Y2FAYpLjWNwNlyTPZJL6QT+2C0rATaJpwa3JEiXs/kEekHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02CtKPfoZoIQVn/voWlrGheZOoxTrryiwqSxhTBkzIwQnaHGN
	peu6FyFztmGumR7+JNdUwVGVU8t6x+5ijYaAo2Qfcyc2+gX2E0TL28drXZ8OIyyakOiu6I3XBGd
	282lKCEWkcfoOCq14eft+5PfW5cYcx/w=
X-Gm-Gg: ASbGncvxqi24XLu8ynO0/QWWWmv/q9Yx27bzyl0/T6ppfNAQCVzFZ3QRhiPZ/Jh2Rib
	L1ej6QtnFpdvT/rpw/5EtAq3RXU9I7c7UWSlO1t5x8IvgyMfhOY2PxIKMz+WqVPBofnjgO+Jcyg
	MzjEhuDcz263PlDjZ65yT0vkGV4AmOk3bn2YNSxPFeUjDd0YB0Kek4qBl9yxj4NmjnwTq7cLw7d
	BE27AGwUlLs6lrQkoTGmrWApZjcSJ1aFUKH1AKBJoDh6VHuwNdgtkI4ADyVVm2Ezj0YAhG1hRn8
X-Google-Smtp-Source: AGHT+IFvcCgG6pGr57yA4MEdSV2o0BGxmUkR4KxnqJzD1CKnDYxQyDUN45vCD7fRxAUDO0fQfFEf0KI3uLe/HCSL/QU=
X-Received: by 2002:a17:902:d485:b0:295:70bd:b04b with SMTP id
 d9443c01a7336-2962adda56bmr23168845ad.55.1762304055076; Tue, 04 Nov 2025
 16:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-4-dolinux.peng@gmail.com> <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
In-Reply-To: <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:54:00 -0800
X-Gm-Features: AWmQ_bmU6TGrwyvmx-hOamFY5JCJCZp3bcPJpWex0EJcwgRNuWp785zP45llSsM
Message-ID: <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, _=
_u32 type_id)
> > >         return type_id;
> > >  }
> > >
> > > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name=
)
> > > +/*
> > > + * Find BTF types with matching names within the [left, right] index=
 range.
> > > + * On success, updates *left and *right to the boundaries of the mat=
ching range
> > > + * and returns the leftmost matching index.
> > > + */
> > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, co=
nst char *name,
> > > +                                               __s32 *left, __s32 *r=
ight)
> >
> > I thought we discussed this, why do you need "right"? Two binary
> > searches where one would do just fine.
>
> I think the idea is that there would be less strcmp's if there is a
> long sequence of items with identical names.

Sure, it's a tradeoff. But how long is the set of duplicate name
entries we expect in kernel BTF? Additional O(logN) over 70K+ types
with high likelihood will take more comparisons.

