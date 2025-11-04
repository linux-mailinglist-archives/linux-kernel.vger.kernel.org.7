Return-Path: <linux-kernel+bounces-885265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE48C326A0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D41642027E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8514033C50A;
	Tue,  4 Nov 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrlfU1N1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CD7DA66
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278356; cv=none; b=KXKdz5i97NJ8YbTS8IbcOwmtzlZh597xuMuLi8s7sJ4c3TDBysSrw9m7+n8yL/+urj1SpvRysqJBgsl2RbaHEBNtkmIa6DXH6aIgZEYwyRT/gsI2VzhYSiY9G22Wdld8O+EoXqTg8YnkDz87vH3Oc/A5BFIhDx5z58OzB2TG1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278356; c=relaxed/simple;
	bh=ZYOsZxL2IUEUQi9IL/F5rSWxWUDAvv3d/2yLXE/nACE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iAsz7C7kS2DJrfuCAXBgskdHI3XjBOW89ZFdSD6gxxbH3C2Gp+dtVkAYMvHGvs5HjfjvgbG3p6+UyrrMgghFBlAW7wdapPTXbRTdWZBBNKzhHw4YquZs1W6X9lNk8B4Yjjbu5c/u8l5YkGz2xkf/A1MsV7C4/jA3zGja/KRfzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BrlfU1N1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340c07119bfso7803954a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278354; x=1762883154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/xAx4kN3ROUTUV2Jl/Po33RbfuZxhuxITOjGQyl8+0=;
        b=BrlfU1N11m05sEBwRFxPHPgLNhMb9QpAZL7eTMKOIDu3lmmCR0tXdvGxXgoHDagP1m
         20xXn3Lw2+nnykG3DiOgGYfiIX1D200adPMpU1WhfQpHPtJ8v3mWGjZVvnNaZQA+5Nvm
         6/jz2eUl5I8QVBKhNpkwZpk6fCSR8aQRx/SV4awg9X/CBn2U4MV9uN1Iv1f97//V/e1v
         x4rlv2nLSe4Sj03MDILJ2iPkg/0t7MK2dgtDBDU0qsNoGnxquarJuIOVtYyF2QSKjjMo
         oeBDz6jCA/5iQxDWPEcOElXsX70wIzfUh9rj3VLIHCGNeE8mbr74abHwDD4WLmKFDZsk
         URxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278354; x=1762883154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/xAx4kN3ROUTUV2Jl/Po33RbfuZxhuxITOjGQyl8+0=;
        b=IUUejTQ7woGyYacZJBeTejthHtoFbwlSvJ2coRuFM0DWEaTD47qg33y5M9AD8fFSf1
         2xUpmkTvJYRFex9EpNhm0aDKrYAWwVWnx6J32WCpM0vSCCCvkhgv7/3Cwq2vYMveS+D7
         KEFDp9pvoh+Rt2Yx7PTLlWNO7ojhAnjcQT02uWqiyRXmyPOEZ9cAetQnP7YC8BqbM74C
         XiS3UCfOgjT2zI8jTIg/BRbNg5M3tuBkUQ81tVKYhbeVYND/sWroKMrhz6X40oQYRLFq
         5usYYaUvPz6Yuv0COZdr8E8dkBvrj14xN1GLlEjg9c1BSVNHrFGuk3kbg/kiP95imtuh
         vigw==
X-Forwarded-Encrypted: i=1; AJvYcCUQA3ljraYbl9K5+AKK1zNa69ZMLn3joxaw78sdUVnIFeofpoUsQisSGXqbuhkyap62rs6sLMIyVoYeeTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1FZ53NOygdDhkECrvvjHTCyrtE5Tc34p2LBX6T3X9DDicPsk
	b7kBXz7oO9Egnf7fqNfrzh0a5mW0gv6+yIFNhX+K/2jAwWsuls8w0yH+6mIeAXFi9OfRuyCInPv
	VUhlVSQ==
X-Google-Smtp-Source: AGHT+IHbbqY213K3DyOfRPQODSW2+ETr6+QF3a9xnk0Mm+lGMKcX25W1Wy4Bq37sp1Hh/GIn/ahciSdHvzY=
X-Received: from pjbnh5.prod.google.com ([2002:a17:90b:3645:b0:330:49f5:c0a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a81:b0:341:8b42:309e
 with SMTP id 98e67ed59e1d1-341a6e05f1emr17784a91.31.1762278353787; Tue, 04
 Nov 2025 09:45:53 -0800 (PST)
Date: Tue,  4 Nov 2025 09:44:58 -0800
In-Reply-To: <20251030194130.307900-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030194130.307900-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227788402.3933803.15173176547209151653.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: switch to raw spinlock for svm->ir_list_lock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Oct 2025 15:41:30 -0400, Maxim Levitsky wrote:
> svm->ir_list_lock can be taken during __avic_vcpu_put which can be called
> from schedule() via kvm_sched_out.
> 
> Therefore use a raw spinlock instead.
> 
> This fixes the following lockdep warning:
> 
> [...]

Applied to kvm-x86 fixes.  Thanks for doing this, it's been on my todo list for
several months :-)

[1/1] KVM: SVM: switch to raw spinlock for svm->ir_list_lock
      https://github.com/kvm-x86/linux/commit/fd92bd3b4445

--
https://github.com/kvm-x86/linux/tree/next

