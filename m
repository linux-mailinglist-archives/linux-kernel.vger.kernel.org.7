Return-Path: <linux-kernel+bounces-879090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBFEC223D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD51898A01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300A329E42;
	Thu, 30 Oct 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXXxgKNO"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBB279DC3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856115; cv=none; b=mNb7q8ax8CYdC3WPWL6Pi9xip6VRRO/kwRAjnXCXgB2Lfs+0PoL94aG34SPkuYCqcV37AB8ZaDOiCWbql0G+Ccls4I4QHiOauGCbaOzKC50+upKZZaxD65YNHTgPI4AxRF2is32xy0xLFDM8mfgBX/7Xkc98+quhxJBErM/sLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856115; c=relaxed/simple;
	bh=H9/xXV6vFX4ZJCIqIxmxB3nw141jB+d1HVL8gk8S4gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CiJK9qksc9KixS5V/faORq9qe0oazu8m2V5puBxgbmtNTUhWPXhF9FWSbYErLQ+f2m28qVXVemM34XuTn6zR2QzIqtkpPQ/OI8/PeLzaedob1XyLH3n1++HOWKkTxTS6dgdVe04ahZO6lCMUhmf+yB/tZucSB18/dTMJNCi7KcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXXxgKNO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-781171fe1c5so1441284b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761856112; x=1762460912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYy3lGD2M24oZtXLBqYQjcEVOzmXVwbJ6uDSdSZV2P0=;
        b=JXXxgKNOSKYHM+LYbEADTlCzoih3ty+Om9hFt0vYbjF9SOsQAPcRWd4ENjcFffNfsX
         SYiUDkgQg0YgH2vP1lBk8W0cSXH+uJoOica7XxdgaPohWClJmtCRJaJYTORPA5gzedHd
         vRUwrPOg5IHCrNzPOUxhj8bFjjAXKrCPukPNTYsJt0wpwKYACfuBwVvthdg3OTHQzLsx
         6WqWYZNUhgu1M5HSkxmIhUkWSBg278LWMY6mDvU3cV/Stst81Cpr81J3jDHxV22Tl6rf
         SFiyglwCLMBrS9usvosShv66/ndjPmIMdh3DACf2TT+iKtZd3YlD6qVJrMMJ06rBVipG
         7YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761856112; x=1762460912;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JYy3lGD2M24oZtXLBqYQjcEVOzmXVwbJ6uDSdSZV2P0=;
        b=MMNK+R9CNZTKnCuZnv3cG5h5dBnAmfony6oFpyGR3k0D9Cvd2TAmsPNijpedHXwbmF
         I91fQD9m4wzbZJQosXN9kyptLLEtrX+n7hl52OTu5jINhLK6Nd+PR+JA6+SSpbpnmNnh
         MhxGAa/LTimQC5K4FR/UhqwK+wQCI/pPNR9Oxeo4JjEnG12J/TP+vjbhZweZ1ggQ5eBk
         hxA+LefsU+7yOFBnqJ/sj/lzb3ujUSh7WtbD2BzSHo0FCepiNS7c5m3dWigk1Di8pkOH
         0OsIiREi7JjNMk/k0UfwnIiqEn0naI3FUXw+KHbxAME9xotNUclrBnu77Ts+WpiZK2+m
         6Gzg==
X-Forwarded-Encrypted: i=1; AJvYcCVcRf66/Ohil4fnbMNzKjbkK6MqKSIwP3exgQmpUjSDjqs3BzemkcpuNX7f+ltH843zIa11TUmzulu48ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZYb3qLJ7TB3i/CELZGOYCkelX5Wy5Bwa9NhV6V9UYo5Pr2ub
	QnOCWNO6IsMwbr1gc0aD1/Y1QWGJwRR5BhrohEeypWfCmRjt+pPVGyjccVpfXlJPfCAV9wtcWn4
	yMcI4vw==
X-Google-Smtp-Source: AGHT+IE9NYAhKnrJM4tsNmEx9VXdiQTQGHzgV2EPdW1C58528xQJxYi4ip5iQMGXcxcQwvbRV5MRMFrhxxc=
X-Received: from pfez17.prod.google.com ([2002:aa7:8891:0:b0:792:f698:fda2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3290:b0:340:cc06:9514
 with SMTP id adf61e73a8af0-348cd90d3b8mr1272183637.57.1761856112060; Thu, 30
 Oct 2025 13:28:32 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:28:30 -0700
In-Reply-To: <c9b893a643cea2ffd4324c25b9d169f920db1ad4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813192313.132431-1-mlevitsk@redhat.com> <20250813192313.132431-3-mlevitsk@redhat.com>
 <7c7a5a75-a786-4a05-a836-4368582ca4c2@redhat.com> <aNLtMC-k95pIYfeq@google.com>
 <23f11dc1-4fd1-4286-a69a-3892a869ed33@redhat.com> <aNMpz96c9JOtPh-w@google.com>
 <aP-JKkZ400TERMSy@google.com> <c9b893a643cea2ffd4324c25b9d169f920db1ad4.camel@redhat.com>
Message-ID: <aQPKbmJGKFvMX56f@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Fix a semi theoretical bug in kvm_arch_async_page_present_queued
From: Sean Christopherson <seanjc@google.com>
To: mlevitsk@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025, mlevitsk@redhat.com wrote:
> On Mon, 2025-10-27 at 08:00 -0700, Sean Christopherson wrote:
> > On Tue, Sep 23, 2025, Sean Christopherson wrote:
> > > On x86, the "page ready" IRQ is only injected from vCPU context, so A=
FAICT nothing
> > > is guarnateed wake the vCPU in the above sequence.
> >=20
> > Gah, KVM checks async_pf.done instead of the request.=C2=A0 So I don't =
think there's
> > a bug, just weird code.
>=20
> Hi!
>=20
> Note that I posted a v2 of this patch series.

I got 'em, and looked at them in depth (which is how I figured out the abov=
e
weirdness with async_pf.done).  They're sitting in my "for_next" folder, I =
just
haven't spent any time on applying+testing upstream patches this week (I ex=
pect
to get to your series tomorrow, or early next week).

> Do I need to drop this patch or its better to keep it (the patch should s=
till
> be correct, but maybe an overkill I think).

It's probably overkill, but there's no real downside, so I'm inclined to ap=
ply
the v2 version (and am planning on doing so).

