Return-Path: <linux-kernel+bounces-747024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4FB12ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AAB189A161
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612F1FBE9B;
	Sun, 27 Jul 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvq9kfhA"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FE4C9D;
	Sun, 27 Jul 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753608365; cv=none; b=t1gDJ32nB3dFZ4eJAeVljNahUFsyGuy9GAEEwSxos71vmdgIiJuhUor/d1VrcKjikViQWRoa93wCnwozf3Oe2X+Nelkp8mskROQUY8EkDAIpBsMbkp7CbWCSk2r2MO9Yp+OHeHcAjCwB3msEgI5jpJP5kcSqLzPF56cJla+PVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753608365; c=relaxed/simple;
	bh=GIT8LRjoqUXjNL2g6LQt2quOnCTFVDHygNFZtj0tBOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETziOSaPOwdhTJ+ip8/d7NuEJS9yxwgEw7CiVAay/I69WfRtUXMPiEy0IrbBNL7S4PeLGGIONBefPlmlIglkvBrpL6KUyRzpPzoOFnje2w7S/9T24UUN6Cvwz254CnwR1FASEzW5lnVh5l7AGjKiVJ3qB4hXEcyYPESqk/3qPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvq9kfhA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3f2ea2f96fso176263a12.0;
        Sun, 27 Jul 2025 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753608363; x=1754213163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Z5wfXNE7NZl9YtBlBIWNhM3u9yuxP8FRz0mSScF34=;
        b=Hvq9kfhA0d9guj4tlaus19276l+flH3T9I4flsqZv8EOZcbFNWmjY673TSxX9fiA8a
         uYVOed51zVZ8xzvZc9NrwfvYlytbG1mJXO2jZs/QAqqNtoXvPJMtAUNN9iTRAvnLVrEf
         353Yz3mdR4P7LAOsblqzjM0w4JJMRai/n2KqDXLGAbaPsTxclAMP4yUOBGImlS2cmI+u
         lLVAlBLFflf4oPgEbCkwK1Kzj7eva2ozR5SizoDBaBrMWcCoZuIg4ZDMh2eYX3R9BpDz
         1NohTDHMsDYjYkcLylwSL3baljlHEs5gEmeONrPDkF4dmUSnseMQjdBJtqYrVY8SP4I+
         C/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753608363; x=1754213163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5Z5wfXNE7NZl9YtBlBIWNhM3u9yuxP8FRz0mSScF34=;
        b=YupQAkux7Ij4QZKNKHmSAV/J4sd3fbDge1F3wdUSqlXY5p2SqNfTaT1dCJVo/bmcuT
         rpJbXASqSenAUndw7Kxq12sZMxdOe9sUjOApzbxuKHyeMayDGDtO2L4QsRztESTogPnN
         apP8NNkQCzmABTBDlZqAVElafEyZKOZVdazIlywPeL1hU3mFiQWerUk9HXvZD4z1tIiC
         1FKwYwRua16R6o0+C4l8mhtwXZeKiuknbIcacn6tiCQJZfI/45cqZ3L3/9N7B8/vCZwu
         QxVLtxz1kVkuMtbFpLISpB5TYWZdmLfPmIcK4qPra/eOhK2ZJJycBrCCtuH+dgqSgA4K
         qvsw==
X-Forwarded-Encrypted: i=1; AJvYcCW4k5xNxrsDEgZJI3AAhMGMf6jwMVzFnmvtn42BZiMLVabzZIqI9MHmWYgou5PYTJn2lfNKJ8RzGFWtyf4=@vger.kernel.org, AJvYcCXAwPCLaYoP37BNtoKk4TnTZkRH1vo50O+dJPQmjk+3NLrMzqZbP5rsLeba3MDlPt36vckwZKjB+6XxeJKo4qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRd4PYcvN1DWVAhQmfbXykom+jnfOqgqv8CZ51bQhZoAJiTHDb
	2Jj9ahQ/wB7vneDNumUC7rv41kx0+W7KjmFoox+/GCm9D0m9P3WKbfmWBx8CQMGkywmLz+re9MA
	FVn/s8WkjiGctbYxAf/17kg38fYEtUNQ=
X-Gm-Gg: ASbGncuOC1mHyeK+DsAQ/EZ2VyH58pr2NI1ZpOShCTMi53KS5I+CWVXiXIP2TzcjigH
	/C7crVq9DzlLI3TCz0pRl16T1iNzNBqdslwGXdZ2+te8dptqvhGQCPX5rnyeZDsQUBaijngOvTg
	0paMVPJlDENkZ9mDT+iLk9OxFMQH5pShSTGL6jFXPnv1cSloMSAx6niNiuvXxCrqq+MFy7IsclP
	62k8vYFAWbLWKiiF3c=
X-Google-Smtp-Source: AGHT+IFmy5RKqRIvt3sRUWTZXPj8QWOHXsdtzXI1ye3M6ACCApSBLGitX385MVPlNIbtPwJ/3qzglf/wH6hOsjA3A+o=
X-Received: by 2002:a17:90b:1d0a:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-31e776361a4mr5230133a91.0.1753608362829; Sun, 27 Jul 2025
 02:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com> <CANiq72nvbKiWiMx6XwRyLUOWxZAEAQgTY9MdqtpjAG+kbk72Sg@mail.gmail.com>
In-Reply-To: <CANiq72nvbKiWiMx6XwRyLUOWxZAEAQgTY9MdqtpjAG+kbk72Sg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 27 Jul 2025 11:25:50 +0200
X-Gm-Features: Ac12FXx1DPEjA_xjWorFGlHIDS5OjGr6vXq7V-Sifhv2vctugOvrtSQOvLgSjXA
Message-ID: <CANiq72=d-X8WiDqBfVChaXUR0Opx+N6T__iiS8WHKdh3v9y+zg@mail.gmail.com>
Subject: Re: make ARCH=arm64 rustdoc fails on a x86 host with SCS enabled
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:40=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Thanks, I can reproduce it -- I will send a patch.

It turns out it is a Rust compiler (`rustdoc`) bug -- filled:

    https://github.com/rust-lang/rust/issues/144521

I also sent a fix upstream, with a test similar to the kernel case:

    https://github.com/rust-lang/rust/pull/144523

And this is the patch to workaround it in the kernel for the time being:

    https://lore.kernel.org/rust-for-linux/20250727092317.2930617-1-ojeda@k=
ernel.org/

Cheers,
Miguel

