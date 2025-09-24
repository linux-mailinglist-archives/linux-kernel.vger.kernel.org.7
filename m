Return-Path: <linux-kernel+bounces-830539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBFB99EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5F6322ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130692FFDF3;
	Wed, 24 Sep 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W9Q8y9v3"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6132FB98F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718486; cv=none; b=P2nc5z2+weq34OIp2eN+bjMuuIfwIOVCpwmtJeqmikSxTbpEdxNOhXUgBLt1QAI+4Iu2LmqQv6jz91Dp1lZyxQ5bmNjldF2aRCCgy3gsbSNdl+tmP29UqVbbAfKQWTxJLht6L9NjaJvVXQHHER/0MvJjxZOZFg9iAm41tkPDDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718486; c=relaxed/simple;
	bh=yvqPG2MZtqGzxY1KDfbo5vvsl38B3MWYppPJlxQQ1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLOm281fpZuE/0Rlpbsv1EUrK9MgYXLwNOhEhuf7Us1s9j17zgWrTmkC2lVxilOpwwr/Pmwo7qQ/X9/EFibWLsIbE+XaShpsl2cWWlYiAxCgE3d1X9uag0nswLTlN3HSwHuIwXwMUL5se1A+yOD8buTklVgV/5Mg+BtHiZWLTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W9Q8y9v3; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-890e5bb3100so164679239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758718483; x=1759323283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXk5gvGOIj4B8Hhv/tzj6b7Y9tm8ywIFhspLK9qUglQ=;
        b=W9Q8y9v3AIJdi57Ixu09Ua6ub4sldwimgu6V9eVxYDM42bLQXIyNpWa1P1nouSuYLY
         QLKzEWzsa4F+1bELuDQbimusajwQtKZSJ2W/kvgpor13ZKe6Du8S/oXD5KxKtlUhJPsl
         kawy3iJY3nKG9rSBXbGdnHUltvHoUvjg/h4nV/XO1K5um1x7LeJ7V8cgrjRfQJCtmJY3
         ac4+lA4jlngf7QzqkXGQdvxO6l3pcxvnidnEcC3pgvNfkTwSimcFOwgwpOqseLnlFbxL
         MNyuY9AMhKf3c77MBuNFB+xyNKWflkYgHEoeb+vuZi8nDwiiEECXzpeNp2jxNYxo+vSx
         jvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718483; x=1759323283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXk5gvGOIj4B8Hhv/tzj6b7Y9tm8ywIFhspLK9qUglQ=;
        b=GJoSFRFEGWnImpmOP4cooVvf5CTx5kGIwFKjLVtAePibf+wh+Uz3BF2KC8YwWxt24F
         awQznXKdTa0dyBRhEYHLhPkhhF49+U/7ea3/cfeOiOpfPFpTxYXsL14p+gJZeu5oRfxT
         cekx18uyuReNVFh6DrMvjNnTl+brtR/IOw8SeetKmvwqUOQEtJdqxbe+ysgZmvK+gKZz
         6iTU6gtoLutA7oHZ5ze2MxZRqTLr4Z+YIOY0RtGor3de2s68rJexj5JjWe761VTOgTRz
         TeH1vLi+gb2A/7eKmZqNlbaaXmXo4aoRCaUqhDUWGPdWba8hY6mh1fYVFmvnmBkWLNt7
         ZtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB4/EcJTOLo35jrEdiSdmgSKVutEv42z3MDNVBeY9u8YJZYpfCgEl4NlY7biWGoIiEUXSGMBved0m2ok8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OEg38Dh4aAg4hX/NqNETtGub/DqqrJCiplk+f3dPL0Tjue6z
	wKOF4yA8TXZ0XcrH9T4OGaHrqsNxT9HLytBLNKA8//X4crVurmuXQRzMiNyA6gcIejQ=
X-Gm-Gg: ASbGncuXbmp+8yCzCvt3XQTyq+l+4Mtad9WyPVWQLgLh+c1uWGLClneKmwvv3z0EV0V
	lGZgPLtlWZE+QQRTz1G1mTC6nkNlBKwaRUZ/nSKnmdGCb+lB7zLGddHQWuipFIlnP+vteqXUiR7
	OacyhFcgycpRWqzJNja186Gmyidigl4Ad7RFZeYF2nkII65Q/UmtHktPHq6Aib5KglFoXWl8cLf
	nTN9/j151o9f9SBEaSRS5wUEaC12jvkwE1BvjIOwYYlSzjFBH43s9AG9mqbkRhqnI7M82OvDKYQ
	/cKfEdEiLNYFKOu9QmiDDdnz7dg9eLOAVwumW9ZDynwockqsf7KryB68a9s8aq4UENn5CAcPxFJ
	GmLKBJ5irLLHmQqi+Svu0ulNZVFDSYnrP69Q=
X-Google-Smtp-Source: AGHT+IE3iBnvBMfmVf9p58xM4KWA9RxO6Yi6uROxLGwroD+MUtGpdeej2f+4Q9Zc1iv4krdN8l30nw==
X-Received: by 2002:a05:6602:27c2:b0:8fe:f51a:16b4 with SMTP id ca18e2360f4ac-8fef547e5d9mr52908239f.6.1758718483310;
        Wed, 24 Sep 2025 05:54:43 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a4832339c5sm620494639f.26.2025.09.24.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:54:42 -0700 (PDT)
Date: Wed, 24 Sep 2025 07:54:41 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: anup@brainfault.org, kvm-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, atishp@rivosinc.com
Subject: Re: [PATCH] riscv: Move user-visible sbi ext ids to uapi
Message-ID: <20250924-7e9764acec6722b5ef29ce7d@orel>
References: <20250917085246.1430354-1-xiangwencheng@lanxincomputing.com>
 <20250923-5498566fbd48a3dfd61ecd08@orel>
 <1be32bd0-a3d1-4fea-8f22-e050f664907b@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be32bd0-a3d1-4fea-8f22-e050f664907b@lanxincomputing.com>

On Wed, Sep 24, 2025 at 10:35:25AM +0800, BillXiang wrote:
> On 9/24/2025 4:14 AM, Andrew Jones wrote:
> > On Wed, Sep 17, 2025 at 04:52:46PM +0800, BillXiang wrote:
> >> Move those sbi ext ids to uapi because they will be forwarded
> >> to user space by kvm.
> > 
> > We don't need to publish the IDs in UAPI since they are already known to
> > userspace by reading the SBI spec. Indeed QEMU already defines all of
> > these except for the experimental range.>
> > What problem are you trying to solve?
> 
> 
> I'm working on rust-vmm[1], which auto-generates the ID constants
> from uapi/kvm.h via bindgen[2]. Any ID that isn't exported there is
> invisible to us. I expect other VMMs besides QEMU will need these
> numbers as well, so let's keep one canonical definition in the UAPI
> headers for everyone to share.

But KVM isn't the authority on these IDs, the spec is. KVM and its
userspaces are just some implementations of SBI. M-mode software
and other hypervisors also implements SBI.

For Rust you can use https://docs.rs/sbi-spec/latest/sbi_spec/ to get
the constants you're looking for.

Thanks,
drew

> 
> 
> [1] https://github.com/rust-vmm
> [2] https://crates.io/crates/bindgen
> 
> > 
> > Thanks,
> > drew
> > 
> >>
> >> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> >> ---
> >>   arch/riscv/include/asm/sbi.h      | 16 +-----------
> >>   arch/riscv/include/uapi/asm/sbi.h | 43 +++++++++++++++++++++++++++++++
> >>   2 files changed, 44 insertions(+), 15 deletions(-)
> >>   create mode 100644 arch/riscv/include/uapi/asm/sbi.h
> >>
> >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> >> index 341e74238aa0..e196feaabb2e 100644
> >> --- a/arch/riscv/include/asm/sbi.h
> >> +++ b/arch/riscv/include/asm/sbi.h
> >> @@ -10,13 +10,12 @@
> >>   #include <linux/types.h>
> >>   #include <linux/cpumask.h>
> >>   #include <linux/jump_label.h>
> >> +#include <uapi/asm/sbi.h>
> >>   
> >>   #ifdef CONFIG_RISCV_SBI
> >>   enum sbi_ext_id {
> >>   #ifdef CONFIG_RISCV_SBI_V01
> >>   	SBI_EXT_0_1_SET_TIMER = 0x0,
> >> -	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> >> -	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> >>   	SBI_EXT_0_1_CLEAR_IPI = 0x3,
> >>   	SBI_EXT_0_1_SEND_IPI = 0x4,
> >>   	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> >> @@ -37,13 +36,6 @@ enum sbi_ext_id {
> >>   	SBI_EXT_NACL = 0x4E41434C,
> >>   	SBI_EXT_FWFT = 0x46574654,
> >>   
> >> -	/* Experimentals extensions must lie within this range */
> >> -	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> >> -	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
> >> -
> >> -	/* Vendor extensions must lie within this range */
> >> -	SBI_EXT_VENDOR_START = 0x09000000,
> >> -	SBI_EXT_VENDOR_END = 0x09FFFFFF,
> >>   };
> >>   
> >>   enum sbi_ext_base_fid {
> >> @@ -263,12 +255,6 @@ enum sbi_pmu_ctr_type {
> >>   #define SBI_PMU_STOP_FLAG_RESET BIT(0)
> >>   #define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
> >>   
> >> -enum sbi_ext_dbcn_fid {
> >> -	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> >> -	SBI_EXT_DBCN_CONSOLE_READ = 1,
> >> -	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
> >> -};
> >> -
> >>   /* SBI STA (steal-time accounting) extension */
> >>   enum sbi_ext_sta_fid {
> >>   	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
> >> diff --git a/arch/riscv/include/uapi/asm/sbi.h b/arch/riscv/include/uapi/asm/sbi.h
> >> new file mode 100644
> >> index 000000000000..d29ac0abeefe
> >> --- /dev/null
> >> +++ b/arch/riscv/include/uapi/asm/sbi.h
> >> @@ -0,0 +1,43 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >> +/*
> >> + * Copyright (C) 2025 Lanxincomputing Corporation or its affiliates.
> >> + *
> >> + * Authors:
> >> + *     BillXiang <xiangwencheng@lanxincomputing.com>
> >> + */
> >> +
> >> +#ifndef _UAPI_ASM_RISCV_SBI_H
> >> +#define _UAPI_ASM_RISCV_SBI_H
> >> +
> >> +
> >> +enum SBI_EXT_ID {
> >> +	/*
> >> +	* The CONSOLE_GETCHAR/CONSOLE_PUTCHAR SBI calls cannot be
> >> +	* handled in kernel so they will be forwarded to userspace by kvm.
> >> +	*/
> >> +	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> >> +	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> >> +	/*
> >> +	* Both SBI experimental and vendor extensions are
> >> +	* unconditionally forwarded to userspace by kvm.
> >> +	*/
> >> +	/* Experimentals extensions must lie within this range */
> >> +	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> >> +	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
> >> +
> >> +	/* Vendor extensions must lie within this range */
> >> +	SBI_EXT_VENDOR_START = 0x09000000,
> >> +	SBI_EXT_VENDOR_END = 0x09FFFFFF,
> >> +};
> >> +
> >> +/*
> >> +* The SBI debug console functions are unconditionally
> >> +* forwarded to the userspace by kvm.
> >> +*/
> >> +enum sbi_ext_dbcn_fid {
> >> +	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> >> +	SBI_EXT_DBCN_CONSOLE_READ = 1,
> >> +	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
> >> +};
> >> +
> >> +#endif /* _UAPI_ASM_RISCV_SBI_H */
> >> \ No newline at end of file
> >> -- 
> >> 2.43.0

