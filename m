Return-Path: <linux-kernel+bounces-819504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C8B5A1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00068321C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D402E8B69;
	Tue, 16 Sep 2025 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfJh+b5j"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AF2E173B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052834; cv=none; b=bmRB0d5WVjm/wUAGm3xRj4qrhmOUPy76mTEjVv6ZzFSNTnXwA6If/O+w9keRambl5iku+oqoyTBKwXu1C2zftFsYvUU0I6tAYS3R+BTpeZDYl5m2c8askzOBMLAMr+9RFys8oNRIjMCvVP2YbiaTrvc2KxMo29QpYZHbYsnha3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052834; c=relaxed/simple;
	bh=t2utGdCmNJ5I257wAhAFuys6zxoQJ7yxsJlmMSzi0Mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ssJoFz2Rp1NdHrFbegwdvl2nPJBw4xv6bTJTOxrL2MNIzBVc+ALq9O69trZ2tdpEqSse6H88yAa0fNHUDKP5AbyvJO3PUCKH/KZptVFb4y7JVxUS4x51ObJ5pjTj5tVGhYQ2+lwzmve1QhnNTx1XffIVi5GCJ9mZLPedO2eQD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfJh+b5j; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-772537d9f4aso4867346b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758052833; x=1758657633; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtAviyMhvxBOy6VTj2t50KMfMNiN9CQqJBtZyq/rBXE=;
        b=nfJh+b5jlYspa6wySWlXkOjLVv1KGRTK3j9R69Csh9xsPnOdlnlAyOLZj0ed2Mq1Gv
         qj+wFphuf/x+xZeY9z8Bk+uFzd+v20oEFSAbGKhMZfAzx4Ufz0JSN1IYKMePuWZZivAL
         7+99hmle4zIxn5HcMplYguQTYurEUDsfT+VpFMzBEcx7uUldonUU4qKXqf8tZ/w8f5ne
         DWWeISbSvjwgMnxP+JZpl+IRX1qHT3Az2PK0g4RZ+ZnmEcw0MSHX/Y/O3z7LslzkMvkx
         M/16d+krjvvDHAEaZec7R7NQO3Aam3KQWBR6DtAhLDgawAxs+TMB/n3f/dOkBBBUzvJJ
         mkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052833; x=1758657633;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtAviyMhvxBOy6VTj2t50KMfMNiN9CQqJBtZyq/rBXE=;
        b=Vo1z3YSqxeLV1q2w1vVei9bVhieFYuC01nCjL5fNLcuSqpVd0bY8j0DtaNJ3XisYN5
         nkSyj7AVwA3ouLlsh2Q+5Kbgj8RjStYeOYgVAMMM4pf5m2vcs9HDUBHzq33RMcE18YXe
         XIZJxorXyulDO7BrUGC336PWj421bWDq67b2wT6DRsb7hhRIlu+gzAoSE1qZBvaA9ADv
         qQjyhNNFkXuv2A7yd5ctZHQjUCyOiZ9xySd96WVecrHBNuWrcXPQyXqi6m0CraZAShiU
         pc8JjjoHEJas7yiEM4GuVm0gZ0eYn9VfDH6TWB4QQib+fb9K+dWLiu509vQOehK0oqea
         q51g==
X-Forwarded-Encrypted: i=1; AJvYcCWIxCoVPBc1CeNYJuzG4anJkYmsrb3OQPQUgsynXLU0EZffijZM56XbP59cp7Aa3ifb1GdzgFvHA2OQ60s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKt7Ro+k+qSgYbxBC8jpNa9kQj70xEgwBTJO8AQHUCTl6Z+l3F
	O7uLArEiHdTHLCTYG6A9JaxMndBhn97UnRlqmvzQVAnLtvFN6oxVkzuc5QT5FICsOaOeQq2SDOh
	YhjThUg==
X-Google-Smtp-Source: AGHT+IHuvuCd35WVzVuncMTaKvPDesuQuvPzFxcrNmVvOKElzVCAcsDWXtEZOJKc877e17BPicyXxlxixmc=
X-Received: from pfbcb8.prod.google.com ([2002:a05:6a00:4308:b0:775:faff:e6f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa6:b0:24a:c995:e145
 with SMTP id adf61e73a8af0-2602a59a011mr23215785637.19.1758052832629; Tue, 16
 Sep 2025 13:00:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:00:31 -0700
In-Reply-To: <175798206914.624430.1356425451234333085.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250901131822.647802-1-liaoyuanhong@vivo.com> <175798206914.624430.1356425451234333085.b4-ty@google.com>
Message-ID: <aMnB36jJ14o68mGF@google.com>
Subject: Re: [PATCH] x86/apic: KVM: Use guard() instead of mutex_lock() to
 simplify code
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liao Yuanhong <liaoyuanhong@vivo.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Sean Christopherson wrote:
> On Mon, 01 Sep 2025 21:18:21 +0800, Liao Yuanhong wrote:
> > Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies the
> > error handling to just return in case of error. No need for the 'out' label
> > and variable 'ret' anymore so remove it.
> 
> Applied to kvm-x86 misc, thanks!
> 
> [1/1] x86/apic: KVM: Use guard() instead of mutex_lock() to simplify code
>       https://github.com/kvm-x86/linux/commit/50f4db196766

I force pushed to fixup an unrelated commit, new hash:

      https://github.com/kvm-x86/linux/commit/4319fa120f0f

