Return-Path: <linux-kernel+bounces-766956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940EB24D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B1A3B613D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92E1DD889;
	Wed, 13 Aug 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qwj3yOtW"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ECB212544
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098122; cv=none; b=lU+M5SQzCUMIe4vYjtjj//GR08Znu3qXIsVGYBOlO/CKxT2sZHxA02YYQda5g/ikFghIVUpjITRNAaufiIV0ix8r7hnGteAbmV6/KTAarrW3uu++59vLdD4AkFdq9fI0aYUOFrqqw1QpW0zSmFKt90WxRh/FnN8Q78RMTG1Jc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098122; c=relaxed/simple;
	bh=0EDMq5cSTxuCUaLadjW8Gyiwo1w0ECv/iUAH72LIgqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNc5LcGIep/72IcQyKoKslyspSjeAH3kHPxOd63OECVLnEKc+ctKTN4sqqne474MiIHRcx/ZqLNY5HD7mKw3uGQsQbXgJDMU8zrz0UFkdrbdOJ9qr6mOC1vv64q3furVFYCZBR9crCsgQjlJUYZ7Ppb9+nwwTOjzG+qnR+eg7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qwj3yOtW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1284480566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755098118; x=1755702918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2L57A8estrxMJoxB1LxgVIY26536p4EpnNTQos21VK0=;
        b=Qwj3yOtWb9cKrT5VNlFp1eQbZzCvSI6oHT00gP41JJohPb29vlxX+koY53CZTZE9tC
         OVe4XQM8Ey0lVtQ/ZWj5O1e+Kwed5RMCEmEYM3mcwH1yqNJk71sr8UFK/c+ZCm9QUaVy
         9i70kre3nu+f/NZW9wYA19f0HEwr3Yt7ye64M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098118; x=1755702918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L57A8estrxMJoxB1LxgVIY26536p4EpnNTQos21VK0=;
        b=t1yYqZzsccNdndW/slAE4fwC8UgWB3qdS9hiNLAHnVbm0fEWrkR4QXCOfu3aZ+PukC
         a8v8NqEAYQmJImpKSP+rLUXvpxiM7NT/iboyMp2TjMnQj5edeuMZcE7LvXWbJe/RTFbT
         hbadW011t7NmelG1cQs9YQfMEKBsbMCkwdTrDSZaAPdRkGEvuThz+jl/CF/MlSFvGTrk
         l7n6Gj/nAhUs40kNs7vl5ab1RFWizObHykjE63w6ImSRG6oz4NGfS/N3UuNa+RoISGQE
         gcS2FSf8DPGA7AtCBVDKUTjh/ZIb1QxT4c337SrpDlGpr7TmOyG3Z/HV74DKNIZZlk+U
         rOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+qMjU5JwoSgunMU/nP4vSxbj9OKjKjAdIB/sSl0xnytdiRf3YuEobpOztngioUJb+fDmkPUbnAkypwpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQddL4pmWeFkNBjpFdhFiUUlBucuJn/J5Gv0s9BjLHjh730Unt
	Zjzed8OziBYUAacigTcP/SNRIpFr93hUaeoUmFTO6yEM/WQUuO6AmvbaNsyJTUTqevIotfGu2Ek
	S1A4gwIs=
X-Gm-Gg: ASbGncu9xcADYniEfTwzd6bjA4RoGGgVpKRFXRuVqbAdR6A61OTLSNMHQhFwrlBmsR1
	YNEcy3GJfG2fh1UMCTmSpH+HMe/WOJpqDlCMLjZG2GU8OLM77OSQx3cirvGKRLys4iavchwNzy5
	53wTHFXxIxVya8w+mPPfD7/OrwXegKsS7MqkBj+FKbiE34aQ+kaWP5/QXQfW4/iwyzR/tEjcC4S
	KOyFJsMgu7fVWvloM+1hg7XHD3fjkwDtgcovssdLKzkOrmUiwHEn2xGreoRr9AcC6PyIVcxCVrE
	k7/hjGnNuwDOhf9azmQUGmsHHY6BxByVq5I3extQXE9W3bwWJ70fzRbtJ6omS/L9CjxJaOhnkbp
	6q/8NWDd8jSt5lXCCmWGvnH7K1ws0bbDGJf6paNrfy8gknL/sfAEFLdIBoIMHsEfz8rroE10l4f
	1SCnEHBWoh8GO5y8dwFw==
X-Google-Smtp-Source: AGHT+IEzMJkblPkXncp67TK9UO4EYgSgApjrUo2Eah5gJ02Roq+Y/+GjaMu4fQ2DMkCGMdf3uDcDKA==
X-Received: by 2002:a17:907:97c4:b0:af5:98b2:e098 with SMTP id a640c23a62f3a-afca4ebe85cmr334720166b.51.1755098118022;
        Wed, 13 Aug 2025 08:15:18 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23bedcsm2417258566b.120.2025.08.13.08.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:15:16 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61813e2fc73so6826732a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTr53DbrRj4jwKTjhAdaC36a+R1ra+9HklFKKm30e2XlS+ul5PXVPhJcUp/UdLmYUSKuEjTxYr/OWRXDQ=@vger.kernel.org
X-Received: by 2002:a05:6402:849:b0:615:5563:548e with SMTP id
 4fb4d7f45d1cf-6186bf89e1amr3186956a12.7.1755098116142; Wed, 13 Aug 2025
 08:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804220955.1453135-1-dan.j.williams@intel.com> <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Aug 2025 08:14:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
X-Gm-Features: Ac12FXyf2H9rUW__r5AJukVyI2fsUB2Hnh8Hl0cQ4hvvDCB_hIfhAbGduc9KWBM
Message-ID: <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with DEFINE_CLASS_IS_COND_GUARD
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 07:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> >
> > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > find unused static inline functions for W=1 build").
>
> I so loathe that warning :/

So I entirely ignore W=1 issues, because I think so many of the extra
warnings are bogus.

But if this one in particular is causing more problems than most -
some teams do seem to use W=1 as part of their test builds - it's fine
to send me a patch that just moves bad warnings to W=2.

And if anybody uses W=2 for their test builds, that's THEIR problem..

          Linus

