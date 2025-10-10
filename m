Return-Path: <linux-kernel+bounces-847653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C588BCB5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36093B711E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F92821B9F1;
	Fri, 10 Oct 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="No/BQ6GA"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335119EED3
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059763; cv=none; b=llfhPi6IBIS7qF4+wg3FSgJ5lnJyjTzytJ++LPaW/4WLpAbsZ3KmD//fugrnhUVj5A55C3OuECsvz0lF3GcjCkpwR/tLEoKR/dvnIsyvZsf3vNiMuUSusozAYpwxU30GJem4tskQaYK2UxVLzpC8sm/1sp7cl4p4RtIrMSjy7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059763; c=relaxed/simple;
	bh=7c5rwEMg8SrN1qzR5HQA9Xm/CmUTmi2KGtRzPG/E4B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3WEuktUZ1Gv1LyldsIfWSdd6GLgC4BF6DmoHyRXqd8GGxRPBI1wRoAXSWYNKmygqv44xAFCJWUG0X+NBEWnHtMtY2LtDMvh0tV+kYIBtei5VuKR2nlk/6MpVYVjJRBfe6rndQhSZuSCYACEWs0DgxNoJz7z1iYLBqSO1BWK+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=No/BQ6GA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e70609e042so4037831cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760059761; x=1760664561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c5rwEMg8SrN1qzR5HQA9Xm/CmUTmi2KGtRzPG/E4B0=;
        b=No/BQ6GAq/pWugZiBkxZGlvwbM96HAxG1lHr6MjO1JjZ/zStha1O1TErCzSUp1+5WQ
         5xNGiUGoGffLOR9U5c80+xNauMOZiwF+xjeMf70da/gOCsoaPYJCz0/v3OtDKI/t1x1Y
         dynLo83xSQBBaA0BwywEfbKdYsyBQ+2ZLcDBaXkPUH0bWrpt2oYKkvzg4kxmA5HuTazK
         Ih+Zo7TgWu5mFYmOhlM775CqvhSWuUBXvURHuev3kfPeEzsEd+gjsTF6Ij/I3csC0sxo
         d2o9MSksN+gk8p0ImHDpbK6Lzup74HRALv3Tk3t5eaZlNI/W0hoJiPNsX5w/jQlWgQ6C
         cEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059761; x=1760664561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c5rwEMg8SrN1qzR5HQA9Xm/CmUTmi2KGtRzPG/E4B0=;
        b=uM0LQoQyknUqOg5LPuKJHGdgTDwd4iH1BywZh6mmjLHyKHW84oaNpoqhq+ixL4Knhh
         Rh0rT/x4PoNNMgHFWQjU6vlBuDdd6hMP65PsDEDHtHGTzQwDHoVCF4IHoNFqJ9CfYHXg
         vD+RCqoBvtNY3nKM/ViF71rdvFNlhGysuVRIaYl52dxcAJSmPtkAaOlnyO1DOgP70MVj
         NyFYvyc/1I9N5q/mRH7UhEC4ZPbBk4ZxXZVoO6xODZtkX/aMVIZPNlc5NnPf0pr4Fahr
         dY93WGs7SGLiQ1vdq5GFMZdUUqKjJONK1VvYYgb7QUM4SEw+MUyDUJ8zjhrgO2YBwILy
         CG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTBn09wfYYL2IZBGA0LfhTrBQ/cJy77+cJv128UAQOnyyEXT5GIdnAyP50eNumGiSX+WF2SVGziDDGA50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMwxeDdxBM1ToZlfOeWzQnrKMnM+JHOzhWS5eIZSn8TnPyofv
	VkyzTcc0liOqeSrh8YaHdBjCBtDgWdM6juYIGgBCgxayMTGbKdieRvHUaAAgEX1HqDKswm4fnjX
	3gfIdh/g74+bxxHXRzogDKmc9YUebTq86xOY5FADjFQ==
X-Gm-Gg: ASbGncuF8k6Z97gtGmmiHb3s9XwwuRQjGVpNzgedEZIHMCEGXCB2f8WtJ8kOgcqiqdI
	MDmazwMLI5H20Bj9td8Gobrq4rYpInH1Camwf7h7Z/6oqtcX0ZDBCQvI+Z2PIsZfQWQS0RoIEYI
	TgxZe3GFn5Ca3EfCzoHd4/9v+Ld0hWoCT6Yb3lNea4OcJhsg8OGyrAQEiJhK9p9Yn5q9Q3qq9Xe
	3Yi39jc8Vt4/ervd573F44+MNRz
X-Google-Smtp-Source: AGHT+IFYIAwQ01bOh934nEooe6YyzjY9BSYL4qW3XccSVaxr7aFcJrk9W6LVbYGLQHAQNTZz3Rnu871Z5RCJbyw4chg=
X-Received: by 2002:a05:622a:4c18:b0:4d9:f929:1531 with SMTP id
 d75a77b69052e-4e6eace963bmr157505201cf.23.1760059761013; Thu, 09 Oct 2025
 18:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca> <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
 <20251002173715.GH3195829@ziepe.ca>
In-Reply-To: <20251002173715.GH3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 21:28:44 -0400
X-Gm-Features: AS18NWDnCmbQmTfSFshrGhyBAifH9UjAR4aAfwdB_LFAs9e46ObD6oWFGCIZCGs
Message-ID: <CA+CK2bC58SLTrROtBQaegzSfjU+bwH_3pjjWdd+JTnHqQPuAwg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:37=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > > I think the simplest thing is the domain exists forever until
> > > userspace attaches an iommufd, takes ownership of it and frees it.
> > > Nothing to do with finish.
> >
> > Hmm.. I think this is tricky. There needs to be a way to clean up and
> > discard the old state if the userspace doesn't need it.
>
> Why?
>
> Isn't "userspace doesn't need it" some extermely weird unused corner
> case?

It might be a corner case, but at cloud scale, even rare cases happen.
For example, if four VMs are resumed and one crashes while retrieving
half of its resources, we can't simply reboot the machine because of
that. We must have a way to recover the machine to a normal state,
even if some resources are not reclaimed. I would say that finish must
be properly backward-ordered, but we still should release resources
that are not reclaimed during finish, as well as those that were
reclaimed but later closed.

Pasha

