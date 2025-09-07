Return-Path: <linux-kernel+bounces-804768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C4B47CC7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47FA189F078
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63F629B78E;
	Sun,  7 Sep 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHB0xpfi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401F29ACD8;
	Sun,  7 Sep 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757268905; cv=none; b=TGU+EsJj/dRbsLo7cUstkacKHPDA5Nv+Vz3JnT9DLJUUgwFvRpE7MaGez9oFYP2LtlJU3CkRvFHlfhq6eFCUhoCmsFYpmOz/dN1l3f9vfdtDWb3ZZTGAAe03Bopb9BeOyZy4DYd5z97QPxQ4zU78n9KXSjXggv11EX9tzoVrML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757268905; c=relaxed/simple;
	bh=Ydk91NzxOXXi/9YfPkvlp88QmnwQdHBwRvBI36n88IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAFbgjNSEeLc5ZFR65qcruGb4mjaGaCBGIR4iZkpguzg1Rne70brX6Lgu5fnQ8IOggUbEsgUdzhC7ktQix1QGF4ODICSFaIWBkMM7sIzySTUezPz5gysV+vWrTzEpf43FOxT8ZeBYw4ZI+BNR8ccQrxWj/EkBYnGZkVkiVUua0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHB0xpfi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b157ba91bso8778465ad.3;
        Sun, 07 Sep 2025 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757268903; x=1757873703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so7tAPulNJoJZMuWiKPDBzUnu5rjpYZ5RN5Pr7FZmqc=;
        b=FHB0xpfivltlsKiK/woNzuD45/ERloPBSwk+er1LDn2Iq4PsCz0RHTJ0thme1KA8Fe
         V7wnOC1g4bR885LbtJpTs9NXA8gpIKdEV8GCUUQVhRakQNbPgZAxqoWoJHDuUEDgxAT3
         SkFO0+bmX1u+j5NTUpteAZuA9fQzM1xMabaco7/0P5iKFYjO37KM9Bc89hT/RFhi8iHy
         NgaDXjc+WB+Wi0fVCN8JA7YDPd9JkR4Pe4BoeQX18CexZ+cjgCEkaU3VZyADDJ13hUiX
         1QvmXrNLQeEShm9ipYspMJWJHZfFn4P4COubIuEWeB7AfvPKZ2ofaiVoIY0k/fvdPLQ/
         B+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757268903; x=1757873703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so7tAPulNJoJZMuWiKPDBzUnu5rjpYZ5RN5Pr7FZmqc=;
        b=g8BCEhw1VbvHOrxrLP9R+Ko1HH5IZ3xIGWohi3dmfu2JOmcXA/XvCJ3N6eLXJIrgwI
         JqX5PHxjPpVLdf4YRon90Bn9Snl30epoaHzQanzDb4BoGA+sQ6NQ7m3xhT/MgpsjXN3n
         I/PVYk0fANt/DBx2nna5mEu1uVU9TmRqnbqfRMTGjcl++Lv0A8Nn5LCQb1p3ObXryyWv
         DozWhCbj4OmLWv4aO+sWwkxy57pO23Im/VQPkJKJv0sFXl/Wj5Ar9ye09NnFilGKQjy6
         Xk6IF8+X49rodG65jfyf0SqxQmpE/Ff6OhmlgSJXXc1F496LZtXfyrJXYzFuIVYl+z9J
         i7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6e4zKuac5VwS1jScn+Z3xMN7lwTc81dqBDqCzOmuFoRzyRrGveAaWojFZQWBoDWbdAwx+9So7W0PGqMeVHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweRzarXz/MTRm4lKHsamFK7R2bsS9BKcrzhnpg2vYrgFIO/cNi
	LHwBO7W9kzGaap0ueSOj6Gk+r3PAS50hnR5rhNSlI3TCqIsfH4e3jytKNiHJ6aE64k7aKvxyxMA
	TrNpvXzF6HrCLtUZqF69gJXdpkgaFLy8=
X-Gm-Gg: ASbGnctn9rv8U/5hzkveuODUuz3qjPfluqOaE+N12QP6GOn1xMet4AHuqFybDbvFQyn
	2IegzowmyaEOPaPlUQMv6yKZvDQ84oPwetoW9NQmEDRWcDq/7sMTZGFwnbtAH4wIo0zM/t1GcvD
	5XEOfmTj5FQXjFD12f3E3kXOkX3a4QlSggkhQ6frZslenvTyuf5fbr5/bEn+1KmKtr01k+uX2Ur
	ePlYpnLO5SuSLCH2WKqgtMLTPkJh6qDAXeTHRlyK90OMDB68RblQhRJZWC0HFikPXgWqQSX28Qa
	yL7RwxnaC3brZyX8gMe1/8Blu+OItC/bcYtY
X-Google-Smtp-Source: AGHT+IEFi+yiD6pVt8xzykvdhNR8iAoTqSIP3/VvCtQxgaxGbdva/bQu0Po7Zl81J3iNwIzpTh79xZ2zh37yiiaAZ/4=
X-Received: by 2002:a17:902:f644:b0:24b:1421:bbf8 with SMTP id
 d9443c01a7336-2516697f1d8mr44536825ad.0.1757268902784; Sun, 07 Sep 2025
 11:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903215428.1296517-1-joelagnelf@nvidia.com> <20250903215428.1296517-5-joelagnelf@nvidia.com>
In-Reply-To: <20250903215428.1296517-5-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Sep 2025 20:14:49 +0200
X-Gm-Features: AS18NWDG9a3NtPqmPD6xE-rs6EheOTI3-aJP7xdVXVOvHjupVzwUtV7enM1PPPs
Message-ID: <CANiq72mx7NA1KD5fw98kba+3oENHW44QXVGO1VmvPPUKin2LPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rust: Move register and bitstruct macros out of Nova
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, nouveau@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joel,

I didn't check the macros, but a couple nits I noticed in this patch
in particular given it moved it to `kernel`...

On Wed, Sep 3, 2025 at 11:54=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> +//! A library that provides support for defining bit fields in Rust

What about just "Support for defining bit fields in ..." or similar?

> +//! structures. Also used from things that need bitfields like register =
macro.

The "register macro" part sounds like it should be formatted with
Markdown plus an intra-doc link.

> -            ::kernel::build_assert!(
> +            build_assert!(

Is this path unqualified for some reason? Does it mean the user needs
to have imported the prelude?

> +pub use super::{bitstruct, register};

Please justify in the commit message why we want them in the prelude,
e.g. are they expected to be common? Does it simplify some code? etc.

Thanks!

Cheers,
Miguel

