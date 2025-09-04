Return-Path: <linux-kernel+bounces-801652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14FAB4485A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33D5873B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41992BD597;
	Thu,  4 Sep 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqRdrM9d"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B601A23A9;
	Thu,  4 Sep 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020639; cv=none; b=iJj/nGrMVzMZP2Q5WAs6esuubapeXP4+iEnUbao5jY3UGM6cVmJMkSzg7Ds2MgrDXaicHUIq+7cStZvv+NO79EXm4aXxe/WVAB+arqd4hAujZ3Br0jI+H5yWS4TuhExyTC7CPv5NRPdOUS2GV197gQsMoLnZNItTyp++oorHM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020639; c=relaxed/simple;
	bh=iAdRiJXtRT5ddNYZ2h4yf+SUvlLPVO+1WbmGgumlLXg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTb30vJNIb/5w8wtX61c4NdJIhOXwm7SJhzEvBp3ITlm6fYkkAqXLqz9wG9mk+aOX+yCB7OPZEdL1u2qnfU39O8J/QGW2pJ93I0g82uarcxmzdZPfbQnqeDRpfEeCiSHZZmjvUC4vl58DsR/UU+Hb9CRZhFGogq6OH/vNdRaSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqRdrM9d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772627dd50aso2941326b3a.1;
        Thu, 04 Sep 2025 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757020636; x=1757625436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=px3Ogp6YWCHs89tEx1iBwQpFNyIvSJt4gg+izDxpdC0=;
        b=eqRdrM9dQ2zka/kK61zNcyyavIWeGx3ifsOu1XJsBZKpfiZz0/mS8RE8FlTbeBr+b4
         73ikt/iwTRN2OfmHfoMYXDJGkCSK7g+hgSfSGCiWbJG6FZF2I+AwQs/+aZkGbSwGe30i
         FQZNapJx79NUGXLbJHKzzpcg3m40cOx5yVgViYLPRpMjHWlf4iNqs3EE5oTC3OES2DyZ
         hiBhiJlLqUzBm64xdZLJPFBIfwuxtuK0pY74VTDOPng5McIRisdin7XW783U3H38IDdt
         4pYvf4uUZrTHG1VNOwSXk2vDoWEHle2be7r3XC70sfkSu4l8bKzLBDpoAZtAkvJUl3cJ
         F+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020636; x=1757625436;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px3Ogp6YWCHs89tEx1iBwQpFNyIvSJt4gg+izDxpdC0=;
        b=kRkpQCNi8UKl1sUqQHgQQQdUHnGhJcrakPZ1czjPTObKPMlEGX7Qex0MW0hK5ymtEH
         dXkC0tfyIE9NrzDdEUrRedZKc1TPSj7V7FHMgotfqyaSyAc57zwJ/NEXZcYNqhtYiCDj
         0Iq0z2fsTLY0FDu7r/MV2TacHO5IGw39Z1e3+EUFoYnEfa1bGhL3n/OdoVD3bGxA1uK0
         yC+B2U07kg3EqRkZoREXF8hQnNDLcy2sXB22H2dwBNPFSVDgKtcrjIPLqu9aiaSh5cow
         6L563aP1A1DIoZTRSyG8Jdj6YWrM6/llyWASF21XCZiG9LHL/ZJ6F4QurTiRO8ZAOOyc
         ooNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUitIGUiicE3wqF7qc5vCJbf/hooVmrlaPrIL9FhBv9uL7AWZbd99p80SB62sRI1jXMPh73pW0oMyStpr5w0fg=@vger.kernel.org, AJvYcCWfnLxirPqEwIootpRvoPzxk5jKP+UdwgkrS7TCx6Z4PEHdMFnIaThWqOwczU/N97iFfhXg3QiV5HAHNac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylfeg5GH6U6NzocNoC7YU7zWTsgGrW90SxYeiWvRDjYl3EG1YQ
	M3i6bEkt+ajrH0lxawgT8h9x2X3cdw81oA/Wp+KJL2xjgDyWJoI0Rhr1
X-Gm-Gg: ASbGnctvF0ehVaMFeolY0OS7gFrydA5yAg+kAUc5SzOD80i1Dff0Pr9xcazcMt8mL1M
	XKfcZhVJGsXQPlEZX9OTI15GyKDJeJqc9HWYIbQjC/QaQqmz8HvNxLNY9AKNGZSBNmsxwdIHtoM
	ntxnk3oXWQB+m1Bm2ILonmSYtrpm+ufv/VCu+vhSrVEJphdC2ODv0+hObON5neHViRQH4y+t2wj
	/BJGvKQMTm3y9e1/ncNzZrYmTJqfHZOqYgi0JDUlYdB7vXyMHqxkau0bedMInAU0Q0lYyzwqgBl
	Pb15VuoVmgf/l+mP9XEP5EpP5/vdjaAY4YlU0Eg/tSaAH2tqXQkzLD3+iQ5fCDBCYO1oIqjvdMi
	gZPqqGMUApaq4aNG5BS2EZ8u3WSI=
X-Google-Smtp-Source: AGHT+IG5l20PWWMfzJjJHKvLY6V0Xvg6JZ009OTeub2pHn29i1TL6bxezyUFqKnj2cbj0Z5C4lE+rQ==
X-Received: by 2002:a17:902:e945:b0:24b:eef:643c with SMTP id d9443c01a7336-24cedc6f3f1mr12554305ad.5.1757020635583;
        Thu, 04 Sep 2025 14:17:15 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cd5092951sm18811275ad.18.2025.09.04.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:17:15 -0700 (PDT)
Message-ID: <68ba01db.170a0220.31417f.72dc@mx.google.com>
X-Google-Original-Message-ID: <aLoB0+aEivX5jEuV@Cyndaquil.>
Date: Thu, 4 Sep 2025 14:17:07 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/7] rust: percpu: introduce a rust API for per-CPU
 variables
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-1-4dd92e1e7904@gmail.com>
 <aLi2MBAwoD65tokv@yury>
 <68b9ee59.170a0220.a7a31.675c@mx.google.com>
 <aLn2PzD1KRbu4SpZ@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLn2PzD1KRbu4SpZ@yury>

On Thu, Sep 04, 2025 at 04:27:43PM -0400, Yury Norov wrote:
> On Thu, Sep 04, 2025 at 12:53:59PM -0700, Mitchell Levy wrote:
> > On Wed, Sep 03, 2025 at 05:42:08PM -0400, Yury Norov wrote:
> > > On Thu, Aug 28, 2025 at 12:00:08PM -0700, Mitchell Levy wrote:
> 
> ...
> 
> > > > +    /// Get a `&mut MaybeUninit<T>` to the per-CPU variable on the current CPU represented by `&self`
> > > > +    ///
> > > > +    /// # Safety
> > > > +    /// The returned `&mut T` must follow Rust's aliasing rules. That is, no other `&(mut) T` may
> > > > +    /// exist that points to the same location in memory. In practice, this means that `get_(mut_)ref`
> > > 
> > > How long is this line?
> > 
> > 102 chars, or 103 if you include the newline. `rustfmt` doesn't break
> > the line, so I left it as-is for this patch. Happy to change it if it
> > poses a problem, though.
> 
> Then don't use that tool - it's broken. In kernel we used to have 80-chars
> limit for the lines, recently relaxed to 100.

Sure, will fix.

> > > > +    /// must not be called on another `PerCpuPtr<T>` that is a copy/clone of `&self` for as long as
> > > > +    /// the returned reference lives.
> > > > +    ///
> > > > +    /// CPU preemption must be disabled before calling this function and for the lifetime of the
> > > > +    /// returned reference. Otherwise, the returned reference might end up being a reference to a
> > > > +    /// different CPU's per-CPU area, causing the potential for a data race.
> > > > +    #[allow(clippy::mut_from_ref)] // Safety requirements prevent aliasing issues
> > > > +    pub unsafe fn get_mut_ref(&self) -> &mut MaybeUninit<T> {
> > > > +        // SAFETY: `self.get_ptr()` returns a valid pointer to a `MaybeUninit<T>` by its contract,
> > > > +        // and the safety requirements of this function ensure that the returned reference is
> > > > +        // exclusive.
> > > > +        unsafe { &mut *(self.get_ptr()) }
> > > > +    }
> > > 
> > > Here and everywhere: would it make sense to enforce it by testing
> > > the CPU with preemptible() before returning a reference? 
> > 
> > The only thing we could do would be to panic, which I don't 100% love.
> > Another alternative would be to take a &'a CpuGuard and bound the
> > lifetime of the returned reference to 'a, and then we don't need to do
> > any run-time checking at all.
> > 
> > Originally, I had left this to the caller because it might make sense
> > down the line for some complex behavior based on per-CPU (e.g., per-CPU
> > refcount) to do all its own management of per-CPU variables using
> > `PerCpuPtr` as a core primitive. In these cases, I believe there are
> > some times where being non-preemptible wouldn't actually be required
> > (that said, my thoughts on this aren't well reflected in the safety
> > comment, since I said it must be disabled... gah). But, the more I think
> > about it, the more I think these use cases would be better served by
> > just using `get_ptr` --- conjuring `&mut` references seems like it would
> > be a big footgun. And the safety comment already actually reflects these
> > thoughts somewhat :)
> 
> If you think that in future there will be a user who will not need to
> disable preemption before dereferencing a percpu pointer, then you can
> add another less restricted flavor of the helper.

Yeah, that's fair.

> > For v4 I will probably have this function take a &'a CpuGuard and use
> > that to bound the liftetime of the returned reference, unless there are
> > other thoughts on this point.
> 
> I don't want you to panic just because of invlid user call, but
> whatever you call in comment must be enforced in code, right?
> 
> 
> You can use the guard, if it guarantees the preemption disabled; or 
> you can return None; you can create CONFIG_RUST_PERCPU_HARDENED for
> panics.

Yes, the existence of a `CpuGuard` guarantees that preemption is
disabled.

> Please refer the recent bitmap API wrapper, and how erroneous request
> is handled there.
> 
> https://lore.kernel.org/all/20250904165015.3791895-4-bqe@google.com/

Thanks,
Mitchell

