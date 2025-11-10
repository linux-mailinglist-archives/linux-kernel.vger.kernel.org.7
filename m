Return-Path: <linux-kernel+bounces-893027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E71CC46624
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A66334E9B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238B30C616;
	Mon, 10 Nov 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbfLQJ9i"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7D30BF4E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775441; cv=none; b=nyfFydgmBakWQ2z9CL1Ou+MRcBs52Lu3tbldPuLGFGy7iKfOmTCYgJwn6gGXfiqugd3fuhC26YsaBddwHcbn9k8IKibu5E6CzjFNzJMR2cu5P6t24PgVenAhSzQ+kLHEORnfjkL9R+r0U4fwjCjUi9Xa7dY/ITfn6YXVpLkN1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775441; c=relaxed/simple;
	bh=m8FS1LKsvEj23KYUxGNEuRyY+Er+5K2VdZOMGbBWuPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YEidpilbT8jCevvZxECU5zggu/2yz0YKBFlCVr3PJGdC9foBAOZbnBwplRR1By1wnpuGazdha7TxQfHLbh1wcq0L4XUURZXQDozYXJD/8eweCBeqqeO2bq13cbzcA+Jl2vWPVUDTXrDCmIu7pkMOMEhANJx86tPNRxkY5YUKzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbfLQJ9i; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b70be4f20deso270410166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775438; x=1763380238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8FS1LKsvEj23KYUxGNEuRyY+Er+5K2VdZOMGbBWuPA=;
        b=tbfLQJ9irZ4UgYbxHdBuCQGlz6pi+O152fJLPmwToJSNVSuIjg8Z/2/TzDmQB0wSKu
         YtAzMdezswPJLeOz5f/+NjJ1bGweh7X45VSenF/gKIehj+sPcNjx32fP8eIClW18/6dr
         vcLyY6usgSXfdNzuNUd/9ksixTNqvtb8dbI+hjqJ+8NzUWTtsdbj6kJFNo+eudz918n/
         X2GAjVGkDlxW56HHziaRBfsfDOm6DeZLR0I7Qn7jpgs+8lFvo1ACVjnMTEARw941Kvwl
         yROal+T9ZmrGcpPPZZlqbPI3ba/47nTE/Mij/9RK+CoG4nVNHfCS8HrCODrQfZTTF9jX
         arfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775438; x=1763380238;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8FS1LKsvEj23KYUxGNEuRyY+Er+5K2VdZOMGbBWuPA=;
        b=MT9sf5akZm1qt+NHzTXJpvP2ecZKXlxUIfd+vwnKYlq+FOnoyi06GzoHzCXbjnjxnQ
         vI/QWoY0aA7CG6D9jTwCidkRk+M08EprC42lZa0Bo9e1RIgHWzcwC5xErRZesTX9QUlR
         kw44rw2kOOiXS4TDkFVNj7pexQ18TI2t8DjPapsuxZN8+bHFNYlgDWcfog2mE4+g/gUw
         jbZiv3/7qGyP1oyiJ3GF2SwgkZPHi1wsFo9fit+cEa/HTRg2Woy3HXEUgGOVVUpzGpN2
         dyJ9a2DN/+zL/wk4akfHnWvJTlV11Q1MAT1YqmuGbSiGv+DEv+b70XJ1X1CFHnXmrGh3
         Ef4g==
X-Forwarded-Encrypted: i=1; AJvYcCXCQ1QlaQ6wyABHw5iy5JHuzciDX0pPH1iDH/UncY2vt6V/GuxOxBwMcBsJ2iSyggnQjn4fZpxGXeGpj6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNisr01bejEd5Kc16AwY+fTX8wd6JQGkiqxw0T1H6kI+U3qgqu
	2jEcPP9mOPAlXuPcRcTcanXCnt61NtXsSb4+4CdY/HKKjSDatzbC2fRek4SaLnnmuOBNdvPuGtP
	Ym9667y71WfTH4S7u2w==
X-Google-Smtp-Source: AGHT+IEdN/OzNgvJoDSQXjw0rImyZwQBZCotyROrmcQM6Hiiz8GNRc/HF5cFI/FbvnJNkDypZwcJNKuHze4K1U4=
X-Received: from ejcwb12.prod.google.com ([2002:a17:907:d50c:b0:b72:41e4:755a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3dac:b0:b72:d2df:641c with SMTP id a640c23a62f3a-b72e04c520bmr672023066b.49.1762775438697;
 Mon, 10 Nov 2025 03:50:38 -0800 (PST)
Date: Mon, 10 Nov 2025 11:50:37 +0000
In-Reply-To: <CANiq72n2TDN9oa7Yu2otk=HfpJQ7NA_X=up4uGO=JszGvaGspg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-3-ojeda@kernel.org>
 <CANiq72n2TDN9oa7Yu2otk=HfpJQ7NA_X=up4uGO=JszGvaGspg@mail.gmail.com>
Message-ID: <aRHRjaSHO0z9R_Se@google.com>
Subject: Re: [PATCH 02/18] rust: kbuild: introduce `core-flags` and `core-skip_flags`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:19:19AM +0100, Miguel Ojeda wrote:
> On Mon, Nov 10, 2025 at 10:51=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> =
wrote:
> >
> > Thus do so here for `core`, which simplifies a bit the `Makefile`
> > (including the next commit) and makes it more consistent.
>=20
> We may want to eventually use `--cap-lints=3Dallow` here too, but the
> skip flags here were already feeling a bit more than needed for the
> series.

Using cap-lints allow for core sgtm.

Alice

