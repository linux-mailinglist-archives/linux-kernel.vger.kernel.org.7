Return-Path: <linux-kernel+bounces-776645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E6B2CFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEC1799C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22426B742;
	Tue, 19 Aug 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUWBSJ1S"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8522FDE6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645502; cv=none; b=Sta2OiRJXggd1ShDQhBiANRNcGHnRkv3zhoknCqcAoS2RA938/v6m1krTBXy3FhaPgQSmbyKoUaNyyULfBbXkSG8aeq25HVYyvciEKw50BaGGFn8mxteuOYw4pWib/LFkJnhJyLCNYGjdbLzdyWvyu/7XMiEHqBUkU8lEz0DJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645502; c=relaxed/simple;
	bh=lVXQBqnqbxpFe1IjAlD49yL+k/R3myhx9rjbCNek3Y0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvZz4rEBoMyACGOmj127D8My+ZqBbqDi0xSgGrkJbj9bkOiqCzhwMFhtYeDbZaZK9qTwHzZrQmwfkGl8u7qG01a7USD1XqRZ4S7gy9jAv9k3zOPJ0UvjPy24XZL8cGKxNrEhCnux1IFt3Pa/kwCkaiZ6XkNJAMF+MGmZwQJ/kIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUWBSJ1S; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445823bc21so145687955ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645501; x=1756250301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rONFSpHM+4UT9RUEpdOXX+LBPAp0V3YjAVNh2Y6TMoA=;
        b=LUWBSJ1SCYZwp5KvnodCzvgtixetO/uNManEEbvcOged4m1cs5wEi0l5oZTFEJOMha
         s1CZKDlvFVFk5LfI6Tn0d0KSaYJQMHu2sMBE0IODBOugz70fdAbIIPEnFn+CUrQviU/b
         vzbOfsqcDwNcrY6dmR7v0k/2WXSxvO1QcqSiDpYVFNbe1bTMydv1qL9prWdagRe8W+83
         0UA8gd/WN/imPYZTCxEuuXinlf8RzN2MLbqjey3Ehu0St6PyYTZ+0eZAD7ZHYTWnPLP1
         CvRSCCG6N80uCoodfsRc9kRJbX0Ks5xn9oJ/IfITjnamJDjQT+m1IJeOUagRvdJHtvGY
         Cchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645501; x=1756250301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rONFSpHM+4UT9RUEpdOXX+LBPAp0V3YjAVNh2Y6TMoA=;
        b=V8xZT0wunjtZLbsL9Y3qOgRrmD9ws/++Knb3ZNmhyArUIR8irB4ccUg6mEsXWeTTA7
         bNAXjIFlKdcoVWUpzN9GVi+OOe585cEQb+vurHbbDvSaJ8cWxT9js47XP3LW/nn6sXpi
         3hXlN+JNFYNGcgit+E+NN5TO9DzcQyP1xIiBI+5mqGOwrM33Cd6F65Qp5bmTJyjPa5/Z
         rfFjlIxWLXl/UFysw3S7Mp3mlBpjlFTwPVVgMYFbh6Y9CU/146ZGwCD0BDy3a3kwjS1w
         YRFYXptlhmKK+hI4Zbe89ysIfnl5+Tisl7rF8+O4TTxHTDtVEucjfnmVIIUsHm4S7pZR
         Ldaw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ujscnZMnrijO1Q2ZtvUH5+dRh6E2gQUow13lfSruqPyrsyMwJBB4kyTiifbHHWNUbvVJDEGywMCQmc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/znoNSzLAyqvFPey0wjj7aCPKDonRRabqT3jzaWVpXP5mITb+
	uL7tYdJxPIEC7jDon1aNgYdwElG4euG3sRvhK5qDZu/op6vuN3zFcx5Z9dI0KE1cwsjVeaQ75Qz
	6lpoRrw==
X-Google-Smtp-Source: AGHT+IHqe32KfT6dho6aCFJ3G/d8VrXeyydbRiGHvGnmJfWMRn3n7mFQuRV7TKc7F+1F+ayU2D2GFF3pcFw=
X-Received: from pjxx12.prod.google.com ([2002:a17:90b:58cc:b0:31f:4e21:7021])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec7:b0:240:1bca:54
 with SMTP id d9443c01a7336-245ef1e87f3mr7883665ad.35.1755645501030; Tue, 19
 Aug 2025 16:18:21 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:21 -0700
In-Reply-To: <20250626171601.2293914-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626171601.2293914-1-xin@zytor.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564427331.3063305.13126467496293838105.b4-ty@google.com>
Subject: Re: [PATCH v1 1/1] KVM: VMX: Add host MSR read/write helpers to
 consolidate preemption handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="utf-8"

On Thu, 26 Jun 2025 10:16:01 -0700, Xin Li (Intel) wrote:
> Add host MSR read/write helpers to consolidate preemption handling to
> prepare for adding FRED RSP0 access functions without duplicating the
> preemption handling code.

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Add host MSR read/write helpers to consolidate preemption handling
      https://github.com/kvm-x86/linux/commit/65391feb042b

--
https://github.com/kvm-x86/linux/tree/next

