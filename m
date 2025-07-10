Return-Path: <linux-kernel+bounces-726616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97718B00F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2836C1898959
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E542C3254;
	Thu, 10 Jul 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ns11KrTg"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7B2BE05F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188981; cv=none; b=u5ctQcQ7CWWh+UKpiWpeXh8M0ntxESIADMeEAHkg+GKO0eL1OinqCGGUhHQmMkM0wBSzuMOGPk7Ttgp4uSQUl99C3fxKhPMgsU5h9UgsCBMSGtlebtl0UGw/6d1gZ9p9TjVH6yRJ/YAJa2QGKKZcDLJqVC2ETkdC2gDD4uxvS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188981; c=relaxed/simple;
	bh=Imhpk93MYLp8xwLOAgb07FPvQgj67wyrPnSesGvWOhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MFIsJ4Wan9DID1KolyZB3d/te84X0TLXjie1X6qythbiB/je1HaJfQjvG5SFR8qhfJrw4HuQ9aHTDW1Xjm7lwITyx7Nrt+bLhdJ9FIljkIhfdWBnLdXKi0Igz8tEuweJwn27xgLGaD1SdZiTCBlvQzi09Lurc89cBFe3ll9Al2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ns11KrTg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b34fa832869so2039890a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752188979; x=1752793779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4gFx6otObzph4vmcdpjljmy/wmOvcgw6O6DXvqQUk=;
        b=ns11KrTgbS08jYLZt5K+8VZ+5NRz62DB0uE77+Z4u36YOWMwLP9Dg6jIlWvZuYrl71
         bLyiNoCNVpYvSztVSBBea/HP9MPz/QkxZuDw4PQWcgyjJ5F3y/PLNmpNMoCrnQRUnkUN
         WK+SshohnLlOCDMwCv2+bvlUrUoKlZ1o/jdRAfOMb9YbmtB5k/AjFzpPVGoxTiOfBvbw
         LC5Ej0N8ITzSaDCRgA06s90pAoX3jf27o5Fglbv+DqI2WTc7i4tuxDq+JiV7xQ5CVoII
         cKmt4LR9fG9rnsSsNAq9gQ5P0ZjGe4nh3of7d09cML7K3UkGI3tec6sAj4TDoBE0NkC7
         ynZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188979; x=1752793779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4gFx6otObzph4vmcdpjljmy/wmOvcgw6O6DXvqQUk=;
        b=wBK1Ts++0CUfkCd/r9pP7Wz6FaqQV6/Ukaaf9XfNa3cztHC2KisERB6iWUfCQgR/0a
         D8UCMssdBojwKF2CGVfmhhM2CR0wIilLGWFgGwCPTcPu9NITLZBsWZ/T02dL94AjaKnB
         yfr9LjvDEEYUc9wA/50owUSYAx//DO1UPH6UzkLrCmWwqTd4SasFKeo724OfB0Sf/EkE
         IGOPu8hO4QVyrYo9bvDlEZVht/qyUV1t2e6Em8463wSBPgqDL0oZqJocoVjeRkh8LF5U
         pqjRWbIzvk2QXZBnIidv0RoL6TkGrHH6n2vEYQGF1emPcpOZj6TR8r+G5GJvienCH1Ld
         d0ow==
X-Forwarded-Encrypted: i=1; AJvYcCVUJ7Pe8yJ7ox9mSi9o1EVsVIubOccr6QMnoy/XQAnzpfhWEIbX0bqLknmwUdYTzX1EZAo64EpKhgcRMT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIagwZZsqb7AFqhBfQCMlNGnG/dshBsBQeYAmQdfCWE7WPVOH2
	fMvS50KsAcydccP51sg9CgN9L07oLlSmgsUbcj/YMW+K80TbYsEZ+3DXinB6TYYxPSvePIdLanB
	TMFZX8g==
X-Google-Smtp-Source: AGHT+IE+dyK2d0uR86qfpkwgq8AVI1vUVbhbMbwUukxTkGUUqxum4AWqrZhpfpFloZnZbssgldsJ/GbSzP4=
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:31c:2fe4:33b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:568f:b0:313:d7ec:b7b7
 with SMTP id 98e67ed59e1d1-31c3d0c25b6mr8663625a91.13.1752188979183; Thu, 10
 Jul 2025 16:09:39 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:08:50 -0700
In-Reply-To: <20250626001225.744268-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626001225.744268-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175218136720.1489574.7636607289998193683.b4-ty@google.com>
Subject: Re: [PATCH v5 0/5] KVM: x86: Provide a cap to disable APERF/MPERF
 read intercepts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 25 Jun 2025 17:12:20 -0700, Sean Christopherson wrote:
> arm64 folks, y'all got pulled in because of selftests changes.  I deliberately
> put that patch at the end of the series so that it can be discarded/ignored
> without interfering with the x86 stuff.
> 
> 
> Jim's series to allow a guest to read IA32_APERF and IA32_MPERF, so that it
> can determine the effective frequency multiplier for the physical LPU.
> 
> [...]

Applied to kvm-x86 misc, with the thean typo fixed.  Thanks!

[1/5] KVM: x86: Replace growing set of *_in_guest bools with a u64
      https://github.com/kvm-x86/linux/commit/6fbef8615d35
[2/5] KVM: x86: Provide a capability to disable APERF/MPERF read intercepts
      https://github.com/kvm-x86/linux/commit/a7cec20845a6
[3/5] KVM: selftests: Expand set of APIs for pinning tasks to a single CPU
      https://github.com/kvm-x86/linux/commit/e83ee6f76c33
[4/5] KVM: selftests: Test behavior of KVM_X86_DISABLE_EXITS_APERFMPERF
      https://github.com/kvm-x86/linux/commit/df98ce784aeb
[5/5] KVM: selftests: Convert arch_timer tests to common helpers to pin task
      https://github.com/kvm-x86/linux/commit/95826e1ed359

--
https://github.com/kvm-x86/linux/tree/next

