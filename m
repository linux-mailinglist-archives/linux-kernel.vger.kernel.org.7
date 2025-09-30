Return-Path: <linux-kernel+bounces-837848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A23BAD983
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50DB1924724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4A30749E;
	Tue, 30 Sep 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoyu7XAx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD833043B8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245102; cv=none; b=fbX+gUSwHO6vHHcaQLdo1yaCvPk7503+Bbi4e7Falw+Y04W1DXGjPyfJjYOXC/eco8G+nfzUWf9ahaF61SdP8BCoXt4z5/n9njtmMoQaObXsO7WKbMtqLQYUU6WUaoWAB2Rum4ca2SK5FBDWR93OvJ7Pd3lWQ4r6gVNfPQ6JRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245102; c=relaxed/simple;
	bh=EoQoC9gmyDFd04iDE/2CPVDmTENmOaGyZ91Ul897hi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OLeHHIg1UBX3K+gTEtAuaD3CkcVzDaiecJhMkCIe9VTn66FuqAaImNZe/D+d/LC46VTMdLkcPFoUKGvCA6F6UVCnXcQEPwmWD0GeiwDyPpDBHWSuk+z31c846/SJ69B2Z5uT1D8pNwvUVM8eOFoUFaDDKj2inB7CawfuoncZ12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoyu7XAx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3305c08d975so6114233a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759245100; x=1759849900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRw+IQDxMuuhxFprgh+nTQeMioqYSRGrn50nIsG9oms=;
        b=aoyu7XAxUwoLK7wIlffUYIJEI/1xFiKHxTEIzO0Y81xADl0TcRuCrZM1tvnvUQYsnX
         Mvb+VIDph920gD28T1LkJpJcwibWN9oadUCCOJXLxxljQUaVadk9sek3UKYCXowJbluJ
         C9yeOun1arQR5ivB3jI7AmfEkylN0ujlKY+FMrgYroN3axq1CTRUlK392ZYZVW6BP21O
         maYqs9yqhLr8uhGDFVkESSbwQhH4TjdUrA8oBf4WLn9R//QABiKCDnyX2Cz7SYhBXcal
         UX6hDp2OcJlYueEe8m2rXH6KLMz4tKn6vTwzqU4Dg4FU8XuBIgFp9xPAoJFTw0pdr5j6
         O0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245100; x=1759849900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRw+IQDxMuuhxFprgh+nTQeMioqYSRGrn50nIsG9oms=;
        b=SZ3h/ktN0j7h82eIo6urMYaZLAF3F2Ooy3NxvGQxdyP72Yb5N1/LOBcSKLpCFEy0Kq
         9L7xBxS7E4s98WK4y4aw3ZVPBOVsHeLc5lNqfMAYSCKFzN5cnnr62V1U2BSbLyjTGK8y
         SRSe8d6NhiLnXPAbjOABZJW5UW/PHjXrxNPUHOnvjkoR6ZWZsrPsT91q+vezdbYvqKj2
         PI9gW9lYv7XwpQ5MUOQlMBDoglNkRl7VuijcVjxUpAiZHFol0kk7F50BTlvNm8W7idz0
         KW080pJfKopHAmnJcDykkWzGfaPTNouOrR652Jhdrf8UvsJ0BrH4DZkgYZ+fJzBQ+Yi+
         fBzw==
X-Forwarded-Encrypted: i=1; AJvYcCV9OvyUmBSKt7VhG4GC4odqX8/tydqvWBw9UFzcemnaMqK/Ep2ffr+4LK67oVB70JkJHkzQ3Qabq4q/FZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60GHVwPb3hsgppPssB2vSSguPVB9PS5R6FVzafTTCqDuXDQJ/
	bdDm0D9rXI2NKTrhUEdubTtwNBDH8G7drsPZ5m1CcdBPl1mXBUlrhZ7znRFPM9/ejGY8KSqq4K9
	mvFLX1w==
X-Google-Smtp-Source: AGHT+IFBJmhE94WYrCLM6s2PzvuRfYNTdKgTIJ07w4Sqgez2h3b8qceYm4qVSWPiyT7z6wceIMRCZp20cTU=
X-Received: from pjzg20.prod.google.com ([2002:a17:90a:e594:b0:339:9a75:1b1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4a:b0:330:72fb:ac13
 with SMTP id 98e67ed59e1d1-3342a22cc80mr21528295a91.5.1759245100148; Tue, 30
 Sep 2025 08:11:40 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:11:38 -0700
In-Reply-To: <CA+G9fYuUcs_-SKWSbiAgyzuhE9-oqSAGDQOU6pTPfwq57+cWSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+G9fYuUcs_-SKWSbiAgyzuhE9-oqSAGDQOU6pTPfwq57+cWSw@mail.gmail.com>
Message-ID: <aNvzKq7itcc3ZY_Y@google.com>
Subject: Re: selftests: kvm: irqfd_test: KVM_IRQFD failed, rc: -1 errno: 11
 (Resource temporarily unavailable)
From: Sean Christopherson <seanjc@google.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvmarm@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, kvm list <kvm@vger.kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Naresh Kamboju wrote:
> The selftests: kvm: irqfd_test consistently fails across all test platforms
> since its introduction in Linux next-20250625. The failure occurs due to
> a KVM_IRQFD ioctl returning errno 11 (Resource temporarily unavailable).
> This has been observed from day one and is reproducible on all test runs.

It's a known issue[*], that I think we kinda forgot about.  The underlying issue
is that KVM ARM needs the test to create a vGIC, but the fix stalled out a bit
because there isn't one single, "obviously correct" way to do that.

I'll Cc you and ping Oliver on the other thread.

[*] https://lore.kernel.org/all/20250825155203.71989-1-sebott@redhat.com

