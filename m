Return-Path: <linux-kernel+bounces-893269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17733C46F33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AC11885EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D4314D36;
	Mon, 10 Nov 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmMy3omp"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F60314D2A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781717; cv=none; b=rJq7ERf/24dpKhCOODO90rf8HeVDQ252BzBt2BfPx0yFCT3Qa5QvnocqChovrLm3951SsQxSRS8znhlYgb1gM5uJm2FRCNa/t2gFUKkH6t+Q6lJJ4FaOARLjo//emG9m/FjoAVs6srk/WvhzZhoOw6jzLKmyoJHhziiTT3dEGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781717; c=relaxed/simple;
	bh=lJTzHX80gcOt+ynIbaRl5FvzwWQVyPrlRODf/k1ryGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jH9nHC8L2lBLqsykyJ4SKnv2dQ16eSf6s96yI+THvknC8igrj8xJKGa67HFKD/WXPMu2ePPl87JZ2qP6sVf+MM+hbUJ57oosu/rsvBvZ3MGUwdgee5x5eAwOygbGMGNkKme0nIMbOcDgI6DDRPLQU2oMODrKVUaGFHhpU0kbUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmMy3omp; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso1052654f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762781714; x=1763386514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJTzHX80gcOt+ynIbaRl5FvzwWQVyPrlRODf/k1ryGc=;
        b=NmMy3ompkpJ7M7DZcb9QIjXGen+v1jnvVkANE9ZmA5pYh/Q/flffBFWd+jFniMYMOS
         /PToix+QODa5BRG2vc/+/RkUEKH7sHxyuURW57993Dqwl/oGfB8C+/6jlk/nNO0oA5jQ
         l90aSscFt4Tv2OOTKLYahsafAlTMnkOWzfsYvZFrEAIoA6t0e4vKYqwxrSV0dS6vv79b
         Ip4MuWpB1cURYR5euwiZQYAEotVDK9dSSB6xvpaSMAeRDRnmIxiAaQPcY/UBzjsTWQo7
         cxXjjiQjomtWuairhCamQbYZIcsCQjBWVCOuFefNCECIVCW6q5KMd8OHatNfoVqWy8HV
         3CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781714; x=1763386514;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lJTzHX80gcOt+ynIbaRl5FvzwWQVyPrlRODf/k1ryGc=;
        b=D1upCkm6iH0GFx1LMUTwvOiZ0WWJ81ZXFxL3k9xFLfLR4XQtPu6EbpcJNKvmjedwCf
         PHsqXpXlpbjLWIpLEv6Uep7exAQJ2fRuPLGNIgV3S7niX+WVlxmmXoxGpOS6OuesTJFA
         12/IyvM/KrsKdNayyLBkkTDE1L2YjGMC76+J5inXImxao1L4bQNaU+wtMmcdkBulEw4V
         liNIFxieH6QNvhMx7NcQ/zZ1tCsFY/9uA4rmNN5cl1Z60x7RYvKZvD3/6mGsAK2Yh9Gy
         8asRQe6ddnXH2/28wd+wJNW+DrmrrWnSzwCPWwMB33/wmbVikT9m2RAyFkauFw0/B3GI
         +wEA==
X-Forwarded-Encrypted: i=1; AJvYcCVxhOa7rQQUdEI1M95F/8wSK5o8JnTar/MGc19nOjK0OkfKVPNXKSo33j7if+PismphQTLuL0/qLPpNNJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgnDqEiWxUO3bt2YkkyXkj2KSdn5wGTvw6imFqj6aRoJ9IjX7
	W/CTPbsRrpqvI1WAL5fBEaex+DbSaYXzV2KTjsNUxHWDmLdgLdPrwq0xq2b+s/XAbTLq8djfscP
	SagmORlXtOJE70lzxdQ==
X-Google-Smtp-Source: AGHT+IGnJplCiE5BS7Zbk5yxG+qcfdSbsxfffIFOw2vKoXQs/5pM3T2FKjbg9K9S0Pk9TrgnCi+z7Nq4/0WV7WQ=
X-Received: from wrtp8.prod.google.com ([2002:a5d:4e08:0:b0:429:c4e9:626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:288e:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-42b2dbe331emr5614498f8f.7.1762781713969;
 Mon, 10 Nov 2025 05:35:13 -0800 (PST)
Date: Mon, 10 Nov 2025 13:35:12 +0000
In-Reply-To: <CANiq72nkjWbtEktSU_TrEfY2Agy7FK0-OLBWPLqTvp_p-CkBUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-14-ojeda@kernel.org>
 <aRHQA6FEoxACerIQ@google.com> <20251110131326.309545df@eugeo> <CANiq72nkjWbtEktSU_TrEfY2Agy7FK0-OLBWPLqTvp_p-CkBUg@mail.gmail.com>
Message-ID: <aRHqEPN-aCI5YkIr@google.com>
Subject: Re: [PATCH 13/18] rust: quote: enable support in kbuild
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 02:22:53PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 10, 2025 at 2:13=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > This is to be able to skip over edition flags for `quote` when building
> > the rusttestlib?
>=20
> Yes, it is needed to support skipping the flags, which isn't needed
> until this patch.
>=20
> It can be done earlier separately since it doesn't hurt -- a simpler
> option is just to mention it here in the log.

With that mentioned:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

