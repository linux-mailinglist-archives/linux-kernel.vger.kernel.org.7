Return-Path: <linux-kernel+bounces-866492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE5BFFE83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E288F1A60ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D92F6198;
	Thu, 23 Oct 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJW/jBvn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212012F39CD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207909; cv=none; b=jvNH8gkUzO/RqRknRYzOaF+tBk418pHasD5dl3UAQ8Lu66taCfBOVthR68/pZTE4u/F8NU98KiME9h9U7wsen0mOeUvDEAUj/BopQBaymp2YgNkBswrPolOUGV5bnXlYoNpr83ZYsR1cS6WsnK7haaSelqXln1HOiWq+MuIWn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207909; c=relaxed/simple;
	bh=8uFSr6rrAqRbXJyqL++cJk6NZkw/N9HzJnLXjE8DGCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1mXjLm8KBNxggdFbqEhfWg9RG0ewbcmEmxKWOwyJ+++JACKbfUMe92/qXo8XUvRZ7MJUCTTPmhiLJIaL5HWu9Wyudc5saIqgZLJhYLXV67b/2RRwD4VxukvzVvIYNkkdYoaYGtZwqTZkLooyD/njbY7ZgZjriR49ckzkvkpw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJW/jBvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889EFC4AF09
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761207907;
	bh=8uFSr6rrAqRbXJyqL++cJk6NZkw/N9HzJnLXjE8DGCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GJW/jBvnRT77pUoElHY4MI+M8h7Lb2CPmZH1H9Rh7RdxaJ9QYhUfuHE2vQ2+BV5Sd
	 cg0GnzOpmcM8C4JS02qnvvjDtvnQr3lUpQjcr8AjQAmRCgzPgT5sYbdHIF3oCd8Oax
	 EyC1uklPKUlcRmQvOAvrrfkqsy5dRRAECJPEldJaMZQ3p7jMpEwQKZDCbuOFhQaRLU
	 S0bg1BWJ/efFfmTkEnL4yZCp5Y6l5WszOLkl8ak/ttqT/3QqMHGG03iOuAVzIW7JEO
	 q7pNo3Fmfx8sHw9lQ2IOcqxvrkvn7PzLnC4fG4BXiToVM5xp6LYFeiYGdUvd3fxa22
	 BZziQk3yBbuUQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-591ebf841ddso694403e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:25:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUehxHRtRu7D7uKPWe2lcZqNP01kWjjImxooEaD109onEoC9VJPRfB1pGpaIb3fpR1IV9ZS2Sz4VGjW8DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiwoRVhqihlluyzWM/myls/WPRrjQMkVL6tYx8xOw2DVnncqC
	9aLX0dpme2XsjPikN/x9RYHSLsRLZrvnDldg5mCdVdg01TEe/LRx+jDVDy0EAKblHJw3q5mj2Y4
	4Cfkt7h5DSysw3ogYtbtCngKVya0MkxQ=
X-Google-Smtp-Source: AGHT+IFqxCRVEmx55DEcN0eJFnMLXpSkmlRfev16YFdxPuXEJ4mAx0bSIsmzzz9jkU7OKoN6o4/LXEDo/QTVrb+7eC8=
X-Received: by 2002:a05:6512:3b88:b0:55f:435e:36bd with SMTP id
 2adb3069b0e04-591d846bbfcmr7204989e87.0.1761207905935; Thu, 23 Oct 2025
 01:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233743.1134103-1-mclapinski@google.com>
In-Reply-To: <20251022233743.1134103-1-mclapinski@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Oct 2025 10:24:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqwOYBNPzNYo2vjPycjyO5SrEnk_wRVDw_dhGd8qT2qQ@mail.gmail.com>
X-Gm-Features: AS18NWDYkROAgecZyBS_FDHCff6W_5tLYQcUqfJKBxEipeFY6nP-phMCDUvL4gE
Message-ID: <CAMj1kXFqwOYBNPzNYo2vjPycjyO5SrEnk_wRVDw_dhGd8qT2qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Michal Clapinski <mclapinski@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michal,

Thanks for the patch.

On Thu, 23 Oct 2025 at 01:37, Michal Clapinski <mclapinski@google.com> wrote:
>
> The intent of the code was to cancel KASLR if there are more than 4
> memmap args. Unfortunately, it was only doing that if the memmap args
> were comma delimited, not if they were entirely separate.
> So it would disable physical KASLR for:
> memmap=1G!4G,1G!5G,1G!6G,1G!7G,1G!8G
> since the whole function is just called once and we hit the `if` at
> the end of the function.
>
> But it would not disable physical KASLR for:
> memmap=1G!4G memmap=1G!5G memmap=1G!6G memmap=1G!7G memmap=1G!8G
> since the whole function would be called 5 times and the last `if`
> would never trigger.
>
> For the second input, the code would avoid the first 4 memmap regions
> but not the last one (it could put the kernel there).
>
> The new code disables physical KASLR for both of those inputs.
>

Should we just disable physical KASLR if memmap= appears at all?

> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> Suggested-by: Chris Li <chrisl@kernel.org>
> Fixes: d52e7d5a952c ("x86/KASLR: Parse all 'memmap=' boot option entries")
> ---
> The patch was suggested by Chris and I modified it a little without his
> knowledge. I don't know which tags are appropriate.

I think this is fine, unless Chris has a different opinion? In any
case, you might add a link to the original submission.


> ---
>  arch/x86/boot/compressed/kaslr.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 3b0948ad449f..649264503ce6 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -162,14 +162,18 @@ static void mem_avoid_memmap(char *str)
>  {
>         static int i;
>
> -       if (i >= MAX_MEMMAP_REGIONS)
> -               return;
> -
> -       while (str && (i < MAX_MEMMAP_REGIONS)) {
> +       while (str) {
>                 int rc;
>                 u64 start, size;
> -               char *k = strchr(str, ',');
> +               char *k;
> +
> +               if (i >= MAX_MEMMAP_REGIONS) {
> +                       /* Too many memmap regions, disable physical KASLR. */
> +                       memmap_too_large = true;
> +                       return;
> +               }
>
> +               k = strchr(str, ',');
>                 if (k)
>                         *k++ = 0;
>
> @@ -190,10 +194,6 @@ static void mem_avoid_memmap(char *str)
>                 mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size = size;
>                 i++;
>         }
> -
> -       /* More than 4 memmaps, fail kaslr */
> -       if ((i >= MAX_MEMMAP_REGIONS) && str)
> -               memmap_too_large = true;
>  }
>
>  /* Store the number of 1GB huge pages which users specified: */
> --
> 2.51.1.814.gb8fa24458f-goog
>

