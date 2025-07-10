Return-Path: <linux-kernel+bounces-726615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1429B00F49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D775C4CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA3E2C159F;
	Thu, 10 Jul 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLOacKNv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE72BEC52
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188971; cv=none; b=sMP6+Zk4KMnu/LsosUpGGA8e4RnZfJcd71tvxUK7LkmtkEL2rrtwkupY60CM+KMTUMM2KDUUUcxO3YQN7FFAZv5Lm0+adbyMc9I7mVD5SvsrcU9/PnPT/nHIolzL8tdPUdzYHbNHk7wBo5UP74t7skDlW3xpueBr1s76USnXcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188971; c=relaxed/simple;
	bh=hPmoK18pg5iLY83A+rbNr0eXxFJUmHHV+34ar6KDHI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgdQdY1qE3quLGvoDQ9uZjfDOMVRvXwROTMC1ImoB5vbJpWC6eWOV7xtWbZoN2dvH4mWkg5zJd51qlPkt2+mtvszWEW0rvxM1gKRaYAOm7ZaOY7UC8aVAkMC5SlyLYVaB6w3sJZe9rRZpRGOUAArxGdlU+cMuXkIEHwbsLa4BIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLOacKNv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso1447724a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752188969; x=1752793769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTOjUgZ+jlqnvf94jkmtcbiRBK+z9uxeasDSIpxLc3E=;
        b=PLOacKNvVTO5EX6BnPQtnbFFsJ3GjDr59eUiJ6Ri6nmA5aY+lOwUmzFwgn1mvkOAZY
         UtrLtTfAdFpV6ENFKPF4mETpWyq8Su3VzX9elREijDoDx1RgEGwOiA+CE72hfSFcWNbc
         deM5JeHhbIJ63PJt9BJmul/dXYSfma323pl2KjlCWNT6uESfHITz2PZXYzi/6OXmHQne
         SSSv6KBZqseA8kOYNl+LERTsIu/D12ZpEz0Suwlc4huDtPl/MJmN2VxHfhOiUn4oEe2Z
         3KSl8fYEZLMP3VUbWzRpL4nMKlxJwfnrTeEE+czOiGZivUY3mJExkc507jIJ3fwqn64r
         dDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188969; x=1752793769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTOjUgZ+jlqnvf94jkmtcbiRBK+z9uxeasDSIpxLc3E=;
        b=irv2Jh9bG9+vIwbLpy9wqoLDiIE30IYtuQUY6zDvL48mGO3N6wgz2najMkQJ0V/hq7
         vYxBUEWfPJoI5UMP+lIVhSaIcC1Mje2o8C2TWGSc8YC9mYElEb+HMDKgBgd+HDmeo74g
         BDt2gOUTBopL2qgIoQuQq3AQQtul43jp8gEAdSnLFxAomgEZyeEtpGW8F/cJ24xm0HE5
         RpXfs1vQkFX9ouwfg+t0Q3Fs+D1kKTPpXnoeesONKddg3RUNoRMkNfRzOtbUiEiyEW6P
         G35vdBLZ9xsz+aFWXOWVJnl96WbjSG0Ro+CWfd2ZnEI86VUxMv+U5pNxZyBlo1a8nu2u
         LI3A==
X-Forwarded-Encrypted: i=1; AJvYcCWvUt5SQEw1w8mgib7bgR7NC9uRNF8/0gDRof5Vh24fYBqXsFFjy3Eqd9NXQ5RHmiZEDwX9wEc4gH1GjfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1V7nHYrRpY5eCNgvLhqVJeibj8BxFv2yuC0e2Inc7RhBFWVvc
	fRZYsPV717tbnWq7ntRocKJelBFmdAlw6s/+DzYIv9yNvseARJIcVYqJJu3oddMNisoqkNQzfzo
	dT3Nr0w==
X-Google-Smtp-Source: AGHT+IE5qplA6OlFk8T7yH4h0UYvRJy0Sx+PveuccgpHAv26S7kZa5gKLhMTgKXx1QLGSTPoNXD53rWofSA=
X-Received: from pjblk18.prod.google.com ([2002:a17:90b:33d2:b0:31c:2fe4:33bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e4f:b0:313:271a:af56
 with SMTP id 98e67ed59e1d1-31c4cdad83emr1515086a91.30.1752188969037; Thu, 10
 Jul 2025 16:09:29 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:08:48 -0700
In-Reply-To: <20250710-kvm-selftests-eventfd-config-v1-1-78c276e4b80f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710-kvm-selftests-eventfd-config-v1-1-78c276e4b80f@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175218119916.1488306.933221879584328516.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Add CONFIG_EVENTFD for irqfd selftest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 10 Jul 2025 12:12:20 +0100, Mark Brown wrote:
> In 7e9b231c402a ("KVM: selftests: Add a KVM_IRQFD test to verify
> uniqueness requirements") we added a test for the newly added irqfd
> support but since this feature works with eventfds it won't work unless
> the kernel has been built wth eventfd support.  Add CONFIG_EVENTFD to
> the list of required options for the KVM selftests.
> 
> 
> [...]

Applied to kvm-x86 irqs, thanks!

[1/1] KVM: selftests: Add CONFIG_EVENTFD for irqfd selftest
      https://github.com/kvm-x86/linux/commit/81bf24f1ac77

--
https://github.com/kvm-x86/linux/tree/next

