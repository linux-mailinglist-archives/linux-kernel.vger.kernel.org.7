Return-Path: <linux-kernel+bounces-789985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB010B39DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7C27C808F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539531158F;
	Thu, 28 Aug 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IDT6xgKs"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0B3115AD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385533; cv=none; b=tp3Lvq+u9cWHBEu33rvUIFim+/c5c2CgTDnkSCjRH7FqlKos9jZslQxkE5kGI/D6o3W+7SC5Ftvl390TlG3zSF+cjLG2g2Vp4YQg4CTpyIrT3TwAJ4SMmFudi89OSEZfwJtSIvT4h5Z+xHi/34pEGjqKHnXT0NB3FtqRXoHgLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385533; c=relaxed/simple;
	bh=Ho1CxaGu4ava7iJtRknlMqWJKlv0JrGEpalyeDE76Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuWXxLz74q5CpLZO1njrDoMbIij/MbGv4ILil1o0HabEoltnyqDk2jWpZw75FNjpGcoOixGpDawnEJzT/PGmtCLMGqADcmdXgiGWKbqjWC8WrfgRzh51c0goLCAV4sUtoPLO/ioBuniKBwfo6y/qM+5J2ZGRtUR/GjsXyIiGzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IDT6xgKs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afec5651966so155848466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756385530; x=1756990330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho1CxaGu4ava7iJtRknlMqWJKlv0JrGEpalyeDE76Xc=;
        b=IDT6xgKsdd+hVm51hhNUoMbZ15y6O31glDLYd92x0QjKtPu9K5/KfF2jjJjEwfrrr3
         qMUw6lWIfEcGUB46P008CBcsi+zHDOSppHFLfJ5jaCBCdzw8auyqSD7EjOkDKmOMOKW4
         Q4zLk9FqgQQr33lCDOx3em1DBw/DbrTL8cknJwR/JM2jxWzmkRTc7t4MZzWOEQh188PP
         QaLyrx/1Qc/7FMQJjLDlyaj8t5T78xx2yTMj07pssBrrUSTS+YyFykmXVSlEOvJ8bgfX
         XFyHj1lAOcdf5JAs/U8xQA8rwThsp4CrTHgMAw+HSaRr4wP/GFF6pCNFU/rD1fHwzeyz
         +9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385530; x=1756990330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ho1CxaGu4ava7iJtRknlMqWJKlv0JrGEpalyeDE76Xc=;
        b=UFEalmTGRhs36Qe63LdPEIA0nhImmlHg6lY3EPaRqi8c+Fvf6bXVHyg9tyJbo6sSF9
         MWSIcBaTKj3gcjwMwDXOdzBKOGSpQDLoHeaqo139COljnn1uQUG0Gn0LxAbCH216a4Yh
         1YeT3Eo59we5WNGm8ry+UQ3d3KcdkoxmAY0PGEZiRx9vHHt7HZLMhiy0mfH00GnReiVo
         v0PY8PWnj29iQ++W1HrZ/gQNGrM98hFjC9zsyV6hFkPDgJ5JnykMYksr1vTJh2C7paZ9
         BgsH6eVIW+2b19Um2X/MydDANzH4KFBbUEJikobWGzWiFYV4t63HTram3lgO/ahCf+Tj
         qVBw==
X-Forwarded-Encrypted: i=1; AJvYcCXCNEGI+9qqtTCsZpkRESj2zdiuMjNPj9qe3jlweME07S3KdVgeZ2hV8FBP0tmYD6qm7hHWyufDUWLdFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU+oDfSdLQTXUFSWU+klQOmGYp2angKQ/iPeWL0fAViQbFqTZ
	Ut1OCprb91LlWv3bUkEgVDhTznG9EqAewsr7jZocsFNkC947m/oYI3HjeWglbqO6wyZkcoJgypO
	B4XNL3wZqwWbb2F5LUBaN6uiCi2JvPNy9z73IAR6S0uM+KJ7LQ7dI
X-Gm-Gg: ASbGncuCwbiGXIdTzmFXR9UTkZFiIQn06yHGYzjZwxYUiUTfeM5y8lYCiORYNVH46Lw
	0bwIb7LkNI86p1PRZdJVQIq43ERULuOKMzzYa8R///vCkzJTe3TCUCGJhjl9NIwWvZ2aQy8aSuC
	J4Tw0KI/ZKRj8G6zFPmSsx/DjIpFmcQBouHYW9RaV5wy5YT4ONfNuZraL8sOWaQkj13YPACNTXT
	70B5zGPom3fe557M0SQ31E7OUeco+N1KaQkgF4hU2Ej4w==
X-Google-Smtp-Source: AGHT+IEUruiZnTPAQ2kjE5R1Bq8XvMTsAfpPl72mQjQ/ziygxxvim0xmPbmYHgr42t/epiUOqsMoo++HpvTafksgVXo=
X-Received: by 2002:a17:907:3f9a:b0:afe:d21f:7af0 with SMTP id
 a640c23a62f3a-afed21f7e3cmr416615066b.14.1756385530015; Thu, 28 Aug 2025
 05:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <c688a2f6-375e-4a00-8d44-6a833e3d30ef@lucifer.local> <27a21510-e9e8-4eb2-9e26-618c103d49c6@redhat.com>
 <CAKPOu+8DbXY6wT_8gcqLDpyZEg0=En6wOYtHX_VkUvZ_oOLHSg@mail.gmail.com> <372a00c8-86e5-4a73-a1e0-ffb8502ccee0@lucifer.local>
In-Reply-To: <372a00c8-86e5-4a73-a1e0-ffb8502ccee0@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Aug 2025 14:51:58 +0200
X-Gm-Features: Ac12FXwHbjxQ1bdGFj6fLXNtPwEhHCOjsF1A3h1FX5zol4wRdGxbToDVPzAOT4A
Message-ID: <CAKPOu+8esz_C=-m1+-Uip3ynbLm1geutJc7ip56mNJTOpm0BPA@mail.gmail.com>
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 2:43=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 28, 2025 at 02:40:29PM +0200, Max Kellermann wrote:
> > > On 28.08.25 14:24, Lorenzo Stoakes wrote:
> > > > On Wed, Aug 27, 2025 at 09:22:33PM +0200, Max Kellermann wrote:
> > > >> For improved const-correctness.
> > > >
> > > > 'const-correctness' in C is extremely weak.
> >
> > "const correctness" is a commonly used term for this concept, and I
> > find your arguments against const-correctness "extremely weak". I
>
> Max, don't speak to me like this, it's disrespectful and unnecessary.
>
> > So you suggest splitting the patch into many? I can do that, but will
> > it be merged then, or will Lorenzo be able block it? Will further
> > const-correctness changes from others (e.g. Willy) be rejected, too?
>
> Also this is totally unacceptable. Speak to people with respect on the
> mailing list. This is not how to interact here.

I don't get it. What exactly bothers you?

