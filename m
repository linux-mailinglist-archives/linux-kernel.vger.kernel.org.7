Return-Path: <linux-kernel+bounces-854266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31867BDDF35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAF444FF5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84F31BC8C;
	Wed, 15 Oct 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffPhRrF8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62B31B827
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523640; cv=none; b=s86kDbRibxIHCMP5bvmcFkGTCn4SWplp660H3okNVCkI1wDT/uYK2AscBMehGnoAFVp8tsAx4amnfW3kagFvMcVTYy7V4n1Kgd4Jpfcj1ra+IhaqAV/wzGm9yIL+7hYowDwxS355cu6HOl2tFo7d9yWVOjHuUfWEUMdLPvfNoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523640; c=relaxed/simple;
	bh=syYNPVw3n/GpSLvcv0QAJA46VNrVDvZJVpL7ER+csm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc+4YOQ3tp27ucrZBQN9NmUf8dRNQ1FYQf7WTew0j4FkG3Fg/fQvdRLEmBL/W9yZY1VklUJc8gahO6zcPX/vlvxWHlMN+gctH6CW/aoOnhXEu02Oa6hgplFKy6u0oIZgLSOexOyMt71/ImnEOCm1zdwdjb7jmXkXkGTSzUzdUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffPhRrF8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28d18e933a9so12313985ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760523638; x=1761128438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syYNPVw3n/GpSLvcv0QAJA46VNrVDvZJVpL7ER+csm0=;
        b=ffPhRrF8dz1vnrtvM1Mf5GlCLZEwKlIXh1m7o8X1EM56P/4UEJBo2+EeJWmE1XVEDu
         7nNdRfgE4ylIYqDfcA/t950lNeyhLUMj1AQCbN34DQrtMGsKqFJIaQOLG6ydPwMMqVcT
         cb/QvdTmSrer0Qcdv5cc3elm7Cm+wG9JzvPDhWbct25UDAj7h7ShDBACC1fd05FVppQH
         CLW40zOV3smiYRfLIpJNYsGsxKAYWxdMKJq00EM0N2CUF25duw5SFAASShEScSksFeo3
         WgXKistovQHqvNnS9Zbfy0g/1HsT9nmy9mpienHkJGGF0NlUPFYJlnXg5Ap1vyIvK/vX
         +HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760523638; x=1761128438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syYNPVw3n/GpSLvcv0QAJA46VNrVDvZJVpL7ER+csm0=;
        b=es+PKLAcdZpE+ku5giGK3Mhg06CnMf6XnrO6XRd7NV7+TA3xJQL3h6MOaPiQ/aQHXc
         TiEbaOwIeAQu8OTC8RoSS0mbL0ja+yLToC6E6GDjrILZGjQxd33dFyugiVipjsRTkJ/g
         G6sj+XfgsjHBwNjJ22meWbl8CBTNJBEHNUZZcQIecS3Vlpwavjbwyb6XoNOioR4A2PSj
         eZhNV/Cw+jNtMaChd1mm0A0f06hfrp4sYhL1vRV7bNl2+4m/vdhJy+bkG2KPhKNS6H3R
         EDEkMekq4W6cEiMOmHYfqs88O37OkHUao4SXC47FYuepwHeNZQSi1kmWP5x2gRNXM4Sq
         tdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUQS33zxhUw1TtFXC9dqwmpQAdPFNelr06yk/Swp4gjpBUjJaUHQ9GuQdkqE3VBaGhF1U3TOuzq7tWhvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLY02Qao/1wuHP2D0IpIcWe5ePXUc1RdGnF6mPUDS9OjBPVbpz
	h5OvwyulAQPViJ7wUbh0r/XlfH5iDirhHKqE7A3BKpafEmBx56zcTzFtWcWzICgaIBaV4uNObWn
	ci4Pw8w1iK/j06EE5P2m2HtMaNm0J2tY=
X-Gm-Gg: ASbGncvkN3a03o1wHzK8Y3MOXRMVQHplv7UuEHoB6OHLxomJKhNCjY+bYKeRDpNLbo3
	6kp4giWNSZ+Kr8jcJOahzNmZd8Y+x2gj14lLMImZlshk1w9Eo53tfjHR2ssbIs3UiJY5jlTh5Hw
	HTeT8TmR9uUgL+XgLydXAePNZYtCxPNfWky+AtEVdm35OurNy/XxFWiw0OuFVBB8XPDCJuzKrtO
	3WIK8HZhBx6PlmlDdoZig8opO3QId/EhBT7Am2ZNjF7lBUu4sfXigeUuHtXVMMPtJ1eCZMHLcuT
	9lbDm9n0dPwUT2gIC9UPb86rogxjXhEqAarj3XmI5tGQHX4ftRgRXsqc2z7mxnvD8+8qyVCSjzT
	G98rTAO+oSIpnYA==
X-Google-Smtp-Source: AGHT+IEuA+7KQXjMigiCtp80sJMmgdGJdPwk4cX3Jo5f+x0gzm6yiVWTi0fYh0LQRKdjtlu+kVhR87VUjMTsN2L8qLE=
X-Received: by 2002:a17:902:d2c6:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-29027215f8bmr182642905ad.2.1760523637786; Wed, 15 Oct 2025
 03:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015022037.14535-2-xry111@xry111.site>
In-Reply-To: <20251015022037.14535-2-xry111@xry111.site>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 15 Oct 2025 12:20:24 +0200
X-Gm-Features: AS18NWCGIGHAWk8P2w_fEJ0NHY0-lJvrQGuVtdn-YvHXyfUVHV1SbvXdcT-w3hE
Message-ID: <CANiq72mvZy+X2ko_sxVCn-2cnsR29boAzPDrYn=S-Tp0xSvvHw@mail.gmail.com>
Subject: Re: [PATCH] rust: Add -fno-isolate-erroneous-paths-dereference to bindgen_skip_c_flags
To: Xi Ruoyao <xry111@xry111.site>
Cc: Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:21=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> It's used to work around an objtool issue since commit abb2a5572264
> ("LoongArch: Add cflag -fno-isolate-erroneous-paths-dereference"), but
> it's then passed to bindgen and cause an error because Clang does not
> have this option.
>
> Fixes: abb2a5572264 ("LoongArch: Add cflag -fno-isolate-erroneous-paths-d=
ereference")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>

Seems OK -- if you are taking it through LoongArch:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

