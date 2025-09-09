Return-Path: <linux-kernel+bounces-808562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313EB5019B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325297ABA39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548C3570BD;
	Tue,  9 Sep 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUaN4oAc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41550352FF2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432066; cv=none; b=Wf4h6r0Di/23/rscEcFo4zVZM0+e4tHZnPaNFpHRqwz2xlej20yufJ1QyrgvXC1lymXFA7i8ozlwd5KgPv1LHlrRGfmy9AdOGcuMHlFcQ8pTDhcYWbULHEhxyvFMVzFCiThyC+QPY3aokGUa2MZZXx3GFhQBT5JtlaUwunZG0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432066; c=relaxed/simple;
	bh=yn2bOh0B0Zx3GkzFvepDHj8pJ2ij4Q0s3nI3qDvTNYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YAWJZaPhUQ9t16F++UPKWs+DuLEShJTm4CF7DDIYLKChYbsr6W1rQ0rHaDs6xXrOrI8H8CtIti5/+k/ypQtLxLZVmkltqWGQmvcJZO1TNyHKFcDa+YRYn9B/1gq7J1WAGJx0NBn4Ili/6rh3uKbL6L7axhBB82maBYuafOzCC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUaN4oAc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60221fso11374098b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757432064; x=1758036864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiRBBw+bFoLEBffFJrRthdXKHEiu9VDNF3NlsubTtkQ=;
        b=MUaN4oAcpMz25eFJC7RUXz52xJEf8onsp+L5U6VOq4o+ouxlzzSTvLYNn3lMroB6QS
         THqAuYDcgzTaXgEKjVyPES1FoQ2HJVKTiCBm20qhbIH3sVyzgxUPX6qpelEGjOWd61Pa
         pJPElCoAe4Yl8WFR+BHTpNUQhN2/mknIbiCd0JLN9WORgzczZTWALiC0oyzCZQ1MNoSQ
         7GIMmuUuuoFUxNQiUZCsfseVSMD7MWo8CKgfMB+YB9dRNA5RU2l4Mku8bxrwDbDv7iBz
         1j37CBY4/9ZrXbkZPZkL99cE5GW2PFnK5fsQ5yWZKF5f43OYcQDrEydk8MbUxD+aAVEO
         4r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432064; x=1758036864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiRBBw+bFoLEBffFJrRthdXKHEiu9VDNF3NlsubTtkQ=;
        b=IxwJ5Pdu0TWi4Ld3xDqxQooyesIApCYF069oFDdF6X8ljzKC0BKlcB2WQPguNlbB6/
         nWeh2egrPFtBTeO1SEIjorKZF73HKBrwzul36kV56Tx5MO6AUaQIG2YSHhoFT7PsrkqQ
         Y1c8BOdenrcN0ErbJ3ipy+e9WRDLsZPh38KYYDzNIq76Q3Ria0s+DhbKCoRKm185RF6Q
         MUujXFKsUBJiKSzIlELsMdBt3FekX2ObeS9bSbi+JGmfoDzWQCT0m4xRobOUTFgZw90Z
         DAsQE/3GzQF0K/cZfchbl9VuJxb5Ttt30jyQGtcfSIXE+wu2JK8zRgcTOvdxaXJJpEho
         MeHA==
X-Forwarded-Encrypted: i=1; AJvYcCWVALIzFWeb80nTvUwOkbrE+xHw6frdOER5Fzo0OS+EzeaNJlwM/U3o6JlV4PWM2TgoteubEpVbXvZRkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb1jb/39iGang5w4Leem8bEVyYPbMKLbUTZyqJLfKrTTqAH76
	OIvlgksz4kFZfogWGLp6derCQQZ0QuJhRV9jANg9fCQKBh0zwOJxt2Yrtj9Mv0kHsyfFwxvOHDx
	slx0jwQ==
X-Google-Smtp-Source: AGHT+IG8H/3KOfeazj5iJ04jjkBz6yIE/AOKQMDfJnt9yz4+nKfKTamhvfczManAY+AMloz39ZjJ5n1zY58=
X-Received: from pfbna26.prod.google.com ([2002:a05:6a00:3e1a:b0:770:4b49:a1ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1d:b0:772:44e8:ce65
 with SMTP id d2e1a72fcca58-7742df243damr18055484b3a.32.1757432064361; Tue, 09
 Sep 2025 08:34:24 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:34:22 -0700
In-Reply-To: <y4sev4v2pixrjliqzpwccgtcwkqp7lkbxvufdhqkfamhmghqe5@u4e6mrwafm7k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1752819570.git.naveen@kernel.org> <y4sev4v2pixrjliqzpwccgtcwkqp7lkbxvufdhqkfamhmghqe5@u4e6mrwafm7k>
Message-ID: <aMBI_mKJPun0eDJl@google.com>
Subject: Re: [RFC PATCH 0/3] KVM: SVM: Fix IRQ window inhibit handling
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Naveen N Rao wrote:
> On Fri, Jul 18, 2025 at 12:13:33PM +0530, Naveen N Rao (AMD) wrote:
> > Sean, Paolo,
> > I have attempted to take the changes discussed in the below thread and 
> > to convert them into a patch series:
> > http://lkml.kernel.org/r/Z6JoInXNntIoHLQ8@google.com
> > 
> > I have tried to describe the changes, but the nested aspects would 
> > definitely need a review to ensure correctness and that all aspects are 
> > covered there.
> > 
> > None of these patches include patch tags since none were provided in the 
> > discussion. I have proposed patch trailers on the individual patches.  
> > Please take a look and let me know if that's fine.
> > 
> > I tested this lightly with nested guests as well and it is working fine 
> > for me.
> 
> Sean, Paolo,
> Any feedback on this - can you please take a look?

I'm getting there, slowly.  Lot's of time sensitive things in flight right now
both internally and upstream.  Sorry.

