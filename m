Return-Path: <linux-kernel+bounces-776646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E70B2CFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624AA1C45102
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549D276054;
	Tue, 19 Aug 2025 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNbyVPoB"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3117D26F2A9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645511; cv=none; b=VUQPSFUESa9bl+4g4e08bEqSbrvBYCvcPbEtI0f4ZU9ojqxwtG8hR8ZStHCzcmzCmhx7+c8tWGfS/RBgV7BOJA5gOlp+fgyBufPcz1gbzlQAzzpO3zUP7+zNP1ZTL+2JYzyYoOFjmbL2kXMpst4eSZrRvpy+FcyD4gi/ubdSXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645511; c=relaxed/simple;
	bh=9me3+Nvw5GR6wrlOiuXQ4s5wTKqNfkfyvfLMFKkpF7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AjR0fJPzvLO4NPm5rtvJpzRIs/+uTfgOoQfweFMeUjDnkSWGKd94lWWMLkA636AUX4wdbdV7jzZoRdZg5kSEZxcc6+0w//dYoLt/ykcOqQjFb+rvl36kIAthJtchaXRJE78+mJUPwbR5g6EebUi3OpdvFILHiC+idTGOrcuYJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNbyVPoB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267c0292so5481792a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645509; x=1756250309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3qU+rUd2uOAEBXugX20aFB6/9OAkp9lvpRb2zp/7U=;
        b=tNbyVPoBRO476mliCBxTnkKGgMj3cDC1hMiwQM7dJHTUG+xHj8pv/dA//MO5iKSnIe
         iPkl/jM7bijcy/2uz276P7depoFLxd+Zia5z/JptE9USJLUy9e/kvgROVt2dmnl567It
         cs7mtFZXvZtebGExEk/OMI1tCMFkxtGt0zflSPsphz3mLb5oivU4v9JOyCFfgPWeG3zX
         ENQUi7tBCSAnkE4eBh//DxUXpklTG1XSRiH96q44GXippccLcyJVATuT0/IuRpoJqehq
         Fu2f4uGAhse3lVcATgEVw4qNaR0mRhtoYQleh8qAdB3xJgm/Y6Uhma3HKkl9CoJF1Wnd
         IeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645509; x=1756250309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3qU+rUd2uOAEBXugX20aFB6/9OAkp9lvpRb2zp/7U=;
        b=VZQN+mn8AYDRqAWHUnKBcVKcKSJZ50oTN7sCy4LCNBzOExTR2F3mfLncjpdY1rp6X/
         gVuga67NQianUTyY16+u113sUDDa7bTOrIMx8TloLBmUQa8EUBfIXK1BMMLPavM3/Cd1
         L8yakxuGF00kt5GcC6N0I85uDzcc3jtax9GTlAunfgAyYX6xGoevZXmkGd+X+KhTCGza
         9W6jJ720SpNQn6NT2yCqjin5S9M1E9dbiUmDLHOaVxGTOGkWaOIze78JzncBMry7Y5/L
         JFZGQmz1ku3ovMmyNuQjuX5liHyY5yRiS9zGHavQwzXrFqYEkFSguLhuilGe9pHdZsp4
         YutQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyBn9bkRHlx8ET/mSh11f4v9kasuupLnvRGDcyYeM0KMmu3BeQkI6N3K+Hml14yIKWE2rB2sfKFqBwiNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9SFF31an9hmezuSqHYw+8IaX1T2BRMp6zsKrSsvF15GJQLR7
	9rhSBsiNhNTz6G5RHj+S1lE25Zr25PEsFoHB/x4Kyx1pS8b3tIQGE5kSTsb1SqYmGYCB35siIBG
	H/8r65A==
X-Google-Smtp-Source: AGHT+IFiv4qYxB6xpy34uXqOHfW6kqJTDu1gCeF6NGD0p1FF444dtxLLsvj8rrTig4ufVAVuUCVK6EPvtSs=
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:31f:1707:80f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d85:b0:321:8258:f297
 with SMTP id 98e67ed59e1d1-324e1420be4mr1076917a91.18.1755645509359; Tue, 19
 Aug 2025 16:18:29 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:23 -0700
In-Reply-To: <20250715012517.694429-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715012517.694429-1-xin@zytor.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564445190.3064051.14000525252445211835.b4-ty@google.com>
Subject: Re: [PATCH v1 1/1] KVM: VMX: Fix an indentation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Content-Type: text/plain; charset="utf-8"

On Mon, 14 Jul 2025 18:25:17 -0700, Xin Li (Intel) wrote:
> Fix an indentation by replacing 8 spaces with a tab.
> 
> While at it, add empty lines before and after for better readability.

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Fix an indentation
      https://github.com/kvm-x86/linux/commit/a1f2418c3eea

--
https://github.com/kvm-x86/linux/tree/next

