Return-Path: <linux-kernel+bounces-656487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7FABE6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44444C6EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63725F782;
	Tue, 20 May 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2z2PAlc6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E921E7C2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747779900; cv=none; b=XnuqoAnA10obfw42zbDJBc7PNry0o8UF07zxRdwbseOPG+cy13SJpa/LWO7aNRmM15nasE256O/9o+hP+RdC2jUlR4AToNy3FypWMMJNuPUtUBbnEmgtu2+zg7/rkFMYHZM2EIxJ3BnuRl1+D72OVfDaPwCMxmslBCz5V9Vbke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747779900; c=relaxed/simple;
	bh=1fY4fCUL5YGMyXxzGQmGeHjD5qzIGXLa97k6xBFOGKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JASfkmkI9URu0DkyCEVvBbfsM9M9a7sp17L9uRVlNm7VO8l+gT4Ji93OzbJn0Bj2G6c0o7cVFGP8MTw+guJNT3C5TSc7CO+9NZt88QmFX6nStkthlqWjAXBg8US9/rDEUeSHXXDdc4Q8o+XjmuZg7qnhkZeQKU92l1Od6oCGjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2z2PAlc6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so9382516a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747779898; x=1748384698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fY4fCUL5YGMyXxzGQmGeHjD5qzIGXLa97k6xBFOGKI=;
        b=2z2PAlc6za43AYnxH7iJn0wSspkd9NxpKPXSiLKcnCYqJA7V3TvVu5be4rtKc33eFs
         2SsbaQi3dkU+vj2zJQ9ZKsIBeKhZmlamq+H2UaV1gHEV6wIu061dw4I83e958Tkb5JqD
         lrcIiTKxdsn+RU1FZURlYcbBctFFHohHGwmpbNeQU9oean3Dn1AsEXN0V+iA/HWbm+hy
         7Buhwm6IF3FdycWucIslr5jt0BmavqQt/IN1gOrMkTfMwsgbioinoiLO25oezbg3jkaR
         3AXZ6kt+9mVMMy7BYWDOmaWKqK/Pb6GhYxFtKft27vbN7i1ji2hpku6QugHXp/LBxNV6
         LIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747779898; x=1748384698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fY4fCUL5YGMyXxzGQmGeHjD5qzIGXLa97k6xBFOGKI=;
        b=IKkI9HuK+IVgb0+zkQe5PYKu/yeeahSJGVHCH3iIrXXRcQUjz4IzKdJtm9R2z9q12l
         0u4rTsesuT9nkriHIzqrMjHT/7zmXbEmKavxWFOKnvY2CqUL9dHQXkfqkBrF5tDvT3p6
         GbVIOQh3TOv1YuyPI0iFWzUCjW3XMiU8k8QxjmqqhFaC4WRhDVinup+VBppbV+kK7Ne0
         OVSnyijwTEvnZmN4DZEU9uATyTc/rt+r+fBKLlxS7V3A6i818YVUNF+Fzl+wUeMb116+
         D3KN8Kef6303uUC5KC710ZEZ9e1Fe4ltTxR5To19Ui91VbCaBogXgxQuK9tDqjBfmv1L
         2q0A==
X-Forwarded-Encrypted: i=1; AJvYcCVouKJHCIvJP+kuYQViPbRZJHw6d0JOeD6c00ptXdZxXgGiteD1Lqf1nzpV/4fYcQoVqeb3VB9fTa2STBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbOJuT0Sy3Oa8LgCydyymdPnLLUHx8Yk2yWt3bZBnEV1+Ac9h
	dIKg3D83ZR+32OwRhNjHi7+QsPvghC5MpERcLFX/rOPENWB0txwbl2s+zr/4KfuAFkVW/x/VYNA
	stx6img==
X-Google-Smtp-Source: AGHT+IGaHyYJa+Rf++C/1dMkyjLd3cn1f3dzajoz2ypKpUcZvvvjQmY+fmHrkfp4/rpt1/V8H13Sg+zxMnc=
X-Received: from pjbsw15.prod.google.com ([2002:a17:90b:2c8f:b0:301:4260:4d23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d888:b0:30e:823f:ef3c
 with SMTP id 98e67ed59e1d1-30e823ff09dmr29760229a91.25.1747779898326; Tue, 20
 May 2025 15:24:58 -0700 (PDT)
Date: Tue, 20 May 2025 15:24:56 -0700
In-Reply-To: <20250515005353.952707-4-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250515005353.952707-1-mlevitsk@redhat.com> <20250515005353.952707-4-mlevitsk@redhat.com>
Message-ID: <aC0BOJoXF45iCO9C@google.com>
Subject: Re: [PATCH v4 3/4] x86: nVMX: check vmcs12->guest_ia32_debugctl value
 given by L2
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

"KVM: nVMX:" for the shortlog scope.

