Return-Path: <linux-kernel+bounces-891176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB48C42138
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722AB188E82F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D30316190;
	Fri,  7 Nov 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDPNJfHb"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D662FA0DD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762559819; cv=none; b=rUXwntUJ2+Z6VKZNgjbMjQr31aOZVKU2pwWaxzmbS5OpEkUbNGnOfkCrQ+VlmJD1qzSCIZt7M3t9bVCly9s8dn1IF1tTTw563JjoTz8pSH+iEG0gtk3VDzcVt9J9I9IsFf1nxwboFMMYWNzpiC0YZCFE7jNd7nQjGbllB1Ya67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762559819; c=relaxed/simple;
	bh=FeFqsI/xYgr7AfG/0So5nOJ0W1lg/e2qWzNg9391MqQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjdpJ2fMXa1sr1qy8IPGBvglO+l4fwuxQA+IOIpXk6sZ3PF8yvN7jc5GzY0F+XXYEZm3l2qj0LC9ow6ElxvUUiCQr5aLswLdhDqIkcmR6uyyVHmRj6NRm8FEyqhmAOs7w/MRtrOWtDkzmZ5s4N8b3cE/OjwNjelswbnkO60C+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDPNJfHb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b18c6cc278so1144722b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762559817; x=1763164617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xyrn6s3e5AdxdBxzmRFJ+DRi5jwnDtSs0lRLo55lmRI=;
        b=DDPNJfHbbxKhy7QtZ9mD7j+QvgLKdkvDb1RSsRYCBBizJ9hEFMv1R/dg75tu0fxDmh
         DHWj2IuAb5kwxjwmu3/+u2ujvxkJCH9/BOmZawRwdp668U6GclvlIssVdJseppvyQe+A
         OrvnIxGAQ9G0UP/N9egGZ8LK5SMHqBO2M98Oiy35xEUDVyggWLKU//HVA+JZyu45H4Zb
         uyGpr+475k/CjO6zR7vquoW6eWkcxT0Lp0wSOd54x+nsVq26nAz4anUp+mKP8oNHfqTZ
         ezH8zr3GfHLaxkBulHEoyW62xiSyzlYRET+vsCHIyMjModpvhpHkRJXW/2JgadViQkaU
         +dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762559817; x=1763164617;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyrn6s3e5AdxdBxzmRFJ+DRi5jwnDtSs0lRLo55lmRI=;
        b=L9Iwc/MW3VRzAhF2nacFHv+FkBbBzyprHpWMR8blyxF7mF8tH0FvIC9yVlMPv03cFj
         TpGocjxWkTsgjUDiSgJ+2M4GIUeuTl7cKzHzldv0EKAKAUiGQ6XUKAuQOzQwxs200Zf3
         iAtRLFaYBOhOr8P5nFo2hLso/i1e/+QR4mRYFA6j2sg0KIkO8auQbgnBxj9T6gdOGDmi
         4/Z+J9VNT2S0wc3jEz4v/T/DfnyCzN9q46FxEJBPAkvGcGVpKoDyr+zegUOVwri2VnxR
         mIBLMjx5XLS/s5H+10IfgvY+FjQUUmFdEuz2fDb8fLSR2xndXHSEUPDpzAb4LYrKWdGq
         wgrw==
X-Forwarded-Encrypted: i=1; AJvYcCVyLTbM8A49BlC9P0zm/YP1ayu/k0HhsTJlmcwmZRTpfIzRJtJn60/5E+u03m5fpx1YehE/4Pya4d0Rj+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6gnI69HbOLfbHKofDR2dFvdNOmaepnp91lqe9d0Wns/LnxJw
	rrePKfp8Nqt177eXATwfSN8RWtX2jDY+MLp0qrZcazFf4HmnUJHCW4UP
X-Gm-Gg: ASbGncvAkRQNY9l5m+p7XuJnmE4Q8i79UNPKLHd7wG4+FziyN1pabrB+csOkOZGpxpY
	Fm0LeOXyK8xejNKM8Sy0yBTu7u31RhTZSzlasRiq3lTtMv3k1UFtvBBRQ2w/3WwhHzUF5sZtVN1
	Fa01fT1Gb3mX8hIwlL3uFeLT2Un5bh1IW7RSiqCqTjYx0VkDxl/dMkFw72DsX3QE6B0cYQUDBOI
	E2cM8NSNhZvidPq9XQF5QS32ToFqOk+BzJ0Bfhc8h/KvhwugE+37lJhqm8hxdri3C5SDmDizeO4
	Q4k3eykmzt613F05+Ss1mimeZvoETSJTrw5K3nsChSDcMQBi70dPijBB29Pw4mhV5TPHPakKyXo
	aHrBCpehtNWSxgwF49J23jj1s7dmte1RKPbjhd7KDFRPsUKX9ZHJsD6rbg2JpJILjIEDTHTKkSz
	6HHr9Z
X-Google-Smtp-Source: AGHT+IFDs0+vuIgKNMalX90Xs3buViP7wrslB+2hOH9XtyLnNMHMWwyAZzwdahX6iyGt7Hher2TH/g==
X-Received: by 2002:a05:6a00:23c1:b0:7a2:7a93:f8c9 with SMTP id d2e1a72fcca58-7b227085bb0mr1191767b3a.27.1762559816785;
        Fri, 07 Nov 2025 15:56:56 -0800 (PST)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b214155c8esm719881b3a.38.2025.11.07.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 15:56:56 -0800 (PST)
Message-ID: <690e8748.050a0220.22e404.3a1d@mx.google.com>
X-Google-Original-Message-ID: <aQ6HRrnRB/E3169n@Cyndaquil.>
Date: Fri, 7 Nov 2025 15:56:54 -0800
From: Mitchell Levy <levymitchell0@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: cpumask: Bindings for core cpumasks and
 cpumask iterators
References: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
 <7107432f-4d0f-4544-9592-76a5e5c6d220@nvidia.com>
 <aQ1NpPIcVIUXqgQS@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1NpPIcVIUXqgQS@yury>

On Thu, Nov 06, 2025 at 08:38:54PM -0500, Yury Norov wrote:
> On Wed, Nov 05, 2025 at 04:19:36PM -0800, John Hubbard wrote:
> > On 11/5/25 3:16 PM, Mitchell Levy wrote:
> > > The kernel provides a number of very useful CPU masks from the C side,
> > > including CPU masks for possible and online CPUs. In particular, these
> > > are very useful when some operation must be done on each CPU (either
> > > each possible CPU or each online CPU, etc). Therefore, it seems to make
> > > sense to add both of these functionalities at once.
> > > 
> > > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > > ---
> > > These patches originated as part of my work on a Rust per-CPU API [1].
> > > Boqun suggested to me that these may make sense to merge separately, and
> > > it does seem like these might be useful beyond the per-CPU work.
> > > 
> > > [1]: https://lore.kernel.org/rust-for-linux/20251105-rust-percpu-v4-0-984b1470adcb@gmail.com/
> > 
> > Even though you are trying to get these two patches merged separately,
> > I think it's best (for reviewers) if you post a patchset that shows
> > these things being used. Otherwise it is potentially too unmoored from 
> > reality, and hard to be sure that it's exactly right from a caller's
> > point of view.
> > 
> > In this case, just posting that 9-patch series might work, and just
> > say in the cover letter that patches 3 through 9 are not ready for
> > merging.
> > 
> > Something like that.
> > 
> > I realize that Rust for Linux is being built from scratch right
> > now, but including calling code in a patchset is a really valuable
> > kernel convention that helps validate the code.
> > 
> > I say this for the benefit of others who may be reading. :)
> 
> Not a big deal. Those two patches are self-consistent enough to take
> them separately. But I agree that examples are always welcome.
> 
> Mitchell, can you resend this small series after addressing my
> comments to the big one, and also can you illustrate it with the
> usage examples?
> 
> Maybe a small test doing:
>         
>         for cpu in CpuMask::possible_cpus().iter()
>                 ncpus++;
> 
>         assert_eq!(ncpus == CpuMask::num_possible_cpus());

Sure, will do. My current plan is to do rustdoc tests that will double
as examples in the generated documentation. However, if you'd prefer
something in `samples/rust` instead (or in addition), please let me
know.

Thanks,
Mitchell

> Thanks,
> Yury

