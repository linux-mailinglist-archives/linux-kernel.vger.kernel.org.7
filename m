Return-Path: <linux-kernel+bounces-728358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C822B02759
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB487AADAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66720223716;
	Fri, 11 Jul 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HztT4eIG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB33223339
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275101; cv=none; b=fdhC73yk1B5HSfz7K4a8BOc5OTvYh+YH210qwPiVIol6GViDvvHjRs4OMBpaznSrDNvRMpNEa9oBnSzJiZ38L9U7Bq7OoTVlsPrbC/hf6+f8YLuTlLdBYV6cfWj3npDEKb1axZ7xv7JGUGlex30VK7PHpQWMn9xNVVVX1OJlfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275101; c=relaxed/simple;
	bh=nnIOfDA/IHDzCc1ICgQILjechAoW55OWkyKQz0wmAqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkCSDRhFUmm/tlAPIpdr6u+A9O3U0jtYPiNdaBc5rgJcr2mDBND4ghthpAOHZtKufvyVRMr1rJ79Lkwl4dezUQN+izELyD4k4K5vmMxS1otOirrwxNdACWKJdX6eT38sg19Y/SBA4K9POs6+Ufz0IdTixWmFPttYyWOhrgrXyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HztT4eIG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237f18108d2so65625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752275100; x=1752879900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIRp4nuNG0MkOmILiokqVBZt7BZxwtFgO4R23+cjxTY=;
        b=HztT4eIG7dkWfloD7++kqit90kTaeqv3MYW5kGKANRMG2dpg0HKPP3lBMgMgRPHUJS
         JJwgRipwG8X1Gl1WAffyfn+caKviNWgDhu1F4OQ/EvuyDqWJyilUaBZzb6sRqMGohvWV
         gqig75Du/5MiXuxcL3Y3q09zhq1KUXQtjf3z3VtLtxqh/F3EuSPLUJrnFTmz+mqnVUiD
         Kca3z0zKXA6NW952l6ok1tleIipCDpAg/ytR1NJ60bbuFsnWQSDSFWagbNmC6iPIRqsM
         ifjyjPFVf7+Bq48ShB+/Pw07Y0BXh2w6LBdxg6hRBXuc2JY5/nTABvgRh29DE7IHxDQA
         xqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752275100; x=1752879900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIRp4nuNG0MkOmILiokqVBZt7BZxwtFgO4R23+cjxTY=;
        b=ftU1H2gjVUMt9iuPuNYAS04ED03wTWHbd8zVRnm+Gflht6Lk6JbnZL5WtqcLpLdVCu
         gTpxCZ+95Y/WfhmuWjP4jKP3QnMnFOTqPhNEzt0h/xzKFvildvQJt/mby4Z87citi7kk
         RjsDVM+3UkUbjN7kb8g1MC1xKZOOFndDC6kWrY76PMGIozUfTE5o+IHK26EZfu6OxFQz
         eq4e2q+/Aop9QXpzNJlu4qccOV7Vsurav59ohFNVgVA2wBY1xCyPf5OICJpSBztsHr4I
         vRy5neR6tOqsD9A10NnRJGcGmC5P2zu/WmndNfNGsrXrjUPjxzNO8h/fxjTj1SUuMcav
         8FMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+pGIL+sU1mVZY6/6BMu8PlGhlMXnmFwO9m7gIchQFvVXd0lYc826UEuxy8/jJYLFc6iBNtQHaPKvqOlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHp4czbGcLSWodm4YTHcAxtPnHgSjsA72p225m3/pgHKee+0k
	p1eZy0rMmCg5jidRmKIJAvsM8HPWDa2fCW3R1/eTWtsCcogPLM4AAShAopo355OkZsMoV1MpiYZ
	KxbnDESdjUervPGk477dPMT4bKzvvNw2HsbOp82A9
X-Gm-Gg: ASbGnctR9fgXeRg7OCvqJbrEGPKYZ8G2dtIfy+V9v01RdbNLpIDNAiRye4CBgQ1zyyP
	iWHEATcu3yj8uNorfhWoZlnEn34g3pKCZOMcVn7yvIP7ay2tPrhYbN0j6Z0hXdhMwk5EmDUyQUF
	rOq6kRnyJAxlwPnqbtOnN2aKjdPxFT/muWKE9QA1Lmp6b+bsW6oIGGBvz2G3FQAd1eY6zRSltFK
	2yEwp7nWL+eOXOz3Nh+WNSfoVByNCay0TypYQ==
X-Google-Smtp-Source: AGHT+IFJLvFxh6Cj1EDVhy5GEJi7jwQTmD7bIFZI5RL+Eu8jhB1itNhMZdfzi4fnCqB1Sk/SsjQhxXaIpf58qI+KDks=
X-Received: by 2002:a17:903:f87:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-23df69c05b2mr1076015ad.0.1752275099063; Fri, 11 Jul 2025
 16:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703062641.3247-1-yan.y.zhao@intel.com> <20250709232103.zwmufocd3l7sqk7y@amd.com>
 <aG_pLUlHdYIZ2luh@google.com> <aHCUyKJ4I4BQnfFP@yzhao56-desk>
 <20250711151719.goee7eqti4xyhsqr@amd.com> <aHEwT4X0RcfZzHlt@google.com>
 <20250711163440.kwjebnzd7zeb4bxt@amd.com> <68717342cfafc_37c14b294a6@iweiny-mobl.notmuch>
 <aHGWtsqr8c403nIj@google.com>
In-Reply-To: <aHGWtsqr8c403nIj@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 11 Jul 2025 16:04:46 -0700
X-Gm-Features: Ac12FXyee47OthrUwA6ohIyisIic2g-mdZCcRA0a9PdY6GqJGMDKM9zNg7Zgiy0
Message-ID: <CAGtprH8trSVcES50p6dFCMQ+2aY2YSDMOPW0C03iBN4tfvgaWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, david@redhat.com, ackerleytng@google.com, 
	tabba@google.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:56=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 11, 2025, Ira Weiny wrote:
> > Michael Roth wrote:
> > > For in-place conversion: the idea is that userspace will convert
> > > private->shared to update in-place, then immediately convert back
> > > shared->private;
> >
> > Why convert from private to shared and back to private?  Userspace whic=
h
> > knows about mmap and supports it should create shared pages, mmap, writ=
e
> > data, then convert to private.
>
> Dunno if there's a strong usecase for converting to shared *and* populati=
ng the
> data, but I also don't know that it's worth going out of our way to preve=
nt such
> behavior, at least not without a strong reason to do so.  E.g. if it allo=
wed for
> a cleaner implementation or better semantics, then by all means.  But I d=
on't
> think that's true here?  Though I haven't thought hard about this, so don=
't
> quote me on that. :-)

If this is a huge page backing, starting as shared will split all the
pages to 4K granularity upon allocation. To avoid splitting, userspace
can start with everything as private when working with hugepages and
then follow convert to shared -> populate -> convert to private as
needed.

>
> > Old userspace will create private and pass in a source pointer for the
> > initial data as it does today.
> >
> > Internally, the post_populate() callback only needs to know if the data=
 is
> > in place or coming from somewhere else (ie src !=3D NULL).
>
> I think there will be a third option: data needs to be zeroed, i.e. the !=
src &&
> !PRESERVED case.

