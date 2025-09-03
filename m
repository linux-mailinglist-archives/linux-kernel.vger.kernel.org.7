Return-Path: <linux-kernel+bounces-798219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EDBB41AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E216F1F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D02E9726;
	Wed,  3 Sep 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0KxacRn"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694862E9741
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893267; cv=none; b=lI2a65TkYoJGxa1k1D/aGwSRnBncMlH1CiZnSF7GOwMlDqVFV06l8ns4xf8yMVrtTxwlKZ18xufle6rt2FiHALSQrcMyaMcRv8vij4GTTTc4Qm7HeS23KttRF/NW12yJZGen2vGRqPGdrkDKOnD9uUVKGuHOQMMwursbVGPWojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893267; c=relaxed/simple;
	bh=RhkEPFn1xmViNE2hu3hA56fTjRO4yTnz3NaB+IP/EoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqB1IWoo6rWmvhwZPmu/iwxB9zSDAC1GKLF6aVCHtZkPO0sPcFTiDMXJsl11S/OXCjcTAlbmEguUBJ1stQBrKJMxDi6hDVsRts2UVGDnAzRC+E/B7jmYFTlZx/DMDSf3ieMm4CE5nwDYXRAHlDGsrmHyP25kMjyito3oHSZLvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0KxacRn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-726549f81a6so1962046d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756893264; x=1757498064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2Rzk7zMFMEV7RW/mx0yGAjSShG/CZFQjSUWSelah8c=;
        b=q0KxacRnI/ha291IpqX2IyTxElVbf56j6fSYRbRxV9de97Cpxim8Ry1B+IzgVWlgT7
         x/xsQQFi0txDBQagdFu4hR1mFxlmoyuL74uc/r8oVD/SjU3IqPh3VTfZr3BiPGnII8tv
         k3T0OLKvBE1b6R1JOzLwtWQnA7ey7BkWKPngtHvhhHxJMw1xGRjq/5srXOiAmJuw/BG0
         8sEoY65GjPcXt6h8L3TdfDGGYA1DsA64nfecSIb7rCq/ZJae3safYSW9DdwUTMAz+cg+
         o64hoWEueKUhm3I8bF9Q7l4wXNqNbZarcOaVc7Dr6keltO3rUuiMGHL3+SanNK8x4vPy
         MnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893264; x=1757498064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2Rzk7zMFMEV7RW/mx0yGAjSShG/CZFQjSUWSelah8c=;
        b=Q5/zHaH1TifXa7lLfl73R1rRhMnJZcGXox2Daj855hY47tXcAab6YZmZqOz1pFLvcf
         OVzqn6E7p07F/zjlfh7XevXpBavLGzviaZmN+o3VBZd+rmzM/0xBQyGAQqRYaZ2gb/Cu
         wpHt8sXqu6nv5uFdHrad4xXmPNRyKOjKGBok5tHzoV0lJlAlFWB1sTCsSUIF0Up0Yh8y
         /PCOkJ/qhBp96uQtEQfs12dwcuxSkdggOWXMj0UEUSbX34PLyyTy0TQgxvGnuxP4CgWu
         bBI4DejjG/Hh4q7rIsFHTBbFluf23kAj0/oNV6UE5go380mxl1M0+0wnVdmpBtnEHkg/
         i5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWnQyEKmgSF4Mhcr3Fr5/39bHSTRZq/EGkDckozUnHx6rMJuuu6scOtn/pCBLLWKrtC66gvX4K2KJYABUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFX+d03ID8Nr8JUvVjPv/Fwu7B8whl01dNFe2PJvaJQ9Ew3Ks+
	gmjbgUDMlZw6i13JDxP54IC8xVUIHUePe45iyKjWT4hxF7myxsMDlVHmy3Ors1gX1g49PwKhNkf
	Z42C867EIDZpOM8bWZb0UX643yBKpVwHmYADLYIa7
X-Gm-Gg: ASbGncvgK0T48g3WbAFY1HBv0JQjd1Ajvdimdg76tZPgp519XF7QJlJEBFa81xWFkQH
	/A5uHmxWwYL+J4tjhI1ASUerPVFwP27ErMglBYi40mARDGMhOrx7yJB4CVv9H9BbfptFS6Yc4Lw
	zfw3HHF5dtND0GddcXW8E7FBc36gdntijv26SbRFrycd1kvWOahGrqASKJRk9GhspnPdtZYQ/o2
	J3zhONVR/cRSOxhH7dJem0MHIQjDDy7vhnKrvytXYI=
X-Google-Smtp-Source: AGHT+IHHxZ7Hfb0qrsN8QMhYVtNZyxle5uZ0dlr8VDvhNcjFGlkqe7J8XNVXFgqPaB9c4DZ7Jz/xYjkzW/9XPfW8urE=
X-Received: by 2002:ad4:5dc9:0:b0:70d:fee8:e588 with SMTP id
 6a1803df08f44-70fac870233mr189626166d6.34.1756893264049; Wed, 03 Sep 2025
 02:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-4-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-4-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 3 Sep 2025 11:53:46 +0200
X-Gm-Features: Ac12FXz83uIidiq7UvM7XG7YD3kWK8XfBqOv9db-g6kDKvYfHmTPpgNK10-2Ga0
Message-ID: <CAG_fn=UX9+1=CwGB-KCe+s85ZzQXfhqO+2dJVqs93XLKYedeWw@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 3/7] kfuzztest: implement core module and input processing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +/**
> + * struct kfuzztest_simple_fuzzer_state - Global state for the KFTF module.

s/KFTF/KFuzzTest


> +
> +               pr_info("KFuzzTest: registered target %s", targ->name);
> +       }
> +
> +       /* Taint the kernel after successfully creating the debugfs entries. */
> +       add_taint(TAINT_TEST, LOCKDEP_STILL_OK);

Maybe elaborate a little that we taint the kernel because these entry
points allow calling (almost) arbitrary kernel code upon user request?


> +       /* Patch pointers. */
> +       for (i = 0; i < rt->num_entries; i++) {
> +               re = rt->entries[i];
> +               src = regions->regions[re.region_id];
> +               ptr_location = (uintptr_t *)((char *)payload_start + src.offset + re.region_offset);
> +               if (re.value == KFUZZTEST_REGIONID_NULL)
> +                       *ptr_location = (uintptr_t)NULL;
> +               else if (re.value < regions->num_regions) {
> +                       dst = regions->regions[re.value];
> +                       *ptr_location = (uintptr_t)((char *)payload_start + dst.offset);
> +               } else
> +                       return -EINVAL;

There should be braces around this return statement, see
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces.

> +
> +static bool kfuzztest_input_is_valid(struct reloc_region_array *regions, struct reloc_table *rt, void *payload_start,
> +                                    void *payload_end)
> +{
> +       size_t payload_size = (char *)payload_end - (char *)payload_start;

You seem to be casting payload_start and payload_end to char* almost
everywhere, maybe declare them as [unsigned] char * instead?

