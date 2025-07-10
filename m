Return-Path: <linux-kernel+bounces-725084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74BAFFAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFF83BBA47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244C288CBA;
	Thu, 10 Jul 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0V3JY3R"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576648F5E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131906; cv=none; b=Jabn/A7WnniNpUkpNDB9z9mqbso3LvKlrsEsS9P3/eEw8oSlI89CNrVMKwTjIfvCHFzv91WOyi60eKwyAdGqT9Si/ZY6LGezAzLr2SeVt2UsSnJIf7SmuS7E2bAY3t2VWeOHxP6aSW55N2LGW1k2Isq1xZRa3nd9tFTwGoS/QZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131906; c=relaxed/simple;
	bh=HBa2adEyKxMu02uV9WlhTzEefFCJ1PJj/Mae4yiFm24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFj4O3pa7mNtYm4CS12vQt+/gRs3p+3mTKUhNDmJis3XadELDz2BBjIs8Q4BUCUN/+l7YGiYBe6WcMC+ySNnvNj9nOWnkUf6EnOPbRt+fRdA3Ku4M4/+Ms6KF1uJpmyXh5LVhJOobcw02WgSGmCtoCKJNwC6iJgGPlNbqVY/TIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0V3JY3R; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ade6db50b9cso78999966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752131903; x=1752736703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxg8f/PDVYM5f6gQgLUHldV3ztA+mO+3Y8DtTKzWoFk=;
        b=n0V3JY3RStlwhaK/3wxwVsYkmFfUPZXem+WTyGSy7zMRc0t1tJvn7CdTfs+FIjXoJG
         SxbsjgxpsTNgwFz2BbV72F6pvDnomXMhBPQEPrEIGZUvuHS27p+mfw1EDRFuKRCn5Sht
         APOsmZHRYAtu+CUjoPCsV2Z/PWVxEyZ1z0TKn7j/gX1Y8JCwpqbAiPZDQdb4rycANe+j
         Q9/9JjyPCQ7mIFMp75GSrss8aNeyipx3Q2TIAj9lhHYyt7gPLGjq+DmfHDTHHGDlxTvX
         kF1mhDA4F6frJeLO+9wHixxt1rC11ttdf96ekUvSsJmOj/tQ49KF21o/R1meDe+iuPeX
         SFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752131903; x=1752736703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxg8f/PDVYM5f6gQgLUHldV3ztA+mO+3Y8DtTKzWoFk=;
        b=IEvwm0dk1jEXurx9spINoWo4gIyP7Kh6rBCXezJvRXgWlyAuMGHo44i5DzwwkOq9wF
         H/NGEbyFv3kvd3s9ksA7/8CyXx6k5j5pPcf9B1JwDrAaSQ314+/cCqupZlcdfLzQxx4C
         qvqx+cpsEyrhdiJO138mzIujexgJo5EKHFdYhllRAHOs1KDqUQnGQc0kZNRcXuPP6+e4
         BedvzX5Nlf+M/FFfmqyVfZA1fnTNr3f2h7NykNvqzXT66KvSP4p5XDa2DqKEU/gGDdTU
         bcrB+FsaaMWXCRe7COiCCoY3jmdaptsvupzAbVA81+ffAqdyAd+Xm9fR/HGyw9IUfzBq
         hwzw==
X-Forwarded-Encrypted: i=1; AJvYcCWicGXJxlO3I/XnrN6tBuvqZcdj48WmNVSTXyDVHFwS5GWIVC/H+6YjTjGlXZqhH5nt+v7DrJvwX1+Csg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywazy9ORfarnvy33EqE9mYgjYRSmlieaMED6f4u2kp6g5PFiaoK
	6cMq8ZC01FXXPu//eKrh01CrE0CdD3vJMVycfSIMEcAuSfgLd0b7DmH3I8PQMjqLwgYxwCepHq0
	vWvXsETVicTmO5xzgUw==
X-Google-Smtp-Source: AGHT+IEXz0/88MQD9EVmv4Umg3MHo3aNQ1cvCFnTgh7/3/7gNI/iV14K18vDlwPGNV6DX36q+v7bOenoGWX6ZNE=
X-Received: from edbbd27.prod.google.com ([2002:a05:6402:207b:b0:60c:1c92:cbd2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f0a:b0:ae0:d804:236a with SMTP id a640c23a62f3a-ae6cf5753a4mr591593366b.3.1752131902776;
 Thu, 10 Jul 2025 00:18:22 -0700 (PDT)
Date: Thu, 10 Jul 2025 07:18:21 +0000
In-Reply-To: <F1EA22CF-1C01-495D-97ED-59D51A45A8B0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-1-1d3d4bd8207d@collabora.com>
 <aGt6CZAUeuK0XnmP@google.com> <F1EA22CF-1C01-495D-97ED-59D51A45A8B0@collabora.com>
Message-ID: <aG9pPW-cjnPQouBp@google.com>
Subject: Re: [PATCH v12 1/3] rust: io: add resource abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 02:43:33PM -0300, Daniel Almeida wrote:
> > What you wrote is not equivalent. (*inner) is a place expression, but
> > when you write `unsafe { <place expr> }` that turns it into a value
> > expression by reading the value. So this code copies the entire struct
> > to the stack, and then you read `start` from the copy on the stack.
> 
> To be honest, I've seen a bug where the opposite was going on, a field was
> being written on the value that was copied to the stack, leaving the original unchanged.
> 
> In any case, I thought this would be optimized away by the compiler. Also, IMHO
> there should be a lint for this, because it does not make sense to copy a struct
> just to read a field if we can just read the original location.
> 
> Thanks for catching that though, I will fix it on the next iteration :)

Yes, it is probably optimized out. However, the main problem is that
when you read the entire struct, that could be a data race of another
field which may be UB.

Alice

