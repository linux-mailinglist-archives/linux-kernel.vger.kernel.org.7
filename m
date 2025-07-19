Return-Path: <linux-kernel+bounces-737815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF38B0B0E5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB42AAA38AB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0222874ED;
	Sat, 19 Jul 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFNCNYn7"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F9801;
	Sat, 19 Jul 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752942009; cv=none; b=FaxlIhRhiENMb2ie8dVy5wWy5FFZfTk6H5tiSeTN+jyxBayHZlUYva0dHxr82JUmnqgdrzm1g8cCMj/c3XmLdnaLSArtey+Jmn2qcfz/9x6XpVn2M7pAi2Du4TGdwmitNN8ZuW4M/lP+qt2oZFLBIBVBBhyycSJ/MQ4bQADB7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752942009; c=relaxed/simple;
	bh=HTP4t2ic8DJrjVhJbVdlvuz9vyHJ21R43AQE4jmDbFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3dZFwo2nSAGQc8z4ljrzdFRz0XUokhcjkFHY6Zg8z6B0q4xn0iSuv7MYkWIiSU0ugQ2aOxuEQ++8zDNxJkrWpoEdQryTgm/W71KPJj/NPAnR4Jfm6vaU0BZZUL02hzeQ5e1ZSMi+71Xw74yFCyaXDGjG1VonFTz4SYDjQWE2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFNCNYn7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313336f8438so486098a91.0;
        Sat, 19 Jul 2025 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752942007; x=1753546807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTP4t2ic8DJrjVhJbVdlvuz9vyHJ21R43AQE4jmDbFI=;
        b=jFNCNYn70lA3vNehUBTV/3aN137QVwY5ki9aS77Vp4lxUZwToEh9l9akDVjlxE0ovq
         k23a2RCduu/k5sZSCaOF6znwdKilOYbdOzpGNIV3WcHhuPPAC32dMSQJGwtES6qSznM2
         RqMUfaY7Sd5LyGI57GyPVqsmNllr1J2vznZAjw8qrLXzhxGjYNKSfJhKFemaq3c2bqT9
         jdPFlTKsAjtyJ9QMaNL6lFi3O3i3RTI6Mro5J37EQ/tBLZ+nLfWC2K9AFIVRrUCcszab
         FSEQBu7K7P2EKnMQcb8E5rrqZUVaNcJ5MoPmrT9OWA05tmb0I8I/IPt/Ho+7mWKPruuy
         EsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752942007; x=1753546807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTP4t2ic8DJrjVhJbVdlvuz9vyHJ21R43AQE4jmDbFI=;
        b=ZkWOHLVBJLJSCwbS84zwH5PUabERBmeVggrnbBMSrWdG+OwAUDcfLxRrrR9ZulQJUb
         INcsfkU1N2MRBGFXYDVz0PzAi6O0aCvk+oglfm/f64oPtRTy9vUArA7IMNhLBA8D+Ood
         q2dkW8sIuDRTnnNMTT6m/H0JYcQyhh5IXImYCgaKdAG60Ax9Zm4RtIhVUOwlsANE0z/W
         8Z1d3G9kBY3qcOy9lK/nWQg0cwJinsFftxetfhpmR+dC1KiNKGUWNTznqypomhPhgVko
         a3YAYi4/ZYOebqRRqn5bZlSUhR7I8600efIywr5pXTZw6ibW798tgC0SjJocniCmE3l4
         HyQw==
X-Forwarded-Encrypted: i=1; AJvYcCW/5fO9mnVM7SxSg5iqRhz6DfkEVCqF0Ox/RFzJ2KF+YhxHzyO7bHk48nvAOCNSSZBH3SOl7h/zSkKIOu7mSzk=@vger.kernel.org, AJvYcCW7XQP0yxV4KtdgY7wr4zPVJRM7LRGABBvLTV+ZFivh+aEmJg9eNyMy0ih+Gaiayce28V+nOJrh7sve1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UyXnmLQXlSpRvtG0HABf3HVGk7xAo/IYfINmwz7ZtV3Adr+u
	HjNNS2udopr97hTG1xZcaoYzp7+I/XZ0CM56ZurzLz7XNGTHJPAhYosom21qYV61ISqsRccsOKk
	twlYMY5eQZi7L8z/jy1yTOLxkyx7GpxE=
X-Gm-Gg: ASbGnctsAcFdDjGdSs6Ld7tkzMCLvbShHYocwbCr/+ye1uLDc8nQ1UrYzwiQ6SEtms2
	GGiVyN7D6gjYfbdVxgEr9iToHcXAo/z92u9b0ltq47bsnBHpDe5BS3RPrUe6n1LRhUR4ZL9aK9T
	bP5+FwtwsGO1hDkhYwEJTtTQRyZQH2jpsQNoGd1YOCIgBHYI81aFKVJSRXJF6sk6eWigrCdbe2g
	Q0IU1DgRYCc9zLYlck=
X-Google-Smtp-Source: AGHT+IH7ZrHfHbLLunJzGQnd+7V8aAGCCrwSF9rAwjLCxNo016vm5ojdGhfbqWoKRnWTdq967efigtKxEeAdrBl1GUc=
X-Received: by 2002:a17:90b:4b8b:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-31c9e798695mr8100148a91.7.1752942006984; Sat, 19 Jul 2025
 09:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
 <20250717-topics-tyr-platform_iomem-v15-3-beca780b77e3@collabora.com> <DBG25OQZJ18V.1W13FEOPX8MOH@kernel.org>
In-Reply-To: <DBG25OQZJ18V.1W13FEOPX8MOH@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Jul 2025 18:19:53 +0200
X-Gm-Features: Ac12FXzXLDPJb7QVWF8myN1mLqF3DuG9a2WLxJrOEZ7ywru3nAwYzSQXsbfjDLg
Message-ID: <CANiq72=LAaQuii3O_+Pa+wYSXyd_Joi8aecNGVqn5fww8PbZ7Q@mail.gmail.com>
Subject: Re: [PATCH v15 3/3] rust: platform: add resource accessors
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 3:15=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> @Miguel: What's the preferred way dealing with this? I assume we just wan=
t to
> ignore this warning for the affected compiler versions?

Yeah, we had this in the past -- when I introduced the lint, I just
went with putting in the middle, e.g. in `rust/kernel/sync/lock.rs`'s
`do_unlocked`.

It has been fairly confusing, because long ago AFAIU it was not
intended to be supported, but then they introduced a config option for
it, and then it was made the default, but there were false positives.

It seems it has been finally fixed in
https://github.com/rust-lang/rust-clippy/pull/13888 for Rust 1.87.0.

I would say just put it in the middle. The only advantage of using an
`allow` would be using the "reason" field to say we can move it >=3D
1.87, but if we really want to move it, we can always use a normal
comment to say so instead.

Cheers,
Miguel

