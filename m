Return-Path: <linux-kernel+bounces-882691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE7C2B24B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2304D3B9069
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAC2FFDF8;
	Mon,  3 Nov 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k76QV0pd"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009D2FF14E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166969; cv=none; b=hb3gedOdIhM5LKUcVP16hSoXRm4LutlECtMRo5vkJCxwRR4spp2dDMkhPDhOcuLadDXk1J+xZgKdGLRkCG2VMEPtEog8ckBPboLjqj69IzHBnE8b5d5c5BNFO/wZ3RyR9Rj1HpzKZE46na7G0l6n0/vF67zVdZ+v3WQFQUZ0pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166969; c=relaxed/simple;
	bh=Evfz1tcnqjd0f5x1YIdlbDb29zhP2FMybct8RGVgIjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VxFtpRwfhMczW6LKHZORvjTDPRG3dKSIRO3uL2uawNHt1A2skMfqFxAUEqrA86+vCLv9m1mvy9ue5MM3MnTzL+8zDlkQk/0ubkEDF9aaWvvujukp9OuWvezsDTS6/ayzPAbnMPrEVARhEfd4KuQNoRLkV5Bu9JbgpmiTETU2XrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k76QV0pd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475de0566adso31896485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762166966; x=1762771766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpWdihMx06jCjHLY5EmCWwN5NA1F7kZ8RlapB6cD5OU=;
        b=k76QV0pdbNe/7LbOu//naw1MYKjcN6XMViWCaSSaCh1xXW31822vn83SUvkd/kMczC
         qjF/vf06TjQ5NltNvQAk7EA+DQFmX+4aHgJq3C2IAGPhcnnpQOC7QbmpGrySg4Q5EwrR
         UinoPIbBiJX0WcNg+aohLLt1Iz3RqM4pNd8cf9TptmeuBdqJqPM0RKMHL3U+wHKR5COS
         mYub+WEsZJtHd0rNSWcfOqaoEubSmmQjK9qK2Qnx0LJRcpa/5VyXkTo4/3k29C+XPMfc
         sX4shZ/mY71mAoKeTniRUdvZO4ZEaTX1KujbuZZTYZ3VMNljhCCNExrZRUqLO4vFDvQ1
         R5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166966; x=1762771766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpWdihMx06jCjHLY5EmCWwN5NA1F7kZ8RlapB6cD5OU=;
        b=i1sYPa9MWgehiztSFoHnAc0uyVTjLGU+kgc5gbRVNldEM0kseEIE0GlDFp7hgQC/uV
         XKAZ5R3Zuvjsl2h2f5BsoUjsNa+cTjdGkoSBpUG1bjwhfUSdJ5MvicHegNwNpTZEdsCI
         jgQvhcGNKDPFRaAO4zfMf75tqJPRgJen1JdBQ8pG5Cw7ZJ0NkdQQO5JW0Tlq2sx6cIkF
         lxlC7aVdyb/3KDqluPQ7DyLv+n56xM/efbVgxvQp4CzM7D0pGSoo8Hk7n6WhFUDAkAvI
         l2gMFiIj4HP99L3hSeRMJhLV61h07MGrsiP1/6bWAJV6ZcC4FPNiM/UJWx4aE3uIGCX2
         7QVA==
X-Forwarded-Encrypted: i=1; AJvYcCVeIlo3atDzA65Pn29xZyAFXz1juzfmn0K2/xD6aCEpp5aDn4a8mFAmoHup/tqNAKiTIAJlh4JvLuJBGbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0opEFMogHmPxLTLK9uJxEKSA30ZrAPr5G1m+9hNWsM94B90I
	PnpboMrMk9r8nxvVDJYC3ogmhUIxKm7zDEoL8e36TWxjwRMUdYklzCyG/fBbideIS8nqUmnE+rt
	0wdnyCdZS6UZAvyYlvg==
X-Google-Smtp-Source: AGHT+IEQzl/e6rTwNPnjUtOH6pZmLtmwiNJNjCotzrRyo/a0nRPHwZhBiPYChczpTpEtjWOvjSdmGgtTEihcQ/k=
X-Received: from wma5.prod.google.com ([2002:a05:600c:8905:b0:475:d8de:fe5b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:848d:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-477308b222dmr106823955e9.33.1762166966577;
 Mon, 03 Nov 2025 02:49:26 -0800 (PST)
Date: Mon, 3 Nov 2025 10:49:25 +0000
In-Reply-To: <aQiBTOj1jl4xM3pJ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
 <20251102-bounded_ints-v2-1-7ef0c26b1d36@nvidia.com> <aQiBTOj1jl4xM3pJ@google.com>
Message-ID: <aQiItc35Y19l4HOc@google.com>
Subject: Re: [PATCH v2 1/2] rust: add BitInt integer wrapping type
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 10:17:48AM +0000, Alice Ryhl wrote:
> On Sun, Nov 02, 2025 at 11:24:42PM +0900, Alexandre Courbot wrote:
> > Add the `BitInt` type, which is an integer on which the number of bits
> > allowed to be used is restricted, capping its maximal value below that
> > of primitive type is wraps.
> > 
> > This is useful to e.g. enforce guarantees when working with bit fields.
> > 
> > Alongside this type, provide many `From` and `TryFrom` implementations
> > are to reduce friction when using with regular integer types. Proxy
> > implementations of common integer traits are also provided.
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Actually, I saw Yury's comments on v1 and I have some additional comments
as well. See my reply there.

Alice

