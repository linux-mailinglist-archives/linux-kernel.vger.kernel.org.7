Return-Path: <linux-kernel+bounces-758118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0EB1CB2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C227756298F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312729C33A;
	Wed,  6 Aug 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goQlNm06"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCF29ACC2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502150; cv=none; b=GEKzdKi9Jb3zEwXo48d4/+5625KNt8bFX2yl9aDWqoXe0SZKSpFD49Jc4gjeCt6US2DTbJo80VMnxI3j/XB0Zsy5QHMS6CjsG01k9KaTKPfw15ysI/5yrEtkiGPtcYxJkg+J7fw8t2qoz8zdeMLqkyb/euQlGRw0MHEGoSzbt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502150; c=relaxed/simple;
	bh=1CPu9lCy0nvdi/L1p1/8uO3fkzxuerfbGvnecx5wZ3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iQd4mUOC7+jJX1k88di1cS2DdX3xUbIAzSy1E1ZUD8+zjMtkEYPPrtbCIYB44BMdYOPByfjw7qtXGaB7XXp7TV/ynda+srQspdEzcENvXk8f4YyUDTM0JDRvYVgh+Jf3pfcfLJ+EuO4is8si5SsihPkniV6MwsNEyDNlqGZRVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goQlNm06; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea430d543so200035a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754502148; x=1755106948; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kF9bpK1qdUp80ZClzRswKI8Qf4Ua9KldMhdifkuZo5A=;
        b=goQlNm06WHZgJRapjTxt7R/TcRyiYavrMYBtU4hmo4uzkAlMJbeCxB8csRwzAolnN8
         ZPP9NIY5cRfYYFplGmGxSempalR2O8dG3LqmC9fjh8daHyrXw8lHwdOrOjMyBuBI/z5h
         URx7jDzp2kDdknl4430tJud1f8asOCruSHZKnZAJg1+lu9Qz8Uo5xrA99PoXRgXUdpB/
         SJS4aHJcbiMIz61P+Vb76QYkNHL4JKa1GyFQtmVMcTylJmdbsh4hU/9VQzrAJzwaowfA
         VKd2ilHFkvRAfQA+WlTkCTuxdcwBjnzQGMRzkQX3C9GlTCcH0UH2ZrG3pOJvQppveL7+
         6mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754502148; x=1755106948;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kF9bpK1qdUp80ZClzRswKI8Qf4Ua9KldMhdifkuZo5A=;
        b=Qly1r5WkqfHKZd7WnuOusUf/wk9XVGt+bbp4N07Gk5ENhVR75xjNnAm7crwp0q9ymC
         SGoCl/dZZLanxfKUOoipeGzZSxkW1EHkCO3/KHu6JUetzJS65HaesO/12gFfARNB6W5A
         PBe+enqeYU/dos85sbBX9hD/5Qr2B6JAn5tj/Zsi884VD9L+pFxWtm0lRMO+qYKk2gMO
         iUA1mbZrR+fAGW+5V4yGR8Vx7MHWh9R64eAyEONGjUzuj9i+swKBvpbpwXxDocW5CV+9
         yaf2oK+h1mJbKSfFYhVUn61MZXE8a9dsb2OyF88o5ozCXyjBPIMsFLDa/MhIHzgf2Krg
         EZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUnJ6px7kS68mdklMjWr3Iw8nU7rvEHQ599h3qLUqDbEPeRpSTRAyjBBPVVDdXnzScF8afcHr07RzGtj80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ysc3ucxn5kknknCjOhlmBGzSblHq1c7FZ/zAKWQYFskqo5HU
	dbFV2G7ygnD2f1gJZx6MN2xGy1OGwTAzZ3/YXrSMyqUJwFsHyWdAllYVfAVWEzrxGQuA1ZLbtxr
	oQbIHEw==
X-Google-Smtp-Source: AGHT+IGxbih1aPqy3gB/PvUjHaW+i+ljUGZQWDmJCtPz45aIX373xGbdvRWIDafeWxu+TILTrn0k5Ma/L1w=
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:31c:2fe4:33ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c8:b0:321:1680:e056
 with SMTP id 98e67ed59e1d1-32166e093f3mr4752885a91.9.1754502148561; Wed, 06
 Aug 2025 10:42:28 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:42:27 -0700
In-Reply-To: <20250805190526.1453366-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com> <20250805190526.1453366-6-seanjc@google.com>
Message-ID: <aJOUA36kOYklPzXt@google.com>
Subject: Re: [PATCH 05/18] KVM: x86: Unconditionally handle
 MSR_IA32_TSC_DEADLINE in fastpath exits
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xin Li <xin@zytor.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 05, 2025, Sean Christopherson wrote:
> Stating the obvious, this allows handling MSR_IA32_TSC_DEADLINE writes in
> the fastpath on AMD CPUs.

Got around to measuring this via the KUT vmexit "tscdeadline_immed" test.  Without
the mediated PMU, the gains are very modest: ~2550 => ~2400 cycles.  But with the
mediated PMU and its heavy context switch, the gains are ~6100 => ~2400 cycles.

