Return-Path: <linux-kernel+bounces-885269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCFC326C1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12EE189DCE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7933C525;
	Tue,  4 Nov 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tjqh/CBy"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB02265CAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278420; cv=none; b=ipi4wFKisgBi3AuPwtbK2DT0kJRuhlvglsUp029fFea4wSt5Lnps4ifdL7t8Wnfv1T7eyiMORU2KlWbLZyDI+jrShzbG5QtA1lmjxVlYikUK3OY7b9kCXghAT6j8sU0iJq+U3PSCqv1yUytYft+AHGhS1LTdkkBRwSrgWRvqv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278420; c=relaxed/simple;
	bh=Y4TUpuiUQw+GzqYKQyfXSEMFi9nilwF7AL4KVO8m+bI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kwqPBYgrioG68TGGCkZ6k0TFr1mfXakXKCSUaw0gKfD+IuxYDKoKVx7g2cHBFGlib11J5ZvHKSn8A9aWGruEq8JeocZI/FsIEbcr3k8LuYnU+x56uWdNpWx7DMANvnX6uW1qRpi2XoPDj+/82XzzyWw1FStN/DVXNvuo1hP+qXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tjqh/CBy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so9468211a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278418; x=1762883218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJYfbRa1skFRmqZg0D90ANzgNEg7u5J9Wjfg+lSYibM=;
        b=Tjqh/CBys5zal9kyhIE7+3ED50/4Vlle3o2FXX5pWYdw7XF6ZUxQ7bfYikCED3fVCM
         avfzH5x3by6Gr+MWTcXVRx+5hL6ITpNi1GD+XydtNO6bU7aY+AGXT7syIkscJF2LOBBe
         zN1ov5BR9nW2ET9ZVqcec4yjwO4MalMTgz5v8NR7V67YKqxCETeSQqdg7UTrMm7Y9tgu
         PD8kAcSicdPKi2cXf5r4DpfsEEVLu5wc1wTRSOJ9BQ+lkSe+N2osTCZ4KsBzFApcZU0x
         CkSc5QF5CHVAr68imi3FfJfrXWYmW0hK/hqw/l2fmu7o9w4y9Ju6QKIsMfjf6gQn/rTc
         GHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278418; x=1762883218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJYfbRa1skFRmqZg0D90ANzgNEg7u5J9Wjfg+lSYibM=;
        b=AbByh79yHWanFkyppGmqIpCc6DAUt3SsC/1jzNy2S9PtP/ijzNXgrw8wE5r45Q+gCW
         uDtn+IwaxX/DGpVGxuqhgSDvLTz6MzKiu6UXE4SWqgPZWeBbglVXD2yJLPpmM7jvBqkS
         JsJy8m4XRZwtuc8cYJTbABhYdE7hZ9DnGFG6Yzss3yGnJ1g2ugFbO68tmaNG7MEMV6YB
         rnAX8YqUaa9p3wRMzhPyWv4zBn+gMtQcBB4GVWp9/0p2MUTwWvQl0K2t72boyygq3L71
         xtpL1PGBHrqPUhL063lCzwePULKcbYeFDwCri1SDuozgSGyJmwat2xAwqjvv8PXkebmt
         0FYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+iRkq/sztz+5Evk499kMrZ4au1svCew1ifC3jm1PtKR1mhhje1D3imVYoGwqg0Q1rdDBapfbBPXRSiWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqNy70wgKfhXeSh3vkILbrGp0UeNcqZcDoo01fG0Xq28cyf3o
	MRCkPnMNEwI4PTwTdlPcECGt8aeFynRtRrgo4Hi0ea+3Z0njgG+eG1pfKMxcsHOpGbloJytjTOG
	7h2BHpA==
X-Google-Smtp-Source: AGHT+IGYxsQvFaY2hHAY1uE3tT9SUmH3z9MYA7vtfwuBlucl6eZbkeKjQCrIA5crD2sXmTLO2ZPmC1CMias=
X-Received: from pjbpa2.prod.google.com ([2002:a17:90b:2642:b0:33b:bb95:de6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78f:b0:295:592f:9498
 with SMTP id d9443c01a7336-2962adb6281mr5015815ad.44.1762278418392; Tue, 04
 Nov 2025 09:46:58 -0800 (PST)
Date: Tue,  4 Nov 2025 09:45:06 -0800
In-Reply-To: <20251016182148.69085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016182148.69085-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227799547.3934766.1180879279941291815.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: VMX: Handle SEAMCALL or TDCALL VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 16 Oct 2025 11:21:46 -0700, Sean Christopherson wrote:
> Add VM-Exit handlers for SEAMCALL and TDCALL as the instructions are gated
> only by VMXON, and so a buggy/misbehaving guest will likely be terminated
> (because KVM bails with KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON) if the
> guest executes SEAMCALL or TDCALL.
> 
> v2:
>  - Apply the behavior only to VMX.  KVM can't inject #UDs for TDX, and the
>    TDX-Module is supposed to handle SEAMCALL. [Chao]
>  - Fix nested exit handling (inverted return). [Xiaoyao]
>  - WARN if the TDX-Module punts a SEAMCALL exit to KVM. [Xiaoyao]
>  - Fix typos. [Binbin]
> 
> [...]

Applied patch 1 to kvm-x86 fixes.

[1/2] KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL
      https://github.com/kvm-x86/linux/commit/9d7dfb95da2c

--
https://github.com/kvm-x86/linux/tree/next

