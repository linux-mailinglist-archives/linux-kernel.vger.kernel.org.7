Return-Path: <linux-kernel+bounces-878820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10262C21882
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217313B0620
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9036C23B;
	Thu, 30 Oct 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlUUoCja"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C836A5F6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846107; cv=none; b=bNYH/dCUHdWKcpS5zZRoxdCzIwRyrk5Ays9q1LF7gkVxbYGvDtQXll9lfJerQODBhTQ+MZoXLWfB0+RAMCD7NgKMSweh3+kh4SF2NVrcKw5sewPFo40e6fr8Kg6/NnNdkX9yWUDJemlIVr1DGhh7R9CiryP757dRt07lGiXAiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846107; c=relaxed/simple;
	bh=oo4IkdW7sLnrYxIJRobVdkvu7rD5V1EssVx2JDkDEEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecB1JGafjIbOhdaWRorIBa7YtmqEutsBQF0V+agne5cyljvgLjE3yjy3Ytfa9MZ40s/AUDSw6StpcYSnEQEaws4b0yFTuB3SgUpjWmKkgYBzUPgCaTzG9xMfBTbPKHtvsK0Eb/6/Qn13C+ydFlD1Ic4uBDG6Bdnp2LVJNhaboIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlUUoCja; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594144059ecso124096e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846103; x=1762450903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaanMAXhNGpoOdRMiFzSWcxFY46ssv0pr1eWhXJPXZU=;
        b=hlUUoCjaC6/ZOat/ou5ynH/uFaiukPxEXbt/e3GuajnxAIkVdcI1kd0oM/rNNMNlo0
         2zjXe2QO02UgWqju6ZNTFEdSdOrKRxGhZBVZXFmVd3QHU56MhT87CSGxvEosAUtokJSl
         vQAIrCZf7CiRoKLxRE+Oc8ZnL7Cr/6DXixaJStbTsGkoUHqaPAPCQEL/g1U73EBZaXP1
         8eAGeazXaPo5BQpXZ7H3/FmEnez3zM9fsw2h/Ypf66vXPncnjpajqiPyAExHV1RIm+2I
         029pFv15yjlFSn/ZRLfPFbFxnp8fNN6dDgfZF1LSluaREJ8xzCz9NXfxyGhs5cdqGlM2
         iOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846103; x=1762450903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaanMAXhNGpoOdRMiFzSWcxFY46ssv0pr1eWhXJPXZU=;
        b=to2nF6KTsrqjCGoOG70KbZpGzSYARV3dj/aE7sGnhFyOxBytPtwjitB5OnLf+pQ7ky
         OHDIsOHLhQJ2sTiTfEGNUbo2rZASdZQRkq8YywFqK2mF8HAeeHRaCOKSPua8AyYmBFGh
         mtXxk5nWpenZ/sDd66K2G6O8MnmQvCjjEMTv5PlcKFps+R5x1ohMumbBev1BkXHxx2su
         lnsbohIqX/2WQXFJjIcLnD885FcmV6OlwjEvZZgvWSAbPh+0SDp9WzmdnZ/zAozXLpX7
         ENwO+cbnEbNiO7kkVMybmoL52oCJiVs1FZp9fRgRGXM7ipri87VaSPp3alPDNFA/GCCT
         YVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZRC2gef964CwhjGeY5bqAU7kh+Ux/I1XX+xULTFdxtlRW11L88mwnbAZxzOEj6s94K7aZfzw1J8RSENw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZrMbrACgGt9b4CsJhztnzflbmW/kwKODZINh/idzhLuRh9PR
	0PXgfsUVvxexQEm32zQMJS7pOzPj22+NTu1rszvsYvGJkzbkn4sypqLngcLaLXB3UPMSIhd8n3B
	rAMz9uxZg7xsNqaPP5ToqzTWnh8CKV3Q=
X-Gm-Gg: ASbGncuOQBOVx6v3sbsFpeEa+aPIqsZHngDkUhxlydjAdvLVZq6Mm9EXgB9HhX0kYRy
	GVE5lB405rexBIGD8/WmMyqy3pVLHMMOxv/ynyi7E600NFh6ufjA3cBJsY+fQukUfKZk8d2t+Hg
	d4cDSB5i7E76EyjsJBtPlmm9r1lbomyGoTk7OHXHv//GM/Qc3Lj4P9F4WypxR5foA06RHkus74M
	zco6HwCCX5Yced4CB7eKM5Y8a+ej86oKrQauCgm+iTiYHY1fqQ7HiBCBPnd/8Dt/oDRc4SbYosJ
	i8e+lqOq8P1ffle6mPuaSbGBkx2/0opolpwCQ9PfWb1j3D+kRsRcOTCGm0pOjKW4ZBFxbTWpFI7
	nqYA=
X-Google-Smtp-Source: AGHT+IG7bvo7ccWBD1MNUKXWUtpG4DmMsqI3BeTQWcJW82J1oN69RUHhnzVjzLexuETgdTaPCXgEfAvcK8gw70Ld9NM=
X-Received: by 2002:a05:6512:3c92:b0:57f:5f3e:84bd with SMTP id
 2adb3069b0e04-5941d543c09mr124070e87.8.1761846103123; Thu, 30 Oct 2025
 10:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9500284ff72ad4e4dc4799fa5392a7bbfdd34f3b.1761814593.git.chenmiao@openatom.club>
In-Reply-To: <9500284ff72ad4e4dc4799fa5392a7bbfdd34f3b.1761814593.git.chenmiao@openatom.club>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Oct 2025 18:41:26 +0100
X-Gm-Features: AWmQ_blmvl6wAJZ-Wsp9J5gdoKOtpBYl-Hhfx8cKJvUKCFPDb5C1gcb1nwusukA
Message-ID: <CANiq72n3uB+sgkak=2JrPD4iY4pFidDe=TbvF8h2idGKCwedFQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Remove the product of pin_init cleanly in mrporper
To: chenmiao <chenmiao@openatom.club>, Tamir Duberstein <tamird@gmail.com>, 
	Daniel Gomez <da.gomez@samsung.com>
Cc: lossin@kernel.org, nathan@kernel.org, 
	hust-os-kernel-patches@googlegroups.com, Dongliang Mu <dzm91@hust.edu.cn>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:08=E2=80=AFAM chenmiao <chenmiao@openatom.club> =
wrote:
>
> -                 rust/libmacros.so rust/libmacros.dylib
> +                 rust/libmacros.so rust/libmacros.dylib rust/libpin_init=
_internal.so

I think we will need the `.dylib` too, given the other one is there
(for the macOS builds some people do -- Cc'ing Daniel and Tamir). Or
did you avoid it for some reason?

Thanks!

Cheers,
Miguel

