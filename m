Return-Path: <linux-kernel+bounces-824981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27AB8A9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35DD7B659B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E46272805;
	Fri, 19 Sep 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZBiefNz"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D4253954
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300173; cv=none; b=D04MkkNFA1g9jMqqZaYojLTmMAmZ9KKreLb+am8bY914VjRMJJ96IMY46zObgcvIdHSrFf9eihcWFJYajPbjuxvX0satsyP/L5yDVA8i0gzhutt0z1ykj4dtj3U2C5gIqPdCeQgBwCm6jvZFMSEcy7nBQVb7Ti9MBxTDx0BLsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300173; c=relaxed/simple;
	bh=9g2fIQ+OFpk7Lg3JarP2LvlyLe5rYR9EVzGRid9/yZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSYGYKMZ5TtAQeXvPAliu3gWPzWRQNu6xK31tIy9nIf1oa7wL9XFGbUa2kj22OhjHoK+C/r0vQ4QPSV9Jhk3DeNVAiCegnaN1Q0ayJgjW2duWVBFdxBc+e52r1Op5Bwf/5Sr1T/0lVcW1bRHb/qzlFTZpMQNsYurmQ+UvHoG97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZBiefNz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5512bffc0dso1188998a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758300171; x=1758904971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zgCKvyBzGE7zMZD/86Ru8E8ycbpLo3QTwgzItIYQkY=;
        b=eZBiefNzZnylJ+1h/C7KHnpURciLTdoUJ+LhJy3eNbw7lC45NuU2iwRNxs8mdftPSz
         kgBWwpXYWiYfgZWryZ4wLYsW7M2qzoeqngLNfbqzLmhbcNiT2y6+KWC2mpdCPnaXE5iv
         BXzTBYe4JSTMY3jgCLzETMXMbcYoPzQpvPZ8T8yOcRXX8gbToFOlnn02PE1qMRP782OE
         LiqZFzzqLx2gjwjj6dgMMHOzGq+2hTuwIyhnvVlj8t7Aso18VbPpfeYvG2FX0qp4nKTY
         2pZ/oLKd5+ETgbGDGyAuDH9TWtEyN+tLRIB616+n32ciLex0EkA2zAogyuQyZjaddTb6
         LFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300171; x=1758904971;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zgCKvyBzGE7zMZD/86Ru8E8ycbpLo3QTwgzItIYQkY=;
        b=Lfrmmn/rf0pb7cNi892XjApGz3HgeCYEF4AYi9Tc1uA8/FC3YvT/yPqs2WScc78IxA
         DdzHMFiShGVV1sugWgp+kZ4156etuE3yLqqg5FIChVRgBo6jLIqK7Gu8YWYkoUyYTLoU
         fAi28S1gXuG0gdQdLNcD2MoZ/206zl5g872q8qgu8HmnlYzpwn6dBB0DhllbfK2UgMMc
         hgXGWq2sfUWUr+wJ0I68gNz7G5hE1xNVgpF4Mh+4YSrgt+JwYqBzjyECscUOovBQKFFf
         HM0Uxq08GAVSAZcMYH6lifDIvhetTYS4vgNEVK8M9wFE+Ci4Jt/yBqxNPSEHaV3mFHOG
         fEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXURBVDlalpx2vfCUWB6Ofnx2D68Jea9T9AT/pUd6UYWPHFEJ3NFxzKq/+1ITicN+c9XCQYbPVQCQaXOyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9x7RICADjBXSdhT3wlNX0/ntOP+AV7lpqKrgrxi7KWEqkqdET
	DobU6MKMxdor6n2pEVpJtwbcXjFC+NTY9XB3itKxZjikk5WDMd/qz74mkppyIt0SXpD5MgCi2Zu
	DjerNcA==
X-Google-Smtp-Source: AGHT+IHXyf8VM+KPY7bCN9ynVvPY9Q3CFknMXWu4BowlO4hA1C/tN3u/8nQsk9be8dFfpYU9qo1o0XAdoSg=
X-Received: from pjbov14.prod.google.com ([2002:a17:90b:258e:b0:330:82c6:d413])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ccb:b0:32b:9750:10e4
 with SMTP id 98e67ed59e1d1-3309836e684mr4630409a91.27.1758300171553; Fri, 19
 Sep 2025 09:42:51 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:42:50 -0700
In-Reply-To: <aM1uzfweXxoaaLpt@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919004512.1359828-1-seanjc@google.com> <20250919004512.1359828-6-seanjc@google.com>
 <dd2d2e23-083e-46cf-b0bd-7dfb3198d403@linux.intel.com> <aM1uzfweXxoaaLpt@google.com>
Message-ID: <aM2ICvFxB7gWnW0H@google.com>
Subject: Re: [PATCH v3 5/5] KVM: selftests: Handle Intel Atom errata that
 leads to PMU event overcount
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yi Lai <yi1.lai@intel.com>, dongsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025, Sean Christopherson wrote:
> On Fri, Sep 19, 2025, Dapeng Mi wrote:
> > Or better, directly define INSTRUCTIONS_RETIRED_OVERCOUNT as a bitmap, =
like
> > this.
> >=20
> > diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h
> > b/tools/testing/selftests/kvm/include/x86/pmu.h
> > index 25d2b476daf4..9af448129597 100644
> > --- a/tools/testing/selftests/kvm/include/x86/pmu.h
> > +++ b/tools/testing/selftests/kvm/include/x86/pmu.h
> > @@ -106,8 +106,8 @@ extern const uint64_t intel_pmu_arch_events[];
> > =C2=A0extern const uint64_t amd_pmu_zen_events[];
> >=20
> > =C2=A0enum pmu_errata {
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0INSTRUCTIONS_RETIRED_OVERCOUNT,
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0BRANCHES_RETIRED_OVERCOUNT,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0INSTRUCTIONS_RETIRED_OVERCOUNT =3D (1 << 0)=
,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0BRANCHES_RETIRED_OVERCOUNT=C2=A0 =C2=A0 =C2=
=A0=3D (1 << 1),
>=20
> I want to utilize the auto-incrementing behavior of enums, without having=
 to
> resort to double-defines or anything.=20

The counter-argument to that is we need to remember to use BIT_ULL() when
generating the mask in get_pmu_errata().  But I think overall I prefer hidi=
ng
the use of a bitmask.

