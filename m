Return-Path: <linux-kernel+bounces-834963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B2BA5EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06AF17DD06
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA402E0408;
	Sat, 27 Sep 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFQZxeZ4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE02DF6E6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975276; cv=none; b=eOVD1sT4rqve+7Th/llwJ4N0FdCHx6IH78V2X/QPiaNZcn3RxctK1AqYxOsvamYYjIi1luGsrKElsBp+Uk37NKuCtXbOqdtZowsJ3BoTtRCdSswxt5S916NwLdciK14+hOGg0Uay5D15QQLzaK3TM/2tV/rDaEhpt44ZVSyj7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975276; c=relaxed/simple;
	bh=cQ/vViuV5kkPC8N6xSHm2TBoNeswpTWYDcjW2WZz3iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzpZdGNFZItJa/UcUkdwmyCmPPgu5d3VMwiJJUuE5HF5KotmGSeV+JNgt/2wcfeeBXg/OptLnGPri4w/apqMnAv1cRLV04/DfgdVIBHsJ7jb09lvngsUzIMBbXdLvlvtIFTLHx+Zpw8TpzMMXBM5qqWm0Q05fEvzCpI6g0o6b/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFQZxeZ4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eda3a38ceso6346145ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758975274; x=1759580074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/vViuV5kkPC8N6xSHm2TBoNeswpTWYDcjW2WZz3iw=;
        b=TFQZxeZ4uOCEM8UibUQWNPACJ9P5ukHSppEoujhdZnKDqlcFVNSN4vFPVMYEAzgJXg
         izt8EAG2uKETaBkQtv6jxxJFxiv+JO+2X/ZKTTvxD+opvXQUFXkVAx7SKedDc0WgMmrK
         bOsFrt2NLTdLQ262lIMJ7XL5E9ozW4p1vn4nxjl4jX9nmBU8oX63DESNtU8WSBpp5dxc
         dZf4g1tCozA5EoZV2KSHthhVQMLRJaWK5yLTxlOO5LKwoSZNQrVZlmR0IGTOLTY/D4ad
         BQviRptzQU08vrYVb99x84QLaEZJagvhdC3EeCjbPoaNU9B+EJfnGYy1IVPkilO5nOPl
         Wh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975274; x=1759580074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ/vViuV5kkPC8N6xSHm2TBoNeswpTWYDcjW2WZz3iw=;
        b=rfA+ILdeLvmKrMNxxrpItm76kote4L3QsviYK7IDRTnE2WUk56AZxPxVWS21lT5q9S
         8n9YsoavRBl2j7ihELL59z51/m6xnUt4qjuIt4BLQoCE5kWYuHCpceS1sprbmDSex0T8
         CcHUo5NFFgMzDCyOKzdlupmq6N5AWfKI5R7USDdJqS8Vcp2opi2V3oaMeC78c2ep9NOH
         73DzE3fY6q1sYir2UnCcXBtWDh9ngqRM9OWAMQRHyCE/QT+NhdOwNIrkwJ/HUYI31sSJ
         hDerztXZ4qX0aalfio5jAKtAv55+Ua5+snIVoz2KM947ax0TU4lF2QokN+e6eySDyUuh
         c5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV13BkQejzvun80w/pBa1syX/+R16bynTfs29o/hotjKPsj2/ytT5hkukSR0ASFN/CK2p44nI474WViw9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykvP1y7IyHTescEnsZhi+y7U4Ey01jipcSFiseotuVnVpbHAaj
	BTDaArpH6WASbFhaO2+iDlDC88hwhRwOhFB2Njj8CDd6k+edjUvMfmVeshB9ql6dqt3iZ9TcA8N
	YG4gS0p5CHAt0xT9Tca2yNutaqoi5G2Q=
X-Gm-Gg: ASbGncv1+WCDKYZCTxDyGkfasiteJ1D5GTscs3b27J0csAkMcIbpPQrTir0YRmqELwk
	Z6HYXacml/1blyiTzc/UTdIf5RrsLcEXkDZVl3xpfUPW+yYadVeqlmixVcn+D3spAvNi/DC86Ig
	f5NinF/FgYOXqHm6awTGjtbU5ZBVSasjNV2uQ860oTOVYA4UAt8gPocA1tkrEP4qnffENk2M/nC
	fZ3DL7oQhs284Ew6s0lAE8bdKzxTIKzdSs6WgQLAEXHBsUdX1BGDFNDhJ2enGGk7LYKY8ExMhPC
	yNybsxnSJMiXapaDW7Wik2E3RotLWMIETjuW
X-Google-Smtp-Source: AGHT+IHZjp/EfiazAV4KIr6CKQXQ4M+vN6ByhlopidH8GmTXvgth0071YPgESmpcClrC9cwMbzePH8Og+U45ZvhzRpU=
X-Received: by 2002:a17:902:db11:b0:25c:9c28:b425 with SMTP id
 d9443c01a7336-27ed4aca4a5mr73015705ad.11.1758975274365; Sat, 27 Sep 2025
 05:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918123100.124738-2-phasta@kernel.org> <aNa7BDpKS2KA__4M@tardis.local>
In-Reply-To: <aNa7BDpKS2KA__4M@tardis.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Sep 2025 14:14:22 +0200
X-Gm-Features: AS18NWCd0oDH3VKEokXgs76roViozK_Ajh78YilTwKiHy-TyrYWiBu0MM9gxng4
Message-ID: <CANiq72=6pGtKKr3XeZXLVrJTNMv7YbGzbezSUrZ7A43MJQLwJg@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Krishna Ketan Rai <prafulrai522@gmail.com>, 
	Lyude Paul <lyude@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 6:10=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Thoughts? Miguel, Greg, Danilo and Lyude, any idea or suggestion?

Either way sounds OK.

More generally, one thing to consider nowadays is whether we will want
something to eventually live in its own crate etc., but for this I
don't think it applies and being in the `kernel` crate is fine.

By the way, should Gustavo and -media be Cc'd?

Thanks!

Cheers,
Miguel

