Return-Path: <linux-kernel+bounces-771110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33CB28300
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C721CE2147
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE9291C1B;
	Fri, 15 Aug 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avnBvjvW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F51FBCAA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272048; cv=none; b=cbcNrww66gfLxVFXt+DniWKZwUt1AcxXyn7nzofzVXLY5+xMkQUT6/z7Xkf2yFRD/PLw0fq8TaIGFP1mEdX43wVicUoogNZ2HZjP4rmYfv0p97r0HUBTdfG97Xgna4te1sert1tuWJZO+Xc4yfKSYQ/iXuJWdpwzI0kmykqGbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272048; c=relaxed/simple;
	bh=9lHqDqnCAZOhPJzNdwbbL90BIhP3tdlv+FGXJ+LDFSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=biLKvmUzCTlyxCCvx7uyCXIOmhagYUKqYmDx2j/qxDk8xxEEn7bZB6Uq/Smra6RNPNpLy7lsSjEQ3sX//yd6MOD86fUWU4RzjFX6RuXqAlhcQRciHcOLnE6n02L9kEvdOOFnr5gRGvNAC8k7kpcBSnkNjQZXGOoFuaqgflA6uLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avnBvjvW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267bcee2so2010373a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755272047; x=1755876847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+lAMpo3zrpCtTQnD+bH8tk+Voow5VNOXIWfYifzfJg=;
        b=avnBvjvWNuAXhQEGrAKxegDtMEZChRkTbOIoUixfxDAlCQocltfKCqp8+9YaLyzQHT
         VXmbAV8ctoG18YEkt5X4iCOtGR2cPxq2BUdqeyCuCllICBYxBS6qnXhLLCJI4IzHheQF
         URd/dNsLhAxkzoL8u+j7EIpu6xf2quShoNL2+c3prcWg0j7Teeea1CF0mcg5W3pdf6Mh
         2iT2HLpzIcNcuUf2zmtolB9WYyQLGsdlQsRWuxBpvqlf84d1RqIYRR6KkPPSdH5fLtY/
         R5MmAGFIK6ZgcUCI+8Vq3tvOibWwaY/2eF9OlC/p8DfdHrGIAllzt8vDu89mLR0dFDcR
         vWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272047; x=1755876847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+lAMpo3zrpCtTQnD+bH8tk+Voow5VNOXIWfYifzfJg=;
        b=n1iwuagM0qtzz2Tsh4cZ/ZG8aSf3yC0CVTqqigYUDFytJNichtpDq/5unss5JF4Bob
         MEbM0D57226ZRZ9hUnJ3fjxJ04YqnFy408S7DKl52d9Nas7aiXZ3yFF+tJ1dmYYhQviZ
         lKQDPzF39B0sRdxB4N8l4GtnI2KzAyVyEmyI7OwDCAsN2SXL4yWVcjkfdD4IwuFl/g/j
         lNc7N3cfGyHbETrGmqm30fPxn3trWPUeOxT/L0k8kpEIhPuSF30q4bBOP+qnelbhgqhF
         WfwTD6BmxkXedc2QRTk547ltKCaaRtV6OevaGgb1Z6T75ysncsiI1mhK7PxWUWwE/XYv
         p3OA==
X-Forwarded-Encrypted: i=1; AJvYcCWA+qWrQAgW5qNYRJTySD5ibSH/CG5L1mECaLCwe7nqXNWJ/0FUMdgXbndhPMlGPK0jnduy9tceIdzgUZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2rfs8sngpzaGmm5S+aPNl1SlxjfNErqshDXxma4Sf1hH+EcB
	MuvcHk9/TqgscU4ddKyBrNBwceFQfMv5XAmZqgwxZzHyA+SMs5G4qp593IyvO/PcixHjcYB22BJ
	zRm+8Rw==
X-Google-Smtp-Source: AGHT+IFGDJJaW8mq6Y/ptxBjAXZTERHnVQrVVxPsYnIKl/PSeunKkWvMrdQzayHzGxTYoLzFv2AGXzHzd/M=
X-Received: from pjyp16.prod.google.com ([2002:a17:90a:e710:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b10:b0:321:38a:dd17
 with SMTP id 98e67ed59e1d1-32342147210mr3753630a91.20.1755272046649; Fri, 15
 Aug 2025 08:34:06 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:34:05 -0700
In-Reply-To: <20250815070227.19981-8-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815070227.19981-1-darwi@linutronix.de> <20250815070227.19981-8-darwi@linutronix.de>
Message-ID: <aJ9TbaNMgaplKSbH@google.com>
Subject: Re: [PATCH v4 07/34] x86/cpuid: Introduce a centralized CPUID data model
From: Sean Christopherson <seanjc@google.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	David Woodhouse <dwmw2@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sohil Mehta <sohil.mehta@intel.com>, John Ogness <john.ogness@linutronix.de>, x86@kernel.org, 
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 15, 2025, Ahmed S. Darwish wrote:
> + * For a given leaf/subleaf combination, the CPUID table inside @_cpuinfo
> + * contains an array of CPUID output storage entries.  An array of storage
> + * entries is used to accommodate CPUID leaves which produce the same output
> + * format for a large subleaf range.  This is common for CPUID hierarchical
> + * objects enumeration; e.g., CPUID(0x4) and CPUID(0xd).  Check CPUID_LEAF().

IMO, the end result is quite misleading for leaves with "repeated" entries.  0xd
in particular will be bizarre due to its array starting at ECX=2.  E.g.
cpuid_subleaf_index() straight up won't work (without lying) due to hardcoding
'0' as the subleaf.

#define cpuid_subleaf_index(_cpuinfo, _leaf, _idx)			\
({									\
	__cpuid_assert_leaf_has_dynamic_subleaves(_cpuinfo, _leaf);	\
	__cpuid_table_subleaf_idx(&(_cpuinfo)->cpuid, _leaf, 0, _idx);	\
                                                             ^
                                                             |

And then the usage would be similarly bizarre, e.g.

	for (i = XFEATURE_YMM; i < ARRAY_SIZE(xstate_sizes); i++) {
		struct cpuid_xstate_sizes *xs = &xstate_sizes[i];
		struct cpuid_0xd_2 *c = cpuid_subleaf_index(..., 0xD, i - 2);

		...
	}

Even the cases where the array starts at '0' look weird:

	const struct leaf_0x4_0 *regs = cpuid_subleaf_index(c, 0x4, index);

because the code is obviously not grabbing CPUID(0x4).0.

And the subleaf_index naming is also weird, because they're essentially the same
thing, e.g. the SDM refers to "sub-leaf index" for more than just the repeated
cases.

Rather than define the structures names using an explicit starting subleaf, what
if the structures and APIs explicitly reference 'n' as the subleaf?  That would
communicate that the struct represents a repeated subleaf, explicitly tie the API
to that structure, and would provide macro/function names that don't make the
reader tease out the subtle usage of "index".

And then instead of just the array size, capture the start:end of the repeated
subleaf so that the caller doesn't need to manually do the math.

E.g.

	const struct leaf_0x4_n *regs = cpuid_subleaf_n(c, 0x4, index);

	struct cpuid_0xd_n *c = cpuid_subleaf_n(..., 0xD, i);
and

Tangentially related, having to manually specific count=1 to CPUID_LEAF() for
the common case is also ugly.  If a dedicated CPUID_LEAF_N() macro is added to
specificy the start:end of the range, then CPUID_LEAF() can just hardcode the
count to '1'.  E.g.

struct cpuid_leaves {
	CPUID_LEAF(0x0,		 	0);
	CPUID_LEAF(0x1,			0);
	CPUID_LEAF(0x2,		 	0);
	CPUID_LEAF_N(0x4,		0,	7);
	CPUID_LEAF(0xd,			0);
	CPUID_LEAF(0xd,			1);
	CPUID_LEAF_N(0xd,		2,	63);
	CPUID_LEAF(0x16,	 	0);
	CPUID_LEAF(0x80000000,		0);
	CPUID_LEAF(0x80000005,		0);
	CPUID_LEAF(0x80000006,		0);
	CPUID_LEAF_N(0x8000001d,	0,	7);
};

