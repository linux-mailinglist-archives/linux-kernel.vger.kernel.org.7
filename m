Return-Path: <linux-kernel+bounces-859838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B7BEEB98
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A28E3BD065
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E22EC54A;
	Sun, 19 Oct 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff+dH/WY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6FE2EB86E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760900377; cv=none; b=F48h5N2dt5kHG8WoEfntZdTXRd4vPl4kC7J/EFcpYcmcpXIUn6Hh9h/bnj/OB0PWHjG6CODXds7TOrWx7cuB18kADvxlBze6VL/nQrIQ5RbmF6wgIzSzIlHoOvMxL508+o7n+BRnjNJ9jMAemXNOOrrZphOfDJIL8xzWfxgpXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760900377; c=relaxed/simple;
	bh=nj/PwdyUHa3EdM3zA/zRNjpb3Mt3Z/MnFk71LgogL/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGljpsfKEl+MDSxjVdec7V0dP4mcOkytbfYDpNPTrf1LKSz156GHlHH6b9wU1pWOtrSY+mm9egLXcZadcePyNxnoIQy2FN7y19Giq/wwMeRjOOC9AmB14HT9qXfAP8iqjNguWL1jQj9PkGcLb79UpSXj769sC7G7nbHCc/laG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff+dH/WY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2699ef1b4e3so6136635ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760900375; x=1761505175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj/PwdyUHa3EdM3zA/zRNjpb3Mt3Z/MnFk71LgogL/Y=;
        b=Ff+dH/WYrF7SlOTBPXwcBru0i1f7ilZrA+ixLMb4+Go0yhP4lG5/0/cek+wndzCs3l
         gn10Ms4HRaNjJxvxDnHOXXRJSuCAHQ9wFaVvXYNv2l8IvFFoD1mRGUb8reQrhMGRqbQr
         2A9YI34DmaAUjsTviffyEcOguEMlkWK/9EBuKhFVMvYI1zivlDZ411v4Qmi1pMmLwoen
         8x1Lfldx15SCFxAU9W8rmZtA+JBzdns6VwTARMkvKaLkE/oGOHdsrCa++x/t7AH+4a/m
         IasM+KsCbVMSXQSi4DIn1CvaB2kLK7HFUM1QKslGAX6arGlz+mC8mhLy2atFhbC9TFn9
         bB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760900375; x=1761505175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj/PwdyUHa3EdM3zA/zRNjpb3Mt3Z/MnFk71LgogL/Y=;
        b=SBZDhhdY1qCBB4SBMihnCrNdUMWQZ+scUESzOQxHZ96NuTG0YKvZGMxtrM4q1/NC2b
         YdChg0IrcSKWm/Q+dNei5lhjn9cL+55HYMBQm/ocB9/syJg4RCs4i5ZDCN3ehZ00G9sj
         +jXCD5Y3T35mo1VRoBJBDCAstwWEUEaEEnDTgpGRabjfhDLV4Xdci1ZV9LUcML3ER6RK
         3gqwlKdEdCJ1GG5sCy9WCPm3d464VLz8ZqVe2KCxGFt3uoAJarpXgIx46vxA9gDZvZDO
         IZIVAgpMxau1T54e0cKmR59y+YcnfsabALeF4focWS9y2AWMJPTLfR/xu0wpVf/ezmmS
         3UeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUodCY86eNihoO+7L8aPFYtOHW9Z86wLS6K58/QktaLbJm6nNpYQzUmLJDQjVloljW0n0I+AlkwwkZBunM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqr0nVbqP7kEVDNJQn4Md/uh9K3WJ4nZCgO4+98kuVqNMQh7cc
	hCbxBzX97YpeABThLXjIJF8bsYaRfdUviBfiEyvz9vKoHGm/rXbo6yhPws53/axSsj5wd+V/h2S
	nWVKwYOAZjkyJg8FQy/neYKImtKI+Si4=
X-Gm-Gg: ASbGnct6an6n9M/yPnRoCs1TGJe7QtKdtImW4ZXs96wu1vF9Dh9R7EKQ6kDbbeBxEVr
	pQm3yLRICdIWb7P8gScjVbJKPvFY7QucHnDoJ9DY1hOf1tprzk8QEZpZ/K3rDPm0S9bRMcw/GVM
	RUuVMAO3MAjaoTlw4L3q/L3AdeEXewZnLrbMibD5muae9dIGNCSxV2fMck2H2DdBe8yw+cNXReo
	e8tfXia5DIslhhnBvVxC8MtilB2EbLWW3AbkmBVihcKOaPHvigsyrSQHiOmmh3giQIsz8T8yfNL
	JTYRpk+iqdUqn7Jt63uwfRiacvDTJyCMHyfsX1VRUaFZ1GM+FWc8FEIR2kKbYdmkXDCziCVG3YN
	ltjMjjWu+JZoFMA==
X-Google-Smtp-Source: AGHT+IFUNFNsgIHwngvFwlMG8aMEOLjZJdhe4E9fo3Ad+ao+mbyr4xKCUfGHRwuRI7LG09H3cfLrVwORSg5QxYsl3ks=
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-290ccaccc47mr69411885ad.11.1760900375198; Sun, 19 Oct 2025
 11:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016231350.1418501-1-ojeda@kernel.org> <2025101758-mystified-prideful-8016@gregkh>
In-Reply-To: <2025101758-mystified-prideful-8016@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 20:59:22 +0200
X-Gm-Features: AS18NWB0V0r9stVsy6SHvBBPktKhMWz1R1H5p861HWbvzNbwfaAR3voM0H57gac
Message-ID: <CANiq72nXw4+HesrgNqJjTy6Ji=pVqUMzx7GDO+6U9VYWezTt6Q@mail.gmail.com>
Subject: Re: [PATCH] rust: usb: fix formatting
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-usb@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:42=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I don't rebase my public trees, so I'll queue this up after your changes
> land.

They landed in mainline, so Linus' tree is again `rustfmt`-clean.

Thanks!

Cheers,
Miguel

