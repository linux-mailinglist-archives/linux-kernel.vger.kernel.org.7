Return-Path: <linux-kernel+bounces-727246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512AB01705
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF359583FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A98218593;
	Fri, 11 Jul 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lA/K/0ao"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2F201261
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224270; cv=none; b=UnK4SaJK1z799w+jx6+xhrNjI7MZsexanepOau7CxNhK576f9faHG3mQ3FGAg4xfBBj0/nyaiXscf9HxYL3cyNb36BB6Bymgbh0Ry+536GS7YJ3T2mwc5IHuTB9TFGCEeamG5cFMMe7K4W1LNBOiZj9KQKpwF2aHPGGiYd8/qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224270; c=relaxed/simple;
	bh=pRHMkDqV97U26JmQEq+woAi2LAZVGtP7svkWnKfjPQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxp7h2SotMMuRdwIK5fbtg+ZYUXYlNd3ds8jfVjVLKQh0/H4/n260buW8GIG73QRc3S+NuLhoxNsLH05kkdsR2DWat9DLiA7h+q967NEo05N6Pbq5jcg8Hu4ZmubE/HCIvhYh7xreDkp18dxrdcLheCfL2KO+DA61DRU3lwQpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lA/K/0ao; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso2028914a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752224268; x=1752829068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jPE3mL5y1udMtv31ER89R9IyYO4SZ2b6SdsXTbZEV0=;
        b=lA/K/0aoG7C0eC79A5ai8HjjGyfIskeVXRtIfJQuzMX/Za8fUzYRxLwbiKkeX8ddmy
         eS6r1gvXbLftMYT7DbI4kmD7kobSHB0nLrjyyEGGvLqQ1d1Rv3tGNrrgHd+qMTRZpY1/
         s+e5q1KWrLm4kgNS0nfLmhNasnodxWACExZn4oCcsKv1ohQiGIEL2ON6v1gG4lkDrd42
         8fBye2bSsHb4YEIQn42V+du3yTnyxqkv3mVPNncvmLKd2ohuhvAxxsiYFFiBP7ICU137
         hzQdM8sdT7mUXvBNz4BWtmzJE6gD4bfptiALvBOeOuCxjCKy6L//oM+gHniUV1PGxg8D
         SYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224268; x=1752829068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jPE3mL5y1udMtv31ER89R9IyYO4SZ2b6SdsXTbZEV0=;
        b=rJk4THkx2/JY1pnD5l/Frbj0H1bSHuNg3WeYzzThZb4uiNjw4T+pMlWbDhf5UQzEVx
         EPTU6J9ra3VBY7d/ZhcpQM0/eZMsycMUNtCfftFxvyrEGpJykiv7hIPZRDT1XFfON0+e
         0oNHTkWCnIQnA03+9qjGiIGB3R3k5EQG/CHhJgFoTG2sltDCA4lKZnD5reXxjS1HON77
         tMapJ15BwOWtZaC9bMV4mEas9fMN3O9gVTYZcg/fgKwFuzoHaNMDwlk/9HuWfprdhEYR
         ycLb72WYNA6Hvy144hLUTNvkb4gXcVPBDZuozhUHR7XRGeoqZAnViJ4uILksiA6xDmvW
         kJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOaL98z9M/a0N+QCLnwtSXrOykt1iEiAgO8Kedk4pM8ltqGVSRhPoeJO7/V7Smadv2Dy7EJ6ogalV9JdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1v7IG12q5IZ8NXV7pA/IPljS3Lt2SrlEkLpGf8Z9ik6nSmODT
	IvNSmUftdNyKgZ95ZbokdXb7MHJz+O5GGsI3iEgldID/uP7FHud920k7gfP5ZOHcauW83f/md7n
	xK6umEBwqbE0oG+9m2k5U6pd51+MLxID1E/x+crHp0g==
X-Gm-Gg: ASbGncvDxEQ90dThxUL/DM30vU5q4Pe27JdJYadRazAscjNpx5zSBK7GAf5LiH2TamR
	mleRSX6SRu7CHo7h0A5zvmROtt8g04/iXARP/fmdOvn2zIcnyMbECg6CdNmPzyXFtPgAmKiX8bU
	RhfPfTdNeECyLFvwwe8yHbmL4oYqnnl9om++6is+hEtRSyHDjuWhrI5qct7XXypPI1vyJAGW9vf
	keQDRWqEFVoW6bsrMdt
X-Google-Smtp-Source: AGHT+IGK/U+DIO6wfNWGGall2Awzk7CE4ogxDlD3/mORB2QJIQwmSRHRTeEmJGi1pr+O0MdSB9VbBzHvyfMIotCxim0=
X-Received: by 2002:a17:90b:384c:b0:312:51a9:5d44 with SMTP id
 98e67ed59e1d1-31c4ca64de6mr3517873a91.5.1752224267719; Fri, 11 Jul 2025
 01:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710133030.88940-1-luxu.kernel@bytedance.com> <CAK9=C2W60a2otfJKucJc_d4=X9YBTep1zSp+wa8E7-kL7tJR0Q@mail.gmail.com>
In-Reply-To: <CAK9=C2W60a2otfJKucJc_d4=X9YBTep1zSp+wa8E7-kL7tJR0Q@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 11 Jul 2025 16:57:35 +0800
X-Gm-Features: Ac12FXySh83P0GWh89XB-YNqsR5yVEel47k01hOQLXeLmyXAGpkJZ76LaWl1N8k
Message-ID: <CAPYmKFur4asd4bzCBgCwrPpMK9amihWSeK2Vwpk1mGjK_Fy29g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] RISC-V: KVM: Delegate kvm unhandled
 faults to VS mode
To: Anup Patel <apatel@ventanamicro.com>
Cc: rkrcmar@ventanamicro.com, cleger@rivosinc.com, anup@brainfault.org, 
	atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:28=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Thu, Jul 10, 2025 at 7:00=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com>=
 wrote:
> >
> > Delegate faults which are not handled by kvm to VS mode to avoid
> > unnecessary traps to HS mode. These faults include illegal instruction
> > fault, instruction access fault, load access fault and store access
> > fault.
> >
> > The delegation of illegal instruction fault is particularly important
> > to guest applications that use vector instructions frequently. In such
> > cases, an illegal instruction fault will be raised when guest user thre=
ad
> > uses vector instruction the first time and then guest kernel will enabl=
e
> > user thread to execute following vector instructions.
> >
> > The fw pmu event counters remain undeleted so that guest can still get
> > these events via sbi call. Guest will only see zero count on these
> > events and know 'firmware' has delegated these faults.
>
> Currently, we don't delegate illegal instruction faults and various
> access faults to Guest because we allow Guest to count PMU
> firmware events. Refer, [1] and [2] for past discussions.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2024-August/059658.h=
tml
> [2] https://lore.kernel.org/all/20241224-kvm_guest_stat-v2-0-08a77ac36b02=
@rivosinc.com/
>
> I do understand that additional redirection hoop can slow down
> lazy enabling of vector state so drop delegating various access
> faults.

Roger that. I will resend the patch and only delegate illegal insn fault.

>
> Regards,
> Anup
>
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >  arch/riscv/include/asm/kvm_host.h |  4 ++++
> >  arch/riscv/kvm/vcpu_exit.c        | 18 ------------------
> >  2 files changed, 4 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm=
/kvm_host.h
> > index 85cfebc32e4cf..e04851cf0115c 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -44,7 +44,11 @@
> >  #define KVM_REQ_STEAL_UPDATE           KVM_ARCH_REQ(6)
> >
> >  #define KVM_HEDELEG_DEFAULT            (BIT(EXC_INST_MISALIGNED) | \
> > +                                        BIT(EXC_INST_ACCESS)     | \
> > +                                        BIT(EXC_INST_ILLEGAL)    | \
> >                                          BIT(EXC_BREAKPOINT)      | \
> > +                                        BIT(EXC_LOAD_ACCESS)     | \
> > +                                        BIT(EXC_STORE_ACCESS)    | \
> >                                          BIT(EXC_SYSCALL)         | \
> >                                          BIT(EXC_INST_PAGE_FAULT) | \
> >                                          BIT(EXC_LOAD_PAGE_FAULT) | \
> > diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> > index 6e0c184127956..6e2302c65e193 100644
> > --- a/arch/riscv/kvm/vcpu_exit.c
> > +++ b/arch/riscv/kvm/vcpu_exit.c
> > @@ -193,11 +193,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
> >         ret =3D -EFAULT;
> >         run->exit_reason =3D KVM_EXIT_UNKNOWN;
> >         switch (trap->scause) {
> > -       case EXC_INST_ILLEGAL:
> > -               kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ILLEGAL_INS=
N);
> > -               vcpu->stat.instr_illegal_exits++;
> > -               ret =3D vcpu_redirect(vcpu, trap);
> > -               break;
> >         case EXC_LOAD_MISALIGNED:
> >                 kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_MISALIGNED_=
LOAD);
> >                 vcpu->stat.load_misaligned_exits++;
> > @@ -208,19 +203,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
> >                 vcpu->stat.store_misaligned_exits++;
> >                 ret =3D vcpu_redirect(vcpu, trap);
> >                 break;
> > -       case EXC_LOAD_ACCESS:
> > -               kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_LOAD=
);
> > -               vcpu->stat.load_access_exits++;
> > -               ret =3D vcpu_redirect(vcpu, trap);
> > -               break;
> > -       case EXC_STORE_ACCESS:
> > -               kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ACCESS_STOR=
E);
> > -               vcpu->stat.store_access_exits++;
> > -               ret =3D vcpu_redirect(vcpu, trap);
> > -               break;
> > -       case EXC_INST_ACCESS:
> > -               ret =3D vcpu_redirect(vcpu, trap);
> > -               break;
> >         case EXC_VIRTUAL_INST_FAULT:
> >                 if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
> >                         ret =3D kvm_riscv_vcpu_virtual_insn(vcpu, run, =
trap);
> > --
> > 2.20.1
> >
> >

