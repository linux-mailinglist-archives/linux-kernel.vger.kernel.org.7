Return-Path: <linux-kernel+bounces-844495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904CBC211C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C4819A3DA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DC2E7BAA;
	Tue,  7 Oct 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jG7FSzFN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C72DCF78
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853621; cv=none; b=esbegA1XL7fEHskgQ4jm8Ir6aofaRN6mh62Z9eEnfUtj3zXiUIuDjOWTXR/d9yMf5Ubsxv1n7w13rMKeo6ZWSMmMBGnUbCRKB1pezdbaOlz+2YOVBQpZOaQaRnPISpJwbdXckwSQzAQgjqLvv389SbPGCCXVNKDW37OkarAhH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853621; c=relaxed/simple;
	bh=76Hq9+KcZm5GgG6f6rPowJlqTFP/oNiUaWKana1uGRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmMHK2w9Z0WjMZBJj8bHqLegM4HdJumJOujLelP2KoeyAyoEY4ZK3ryPLAbMGrP8aGzfPuPVU8BIEk2tabjxfnd/lLyYt20LuMD6O97z0mGdy7AAOHXJw4bikrObexy/XvCesvbBZVgPjvTL2nmJFJcO2zHPxgCaFwN8H4lMLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jG7FSzFN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so5301548a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759853619; x=1760458419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/0R1SD3VaA/2ykITD569p+LVuMnDQxYEsLsVmg+Y+w=;
        b=jG7FSzFNQA6NZQ6W1zWsB4FIBkamJg88fYZDbhLRllyIpfwRt5bFQdAJkN9KiIioSd
         QJ3KvLgWE7FnFR1Pr6TwqWywzUhDEw79pzFrYnME42LY6bFV1NIH8JdtWJO3CoCB7mDP
         EPUYhPLBixN4MppN60IlYaV/lJM2CnNhwsluKwlqB2raZSlmQwE6FZp5xgrsb8bY0Dfx
         UDd7pV6gTU1lr8CjSKRgzWqV6WCCDzgozDFy84kmcMvRu4h/MyhtfkhpVowB4Yf5aqkw
         gqHtOKvAKQyf2j20MsFeTuJ7ugG7VYAWUpAIIuFRpxqPYeYyxLJd+5INkKKIOFIBN2Aw
         y+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853619; x=1760458419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/0R1SD3VaA/2ykITD569p+LVuMnDQxYEsLsVmg+Y+w=;
        b=LW7qPAX4BcHQNLaYf1JB1nro3qheyEiouO2WgVpkWcGIK+bLOIm/BGzBQm6WbSyWlw
         7ob/STpVzIszYoW2BbYxBE5zh0K/Den0nJWNjtCML4fkdWgXA1WUwh8P+cmn+5EhpOf4
         mQXrH6j2CJyc8UfPaX5Kbb9WzPmxq4wnoXXEV4snyBQzUnD+gPsWG/uOjYUhzI4PxWvE
         ygPPRKRupGQ/cvaeKF5Q7iZj9KfOnulgwRX7MMw0mlbF38ZFhSlsZp6uQJO+PFMB01x0
         tuTayvYNQ9mmZpEcdjZC2jnvqPfvP2VYajqqIjE4Cl22LyuwRU6lZglc7i+zXtdVRJjl
         0f7g==
X-Forwarded-Encrypted: i=1; AJvYcCWBrNFh30H6XqrQvMMm7bN4CW/lLyXAMgz6QophJsQj0t0W6Jqbqb74KFb4+TPxTsqNhu2+bisYsJxDfvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJp1eZjuYEZxs424Y3gHfHA9rI/2XrtAa9r7lx6h5WtveDrCzf
	qQ462FIwFlcCj9rDOQQMijpQk1yqeT0YLElOBJguRVbdGV9061Z8IVvWbFeiUjdIZoy9Qv7YLgr
	Nv/6RoQ==
X-Google-Smtp-Source: AGHT+IFi6jaCqXX6ipD3iFzSfYf2cSObKx2sGxvSGH0ly75WnnVzYddNut6i5GgfZdU8C9rFg/s6RmCxrTE=
X-Received: from pjhh16.prod.google.com ([2002:a17:90a:510:b0:32b:6136:95b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a8a:b0:32e:a8b7:e9c
 with SMTP id 98e67ed59e1d1-33b5139a3aamr71491a91.29.1759853619222; Tue, 07
 Oct 2025 09:13:39 -0700 (PDT)
Date: Tue, 7 Oct 2025 09:13:37 -0700
In-Reply-To: <diqzh5waelsy.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-2-seanjc@google.com>
 <diqzplazet79.fsf@google.com> <aOQkaJ05FjsZz7yn@google.com> <diqzh5waelsy.fsf@google.com>
Message-ID: <aOU8MbqQ0ZnHgRr8@google.com>
Subject: Re: [PATCH v2 01/13] KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 07, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> >> In this model, conditionally valid flags are always set, 
> >
> > I followed everything except this snippet.
> 
> I meant "conditionally valid" as in if GUEST_MEMFD_FLAG_BAR was valid
> only when GUEST_MEMFD_FLAG_FOO is set, then with this model, when
> KVM_CAP_GUEST_MEMFD_FLAGS is queried, would KVM return
> GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_FOO | GUEST_MEMFD_FLAG_BAR,
> where GUEST_MEMFD_FLAG_BAR is the conditionally valid flag?

Oh, conditional on other flags (or lack thereof).  Yes, the capability would simply
enumerate all supported flags, it would not try to communicate which combinations
of flags are valid.

