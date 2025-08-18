Return-Path: <linux-kernel+bounces-773256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1DB29D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56641885126
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01E305E1A;
	Mon, 18 Aug 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQFx8X3e"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9B2236F2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508409; cv=none; b=kv8g6AZmKp65FnEeDHsYGUjpDoQ0ZFlQ+Crvua4DskqgXu1D1IPRY2xSNVS1m/mCAfDxTmbdc1W9do7FQOKtSOWqiUwCqU5B6kE43d1+8eoisRUbq50QBh/6e2/tDMR6V7H0RinnlFgedJGifnW2l1KIwuxc85mERPrFp+acXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508409; c=relaxed/simple;
	bh=qXvAwrziN/lAskXzwUnoyGUep7OsSqIFEsPdj0CUIAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOKHAcWWY8GNOUdLI7DItu7iA2mKjEOlBfu1bkozh1OuitmqYAqeMfFxP1eUcG+fy9xOshzzonKG4EBsxWWcAYys56gEcsHqzEkhiPNWkMWDQxmUgeYye54baJDtgSYIG3yjdPF5xvFFR8QqGeAfb0QvvVMIFtPlQ2RMOEbBo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQFx8X3e; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so15245685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755508406; x=1756113206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/T6yNTNNcyBvkF4SXYIm0iA2RVO/UVwCmxQoxlZukLg=;
        b=BQFx8X3eNmYpzLDQit1D2cTtkSyv1p08bP36lfK32ZdBCoVI9BpaAb5pImj5o4u/cy
         302T6/kOrvyo8D9I5/bsq5zYFS5UVJuZcHNsC4KwFhJq5s3Cpw6w/Qhm1sScxVaCqEOM
         0yoYLBXq3F2aKpBgOTAD3EzgLTSEDRRxBPOdGFV3aKJHC0/CAJmt3dbrYHCQV5fPqRsC
         lP9kKtl/Qb9rvwFX1eWbfa6UxLP18enOYGVtGBylW6QGNwdY+h19XauzM7e/Ivs5j486
         UgrLd4SWw5acNaPPh2pvAnqxt6VDSF86pQ8M2GJ1HHD4/Y1VZ7tNzzfcJAdCTrBgjnV2
         kAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508406; x=1756113206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T6yNTNNcyBvkF4SXYIm0iA2RVO/UVwCmxQoxlZukLg=;
        b=d8VjLPaYtr+MVEO1s18r6C+X9AzMxCGtuL4/aq/dpUfZJfc1LmTzOuzhRETP5LFGWr
         c57SML6Smfwjy1hlBrXnPUnmxFGPuouxeV4ktDmEYOmnOUvhfNsCk3QcuMeYD77ZHxcN
         6ogh5Zf6eyNt1h0inmfRdh7N80J/FHLDTGzcYy70NOufjOLL3OS9WPWza4IAOUdSlkHG
         2m54H9RklaaBn6aJhNERmFkaLY9yP8YQMQrb8XP87T+L0TewrM5jwnb9d4l7OV1oF30l
         1tzlX+gymhqP7kKU3LSNyDbRluf8wb2HG8Uq5IAVfwWTpKnzG2ae2F9Jy/DAcmL0zKSm
         RzQA==
X-Forwarded-Encrypted: i=1; AJvYcCV0wsVe6EfdOMTa39+H1FHh4lVNXGywfIjeow20wjpUdFx8xZMM9BRoguSO+F6N0ems/QYJbI32jy95uGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UXzQGep+t0t8TiwLsPfovqN4tJEOUKp3g3IGBFbJ0Q9Ffq+E
	zh+e6L0ri3EQVzvQ3vkKXEWDpvPy8nDGxt7BQbbLAdI7YPze+mcSOT9rTntLZcbmcAiE1dlDgMn
	k5QdKpjf2fV8Q5w==
X-Google-Smtp-Source: AGHT+IEEnD0SZkFL9rIzkzBduK0cuXWfiUbNnfGFlI8aPtDy+1l/AuP7IrZsSndDMSEvFTZEEMsWZrM6hs7vPw==
X-Received: from wmbes10.prod.google.com ([2002:a05:600c:810a:b0:459:d4b5:52cc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1914:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-45a29a7173cmr36698975e9.1.1755508406524;
 Mon, 18 Aug 2025 02:13:26 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:13:25 +0000
In-Reply-To: <20250816152820.427784-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250816152820.427784-2-thorsten.blum@linux.dev>
X-Mailer: aerc 0.20.1
Message-ID: <DC5FSK5QO5B4.2IJ9JV7V88Z96@google.com>
Subject: Re: [PATCH] x86/common: Replace deprecated strcpy() with strscpy()
From: Brendan Jackman <jackmanb@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat Aug 16, 2025 at 3:28 PM UTC, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.

Seems like a good NOP to me.

Reviewed-By: Brendan Jackman <jackmanb@google.com>

> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Note: I already submitted this in April as part of another patch [1]
> which doesn't apply anymore. Submitting this again as a separate patch.
> [1]: https://lore.kernel.org/lkml/20250425074917.1531-3-thorsten.blum@linux.dev/
> ---
>  arch/x86/kernel/cpu/common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 34a054181c4d..8aa170762cc7 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -184,9 +184,9 @@ static void default_init(struct cpuinfo_x86 *c)
>  	if (c->cpuid_level == -1) {
>  		/* No cpuid. It must be an ancient CPU */
>  		if (c->x86 == 4)
> -			strcpy(c->x86_model_id, "486");
> +			strscpy(c->x86_model_id, "486");
>  		else if (c->x86 == 3)
> -			strcpy(c->x86_model_id, "386");
> +			strscpy(c->x86_model_id, "386");
>  	}
>  #endif
>  }
> @@ -2013,7 +2013,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  		const char *p;
>  		p = table_lookup_model(c);
>  		if (p)
> -			strcpy(c->x86_model_id, p);
> +			strscpy(c->x86_model_id, p);
>  		else
>  			/* Last resort... */
>  			sprintf(c->x86_model_id, "%02x/%02x",


