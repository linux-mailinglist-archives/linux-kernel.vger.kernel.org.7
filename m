Return-Path: <linux-kernel+bounces-739128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC16B0C225
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6BC188EA56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A1291C0D;
	Mon, 21 Jul 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ou/Qu9ev"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5028B4F3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095983; cv=none; b=CPFZ0BZ0ZobKM2QSsBrLLMb0Hf3CMHKS3WasCR7BoJn2BwcsbeKRDOpGnsgX9zee7bZjHu+RuLlkeWOfUs737CFRWCsIr8tKLSe4crCXFO9VXoVvNYz3Tn2NNU1S83BJWBe/hRYwLByhMGqvL8qzUA8SqjH3UOcUwXEl8g1iBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095983; c=relaxed/simple;
	bh=s8DwLMaxGVgo8hNq/g2EUh6Icsw4FGGLvVorXWdS1CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O71DKlQp3lxOOgMWWm3WgyUpvvo/WUxXKYqU4EqwXAAOR5Wf54OJzAub7+viwtabuRPDah0ZSqiPVDaffdFGqMsztRCN6lMWhx2e8ttmkDyFsfcUEBxgVOL2W8RtXZVgmtQmnOPtsYe8kvIPqdlZ6UacAAF90Zq/CEfdGE1p+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ou/Qu9ev; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso2596159f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753095980; x=1753700780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8DwLMaxGVgo8hNq/g2EUh6Icsw4FGGLvVorXWdS1CQ=;
        b=Ou/Qu9evJZNnwRhAhGKg/O6dbr43J+SqZRtoFn9zA+ialI5TUyFi7RERzuP9HjLxI/
         HdtoFOMKCGsN87UU7dYCLjG3s/yUHx6VdFWmB3+qXf/yTeXvhRAhodBR+C+CzYzrnwjc
         PB/lwjFjl7uqXlQunuQ/32/Fa3XpZfJeL83jBs1u6rGMbgeBg4Q8BIJmOa62HipNRMqe
         tvp0E82CPYtKH24bKrERG5vKwpDPw01ikFlar8htBOuihInJXSMNvZMG2/T+WsOiGPR3
         uxJj58ssZvbOD7e6cx9+6LJqEFDME6PZE1y2xVRKb2yCD4YZVgUUx/rVFgBIghd4B5Ew
         e09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095980; x=1753700780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8DwLMaxGVgo8hNq/g2EUh6Icsw4FGGLvVorXWdS1CQ=;
        b=fnqMiUJV1Qu8GDmowyTx0N/yLBSsEiTjzV3KG+pnWTOS0KvEdstWSm5ndy9SzgURHa
         cWQJVGQha54Ue4MkN6AQesvn/DuAv88NpgwCcLdDi7Za/a1YY98ZdaB/wt16NFmx5MyK
         SWmaBs48m1lurmaXkW4BG4PPVtiGOFFgCwwnDV2NIB41TwgfN+XDYiXUoy7yBS+/nRua
         GKygnq4+84kIlpkjn8vuWypoUFYxLGzswO558d/UN9aXuWAhtifdfnhYTOD1x0xqcGi3
         HXoydaKbdLMsDWVfHIX8Aw/xytd8kU8eW2RdPSF9mny8FWqfvOids+CAbik4qMoFWbuZ
         5Niw==
X-Forwarded-Encrypted: i=1; AJvYcCUbgALYBxz7Jw+VgACf/eYho05N1qPsJ0A7Aj/I65x8zu6MVBqV8LMss4FLBUcPc+TT3f9xrSXYSZVfWPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIgavl7RSnbrpj15Lbiw4LSvl7aTtmcYoxAsF2Usp0mt1ozfG
	RocjTrbF4MF9hrokePpR2dfwov35guHylbz+xozal9jSUOnnvEKasGcDgwtK2aOssBYC3JbZfWK
	0UpHFVdFi1FA2kReMxrAj2x+w423sKq07ZJ+ktofx
X-Gm-Gg: ASbGncvXNByHc8AWebCJLzjeJC89E91oB35QYA4X/Dx5SaPjfMlmRqYZsIX/CwLLshH
	zxG9ELdmtWrrbOk4eNOHNst64uUi98QnqTfc8Ll8hgpZss6Obw3F7pL9sASTH+Y7WYOrtHT5on4
	rVNeDybGrQIO0+0tceoG/yudLB3t9E0pAeUwJIVt2uA2FCZThop8zGnTdkuISjucWdqpMmIP7lf
	uYw2qNku/jmcFi9phLBp/FpCSrcltWkqRnj
X-Google-Smtp-Source: AGHT+IF1riY517jNsBWworq6HoIm32GAqoCMfQTdA2WL/azNRCOSh84I+OHSTSXC9ydWwvuBVz7iqeGv1Yh0IPi/6P4=
X-Received: by 2002:a05:6000:41ed:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3b613eab461mr12459180f8f.55.1753095979751; Mon, 21 Jul 2025
 04:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718142026.2232366-1-i@truongsinh.pro>
In-Reply-To: <20250718142026.2232366-1-i@truongsinh.pro>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 21 Jul 2025 13:06:06 +0200
X-Gm-Features: Ac12FXxH7sEDkUsQd6yCfdYvbgFR5hMpNbPBuNFYbo0S4ZhPZjZIN2YZsKV5KbM
Message-ID: <CAH5fLghFCSS7HB7JqucpAPrExdttvcOSNJwuZMFNXspu0=4G4w@mail.gmail.com>
Subject: Re: [PATCH] rust: Add #[must_use] to Lock::try_lock,
 GlobalLock::try_lock, and XArray::try_lock
To: TruongSinh Tran-Nguyen <i@truongsinh.pro>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:20=E2=80=AFPM TruongSinh Tran-Nguyen <i@truongsin=
h.pro> wrote:
>
> These methods return an RAII guard that unlocks the lock when dropped.
> If the return value is ignored, the lock is released immediately,
> which is likely not the intended behavior.
>
> This addresses issue #1133 in the rust-for-linux project.
>
> Signed-off-by: TruongSinh Tran-Nguyen <i@truongsinh.pro>

I like the reason string that the previous patch used:
if unused, the lock will be immediately unlocked

Perhaps we could update this to use that wording for the remaining
try_lock methods?

Alice

