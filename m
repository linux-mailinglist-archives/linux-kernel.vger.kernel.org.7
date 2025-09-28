Return-Path: <linux-kernel+bounces-835142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA12BA65DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E7F7A1871
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5913217F35;
	Sun, 28 Sep 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNx7/3ty"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9034BA44
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759024729; cv=none; b=GRUHx/ZlF9VkYmtd2qRdINeGvOfgR6TZV92C01iCxCpYJ8sPHIwOyOvDUYHYf2AzwV8BNumXBLUvpdgsOVzgZHcqjQg0JK9mRBMAOQqG3SfmlpartndQDjWtDe1USkEUClqskp7l9v2oQuHgestFRUDilosSDFQ06zldoJ2QQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759024729; c=relaxed/simple;
	bh=toVM1Ogm2QgQXQWoO9gAszCKQ0Y2rcb6Bhhpdu9LDuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asVIOzQudHAP3eFyxSXdoKOv5/tN2AJO5K6iyFIUyOFK3y+vn0pPCZgS3c+wxTQIE8KG9B5WRa2MyXfAql0ffuGMfnD2qLXgG7hUjLi18Ke1JSKQcOdi8RfSDDj7kdPBhm/eUfV3KOo4uIteKayu0qMlYLHOSAwNwNg7FDXAITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNx7/3ty; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2681660d604so32908085ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759024727; x=1759629527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5J/rF/bT3HbL7GYNEj2zXCEt17ncS6mxLv9yaUaITM=;
        b=CNx7/3tyINbI40GqlCj2iTku7bhne7y2JCBkhr3zwqlLX/ScVbugPWJeX2PE0+Y/at
         FhJuN4QREcd/EPc5/+76V1h9lZavGQCt+koKBrd+/GG+Uqm2Zl7elFxY+jJSes4sXijh
         0Cev61Iengel9Bpipav9MANJQcGUy8eMRBMPlwAtDfONXmCkltxD639JXws0rNSYY+OU
         HYSpfPAQujJorUIRZeVOv9PYeJb4wyByjKf8oYE6OFZglBlw+FeDeMAprerwzwsvgOnj
         TmUxMnhyk+qAcL1+GutqENRXcOr9A7NhNEZLN+skTYw6KdQkDppR9xJwOqPQpu1hsGHU
         zHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759024727; x=1759629527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5J/rF/bT3HbL7GYNEj2zXCEt17ncS6mxLv9yaUaITM=;
        b=bVm0lSbjDqWlah9TkJ4DY2pCMb4nyMBOxkz5XUJOWUf2GUukskZn1dX9slZdeU7Hqd
         hDuDoX8kKFlpMSMM57aT0pJO64h+OzTqLSbTJNNl9W2gYmjVFUxKKZu1qmokIZdw8+IL
         phxbbz5ohXMaFfFlPDYuVke0Ve7faCy01+DQ2fUSgAzGn9CTn0reNDLsZjcuuJ53/4AO
         cXrUIVprVRyckINlVYPwsME4HK8cbqdrqpfTbkdmwpYc7UkMdkRXlsChd1bJUFsnuid2
         xSyCGCb94WOD2VF0A2X6VP2bycQvrEgdycdCS2Lgk/nUqDObwfe83YC2URz5SkabTL75
         6M4w==
X-Forwarded-Encrypted: i=1; AJvYcCXh2dzEUIIdSbWAcfFjOhTxnRw2nGbxJD6F6+cQZjU6PjBxAzG3H846eI8IYcGcmQtIXx54daR2aI1G/YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvELY6h5ToK7VP8U3hJW8UTgv/pUPswDcqtTFwLinclGOTGHc
	yGjVxAxjQ0a0bht5jMOI6QcDogiCbWwaiQ2Noom1KsDYDx0Kp7f5hruOevMnwKSVozmngojNEpI
	Nzzp+Ayoang/AOdiTl9eMOYOthZLz9Wk=
X-Gm-Gg: ASbGncsGniJo1Oovd/B1mJTH4c7fi5fXqU0XtvfhFHj34fkVyAL/WgMCRqCPMi2gYrM
	KRfqBerHB/OCBt9aYLdMJ59PWnx5CHdMc5EPVGMzLVVKeOPhGh4Rg5ixQYpRxzaKFGqRssVRIGv
	wPH++VVIwwNupW14e4uZAOTtNBWSqgObiHcDOWJxWOxdjFzGTyLK7CJJEt0p0YnCl6OeejmPNX3
	rhlgYYyRGB6SwYp/tEAYUP3Wexc
X-Google-Smtp-Source: AGHT+IHMr4GAhOOYgL/sXUOERr0H7GehVK7nACxXSc9vI5DWqoUYmLvmCEQseqEz11GRtA2XbKHRiIeukKwa2mTghPo=
X-Received: by 2002:a17:903:32c5:b0:269:7c21:f3f8 with SMTP id
 d9443c01a7336-27ed4a31641mr139636615ad.39.1759024726897; Sat, 27 Sep 2025
 18:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927064926.1496579-1-jianyungao89@gmail.com> <20250928013244.qzevjut7gbxdbyli@master>
In-Reply-To: <20250928013244.qzevjut7gbxdbyli@master>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Sun, 28 Sep 2025 09:58:35 +0800
X-Gm-Features: AS18NWCJJMqbXcZQ3ctHwvgO-5vDzc9IB8XsIIHkkMb6JC06O2fFVitblxyc84k
Message-ID: <CAHP3+4C5U7CU=q8hd6XK3zpKhhj7m1OdY7_pMpz0m-csDBpdmw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Fix some typos in hugetlb module
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Wei,
Thank you for your reviews.

On Sun, Sep 28, 2025 at 9:32=E2=80=AFAM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> On Sat, Sep 27, 2025 at 02:49:26PM +0800, jianyun.gao wrote:
> >There are som typos in the code comments as follows:
> >
> >  differenciate =3D=3D> differentiate
> >  refernece =3D=3D> reference
> >  permissons =3D=3D> permissions
> >  indepdenent =3D=3D> independent
> >  Spliting =3D=3D> Splitting
> >
> >Just fix it.
> >
> >Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
>
> The change looks good.
>
> But maybe we can merge it with the next one you sent? They both belongs t=
o mm.

It`s Okey. Thank you!

>
> --
> Wei Yang
> Help you, Help me

