Return-Path: <linux-kernel+bounces-893529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726B5C47A13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6B2188CD10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1726CE05;
	Mon, 10 Nov 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIDdzSz6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69A2236E5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789291; cv=none; b=l1o2dfRd6DmZn52RcFOzGEmca9/NXsuXZyoS7CPtUpcCyGX3gTShVUpYLFEq13TyA7UViAdRazG+xQg/SlnXxjqXG7I8rXcLZDekZPOqcPblGEq06m31v+80Q/ftyGgBoYnayOkvW79gR1gdIua89sRCoSuoPADnC7/I7bNce1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789291; c=relaxed/simple;
	bh=h6fvhlb5qL2yiZWyNImFBexKvyI93L8SUFeljjK9Ops=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GuHyn5krkHwNnkhN/mI/B7gJV+U3Dnv0cqAps6yNuUVu/sQKgOkFkUm96o0HfZZzkEZ+irO8fEKQejvm4SlsicBbjdJOAWyPPWsig/oXWNhJZvV26d0RqgwLnAtGOmQ4qRwCYZHy7uAsg+FGrROV0wC1F+HG+y5DN2Fpm2S/bNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIDdzSz6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso3667243a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789289; x=1763394089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgkoVDJKLe1jOBuatcMyGEsvjHvtN3ZYXFqt51mzfaM=;
        b=CIDdzSz6HDhyymqHU22RuKeyizPXsl682WndZcIt4wXBAMBbuc2Ko9wEAKYuDg4e4V
         aVoQtaTJZCWxo9go3rNZr7+qXt6qfbaatVV0Tni8v5jG84YFQd7CiWUaiZP5g378dRdq
         r0r62fR912wEMpeo6LgZdITIPMT9LwxWYgeaEXaL42Z9gkliDlRRJlht94WwWerQZh3h
         V0/KuGvobac1aNg3bQofDE4xZ3rQKksJnhJ7nklOr/kGxqBO8EeM3bzb4OJLo4a6hbnp
         1BsCaq0JCER6AF4Q8v2cUG+ZkzMKRyyymXdeUc031itU9KikUfawlBqjmto0BO/cYsF4
         aSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789289; x=1763394089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgkoVDJKLe1jOBuatcMyGEsvjHvtN3ZYXFqt51mzfaM=;
        b=Ktic/FuQI4nYtCUyr4JyZQqK0Gwz/qXJrWKMBNlDOtrTT+qvkgKnHtG3Bx+r5T1Xp+
         j+DCBtMy3tei32Z++khntbJBKzxY8ewHE7nVJBcQUMoaj8e7eAu/z8TTOMwCpqdKVv/O
         5K0wlp9d2Stru3M/nfOyf36q5mZ6K2uTzE8x0WK1IFuK3s8D5b6UkJRXLX4phH4o72ow
         BUDKOnfZw15GuxGgH+F/loVYHWeMKcSyS4r3cFZRxPEv1O1a9ibssZDh4BZy4rkROQ7h
         KEhU7YdZRVLll9XVZ+p7pB23Ufas+VgriQiV/w7eFRfK2ntipZ/YXxgPOwSAxZ+GPlwc
         J/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGBZ6CNkWduRlJUIinZtiCkx5ldbJpOkkhD+ER/RZ+CByVO2Xm59JdZq6BBgsDIL21+n4pyCBW4OBxGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQ4CN+rtILjgYbn5Lf6vJY2zwJCn2ADrMi71o2C/fFkLn15hD
	V8udwFHcfAeZBWpWe0lWeXJfqwiPWJQPGq53QdvVXFxVjgOcON7q1cNnYPlEdiu9zbVd3b1CV6/
	6PA2xhA==
X-Google-Smtp-Source: AGHT+IGdNkJMtTEnYMfSsIqBsSSQ/jBHwYkaAkoEe8549P2buRjTsfhQe8p1ftk/vjq/9yTIZHYVO8kgbHE=
X-Received: from pjbkk1.prod.google.com ([2002:a17:90b:4a01:b0:343:65be:4db2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8d:b0:340:f05a:3ed1
 with SMTP id 98e67ed59e1d1-3436cced91fmr10306410a91.21.1762789289588; Mon, 10
 Nov 2025 07:41:29 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:27 -0800
In-Reply-To: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176278819404.918294.6609629362258186097.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: nSVM: Fixes for SVM_EXIT_CR0_SEL_WRITE injection
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 24 Oct 2025 19:29:15 +0000, Yosry Ahmed wrote:
> A couple of fixes for injecting SVM_EXIT_CR0_SEL_WRITE to L1 when
> emulating MOV-to-CR0 or LMSW. LMSW is handled by the emulator even in
> some cases where decode assists are enabled, so it's a more important
> fix. An example would be if L0 intercepts SVM_EXIT_WRITE_CR0 while L1
> intercepts SVM_EXIT_CR0_SEL_WRITE.
> 
> Patch is an unrelated cleanup that can be dropped/merged separately.
> 
> [...]

Applied to kvm-x86 svm, with the proper stable@ email and the tweaks to
svm_check_intercept().  Thanks!

[1/3] KVM: nSVM: Remove redundant cases in nested_svm_intercept()
      https://github.com/kvm-x86/linux/commit/3d31bdf9cc79
[2/3] KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW emulation
      https://github.com/kvm-x86/linux/commit/5674a76db021
[3/3] KVM: nSVM: Avoid incorrect injection of SVM_EXIT_CR0_SEL_WRITE
      https://github.com/kvm-x86/linux/commit/3d80f4c93d3d

--
https://github.com/kvm-x86/linux/tree/next

