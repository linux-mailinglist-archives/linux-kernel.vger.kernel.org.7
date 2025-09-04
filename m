Return-Path: <linux-kernel+bounces-801604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D54B44778
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6171BC735D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A6286430;
	Thu,  4 Sep 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CytsPNQd"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A79284B4E;
	Thu,  4 Sep 2025 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018284; cv=none; b=MNd+5KS85DFABTOVjU1W7B6MO+UjvP/kVcVMF8B/aBN8FFMC0GEzkp1v+/LtETB0DlZGJVFz7iYJ+6SSLg5zoHSBS0BpapZbac1G8nOdtoRoYC9VGo5YFnFMNDZ+CIiqq3M3k2OmlTAkly4/vZNwvfBOiDnENf6w9b1aucC95FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018284; c=relaxed/simple;
	bh=jhh00s7ip+FeDC7Nh2hWPnkefeUX3xcGprPGO9tNdd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpTxC/VomGwgkVinK0QqZjqKVQk9k0IqhTme7R5lFVhF8Jhs9Fc+3u2xh0udIGnEoDD1914C0EUqB0+UDkjdMeAdb/amhPYo3XwB9OYfeXN8J3F5yVPidGXesckJNLIgkNFAArZI+VGv4JRnxYNTIiXasYigai2UFoJruBrRrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CytsPNQd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4fc0249e41so63638a12.2;
        Thu, 04 Sep 2025 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757018283; x=1757623083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhh00s7ip+FeDC7Nh2hWPnkefeUX3xcGprPGO9tNdd8=;
        b=CytsPNQdcEhTkbm6OSROeV4cTgTrea6mNIL9G5cTR0ab5KiQp3XKKHYJuk9Dy1weM/
         1bAlP2bCcacvbbbmR2mfEphqguz15d0JzpSZ+0Z3Dk1RbfdQlCM9FtEhM0+yBfvNONPW
         jII6dkfWeqJFnAg6iwoT2UMJVpYZY1+deDMlN1ctCg+leTXIZnMQAxwLneRcnxbHhoBg
         mO9X6crA/KwkG2/D60a9XSbIkPPUvKpt5vhhbEkeeQyIY5OWvY90aQSqLcarSX9pmA9C
         3zQHEM0XF6vVqFIEdw9YvvPhPaK/+82PFLUpVg3UQYt6ofHue9J0fwPbdL0ZlodmGayh
         fv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757018283; x=1757623083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhh00s7ip+FeDC7Nh2hWPnkefeUX3xcGprPGO9tNdd8=;
        b=cS5LTL3731Bhlj6KJ9eAfPPWPAWCaMzsjgBoG0KOL3cWk/jgGZzNWQW9eh2BncWLbl
         x75V7hWwyOTvdWBmywc1ss2WqohaMRHKjnvdkwLT3at4MRL9ZnkeKBz7qMwZYjmxz+rd
         h85rNRGrV0tT6Fn//PbjyDYYlCl6KtObiRZz2ZXOT9vb4FQvLyhEJBpPco2DZIaIRmsx
         eDAqpVZEqG6eY1bs1oA5pmH5cE2K1eD/j2nC5xs+hQUe6bL8Id3qXzxtiAyzohpyHu5a
         0b982CIxAQdzxZg62BL1OBNlMcVs6dfR1YmBzyXrnfBNfmsNVBfZDdCi69/DSPU0UjDm
         CoFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOWeyIYPEcKV1FdIPlJrkkWpH94j3hSQz4rHkTRizNxOSDqHOfKR1+TGD8uY1ySR/Z5BfaFKEPg/0mjV0MMo8=@vger.kernel.org, AJvYcCXZ8tyuj7uavhAnqYiZMwfJxiqEkTvV64wNgEDyxGr41bcH8LH9r4C7hApHqNiJNSP+d1KwjPtmb40+278=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uSqDZcOjK8whm0i1iE9n30vr7kyoZwsM/z2acJHEOVST5kVg
	lgZsQcNUuz9P2Xp1dH4FYcYue2q2IvdZHd3LBs4SDhBUmrQwfBobPY2BFJGjYceJPivDeUeYXaE
	OwhBGio9J2Qb58zs2gRsJ+HdJ70lj/eE=
X-Gm-Gg: ASbGncsvFycxLfk3CXwiq8RMhEejxRJfR0SU4gqgoLy7OIPvyjY0Ywdf2zifu/sisps
	iAQE7sA7HD1/QOde9pkKWp3PLkbgPTAT8e4sluXDyS7nJVyiu7xI5ugooAedrMAA2r/NIlB7+uO
	8onQyev+91FcBeHiTef9qFUD+mtycKxP5046heUBAU9I/yFuHz7YBGKQ4CMU/+kKGkUYL4oBy29
	rR2/c1SNJWXPpwQVHbvalBVQBgJGwkR4eRenesK0tHcYY/qILFoew9r4JBGexMM4QJQWP6p8OUJ
	F8+OCpcA1BpE/p3dOBt0GUWdrCeWDDfPrHFi
X-Google-Smtp-Source: AGHT+IFqx1GUCyWqYDe3BDuJ5rH+p0E80yA7Xljhs0Nix5yrCExt8EgPQzOmi9EaBsIyNxC+TxydT7c2/DwA9G8pP1g=
X-Received: by 2002:a17:90b:2250:b0:32b:aed4:aa1a with SMTP id
 98e67ed59e1d1-32baed4ade9mr1371213a91.4.1757018282507; Thu, 04 Sep 2025
 13:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com> <CANiq72nnWmzOfZ1PhSid4t_e-yWEgi_hVx5Uj4hrB9wzpuP6nA@mail.gmail.com>
 <68b9f3d6.050a0220.174510.28d9@mx.google.com>
In-Reply-To: <68b9f3d6.050a0220.174510.28d9@mx.google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Sep 2025 22:37:48 +0200
X-Gm-Features: Ac12FXx-tTsNVn2EwIk9LpKY3_SwIwSIlYHTvNwAjGyhRpyARFyh2FmCJDKByuI
Message-ID: <CANiq72nkZ0F1_YUfBg_y=JcEMnQW+uVr9v4BXONUJdor3ZJzgA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for DynamicPerCpu
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:17=E2=80=AFPM Mitchell Levy <levymitchell0@gmail.=
com> wrote:
>
> Will do.

By the way, sorry -- just to clarify, I didn't mean to remove
anything, but rather split it (likely at the first full stop).

> Yes, this is true; strictly speaking, calling this function without
> dereferencing the returned pointer is always safe. I suppose I find i
t> clearer that, when a function has preconditions that are necessary for
> it to return a valid pointer, the "safe-ness" has more to do with the
> functions preconditions than the act of dereferencing the pointer.

In that case, I would make it safe -- we don't use safety
preconditions to mark "dangerous" operations, so to speak.

> In this case, the pointer shouldn't be going very far, but I think this
> logic applies especially well in cases where pointers might be getting
> stored away for later (and so the validity of the dereference later on
> might rely on non-local conditions).

But that applies to any returned raw pointer, no?

> This flows from the first requirement (that `self` is a live allocation,
> which is necessary for `per_cpu_ptr` to return a valid pointer). Though,
> as above, simply possessing this pointer isn't UB, so it's arguable that
> any call to `per_cpu_ptr` (on x86 at least, I'm not sure how it's
> implemented on other arches) is always safe. Regardless, I agree this
> comment should be more clear (even if the function is safe, it's
> probably worth noting why the pointer returned is valid when the
> function preconditions are met); will fix.

Sounds good, thanks!

If you have cases you think other architectures may have different
requirements, and you think it is likely one could enable the support
for other arches and break it, then I would suggest adding a comment
about it.

Or, ideally, try to see if other architectures are fine already, even
if you still don't enable the code in other arches.

Cheers,
Miguel

