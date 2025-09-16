Return-Path: <linux-kernel+bounces-817950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52577B5896C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7202A4751
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57304221DB3;
	Tue, 16 Sep 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQlrheft"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D611EB193
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982545; cv=none; b=eVHw32D1wnap5LuC3KR5EGxi/2TIwWOe67rx9UdMmqK7xOGbCtYCtkpJXz9HeR6pP4kjpHZ7vuithc3sDqeLygDjwCmNdsmaYdLoOVXtriqUcfKYIZhyU/+9Rj2FAA89cxR1bimCOb8bKg8j9/Z0l1zy9illPa6v9mx8RQSy0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982545; c=relaxed/simple;
	bh=R7h6vr5y20LrVY2Fl3mb8rlL1FhWw8nm3xKS7IlBQ2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PEmpjce4W+1YMltpJYPOZt/JL0FhRUY8yhy5+OTn2dXQqvLrQdf09zYOdRrWqbryiyjQsgYBWu/cUeoeibiYf+Ag+dCx/nFxY2HE74PHm5TQXxxyqJOJyLnclSRXzIC361ZvP9vtYXndD8RIW+zYjRN1T+xdL4w43DLC+dqbQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQlrheft; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-265e92cc3aeso16782135ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982544; x=1758587344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeZf4Mz9tBewAkqHUPgxSGEylmAc4WQLOzaHS12Y+Sw=;
        b=IQlrheft9l+MJK/w1jups4z22vv9/LuOyWYN6Z677dikp6vxZhqs1y084h1d9TnTNr
         3kYvktbdN9mZKqmUbiT3xsSlx9+cu/SwghkKJN3jqnsfqCjXmne5DaOAAEW9J5Lb9pxt
         uBsJ5I2hILvBQWodt3IO6XMZyz+BRI6f6NI6bj89wSKxoZTVNMRT0BPsKfE6PpSj1M/E
         MBtlIXAr+ALfaVNfra9ibxv17ADzz5cmPAbkCKEuFpNbSYwPmZjbEY/3T4rd7f/SMOSW
         usr2bNdMuTKaz9zOBINrafNWJrSDrRE26AYHMibFQQhIi0n0K5KOcXQ5eWj08FjGqz93
         AVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982544; x=1758587344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeZf4Mz9tBewAkqHUPgxSGEylmAc4WQLOzaHS12Y+Sw=;
        b=gmfM3wrOIT2Y8VEEDwWDnPkDgcY6qbWmZsIlXMhszVUeEBFXofUGvzxU8oVTVF+f4P
         RT5Q8HpoKB2z7B4N6gVvRoyQrP9ym5Ju5mFR/BEZXn0ue/OfbkUwW0nPE00azynMdFmc
         FK+SdgbKst4R4vDDe8BcgbB2vTCvJaEcU5OEM9u9amNvo0IKEmqfkHL+3Khyn6nULzHA
         5RQZhWwdmeDUqnJEzKtWbFz/vZQ6KF0SU6lRiKebmtvt+3xkz6HuqfASA5r8K8iudjYV
         WRyukiURsxc9FEBb1cQjj25w5SC5uAfFVPhsyAgCcMVCcmE8sVg2DhO4jyNkDXeIbRse
         uGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt3vjjDsM55TMFGVAegZVeHo8j2AR1jcFedtf3FjBj0EysdpTkB+OCJwFSghDOrmB6YjCS0jzIl8WMwwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyud5PuV1rM3Le9dawSKKnIPHFcaoD+iOy3ZZm6sJU2Q18LBaHF
	cSCBajVEMz8ofTb3D5VptBoEQhtvUi0EJ20VqZINem0ytgaeaIntrl+ezwHPvC3/oOYrDH0ggmE
	/sJD8vQ==
X-Google-Smtp-Source: AGHT+IGGG6fnp3AkWxZKPRekSDJd915c70ZlNtc2w1eE3cpek12PdWD79YgRwFnKYoGLRXVYrTeikulsLko=
X-Received: from plbke11.prod.google.com ([2002:a17:903:340b:b0:24c:1a91:d08a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80f:b0:24b:11c8:2d05
 with SMTP id d9443c01a7336-25d276230e7mr187711185ad.45.1757982543752; Mon, 15
 Sep 2025 17:29:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:53 -0700
In-Reply-To: <20250909202835.333554-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909202835.333554-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798203762.623957.146740047246949369.b4-ty@google.com>
Subject: Re: [PATCH 0/4] KVM: selftests: Fastops DIV testcases
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Sep 2025 13:28:31 -0700, Sean Christopherson wrote:
> Add DIV and IDIV support to the so called fastops test to add coverage for #DE
> (the only exception that can occur during fastops execution), which was broken
> due to a typo in PeterZ's overhaul[*].
> 
> I meant to post this back in July and forgot...
> 
> [*] https://lore.kernel.org/all/aIF7ZhWZxlkcpm4y@google.com
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/4] KVM: selftests: Add support for #DE exception fixup
      https://github.com/kvm-x86/linux/commit/7b39b6c76942
[2/4] KVM: selftests: Add coverage for 'b' (byte) sized fastops emulation
      https://github.com/kvm-x86/linux/commit/9bf5da1ca427
[3/4] KVM: selftests: Dedup the gnarly constraints of the fastops tests (more macros!)
      https://github.com/kvm-x86/linux/commit/fe08478b1d51
[4/4] KVM: selftests: Add support for DIV and IDIV in the fastops test
      https://github.com/kvm-x86/linux/commit/aebc62b3dedc

--
https://github.com/kvm-x86/linux/tree/next

