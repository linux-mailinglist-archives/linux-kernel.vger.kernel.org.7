Return-Path: <linux-kernel+bounces-776713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103FB2D0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EB1684E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9B189902;
	Wed, 20 Aug 2025 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udAcKlV+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F268353377
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650473; cv=none; b=nEeuuNN8u5wImdmTAfzYIV4Iv1pbAzv611edOT5yLjVCWplDOS9wS7JFipM6eAwKfJY2s/lxaFZwX0F4deZcLvkK/y+BWCYSAbaP+/GG4UI1NnBcyfLzO71yu69VpqWfsPa5HfV9EJ2KS3VXgmBYeaHlcLwEzf5IuAZxI7Z63H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650473; c=relaxed/simple;
	bh=8UIjtrsY+An8yPv79UD6v3zTCgrBcxRINzOnoGLp1+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d16luK7pn5n+F3cQcG6YSTRKLghNIZ16Vg33RkEgjh/CDe5eY62srcwKVqABl/z8KI2D6vl/jJXhj5FVg6+8A0HsGrhAO18eBBgyeq1xsxAb/eBX89Id/hN3+22W4xIQ9N6cpkpVpS8sY1Bxop0ZxGeJ67fNVeDgxHrtU7ZdITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udAcKlV+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so2349a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755650470; x=1756255270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IqLuyaFxXi+2wRaiu2PfqA4zWY/UYXAdYs60oenvXQ=;
        b=udAcKlV+eRuYPPFOHVwkwF7ZO009hbJ4Roqg1IBiPnLChHaKKqtSbcjVVKJiN16Ten
         05P9iqoYXmSuw78XC27YpV+DWFa6Have0H/DpnJoSujngUVVHHyIjoS85Ap0gKuTGJr1
         LuNkYqcmLK9EvnZZk7Fb2SRpKnlIbxdFuJmbb/J7H5bUYvWX74ktbpaQ3lCLoeiz885L
         p8N9OiEVGCDaI8k2XYpSLz0hgu0udgg1BXVp1775ky8JC2gpyzsar5gC8O37Hzj2Nzok
         FD+HWBtTYNorI+xfKWTvq+D6KJHQMghWAaH+9pRCxLpj6yR6+t41M5TBr5hZ6BrCMVv4
         1vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755650470; x=1756255270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IqLuyaFxXi+2wRaiu2PfqA4zWY/UYXAdYs60oenvXQ=;
        b=wZFPxTqGseuTRoOrMy/qb5godBVGBji6BR9y74XKOZaFUlU3DzDUDYYk1Dq5VIaasH
         6Whq8nLzLlDY1UGyJPxm/znqYUfGVVFPqrZYqVv7F9ioZV8no/vcSxnauhCh+fBsCMrZ
         xhC85faDfhQskv06neLWfoplsKSGHvrwcO0ECoMuM7QermeiUlVRXKKJHjOebgMBQtwW
         mvWWvbnIrzNkyTi8hORE4kXRDeT1z4ewiL6LlwPp8aqb02mpL+8zS1SfonCAHNultlTf
         3fBQQ26RX143UxpgXikdkF56MCCQVK4cB3MaYohwqMp1CiMUvXBedv3O8Dn/xCodD3AW
         PrPg==
X-Forwarded-Encrypted: i=1; AJvYcCWqr9ejLvGgKwqaRaL0IDbyP1ELminC27W3iYznEq9xPASziOBs5qLgNuAB1VulYbG/pV8p2xF79uBcclI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqb99i403iMpueiNYKghfobbMakRc1/G8CVOjAW5rsgI9O+ZrF
	3EDs+bRM6Bo+G1DfncAchzyfsC/1eNSQ3y5ptwqmLEeHyXUdaSwRHGlK7hgWaUjXrK6hgK1nWvY
	z4KCprIx0hmX3hfI3NxbXuyzhCJ3Xu/JrxRGm3Z3O
X-Gm-Gg: ASbGncuAIOjUr3NtrdFLLDIeh419CQ4Oc5otpMThssJjaTQQs08jPzqN+9pIVAGrPO+
	VXnPtEkKm6iuF1pOlcnBEV6GBtR0U35My+l+ryWfBc0Khht6VOJLgd7tvbTWDUpQFWs+EyIgRmY
	LJq5etVurONWUr6MdjcvgBHpMXXpqvoxwz1BzQz3AUHFUzVzy/mimWudAY+QoWG6743310x3JFu
	fk0ZY3lLYBfmIKCsMBO54btnLq3qV7cJORk3M1eOe96GXmJS86xUNTSyw==
X-Google-Smtp-Source: AGHT+IGeDw8BD2i3CVxmFhBT3dNw+UjlmwBqZXmTObhC4KJScHjZ6oX3e0H86dfL6pkupQ3dIUBlVzUM7JewSU6nLnA=
X-Received: by 2002:a05:6402:21da:b0:61a:590c:481c with SMTP id
 4fb4d7f45d1cf-61a98aacf9fmr58868a12.6.1755650470324; Tue, 19 Aug 2025
 17:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-5-86e20f3cf3bb@google.com> <DC6U02DZSX1W.1SXD7XQTNHXQL@kernel.org>
In-Reply-To: <DC6U02DZSX1W.1SXD7XQTNHXQL@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 19 Aug 2025 17:40:57 -0700
X-Gm-Features: Ac12FXzGHB9IaGuvsxmIZN7J-bxVIRvmhlD1GhpuPHArH-kEahMOeHvtf74s9Q8
Message-ID: <CAGSQo02f6FOZ6fujzUhJEbysDpuASJf+4NBfqj0NGHKy7GQ7Yw@mail.gmail.com>
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

On Tue, Aug 19, 2025 at 5:34=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
> > Adds a new sample driver that demonstrates the debugfs APIs.
> >
> > The driver creates a directory in debugfs and populates it with a few
> > files:
> > - A read-only file that displays a fwnode property.
> > - A read-write file that exposes an atomic counter.
> > - A read-write file that exposes a custom struct.
> >
> > This sample serves as a basic example of how to use the `debugfs::Dir`
> > and `debugfs::File` APIs to create and manage debugfs entries.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
>
> This is a great example, thanks! I really like how the API turned out.
>
> When it comes to the newly added Scope API - and I assume this does not c=
ome at
> a surprise - I have some concerns.

Yes, I expected this to be the case, but inspired by some of the
comments about wanting to just create files off fields and forget
about them, I wanted to take one more crack at it.

>
> But first, thanks a lot for posting the socinfo driver in both variants, =
with
> and without the Scope API.
>
> I had a brief look at both of those and I can see why you want this.
>
> With the Scope thing you can indeed write things a bit more compressed (I=
 think
> in the patches the differences looks quite a bit bigger than it actually =
is,
> because the scope-based one uses quite some code from the file-based one)=
.
>
> I think the downsides are mainly:
>
>   - The degree of complexity added for a rather specific use-case, that i=
s also
>     perfectly representable with the file-based API.
I don't *think* this is just for this use case - if I just wanted to
improve the DebugFS use case, I'd mostly be looking at additional code
for `pin-init` (adding an `Option` placement + a few ergonomic
improvements to `pin_init` would slim off a large chunk of the code).
The idea here was that a file might not always directly correspond to
a field in a data structure, and the `File` API forces it to be one.
We could decide that forcing every file to be a data structure field
is a good idea, but I'm not certain it is.
>
>   - It makes it convinient to expose multiple fields grouped under the sa=
me lock
>     as separate files, which design wise we shouln't encourage for the re=
asons
>     we discussed in v8.
It's still pretty convenient to do this with `File`. I don't know how
common it'll be in kernel code, but in userspace Rust, `Arc<Mutex<T>>`
is a very common primitive. I would be unsurprised to see someone use
this pattern to expose separate fields as separate files if we go with
the `File` API.
>
> I think for the sake of getting this series merged, which I would really =
love to
> see, I think we should focus on the file-based API first. Once we got thi=
s
> landed I think we can still revisit the Scope idea and have some more dis=
cussion
> about it.

This is why I put the scope API and sample as patches on the end chain
of the series - it is possible to merge only the `File`-based API if
that's what we want to do first, and consider the rest later.

>
> I will have a more detailed look tomorrow (at least for the patches 1-5).
>
> Thanks again for working on this!
>
> - Danilo

