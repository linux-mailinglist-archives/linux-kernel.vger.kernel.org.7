Return-Path: <linux-kernel+bounces-895702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC5C4EB65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4C4F4E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BE35A921;
	Tue, 11 Nov 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfrQT8UK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25D35771D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873559; cv=none; b=sQhFfyuN0tdlQODi+f3lj1atVpylu8i4pAoc0ply4+Cf76f1LVKOd851+z/vmhiHu1el4AL9eFWtFC0V++mpGXWQJ0qGZTa9nmaRKY4GrQVnWAR8cHu2OF+lit8Q+Gm+y3AWfAcSUizCZeGn/NHbbo3os229inIpMZbXSpWB+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873559; c=relaxed/simple;
	bh=SfMT/5nRjA3afLzv9Foi5iH+LBhxZGY4UrfDPe3Kods=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhM8N++D2jQiuxIVJ6X9yWGnoRpozoDcLyHk/oS/D0NVwSBSRnBO3VJzsNlOx10afTR3WnyccQT4/C7bkoEcNCcr4pLdxF/1EnX2pIkOH7vM3HJb+nxg0lFGhsFHRAL93gEM/vJBLIsLll/Qrn9c1I3dmjCme+ex0HiwcsECzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfrQT8UK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47775585257so24040305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762873555; x=1763478355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfMT/5nRjA3afLzv9Foi5iH+LBhxZGY4UrfDPe3Kods=;
        b=lfrQT8UKNOejvXqbNKuOq2zmRAVsY7hM/XzhrWNyvmB+Qs1b2pcRDVhoeGeffXqlVr
         NBxUGPqGhhKktU+FHSIJ1umcgsEWVpbXZJgXN4N1dRWS2HO4hs9M3xkVhCifCOJxfqo6
         Peky4QnNdN378xqXzHDkw3IxKg+pbyw9Uips+7UKsI8W8o8OjSvbv57Z0fZagvLllRvZ
         QW4IKHepAieNuLrKGVvuslv4dzi0fgozF7BkW9kTsOXjC3eHDtYdmz/AraZNm5rUxOWx
         Fnl/hYA30ITCU006kQXGNqXKFcurUhrkvgj2LZmM22PHDmMx86SU+XPDIPU5jHoEfi0j
         U66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873555; x=1763478355;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfMT/5nRjA3afLzv9Foi5iH+LBhxZGY4UrfDPe3Kods=;
        b=fTrKacCmQO5yoxlavN6pW48nluSBWRZHPdoTCjmwD/PpMckowNuYsuctJO7GuwRmBh
         OMuIz2od4oain5/qmwhMAE4W+mH3U2Z+iA+/c9sBi0ycPFI7iqAfp38VK7A4e+i5eC3h
         W3Gjw/kiy60fj1Va4Uw6oUB6aK6Fz0gbwvI0KqSH/8h7MHjyqUgeOxobbj6DDfvPZiFw
         G4GIkGeK+ucuZ1XmlkhpMwpDctloIGEvnBTJqkO3AxCDsudSzjOMtICSS9amzQglfU4B
         QYj/L5PM4BMmz72K33KJ2WcJ54KlvdVj/+h0vfpjGsugbsCs8EjQHsH2BJJaw1XIVsUC
         PPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUioeKnjE+BLC46oPAGSuScZo1VK+m+qmspxceKxq19Q2mBlxKnNnEFl1SRNOy2DClobMkBY72KIOaPbg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC09+uNLy4ohpzu4xjZtgNngiHnOkaGGpNCeMDMXwdUfnRzboI
	fxah9PUc9g0hB7eE/dSIcXp5rEpSKt66pxEVW+27Dgw+gwRS+Fh8e3Yn72WNnw93vsrHErVo0O2
	d5Dt/ApTKT4HYOtf9GQ==
X-Google-Smtp-Source: AGHT+IGvgucKwyCN8EF+pU643WbqgIgijDo80ZsWN9AosRWSEy/CQyb/HN1/S31aszXHJHlV1eCqBbXhnvjyXGg=
X-Received: from wmlm3.prod.google.com ([2002:a7b:ca43:0:b0:477:554c:6842])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b0a:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4777322e253mr92021425e9.1.1762873554751;
 Tue, 11 Nov 2025 07:05:54 -0800 (PST)
Date: Tue, 11 Nov 2025 15:05:53 +0000
In-Reply-To: <CANiq72m4K+UZxodnKqdx3cowbYB+Mj_Z0gB63j=3jE+E-x+3UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <aRH9Tjf0tszyQhKX@google.com>
 <CANiq72m4K+UZxodnKqdx3cowbYB+Mj_Z0gB63j=3jE+E-x+3UA@mail.gmail.com>
Message-ID: <aRNQ0dymO5GIBc3e@google.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 05:48:51PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Is gendwarfksyms actually present in 6.12 upstream? I know we have it i=
n
> > Android's 6.12 branch, but I thought we backported for Android only.
>=20
> No, you are right, this is just me being overeager. It should be:
>=20
> Cc: stable@vger.kernel.org # Needed in 6.17.y.
>=20
> It would only be needed in 6.12.y if someone actually backports the
> feature (which does rarely happen, so I guess someone could have found
> it useful since there is no Fixes tag, but hopefully people would grep
> the log in that case...).

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

