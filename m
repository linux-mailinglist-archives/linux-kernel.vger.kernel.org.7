Return-Path: <linux-kernel+bounces-894111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABCC49497
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F271889ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F52F12DD;
	Mon, 10 Nov 2025 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs6EgrmQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENPZoCy0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E82ECD31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807498; cv=none; b=sCfVQDsedrFQoFNMBnW33/W7V12Tq/QPfqVEdZIM/XvZjgd7byecWxb9J34UpYe5/AztojVBVZpRu9MLuf8xW1GaqR3HRQRf2XRGhiHNHBi9env5Hg5RBoOtLHGWHAx0TwlwUBtfbT+C7UYKePQE8csX9lYqN96moCseLrwzlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807498; c=relaxed/simple;
	bh=0QmLAhB4Dr1WEPpk3887110fcGYJhxEIE8hNtWv5p9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaYmlavCHpJjO7EW3G3hT1YF2HLGdeNIZyrEGOBFx6O9pg6kHWE61z85TUAjCm2g5T5myRuWjTg4RiCAluNL2IUGbJeEZd5oaa9eThqwZeZZsBFNGEvpkX726QZqMugoI310CXK3bf6MQQ/KuiWISEfi8KSpnR8eYVhyNS4llFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hs6EgrmQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENPZoCy0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762807492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0QmLAhB4Dr1WEPpk3887110fcGYJhxEIE8hNtWv5p9w=;
	b=hs6EgrmQIDgnDTOH7X/W5iJLUuSMn956wLRjDslN9bsxZqROrb8sJdr4M4L9FeHVhMjMFC
	eUUnjGer0cyJtroCaon+WbUM4sPT/qj3awCpvtB2JR/IzB0wgsaDt5+g4cPfSwAmtNPkVz
	lKCDsEk/LNUL4TdgWoktVk53THTvGdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-X1G2mdN5PNqGUIxqiZR9NQ-1; Mon, 10 Nov 2025 15:44:51 -0500
X-MC-Unique: X1G2mdN5PNqGUIxqiZR9NQ-1
X-Mimecast-MFC-AGG-ID: X1G2mdN5PNqGUIxqiZR9NQ_1762807490
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso588835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762807490; x=1763412290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0QmLAhB4Dr1WEPpk3887110fcGYJhxEIE8hNtWv5p9w=;
        b=ENPZoCy0Y5Ucx0OvtHBoir7oqkL46BKyCGz7Zxun3iFZX/mSB3M6LpZjJA57ajn9cC
         e2TfJS3KMPUTYeSyloLORAd4hz4RtbJdRynZQhOXuc0HMMcNZ1FgXayFx4dHe5lFpttT
         SFA8yl0HT1/at5uM7af+H5XO111q0G3WRV+TCi4bfRao2kv8Dhc67RowED1y8XGs3jae
         9oaUDq/AtmDcBmNlholvzzPGe/I+sq0Rhxacn0eccv0wCFxOl88i0QxB1CXEW2jVQ4Ol
         tw1GAs+Okn7W1fN4Yf05GfxoavGAqmAYSf3vrbkgcX/ZpBE7rIBUShcH9LG2w1hPNq5V
         V65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807490; x=1763412290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QmLAhB4Dr1WEPpk3887110fcGYJhxEIE8hNtWv5p9w=;
        b=gcyRv34QKk78+99FzIcf3onYigVXJ/bZ1hUCHyKHW2rxNDwwzIMjSZXTOY7Kh8+0kc
         tUVKlG7quWUBmo+aPphBc8q0aOWl8z8qS6KYczlT+1QIsimWJGXPmM/Du+dMqqBNff91
         Y8sa1cKo4LD+9mos+k04gB/BrWfEDNz5p1/hj4OLgs+E+RD/HihLVJUhaewXqkbVFYnZ
         EKWLQjaRFDqUtU79fUhRrhVS67WK/LQHGn+K6YuqZPM0bqJRnsc6sbu1aFtWl6lPxa/r
         ESV6wSEKVrI7vNDM/T7pLNtmCaTqL06h0S472M8JMciGX6xQohr0e7sX1NMHGKV+B07t
         3KuA==
X-Forwarded-Encrypted: i=1; AJvYcCWh4B9Oasvbnjo6qm6BusUSAoyK4B/Kb1G6MeG6tDj1nFXT47ppE3G19aF5Dsl+s+WvS1MKc/ckSTW5WpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmZjwWRFFlSLur6F6hpTEyqT/2aNNBRjD75tn0TSG1uMFaQuB
	pNNkYct6e1JCNtAPIUzlXM/3YjEpUKk4cLDndLuzutzgl9aaJZmPfd0t4+O/HxCSA2Igub2shjZ
	jlXneBDu5hppQw2Cip5L2BGKdQlWeEL4HKVo1yBMnI1sWL/uU9bQPvlVliJ2lLoTw1sqt5HK9+f
	Lw5AApHZF9H1PNd+zDp3nA148U94BR3jZW0YpfOUME
X-Gm-Gg: ASbGnctWyIAHFDlnHHdFhY3ndb7YRsM6J1rm1QM/Zb3FzIVW3JpOpHP8j7ZK8XQ8Ai3
	XdhUjlVhqXs1dOINqP5eokkCShJlZ2Gb7ZpuUdbzh5oxXbQMJcJU1lWlByEccP98/X14EcCv9HQ
	JfL/GerSXEBHK6kYECWF5FYhPyhePXWoVG7nR3KQ/UAUv/b7wmR5LHFlDpBsbzgIDa2tEiSM62K
	q7Uhq9xJ4aKR2aJ70XUFBiQ7OZQheo9u3Y+bBzRwYOGfYnEqjMbDIGX7i7sOg==
X-Received: by 2002:a05:600c:705:b0:477:81d8:df8 with SMTP id 5b1f17b1804b1-47781d8110dmr569375e9.19.1762807490024;
        Mon, 10 Nov 2025 12:44:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxgmlnkD4pZaOUZoaHUEyi4FhNrg7OIYNzNltbzPAiHrzD/ABZ6T0/DHHvTLeLO5rSzr5b0t7kC6amnCZvfAo=
X-Received: by 2002:a05:600c:705:b0:477:81d8:df8 with SMTP id
 5b1f17b1804b1-47781d8110dmr569225e9.19.1762807489677; Mon, 10 Nov 2025
 12:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220424101557.134102-1-lei4.wang@intel.com> <20251110162900.354698-1-lrh2000@pku.edu.cn>
In-Reply-To: <20251110162900.354698-1-lrh2000@pku.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Nov 2025 21:44:36 +0100
X-Gm-Features: AWmQ_bmE9lW1YJSBbubQWZMySQSyLd1I6Mr0gyYvS3wFNwWQ6M81mIDCY6FrJwU
Message-ID: <CABgObfZc4FQa9sj=FK5Q-tQxr2yQ-9Ez69R5z=5_R0x5MS1d0A@mail.gmail.com>
Subject: Re: The current status of PKS virtualization
To: Ruihan Li <lrh2000@pku.edu.cn>
Cc: lei4.wang@intel.com, Sean Christopherson <seanjc@google.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Jim Mattson <jmattson@google.com>, 
	Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Il lun 10 nov 2025, 17:32 Ruihan Li <lrh2000@pku.edu.cn> ha scritto:
>
> Hi,
>
> I'm sorry to bother you by replying to the email from years ago. I would like
> to learn about the current status of PKS virtualization.
>
> In short, I tried to rebase this patch series on the latest kernel. The result
> was a working kernel that supports PKS virtualization, which would be useful
> for my purposes. Would PKS virtualization be accepted even if the kernel itself
> does not use PKS?


Yes, I think it should.

Virtualized PKS does not depend on host PKS, because it uses an MSR
rather than XSAVE areas (which are harder to add to KVM without host
support).

> Fundamentally, I don't think this patch series
> has to be built on top of basic PKS support. But I am unsure whether there is a
> policy or convention that states virtualization support can only be added after
> basic support.

No, there is none. In fact, the only dependency of the original series
on host PKS was for functions to read/write the host PKRS MSR. Without
host PKS support it could be loaded with all-ones, or technically it
could even be left with the guest value. Since the host clears
CR4.PKS, the actual value won't matter.

> One problem is that if the Linux kernel does not use PKS, we will be unable to
> test PKS virtualization with a guest Linux kernel. However, given that we have
> KVM unit test infrastructure, I believe we can find a way to properly test PKS
> virtualization for its correctness?

I agree. Thanks!

Paolo

> I'd like to hear from you to know whether I understand things correctly. Thank
> you in advance for any feedback.
>
> Thanks,
> Ruihan Li
>


