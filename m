Return-Path: <linux-kernel+bounces-737940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF8B0B23D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBE2189BD05
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2DC237164;
	Sat, 19 Jul 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSey/gRR"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254A1C3BEB;
	Sat, 19 Jul 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752963451; cv=none; b=J63bNFmUXMSev/S/IzGIaxbu9wYJdU1teccE8wFd+q10aKTHgvEsxBXs6hZXmCNi5kaOOCnZ+Feh8KYlyS9VFymdfDNpjpE3gNTSfpwj2LCeox/jmjst0/6YfuFQABBdPBqwnzUBEBGydH3tcfIKK5Ud8+2p2VliWtcETonqKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752963451; c=relaxed/simple;
	bh=dG/Q49L9r2Wo7puvT5MsPmP2NWTrHo0JwBlv5w1Y1Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpeC4+60Ivo+OavN8LsZtP+btc5oESV7s4TTUC8c4mMXSERHOXLHhQY6kxJu0sIh0rzBuY85gmpgxlibo6dXZt9h3sfX1sbf9aLYhNtsmZ7oFMtG2rO/ufIXfSChxUFVCbHJ0uNZMDETuhPDedUpMp9MiJI1Nb97ARsK6fghxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSey/gRR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-312f53d0609so675938a91.1;
        Sat, 19 Jul 2025 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752963449; x=1753568249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7hZEVhTHQ57sSInGr5CcBA/UAl9qyK4TrqHgyReOe4=;
        b=MSey/gRR33dGIX+4MF2fihEFoU3Pf1b7Eq0h2k9dkXHJskjY1fH9Hw1UaTw3GoKH/I
         ZYy+IZP6TQUKm+f9YLzusj/rea/8qhlPiADeygF6mgMggvnAJUg3AbVmYC3SfOC2uPwL
         ChVp+8He6VnzbSsHJUID/Mb52y93RCxz99QXlZ1YBM8iRdaA613EqZP3dz7Gsl317Qdl
         kf8hc2Enxy7SyUy22zu3qtoCi8pvzPQPwbvqynrviBUX+dwpiF4y+rpPKRBuW7hi7A4X
         aaq+6JhfwBEqxYDvJlxtZ168BraxpuAVCe/Oyg5xuHI0ZRYgowXSvUrJ0DnHOLX4KKm2
         3nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752963449; x=1753568249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7hZEVhTHQ57sSInGr5CcBA/UAl9qyK4TrqHgyReOe4=;
        b=E76wy2EGVQX107HJdoyXqLXAQHTep4ey8TNAJwXbdEUNmgf8nki2++ZrZ1ubK6BX1d
         jO5awv6TaMfC3pPRjQKOhqCAkR73g4gZmteCDY94El0oMMoepd87k/z0ro8+4a3+RQpH
         w/CJcWp3UQMj7ubsolR8CBrX3zZHIhwXO7SHf6LUB2wnxZIryuJLvBWlNjv39C/H3btD
         7t3IU3xjUL1h2Xg2MQKPpZAX6PNTHI4tusptAsE2hU8Nc3Rd384Lo+EQHC1mv1aFsre5
         yT6BAkSFhBz0zOrWbJ9ms87t3w8dChebXU5v75iZaR70OUdLWbbD0R/5xZFR0/CdroX2
         bzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFlHqOvM3Z6g5RdEWgy1ZKG7YfWUBETtfupqk0Ph5IpRG3BTSmCz2D8nBf4++F+zvGcnED2Wky0w44DN1JZSQ=@vger.kernel.org, AJvYcCXkn7zmk/SE/tDgEBWDZwsXHlYbq4kkagq+OX5N7FkjS52TvQchl0/1ueFsFXihrLX96XJidi7GhwFvAf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFbbYQmi/KFU1I3lotXqc6nKVR19KEbtgaI+Aj/fRvXateOA5
	klIAuz9tfSBgR5iALIZaIvL3XgrC66HfBUzVuH9chiOyRWfCBPRcYs47zsoLI0Yg1OJi9WleqvV
	wOcE19zgZuIEw5jrWtEhrZzUk5PV3g04=
X-Gm-Gg: ASbGncupAPKvEsL2wtHTpytzDRqJaFhAFjeKBtSJaVR5a6hCFOx4ranRG8hmjX44jQw
	IRlsNKiDkbI4bwkgkgUJFX08oFBWp9+hRllBwNItQ3jSeP6IYFm4RoKrUng6rV6YZkwvo2OvI6b
	QG3Vu/XALEFKjRCFp5IQZXxRYlLXCjVIB8RQmAZHpWRcgdZnxErrPpB7YCpa9BE1VaGMijZYnYv
	c1xABl8
X-Google-Smtp-Source: AGHT+IHhOknouiKI6/3BW3p7G7Zlz2QYHldvTe/w7MT6ovN3W1pbogStNoHbazw66+baPmNqhzER2zXzaaW0NDB147Q=
X-Received: by 2002:a17:90b:55cb:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-31c9e7a4b17mr8974894a91.8.1752963449073; Sat, 19 Jul 2025
 15:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
In-Reply-To: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 00:17:16 +0200
X-Gm-Features: Ac12FXy3QsylAsRqKuVWnrAEVZcuV5f6BaucvgqUaHuh-yNZGkGmjHrB97x_2dA
Message-ID: <CANiq72=FVpt2AgvXifUGqsC_sxyLEFbGzC-NPa2uDLkoU6t1Yg@mail.gmail.com>
Subject: Re: [PATCH v9] rust: kernel: add support for bits/genmask macros
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:30=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> In light of bindgen being unable to generate bindings for macros, and
> owing to the widespread use of these macros in drivers, manually define
> the bit and genmask C macros in Rust.
>
> The *_checked version of the functions provide runtime checking while
> the const version performs compile-time assertions on the arguments via
> the build_assert!() macro.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Applied to `rust-next` -- thanks everyone!

    [ `expect`ed Clippy warning in doctests, hid single `use`, grouped
      examples. Reworded title. - Miguel ]

Cheers,
Miguel

