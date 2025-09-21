Return-Path: <linux-kernel+bounces-826462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4494B8E958
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEA83B7EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D924DCE2;
	Sun, 21 Sep 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QGxxEBZ7"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B917B3E1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496060; cv=none; b=ot9Y+JGhRr5eeaVsXabMVQ8KM66NK5tO5S86frj0VW5z6DSiwW+vI5DOtfJXSVcskQiFxnghVqx80Mdgf/JH1WyR186hLNMpyOwPIhjjaspG6x0cXSzcTMgm/jngm5azM48JWyvuwJXyilMifToAurRiSDMP47A0qWvcK0jUaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496060; c=relaxed/simple;
	bh=ryAD8ndu9UdBCdE41QTkCS+/Io/eF90OHESujU5J02w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCVc1pYLeLFZL3PEYlUfmOFV0AZmTpViXk62Txb3YOBVRrTQOlWJDE4N843eL+b9/PrYrfyY7w5GWAxkXUD6OR8V8NV0zNfKNh9k0VTPwx8K9iv3MC0nUycBsPX3G2Zf214osfYudv2fWpC6YGqA8xnTkiPqml1aWOhy961ZIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QGxxEBZ7; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b7a434b2d0so33445081cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758496058; x=1759100858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLMc7S+BvGFbDaO/gJECxMl9cCHViKZI7SeUZwZSwFM=;
        b=QGxxEBZ7nYy2oY3pQlE44UpgRf66x4Qv0NWRiq9eWziULNvkY9TYLkX0SmLspcgruN
         gMZePXEOKQIvHlk6IyAWBF2PveAhWHdhuxihI5K5pl1cmnukgZ2QHTl5zXfceC7bS3ou
         bA7KgI6YTAaUkwgWxaXcclJzld34tqr7mYLY9+bBO1amp7Mo0YtHQlYeOXS3dcg4iWPQ
         6KMockA2sFGMJtVbFHHoDWf3Yn2eJf4Nxt+HF8OkDoDj3VdD5DjWBLDqVuSOwBoqbZta
         k9zkxV+9go+180xmw6iNKumNS9c5HLa7Z2C51o0FroA2CITIQ5a9DxAJk44SV5azDy/V
         gk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758496058; x=1759100858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLMc7S+BvGFbDaO/gJECxMl9cCHViKZI7SeUZwZSwFM=;
        b=d1ChfrxDwe3MUlflsnyEpVZEHhi3uYswFEnWREahfMpQ4paxP9F3z7AMDnmI3YAubd
         srgW/f+tvwsZyOTeB2vi28hTzkQKlFGdeT3oRBS0JjY5nBktjFc9aS7nHrcyt1uJ2Xo2
         ceGjXWQhfgBibv+1Yggijb6rxVEV6XMlusIRgO1Vvt1SAvxSRuJKm0Cn7xIE88zrKp9e
         +j8dPjapj/2s/QrVPYeMUhXYzVAZX6XuQvLNJwr2RNv0O0lyE9VLTkFnJseqfSHZ3xGc
         WE0OAeVeRyueESvxkCTz3zIWxs0EPJkoH52rb8BQNV0mOu0iksy9YeBX60wkgUmWqHiA
         NZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUn8zQkykHd45EO3yppS+JY5B6xf1rwMe+W2AaAyJSypIl2i+PHdhL0EXemgdWU+S7YTjaX7N9W4paViEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxh44wkEQ6R8WEtg3OMkyLuaCuTtEIfnazP4q1hvGH7F5ZvT9
	Vcyst+4zW6doH4fDfEsa1zg7qZPra7ze3YPlUKebn0QoUYf7lfKbhwKC53iUxemU81nVx0wUIPK
	Wp4UcTdkzUhA1JJy5UtYQD3UnQ5VP8PHTU9C9SZthQw==
X-Gm-Gg: ASbGncs22/LG009m5bAzltEzl9fedGJpvcdqUp68J9hylTfxqX88uKBH9D3Y5fWzn8T
	xyJJ5KyfLicPXWCTX3A47tMzVlsaFdyFbVn/vSmZQ2V1CvsntLTTrFer8Qz0eKNh9jmmLkxNXWr
	us7UYRqUl79vOkfaaPvyffSzYwmiXuwZ1e2sp78OHXmb4Urs9UqVBq/QgZBOHKeLbxK6Sla/Al7
	uaL
X-Google-Smtp-Source: AGHT+IHmze5kshtpkjcVDTa3fEK5IBVKNtBZKjp0RsV9bU4OnWjNfFA7pSzx83Z/cbIj8bRK8EXOYxNjbrN+FqGjSUM=
X-Received: by 2002:a05:622a:198b:b0:4b5:e807:75bc with SMTP id
 d75a77b69052e-4c07623261amr138764581cf.80.1758496057664; Sun, 21 Sep 2025
 16:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917113609.GB1086830@nvidia.com>
 <aNB7fTesaVCXHB0E@casper.infradead.org>
In-Reply-To: <aNB7fTesaVCXHB0E@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Sep 2025 19:07:01 -0400
X-Gm-Features: AS18NWARkb_6dtXKYB99s3afrmUWcnRiCwC7xnI9uhoqJ6HmAQbNH9XqJVlHJgw
Message-ID: <CA+CK2bDBU4Bb83tUyzdiTa+kjhKK7fvObzpqH1gOPwKqoOnO8Q@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Make KHO Stateless
To: Matthew Wilcox <willy@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 6:26=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Sep 17, 2025 at 08:36:09AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> > > This series transitions KHO from an xarray-based metadata tracking
> > > system with serialization to using page table like data structures
> > > that can be passed directly to the next kernel.
> > >
> > > The key motivations for this change are to:
> > > - Eliminate the need for data serialization before kexec.
> > > - Remove the former KHO state machine by deprecating the finalize
> > >   and abort states.
> > > - Pass preservation metadata more directly to the next kernel via the=
 FDT.
> > >
> > > The new approach uses a per-order page table structure (kho_order_tab=
le,
> > > kho_page_table, kho_bitmap_table) to mark preserved pages. The physic=
al
> > > address of the root `kho_order_table` is passed in the FDT, allowing =
the
> > > next kernel to reconstruct the preserved memory map.
> >
> > It is not a "page table" structure, it is just a radix tree with bits
> > as the leaf.
>
> Sounds like the IDA data structure.  Maybe that API needs to be enhanced
> for this use case, but surely using the same data structure would be a
> good thing?

Normally, I would agree, but in this case, this has to be a simple
data structure that, in the long run, is going to be stable between
different kernel versions: the old and the next kernel must understand
it. Therefore, relying on any external data structure would require
the maintainers and other developers to be aware of this rather
unusual kernel requirement. So, I think it is much better to keep this
implementation private to KHO, whose only responsibility is reliably
passing memory pages from the old kernel to the next kernel.

