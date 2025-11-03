Return-Path: <linux-kernel+bounces-882641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107EC2AFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 755174F14DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCC2F39D0;
	Mon,  3 Nov 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2iuyYRl"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348B1DED42
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165073; cv=none; b=bSigMCGsV3+ONzXLN8fKwQv/rxZZLYmiQBMPNIpsLY6DieSw9QJTUWsdntFvASgmu3y361TR6NEOTm6wxHrVyo2wmf84c6g/2LaYN2r5UEOEn3qZf+wV26eBgen5nbgSxY3Xiht70o1UNZOwwUCGYgJLbnqBJH9VLEIV/1YVpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165073; c=relaxed/simple;
	bh=8MiCb/wkimzT9J7ynbKauVkA4ev6a3Tt3Yba+gQGitY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjVxVYVHX08nkvZ7n/x2cHDkBNVHGgNvjwRtFG9gWdVoPw3YumuysJ8gD+wFjOtllVXeSBzqUv17Jv+93XEzwt4jXTj8pymel24dcycFmhhGe/9bOe3lm9uXgk/q78Dj4ornhqJUd9xGxiwY0OHu30Loq1MRMrH90g7f/KB3C0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2iuyYRl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-476b8c02445so33789295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165069; x=1762769869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOgM8WNLkc6Tm8aSr853varn89fMEi98z7ILIYLUAHI=;
        b=u2iuyYRlALb/4MtI3k+vG70n2zuOdQKOw/wm3ErRBGVp4XSJiZTSO4NfZtID3KJ5SN
         9O1X4PXRkucTU1DBaMMyF2qNXqG4vnqnDSUqTxV+664p3WIR9n0ipVVaWX2HBGo23+a2
         2kw0upQBFBm46vGDz6y+kQPVp+TXVXsHDKms1jB9a/DvODyBSNoOMEIAkVMjRmsCcP2b
         mevbCGOtAGRTPiKeUfKCkzqFpfp6XgZE/9d4Kzv4uetAvyJYiIskWlzl2Vhq1CKVanXr
         cmpZxfcocIgvsTg6EAt5wft2Nc8kTfJ2zzve7mJ3zpiZib/R3c8oV7sSSWeUSTk+whHu
         yYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165069; x=1762769869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOgM8WNLkc6Tm8aSr853varn89fMEi98z7ILIYLUAHI=;
        b=VRh5lh7dudJPAa6xvEiWoWsZa7BDgcJMloUHDrxjN5A4ij5oZ9XbxerCije5CtELQR
         nV9p3+jh6mSIxOrK8yXTrJFZFz9u3H51gp4i7opwf+/7wIdoGB2JzXHf9rsBPUlNfWIg
         AL4NzZjYmtVIIHCSR2yEDulVbIhkgaIEtTN1vityH4/DAwsrFS7YglJ0iz6HexBr/WGA
         TmokzdOOvG1g+3lrI97nwuCl5fZGmM4bYbg707/IbJuiLn+nr+n4dRETZ52FfBEglS6o
         4u4fY/oeSS+qzppQ1qFD02szDPNO5HjSFLPHV/rZfHWcGPjwA8Jw6UtSQRgoyMJyrk29
         ga3g==
X-Forwarded-Encrypted: i=1; AJvYcCWzoMhwDeov1Zz5XI/AKs9UsohayNtknkzAzLRFIzpash7F6CaIapwAbKp1dUjzcTmU6sOPt11UqxrApqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsJJjxwpoEXkbcB0aOo55ON+SsYh0ujZegjgS/HlnABya4Zvl
	94ON3vDs/1G7rDp//qnDSDe0xHvSymlSBbgYE/6N5d/J5qYCY26r3XaK88N7wLmSp+muiDHMdEe
	G367jBFrcwH4FCif0FQ==
X-Google-Smtp-Source: AGHT+IEGgSk8YGC/S8q02Xem2EpZ8CGSxhkfBY/COwRI6jkeUuW6v2BW/B/8X3uqJpmloBszvSIHf8ynay12SJQ=
X-Received: from wmbg22.prod.google.com ([2002:a05:600c:a416:b0:477:14b8:19f6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190e:b0:471:669:ec1f with SMTP id 5b1f17b1804b1-47730791083mr125439425e9.8.1762165069626;
 Mon, 03 Nov 2025 02:17:49 -0800 (PST)
Date: Mon, 3 Nov 2025 10:17:48 +0000
In-Reply-To: <20251102-bounded_ints-v2-1-7ef0c26b1d36@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com> <20251102-bounded_ints-v2-1-7ef0c26b1d36@nvidia.com>
Message-ID: <aQiBTOj1jl4xM3pJ@google.com>
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

On Sun, Nov 02, 2025 at 11:24:42PM +0900, Alexandre Courbot wrote:
> Add the `BitInt` type, which is an integer on which the number of bits
> allowed to be used is restricted, capping its maximal value below that
> of primitive type is wraps.
> 
> This is useful to e.g. enforce guarantees when working with bit fields.
> 
> Alongside this type, provide many `From` and `TryFrom` implementations
> are to reduce friction when using with regular integer types. Proxy
> implementations of common integer traits are also provided.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +                // Statically assert that `VALUE` fits within the set number of bits.
> +                const {
> +                    build_assert!(fits_within!(VALUE, $type, NUM_BITS));
> +                }

Since it's in a const block, this can just be an assert!.

Alice

