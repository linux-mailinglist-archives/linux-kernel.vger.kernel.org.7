Return-Path: <linux-kernel+bounces-885274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A02EC326F7
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C91421E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01C33E377;
	Tue,  4 Nov 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWFbpxbc"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6F33E35B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278456; cv=none; b=bkneEjsyp3fqqfMeQdU5UuJTTPUdmZwEIzoNNxvcZ4g3a80VhBqUxp2aVGJcMgPn/69CXT/MIrj8g9uwKX9+pH9Bufckgl7FypJvAU+hajs2Ub91zZGAMnIeTstiQJAufYghN0m9mssVik00m6osoVhvghFDdJk1Vp3XpHcZeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278456; c=relaxed/simple;
	bh=m6iIOxVdV9xZ4R59J/j5BOZ7itRe9uWFn2gu8sIYRe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=byRSRxtJ55wGKLXqgaOmI/xcfx2hGLIwfR1czWDL8QwhEOQG88r3aZtF0HLmOhcuD7bjQDnKu+LPmYeZEUeVoIddlV8HP1pYgJeJSOnHH4aFR35QRV90kgGZ72t5ItglgFeXCTFTIfDiRL80NloEkj+XnP5Vhr+LOdIt0Hov0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWFbpxbc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340be2e9c4bso3068912a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278454; x=1762883254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPGvA3RdI0c5gQobVP2oSU68Sp+AIlD9qDBLxOUqB+Y=;
        b=oWFbpxbcZwdLESj5hbygX5KXMNrflN7sI1P7M9TXdNHN73tQReusejxAZJbnpZPSOO
         eVchRDVjIA8cKrte0dlC1Y1eKvvEWpspu12dlgS+ir8KRl6bkBy3FVLJrl0jTLsofFOH
         CaFASHHugoJqzUQXjUS4Ez7yeTTPo1fY+y2U/jEszxJnG6XVQMQZqBqD7UGN+o5lnYFo
         RHFzToJsgke5NDhrKajeKaI/7Y+CGXih3KkJo43DoMPHERCUimiNTvCMcGaplBHUkR+6
         QHAyHI5rZV+63vlR6cZ98Vfe2TNmuPsknW9j8y3SKwriuOo8fHBGOC5OI5bfn/IPKeZI
         5k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278454; x=1762883254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPGvA3RdI0c5gQobVP2oSU68Sp+AIlD9qDBLxOUqB+Y=;
        b=HiT/N7YrrsL7mj/pka+jI4MTx2vJol+NsTIesOKKpSXN6/yMx3fPm0PQACxQsktkvl
         wMj1PwTylHfrODwJpDNUDZK3CvWwmpZA4CdFkf8uax7XtJ2MBkcokUX9MpVmcR6m/Rnc
         weHF9wm/3t0hIHceBXJHpBxUMP1gMulVDTwQnrai0+eMXvERsGJqd11XpXt3L1XWHsVl
         I0HIW7JOBZhjfUVXwKxxeD7EbkkvSUT94BXFjuYKLwmmFe6pIobuFrAB/am3zHuL0F1Z
         Lx7lHdGlvWDl87UxWbU9jJ7ZJjHe5BhuS2btc+Rn9iPufOsdk+lbDOHmoZpaKB/zs07I
         0cxA==
X-Forwarded-Encrypted: i=1; AJvYcCV0l4r0QCHmyO56wkHAScMvbRyyPFsbfWhiB93+M/yupGH9NlVfOxskMNYDejaZ1j52vlDgCzvZKYPIUA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVhhy7atlIQlo2dTGOMuXZI5Sr+87ez5UPq7NB3KEkcKScOIg
	5w+rZwGGWO+tqm19B9gEQxcGyc97HbvZI7A6Pif7F0ejHLLjTd9SdEw5DAwm2doAD6e1VB3P2r8
	JFyew+Q==
X-Google-Smtp-Source: AGHT+IEXgUsBcWuuZMqpwU2yUZ0pdaTC98ExjPfngQwQ3P9JHrsrI2UqIk7JzuBp5OBgGGY6ISRc4F+NOtc=
X-Received: from pja6.prod.google.com ([2002:a17:90b:5486:b0:33d:acf4:5aac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:32e:6fae:ba52
 with SMTP id 98e67ed59e1d1-341a6c1e406mr59316a91.6.1762278454600; Tue, 04 Nov
 2025 09:47:34 -0800 (PST)
Date: Tue,  4 Nov 2025 09:45:14 -0800
In-Reply-To: <20251007224515.374516-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007224515.374516-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227807716.3935194.18291135386554722106.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Use "gpa" and "gva" for local variable
 names in pre-fault test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Oct 2025 15:45:15 -0700, Sean Christopherson wrote:
> Rename guest_test_{phys,virt}_mem to g{p,v}a in the pre-fault memory test
> to shorten line lengths and to use standard terminology.
> 
> No functional change intended.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Use "gpa" and "gva" for local variable names in pre-fault test
      https://github.com/kvm-x86/linux/commit/9e4ce7a89e0b

--
https://github.com/kvm-x86/linux/tree/next

