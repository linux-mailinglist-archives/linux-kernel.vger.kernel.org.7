Return-Path: <linux-kernel+bounces-830882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8088B9AC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B261897700
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4FB21FF44;
	Wed, 24 Sep 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4eNvOXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC564A8F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729275; cv=none; b=EFuGYXPtCtHx+JWPO5l1iWNzqbcHiVeyvRP3o5NY7jTb681M0kJYpBW3Tn5lS1pspj5zEQ/2PHGjLS72hb+YOusNZUqcbsGI9DqhtRJxOpNBefTRpDR90jnBCnssH71jrNd3l1hzf4KkYvqAejZuQ8shuZmPIaJyQA9gwAUMMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729275; c=relaxed/simple;
	bh=xgbG+Ne5vEns3KfVSidt9AKEI75HCfr+uIbP+cEpXmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGpVnkein1uxfFXe40VF0hHuBwOTXkLfQ+fkAyVYbMfA3lGBViJ78vPyZjZMh1GL6f99vsMeJgD1Ad1zsSGnF1UO8ElYshd9RHT+9XdVKz6bwBp301l6CMPvDzz/HFLB6tRPQ4hmqFI2elLLr0KjeBX+Id3NICiPf+vGydgAvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4eNvOXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D174FC4CEF7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758729274;
	bh=xgbG+Ne5vEns3KfVSidt9AKEI75HCfr+uIbP+cEpXmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H4eNvOXu5rw/z2Ja/Z6MPM80k4kPDskGC67/AUhzKiSNFCttFghi5KXh2RwTaUPcH
	 9Zr+zTQXjA0EhNjXcGz6J3YVK/EV5L6/R6CCA7W1XxDcWxdGzwMDH6OMuQm5MZe5jw
	 fjyCixN/Gm/nWW5eNRuerL0TCkVKxqKhd/XmYGZ1kT7XD+MD/DByO2ba9dyWSiWb+x
	 ihN2oQbIV3boQKe9DBYvPGH53npc/TmLR8FZ+tIgrf76dSUBn0Emkx9A686rFjByr2
	 c6sym+141zL2xopx4ItO5ljm3JBBxdboYiMoD3EBJSfqvVnkHzG/Xuo2XxHEFeh3Wy
	 ck1fpWUVEDPuA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bd7f0e5baso4076675e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:54:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzM+yWeWfYF15+zc1JaE4fIm3nvJRQ2vGOSWu78Wpu61iel1KvT
	vz9atYryg9RYD5Hv+9pyAE+RespdLuWjHyYFb5fpqXK6JVD1W3aeQIJIc3ERbNM/RjMiX7ffyow
	4+yu/O4XapLvTtKpIJNLmGmQLBY3LezI=
X-Google-Smtp-Source: AGHT+IFmGO5tnUsEbMEYv39fCF4oILEOYHwYYg6kUpjUuGJqGsb3xLgGZQ7JkGTDs4fE/OL4QLceMYaoIkKzMSHPFNs=
X-Received: by 2002:a05:6512:3e04:b0:57a:7c9a:e826 with SMTP id
 2adb3069b0e04-582d092e603mr2224e87.4.1758729273213; Wed, 24 Sep 2025 08:54:33
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924155310.3341370-2-ardb+git@google.com>
In-Reply-To: <20250924155310.3341370-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Sep 2025 17:54:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHGuBB+Z6Yu_u0-NzNH__ho5GqCJH+fDz2ks+WMihVCGA@mail.gmail.com>
X-Gm-Features: AS18NWBmex-nqwj6eMYr30HM3l5DjbaG6tqJQFzAArn50HUF-0dY-BV_ZPBUKiE
Message-ID: <CAMj1kXHGuBB+Z6Yu_u0-NzNH__ho5GqCJH+fDz2ks+WMihVCGA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Drop erroneous __init annotation from early_set_pages_state()
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	"Aithal, Srikanth" <sraithal@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Ashish Kalra <Ashish.Kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 17:53, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The kexec code will call set_pages_state() after tearing down all the
> GHCBs, which will therefore result in a call to early_set_pages_state().
>
> This means the __init annotation is wrong, and must be dropped.
>
> Fixes: faed658ce71d ("x86/boot: Move startup code out of __head section")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>

> ---
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "Aithal, Srikanth" <sraithal@amd.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>
>  arch/x86/boot/startup/sev-startup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 39465a0ff4e5..c4c389f7cd06 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -44,7 +44,7 @@
>  /* Include code shared with pre-decompression boot stage */
>  #include "sev-shared.c"
>
> -void __init
> +void
>  early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>                       unsigned long npages, const struct psc_desc *desc)
>  {
> --
> 2.51.0.534.gc79095c0ca-goog
>

