Return-Path: <linux-kernel+bounces-844483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0ABC2098
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397C33B4D52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001B2E7647;
	Tue,  7 Oct 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcDmNlNO"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646842E172B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853176; cv=none; b=UJHN9S3WWAgYZkldH4duwjljACzMcSMlTqXxHr5Y15NvlQL1r79L0EjqFwas80/FFo6zo024Fs7VPjtNVRALvnzli3awwRfnNzsVfe0xawN0WzW0BEMuFEv43eDxQWBlqQwiO9VdE6U92R8P0yr2BeY9jXhZF5U7JI3V4D+vp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853176; c=relaxed/simple;
	bh=X65wHkpJhWZgne4Ag70cATb79P5sdfgFOkB+4Mn2Nac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf4IbR8InJ/6NNBIX56QExoHoEheR1u1fnhHPCaxrerSNjjkWadfNseUQqg1F5cgv/VTDHZHTm4VUdPYV+cPspqU/n/sAsP9+SemQj2G2NLh7sW/VqkH5FlqOlSPWxx2aYPNlqoc7pistNo24o25/yC08qTrW+R7SDwQvyUOU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcDmNlNO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-73f20120601so77724957b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853174; x=1760457974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxd7w+3c/2swwtIgYgecKNq0yqsZikLr6MYY6N0WKtE=;
        b=IcDmNlNOx475w5C0sVAVePxq0u6fsTmLL3QtWE3svilGouWVyUnqengbFDXxntl+3Y
         jKbxQF+dpQc/b0wqBsSGO1eAhpPbPY7Gi/3HfX1ABB4PUKzdtVKXg7t0MHBhVjG+TiKa
         dtDDSE21te6Z3AsjhU1uOtRufxvYvbBLCMEylUKM5jylHvW3fl8Ojezh08uutLJqIoE1
         UPhOvQuEJT+IMw4TvU4OYp1CfWGFtsSr4F9i+1bC19KoW4TTz5qU24/CIHAdR2nFVnj9
         NzTCLzMA8kYAuAAyBa4EFWh9iYa9Sso2FjEfTo7qFuSRmTUDyUp1ZdEUGENQGsmi8PK9
         kJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853174; x=1760457974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxd7w+3c/2swwtIgYgecKNq0yqsZikLr6MYY6N0WKtE=;
        b=QacFGzWQDphjFjhexsKkl42xvhWES3TU5Sm01n6nGPFh2URJfpF9aRtV/3TNUrc4bi
         woon5cVvZh7WnY8GtzfEC4ArkrH+i6kPMjw0N9uMaAu6/U8tcE/1AzRfObc+B0qugRW2
         gw2PUsWiFOy1Uz9dltJDdNmHogB527sjqHnjXo5U8x4AYEjpVW7z/0dNk/f3C85E1scy
         nzIFfJl0TRcDlh9CsaJL5NBZCoIeb5KLEOgQszMuYYty1QCvB1Q5bOr3AKGmEwJJyRSQ
         v7VDZaA2B4+ILMYfqSW5tV4zYrfUWc2nvNwiVkq7uQXTEDZzCbv1AKYMdZZ7MfevO9at
         sBdw==
X-Forwarded-Encrypted: i=1; AJvYcCW6D7cLbVBfrc2boAX14Aoel1jcioJ+snMng//WYQ/JKuYWLS+290VPLQIAt3hPjza1HdkV1HtnfsAE7WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzbE+vGrn2zevq143ZIQEKCkmCI/62mcaLi/9T0/VBzkANkrd
	YT/Ibd1E1oxOd7M5AwQWoXUeukVypOHCzoZEnPBP/Onm3db8EsebWarg
X-Gm-Gg: ASbGncseVWvoqLFb5tPOjQXb72CmJRy7+3sQj7I564TuwxiO+ekuZagP0wH3hQ2EIt3
	x+ZXHnu80JOGI8HjR8XhHqi8KdA2WvNZ6EzPznaIhncRGkfszPRjwPVoJSV4m9Fx7TCTGCuBrGI
	Ml5lSoyK5zHjQech5soJODupKkjE9i3f+Flc7S1kYasoLsLUjnNP5BbdReDS07RxNhLimi+LztJ
	BLwA7E8QsaEeqLF4EF/DF8NHzFhTqLPZLddhKYVE4lUMsGo/2kWHOTunrkpFJ9TRXsHQEcWxnqc
	ISOLEgNPryqbRk4xa2e2n/ZZynSvI/FslQHZtuskKX/T93ZPTuIjs5aYO3DnzpJuKl4TOcu9B1W
	erEuyA9iRtNWtR4SeUkW4Ff8T1QXgN4mSn4v6l2ulBqw6D9xIVm6r4+r2bqs8XB1VRNGXN7tPL6
	yC6Xo=
X-Google-Smtp-Source: AGHT+IGOfFA9QkKleZeWTFtFw7q0cnvtzA4e283IrCuPbzkVclh+0FUFO6eeZ9qg2IcZjjtJmEaW9Q==
X-Received: by 2002:a05:690c:4a05:b0:77f:a301:4634 with SMTP id 00721157ae682-780e17aa12dmr3158717b3.45.1759853173810;
        Tue, 07 Oct 2025 09:06:13 -0700 (PDT)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81c0c2cesm54284547b3.11.2025.10.07.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:06:13 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:06:12 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dakr@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Message-ID: <aOU6dEEedEnK5ZTk@yury>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury>
 <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
 <CANiq72m1eiGVJHNyym+JwM=tQ9bGnmoW0+OuKQ3Vxo_AQOy5dg@mail.gmail.com>
 <DDC4DA0BPHRC.3P5M2CXSJYYTI@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDC4DA0BPHRC.3P5M2CXSJYYTI@nvidia.com>

On Tue, Oct 07, 2025 at 10:20:54PM +0900, Alexandre Courbot wrote:
> On Tue Oct 7, 2025 at 7:42 PM JST, Miguel Ojeda wrote:
> > On Tue, Oct 7, 2025 at 12:36 PM Alexandre Courbot <acourbot@nvidia.com> wrote:
> >>
> >> We can assume maintainership of this of course, but is there a problem
> >> if this falls under the core Rust umbrella? As this is a pretty core
> >> functionality. Miguel and other core folks, WDYT?
> >
> > I think what Yury may mean is that this should get an explicit
> > `MAINTAINERS` subentry even if it falls under `rust/kernel/` -- I
> > agree that is a good idea.

Exactly. Otherwise we'll end up with a single maintainer for a huge
codebase written by different people for different reasons. This is how
lib/ is maintained now. Not very effective. 
 
> Ack - how do you expect things to work in terms of code flow? Do we need
> to have a dedicated tree and send you pull requests? If so, should we
> host it under the Rust-for-Linux Github org?

(Not sure you've asked me but anyways)

For maintenance hierarchy I'd suggest a structure where an author of
the new subsystem obviously becomes a maintainer, then some acknowledged
Rust person co-maintains it, and lately some non-rust person from a
related kernel subsystem becomes a reviewer or co-maintainer.

In 6.18 we did this for bitmaps, and the maintenance entry looks like:

 BITMAP API [RUST]
 M:     Alice Ryhl <aliceryhl@google.com>
 M:     Burak Emir <bqe@google.com>
 R:     Yury Norov <yury.norov@gmail.com>
 S:     Maintained
 F:     rust/kernel/bitmap.rs
 
Check 11eca92a2cae ("rust: add bitmap API").

Thanks,
Yury

