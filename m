Return-Path: <linux-kernel+bounces-726619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFEB00F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07EC37B04DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8E82D375D;
	Thu, 10 Jul 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oulmYX2r"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD72BE7A6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188994; cv=none; b=pk+/wKtE+xrIyJxTNpKzkFyuH30dh0D1uXNReYIYD3wcaV6EcjqhU6arDIxFTC+tvgTn7fuxNzu4DY0knV7vqO1mhfGw6yrV3YNtqALAm0EFUQg34Aj6WF9Aoss2Wtysg7EIVX+S/1teu+cno7vty7a8eJvxyqTCY+8DP3oytRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188994; c=relaxed/simple;
	bh=rDR6TFy0U1+b5Ym9QhsrmAuvjwRfWzlAYTN870XnoWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bZFPDUu1I6SQFPxw0gH4wNr6OSTejAJaalK1SwadBG73ShyQxo2YKgRtk+Sn9ZAJh+N9i1dsOiCEF7IjapATlTLT0Gj9T7isjoaXujkkGIRcEsLQtxTexOp6KyLaiuflDivAdg82C8PI84BkDq1Pcx1wc0EQ6g3gu3DN5G73WqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oulmYX2r; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31215090074so2463457a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752188993; x=1752793793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=67GwB+aWyumwRZOh2fINIZ/EYoiexZgJdVtrS9LdzOY=;
        b=oulmYX2rCjWPySXBUpjljAnUIWM+0rE7jd7wXo8dAa4BITFOTLkBTsSU+DrIoawIEC
         fYxWrS1t7UEu/XaB8oLDCofLm1Nte3XZNarBhP4CEmlQM7bJgwpwzG4teE+ZGdK9b1QZ
         IroMbvL5FDmTLMji/QKb+qWy5xUKqsWudiF3hkoChNyFy4nXRC7VMsp38/Hu2iaeAshK
         /Jp7gBSY8j9NmJf0W2iw5iQtaPFeqP3JM3KrHEwk3MJAtkSjLw3e1SJBzCT8qAyUf0r9
         I6n2qe4cxvXhuLsIy+Wp9Z97imwzMSV5C5KQ3/K9Wk2ZuVjJXiZKA1WQAsNzr7uQtBVB
         iVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188993; x=1752793793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67GwB+aWyumwRZOh2fINIZ/EYoiexZgJdVtrS9LdzOY=;
        b=PJQYIv+eUIvSxsZFtnVFkmffUK0Ib7HoBywT8G5W736i95W6uzwEIBWT9fD4iHMvp9
         hC93evuscXWa6y2HTt1m/0G113UA7+rrfrgtjVEe93pjUoCaP8A4BIJnUVjMLvbt+105
         k/uVmYGICZuUfuWGDm4i3tQb7/RDxqnkIGayhTk1qpO9m/oDqOZ4fdeCdgc14KDwgmII
         Ygpg6Dg74HDY1mgSBjj7v2/AXdsJWy3CwfW1V8w39zmkxrCb7wKDSyVIrxflCY0WojXQ
         qQbFYJ8hEsD4hAdYWCt31kOWFWeLwcsbR6LRES3AKKifvO1jJiLQfLAegIjtvE2QKTgE
         CxUg==
X-Gm-Message-State: AOJu0Ywbi/duo/b2TcQh4WnG9xaglD/QTehMMQGs79rNcevtotHfC7By
	DrxUZZmmc47OTY3w6TJXCA4XSiy5ltOnRelHzSxNFJF8lL2TUmyihQv8IdQzND7ymzrOE4dRnoW
	eahhOkg==
X-Google-Smtp-Source: AGHT+IEo94Y3+LJsQbHDiFEaMdeiLRqMSRnEEoCZTsH9vs3Gi2iRWPU6d3/xOwSjelhz6h4GAhCCPZ+Zu1E=
X-Received: from pjqq16.prod.google.com ([2002:a17:90b:5850:b0:2ff:6132:8710])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5710:b0:311:a314:c2ca
 with SMTP id 98e67ed59e1d1-31c4f4b557bmr528192a91.6.1752188992830; Thu, 10
 Jul 2025 16:09:52 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:08:54 -0700
In-Reply-To: <20250522233733.3176144-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522233733.3176144-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175218114710.1488061.16698832498491480621.b4-ty@google.com>
Subject: Re: [PATCH v3 0/8] x86, KVM: Optimize SEV cache flushing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Zheyun Shen <szy0127@sjtu.edu.cn>, 
	Mingwei Zhang <mizhang@google.com>, Francesco Lavra <francescolavra.fl@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 May 2025 16:37:24 -0700, Sean Christopherson wrote:
> This is the combination of Kevin's WBNOINVD series[1] with Zheyun's targeted
> flushing series[2].  The combined goal is to use WBNOINVD instead of WBINVD
> when doing cached maintenance to prevent data corruption due to C-bit aliasing,
> and to reduce the number of cache invalidations by only performing flushes on
> CPUs that have entered the relevant VM since the last cache flush.
> 
> All of the non-KVM patches are frontloaded and based on v6.15-rc7, so that
> they can go through the tip tree (in a stable branch, please :-) ).
> 
> [...]

Applied 5-8 to kvm-x86 sev (which is built on tip/x86_core_for_kvm).

[5/8] KVM: x86: Use wbinvd_on_cpu() instead of an open-coded equivalent
      https://github.com/kvm-x86/linux/commit/55aed8c2dbc4
[6/8] KVM: SVM: Remove wbinvd in sev_vm_destroy()
      https://github.com/kvm-x86/linux/commit/7e00013bd339
[7/8] KVM: SEV: Prefer WBNOINVD over WBINVD for cache maintenance efficiency
      https://github.com/kvm-x86/linux/commit/a77896eea33d
[8/8] KVM: SVM: Flush cache only on CPUs running SEV guest
      https://github.com/kvm-x86/linux/commit/d6581b6f2e26

--
https://github.com/kvm-x86/linux/tree/next

