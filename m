Return-Path: <linux-kernel+bounces-886554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8DC35ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3179F4FA4C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999863254A8;
	Wed,  5 Nov 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqccyxyL"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C7299AB3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350579; cv=none; b=kVnhjfVqnaXl0JxjwJrQuX5x6YQLqM+1IyLQciHJ4AwBflWdRO8I7p/ivac7mv7mZ3dactFVsZTE59aFLYqNLFaZu4qbNhhrZ71XsvPvq7gupqzSY28gnVsfEmJL20KdGCupsWKBy3eTrEhF6STXjWegyYtlNY90VT8XzTCqDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350579; c=relaxed/simple;
	bh=oIm02qwQMUr3+CCU5508/rpGiaIngAIROsHPHbOPNLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W89n3L4wK3nF1qzjJuV8mnsHlSz9K2qrdOP/OC4XRLu1Rze72XqdDsEaj2GB2XDgjdHrgp3bbgZQYSmHf8vLf5bOOIOf8z/LTpkn1H/Ul6ntpghUhe8nh2mXTKRiATy2GMOVdKXvTDZsxQvY3tSlbl0lnxG+W4GaKjo2f86zd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqccyxyL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b997ae045b7so392939a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350577; x=1762955377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIm02qwQMUr3+CCU5508/rpGiaIngAIROsHPHbOPNLc=;
        b=jqccyxyLlkPLPbHtw/XfA+Uym8yLqm9tEmy2RbsIJDO9CCzg9TzcFpBPv03EZCxRGd
         WW3kVNg39rnr4JRSOUMqZgXh4+y7ke+2LLCHDLxMV1NGMn0TzbkqVi1NNHgBFvTsIf7p
         qLjLrb9Bgo6BVjb4DCZgBVHS99Fwo16LtgOlbLeBiRYJpZ49vodqaCZ+vNnlzeDVwP+a
         IDyzQ1AmpYLJUPjbhMz1SPDcbSUYlJmkyi1z9jJhUcupkBUtUEq9p9N1KrZUpYoPhzNr
         5CngbwdcKArUandkOh2JV2bNLrtrC90UysoOvJY5vkXArGC7zH+5OfsvS9xPKJYQ62wy
         CFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350577; x=1762955377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIm02qwQMUr3+CCU5508/rpGiaIngAIROsHPHbOPNLc=;
        b=AFHPpnGRCVc4h8Z2AKGx0r/gWP67lm3eVTA+U6VPXAD6hFmJ6NwiReuecxVVQNoPSz
         UZuXFK0qnYzyKiPvMb0oTscvDVE7RrCre9XwQWUNAUSr0zq1w/h7Ew2j5YVKnrKwRnJw
         80RxAGzo4+LCBKKABp8Qe9vCseFOws3NAATrrJZP4zOYR4zGRCrg8nNyEQQhvHbsiXJS
         ar3/fzd1qu54xuE6gGQrMyOJA8MLRSuoLFgYHfKi48F1Ns1Fv8tnSIhMuVM0E3X7BGVF
         lGzeVKLsYwKNfZBxy+8fWfjSbyI3KgNKb3o6xHJPGkd39MngeYl4MSWwntk4VZyxZWOE
         ZE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCldjKVndE+VOdf/rF/ouhqrPJJmKHRaUHHN0/hehuE91BERcVFX5Q+rEOxCEy6q2zLVqFhcLuhw6dEXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYCGOqG/qE5Twk+4N4Sgw2/qBh8TIY4bj0yuoND9B0loEYRTS
	e/ECj0e+dD1PLboMCDDjTyE1v8LxQbKj5JUeEWQf/aYW9WctiB1XmhlfPlwOi0a24E7qBUYkDXY
	ScoBu4mWf8pLaUMl13h6OhZqexJcdZJs=
X-Gm-Gg: ASbGncsh1ECke4skaNUoMUx3yU8iFoStLLcQ5BbWwHnwwhzLKh7ipFtVV/kOPDa55KX
	5ilPa4eJZBZP+vwLpdHgBzNdgBRw7WoTQH9Bw4mrdNUyGknZ0zPFVg6Dec3wESE0l4FtxtNdJZq
	gRRWH28om2X80lYmt810/edO/y5fm2p6yrplFSu3F+tNKchjWPBqJr81zcxaPBLlG+bkd+s7Uwq
	ICz8eowXVeoDike8laM/FXzaBh+Z2wXTn1QOdTzkcRRgEa1Ta+Nus6VcKzaXNPdiyWJPfGtxtFz
	tLrkOApeTK/2gz9X4DlkqCE0Z2gGnco7BzI/va4MrsQD/Cv8mjDsYHZPFM8CMCaPg3shyY7kYPk
	rqMc=
X-Google-Smtp-Source: AGHT+IGWLachPv11EWrLKE7rZGSMROlPAdaCj+6oHxMpOeQbc5pf72anPPI+Nftk3bVxhmwo0c7+rcHLAvKmUO+B4uU=
X-Received: by 2002:a17:902:daca:b0:290:c3a9:42b5 with SMTP id
 d9443c01a7336-2962adee35emr23599305ad.5.1762350577024; Wed, 05 Nov 2025
 05:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
 <CANiq72=WZJ5=UACpFLWCVJ7mcXbc93X9MyYAZP8-0F==2b0adw@mail.gmail.com>
 <8d865a46-82c8-428d-a371-407889eefb62@openatom.club> <CANiq72=OE3JNpemanR-r1efbgKqQrZCiQ7hY2-=_bvxLyJZ-HQ@mail.gmail.com>
 <282bd8d5-afde-4a96-b294-bbd7b69ce684@openatom.club>
In-Reply-To: <282bd8d5-afde-4a96-b294-bbd7b69ce684@openatom.club>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Nov 2025 14:49:23 +0100
X-Gm-Features: AWmQ_blkRqxnqjxsVLafgzdnmODrUxOguF_tNfS8UDpxdUVWCEiDo--qmwSmN-w
Message-ID: <CANiq72n=i8DM7uwhZCK8KZztsDJxwB8PEOpN1qrQtOFkG8aqUg@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
To: Chen Miao <chenmiao@openatom.club>
Cc: ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:46=E2=80=AFPM Chen Miao <chenmiao@openatom.club> w=
rote:
>
> Well, I will follow this rule and change the Signed-off-by to "Chen Miao"
> before the next push.

Yeah, the rules are a bit particular w.r.t. other projects, so it
takes a bit of time to get used to them -- no worries and thanks! :)

Cheers,
Miguel

