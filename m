Return-Path: <linux-kernel+bounces-776714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4F7B2D0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC7B58509F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0718991E;
	Wed, 20 Aug 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pr3y3ZWH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E9256D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650574; cv=none; b=huQgs/O6/mT6MsG9vt0uHq9ZMx4MIMwZlLMy2fmx+WDevd6XE4ItRR/xZmABie2akr2phr6Hcd1VgDmwCRzEAwg0KLN6lPsaqVai0UoRL8fwcAaOZAbNyjf9TZ2xfPM4P5GsfjjU5OmxBZJI2kj7pJDajTyoC1qjmV4PPex6nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650574; c=relaxed/simple;
	bh=Cob62gZxusezzELlnbEq1p53FOmb982R7fyEQt/FObc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnU7+FFPf3pgKbieGXdGqDttGtCSTZ3XfReXMv6Gd15uMkqxWGZ6tNRZxDI5T7l7RzST38TP+RQjkBehzWeXYUvPHqxY2QwZF1CxofK/439XMRY8K18OBKdzefHc34ntfinHY0kUHENBa1QCn1mZ2pP8III0NeJjvDcqT9YYtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr3y3ZWH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61a207a248cso7349a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755650571; x=1756255371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRY2HHTE2P+K8s/S+rilfuFwP5JHuBgmUKUOpxbgTw8=;
        b=Pr3y3ZWHyleMFafg8LPJ3V1ffDsmzx+fZ7UtPv8mXRydU3iOpiBIehQzSzDzZvsC4M
         xHQEhmCSvdV2AK4uIlOtOukC+hW4kTPRYVtZ3YvfDRH9zLZnfeF6Q+lTFT3bJ2IfFjUv
         /wAV6H2iofmofeZeRq+YWVjxMQ8cvuTAbEf98m/ulJ6Z1efA+mtkoosNkQIKFoowNiCv
         9ERejeI+lMey57gptB+QBUBgwXrIHNEcBdYxV1P3DilT9NBhXy+RhiHRysEvmB7PcnAa
         fD7EoGpXPyMPkWbgat0gLeq2XYOeP6msczMjwZoGrGEM1N7un52Zdq2zxo8PCr9Z6pMI
         M76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755650571; x=1756255371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRY2HHTE2P+K8s/S+rilfuFwP5JHuBgmUKUOpxbgTw8=;
        b=JtE+0H+A1T7m6GefI5BAsS59+kZVG1mibQdKuxNY8lVOdjw1jJDXyL3Q3EdoSDbH24
         kM7GcpRP/qIqOW8v2cZOdyXVVNnN6kg0XBjEFM8i3tbGhG4ssoYPeqUqMID9BV/VcJ+w
         tLDo2euU+O7sScET8m4BKN34/9uFAURK/X9aCtemchUDcttUaMwgr6Pi//bj96bw050n
         jiIxjO6qSGfZ480nNJtf/CsWS/0I0oOuGWhD9qo7VroojpstpzZcaiDqjtaL8eLrmnX0
         /CszdIiducTZQFB0c+avFeA7i2BZw3LeE0Q+VuTVz4uhnUbIai38RVDDyCuHSGkp4QKS
         03WA==
X-Forwarded-Encrypted: i=1; AJvYcCViu0w3XcijJn4D1uVOcBtXo7iMmbZ9c7TyCM3pLt5CbscJgn/Vltt7J9VT0Kq4RlvhTHo2wSeU+zy4qMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFf+tCToxwrSAzxRmC02jb4NzFdt9rHNq78WuvoI1DVbu3upJ
	uFuDoJ4p52rVQcPPxt/HluUxsTS65UXaZe1IPxpucdEb1gvH9debWo6wKZY4Pxj9j/GgxM7YWCR
	pH9eTeurqndJfm7OPxUTQ1YhH6XglVrD23gF6EJ1F
X-Gm-Gg: ASbGnctmGIVpb0yq21ijPFKhZKcSKSR7m/AHGy/E+XeiQeQB1jRezdqcmTgq7mNwlYb
	9wtkBHOelBwi+Hyi2AMniaxtbeFT9Ckg2XmmmYW7O3e482+/EAi7J8izfkZG12D0LBabHT078r9
	AX97swgUq2XqMQbUUn8K+6NKjX0E1pvrq8/Vckcn8qtlip3M22ABn5KDJ47J6nJeKRj51sW8fAa
	yqQr5yk6QcrdtCklm57xl6w6zLyuxjrTMmHkzE6WPgT//w=
X-Google-Smtp-Source: AGHT+IGuz8vfN8gEV0TKku2fAZ8eu2a5NT+0eZgcslCi1URyxVb8cDu2+2BIr1gze0SjMpjpLVjWMIgz712UaGsS8aY=
X-Received: by 2002:a05:6402:a18b:b0:618:526e:c94e with SMTP id
 4fb4d7f45d1cf-61a9b4bdb38mr16848a12.7.1755650570567; Tue, 19 Aug 2025
 17:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-5-86e20f3cf3bb@google.com> <DC6U02DZSX1W.1SXD7XQTNHXQL@kernel.org>
 <CAGSQo02f6FOZ6fujzUhJEbysDpuASJf+4NBfqj0NGHKy7GQ7Yw@mail.gmail.com>
In-Reply-To: <CAGSQo02f6FOZ6fujzUhJEbysDpuASJf+4NBfqj0NGHKy7GQ7Yw@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 19 Aug 2025 17:42:36 -0700
X-Gm-Features: Ac12FXzAfLXmm8Kg-LTW0BIxsriMcYffv1nZCRxJddb6RaAyZiCI7mxexudtt6c
Message-ID: <CAGSQo00m_VBpJ+Vez8e_dBNkxGaTjtA+eDcpcd9zzjLsLyFe1w@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] samples: rust: Add debugfs sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:40=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> On Tue, Aug 19, 2025 at 5:34=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
> >
> > On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
> > > Adds a new sample driver that demonstrates the debugfs APIs.
> > >
> > > The driver creates a directory in debugfs and populates it with a few
> > > files:
> > > - A read-only file that displays a fwnode property.
> > > - A read-write file that exposes an atomic counter.
> > > - A read-write file that exposes a custom struct.
> > >
> > > This sample serves as a basic example of how to use the `debugfs::Dir=
`
> > > and `debugfs::File` APIs to create and manage debugfs entries.
> > >
> > > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> >
> > This is a great example, thanks! I really like how the API turned out.
> >
> > When it comes to the newly added Scope API - and I assume this does not=
 come at
> > a surprise - I have some concerns.
>
> Yes, I expected this to be the case, but inspired by some of the
> comments about wanting to just create files off fields and forget
> about them, I wanted to take one more crack at it.
>
> >
> > But first, thanks a lot for posting the socinfo driver in both variants=
, with
> > and without the Scope API.
> >
> > I had a brief look at both of those and I can see why you want this.
> >
> > With the Scope thing you can indeed write things a bit more compressed =
(I think
> > in the patches the differences looks quite a bit bigger than it actuall=
y is,
> > because the scope-based one uses quite some code from the file-based on=
e).
> >
> > I think the downsides are mainly:
> >
> >   - The degree of complexity added for a rather specific use-case, that=
 is also
> >     perfectly representable with the file-based API.
> I don't *think* this is just for this use case - if I just wanted to
> improve the DebugFS use case, I'd mostly be looking at additional code
Edit: Socinfo use case
> for `pin-init` (adding an `Option` placement + a few ergonomic
> improvements to `pin_init` would slim off a large chunk of the code).
> The idea here was that a file might not always directly correspond to
> a field in a data structure, and the `File` API forces it to be one.
> We could decide that forcing every file to be a data structure field
> is a good idea, but I'm not certain it is.
> >
> >   - It makes it convinient to expose multiple fields grouped under the =
same lock
> >     as separate files, which design wise we shouln't encourage for the =
reasons
> >     we discussed in v8.
> It's still pretty convenient to do this with `File`. I don't know how
> common it'll be in kernel code, but in userspace Rust, `Arc<Mutex<T>>`
> is a very common primitive. I would be unsurprised to see someone use
> this pattern to expose separate fields as separate files if we go with
> the `File` API.
> >
> > I think for the sake of getting this series merged, which I would reall=
y love to
> > see, I think we should focus on the file-based API first. Once we got t=
his
> > landed I think we can still revisit the Scope idea and have some more d=
iscussion
> > about it.
>
> This is why I put the scope API and sample as patches on the end chain
> of the series - it is possible to merge only the `File`-based API if
> that's what we want to do first, and consider the rest later.
>
> >
> > I will have a more detailed look tomorrow (at least for the patches 1-5=
).
> >
> > Thanks again for working on this!
> >
> > - Danilo

