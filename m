Return-Path: <linux-kernel+bounces-739990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EBB0CE48
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20016541B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C024677C;
	Mon, 21 Jul 2025 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAMjTC+q"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6841F243953
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140995; cv=none; b=o5/4n5rTQj1jZGn1OnhWIBM5OCqz16vMdE+xGDspdw4ncf8eCWd6smUifI/HPwUlEDxu0rijbLGnzGy/asNZ7LEm+6+XM5+kE4iLw4f0X005Wfx45mlwZNV7+3fqBD+Q8j79ECSwUUKg78i711SxzadFahE4LR5j6iA2hPBaFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140995; c=relaxed/simple;
	bh=75dMwOD9AhRAfD3iv6MD69VKM7Uns0ZEiqNvuewGj/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCYpVZq4XfW6BTpWbwjyJjV+jEAR64EXl5Z+fywcPmw+8/A0LE8cYsKVIgxNibqV6gg7ZoWztisnN2Eal5PNwwd98XQ/2AJu88hHGSLHulEjL0zY/EZSWW1IZvYugta5doOCL4UFFvlPS/zglAIOBIYgoCHfmZ3jjYQFFY9EYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAMjTC+q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so7093403a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753140993; x=1753745793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YthwGXG3vj6QbGejtobQA1vVh1doihtlZSxEX69D84=;
        b=oAMjTC+qNJlZAgcNToEI6LxX3pWG2b4W3irkJY8lxXAGcmxrT+nuUojFcLYOyFeCne
         bCOj2nEtlwFH27OJOcix5mQ8KWVzufqkFx2WilQ2Y94Ui0qzYWDlt5CJf6L3mVNZoXcr
         6n+VDZK9E6xqudI3wr3yu2UnBDjgQfzM4cvL0jVa+1V35baDwe8onCU0i9buBOj7SBM3
         /nXypEy1a9RdgkPS0EJ/GKJgjCGmn4YuVvn5DC1aOmWC4F6gkUwLuZbNFEZgnmB6mowm
         cvqQgweJ3/WAacO2B2W8jaDSVXOu4Uc69ZB5MdNXL6mxVNpTe+kd+0xKpVgFrYgDmus/
         gTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140993; x=1753745793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YthwGXG3vj6QbGejtobQA1vVh1doihtlZSxEX69D84=;
        b=Z8PZ8c7OUWzwfkWPbto9tZqd3+dz5IAQUM8qf8//81c0r/H/5OWkTHhtfq2Ro/ds8c
         dPMzsi6/jUiNrK1X3AcnqUbfSBsHzDoh6H1XyhDCMxHu3qv5gT3C7mNIaLxkiySriQ5+
         sEU/xnSl283njACcdIAEjFpILaqtqZYSrWzeFyW5RQgTol1gW/KwHg3qfeTdbTr+ikKC
         0VSeurnnaEc4nqCDn4U4ovJ8N5yMgS3E/AB7aI/u2qS0l8qSggn7TFlNItKjg78DIuij
         vaR1MRcMX6/I0FoWRuVZn13tM8mLby1A+/kCZbICM2GOgDNUU2MwSKNIx/95V1yL/qNK
         iGow==
X-Forwarded-Encrypted: i=1; AJvYcCW8O6J6wwgpRae14677xJUl/5S7UD3KIXK4dVVUHZqm7Zq8GYj9BkUPiS2rd8VspfQ7lTzPpBw8l+O0Oms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgclWIOI0bXE5Gu3bQ8hRgSh7zhNthrdTbEgDz3NQa9He2mbd/
	yxf0T83KOqSbtEhOj3lUMuHZsxAW2NTlO3KIvKXAjGMtYsC++0znu/SDZMKIE8G0cO2TQ7lGHXT
	Hl4WHDA==
X-Google-Smtp-Source: AGHT+IE9g3Dc400fJRZPtwB8je6BnCrNs3sMZht75tqkWzv4R0BO7MR7AIhpIUbUXri1mozX0W2ey+JTujw=
X-Received: from pjtu4.prod.google.com ([2002:a17:90a:c884:b0:31c:32f8:3f88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4f:b0:31e:3848:c9ee
 with SMTP id 98e67ed59e1d1-31e3848d027mr4301574a91.9.1753140993732; Mon, 21
 Jul 2025 16:36:33 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:36:29 -0700
In-Reply-To: <20250718181541.98146-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718181541.98146-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175314043500.309494.16326805597766494871.b4-ty@google.com>
Subject: Re: [PATCH v5] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 18 Jul 2025 11:15:41 -0700, Sean Christopherson wrote:
> Add sub-ioctl KVM_TDX_TERMINATE_VM to release the HKID prior to shutdown,
> which enables more efficient reclaim of private memory.
> 
> Private memory is removed from MMU/TDP when guest_memfds are closed.  If
> the HKID has not been released, the TDX VM is still in the RUNNABLE state,
> and so pages must be removed using "Dynamic Page Removal" procedure (refer
> to the TDX Module Base spec) which involves a number of steps:
> 	Block further address translation
> 	Exit each VCPU
> 	Clear Secure EPT entry
> 	Flush/write-back/invalidate relevant caches
> 
> [...]

Applied to kvm-x86 vmx (again).

[1/1] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
      https://github.com/kvm-x86/linux/commit/dcab95e53364

--
https://github.com/kvm-x86/linux/tree/next

