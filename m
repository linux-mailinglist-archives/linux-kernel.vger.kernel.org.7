Return-Path: <linux-kernel+bounces-809911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A393B51367
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598D57B41AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73167315D4C;
	Wed, 10 Sep 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTduE3HG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E07219A7D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498473; cv=none; b=g5/Kh266LETGApk7CzWMPSpzYjNwlpgHu6aS5K9xt9WxoZZhZBwPzUO3AeRHCc4oyAS+q8ZZfAwg5MGRbciDme5TrUbNbthbq0r46Fh5ueTx4pWniPo2QcB9cJFXAkXzeR3HhkQ4fFmz1pSCjVPYBKtIeecKycSlbID5+YlEblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498473; c=relaxed/simple;
	bh=q4uYyjZeT3X1uLSrC3Wk71Cjszm5hRnmgp8XTdb5gD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc+Xf8UUEY/ViLDnCTCeBbQkxGksvU9gdMPDX4jDgwCq5m/d4Mn9hVasWFJOkZOYS444ERIwZb2bswm+QNPcJZCC5/6G/Djpr5UBjM3VLqZG8NUT2V9ypY+oQzSYFFlIKX0yz8NQ/M79UZK+or5truOs53jM9gK8Pd/Onpq5Lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTduE3HG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248e01cd834so14071745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757498471; x=1758103271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4uYyjZeT3X1uLSrC3Wk71Cjszm5hRnmgp8XTdb5gD4=;
        b=hTduE3HGI/jHNu9cosNZPFkC7ZbMAZU67riRIjP7/vA/tglJC0Wb5ceuyLBuxQZp3c
         h34Shy/XvS7qmL/8jAwu3Mtu5lllmDkbqhar89bE2hbIbHZ6hdNDEl7H0Amp6kuKter8
         LcX/zCxnwRMVIOnqJA5/iwLMmxYjgtNdA4UruqXQsvorgHy416IOZU2tEDFPCHCHg1Wu
         wIuRiT82wYUdkplxugrosbGMrntkDyozCv/Y8YMBVwS4/Ryk9F6ZsdBjXras+kEYNgd6
         asV7HR7D9fU9ubWRFwLyBL0VHPNWcmOZJN8c6KB/MLGfmInfQWkd9QyGlJ+OoQojSWfA
         3Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757498471; x=1758103271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4uYyjZeT3X1uLSrC3Wk71Cjszm5hRnmgp8XTdb5gD4=;
        b=n/WlmHl9jWCgZePhPedTbQj4+Nyeu14lrxt1cKAW9zsz8Y2DGLvy6JIVJxa2oIumAe
         Sx21IzyrSZ9XURrXwEtHn7MWAtZVNQ35BSrRj+/Vl/V+uq9HnNheAFBQ0i9xKiXwjNqA
         6zhb2REQvwcFcrRzSbOYGtj87bpuIv94Z/3B3wYRv1GBcSIXYXEWSyJ48frCdfYVyXiv
         NZvoxJ2Mg2OkyenJmDSYqzaLj/aDGmCwKD+38rihKDG20uW+tjKhWczfc76MOUUrXsUy
         IMDJNBMmQP46shZcMSag5msFI4p8K+Ef9f4YUisZg9RUQveoGe3l4QhDbF3gtxSR2a/f
         6oiA==
X-Forwarded-Encrypted: i=1; AJvYcCUKwUmxeNIPSsQyq169u9IMe98BMvOq5uLg1oDB1lpH5TRiX2rwHYSHoudXTTCRXdA69A4+5eZBUMwrbuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhcYcS10zAhc33nkVyh+sJuIPR6KzMPVMiKXXjfq9hH7h44rN
	cUpfqevirPZkxdgGQW0QTAsV5pqPL7Pb+B5JA4Ph/Y7/YAxU2tlczPa6O+bhLuwcKXGPI1XPizn
	Lt48+T5vmmBeTl/rWxai4nxMgZvKRR/Qfn4NKjlRnwg==
X-Gm-Gg: ASbGncsfxZ5jYDKistPRg20Hq0QiOV7BN0/LmcigWiIKjvgJbpwt9+A//Lpg5WHKjtH
	Ct/YefjLPRSgmfnJwkUNX10Chq207Jxu991wCAsv4vbOFkBbt+4n9Vg7Vvo7b2Uv1B3cO/X074j
	rkbj12g/H/D/T4iOVuYFYgTG1snEgDY8wsYlfbCLeSiaNYsF7A4W5p7tAE5+M8IPtAh3EXokMm7
	14NHZDFNtHURv+WrXKpJtEnR8uw0iZ3sEsTKDmb+gMvSqKO4y0rz64Jj36zEzSY5cWRK95g7V3w
	McMAt+fH1DYg08/yUh649jL5LL5GLatzXQad
X-Google-Smtp-Source: AGHT+IEAL6fPEIytHux98x5koSeZTz+GJXocZx4VGKO9evNP7NMBw73sdhCn/m6+6whVEQTC76oWfQxflZiVR9UaSxU=
X-Received: by 2002:a05:6a21:6da1:b0:246:d43a:3865 with SMTP id
 adf61e73a8af0-2533e950b02mr12197267637.1.1757498471364; Wed, 10 Sep 2025
 03:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <20250826-nova_firmware-v2-2-93566252fe3a@nvidia.com> <9adb92d4-6063-4032-bf76-f98dcfe2c824@nvidia.com>
 <DCD2VJ1WJW2O.VM7E4PD3DFYO@nvidia.com> <CANiq72=nGbziZCKt=AneE_vXw76i=+td0dSVfbOJ8kJ9eYHw9w@mail.gmail.com>
 <DCOVRI3TVJBN.3OGDSK8HW74LL@nvidia.com>
In-Reply-To: <DCOVRI3TVJBN.3OGDSK8HW74LL@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Sep 2025 12:00:59 +0200
X-Gm-Features: AS18NWB3P1o-FQ07s_jB_zwoyBitfxkjABJvrHdFdftaj751AhGxluVMI4T6kjw
Message-ID: <CANiq72n-q0vdzp=Tb=brue+BMoNYdCTKsqcMYUsvKgvu9ZqGoQ@mail.gmail.com>
Subject: Re: Implicit panics (was: [PATCH v2 2/8] gpu: nova-core: firmware:
 add support for common firmware header)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Alistair Popple <apopple@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:45=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> That would be nice, but also wouldn't cover all the cases where implicit
> panics can happen, like out-of-bounds slice accesses - we can't have a
> "report-and-continue" mode for these.

In principle, it could cover OOBs (even if it is a bad idea).

> But perception matters, and such crashes can be damaging to the reputatio=
n of the project.

Yes, we are well aware -- we have had it in our wish list for upstream
Rust for a long time.

We are tackling these things as we go -- e.g. we solved the `alloc`
panics and the ball on the report-and-continue mode for overflows
started moving.

Part of Rust for Linux is about making Rust the best language for
kernel development it can be, after all, and so far upstream Rust has
been quite helpful on giving us the features we need -- we meet with
them every two weeks, please join if you have time!

(Side note: the "safety" that Rust "sells" isn't really about avoiding
panics, although obviously it would be a nice feature to have.)

> Writing a uC topic proposal for Plumbers right now. :)

I see it there, thanks! I can briefly mention the topic in Kangrejos,
since we will have Rust representation, including from the language
team.

I don't think the discussion should focus much on "Do we need this?"
but rather more on "What exactly do we want? Would we be OK with a
local solution? Do we need/want a global one? Would we be OK with LSP?
Would we be OK with no panics after optimizations, e.g. a link time
check? Or do we want full support in the language for guaranteed
non-panicking functions? Do we need exceptional carve-outs on such
checking for particular language constructs?" and so on. And, of
course, "Who has time to write an RFC and implement an experiment
upstream if an approach is decided".

Getting data on "in practice, how much of an issue it is on the Rust
side" would help too -- those with actual users running Rust kernel
code probably can tell us something.

What I would personally expect to happen is that, over time, we
understand better what are the worst cases we must tackle.

Cheers,
Miguel

