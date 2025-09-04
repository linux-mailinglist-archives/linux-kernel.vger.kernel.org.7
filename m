Return-Path: <linux-kernel+bounces-801602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0279AB4476F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC91816718F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0417284695;
	Thu,  4 Sep 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjB4Y7/Z"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43E280312;
	Thu,  4 Sep 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018227; cv=none; b=ShkyX2AiC+uiFAL9SNPmGRZVZgYKqkwjda2qmaDFtiTwrJ6x8UYP77IcjKOABA5uAbQE0WVoIWQLHQtMPLzPigsPNLgGaYm87/hC5bGcdmvzXLJyyLS3w9FQLsMUK2RGBiDIPBgxjIsJNq4+30oNTv8uqwMDjsmsoRWs7eRN35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018227; c=relaxed/simple;
	bh=XNF4WH6xk9pZ4JhitpBCMSFT4vAaOschjm1uXKEQMGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7giIQ2urqUun0U1vaIoRGCBOlXHEhOlFL9NHP8TmqUM6SnKs/eF/bftG7yyuIKrhS3RO5Zbnic4XntSrsVwd0QncSdrG+kyGL1Le5XyKw5bPj2JaKPaLozWDo1Vt/pJxQTf0NKvbcbes4e3FFHoUrnaZk2WUiHoKulX8qkbX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjB4Y7/Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603f13abso16969497b3.0;
        Thu, 04 Sep 2025 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757018224; x=1757623024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EI6nD7Kb2vJ6eXm1beP+MC7SFJD+s+Tf7//wFJSVUQY=;
        b=XjB4Y7/ZgrkgpVYdds1MMNwauyDUKFykcyOKpy1dua8pltaxkJDU883B/0H6Zztexc
         zMYuV9upEH1LchSpW13sxwsv/o3HUUZS5Ow8BjzIyisAp+bfXakiZFtxxy72lO7odmvk
         geKbPXZ4MtDpsR9ZB7A1oNWCp78AxJkJNFxa41/k8IRj6dY76zdKnPmevgs4tO+b3Ke9
         +mVBUH7wzLww7gH19JYr6KrY/VasULVGdfzIGwAVS37A/fE9QreqGUNfayuhI5jHIeta
         1nfrl3oiPxmnEwh1HR7VSJLJgYNesDYfvjFSe0Hj6tlH/RL1WJ9ELuWDwxKB5TUlmD20
         D18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757018224; x=1757623024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI6nD7Kb2vJ6eXm1beP+MC7SFJD+s+Tf7//wFJSVUQY=;
        b=GZ+hhBh1ZF8kBrzMSEcpd6SF7lbja4ZD52T73ASd6/HfZ2Z/TGSnOlmo7OmQexVAIF
         MJ85zR68AGt2fqJhwhiHaqX0JIQ1N/AqseJqm5/Znz71XruFUw+kVz1J9Vlw6wtMGZ0y
         aY7+AKSdnpj8Xyz3aIcmX5/bmGvDjrKb1OdHUyqpKWKyzx1AlldFNJgxHPqCqEaF6ZC1
         eQ2nbDvRBxGUZYmpAH4C5lsRAB+RNTrdQS0ZfJk0iiPQHYz2PVw8GFXFhx+HTrsyWlmk
         t3BgGCihNTEwes9+PPs7K88xcGlGtP40NrIA/ZP8kYEJnc9EYNRbBr/AN/ayWQ4RTD9y
         MMLA==
X-Forwarded-Encrypted: i=1; AJvYcCUCMRA2DkmIWyNMnPEnP6YLDaZw4ags+Ux579bhB8lKP7GUefTHcFYXDmMFNHy3BnxtIdcxFkI1/4pEZm8Vg9s=@vger.kernel.org, AJvYcCVNtj09nS20kZQRl6iuNp1yw4q7abtej5UleE43Glf7HEhWOmdVDkO3bk1n6xPvRbZ7ZwRz3nRR6saG+Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgt03jUtxnJmUhPVLXCjhHPaLR7HHseNETTcMqN4iR7/6PRrz
	vBgw5K1rBwxbsxokgymz+rzQfPyZ42xkkeL1AicVgC1MaNHe5Exngww/
X-Gm-Gg: ASbGncs+qvO4v1c7K2InwuDMIdWvG8Xy3yyvxX9Y6b5aL6iKPliGr44ktmjBQ8DtvNg
	25hqb4eL9RUcnvhlkb2zXIWwlALWmSfZTwDu8fMVChhUKH/d4T+wOh8YeHedhs0KBX+jz0RW4cH
	uj/urGaJBPEpbTKRtmq09ID3Yp3xDDMH0ZFB88O3kLWBzPRs33rpD29EQAqKlUerLVLTjWDl/On
	oY4hb4O+ta9684+XsFyORXUbaN9Y8ZZX5wO0WdRXr+hGCmdJ+1yqpaLi+mbLZjFFSTh0d+/7nh2
	nm9F7gmAzd4UCceUcaws0UFWIRVmkMq9DbDoUZijSKhb9d7UJ9ICoDsR+jdjYkHiIDL8/gHYApS
	sFua/xWtOkpTNq6w50XigXFY71zMNUtH/
X-Google-Smtp-Source: AGHT+IFiE5N1M0ZHCK0VNaiwKKRp7XpL3kAlt6Jadb18nEF1ZoE40INUGXk3t/leYVgwWHl3y69GxQ==
X-Received: by 2002:a05:690c:7002:b0:721:3efa:6d05 with SMTP id 00721157ae682-722764caa67mr246004437b3.26.1757018224161;
        Thu, 04 Sep 2025 13:37:04 -0700 (PDT)
Received: from localhost ([2601:347:100:5ea0:1218:85e4:58ab:e67f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a855a89csm23725327b3.55.2025.09.04.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:37:03 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:37:02 -0400
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
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
Message-ID: <aLn4bopPt8uS4d1O@yury>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
 <aLi-7W21N45fBGJk@yury>
 <68b9f5e2.170a0220.1224d9.5d3d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b9f5e2.170a0220.1224d9.5d3d@mx.google.com>

On Thu, Sep 04, 2025 at 01:26:07PM -0700, Mitchell Levy wrote:
> On Wed, Sep 03, 2025 at 06:19:25PM -0400, Yury Norov wrote:
> > On Thu, Aug 28, 2025 at 12:00:12PM -0700, Mitchell Levy wrote:

...

> > > +impl<T: Clone> DynamicPerCpu<T> {
> > > +    /// Allocates a new per-CPU variable
> > > +    ///
> > > +    /// # Arguments
> > > +    /// * `val` - The initial value of the per-CPU variable on all CPUs.
> > > +    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
> > > +    ///   `PerCpuAllocation`.
> > > +    pub fn new_with(val: T, flags: Flags) -> Option<Self> {
> > > +        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_uninit()?;
> > > +        let ptr = alloc.0;
> > > +
> > > +        for cpu in Cpumask::possible().iter() {
> > 
> > In C we've got the 'for_each_possible_cpu()'. Is there any way to
> > preserve that semantics in rust? I really believe that similar
> > semantics on higher level on both sides will help _a_lot_ for those
> > transitioning into the rust world (like me).
> 
> I'm not sure I understand what you mean --- I believe the semantics
> should be the same here (`cpu` takes on each value in
> `cpu_possible_mask`). Could you please clarify?
> 

I mean:

        for_each_possible_cpu(cpu) {
                let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
                unsafe { (*remote_ptr).write(val.clone()); }
                let arc = Arc::new(alloc, flags).ok()?;
                Some(Self { alloc: arc })
        }

Is it possible to do the above in rust?

