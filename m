Return-Path: <linux-kernel+bounces-893536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34CC47B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 986CD4F495A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98830E857;
	Mon, 10 Nov 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHxxPFoZ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C3258EC3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789485; cv=none; b=hds/Y9JMkglsZRGzY15Dbs3VSN8ZlX2AVl7hpM+wwxgX8vFNwfChWl6HxTLIa06Mn9Tb8EQAERnAnZf5QnT4ov7kxLTA2rVmqeYrxDeGiZMoAQl2WuQn4xpbMWFPIoB22YEm+Yn6oFICffuTx2UvVIJCSQ6kqlzmrsKQe1PhBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789485; c=relaxed/simple;
	bh=bNt2PZljUpkQXyqAV+l9raXMOae2EYPbRP80e8vTOcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HiSMVHHQdQzcxGyovRzFbQThygxSmy9REC9pdaWV1ZrnHML2Kg02FzQSwwJNJTP6UuN8mPF2HJEAeEQkGuS86yrULly/DdJvthzoDkYbPAr/EmFUnLIFIRaXvTxFCD1M10KGtusf8cLFZfQwo1e7/ouZCOzEm2yxQeiX2aNm7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHxxPFoZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29806c42760so35811835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789483; x=1763394283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNvF5/12NI7Kmlyo9BOq5gEtZwJ6DGwEfeo3VaDJ+tc=;
        b=uHxxPFoZDfimZl3wKLKhg3Hyn0VZVm52poy2aiwqsZ2VB2jZm1aO7BVW5PjlOfTe/3
         VvGyYTn27OXpuSVzidzvlSzhON1UmDyzrXnXFIhNMJMzrJYKVsc5W/YmG4XR6Wf7Likr
         CVYlOFuPVpFU9akSy1KgULE0ctjrj0VJZ/Lj/HAK0TtKOS81y/JnbxXtTJMT6lYZ0xvx
         QR8VULZv4mBufxUJj6xxuDZMCancS3zEy4ok4OeYnfiKeILwhWDGkInr+Ei6AXs4fjqO
         hx+fjJ1UF7fIkrr8L9lCIxmaOgSzXFK3S7jmvClQ47Sry5t8/Fr0DyG0ta5JvhR7xOfl
         X9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789483; x=1763394283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNvF5/12NI7Kmlyo9BOq5gEtZwJ6DGwEfeo3VaDJ+tc=;
        b=oTY8j234iC9diKGbtVUp6+NkSs6shv6uHm8sJi98IUa5yX85Je8mh6ZazkM1yoteEE
         zJSNyc4lU4WDR73KdPY87ZuBbq4YZIeq4zcM1bp7MPo1pvRuZCLMBUs2D4eKBf67B0xG
         CsCpqF+49y4xwp3OHNot0X+jlStGDZbZdOmCnt711ZeAUagJ3ZWrXumN/YC/+8nRhsNQ
         RU/9qhuNhUnoh5ZTru9Q+eCIQ0xdDjII5xkG4ln1b7IsC6pREtFu0Eb7QE5yQ1ZbRv70
         SWMhH6VV/+wlRB50ci7bfDcXdY1MyHdx35DdQaEAg96N1sfJwBMFWVMM7YuM5b6vHyik
         5dhg==
X-Forwarded-Encrypted: i=1; AJvYcCXh+Tbg5tjWW8wJlvwKHC8q57s6aA10yKy2TZGPClu/rHlO/f9Ha7yG2rp7Y+42d6tefV3WHgqO/qGOsQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGI1QBeXvqgk5o+o1q1USGOHbgXqYkzPSTSCk7SSe46RfYcRw
	zXVmP7NAX6ing/8vXLsTlU0dANCLUq0RGmccMWCUcMGiyBdmIgLuPm60IeROvuCBWPyNLyPRw62
	9E5VZLA==
X-Google-Smtp-Source: AGHT+IELh7nZC4fHPfancD3LYIl4mtUlqnr7FmYAen6UFOQxRy4XiowaQaog0157dzQxx8WtJhl+aMM0lzQ=
X-Received: from pllt13.prod.google.com ([2002:a17:902:dccd:b0:295:61b:84fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:388b:b0:269:d978:7ec0
 with SMTP id d9443c01a7336-297e56d900emr111842015ad.28.1762789483440; Mon, 10
 Nov 2025 07:44:43 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:31 -0800
In-Reply-To: <20250820100007.356761-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820100007.356761-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176278795912.917009.6888471958480924459.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Fix SPEC_CTRL handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 20 Aug 2025 11:59:54 +0200, Uros Bizjak wrote:
> SPEC_CTRL is an MSR, i.e. a 64-bit value, but the assembly code
> assumes bits 63:32 are always zero. The bug is _currently_ benign
> because neither KVM nor the kernel support setting any of bits 63:32,
> but it's still a bug that needs to be fixed

Applied to kvm-x86 vmx, with a slightly tweaked shortlog+changelog to call out
that only the guest's value is affected (whereas on SVM both guest and host
values are affected).  Thanks!

[1/1] KVM: VMX: Ensure guest's SPEC_CTRL[63:32] is loaded on VM-Enter
      https://github.com/kvm-x86/linux/commit/32ed0bc2f0f8

--
https://github.com/kvm-x86/linux/tree/next

