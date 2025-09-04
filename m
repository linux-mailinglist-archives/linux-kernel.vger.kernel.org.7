Return-Path: <linux-kernel+bounces-801491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB870B445B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6B3547566
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9E253956;
	Thu,  4 Sep 2025 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zt77tJU/"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9D1E3DFE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011569; cv=none; b=n2EjbAbMX6gYg3KgtyUNijOzs7YpBlAMj/CBh3XYtvvECu1Dzhm07DfWrFJ32Au/GWAlTH25aGg3iZKeh9Qo012AtTjziymQv1bYATo2GM1FIYBTEQtiv6kBE4sCgxVHbMQ4FSXzKa7K5aU/diXeXJvsurJ2WmP/ICwnxOvWM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011569; c=relaxed/simple;
	bh=lvuwRmNZNM7aSL/GeaizMNzN5z2gDAqq7f4Bxl2+g5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjB2o+yjwZ/7IQYA/FfivXU+q2ALBgrW99r/RzT5sDmdiZnuOKU771Q2eauTb/NlTjBCHkQ02k0VvhB97dnYBbJ9GVU64s8u+r0cTbMZVpeqtVqZ4I/z655Y2kKmRq340jONYUTl6TkLSC8VCbdA0kGTTh5GW3ol2+WfuldyHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zt77tJU/; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e9d74ec040cso879641276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757011567; x=1757616367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMO3Rs3kVsbeR9kpL3G2iwG3KSDbb6leHyCteNZWJKU=;
        b=Zt77tJU/S7/4wbkTKrWks5+MLgDI1RO0M1xym5NvnxBx7Et6iV5qwFviZyOKRSkVBc
         FMAClKvBs//jl6iQ5vb+q2xzwUWjRfFQNfLJistGfZYLCOajqL91xTBB/abZNYXb+nqH
         2MVP6l8ZiJVdLlQ3zQm9LBbY4OhO5u/Qo4XTh/d+KuyBps+VFHqeEJuXcsgEty52kqpy
         HWRokTSahu5ZqCXz9DstpOGWy4aXse0j2AAmHFURZh6lpyq5uAxYvRdQkRCoyOLyFKdM
         puSCgGKV+AW3aQCw2mEk0qyTgLtdU8G/0iz6s800aUPw/KArR6gvs1XcLUHJNWHSaUzx
         o9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757011567; x=1757616367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMO3Rs3kVsbeR9kpL3G2iwG3KSDbb6leHyCteNZWJKU=;
        b=OpoBf4k8VpWtHuEyoUmbDJeT0x/FV42SRRrtkHIXqtjc1lxx4RdVFG0PoIypI+c1MH
         5y6Ro4lyC0GMh245ix2BjuEDbYSP4qM/UuEv0qElcEtKzfX0Vs6g1BKCG4zc67EtxN5k
         ytTNc9IPPAIE75YJVsl5/jQXrxsjBb2G54p+QCmUuyPNyUQOx+So3zHNbi7cbMhM2kF0
         kG8qaE/RCTkqeqSuYJeD2CQkTbQOXJQfoKUvYnFKajwXGjauLygQNN+zZHz/IzcHiLPw
         1JbyxeGXmMGM6GOFRmHzvVoBJBWe9VuxhblKVBusU80D8idjv679uztuJ8ujCRuZ8rQs
         T/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgJ9na2txRnkxG16mXxOOYHGPlGwEJtLTzpOexzjWTlcU6SqJG+VXKi8S+Ta3IjAKlc2k2ceWjIoWDDFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMwf7aIusNVhejH4O83if2OjKvz02j1NGc/m/VttVubwdweyQ
	O+fVmq5k9fjW/zcfk43sGz5VYCxYmI4NQ6sNZBZEBgT0ki7G3Lsv3Lo5hfhWOqWgSiRg8cz0jR8
	hU7zpTBh0oTIE3iOsmNB9xgdhKJB+hJiilM1BXmU1
X-Gm-Gg: ASbGncsOaVbKGJ6fn6PB6V666JIPIpRxdMvpq0n1ro7fvhLqFbEQ82m01oHMQJf+wXY
	+BcRBn+JKO52u1gABD+0WWCUzATDHZVkqTnH6ZMCQm5IAtjy3QuQNPnD1FS42aJ/tSJ8WrELeRs
	gW0bmp/OcMcXzihbqWpe9Dc6mqhxmJpnuJkQg9TVfsueXWrHTcF0xvbuXx+Bx+FP266TG4857RV
	rSsd9YuWperkHyuqILUKM1ZhwnCMpeDO36OZ89Ib3hnaT82xnoZfCg=
X-Google-Smtp-Source: AGHT+IGn9N+homcANGMwR4jfEFzD2NCD2KcIcBhFWplr8ibSUoc3dBeDSKfXSBSRcFnFSDBlKc1RK8qrGOI6Pnn1inw=
X-Received: by 2002:a05:690c:f86:b0:71c:40c9:b0d1 with SMTP id
 00721157ae682-72276134719mr229604487b3.0.1757011566319; Thu, 04 Sep 2025
 11:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618042424.330664-1-jthoughton@google.com> <de7da4d8-0e9d-46f2-88ec-cfd5dc14421c@amazon.com>
In-Reply-To: <de7da4d8-0e9d-46f2-88ec-cfd5dc14421c@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 4 Sep 2025 11:45:30 -0700
X-Gm-Features: Ac12FXzXQ2J2IObwStpXP8KUnuPjviPOSORfujA1_ZEACSuvKQLNHacmBk1cLV0
Message-ID: <CADrL8HVxvwB4JrnUf6QtDCyzZojEvR4tr-ELEn+fL8=1cnbMQQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] KVM: Introduce KVM Userfault
To: kalyazin@amazon.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Yan Zhao <yan.y.zhao@intel.com>, Anish Moorthy <amoorthy@google.com>, 
	Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:43=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.com=
> wrote:
>
>
>
> On 18/06/2025 05:24, James Houghton wrote:
> > Hi Sean, Paolo, Oliver, + others,
> >
> > Here is a v3 of KVM Userfault. Thanks for all the feedback on the v2,
> > Sean. I realize it has been 6 months since the v2; I hope that isn't an
> > issue.
> >
> > I am working on the QEMU side of the changes as I get time. Let me know
> > if it's important for me to send those patches out for this series to b=
e
> > merged.
>
> Hi Sean and others,
>
> Are there any blockers for merging this series?  We would like to use
> the functionality in Firecracker for restoring guest_memfd-backed VMs
> from snapshots via UFFD [1].  [2] is a Firecracker feature branch that
> builds on top of KVM userfault, along with direct map removal [3], write
> syscall [4] and UFFD support [5] in guest_memfd (currently in discussion
> with MM at [6]) series.

Glad to hear that you need this series. :)

I am on the hook to get some QEMU patches to demonstrate that KVM
Userfault can work well with it. I'll try to get that done ASAP now
that you've expressed interest. The firecracker patches are a nice
demonstration that this could work too... (I wish the VMM I work on
was open-source).

I think the current "blocker" is the kvm_page_fault stuff[*]; KVM
Userfault will be the first user of this API. I'll review that series
in the next few days. I'm pretty sure Sean doesn't have any conceptual
issues with KVM Userfault as implemented in this series.

[*]: https://lore.kernel.org/linux-arm-kernel/20250821210042.3451147-1-sean=
jc@google.com/

>
> Thanks,
> Nikita
>
> [1]:
> https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapsho=
tting/handling-page-faults-on-snapshot-resume.md
> [2]:
> https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hi=
ding
> [3]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.u=
k
> [4]: https://lore.kernel.org/kvm/20250902111951.58315-1-kalyazin@amazon.c=
om
> [5]: https://lore.kernel.org/kvm/20250404154352.23078-1-kalyazin@amazon.c=
om
> [6]:
> https://lore.kernel.org/linux-mm/20250627154655.2085903-1-peterx@redhat.c=
om

