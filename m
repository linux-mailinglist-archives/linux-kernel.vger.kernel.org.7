Return-Path: <linux-kernel+bounces-626634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C274BAA457E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC4E9C3D88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E0021A92F;
	Wed, 30 Apr 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jus7eEVg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE7218587
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001790; cv=none; b=ffrHglXUVskiHRd+y3Yxwz83MsI1E0NJl7btTOyBiVYWKCHvU9b6a/gb1dd0IgIqXhBYvozDNmxTMjiwD7Y2/SUmKavwqxsDZSZCd9PSf6DvlvlYlfAuwGOzDyadsQ2yLaIT5oUSLuTs1d+S8A7MZrJShTcRNdy6AIOeu4wsH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001790; c=relaxed/simple;
	bh=dCZ5RwLhubKFun+DSZWL9Mj0JRav3cRy/OY3ps7NlAU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=k8HxeSWTnocbyo39fS9ph8Ps73kBQd/MguRR6V7mjc//JL+rJEeLJCiJEbu2kkeZ+OmNb/U69bPhkgCp0XLDfvNsLd64z6jzrFJjBM0BK5SlSpAXYtG9ImL3gv19Oh9pqvfnKWSAXcnXv8ox8n+G64YKSidFuqjLNghJElfgiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jus7eEVg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so8091735e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1746001785; x=1746606585; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjLDCSYme2TvJ6cWJlZ375xtH0fHLFeKajOPyMJ/Dkc=;
        b=Jus7eEVgnSKG7vzn5o7yxPF7fP8USHyllBB/3fpkj4dzxD1D8FrL+6pWB4jnk3aDZ8
         IvfuSLtg40zPV76D+qFY4QyIPrNJn2rVwEiX4Sgbb1hKE2p9QNxJ8/rQ5Kear3KEXQcK
         +r1JgjjDKzWLPtHn2e4B0qcee+oUHMvYWJ0T/iHnxDn3aB1cNs/d7bOtgkTIUieR3gjo
         wNd6IgN/5K1pUwzZLDLs7UuEwM2QhUQil21dBKEVlEI9oitt9/U3u/gwRklgePgPJysJ
         /uXcqCBIPmWkTzsEHs1vP06K0du8yJUPqvzbqnANTrWKEVGd00LYlDme0LO2j3hTfJrB
         /XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001785; x=1746606585;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bjLDCSYme2TvJ6cWJlZ375xtH0fHLFeKajOPyMJ/Dkc=;
        b=Wifk4PWO+nQ5mi4Hk0WLedQeOrLCAgde7fynyhlTfJPRUlR23TOEBepjIJua+BEjky
         CUx5UP7iK+C14/QaqJIqodmC3XXgpS/23A9mgEEE46l1JKbnkfZQmGEiS/2sd0jGyuVP
         ZDnqb1ARMaKZIn3bHeVb2GzgaapAT3NBE8ORRzncNsy0SRFeRj35TjQiSEQK0hrM7fCA
         aVjNc26K8ZABZ2HLx8VTZPBAUxIDzZPMN5v62YTBhsH5Yy+QiZ3oCJNXa5nVoKArGXO3
         Wo1/0LOR6h6cwVkeS7G0IXT6Zwfmg4VabI7v53W/GZXgeoDLohmde5BznfB6j9wWsZp1
         xZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH2J1ate217TMt7zWDHwt4Imr3zCUAQsbt8dE3ThUeCvWZbClLqiO15Rpe4w46USUGGeAPXBQ8j2ham6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfu9IV3Yzjw08OgxJoQWLl/86pBiakodKD7T/HKAnUTEYwN8Wc
	Ly4X1nR2N7cpOfJcxKiJhBgj8QqPL9418PZkX7JY67BBvE0Vpo0aHa7mj5wa5bo=
X-Gm-Gg: ASbGnctnphzVaE4sRIoDTQQBVsHRj9XIt9nUTku+v9NkiUn1BkwZ1AEgcA3cf7QYN/n
	cUa/3rUqAxxNfux+QDEijU1J1acCg7HvhhS7StiYo32VuXO5BHiaMNw7mP+fE4XNKeejF+D6/1L
	hh9B6qxUOgkim7Ajy8615G7fAajW9KnJdtvKgVr4bi5WlfJI1lh8E9KhRGsPh45tLrpnHImh3Pk
	TcDQkSBLn0hPQUo7dQzEv8IT++fouxrwIAwRX9P1zwHy3i3iWhiO1NF6/Hbn+0ikJsnsnf4G3OT
	0DcbzWc1vETMfhfvfBbESCoa7Uhx1cIE44V+cg1WkbFuq7HZ2DsifKP67RlIKKtuecAv1PE4ruO
	0
X-Google-Smtp-Source: AGHT+IElJ6bzFuyM/pSP5u9AllDzzrZUuMITibyohlqbbv+eRenSAoVF4bi3E9BpC3i9wIEQOj9V1g==
X-Received: by 2002:a05:600c:4e8e:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-441b1f618f3mr6085885e9.7.1746001785148;
        Wed, 30 Apr 2025 01:29:45 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b9726fsm16193745e9.8.2025.04.30.01.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Apr 2025 10:29:44 +0200
Message-Id: <D9JTZ6HH00KY.1B1SKH1Z0UI1S@ventanamicro.com>
Subject: Re: [PATCH 4/5] KVM: RISC-V: reset VCPU state when becoming
 runnable
Cc: "Anup Patel" <apatel@ventanamicro.com>, <kvm-riscv@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Atish Patra" <atishp@atishpatra.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Andrew Jones" <ajones@ventanamicro.com>, "Mayuresh
 Chitale" <mchitale@ventanamicro.com>
To: "Anup Patel" <anup@brainfault.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250403112522.1566629-3-rkrcmar@ventanamicro.com>
 <20250403112522.1566629-7-rkrcmar@ventanamicro.com>
 <CAAhSdy0e3HVN6pX-hcX2N+kpwsupsCf6BqrYq=bvtwtFOuEVhA@mail.gmail.com>
 <D9IGJR9DGFAM.1PVHVOOTVRFZW@ventanamicro.com>
 <CAK9=C2Woc5MtrJeqNtaVkMXWEsGeZPsmUgtFQET=OKLHLwRbPA@mail.gmail.com>
 <D9J1TBKYC8YH.1OPUI289U0O2C@ventanamicro.com>
 <CAAhSdy01yBBfJwdTn90WeXFR85=1zTxuebFhi4CQJuOujVTHXg@mail.gmail.com>
 <D9J9DW53Q2GD.1PB647ISOCXRX@ventanamicro.com>
 <CAAhSdy0B-pF-jHmTXNYE7NXwdCWJepDtGR__S+P4MhZ1bfUERQ@mail.gmail.com>
 <CAAhSdy20pq3KvbCeST=h+O5PWfs2E4uXpX9BbbzE7GJzn+pzkA@mail.gmail.com>
In-Reply-To: <CAAhSdy20pq3KvbCeST=h+O5PWfs2E4uXpX9BbbzE7GJzn+pzkA@mail.gmail.com>

2025-04-30T10:56:35+05:30, Anup Patel <anup@brainfault.org>:
> On Wed, Apr 30, 2025 at 9:52=E2=80=AFAM Anup Patel <anup@brainfault.org> =
wrote:
>>
>> On Tue, Apr 29, 2025 at 9:51=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkr=
cmar@ventanamicro.com> wrote:
>> >
>> > 2025-04-29T20:31:18+05:30, Anup Patel <anup@brainfault.org>:
>> > > On Tue, Apr 29, 2025 at 3:55=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 =
<rkrcmar@ventanamicro.com> wrote:
>> > >>
>> > >> 2025-04-29T11:25:35+05:30, Anup Patel <apatel@ventanamicro.com>:
>> > >> > On Mon, Apr 28, 2025 at 11:15=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=
=99 <rkrcmar@ventanamicro.com> wrote:
>> > >> >>
>> > >> >> 2025-04-28T17:52:25+05:30, Anup Patel <anup@brainfault.org>:
>> > >> >> > On Thu, Apr 3, 2025 at 5:02=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=
=C5=99 <rkrcmar@ventanamicro.com> wrote:
>> > >> >> >> For a cleaner solution, we should add interfaces to perform t=
he KVM-SBI
>> > >> >> >> reset request on userspace demand.  I think it would also be =
much better
>> > >> >> >> if userspace was in control of the post-reset state.
>> > >> >> >
>> > >> >> > Apart from breaking KVM user-space, this patch is incorrect an=
d
>> > >> >> > does not align with the:
>> > >> >> > 1) SBI spec
>> > >> >> > 2) OS boot protocol.
>> > >> >> >
>> > >> >> > The SBI spec only defines the entry state of certain CPU regis=
ters
>> > >> >> > (namely, PC, A0, and A1) when CPU enters S-mode:
>> > >> >> > 1) Upon SBI HSM start call from some other CPU
>> > >> >> > 2) Upon resuming from non-retentive SBI HSM suspend or
>> > >> >> >     SBI system suspend
>> > >> >> >
>> > >> >> > The S-mode entry state of the boot CPU is defined by the
>> > >> >> > OS boot protocol and not by the SBI spec. Due to this, reason
>> > >> >> > KVM RISC-V expects user-space to set up the S-mode entry
>> > >> >> > state of the boot CPU upon system reset.
>> > >> >>
>> > >> >> We can handle the initial state consistency in other patches.
>> > >> >> What needs addressing is a way to trigger the KVM reset from use=
rspace,
>> > >> >> even if only to clear the internal KVM state.
>> > >> >>
>> > >> >> I think mp_state is currently the best signalization that KVM sh=
ould
>> > >> >> reset, so I added it there.
>> > >> >>
>> > >> >> What would be your preferred interface for that?
>> > >> >>
>> > >> >
>> > >> > Instead of creating a new interface, I would prefer that VCPU
>> > >> > which initiates SBI System Reset should be resetted immediately
>> > >> > in-kernel space before forwarding the system reset request to
>> > >> > user space.
>> > >>
>> > >> The initiating VCPU might not be the boot VCPU.
>> > >> It would be safer to reset all of them.
>> > >
>> > > I meant initiating VCPU and not the boot VCPU. Currently, the
>> > > non-initiating VCPUs are already resetted by VCPU requests
>> > > so nothing special needs to be done.
>>
>> There is no designated boot VCPU for KVM so let us only use the
>> term "initiating" or "non-initiating" VCPUs in context of system reset.

That is exactly how I use it.  Some VCPU will be the boot VCPU (the VCPU
made runnable by KVM_SET_MP_STATE) and loaded with state from userspace.

RISC-V doesn't guarantee that the boot VCPU is the reset initiating
VCPU, so I think KVM should allow it.

>> > Currently, we make the request only for VCPUs brought up by HSM -- the
>> > non-boot VCPUs.  There is a single VCPU not being reset and resetting
>> > the reset initiating VCPU changes nothing. e.g.
>> >
>> >   1) VCPU 1 initiates the reset through an ecall.
>> >   2) All VCPUs are stopped and return to userspace.
>>
>> When all VCPUs are stopped, all VCPUs except VCPU1
>> (in this example) will SLEEP because we do
>> "kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP)"
>> so none of the VCPUs except VCPU1 (in this case) will
>> return to userspace.

Userspace should be able to do whatever it likes -- in my example, all
the VCPUs are brought to userspace and a different boot VCPU is
selected.

(Perhaps userspace wanted to record their reset pre-reset state, or
 maybe it really wants to boot with a designated VCPU.)

>> >   3) Userspace prepares VCPU 0 as the boot VCPU.
>> >   4) VCPU 0 executes without going through KVM reset paths.
>>
>> Userspace will see a system reset event exit for the
>> initiating VCPU by that time all other VCPUs are already
>> sleeping with mp_state =3D=3D KVM_MP_STATE_STOPPED.
>>
>> >
>> > The point of this patch is to reset the boot VCPU, so we reset the VCP=
U
>> > that is made runnable by the KVM_SET_MP_STATE IOCTL.
>>
>> Like I said before, we don't need to do this. The initiating VCPU
>> can be resetted just before exiting to user space for system reset
>> event exit.

You assume initiating VCPU =3D=3D boot VCPU.

We should prevent KVM_SET_MP_STATE IOCTL for all non-initiating VCPUs if
we decide to accept the assumption.

I'd rather choose a different design, though.

How about a new userspace interface for IOCTL reset?
(Can be capability toggle for KVM_SET_MP_STATE or a straight new IOCTL.)

That wouldn't "fix" current userspaces, but would significantly improve
the sanity of the KVM interface.

> Below is what I am suggesting. This change completely removes
> dependency of kvm_sbi_hsm_vcpu_start() on "reset" structures.

I'd keep the reset structure in this series -- it's small enough and
locklessly accessing the state of another VCPU needs a lot of
consideration to prevent all possible race conditions.

Thanks.

