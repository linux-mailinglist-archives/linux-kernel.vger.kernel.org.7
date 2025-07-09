Return-Path: <linux-kernel+bounces-723834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F948AFEB98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623AA644D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854812E6121;
	Wed,  9 Jul 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FInAPt6P"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D302E54B9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069931; cv=none; b=V+bIHhefYBSMGuy/j0Zafn0ADWj/S4MGUFJGaNp9YFtkANaBef8Vy3AmxuUNBk2ZRepVhYPVvMLQToAwGkanqeoH07NCTqZIl0Wf/R6L6in41KPuWvoB1VuFWdZrTY5Ly4qLN2Xg+8RBu0XxJRHGZyf+CnGVn88EyAWuLX66kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069931; c=relaxed/simple;
	bh=eq2R43olCt0mKXS/nYv3DiTFOYuZYuJTp2jSSttHiUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtfxKU7718FN5rvjoA3bV5j7mP6SBD9+DWW/F+qYSyD40p8749fj0BANBvIYxQdgrP63dremewFe5AHH19owCzWCKeOWDZqSAooSjZ+RxyFpzZaya7A5AxSpoVUJrnZmDLI6qOOumpfURSYAKkqXki7+aKqDgPiilorQKeGSWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FInAPt6P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313f702d37fso5080527a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069930; x=1752674730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsCibf9ZiHjq4Pe5rKeumNvzDYZj4QPD/ApNA1NCOCw=;
        b=FInAPt6PebqJ9ef8vABkOy5Xeg58J2xs9Q+Sd1dUGn+PtqJ3s2m8cPeqoj7mTer7Eg
         ws3Fn/G+KDFBU4b1umz+UBh1hmV+jz049/nqK+MK9J8JpEgKeC/wbv/aFgO3mFIoUjg1
         cTGcByueOBpQybsTOn7cobfGuZz6xJUdKrwXIne8KmtHuVUGJiXTowUAsUQVHG5CYohv
         Pa0XZ5GlD7rx2SX72bOJJkpHOBCZxwy2uD7zu7Isikxs6TZBQ0/c+WDYr7aHByMCB7a4
         Xm6nlShDEGsgIdzQq1/wJNr4lgWfoFBWk0QbQmbtiKdKUXQT5JdoI3MEATM8iiKsLM96
         GLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069930; x=1752674730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsCibf9ZiHjq4Pe5rKeumNvzDYZj4QPD/ApNA1NCOCw=;
        b=ICWn1orb1sgdbxiuswhpJuMfqL5bvyJFJ5MkV1WgylX8qfrtSSXzjCZKsMYjrevodg
         DlTEkeeK50nEhZOSilUXkdrU5NWL4yaDL6VALJTfkX3rOkREaq99fy90cCft1iqn2zT0
         vc/X4+C3t5V4K4WHOz5dWm3m6Zf5uAMaUrM2rHvRz/0KIzb0Eu93boMtXHLNHhKx8bSv
         d1um2vWGhe2J8thWiYzlwhQEjqsOWwqfrp14K1qjAhlGxUYooX/zsXLKb8NVXZjzJ9W3
         MU4W7anyOJWowKQoGBxCBDJ3u/UEQ4YCtkSe3DKVnsVtMpTAhXopl2mZyW4tcj6JEG9T
         w5oQ==
X-Gm-Message-State: AOJu0Yx8fFFZKjbcjqHw0ZcJbD3QXRDqzXSyUbPCQP23rgG6DFSfgd/W
	qCwYHnDWgj/OtsteEmd97tdAg2j1hsQjVzqOl6gfuozETqVoSHH03gahlfvrLHwe7ngEzRJwVOg
	6NfVYdA==
X-Google-Smtp-Source: AGHT+IGQ5D/KnPA32Q6AFPnHQBathUdZ+hZBD+fS7a2lhu/QJjnqKpQX+yGZ6G3vlqm2nNTZxCg0N7ZaVFc=
X-Received: from pjbsd3.prod.google.com ([2002:a17:90b:5143:b0:311:c5d3:c7d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3811:b0:313:287c:74bd
 with SMTP id 98e67ed59e1d1-31c2fdfe649mr4678804a91.33.1752069929821; Wed, 09
 Jul 2025 07:05:29 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:05:28 -0700
In-Reply-To: <20250709033242.267892-5-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-5-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53KGcx4gq45SRA@google.com>
Subject: Re: [RFC PATCH v8 04/35] KVM: x86: Rename VEC_POS/REG_POS macro usages
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
> In preparation for moving most of the KVM's lapic helpers which
> use VEC_POS/REG_POS macros to common APIC header for use in Secure
> AVIC APIC driver, rename all VEC_POS/REG_POS macro usages to
> APIC_VECTOR_TO_BIT_NUMBER/APIC_VECTOR_TO_REG_OFFSET and remove
> VEC_POS/REG_POS.
> 
> While at it, clean up line wrap in find_highest_vector().
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

