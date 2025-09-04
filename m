Return-Path: <linux-kernel+bounces-801588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E31B4474B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B39189D8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A710280309;
	Thu,  4 Sep 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD7c7LFQ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE3253F05;
	Thu,  4 Sep 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017667; cv=none; b=Mp72lIjnaKM3GCrSYaVdTNamtaH77STG5eDsqrngaTvNg/VcrXZ7GHgcTE2RyNy7+zvVPRKpj8pGOppQMKcXc8RKXUFVvbiEGSZJZI/DcIBb9H2ylB8h0G+hL0FN0+Qt75UHG6ZDsfZ5lYibfyrsecGcL8b6laQ0of1mTOnTGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017667; c=relaxed/simple;
	bh=TCyNPOGCtr/xyMB/1/cD+kQcMkocTSItLEGsbf8MsRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDbN2yQE9CTBidYvfAIGM/VH4sJ/YXSCyud70Z9grgSOFu3ukNwg3WGoG7Bn8f7oDd+orTMzgyZmqh11AcovvkacyUPFlgfxbT0sNKPnOEqQjPdEV6h8xfa58y1k6N6LEAmRwDU9AUhkWj6NS2+PvKch3TOajLoLlTxMYm42E3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD7c7LFQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e9d5e41c670so1526104276.0;
        Thu, 04 Sep 2025 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017665; x=1757622465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvB00ALLfGnFg6LmNb2oOcpwz39zT9dJ6DxoEfayJGI=;
        b=OD7c7LFQpPcWXuxRRbWH1Xf9xryyhMnhxaKcVUGSXFCMWGaTH8iQm8gVtD8Zb153vx
         eBBCuDIX817Sq1Q0DF+qtPwarlZHpbNQX47HKlOxpVb7RqohLW7rin5el9uMxLoUfrE6
         N3DHMk/6ajz8avDEwLlY+EsxHLKQL2dtcMNjgJtdC8IVdkzlQ+KX2XmQmdqJ+vd9hkA7
         vhqChvggrXtP8XgCsR4bPMgSF4wd+5QMaLPVyrhxO3DCiZhlzXAIyOVpBob9PzpjsOrI
         2UZPFj2rr2RzZQD1KnECOSMXLwamiuU6QYvvWcGY0VI0+h9tyncms36fspDtFHZmnbg4
         SZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017665; x=1757622465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvB00ALLfGnFg6LmNb2oOcpwz39zT9dJ6DxoEfayJGI=;
        b=CrbAnbRobYR3DwGDZF/Fxq4BjFfQU0BNgfP3XaIZNdX648NW9a0jX75vQtOG0NY6Rv
         CoAV1lRyJrXjkZT5s+tGSq4ESXEr12ZDr5OCP7X11Dwu52FLyR0+ms0aSaYhAzxo5Dyk
         fmFVB1tYMUWlm+Cv7U/e3hkiFlZuU/kvXvG+aqncJulOKOe0Ssu9VTT6piZaqaIyPf9d
         RpwciRg+ZrzTx93PufJ1SVx+TKMX2Qzk3v1Wqq4p5Oo1ZcjJNnU5SMUqqRhgrd1CJG5Y
         sNm98KakTBtKmSL3ibh5Oqv5vkbLj81oDa15WcLZkge/3u1/SGA4OzSpkJjfVvnhjGUG
         13qA==
X-Forwarded-Encrypted: i=1; AJvYcCU/nVM7jWJJkHCCLNiOcmm6u8eCXdcEg/9jH0ZFTHenNKutZH3p140T0J9DneSfHCbaOms07teAv62lULI=@vger.kernel.org, AJvYcCUyd6Rm7FSZK2bBQeC78hhwN26fegYWBkQ54jMwzIOysWT8ekx1JQhE7gx8lLjX647iGY8i0xz4K3jLyy60930=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7xTjUx112bhIUnA4a2SoKtEsxvodmqJQsPhfs8403DgI77ie
	MrTF2PaVi9Sb4GEqkVab3OokDhfwSyIBhOdQ30BRk2EOJdJGqM58spUx
X-Gm-Gg: ASbGncvF2/tejYQOvghMiaBvMBRtKEd1oFqtwPrGVWpTVbWh68/pKL1r3l9MLeNnz79
	5qpekTmE9syT5cW/YTqckJAIL6+SnMI51/zYV+OPLukxab1eltidUpGXG4tFVgRVN6o+8ludrx+
	Pb7rU4XOue29ukfXawpFr2fAPIXAzU+qJ32Vvdv6H8qNhYTZhEia7j7184+3pawpZe5loK5lGtt
	TAuACeaSsRNTg+WqYS31GIuAO2pPqKNL/99Ox6rRcHyJ1EMRmRPEHAUwJv467gTWplmWO6hf78D
	GONe+A+rVwOZvOv4q7gPrMQN+C6K4ST+vDXKrgHWNOy/J6orwi1o8LuT1ObP6ylsbyxxgYR0TNJ
	f25UPwq7V8WZq6Wtl0sZ16Ii3L6Qbs1jx
X-Google-Smtp-Source: AGHT+IFEin3sVc/RJ0H3j23pXeDGR2NQkhbQfFAip/QeL6r8A6bl0sYH8LkbMo/F5ZLv1yUwPLRxSA==
X-Received: by 2002:a05:690e:165c:b0:5fc:8075:1ac5 with SMTP id 956f58d0204a3-60175d7f7b7mr3511304d50.11.1757017664951;
        Thu, 04 Sep 2025 13:27:44 -0700 (PDT)
Received: from localhost ([2601:347:100:5ea0:1218:85e4:58ab:e67f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a83295b7sm24319117b3.24.2025.09.04.13.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:27:44 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:27:43 -0400
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
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/7] rust: percpu: introduce a rust API for per-CPU
 variables
Message-ID: <aLn2PzD1KRbu4SpZ@yury>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-1-4dd92e1e7904@gmail.com>
 <aLi2MBAwoD65tokv@yury>
 <68b9ee59.170a0220.a7a31.675c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b9ee59.170a0220.a7a31.675c@mx.google.com>

On Thu, Sep 04, 2025 at 12:53:59PM -0700, Mitchell Levy wrote:
> On Wed, Sep 03, 2025 at 05:42:08PM -0400, Yury Norov wrote:
> > On Thu, Aug 28, 2025 at 12:00:08PM -0700, Mitchell Levy wrote:

...

> > > +    /// Get a `&mut MaybeUninit<T>` to the per-CPU variable on the current CPU represented by `&self`
> > > +    ///
> > > +    /// # Safety
> > > +    /// The returned `&mut T` must follow Rust's aliasing rules. That is, no other `&(mut) T` may
> > > +    /// exist that points to the same location in memory. In practice, this means that `get_(mut_)ref`
> > 
> > How long is this line?
> 
> 102 chars, or 103 if you include the newline. `rustfmt` doesn't break
> the line, so I left it as-is for this patch. Happy to change it if it
> poses a problem, though.

Then don't use that tool - it's broken. In kernel we used to have 80-chars
limit for the lines, recently relaxed to 100.
 
> > > +    /// must not be called on another `PerCpuPtr<T>` that is a copy/clone of `&self` for as long as
> > > +    /// the returned reference lives.
> > > +    ///
> > > +    /// CPU preemption must be disabled before calling this function and for the lifetime of the
> > > +    /// returned reference. Otherwise, the returned reference might end up being a reference to a
> > > +    /// different CPU's per-CPU area, causing the potential for a data race.
> > > +    #[allow(clippy::mut_from_ref)] // Safety requirements prevent aliasing issues
> > > +    pub unsafe fn get_mut_ref(&self) -> &mut MaybeUninit<T> {
> > > +        // SAFETY: `self.get_ptr()` returns a valid pointer to a `MaybeUninit<T>` by its contract,
> > > +        // and the safety requirements of this function ensure that the returned reference is
> > > +        // exclusive.
> > > +        unsafe { &mut *(self.get_ptr()) }
> > > +    }
> > 
> > Here and everywhere: would it make sense to enforce it by testing
> > the CPU with preemptible() before returning a reference? 
> 
> The only thing we could do would be to panic, which I don't 100% love.
> Another alternative would be to take a &'a CpuGuard and bound the
> lifetime of the returned reference to 'a, and then we don't need to do
> any run-time checking at all.
> 
> Originally, I had left this to the caller because it might make sense
> down the line for some complex behavior based on per-CPU (e.g., per-CPU
> refcount) to do all its own management of per-CPU variables using
> `PerCpuPtr` as a core primitive. In these cases, I believe there are
> some times where being non-preemptible wouldn't actually be required
> (that said, my thoughts on this aren't well reflected in the safety
> comment, since I said it must be disabled... gah). But, the more I think
> about it, the more I think these use cases would be better served by
> just using `get_ptr` --- conjuring `&mut` references seems like it would
> be a big footgun. And the safety comment already actually reflects these
> thoughts somewhat :)

If you think that in future there will be a user who will not need to
disable preemption before dereferencing a percpu pointer, then you can
add another less restricted flavor of the helper.

> For v4 I will probably have this function take a &'a CpuGuard and use
> that to bound the liftetime of the returned reference, unless there are
> other thoughts on this point.

I don't want you to panic just because of invlid user call, but
whatever you call in comment must be enforced in code, right?


You can use the guard, if it guarantees the preemption disabled; or 
you can return None; you can create CONFIG_RUST_PERCPU_HARDENED for
panics.

Please refer the recent bitmap API wrapper, and how erroneous request
is handled there.

https://lore.kernel.org/all/20250904165015.3791895-4-bqe@google.com/

