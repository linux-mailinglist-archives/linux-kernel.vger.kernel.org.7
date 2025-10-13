Return-Path: <linux-kernel+bounces-851550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCBCBD6BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1033A71CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF82BF00A;
	Mon, 13 Oct 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uph6FHzP"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511715E5BB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398245; cv=none; b=XoiR1c3GEvQLNUx0RiMFcN/s8m0o+bVUKSpWuqIplIn6bg+JvofW7+qwsKIIKXjy0WrvMeMCKKHBM9ail8MhI1CEH3oIQYslmJH2SdbTYyZ9qAdcQzyT27RIdNR8xc4UsK5b4vnI/ZttLxM3Z3DITLGmIWv5jh8FYUFcfsqgYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398245; c=relaxed/simple;
	bh=f1t956JBV+YwJMh+YwrrZfOciYvg7blVAnIMvPKNYWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6k8655Vs6VHNTsdzSwYQRAggJmD1z8D/WpVTLaLRAFF2g6oreNsUkUTZtTBQvopYaeqzmwlG9e3JocX1BwdNgUFJScHN8VJM0yfogDvEBAzkcyY7tDJjVT4b7DjbgW6Cqm/5u3RFKqNoL9DzNFi7fhs+Xq22mVrukRQJ5xxZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uph6FHzP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso8550676a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760398243; x=1761003043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08aB01K3QlDxNQ6Di+ZC0Fy9ecw0hHQXKJJoqFOXoow=;
        b=Uph6FHzPc/b+vglLfbjZCr6KjDJ2zmgxbDJayKIw5OqT1WmL19SVwuCjuYq0HNn6BK
         eGHUGRKOGrc3kO420C0+fBZn5s0tZD4i7FFSatS0ltUBQL49XOYorDGQ72acddkim8ip
         ce9ryTKim646cxrT9G6WKmhhg27Yw80v5+MmCwvJn4UmTls+T0oR3x6lFHcYt4UsQ1ov
         p4iQwEKTzteS69d7HrWbRdLOrUv9b+zBiIulj7OwgZOSLu641FsfS+Jf6jNc0W5iMrFh
         uKY14V5JLNw3eXSYTg1dbdm9NXVP7/645gmStX4/0wQJeOgXZnO2gOO0GUvOfApmHlu1
         J2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760398243; x=1761003043;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=08aB01K3QlDxNQ6Di+ZC0Fy9ecw0hHQXKJJoqFOXoow=;
        b=BmmztHTLgMqs3rudn+fbHb/qymb5GANa0Tk8MtiY0LDCnYumc/7WHx8KXPcPZZeinq
         4mOYLEQXWWZp/m3PADcfOdloLy6FSO17HCkHBdO37IAuRMRUOaUaakkxZWz/Vk9uWUo1
         KqiaJoa1XKwFZy9tfqK8h2AuqKl6qY52Qh+At1WwDEwy2A6V6MzYDaV3VDH2eASmd+Qq
         BlpavG/nW5wJOe+riKaxTIuTlvFQ+iikRPSPfiIOdbCZgJdczooPpC2tASB4c09mhSdE
         ZVLiijQnEkG4whe+yHEMxXwhhdlrM4IKV9C6PFuDGCVSUXBRTaa+QQ98u2o09fu5QcXH
         fbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEsQbfcA2259XLhw1uzCJplQj2hJj/jlfLFQbg6zOeONmOuzv4mgpvcN4lU/In2y3GLW+DrKUkoLzCFcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcx9sbShX/Rcf273dO1FYQk1w1V2QVyo6n77mTR1eim+K1WjXL
	D1mtuxcVd2WVpYvcJEhDzuX6rI6Fsak1Nqn4xLCU4qbysjXWmUf+Fu+wycOj6k+Xul31IcwR7np
	xvOv39A==
X-Google-Smtp-Source: AGHT+IHs68Jiesyq8CVwopkosF1NFYrZ8tVJ5yK1fRCuny9H+M0GlqQ+GEI/HXfswBxaNk8YEghSh7Wv9pM=
X-Received: from pjbgl20.prod.google.com ([2002:a17:90b:1214:b0:330:acc9:302c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a87:b0:339:f09b:d36f
 with SMTP id 98e67ed59e1d1-33b513a1e0fmr28253894a91.28.1760398243550; Mon, 13
 Oct 2025 16:30:43 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:30:42 -0700
In-Reply-To: <CALMp9eQN9b-EkysBHDj127p2s4m9jnicjMd+9GKWdFfaxBToQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922162935.621409-1-jmattson@google.com> <aO11A4mzwqLzeXN9@google.com>
 <CALMp9eQN9b-EkysBHDj127p2s4m9jnicjMd+9GKWdFfaxBToQg@mail.gmail.com>
Message-ID: <aO2LomPuqvvRF5l-@google.com>
Subject: Re: [PATCH 0/2] KVM: SVM: Aggressively clear vmcb02 clean bits
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025, Jim Mattson wrote:
> On Mon, Oct 13, 2025 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Mon, Sep 22, 2025, Jim Mattson wrote:
> > > It is unlikely that L1 will toggle the MSR intercept bit in vmcb02,
> > > or that L1 will change its own IA32_PAT MSR. However, if it does,
> > > the affected fields in vmcb02 should not be marked clean.
> > >
> > > An alternative approach would be to implement a set of mutators for
> > > vmcb02 fields, and to clear the associated clean bit whenever a field
> > > is modified.
> >
> > Any reason not to tag these for stable@?  I can't think of any meaningf=
ul
> > downsides, so erring on the side of caution seems prudent.
>=20
> SGTM. Do you want a new version?

Good gravy, no.  :-)

