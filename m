Return-Path: <linux-kernel+bounces-794929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5080B3EAF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5421884FC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D12D5947;
	Mon,  1 Sep 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V8FU0ftV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845B2D593E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740181; cv=none; b=MozLhJQPgUWTu8ziW0+AyoSQb6ypMTOFfaXNfCnYi9U0mAsU/gp0+/EEStsyQcluiiRN0uH8UEA2A1ryXvwjFo2VKoUg8C+F+SN5D1UJ58MkHkRf/IsjGrfTyGc26YBMQYpVmq5sjG3NrIe6+13BQCEMSq0yCUU2RW/PKyszEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740181; c=relaxed/simple;
	bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNjxpyQceEshMz7J9SmffSVT+gQVPRNB3xXAXILjhSKTS85Z3wVs282+7YQgwlqJHGInqP/jDhgaCkLCEfp0ZYTW1fR8p0M7G8QreWrNnnjikszGJ9Xu3ZPKEqc0blpyFkd7iihqbeq30KpnSodhOhFzJr2AZGYsvku7f7Lee0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V8FU0ftV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b042cc3953cso131331766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756740177; x=1757344977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=V8FU0ftVpb2p3tqAzIFJXxS9Ss99K7zDrWutbLl7NXM+DVbrHRVuPdUwELaYxrUoJ5
         m9CACTX/9p5DCsmSlRkv3pow87OTYaHJ+U/hZ3zV1ObOLfuEdmJ6W2D0SdgImFxt1rGc
         YBOBj8dcjxunOFCA4rlg2VL4iJpu8cz9Q9kZ9wh7pakm9lptgJPkdDmrl9Wbumvavx55
         PEVAgB14GA468wMQXDOyGILndkwcV4tLIz9txw9r/0k6Jh3z/xgkmkWzHLxAwFIh0tWW
         A2IhGwemR1wxv1W8X5/qKELXxe8HrfXNd6ANkNeRr8EAxaYN82MI94epPvY+f9P4695p
         dzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740177; x=1757344977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=fWacQRQer3yXCs19dyDqtQB5PP/2g90WlwiVz4hIx7luebEiZwENXgzdtP/ScKYcNU
         +L/o4hZ80400cmuOgIKcBbUDbIt+osnaPIsNKF/zUbZ5VCayAbIIzAoLhzs4ecvrBbb0
         XM/hpFB/kyoDe2aRBvx2OiZovibKm5D2IJb5jdHczfsObY0BaRMcAUIrC5T4T5HZRsG0
         TTg+PmRP4r5u0y0PZTLLoL15/7GxZWsHrxgQTkqc9vxv2Pc+v8tesrw9amWcSeLR5mu9
         2ZYwyEg0QGzLA7lDmP1qGRTWHeI53T3bfDzeBopmxSejBXYjkNS9Fzn9A4rDBbTpEdbp
         hT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXicDjk1KG8A1AjVlkw7scqUqL/RHoDMVNuDzzt62KmYjxL62f0PreDhg2EqDSQMWpHuC0SQM9HKOhc8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjK+sDR0l/PwyMo0TVijyfZ4fKZVpMhd0N1Yo9f6P+bgni8rX
	5KnN5Zn9tfwaePseCuo3RaWez+Js+Vg7VbYuoRz6sw0FRiWnmH5WS1vLrmLqjj8J7YBCIpCiEGC
	pOFlsIt5HwDtlnEartsqKie0h/M0T0811bFUPW4jn7A==
X-Gm-Gg: ASbGnctMA5hhp0vOBZLYDL0qnpqrICvNIpUmSP8JZY8AfHOugcNURFQeNebvILIgWWD
	FHgGxNvkPC95jqrbSesi9TjSsE49Gktot+GDoeGJVBB0agmM1lMLsHhdTXK/KIsmu5qWYo3QHcP
	kUxedIh4QcEOHFFYYUJxczq34jrYIW4o5h9mznpKTl0NibB6mkyUGd1gPU4l9gyNaUqWaOOHmlU
	dA8MYuGDYJVOdaMJVJvLRHVAwJN2EZPqsg=
X-Google-Smtp-Source: AGHT+IGyHGBQU5Fmr9N1bQCrhCA+i8zJzAFx27YAdwJf0bpouLhs7aYdtEtaq8rinlUX8phhR2x58GzGpQKldL70zDk=
X-Received: by 2002:a17:907:60cf:b0:afe:a7f0:80e6 with SMTP id
 a640c23a62f3a-b01d9756fb9mr875954466b.33.1756740177075; Mon, 01 Sep 2025
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com> <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
In-Reply-To: <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:22:45 +0200
X-Gm-Features: Ac12FXxiiebv9X2d18G9zaz1-52NeLol_OdOPtBiylMXolSmoqbk-OqNT_yTCiM
Message-ID: <CAKPOu+8SdvDAcNS12TjHWq_QL6pXnw4Pnhrq2_4DgJg8ASc67A@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:11=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> >> Should this also be *const ?
> >
> > No. These are function protoypes. A "const" on a parameter value
> > (pointer address, not pointed-to memory) makes no sense on a
> > prototype.
>
> But couldn't you argue the same about variable names? In most (not all
> :) ) we keep declaration + definition in sync. So thus my confusion.

Variable names in the prototypes have no effect either, but they serve
as useful documentation.

Whereas the "const" on a parameter value documents nothing - it's an
implementation detail whether the function would like to modify
parameter values. That implementation detail has no effect for the
caller.

Of course, we could have "const" in the prototype as well. This boils
down to personal taste. It's not my taste (has no use, has no effect,
documents nothing, only adds noise for no gain), so I didn't add it.
If you prefer to have that, I'll leave my taste and home and add it,
but only after you guys make up your minds about whether you want to
have const parameters at all.

