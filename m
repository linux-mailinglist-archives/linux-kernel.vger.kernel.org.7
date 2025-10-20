Return-Path: <linux-kernel+bounces-861145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA12BF1E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B464F07DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED044225397;
	Mon, 20 Oct 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQ92lt0B"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC060207A20
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971353; cv=none; b=qmzYRpP2nNHZCaAm+Uj/Nso/Oir17KiWmZyztvonkl1CFNCjtk6ct3VPRhLQFN5yH+T7vv6pJ66aknDGKTtgfYe9IZihe99lhus7nF8Qcov/hUrLmQ5nO7yxttLt0ah0gibyzC8z5iWCEuEw10wV/hbDgbnuAqUTzl3xhwcK9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971353; c=relaxed/simple;
	bh=AUm+U1cdUJCUKS7ZA7tvxHQEACWT09VkO+uyfX+/uWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uAPj+UhffNqlVe80k8D6/MBtGoLeY2Yq6SgiMZa9BhN8Rv9FL83hjbAon9O6fJLoAQylqIBWROdUPX7qmMEbhlc2i/2kjhVT59KqYF+79sFx8YrnJJyp7NNJHbM66eRtLNgTaWVwdp1iV5u7GV/x8QGL2kx6f43SXHKAOSNswH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQ92lt0B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28a5b8b12bbso111603975ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760971351; x=1761576151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/WpZ95ObL14bxrV4qoPKrRDt1vTTzIm3G3nDoruhqI=;
        b=WQ92lt0BjiDLRLgYEcxupjmofrf6gsD3q6UlQuxToxhrVQafpVdltAH6PrXBd+m1X5
         o//oYxMlYS/6KF1ai0OMcC0LtRIP0WRsl8EjcBgmROziIB1hr3KGIwaDd2WLG3FsbfLR
         lE42ejKvS3ObYJH1pg4wX5dOe2lKGCueMMhgIyY4psq2Bi7kaYsTpvzZDyY9D8c0glI6
         RFi0mBBHtxY45Yrqfhk3/D8LcSy1dnTEBG0hK8yuQudLGI2+UUhnAVaLsoBEDU15aFU0
         7w8aZ6JUBMJijVRcUuuWWl3mXdVBohGyZ6DegA3BPHFYSoZ6Jstq0RRePYKI3qIfNdZv
         MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760971351; x=1761576151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/WpZ95ObL14bxrV4qoPKrRDt1vTTzIm3G3nDoruhqI=;
        b=KmLOzXkv/2Ni+mLa6JiVLvO1raN6HY56hbRxrZsgIcRHn9L+4Y4AOSq7RmxYkiZFyd
         YHcAIOhMRW7JQ0THqfn3WTrLQsL0GAlVk+cXQJJON65ZTiSKD9E6R610swzmQ6OObeMj
         sSnIrlcbwZ1f91ABXY8xhBauGfoDlrR9jKHJ03D+iSqTj7JfrSgD6F0KFlRmJfEdl6xS
         D3rZbOgYipBT1pc9ZKrSoa+QD6o9PWJoRGdVFzLzIKJ/pSqCzloBstEvb1GHTuIcis56
         HVZ6dNESFAsabjNG80b49mbNO65ODT/yUa6Twob41ugNmpbJWCcGAaHMVN+vix00etLj
         G2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXymHTxxTTrP8bfOvvElubMO0DTpOZSkRJj3GoJ72HU9CfrwSlunwR3HzlkmU7c4s1OsyaCVlp94sBp1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqMVBPvtCvihmZisIOmN0D2MuG7zF5UZjmBurnx+WPFuB5eDk
	PDZUklD/pPISy0fwurTKNgkD+DXW6zSImcZx4NvJH5My99MlqMZgStuEipGvBLHXqxeJmUEn+8x
	yVTQABw==
X-Google-Smtp-Source: AGHT+IG5bkRz1Grck5fnmgvosqDspDZYYbROSXUDaOdreC4Lek0m1RZScrTovv3SkUBdnFvn817DXQ6Q8sI=
X-Received: from pjro20.prod.google.com ([2002:a17:90a:b894:b0:33b:dd01:d6fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d508:b0:28a:2e51:9272
 with SMTP id d9443c01a7336-290cbc3f200mr190082845ad.48.1760971351111; Mon, 20
 Oct 2025 07:42:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 07:42:29 -0700
In-Reply-To: <872c17f3-9ded-46b2-a036-65fc2abaf2e6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910144453.1389652-1-dave.hansen@linux.intel.com>
 <aPY_yC45suT8sn8F@google.com> <872c17f3-9ded-46b2-a036-65fc2abaf2e6@intel.com>
Message-ID: <aPZKVaUT9GZbPHBI@google.com>
Subject: Re: [PATCH] x86/virt/tdx: Use precalculated TDVPR page physical address
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kai Huang <kai.huang@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Thomas Huth <thuth@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 20, 2025, Dave Hansen wrote:
> On 10/20/25 06:57, Sean Christopherson wrote:
> > Why do these structures track struct page everywhere?
> 
> I asked for it at some point. It allows an unambiguous reference to
> normal, (mostly) allocated physical memory. It means that you (mostly)
> can't accidentally swap in a virtual address, pfn, or something else
> that's not a physical address into the variable.
> 
> The TDX ABI is just littered with u64's. There's almost no type safety
> anywhere. This is one place to bring a wee little bit of order to the chaos.
> 
> In a perfect world, we'd have sparse annotations for the vaddr, paddr,
> pfn, dma_addr_t and all the other address spaces. Until then, I like
> passing struct page around.

But that clearly doesn't work since now the raw paddr is being passed in many
places, and we end up with goofy code like this where one param takes a raw paddr,
and another uses page_to_phys().

@@ -1583,7 +1578,7 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
 {
        struct tdx_module_args args = {
                .rcx = page_to_phys(tdcx_page),
-               .rdx = tdx_tdvpr_pa(vp),
+               .rdx = vp->tdvpr_pa,
        };


If some form of type safety is the goal, why not do something like this?

  typedef void __private *tdx_page_t;

Or maybe even define a new address space.

  # define __tdx __attribute__((noderef, address_space(__tdx)))

The effective type safety is limited to sparse, but if you keep the tdx code free
of warnings, then any and all warnings from build bots can be treated as "fatal"
errors from a maintenance perspective.

