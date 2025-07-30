Return-Path: <linux-kernel+bounces-750767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08937B160D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625191AA134F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8539298981;
	Wed, 30 Jul 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQX9IwjS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164E3594B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880230; cv=none; b=Cl063pKQjQ2EoKufUcJF9xfdfaNJUZFCx8gQ59TkoLfydPLpJ6gfncO2u9x1GQpS80vEfkU39XhC0JZGzpJFfSyXLKAV8zkT17s0IPGn+kM8b2liJSKXRRJNIHruL632ls9cX1TzEH7jTMsV76vpfaA2YRBD3/fdlYL2uqmpAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880230; c=relaxed/simple;
	bh=tbQGkXTx5N8cfzBhsKZ6O8byb9fUPaWpLKuMOPkynhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJpYASeqwgabJgRRqCWzRzxDsIOi5Sx5bVwSjjvcRYUA2KwOkKtDjsUo+dgaETHIXKKT9iYMpoPDidrutbe3RPl1coMC3lNbro/InnZBfZ1eC/8OI3HBUS/tU7H1oSEYHefwMqPPfkEd+ARnCPeNUQPyAvyjRq1uaGcA5qgTZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQX9IwjS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313c3915345so10676865a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753880228; x=1754485028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGJERRSxIHYm/D7qRYs3pk5CzuzrfI4TxpqJDm/o52E=;
        b=HQX9IwjSSz47AyaW5Je9MwpYr7KdHq4RVoerhjh9OI1HWyaqkBxYjEY7kEWQyHFghM
         wIauXsGeYO9wz3nyumLj+Uea3jkMjB2GKKDDaXsv9lu/oyvvky6KuxjQCR2sX4t3SEPf
         C5oAFww0wKTr/dpAfY/55oy+Ed5T0uqQhC8Khin8e1DN0oYJ96q3orNlDfYC3ssuP7O+
         71EynRwr1aqf6BRxPLS5JBmVroEORr7RVotKrhxBKN9AYDN8a5bmoWSETbGHvJ4VS272
         wr3v8Irrowbuprdlge2dU7g3IKJj5Mf0A8b5yXQ1snEgdfxi+1QF8x3SQTAjyd+mEad0
         0SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880228; x=1754485028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGJERRSxIHYm/D7qRYs3pk5CzuzrfI4TxpqJDm/o52E=;
        b=oRny8EaOtgiCLZ9kA2XHWNnQX5BACbUwQL2dgtGCK5cdV1MtXm1I70DjIxNb9QF7h8
         TqpBhmgcG4KMGPqNRT+xWYGfD30cdBPJdudJKt4jkkmvCJlwSsLEVg2eOlfJZ5HF19V3
         781yzmVaNPAzavUz9I7Lqox3sAon+LUaL/EdRnpbWfI05XU5m32GD8AsqC8SvqokM1Uu
         +M/SdgfFziwkcNwNUum/tunIukfI9fP3t0V9kzidcTFHAXgjp+ylvNTYa8IvMXKQPftz
         F5JNPyyZnsN1POqlzjikUCHsTHruD64sUSxbxPmJjAsDCFBFXuKAg+p5hKKnfigfvjs+
         8OJA==
X-Forwarded-Encrypted: i=1; AJvYcCWVPNPU19cjk0pMvVhUFOjZCquoUW1DJxLQGaSGgX0840gfaC8nQSFy1QEPOhjCGJ9xiPQoVvFfauiQ4gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznG4/JMNiKINpRiAB9VQuynbPlYtCAJg3W8TpMpv3BJ/7Hecvn
	otlUQ4Y/JWtbS65mxQniuTaph4W4xkn3c8Ey7g35W2OxVJ23g7ed7XMEBKYTOvTplOkm0sZmDFb
	P7OdNvA==
X-Google-Smtp-Source: AGHT+IGTVzSY5NC9djL4t4SYCqSM0WRzbgQXc+av5XxWfwIb706Wi6fuHTkYD9Th8LKmbEzDjnpm2KiAEQI=
X-Received: from pjsa5.prod.google.com ([2002:a17:90a:be05:b0:313:274d:3007])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3948:b0:311:fde5:e224
 with SMTP id 98e67ed59e1d1-31f5dd8ce1amr4347975a91.6.1753880228258; Wed, 30
 Jul 2025 05:57:08 -0700 (PDT)
Date: Wed, 30 Jul 2025 05:57:06 -0700
In-Reply-To: <856487d0-8e1a-4e64-a8e6-13977fd31fed@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-24-seanjc@google.com>
 <856487d0-8e1a-4e64-a8e6-13977fd31fed@intel.com>
Message-ID: <aIoWosN3UiPe2qQK@google.com>
Subject: Re: [PATCH v17 23/24] KVM: selftests: guest_memfd mmap() test when
 mmap is supported
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 30, 2025, Xiaoyao Li wrote:
> On 7/30/2025 6:54 AM, Sean Christopherson wrote:
> 
> ...
> 
> > +int main(int argc, char *argv[])
> > +{
> > +	unsigned long vm_types, vm_type;
> > +
> > +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
> > +
> > +	/*
> > +	 * Not all architectures support KVM_CAP_VM_TYPES. However, those that
> > +	 * support guest_memfd have that support for the default VM type.
> > +	 */
> > +	vm_types = kvm_check_cap(KVM_CAP_VM_TYPES);
> > +	if (!vm_types)
> > +		vm_types = VM_TYPE_DEFAULT;
> > +
> > +	for_each_set_bit(vm_type, &vm_types, BITS_PER_TYPE(vm_types))
> > +		test_guest_memfd(vm_type);
> 
> For ARCHes that don't support KVM_CAP_VM_TYPES, e.g., ARM, vm_types is 0
> (VM_TYPE_DEFAULT). the for_each_set_bit() loop will not execute any
> iteration at all.

Doh, indeed.

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index b86bf89a71e0..b3ca6737f304 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -372,7 +372,7 @@ int main(int argc, char *argv[])
         */
        vm_types = kvm_check_cap(KVM_CAP_VM_TYPES);
        if (!vm_types)
-               vm_types = VM_TYPE_DEFAULT;
+               vm_types = BIT(VM_TYPE_DEFAULT);
 
        for_each_set_bit(vm_type, &vm_types, BITS_PER_TYPE(vm_types))
                test_guest_memfd(vm_type);

