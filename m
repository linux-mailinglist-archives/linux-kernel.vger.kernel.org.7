Return-Path: <linux-kernel+bounces-729979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9822B03E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662BD7A2C40
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D5247290;
	Mon, 14 Jul 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRmQBjW7"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785724728F;
	Mon, 14 Jul 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495893; cv=none; b=ZzwFhfljhFJ9YiVoQFY/IiLp59sWHtKzOZpsbMM8oeyvHcHyW/PE7BuglKS195Ok4NIoZKqeDlD6KpCC++8GyFnPgajDY/xvn9Mgx6kBcEWfZWD7K1RsoDo50t+U9Mc+gjYk5bGf5nvW/pgklLx1NKP/sM3u1LoeSYrhEicExTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495893; c=relaxed/simple;
	bh=ZuXG+i+SmuchIhngE9ENKqZaKdRzXUfnsQZhyf2kAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxn8JjLSNi0XHIQNu9ciBY7Zxd24sLcIIiDZ0HPoXBlTiX3jEOazpOaSGqoFpGUI+z7BU3VQwyVbhEBu3RDZOr9ADNd8ZcAC1olbmBwEHlJfaXDbaRu4A1eMfSwFvF5o/kkyOOaNrKfMao8trAuLqccbz4biZUbj8nL3Z+wakqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRmQBjW7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso37659951fa.3;
        Mon, 14 Jul 2025 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752495890; x=1753100690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiunIh4eAaoI70/iX33maNxdiRWc/PBAOU6pQuqO8mg=;
        b=LRmQBjW7nU1o7nHTrUrmfHy+zZuzMFPPXoR4w+4sHcnOr449KLoG+MmiqgR5TL2iiz
         5E1ZiJ8bQEJ41TSj/lVCABzQ6b1fXiXCdwTxSS06r3wMRlMvcNkL/Ok8uTRuS8aEnZMn
         phwiOiSpP1UAL5/qgnwojfqq8E4r1fU2Jrc07TYWgYcCS8OZ8VuTrRN+F+p2LyprYKKz
         e8D6AhUENwl6ymaZiagrWMDyh7wAXXIdyNfaoq1R6KOhHa/Dp8aTILtodYyJvx3hKydc
         5oCC/uMwXYwS6hgaqlv71FhTfeHNmpphMwdOBA2317Ep5mkL+o/B/WoBnm+AZrm++36a
         qadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495890; x=1753100690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiunIh4eAaoI70/iX33maNxdiRWc/PBAOU6pQuqO8mg=;
        b=wSuTORzdbBDDoxB3snk1FFJa8KmWi0OjNtkcBy5ne4vh9NjPlV2ZqE1Jq0JKs0C/J+
         5h6mbVgIUdJKJdkrXVOZl1lQDEKONvAk5DmreE7dyZ3IrDz+dptFO3Vqrg2EXsKjbqvF
         yAltdUdqo7YJhZ3yQ1cXmTDKN9PaAzLgIaxHjSODmMV22BK29eUfZgy/LOqhseXy5vbd
         CP35R5dYn/otSH74LoJ55k9xNbtl4BTWL1jKFTiYHP7ci9uH6RorGHOYKXj/w+Vl0Tgy
         nDE9nsHCISa7ejE5bfmpDe0yjO9MwjRIZ9YY8r2y79J/t4JU/ETPv1ns0C+dopfB10vR
         SaSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+LRD/c7HBnqnKHhwignN+RGHftdj0yMg0orENTvJD3jBsAXqp9a6leNlSSbMzHXcEFJbHDE1SB0aD6gQ=@vger.kernel.org, AJvYcCVsvaE0AP6xooriXSnTAQEhSgRJPk2dYdxkZKdsLVF0X8VEtYs6htsqYPLL0wHQkQFp0uwn1v7GlspWIgRP4ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtzj2FhGecpBdWoC/4RZZXxDGKVa1NzzfNKhrwIVoi51B79Uf
	giuiDcfiesRZEw3x/fSfsCS8oF3bELbEzm1a5BgdiMS88bxDD5sHqgHjjH+h72q4RRlzdwyFF3l
	BOzy4IQiExtrP8JRUMs7LzY85znXJZTk=
X-Gm-Gg: ASbGncupAJ8JPwNT1sorYEGTDDe8Anh5CCxgJAMj/WtBdC9VuNzFVJCLD9SxXgoIpb1
	RcV0ziOf+fq4ETacZMKvg4hxFPpOBzOgnt9JBzSH3xiNp1PbP+XifVxPZkpopaEawLYz+FSukPE
	fnUA79g32tFRx9+M0bSyDjI/Y6pDwcVhdRrHl8ZTEFM6AIrG0gNLLEFTA+kR34UYIMXpGB/xPu/
	wXSoR+Cfv4bEYlZyGIn/1F4IXIHQM+ZuRblOwHYlA==
X-Google-Smtp-Source: AGHT+IFupoiMpTpkWvoF37zAwoSnfHR0O5s//yyqCJ8UyAIoPxUTpvFl1pIX2xmYkdy/dg3/14bCw9Qz+Z8UhOrXzJE=
X-Received: by 2002:a2e:8005:0:b0:32f:219d:760d with SMTP id
 38308e7fff4ca-330534661d6mr26394161fa.20.1752495889605; Mon, 14 Jul 2025
 05:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com>
 <20250709-init-remove-old-workaround-v2-1-a3b1be8fd490@gmail.com> <CANiq72ngcL9CSkSTFcp+Of8PemAKbvQc1TJ5s3vCiLoHX4QfcA@mail.gmail.com>
In-Reply-To: <CANiq72ngcL9CSkSTFcp+Of8PemAKbvQc1TJ5s3vCiLoHX4QfcA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Jul 2025 08:24:13 -0400
X-Gm-Features: Ac12FXyMojXfpaatszHdqv7PAZmb1uKx2hqH7RiyjwyzDTQ5tp-1mmntU2x1_jA
Message-ID: <CAJ-ks9mSLKzw=-rxPgfyjbGk0hzXQ0o+_kH4HoEZeSAW-Opa2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: init: compile examples
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 4:33=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 10, 2025 at 12:49=E2=80=AFAM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > It's not exactly clear to me why these were `ignore`d. There are many
> > others like this in pin-init, but I'm only touching the kernel-specific
> > ones here.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> This seems essentially equivalent to this one applied a few weeks ago:
>
>     https://lore.kernel.org/rust-for-linux/20250526152914.2453949-1-ojeda=
@kernel.org/
>
> But that one uses `expect` to, which is a bit better for the future.

Yep, thanks!

