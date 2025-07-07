Return-Path: <linux-kernel+bounces-720047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C17BAFB63A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8882162396
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A42D8373;
	Mon,  7 Jul 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwyxl93z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC2288C19
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899049; cv=none; b=huUWQBpRa4u3YBwGzSXb+ZRFunUg0R/tWKMIrp1g9+V70G4BPZcsy+Ufb1c1qinedh8N+qA1ckrjSJEgmOaxje7tH7tvq6aYkqdHRUWGc7JruOnfGtViBQwQA9OcIdCZvzfpLrCFpWmXF5AFumaW2YbQnHQm4j6okg0nKXFn1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899049; c=relaxed/simple;
	bh=JVzEUf8d46X+1TyurtsvmvEPFDWxvAuVaAPdsdMEda0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1Ngbv8K31GhWmQjb92IkUnx+sKe1tJY2kSoTxzB5z1BzPH1H7LxM5+dAoutggQSF2h1SyGAU1Qc6W9umQFaad7maI6yKD9T54O0sXsxF/e4Sz6jqAkgFCUwa93AKk+si0wIq8DKNany164nMHzAAh1bKLxuYqEBlkFOvDWtbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwyxl93z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751899045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqvKlmPJ4I9gAV0QuPRJRq7KjZnBRHxmrPJwdWlhbu0=;
	b=bwyxl93zIiv0OLrCviWjwgkKhr+mMmFCwJGxdc5hHsuFe3LMcDUuB2oDAYZsf+lpNSp7lZ
	52/6A2EqV8SdjwkUDWTfTlA34//nM9imI78+TQZG+wNVZ1lJMKByhNHIqXojyT1K4oZLjQ
	VuXADs1HWWQah+0PVd1a/mf7kYlPupE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-ZMgHtrd9MRqQklkfXoZZeQ-1; Mon, 07 Jul 2025 10:37:24 -0400
X-MC-Unique: ZMgHtrd9MRqQklkfXoZZeQ-1
X-Mimecast-MFC-AGG-ID: ZMgHtrd9MRqQklkfXoZZeQ_1751899043
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-adb33457610so314937966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 07:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751899043; x=1752503843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqvKlmPJ4I9gAV0QuPRJRq7KjZnBRHxmrPJwdWlhbu0=;
        b=ubZCMiqhB9FDrJ1wBuA9cVndvyyw29k64RA0timHNidhp8t/ulF2TKsMPrt400/lrr
         v/XetWPXuEQqCxxGEBl6fbUFEZT4MEMmlKL4Bas59GGdgZwLkCRFSmRwwXDnD7mlToUo
         j+J5OMDMlJNHST6YO2ywkM4hcyI8a23kChyR4hZcyruO+8ooGdDxRNw4FswF0hIyaW+Q
         DdrBHqoqhw090BqpB73TublpZWW0UQAIPuZp6PFR7eeAJ3byP799o6KcGQCsTjog9uqi
         2XPDdYjoQW/NugMT5N/43E+M8PQhXgYBdVghWk2h7yRdX7HvWN7aNiRzq/MvFHC014pD
         k5zg==
X-Gm-Message-State: AOJu0YxMyfVQjC0nAvb3m3wzoxT+uKcw/RTZsnlzilAWBwnrYpqfipEJ
	Gq3CP9xiakJnwwBsmm54XCMV4RfMNykm6dOI9O6HXmk1KjLtYP5/BNikZpBGvy4t/f4dm0xz9x/
	xWw4eqpU1xh7XBklW3WQx6ewSJZQagI1LdtUveswdT/8hQeNXrqSlK+5QHCVgG+gt35hdc2AsLd
	j/mvA+tVwsWG81HPWafOXFlxnZCoKOlcvwWP3pWG01h8KME6Gp
X-Gm-Gg: ASbGnctK0ddamlnrE+fqM2+UQhAn3E19diRWbdQZLqA/jihxkDPtJezyLYwitJd0Y8C
	RUTglaQ2FF1SMMLxPETo6IyAb8BLrVtHWvgEYgEgPPHkkH76V895BHQcRxwqbno7ZGzM1wOmech
	zXZUriVUqEF2GmsWT4VNq6+bQTRjgd2tB+
X-Received: by 2002:a17:907:6ea5:b0:ae3:5e2d:a8bf with SMTP id a640c23a62f3a-ae3fe5bde90mr1254027166b.14.1751899043141;
        Mon, 07 Jul 2025 07:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2rWxllcFS5ywAo3gj1UHR4L/AtdKnBTyuC4S6YZ6OMP3OMSoEKTk5WznoWU5bL+m01nCsSBqDVUmGdQ0WBXo=
X-Received: by 2002:a17:907:6ea5:b0:ae3:5e2d:a8bf with SMTP id
 a640c23a62f3a-ae3fe5bde90mr1254025566b.14.1751899042790; Mon, 07 Jul 2025
 07:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530200305.85319-2-jsavitz@redhat.com> <CAL1p7m53yJ-dpg6L2QVQM7bshWYXAxOJjrVGdTG8cDMEhNogyA@mail.gmail.com>
 <CAL1p7m4bK1LA6Atc4P0h_wC1Kb47Vzb93C8tmJtMiEBDLy6yzA@mail.gmail.com> <CAL1p7m4PzOvrAT70RVWR-cQ48-h2MZ_nms-SE_GsZ_GLujZXnQ@mail.gmail.com>
In-Reply-To: <CAL1p7m4PzOvrAT70RVWR-cQ48-h2MZ_nms-SE_GsZ_GLujZXnQ@mail.gmail.com>
From: Joel Savitz <jsavitz@redhat.com>
Date: Mon, 7 Jul 2025 10:37:07 -0400
X-Gm-Features: Ac12FXyA1Qs-O3SUdp1en-yGcbMitQ0dXqRQAUSO0sQBLQ0wLTe0u7yMI1v0JGc
Message-ID: <CAL1p7m4+6S95fKZ6ZEBTXgvFqTHa5=SqkHKrESSg8-MPmgiD5Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] kernel/nsproxy: Minor nsproxy code simplification
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 12:41=E2=80=AFPM Joel Savitz <jsavitz@redhat.com> wr=
ote:
>
> On Wed, Jun 18, 2025 at 3:49=E2=80=AFPM Joel Savitz <jsavitz@redhat.com> =
wrote:
> >
> > On Mon, Jun 9, 2025 at 10:23=E2=80=AFAM Joel Savitz <jsavitz@redhat.com=
> wrote:
> > >
> > > On Fri, May 30, 2025 at 4:03=E2=80=AFPM Joel Savitz <jsavitz@redhat.c=
om> wrote:
> > > >
> > > > The first patch removes an unnecessary guard by the same logic as
> > > > commit 5caa2d89b7f1 ("kernel/nsproxy: remove unnecessary guards").
> > > >
> > > > The second patch fixes the total ordering of resource acquisition
> > > > in validate_nsset().
> > > >
> > > > The third patch implements usage of the cleanup helper added by com=
mit
> > > > d057c108155a ("nsproxy: add a cleanup helper for nsproxy").
> > > >
> > > > Joel Savitz (3):
> > > >   kernel/nsproxy: remove unnecessary guard in validate_nsset()
> > > >   kernel/nsproxy: fix put_*() call ordering in validate_nsset()
> > > >   kernel/nsproxy: utilize cleanup helper for nsproxy references
> > > >
> > > >  kernel/nsproxy.c | 12 +++---------
> > > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > > >
> > > > --
> > > > 2.45.2
> > > >
> > >
> > > ping
> >
> > ping 2
>
> ping 3

ping 4


