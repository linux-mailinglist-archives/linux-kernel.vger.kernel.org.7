Return-Path: <linux-kernel+bounces-863192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD417BF7366
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86DAB504B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB04340A76;
	Tue, 21 Oct 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVIOfilx"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318622D061C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058726; cv=none; b=lmcuvEZH8Q9aLA6F9+lwXM5pJ2XdQRu+lQ6WnC+4UHB/l7OPXqniiQORSh6naZaK1fIcUjEWGxANIHIBsCVoleIlhAma1hMk5GF0RYdAQKK4Hfd2mvYNTDJQXbkE2bpbu9JBoICDlQOW0pst9K+sObQPzFacPup7a9ivq6D7VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058726; c=relaxed/simple;
	bh=Gyq+NjhiKqVLnuujXH69Hqyu6MFhqZ78VaI+VUb+2E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9ah3OZt2MEyhgkQ7D7zaqFcPqu+gMIg9jrBaYMMcOvIUUFzPuE/pcqSN/dGvCexHDnhJVWR85HYJJh8fdcdToHGP/t+nuOTK1kLFE1l2iQRxJ7eVE5ZYkE7zTQaCyIxO6tBgdUAs5enZsrLmnk7PijGdP4K+fN7suBwR1Wpvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVIOfilx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bb66c96a1so1553095a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761058724; x=1761663524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gyq+NjhiKqVLnuujXH69Hqyu6MFhqZ78VaI+VUb+2E8=;
        b=RVIOfilxT7vxYb4x6snRYd8d/y6G/FudKfAxPUTZfn+2ZWZwDIwP5lAvAReELTbnqv
         H4ybI72f5a0j6SOW268kgDXwTJ+eAVWlhEEnOyP26fplCqeYpqxTB7p/rfZb57Ibw7f8
         re2rhVoNQIgZpO1qZsXSVrmQkLv9U0uJSZ6/loaxTAp2K2pO9PQjGxYwGbRqqq1N18ju
         dIdRxiAt/nznHZOaOKT7LQYeK74ek/3E/23+WFmq7JVdn3XcBDcVHW7M7KrFtHoXenYD
         E3ooBA4MslSofOwDX3wtlKIwkj1DTk/g2AxVKe0RiiPSek5jJ0OQsHsmP4EwFf5kNhg8
         wfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058724; x=1761663524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gyq+NjhiKqVLnuujXH69Hqyu6MFhqZ78VaI+VUb+2E8=;
        b=u3IyyIg/5/XXMdSl0nKculkyZf2r9NtPsPxB7P7di74ZP6qQU9+V4RgGrcQa7/kTNr
         1o12HpcQr8a9aigMXGH4ADu7fYGc92EF9jdJ1EQci4i1uX4N+jz9C/6yVH5MXVcEia2i
         aHk0abRDLMOD+P7hRGlWlfMoqDW3dTMhzRSc6EI13UpsbmxO1UpQAt+atPisFNMDwfH8
         SOLb0lkSJbJp78hMdw4MmDIDq/PBgYShodnfkVGJy4Db2tmKrwOXx7B9ZDj0lC9ZFNWU
         77APMyeG7Pc2Fi4gIOfzSZnYuBfYA/mCf6KnTwzVvVihB1BoB4NrzjWRgwTk00H8NGjM
         8fyA==
X-Forwarded-Encrypted: i=1; AJvYcCXLQYXnbR24gFxA1EaFHM8Z99Ay6+wLiTHKR6Tos/ASQz9VxhxUflH8kfaC68y+Rtmp+9bZeGxvcwJxxB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxCv6xpCr6EioBpoCFtTNkLnYw8e5XGT6QhRIq94/cLfe+eKT
	ZY15osgdTh3u4brj80IBUfn/5THZ+pm+ZXOCzBklh75Fz/u9Kde6A8hPQt2ZseNjgDYnDA2C10q
	Y7g4oLKpPRnv1lEa1zQ90LUgneIOhaVc=
X-Gm-Gg: ASbGnct1zX5t39DKujVYVi44AVgD/6WqgvgT75Yv0NhWVpm6nLQrRyxnvA5TPWXkJn8
	Gy3eW9bQl4CFMibDz9gfO97grQQsK9hQVD6djFMdSwVWsEgTBmmE6nvY+cpw9fmB3M9mL0t0/v4
	ysj8uq08Wigdzj8ioKbmGl3pMp/3EGnNPyiW8ty61begXN63FKIYoUpfXsZSMaeoeHP98rViYjs
	TaoggIb2bqc/gDtAla6Mra5EoVSfPy5uPH66JjedZhiBlEByXm6k/7YIXRZt6VsEZc/fn+vRN4b
	/4PGk899uJqq+9BSslg8q3b8FSAjbxzN8Az3Z2Yi1qRBfXOC8v1dgdQYSa7JAoRK7jllVNnLm7F
	Uzr8=
X-Google-Smtp-Source: AGHT+IF8U7aHVuqLNukPYI1Z6fbz7kccYaz5TMejDf5NetEDaXPajidIApPI7hCnWhm6BSXxWODHy3+BBqh1rlaFwGs=
X-Received: by 2002:a17:903:2bcc:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-292d3feca86mr22781715ad.11.1761058724495; Tue, 21 Oct 2025
 07:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com> <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
 <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com> <54328318-c235-413a-a069-5ea93f1dcb2b@kernel.org>
In-Reply-To: <54328318-c235-413a-a069-5ea93f1dcb2b@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 16:58:31 +0200
X-Gm-Features: AS18NWB0fLmSfGSi59zQ3L8rJftxfYIoazmWWuxcCF_4YjbrFrne7KAPBys4oJA
Message-ID: <CANiq72=eOYk=WM5xfMkHj-REYjedYiYNakVvfto-AUL5E0O8qA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com, 
	daniel.almeida@collabora.com, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	ojeda@kernel.org, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:46=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Given that we'd have a WARN() for any value passed that is > MAX_UDELAY_M=
S, and
> given that WARN() is considered a vulnerability if hit (Greg, please corr=
ect me
> if that's wrong), this would literally become a vulnerability generator. =
:)

Yes, but only if hit in a way that can be triggered by an attacker,
e.g. user actions, not in general.

i.e. that is why I was saying that someone could end up calculating a
delay value based on something e.g. user controlled, and then gets an
edge case wrong, and hits the `WARN()`, which is the "bad case" and a
CVE would be assigned.

A `pr_warn_once!` plus `debug_assert!` (or similar) should be a fine
way for having EB in functions, which is a useful concept without
leaving it UB liek in C nor going with a full `Result`. I can document
that combo.

Cheers,
Miguel

