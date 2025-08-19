Return-Path: <linux-kernel+bounces-776642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E7B2CFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA77C684ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948D271462;
	Tue, 19 Aug 2025 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9wr26FE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0E26D4E3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645466; cv=none; b=pzDp5EtG/e5E/3i4QZeDqGpqsiDxFJRW69X/4aQgJYS53pVTjlDzENB/KvaH80kgqUT6bAIG2cNeiwulUanO4A0MToF8ePmHoGqkvCPmKt+u4DMsjRB+5ZprNXeh9hLkwsRjbIs3O0IR+XVkSVxFzNWLzXtzVQqJVMwGvlfDF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645466; c=relaxed/simple;
	bh=6Lp8koz8icx6UErQeApTP21JAa8WS631GhdRQq3Vpjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDK2IYnop8rDiKlc9w1hlED6K39JDsyBbMU8/ZSqpTPQv+sBu8UQMK0kNsKv/1UB+bj8OlWF/9+nmgsZvndhEd0lOq+LxT6ozvdDw3A/8swLa5gd9le0PQDiCspFZQes/83APaGEz8zj3JCJwWEn+NLMtbhPiGLh9NuN34Yk6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9wr26FE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266a1e87so6100924a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645464; x=1756250264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7VfQHnAzOVrnTklpJsc/54P4E858rp35fesctvpDM8=;
        b=q9wr26FEfaB5Pmq3rzazKyuiLDgYtNly/xEsUZWipDlS2VZictyZF512CUf0TlX0o9
         q+KXOJsDyXhGQPB5k8dS1HCKCtXm/1NgPg1xDbN8Zgf1Xh01GnOKG+uez9zkujXi2Na9
         7BUdI8si/bTXLLa8aPaH/njMFVb2G3dMhcRogxfBU35q3hnypDHvNkef2lg/FcyS/gNc
         aIAkG/Kazbd8k0Pbc/YUNk75dkqYEfYyzfepaPIvnpXzShzbQTC6txNEkTO+n2viis+l
         r1YPHdsPx9Or1bTgU3DaC/QAYdHQa8xALTsKoEJC7NOk5h3D2AC9uSvx1NQS2Nc9N70x
         r7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645464; x=1756250264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7VfQHnAzOVrnTklpJsc/54P4E858rp35fesctvpDM8=;
        b=RU/DvNpEj7FMHhBfXr1qY3Qv4eIdETDX9+KRm/VZl3ZoOm3Amg/71iwUpvFJUYG7KV
         IU8AyIeSu3rSJJR7yUJ4pUvsed0P4J9rp+yZZ1C8TTiEM1Sar1M9i8lvZYvQj8Tzgryo
         QRL+cBmhpsi20Ljz4pthRFRjhYsnG01xHblzQ9EkPDoo6O08Oi0oJ8uWSkNmecWwTdnr
         1FVRJXXE/x4+sBP3E9IlNk/HOqiU8NR5qlksgt4ZIvN7BB7nnn4EPmAy8fDaOWEepDKZ
         7mxlKRstqlA0JUnHcXwywroQ8Kcfbz63HEzrkTokiOMqo2cGdHvbpnk6Rxphcy4llF3t
         o37w==
X-Forwarded-Encrypted: i=1; AJvYcCWjYRioYUWB8D9HPGBviE0CzbJ676WbLMgUfatHN/5jqEIZKDncadEsbv+ga12w2RY9n8WGZfm8jwIqukE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+5tC2L0UzX4a4RvpwCWBHteyyNDWNUaJaqiB5QOkJTY9m6Bo
	f4oLKpWzqtMVkMBeu3Nxce1HzKsA5GOiux2gldGuYrHwES0DGit/tOhEgxHzqEojIPSDi6T6Y3t
	pBP1NRA==
X-Google-Smtp-Source: AGHT+IHtyXeI+NAYbbwEcFRwaEtunTttos1ZlDNBzVUb9vdoiOgkiKpFg++zVs2ayLlicxitsbnrBjwlIkc=
X-Received: from pjm11.prod.google.com ([2002:a17:90b:2fcb:b0:321:cbe5:b93c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5623:b0:311:9c9a:58d7
 with SMTP id 98e67ed59e1d1-324e13e238cmr1256386a91.19.1755645464064; Tue, 19
 Aug 2025 16:17:44 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:13 -0700
In-Reply-To: <20250711001742.1965347-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711001742.1965347-1-jthoughton@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564466673.3066105.7016376973027336397.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix signedness issue with vCPU mmap size check
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	James Houghton <jthoughton@google.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 11 Jul 2025 00:17:42 +0000, James Houghton wrote:
> Check that the return value of KVM_GET_VCPU_MMAP_SIZE is non-negative
> before comparing with sizeof(vcpu_run). If KVM_GET_VCPU_MMAP_SIZE fails,
> it will return -1, and `-1 > sizeof(vcpu_run)` is true, so the ASSERT
> passes.
> 
> There are no other locations in tools/testing/selftests/kvm that make
> the same mistake.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix signedness issue with vCPU mmap size check
      https://github.com/kvm-x86/linux/commit/a585b8761451

--
https://github.com/kvm-x86/linux/tree/next

