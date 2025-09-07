Return-Path: <linux-kernel+bounces-804625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7AB47A91
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AAF27B1F84
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93025B2E7;
	Sun,  7 Sep 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZKhdpmE"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2812264AA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242659; cv=none; b=gqixXxYVUZRtarNqschSlmllK8gFjm84y/spOAIkROuNiYaGgLAUJJuKWVEsCxVOEfiB9iqHCxYGHpo4WJkhwdEaj0y3pI1kixb8f32ZmmO97yGfzqw9JUk9pQ9b8juPyMrKsCGQCddnbgq9a8J4SEBd6x6s/5AII92VhZu+9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242659; c=relaxed/simple;
	bh=lPpPZRm5wDdiOlnmObs6/JqmfBFAenE2Kn0SI6dg+Mw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y/YqwaFzqo5eIUTompLHFKF/b4BEO2tz5ZkVdsKeQcjuIOrvEBujquitxH9SUR3QMB72rBeqtDoWK/DbbQKWqjrlWpJp4u9+OIyCcf66z7OWumLfIa7mXV1IaRNGm6MDy0LGuubRlldD/ZaDYY0WKZ5GKKNJ8LIwKU2/2D2yCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZKhdpmE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45de07b831dso4264465e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757242656; x=1757847456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bW5BS8l5hy9hs8XlT7fBWdVcrw/67VKhJ4W74l/W1A=;
        b=fZKhdpmEL1BozGkK59VxXmLw5WHDt8kAw7TVU1qcnazl01tqJaRqoUCSvKPV5+RKe5
         v8xAPyq+SUx4QLcE1Iq7zLwzkh0bfcBmli3JMuTS+NhAp+ICNOje9N+pT9iHOWXt5Ivx
         dbsjEWBAapAsJ7aw99sS3lkr/4IxcqWECEfhdoSzHesJYAE8hALcqm6mEwCXEzw0T45g
         j2PgWi0ZCEoK0adWztAGdfo0HlnHkVyqsbGSwtEEyInZ7rn3OAenrUSP1COCgYGupmI+
         CJAbNawavU99x8jXgK2Bt3G1Ea3vs9AFAeOJcywoguRnG/Zxxrk+tcXKPe7/SU0n1Whk
         lGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757242656; x=1757847456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bW5BS8l5hy9hs8XlT7fBWdVcrw/67VKhJ4W74l/W1A=;
        b=aKmn5NawlVkUGX05NEpmiLdJI+1+IN8xC4X5IwXOdXhkmrzdIOiYmAqmfG86HhMLw8
         5fZvj24CJfU66amjMb2/sQoFjga8QcZ+3d2AVGRBANDfmhLL6SoEUV8HbwWVnLmgooyW
         k6VXc/dHrikgUjzdBh8A/5Irhc0qZsfuo42tdaQcLZWLkl39sq4SUnXIE6Z1iBuhAJIh
         j8PiOhuT2XFoUaT9644Q4/HzjWYaJz2xaYeAJKpOo0LxWATJYKxMjQnY7n129RAIGZQz
         vTJSc8hEj8y2ezisfpZ6fOhPARR/heKVRsBOZSAPg10ql9BHfW3pawS9VStP+gowiLus
         NuDg==
X-Forwarded-Encrypted: i=1; AJvYcCU6E1fHvDtkVrCs3aeAE9KRcfk5tHqJWXWo42wvdq6O3O3+a0kf69l8AgH6eONFqt/sznNUfdmeFpXJDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHproTnvTeXydrlFT1mO+j2lbiUHSOxgo1aEtriP9k+855v+v
	p4VJIY8b2h9pZEhn1g+n6cBCxybszSK18vGdTRqzUHu8bv8S6nbmUvxIOg5YprJ3XuOOhKlxS4s
	/mL4Dxe4jpRLvfCwGkQ==
X-Google-Smtp-Source: AGHT+IFHWBdpeOOMGJf+wo6ol1QZ252iQApfx25t8bt4+q6E9lh+rGvi5+RDjvCHUYIHevj0+eJknd7d0bHkPSo=
X-Received: from wmbep24.prod.google.com ([2002:a05:600c:8418:b0:45d:cfa4:ce0d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1386:b0:45c:b5f7:c6e4 with SMTP id 5b1f17b1804b1-45dddedf9bfmr30888125e9.35.1757242656441;
 Sun, 07 Sep 2025 03:57:36 -0700 (PDT)
Date: Sun, 7 Sep 2025 10:57:35 +0000
In-Reply-To: <20250905140534.3328297-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905140534.3328297-1-lossin@kernel.org>
Message-ID: <aL1lHyhzWX0xGrmo@google.com>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!` macros
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Alban Kurti <kurti@invicto.ai>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Sep 05, 2025 at 04:05:31PM +0200, Benno Lossin wrote:
> Allow writing `_: { /* any number of statements */ }` in initializers to
> run arbitrary code during initialization.
> 
>     try_init!(MyStruct {
>         _: {
>             if check_something() {
>                 return Err(MyError);
>             }
>         },
>         foo: Foo::new(val),
>         _: {
>             println!("successfully initialized `MyStruct`");
>         },
>     })
> 
> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b898336e2d54f80715f00ce00f21f74d2f
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Nice! Would it be possible to include a user so I can see it work in
practice? E.g., for the irq feature?

Alice

