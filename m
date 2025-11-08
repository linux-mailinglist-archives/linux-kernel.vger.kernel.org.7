Return-Path: <linux-kernel+bounces-891300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13857C42615
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2E3AF438
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE682D23A6;
	Sat,  8 Nov 2025 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWOkEe2o"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F472882C9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573161; cv=none; b=tNgz2S2yv9wZRWwTXSACglojkQ2diV0UotAC4Yv8caOcVEMXjvYITmYjGRYNSesCqQCRxdTxHtA1MlQEM6clvg6PdkOMzx0h0LjR6nO9VPJ69t7Tb7V0ccRJZEycIc5fg4HCycMazw8js1K57z31uG4VzbMA2AOACzrPtuCV7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573161; c=relaxed/simple;
	bh=cpeEB2eQdwz7J5BbckHZI1v/gGhFt+B61YZabTTCLg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kakN8IdaqqWTuhkxMcN41wK6w3u5lwf6qDHg3r87lL3X3n1RpBY0RpLEmOinfOHPzM1hni0HrbdlVWoET8Dre8D6X146GkoPgTnDvvuXtq+/ixYFKOW3Lfof4rNGJx4HdBDcqE5twJ7OP2SRnSV4PpBU7FsV4JD4tXhG0nqtwjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWOkEe2o; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786a85a68c6so14343527b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 19:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573158; x=1763177958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9h3FkFllvRL301ULuxgOtHl5uOTbxkQC4ivgx2/U0MM=;
        b=nWOkEe2ospG7Rv/zG/fRu8tNZAWZsxnM0+Ieup0kx5Nt7EkqamLrHbti2jXOPeTxtT
         6oYeQ18+k+a+qzzpSuFXD0AZd8Bbc65F69k1OJyVo7j28KSbMV8KoHe7dtqd89W8Pfk9
         5nGu1EaAiWhuDRKQGjpZB3MZaIJ5LL1okI9An8KX9qBFTgTNcuaNvFwK+vs4Yb5noV8M
         Dck9AWrlI+nGYczEWDW7zRzB5no8bIlUkFy1EgSho0dkwmdEf61BiZdVVjIMbotImxsB
         ditqlcobzOCkIzjAOLlfr1oiX6bUCkqmUYeNuqqZclPfnP4iu47GGZ/EHoWPXTeHQzsS
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573158; x=1763177958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h3FkFllvRL301ULuxgOtHl5uOTbxkQC4ivgx2/U0MM=;
        b=SBAiby2D9o0ShZpvuy9KgLVVIrx5Cw4MXmpnjlN/LibYNPoNd4sPorVzPBDRsfAN9m
         IZERgcrwzUWc6MWR7hvCt19EcWE5X6NwG0ziHBJU6r1Q5+zqbU+vtQIX7cj1dCuT/T98
         JAfYCat+GtxIXqo3nw6ztEiVKn96Nb2DvGuzwsGouN35lz7hfs0OYGIbrQHPZ35//coH
         27kuQDN2cGKo0gsa8MTJ6BpZoNncwasv8ja/ymL8McluQPybWzTUAiiMdZE0cE9UsMqw
         DECSFnMb1HG9l6OlCnYTsiJMMZlhtfsuGsP9FYOo7hBkgj48o4gEirY+38hmR342NHcL
         rSxw==
X-Forwarded-Encrypted: i=1; AJvYcCXKmzA1qz7dbgTDxQVV+9a3BySsQI/XSBCQlvmV8sYTKKME0hl6kQcfBj09x6eyspSt3zIDIwYLHh73y+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3nv6JjBWYokiseu7XhMVETeHTlGcl+zfObesJYlRbhju9pPw
	emkPfm/ICgYJ3J9TozY4maktwkp5vTeph+mZjl4e+UAenXWO98OEogf6
X-Gm-Gg: ASbGnctzPqyCYOxGbB44gWoVh7eOjLDruA96RiRciCjfJVSX+2J23PbtayHxh3+V+8M
	V7bPgksXr5S0SqUF9YzCiFf6fDQOUWeVLf0CJeafRtpExneF9r37Ifbvv325p55z37c0QC8O0cD
	qqEiSiUHESp/PfLgHHlKbECXJeBfjlxSLL53PKuqx7Vk6qtijtCfygLagdgZFRHP0g5YYp0fEs9
	djCU8dwS2TEYV+kA1x5p94HNsyNS50qXglZBdh3yGlkRK3Ovomr+Adeke8NPVMCV8IvHmdzY+A1
	d0sRAHvE3TbupivV1abPuq/SEzwM+QQPNZs1HAUcEJhC4HvEU5J04+sYdot1YQmj6UKvDBv2HUd
	Z73klE4aBsAoucaBL7NUVDhjCKS7z6sayyUldrKiKnKovk7+Y24wWZPYZzZUH1yKfqneM1A+IZ8
	5ZQE3sEAbHqdz69i7iNa4TWuzcPHGog0qPOXJom3vRzPA=
X-Google-Smtp-Source: AGHT+IFYVT1fUkHV6VJLT6N7hlDvCT+tD4Kfn+cnUafAF1yf5tELB6GAdHtxmqPcstSWjWMEWAfufA==
X-Received: by 2002:a05:690c:6e0e:b0:781:4b2d:7261 with SMTP id 00721157ae682-787d54156c4mr14832407b3.41.1762573158025;
        Fri, 07 Nov 2025 19:39:18 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a2947asm3452237b3.55.2025.11.07.19.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:39:17 -0800 (PST)
Date: Fri, 7 Nov 2025 22:39:16 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
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
	Tyler Hicks <code@tyhicks.com>,
	Allen Pais <apais@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/9] rust: cpumask: Add a `Cpumask` iterator
Message-ID: <aQ67ZC__zN6yt7Ln@yury>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
 <20251105-rust-percpu-v4-1-984b1470adcb@gmail.com>
 <aQ08d2NUVsIf5ukH@yury>
 <690e897d.170a0220.3b9532.0c02@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690e897d.170a0220.3b9532.0c02@mx.google.com>

On Fri, Nov 07, 2025 at 04:06:19PM -0800, Mitchell Levy wrote:
> On Thu, Nov 06, 2025 at 07:25:27PM -0500, Yury Norov wrote:
> > On Wed, Nov 05, 2025 at 03:01:13PM -0800, Mitchell Levy wrote:
> > > Add an iterator for `Cpumask` making use of C's `cpumask_next`.
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > > ---
> > >  rust/helpers/cpumask.c |  5 +++++
> > >  rust/kernel/cpumask.rs | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 52 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
> > > index eb10598a0242..d95bfa111191 100644
> > > --- a/rust/helpers/cpumask.c
> > > +++ b/rust/helpers/cpumask.c
> > > @@ -42,6 +42,11 @@ bool rust_helper_cpumask_full(struct cpumask *srcp)
> > >  	return cpumask_full(srcp);
> > >  }
> > >  
> > > +unsigned int rust_helper_cpumask_next(int n, struct cpumask *srcp)
> > > +{
> > > +	return cpumask_next(n, srcp);
> > > +}
> > > +
> > >  unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
> > >  {
> > >  	return cpumask_weight(srcp);
> > > diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> > > index 3fcbff438670..b7401848f59e 100644
> > > --- a/rust/kernel/cpumask.rs
> > > +++ b/rust/kernel/cpumask.rs
> > > @@ -6,7 +6,7 @@
> > >  
> > >  use crate::{
> > >      alloc::{AllocError, Flags},
> > > -    cpu::CpuId,
> > > +    cpu::{self, CpuId},
> > >      prelude::*,
> > >      types::Opaque,
> > >  };
> > > @@ -161,6 +161,52 @@ pub fn copy(&self, dstp: &mut Self) {
> > >      }
> > >  }
> > >  
> > > +/// Iterator for a `Cpumask`.
> > > +pub struct CpumaskIter<'a> {
> > > +    mask: &'a Cpumask,
> > > +    last: Option<u32>,
> > 
> > This is not the last, it's a current CPU.
> 
> Ah, I meant it in the sense of "the last cpuid we've seen", though now
> that you point it out I agree the naming here is poor. Will correct to
> `current`.
> 
> > > +}
> > > +
> > > +impl<'a> CpumaskIter<'a> {
> > > +    /// Creates a new `CpumaskIter` for the given `Cpumask`.
> > > +    fn new(mask: &'a Cpumask) -> CpumaskIter<'a> {
> > > +        Self { mask, last: None }
> > > +    }
> > > +}
> > > +
> > > +impl<'a> Iterator for CpumaskIter<'a> {
> > > +    type Item = CpuId;
> > > +
> > > +    fn next(&mut self) -> Option<Self::Item> {
> > > +        // SAFETY: By the type invariant, `self.mask.as_raw` is a `struct cpumask *`.
> > > +        let next = unsafe {
> > > +            bindings::cpumask_next(
> > > +                if let Some(last) = self.last {
> > > +                    last.try_into().unwrap()
> > > +                } else {
> > > +                    -1
> > > +                },
> > > +                self.mask.as_raw(),
> > > +            )
> > > +        };
> > > +
> > > +        if next == cpu::nr_cpu_ids() {
> > > +            None
> > 
> > Please:    if next >= cpu::nr_cpu_ids() {
> >
> > > +        } else {
> > > +            self.last = Some(next);
> > > +            // SAFETY: `cpumask_next` returns either `nr_cpu_ids` or a valid CPU ID.
> > 
> > Now that you've handled the no-found case in the previous block, the
> > comment doesn't look correct. Can you either move it on top of the
> > if-else, or just drop entirely?
> 
> Actually, now that I'm looking at this again, I think this whole if-else
> thing should just be:
> ```
> CpuId::from_u32(next)
> ```
> which does exactly what we want here. I think this should address both
> of your concerns, though please let me know if it doesn't.

Looks like that. 

