Return-Path: <linux-kernel+bounces-868484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E102C0552D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBF5407D50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C83090E5;
	Fri, 24 Oct 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPwmNaia"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA7306485
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297444; cv=none; b=XmnK3oBxmi6+tQfopsn78oRidIMaaFKjDY3RX01I2+hXxQHy/79zDMZ3XKZ6+l96ZR9irJ7xNXeOGovQPsoU91O0UUOw/n23NRyh8+XdsJf7K5S4xx5OBpWs+zRneQhrbPVukfdXtwddaYwrBsxJdIO+v2aWiPXO11HOWxbzJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297444; c=relaxed/simple;
	bh=gNJPqjV6kK3WGFQQq/V0cc7zowpWRzML42SoOyIQPtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Se3Xukdt8CP5ZRHLiAGbh2WYE6JqqoIVpTOnrI4vOz8k0bq5oaeP66zhk/ehdYbUYyIy2sTf+9lCPDDp7PlOwLJOvaUmkwf5p18rmEBLEoDQ75pWiBfi9WGIpZ+0eBXWY4IkHwBzHWW3EjyG81zv4V6p/KlYGFUUhsi8/QPnhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPwmNaia; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46fb328a60eso5583945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761297441; x=1761902241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6wYhnWOu4HUC294Om1L0/GzEXAdBMUsewR7Iu4+cdI=;
        b=PPwmNaiaSWoSoOiYX/4nH7e9DVzxvpTkDn8KkHXJi8hJn9aU9zN+Q478eVOJyKK6Qr
         9o+ckNchu3hfSVV0jy5G61jgNV5eUGGYVz7oU2tA+u6VcRngQPxdCkOJI64ND1zwrZCR
         fjADAYSPKxqrWR2nbj0KjSTxs8kWidkBOmgBsJha6plxRaBbJZxWFRgLa3fN3yyORdN3
         fJSKl60xS/pwkiZ7Nk25LtlSFxO4z2RFLzHVVkOQJDHJoK2gzYDXbEWK7SooWJh0uDXC
         uFpQ/yW4wUsIiljFPM76WBN1T6BORHxgZHwYslgf4TuPdsV5gh6mudkDN6+CsvtT0Cjh
         DhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297441; x=1761902241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6wYhnWOu4HUC294Om1L0/GzEXAdBMUsewR7Iu4+cdI=;
        b=sySPLC15Iq1dpns4nb71sEDZ3vdOi/W/xmQDkZzZWv37QxarjB+mQ9J94W2HAjNpCk
         05it5Wpgp/vkBsqyJ5z5dw1WejfbGfMNK31oRwUSAlV0jv2FRaZ3It9HFdvpAkCAuN22
         8tIuZj4Az0sFx9pG4EopK5jR0kllM2K9PWHFwi0vFJiPUla1wrdlzrTw5zhLfYe9ppBW
         7Q8zEK6K/oj8Xzd7mcWfqDvvEK7ZVBe2hkI0Jf3OF4uI4kN1JGzxzCw68jDlq/SSWmaA
         v4L32ASGFwhTi7VvQv7N8fe1wlgTz1QRjSajkpII6F1w2yZCMjLbfIBfe7lGX2lwx+IN
         7lfA==
X-Forwarded-Encrypted: i=1; AJvYcCUwMatzWQ5MkDP2HVCvUkmb1HVrDQqm+ArDBFofZkhCp2h78J3g+rTnciNLnjwIzXMD/XZP/Wewodq5weY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWBHe1vDPMhx/UI1P3sz/XYcHqYOByoqdhmQHDI6sRU92wTpw
	ZjdCqnYnZxlPpXaDLah8dRz5rd2pyW6ezgAPpL+BHC9QdxLLofepgg41hvcpFG5Rork/OTpd5DW
	kxHYQ4RR0hIwKyIPpmA==
X-Google-Smtp-Source: AGHT+IH/WIt/1A98hPXg4ucUKKx+zX3VscsazPNOSByXZiXdNmxXU300WI/XmlWHMFCv9sa1dHLygnnmTe8hKsU=
X-Received: from wmco22.prod.google.com ([2002:a05:600c:a316:b0:45f:2b4d:3c2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:420f:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4711787dcbdmr192790485e9.15.1761297441253;
 Fri, 24 Oct 2025 02:17:21 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:17:20 +0000
In-Reply-To: <aPpnwXGo4P4-WI6v@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
 <20251021-binder-bitmap-v2-3-e652d172c62b@google.com> <aPpnwXGo4P4-WI6v@yury>
Message-ID: <aPtEIKvcOJJiE2yR@google.com>
Subject: Re: [PATCH v2 3/5] rust: id_pool: do not supply starting capacity
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 23, 2025 at 01:37:05PM -0400, Yury Norov wrote:
> On Tue, Oct 21, 2025 at 01:32:45PM +0000, Alice Ryhl wrote:
> > When creating the initial IdPool, Rust Binder simply wants the largest
> > value that does not allocate. Having to handle allocating error failures
> 
> That "value that does not allocate" wording is pretty confusing.
> Maybe:
>         Rust binder is initially created with an arbitrary capacity
>         such that the underlying bitmap is held inplace.
> 
> Regardless:
> 
> Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

How about this?

Rust Binder wants to use inline bitmaps whenever possible to avoid
allocations, so introduce a constructor for an IdPool with arbitrary
capacity that stores the bitmap inline.

Alice

