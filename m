Return-Path: <linux-kernel+bounces-855034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DEBDFFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BB919C77C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75C0303A32;
	Wed, 15 Oct 2025 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU4u6g3X"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41D3009FA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551604; cv=none; b=V6i+7wNwZ0wnfB2/G+PGNx1tLjYBEX4p260LSiibgbtQ95GKHNYxNvhkbH1rJ9xpekVHklxP+LD5W43qgzng39YUXNS7GcKVEsonXQgFaEvb2NkopSR7BAM+ixBOXCu8dnMhZai90N5l9lHwfR+XJXSWqQ+8ZdHrzaM00Uy0tQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551604; c=relaxed/simple;
	bh=0WpsZOIGxI95gzJAoZvCSpzF+V+dgMO9D9tFVdnnDFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NV0ERat+CJQ4l6nLuJKUm8gmxCZwOz91VDp3KeReEGMUiI145ICIAdn1ILgYqQUUdpXiRieAYEOMBLzmBtRa9a8QFHPDNzCd6ZZyL2Lc9L8+PcveLx1KDCHKOJEqmscmbc8RnpAv78E2K5Nj+1a7PwBbhcfvGwD6UkV3QebH9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU4u6g3X; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269af520712so116931945ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760551602; x=1761156402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XErphyN+JzD2Xx6NUwRPhsh1p5MuT3QNYB/D7xXWYjk=;
        b=KU4u6g3Xi8/1wr8xQOCit00dGB4xQLtcZiG3KHAk0GbE+IgOQjj4Ug9c9ycUVZkAn3
         JNPsUNIsH6BxDde8/xRfxv6B2sky2Ka/nzH0xISQuo/mFYx3xLa9H3JSzlrFaqHLZ34T
         xj9Km/VY+q1Oj+KojkopN6DjPoOCYCiB1aEGW74W9F/WXFrYQ/PC8sFlbdI1Eur7Nup5
         cgV4jjykjiaIAeqvvtRHAKvl1XMBMtr8M3+p+0RD2a52G/EbzvZQDOJLWTZfDxcCZE1Y
         e0AWGRbcJGeKduF+9oHwwqGS740hC/Gq7DONE8PxOIIUjGMzc2dYNk5ckr2M/Y1BHYk0
         siMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551602; x=1761156402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XErphyN+JzD2Xx6NUwRPhsh1p5MuT3QNYB/D7xXWYjk=;
        b=RbaaMVdj2vx/0t1gIi9hVp7XNbfEzxLh19GkuztUUNbAXOL8xlF6jyKNrYBN5WbWuB
         qLUBCOdJutISX3CPXJNUjD82haUC1MxVuqX3xCmuksMgCOmf8dVapgU/yv7tz6iBk3IY
         xxCcw+QSFwNeNabAf5bL/i/g1XNIiNj7nuifPeJ7ScAo4ibQLjiKccAopkMTH6cDnc+o
         o6ckHY735bxU7Pf047wR96n37OLYDNTgO18MvVfsv5utxBGj6Rj7fntippImFl9zLCHm
         5uS1EvWNkez/thZQnAk1hUETzjpNLrqZ2fwAnIjbfTFE20oTyxvlM8RMooMPE6DiysdE
         TYqw==
X-Forwarded-Encrypted: i=1; AJvYcCUeerjNrdIQDHxOtaMUa5k59vtzIfew1QHgpqQlS90iqN6LjTtw4xFOfEhfOcAOBtRPZwJwNyibfPnTDhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWu1moWg0Wd6lmM2yyJCHeCG0fGraZ6pXaz/CIE3wePVC4YPeN
	383/Oi7Bh4NU1GzPBquJLOVrlTEGNZyMz2qqi42z1pDqe9NccX07EWmqItJOd9bdR+ylFxwxLCZ
	BuFGPYw==
X-Google-Smtp-Source: AGHT+IHlakRU4nPx/jipQbR53rq+2o27cd14m0xgJaDIBpqYbWuzPcu6OCgdGEa0Hop6qlgIboGtL1yDOiU=
X-Received: from pjph8.prod.google.com ([2002:a17:90a:9c08:b0:32e:b34b:92e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:380d:b0:26d:e984:8157
 with SMTP id d9443c01a7336-29027356ab2mr323031385ad.8.1760551602229; Wed, 15
 Oct 2025 11:06:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:02:54 -0700
In-Reply-To: <20250926155724.1619716-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926155724.1619716-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <176055118442.1528733.6525818620715365939.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Remove stale vmx_set_dr6() declaration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Dmytro Maluka <dmaluka@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 26 Sep 2025 17:57:24 +0200, Dmytro Maluka wrote:
> Remove leftover after commit 80c64c7afea1 ("KVM: x86: Drop
> kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag") which removed
> vmx_set_dr6().

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Remove stale vmx_set_dr6() declaration
      https://github.com/kvm-x86/linux/commit/0152e049bd76

--
https://github.com/kvm-x86/linux/tree/next

