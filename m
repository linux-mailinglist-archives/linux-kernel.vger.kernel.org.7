Return-Path: <linux-kernel+bounces-891277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D544AC42503
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3769F4EA537
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA82BE7CD;
	Sat,  8 Nov 2025 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Pz1O8f"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AB28641E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569447; cv=none; b=WyQjcIoObvZ24OZMxU3ogOKsXdLjElKBI6hSDRrX2pcSUDcWwjiLSRA56Gxf2VJJwt2jsjQZcQCub7bhthK0bfhg4BPOXOLun9uke0rua8OdNXMi2pDoXt7pSrFf5FZuRh5NM1c5uDe12ctHuRiKXJN74WTiXw4K613+qillbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569447; c=relaxed/simple;
	bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZafAlbImp7ggpCGHZeZHUdNnGBHzaKNMd+5MOM6MMg+TWwnY2cIR6+4BZGXPONFeOx1MOVshC3njm7G6n3/wOda1pdoBr26DfnQvFafpVVkJ9fx6KovOK/j/S0WYIlI9t7yHTz0goFqmvQ2dcTdd1BjAfIezSIuryItfo5+rblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Pz1O8f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ec8a6418so78695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569445; x=1763174245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
        b=D4Pz1O8fBgxVfdLn0kGOEPXb0Nmg76AgpJ/stxFpJ6/vKMwRMy+tyE6VHmRef8yl5a
         J8sC7qAT32BKsKL2K+sbGtrDuSBnfDyI+7SfLKNmzGRO1uevSAXTYuv26lKUoFrw8U+Y
         B2iSh3SbPRyQIzoTfh5Aufl4OIfIF+RhjQYQT4e6cxaOWLx++qhEZNySZlLeQCZLhZTr
         JlJy7lOhCEQfh97v3Fv6CRy8JV/mXtkpggFW37TBz99luVoUGN6om9GQHH+RO930XbnQ
         R1Qp/PmzrTRGrjz9+oDbKhBd0qSgwkzT7MHKilazuxuiRpEcpB6Nti0nr3KLk1Y+q/5D
         o6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569445; x=1763174245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
        b=QRGinU2PnMmRouJjSj1hlf0p2eyehzdteiJqKpmgPhROtNG1SOO6F6pLlHporYvAr+
         eA51u3orbqTJCOY/XlvRXvYlm0RUAGRkX/uvRse+OpliwWmut91HZ7/U1iip4MaqiO/e
         uhI9ypEqziNg16wEx7ZtTL4O+ANCpTTJfzRDYYkwHfDwNqfuM/KJOBDPIOkrR4qoalBB
         hOYqlFIchhgyYFxBDQbyzGWSdIyKrRrcVeGM9hwSwnvDQCewBn2WHq06ryQeT4Wu+YFv
         NqzK4Gjmwveq7q2IfRsGqp5BqrMgVtfWklN1cUWRVB7djnxHJmsuk9HCv1gHGNyoyE8Y
         rtQA==
X-Forwarded-Encrypted: i=1; AJvYcCVAA031AXsrJzpUJ5cKulcrwYg9ghHELhE0VnbMCCydqXn3K5lfB829gDxLa5p6cqMP7YKvQUcWSuEaYsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfaICuSfmgiKAWjGacQACJ40tJTSO5ArnpuSW3u/nOcr3Fplk
	+YmvKv71N4W96j6A9OMOOd/huS6tAue1UBZ7gN4HxOhPxqw0ZpdRBi7gFjpGagbzd5LCYV6PIwh
	3PRdSb36P1T8GEz32L+kxtWDAEzCaM0Q=
X-Gm-Gg: ASbGncvo34FykJ6aDWUzyI8MjO47ZhCs5YBWCNJ3EHJ37UQRQodqS6skg926IZnG4u5
	5ZFKR1CyZ3/QUgS1i9++w3Lbsjd7aH77C260SIWPF5KKz/bFPXk90/XcAnWAJB1CdSJqfdljsu/
	iPf8SZZoBsuRDFOu7FbVPa4LW4JJs+2KSYBSx0aDwijpZeNe5t2Vy8o2o+saqnA01JjOzytU9X1
	Kw43g3AXHF3wn5gA0D4elsQoqlo3x2gvkBpTeIT5kpiiazTPN0i4648fn9AeRpGI3ySy2SohdW+
	MhvVOvygb6225T7UhQIX9LHb18UuwDJXLafEJiUQMw9BcJo/rt+hKkmycSj4oZq8qe43dkAmD/1
	OcnOIze6VHQaScA==
X-Google-Smtp-Source: AGHT+IEovvjVicfDdGQT2CYmrDOWKJSfWNjNZjATvixUw1CuI60OG2r2rmWY0cQTlJoWG3OL54m2HoMu3xt+gxb8f9U=
X-Received: by 2002:a17:902:c409:b0:295:3262:c695 with SMTP id
 d9443c01a7336-297e5646bd4mr8325045ad.3.1762569445056; Fri, 07 Nov 2025
 18:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org> <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
In-Reply-To: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 03:37:12 +0100
X-Gm-Features: AWmQ_bkkl97L4KdKe3MLMAG94NJvyqaB6LbDFgvfVIDBf_nqC8JcMtGIqLcDcT4
Message-ID: <CANiq72kWWe_w-0088SiGvKFrh49P9wRcPxQvkSoU=SOpSrHbKQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:30=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> With `#[no_mangle]` may be more reliable and it also gives an actual
> exported symbol.

Or `#[used]` to keep it mangled since we don't care.

Cheers,
Miguel

