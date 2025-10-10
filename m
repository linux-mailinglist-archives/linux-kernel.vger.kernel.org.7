Return-Path: <linux-kernel+bounces-848809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EBBCE9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82FB4F386D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BEF302CA3;
	Fri, 10 Oct 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hA2jaENo"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C606944F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131842; cv=none; b=iuNJ21sAgR5q4A7gX+ldnnaZvTrVahYSZaGXD7H3uF01aj998PUh8LAvRdfaBGL6pep0jNfVN8pwgdP5DbuF+4jf09qDNEV/DCf3wBptyRyKdFNprBO2TZms87f6I38buNlEZPcIjbofUUOJlVemzPHZovpXTI+eGK631Gb1QiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131842; c=relaxed/simple;
	bh=8/p7tRrQjkWsIDoGrp+Q/dZhfHbhdeZtiwno3OQBCi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ahrkzm1GefktkK3l+0d8l6gVF7kn3Ci3zjvmKPyo9MvSN4i0+4mNoZHmD47Wq+QYMU/UzOfYLN2n9MvoxUVde7iyjbfVK4B7ohvFV68OWJ9DfXVvBG76Z3vKQxsUD0o1pW3IlsmOKYS/rjo/GLf3ZcIDFRRrhNZtCR/xw/Pk3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hA2jaENo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso12084358a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760131840; x=1760736640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGidvreBdRrQ9/e+QABa4XqhsTH5hvZRquUKr+ibx5g=;
        b=hA2jaENokK0aNDL9+jMmbO7XlkY2L6ddh18eK7j6YlyMnaclZ+iAhuXqOmFzKfpcfO
         4otQ3Y4KhhzOejtqIgf26687JrPLoBjJWuraP/1eacEYYTek9bjC9Ww4f2F0G4V3ZgYN
         ejpW0DH5yOty0M29VhSxSIx61mH4Jvty56g4HfAPz8RiqYPRR8egB9AHWr59r5GLlOc0
         qWmYCNM/iJ34OEbqakv437BBHFPUIS/cGtY2c0CHPhupZi4pswVTvzIxZFHQr/GY/mP4
         LkpZP4iBnC+1DjlMItKPcsuoogU+mHwCEGiIzBLxwqVtJY/G3NdlbCrjxH7wSSEOllPG
         zTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760131840; x=1760736640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGidvreBdRrQ9/e+QABa4XqhsTH5hvZRquUKr+ibx5g=;
        b=SVJOgIM+kjxhnmo+AJ1eU5veSBgcb1p5KvPyDgD8phbUdKWO17UCdVvcE2nXqGK6IK
         tjHvV/kH+uDPxzwy4M+K511Foj/IMeYY83lUwDvPzmlSFw6Xyhx+U7XPQI/8G2QkPv/h
         A5kXmJe7pvcJp4LI8Gd0T1/ksTtrCIs22dN9nU20tdWHjLVa59jy2fs5ha1didduS+vM
         kPfZYO5tgKzM4Zvt57IthrCeBPPL7S1MffxdcyOufoobsz5VrJjrOVxYDtqGDP9pp5y+
         3waZxyEUhBezmnSVchjjcwK1vgfs920ZcVwfdVlrhSGsnyF2iWcQKu4+czBquBPcAEzP
         iJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXGGDrcGmtaEHzZgDOici++lwjGcsAg5er/58dSZjZwpZCJZSP0bg/vwQ0/5ok2BKOaWq9QBv9pLKgDlDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZd8oXscpJCzDUxAzzf/zBaZqky3RfaNeIwx/LUnxh8Z5z1wcr
	7x7vruK6cOyfBuf7bs/Idl7/bxbfg6r8DNzu6IskM/wdvcki4wAuCQsy8SUCXD8sD1+HXlfdkgb
	5jcy78w==
X-Google-Smtp-Source: AGHT+IEcoM39c7Mj6p6VihhWMNZc1Lv9bgkpm92KunbjLNVZrSA/4FpGt5gG4aPbYdD2+ok2Z9TplqyvzX0=
X-Received: from pjso12.prod.google.com ([2002:a17:90a:c08c:b0:327:dc48:1406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e05:b0:32e:64ca:e84a
 with SMTP id 98e67ed59e1d1-33b51162572mr20174140a91.12.1760131840262; Fri, 10
 Oct 2025 14:30:40 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:30:32 -0700
In-Reply-To: <20251010005239.146953-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010005239.146953-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <176013142377.973380.7356596643115609309.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix the warning in perf_get_x86_pmu_capability()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Zide Chen <zide.chen@intel.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 10 Oct 2025 08:52:39 +0800, Dapeng Mi wrote:
> When load KVM module in Intel hybrid platforms, the warning below is
> observed.
>
> [...]

Applied to kvm-x86 fixes, with a different shortlog and changelog.  I wanted to
call out that the fix is for hybrid CPUs, and that snapshotting PMU capabilities
for non-hybrid CPUs even if enable_pmu=false is intentional.

Thanks much!

[1/1] KVM: x86/pmu: Don't try to get perf capabilities for hybrid CPUs
      https://github.com/kvm-x86/linux/commit/034417c1439a

--
https://github.com/kvm-x86/linux/tree/next

