Return-Path: <linux-kernel+bounces-775603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D622B2C246
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CEB188CACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B032C32C;
	Tue, 19 Aug 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1jUQrQB"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612932A3DE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604397; cv=none; b=aefmqpLQSjSd8Q5+CKt0iQT7CoOTr7ZzTLqwUjFFTrBCy5W7lyPGKrHT+Jx7bzKY+Q29O9GIYuVXXLpduiUyzxyCB2W5ZRC/sBgcv8bGBNBVY1+vlHiF6qSAzIACWX9PrgMXFYTT3ag3gihwS4O6tIvy83piXJZ+LjOIy+HCEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604397; c=relaxed/simple;
	bh=I9kaocHcpdjExnXypb8WpQ01pHs47QTzq4hV59I9qmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYy/bUKl7F+qdv/E6Vx6lnZy7WwFHPCJ0R45djMBokfyhaMBb4RZSFwp9/BaalX2fVvn5guboZubUmCtAvKWSPUfn+mcKL/ydZANkI0a77HGGDY/K9mwlwczGZ5uCpVnlQjZEbpxEgeSsdcEePNBf4zHnw0sndrF1ws+/aKoDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1jUQrQB; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9edf80ddcso2753976f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755604393; x=1756209193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/n/RzlOnOSbc3ctN8YNH+OqdETSM7TkL7IcD9MY3wg=;
        b=u1jUQrQBDTl0D2ti/e69cdqFDgCQrnV8s4xt0IBGovtlx+1gwMxOK760V7EkQGu4Af
         jEbZ5Q6x3/pn86zcckZzvGH6WXPJylCkhbnlic4JVrK8+b7f3BDEl6aZN0426OpK3aZG
         vFlXqOEE2qTjDcGRJlFq5uWIKourXDjrPv98757bRv7WnNec2LyAe00I4l7jvmuwxJRE
         gqOZ+sJBQt270OALtzv8Yrgdb5xMI9R5m+vbflc2P5poyMs3M6ITxbjW6dlxc6Oy82kz
         w24iGE/2la22bLrJwLGANwV9LTNre1Xk4CxOzbFV055RFF+/vYY59OyzfXio7GVlqONo
         XjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604393; x=1756209193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/n/RzlOnOSbc3ctN8YNH+OqdETSM7TkL7IcD9MY3wg=;
        b=LX/hijwxpAKXzB6xiT/sIOwykcnbdKn8Gm45lL0KjRFGowtVNt85n0hZx2yo2QxeEq
         4t9McEppcdFRECxKyQ5cGjal93FQfT0LAt9r0EAlnpeUpmx3vAeStaYh9W4YwtbqBqWm
         wTatYKuAMF5qZKJwV/rv+3GYfGca6gBSfctJLRyq14Zq0THGdeveEujkf/qI9p8N2Rlz
         haCqRQSp4iRHsd++cQW0RrSIF5Z2k0NMo/6aHSEIonX8zqm/ZD9I4w2iGM5aXQAl1BWz
         zgKLAT1AyjAWS34i+xIUdgKg6mRBwphwO88nhpXGprhUlFeSdpJl+0u1O4RhmQmzAqi+
         IL8A==
X-Forwarded-Encrypted: i=1; AJvYcCWd8cCXsGVNakh104Ew3ef/8iXEbcDGrbhaxqOHetT25Za4O+Zzfwkx9/9+JsIAI/oVStCiCd8O8BtHZKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBLvVofuQn1h9hvix/BjO3h9bifVitKPP4I4HlyrqdYuhNM9A
	t/2qzk5dWf0fDrcYe3NYjTk+VLAg98s1pkxykjKhYdK95mtUrqDVLlrK7qiK1g++mkXdSbvSVJP
	iFmgpr5Ey6Mgp2kPx6g==
X-Google-Smtp-Source: AGHT+IE7f2O72gPFvlZmpRhidugQTwHJ1mrZUd7dkrJhh6U3uYwMjLdOZbZZsES/4VMDcuQwJoHeY0AKWrYXu7U=
X-Received: from wrph13.prod.google.com ([2002:adf:f4cd:0:b0:3b7:7461:467d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2909:b0:3b9:16a3:cf9b with SMTP id ffacd0b85a97d-3c0e00a2289mr1865237f8f.5.1755604393422;
 Tue, 19 Aug 2025 04:53:13 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:53:12 +0000
In-Reply-To: <20250818132806.134248-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818132806.134248-1-shankari.ak0208@gmail.com>
Message-ID: <aKRlqA_Xa3S4_P1a@google.com>
Subject: Re: [PATCH] rust: miscdevice: update ARef import to sync::aref
From: Alice Ryhl <aliceryhl@google.com>
To: Shankari Anand <shankari.ak0208@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 18, 2025 at 06:58:06PM +0530, Shankari Anand wrote:
> Update the import of `ARef` in misc_device sample to use
> `sync::aref` instead of `types`.
> 
> This is part of the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to the `sync` module for better modularity
> and type organization.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Greg, I believe this should go through miscdevice. It's not going
through a shared tree.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

