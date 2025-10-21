Return-Path: <linux-kernel+bounces-863092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F63BF6FED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3F1C503668
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145633B95F;
	Tue, 21 Oct 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oywEPCVo"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812535502F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055804; cv=none; b=lJqgG6n2Rvkg0+wnSi9BUbI5GN2UZJCQmbH8v6P8gliPYB1rfn5pYwgcZopGDGccXdUkbn6v29KQxrxPuxyEYpZfmbN6AIREipbPTYA8KyRZJJHt2QcvfBJ3fShIk3sdvOg8CIC0hbX015/VLcMQJqcQM0GwquGSwcZJc3Pl/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055804; c=relaxed/simple;
	bh=8wTLAvGi9ID9Ft8t8f5sMJPAEM8KIov9ku8jUR3+m8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R77a7mj0NgrI/3F0ph2/ebnqvyDMGYpg4anqOtUH2tDkEChnWJ8MfQbg8lL8L4oRNYM9OT+fr9JtaNxCF0F1skXAUUkiSDr33d4nVEq1ZwR+i8DlMrK/xl0eZQ6ZiCh5dWY5n0qQLWfKRLbm7M6gcU7PKODimFOZFcQrxC/sE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oywEPCVo; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3c9b1b8ccb1so850300fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761055802; x=1761660602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wTLAvGi9ID9Ft8t8f5sMJPAEM8KIov9ku8jUR3+m8E=;
        b=oywEPCVo+SyvObmNYX/40v4pP4Y5PlvowGYvqSX/xOGgzoMd94pmkKxyHyucAgBLEP
         qoTHAVKTHRQ5Kv4PSUpXY58pWtqxoqVaCkRwevoK7MajdsWB+DsmxCwYQ4S15AnOgwQ5
         uqB9cwqN2n/10FqlypeO40+Pyd3NDBSQupcVJj+3Hkf5mmtv37Fe7Z5p2LqeWDfcE4MJ
         IEpxEp9xvGet3X2PRkZVu5jSunuKzYwuLk2dMocQKgxbQ8OLmF3EwDlooPbKkvquer3d
         LMEaxpvNF4no2WnsAV9yH3encdoKvq/OUmceIIVc4YEMq0vbItM6s1wsZHeex1YVd113
         HysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055802; x=1761660602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wTLAvGi9ID9Ft8t8f5sMJPAEM8KIov9ku8jUR3+m8E=;
        b=EIVvo9/76BMyzrAB/DNglVnZAeR1vByjuoxBcfXTma9vQIT47BuxdQXN/0W2r+Xg+l
         PhtsB55V0FJwWpHo57/oWhsIxTUEI99as3Yy0p5Macfy3yRs1j6xedUW5MbnTNJ6X6Rp
         HKcjGqxR7XBrVeoewkRYJjtoM4PFEm0OyYrXUcb0+uUdGddnIMcdVVaqP7Hbb/U/KsOX
         Fg6NJjuXnan6e1YLzBRw84IxQmKjzRhLeNAMn7zDQO7MR5xAREzzwiuET2OHu2cZalCu
         1eWnOgHg61aU2Bxu7RSeJodtqJ28jEYAjBuAvtZrMJsAg6ca1v52fkpneX2GPNhGXTfS
         I0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX42X6DxPp5o1ycv1Yl4/W8dLCEbN86EDEnI7IR6eYguxMOcI+0qVSSIrVFZfYBmiBluBjP4pT75Diihtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcu0aBgeyJqNUPas+W3PsoES2sWbitZQoeuiadH2+U1DUkKbt
	fkZvOA1PH+dGN1smriG6Gw1jI6u/zScmX4AVz6RyBb88WxpPBFqd0dsa0HuN9LvZlJbVDZmuUPc
	BMC4fO7qNIHyeofk/TmtHiE7hSI8fuDftLOn0WOvs
X-Gm-Gg: ASbGnct+NZa4UGj9JVZP3ZDXSSJdocSmEw8288nFfrgn7MebLo6DAiGNgotwuF7yhHr
	1DHMTPuKra0Rt2F+PB7fSdPKKgv4z4wMvcIwHZz4AKyrBKmF9KHm640DbSPVovpv/0KyxLMu98u
	w5HDwlQlp+3Rw7PKwn+hSvsR1Bq/NBARf6nirz1Cx5IGrgGIQCh+cmUiEensMlmCZPL987vHp1Y
	CwpG1xY3N2Hg6MwoZ0IZnHMgadoCBNuTZZJNVIZ4b1ICN4FAkY2zc3HbGtXiKKdQGTBIZQtvCtT
	EwqMim7FPUjXUL8=
X-Google-Smtp-Source: AGHT+IH3VghCiCE3lxLOTrviSNeoulpzb3G7Sl27fBh08zim90scpuPdYk8nSiGtl8LWCrKQVcsM85+T67T5u2ckeQU=
X-Received: by 2002:a05:6870:1f05:b0:3c9:83d4:db66 with SMTP id
 586e51a60fabf-3c98d1e2699mr7751225fac.48.1761055801935; Tue, 21 Oct 2025
 07:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com> <20251021-binder-bitmap-v2-3-e652d172c62b@google.com>
In-Reply-To: <20251021-binder-bitmap-v2-3-e652d172c62b@google.com>
From: Burak Emir <bqe@google.com>
Date: Tue, 21 Oct 2025 16:09:49 +0200
X-Gm-Features: AS18NWCfdoTu2E-3B42NFe8GMy5fnHpVX_b7zcHHmcDYGg8P0ZL5WsqS0Rf8vrY
Message-ID: <CACQBu=UyZ_=A3j56xNX+F8nExTN8CdCrAXbTRT6z-9MePyuqKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: id_pool: do not supply starting capacity
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:33=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> When creating the initial IdPool, Rust Binder simply wants the largest
> value that does not allocate. Having to handle allocating error failures
> that cannot happen is inconvenient, so make the constructor infallible
> by removing the size argument.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <bqe@google.com>

Since Binder is the one use case we made this abstraction is for, it
makes sense to me.

cheers,
Burak

