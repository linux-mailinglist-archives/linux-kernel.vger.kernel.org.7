Return-Path: <linux-kernel+bounces-831060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE61B9B646
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60D32E4D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB4330D38;
	Wed, 24 Sep 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sl6ZgZWC"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5432F763
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737301; cv=none; b=q/QPDJ8+HpUpyrS4gK7wTSA6FNCzQe6MaHXflYCY3iprya5KVmmgta0IoJV2wdhURCj1G0RzkdJjP8VPS1T1aS59LzAe/5BIwVvBT1Gom0idPM/WmRPfwuafgE6lc1O+B8euCq7Ai9K5TtkHRuOJMK+iRtckcqs97Hx+J9zOrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737301; c=relaxed/simple;
	bh=EGhb0RvyQlm7iZwhsGxvU7M6C4b/2pTdXMLeRQfd0Qc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMuemUJ2JKni6vtX9RzverxN1a5NFAvRGhTQPG856OlB2lJfbaRh46nrYn50jgtxBPrZJPiPidieQdmnD3W5oItjy1xrYfZlgtlp4d4y7/8kHoLVNchGhKRwwxR5PVC22MpkWdxtgwvhC4LcHkTekkFiP7GmHElqA7leBEFDTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sl6ZgZWC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2681642efd9so562575ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758737299; x=1759342099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkuc/fF7H0VC8ANgHBpHu7wU6KQSXWbo1rt2SqB0zfk=;
        b=Sl6ZgZWCW031UTCtuUJE5AydySna6reS/EAZZlm7cn5T9JMxggeTxWPE6mspkXw+Xk
         ZeHwjazg6jT5VzWL8JeZBmQKnGWZuYocPFDowNggM1DdW6SRuoWkgJiXA+uvYUiYAitO
         wZd1i2ihKf8C3jfdLEAiK5GtPAklt1bAsy1Mq9R0Pn21AtdM4UXp/nJEJDnCoDis60Vr
         zNOCWEYdke6p//NMT29hADiZeb788ZRozV4o3dWKsX2U2RWXnEzIkGrZL8H7DKG1lDtW
         QJJPSb1UuaMH9Nnn7UqngYNWswRlZNxsmUbscr1zPrzqs5EYLMna2KRAOP28E2xo0f2t
         f7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737299; x=1759342099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkuc/fF7H0VC8ANgHBpHu7wU6KQSXWbo1rt2SqB0zfk=;
        b=dxkoCPiSRf4Xbn+s5ySKWoUV4FsVXzlfAi/qVEb5I5haqD32Vgt1AQXEEV91RiyEos
         7KeDuChytfGDnJn/t1/uRBv1HvVuAbCIBbzpU4zdVSsmoKn9qkMRNCKK78rdCjyftIVn
         e4emFsOmG0z2/zkJ3q7vb7u+eBops7+4zJRYxUO6OH1pPj+uE4XIuu7jZosGu9BE8+Lo
         l/VAG/J4FYJ8tu4KlvR5fc3sONHbgHZxfYECpifLax8hl7sIypr9hKzVD8zJES+LtG80
         OrB2RMYmbwF117Jsudaia0kXW0BP7kmPQnG+pXSAdwQQBU2P9s2hg5QiDuqKY8zhf7Um
         rqtw==
X-Forwarded-Encrypted: i=1; AJvYcCXAZdKy+CeOP3b7aEJ3fKVUT2WDYwUnUiDOkEc1Ewd6EYcjW/eb9Yfplf6mk4OpMG/4cTyOb8o7oyavcDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIlUvkuuN9me2L/Fxdagp97J3xaXR0tPLpSHLFttpdHobK/Gm
	CdMC34GSSzj5ekeXoE9CyWPMsLrdK+DgwLqdH+daRwfd3pXEYUF+QYKRhD9SZBTYnLecV15p8p6
	ZS+FfIA==
X-Google-Smtp-Source: AGHT+IFiip93Y8SalTeWn/bXmvAZdZQIdPnwJH/peLWIGmz1ar9OPzcSFYPt0DBwYf8tyRdYIRNJWiF5JtI=
X-Received: from plss12.prod.google.com ([2002:a17:902:c64c:b0:269:ba45:78f9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cb:b0:26d:58d6:3fb2
 with SMTP id d9443c01a7336-27ed49b30fdmr7146075ad.12.1758737299218; Wed, 24
 Sep 2025 11:08:19 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:07:32 -0700
In-Reply-To: <20250919004639.1360453-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919004639.1360453-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <175873596698.2143185.9486968747074623197.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Don't treat ENTER and LEAVE as branches,
 because they aren't
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 18 Sep 2025 17:46:39 -0700, Sean Christopherson wrote:
> Remove the IsBranch flag from ENTER and LEAVE in KVM's emulator, as ENTER
> and LEAVE are stack operations, not branches.  Add forced emulation of
> said instructions to the PMU counters test to prove that KVM diverges from
> hardware, and to guard against regressions.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Don't treat ENTER and LEAVE as branches, because they aren't
      https://github.com/kvm-x86/linux/commit/e8f85d7884e0

--
https://github.com/kvm-x86/linux/tree/next

