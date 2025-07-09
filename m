Return-Path: <linux-kernel+bounces-724178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D7AFEF7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A476563706
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006A224B04;
	Wed,  9 Jul 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2bcq/X/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D21F0E50
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081187; cv=none; b=LDNK1FlosZh48YyEgUyYU/Ka/NaR5ILBOrZbtSRYSXNOsVIrGdtYVBhKsJEkfl2LwmW6oFheprt8yJ3n2Qnb6OucQthtttvT/77NQX/im6TecInBvisAXiMf2/at7bah1cbggzEIUTdrdfJqZeOKpIqph7V9VS4MYkWzKhLosa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081187; c=relaxed/simple;
	bh=O2YQhZBU1ofBekN2KwRZdHuhqsC4q7S/ZNAWBEom2CU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkkHFPgJqGV+ZNFs2KSu5GzBgEG17bIg5wZHNOE6JZMiA0911kH0Jugi2HYVTsjUQZqlte+ROY6RBNIUPEVadK5XTBKkJLNtXsvJvzRhCAS2fG5c3A1x8bKFw3//WaicDZXXrdG5kxke4ZZxLzz/PAIw9sMs//vWd80COt1ROoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2bcq/X/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso147101a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752081185; x=1752685985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFdwR3lAJd7vdYwnOv4iE7Hy18jXCV9dXILHs2CzgU0=;
        b=R2bcq/X/b7C2Gj1ru81iM0XLOZ78/WgyxeH+4CJeMByOuRNjzd3KZ52mKYIjCMzu4T
         xChKKGZ2x/cCapjx9RXsJB145VTrBnUCp4Okn0loLhkgYte76do0yWx9LW72s0goCsFF
         ueNBLtJ7R/CDyqdup3BpH2HFJZvoZnK0Y7qG23iOc21cPSIRkbsbeYCGmnnqcYfKaTiC
         ciaJonkXZqCHuqq0ryi92uYC//E51HJd/Sp0I7idKptTSa8eL9wpAYL60W8x2WQSLTqV
         VsFz4EqP2IfyIsRBCLB3Tb+UG6aAvzqJekU1UrpI/04we99S3C3Y3nXh9THQus0U5a2a
         bVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752081185; x=1752685985;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFdwR3lAJd7vdYwnOv4iE7Hy18jXCV9dXILHs2CzgU0=;
        b=s3R62U23BWaghu5MwR/fLaCyT3DRD5bh1LHPdqYWm+ozj70G+oyEWSamNPOrJfQwKs
         5Ap4vu/pb0WBuIUIBmCtXg5BCMMbBYvN5E3cVL0uGIlQ49SQiYvmGzNxmP58WH62CPpd
         eArnx0haUh3CQft03MpxsgVNJGhecqzL8Dxu3TS/6CdzeIoH2Hr3reDL47qoUSl5Atwk
         8JLtmtLPB2HyvsFQPuUnrG7jeSbscHdi7e81z3iM/dRpRdoWJItS9JmT5N/TQJ+SQIwF
         s3IHfZE++f2lGe/SdIVIvPzHGSghecl1nz/VRIsUYfpSTZs0dw/aWSQh2XiGRR6O9Gu+
         xoXA==
X-Forwarded-Encrypted: i=1; AJvYcCWjzrCZC3W2cVRFbaYJWwJhJURsqY06StS3GbNTmXTZCF9tILNCRbGT5N6aX5pgUVEy12QjSeyUUZlvIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq13NqaSrBj04X41MnOwv4hkN3adCeWl3OkoDo0+b+P3A1j5WK
	winev7GtL8k7M1tcM2aqe+h7U0hd5PxK77HUrK8eBXvVayV6YbQhL1H43jkUf6sYEqlZU4lDL1f
	IMv0lLA==
X-Google-Smtp-Source: AGHT+IF4KmprglJhQcCJjAzzWMjja6iK8iRcdlNEdxxLpwXx5M10tRiFlzyYJ7m3VJ2DYG0UO1IJjLbBGog=
X-Received: from pjbsz11.prod.google.com ([2002:a17:90b:2d4b:b0:311:b3fb:9f74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec4:b0:312:e9bd:5d37
 with SMTP id 98e67ed59e1d1-31c3c269ae4mr1071299a91.6.1752081185093; Wed, 09
 Jul 2025 10:13:05 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:13:03 -0700
In-Reply-To: <20250709170454.74854-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709170454.74854-1-darwi@linutronix.de>
Message-ID: <aG6jH9ZHWiTxfFM3@google.com>
Subject: Re: [PATCH v1 0/7] x86: Disentangle <asm/processor.h> dependency on
 CPUID APIs
From: Sean Christopherson <seanjc@google.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, John Ogness <john.ogness@linutronix.de>, x86@kernel.org, 
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025, Ahmed S. Darwish wrote:
> Hi,
>=20
> This series avoids including the full CPUID API from <asm/processor.h>.
> That header only needs the CPUID data types and not the full API.
>=20
> Replace the <asm/cpuid/api.h> inclusion in <asm/processor.h> with an
> include of <asm/cpuid/types.h>.
>=20
> Modify all CPUID call sites which implicitly included the CPUID API
> though <asm/processor.h> to explicitly include <asm/cpuid/api.h> instead.
>=20
> This work prepares for an upcoming v4 of the CPUID model:
>=20
>     [PATCH v3 00/44] x86: Introduce a centralized CPUID data model
>     https://lore.kernel.org/lkml/20250612234010.572636-1-darwi@linutronix=
.de
>=20
> where <asm/cpuid/api.h> needs to include <asm/processor.h>, thus creating
> a circular dependency if not resolved beforehand=E2=80=A6  Patches 1->19 =
of the
> v3 above had parts of this series circular dependency disentanglement.
>=20
> Per Boris' remarks above, merge the header includes reorderings into two
> patches only: one patch for x86 and one for drivers.
>=20
> The 0-day bot x86-32 compilation error:
>=20
>     Re: [PATCH v3 41/44] x86/cpu: <asm/processor.h>: Do not include CPUID=
=E2=80=A6
>     https://lore.kernel.org/lkml/202506132039.imS2Pflx-lkp@intel.com
>=20
> is also fixed in this series.
>=20
> Beside the call sites converted at CPUID model v3 above, this series also
> switches below files:
>=20
>     arch/x86/kernel/cpu/microcode/core.c
>     arch/x86/kernel/cpu/microcode/intel.c
>     arch/x86/kernel/cpu/mshyperv.c
>     arch/x86/kvm/lapic.c
>     arch/x86/kvm/svm/sev.c

I'm officially confused.  Neither lapic.c nor svm/sev.c are modified in thi=
s series.
Does "this series" actually mean something other than _this_ seris?

>     drivers/acpi/acpi_processor.c
>     drivers/acpi/processor_core.c
>     drivers/cpufreq/longrun.c
>     drivers/cpufreq/powernow-k7.c
>     drivers/cpufreq/powernow-k8.c
>     drivers/hwtracing/coresight/coresight-platform.c
>     drivers/xen/xen-acpi-processor.c
>=20
> to explicitly include <asm/cpuid/api.h>.
>=20
> Based on v6.16-rc5.
>=20
> Note, the last patch is a CPUID API naming change in preparation for the
> model as well.  It can be skipped if merging it is not desired at this
> stage.
>=20
> Thanks!
>=20
> 8<-----
>=20
> Ahmed S. Darwish (7):
>   x86/cpuid: Remove transitional <asm/cpuid.h> header
>   ASoC: Intel: avs: Include CPUID header at file scope
>   x86: Reorder headers alphabetically
>   drivers: Reorder headers alphabetically
>   treewide: Explicitly include <asm/cpuid/api.h>
>   x86/cpu: <asm/processor.h>: Do not include CPUID API header
>   x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf() APIs
>=20
>  arch/x86/boot/compressed/pgtable_64.c        |  1 +
>  arch/x86/boot/startup/sme.c                  |  9 +--
>  arch/x86/coco/tdx/tdx.c                      |  6 +-
>  arch/x86/events/amd/core.c                   |  2 +
>  arch/x86/events/amd/ibs.c                    |  1 +
>  arch/x86/events/amd/lbr.c                    |  2 +
>  arch/x86/events/amd/power.c                  |  3 +
>  arch/x86/events/amd/uncore.c                 | 15 ++---
>  arch/x86/events/intel/core.c                 |  1 +
>  arch/x86/events/intel/lbr.c                  |  1 +
>  arch/x86/events/zhaoxin/core.c               | 12 ++--
>  arch/x86/include/asm/acrn.h                  |  2 +
>  arch/x86/include/asm/cpuid.h                 |  8 ---
>  arch/x86/include/asm/cpuid/api.h             |  6 +-
>  arch/x86/include/asm/microcode.h             |  1 +
>  arch/x86/include/asm/processor.h             |  2 +-
>  arch/x86/include/asm/xen/hypervisor.h        |  1 +
>  arch/x86/kernel/cpu/amd.c                    | 26 ++++----
>  arch/x86/kernel/cpu/centaur.c                |  1 +
>  arch/x86/kernel/cpu/hygon.c                  |  1 +
>  arch/x86/kernel/cpu/mce/core.c               | 63 ++++++++++----------
>  arch/x86/kernel/cpu/mce/inject.c             |  1 +
>  arch/x86/kernel/cpu/microcode/core.c         | 23 +++----
>  arch/x86/kernel/cpu/microcode/intel.c        | 12 ++--
>  arch/x86/kernel/cpu/mshyperv.c               | 29 +++++----
>  arch/x86/kernel/cpu/resctrl/core.c           |  6 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c        |  1 +
>  arch/x86/kernel/cpu/scattered.c              |  3 +-
>  arch/x86/kernel/cpu/sgx/main.c               |  3 +
>  arch/x86/kernel/cpu/topology_amd.c           |  3 +-
>  arch/x86/kernel/cpu/topology_common.c        |  3 +-
>  arch/x86/kernel/cpu/topology_ext.c           |  3 +-
>  arch/x86/kernel/cpu/transmeta.c              |  3 +
>  arch/x86/kernel/cpu/zhaoxin.c                |  1 +
>  arch/x86/kernel/cpuid.c                      |  6 +-
>  arch/x86/kernel/paravirt.c                   | 29 ++++-----
>  arch/x86/kvm/cpuid.h                         |  3 +
>  arch/x86/kvm/mmu/spte.c                      |  1 +
>  drivers/cpufreq/longrun.c                    |  7 ++-
>  drivers/cpufreq/powernow-k7.c                | 14 ++---
>  drivers/cpufreq/powernow-k8.c                | 17 +++---
>  drivers/cpufreq/speedstep-lib.c              |  6 +-
>  drivers/firmware/efi/libstub/x86-5lvl.c      |  1 +
>  drivers/hwmon/fam15h_power.c                 | 14 +++--
>  drivers/hwmon/k10temp.c                      |  2 +
>  drivers/hwmon/k8temp.c                       | 12 ++--
>  drivers/thermal/intel/intel_hfi.c            |  1 +
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 15 ++---
>  sound/soc/intel/avs/tgl.c                    | 25 +++++---
>  49 files changed, 235 insertions(+), 173 deletions(-)
>  delete mode 100644 arch/x86/include/asm/cpuid.h
>=20
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> --=20
> 2.49.0
>=20

