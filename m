Return-Path: <linux-kernel+bounces-645966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB72AB5608
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332604A5AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57028F538;
	Tue, 13 May 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMVO8gol"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B111EB5F0
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142899; cv=none; b=cBtzTBnvYNoNEVApxyq5e1GfaazJir93s1YtOmf/s+zVcXT4lfpTQVlr+iPm3g+VijpvhSnHYqF2oZxRI36X6ErdrMpOnYuqlk13RoYjISIKzXqZVhk0MamyYZhGFswOHzqF4QrkxklzWe0lEnYHHE6ohXBMR7Dg/yRyb1+UehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142899; c=relaxed/simple;
	bh=c+q34kbRvUZ1A5FxHPWqxBi7hEvp/OdKmOyxM3Seyas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LTFMtHrIb4tfWBo1Ply4hDfCvKR4aO4uce8aHGZOr37t16RK79wJR4gVFcmZio8D/Q+BCLg8WXkPZHjxWITV/GhVKOACsg6E8rjFudaMJjIVW62jRHkrJUVpWGXuy482bEu7hROVfy8tnq3/ZO7kcMH6Q8ZaJmDy69VBUKvOd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMVO8gol; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742575c4fa6so2080850b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747142897; x=1747747697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8X0jVFckAPxaCnI7pAGE+i1A3ZXX7wi7lJ+jewe5bQU=;
        b=KMVO8goltqQ3T4YNiUyVpOXUEM38+PSbVJHXa9DM39xVtlw6AYSoBu8w/ywsK8L3+/
         1qUgqdF7itvWlbukNBjunHkoN/YWuwJFooy7qGMwGRBXzFK4wSY3OZXru9KOqmvAm7W6
         x2ZU7SyVd4ThKNhMcM5Dl+T0VBaCJwHgobJQkTdkgxouvd4tLkzVJo27vKUcaP9Bp3lN
         zSTBdxjdgu/9HckkTnTUsJZcQ0Lp3dZYoAALOsZYb75TQkSnE8nwU7Q5vb6YMMTfkDV+
         WtGwTQXj9h1nT6iO1NRA9t2EvFfFTsOIYRrs/Kf9RqF2VDjWkcKZ1ZWhKpHYGprM9OKG
         SLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747142897; x=1747747697;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8X0jVFckAPxaCnI7pAGE+i1A3ZXX7wi7lJ+jewe5bQU=;
        b=XdqqHjOtst2X9IwpIEEL2wszK636Z/ybOOKiz87vgqi77iTciwqO+/bsVOPW6p0Aci
         I7ulDecurNQccQyB4u/KAwnZDxlA2hqBskJe29Dx6KoPD+JWRFdyMdgXQFILEEzSz8r3
         jGKHH/oZp7IovY1tretW/PJZFkQDuRpqBxNJXMZkoIwrwxOEmVIHp9sOOkGNqaC2ebNY
         XM300oDHiHejy2xzolwMCZhhGQSDpXnH+QCK5vh1+bBncogJCaaJMwM6Cv/0rPUeb62g
         9Y1CFmfIEiXPksVxhFfne4V8TtIlpv3Kl0YO3B/eDE5ceXtxQ9RW/KvwS6SumNZZUnxj
         Vn4w==
X-Forwarded-Encrypted: i=1; AJvYcCV3SJPoq0dIhgXebCA1Mh3EbtG3R4M0gpMCkJ8GgtUqtR+e7q1awmR+Y+rXj0v7z2LT435qAcpyRwIjGCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGM+Uai87uIOHIionByTVxVD+QLcvJ6inLEbB89DyyKUlESeI
	4hilWxBOWC4lzLm+lsAj3J9xccmF3Hv4xpHmp6O1kFAotvLTwAzsrXkOd/7U2swC5zZWYyRy48V
	jUw==
X-Google-Smtp-Source: AGHT+IFrYTRYyI6vdzRG5DapDxsNyp8wuBVHd1nEnVFl2gCK7K8ZWOgP9cYwwdpOAgoiNdeaXO7CokwCWCk=
X-Received: from pgbem9.prod.google.com ([2002:a05:6a02:4689:b0:b1b:54f8:d2ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:438f:b0:1f5:619a:8f75
 with SMTP id adf61e73a8af0-215ababd87amr27581506637.2.1747142897657; Tue, 13
 May 2025 06:28:17 -0700 (PDT)
Date: Tue, 13 May 2025 06:28:15 -0700
In-Reply-To: <49556BAF-9244-4FE5-9BA9-846F2959ABD1@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313203702.575156-1-jon@nutanix.com> <20250313203702.575156-7-jon@nutanix.com>
 <aCI8pGJbn3l99kq8@google.com> <49556BAF-9244-4FE5-9BA9-846F2959ABD1@nutanix.com>
Message-ID: <aCNI72KuMLfWb9F2@google.com>
Subject: Re: [RFC PATCH 06/18] KVM: VMX: Wire up Intel MBEC enable/disable logic
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025, Jon Kohler wrote:
> > On May 12, 2025, at 2:23=E2=80=AFPM, Sean Christopherson <seanjc@google=
.com> wrote:
> > > On Thu, Mar 13, 2025, Jon Kohler wrote:
> >> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >> index 7a98f03ef146..116910159a3f 100644
> >> --- a/arch/x86/kvm/vmx/vmx.c
> >> +++ b/arch/x86/kvm/vmx/vmx.c
> >> @@ -2694,6 +2694,7 @@ static int setup_vmcs_config(struct vmcs_config =
*vmcs_conf,
> >> return -EIO;
> >>=20
> >> vmx_cap->ept =3D 0;
> >> + _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC=
;
> >> _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_EPT_VIOLATION_VE;
> >> }
> >> if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
> >> @@ -4641,11 +4642,15 @@ static u32 vmx_secondary_exec_control(struct v=
cpu_vmx *vmx)
> >> exec_control &=3D ~SECONDARY_EXEC_ENABLE_VPID;
> >> if (!enable_ept) {
> >> exec_control &=3D ~SECONDARY_EXEC_ENABLE_EPT;
> >> + exec_control &=3D ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> >> exec_control &=3D ~SECONDARY_EXEC_EPT_VIOLATION_VE;
> >> enable_unrestricted_guest =3D 0;
> >> }
> >> if (!enable_unrestricted_guest)
> >> exec_control &=3D ~SECONDARY_EXEC_UNRESTRICTED_GUEST;
> >> + if (!enable_pt_guest_exec_control)
> >> + exec_control &=3D ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> >=20
> > This is wrong and unnecessary.  As mentioned early, the input that matt=
ers is
> > vmcs12.  This flag should *never* be set for vmcs01.
>=20
> I=E2=80=99ll page this back in, but I=E2=80=99m like 75% sure it didn=E2=
=80=99t work when I did it that way.

Then you had other bugs.  The control is per-VMCS and thus needs to be emul=
ated
as such.  Definitely holler if you get stuck, there's no need to develop th=
is in
complete isolation.

