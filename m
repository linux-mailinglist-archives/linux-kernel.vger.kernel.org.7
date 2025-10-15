Return-Path: <linux-kernel+bounces-855031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC8BDFFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8531A501787
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C58630103D;
	Wed, 15 Oct 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ed+G4eby"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989192FF65F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551579; cv=none; b=e0r2GDV3FH3YOz8z3loxEgDOWNSRA8l7f1AzkjC53n39HWzvpz/vQeuJkLEfENYm1fgB8+/QSl6O2RF1jSIOgmJQ8zNuapvh5l04bMwXbaajlHRAoPVRMWWTgzd0GdExrPikseNtHyNxusmmYm5qX4lh8X8xgUGLgX/ZRmdeZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551579; c=relaxed/simple;
	bh=oUJnw/ES22KXI4PYCvskJYEsYesu1u36fPnCUhxynuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNTb3TqEen1Pr2PLmrIa+Jr/nLXaXNe2/zysMhrB0rIzuvCDvuJp2dFgoMjnUQRmTiiWbWfE660lpV9jMCml9wm1AwYxea7n3QtnWNIK/ycz1DfoyLzfGvYP27e6mP0AeRsvMjQCsR0dw+l2aGZGFE5ClLcPG+sdhxql+sEdb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ed+G4eby; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so16720268a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760551577; x=1761156377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f61Rm9CXZ7yTPp5k0RnaJz34I/PB/mN1ZqanYu35itY=;
        b=Ed+G4ebyQI3EgC7TJGOrERRltkYlqwZbrAmzGhyT5w+ODm24vyTOoFy1oA2oFjOAnD
         qnT5G830vuf8QN1GFY5oXZcMo4LugJqcsb3YUF8NA005GJn4zu2jVgcgwbHjJjpX7ibh
         hy2RdxZgzRUDMeQz2RPtPiJvvMVpgLJfuOxqTLTXTQTBXsL402eLrhS59aAus+uqKyzx
         haGTGGG440xjXKy/XlFnBeZJmZTl0FBhPWq6A3fPdJPnazZyyxNFZ+TgVHQvbjNiHtP6
         uHzlx88qoTl/NyDRLqA1wvNfRi60Tp4XR3Uay85HoU5KpQn7X4xFofoQqTO1iqgz7tU2
         +XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551577; x=1761156377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f61Rm9CXZ7yTPp5k0RnaJz34I/PB/mN1ZqanYu35itY=;
        b=e9lEvfdb84JTn0ab1WsaMUEHMuEUAlQ71qAvPpVcr9qYh/OtwDYclYtJF/6XzW04G1
         6ckId84x4nqw0Q9UYwpCtaVk+PzkeOJSNXB9/d8j4EpBo8A73xGtAQe07aFyL4SocPKV
         Es/tqh8iLs8MNAy0R8HLUw/zSrkVP3VRz/UDCLPjTW0Enm3gkK8SbFf6KEGkzicDgNDX
         LRhJgGKIP9Ksy7NQqZBgEwZ4+Vl7T4GhFr+UorINw14Yt00HN/NmRzhAHGTWDopAyO4S
         5UhtKBDpVMX9mXcBqGbBGYckGMbdyg2mPsFVUJK3/3zjqwZLiiS9yBk7Fm4+YITOb4h7
         VWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPpWuznEG3SuUImPImzER/oL8VRpyT233BTWnGV/h/gOXpvV8x3hzMOKv6NRCZ3oE1tPZbnbYCnFgB41Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYFp90ImersmgAVMK8Eg/BF9zPx0+HbZuE/qAoxMdPRum/BYX
	7HJSh8lTDV/yecJTi/dauAj0fxxazO1vmCSGXCpClRwy5yYQLVnJVfCeotvx6NATkCgmJKWUy2r
	kWCJp0w==
X-Google-Smtp-Source: AGHT+IGwrtYVIxH8yRc/kLwj6t3/4zFQjhWv04zO22u4AAldHuqy2xh4xdTXcqSGmYvfqEyrzff7Eq9esRs=
X-Received: from pjbhf7.prod.google.com ([2002:a17:90a:ff87:b0:330:5945:699e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3911:b0:32e:7512:b680
 with SMTP id 98e67ed59e1d1-33b51106b22mr38107821a91.1.1760551576921; Wed, 15
 Oct 2025 11:06:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:02:48 -0700
In-Reply-To: <20250926135139.1597781-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926135139.1597781-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <176055118045.1528618.11131558125165685639.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Skip MMIO SPTE invalidation if enable_mmio_caching=0
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Dmytro Maluka <dmaluka@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Grzegorz Jaszczyk <jaszczyk@google.com>, Vineeth Pillai <vineethrp@google.com>, 
	Tomasz Nowicki <tnowicki@google.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 26 Sep 2025 15:51:39 +0200, Dmytro Maluka wrote:
> If MMIO caching is disabled, there are no MMIO SPTEs to invalidate, so
> the costly zapping of all pages is unnecessary even in the unlikely case
> when the MMIO generation number has wrapped.

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Skip MMIO SPTE invalidation if enable_mmio_caching=0
      https://github.com/kvm-x86/linux/commit/b850841a53c5

--
https://github.com/kvm-x86/linux/tree/next

