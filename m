Return-Path: <linux-kernel+bounces-848736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D13BCE742
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8C619A73C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADC302156;
	Fri, 10 Oct 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="trHLWnrU"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BD302145
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127150; cv=none; b=Gy81MCPh0W/cG/jLjnsLCTrIisFievbug1vWDuDF60snuuYVpb4Olt9ypUFuNIxfhJReRoycHgrpeUy5WGJ5+qOBuWgI/iy5c2R36Fpu9LCs85qinGhDEfANtVVBXoRChFyJ36H6m8sIbA86MS3qFyZ+b8nWXXigV8hlVwP96sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127150; c=relaxed/simple;
	bh=m980w+tV5TADJBSlCBnIfiOVSHM29ZT0tot7S9EIrtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BxVUdcCVGu3ZqPVp3NofNDtAqnkb6LAQWx+6ScBtHF5Fm01yP2xHcRP6BQ1aOo/ju6tIFyTYWvRGJDULqQVrL0jNt5/qEWUYKDxvZSVLPHChjZRpsyOpBNq+Sn7hkGvnt99eNB6bL/9B2m6VJFzlBsRRNHW7+8sGrahGBh9FJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=trHLWnrU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5529da7771so4305950a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760127148; x=1760731948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPLmlw+ZA3/NYclhY1Cnuc9BKdnw5r8GoY210fxSaAg=;
        b=trHLWnrUSk+EetlUwEr3NSIWxyYM0urXQKKx/4Alv5D+o0uTrMsk9/hGuQiDYxVUs/
         56hY6hkYqeAIGeAz3wkSWdRfEm0IEKWnQsNuh4e1CWJ2YSueYZsEM5lSRHMscLJ8/EZu
         PpM2s+Yj46iZOJAPPGtiDsPcyLHg/SxrAKlu1s/QjktBLcgkrVLqxBjDM16+FixiVpnN
         F71h79v+9l3lIq2Sgd14j8tqaVmQaW0YrJVv4WXdMa1jXkZCyBio3RW+OBDF1sP0tqEK
         wxE9rdgI1RRz5gJ1g0H7xpcURbhQza3rjuTYym66b82Gpk4i5ZpALYpKvyQ/6Yvhpq4l
         mylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760127148; x=1760731948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPLmlw+ZA3/NYclhY1Cnuc9BKdnw5r8GoY210fxSaAg=;
        b=qD1Xd9ju34OMgEKDrlwXJ5NPznLfvQuuMXT0o4sdbn9aBieQv4ydszUc6nVVGymcHF
         teF36YCx12oYnWiPeXFh27qkWd/CDXrCAsq3VwJdx0NKa532x71rhVYfR1dPp0omSzTI
         dr+kBBTmhHmSH6log/3Aclh46RUxe/zfR+/aQ/t6+nlles6jMWC1IUgZpmO1pMyUHVa+
         FUy2+dsHxg118xt5xocRJwcTwg4Yn+0Q0W91jI3wyz8/zafO20Xu8sUnIbRke86AYN4z
         NpfS/9vwIHpm+Au6XgMloMUDCxNXjjRacD1Vc1uunaYgisbKa2P4Dj2zN9KIM+p1owcj
         /a5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgeKLC0he+FqBCo6D7HWnu/8dLan3jrvQkyHxnpckJBpc1wxyO/7TEz+UH46BxlucHolnV/xcvkmMbCYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTA8EiwXJvYfsq0WP+L6QEJmxeExv8Yphlng5Uwbndl5fvXgL
	vYIBgbWwEvXrhdMJw8u3LaE/CsIkOYk1yaEFjjsjMJ6HZpQsW6ukDmW8X957HkUJOSuXhckUJBV
	VTwPihA==
X-Google-Smtp-Source: AGHT+IF2N1F+XVoeJoJSDhB9Do7hyVJSgZ2N5bmWu/SeK/fyLFAkCBsUrqlY0zX9LDBKEwCl8at4lgVtrDI=
X-Received: from pjoa3.prod.google.com ([2002:a17:90a:8c03:b0:327:7035:d848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a4e:b0:32a:34d8:33d3
 with SMTP id 98e67ed59e1d1-33b50f608d4mr16202797a91.0.1760127148230; Fri, 10
 Oct 2025 13:12:28 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:12:26 -0700
In-Reply-To: <76daa3ed-4f75-494e-ba3e-0bfcd7a367e4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-8-seanjc@google.com>
 <76daa3ed-4f75-494e-ba3e-0bfcd7a367e4@redhat.com>
Message-ID: <aOloqlm6z-c7NvVE@google.com>
Subject: Re: [PATCH v2 07/13] KVM: selftests: Create a new guest_memfd for
 each testcase
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 10, 2025, David Hildenbrand wrote:
> On 04.10.25 01:26, Sean Christopherson wrote:
> > Refactor the guest_memfd selftest to improve test isolation by creating a
> > a new guest_memfd for each testcase.  Currently, the test reuses a single
> > guest_memfd instance for all testcases, and thus creates dependencies
> > between tests, e.g. not truncating folios from the guest_memfd instance
> > at the end of a test could lead to unexpected results (see the PUNCH_HOLE
> > purging that needs to done by in-flight the NUMA testcases[1]).
> > 
> > Invoke each test via a macro wrapper to create and close a guest_memfd
> > to cut down on the boilerplate copy+paste needed to create a test.
> > 
> > Link: https://lore.kernel.org/all/20250827175247.83322-10-shivankg@amd.com
> > Reported-by: Ackerley Tng <ackerleytng@google.com>
> 
> Do we have a Closes: link where this was reported?

No, it was "reported" internally by way of an internal patch that Ackerley
submitted for review.  I suppose maybe Suggested-by would be more approriate?
Ackerley's patch essentially did the same thing, but through copy+paste instead
of a centralized macro.

I used Reported-by though because this really is a bug (I've been burned by such
issues in KVM-Unit-Tests many times), and I wanted to treat it as such.

