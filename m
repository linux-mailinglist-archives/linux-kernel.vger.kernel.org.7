Return-Path: <linux-kernel+bounces-785559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96181B34DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264EC3AE21E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2A29D282;
	Mon, 25 Aug 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+KICfZE"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F7296BDF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156294; cv=none; b=KjLAYIaSxr7ByAY+hm25qVGAVxgHvBkqm/M23pzizS3DtCjTl8amdkM1oE+OP5W5EmxQdhGFroGWf8O40w+plalzXg4/P8ryxvW+2J0GKKYnjlkzzDU953UkAz3ikJzBgL9Bm5DlvVHpqfMNWCypoSFDD+y6thP1K0TLWTPKx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156294; c=relaxed/simple;
	bh=nFbTNjxctDGMu7gKAPNA3RP/CMiZt9a/yh8OXsYC9xE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7OYcxaYg8XUclbjgmSZ6s1ci+zaYqJ2XU1KyXfC2YHYoKhvRpZNgWsZL5o7ckyy8q/YX431Hv2XtzLfYwfQGt3ndoe98fsk+tpMJr6voScrUUOS9nPZp5eJsSaQMO2gpe+8h/p7BIxzZ+Av3/iprkTLsYLPXXg8U/QFYF8telU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+KICfZE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244582bc5e4so59655095ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156292; x=1756761092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bU/VP3KImYxnarLk0B3IOiENhi91lMJDhOtDAwiONbw=;
        b=P+KICfZE0PJy3Y83tPMgyg+zkNONscb562RHl4XrM/JrXNmkKn+yAzCpRAou1h+og7
         b1quBY96Qe9Co8ZXsWxrfAbVFDgAdjyO3zCAmlc26XilYPjycIHUxlqgcTJRflPX0u4G
         XOPJewZKlu1WRn5VPZdojohVIu2CdaOYi8dmyVZGN+Y9LHG7qHkcEpaM+4OdOu7/QGF+
         kWp9Avrc4oXsqqs64f1C+EF2A+Dkbi79xGrar2KWCTMEKY3X0zxDRVBBN0QSvmK3B1st
         TcQdVcZQNX3SeVhHAuuvWhqNDj2rK+vq2m+BeGIpAn/f7kjBks/0I4RQE9wzRq76RCma
         UwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156292; x=1756761092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU/VP3KImYxnarLk0B3IOiENhi91lMJDhOtDAwiONbw=;
        b=u2SVqCQNwxf4Y92etSzHWWeHl+AZ946JEMa0vH2tt3HiGlqKRs0wK8E5exFhncGvXD
         sFSvfrws7Il2FBLCJ8yK7rMuUiq1TO6V81Ag/A5fXWC7qH5MTcGkFf12hffSLAIPKZ4R
         /+apL8HDAtAUwz02nWOndZ4pL7xiF0TbyXWlAhS/567TpRnkNVQW1nWYlbFYRn9V+CaN
         GhY/p4lwuePQoqB/zViaLVldkTlL+vt2ArvNM5KB+0QjpgfF+uXh7JsSajHMSXqb9L/j
         ysoBeUmy4jQR1PXmtjrzu+D1NSeFJiqeaiAOboRjxRM8fH7OdxQ75P8gf9wr+orzL7LG
         PIKg==
X-Forwarded-Encrypted: i=1; AJvYcCV2IN3Anvwi2TpPgCexrg/bHqswLEgAVoMnRj113Pau+CuNwLl/+wSd9+57UyWl7JYgQQc92mYfhW7QXvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtj459oWEY/+MbPzmt9RK9G24dB3bwidzRuDXF5AR13j936mkW
	42AvKg2h9hm/DIlYaSds6+ESGMfQe0VfNxNGW0/c3Bl5rWFN1qP3xrVIb3eRoCKY6/Iphj6qaQ5
	UwcBmng==
X-Google-Smtp-Source: AGHT+IEmXw+WuOyMgM65AZf9fTrlI3TioKulbn9TFehdZm7hjH7SGdKKkkNUobg2k6tabLgV7nQdbhXUq2U=
X-Received: from pjbsm17.prod.google.com ([2002:a17:90b:2e51:b0:325:238b:5dc6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c8:b0:244:9913:2fe2
 with SMTP id d9443c01a7336-2462eec67a9mr166879855ad.27.1756156292252; Mon, 25
 Aug 2025 14:11:32 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:11:30 -0700
In-Reply-To: <87zfbnyvk9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825155203.71989-1-sebott@redhat.com> <aKy-9eby1OS38uqM@google.com>
 <87zfbnyvk9.wl-maz@kernel.org>
Message-ID: <aKzRgp58vU6h02n6@google.com>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Sebastian Ott <sebott@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 25, 2025, Marc Zyngier wrote:
> On Mon, 25 Aug 2025 20:52:21 +0100,
> Sean Christopherson <seanjc@google.com> wrote:
> > Is there a sane way to handle vGIC creation in kvm_arch_vm_post_create()?  E.g.
> > could we create a v3 GIC when possible, and fall back to v2?  And then provide a
> > way for tests to express a hard v3 GIC dependency?
> 
> You can ask KVM what's available. Like an actual VMM does. There is no
> shortage of examples in the current code base.

Right, by "sane" I meant: is there a way to instantiate a supported GIC without
making it hard/painful to write tests, and without having to plumb in arm64
specific requirements to common APIs?

E.g. are there tests that use the common vm_create() APIs and rely on NOT having
a GIC?

> And ideally, this should be made an integral part of creating a viable
> VM, which the current VM creation hack makes a point in not providing.

