Return-Path: <linux-kernel+bounces-837214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF77DBABB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801DB1C451E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98BC2BDC0C;
	Tue, 30 Sep 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwlxW3JT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E17D07D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215142; cv=none; b=qLVxW/yrgKJyl14EOwg9N171no1PlvlHz58aay3mdmXSrU2GVjNqKKqE4oF1K5ps3bJS2cxy9dLjxy2M4GSObVIWvuYnwMySMv3FU7l+GPxUxPG1jvNEhug4MwC0IW87yNUh6Latskvm3CBmYgArKMApOhpB9OFkjCSbB39r7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215142; c=relaxed/simple;
	bh=cYaBpm56hinhNoSwuyHJ0YHIPFozFBLLQv/kuBfheQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JQjVWSjGUVAyw2OvJFvPuEysl34+ghMA8Y1M2g6m/cDIscyrMJ7pzLL8TODcPVaTAcU8mPhldF/+fPztS+C+9cohIMJrAdndlJIHdx+b/LDcgmzy12G/MA0R7qgkdP+TzUcZ5qmsnS82JpZydIBb9X+/DG97KgysUerQl1pPVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwlxW3JT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25d21fddb85so101961635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759215140; x=1759819940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWMHlYc0hMoE1GM3bsB+Lb3OGqc1VWCQ8QLyLifKnkM=;
        b=YwlxW3JTJ2AyDfqlhFx4i1adAwlBh2lqBeOLhZ7xon+E/tXTPB/vPhkdPKILRCQdXD
         GhVAP8yVEaCJdnD+XaB3g1U+ORQ2eRcYUjHXQESMMkq1ghz9LNHH8AX1WS/97k5MI+t6
         fSPC/wsXjvWKJGEbTlflYmNwFgt3Va4lRYB7mFtKDKy24HUsMXTYBqD6jRmAN/rVQWft
         D/QAeEBmUuQmMrE6FW9nMBo0Mf/zIxbrilD/c5JvbZAox/XRcMgtZh59sDhISJk4EYvn
         PsK4z+aycnaClEhPjNI+FDWRgnNxsQqxJhyxzLXHdBlq7aUIE4qXTZclFG358++rSdVb
         v4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215140; x=1759819940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWMHlYc0hMoE1GM3bsB+Lb3OGqc1VWCQ8QLyLifKnkM=;
        b=lL07i00yXT007FKClFPRXnr8qtSDWJBMvOc+886FHLav4UDfMjah3BgIzvjjQEJ1aW
         QxFIIT7NOZK4J1p+Aw5baO1BU3/NlRoXb7mBPzka6IdcnUg8NpPs3F/ybwEgbQ/0vACS
         qaIWV8AAwSYnOMJzxjIiYIzhhsjNLQOi23APDKPb6WeSCW0Zjq2eZZqKcfQiXx28GcUc
         35r75jHAvXEI+Xazag9/xvgwoJPKLLem4La+jgEmzfSz4FD8DMY3/hkGfIu3Jj1GrclD
         wBIp81myZaJcn+ED5c0SszoTjRJDi9sxe/AHjaXw7Ugtdkbwi+LeNDCL0ryo8wBh0Efx
         2PCg==
X-Forwarded-Encrypted: i=1; AJvYcCV3CLGRkutS/3Eu2dnde/rY8UTJmTKZ5ubB8S39tfmc16VS01qkYlsAFi0vYfxXLEGGwtwk0B49YzFhaL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVXwOFhFHif3UoAZoE9xJGCTNHaQe6pJjB4UlmujQkBv631Ca
	G4nA52V638rorSSxC/xLn98YjNQQ0rBwI2uGpzpwP8/OQY2jvJ0zJjfzNy93XpJQeiTFQAVbAcX
	hiZ0fCocL6co8tUcog5h+7kGlHA==
X-Google-Smtp-Source: AGHT+IGC7MITWguwW4mNJBum52j1+kua3rPzsQOwcaHFJ0a5mYZtyTF4W2e7W0OIUPIt9GOaiwODKYzxXGoW4ftPsw==
X-Received: from plot5.prod.google.com ([2002:a17:902:8c85:b0:273:8fca:6e12])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84e:b0:269:9719:fffd with SMTP id d9443c01a7336-27ed49b8623mr245208965ad.1.1759215139860;
 Mon, 29 Sep 2025 23:52:19 -0700 (PDT)
Date: Tue, 30 Sep 2025 06:52:18 +0000
In-Reply-To: <aNq6qWVEBLkWhWFc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-3-seanjc@google.com>
 <diqz1pnp34st.fsf@google.com> <aNq6qWVEBLkWhWFc@google.com>
Message-ID: <diqzikh01lgd.fsf@google.com>
Subject: Re: [PATCH 2/6] KVM: selftests: Stash the host page size in a global
 in the guest_memfd test
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Sep 29, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > Use a global variable to track the host page size in the guest_memfd test
>> > so that the information doesn't need to be constantly passed around.  The
>> > state is purely a reflection of the underlying system, i.e. can't be set
>> > by the test and is constant for a given invocation of the test, and thus
>> > explicitly passing the host page size to individual testcases adds no
>> > value, e.g. doesn't allow testing different combinations.
>> >
>> 
>> I was going to pass in page_size to each of these test cases to test
>> HugeTLB support, that's how page_size crept into the parameters of these
>> functions.
>> 
>> Could we do a getpagesize() within the gmem_test() macro that you
>> introduced instead?
>
> We could, and I actually had it that way to start.  But I found that burying the
> effective setting of page_size made it harder to see that it's a runtime constant,
> versus something that can be configured by the test.

I guess I could also just update the global static variable page_size
for HugeTLB tests since we won't be running tests with different page
sizes in parallel. Maybe that's better, actually.

