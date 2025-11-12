Return-Path: <linux-kernel+bounces-897768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3379C53A71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C063562AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311CA340A72;
	Wed, 12 Nov 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGm7j9oW"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36592BCF6C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965635; cv=none; b=ZKvoKHxmGXE3VXaQxlO0sYVIgMOGEdb8h4qZ8+fWNu2rIBi7Eu6FI4kc/PDZ4k6AHWjXv7po5Ef+AxvAssB/3Xx2Qm52/D3cPL5IboFGYRgibBNosvMBE7zeJrf6fUZTgb6dCksw7hKs6o0ho1fBimaufxqRC+h8e6pKvtEcwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965635; c=relaxed/simple;
	bh=Ka+oo3pgj2JB2kc973RtV4omtwTlaZBtkFnKjkUoQSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjWpLzy2hgFBWn2zU5ps+5ipOpls7W+CZmBVJAeEzr60xmLwggvqvGdx29Be+yrRwCMMj3KDSgXU/Ajadlxv2lLKwoKI1HhKIZ7SS+pFFINBWpfjrNbkNFuk7Re0SnlQ16vCYJqiGRRy7XOTOxlAW7Wfx8apl/2+aFOhglweRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGm7j9oW; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c70fcc8561so390772a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762965633; x=1763570433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka+oo3pgj2JB2kc973RtV4omtwTlaZBtkFnKjkUoQSA=;
        b=GGm7j9oWE4/zlHseA4mqq6UbNgcg7r0FAKbryrag4v1u44kO1VbxZiuwIyFF6Ssqco
         jaqqtgt1iiavjyxcii1wobtYqONk1KdqonB62p80YS1YGIuuZZpZGt0M0VvS1uzI/l0p
         2Rx8vDMtYym9pF6A5ONWCwjbRx4ejAaXalvMLzmRzfipMp7DoPa2bP3qBV+T/LMgvUcD
         tZ6yVpfc2u58AR9mGQZZMoIMaXaB7RXalznZAzdQi3CAkbNlA0LLoBcNbqFNlSx1ZpJx
         SMcsOVQbXmVwMvhrgmMf/9dYTa3M2Yg8gZ+HRx5NJSqZtYhki8MzPEA858pA5GC8u2uH
         erRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965633; x=1763570433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ka+oo3pgj2JB2kc973RtV4omtwTlaZBtkFnKjkUoQSA=;
        b=u4BaLcqiTXFUPYVTiuj8Sgw0RRXAQmz5VZwAsO/obzbY+FHwRdI6W493rRroqdfInq
         E41Fb6dB+bYv9niV+0s92DlAMbutlWc1tVqUzFX+NIUEwea0bxUa14rdtKbALIkVLS3X
         xf/xd6bAz2Diq6j1XQJnPQSgepnQGqX01UtjlXETJia9Gse0Ha0GcI7m+/vIKsmRXBmc
         5bY4Oeib91KgG38l6JUDga3xqySg4N5JKwPpGq9vDexkvSS6gsKPnqSQ8W/FqgNFwKOy
         BdVwjcUo4Kpn9JOn7n97LHsngRDETpQp/Y9kGlukx3oHM3uuU07MTj5m8ISI/O9I6mMo
         Gs+g==
X-Forwarded-Encrypted: i=1; AJvYcCUF1QZIaM+VHn+OzwJzXjzqIW3VqRMNoEmpbNOdim3fTfzZx44zqk0PmGemzHHRUiLGKs6bfytmPrZFCyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUK+LaYCIRabmQzbn8KmKfeknRc+OWw0XIDvmRrSZugXX4sOy
	jpb4KhCXWji7Jz1wsOjUNKbvy36TAs/Q5810temZ+cT6uUmmmqGM/fvpkS9jhS3SIcUzbBEofso
	aTQ5MSr6bgH7DufmPcWMKPIMR2fM4X4s=
X-Gm-Gg: ASbGncuM/86M+DYKc5muZE1kDwg0TrqATy/N/AWxTW3ceDe/9u+wKhX8XFw6S65fRBI
	r+g7EfDAOhQpx68maHy5Wkp5AHPzwFkDcPIKKPAipLDJ9l119CSxu62FMZapHpCtDEiOEEwViNZ
	A4dz6yAaOLM7QVxgFp+yuq+iUVTpU/Hx8mfWVrtMIt1gCc/NspXa/0XDaYntqhrytSYn4fus3JI
	g5Ghvtew0/Y1+5AO8CWWLXfr4O+CGznZN5DT1EoYYKWvDbr87f2sPqzFw==
X-Google-Smtp-Source: AGHT+IGK44z86BN2OSnOpdaIYixeb9Hn2wTFfWJTLtnMDWPUJTmZR96qPQq4/NfFd6A9d51DPL2ZhfKVYst5wfWiYj8=
X-Received: by 2002:a05:6808:1b0c:b0:43f:63cc:aed9 with SMTP id
 5614622812f47-450745ae5cbmr1472885b6e.31.1762965632892; Wed, 12 Nov 2025
 08:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2> <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com>
 <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com>
 <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com>
 <CANiq72nLzuCXh0r5W0HMM36f9yTSQfP9yCxXbzH+wS7VxFM2Eg@mail.gmail.com>
 <CANiq72kYYu9C94aY72HK1ELSmvktF3nq+G4+smdAW_Xaxw1kqw@mail.gmail.com>
 <CAAOQCfSRVqFZAJN_m-kGLe6fnqKYyhLUf_WOKdHHMW-C6NShkA@mail.gmail.com> <CANiq72nU7LOSEv=RsewAwiEbeO4=pTqg_pm+WJGfum90BC43kQ@mail.gmail.com>
In-Reply-To: <CANiq72nU7LOSEv=RsewAwiEbeO4=pTqg_pm+WJGfum90BC43kQ@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Wed, 12 Nov 2025 17:40:21 +0100
X-Gm-Features: AWmQ_bkPOh4vHeoQWSet6WU-HZHFI2Z23pN6yKqCCaQUHSdDpwmkPCSibrem5WM
Message-ID: <CAAOQCfSu3Ej3K63iRcsBJLS0rEVBqjLqN0mE5VSGHyX7bVmU-A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah that's what I meant. Ping me whenever you want to talk about it.

Le mar. 11 nov. 2025 =C3=A0 21:32, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Wed, Nov 5, 2025 at 11:54=E2=80=AFAM Guillaume Gomez
> <guillaume1.gomez@gmail.com> wrote:
> >
> > You can add your own tags in the doctests, and with our patch waiting
> > to use the new rustdoc doctests extraction, it should be pretty easy
> > to plug such a feature into it. We can check it together if you want
> > when the patch is merged to see if we already have everything needed
> > or if I need to add more things on rustdoc side.
>
> If you mean the `unknown` field (in the JSON) that I mentioned in my
> message, then yeah, I think that is good enough (though we should
> probably still prevent collisions with future `rustdoc` ones).
>
> If you mean something else that I may be missing, please let me know, of =
course!
>
> And yeah, we can take a look together (likely after LPC).
>
> Thanks!
>
> Cheers,
> Miguel

