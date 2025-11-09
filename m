Return-Path: <linux-kernel+bounces-891878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFEC43B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B673AA8D1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A612D876C;
	Sun,  9 Nov 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIOTaenL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D022A4F4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681692; cv=none; b=STJXLUJPbU8P3UdeqAgg+3wTq9EE50iYTsedmjyUXX0Zv/uXSqB1ajietU/7hoelPcpX6ExcuCCP/tlKgmrItHrQQ+ly2ip3zVfhVu9ZhblxSbhOO5v84A6QwEzXOaT2ZTDscKLjhQnNpkGZRqqXZb0wREw0bYFjpQVuQdnJuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681692; c=relaxed/simple;
	bh=7UbbWu4YJEt2N5oFO0yvfHfoZZvWupJp9/gMRHzUkU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scvXvJI1sbamifwodFJgg3GNoLRROq49f3lP5c0NdSd3KCC1rgxIGVayKtQJIdy6OMq/5j8K1fI9HLI3fg7zyVMtUUyl7sJslPkbK/WjKsw1s6dN9J1LDTczn8L30lmaQ/c+NGh6fwVlL5KBiXcdN1h3iq+Yq37RMKpOaUxsomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIOTaenL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340bb45e37cso327846a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762681690; x=1763286490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UbbWu4YJEt2N5oFO0yvfHfoZZvWupJp9/gMRHzUkU4=;
        b=HIOTaenLfun9mvmLYJWA8wP8Uu0mjVwtY2hF3KT5qdzQAXjl3J/3zKVS1WRWkth4W8
         uo3UgRK9ij2ADaMNy0vEAf5y3xMUFqu8hFk3jU7mnNH3FPQoTVyMthBOHOt6TGVXbl8Z
         7yl4QBS2vq0nerwW0ygB7FqBM52h4N14OEHzXctUVvkNJnSm5Z+FRJ4sAL/nU0zz5o1F
         Rehzm5XHqZCcpZebDgsHTwTmMd30QWJGUDe5gaX5IW3j28XcCfVBiYg6GB597fw9/UhV
         eoIBWm0Ww+VgLED2c9ZfI5w299Jh4bijaRpqN54D/q4v4bbOMDXCJRFZSlghe45CnXQf
         7NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762681690; x=1763286490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7UbbWu4YJEt2N5oFO0yvfHfoZZvWupJp9/gMRHzUkU4=;
        b=hlClavKzqntSRerluXmj8GfkbfN5+v4ue3uehPb7F5ZRwMbaws/aFvCXG6Ak2IYbF1
         uLlzuHTTQfQOQeo0L6qekxRPacmyO33ITmc5JXbX5om8RLXT1zkLLqoiBzRo/5IAxlQC
         KOBtTkEDaJVZw1tKMe0vqAKZbV2B8Gv0XitJAzon4QN613/AQK8Yn+z9FidMQvxfqqPy
         ViuX4n3cVb7M0BDlyXH2OGsbglWbl7yFYbEGP8ze23DO7fb5TYiu9z5t6hafQLifr3Uy
         IK3iXFnOtvvA+CruKkZR8KEIYFqs08+ZW9tXOnzirjY9BwW7IiR1/0ZBPmIk34GzmM9m
         Bz3g==
X-Forwarded-Encrypted: i=1; AJvYcCUeA9ueFaYvdXrTGQDafhp4vV+ZwCB7kTteLAbwR+f8u2Dgc1NjeZsoQMJxEqZnb87Idlmc5kmmX8vA6Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aXeH7jf78e67r1U5UaNCpIOwc8e1GAJ8P8O4wABbA1zKTu3f
	pc5J95D/3Gnp0bzfmNV/bJN0XyK4tIDVCorbb7XVaD0xpgLp8Ui/JOtm/oxR2jo3OxaCICrnlVn
	4/yLce4BrYctpOe6eMu2Kw4vMnn24nRQ=
X-Gm-Gg: ASbGncttTCO8RPmxwWRnli6jM3Zxjj2qaxE7yyOOUlHcXAqb6gHMoZdFTF+3fkhBfD4
	I2hT/UmQvb5Ue0q/mZbYNsJ3M/cC8oxlp/B8Dx9TOFv/UnLzjTpENBYKmNo3duhrnWTqAGhGtA9
	K5Ju80n9oSul1HxebvX9OeeMbqDoqD58yGEmrs3NE/+BKtoQAWBB8k/MQJCWi5xdpEkEzbZQVbW
	hjhkMBqZVYN3kuRy2p/SAFuVnfaHGAKh9Tnh6+A5+5H0OsoVXJ46yvs9iE8XGrk/wliB1gK/rZU
	hsp+Adv16ltIJHDUBDnUMqVIFma64VquvMXIQ1/SpAyA99XIZd59BvW9VgIuXMBwveg9XOWDenS
	kGlE=
X-Google-Smtp-Source: AGHT+IHJ3X970Fz+WZG6aqfSKGTdXxfzPaNAG0irWW2OKqnIbo7IoDwLMSbVP8viSAFnVGTRp05nHQrCuUons0eLXmA=
X-Received: by 2002:a17:902:ea09:b0:295:511d:534 with SMTP id
 d9443c01a7336-297e5731561mr32609445ad.10.1762681690341; Sun, 09 Nov 2025
 01:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108043945.571266-1-jhubbard@nvidia.com> <20251108043945.571266-2-jhubbard@nvidia.com>
 <673640f6b26617bc5e1f4962bc2f9f7257346efb.camel@nvidia.com>
 <46c4877e-2af3-440b-b8c5-fa9078a5cf9c@nvidia.com> <DE3AAYKKI0HN.2QTWD76BN3LMO@nvidia.com>
In-Reply-To: <DE3AAYKKI0HN.2QTWD76BN3LMO@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Nov 2025 10:47:58 +0100
X-Gm-Features: AWmQ_blUxjf3ArTwjKKrEFU9NX1RDrwQAlazu89gcX-vqWpEmM0esqgYqA4hVRU
Message-ID: <CANiq72k3gkVnkW4_A47FzAD8CwYLHj3qDUhNsT27P71=XppRdA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] gpu: nova-core: implement Display for Spec
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	"dakr@kernel.org" <dakr@kernel.org>, "lossin@kernel.org" <lossin@kernel.org>, 
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"aliceryhl@google.com" <aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, 
	"ojeda@kernel.org" <ojeda@kernel.org>, "tmgross@umich.edu" <tmgross@umich.edu>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, Edwin Peer <epeer@nvidia.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "gary@garyguo.net" <gary@garyguo.net>, 
	Alistair Popple <apopple@nvidia.com>, Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:42=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> I think this is the correct way to do; `Spec` should be the one to
> decide how it is displayed, and from a maintainability perspective this
> ensures that other sites that will want to print a `Spec` in the future
> will reuse this implementation, instead of either rewriting one
> themselves or having to figure out that there was already an existing
> site and factor it out.
>
> Iow, this code is proactively doing the right thing.

Yes, please, avoid hardcoding inlined display code.

Cheers,
Miguel

