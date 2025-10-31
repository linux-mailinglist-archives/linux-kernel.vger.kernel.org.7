Return-Path: <linux-kernel+bounces-880251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F0C25391
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B0A3B3588
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54696322A1D;
	Fri, 31 Oct 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/emK1o9"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5B20FAA4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916727; cv=none; b=exHugvT8NtQowFyPpqHbSpObkCCPvDlt8nLGDygYd9V+7bRmgGcVsYlRpB+bpdU8OMpV3lfJvLKpRYVQwyXsB82LefDinOobIQUQNMLzmBu/KOfGJTsEoH3a/yLSENTodaMMGEXnyRpBCroAb6ma+9td1ctLBxVl2DYnMAjeP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916727; c=relaxed/simple;
	bh=hwPwg21PUNDY7bWS1a5ZPuPQ7556dJiTKUQ/Cmgyxw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOlA7hSHg0L5QpP5Ise3DDempMekv8tOE8CFLigYLv+99x2LHGOYh75V8JMUk55uIrwyxPHLA8elmk8BZEqSwiV34q5QmmVy8X4FK9psHZzAXK195SQY7z76tHA0PAcyNicvvWDqiXCWY1XeDfezuaEWPeVP21R9pzHyMDn8Vg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/emK1o9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6d0294865eso49461a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916726; x=1762521526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwPwg21PUNDY7bWS1a5ZPuPQ7556dJiTKUQ/Cmgyxw0=;
        b=Q/emK1o9WweUKP/TM0qnDGBni2rJZHQZAp0oWvw1UfE1vFfICbOMC7CNzNuj2OPwXf
         eDc7fXGb0fUGWFWhr+qY1PvacuFs8uAmaqVaFztMiJwKaCOO71Gew+NJKrocVJ42YwL0
         k8iAMw3VSMxt0qsULEAmRrjraycqOUHZX+k/7CjOad2SH+HH3p6rUfScc/Hsl+QALrBL
         dbcV5kFINAPQ0lk6Gz95M01d1NHyCbjZuWXvu8d6gRtjIjPqiuNXzOz+Xqw3jTKBpL+V
         pQjcPzQZl1haXGQ9SGNvC0+zUYy3jrJojqPuPZLm1RLQcCN6caBqcDwlE0RZb2RNw618
         X8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916726; x=1762521526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwPwg21PUNDY7bWS1a5ZPuPQ7556dJiTKUQ/Cmgyxw0=;
        b=FHVmNpwJuqIE40ZwWS7lrWW8fMghqml2ukXFGW5npgU1bIjM1NIxjTaSFPGqTX/sx9
         DkDBTW0LWNMeNPNek/usIud9UoNwY/J7/znmDNb5LCB383HgCNCC5C+LP6q4yfWit99a
         OlouYrWOuKG31l5akYrE9TlHUVGN66wD6V/NyT4pr4V24sMZwz90Ec2sBXNa94J8tTsH
         Nhh6A/95uOaCD1aLQVFFv9LlDFYMrv/xeyW87XhvGopI1OlbV9QPX4FVuqTPIcrfJxzW
         g9dSQo7TrmKC2Uk7Umd0YHMIiyADjSmRRBrYc7NlqgblxaXlGnROugG8Us+PyePd6fvn
         CZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3XXNaBwhCgk6IZ7Ci2tIt5vt3xnS6Uu093EXjV8WsTxXEZOumWMyDl9rcHPINKd9+YvWHVoNQS6q2chI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwtkmnuq4vmTWL4xkRJGEsBoYr2VbQY23z8sX3BKrALxeB4m3
	dyGZtQ7w/GlUvu6B3zywb9Vb3CdSFQ2e8fnLBTWixfMoMTmlvJi6lKV31J/0MzBwKKedRKnS2cn
	eYTmbow80LPzPoP1i/LegMRZA1qvQcN0=
X-Gm-Gg: ASbGncsxS+Qng9v7q3mPTtIgDmzwdgju6vlPey3N6sBJ7BlECPjI7v/1d61EJz5qtzN
	zHMgVTxovIUxKyYIotcPxdzS9zu1sbmuGNUfBa+DrbqW39SRdl8HT5zXve6onQ/NY1uNRnR/tpb
	lcydIp1FssMGXdkkAuFZ9nX9Q5cYXe8dZ/rxeFonihdgQOLHBDNYezn8dFd1V/Q24IQFNzbTmJP
	k4TV4qQoGyxpTNNdjO8297sBQF54bFwlTYRPaycoHgR65fxKuqUTXA7YRyA9jFimctS+apoj19V
	yN7zP2u4mt1B3Mh4JjQ/WXajAGUptJ2S3B7Eqi59pzyzfU0Hmbzj/k+/05ahPaQaYXP8RKQv/do
	W796ZVltT+j9XlQ==
X-Google-Smtp-Source: AGHT+IEJ49gwJ5mRxtZtv0b41URKbZUBJLIt2VoQe30SlwO+FAYpwSB5aWCZX5jYTBZ0NgbiTYvlaN89VXh+FK/gXxA=
X-Received: by 2002:a17:902:f684:b0:294:ec58:1d23 with SMTP id
 d9443c01a7336-2951a3a3eecmr24614175ad.3.1761916725522; Fri, 31 Oct 2025
 06:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027200547.1038967-1-markus.probst@posteo.de>
 <DDVLMBC40199.2BVFYHDGQP4Q4@kernel.org> <cf50c6db2106a900f2b9b3e11e477617d8cbb04a.camel@posteo.de>
In-Reply-To: <cf50c6db2106a900f2b9b3e11e477617d8cbb04a.camel@posteo.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Oct 2025 14:18:33 +0100
X-Gm-Features: AWmQ_bmiIa3swbTRNRoyyzvdTz1VncSekR2-DDUNMdwP2E3BLG71zRyd1NoCFP4
Message-ID: <CANiq72nhhji-cz2T2Cg9y5AwUwcc9q1Hd=-6J=6TafaxcHZHeA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] rust: leds: add led classdev abstractions
To: Markus Probst <markus.probst@posteo.de>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:09=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> No there is no MAINTAINERS entry for it, therefore it will covered by
> the "RUST" entry in the file. I have added the led maintainers and the
> "linux-leds" mailing list to every patch sent regarding the led
> bindings and none of the maintainers have commented on it so far.

The global "RUST" entry is generally meant for core abstractions and
infrastructure. The best way forward is to get the C side maintainers
involved, since they are the experts on the subsystem.

Depending on what they want to do (e.g. they may want to maintain the
Rust side themselves, or they may be looking for a co-maintainer, or
they may not want Rust code for the time being, or they may prefer to
leave this to another entry, etc.), we can see what to do.

The first version was posted, I think, earlier this month (please
correct me if I am wrong), so let's give them one kernel cycle at
least to think about it.

Of course, it also depends on what you want to do. For instance, would
you be willing to maintain this code if the maintainers want to have a
"LED SUBSYSTEM [RUST]" subentry?

Thanks!

Cheers,
Miguel

