Return-Path: <linux-kernel+bounces-880649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A2C263F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9DB1A20353
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E882FD1BF;
	Fri, 31 Oct 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doWPlNbU"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D62BEC20
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929741; cv=none; b=aeAiby/H52+c7UeNAkAllbDlnKU/azpCqC2bLpbsqZEfxmNEFaNRxjAYPThqnvGtTG2hJ6DSOCk2rhXcf/lC+OUHDykWEsuX62oJnYOMiho7LYeincnUHiWkgHo9RnSwxUgoaYCWTT5X3JMMJZd+s9f/mk+P0rwu2yqUbv9MOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929741; c=relaxed/simple;
	bh=56YP9bOOwpxRWaqA+O3PwGVFgv7zsAGCzkLhzmLCRpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFU6f6bq4t3+AlKK93pu0K2OHkeRIo7QmWWUK4xceGy5h+hb2M6zFikYnVJ8F3lHWIUULpTq/EAg6ldfT8XzMngDia9GEmoRMlWLY48LBmpliuXfGSSZria2QeIcAVIsfhhvl0evDIXjU3UdtOrwxJ8O5TJKTfSuW5PBw904xmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doWPlNbU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso10381cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761929739; x=1762534539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2PgiNfT03NpyavbwhUGeVVJeE0kuxyW1JyOtkY0SVg=;
        b=doWPlNbUPa4G8pwp1iwF//1pgOF2HwkI0r2CEzlVXjXawOGLfnLhYcKDR9fSug2IWY
         SuD0FNA2jSHe+9geNRJEdhX+5lff1MukjXUSJMzrSedCXwRVXJd3LY6GgM1c+mYd61VR
         3EMo5yoAsKtnid65GOLPLv2Wi423lVm4mJSSrrTSanhD7fqfd8Kd6oG8hymjZ/tKRdTU
         vjIk054+vjW+D1364To2LyfN1eSxdMOXatLzlvhGPwKP6Q4zY3qDhCZnuh6o5tHhKk4Z
         gGtb8s+itiOJTlsU0eibkWRrFsuD11WieDrucDWfJh1EhQZKu+1ozPJN34nIHDS54/s8
         SBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929739; x=1762534539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2PgiNfT03NpyavbwhUGeVVJeE0kuxyW1JyOtkY0SVg=;
        b=OdayZl05d2f7sPJjqFBeAYoN4hitGJD/ZSMjQ649G0OS5A3MJbzcL/vnndpnAA6t27
         TJtAxGTdPqQRGdgB4TewvLlFeaM1ggou7Sa5CoDB7ss3+5kbc6qaZg7A4HYqbT22/ia/
         rQ6DjRaDuPZRoHMs7OeNY5t7fH9F9g9q04KfiLLwuZP1V9zB1hoNodUvhSYCcFuYVUq2
         w43VuJw4zl75KppSenNvvMdwp0LDDpb66s0Af0xCncDJG24LXyCAGiQSPokh12Ka7qY5
         vnOSROyv2eSDU8ZOLVWNbTcMwW7XkZzaRmZZzNErmhbWJ60dcbZgpl0nxuUBdFVvqqOz
         ME4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfUhS0PZ/dXS/FnAblvy8Yz/HiPZ0QUpmuMNziid4jBZY3dOtRcrYuOHkA9Zhgy4U6QLi6GBD7Cwe7Rg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBQc//r5N1ZNrckR4TvdWACUNpuANkLZEeDjgG+nGeKHknLAX
	InP5+mRTo8LzdZLUO1zdQQe0zfDbpQBuAU9CUeDtf9Wli3FL54hvCLzgX/L2n7jBe05zO231lHT
	M65eNx3ncppNlso7MZBPD6d5eYvimpT1timSqgCy5nmgPGEVPNiyM3APVoKLuug==
X-Gm-Gg: ASbGncuHL7b6/asFOgYMbvQ60cgkMS+74yNwNQ1K+Lz1/mUIWuSka5MStX6V1iqXcHe
	QGfWmsfENleD5zfclNIGHsrkynM2gIo2bQzkPjugmWzxtla7SAiwBfC5HfnK90QIs2TH3cfarLy
	+Eg1g/vvcHCfu2uWLQStdbyUhHzjsgagb+AqP0uQ6yWwM4k002xDt9VA4dhmBTFU6Af1q/eoALD
	5GeTpl+ZCNSX/c9BlkHyAxGej8vwbDee6Mo4OE1R7rfWKCPu5pXIMvbOA88k59VY7Nsc2LVgg/w
	l0jTl0AXvX0oUu9Q159+pkkqKlb1rZhlkn7xQw==
X-Google-Smtp-Source: AGHT+IEJfbaI9O8W6tmM+KPDJeLSPU2pRJ3c2ODobEUnDZqE66zG4QbCQYq9QXR0kiOjpXSXTYj8u13C633eOGbldWU=
X-Received: by 2002:a05:622a:e:b0:4ed:2f7d:bd46 with SMTP id
 d75a77b69052e-4ed338c4dc1mr6590451cf.13.1761929738538; Fri, 31 Oct 2025
 09:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com>
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 31 Oct 2025 11:55:27 -0500
X-Gm-Features: AWmQ_bkPE5YTmxbtr1eAnNNvO5lcJ4CGGWinWFilxPEZHxRyXdDTaeKu0umSWCY
Message-ID: <CAAhR5DF74PhX_YpMebbqnZOJom-sR=1s7xbhrk5WCTS8jn7U7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	reinette.chatre@intel.com, ira.weiny@intel.com, kai.huang@intel.com, 
	dan.j.williams@intel.com, yilun.xu@linux.intel.com, vannapurve@google.com, 
	paulmck@kernel.org, nik.borisov@suse.com, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:54=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> Changelog:
> v1->v2:
>  - Replace tdx subsystem with a "tdx-host" device implementation
>  - Reorder patches to reduce reviewer's mental "list of things to look ou=
t for"
>  - Replace "TD-Preserving update" with "runtime TDX Module Update"
>  - Drop the temporary "td_preserving_ready" flag
>  - Move low-level SEAMCALL helpers to its own header file
>  - Don't create a new, inferior framework to save/restore VMCS
>  - Minor cleanups and changelog improvements for clarity and consistency
>  - Collect review tags
>  - I didn't add Sagi Shahar's Tested-by due to various changes/reorder et=
c.
>  - v1: https://lore.kernel.org/kvm/20250523095322.88774-1-chao.gao@intel.=
com/
>
> Hi Reviewers,
>
> This series adds support for runtime TDX Module updates that preserve
> running TDX guests.
>
> =3D=3D Background =3D=3D
>
> Intel TDX isolates Trusted Domains (TDs), or confidential guests, from th=
e
> host. A key component of Intel TDX is the TDX Module, which enforces
> security policies to protect the memory and CPU states of TDs from the
> host. However, the TDX Module is software that require updates.
>
> =3D=3D Problems =3D=3D
>
> Currently, the TDX Module is loaded by the BIOS at boot time, and the onl=
y
> way to update it is through a reboot, which results in significant system
> downtime. Users expect the TDX Module to be updatable at runtime without
> disrupting TDX guests.
>
> =3D=3D Solution =3D=3D
>
> On TDX platforms, P-SEAMLDR[1] is a component within the protected SEAM
> range. It is loaded by the BIOS and provides the host with functions to
> install a TDX Module at runtime.
>
> Implement a TDX Module update facility via the fw_upload mechanism. Given
> that there is variability in which module update to load based on feature=
s,
> fix levels, and potentially reloading the same version for error recovery
> scenarios, the explicit userspace chosen payload flexibility of fw_upload
> is attractive.
>
> This design allows the kernel to accept a bitstream instead of loading a
> named file from the filesystem, as the module selection and policy
> enforcement for TDX Modules are quite complex (see more in patch 8). By
> doing so, much of this complexity is shifted out of the kernel. The kerne=
l
> need to expose information, such as the TDX Module version, to userspace.
> Userspace must understand the TDX Module versioning scheme and update
> policy to select the appropriate TDX Module (see "TDX Module Versioning"
> below).
>
> In the unlikely event the update fails, for example userspace picks an
> incompatible update image, or the image is otherwise corrupted, all TDs
> will experience SEAMCALL failures and be killed. The recovery of TD
> operation from that event requires a reboot.
>
> Given there is no mechanism to quiesce SEAMCALLs, the TDs themselves must
> pause execution over an update. The most straightforward way to meet the
> 'pause TDs while update executes' constraint is to run the update in
> stop_machine() context. All other evaluated solutions export more
> complexity to KVM, or exports more fragility to userspace.
>
> =3D=3D How to test this series =3D=3D
>
> This series can be tested using the userspace tool that is able to
> select the appropriate TDX module and install it via the interfaces
> exposed by this series:
>
>  # git clone https://github.com/intel/tdx-module-binaries
>  # cd tdx-module-binaries
>  # python version_select_and_load.py --update
>
> =3D=3D Base commit =3D=3D
>
> This series is based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?h=
=3Dtdx&id=3D9332e088937f

Can you clarify which patches are needed from this tree? Is it just
"coco/tdx-host: Introduce a "tdx_host" device" or is this series also
depends on other patches?

More specifically, does this series depend on "Move VMXON/VMXOFF
handling from KVM to CPU lifecycle"?

>
> and the TDX Module version series at:
> https://lore.kernel.org/linux-coco/20251001022309.277238-1-chao.gao@intel=
.com
>
>
> =3D=3D Other information relevant to Runtime TDX Module updates =3D=3D
>
> =3D=3D=3D TDX Module versioning =3D=3D=3D
>
> Each TDX Module is assigned a version number x.y.z, where x represents th=
e
> "major" version, y the "minor" version, and z the "update" version.
>
> Runtime TDX Module updates are restricted to Z-stream releases.
>
> Note that Z-stream releases do not necessarily guarantee compatibility. A
> new release may not be compatible with all previous versions. To address =
this,
> Intel provides a separate file containing compatibility information, whic=
h
> specifies the minimum module version required for a particular update. Th=
is
> information is referenced by the tool to determine if two modules are
> compatible.
>
> =3D=3D=3D TCB Stability =3D=3D=3D
>
> Updates change the TCB as viewed by attestation reports. In TDX there is
> a distinction between launch-time version and current version where
> runtime TDX Module updates cause that latter version number to change,
> subject to Z-stream constraints.
>
> The concern that a malicious host may attack confidential VMs by loading
> insecure updates was addressed by Alex in [3]. Similarly, the scenario
> where some "theoretical paranoid tenant" in the cloud wants to audit
> updates and stop trusting the host after updates until audit completion
> was also addressed in [4]. Users not in the cloud control the host machin=
e
> and can manage updates themselves, so they don't have these concerns.
>
> See more about the implications of current TCB version changes in
> attestation as summarized by Dave in [5].
>
> =3D=3D=3D TDX Module Distribution Model =3D=3D=3D
>
> At a high level, Intel publishes all TDX Modules on the github [2], along
> with a mapping_file.json which documents the compatibility information
> about each TDX Module and a userspace tool to install the TDX Module. OS
> vendors can package these modules and distribute them. Administrators
> install the package and use the tool to select the appropriate TDX Module
> and install it via the interfaces exposed by this series.
>
> [1]: https://cdrdv2.intel.com/v1/dl/getContent/733584
> [2]: https://github.com/intel/tdx-module-binaries
> [3]: https://lore.kernel.org/all/665c5ae0-4b7c-4852-8995-255adf7b3a2f@ama=
zon.com/
> [4]: https://lore.kernel.org/all/5d1da767-491b-4077-b472-2cc3d73246d6@ama=
zon.com/
> [5]: https://lore.kernel.org/all/94d6047e-3b7c-4bc1-819c-85c16ff85abf@int=
el.com/
>
>
> Chao Gao (20):
>   x86/virt/tdx: Print SEAMCALL leaf numbers in decimal
>   x86/virt/tdx: Use %# prefix for hex values in SEAMCALL error messages
>   x86/virt/tdx: Prepare to support P-SEAMLDR SEAMCALLs
>   x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
>   x86/virt/seamldr: Retrieve P-SEAMLDR information
>   coco/tdx-host: Expose P-SEAMLDR information via sysfs
>   coco/tdx-host: Implement FW_UPLOAD sysfs ABI for TDX Module updates
>   x86/virt/seamldr: Block TDX Module updates if any CPU is offline
>   x86/virt/seamldr: Verify availability of slots for TDX Module updates
>   x86/virt/seamldr: Allocate and populate a module update request
>   x86/virt/seamldr: Introduce skeleton for TDX Module updates
>   x86/virt/seamldr: Abort updates if errors occurred midway
>   x86/virt/seamldr: Shut down the current TDX module
>   x86/virt/tdx: Reset software states after TDX module shutdown
>   x86/virt/seamldr: Handle TDX Module update failures
>   x86/virt/seamldr: Install a new TDX Module
>   x86/virt/seamldr: Do TDX per-CPU initialization after updates
>   x86/virt/tdx: Establish contexts for the new TDX Module
>   x86/virt/tdx: Update tdx_sysinfo and check features post-update
>   x86/virt/tdx: Enable TDX Module runtime updates
>
> Kai Huang (1):
>   x86/virt/tdx: Move low level SEAMCALL helpers out of <asm/tdx.h>
>
>  .../ABI/testing/sysfs-devices-faux-tdx-host   |  25 ++
>  arch/x86/Kconfig                              |  12 +
>  arch/x86/include/asm/seamldr.h                |  29 ++
>  arch/x86/include/asm/tdx.h                    |  38 +-
>  arch/x86/include/asm/tdx_global_metadata.h    |   5 +
>  arch/x86/virt/vmx/tdx/Makefile                |   1 +
>  arch/x86/virt/vmx/tdx/seamcall.h              | 106 +++++
>  arch/x86/virt/vmx/tdx/seamldr.c               | 382 ++++++++++++++++++
>  arch/x86/virt/vmx/tdx/tdx.c                   | 149 ++++---
>  arch/x86/virt/vmx/tdx/tdx.h                   |  12 +-
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  13 +
>  drivers/virt/coco/tdx-host/tdx-host.c         | 189 ++++++++-
>  12 files changed, 884 insertions(+), 77 deletions(-)
>  create mode 100644 arch/x86/include/asm/seamldr.h
>  create mode 100644 arch/x86/virt/vmx/tdx/seamcall.h
>  create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c
>
> --
> 2.47.3
>

