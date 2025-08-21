Return-Path: <linux-kernel+bounces-780296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9ACB30004
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4A17D082
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5892DE6E2;
	Thu, 21 Aug 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEKp1cdH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D01A255C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793599; cv=none; b=WORdcfVETjTQm4uq+FRV3ZtfCWVtt1I7brMQY5g+iOwF2vALxd5l+nqOsisjXPpa+5oqQ2mcLZHoChjdTRnuFtcwZdfXAxoVQMDVbV3kkymqU53mYIDG66PFH5UKnD8pPVKDivEpGmde1yY4rUpstLtKX/EaL4qx1AHRGHEn9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793599; c=relaxed/simple;
	bh=BGQfjv+3ECSbNnEBjSjHcyVlkv1M+/afrif7mCZ1NAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUbHHozmRbLTOU+i13g0KA0OAKDqFbebKoIoc2yLF0Wly4qP+CRIQmBBso91xmXfehQHsGIIgaiJksaxeLHISEuukygqrcIB6M8YwuBRHVH5c++0xd/bkP/OwV8uCRZw4CT3geZ4UDFbKopROoAaTdDBQ8rPqAgsGn0Z23CWTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wEKp1cdH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324f2f16924so871067a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755793598; x=1756398398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9RvlD8X4SEG9tahkKerzt/w1Sov/ZfSlXlYzBetr28=;
        b=wEKp1cdHNkQRwaMic2/rMYkNueHTUdj1mt/RcLkud/E4m02Pz1/mdPuqugE/03tkJr
         1AF6kDx4UhCbbd8YpgJ3g0Bft2c3V9Ih6UicqvU5ZFrpWROv5zf4ibOo4tG1D3QW3Kq7
         H+q2RrEHXKZabSA+UF5S60OAFTTfo6KUETuinogdAysHlHw/P3XUiRKSDSJKnl2JPARs
         YwFEMEsSaBJKoJXO6PKKvYYKa734ya2ELIMfYD++Xbcf5w2N28R5/tuwEgHqYVyVEPoy
         4uvJ+jqyVOCsOZwc6bUQZUwqZPsRh7wdcyidqn06clu8zShw+71MCgWC2+n1PSXnXw+4
         NOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793598; x=1756398398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9RvlD8X4SEG9tahkKerzt/w1Sov/ZfSlXlYzBetr28=;
        b=aFI8z6tD/sDNq7rzhJEqblxKxYKbFMw7APuXM+Z5nQGqcnmADx8lkTIGGu0P3xrEBy
         +R7fDy1LzpGV6/b/SWUObF1QC1yALVIN4BbFEITmdVlOlG3nYbOkBGIx3nQOTLumqyYT
         MabpB2cnz0QhIg19+W/ZIqHmSV7e1VYZIqCoX9tYT0ReZXhgv4w+YRgM7yVyXqYCTH+C
         Y+QqdmPWPz81RYwJL//iz8Oymef2y5XIXGYfYZWR0j/QVbiKsWaUufsdKhTEZlpybwTx
         C7raw8NXih6MM/f2gevPM86aEyRmhAWYeJiBYRTk79R/YTRQLwdcEHFCocLy0mSqk6Oj
         qhoA==
X-Forwarded-Encrypted: i=1; AJvYcCWi1D34npD3FCBPWkuWSBofZ28GbBqZTrYcyMC3/oRyvkut7V00B7WXxrqu6hM84AKT5KGEw/9TTqc7uT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYIHVOty0zY5EQN2sn83DixVcKdAYyGmeMEK1Rlax6E0JpCEB
	G9NsUk2Mjm2tcaL4Kvuw89wXyIJi4ULH4t4mYM4K09FcsxNawrhVMHrDz3sc+8TOnn8SPELRbZE
	7qf5EAg==
X-Google-Smtp-Source: AGHT+IFBzpbYhwtJlmCT1TvGVIG96QJUu8LcbjOprwCjwMSjfpsP8VmuBfeFO4PBSHGBmzi0dYxbX/ODjm4=
X-Received: from pjbqa5.prod.google.com ([2002:a17:90b:4fc5:b0:321:c2d6:d1c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:258c:b0:325:11d1:1fb
 with SMTP id 98e67ed59e1d1-32515ee12ffmr160940a91.6.1755793597571; Thu, 21
 Aug 2025 09:26:37 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:26:36 -0700
In-Reply-To: <20250816101308.2594298-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250816101308.2594298-1-dwmw2@infradead.org>
Message-ID: <aKdIvHOKCQ14JlbM@google.com>
Subject: Re: [PATCH v2 0/3] Support "generic" CPUID timing leaf as KVM guest
 and host
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Colin Percival <cperciva@tarsnap.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 16, 2025, David Woodhouse wrote:
> In https://lkml.org/lkml/2008/10/1/246 VMware proposed a generic standard
> for harmonising CPUID between hypervisors. It was mostly shot down in
> flames, but the generic timing leaf at 0x4000_0010 didn't quite die.
> 
> Mostly the hypervisor leaves at 0x4000_0xxx are very hypervisor-specific,
> but XNU and FreeBSD as guests will look for 0x4000_0010 unconditionally,
> under any hypervisor. The EC2 Nitro hypervisor has also exposed TSC
> frequency information in this leaf, since 2020.
> 
> As things stand, KVM guests have to reverse-calculate the TSC frequency
> from the mul/shift information given to them in the KVM clock to convert
> ticks into nanoseconds, with a corresponding loss of precision.

I would rather have the VMM use the Intel-define CPUID.0x15 to enumerate the
TSC frequency.  I would also love, love, love reviews on that series.

https://lore.kernel.org/all/20250227021855.3257188-36-seanjc@google.com

