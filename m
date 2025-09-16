Return-Path: <linux-kernel+bounces-817944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27238B5895A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7836D1B25DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F221DE89A;
	Tue, 16 Sep 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLsIzofy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF571BD9CE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982503; cv=none; b=iIJgGiVvPkFBE0a8DD5HDt+CNF+wCiSOyhTuKrPS4y2glAj94vyuUBFLBPkJ+GFd4UHV0Ajj3DwzLB3AAwdbUAxmrfnhoCOBbGjISWdr0PNo75JPBlxsN1aWU6YqdhJgyam9l+tTbvA0vXJzEIBGkW8J9vZ2lPLpjB78BkmoKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982503; c=relaxed/simple;
	bh=Hzku54Xz8F3o3FaR02WNtbqHu8t/XDsCXNVgraPSj5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgIyHWhdHSLEafg6vL3WQx+CvA5I5gdjfsSmHHZlczd4PviXoym+GHiUPc+nPGFjGOPEICan+ZAnwfg97Yn60Q02M+NUi2g7RFs0n5ds3qGUy5TwJ3uMsd7RN0zbmQkeiJ4iizDwrw/D2O6+TGYxvTqYDH/EjLMGv4P0yhqf4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLsIzofy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e0b00138cso2399224a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982501; x=1758587301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AOkv9hGsWVXFwku0Pf403WUz7STeDqn1uZn/dDK2wQ=;
        b=uLsIzofyDcuExTWu8ZaLXt4dwK8WVlRUKjHb8BCMLT5kqrPVZxN4JQyb1wxG5neC5m
         KzG14cVo9R7DSCgqk7Cy1aU4r8GwXiLpCafc0Do2bdlV+QEufufBAOB+Etsg593HLPOT
         wTPDE7VHvHdd2GY7vxEEmPl4XgovHC7lf8ASM+Y7mr5qF6u1Oh8zQqtwBnhScrzB3OxA
         W9wtRUP+XmdV9lLVdnu6MSalJFe10Pto+z9x8IoCPr+ZyBJOrgsGsB3Aosn2L2zmip5F
         MViWaq8CUvayDKpTY+jfg7arKaTOhzhxc34bCXZEmGyx4J95ZWme+atckTqAvJT2RsoB
         2i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982501; x=1758587301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AOkv9hGsWVXFwku0Pf403WUz7STeDqn1uZn/dDK2wQ=;
        b=H0FEplH93S02nXt1yqhT7S4DBEY7B1PSQTrbk9i8iQ59GbD24D2pxWpVskoZm91irv
         P6kaHELCv3hy9yRIEFPJu3OLo8+iBMz1QEvR0BdmmKcwXdzbh2Lmgz7OCgkKgTyjrcty
         ZcxoGPC6TsaB/9LInfU6aeNxIrtgpU384b9JkVWEe34m0STLvCsE9uvK84zVjEZ8w5f/
         dl5hWrPti3Ptmom1GHaUhqO/bQKNWo7WI365hmn4FOfjsAVpEMtAAjeNEoF58dzqCTKJ
         R+tPWZHVRACNk7KPUl33SjW/LPjgRyQ7EuzGL1ixC0XNhQ+uq4PiSePdac/i/n2xZ0oO
         Rkvw==
X-Forwarded-Encrypted: i=1; AJvYcCWjZdYEXGGocTlqEk/eMR0xlseKXVQMmmJQ3yMbi04iJ9XJkMMXlXKpmQwiwuQxCwEvNGiJisHj/O0Mwsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWH9gY0QkFeiHw0Yps2qCWfh9dtpspsoIIn7n3FDbIpfC8W8Ux
	tDOCa/0NoPewq6n/b/A2gMEBDrGvWRYMn2mvGh9cwihl6oCJzlESca/8wKwR4X/V6+b1jn72U3X
	F/t+EkA==
X-Google-Smtp-Source: AGHT+IGQDEFWS3Y2K8qFkgjTf02yLfsVnbvTS5K/L5DS3VHz/kmL7yZiceoeOwoC6WZrcEtMLZwCDaXUGjM=
X-Received: from pjbsz5.prod.google.com ([2002:a17:90b:2d45:b0:32b:6136:95b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d06:b0:32d:e780:e9d5
 with SMTP id 98e67ed59e1d1-32de780ec01mr14229784a91.22.1757982500941; Mon, 15
 Sep 2025 17:28:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:43 -0700
In-Reply-To: <20250905174736.260694-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <00378f4c-ac64-459d-a990-6246a29c0ced@infradead.org> <20250905174736.260694-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798208800.624836.165612810420047605.b4-ty@google.com>
Subject: Re: [PATCH v2] Documentation: KVM: Add reference specs for PIT and
 LAPIC ioctls
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, rdunlap@infradead.org, 
	Jiaming Zhang <r772577952@gmail.com>
Cc: corbet@lwn.net, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Sat, 06 Sep 2025 01:47:36 +0800, Jiaming Zhang wrote:
> Thanks for your feedback! I have fixed the grammar and put the full URL on a single line.
> 
> Please let me know if any other changes are needed.
> 
> Thanks,
> Jiaming Zhang
> 
> [...]

Applied to kvm-x86 misc, but only for the PIT documentation update.  The LAPIC
ioctls do muck with state, but unlike the PIT behavior, KVM isn't _just_ strictly
following any spec.  The LDR fixup is arguably KVM honoring the architecture,
but the ID fixups for x2apic_format=false are very much the opposite of what the
architecture says should happen.

I honestly don't know how to document the LAPIC ioctls, or even if it's worth
doing so.  But that's not a reason to hold up the PIT documentations.

[1/1] Documentation: KVM: Add reference specs for PIT and LAPIC ioctls
      https://github.com/kvm-x86/linux/commit/3f0bb03b9db7

--
https://github.com/kvm-x86/linux/tree/next

