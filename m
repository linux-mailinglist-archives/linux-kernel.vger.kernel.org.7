Return-Path: <linux-kernel+bounces-730970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD44B04D19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE611887FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE781990D9;
	Tue, 15 Jul 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuzDbETN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A46156C79
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540092; cv=none; b=b5YAcMWhVb2tHCVY+uDgU7fNoHP1Shgh8Pwb5oUmN+n+9HtBY0Qqh3wVf6jv5LoZrudRE0IhKlkSDGAgTNq8DTipT4/yVrfu3RHyWVTiGyS9DLTnpvJXxQ7T0mnUK+0rgvYgyS5Ffag9wZJkjeqj5z9EDG8zTKMam05XvqiqtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540092; c=relaxed/simple;
	bh=e6u4kzbTlpY6XgWvdx0C4bqIzQlBCHDgDKiaDMRpPo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgSRahKQnrBaES2gBtKRBHoELsWJ0NVLcLvq9mocBnTv6n5t183k4yzFxdyUQBxn2SK3AFBOi3sL6FKeMNYmU+jGSOxWWlr/+dPW6W/5LMeFHDA/RzzNAKPcJ2ChTskO9lfK3CmdSVKfVV1ddTJ+1pPnqzAxrBq2nDcBSRHGl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuzDbETN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2357c61cda7so40595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752540090; x=1753144890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX1iqBfYXGafPsZgRW8n/DgE7iPmep19kIXNMUQ2HJk=;
        b=BuzDbETNvmIL53e3+0KoqNUHsuY7KjKSfZ+D3km9sfIIyrMA1jjzestPzCPQ48QQAB
         +HV2xiDtIMMSmTheQRdDx2Kwmj7sESw9yDHUOKpCWPJbG5mYQ13JqCbUGAIv0D2jGOAz
         WjZPlSC4X0YoMK10OaCruS4rFgwOgtoAjVW3FCNEtRhJs62K025I1H23/7+Hd1cz6dMU
         NgMc6sP+6mX4M6oqaLlhsNo2/f1KYgu3hx9oqdywFp4yY1qITuygiSnfIcifJCK4eZXA
         BhGVwDbnbZfrhmxc7Gft7UjMrH3Y/vfcRFfU2kfGW5sFwOdgN92Akccc1waMqwTqlXHk
         cdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752540090; x=1753144890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX1iqBfYXGafPsZgRW8n/DgE7iPmep19kIXNMUQ2HJk=;
        b=Qx6snDCk8MN58vg1+2KkDdwRpAWEsDlIWuE1//0ZTysFYCvW2hO8HzozM8+olRngFo
         2e7PyFkmOb0+v2ROglyTvbHEnMRPmF3QXg0HRg6mrbQ910swKF3vc4sysCeq34N56NXp
         0L3SS2JwO5mX4z4apN5C8cF+fxM/lGt2T3C8Fb/abyKDZoz7FlB4Gpbf2RLYgTDZuCRj
         883BESo3PNM6jU7yN3AIIJKh4+sF6ddLOmuE8Dyjc0u9UiANoOhlqDE0iDBPr7LCNAvp
         RJLDFngNfi/jvTFAIi029ujl86L2ZLpLWPA3S3QF5eIk+SortB5IbzCwD62iH77WcDeB
         azSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9reRqSIbA7+bBQw+Ea5xdBu+pjruMhqKfeghKLUJaYci/drTMElTZKmvYmM1uU5+WJUvkdlf6H5jG30w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5lDzqiI4IbhoAS9sCvQmwEEuaPRvekY1yBVLQz80VzGvSmky
	PD+hEanBwPhhHvoswC3f/pqC6pztthDhjZI0w7xssIkQHn7DH51uhPkYbGQBcaoX/hKRPeMgQQn
	Sp4o+FXrcoeygvHVxNNDeA4CqvtLDl/kU9n4PqBkN
X-Gm-Gg: ASbGnct1ifvkDPqf7s1ImCdbErYBemFrBDAs5FksHxJGEnbDTsVEB0KhAgUuqOj/EtR
	DY/SInIK4FhR1LyyHfZBF/30h6Mm8jpXIlajOVYK/8bIOo4MowHJTZJlNqjUFtuLsTdoV8IgDY/
	zzlO4HgU3ChrhB9jWo9ANYthhsmGlwWdYdkGh4DJmJXhwgWfyew8YR8btKN7HT2NZmZiooujP36
	tCcoN+9qpCRhEk+oY3b8mFfc7h6imp/KgyN0qloSJFS3pkI
X-Google-Smtp-Source: AGHT+IFnnn5TfVGyd1D3iP7UwsZJHVlC2o421euyx05G3rKVs3eMXQL5ccITcJ6SIchFux3YCwHP/tZwUq7+K6O/qMY=
X-Received: by 2002:a17:903:185:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-23e1b55fab4mr567335ad.25.1752540090046; Mon, 14 Jul 2025
 17:41:30 -0700 (PDT)
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
 <aHGWtsqr8c403nIj@google.com> <CAGtprH8trSVcES50p6dFCMQ+2aY2YSDMOPW0C03iBN4tfvgaWQ@mail.gmail.com>
 <68758e893367f_38ba712947a@iweiny-mobl.notmuch>
In-Reply-To: <68758e893367f_38ba712947a@iweiny-mobl.notmuch>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 14 Jul 2025 17:41:17 -0700
X-Gm-Features: Ac12FXw6OnnBeRg5tzGo9zODyPTk-FHWOunP2TNCEpzwOFdIR4F6wxZS-QA4P7E
Message-ID: <CAGtprH8O535VFYSTp+zqXF0cptDwOn5gwmJa=BLy1zoCdLa=iQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, david@redhat.com, ackerleytng@google.com, 
	tabba@google.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:10=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Vishal Annapurve wrote:
> > On Fri, Jul 11, 2025 at 3:56=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Fri, Jul 11, 2025, Ira Weiny wrote:
> > > > Michael Roth wrote:
> > > > > For in-place conversion: the idea is that userspace will convert
> > > > > private->shared to update in-place, then immediately convert back
> > > > > shared->private;
> > > >
> > > > Why convert from private to shared and back to private?  Userspace =
which
> > > > knows about mmap and supports it should create shared pages, mmap, =
write
> > > > data, then convert to private.
> > >
> > > Dunno if there's a strong usecase for converting to shared *and* popu=
lating the
> > > data, but I also don't know that it's worth going out of our way to p=
revent such
> > > behavior, at least not without a strong reason to do so.  E.g. if it =
allowed for
> > > a cleaner implementation or better semantics, then by all means.  But=
 I don't
> > > think that's true here?  Though I haven't thought hard about this, so=
 don't
> > > quote me on that. :-)
> >
> > If this is a huge page backing, starting as shared will split all the
> > pages to 4K granularity upon allocation.
>
> Why?  What is the reason it needs to be split?

I think you and Sean have similar questions.

This init private-> shared-> fill -> private scheme is for userspace
for the initial guest payload population. Another choice userspace has
is to begin the whole file as shared -> fill -> only needed ranges to
private.

Regarding shared memory ranges for CC VMs, guest_memfd huge page
support [1] simply works by splitting hugepages in 4K chunks for
shared regions to allow core-mm to manage the pages without affecting
rest of the private ranges within a hugepage. The need for splitting
has been discussed in MM alignment calls and LPC 2024[2].

[1] https://lore.kernel.org/lkml/cover.1747264138.git.ackerleytng@google.co=
m/
[2] https://lpc.events/event/18/contributions/1764/

