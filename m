Return-Path: <linux-kernel+bounces-880055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A932C24C40
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384D7401E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2D345723;
	Fri, 31 Oct 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q90EUdEE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C11327214
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909771; cv=none; b=maHGsGBFkJ4Z9oCOZmZ9MZ0Pisf4yDSPE7goJr0beapbwLELh29mTvgFni4xHG5z1KfgmUk+g7PNu3LUI1B0WeMlpqQDY+3QNI0aszxLfqIQqcCSgNBeAniVXAvm27DNha5LYdxxkbrh6B/JfXJz8PFGXLQg/tEDH61tKbYccx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909771; c=relaxed/simple;
	bh=fbWhQfJZj8HCmG3H1/jP5tgPn2hV/GyhIqcog7Ktfkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UkF8UnIzNIQ50LqtfjpphU4SjhCFx8Zaz9JHIijUUiAWCHaVJPTaRIDyF1ugapz1dOV9K6ncPx5Tp72D+t/G4Mu6C5zA9v6Sh1AWsQbG6w4fnbskY5nHhgGBtzSo6caW/1cdkyAHouR50azPqJlE+Kd1Gj4akHN7oT+mvMHulLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q90EUdEE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475de0566adso17048525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761909766; x=1762514566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWfm1RxpCriXJZKJWKkjI+FEcuEWh6aqEd8ZawD9gRo=;
        b=q90EUdEEvIDK3haYfEF1A1Gc9syg8Wwwt4cj3VNFkGkN7zsECzUV5ef2pF5asonmPH
         mIjlBZMOva0nbPGgpjf6zZEnkU2HBimL+3byrNzAfHAkSD2gEWNhAYX9u5FOORPMjhtE
         esXhrulZvx+GFT78OcKttIxig62OlP03V0iIChkiAgBtSa+omX38r5A4gnY8buraWmOR
         jnAI0VoFamDBPy0rXAxj3VMiz6GX3S5Akc2/weSsEPv6bqXr0U1QWq5O5elw17Z3J3sD
         QOFvvQnCLHUu8aMhKpFBLShyQb5O8ge4huLoscuxwh3EF182tuvSGwcRrBySLiSkJJ3p
         jYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909766; x=1762514566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWfm1RxpCriXJZKJWKkjI+FEcuEWh6aqEd8ZawD9gRo=;
        b=sq5GX2k2JwrtkUqCu5oAusCLi9Df6jIFDmhCVdeC5dKXt7QpzCU49AfJ+FJUMVj/Qd
         X3mP7hi9sgDkjQFnxgHs11QZXaVT3YGYP/8FQ3g0ueGzOzeDvi7McqfMHbTSBiG0LItJ
         7p/6f3xy7JCkUM8YVBtrZLQLdwkA+N+rK0DLNw0TPbj1nLDj0J+kMmup1JHGARHLfxpN
         +EgvGbEWHb1U/ezK14kNASiXdN2Df1ZkASVj+fKXucm88AtryZHEJdGgZUVa2lfMLYTG
         Og8d+G7SQ1OgoVngkjP8mj4p05iOMvT0clMCthYxqvWgaFixDjX/Hk5ybD0rHjRxbYxZ
         D8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7HSNSsL4bvZzrw7haQlo0k5DY/Bh2B5dzt+nlRFGAkj8U10KqLcLVHd6kr9IWt/mhJaW4fIVYKGjv/8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc74dR7vwKn1Xm8yx8AKrog6SJSCzpmyD5ol3g7h268ZtkEeAy
	vIt3kB03hN9BsO1a+iMm8+jFqSChtU9t5fbDbp2XcILx6IfjUwD1Sbw4+B0jLANF7flcm5YvU7o
	WR1h02OzxiG0ufQ==
X-Google-Smtp-Source: AGHT+IHH+CXCZrRgwm3g861gn6Y0RlY6O0gwkChBWJhVrVubqV8OJjXSbqaG9Nmja1vNYsXI9PQqe4gQXc36Cw==
X-Received: from wmbd14.prod.google.com ([2002:a05:600c:58ce:b0:46f:aa50:d70d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a0b:b0:475:d952:342e with SMTP id 5b1f17b1804b1-477308c2961mr32962115e9.35.1761909766216;
 Fri, 31 Oct 2025 04:22:46 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:22:45 +0000
In-Reply-To: <20251031003040.3491385-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDWGVW5SJQ4S.3KBFOQPJQWLLK@google.com>
Subject: Re: [PATCH v4 0/8] x86/bugs: KVM: L1TF and MMIO Stale Data cleanups
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
> This is a combination of Brendan's work to unify the L1TF L1D flushing
> mitigation, and Pawan's work to bring some sanity to the mitigations that
> clear CPU buffers, with a bunch of glue code and some polishing from me.
>
> The "v4" is relative to the L1TF series.  I smushed the two series together
> as Pawan's idea to clear CPU buffers for MMIO in vmenter.S obviated the need
> for a separate cleanup/fix to have vmx_l1d_flush() return true/false, and
> handling the series separately would have been a lot of work+churn for no
> real benefit.
>
> TL;DR:
>
>  - Unify L1TF flushing under per-CPU variable
>  - Bury L1TF L1D flushing under CONFIG_CPU_MITIGATIONS=y
>  - Move MMIO Stale Data into asm, and do VERW at most once per VM-Enter
>
> To allow VMX to use ALTERNATIVE_2 to select slightly different flows for doing
> VERW, tweak the low lever macros in nospec-branch.h to define the instruction
> sequence, and then wrap it with __stringify() as needed.
>
> The non-VMX code is lightly tested (but there's far less chance for breakage
> there).  For the VMX code, I verified it does what I want (which may or may
> not be correct :-D) by hacking the code to force/clear various mitigations, and
> using ud2 to confirm the right path got selected.

FWIW [0] offers a way to check end-to-end that an L1TF exploit is broken
by the mitigation. It's a bit of a long-winded way to achieve that and I
guess L1TF is anyway the easy case here, but I couldn't resist promoting
it.

(I just received a Skylake machine from ebay, once that's set up I'll be
able to double check on there that things still work).

