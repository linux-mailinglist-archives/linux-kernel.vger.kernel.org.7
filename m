Return-Path: <linux-kernel+bounces-891278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A7C42528
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909BE3BEE07
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D12C0265;
	Sat,  8 Nov 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QY1QnKfw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077011713
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570214; cv=none; b=CBgBRPN5IYJovDenv2BBiYv7GvpzKOhttmSX93sSKRmTiXUC5fYr4GXQ/bydzQoHhlczrcHmjhjLKSZUMDQ8tmRR18soMU/Bw94xAJ5MWoBn53+Sb19CNs5fbNoHVPkR5wZPYjEGY2e9g6SlyFotENAHCQZ7YeMeuwWdAhnD4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570214; c=relaxed/simple;
	bh=OAMQkM8H202HpZ9SyALa6Zflvi3TrT+59q9nVOpCnkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSDmI+WRRoAVWjEmAFc41wmHR9TsM+7Gd8wqMOtBwqO0yF4QZOyC7fYDQfZzWuEwnvk+KtJcNLwsmeoTeNXhpBPREOdHj5jqlc+NM6VtMosASVLTzc2Cv8I/jsOfaLJOgq68E391WWVjEaSCCNPBYVcQLSCt/ygQlxd3HDLrJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QY1QnKfw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295c64cb951so90325ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762570212; x=1763175012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz9KbiB3pKiQMMUPj1p32orHVehzjrikuGFe9xgdEQk=;
        b=QY1QnKfwmNmjFiqVyx94aqCp/G8lLQqfRTEkDX51/ROw+PoGRpC4bxzUlbpESmwWqI
         aABb50O2PwkiI2auKcUbxKeKxIBFaORgXvhL4+0TA6wcaPbYh2yCiS5hFjVI5kz0SxsG
         0cMvmVJ+Yq9AfjcEAP4/x5bVD87UKfk60LgRfyWiXt/eIiTERsGgXbYz7UjR24nfJIP1
         sqC/w8iXM1Jr0FGQo+usxjQfbmqxye6gGSaZGBSM0GXQ490WztJ8ncmByUk4rFDZFPs0
         PnOPkWXKolBG+joU623zKefwwtoDPV1IrbD0qoVqAKC/JtKisTRbXSFGo2yhRhdxpYZA
         hxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762570212; x=1763175012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xz9KbiB3pKiQMMUPj1p32orHVehzjrikuGFe9xgdEQk=;
        b=OkHxIIbxMnALpxiyYVWIWMKctH6i18ha6vp4bfNdtPyzLcv5Rr26SkHCZV4TmrQQLP
         rfV0Dyb8WFtq6UMFBLSDoa4wvk6JQYkkAv0ITYd8piXfquN2uqbz8vp3cWWWRhKKm6J2
         wGQHdyi68VSuXSaoYut8VLgTpQTIUxOGVrVwxfPgsbJEfMvCc1WnuIUPDeExGtGkNmsH
         ClEn29xmitkJyTDJfHAxfguRP22dNq71zuhB6IM0+wqoQxMiZqeiGBnzV0EgKB5wDpCF
         b/OFSLjJtW8zfI9pjbrXzeVebDVxaTTMfhC6hJwPdniF0d7iE7EFyQg+tS0JXp6rGIcC
         GVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmLKRGgufCHPvG4WrTu6K5RypFSP/SRPvzcurBqJG6BrtIlNftOxHUBaL5IQI0JSzWmw+JdN6aluTlHxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7dzZp2FjDOwDLrS4PGY4+JS2q30B8XOkhlS+wdXXs5aVb4l6
	XQixF0gaZP1MUFF+rRhkjfRbH9BwyibnKAyPzbyKvgwC5IPVSyothgvJ/IsPjY7kGWHNfeTk/jj
	hEUqIXkMzvOhnQJy2TKYKPaA7xLpnjRWC4QzuVB7o
X-Gm-Gg: ASbGnct90ui5R3ASyU6v0D4P3ShkztDA2K27uq91Sk6uFq44YXOEN1IX/oLpeXG1TbA
	IoNcwlsjEiH0I1gbzcQYrV1XlEQtgVwCN/mqq8d2kzpwHRcBE2pURLrQRgVOP0Pis8+XccPcsNw
	MvjwXBu/DMkbyHynZwAcWeCqtCF6ErEGMcnLhOzNM5TR19d5C9nHUhiswOw892UGGRy1X3lv8JK
	AvUoI3HsTPxkHfuU6QE7kl0w9pM0BgADf0GZdt8lni2ilxvFqMiJX0lBXHzpixCbcpj
X-Google-Smtp-Source: AGHT+IEDYpJKL+hIOzjq2gpmJ4iFLKF/Y9OWuaaO1G7yVaYPMHtubhDweRGu3Pd8BduK0hfGnF3VI4ZMdg1XmQs5Cik=
X-Received: by 2002:a17:902:d4cd:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-297e51be5b3mr2383685ad.4.1762570212326; Fri, 07 Nov 2025
 18:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org> <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
In-Reply-To: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 7 Nov 2025 18:49:35 -0800
X-Gm-Features: AWmQ_bn2xE_C004xbiOPfj6vuNrWvyE4Ho8Vxi_L-U3qXSI0Ruu8KQu5_TFbvtY
Message-ID: <CABCJKucCJLWfHz6o=wWWx95keLC6na+uO3a0WVLTPEz02gENPw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Nov 8, 2025 at 2:44=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
> >
> > note that `CLIPPY=3D1` does not reproduce it
>
> And obviously this means we have to special case this one too...
>
>     $(obj)/bindings.o: private skip_gendwarfksyms :=3D $(if $(call
> rustc-min-version,109100),$(if $(KBUILD_CLIPPY),,1))
>
> There may be other cases that disable the optimization or similar,
> plus we may have other small crates in the future that could also
> suffer from this, so it may be best to simply force to generate the
> DWARF with a dummy symbol from that crate for the time being as the
> fix:
>
>     #[expect(unused)]
>     static DUMMY_SYMBOL_FOR_DWARF_DEBUGINFO_GENERATION_FOR_GENDWARFKSYMS:
> () =3D ();

This looks reasonable to me, and indeed seems to fix the problem.

> And then later do something in the `cmd` command itself or teaching
> `genkallksyms` to auto-skip in cases like this.
>
> What do you think?

Like I mentioned in the other thread, we ideally wouldn't silently
skip symbol versioning because the exported symbols won't be usable in
this case.

Sami

