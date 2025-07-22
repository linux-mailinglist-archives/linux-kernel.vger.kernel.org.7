Return-Path: <linux-kernel+bounces-740657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C012B0D75B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189E31887858
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262582E0919;
	Tue, 22 Jul 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REpiLnab"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4672DE1E5;
	Tue, 22 Jul 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180142; cv=none; b=iRsfB6S0Ywhg4pLPLQj7zJHZImwRllelnrfP8CVCcusO+cu6wMQ3ok4LMJa9YvHhvSfMMZVE4stSksx4yfX0KhspZKx7cIK730H+yzjKcpwpR+wppDyRC4DdmWXqDIli/tcRHoJjlUH4ReLuoBAf5WvT92+xKtRrQtTlUhY8I5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180142; c=relaxed/simple;
	bh=kmsBUmTbcFqMAlUGoznBkV3pnZIyizNNQNeCUvRN870=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+OeGlAp9GiLogVV+QDpGQksXx2XK0RIRpx3JftQ/m9H/aSgKeLP44LqO2JXyVz3iCXz7VmmsIpOOZVd3y0QTQhK5xQXN3TjORpnU0qXQd7AOtegZIMHg/qqy60dwTXB1Cfck/FuZVw77ZLDxpZaVqZyE7tLJIGnqOLWIrdQ/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REpiLnab; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-312efc384fcso135580a91.3;
        Tue, 22 Jul 2025 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753180140; x=1753784940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw/ju9rvHXHnonIseX34aE2nlCCcwdEJg+zhSfxvjRE=;
        b=REpiLnab2icGSng06mpj6cEBngLFhui4LEK2EErNzOfvmhzOYP9DTYitCyl6Fa8P/D
         IXdBfx5fFD5JEQADzQJN/bwpwUcURKSeaK4UtLi/QCEh01BHa1O2Mb54t8mtZBd289Ec
         u8kVxhoK5mGtfuyi7+nZFH3sQ1sjcv0ZSiEvYp2j+AC05w+Yz6n4/yAszIfhRh/utEsU
         54N/e7FU7XwfHfB+E1v/2I89QbLCzKMPtjWhQZ3RzPGsRYIL9B/CDug93E65hiUqdLYD
         Cz4Q9RruD+i0BTF7/iB/gkMVzSMibkUHoJCBfCC44oCUmP/HDFVLDj3KYXiDp+hzHOmp
         LOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753180140; x=1753784940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw/ju9rvHXHnonIseX34aE2nlCCcwdEJg+zhSfxvjRE=;
        b=KTbU36UyrmMaC9pKFXeGBslUtGW5+SxAWAxvuHdNGpYtiOFBXKbMmFyX+TmEDiF57o
         bowSvOLDxDelxmURJlBzhfnYnGnPHu7w0G0eMqZFaPWjS2R44SrwpJu9+ke1z9dXlJI+
         ytNUP8VbqgyK3W/VqnKZ5dsfR/zctVAjNVLNAEPimWmfNubDFal2O27c32XzRl54qW2A
         UkFAO/LA5BqdqTk/TDxCOGIc2l7kLCHzlpZfEUNe31VHRZY9zqxOS1NJowKqL2er35f0
         KeOyUlzAP1ZisWPNJ5gEv8utV8UPWkrKscuOkahQFh1xZxIiB/JtiqqDL7x1ztk18CjZ
         2IIA==
X-Forwarded-Encrypted: i=1; AJvYcCXAiJTlr5DnKCs0mKt/4iPyHalDJ/LFzCO/BF8n8+qw9z43eYtXOKxg+ensM6wwBob4RezSliLTNybWanBqvMk=@vger.kernel.org, AJvYcCXCOZnf2JT3AAq9aTx5jwbW74v/i8UG68MNnRLX+jiHucccdMST3gBAH5tgT14jgvrw8+DJCKOdjBUXY0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxswpSomQBAGm1roYoNanXoyNTkkZ9G1FsWfJsFEP6NeaYM22y
	OJe9zM1Npt0IRdtNazzhxq7/ok12VUaVOa45W6nhLPOXmTM7Eay50A6EQ/5aszCeGPJQ2b9/v5t
	xw9Wm9qKeUDb2RpcmWNxz0R2BwR6yKUA=
X-Gm-Gg: ASbGncsiiJd9AZxoKZInX73AFXEo6QQtQA2F68TZ2FypOUmyeulQyhQZNGKveKsHP2/
	jZLrzGi+pruxSZI1kw62GQxqFC/opjnZ1sweDSOoF21bbEdFP5qCHa+/EK8cbzlyQVT4qipRADK
	GkGnj7zBrVPOp8uZfPnCWUXgGKITCekzsfExXwiXjXAJjWn7DdqjAH7ik9o65YGgavDLvmgbUh2
	kQ6f+Tj
X-Google-Smtp-Source: AGHT+IFZRUIcJKoJI1N/811uHl/+6xL1FcqAxJgYR5GedPqfBofKM11Z48fkZMwPdT7cuHhTbzif2+tsEl/CCkj4vuA=
X-Received: by 2002:a17:90b:2542:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31c9e760d63mr12910238a91.4.1753180140334; Tue, 22 Jul 2025
 03:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715110423.334744-1-shankari.ak0208@gmail.com>
 <CANiq72nZMLghTj8bHerEfXyYMtbWDH_WVxYeQY65ymWjSuxA_g@mail.gmail.com> <DBIHASMYLFEZ.19R61CE8V745Q@kernel.org>
In-Reply-To: <DBIHASMYLFEZ.19R61CE8V745Q@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 12:28:47 +0200
X-Gm-Features: Ac12FXyKBAbQXxGBytZnrKSboIFI-2NK3V0UTEhIkQk0DFie2t3OIpnw-M93LmM
Message-ID: <CANiq72k-BaJFzY7bBci3Xqj6UKXEibpu5fGuxa2rkSZdjjvyRg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: move ARef and AlwaysRefCounted to sync::aref
To: Benno Lossin <lossin@kernel.org>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:33=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> `ARef` specifically is about supporting types that already have their
> own "built-in" reference counting. I'm not sure if built-in is the best
> word to describe that, some alternatives are inherent or internal.

Yeah, it is a bit ambiguous (e.g. it could also be understood as that
the code is always built as built-in, which is true currently).

> Maybe we can just expand the module level docs with:
>
>     //! Internal Reference Counting Support.

That would be nice, yeah, please send a patch. I will use "Internal"
for the time being so that it matches what you have here. (Inherent
sounded also good to me.)

Thanks!

Cheers,
Miguel

