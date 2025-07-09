Return-Path: <linux-kernel+bounces-723840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE64AFEBA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8515637EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684572E7644;
	Wed,  9 Jul 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2gMGYnW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772042E7639
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069996; cv=none; b=dL5tWFOP3T0MtX1c7l+WXyQIXkGEn+ErLJzsJG7sW5LExM9IsqgGbBOcwlyA2xidnHP8UjO6veVKsgXEcFluw1mNDoZdCd0y8zzc2q54zbVcjv2XWFZJwgkMQ8wojNJMz9RB1ZkwhviYy2Tp2xR21Q/tprzpELzF9hkANojAgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069996; c=relaxed/simple;
	bh=K2ubXN8Y7FV4gsNj9ChZZrRRUrk7boAkqhqP2kLyldg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GPhFuWg5zIOWQEFTxqGJ6WRpLH5H9jIvqkXTXb3sMGhVzSGJmDRj+vlf6JXZeIhrWniG+dsLC8HblAiYX6CwQzRTB1witlZo0dAuuVoFh57ev9bVNqjL2ojF/NbQOndLQ5rw5fLvvV1AyxDp4S6WEPy8JXwlwMO0FBOmi0I1yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2gMGYnW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b350d850677so3618655a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069995; x=1752674795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XipEZY8UbdY2iY2xgScmeGFI4rkvAM9wtVZR86idj3E=;
        b=z2gMGYnWLTEsu0hJjmoi4y0VCPBz2zN2pGqpq6Ce/W/GuNVcYb+ycD5le2Bm7DLgaR
         kj5JSWr57lgVMbPhv8M+VQJv4N+ssg0EDSgBxE/1X5UD522AZdq6MXgKiAhFY7DI6XA5
         5mCePj7tLipVqnK/KgGj2a/KbtRhApemziPtCBCs5P2sDfArVIN5v3zXys8bijWP4P3E
         44U+zAWjITIpPoBPKIPrzHmWpLwmeNeTHuYEta127oYFn7TB6js8CQqk9ZM5hdAuA6SY
         UwVlgN4umDb8g8PXCnB/NfSMLc3Rkooo82G+llkh2MgAqfV5tjLyMllLXCXBg42ge07K
         mvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069995; x=1752674795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XipEZY8UbdY2iY2xgScmeGFI4rkvAM9wtVZR86idj3E=;
        b=cs/zTQBBXG+Ie6tQN31qDr19GP04MwsO4DYyS/8geCHvh/RH31Bla0gnF+hzQq2hVS
         +5uYo9npgtirYjq0nOFBf3cigMqVBX6EWTxXxA3SBTKWEKEo+Z4vjq9Ji4JhuK2+7pNf
         aSODL5NaI8KBAet53skTuElp5A53O/FYRnmM0jEgy08bS6+4OAMUXTOiUJQm9YAubeZE
         6JCwlpiQrVjC7L5iF83If7AxdS/k+wUw/f4Yh/YhY52i17Ksuxgm64WgFeyhuTx6nQjO
         8gqDoQXb6Kdi2XSK+J2wHOHUGWZ6ryL5Zm2iq5EN5K4V1rwcuCVWbg01KElhbzMup995
         adVA==
X-Gm-Message-State: AOJu0YzQ/qH66bZFoGNNG7sc9Ck+BFio8dyvCmGt0TRH5uGnOj3zhW+m
	Ztk4zpERsgA9gDKVsUSy1u4yKoMPtaQxyB9WFPXty6bXr8130CxW4tzZIbUea+S9uqObh1CBLcp
	PVGnauQ==
X-Google-Smtp-Source: AGHT+IF0cjdX1UgdEZi2gM57ZVPSAIjTiT4q1I3Mb4JhgStZQ6TbejjYG9u2HzHUMY6MGxy4uA1F8k/rwqA=
X-Received: from pjbcz4.prod.google.com ([2002:a17:90a:d444:b0:31c:15c8:4c80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c7:b0:313:271a:af56
 with SMTP id 98e67ed59e1d1-31c3c30a79amr39477a91.30.1752069994773; Wed, 09
 Jul 2025 07:06:34 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:06:33 -0700
In-Reply-To: <20250709033242.267892-10-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-10-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53aXD7IsiXBR61@google.com>
Subject: Re: [RFC PATCH v8 09/35] KVM: x86: Rename lapic set/clear vector helpers
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Neeraj Upadhyay wrote:
> In preparation for moving kvm-internal kvm_lapic_set_vector(),
> kvm_lapic_clear_vector() to apic.h for use in Secure AVIC APIC driver,
> rename them as part of the APIC API.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

