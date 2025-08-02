Return-Path: <linux-kernel+bounces-754150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3ECB18EB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2647017D237
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500223BD04;
	Sat,  2 Aug 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO7Zk3A3"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D95149C41;
	Sat,  2 Aug 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754142101; cv=none; b=S7jA7E6DEDBcfvpm4cNYPQduAjXxI7LZtdiU5zKJ0WBjrx8b3SoScxl1xBaNnlo5PF855nXYxhteBbqEtEwqkya3ismCLPGxDoKbqXS5pk5v9Sr89k3hpu4VswbCuCOa6gg5EQbWObhpOSwnDJ4mKtykZNrTODN4EgvhMXsk7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754142101; c=relaxed/simple;
	bh=s5Adrm0DQ9KzMRIFpXc+ajYpj+gHS/XMsPLGkglG/wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jADZVvZrsWgh4MRRPDLqxNF8kGYqKJCIp2B4JUXhWPcpePSOaVtPMGa0GXQrC57hZa697RYZ9hMdYSsncXFOCXpj0mhwwuJv1Q9trmESB7t+1H2W52wEna7IPjwHWaalgBErtayTwUU51PUbRat7JGy8hcV2Cvwp6YL+ZOJNT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO7Zk3A3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32127d5f63eso1951a91.0;
        Sat, 02 Aug 2025 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754142100; x=1754746900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsxZESSbpSCiPFgh1RAgcx6H+uTAf/oM/QPaKZ2GOQk=;
        b=HO7Zk3A3akRT83tLzvZwMxQBDJnDyrAejFkdapsG4KNVTRbGLsChJGEfwacY14L1lw
         ab5/kxSg2WlmRAb1rZcxm48apKeCwlngnAxZN8knevMq7FBNSLiH/gMln2b4+uOY2e5T
         4yb6j+PbfaHbp4Mr/zit7d9V4H1djjuRBJzsh/V06uNtgYO/ccrh+IbjmRvL5426kQ8l
         LgIjkUMShhn9loGVEfBcEhczDXoI15phNqfZE+Ut2uLtvS6naVuW2MS+ezFx2qBLHf2S
         YBR/rgIskjZuOW4zIrkDkciCcNU+iPyhW0CpXvSYZ4DmkXoWLF37aG21CS3NKZI0YLo+
         Yu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754142100; x=1754746900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsxZESSbpSCiPFgh1RAgcx6H+uTAf/oM/QPaKZ2GOQk=;
        b=FL1G+HqpA59lu2pX2SIWM733jWujWSYp93r2OnMp2sEv60kFaukTInujF0xdm3/WLV
         DcEKxGQPDvBwXOkoGDXtgaNbWChmjz/oFKf/Hen8gBgsjb0wT4I0mvBXIyjO769PgYWe
         hd26fUUMS4hWYLexTUAMpjL3mIUxNV8UsIe2C6gOeO/Yo1YwlV04C+rj11TVVIRIqd3w
         jYuSQwBK+RRhq1xH9YyR3uGkUtkJLIo7czLqYHoV5VrRTxCf/AyQIRl165wRI2wUTKu8
         JGAzCeYPY7lsLziB4fY624/H/tVFkQ0+3walxGg6BKfnQdwVszI7lA7Kw1dk8O2Lennl
         htvw==
X-Forwarded-Encrypted: i=1; AJvYcCVgQd25T15ucHbtNnFXn41+nzRcHfFDg9Qb3/RkZBw8ajZNLoCDKeVNqdq7PtMUkSgYXiMklq9XzJFBpe0=@vger.kernel.org, AJvYcCWgIi96zcjRzBBND1iFsEjNvkn6KDpYlxIzeBg+ZvoPTfXaKkd+iTO7AEFOJVn6OtyCxVNb5eeGqMvJpZY7T5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FzE5Wl1oX5BHhSYFgBI47AlsERsJdcyOMLimsPW5B3kA05ln
	jYttwFeFvkNQC7ytdiqS8aFlVfl20oXedS2Ersdp4pNv4UA5N4vcCJLhJ0+AKPHpH8HUFXmah9I
	T5c1r99sJSmny3QLj5J+A4u1xrHZ7T/w=
X-Gm-Gg: ASbGnctUXJRCkqrswBCLIHq84YP/eA5uBDFGNTr2IDOZPaX6wFdhpcewpz0JbJOrCKb
	9JLFdJTaeNTB3z7dJvDT+b+m+7stToLM5ep47T7U5vOiVB5PiELBwWjCOl1P8quPRxhhVrQnb6p
	BtdOd1y40+nruJt5aXr+t3vQKPWM7pxOsV4g1BaUyMAh6FZJYk70BUZfAwzDCQMfp5fbb+Vq01x
	vglpQx8FC7ODXxhZlI=
X-Google-Smtp-Source: AGHT+IErFqc55TWByZ9qMI1Pagy8hH9TWRfQtk4fjo7jHF/OVaGon2/ksIFACwkNiYTtohBJgqVt73r2/Zl//XdGZrw=
X-Received: by 2002:a17:90b:33d2:b0:31e:ec03:7fe4 with SMTP id
 98e67ed59e1d1-321162e4270mr1647853a91.8.1754142099761; Sat, 02 Aug 2025
 06:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621184454.8354-1-work@onurozkan.dev> <20250621184454.8354-3-work@onurozkan.dev>
 <DASY7BECFRCT.332X5ZHZMV2W@kernel.org> <aFlQ7K_mYYbrG8Cl@Mac.home>
 <DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org> <aFlpFQ4ivKw81d-y@Mac.home>
 <DAU0ELV91E2Q.35FZOII18W44J@kernel.org> <20250707163913.5ffc046d@nimda.home>
 <DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org> <20250707210613.2fd5bb55@nimda.home>
 <DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org> <FF481535-86EF-41EB-830A-1DA2434AAEA0@collabora.com>
 <DBRVNP4MM5KO.3IXLMXKGK4XTS@kernel.org>
In-Reply-To: <DBRVNP4MM5KO.3IXLMXKGK4XTS@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 2 Aug 2025 15:41:28 +0200
X-Gm-Features: Ac12FXxWIkPx3j64iIsxdsItUTgUAWyOwNJACurA9ndJljWW9o6QHgtjb8ehGfg
Message-ID: <CANiq72=owOmGLi3Zh+7o5CRKU1_tNU-OsKskj35GXwkDCchwKQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
To: Benno Lossin <lossin@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Onur <work@onurozkan.dev>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	gary@garyguo.net, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev, 
	bjorn3_gh@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 12:42=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> My understanding of C preprocessor macros is not good enough to parse or
> understand this :( What is that `__PASTE` thing?

It allows you to paste the expansion of other macros, e.g. compare `A` and =
`B`:

    #define A(a,b) a##b
    #define B(a,b) __PASTE(a,b)

    #define C 43

    A(42, C)
    B(42, C)

would give:

    42C
    4243

https://godbolt.org/z/Ms18oed1b

Cheers,
Miguel

