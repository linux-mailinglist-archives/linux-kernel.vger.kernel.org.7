Return-Path: <linux-kernel+bounces-723459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBCAFE717
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EF33B2F18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB128DF14;
	Wed,  9 Jul 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXQCsxf/"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3228D8C2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059345; cv=none; b=Lp/tSy3G6oLDG+54dyNNU2ktLsYWI59GqM86JB8tOTfUggEYHhQC7Msve9qVgax4k7P17sbUqIj75DqKDvXLge+XEHZc9/+VP9ZQOnbt4eu3fthLed3hNf8ygPblF5CLu3zwamr5hGDt7KTAP6Cjrmvf19ycjGztZauzkpzPWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059345; c=relaxed/simple;
	bh=B7deMPbFN2CYKI2YUT400xYx0Qqiqi3bB/h0pqy9rXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fvyfs4mjD3ACX61pVIIp2o944AWz+QXjoH45lDx6jlkh0SW/hdMlUiDR6Fsxtj97XLrmIbXmqW7/HC01biKHRnyNaqW4ZW4w8IeqKvKv7pfs1iV4JfgT+HMcA4WsAy6Gk8tl4li7kR039sMEPTLE5/yKzfeKgxECCunCBtuN1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXQCsxf/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so2502702f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752059342; x=1752664142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bjYpJSDclGoTb/1hN2DNKLtiaNHhBK2pMEgZTCoG3M=;
        b=JXQCsxf/J0PYGqtV8iMwRtkRy7oP4SeEcLXXE6IAjlNWmTNp1ReZFcw36w6yqBN7Ze
         NrTZsQRRvyBEUvddu8fy4nky5slBWVUKjQdLSWyai28INjoQvEN+nk0nBVPvFSSVEtOR
         wR07ICISVZ7SdCLrLqAKxwMxBcfeXghIhyER3BWUxmUNkFt5f6oMOf4Widp8Pjklh9oi
         x04tkNdpJP6jebdi+LMsAK38KHwdFug8A5sR7dh7pVxOMuB77TgJCbEVFOpAVTTDxNpP
         5eF3z09/9Vw3nNFR/I88R8U1tNE0BYBLXdKY7gItP5wItn6grS9wT0RmmtwN16TIpLCR
         IgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059342; x=1752664142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bjYpJSDclGoTb/1hN2DNKLtiaNHhBK2pMEgZTCoG3M=;
        b=ccGqJVeZH0+J2Du9OzoyvW9GvuYei8BqjGGw6HixtqsBbbfMbIh7DFySPVUOKnwehN
         wAEMuyppKimdVVKWw9VRURwU2OTt0Ot7Bxx8Kuv3I5mVfWwIG44nKyWijokdMzo5RklU
         75J9E8rZtHdKfjOVuXRbwhZdcxJzdCprmaCxTD3t+eGF/RS4xSXRZz8dKt4iXEyPp6iz
         54D+Fa/n8NjZ81Xo9sHjL+tDlS5PSLItzhQlKvPdUEKE7mfWhj9i4tSuFkdbel15YX9x
         voGIHUH+p4JAwUdQVwjN36wF3x2xSr29Db/bt3E0tpTYgAWn2EOZqItgnhSQiaNau7hZ
         4fXw==
X-Forwarded-Encrypted: i=1; AJvYcCV2N8v9Fs29kLRCL5do17X3ohyYLXGV48SWYnFc0l+WghAYmZfnVCT9+qSxOCKk26+mF1+DpQTt0tqwubc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmizHf5EJfxlqdPxYzazkrOzchGE6lv/fClhp6H7BDGoG4LV9v
	3Kfs1HTE6bWywBOlfADYU9nPzcg1lQAHCi2lH1x8auPrgHPp/gAzusGuGcNVFHOV8NtAkuN9A6+
	6Vziel7J0h9Q3uupp2A==
X-Google-Smtp-Source: AGHT+IHpIwEDwkwkHsmPKAoctj+/lLKs6GIuB+wtVk2MK/CSAVdldJRNgjT615TKHY3qGM+iPQEtTxicyM6LY3Y=
X-Received: from wrtp9.prod.google.com ([2002:a5d:4e09:0:b0:3b3:b082:6e06])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2002:b0:3a4:ed1e:405b with SMTP id ffacd0b85a97d-3b5e4577c86mr1377851f8f.46.1752059341982;
 Wed, 09 Jul 2025 04:09:01 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:09:01 +0000
In-Reply-To: <87wm8in3c0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
 <A6L7hDRsDyJJvX_NuoUG_Zb-Jy_BMdGLhjsq5xUSRkl6hpItQD9ZvX5ChAr9QIFH4eeDBpW-Q-582Tt4Nef5SA==@protonmail.internalid>
 <20250704-iov-iter-v2-3-e69aa7c1f40e@google.com> <87wm8in3c0.fsf@kernel.org>
Message-ID: <aG5NzRx7dIWzTwdf@google.com>
Subject: Re: [PATCH v2 3/4] rust: miscdevice: Provide additional abstractions
 for iov_iter and kiocb structures
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 04:51:11PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> > +/// Wrapper for the kernel's `struct kiocb`.
> > +///
> > +/// The type `T` represents the private data of the file.
> 
> Could you give more context? Please describe the purpose for the type
> and intended use. Perhaps give an example that can be compile tested.

Right now, it's basically a `(&mut i64, &T)` tuple providing access to
the file position and private data. That's it.

Alice

