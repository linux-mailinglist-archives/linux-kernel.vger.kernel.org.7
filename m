Return-Path: <linux-kernel+bounces-776635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14554B2CFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A7C58041B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B4275AF8;
	Tue, 19 Aug 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQvoB0z3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B1272E51
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645307; cv=none; b=lprzUN6nVRFnRMdnd0mqEIWKQti4Jze8T228VRJwEb58w6LN4vuBaYxD+Mf1POp8X7dv6fsmyXl3eQjBL8AYIYZnXjWlWmHAz5s+Re5PoKVC1uHHqFxLKPNtyKSuk/XH6TGZA9pVevxqc1KXBSE/7cllcxlUt36Nh0Bm0qRYzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645307; c=relaxed/simple;
	bh=yEriFb67RK9r5RACn+K+jkmiLEx3PeKZ2YlQS7CNoQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hM/AJD+KisguDi+zYZV14C5DvR//k7OIZJhZfknYpYfD7k1y6XVnOqr5UxQ5w92REzCLb7d713QK609La9MdlcdhRZsDjqC7aa+EVAaYwKZ/X467qvWeALX3wv3s9/FNyk3RZHNNP9+tl+yLTM2MWtfgfDb6Zv9L8DfVL39hiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQvoB0z3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266a1e87so6098752a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645305; x=1756250105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xnFFqxZL2dKWyQPAP8LNzyOxlbZOPfUkGBwwG1dl4E=;
        b=OQvoB0z37qCtxdys9S9lf1yaCo/iPiuAbNXBbV+0itLlCZElPlIcpuZj68oYiIc/jd
         xDMJpxeeqntT6gbCRoFtO0WgLDdIgOglX0sqhbZAWCj2GWIsH0Otakw689TnF9f0LRrD
         0HatjGAyFs60PQi1/B8x2lxP9mpsl1u4bvjcuUtt/cFtSQrPCsOgLCxMAv3EsV2WEDNH
         FgX7jQGo5cebTzseg1aQF2SDEgHA/HstfknD1LrE5FIBRWP3pRkHcxkBY5TtAUh9BqDi
         H2lc/+5w9LsXj7WNpt0hpGfbLRa/L2sf01jyzcwSr7mTybhpxv+iEohIw0uqf+IXETU0
         dM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645305; x=1756250105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xnFFqxZL2dKWyQPAP8LNzyOxlbZOPfUkGBwwG1dl4E=;
        b=Gs5My1jxrSqzJRKBGQrztvHdjowtscSkZoDXSV9Ds5HbPRA8uryLa7YYbyQeA0iPu4
         CdpvT3lHyBdPu1xwkzBkVU4jYJisN2GjZFfQlQ6AIESj7eq3OFYXIHZLX5JuRx9KT0hI
         KBGZJpa6Q3YKZyDEhMy2a8gncMDEuDNTRf5LKS1mbJnhZTSnT992wXS1nh53j8r+IQG4
         CfznRzwnBXhjn6IilPxsJdn/3knpdFe2Atb3T3ILYGrSiSa7zGPwvbQcX639k7fq8gbL
         9gwlvVdemQGR4/56lWNUM8tR1yvzxSXQyYrqrFn/LU8ZYRIIfjALPwAWj/sCOp64bALO
         mJiA==
X-Forwarded-Encrypted: i=1; AJvYcCW8fK2y9//pTxkJCDJqoD1LLEUtLmvnYJ4q+beSY8TPhsAl8+PoxGcuiWyvhxhJkdai81yKRR9Rb+oZLV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdQ+Z8rBtCdZZut2LR/lt4ALOdI245tC9bCKh24hd4q61K4gn
	B7EE07ASw1hd68T7YggEXcB/AAwFHd4mJovmwT9a+Nf7O9QlyayEPZ4J968nXufkdfZMo0Y0X82
	p9ErQSA==
X-Google-Smtp-Source: AGHT+IHv1eDV44dDXpdL3YKaUXVosgCxmndbwnWK4FetmEDu1I4NxJDYRxi+ZCLgPhhGzqJMjLWITh1N5u0=
X-Received: from pjbta11.prod.google.com ([2002:a17:90b:4ecb:b0:31f:a0:fad4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1810:b0:312:f2ee:a895
 with SMTP id 98e67ed59e1d1-324e140c437mr909249a91.31.1755645305447; Tue, 19
 Aug 2025 16:15:05 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:01 -0700
In-Reply-To: <20250711172746.1579423-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711172746.1579423-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564468839.3066340.1363280133168167552.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 11 Jul 2025 10:27:46 -0700, Sean Christopherson wrote:
> Emulate PERF_CNTR_GLOBAL_STATUS_SET when PerfMonV2 is enumerated to the
> guest, as the MSR is supposed to exist in all AMD v2 PMUs.

Applied to kvm-x86 misc.  I put this in "misc" instead of "fixes" as I want to
get a full cycle of more soak time before sending this to LTS kernels.

[1/1] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
      https://github.com/kvm-x86/linux/commit/68e61f6fd656

--
https://github.com/kvm-x86/linux/tree/next

