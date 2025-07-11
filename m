Return-Path: <linux-kernel+bounces-728442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883AB02824
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6671BC0582
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6922230BC2;
	Sat, 12 Jul 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNFaI9qo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E79224AFC
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278410; cv=none; b=HwPLR/VcmvBg3DnFd4IU9TLEUsqN4rMVvdlyo6Q4ItZtki7WT33GBzkc66ZjYNYe42UnSfdUqqLhaB448nrah6hUtfzK51Nyt3ieywoZwl7jhK6oQnZTJ1iUTgvGbGq+gNKePzaGNhMB9+kh3UK3X/HGqR3abD048DqZS9s2IkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278410; c=relaxed/simple;
	bh=PtSvbvn1QcCg0DBk1whBIsA/eSOY+4nsci4fAX624Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBgAlVd+HX0BFl8WehAvMpMkx+RtnZDOgt4CY+HUmpEANPOwl96rHYc3aPpvyWGL6HqUyd0GWI7W74MDx58GKRnKe5HGeJQzU1ngdzkCsgrHQhKnCLMRfcclORI4aotJM5gEC9lvsYpriK7OXpikRGU7X3KkevqK9D2p8NhkC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNFaI9qo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453663b7bf1so27475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752278406; x=1752883206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx2qCtcW1iHm6LrN7B3tW80PWrDcUeBrILrqk51qr+0=;
        b=DNFaI9qoFRmtnnYAALZUbvHEFHNYRoSrGUoWqp1T8a1Q1nCBUSxZhl6ihq77plrDj0
         W8KWM0qfj/wRK33eiXRvcFrrWSRGhIAYSKeQSp7LQcDCNFMZfNXva+tVt6k3V4Fcg9cr
         XUat4MWNLOMJMgpy+2CJ9LrD3HZAmWjzJmGTrBkR7j8pdv8c0x4AGvYpenDT76dQQPQd
         7NnVUbK2F9jRmEyi05PuNybiC0PXyFPI8INQsDypjRySaKwfTBaKXTamJDv897zV0QT4
         Camg+4vcbKqPmRZIgpRFQp5EtScf9gYpLNbbRbDv2bgalgqz6g0A05VD2mKTi3PXzFYL
         inow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752278406; x=1752883206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx2qCtcW1iHm6LrN7B3tW80PWrDcUeBrILrqk51qr+0=;
        b=Jo6kvNJy/M/Gt4lSGlrRZSSBVCUuGNMwDvrb8XiLtp3sSy4NOggxBrnonMd+yBfs/+
         dl1ey6N43w5/5J7FL6irbOjbyrsbrnPRvp805MrnKcfb3gr9FmRmX+Cy2jGSglHaOmu+
         qMvd/UyXuzmv1E0n+CCfb5d69qMkDLxGZy9FedkBRUtv4llh8BRUCmkdpvQ2KzWT/xlO
         gk0XSdWszDANBPf22rTlfqjkQ8G2v+7rmk7d1GnmdKK5AWhISXnD5Q23jU3zkY16H2x5
         cI906Mbn3y7gEyJQKnrSFs/Qop+C9CfsvQEH6sSKRqJu0KRkXbbtGfSJMjxthIiZzZFk
         WNyw==
X-Forwarded-Encrypted: i=1; AJvYcCUHliIsGPNpn/klBaAyD2sEsrVsBQBQO+uVooCtoJlwUzercOIsUmYYLzJsuENA2XenxHTAG0f04QThNwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuachQURulh+cdAjvTsnGe7otCyz4A0hLl+eAj4GSM9dOC83RB
	UzbdkB8gjwVSqYoeNc+KU6njHpyuLAbb3uR9UqJNOw7ZqvX01wD3pAiVizxVA8Ni+ld0DBXlyY8
	HUyI+cfUYypvBu8kOvMh42MbyHQIvXyPXhPK+oYvc
X-Gm-Gg: ASbGncv054kOcggGa48cVsTvwzTK+tn/m9sIxQWINtGRN/RWAyK1OagqmhMCKi1NQvD
	3WBoCnus9VfN/0OieFIY6ULeje6Ey3JaEolIWcJBLQTu6p7X+RV+DmTbKbr1T6ZgOgASeOqP+FH
	r80wZTPmIummUYmj6402KTWOXFD6U1HY4zqIOOfeDd7Y8NjZC2jmBnUoqY3NHMuZufgi9t0M4fM
	wyIWFzhRgzzTxTOdoa2KOlL5SZhCcE2YZfwuw==
X-Google-Smtp-Source: AGHT+IGm/4nykkyL/t8NH+t513GwsEYgWr6SSPjErflvI3eUGlmuciPanbhrR0B98Q027GSJ0c2DKA/l/x09XDzmWT0=
X-Received: by 2002:a05:600c:5023:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45604733553mr315825e9.1.1752278405508; Fri, 11 Jul 2025
 17:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com> <20250604050902.3944054-6-jiaqiyan@google.com>
 <aHFpt0qJF-Rvb2bS@linux.dev>
In-Reply-To: <aHFpt0qJF-Rvb2bS@linux.dev>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 11 Jul 2025 16:59:53 -0700
X-Gm-Features: Ac12FXxsGWdg2WMinw3VOi85RWYlMpcQBa3KtW7EiT-XKhADcP3_mP0w71DBbsg
Message-ID: <CACw3F525HQZ81riTQPuhR0moe8tNEst2AycwrGuM5xDq=oJGaw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] KVM: selftests: Test for KVM_CAP_INJECT_EXT_IABT
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:45=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Wed, Jun 04, 2025 at 05:09:00AM +0000, Jiaqi Yan wrote:
> > Test userspace can use KVM_SET_VCPU_EVENTS to inject an external
> > instruction abort into guest. The test injects instruction abort at an
> > arbitrary time without real SEA happening in the guest VCPU, so only
> > certain ESR_EL1 bits are expected and asserted.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> I reworked mmio_abort to be a general external abort test, can you add
> your test cases there in the next spin (arm64/external_aborts.c)?

For sure!

>
> Thanks,
> Oliver
>
> > ---
> >  tools/arch/arm64/include/uapi/asm/kvm.h       |  3 +-
> >  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
> >  .../testing/selftests/kvm/arm64/inject_iabt.c | 98 +++++++++++++++++++
> >  3 files changed, 101 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/kvm/arm64/inject_iabt.c
> >
> > diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64=
/include/uapi/asm/kvm.h
> > index af9d9acaf9975..d3a4530846311 100644
> > --- a/tools/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
> > @@ -184,8 +184,9 @@ struct kvm_vcpu_events {
> >               __u8 serror_pending;
> >               __u8 serror_has_esr;
> >               __u8 ext_dabt_pending;
> > +             __u8 ext_iabt_pending;
> >               /* Align it to 8 bytes */
> > -             __u8 pad[5];
> > +             __u8 pad[4];
> >               __u64 serror_esr;
> >       } exception;
> >       __u32 reserved[12];
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/s=
elftests/kvm/Makefile.kvm
> > index 9eecce6b8274f..e6b504ded9c1c 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -149,6 +149,7 @@ TEST_GEN_PROGS_arm64 +=3D arm64/arch_timer_edge_cas=
es
> >  TEST_GEN_PROGS_arm64 +=3D arm64/debug-exceptions
> >  TEST_GEN_PROGS_arm64 +=3D arm64/host_sve
> >  TEST_GEN_PROGS_arm64 +=3D arm64/hypercalls
> > +TEST_GEN_PROGS_arm64 +=3D arm64/inject_iabt
> >  TEST_GEN_PROGS_arm64 +=3D arm64/mmio_abort
> >  TEST_GEN_PROGS_arm64 +=3D arm64/page_fault_test
> >  TEST_GEN_PROGS_arm64 +=3D arm64/psci_test
> > diff --git a/tools/testing/selftests/kvm/arm64/inject_iabt.c b/tools/te=
sting/selftests/kvm/arm64/inject_iabt.c
> > new file mode 100644
> > index 0000000000000..0c7999e5ba5b3
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/arm64/inject_iabt.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * inject_iabt.c - Tests for injecting instruction aborts into guest.
> > + */
> > +
> > +#include "processor.h"
> > +#include "test_util.h"
> > +
> > +static void expect_iabt_handler(struct ex_regs *regs)
> > +{
> > +     u64 esr =3D read_sysreg(esr_el1);
> > +
> > +     GUEST_PRINTF("Handling Guest SEA\n");
> > +     GUEST_PRINTF("  ESR_EL1=3D%#lx\n", esr);
> > +
> > +     GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_IABT_CUR);
> > +     GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static void guest_code(void)
> > +{
> > +     GUEST_FAIL("Guest should only run SEA handler");
> > +}
> > +
> > +static void vcpu_run_expect_done(struct kvm_vcpu *vcpu)
> > +{
> > +     struct ucall uc;
> > +     bool guest_done =3D false;
> > +
> > +     do {
> > +             vcpu_run(vcpu);
> > +             switch (get_ucall(vcpu, &uc)) {
> > +             case UCALL_ABORT:
> > +                     REPORT_GUEST_ASSERT(uc);
> > +                     break;
> > +             case UCALL_PRINTF:
> > +                     ksft_print_msg("From guest: %s", uc.buffer);
> > +                     break;
> > +             case UCALL_DONE:
> > +                     ksft_print_msg("Guest done gracefully!\n");
> > +                     guest_done =3D true;
> > +                     break;
> > +             default:
> > +                     TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> > +             }
> > +     } while (!guest_done);
> > +}
> > +
> > +static void vcpu_inject_ext_iabt(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_events events =3D {};
> > +
> > +     events.exception.ext_iabt_pending =3D true;
> > +     vcpu_events_set(vcpu, &events);
> > +}
> > +
> > +static void vcpu_inject_invalid_abt(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_events events =3D {};
> > +     int r;
> > +
> > +     events.exception.ext_iabt_pending =3D true;
> > +     events.exception.ext_dabt_pending =3D true;
> > +
> > +     ksft_print_msg("Injecting invalid external abort events\n");
> > +     r =3D __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
> > +     TEST_ASSERT(r && errno =3D=3D EINVAL,
> > +                 KVM_IOCTL_ERROR(KVM_SET_VCPU_EVENTS, r));
> > +}
> > +
> > +static void test_inject_iabt(void)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +
> > +     vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> > +
> > +     vm_init_descriptor_tables(vm);
> > +     vcpu_init_descriptor_tables(vcpu);
> > +
> > +     vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
> > +                             ESR_ELx_EC_IABT_CUR, expect_iabt_handler)=
;
> > +
> > +     vcpu_inject_invalid_abt(vcpu);
> > +
> > +     vcpu_inject_ext_iabt(vcpu);
> > +     vcpu_run_expect_done(vcpu);
> > +
> > +     kvm_vm_free(vm);
> > +}
> > +
> > +int main(void)
> > +{
> > +     test_inject_iabt();
> > +     return 0;
> > +}
> > --
> > 2.49.0.1266.g31b7d2e469-goog
> >

