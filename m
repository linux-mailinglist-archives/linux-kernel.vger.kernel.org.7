Return-Path: <linux-kernel+bounces-751598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ABBB16B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CF54E530C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AF222590;
	Thu, 31 Jul 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uc4juRBo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AB1E1DEE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937340; cv=none; b=mkFkP6FvPxADn8XigElPcmGpW0uWeV55Sr0ejmrvBI2q4N9YNKn6ANX3dUcnhxPnPJ+UzsTXcmEDYhxYbefHF5VQEPgbNWtr9qY0rTibP2hX7dmZfotUjEsQZoVuhpst8H0pCY+LpRUOOdpoc4VMCwnk1n8Diq2QMi2bLlZnp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937340; c=relaxed/simple;
	bh=E6b0BGGR/RtUGN8YfAQcFiZryLTFBxGC41R0EFwTd18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue6Rzs6zn4VF4/rMZaSGe4xWPQAu02lOhRwesCQe2dQVYhfXEWWNSC9UHDgvcfD1x2cju6GtfIVd+akqjd6nHVwW1vHPy4Sw0KKhYyS+X/wnk9N3Gwv46DulfqudrkM64OGg96bp9q2tTYfI1kc+iuLsq94eftt6IV69oPM0pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uc4juRBo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af913d9d2a1so94847366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753937336; x=1754542136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DINYJ+FM1lqJupdP3vzGFRoexFRJ9IKZ3t9dG0gHVuM=;
        b=Uc4juRBo1uLI5wFk5+zM/2RlcjL4ci0/O7shN4///JG5UdhuYghlW8GRYJN0sgM88k
         a8tr1Yl27twHAGVXtCyQyRy9Kr4KxzlRACwNjaMw7GPp7G7jKWWfjdtKnAzb1RSnjp7l
         I8i/wsb+r9I8XZYkK9PVJb3HsLGA2Xcfn+ZUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753937336; x=1754542136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DINYJ+FM1lqJupdP3vzGFRoexFRJ9IKZ3t9dG0gHVuM=;
        b=KdHZVOL7Nt8vL52OjwBPpcv+BnFp7VCIHm1ggO7NJw2Kqj0a/dSC+PC3wmA3f/At71
         uRetjzkRCrhaYMYtkRq+F/jkpB7l+hE9Pj5UXzrEmMgY0n1OWKTHR5hzaLQXxfJExfv4
         cABDdt7LuwrEGBWPwnG8Y70KN7oJqOeu8PXoxce0PGnVNoSqpPhBi28spnJ5AZpdRFsu
         n8s1+t9cwUhExCyv2jaG4GErbbDS7lHQEBFOu6OmLPGEtHnkisPoxmgFE6gh/1tThVqO
         hnv3uVniAltgzvKlpEgEBFtWLFKwXBQIfOh47F+7UUvjaDlk5kmVQ8nEW/gsyww+y3ue
         d6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+uuNxzELJE8MttUvafm1Iw0fU2tf0RP504UZjcwUoyIpzmafjixha0AbZnBDbIwsqrSGBIeeXHERH4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9X4B87Dr1fnfa+QMoyAQpC1KutwPevWrmdSCgBKQxNfnAwFXP
	vFpyudWdcE7eIYjhKNAGefBQ4RwXWokWu8Oe8ATiBZd4TJnlwIWHRNC0t43PJn1rT+mzzbvfHct
	lEYZ2Bmo=
X-Gm-Gg: ASbGncu0Oio25/O0/NLvRCnrc7bW+NA5G8aup0me/CRVxmXC4/+WvtBCuJWiXIGsBb9
	GMuef04qi4m0lg4WAarqic+wU9VBzzWXuDXb1IZrLkmL6kh2MVox8V6+0lDdjAeAy3rH05UlsTF
	5HKv/zFGWjCRYMfh9JYceXji4PLThyuDuo2EBH+oGmrQfWKAJXHJaqIVkuYr1pWd7mc8l61xBGe
	yyRYGkpUCk+HroX68rRX2pJuVRYTEJN8hkFvRReDvPjwy6mFnaouSHDQaHyKG5PablowuUyN9Vc
	0yjY2Xw+2+xPHYWJj+wpF6XjSQ72DKHmy9/+1cDtLRsROVZcM3/9QNJE9tIEJTxnD5QNjGWFgRb
	yVjhfIgHULZ50Pjg4SHflqPhl5+ucUIVJKBDagQner1uOq/qiqOoe7UHvFsitG/flunbYvn5p
X-Google-Smtp-Source: AGHT+IFTPzSFKBHaMnwAfFUaYtEwoxtg1MECFBZpH3JPU0vlC2z8xX1OB5sYBZKK/NIcimWyPuKVpA==
X-Received: by 2002:a17:907:60c8:b0:aec:6257:c22e with SMTP id a640c23a62f3a-af8fd72904dmr717184466b.14.1753937336550;
        Wed, 30 Jul 2025 21:48:56 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a38aasm46325266b.37.2025.07.30.21.48.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:48:55 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso873773a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:48:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQoML38ovtIBm9z4SBstdsVMbGr9yX5fxR/Wt1LFkrS205I7lQ4uiJow4iwoQaaxSwVGVQGcTYY+v7Pbc=@vger.kernel.org
X-Received: by 2002:a05:6402:42c2:b0:615:8f10:2d4c with SMTP id
 4fb4d7f45d1cf-6158f1032c5mr4612317a12.4.1753937335353; Wed, 30 Jul 2025
 21:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com> <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 21:48:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
X-Gm-Features: Ac12FXyqfcARQ-zUwGqzZGAbIHJ9CUJpqWHEZ271UfDUtdTjz1kORZjkZIzYe-s
Message-ID: <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 21:36, Dave Airlie <airlied@gmail.com> wrote:
>
> https://lore.kernel.org/dri-devel/20250717204819.731936-1-mustela@erminea.space/
>
> is the only thing I can see that might not be in the merge.

Well, it's one of these:

  3f2b24a1ef35 drm/amd/display: Monitor patch to ignore EDID audio SAB check
  aef3af22a456 drm/amd/display: Add definitions to support DID Type5 descriptors
  d7b618bc41ee drm/amd/display: Refactor DSC cap calculations

Let's do a few more boots to see which.

The sad part is that this machine builds a kernel quickly, but then
takes quite a while to boot, and the failure case requires me to then
reboot again to get to a working state...

But almost there,

            Linus

