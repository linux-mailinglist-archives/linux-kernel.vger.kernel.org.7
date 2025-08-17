Return-Path: <linux-kernel+bounces-772574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F54B29453
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77982A2E80
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4422FFDEA;
	Sun, 17 Aug 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I40uVsDd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1331533D6;
	Sun, 17 Aug 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450225; cv=none; b=CmH5kqst6znUfWRgUGTP7IBdT5NvRPUUENyKnSJ+YdG6Wj9JuTLt3Kruwkp1m+vVFJsyL50TL97mCtDKKMNC95kN6Jm8tPVAiLZcJ3lcUwn5+hz+o3xiS1oTWHMUcaviUJ/93bfXZZ4DCQU0Doa7p2yXBDONMzPbhI7NlB4nfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450225; c=relaxed/simple;
	bh=Z4N7YBBSSZzNTU2zD/HGZfT/36C0b5v1Z5vHwSdAxmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFarHn4qysEFAKUypW7XxA3Bx8QFVbWFyGDoFwqh7tMmP/BG9OkASiVKEpDDEN/E9oGtxFsAo5eT/eS7YHQ8Qkr7C7+JJGTGWWSbrYcK0m9/H/ZMBnmWYIkabafC6PGEBKy9blds3Y4QsoDxY2P6vVrnYA8nxYP7K5+go4xpkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I40uVsDd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244581cd072so2915595ad.2;
        Sun, 17 Aug 2025 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755450223; x=1756055023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4N7YBBSSZzNTU2zD/HGZfT/36C0b5v1Z5vHwSdAxmg=;
        b=I40uVsDdVF5rfmYeHRXsG3lk79IdnVEpbR3WHvQ3rhrME5eOT+P/O+0EZGBQa/0Qc6
         t60ytExJTbX725DuDyob1Se0tsvBmFZEOXTvuQrsyfWv+fRy6AzUWLrMXiyOaoBhsNNY
         NbK/YXtRM8pqqPmrhoB0k6e4pG/5Or8HuNfKrcaoLE3KAXnYI9fn5DmaTozSfOPNgnow
         74EO8kqojaufNf+3TYS0+8zlS46rPgeLE+PY+q4kKmWFrYZjXgcnIF4OvqtPi8hyFAcj
         cHo9vq/7wterjuoQao1vNTpbqqisk4IJkEnU+1GxcIsnQ03vnBlmeUYaxdR9TQ+E6yXc
         f8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755450223; x=1756055023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4N7YBBSSZzNTU2zD/HGZfT/36C0b5v1Z5vHwSdAxmg=;
        b=ub+IOpu3Dl46PBFugSlFV9Db3Xhh2JRniamPvFNNhyP0/TboQvDr3bPXFZHPjenRWD
         dtm0ohIpfYN5e2k/k0v28MLdUlAcdPlfmxAVly126KT0kjioD+EOdeedWpyLAUw5+kQn
         duSxS3CDMlKnRFicPS99/cFmaAg9Dpjn6fMIfpj3FifCFBalMxALm8pFV7AQ6oL+qfyX
         NEsT1XdLLX4nVkSHWZYSrzj8uv8Om2JXmWUK7iUOP2tnyZPYzu2mR4K/0zA3UbAl4rtM
         LKOAy3XnuGxomsSU11P6Q/uvS4pMb4KytLQeIrPOsoLuNNvgCNTo/FqH4Y5HOLd95bMd
         TIKw==
X-Forwarded-Encrypted: i=1; AJvYcCV088Rxnqf6ueDz7NxOwZAGvcw2kiGrLGoCwEpUDe74fWIo6Vp3xxnwrU1CFI6LYOhyrVibIkij3TX9wbg=@vger.kernel.org, AJvYcCVUWp2kIwmL9wVn2QkdEnhoKi6EmjCrn5ARa07wyc+By9tTHoiDzVHJjCrNyLmEDQ6Ft4dgmbIUusZmVMoPVbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0Xjb+L7jvbzpBK49VekmzKYgmTJhXMmn7pNQs3YMq81gRn8B
	dovMpA/IVku22JsY5Kh0Gfwhc+ofTWIkPiPliKC67+qeIc+1bP8nQn2UaAN33O9CJwx4O2LIS9T
	5sG6YXthgxxCXIjEcX8c1hIbS6lnKbt8=
X-Gm-Gg: ASbGncs5bLTpLH0GmWIyxU6DBSHPuZDvz/P79aXDK1REdObOSeI7+k7QcT+NpTajdfG
	ICkILHGyUXW6MGSliHsKMw9xS9TWOwgAEAlUGq49VYcSH7nHPab5IErKPMysUGketpVxrREhv7Q
	hBonKuT6df77IK04yfqN3eDUk5h0wyhYch7Zmjle499CbRPR6yw1C3Xto00LtoXzSVCEo+DmVU+
	hYwAVPM
X-Google-Smtp-Source: AGHT+IFl+5E3gbiIXwNOLZ0ZIk7qldaCogEMXLZNAeNVsrRBmZHNmW+vv+tlRpUc1L8CpCng3OiKp/WTftzqec5IY0k=
X-Received: by 2002:a17:902:d4c1:b0:234:df51:d190 with SMTP id
 d9443c01a7336-2446d756119mr64088915ad.4.1755450223123; Sun, 17 Aug 2025
 10:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816122323.11657-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250816122323.11657-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 17 Aug 2025 19:03:31 +0200
X-Gm-Features: Ac12FXwOlEic4M18w1tw_6HpO5tbPUwKl3q-j4P_YB6oQ9WRk7qpXjv6HNo06e8
Message-ID: <CANiq72kwTfO7tgCtBgWLP9K2EO9eqXRMV3-UzeVRAG+1__O9Aw@mail.gmail.com>
Subject: Re: [PATCH] rust: pid_namespace: update AlwaysRefCounted imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 2:23=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update call sites in `pid_namespace.rs` to import
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to `sync`.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.

Cc'ing Christian.

Thanks!

Cheers,
Miguel

