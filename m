Return-Path: <linux-kernel+bounces-743153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C276BB0FB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012D6544B98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB522222B4;
	Wed, 23 Jul 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FWV9ihP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1C5D8F0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300881; cv=none; b=pHhP9d6tD5BmmLsp3y7ww3iHY7t1PU58cc4iadQVqtUggIJsnXNVNfdo3lTFL7eogjRd27XLIe1ACb9lTMk1aB9tRXskE31vei7cF8lVW0hjT8rluGMxIOzl8gkjQbujxJo0SW+cCpl85TpTFl6LTB/BhL8Yj6PkRT3nmP9ZyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300881; c=relaxed/simple;
	bh=mmfqhyu9vL1PIyA4FAolJ8zTTEeu0mpAwsXikAz/bGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qT6aAWVDox0czqN0KOUqh7TZ+P95fkixOzkHRs8CRmBZkKLVClMD2Imx0EMLC0kKZNnKvIrc+fj84sLhE4yx2JSPQ4sZ8GNok0BZ3ccdajiBglqy/Llam3EDf3XqC/kB5RhyFC9sPCkIflO/eSKF7aA3lT5a3uBhEvnM3PEtbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FWV9ihP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso523a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753300878; x=1753905678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmfqhyu9vL1PIyA4FAolJ8zTTEeu0mpAwsXikAz/bGo=;
        b=2FWV9ihPtT1p2OV6zcXOkWC9q/0HphEiNNieJ4AS8E/U80N8rh6BpT2E9ekBpIwWc8
         dxmsE+BW/1rfVAH2hCSCovKLSHIlNWAtyPgJqfkgD/tL9nbDk++KYGMabcZzjL238pUK
         LkSBqufaAUMAKi/jiOvZGBW9ZJ0gLrYiHk8FEe/oCCR4uTeFSjcw7ldu4Xfo6+uHWZT+
         xlCA3WOmBAthNhd67khRPJQHCvMwQxOHCJBHovLSbzBCuMl/Qq0zBKsK73OeXchUm78k
         mjgFf1Mk3/poazZZCVD3f4m8k9ZDCZDFYo9dzF4BqSI69wo2yXDkecGsDwDKHx0wAGcr
         cAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300878; x=1753905678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmfqhyu9vL1PIyA4FAolJ8zTTEeu0mpAwsXikAz/bGo=;
        b=QLyq8ZDD7NGwkq/229o783+OFO/Xlv5UwX2/KvmDIaa1QIf67R5Sd+5+9TWcvWuikw
         M6uaQYgN5Nwc2sBLO0dMZ5oTM6mH2KTcuMuZl0ubOytozAMNpEbgLck1vGcH/qY44Rq3
         yIkR8Auwctla8ATOa+xsvmIfol6XIOkpMRwSrRFp0se6eP8EG6uVNHlEjnlxFsO2+tZG
         VxlWwvWec57TtfqQAmi7NpEwPy9+wEiPCCJ75+ToVYGaFTbjCtt8eejeNSaQR+Ie2qFO
         rLtDXubm4Rwsp0rHlGTe1UBuTJFKe3pWFEmGRyF4bwTVTuKNYw4Yp2uF1eCwdZp/nSDY
         CUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdiu6jrY7YMwHej2bNISOvB93I26vptJYPI3xQYVnxV3/QTMoQTVPRjNntFiqib/ib4a7gsu8dwYf8MHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZz2ynkPwRreyk71wTlvQNAXYfHFv6DoaOb/a1mProGRJAf0L
	Kw1aossO1LgkPNNfBZhvx3S4NJ1FwM7UKgVf6Vg818XZ/aGhKIiGXiDsiHOfMdCGC7Uj1xsGakx
	TgsVcwmJLTy+9n3iPUO7OUaz8M7SfzSXvQciPeMRD
X-Gm-Gg: ASbGncshP/ebn+5iqeFr2P1dRyERrxGxVFECZBpLZKvHyv5SlwZSAcdvD/T2jt7L376
	bU6A1OKTIvrWmNhqt6mOnM/zQMHBliQNkXPIAFm0aTEF1VAZ/0C61L7MR6O08mvrb1FbodniqKE
	PATZhURRAiZaw9z1gc6/AI8cBf7INqVsUIIIeWSb3jqZ3QmfJFH9oNIQwxNcvcTW+/g+vZVus0m
	fOsp+p93o92psa74OkRNkMt5CihaFPhBrs=
X-Google-Smtp-Source: AGHT+IEyXGTWR0XZZte/eASlEm7qrI06sVh3iGjpWdMzm8/vWVFxkQtUydmt9xCTl4XoHoqeljjoWTaB4r+v4tgfXVM=
X-Received: by 2002:a05:6402:290e:b0:60e:5391:a9e5 with SMTP id
 4fb4d7f45d1cf-614c50e54camr10227a12.5.1753300876951; Wed, 23 Jul 2025
 13:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <28e1fc65-995c-4185-b5c2-7eb001312698@lucifer.local> <CAG48ez0KE9bfFJ+yAMPUAj=_hcNRfes3=nfQd7Rv95TSnHtUCg@mail.gmail.com>
In-Reply-To: <CAG48ez0KE9bfFJ+yAMPUAj=_hcNRfes3=nfQd7Rv95TSnHtUCg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 22:00:40 +0200
X-Gm-Features: Ac12FXw7CgyRl7JjB9ySJ0F_t8x_hAcLmfJ4tfnYlheNfb0W0Wn0LvVOrf4lVAk
Message-ID: <CAG48ez0782x2dqa5LrK2cf9M0_Q=Gvo5tXsUFQDtyK00LpcvyQ@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 9:52=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> I'm not sure if I'm understanding you correctly; but yes,
> __vma_enter_locked() waits for all the waiters to drop their
> "refcounts". (It's not really a refcount, you can also think of it as
> a sleepable read-write lock where the low bits are the number of
> readers.)

Sorry, that's not entirely true, since an attached VMA has a refcount
elevated by one. It's kind of a refcount, and kind of forms part of a
sleepable read-write lock, it's complicated.

