Return-Path: <linux-kernel+bounces-749326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA4B14CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EBB4E42F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED828C5AB;
	Tue, 29 Jul 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fclqUbpI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F4228C99
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788061; cv=none; b=p4AswYBmqAKReUP268HLAzGPU76OvcW8iZJYnw4MwfqP3J2bD2JR0wS9ZektQNhe8+y7iyekfKMnHvZdGsaqNRsAQEIt3+5ujGfzL2KtVFm9fi7xoHgRi8wiaV9cll+ZDo3uJFkO6ZjNVa4fG6d1We+q/HoRX7e/dhwpcZAChHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788061; c=relaxed/simple;
	bh=BgHGoF7X1TSb+NTWpqydb+SKb3xcylkaFVep/pDq4SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpD9CuHfT3WyJugfkXcC7BDVwnOx1MNCGszO8fRGsnj+TFzg4IusVGFDNwgSwLKiuXYf0tMo8yk9M+Ah+7Qq8ngD+92chE9Gdt2Aa5nHptG3JorNfD96XXBvkzzXzhr30ok0Kw8G0RXYm75d1EAU41D2JnDS2jbmBEYKzbpnBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fclqUbpI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-33212421e95so12090391fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753788057; x=1754392857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aZGvUusdBUkFEqwrfYta8x6X6B0/cd+kHoZtenZK+Qg=;
        b=fclqUbpI9hYEnu5KgbpA2exZi1e5uD4zIQvOZJMKvimwj+sWYr2pP5UOC+wZ+qKtuE
         6IWIzKJQDZTRz19jxqhdLOwUqblPn68z8uyYNCBEXKHW+ujXkP/RvkaVvRCGiJxf2fbx
         CRGJbcMALjhFToBgvIPN1donNEeaRGCKQHECYb+NBNOtAHpKpXX85/Z1iTiCJhA6mfuT
         yAFg57WwcqjT/lUjuKjZU6R/JYlhSPmWWzjNRRC27t2Ni+Jx+9NdIgO1OmYYhy+JJEj9
         ct4fpKt7RQZU+ZqcWYEOxMzj9XY3tUbIPwlAdboQXa5qVplgWpaB8BYtdjrI+4nF048T
         kesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753788057; x=1754392857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZGvUusdBUkFEqwrfYta8x6X6B0/cd+kHoZtenZK+Qg=;
        b=jDut3Ony9FI0NMvwckKYv17FAOuxSeIZ1BV767TUQPScLJ8mK/TgCMzbvvzV871n4w
         k15XcxZxOuYmi5nw8bZOgv1bPdupSzSsjkcNxmlqi659706jzwEpSa8wZVUGKEnNedjb
         EvfUGi9il1QTo7a9uyJGlW6N1xBrudUUX9JGfXcOzt1An9meCJxQsUwEkzqPrwLB8GDM
         lnaboYMvLWW093cH4RMX4GLJgOw6Lw9B1a7iR6kyK5HzvLwY/icQglBPm73XysuMYefY
         NZENDZ6pnGRRynCwPEwFEWmwqmG73aaWMiowA+1RUCCDu6Xqtg7EFBfJTN4coLRVcWzp
         lZfw==
X-Forwarded-Encrypted: i=1; AJvYcCU7mLs8O0piuTBjG/kN6ez3tFw3nU9fZHhGBltDOE3J5TWI6qXmxjPAS6c9rhvtG2kE8Wz0xtWSj6OvdNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAcAD/JVoWtTKr4fDfOVXLx01vCGVfx/fEMyawgvcmG3SS60Y
	0u89DAkrrkSYiuGgU12FhanbofavwCFKtF2DBPgPkU29leP8QiOGzaXRTYnOkNW35RVulGs+7vN
	hcGP9J6oxHIJJ9uO7gbTTbDY0RWtTMazBpFyFEWz6
X-Gm-Gg: ASbGncsbJHy1NMhL8mdwF/yGOjY8kS2yfaEZetRXLkep0ehe2JmdgmcQiIQnJnV0/jZ
	YPGYlx1J83Uub4+o/Ymd/DeE1anWhfzeZnBd4wIJU3dns+rqTEz5M1uibI96gbv/pxTdOLRAUoV
	ZwMNZibCIlEPZvu/SITvGl/ZtALl6p/T+6jlclSv9yZDFMNpn804ugi0ZmdqERWv8DHytUGjjeb
	1VBeKKocIayr46iFASxZPhmLqNpRZg8TOx5DJamr8oPiseh
X-Google-Smtp-Source: AGHT+IH/sladzkTb97jFQoBNEXbcpPVUkR1OSWTfOCYF7TdtAaFjbi3+K08XTe92DK4d2Igx0jp9W7Rv7hhR2NzcD9c=
X-Received: by 2002:a05:651c:1107:20b0:32c:bf84:eb05 with SMTP id
 38308e7fff4ca-331ee755392mr36538281fa.33.1753788057365; Tue, 29 Jul 2025
 04:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-11-glider@google.com>
In-Reply-To: <20250728152548.3969143-11-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 29 Jul 2025 13:20:46 +0200
X-Gm-Features: Ac12FXxyIb_E3t0l8qtZ2HSqsI1hLPZphi9ZLVEqgdYyys_290qbB_DEIwuF4CY
Message-ID: <CACT4Y+YjtGOnkex3fc8Ugcqx-qYtjty45jgdD3AurFYv4Xq9hw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] kcov: use enum kcov_mode in kcov_mode_enabled()
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 17:26, Alexander Potapenko <glider@google.com> wrote:
>
> Replace the remaining declarations of `unsigned int mode` with
> `enum kcov_mode mode`. No functional change.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> Change-Id: I739b293c1f689cc99ef4adbe38bdac5813802efe
> ---
>  kernel/kcov.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 82ed4c6150c54..6b7c21280fcd5 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -949,7 +949,7 @@ static const struct file_operations kcov_fops = {
>   * collecting coverage and copies all collected coverage into the kcov area.
>   */
>
> -static inline bool kcov_mode_enabled(unsigned int mode)
> +static inline bool kcov_mode_enabled(enum kcov_mode mode)
>  {
>         return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
>  }
> @@ -957,7 +957,7 @@ static inline bool kcov_mode_enabled(unsigned int mode)
>  static void kcov_remote_softirq_start(struct task_struct *t)
>  {
>         struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
> -       unsigned int mode;
> +       enum kcov_mode mode;
>
>         mode = READ_ONCE(t->kcov_mode);
>         barrier();
> @@ -1134,7 +1134,7 @@ void kcov_remote_stop(void)
>  {
>         struct task_struct *t = current;
>         struct kcov *kcov;
> -       unsigned int mode;
> +       enum kcov_mode mode;
>         void *area;
>         unsigned int size;
>         int sequence;
> --
> 2.50.1.470.g6ba607880d-goog
>

