Return-Path: <linux-kernel+bounces-877268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C407FC1D9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265DC421941
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D12BE629;
	Wed, 29 Oct 2025 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yVP8piSY"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348518C008
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778079; cv=none; b=MLInASbUdgVmbUFs0d7nENieK+Mdu6qsJFnONz1fk4Cy2r7nOovQcU3KJy29QalOXeNZ3JUFRTDjw1kOwDDTFQUqkAsZIwFHZ1USHQuh9cwNhvKRHXImwBG9l5dbKd3tcO08fJe5Q/TTR2BgVy4B9INaKlS+YZApGJPq/mfNEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778079; c=relaxed/simple;
	bh=cgGZWtGKa5npg/MTX2D6gmhc8SWIDwF/Qcdu1jVtR6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y3jFLlVfpzbxFtTNu3u++mJN1b8rfdddoPP+sp2cbs2YQnL+gk4EBOdut59AOUC9G2DJ+e3adKUYr9pB7utLHtVeiDuvWSA5G0WucDhakD1HMVO99ruvQriJHH/2n/trqxrg7inU+C765c+RfAudxKhywMTqmjx1lEZi0Wwwp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yVP8piSY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33d75897745so927429a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761778076; x=1762382876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TD8UsDIiiN72tVtcxsjIL/Io+7/pHH4cH58koU9gOo=;
        b=yVP8piSYCBh82Pm8W04P7Ar+nCCVdFvyG28Q4CLgdvrGERK3WRB4aAOx/LcorcjQqH
         tx01pBOTTh9/k/G7EDsbaUHUP5YJ+IgpLW/2PnK7iBWAp0Vv1SBXC6Tk80dWqLWHMIZw
         SWRODfUmPbH4NMxPwzeAPtARm5EOxU636g/cPhzTJjonFIW13IJjCjnaKqZShY305acX
         DXiBtRtaBtFCAO4+dZlBuGAdE5dyRk+ajAdShtz3elHYmXk0fatYPNzIdDyOYyfFlMFV
         tEeQ2H0F/q9xvHItKet5FMwf7/hrnrIfpjooSlThcud3NPNEX3fWCPkEX8u29419EU5C
         S/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778076; x=1762382876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TD8UsDIiiN72tVtcxsjIL/Io+7/pHH4cH58koU9gOo=;
        b=wYBW/2hneOQh4R1+sVSVvqmirYFt03/4g01pbMieIMRXu90fQ073NG5adfNi1PrsNY
         NDP3+a/POsWc9IboU+F5j9UZLb2A5JckJHY9D89WPef543YfWyFtaqpJyGWa7AIAjvsU
         DO5e3ZxM4mIb9tBhTl6HakHzzIZiI+WmIBcyYIgLy3eoekj2LoHtkBqJ/6F95Hwgoi44
         jbuwneOA0eOS3cq3B6cXmKBeaIbYZ23qQqAD1RnC1pyI3p5LFiFvIMfyqutGizwDu1gC
         TIuz0R99asN81MteMCxOCh+ZX6OJ0DlsV24rTBy6nKgu0WqZoQ3r2itM03nGf3sginn8
         lXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkEmdj1T2o1lbLUZppr3qILqxocETRKlGorBsP7J7lOlikzw6AucZomqwdSpJ2IVDAnmieidx4BxG+OFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULr7cBB26XysOEDdaYGKPjQcjOzD6qVO44Ah0gYfAdjO+3jxd
	h2DDN9CCZpqr72ItDIwZYwQsP0AIn/ynhMurSfWSzlQ1fEykKsPo3TP8LNC0CE8eMQAQaLRDPxl
	OQM76+g==
X-Google-Smtp-Source: AGHT+IFFs/N3Ci15uaXdGWwFKpvhZRCcmQ9q4DWDTfGfBtTXW3KbncWH6bCM5Q4XtD5gsksdTEKAorSW58E=
X-Received: from pjte10.prod.google.com ([2002:a17:90a:c20a:b0:32b:35fb:187f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0e:b0:33b:cb70:31d5
 with SMTP id 98e67ed59e1d1-3403a2659ebmr5567686a91.15.1761778075915; Wed, 29
 Oct 2025 15:47:55 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:47:54 -0700
In-Reply-To: <20251027-vmscape-bhb-v3-2-5793c2534e93@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251027-vmscape-bhb-v3-0-5793c2534e93@linux.intel.com> <20251027-vmscape-bhb-v3-2-5793c2534e93@linux.intel.com>
Message-ID: <aQKZmoabW0M9STCa@google.com>
Subject: Re: [PATCH v3 2/3] x86/vmscape: Replace IBPB with branch history
 clear on exit to userspace
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	David Kaplan <david.kaplan@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 27, 2025, Pawan Gupta wrote:
> IBPB mitigation for VMSCAPE is an overkill for CPUs that are only affected
> by the BHI variant of VMSCAPE. On such CPUs, eIBRS already provides
> indirect branch isolation between guest and host userspace. But, a guest
> could still poison the branch history.
> 
> To mitigate that, use the recently added clear_bhb_long_loop() to isolate
> the branch history between guest and userspace. Add cmdline option
> 'vmscape=on' that automatically selects the appropriate mitigation based
> on the CPU.
> 
> Acked-by: David Kaplan <david.kaplan@amd.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  Documentation/admin-guide/hw-vuln/vmscape.rst   |  8 ++++
>  Documentation/admin-guide/kernel-parameters.txt |  4 +-
>  arch/x86/include/asm/cpufeatures.h              |  1 +
>  arch/x86/include/asm/entry-common.h             | 12 +++---
>  arch/x86/include/asm/nospec-branch.h            |  2 +-
>  arch/x86/kernel/cpu/bugs.c                      | 53 ++++++++++++++++++-------
>  arch/x86/kvm/x86.c                              |  5 ++-
>  7 files changed, 61 insertions(+), 24 deletions(-)

For the KVM changes,

Acked-by: Sean Christopherson <seanjc@google.com>

