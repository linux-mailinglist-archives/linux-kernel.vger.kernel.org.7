Return-Path: <linux-kernel+bounces-893526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E5C47BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C18425152
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27031A055;
	Mon, 10 Nov 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J80sQnt5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20325314D03
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789178; cv=none; b=JIxQ7IUls6r5uu8pgbYJIfyZwLHzX4KKyE/3svZY2Tn4BLUZPRPdLp2lm7SAYCJiKXlEu/mAEBp9v3jzKd1G9zMaJToGARTRKcPEldVz7zxwrhNkt1p2rk2Gc3lelQGPvJ/LcIB6VvYu+j8yTmFJLf3GrZO/hlpg0i6DhJaZSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789178; c=relaxed/simple;
	bh=HLqpw9OccrvyzVMI8pr94sqlLBqJLI8wM/NU8/1R4X4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYIPTXmZODYVf5XAmHyt0AI2BjhEpT2WL515/IA8Mtvxneu00ZlDki/p5jCrRg4tc1M5FSAq46icXatzHEtnzVb4e9mIIYI8TbnLrNYhr4WZ0UMOlNdCXbaLM0bcxgL3SxIUQJC9wEcFxHOEJxnLiEkmEB4WGvJ3fAcgTzC350Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J80sQnt5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b8f8e1f1044so5120211a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789174; x=1763393974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxV2BK8QKnCiH1AuK2g4amllIFkIURPoopgCW0Ha0PY=;
        b=J80sQnt5gziIRbw9fSifeRn8BYIsf1jg4gw6ZdmS9RIw5840ZKkrW7sfEfxeCiIoPO
         8OGDzuc3vvVtLbGrcMvxkIcqwwa1TBPyn4S9bGzjrLRnP5r62KK29Vb/pFLGRbtT8gj9
         C7C5X4cANXIPEeIOd0HmXl9JULUpX67Ncnfq3jXAJPOgS0wVi1wrDbTXHSbhuFZPzvuX
         fSB1TZDH9+v232CESYGHDs9KntKyzQV/pwkuUJ0H34CXCaPMFFneDtl6cA1rE0INC7xe
         N31upxXcVF00QY7vKF1xMz2Loijcxowhnt52P+Rr9Na9lU2wTBXPfoFo0XmD8vAjNEks
         rzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789174; x=1763393974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxV2BK8QKnCiH1AuK2g4amllIFkIURPoopgCW0Ha0PY=;
        b=fnb8s5zyX1PF/LlSFJWF/WAXDbAYG4R05WhZGQz/Ez3AT85eff6ul1LFc+tMZZr408
         I63B+y7NMFXF15Kke9INdEBWFREN0JUGf0o4IzpnkUPplvFkwfweQco9GbcBbBsSqNf3
         fIyrwFHR7u7chUlS9ErY5+prmb/pPPZ6x7voXhCQiak6NvenrOQFhq0BJUiWvk7aqMxP
         A7O7yqE9oJEUQt4XkZzMUJyxiG9C7vnYU3VS09nY+jsmtVonKEWRLeIPqe7UTxntPuFc
         3l8bdqsbzrUqs+M0sv1m5PhmqfLjMZF9iQWN1M32kEm53WCSeafTvz4/gEjxiai8ICMY
         nQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCUlTqzo+WOViIURWWN/7PMuhRT+4oN7j9XUnyc4KTuG44Uhfme+YrlP6P0YODX2wPWWGCIyy2JodvaGbao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuptz73x51qjQHzxbaW3RURTDc2MkXlnoZxCIBByNXh/kfSkcM
	ND2c8OrCQ8yzbUVqFwP6zog87/n9K+9WJCLl54/Y+JMmfgSdh+USGw4LBtJBvn4YdABLAZJ2s4D
	QNKMqmw==
X-Google-Smtp-Source: AGHT+IG1WjnuFZxaKrB2Uz9FQb9ICjT0M8KZd2b+Eh4t1Ia5GLPxzkUDRvJD7JP0d2vdeKv3tjb+ORIQYT0=
X-Received: from pjbsv16.prod.google.com ([2002:a17:90b:5390:b0:33d:98cb:883b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3cc3:b0:33f:eca0:47ae
 with SMTP id 98e67ed59e1d1-3436cbc9a33mr8936483a91.28.1762789173839; Mon, 10
 Nov 2025 07:39:33 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:25 -0800
In-Reply-To: <20251106191230.182393-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106191230.182393-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176254226343.805329.8193068148325939353.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: SVM: Ensure SPEC_CTRL[63:32] is context switched
 between guest and host
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 06 Nov 2025 11:12:30 -0800, Sean Christopherson wrote:
> SPEC_CTRL is an MSR, i.e. a 64-bit value, but the VMRUN assembly code
> assumes bits 63:32 are always zero.  The bug is _currently_ benign because
> neither KVM nor the kernel support setting any of bits 63:32, but it's
> still a bug that needs to be fixed.

Applied to kvm-x86 svm, with the comment fixups.

[1/1] KVM: SVM: Ensure SPEC_CTRL[63:32] is context switched between guest and host
      https://github.com/kvm-x86/linux/commit/c331b400e291

--
https://github.com/kvm-x86/linux/tree/next

