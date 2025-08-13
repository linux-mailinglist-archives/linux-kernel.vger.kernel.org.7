Return-Path: <linux-kernel+bounces-766793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FCB24B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D14166D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37832ED157;
	Wed, 13 Aug 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+4Fmtxn"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C02ED145
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093041; cv=none; b=QHH9gjQzJzMxKDECnXO5BVfk8untlq9fCZnHW+YyVbrG2ue/XD6BsTLm/sqDTXG5ChZwjw0pnj19OhcFP/j9lliNbTiZbrgwApkEtMxWFolUCzBqFpyShPZHFDKcjm2fSyROj2HGO0ILD6IeIC0JJfgsvVzF3TUMLbFtbo3eexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093041; c=relaxed/simple;
	bh=Th4SgWJ7uOrhbJgJsJ1OslYEWLKNV+cmdvYGwrA7T+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8+UGrDeWogBp5nLGoySlMqcqINFI3hGhQXiplxmXs6oVKkfmLmSz1SZY2vkV4siX9v1kTctaF0vay5bcrtVAxAs/aO9xYZMK/vTM5djK3vuZVFBM3oafQ5dRIqzSHL0gZHn/TcCR5GTmpyB5vzftrpQ+pffisH/+rOuOYMGR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+4Fmtxn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7910123a0so5883143f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755093038; x=1755697838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX7HsBZ1OSxtuZpt+0fUOkrMNSmDcBAX1JrxfwqVFSE=;
        b=I+4FmtxnFZLEaXk8+qCr4cn8GcUsrpVhl4TiAG+MPNs8IX57z/AcyQEpg00hcDrFbL
         6QN1Td2nkXBXLhfbpumDzK+Kudldg8zC7QeyMPl0mybfOQo1qs+HSVrs7Y78+JvIe91D
         TtSkW7BvWI+FeHcne4eHWKHCcS2wkuFi7yVQJv5erTVQuoAWr4xIK8p7/r/QSgsa/UlK
         x+X0vb6wjhl5DQPSGnuTXbnMt8QQrTDvDRPGCiZr1QhAUZdwK67p6ILt/08l4XHmWIwy
         nq1DL4C3Tn7AIevyMll1XsvZLbe3EVetsdPeKPcmwEA2MIDwyDTjnFcdqnO5ltwqUDTh
         YpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093038; x=1755697838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX7HsBZ1OSxtuZpt+0fUOkrMNSmDcBAX1JrxfwqVFSE=;
        b=hmh6Ae0T9EYl80ku8PLtPMD6eeu8juEpImi3BUcS5MVBaajMtMYA4QeMD26t7k3z6s
         8OjihemhJD8mMJebj6SQMa1ccJW5L6JtWEBk0NUtF215n6ofrAmfQklpwwZMu9ObVLgl
         /B+MKOelj97ClmzY808AACfmx3Jgk2ohbr8gnCeUnAr5wdUWFbznQY/MF7LyzCGIEiva
         a1gdh51cEd9y5AcfeCIL5jng1ALncFBCCcFj/ypiYObPX1Eqm9J87+g3xCY5f0mBP4Xc
         PCBosf1JTwKScm/NdtLmwbn6o9azhKupU6Uimce5OArd7ojPeYlvo2ZOCdeMa5754g95
         DYAA==
X-Forwarded-Encrypted: i=1; AJvYcCWLfcvDDoPh5rUbAnGZziJp8zJmCQXUD196VLkQ/QqO7ITFJ4Er/RYAFyiaOV2siZIXqND/Z9UGiyHQJas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACLMlmrJ1K1VLjuuIm1GZHmmCoLg3W8bZYiiWF1ne/RRIqU5I
	4Kix/n+X1mBV5vs6qZtE3z41osnDsKuBcmPQmrRu92cHoiaNOQCd2YEgqjN49gzBVRDJIWdg4Y3
	b/R98Pe/z2Lj86AP8jDgAVbW0dzZj9gUyrwHl7VnA
X-Gm-Gg: ASbGnct69pfOn7AZr5aX1cHpcyCcdxjmTlzp66d6FMqGihgRVXMik4llULoXX2OU62P
	doBJZvBK35UW4G15zIgv4GNw8BdS3xi1TiYakb/f0dfLhL+RU/4vCZ3nMRW6IMkJA7qnKdVUZq4
	hRltpUallrfq5AF96jdh2w6pqasE0AmiXPQSpR6MXbzs2ncEewTghV4r1zC41gbZDwh3sLkcMx/
	JxyLo0cRoP2LzefXb9Ek7bfxs6B1n5Nw6nQEsDnHml6zF4Y
X-Google-Smtp-Source: AGHT+IHh+vA/07eWR9Ebta9w7V6pVGfOotLmHgLP9XCK0PEzsGlKp04MKCCBaqBhhNesoViqmXpEfMe6W8DHSs+xG04=
X-Received: by 2002:a05:6000:2005:b0:3b8:f358:28b0 with SMTP id
 ffacd0b85a97d-3b917e4ee33mr2691536f8f.25.1755093037572; Wed, 13 Aug 2025
 06:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-12-ed801dd3ba5c@kernel.org> <I-QXOGdDtTAVOcFvHZksoPqkYUZThmxrTUNw1h_MEGXdk_X_dc2txQdKJPMLz-yPmqL956iydAqVD9D5aL2SDQ==@protonmail.internalid>
 <aJw_I-YQUfupWCXL@google.com> <87a543fkh1.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87a543fkh1.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 15:50:25 +0200
X-Gm-Features: Ac12FXyzo-eVyDXufLE9G-NGeZ0mHM_6CqrztsTkjyFXCp398EsRl9GEXjBkjqs
Message-ID: <CAH5fLgjezWnFLaEKZkfvb9ko0RHG-c5g6yO0KvOJ8nyennEXOQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] rust: block: add `GenDisk` private data support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 3:47=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Tue, Aug 12, 2025 at 10:44:30AM +0200, Andreas Hindborg wrote:
> >> Allow users of the rust block device driver API to install private dat=
a in
> >> the `GenDisk` structure.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > Overall LGTM.
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> >>          self,
> >>          name: fmt::Arguments<'_>,
> >>          tagset: Arc<TagSet<T>>,
> >> +        queue_data: T::QueueData,
> >>      ) -> Result<GenDisk<T>> {
> >> +        let data =3D queue_data.into_foreign();
> >> +        let recover_data =3D ScopeGuard::new(|| {
> >> +            drop(
> >> +                // SAFETY: T::QueueData was created by the call to `i=
nto_foreign()` above
> >> +                unsafe { T::QueueData::from_foreign(data) },
> >> +            );
> >
> > This is usually formatted as:
> >
> > // SAFETY: T::QueueData was created by the call to `into_foreign()` abo=
ve
> > drop(unsafe { T::QueueData::from_foreign(data) });
>
> I don't really have a preference, my optimization function was to
> minimize distance to the unsafe block. Are there any rust guidelines on t=
his?

I would say that the unsafe keyword just has to be on the next line
from the safety comment. Optimizing further than that leads to wonky
formatting. A similar example that I also think is going too far:

let var =3D
    // SAFETY: bla bla
    unsafe { value };

Alice

