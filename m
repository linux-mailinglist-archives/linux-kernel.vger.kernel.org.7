Return-Path: <linux-kernel+bounces-868609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3908C059C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1B024FB417
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41330F80C;
	Fri, 24 Oct 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSz7tjwg"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100230F95F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302220; cv=none; b=ffkzX7jGexx/8QemOcPzCzN5JCZw6Mcva5yDs7YBllb+Ni1o6rdpPYdUJq19hKhCmb8YErmpaKvwlpScZ2Uo4DzblvU5Uwkg7KqYpRWFiPaZfwvKwz2TCoo6/PcjWyHMj/KIf+XV6crRaeGh8xsRRWnWa62BxQX7GZebV6KvIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302220; c=relaxed/simple;
	bh=s2FO8pnEV/7szb+dOJiq08LSuK/rb7I+nZ2d4KW8ctI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dGfvdOcFAEGbgUf7sfUU979vg6Tam7sqfZy4G+bSqHORMxjVjW6lb/W0yRBvNRvLC6pOeUHpVyetUbiZ1uj0WQelhskE085UkAh+iDLOyCbH8y/aAdg2tHIWJwYn0kYgzjQBMCHfAIKlOLLPJC5Y9jUzesRZMuBzW5TbXMkVW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSz7tjwg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso12682145e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761302216; x=1761907016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5WckZjr4qpmTV+gX2VgoGwpr/mWfENYA9Da0Yb01PI=;
        b=MSz7tjwgyvFZkXvDVUUXgaxwns48UJXrL6dnuTQzZ43x3DlchEM61p71kMIuz64ph9
         suiSlWxDC2AcqvZESe7730GIUlX1KntWwl+gUZ+7e4CY+rcdMDN2iDQQ5yNUngCDTQjf
         FhlGmFNnfYQke2YQC/LcnvN9KAXP03bV7aiWOxaiLeVuTSYWvza+5Ec2Of1RFoJAYNWf
         cvZbUaszI4w394upLVxOhNSATrn9+PqqGfEIaPcg1f4CLxX+tRaUiFCLVSXHAw8qpGkm
         Nmg/DjVkc0N+3j9E17j1Z5bCoviefd4Cd/uNGcQWB61yVFMHTrrN7tNy1lHwaQPE5ppL
         A6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302216; x=1761907016;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5WckZjr4qpmTV+gX2VgoGwpr/mWfENYA9Da0Yb01PI=;
        b=PrrYZRp1VUjHvzElQEeV1pXta61rrOyEEISjzFnCtPxUnbxHDp9sza2Fqy3wMd1Wsc
         YmAES6Z6jY9xB0UiezabzMG78iozp+opXwhSo+ecJk4IOkSJ92KcMx8Uf+u+aZ/2yGks
         Q9hTFjb2E0kiXWprai/JbuhO7Be9eWujPyFPHfcd0r4DKFuYIysx9TcFonXX6+g/rTec
         vMOzs0zqxK+7XKDIFZ+gYQ0qH/uKoa6qmikSqILN/9Io+ZXRYc+pcIDcI21pSldBSQHo
         nfmLJufInwq+eH+MGAVopx0FdFWbKtrLlV0rPVquketwHfs7V7cTnnAx9eaFHLJgL2fh
         Oz8g==
X-Forwarded-Encrypted: i=1; AJvYcCX9OD3jxD3CV2nXmJw6tpKLB1cwXWcV9lhN+126qySuFN/BJJJhv4zNqcqq+1Q/UriQdYAe9HFjuGRKOR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUZQJCfziCK0sq4Y6fGatnctd91YCTgL9RKgumBMwIevsn9Rs
	irjmQQOC76uaoVyoQefKyDRE7IThtyM0NpZQXtNdp3Snutd//wYIlDh5NJIV8uPrxhZ8hJKo6gE
	dBvrA9F84aZNfDI6m1g==
X-Google-Smtp-Source: AGHT+IF6Mgy1YsJz+7QCsPHpP9ik7YMhi0K8WjvdltQv05VpchJvsZPKXTgJ4bEGg+tkcUMZROs5PhBuuxH4BSw=
X-Received: from wmsm9.prod.google.com ([2002:a05:600c:3b09:b0:46e:684e:1977])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-471178a6e99mr195067895e9.17.1761302216346;
 Fri, 24 Oct 2025 03:36:56 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:36:55 +0000
In-Reply-To: <CAH5fLghiEqqccH-0S9-GD7pJaNuVpuo_NecMMmGVF+zR7Xs_dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-7-dakr@kernel.org>
 <aPnmriUUdbsQAu3e@google.com> <DDPMBR9EUYJ6.23AYG1B27BUEN@kernel.org> <CAH5fLghiEqqccH-0S9-GD7pJaNuVpuo_NecMMmGVF+zR7Xs_dA@mail.gmail.com>
Message-ID: <aPtWx4i3WuIlcWEM@google.com>
Subject: Re: [PATCH v3 06/10] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:21:24PM +0200, Alice Ryhl wrote:
> On Thu, Oct 23, 2025 at 12:09=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >
> > On Thu Oct 23, 2025 at 10:26 AM CEST, Alice Ryhl wrote:
> > > On Wed, Oct 22, 2025 at 04:30:40PM +0200, Danilo Krummrich wrote:
> > >> Introduce support for read-only, write-only, and read-write binary f=
iles
> > >> in Rust debugfs. This adds:
> > >>
> > >> - BinaryWriter and BinaryReader traits for writing to and reading fr=
om
> > >>   user slices in binary form.
> > >> - New Dir methods: read_binary_file(), write_binary_file(),
> > >>   `read_write_binary_file`.
> > >> - Corresponding FileOps implementations: BinaryReadFile,
> > >>   BinaryWriteFile, BinaryReadWriteFile.
> > >>
> > >> This allows kernel modules to expose arbitrary binary data through
> > >> debugfs, with proper support for offsets and partial reads/writes.
> > >>
> > >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> > >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > >
> > >> +extern "C" fn blob_read<T: BinaryWriter>(
> > >> +    file: *mut bindings::file,
> > >> +    buf: *mut c_char,
> > >> +    count: usize,
> > >> +    ppos: *mut bindings::loff_t,
> > >> +) -> isize {
> > >> +    // SAFETY:
> > >> +    // - `file` is a valid pointer to a `struct file`.
> > >> +    // - The type invariant of `FileOps` guarantees that `private_d=
ata` points to a valid `T`.
> > >> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
> > >> +
> > >> +    // SAFETY:
> > >> +    // `ppos` is a valid `file::Offset` pointer.
> > >> +    // We have exclusive access to `ppos`.
> > >> +    let pos =3D unsafe { file::Offset::from_raw(ppos) };
> > >> +
> > >> +    let mut writer =3D UserSlice::new(UserPtr::from_ptr(buf.cast())=
, count).writer();
> > >> +
> > >> +    let ret =3D || -> Result<isize> {
> > >> +        let written =3D this.write_to_slice(&mut writer, pos)?;
> > >> +
> > >> +        Ok(written.try_into()?)
> > >
> > > Hmm ... a conversion? Sounds like write_to_slice() has the wrong retu=
rn
> > > type.
> >
> > write_to_slice() returns the number of bytes written as usize, which se=
ems
> > correct, no?
>=20
> Yes, you're right, I think usize is the right value. The cast is
> unfortunate, but it can't really be avoided. In practice it should
> never fail because slice lengths always fit in an isize, but isize
> isn't the right type.
>=20
> Alice

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

