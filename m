Return-Path: <linux-kernel+bounces-801631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E1B44806
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F51C823C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9329346F;
	Thu,  4 Sep 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQmFlp4Z"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161A28DB46;
	Thu,  4 Sep 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019935; cv=none; b=vAHHE6pYOk7WtB36owvkn17qkj+LVgThryuGkJfkLEDW1XQstFVH95bzS1C9xZP4kOMH4JJBckxp6nL3kbQC0r9WO9ASwxG+0esSU5+bxidmFzbMutWV6/SauNF4TrQ2EbUf87cu5BU+t2q3H64DIwxLib4vJxK5wJXzsesd1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019935; c=relaxed/simple;
	bh=pywoOeEESFWdfylHO8uqiS4BGL+csxqD2zObt34MaAk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyg8z/OvXFmcegh4lztNDOD8Ovx5iEzLiTqRn8pfbRpBGym4j+lT24J7PMN6vKNgTHbFxQnp5WAdX391AR/aqMhr9zkW2BCoJfM1VVrEb+ekgIdYkJ4rO16u8wlHVbddbNlPt8NUH5ZPMvR1kb/Hucjx8kZzsnLcrS9ORKp+KWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQmFlp4Z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so1959832b3a.1;
        Thu, 04 Sep 2025 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757019933; x=1757624733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pePvqOR7Q5lmGezz3Zl2SMH1cqCRYl41xACklsYlDnY=;
        b=DQmFlp4Z9B6BlsiVOSOdqeO8UdoiRmgOtSCJctN5XltG6sPRBmiSzt7b9kgWBAVw9U
         wFdZbLO42m12pGyCKDmI/Khovel/4Z0SVmGW5RoW5kTYyHe4iAk5p3h8yMLhUZWPZ0Ok
         9PD7AyQufRdm4wvyHUX5ONa0onBqbYSMGsaox35e9MbN4WAf5wqRvDF9zc98UNYAMaKv
         pt8inPe/1kDmptHyennpdIWz0hiyb1jcjWcDAQLHDwGToNk4xZZXVp9GTrCZog2Uc6DQ
         tAuPu25nJcq5fOZYF0pt/Rotji5NiDV82tXYP7Is2R60TzURcnrQSHg56zLio/QVnFWW
         YlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757019933; x=1757624733;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pePvqOR7Q5lmGezz3Zl2SMH1cqCRYl41xACklsYlDnY=;
        b=VofiQJxOYwaKj2it9PhhLSp8a0XB+ymU4fWVwHCw/1+yf4gfnhBHN3e3Y7ARb+SjCI
         v3grEfFVU+GjmFRAXivjoEQAUWWBUXVY7uNg1lGdM/yzp7MV2ONPfWkaQ974dOVmHLuV
         8ZQb2wYsZqqqQdMv1AlvIzvT/9M4p00HkgW2/6SfcOWqI0HOBbcTOSgbynSgMr700Wnm
         kyvs+NzszDwzbxI3jceKYCOzGspZvPs0qO3OTGfhl/UQgSEOIt5KOgHpEyN1k0x3vDy4
         4RX3ki6QxbSKQ7XJThAhvxGG5oYNCx3CmVAJOeFrupPuE6z5cRQwunQ5GrhFqbAhX8sh
         Rggw==
X-Forwarded-Encrypted: i=1; AJvYcCUs8bQeX7MLHFDNiO7nmcvyejNBfxBM6IAKla6q0PHUrJFMQl2SHlLoyldk6KVrp1FVyWopkT1q5Jio17FtePc=@vger.kernel.org, AJvYcCV4rsw1gaDRdV9LpihG7CM3LeiLs7kH3vRUWwjmJTMsaVuuPBWFSW4RRcGABesX8acF1ASUU3QZkPi7ThE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85kz135BAyKkMfb0rAOW2EW+zrOcYCdPHV74S43m1ytfO+a4T
	5qGzg93xI7u5BJpR82U2U61NkxAttbAk/Wt7rHMRApOt/Vj/XrdxloW6
X-Gm-Gg: ASbGncttPfT7R0AxpxY7A0nREfYZ0U69nQf7LOHMDhQ3cVsAfE5O1LXgqmm5p9wj9vF
	lyxKHZEmW7mToojSQM1IurAIg4Y0iUsEw3cc1wNjVEDSgU+3OX6/iYSLKVYJTlF+6IAYkOg3Md3
	4EbcGhcSFyzryEhlUsoBJq0ETaPTQDkl+0cj3AtiASiqVri//2NrJ2g2fAmwesT/T0a56EwOYqI
	j0ei95UPEF/8VMg7UHWh84bPyE6uHY0youxblHmjxwNEj11ZoXzMnKUPsK/l4jqn/8cD9IYP0dB
	4Q7HFWNSLXrW6BFQxNVOZvN2JFTFi9AKvhuXEVRiKh4aNjsUgiLQsbm7Kg1Qg+sCgVfToKOLt6z
	KNZHfPgOB21liztbLcYXYEVMaeEn1iZE6UjOfTA==
X-Google-Smtp-Source: AGHT+IFqHr/M76UHbTB5jG3tqCeaieTz2lBy8yr6iwfKPpC80S5IkLRd3TQLo0XvYyhNo6p2eDpIkA==
X-Received: by 2002:a05:6a00:1acf:b0:772:615f:b5b1 with SMTP id d2e1a72fcca58-772615fb6e9mr21433903b3a.18.1757019933027;
        Thu, 04 Sep 2025 14:05:33 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e27d1sm19872865b3a.81.2025.09.04.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:05:32 -0700 (PDT)
Message-ID: <68b9ff1c.050a0220.35de1d.11b7@mx.google.com>
X-Google-Original-Message-ID: <aLn/GebopZOJZoyc@Cyndaquil.>
Date: Thu, 4 Sep 2025 14:05:29 -0700
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
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
 <aLi-7W21N45fBGJk@yury>
 <68b9f5e2.170a0220.1224d9.5d3d@mx.google.com>
 <aLn4bopPt8uS4d1O@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLn4bopPt8uS4d1O@yury>

On Thu, Sep 04, 2025 at 04:37:02PM -0400, Yury Norov wrote:
> On Thu, Sep 04, 2025 at 01:26:07PM -0700, Mitchell Levy wrote:
> > On Wed, Sep 03, 2025 at 06:19:25PM -0400, Yury Norov wrote:
> > > On Thu, Aug 28, 2025 at 12:00:12PM -0700, Mitchell Levy wrote:
> 
> ...
> 
> > > > +impl<T: Clone> DynamicPerCpu<T> {
> > > > +    /// Allocates a new per-CPU variable
> > > > +    ///
> > > > +    /// # Arguments
> > > > +    /// * `val` - The initial value of the per-CPU variable on all CPUs.
> > > > +    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
> > > > +    ///   `PerCpuAllocation`.
> > > > +    pub fn new_with(val: T, flags: Flags) -> Option<Self> {
> > > > +        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_uninit()?;
> > > > +        let ptr = alloc.0;
> > > > +
> > > > +        for cpu in Cpumask::possible().iter() {
> > > 
> > > In C we've got the 'for_each_possible_cpu()'. Is there any way to
> > > preserve that semantics in rust? I really believe that similar
> > > semantics on higher level on both sides will help _a_lot_ for those
> > > transitioning into the rust world (like me).
> > 
> > I'm not sure I understand what you mean --- I believe the semantics
> > should be the same here (`cpu` takes on each value in
> > `cpu_possible_mask`). Could you please clarify?
> > 
> 
> I mean:
> 
>         for_each_possible_cpu(cpu) {
>                 let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
>                 unsafe { (*remote_ptr).write(val.clone()); }
>                 let arc = Arc::new(alloc, flags).ok()?;
>                 Some(Self { alloc: arc })
>         }
> 
> Is it possible to do the above in rust?

Ah, I see.

The syntax would be slightly different, probably something like

        use cpu::for_each_possible_cpu;

        for_each_possible_cpu(|&cpu| {
                let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
                // ...
        })

it *might* also be possible to use a macro and dispense with the need for
a closure, though I'm not familiar enough with proc macros to say for
sure. That would probably look like

        for_each_possible_cpu!(cpu) {
                let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
                // ...
        }

though personally I think the first one is better (simpler
implementation without too much syntactic overhead, especially since
closures are already used some within R4L).

Thanks,
Mitchell

