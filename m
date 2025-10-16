Return-Path: <linux-kernel+bounces-856839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFABE5367
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C93C358125
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB332D9787;
	Thu, 16 Oct 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QydhAQqw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642542D949A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642348; cv=none; b=n+YzaalF+eLqJ5uJscqYFZPyRaVqwFj5/47Q2rDti9+jWYQasDbwuaeNSVFP+lDZk2MS+FSQkK+UzCJ34etlssgx+oSyoDVrpQoyb89jND9gapymcUmneL98W1dvS9cF6W5aL0A/zS12oUJuSh3xDBT1WqbcR5zpzj1U9QRCh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642348; c=relaxed/simple;
	bh=a3Gj7mh3v/3Kk82UEe0rHgCedYTsE9uhWk8L2/gsUsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQL4LtIix/5FDx7VeYhca6vsjZm5WU1uTjldvQrwdd9KqHh6qQ+MpkxCLZPWHvp7lmJgzJ/hQopjW8ZLqkIOkmS8A4agMms+SLucJMvm0UWZLY1FG0z9p4vkFXW7kyO4o/CZsaI2B8iaUEAWjo/Efn4vOy4R9zaeqTFg3Gbc7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QydhAQqw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29094f23eedso1628605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760642346; x=1761247146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkNb2DeKO+13qtb+PBXoKP6RFeVYVbqfpbvDK5KSaF0=;
        b=QydhAQqwREUOnfLFgCf98Hk0Yq+GnD43PvXt4cFJoMlID+DgSA2j5uT0edUJPvVkJQ
         5M4FbS/75Qv7AeKj+94BFBAJPa63XEnpN2tEXWOsn07xtVHGlxtaNsYd4wEQFfZstON4
         97jQpkB3YQqFB6EQhhmw5LnywFdDQFSaWXW2xwdu/+SxGVr+RZi8n7VPMmjnjwpO+/Mu
         5TuX8OtObALzOomWoirLtUL5A+9L0tGXZesw/mBbV80sVDk+QnLJSYwpTJVfPqZXC74L
         u5NmaryNSfryQfFFq/VEJTOs5ycM28JMQT1yK2p8PJWDBfHOA3lDXSOK0e65sg0+PL/P
         h6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642346; x=1761247146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkNb2DeKO+13qtb+PBXoKP6RFeVYVbqfpbvDK5KSaF0=;
        b=Eypmx4OSRtf75ZGth3DcDXo31bFxHahEPY4CTCyOcMbHqVNr9D4ZvZEAOIuElwKa2R
         pcLndbnyQVQ3BniMO0/CMUOjiKxna5v9BXdr5OOsoF8MPnvruYWkUqFOfotJRKr+L+rc
         k0lFfe6HlxfWTiOvWrzl92kOsDTojM7GiJSBOj1QLTU2bsOSlfuuUVphjLdmA38g0KlB
         rfJzwz2pW3ZA79jatLb484lZph9AFfr+eXUjX4kBFBMSzEedc3fxq2Y+YerPFD+r6UTR
         mLMJPpVTaetvVfu7tv4NBcemExfz+guehR/AJfP14jxsGOheMteSm8iNyFkXpj/rs2EF
         J5vg==
X-Forwarded-Encrypted: i=1; AJvYcCU+7NyTALfRLGYkkG4ZyJldIkcl/UX8zqA6HC5ziz9Yr7GJ+A1iuat7DJp2aSYAp1QZq8KDJzAj8IxhrDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRP78Xl1CAqJ7Rbrc/LvlMbEmXKUS01ZoCndbUsDCSl/cQPcA
	/uwe7qzx+BpdnHo/kVY0/p5b5X7NwtyIb28Ole3w3Xoen/2Npj7iW4wkwH7f1JsfFq1lN8e+OYG
	xTApp9BtvClMGMzB9OJtmoRVBYrZ24dg=
X-Gm-Gg: ASbGncv+D2KtSuTeiNckufMkRTKN7PYHOcUTTuMGojIVs8VrnBhlEmmMQreEe0lP0C+
	IQsG/YEqsd1s52rcAZhM3PGlGUIuc6EonFfD16gvyhsXfMmndHM2VN7nF0TkRDDeJ5HmJneMp78
	9r6ozwXCXku6SNefddCTYonP+VLm1We6ZepPQuFYAGDYn0oTFccvCX9/rrDTtyKcMq6qVwXU+ge
	R6twRbWTREczjYrSVrUkS0gLzxwEA7ra5LNGpRvXxFjY1alekm6Al00VHvzc869a/cyfDom7BY4
	n7wv+zqhK4OzfcHdYP6kf0BIx3OPtaBsHxQwTTpAbWDExMPYHmSXHmiCm4bbS4rz4lR8P3IkRtg
	+nUo=
X-Google-Smtp-Source: AGHT+IH0YWgGKSo65cgBPX5W3p7j4HkK3bVU7l78fZ+js9jI7tU4OLEp6GPUbGx58mDOvsKGfrW9fh+1rWFnGpM/2VM=
X-Received: by 2002:a17:902:e950:b0:290:7634:6d7e with SMTP id
 d9443c01a7336-290cc4ea8f2mr6194375ad.11.1760642345509; Thu, 16 Oct 2025
 12:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013062041.1639529-1-apopple@nvidia.com> <20251013062041.1639529-5-apopple@nvidia.com>
 <DDJJ4P7ED3LJ.6YD2M62RB5VY@nvidia.com>
In-Reply-To: <DDJJ4P7ED3LJ.6YD2M62RB5VY@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 21:18:52 +0200
X-Gm-Features: AS18NWCOXO5Nlj8i8ZNj-U23NNA7RJ1ucE47naAt3VXCGXJAjL5KZrU7UJiyBhk
Message-ID: <CANiq72kpgPT8=-UPj8Bez_ui=MTVauCPg7CabDau=jxOB8qdow@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] gpu: nova-core: Add a slice-buffer (sbuffer) datastructure
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:23=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Mon Oct 13, 2025 at 3:20 PM JST, Alistair Popple wrote:
> >
> > +/// # Example:
> > +///
> > +/// ```
> > +/// let mut buf1 =3D [0u8; 5];
> > +/// let mut buf2 =3D [0u8; 5];
> > +/// let mut sbuffer =3D SBufferIter::new_writer([&buf1, &buf2]);
> > +///
> > +/// let data =3D b"hello";
> > +/// let result =3D sbuffer.write_all(data);
> > +/// ```
>
> This example doesn't build - there are several things wrong with it. It
> is also missing statements to confirm and show the expected result. Here
> is a fixed and slightly improved version:

Yeah, I mentioned this one in a previous version -- the section header
is also still wrong too.

Alistair, please check the link I gave:

    https://docs.kernel.org/rust/coding-guidelines.html#code-documentation

or other code in the `kernel` crate for examples on how it is usually done.

It is not critical today, of course, but the further it is from what
will be needed in a few months, the harder it will become to start
building the docs and running the examples as KUnit tests.

Thanks!

Cheers,
Miguel

