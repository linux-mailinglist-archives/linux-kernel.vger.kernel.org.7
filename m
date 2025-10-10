Return-Path: <linux-kernel+bounces-848811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F3BCE9E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD0C426C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5BE302CAE;
	Fri, 10 Oct 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYbVRhIn"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1749303A0E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131851; cv=none; b=MVl72XCQXw3pE/Jj5gXyDOxSQ1LtWFj15z5sC4foJr9AqLLia7r0TM491Atsa+jHdSZA19A0eFyRdgoV34WbMzwUs53uPWwzy1O2AEaxg+9RbCgdpDexAHWB8ccck4q+z7l4HFPRb2BAgpJLyazWP8tWrwKW4s0SREpI8YmlYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131851; c=relaxed/simple;
	bh=x8ZdD9t8xaKyanN3XNVD+r2/6u9tMr0Y+7qjId0Z1kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DByhSamef4DDCwx//Ful3IFv0+maFmGgRbVztx7cvzxUECcEDTiTwbTJA4qfr0iqOyi4r6aJ7ZGJ9n1bOP3BSIz981VTMYDS3ACOtNHhHh7sLCtg7UXRVK9aHHWXKfKRWiZknotMulUqesN8BD7dzz1kZpWvP+huFh2upfiPqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYbVRhIn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-268149e1c28so73082245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760131849; x=1760736649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EL7WGjbXjGss0nIK+61duSt+Dw39EYfognGEJJFlik=;
        b=oYbVRhInqgq18OMJSlpNIK6xXgyZU5lspp0gO3E9ECvlppFs3s6M127qJHEk8DoMXe
         uaSVFLA6FKtGd1tiZefyhclq6HOp0Bvxa2xMt1aIb2Hk8I9lSOzinOhTnP1WyiMfU86k
         sM4u2CBKs7cpIlRkNOnyirtewa8fAMtTfnnk9hTWcoyrKfl7/XmohJq/avbKsdZFFsyI
         DKwCQqlFHioY7/7NsMCFtzZYrWzt406sUFVfWGqCsxYrXrOcCdeZV49QuXFnwZAlqrdK
         ogi83FdD+9AWTRCKTPNWMSbIvQkWjisHLYj5WaBnoZbLudOiNTkdGzpIj8dHKtCvqTbD
         YlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760131849; x=1760736649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EL7WGjbXjGss0nIK+61duSt+Dw39EYfognGEJJFlik=;
        b=d1/jcSY0RzpVtVDFTAgIXjifbfM3LLTL+MloNS4zeulwU6ST26APiTaSQpKg+CWRjQ
         nVIqKLaii1pUOX/OwH7MFJLS/jqtiH6ddgzr+AgP+xpVu467FcV3pQYnEVDQujU8XxlR
         gHbsiZe5xt3UTe07Qd+Ra/falMImeB/hhd4Rt1llq6LTLMRzb3hON5sBX8bXYbetW3f6
         WYchVxBB20Ij1qQfnqWOw6EIQGElFYNcw16NSkpqgQRtth9AqUGDWvrGFoPW52NpNVMw
         b+tCMV5R+CwW5VqegkPfKcXxxkokR1pRMHIMYZ3QgmcS46IaV80M1OC/1CWi+nvmoT2a
         AwKA==
X-Forwarded-Encrypted: i=1; AJvYcCVSPJGVCHB6lGVWs2hGkIKAKb/mmluq9oUka52d8VL1kggccxlcSFQG2H4etMaScuot7I+Y8UOqIISf17c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/aXAEq2hqxX0aCmAHW7nTYc46Zf+X9Jp5MNJ/SLA1KoAOdUR
	zQVY9KQ7v4XpxYBXaqc13Mqs/F+zmRW8rcf6QXTXatHYH67JYaVT5NyL+TIwxcaEjpKfEwf57Hb
	UnvWgqA==
X-Google-Smtp-Source: AGHT+IHhbLvCYGsBh6ODhMnEDvAuta6cPkH1KNgVvHSQ9KHYqVszyeRaOArV3kO5lGiA3vXVq/dSXjWdUKY=
X-Received: from pjbga18.prod.google.com ([2002:a17:90b:392:b0:32e:c813:df48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0d:b0:32d:d5f1:fe7f
 with SMTP id 98e67ed59e1d1-33b51118e6amr20842431a91.15.1760131849296; Fri, 10
 Oct 2025 14:30:49 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:30:36 -0700
In-Reply-To: <20250924174255.2141847-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924174255.2141847-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <176013138845.972857.17974431872471984207.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Test prefault memory during concurrent
 memslot removal
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 24 Sep 2025 10:42:55 -0700, Sean Christopherson wrote:
> Expand the prefault memory selftest to add a regression test for a KVM bug
> where TDX's retry logic (to avoid tripping the zero-step mitigation) would
> result in deadlock due to the memslot deletion waiting on prefaulting to
> release SRCU, and prefaulting waiting on the memslot to fully disappear
> (KVM uses a two-step process to delete memslots, and KVM x86 retries page
> faults if a to-be-deleted, a.k.a. INVALID, memslot is encountered).
> 
> [...]

Applied to kvm-x86 fixes, with a massaged changelog to call out that it's
KVM's retry logic, not the TDX-specific zero-step logic that is being tested.

[1/1] KVM: selftests: Test prefault memory during concurrent memslot removal
      https://github.com/kvm-x86/linux/commit/1bcc3f879127

--
https://github.com/kvm-x86/linux/tree/next

