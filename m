Return-Path: <linux-kernel+bounces-730781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BCB049BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785874A7971
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12F24679C;
	Mon, 14 Jul 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmffT8M0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D222777F1;
	Mon, 14 Jul 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529680; cv=none; b=MzEfCqUzszZAJgbFvlYVVPaf7uXoAJF8XtkXf55tdogR9UZQvkUnkfGgBNyAi9HxxmrX8ZWBu6PwlBM7OaVMFcts92RDLm0KKTa7N62Am47to6Vm/W7AKqF7Wtux0A9KNd/XOWET9L+p+2/dQLV+klqvyF2RiH5W3sKsxYhHrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529680; c=relaxed/simple;
	bh=WKM1aStfHEjc3YEA6JYF/VBtXRtStKPA4i9K5XphWi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaKVYeOO3Gu49obtb2PQ6yFJlQj3oxc4kEuQpUvsb2jGdg18FueAk71/WoT8QFEcKB/NpY/cvCTpK3LH3+ucbgPGwNC74kFLFPt3skyRchVPTNw8Tn8UXDNJwYLEwxNU/3TvEskdO38Eg2OLk/Ojg00u0wIrTDUCdBhO/dcHm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmffT8M0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7493d4e0d01so188546b3a.1;
        Mon, 14 Jul 2025 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752529678; x=1753134478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKM1aStfHEjc3YEA6JYF/VBtXRtStKPA4i9K5XphWi0=;
        b=FmffT8M0Lu1Gc092+Kc/gBgTODx1QTQO6DeouNsjY4pi6p8B8VmYhKvPdJHZ0VXyO2
         uJnaUzglpsF5ZKfFLSH8yI1LSWJsLuawI6oalCuyfTkvYWcSHMTDpL88UwO7SQak+aK9
         B3kWTvAKKnyVhvRBTBkAul//C7kNlPDZC5ngr7qIiYdc4fAH8txrCPmNxdAyOLU5kEdu
         orNQacwiKbJHe2hLTGT6ZM8vixjWThzogxLgYk3kwRxOGh6xuWzxyITn3kOfXhuqzc0I
         58LhCV1s5b36F1DmS+hdR1MmZKc2C5FO2ylHZBZwEuVszI6Wfr9x8D9X5r8gGm4nKF1i
         6fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529678; x=1753134478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKM1aStfHEjc3YEA6JYF/VBtXRtStKPA4i9K5XphWi0=;
        b=s/68ZchR3gS2YobKyIUEHfY5m4xQgV0VKweM8xw8f3ANUl+vAC73GcLT5PbQZhojgC
         Wg/Pyipe6HFvKkCajnNVOeQzFp924ms69zWtErWOLo10bNAHahvHD3w1V1x6/VFbxHJ0
         q24rJZAI2TGvw7rw7U4gVIZ1ZXK+7xjtOUWcltup3TtTkZsesdoGrjqJVfMz5eWDS23j
         XIKMr9Ujnw9cADHcubwOSd2PvdsUdeVBIEG7p1TiyYXSil3JQ1vl9luh6oGEro4B4+eQ
         fRyzjlj1YNVyRRdsEW9mHBoijO81ycZ1vfjZmkKCpAIxCwJNodS1G5xXE/JAE0jxtpyt
         qqTA==
X-Forwarded-Encrypted: i=1; AJvYcCUxksu2J1MVPe+RXf6HJOOFnSSNADffrZAoXCsAk776QIn83KJtKnqfqNJ3vFOI1NGYXFrZ2WDCoq31CZo=@vger.kernel.org, AJvYcCWtCZNZ7OzCPNT76Pi9HC8Mkpb2+jnYvG3qg67mmSHezCTA8eZevCTozNBRWJG/1hDKc5g3XvzWZGXd5u9hRXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgcUDK5WmIRD8/MKcWB0lyj+HlglbY+rOfumSTeAKqpXcl0ib
	hWJjO18g0XqxX+fEEr9/yxSBcaNSRnXmaH2owiy8cWLrCqxoteRe//52efGXav7DeQVhn3APtBL
	uXLnV+e4Kq++xeLXRbiYmkuy10k3/Lhc=
X-Gm-Gg: ASbGncuGyqiQHjDwr12eOIVgt48LFUawxoT56Li0QB5K1ZDrxcUGxgtoxsk3sb7YZtu
	gQgLowlaM+5HRvHiN2gGQhsR0nGCgBFk89Y41MLJTWqX+Lz9eGcW2ruSJYEqixWzJG5J94inFWy
	5ebjOKsw7ZTARoiGaELf14T30FKjiHTATLKuLyhxfIbPSvFV9lICh1fVl1BT0BZLWPLcLT1l2rm
	cHFnnY8
X-Google-Smtp-Source: AGHT+IF6qFK9jJfSuS6UfYow20fPhd5Ta6sQiyzw3W/fibck8ROrxCHMK/fBoG4m6++ObGEZYagGL1WA8m5GRBSPhzY=
X-Received: by 2002:a17:90a:e7d0:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31c4cd1cd40mr7642269a91.7.1752529678063; Mon, 14 Jul 2025
 14:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com> <20250714-topics-tyr-regulator2-v8-2-c7ab3955d524@collabora.com>
In-Reply-To: <20250714-topics-tyr-regulator2-v8-2-c7ab3955d524@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 23:47:45 +0200
X-Gm-Features: Ac12FXxQ9k2LjwZThXlp4SFHTlVRRWXFwNx8PI5E-A-5a-u9bp_w_3EcblNcnnA
Message-ID: <CANiq72nhMe8XqtgT5myf+jPyyAdaGOJFqMxAen+miYhQFmDRCQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] MAINTAINERS: add regulator.rs to the regulator API entry
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:52=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Add this file to the regulator API entry as requested by Mark Brown.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Great, thanks Mark!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

