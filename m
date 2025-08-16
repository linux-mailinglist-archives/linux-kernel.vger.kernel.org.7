Return-Path: <linux-kernel+bounces-772016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0955B28DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3D7B610B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2902E36F6;
	Sat, 16 Aug 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+7isR9q"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481ED23ABA8;
	Sat, 16 Aug 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348169; cv=none; b=fYXJQ8t6DHuOrNg66Avs4P8h40xX6PFK08XagpPyr9vjPyzstLEdWOMjJiqJqf40Ld4+2LJd5I/9XPcPJrZFqrlzmMLTLxGC2N8G/OpXOX3au5JDeO08dovck4lvcyfHX3+LC49a+XG3I7RgDuCm3CbsQq93baHcspMKyhwqW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348169; c=relaxed/simple;
	bh=r/5SKdB+89UiON2D9Ym7suFSZvCdbGblSLmzLXDSiKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQHG2AcCMwfhkSAs5YrRMgDsaZ0LnUKct5qah3je7+B09Th6JaEccjzUE3rGikxzw3iACXNiskmdvu1AHY+rJg8vLw/57OmlsA6WBTEv7YxSMs0JGy93JyuHa2A/NlHVXnWTh67AmH5vN/M/JnMms0M7XYDrt4vxblP9vQmmuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+7isR9q; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47175fc02fso212477a12.3;
        Sat, 16 Aug 2025 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755348167; x=1755952967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/5SKdB+89UiON2D9Ym7suFSZvCdbGblSLmzLXDSiKE=;
        b=H+7isR9qELMfWWMrn7L/LmsLWZ/DGt2beqdtc8z9KHKxJwEq/L14IMx12i01e2Ft1K
         RuC33SHwsIP1YSxhGKmnQdpyDS1qx+jAYKx04jT4xrsEj3kH84Kbx6bAZJjsYfCRCt+i
         KD/26asRF84kpvTbvbK3Iov9AWfVYzisbhPYvf67mT63f+8ub/ty+9PTJkGY7WpGVXJK
         02xB6V/Lr2HU8wuyUJTkGtB5YvThMEjiMWwNoOjcxTrQMXpwrd+1fkP5loyYWavV8QDH
         UhuQ/gg98EM3hwvS/HLcrV/K9Re9rGnHOzTrT5KMhof+CB2arV4hOsDOn2zPrlyUr2Ih
         1IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348167; x=1755952967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/5SKdB+89UiON2D9Ym7suFSZvCdbGblSLmzLXDSiKE=;
        b=BPWbfnTPKlAlYwfJMC0PUpk3rRGbElUp/nfx4btB/0dUWoz6rwRSLcz1FToDo6XxLq
         rxpiTSVZtbLkiuJh7wu3zlqmgCfJqax5PIOdCt9xLzAMeW1zaMQEfdNz2vs5tYqDLaF4
         jC9RyQ8GzrTg58ezEz1Ma7yhcI4x5T0XT5cChpqIAcbM/iY0LLzh5hMZMhdgC7tY5t8o
         xsvVe4eNppxHcjFQbCcXaCd/4kqTiNQL0dvJe63JtduDj8lcgx5dxvEAT50iZ2859slZ
         dxQ2A8WM67LM1Jk+p/YAvXlQdPbUwnaTEjJ8/ocplwcyP9t69/W9HpgfNqkxwpkH0G0h
         RT/g==
X-Forwarded-Encrypted: i=1; AJvYcCVG6CueqKUaCI+8VgidbUtA9ZYM4EJxwk7BvqYMI5lp/x8DTnNZwgHrnulN0NFCLQujroewAN+4drvm@vger.kernel.org, AJvYcCXqsKBFoVbU778prBwRcCWaVKhEgaZtlD6IWjLaKZJGFdl4AnauC17L5YTLHkRi00yxf8RqfNsqIhcEz4/fvH0=@vger.kernel.org, AJvYcCXuJThnsOLIqFji5nlnw0tLlUf5eEVuXSxvmx7NLBdEQPYsedGD0lNa/hhl/BHv0fzwZ/J+3c3hq4levtfG@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPuPaO1/P5vK3P0idoVnQYX0aNpYp+3ddXmZ2HTUCVN+E4bSR
	AhbAB7QGmxbTBGw4oTNRu4/mrXQAmKrMu2acsT+YPAejPZDJMqeZaNdBDucWxviRC4R5gw45K3Y
	EjmZ0wBtTVR1wkXpcic2YVGqIojZ+vSI=
X-Gm-Gg: ASbGnctRf7GaVYnC3a18W48Q2cqGldmM2PARbQVKgFkotXrjxf1qOZuBCGrx9YUQxH5
	r3KfRAxidIaQf41kQk1rwjVGvr/9SXdOk66v9UAQwzq2atMor8PJ+MgRG+tXi3s0ulPWQuBEZXY
	phf0z/7nSbHhb7H+V5gDiVhF1LsKKsjCLc5ByoGGPGoGPAjJc4PYojVBYri3WNNGrHjTb/EVkJ1
	06JPMrTIj8eynAz3LQHmxfJ5YxO
X-Google-Smtp-Source: AGHT+IGovhTP2U7ztW1bWLFAefQYPDOSzbOpM9VBaVzcXcCvzG66sqPV6GyRR7iQuZ/F4UNNjLvMyeBHyPJ87ccq31A=
X-Received: by 2002:a17:903:11c8:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-2446da155e8mr37204245ad.11.1755348167400; Sat, 16 Aug 2025
 05:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816-rust-overlay-abs-v2-0-48a2c8921df2@beagleboard.org>
In-Reply-To: <20250816-rust-overlay-abs-v2-0-48a2c8921df2@beagleboard.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Aug 2025 14:42:35 +0200
X-Gm-Features: Ac12FXz-EXdaXGsWL4T6sgibxvJlg5WSIxqJtbGeuAIXYn9GKBFHeAa0oBFwp9o
Message-ID: <CANiq72=fQbr0jO_83zsaf13nPvfm8z2HxjxcKPft5MLos+3G2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: Add abstractions for applying devicetree overlays
To: Ayush Singh <ayush@beagleboard.org>
Cc: Jason Kridner <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>, 
	Robert Nelson <robertcnelson@beagleboard.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Dhruva Gole <d-gole@ti.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Benno Lossin <lossin@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 7:58=E2=80=AFAM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> The kernel header currently seems to provide blank implementations of
> these methods when `CONFIG_OF_OVERLAY` is not enabled. But I am not sure
> what is rust-for-linux policy here.

In general, if a kernel feature/API has stubs that do nothing when not
configured, i.e. the API is always present (typically to simplify
callers), then it is likely the Rust side should also be available
unconditionally for similar reasons. We had a similar discussion
around debugfs recently.

Cheers,
Miguel

