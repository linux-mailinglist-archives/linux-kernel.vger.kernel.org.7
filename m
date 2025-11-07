Return-Path: <linux-kernel+bounces-891012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDEFC419CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F46A3BCD28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039030EF85;
	Fri,  7 Nov 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuEVjx/G"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B130EF7E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548280; cv=none; b=ULJv5EIwHH8fBi0fGqBJEExyDCmfzhJNTQOCo0VV5GSa4i2LD3zxpKk39gg2qOXYHujjRqtYJovPsPGna+0TjjhDkIW48yXSUMzP1bGkXl2sIoip57XqyO1RxfS8PBapgO6hUngTJbRm/Nmf6gr7gatnSThDnpMeBTTwuhI+Z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548280; c=relaxed/simple;
	bh=FJwadjvE+x6S4hONQHvG75rq4vKRo6ZUAojElg8WjXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQhmo+RKCBgZtvFKxnGJufGK1316CxbEvHQtNS0iENjLHUDEK/ilnt9/RqfZdHpBiJVhNX5bqBtZhC3eXoSo1dNxIuYRJO0RHlXgUoRJFtTL9t2BaRUS2hC/1pvJeLwyLs0+fjuko71yfGXJp5I2g2CIWsE/n2udl8B0lwDGuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuEVjx/G; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso116539a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762548278; x=1763153078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJwadjvE+x6S4hONQHvG75rq4vKRo6ZUAojElg8WjXQ=;
        b=YuEVjx/GWatgZC2eCXMljvS/oWguxmiPUtOh46Hpp+ZkYBOykhyCYDir2yhrcoaZWJ
         FUHc8SOfRJaIUonet4se4gHjRLWNW4ur5McbhTqU8E2N92VyCbqCVUX+6ud1+EfNLBTO
         6HniGPvVQ9aUnEjzw0Q424UokIKnYZ6GQwGBObBk32r9VGcVCecliGDXEwg+G+lXPbvU
         3KRmluXMvl7I8ZtL1kO5kH27Pxk+7i/F26ihWo6PGN17LAyB9zZSkVOCflPC/bQZxosJ
         p8eGIgZmrtsMdhTp2d9YH5ouWtXx2Gra5IeqE9QVk2M8p/K8l9ZVdLdaDGOsF3pgVmFZ
         DMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548278; x=1763153078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJwadjvE+x6S4hONQHvG75rq4vKRo6ZUAojElg8WjXQ=;
        b=M4751JHN8nnuzn2VuaBWizF2+Fa3bTVhnGU/AOEcjYpQDG+Z2FwEYAnF17Y29nKITp
         /Vovf0LfVXaw+lyiZs0OH5dhxjehJBS8jhHIBy5HERnMzLF8Sx4Jvopw+HJ8B6pxFvYu
         tJTxQZ3/hD7RsTnCvOluAPoLOyzxd9jvy1i+XWGMRb9CZ6fvTfcfvkjcIQKROGfhlhSF
         R/08e2Iwcbwy0l2Roam0mH7ok206enSA55a8cbHQn34kIemk4biP39T+IDCx/LAMIQqe
         K0o5bZa3frIr0+4wLifHbL1s1tiPOmywhTF2jnJ5WDyxyxxTtR653TbfDpwHcFRfqroM
         aNBw==
X-Gm-Message-State: AOJu0YydF8Sougk/wfRMftajokv4A47RukuFA0XjCoKtkJICBugZl82v
	GMMS5uG4i2/Z8WDHRmrhJklxPDyIkgVXhKRZbGHSzROFRQlfHI99JSQTUXo8RjAdkO2JBlLqkPg
	klDGjrh89WDTIh6zWLaDTTFS3xtzujac=
X-Gm-Gg: ASbGncsX42TfL88sYgMSYOLdq1g13/QBqXMdXNe3U+rBHd9PLJqZ2FvAmp9/jrQv13Z
	xmhz/+1U5JqFlu2dSQ82MAppoBRnz7srF1lPPiCJ11Ug2fjNMKZQBWTO3iGxbZfuwvN4vEg9pdg
	Yz06A99O1OJPd6vh6SayHl2vtnGF5FnYwCryGXYibW6G+QaYn00VMw5gc/ftwqaPiOrW7GYJd9m
	1DJ+WApibBzXAQGIKctAiEV9M4gIbsRTRzuxEMBP87LmZ1dGaPs4bChpzM6ESaK/mUepQD8cPN2
	Rh5bH9cXDKZVB8pZz4FUp6BBUZKcucbMkewRP8i6+6V3S51TcUd77eK/RCZqZMA2ZLVe7LhCLBN
	XjzM=
X-Google-Smtp-Source: AGHT+IG4kfdE9ns+hw2rpt0h0Ke6GeX0YiddNE3DhFtSBXMZ3HIxQ2OtW0G9wd0osT7WC1CnPcwhL4cL4czBFQyIQaM=
X-Received: by 2002:a17:902:eccc:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-297e5657e71mr2838795ad.4.1762548276152; Fri, 07 Nov 2025
 12:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107202603.465932-1-lyude@redhat.com>
In-Reply-To: <20251107202603.465932-1-lyude@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Nov 2025 21:44:22 +0100
X-Gm-Features: AWmQ_bkvvWpH3oiH0ZMom1_CPsAEk9l2Cr9yEraf7Pp4-uYDzYPAwG5chWQGO1w
Message-ID: <CANiq72=c_0+H+ZysBL6a=zVd18sGPex1=e9N3_nDMxFFt9yqjg@mail.gmail.com>
Subject: Re: [PATCH] rust/drm/gem: Fix missing header in `Object` rustdoc
To: Lyude Paul <lyude@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Shankari Anand <shankari.ak0208@gmail.com>, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:26=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote:
>
> Invariants should be prefixed with a # to turn it into a header.
>
> There are no functional changes in this patch.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Thanks for taking care of the docs, very much appreciated :)

Cc: stable@vger.kernel.org
Fixes: c284d3e42338 ("rust: drm: gem: Add GEM object abstraction")

Cheers,
Miguel

