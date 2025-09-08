Return-Path: <linux-kernel+bounces-805939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC0B48FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED89A3A1D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325530B530;
	Mon,  8 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JB1ytb3a"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0930ACF0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338498; cv=none; b=mpiD52Hd3dZTc+jq8Pb/rtRXQv+RWYGYTxOCQ3XodrAs9tSPJBhRSFa2KGwld52uYt1L+UvId3CS/zYFKLNMHwZLZm+ioS5lg7Mi5EPtv2xi2EsSIwKqK/YmerajDm7BbSYWUBivEIi/1GVlIAbiMfHBlHpfehE/RhbTy1bK640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338498; c=relaxed/simple;
	bh=LNcX05/LCXsPUHERl2+7b0SIa/daVDyP7L6I5U0eI2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kovgcBhC6M4P/iwfaqDYMVlIwAMOmuS0Tpg3VlrtM2tCoOl2gYM+kscBDae7VuzCRYCYMj6kLC95mE2nS2Isob4U8kYtv73yUW1y4A8xP5JBR8wg+2NTbpvnKiGoUfTKktFklkqOCmDDeHEZb6SOC/mBJqWt27R64Po+pZJ4QoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JB1ytb3a; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de221da9cso7724735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757338495; x=1757943295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/tKrYwMMkLTbqkkthV8AG/fr+t6l+qGhUImzEGNYdE=;
        b=JB1ytb3arQal83dvvuMBQ3SsGCrGJ9p4QLCVCD/8jzuUAOBsCYaYsnkF1Ow2Fzm04e
         oeRPt1hEDD/sAqvDP9Z5WdvFXE+/jdB9JhTJ9jiYKUOoSS506cArYFGMrXMC7VUT8kih
         cXaeS9VSWHEN1DoUwumwUOdk34Lo5HxksyvK8nlCw4nW8NXFc0OYi48ijIKUS2w4c4qp
         sDfOh7/mTAdVqDyXMsvSVXtMYjj8g8uRQlz28nAk7AopVgbxs3+S6dezdXW5jsGMiWEv
         591c+Dlp9HaoqC9pdduESO2gXZgrxeBGGEgQdF66GDc74v94+OraBDidq82lcjkrPzEY
         /+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338495; x=1757943295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/tKrYwMMkLTbqkkthV8AG/fr+t6l+qGhUImzEGNYdE=;
        b=CJHzgXtNkrK5zU0IcNj8N78Vpz8jgfbKk052C6k3O2aTA8JzW44s9mMp+2bR6JkiE8
         7xI1xY6h11+x7W1RjDURegcB2QlOn8yQijwBsYOOmC5/5+o/eRKsQeFm1GJg9KA4R1Pw
         J8hDG3DIFZq6OTVvb1sSDoWHN0InBQS3UmVmmCuuS8M7reQKtv6lu6Ei9voizWFImefC
         cnch/HZ0d4mcS+0tEkWarCMvnJ9D/6GsIW2HGiSaZG03T4P18RyY/BIPa9riwWDw2JuG
         oDfNJTUWSLCBHUSarxHZ0EH9kk3NRnBV4FBw22I9FHID81gaAh2oIkkdH83wncBgwnYQ
         i9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVGR+id3ldceWSlZv70f0ft76NckAjVyu4lqQsicpR3iHAMPiFBre2Oa457Czonyk+9dGV2xiyM7hPqbKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLyVZz68FqqH7AC00elqx+BYbygl8MrvSxAlMWGUgEVP2ObT7
	XPKM4KrfsFY7olKJwC4AIPB6OBqxSNHaizTJ3h8nIezyT1Xdnlpaxd8KLEPUe2B5J2NySopGEay
	esSDwd2tX31Fnc6dDrQy2uc3sGnlZvUxFppv+5FOt
X-Gm-Gg: ASbGnctsf85tm+2jyZySREnoTzs4//YeqFhUFLGxeBhE9u2qGXfXcrHwzmsYfeMmM33
	dfFtpLoPzWwRuR2hQ7l+YnAVx2fcn196qxUhsikly+nGXtqphi7BPQ3viQYoYbJbQyVaT0FAphQ
	8zQNhbMXQAuJy/H6m/9rm9D0R45smPlNlcC6HtKzixtmtOON1k8qbVFJhG1c/t3YdE70FdyzVZe
	qtk/xSlsWBhQqDiO4zh87OcPUasvSiTBPrfw5IYb+NB+uwY/Am9Z1wTIfQsM5EknQwaV8rDj1nb
	o/qlz03FSBU=
X-Google-Smtp-Source: AGHT+IH4AhoIeHcXN/Wiht429W5rIuhwkFXhsm5HZS8OIgOA1tUZLzgYvnfHcj7Aw/Vm3U7aoBcjWOOLcRy+pzEqIDg=
X-Received: by 2002:a05:600c:4587:b0:45d:d94b:a8fc with SMTP id
 5b1f17b1804b1-45ddde8c757mr85977165e9.16.1757338495051; Mon, 08 Sep 2025
 06:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com> <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org> <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org> <2025090817-attendant-ungodly-78f6@gregkh>
In-Reply-To: <2025090817-attendant-ungodly-78f6@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Sep 2025 15:34:42 +0200
X-Gm-Features: AS18NWB2zW9ifDWrTNJgpft2LnY-eb3jo16xCwu4pQuWQeM6FgNN03Mu6Cw2yAU
Message-ID: <CAH5fLggZ_ELrcLekF5GD5JQAkSz_Ycg7T+fZc7crjFA5jk1y3Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 08, 2025 at 03:22:41PM +0200, Danilo Krummrich wrote:
> > On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
> > >> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugf=
s.rs
> > >> index b26eea3ee723..475502f30b1a 100644
> > >> --- a/samples/rust/rust_debugfs.rs
> > >> +++ b/samples/rust/rust_debugfs.rs
> > >> @@ -59,6 +59,8 @@ struct RustDebugFs {
> > >>      #[pin]
> > >>      _compatible: File<CString>,
> > >>      #[pin]
> > >> +    _test: File<&'static CStr>,
> > >> +    #[pin]
> > >>      counter: File<AtomicUsize>,
> > >>      #[pin]
> > >>      inner: File<Mutex<Inner>>,
> > >> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl Pi=
nInit<Self, Error> + '_ {
> > >>                          .property_read::<CString>(c_str!("compatibl=
e"))
> > >>                          .required_by(dev)?,
> > >>                  ),
> > >> +                _test <- debugfs.read_only_file(c_str!("test"), c_s=
tr!("some_value")),
> > >
> > > Cool, but again, we do not want to ever be storing individual debugfs
> > > files.  Well, we can, but for 90% of the cases, we do not, we only wa=
nt
> > > to remove the whole directory when that goes out of scope, which will
> > > clean up the files then.
> >
> > This API does not work in the way that you have a struct storing the da=
ta you
> > want to expose *and* another one for the files with the data attached.
> >
> > The File type contains the actual data. For instance, if you have a str=
uct Foo,
> > where you want to expose the members through debugfs you would *not* do=
:
> >
> >       struct Foo {
> >          a: u32,
> >          b: u32,
> >       }
> >
> >       struct FooFiles {
> >          a: File<&u32>,
> >          b: File<&u32>
> >       }
> >
> > and then create an instance of Foo *and* another instance of FooFiles t=
o export
> > them via debugfs.
>
> Ah, that's exactly what I was trying to do.
>
> > Instead you would change your struct Foo to just be:
> >
> >       struct Foo {
> >          a: File<u32>,
> >          b: File<u32>,
> >       }
> >
> > If you now create an instance of Foo (let's call it `foo`), then foo.a =
or foo.b
> > dereferences to the inner type, i.e. the u32. Or in other words `foo` s=
till
> > behaves as if `a` and `b` would be u32 values. For instance:
> >
> >    if foo.a =3D=3D 42 {
> >       pr_info!("Foo::b =3D {}\n", foo.b);
> >    }
>
> Oh that's not going to work well at all :(
>
> Think about something "simple" like a pci config descriptor.  You have a
> structure, with fields, already sitting there.  You want to expose those
> fields in debugfs.  So you want to only create debugfs files in one
> location in a driver, you don't want ALL users of those fields to have
> to go through a File<T> api, right?  That would be crazy, all drivers
> would end up always having File<T> everywhere.
>
> > The fact that the backing files of `a` and `b` are removed from debugfs=
 when Foo
> > is dropped is necessary since otherwise we create a UAF.
>
> That's fine, but:
>
> > Think of File<T> as a containers like you think of KBox<T>.
>
> Ok, but again, you are now forcing all users to think of debugfs as the
> main "interface" to those variables, which is not true (nor should it
> be.)

All of these things is why I recommended to Matthew that he should add
back the scoped API, since it doesn't have all these drawbacks.

Alice

