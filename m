Return-Path: <linux-kernel+bounces-868904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C8C06739
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BA31C00FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F831C587;
	Fri, 24 Oct 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DcA2zw/o"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6919C546
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311971; cv=none; b=HjvB9M+x2e8jH1GhVLDrxCIUi2jzrMi+TQ2OOi07nbLbdZyAEnf8wYZBMUe+CbmgAyZxg6dIDylzOMEgjbfAdY9GrKpX+3xkRhXtsgFeoZadnTisJUQu8ysjpn3I1pg8J4Z5GUaY04aovCGwsW7n64PF+85tahiLG0AsOgx+ab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311971; c=relaxed/simple;
	bh=1SiLH2oZKrYr6G1LOocBI3A0/FbeTXAqtSKq+LfVhhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NN2nKOR/Joo3fib932dLYP7eRGUhmDKGAarzdGHH+IZLqBjr0OOg9YZJm9uykTKjrO55mF8Pa3MT5ox7bKC0bYaid4LM7J0mEf/XCetJhp2IqL7H393CXgwsEFtuZxDToKmRuasAFo9TE9GTepVWw1f2X5TKUzhtgPi4fdqtEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DcA2zw/o; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso3514575a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761311968; x=1761916768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd+byjApNbKDhYg7oeVVpvm1SD1excSJlnJeo52Q0hI=;
        b=DcA2zw/ouS+76DnKbt9hL1fReglb8Fm3Ksi2YNAu5MzDx7sg2apAaRPUQpBubLGqpW
         Akb4Q6Y5pYwGSVhEt3fdkBqx4VpAyHkTQC5NIPaAjtvMfZo/LFnDiNB48EWFpPbKFdhU
         A64PVv7TCPN810x5ftUWwLziCN7BZUPSIhcCfI8nwQv+OI+D5kSWLDjIKKR67A+JBHii
         tW7siOXp0rZIYMIrKP1aUYahqKfnmwb+fvqwIvYeGyi5UIgTcC3d6QWumafOcNKlDAuz
         HUzndoLZxde+uH31X2A+WPSs4J8qjGUka9SlUUUGifzjDupQzLOuF0BT+z1+7GfcR5ap
         zRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311968; x=1761916768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd+byjApNbKDhYg7oeVVpvm1SD1excSJlnJeo52Q0hI=;
        b=LUR5gFXa+vK7ux9Bxr3/P0pLRhcxoa7gsHE3LWmU/YwTOxfsKSVNqNh+PUzi4w2oFb
         nGPJX1DZgeejV0JgNEHgAIMZQP15D3Ptc6nEiudoschvOotfpkMSQEkB6oGfmRLZuQ85
         LLTe3pI7KqpR/E0ZxT5dpwF4ZhmbL5VLfp6DnM7d+DUr9FLhVaVYDLu2qfk1eTuODwGF
         xRMG8X+duKEhPmKCZldwI8AVmOjgRfQKR3G63zMG59YTMMw4M7zM7uSP6x/oNaeT5Lwq
         bTq8FpxWfB1QVOffNi5BPevrFXZBih6yxMYRJ1vA1rzCKT4g4aPry3CL7/oUyzU5sou3
         wpSg==
X-Forwarded-Encrypted: i=1; AJvYcCUTPUELnZLDI6VuxrWZeQf6J4kFM5Qv9RsrOxEjOEGvve5Duc7Vmi2BMuJ9Vz0qYvYPCbN4vKI/4CU3fzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Zk71WBMJeUXX23F59P7g46idSzcn3jWB+9n87ex0UHtg9dfe
	oP/SAoPsJGYTYCNQQH1EqSsT3yctoQ5KU5KIpYuxwkkGTz6CT6ndZKnqhq69wihWXZXEKycwCzR
	rQOWXQIqzlM+HgaiI3l5fBgvBRzE/gNZKAeE06bPsTw==
X-Gm-Gg: ASbGncv126kg8vF9t6+lALpLDDI4OsZ5t6/+16GH+z3OTRD7vvR5BYO233tnGEoyjdv
	95dCtAuXuK3zOzKN+psouz92ezFa4ussjaPcRhBvnFxxiOPtHr6DzKkLk/BKc6pdoETLYONcxCr
	ZRR0H3w7Lx7LXLHDlrpiEItEXuoX67Ub6Nkq9njOo7WEX6K93RDcR84x57MCOtTvityarlsmOnq
	s+Vw921EXgtVT0eFAPkr2WrOzZNMihK+QECy21m4cWDbvq0nty9roX+ag==
X-Google-Smtp-Source: AGHT+IHerXBAjE+eqb3d+VEJqly91GUZl7zoRvZTnmTC+7QMZhEDWBp0kb9IGewYF1+6lcIQ+kV8dBJajelZ0Tf7+s0=
X-Received: by 2002:a05:6402:1d49:b0:63c:43e6:16f7 with SMTP id
 4fb4d7f45d1cf-63c43e618d3mr26739268a12.26.1761311967869; Fri, 24 Oct 2025
 06:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-5-pasha.tatashin@soleen.com> <mafs0ecqvfazg.fsf@kernel.org>
In-Reply-To: <mafs0ecqvfazg.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:18:51 -0400
X-Gm-Features: AWmQ_bnYAH8dRV1ngHGEfK3HhlURkQgl2sSokzMwDTJAswcSitgikNMtMv1tkos
Message-ID: <CA+CK2bBA46PNuwDDa2pqNoLVN5vZq0nbfo3BnDwn7fXK1MFtdw@mail.gmail.com>
Subject: Re: [PATCHv7 4/7] kho: add interfaces to unpreserve folios and page ranges
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Oct 21 2025, Pasha Tatashin wrote:
>
> > Allow users of KHO to cancel the previous preservation by adding the
> > necessary interfaces to unpreserve folio and pages.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kexec_handover.h | 12 +++++
> >  kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
> >  2 files changed, 84 insertions(+), 13 deletions(-)
> >
> [...]
> >
> > +/**
> > + * kho_unpreserve_pages - unpreserve contiguous pages.
> > + * @page: first page in the list.
> > + * @nr_pages: number of pages.
> > + *
> > + * Instructs KHO to unpreserve @nr_pages contigious  pages starting fr=
om @page.
>
> s/contigious/contiguous. Also drop the extra space after it.
>
> > + * This call must exactly match a granularity at which memory was orig=
inally
> > + * preserved by kho_preserve_pages, call with the same @page and
> > + * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved b=
locks is
>
> Stray closing parenthesis here. Perhaps a rewording to: "This must be
> called with the same @page and @nr_pages as the corresponding
> kho_preserve_pages() call. Unpreserving arbitrary..."

Done.

>
> Other than this,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you.

