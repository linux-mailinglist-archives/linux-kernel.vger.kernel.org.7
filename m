Return-Path: <linux-kernel+bounces-827112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A8B9057E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CF717B25F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650DF305043;
	Mon, 22 Sep 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9jDx9wz"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC243043CB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540337; cv=none; b=ILd+UdfqESltKiE483c84eQTUj+T6vbylFvQ4dt/RAhKnO0xA71C4XJhglabOURWLc/Rj1p9ZMY49/ii2GO1gex75tPr30NYwkgPas1emQLHmHcTOyGssTYnPnkfCLm8SJGrarVw6N50ltMNVwxZuFw1IcV555lDB4hTJovx5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540337; c=relaxed/simple;
	bh=UoJ0C87m6HCaK+orWG8VsBB/tReSjBexBOp6XdahtBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTc3QIicv8Y4toIyG5O3NRHDA4jBHlJzKq21rfMkBr1wV2zqwCpweX9UjfM9SA4ITyrRVs81wyx+b/YUfacXZ0pck9OuY0p2ji0IsFyvGUha3pozaYVlO3d4Zn1mhpKIGzSKzclgmYO0kP7/OqGhRpkIcFx+87dGklfUQgiv13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9jDx9wz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-267fad019d4so9644405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758540336; x=1759145136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgcdd398SyH0pM8oXBF9CE+eBVlofs290sIYKa4TYbw=;
        b=g9jDx9wzHL0IN57wa5J8UWlRH/Jq5aGns8Pvfoc5nmzmqy+/QJLEW9Ca4RA5WowsCm
         DzSr2vroD6GJr27KVZT7djkamTC3qIJXtQy5bqmTDzsTEFLQGkSvxO5BQ/csBX4oz/+J
         05tLI8FZFSUIj9LM3IAhFJve2/lYofCm2vqmS3HbtxLznLj9z/G3b30OWMhDCPWGLhqg
         WS8xfjtTBHtjNkIojCf5/J3nWjRhI+SPiCzStyCBost7jTQ1F0h18J16M3uOlKrc/BQW
         ITxJevI3JkAJ/6fv/WHOgoOi9QSOtHYAOJYpT+PIFbbNP8KDfXAQ4NgP/ygYfVTaWQI2
         UBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540336; x=1759145136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sgcdd398SyH0pM8oXBF9CE+eBVlofs290sIYKa4TYbw=;
        b=KqVUUDAE9uTOnhYx2wRuSVY0p9akapqlLvwqLfnf9QYSBDJmdzNEXjCJDLGZ8zFrbc
         m1ZCaYJb7YjbNun5/Jypkhq5Rna4IgcW7eZeLDQmbk7y2ODLo5KxFlRDQ12w32HA3ZoZ
         YEIMp8wpK4rWF71CmLvARUEGhIvSxkUxL9UULp5RAJgszWhNfHPcBg1OWTlfxKRmb2ee
         eAQ/nuUlTbBvbfM292AnXGNeRwIMYq3GifqEiL6s6azKxIvArTatKqkdNA3fOkmZHBiP
         ukCKzUH7q2I6DtebZW0mh6aGXfgDS3SiUIJ8pjXbEJ+Bg+RBGPjBVGqvNiHUhnUkKGqn
         PJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXeUGIHVqdy9G9dv3G8Cp+2aty//7W2ChPypcvScv300l7fQ6ObDbw4j4XkVhkBVRuFfAuj9+yU3GCR6kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSXt+v+JC9Y/PUy1m4IF/W99z4n3BmtVA7E2oxKckK7U1BwGR
	ER5sj1wv9CeAPvrARFD+GajL5SIkHsBykBvbZKfNGvV9IJlctityyNASVvwjrPYC7Vwmy1YotZs
	L1iOuSseFILdCVYKOQIW3cqTH/pgd5sE=
X-Gm-Gg: ASbGnctKh8FJdD04zFlQqTF5EeY7QjDNtCMfJs0NA5tsbvHNk8iokprhdY3Jbzd/Npm
	xxU+hIjgMy7aucMHJW9C2Xz2lqTpkSNHt8MKFuOO1EpH8r8aEncNYqtXm8UcEpDyDAy2guVXvru
	bFImryr5SjKnIsoMz0wYETx+FYhmtcs2xYLnfaJ7hfADbn1hH1fGce7pH+55QrbydRAmh/sqbuF
	d1r5MdZFQSvNcf0ygnz0KvDFH6kdy/KbumtHFezOJ/GwVKgx/ZkTKEGkEIQZiPru+4fop/cYz2/
	zredts8J62GnHfuGFRwdKqJJuQ==
X-Google-Smtp-Source: AGHT+IGWzqE6SkDNOWNhRZf1mCPF1QlPca4/WT51LWClbsTLspDL1DyVQvUJcILN3SbRU8SwMNEDLYi4dw9cO0SZbq8=
X-Received: by 2002:a17:902:e852:b0:25c:9c28:b425 with SMTP id
 d9443c01a7336-269ba5e507cmr91055835ad.11.1758540335805; Mon, 22 Sep 2025
 04:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org> <20250921004517.GA2101443@joelbox2>
 <DCYAIOO2W2KT.1CANHTH6GRVO@kernel.org> <20250922112922.0f57fbf3@eugeo>
In-Reply-To: <20250922112922.0f57fbf3@eugeo>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Sep 2025 13:25:23 +0200
X-Gm-Features: AS18NWBiQa9cs1Xaw5JY9X-AQevjIN3LMYl3QrNMzpfrvwPsi_bojXiVmltFGc0
Message-ID: <CANiq72nZRbbabMXOyEQirzt4v2Q2TE=-Z73-RnE7exJygfiFHA@mail.gmail.com>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:29=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I suggested to Joel during Kangrejos that just
>
>         pr_err!("{}", {offset});
>
> should work, as it would create a new copy.

This one (or Benno's) sounds simple enough (assuming `rustfmt` keeps
it reasonable) -- I would welcome a patch adding the explanation of
the issue and the workaround(s) to e.g.
`Documentation/rust/coding-guidelines.rst`.

Thanks!

Cheers,
Miguel

