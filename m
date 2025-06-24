Return-Path: <linux-kernel+bounces-701039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00631AE6FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 21:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B523AE565
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342E2EAD1A;
	Tue, 24 Jun 2025 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J61/Gy9q"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FFC2E88AA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794071; cv=none; b=o01HksuIateClnKcdeAvN1mdkg0/aS7M+ECFxhE+Wfb3jbIU179sfKOSBPesYO2ZJLaddUaTZsR/z1fXT5Ru2U7DTVrcIyEcIWy1Ls5OsZwpzCU2QIx6TepODcKiXn7DMPKJCNgOnfy5ZTmRbvrJxo+bmrKlVukw2vnomtsdLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794071; c=relaxed/simple;
	bh=XKWkUMZVzA+dBYCVPpvxIgaKdkXs4N/J7Rl8dOvJVz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7CHct22XoLCV+wU+at/5m/dabX8YK4B53O/Go31V4r7sv6jJXB9C3aV7OGW1bss1rVJQGIegfEUPdFaH9nVR9xxIfUwKFLwloWIJxxPy+Fu37zt7eVUOjTRF1gzmfR41y4qEkg/RDOi+LmMIRc20aw6eJb5jWrRZGYK7wYjosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J61/Gy9q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748764d84feso7644552b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794069; x=1751398869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXiP320Rk+IeNYwcDV4nPbIgqWo0YYn3LIURX0sKo4U=;
        b=J61/Gy9qKuFITkCnkJfsUCdOtb0wez6ao33eCNrOz3QA9deST3Wz58EDgCZUTX8VOf
         U/b9+2KRemW9fd0nYGbmMNAMY1mpj0xZcATPfpLFVljeK8i2jssYF0JodpnE5oOuX265
         LG+QC/xu6KuCswec+Sy1+PFWYqh1npHeU9MSj36VqxciCkLg4IwxHTpnzavufuHPgzGj
         VgnoveuemnXc2U55F8TdV8LDcWT2U6cEen+wj6/RH0NPr18wD6oQMNLCfxB3d8HWiYiV
         OajE37G2c+qouOZOtnx3GW1Sl3AsOWT7R/u2mqfvb//CQ9qELWT6c4CvjGMf0IXMqAUL
         XYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794069; x=1751398869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXiP320Rk+IeNYwcDV4nPbIgqWo0YYn3LIURX0sKo4U=;
        b=itaKx7fEQqC2LRMfgbPio7SHQDSV948wzSL8+w/Bf5g7CyOn64MTaFUp/+BVGUdTve
         u0KWHpcEKPeI1qaf8YHTohx2OejQUiKA8wFYYoTNHikbB316Ytocpl0NqP0Anvf2yRb7
         UtNR+36PQ6SSgp3IO2wJJGI/ZXtRPm+3efr1Gb4tyoWQgj3PG3+t+vwLuyT8iBUrdqrA
         Cr4sXiS0QwEnkYg8FBNOoTcxklD7xDeZ8m/L1WMwE4Gvh52M93BSNKM9J0J/NTrofWXD
         l1Wrfi9rQxZdfBlkC5u+vCV8o8f37tc2FBvXSqLRsJddSucd1ipI8MwvpI1e3P6cTHFj
         zi9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPseTU5MFPAq63RhUlYs6GhowdCKaItryPwLThW2qNgAFw1cTkCdCXWnxQl1aQFbS8cyJybEzA7X8AvEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhkNSFGgZTzOaaNzv+PChlagcPo8jOP30i9MXWGz2srLjc1+t
	ojHpHQ+pEc9N6C6yGiGBIklx0d0tD7oLQrZvkna04QreK8jqEAa6Lz0r2+Sp0M4DCb7DPBB4K4i
	EeLu7WA==
X-Google-Smtp-Source: AGHT+IF4iAyO0/jtdeTd/8bHHz1AfSHJa1kRLTY1ZYhbBi7eks2S0+pU5J68NpHqGCPbGgybwZERsmzdGEo=
X-Received: from pfx28.prod.google.com ([2002:a05:6a00:a45c:b0:747:a9de:9998])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ac6:b0:740:aa33:c6f8
 with SMTP id d2e1a72fcca58-74ad448fdfcmr481317b3a.7.1750794068977; Tue, 24
 Jun 2025 12:41:08 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:24 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079266935.516926.16732685121513755333.b4-ty@google.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 16 May 2025 16:07:26 -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a very simple concept (device signals
> eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> 
> [...]

Applied to kvm-x86 irqs, thanks!

[1/8] irqbypass: Drop pointless and misleading THIS_MODULE get/put
      https://github.com/kvm-x86/linux/commit/fa079a0616ed
[2/8] irqbypass: Drop superfluous might_sleep() annotations
      https://github.com/kvm-x86/linux/commit/07fbc83c0152
[3/8] irqbypass: Take ownership of producer/consumer token tracking
      https://github.com/kvm-x86/linux/commit/2b521d86ee80
[4/8] irqbypass: Explicitly track producer and consumer bindings
      https://github.com/kvm-x86/linux/commit/add57f493e08
[5/8] irqbypass: Use paired consumer/producer to disconnect during unregister
      https://github.com/kvm-x86/linux/commit/5d7dbdce388b
[6/8] irqbypass: Use guard(mutex) in lieu of manual lock+unlock
      https://github.com/kvm-x86/linux/commit/46a4bfd0ae48
[7/8] irqbypass: Use xarray to track producers and consumers
      https://github.com/kvm-x86/linux/commit/8394b32faecd
[8/8] irqbypass: Require producers to pass in Linux IRQ number during registration
      https://github.com/kvm-x86/linux/commit/23b54381cee2

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

