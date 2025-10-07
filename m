Return-Path: <linux-kernel+bounces-844770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B8BC2BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34E304E3EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88702459E1;
	Tue,  7 Oct 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykhMHFil"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C51D7E41
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759871802; cv=none; b=KRS0sROnblLzlnUth9tqNOtpGNQQ33HdOc8Sf+BAvmR9FNBA6TutEttXqVJte3FCXJ4Cn0CO2Ci/muJUvzbuSR4o4nSCkLfc2hPUpulGECg01Heqa2EZAUNTLVox+DDfMmskodMh8scTpJOoC1xYz7mLSTR936t/sF+KpFaaAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759871802; c=relaxed/simple;
	bh=BHCkvXNoKTk8jmKhOfycZLfdR0v9T37k4whB97KDImc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp46873vEBfKvJVVTLnMKFbiBoUbX9QawuO7SmEQwfojCyDB9D/cr5XI6LY83xydULT+leDu2GiBFTaQu+yghNNzKllaSEpPMrBE5DVn23OczkI44iIJjgMxTeUGvEhSE9F0dDffIDPmfH382wH7XhMYiGvY/m47LfT6ZXGPXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykhMHFil; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2681645b7b6so24815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759871800; x=1760476600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2QqANFX2LPHkZhXD0HBeGVr/gP/YomGFWGJkcvYX2k=;
        b=ykhMHFilbT69YPsJzTk6gcMPiar5ZDCg4tftAzIs+dz8U5cvA/ZWuqOyNZ/3oBjfGc
         HaEMDwrsgoTCwbZwwUogcAeFb7GikFn3x93HwqV4aRAB+/4/NyuLPVGZwmLqIBecNg1E
         35IDUINavQdZDd/p1hvix6bwLBquofxLLfLF792RsH6b95T7VceAjPAWOEWlmZ3Hrh3W
         HgyE7hK6vPBIFMOzlNjyZq+OiZ8y1fMO7InchXcuGr24deAn0+oiDF1i6F+vwTWTtQy9
         aVz1hamkBlmN6/u6+HqbNLsx8n92OETIJsL162IE0TTr4ZJDvJNEg5oOA+d0ZqlS+VWR
         kBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759871800; x=1760476600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2QqANFX2LPHkZhXD0HBeGVr/gP/YomGFWGJkcvYX2k=;
        b=DPPJjHMzrKwB64NMOKO+Z4Vq6AI7DbHoKTAEZQkBS4rU8VRVbrN+pSQ6YSP4pBWFXA
         EvYA30SRZ43o7oqtv3s634d5YOE0ziz5jajJJSWYwFaJaK5idqrmf/3GyzuFFIbthaH/
         HsGz5qm67O257KYnoFRD+gHoaRWCIU99RD6SASMqlPjEseRgJkDfYxUUIVKMCN1YJj60
         52q8403chr7aUrSNEZar14d1Dv/RhMfZlkO+QmGYOIiPH4Kn7RU9HgJtiKoXD6svbmrO
         wZGD6wjqZwQpWFvLYg8od9XnrTrDYJNjQsT9eySi1/tvYVm4QnBsUPf+DRTJaIPQe5QE
         jc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEubR9/OdVU/g185AgFjhwd52RGMhh/XZg46SwahTJ2OllIWGwg/7RuAmib/CUEmmyjwLQGUg423z7Khs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AaQYiFkIzasCT7gWX7xhYsslFQ4I0nVibMh0Z1pQWNsKZTSP
	IDeF57EZETkvpZt8t1mMV+KDdOEF5T2ryrz3vSRRlh2pMLim4lJ4gjiF8fzwkmrUBg==
X-Gm-Gg: ASbGncvtIBnI28drRxuhdDFtLJVuECLI3N6LHq7q1vzcy5KeNOHj/xpU5Hnf/dhATcZ
	DA6qIf3oy1vfIfnwHFWTARQsVelKfd9lTLrzQ6YlO8XnqYsbOL/CEnw5xr7kmaTq0XDYzVAPWgS
	s+FUVU8eO53B7W2XkDbUl7EttmFI7+p+y7IaUCeKTv/Rb6jxHcyEHiz/XzPFqWy6hTwmX+aaLBi
	70Zh4ZgP6HrfxK4khyOJbkSywItb/1YKD2L6u2iB38l6M72BaKwQprY0hgjpBmgOet2N2BkKlw3
	yQpk+euxNko9SbsJnsGu9yWBkK+PIz+WYHilYAYMhu1XhtV43Xw+goks1Sx5lwDY0YUoiIKn7CH
	+XNduajmgEFr2MYvF3PPhFwTjihwYEi78JXnAmrW9OoiXgazCr+JhQdzKSTw1dGeVxk9FNuEl8o
	tK3/Iu7HL5dtnCJO2bjJPwHsBVt5y4
X-Google-Smtp-Source: AGHT+IFBVfvcoKubDQzM9ayca7g+2ZobIcYGeDEcwf0nhxbMMwylROUpa0JJFpvYgiSjZLfY0V4/yQ==
X-Received: by 2002:a17:902:ceca:b0:266:b8a2:f605 with SMTP id d9443c01a7336-29027600f6cmr2020635ad.3.1759871799868;
        Tue, 07 Oct 2025 14:16:39 -0700 (PDT)
Received: from google.com (115.112.199.104.bc.googleusercontent.com. [104.199.112.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280a1sm176064595ad.51.2025.10.07.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:16:39 -0700 (PDT)
Date: Tue, 7 Oct 2025 21:16:35 +0000
From: Lisa Wang <wyihan@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Fuad Tabba <tabba@google.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v2 11/13] KVM: selftests: Add wrapper macro to handle and
 assert on expected SIGBUS
Message-ID: <aOWDM_7gYNwUZFgz@google.com>
References: <20251003232606.4070510-1-seanjc@google.com>
 <20251003232606.4070510-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003232606.4070510-12-seanjc@google.com>

Fri, Oct 03, 2025 at 04:26:04PM -0700, Sean Christopherson wrote:
> Extract the guest_memfd test's SIGBUS handling functionality into a common
> TEST_EXPECT_SIGBUS() macro in anticipation of adding more SIGBUS testcases.
> Eating a SIGBUS isn't terrible difficult, but it requires a non-trivial
> amount of boilerplate code, and using a macro allows selftests to print
> out the exact action that failed to generate a SIGBUS without the developer
> needing to remember to add a useful error message.
> 
> Explicitly mark the SIGBUS handler as "used", as gcc-14 at least likes to
> discard the function before linking.
> 
> Suggested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>


Reviewed-by: Lisa Wang <wyihan@google.com>
Tested-by: Lisa Wang <wyihan@google.com>

> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 18 +-----------------
>  .../testing/selftests/kvm/include/test_util.h | 19 +++++++++++++++++++
>  tools/testing/selftests/kvm/lib/test_util.c   |  7 +++++++
>  3 files changed, 27 insertions(+), 17 deletions(-)
>
>
> [...snip...] 
> 
> 

