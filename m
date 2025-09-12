Return-Path: <linux-kernel+bounces-813244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E063AB5428D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FC55A1CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D3427B4E5;
	Fri, 12 Sep 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0yA2YTY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337E846F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657455; cv=none; b=iJSjTn2TGe2x1wIqA2GxF5vpXUe3UUlTg3rl5blq6mISOpkiq/Je0+VGyeAx67LdEyUPa1JHsLNFbHxn1G2c+SplUQd5hS1HX74jK1V6f/TptHwbMTsrYQxDMcQ7uaj8PN/1lFYi1UAmDbdEnSyN/GGL9pn35ojdfxq7MruKyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657455; c=relaxed/simple;
	bh=tkQeY1fSriekvByW2kQsBRrTqAH3Pgp8gd0+r/tBA6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FagREgXaoQZ5G6eu+SBzvOYe1EQS3QdiRMGPCIitCDQv4iZT6CJrpq35Iq2kTBQ4+9W5FvZ4B6SUHehCK6mQ26MJzdzlzQUbBZf+IzhE34zEpkHTxtkG+nHtyOAN5PsFT8SOoE5Pndrv+sm0/hQSBpuTznenJYob6Gd9FMS+HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0yA2YTY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so8029505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757657452; x=1758262252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkcnkimq0914P3F1WhqHUu/ZQqNnkVGBME3u91cNVxM=;
        b=P0yA2YTY8MiqpphsgHm4Pjc+LWKPbV6I8PQ1cPbL9fhURGNoM2/rKZck0oWbmfTcW6
         NuXRxa38nVVD2gZvokES+kRvTAvNABPXDKcvMU6RyHDKeLwoRF/SJYa4DaoeIkxB4jb4
         Ilf7JMpkwvVnopV0ADaEDrMdvGjqR4rrFf9myE8ykB33BH3KBaW/vAYFQA60HOS5Jr9v
         EK765grzy0zpIjv2opqHQbKZiPR6yfr2qhQfAwgUxtlK0dK5hFMICg0NTBZCustw0Akl
         8hIm2gTV8aRZFlRWnDHmik/JcvpJ6SaqU9Pa9kV/aeYZKPTDmlYDyiQQjHH+eoSERBAK
         Hdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757657452; x=1758262252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkcnkimq0914P3F1WhqHUu/ZQqNnkVGBME3u91cNVxM=;
        b=gCP6wX+jA9JejTJz0QjGWXwKJlRlu5MYynC/Gbba9/19NTrfbgR78NFTaQQBXdERC9
         X4ySl+JG02HBQxOE6A+aAC+qiCaC+uypf9lMgizbxqC4k1m8AizHlmlfjOKf4dPbvbh4
         83IxAlz0S2oWXRcyYGi5M2zym1GzQG+pxmOGEgnr8eeqTrdg4iedO9z/0UaBnz+U/+Y1
         AFzWmZ41Crd0ueqyrscwDBjEL3q5yrXe3F1/v/JH41vBsc09jBFjOckhWQwx1by4+JXN
         W8J+8AMRvTJlibEjeWPHZ8imvR4WNpBtOHtFeV4gZyliPFv125dTNPNXCm9c2V9VNOZz
         ng7g==
X-Gm-Message-State: AOJu0YwKGTMgyY38UlKbJZxMZWUrCV3ZMp33no8kv7b6q+QVDA/2rrwJ
	LYpwBbkcrW+rabIxyhUdpUF1TRSpJGVM3sKAXDVezSZA0ibPxoxEMX3CUNfPKmS2
X-Gm-Gg: ASbGncvTdPllSsOry6OmLDiobRjW4fs7VHfl/2tVBln/VBjaWc+rw39nFw4WbwsWsRd
	S+j/FBi3Dq0X/0M/acpYmQgbUoHK0IB2AjQEDHaYEmp3q/yRt0S0wAWVklkLNsaQv8x+D01deJE
	1MjOvxmq+MqrMHse3l/AnFfcWRkmQONl5zGh2yMGtyj7p1C9dDcvJ+/yKv2j/hd9s2q7MhqO/RB
	WvPZtcZYphgbZiVq95UIW2IH5CB/zegP+JYJCXwBuh5qMGC0jFKc6RuY2qIUE7t8TbuxmISFm/p
	ysnBbOqL98+IsqE3Wo0G7aWiMAu/SjktNJAL6cfPIZPdopWwEbXBQaxgeEEg+jjb7bcIqN2xpqV
	15ql59idiNvdl1pJkBOcLVBYV7JhqsfmlUSt4iW17K3vcCCpERCbi2vP3oi2h1Q==
X-Google-Smtp-Source: AGHT+IH1FVKft+zZv4E3Bkd7VErYv120ayA/V4pOg6fBv9ezf+S/3RkIlorWf/a1Z5+AyjKuXhq1LA==
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1529249f8f.25.1757657451930;
        Thu, 11 Sep 2025 23:10:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e766659ea0sm1874680f8f.43.2025.09.11.23.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:10:50 -0700 (PDT)
Date: Fri, 12 Sep 2025 07:10:50 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] openrisc: Support basic trace mechanism
Message-ID: <aMO5ap21H455GbfQ@antec>
References: <20250905181258.9430-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905181258.9430-1-chenmiao.ku@gmail.com>

I have queued this for 6.18 now.

-Stafford

On Fri, Sep 05, 2025 at 06:12:54PM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Hello everyone,
> 
> This implements a basic text patching mechanism and a complete jump_label
> implementation for OpenRISC. It should be noted that the jump_label have
> passed testing.
> 
> 1. Implement the patch_map interface and the patch_insn_write single insn
> write API by providing FIX_TEXT_POKE0. And create a new insn-def.h to record
> openrisc's instruction macro definition which only have OPENRISC_INSN_SIZE
> now.
> 
> 2. Support for the R_OR1K_32_PCREL relocation type is added for module insertion,
> enabling subsequent jump_label selftest module insertion.
> 
> 3. Regenerate defconfigs for or1ksim_defconfig and virt_defconfig.
> 
> 4. Based on the previously implemented patch_insn_write, achieve a complete
> jump_label implementation, directly supporting arch_jump_label_transform_queue.
> And add a new macro OPENRISC_INSN_NOP in insn-def.h.
> 
> Link: https://lore.kernel.org/openrisc/CAKxVwgdGe59F=giPXsukmQDO=XY58BH2gAMCV6uCR=vmwkAyyQ@mail.gmail.com/T/#t
> 
> Thanks,
> 
> Chen Miao
> 
> ---
> Changes in V5:
>   - Simplified some code in the fourth patch and removed unnecessary braces.
> 
> Changes in V4:
>   - Added testing for jump_label
>   - Split part of the jump_label patch content to form the third patch
>   - Implemented R_OR1K_32_PCREL module support for jump_label testing
> 
> Changes in V3:
>   - Removed the is_exit_text used, added some necessary comments.
>   - Modify some macro like __ASSEMBLY__ to __ASSEMBLER__ and ensure the
>     defconfig by make savedefconfig.
> 
> Changes in V2:
>   - Add a new insn-def.h to record the insn macro.
>   - Modify the patch_insn_write API from const void* to u32 insn.
>   - Using the modified patch_insn_write API in 
>     arch_jump_label_transform_queue.
> 
> chenmiao (4):
>   openrisc: Add text patching API support
>   openrisc: Add R_OR1K_32_PCREL relocation type module support
>   openrisc: Regenerate defconfigs.
>   openrisc: Add jump label support
> 
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/openrisc/Kconfig                         |  2 +
>  arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
>  arch/openrisc/configs/virt_defconfig          |  2 +-
>  arch/openrisc/include/asm/Kbuild              |  1 -
>  arch/openrisc/include/asm/fixmap.h            |  1 +
>  arch/openrisc/include/asm/insn-def.h          | 15 ++++
>  arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++
>  arch/openrisc/include/asm/text-patching.h     | 13 +++
>  arch/openrisc/kernel/Makefile                 |  2 +
>  arch/openrisc/kernel/jump_label.c             | 51 ++++++++++++
>  arch/openrisc/kernel/module.c                 |  4 +
>  arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
>  arch/openrisc/kernel/setup.c                  |  2 +
>  arch/openrisc/mm/init.c                       |  6 +-
>  15 files changed, 255 insertions(+), 16 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/insn-def.h
>  create mode 100644 arch/openrisc/include/asm/jump_label.h
>  create mode 100644 arch/openrisc/include/asm/text-patching.h
>  create mode 100644 arch/openrisc/kernel/jump_label.c
>  create mode 100644 arch/openrisc/kernel/patching.c
> 
> -- 
> 2.45.2
> 

