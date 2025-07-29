Return-Path: <linux-kernel+bounces-749839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5925B1537F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116974E736B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70732522A7;
	Tue, 29 Jul 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtcwUy1B"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EB13B298;
	Tue, 29 Jul 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817721; cv=none; b=i0pJTL0vNoahfrU0yRwiL2Kaz6euDVDoi5HRTBpzzzYEI0vseeC54tuMHj2kf4LdAEXzEgvxA2Sw5Qp5guwBEqbCilmVBF01waU+l+csPn5ygTS34sIVmS+Xkt+sF8tkjSdedUaE1oIOz7tB8piGEwC6c/m9Vp+vKyFnxz8zWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817721; c=relaxed/simple;
	bh=vxbkeRBX+ImlPpBqkPXf62JLUx5qg7K42WUjUczOu+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQIUSEmyScByaj8pTaC7yQFlhbu5aroFiLU0Xv7UOqcqtCGbEe/S2x2cOp9RpLIXB9fFPwy+kAB7o82wbxgSWuzlxQhwarTp+cn7ujwYvLu65qx58es2viUKtUUBiK137GL5J1fW29rCgx3zCIODaSXFG9EY5i3OQ7uWaUFTrDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtcwUy1B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24050da1b9eso2773995ad.3;
        Tue, 29 Jul 2025 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753817719; x=1754422519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxbkeRBX+ImlPpBqkPXf62JLUx5qg7K42WUjUczOu+g=;
        b=DtcwUy1B7KYACtb+Enzlj7UUAtz/dQY8uDJZ6+y+tLRsQpNhDEUPbk5lEhEVRM2aFy
         rNLMBEJ/dEkXO4l8TT6fnIMZBjISdyq7TxxM0oSlUJNwBsfxrU+GUEFjfoM8zKmfWcxI
         3MJImY6eMUtQzqdGyL3l2DJM+/BrHU2HdsPXwF5nEqmAJfFYf+dgnzHZr9sgInuBIdrp
         c83Yp1JcMD/BCXMxLMJjdY7KcIREs41jArDzb1amK84FpgEZhcohVMh6oUsnbb7UayZf
         hb42FC12aUlXdgdcyk7cByAzTPVgiOHZLgGnfIGIV3pQseZ6d2LEKAtSYpt2j1p5Pmh7
         R2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817719; x=1754422519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxbkeRBX+ImlPpBqkPXf62JLUx5qg7K42WUjUczOu+g=;
        b=aqo38+FBkheQZsjzWC0D+93pgzQeynTIQrBGLPrQwmi6U2SVKbQb0T9hQ303c6vEun
         u5Hs/TXWZraP/qyFEVBsjXWtfKIb6VmBeA8PTLgBv7YQAPRIFupKkIEim5N57DvJ2FBp
         bKVngZ8l6vU/teISTIM49nEvxQcDzzeLU3AxEe5TmENVBvwTIU5D3UPOCjifQYdIhUHt
         Clkg/LoEKdXTF0+IPe7xyeIynMUg394GPyB7XW7f5MGF+0S4/HFdgYGKEVVt/GQT0wzh
         mnS/lBNbZJBjcZ1B+dltsW6GBZsgHJQFxwA0AEzDv0ZXUZnGip2RoNaCRxFg6DTHv67/
         nUtw==
X-Forwarded-Encrypted: i=1; AJvYcCVmYDlulsI3UfYlt4cednIjTGJl2nnen+QdEoP/KiGrRUgG9kwOkn6MtOByyAjb/ynYP5sTtzyTBejaKj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00tRBH11dT/4vjrAQv2QxxGieQbftbfRy5Y7E7d4+gbs42tNp
	3qK09sSDHS+OptTTKc13VCm/J6OCSDKE20xQ1chnFb5B9rmU5XFPTaeAtKvzIp6UCgbUEcVRk5f
	XzHwBkAbo4+vtkmm8ObkZMvcDRKiYgCU=
X-Gm-Gg: ASbGncsK9cpC2jRqOQvpQ3tdS/Yne5f1xd7ftTCj64LhweMkzq6IfaicZQTcicwZ18Q
	LgsklDD1oe8ZTML3Eu5jfa+6crEUCn5SYTGNU3YxjxslttuEpKex9PS9kSRwKtWRYJVW9w39K+I
	4oQYtD69IIzxvnXjGx3ZbD2aPFc9l681D/e5vGwzsauynNUUNdC5qZ+R+gSIGN2bgbIfbLwTt3D
	9s5buNyigHjWapkHjA=
X-Google-Smtp-Source: AGHT+IEsqf7OwfdvD2m3jUs2IP0Dm+ZPhdFGRYYYRk+2nstuMBM2XQ/ZzLKXv7t+cYSzpVaSafPepxjENgriDB1Apt4=
X-Received: by 2002:a17:902:e94d:b0:240:71db:fd0 with SMTP id
 d9443c01a7336-24096adbc8amr3397135ad.8.1753817718702; Tue, 29 Jul 2025
 12:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729143600.5305-1-work@onurozkan.dev>
In-Reply-To: <20250729143600.5305-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Jul 2025 21:35:06 +0200
X-Gm-Features: Ac12FXxmdasWkDr2HQ-YZk0lBgzoUYfM6aDTQroAJE0v81DfVPJayI4sw9VIeTM
Message-ID: <CANiq72=L_ov+Dc5S=adPdson9gq6wGp4xp=iCZLBnz+YC1_vgw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: update `error.rs` documentation
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, felipe_life@live.com, 
	abdiel.janulgue@gmail.com, dirk.behme@de.bosch.com, daniel@sedlak.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:36=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> Replaces the outdated (e.g., `ENOIOCTLCMD` is in the
> `srctree/include/linux/errno.h` file) and overly specific
> description referring to a single C header with a more generic
> one.

Yeah, we should have the other headers there, but I would avoid
removing the links entirely (the links are meant to be there as a
reference and get converted to actual links on render).

Thanks!

Cheers,
Miguel

