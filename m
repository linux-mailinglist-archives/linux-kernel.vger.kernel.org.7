Return-Path: <linux-kernel+bounces-831109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69214B9B8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3307D3B1FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E983191D7;
	Wed, 24 Sep 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RU4anlX0"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FA20B800
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739523; cv=none; b=C0pWM+DJqlSFc7Kv9wTUjryKMXncl73IDe7BggJ5uo9vaFq1hc74I7I5fkzgk7rWjkG889+wzOwESlSuRe0wglcCBW/zWM7OWJoj34HIOBBk9xRs/Iaul/XQxNxneYneAnG6olFdFddIElOVSsRaTCBzM0/3BQYhpfwryFJeGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739523; c=relaxed/simple;
	bh=Lux3sbRLdDVcfZqDHkK5B3VxvEzuH7zstz9HCkeka+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sV2fa8Fwpyhh/UFaZge56jEJJdwxjdE3GF8zhl+RPILS6mSTb00Mf7LwWXoIfh0DixaYLSvj0A6qFt8TuhmiTG9R46PMbFBbzcIG6KTgu2kVxvnp49WAOLYxpKQAqgQGyTVfY4ciP/rdeDP49GQYbcwHQGgsG4Tb18h3hY65oFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RU4anlX0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-268149e1c28so1191305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758739521; x=1759344321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PuRg6SNsqixaTOVmmK3uOTfxD/fSeqR6sejXpJN0UP0=;
        b=RU4anlX07u3t0wT9zF2yA18TBUbRmrS5iQ11g/kU/AkGY7TextMWSlI03OyyEgX4+Q
         yIFtrZ+qGziIJFHvkc9Dl28wldYlRMTSuWvQPjUPTBzO6E4fjUpRM1lbzNvdPd4T2mLk
         O8LGR/9ICeu//v+aSRMbxlM8BEZnG6XpL8cygS+rCIj1PkyUkfkhY1xHZb6CcMZ9LcXq
         4dDYOdP+2Qvs+VR6+pOzIjgl12JsR9xrM8E2AXblcb0G7Sm1Hxd9bbyAufVXA7JelZiI
         x0h5ForbFv+5t7yGaj9chRO69ucHV+WGMCJ3yr+COd4yKkblHVHanvgB6usYFMWRWU12
         Golg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739521; x=1759344321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuRg6SNsqixaTOVmmK3uOTfxD/fSeqR6sejXpJN0UP0=;
        b=jNiVXMDAFcjoCLwewrIhsZpvq5GtQc/94U9KLCeP0CcnethTkKGEHUOBxTvRsD19Db
         5un5v6HZ2peCq7d431C9IvTtCB5gxxebR1UMu+skL5sjeeNHiRm4a65N3OC4Ho0I8U/Q
         JAQQDjnFrbyjU5OhFRASafbRjbCg1nI9LIMO6gGh3VPlGlEVas5ZKB1NaD5d6c5h3zTJ
         4WRGqNIgJPvauE3IhXsVANnBlP8uhVrnzlY3qYFAIiefwULx86sV0nbR/fT33oRiOewL
         6HSR6vrmRlWYWae5r7cLFj/AII4Srq0gDciUUXw5J3q92B2eG8jeWFaZ09RxYMOUfX2K
         ihYw==
X-Forwarded-Encrypted: i=1; AJvYcCVURXx6UiUGrO/TxsmjCPm4y1YQnnjAzcuaIswyGhGGcSAdDwaclPWbuX/BAsgI5sVLYaxxUNdBb+g8jSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC5iJk1kOzp39MjhuDD66uE/C8FhbRoTf79UDTp6TWxWlci/5
	0WHox1z+ojPw2dWZlAsGYap8VKr2dqTxzq8NgNco5ObMTZcxRlszQBeJZ/duWcJ2cgeSCVoR5On
	ueNiDBw==
X-Google-Smtp-Source: AGHT+IFKjoeIQvU+5qMuE3xLff/oP/JCX0j8XzLHJgmDk8X1MKu15hv5mG7VqGvTSem8tEiUa9GMntO5xhI=
X-Received: from pllb17.prod.google.com ([2002:a17:902:e951:b0:269:7051:8e4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebd1:b0:267:cdb8:c682
 with SMTP id d9443c01a7336-27ed4a315ccmr8753205ad.30.1758739521650; Wed, 24
 Sep 2025 11:45:21 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:07:43 -0700
In-Reply-To: <20250923153738.1875174-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923153738.1875174-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <175873605243.2144113.4486198413338077399.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] KVM: SVM: Fix a bug where TSC_AUX can get clobbered
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 23 Sep 2025 08:37:36 -0700, Sean Christopherson wrote:
> Fix a bug where an SEV-ES vCPU running on the same pCPU as a non-SEV-ES vCPU
> could clobber TSC_AUX due to loading the host's TSC_AUX on #VMEXIT, as opposed
> to restoring whatever was in hardware at the time of VMRUN.
> 
> v3:
>  - Collect reviews. [Xiaoyao]
>  - Make tsc_aux_uret_slot globally visible instead of passing it as a param.
>    [Xiaoyao]
>  - Mark tsc_aux_uret_slot __ro_after_init.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/2] KVM: x86: Add helper to retrieve current value of user return MSR
      https://github.com/kvm-x86/linux/commit/9bc366350734
[2/2] KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from SEV-ES guest
      https://github.com/kvm-x86/linux/commit/29da8c823abf

--
https://github.com/kvm-x86/linux/tree/next

