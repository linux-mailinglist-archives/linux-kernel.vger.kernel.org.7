Return-Path: <linux-kernel+bounces-752506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8506B1766A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0617A836A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7523ABB1;
	Thu, 31 Jul 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FK9TJqiz"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED9A923
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988732; cv=none; b=WBMyg9SrjUlOvyeViv1PwUiGMYXVc2Uh8nRyg2L8PJ2hQ3Ve5MUJESH/ObajLowQ83joXgI09aAvQPF5op00+7XyOCs09D53DRMIv46E9QHZkb0inV//vHJzXrFDbk08DhATy1uuN0AUQJUlR2Q8KhTTseumxiEuWyzZnb0dNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988732; c=relaxed/simple;
	bh=x1ypT2fJPNgyIicOoC6mzglibewwl7Bcb9TDib5VIsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+8C6lDeJqN2/hP0orvwWeHGOIGDLYWLPjraqh8BlmVNQKErmI1n2RTJ+ukG7pRkIbIYdheOBVRsDSuKDQECAhnRRlqqDCT16rOgyWCqm+0H/BlvWgxKR5KNfTMZeaBka8OOldZf5I54cW9rNc8/ZALxtv4o+7YjEmx4vwNRQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FK9TJqiz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615c8ca53efso590453a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753988728; x=1754593528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2PT6XPI8glH5ApErKJyggXcgzcrrKoKKUUfLUjAEO0M=;
        b=FK9TJqizTdkest6m+MwsMMNXb4fRAD+xgoXjddAXdVip4ivUY2PfR1CRKBZiPvYTC/
         nLvAu5emZw3TC0JLHq/DPYxjTejNXkAryn4V4Wk8cazLEM9kyXqS582AlLfS3YDyslKq
         IsbAilrGRo7mMAAyTVRMANaG0xS1NN5reVvLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753988728; x=1754593528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PT6XPI8glH5ApErKJyggXcgzcrrKoKKUUfLUjAEO0M=;
        b=vqg83cwkIp8whYCFoWjbJtKGHxjgzaedM7DULGaXkHyoobz0ymtqgGU3LeiRWB39er
         IMChkBOYmYs9ODYv+Bs2TYiXatLsOMd7Vw3YrgPpn0Z62GlJWe69qGOw6boihG8/+MTi
         OEjrOuSfZH5fCTjdLpBsvaUZl7x4Y9OXmFaYLWMjs/nkJs+Cj9tmM8uRw6N+9EUYOJ8Z
         Ha9qH9qDVPwDmmQFpEv85ctLDXZ/POLp3YMMKxwH3FFRflg75IZq6u4PxHsP/GTxJQJi
         I+oCv41QjqIm4Vmhwxg9jUT3XZIdWTVFlFkQomWNBGjT+yfy3CSs2wJiRYAO7bcxxK3f
         Sf7A==
X-Gm-Message-State: AOJu0Yyw9Ebb81BF+POSkyy9yREW0kpJP1KOHRo1P4Vx8/p8A+mVZH55
	e4mVdIb/d8Ki2sY0QduLTwJsFCpFI9gGfKB7e7F0fV0shtaQ1qolroOT7QQ6Z4e6wtLNmDI0VPE
	/F8nSGRw=
X-Gm-Gg: ASbGnctF3pR7m5/M8Fp+dXcF5dfcalEOBbvPk7KvcMK/jjvVzV/n+On9PHQ1OMZ3umX
	2HI7tf2Ec7Gc0mYlwgwv/yL7suwV587cZx+iCwrCES0RDCB1qJ+xMtAw8zZptIhub07hxBGIbY1
	UnHR2zA/8vNaylShLnGzlVzUME/T0DFYataBB35opzQ0l/3SvBZdzsM7laY3Fz5tBy2bJyo7NQv
	RqQuPPyTOJnyHrPVhsjkpVqPcZA5vcHP9N/kBJH3/A9ENA3KwE7J4tXWDSQ4IGzWWCvvaylXhww
	pIh7lrhPDAF/+E6SenNEsV7OHpOTicXvH5/b+FMTuqvGg4RHMoS6uVN7TFDn3YvctI/NkdSAfPr
	WKBxX/iaUmq398qk9i0CBqeqHRQNwqlExlqLwg9H/nDe21Iqcw9ocVvg6YQCTc8OvzvYXm8pU
X-Google-Smtp-Source: AGHT+IEaVRfP82GHEon11O+bR79z6VW7HgSCNjhqDRf6QJBqxiyIL6ehs7tzp+5ixpoDxVAtQQ0tfg==
X-Received: by 2002:a17:907:e8e:b0:ae3:67c7:54a6 with SMTP id a640c23a62f3a-af8fd96f774mr926202366b.34.1753988728492;
        Thu, 31 Jul 2025 12:05:28 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0def2esm151133766b.61.2025.07.31.12.05.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:05:27 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso1064954a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:05:27 -0700 (PDT)
X-Received: by 2002:a05:6402:2355:b0:615:a3f9:7be5 with SMTP id
 4fb4d7f45d1cf-615a3f99733mr5652402a12.25.1753988727246; Thu, 31 Jul 2025
 12:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730151013.GC6782@google.com>
In-Reply-To: <20250730151013.GC6782@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Jul 2025 12:05:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwhtLWi7n1RjOk4Yvmt4sHdEMd9DdzaLdfHc_8StU-qA@mail.gmail.com>
X-Gm-Features: Ac12FXwkMR_sa7-aatpk2e2co0_SuKZZ9aejVZnXIfXrkL8WCNxajW2xO_n2rD0
Message-ID: <CAHk-=whwhtLWi7n1RjOk4Yvmt4sHdEMd9DdzaLdfHc_8StU-qA@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs for v6.17
To: Lee Jones <lee@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"

Just a small and unimportant nit:

On Wed, 30 Jul 2025 at 08:10, Lee Jones <lee@kernel.org> wrote:
>
>  * A potential buffer overflow warning in PCA955x was reported by older GCC
>   versions has been fixed by using a more precise format specifier when
>   creating the default LED label.

I'm trying to encourage people to use more straightforward language in
commit messages, and I ended up rewriting some of yours.

In particular, try to avoid passive voice.

So instead of "A fix has been implemented to Xyz" just say that it
contains "A fix for Xyz" (or even just "Fix Xyz").

Straight and to the point.

As an example, I edited that "was reported by gcc" and "has been
fixed", so that bullet point became

       - Fix a potential buffer overflow warning in PCA955x reported by
         older GCC versions by using a more precise format specifier when
         creating the default LED label.

in my tree.

This is not a huge deal, I just wanted to point out that "simple and
to the point" is a good thing, and talking about fixes in some kind of
passive voice is just strange.

            Linus

