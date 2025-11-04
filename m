Return-Path: <linux-kernel+bounces-885270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30CC326CA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE58242602F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167E333C503;
	Tue,  4 Nov 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCdZc6YX"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB0339B47
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278430; cv=none; b=KaVmiKCrV4m4TitYAPcf9j1BVe5CL/tScb390OjfU3BPT6dSCvibPa1/C3k05XGZNBl+j2m/PffMnMU6LhxEdFzV9KEhyB9y1HzkbOqSIKrmhn+vLDjjmWt1ycqQsyu2ohfXqPLC32CCoxubPwZVjfikueK6KzFbqwuJWUg4NY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278430; c=relaxed/simple;
	bh=o1UzLi0rBAxaCgAw/bo54fRW3GIvb2Y0iafyFAWxNSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ptP9g/21jDMGvGeFE/p8XI0caVDbWcPxJ+Hbku6/RiBVpASjCiOlnGDnDrt2otVyNht0/w2r61Z/BdOAGMPUQK6WpRh5Bry2HrmJUMUzHF8I//fVDpGh35L3f8HXk1Xdf8RNLtvC2ZZLVOEAWwAndHj3qrqHBD3XApkcagSx6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCdZc6YX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so4924449a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278428; x=1762883228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBgTOmIH2rvFMcQtZbtLCHjPqtzcnQ/DckIBiusjMm4=;
        b=LCdZc6YXi9MxjkEajd0Ru9W0lRIaUTW58qpobVtyMO9PEDMkCRm6XCz+6nbvBJEZij
         pxrvhEEszgnGvRaktuFaPvMxU4p+3bWYRMwEkQcSHfqSt2nzpfbDCdRvRKfnzZyO/L+v
         TNVZfEEnwUwwz8hC5R6wruJp2eyokCOjkhJ1yhcrKMyYvKX8ASkpmn1zqKC0o6cAzqjT
         xFh6RTNmhlBD9MFL1fzBBUdzOYyVAT9+b2cUglRsdxykq2L+Be78VG/stEg8cArMlB0Q
         6c4PbkQedKEWGRdh77bkne791l5yEKMYES2e2zFX2oDDBlECtYORJ6W2OdN50I89M8dc
         oeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278428; x=1762883228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBgTOmIH2rvFMcQtZbtLCHjPqtzcnQ/DckIBiusjMm4=;
        b=gPQ+WTNriqkPFF2UsKHR22yn908Wtpcz93uoVmsigoWwWgYrEqH2GzUdkJyAdEywn1
         P6aAMZ/2rjasGONVNTNvuzxXoyzByvHA3qtqkAa0lmmEUR/f6htrwOc2420zFAKZy14b
         osH6Y/2UDHpaGxPPHlkQa07DCTgrIaaMygGtcQQdhP7erW/tOPUMyCQMf2EbqzUQvKdq
         GkSWiI4PNI6ODRx49J8SEhSuAjc2iDxE3h3FjXoVoyBYU9AWl6c84m+dljkTfXbYEu9t
         xacZumeMGpnbwNE12Omi524mvb2LTbJNiGkeKVQ1jIyuUbPVRvK0FqLyO0s5a111jA45
         AI2g==
X-Forwarded-Encrypted: i=1; AJvYcCVCsVVsglkFzHSz2sffVGWhI8Q7TX2sBmeaI2ZtAbDnaan3dkJFX6wN3rGxwzxz5B1RO7eB+1V1UdPuDgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wE7ud6GKpP1ZMddwFrI7bfSKAyfT9XbDqn8lozFBYLaXSN9n
	fsSoBrAPXPVXqbOBub5gGxCI2UIt6hi0z62T1mr0X7yKiSOb18H9MKgZ2pyDAg/d/SsnmmBk9J0
	5ZWCqHw==
X-Google-Smtp-Source: AGHT+IF31hzPwkEC5vVCxNW24TD9L2KHR+3J8xra5yrgU1zl1wKzm1bJDJBIIYhenGxokGEpP+EHLZKZbmw=
X-Received: from pjbdy5.prod.google.com ([2002:a17:90b:6c5:b0:33d:ee1f:6fb7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3505:b0:340:d511:e167
 with SMTP id 98e67ed59e1d1-341a6ae3b0dmr98418a91.0.1762278428324; Tue, 04 Nov
 2025 09:47:08 -0800 (PST)
Date: Tue,  4 Nov 2025 09:45:08 -0800
In-Reply-To: <20251007223625.369939-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007223625.369939-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227779334.3933282.8557520441138135229.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Rename "guest_paddr" variables to "gpa"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Oct 2025 15:36:25 -0700, Sean Christopherson wrote:
> Rename "guest_paddr" variables in vm_userspace_mem_region_add() and
> vm_mem_add() to KVM's de facto standard "gpa", both for consistency and
> to shorten line lengths.
> 
> Opportunistically fix the indentation of the
> vm_userspace_mem_region_add() declaration.
> 
> [...]

Applied to kvm-x86 gmem.  I put this in "gmem" instead of "selftests" as there
is a non-zero chance additional changes to vm_mem_add() related to guest_memfd
will land in "gmem".

[1/1] KVM: selftests: Rename "guest_paddr" variables to "gpa"
      https://github.com/kvm-x86/linux/commit/83e0e12219a4

--
https://github.com/kvm-x86/linux/tree/next

