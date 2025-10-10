Return-Path: <linux-kernel+bounces-848197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524DBCCDDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0031A626EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935A28BABA;
	Fri, 10 Oct 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="avTqcA/A"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85616215077
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099045; cv=none; b=KcLGaFiGWWQMvCrNrUTu982oERqnzwRMTdk3Ha/rO3kC4rA/Eg8lp+rSzELxw+39+AFkcRzOE3uECxtnXzjvMXEccxEUepIPwKhzvoK+7CYXRrD3BIfExILmjpja3fPz+9qhUdd6Qi4wc+gMpWu1pv7fPTOJdHF9fY/si4Mfb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099045; c=relaxed/simple;
	bh=VikWKkG6XHYuWwJ0LqHNlM5SlI2m77fONIHGfB8p2Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYktFCb33uI6q+2TN8erUjTWW8utB1S1PGoy5Sd5kuVEARMmuP6AM2C1zuvb/sbDh8JHLXSmvzgaMSx0+jqN31IbT6FCtWtF2G8Kobmyfsl8/RVL5V0WdbLpW4Lyfi5Qtek+C88ekYO+uzWqk11V/rw2Ls3j9rR+IGBaMEg+JQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=avTqcA/A; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ac1ad95537so1244695fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760099042; x=1760703842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro3+kAua24TbasdwiZJ06Dvn43ZJ82YF71cQ3Adsr5c=;
        b=avTqcA/AGhLSEJAM8YTPgQhjh9A2LsH1eUfofQit4z68EM1lCqbdmxwCcoGnpdLsx6
         Z0V3pS8cjCKUSdFFgBs3niZtyC9DX0eH5EGXpsK46goZNvTFDnE8eRMAB3aLSyUqzMPb
         dT0M6aVPbz4VZ9+1bjX7OLlP0sOodACS0C5XyQpt5hyUgg/p6nd+y0vXGZe18GapMLCq
         fLhByM5Zgmjw8EWJ5A4mhr4ocGdPV5oBV6veXOYu3O0mYEKciFTEO4cUvaHPDZi3tGmC
         N5CZrbhyPtOpPl8gZ2EZphOcmy3EgK14pZiPPhtXWLTbV3t2XMl12Kv0mJF3tsOVCe1S
         cw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099043; x=1760703843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro3+kAua24TbasdwiZJ06Dvn43ZJ82YF71cQ3Adsr5c=;
        b=cg88lim8gY/w137ZsiKbZzxzMkD81H94AYb+8c0H2llNbyz9zdkdRrgZH4DoDLsGEL
         4sH3CTnKEw92OuN7YW/2qfEFlbx+LSCGKsUD5y4ZlBsiOgi2iccnUgsHeCGvUunEbjy4
         JeO6oX1SATXtvuk0s0EGakuD5ep0b86/OQJD9HK4p1VekIM44u7gZhIYjdrRLXC6XAng
         lorD7mL2DShR/a6v7pJBYBpDkoAPJDxHnqcBmkrGwjo3bh87s57RaEs0/FS34kcfVFMx
         fWrglaGEOZnLBZQDjpiG64VPwRMclPJFsjbmhUeJJWZ/BcN12Y5EZ/v8llwIVHYxmeo4
         5FSg==
X-Forwarded-Encrypted: i=1; AJvYcCWSWiFj/CYk+ZQe8oFj1kOc5FUJbF2WzH4/kxQ55Zm0/IbwbKqBhQe2gA7G5wdU01l4QFJgbSkYFd9IKg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhj0jIcE9PKggm49YBLFlCqYI/Sas/vHFZczVJZo6qM4VU5dEm
	oR2gm1IuF3wGUzbrgoaGohyw/IgoiPRixWsk+1NOyFM3KqHyaoDChECATkSBS3bBx4Nh68713Tx
	HS1b8pWax25Jg2OMvo2J2L1LlFBAXvQYwcolAol4t6A==
X-Gm-Gg: ASbGncvvQaP0kBEY251UI3hc+vCxugl6YOnv35aJCP4bdYWSMBvN7Fx58AyJ6/Z8y4c
	FIdSZBwk2fJJvBxCCBkpfFiYCuZS4BKbs1H0F5NCC5ZnA8EA7R1w2USnGRGt82o4lvbUTibCFWR
	KqlgmTCOkcqQ2oB2YUe+mUfn/qdl4XLyMCuo1XIf/xsLDy3viA84fq/VZR06usk83nOw7vBwJ8l
	3YQs573BdJSWn+JgC/UPaaq2BJ6tkgX/CTmYRs=
X-Google-Smtp-Source: AGHT+IFwxCA7x9/0sbYa1+iquw2dNW2ztO7RgA5N9vNqLZKjJ8WptOtg61iPfZU7eyB/c+01KuJjQS2dtnsOgkC9/no=
X-Received: by 2002:a05:6870:d372:b0:3a5:81b0:8339 with SMTP id
 586e51a60fabf-3c0f91a8ef0mr5229274fac.31.1760099042537; Fri, 10 Oct 2025
 05:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
In-Reply-To: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 10 Oct 2025 20:23:50 +0800
X-Gm-Features: AS18NWBjm-gW9xf5A556itmFvcxR3HUB5zONSZ2JAVqk6TC55UaCFUsRW7mLiVI
Message-ID: <CAEEQ3w=3pte5=CR9-R3rmCGFZ9ErJ9YcWS9i=JwPUb1Ty3ipwQ@mail.gmail.com>
Subject: Re: [External] [PATCH v4 0/3] RISC-V: Detect Ssqosid extension and
 handle srmcfg CSR
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Adrien Ricciardi <aricciardi@baylibre.com>, James Morse <james.morse@arm.com>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, guo.wenjia23@zte.com.cn, 
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Oct 8, 2025 at 2:22=E2=80=AFPM Drew Fustini <fustini@kernel.org> wr=
ote:
>
> This series adds support for the RISC-V Quality-of-Service Identifiers
> (Ssqosid) extension [1] which adds the srmcfg register. This CSR
> configures a hart with two identifiers: a Resource Control ID (RCID)
> and a Monitoring Counter ID (MCID). These identifiers accompany each
> request issued by the hart to shared resource controllers.
>
> Background on RISC-V QoS:
>
> The Ssqosid extension is used by the RISC-V Capacity and Bandwidth
> Controller QoS Register Interface (CBQRI) specification [2]. QoS in
> this context is concerned with shared resources on an SoC such as cache
> capacity and memory bandwidth. Intel and AMD already have QoS features
> on x86 and ARM has MPAM. There is an existing user interface in Linux:
> the resctrl virtual filesystem [3].
>
> The srmcfg CSR provides a mechanism by which a software workload (e.g.
> a process or a set of processes) can be associated with an RCID and an
> MCID. CBQRI defines operations to configure resource usage limits, in
> the form of capacity or bandwidth. CBQRI also defines operations to
> configure counters to track the resource utilization.
>
> Goal for this series:
>
> These patches are taken from the implementation of resctrl support for
> RISC-V CBQRI. Please refer to the proof-of-concept RFC [4] for details
> on the resctrl implementation. More recently, I have rebased the CBQRI
> support on mainline [5]. Big thanks to James Morse for the tireless
> work to extract resctrl from arch/x86 and make it available to all
> architectures.
>
> I think it makes sense to first focus on the detection of Ssqosid and
> handling of srmcfg when switching tasks. It has been tested against a
> QEMU branch that implements Ssqosid and CBQRI [6]. A test driver [7]
> was used to set srmcfg for the current process. This allows switch_to
> to be tested without resctrl.

Could we consider submitting the entire QoS functionality as a single
integrated patchset (indicating the upstream branch that the patchset
is based on)? This should include the content from
https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylib=
re.com/


>
> [1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> [2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> [3] https://docs.kernel.org/filesystems/resctrl.html
> [4] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@=
baylibre.com/
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log=
/?h=3Db4/cbqri
> [6] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-rqsc-pptt
> [7] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log=
/?h=3Db4/ssqosid-debug
>
> Changes in v4:
>  - Rebase on riscv/for-next as of riscv-for-linus-6.18-mw2
>  - Add Conor's Acked-by to the yaml patch
>  - Link to v3: https://lore.kernel.org/all/20250920-ssqosid-v6-17-rc5-v3-=
0-5093162922d8@kernel.org/
>
> Changes in v3:
>  - Fix parameter in __switch_to_srmcfg() when CONFIG_RISCV_ISA_SSQOSID
>    is not set to avoid error in clang. This does trigger checkpatch
>    warning about "Argument '__next' is not used in function-like macro"
>    but it seems that '__switch_to_srmcfg(__next)' is needed to avoid
>    the error that LKP reported. '__switch_to_srmcfg()' will trigger a
>    build error in clang.
>    https://lore.kernel.org/oe-kbuild-all/202509162355.wByessnb-lkp@intel.=
com/
>  - Improve description of ssqosid in extensions.xml
>  - Link to v2: https://lore.kernel.org/linux-riscv/20250915-ssqosid-v6-17=
-rc5-v2-0-2d4b0254dfd6@kernel.org/
>
> Changes in v2:
>  - Restore the per-cpu fix from RFC v2 that was missed in v1:
>    change DEFINE_PER_CPU to DECLARE_PER_CPU in qos.h and move
>    DEFINE_PER_CPU to qos.c
>  - Introduce a patch that adds Ssqosid to riscv/extensions.yaml
>  - Link to v1: https://lore.kernel.org/r/20250910-ssqosid-v6-17-rc5-v1-0-=
72cb8f144615@kernel.org
>
> Changes in v1:
>  - Rename all instances of the sqoscfg CSR to srmcfg to match the
>    ratified Ssqosid spec
>  - Link RFC v2: https://lore.kernel.org/linux-riscv/20230430-riscv-cbqri-=
rfc-v2-v2-0-8e3725c4a473@baylibre.com/
>
> Changes in RFC v2:
>  - change DEFINE_PER_CPU to DECLARE_PER_CPU for cpu_sqoscfg in qos.h to
>    prevent linking error about multiple definition. Move DEFINE_PER_CPU
>    for cpu_sqoscfg into qos.c
>  - renamed qos prefix in function names to sqoscfg to be less generic
>  - handle sqoscfg the same way has_vector and has_fpu are handled in the
>    vector patch series
>  - Link to RFC v1: https://lore.kernel.org/linux-riscv/20230410043646.313=
8446-1-dfustini@baylibre.com/
>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> Drew Fustini (3):
>       dt-bindings: riscv: Add Ssqosid extension description
>       RISC-V: Detect the Ssqosid extension
>       RISC-V: Add support for srmcfg CSR from Ssqosid ext
>
>  .../devicetree/bindings/riscv/extensions.yaml      |  6 ++++
>  MAINTAINERS                                        |  7 ++++
>  arch/riscv/Kconfig                                 | 17 +++++++++
>  arch/riscv/include/asm/csr.h                       |  8 +++++
>  arch/riscv/include/asm/hwcap.h                     |  1 +
>  arch/riscv/include/asm/processor.h                 |  3 ++
>  arch/riscv/include/asm/qos.h                       | 41 ++++++++++++++++=
++++++
>  arch/riscv/include/asm/switch_to.h                 |  3 ++
>  arch/riscv/kernel/Makefile                         |  2 ++
>  arch/riscv/kernel/cpufeature.c                     |  1 +
>  arch/riscv/kernel/qos/Makefile                     |  2 ++
>  arch/riscv/kernel/qos/qos.c                        |  5 +++
>  12 files changed, 96 insertions(+)
> ---
> base-commit: 68247d45c045bb7dda923cf2c8d0937ce0e16394
> change-id: 20251007-ssqosid-ddc87968b2d9
>
> Best regards,
> --
> Drew Fustini <fustini@kernel.org>
>
>

Thanks,
Yunhui

