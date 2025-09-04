Return-Path: <linux-kernel+bounces-801582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2780B44724
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91907B8B33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241E27F01B;
	Thu,  4 Sep 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpg1Sss7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F52798E8;
	Thu,  4 Sep 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017049; cv=none; b=qE+SJjDgnN059GYo2JLc2kQwWitxnPpzEfPLpJBYIrLQezg1pihvxBay9yg5RttVqX5Ox8CXbRJMYxICTZyYYbJQwYTrphHFJV75ErNkbIjHjf8wT52FWvbNPiH+z6G6i14pJbXZffG6ciiFgTgmzKmMPzQXSot3uXgqfYxM48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017049; c=relaxed/simple;
	bh=akmB91/5JsklOIohA/swf9n23yiBDEKyGB2/pWCMB2o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN9MZ7V7PLwHKe9lFCtvR228YESFs/FbukuQXsMXnUZz33BMfxVa55rpaaYQPQLqQoYSgGNAh5GCSd8KQRFyNUWsq3PKTT+8uzF+Z4Pe/63B/kkdyt7Q4U0Qwr3Gi/j03Oymq9RE2oSGZSfNKTp6sVxHRT90kiPZWGvUCpe5JH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpg1Sss7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772679eb358so1402811b3a.1;
        Thu, 04 Sep 2025 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017047; x=1757621847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pq20/wlph+/sfx7lO2f1OE11IHMFYfLN+JkAAI1PIb4=;
        b=Zpg1Sss7aQf76tyFxr4vwPZ/Va//Zn1MOBZ6N66J2z/Vl6666hcfEz13JokihNUb17
         GZfk7ZbqiH4hS5VZJIULabmVLHkQpy7+Z7+Iy3mq3iBlNx/5BSK/lRhBt+KGdUSDniKw
         RhZS30f+BjEe8/GwhLdWy+P3GWYWbVyqk2mrlYOxSAjO8PYQmRwb5sKqYLRHLKc9mlEg
         sCHHYj8ly8NchleE43Zc8AOa0iii/J5Q9x2beQLAAUT3uTd/6wrSj67thUW3bGwe6VFW
         dtso27OCMC6W4HqCJK6zNqa3F7714RYgoCUooLGVmfIPpVR+JHi/w+gHOlt6v1Qw1yrv
         czLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017047; x=1757621847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq20/wlph+/sfx7lO2f1OE11IHMFYfLN+JkAAI1PIb4=;
        b=cvmNIVsaWrA1z3rMB85sP+tYvsmLFGEWZ8dHvsuZwV5tS4ggtiKcENRx/J3xn0Tmoh
         ISH+Z2assVpMdEi+rNHY4gr78aeKl3DaebLbl6+ZGChBF1jSezSc7ZbGm+dt0G7nf8g9
         VV/l+MBUkQ+oEzXSuBLclMClZJAD69ZtSLbXnRV64GMEVDRzkWAjfvHQ7Kd6jGC4ldJe
         hZN7igiqHq/otjqYM0V4wNtZ+1q9hUodZoKP8Ro0w3aeptUYXqIYOdhQ6Xd4YuSwNyXE
         NU61zVkX8jxkzO/2i8BEP8Uk+GtKUX5nrKiwzhvk1C4p2LcjOFkG/FwdlI0aqehblTy/
         IH/g==
X-Forwarded-Encrypted: i=1; AJvYcCVO6TW6gPQVUrVUnRbgNZOz5iPg/4pNgbKRPKQUEOOKdTb/f26dCqGOgiGU8qJooa0ZrERkvnt+e6m3e3GrorI=@vger.kernel.org, AJvYcCWpRhbhNoVarA/O2SILA9IhFbfyM6p1FOz9wLOpW4DT9oQAMPq0SReLBBTYlqua62BwM8hlwYmi8edhZwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzduVksNNHrf+mqeH5wEfCP7TVyFAIiWOIacQU+omng1OHUNmC+
	6rFCozhTQ3/SXP5Ay3VbWjjyYCY/NG4jox+JTGEmwBm6kAfg6tXJ9U+m
X-Gm-Gg: ASbGncu8JA020mNBT38yuCfuTR79nh64yY/K3uY/HTWhviaJI0nlWwYfBS9fHbc9u50
	+3BbuX1miH9k73QHRACKWK9agluIcQgsxe40+hBD/N2zrXn/s3DU/RUQqpkuPka/XXolI8K/hpo
	1+e4oBeQEQ/CKdB2IuHAmF76yIb90pxLiOIdAnPslvy3CsWhRmrNDsvi3CJS6cyrEkVEoLv84mB
	HiIOwkwwmBeJ/wuqgLpvSbrql+qJw2kw7a9G6F0F5Ue+jv42CuuHeRWIRpnaWohRkwaKKJEMuLG
	Z6RW9qMxq9GeZ3EJqU3+eYwV6S4JIrgYEoEJDlh2v9PBLGCzZjBt86uTgolSyq4GPr1wF2yNF/6
	wrWpTxEY4SANjTWon+V6WFNyDdlS02M8QUHFaaA==
X-Google-Smtp-Source: AGHT+IGtYbHSzsT/hKR4OTH/QsGVO8hm2oxQsP17KMB8YDd+oFWhTdXnU1XAVUUiBDw8vBTOxLxecA==
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr21653637b3a.23.1757017046728;
        Thu, 04 Sep 2025 13:17:26 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bfe2sm20265198b3a.14.2025.09.04.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:17:26 -0700 (PDT)
Message-ID: <68b9f3d6.050a0220.174510.28d9@mx.google.com>
X-Google-Original-Message-ID: <aLnz01wMxA73GRA+@Cyndaquil.>
Date: Thu, 4 Sep 2025 13:17:23 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
 <CANiq72nnWmzOfZ1PhSid4t_e-yWEgi_hVx5Uj4hrB9wzpuP6nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nnWmzOfZ1PhSid4t_e-yWEgi_hVx5Uj4hrB9wzpuP6nA@mail.gmail.com>

On Thu, Sep 04, 2025 at 01:05:36AM +0200, Miguel Ojeda wrote:
> On Thu, Aug 28, 2025 at 9:01 PM Mitchell Levy <levymitchell0@gmail.com> wrote:
> >
> > +    /// Get a `*mut MaybeUninit<T>` to the per-CPU variable on the CPU represented by `cpu`. Note
> > +    /// that without some kind of synchronization, use of the returned pointer may cause a data
> > +    /// race. It is the caller's responsibility to use the returned pointer in a reasonable way.
> 
> Please try to make the first paragraph ("short description" / title) smaller.

Will do.

> Does "reasonable" mean anything different than any other raw pointer?

This will depend very heavily on `T`, there's a detailed discussion
here: https://docs.kernel.org/core-api/this_cpu_ops.html#remote-access-to-per-cpu-data

In general, remote accesses are strongly discouraged, and my intention
was mostly just wanting to reflect that in this documentation.

> > +    /// # Safety
> 
> Newline after section headers (also elsewhere).

Will do.

> > +    /// - The returned pointer is valid only if `self` is (that is, it points to a live allocation
> > +    ///   correctly sized and aligned to hold a `T`)
> > +    /// - The returned pointer is valid only if the bit corresponding to `cpu` is set in
> > +    ///   `Cpumask::possible()`.
> 
> It sounds like the returned pointer can be invalid without triggering
> UB -- could you please clarify why the method is `unsafe`?

Yes, this is true; strictly speaking, calling this function without
dereferencing the returned pointer is always safe. I suppose I find it
clearer that, when a function has preconditions that are necessary for
it to return a valid pointer, the "safe-ness" has more to do with the
functions preconditions than the act of dereferencing the pointer.

In this case, the pointer shouldn't be going very far, but I think this
logic applies especially well in cases where pointers might be getting
stored away for later (and so the validity of the dereference later on
might rely on non-local conditions).

All that said, I'm alright with having this be a safe function, with the
documentation noting these requirements for the returned pointer to be
valid.

> In addition, please use intra-doc links wherever possible (e.g. there
> a was also an `Arc` elsewhere).

Will do.

> > +        // SAFETY: The requirements of this function ensure this call is safe.
> > +        unsafe { bindings::per_cpu_ptr(self.0.cast(), cpu.as_u32()) }.cast()
> 
> Please try to explain why, not just that it is. It isn't clear how the
> safety preconditions, which only seem to talk about the returned
> pointer, make this OK.

This flows from the first requirement (that `self` is a live allocation,
which is necessary for `per_cpu_ptr` to return a valid pointer). Though,
as above, simply possessing this pointer isn't UB, so it's arguable that
any call to `per_cpu_ptr` (on x86 at least, I'm not sure how it's
implemented on other arches) is always safe. Regardless, I agree this
comment should be more clear (even if the function is safe, it's
probably worth noting why the pointer returned is valid when the
function preconditions are met); will fix.

Thanks,
Mitchell

> Thanks!
> 
> Cheers,
> Miguel

