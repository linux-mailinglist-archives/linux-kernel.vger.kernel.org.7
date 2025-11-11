Return-Path: <linux-kernel+bounces-895966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9DDC4F61D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7609B3B3F00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F4436B05F;
	Tue, 11 Nov 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT6DjYow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A73AA198
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884744; cv=none; b=iamxVElUHexa5QxJATXvNNJGgI+HiXDOoDMAo3fnvms7MOUuRH12UYnMm4vqdCmHDSgVrhJ94DMZWmbiCc54IvIpEq4vEBtdro+REWA3noNGQvK4m1pZfoQtknW5voYStIOlpZYtx8qdm00pLyg5DBIq/fGCdRnByI+xjqkdfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884744; c=relaxed/simple;
	bh=lTCxJMn/6bDXyg/fLKODxCwr/JhfLR/k283NoJJLJD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhkBTw1I+F7UgR3tlTQndF81RNjhkZgDSBNo0Bk8omVrZSUfUE5wYAFQDaj9KH6qQUKKaxcifQPBG3ibWgUBLJIFD2MYk7pzfms2DG31mLnbAPGBORiB0VfBiN8NcVabQUlXrFwvBLenuqU+h4YQtydNhRj46H4CozFqs27kCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT6DjYow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FE9C16AAE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762884744;
	bh=lTCxJMn/6bDXyg/fLKODxCwr/JhfLR/k283NoJJLJD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aT6DjYowzlt/3FDTwefxq3qKx1T4ab+22W4TZFO8JTd03EuFfZujBPATJTXHikTgE
	 kl32GytZBCjsEW7IrPOJzP4Hf6NHfCCHClwiZD06TbGPc+zwHSlFdttVWhiXUviWBN
	 Ci+xA9fAd3eDKb2qKGhzIzUzHBE4w/yWSBNPiVohl1nmF11PZx3S7Nvb+vb7H1CYn8
	 VMrLjzdAvmu/iJYkZ5Zck9Xwv00U8MVYZLrRBr22MsNHd5lRImj9mQAVMegAGXxkuO
	 VCpjdNzJS2wkkKQ50+Bzs+n00XQbhh04UETuGqOSLLn/N+9lFkImsjQl44aFY/E0L+
	 05tacGa3f7sfQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59457f79859so4892346e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:12:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOmSWYGkcrS50nUTnuxxUVvSIByWGrYVD0w2Ztb7pQfeMhnq9gGjcuvSImUIOMyQ87c1GjLA8SV65oRcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LGoYk1x/LpQIAsWMW5WcgoziH9PFbLm+XXjcv/fJE27sf5ph
	A0rVrgt0NTjMlI0kp+JiK58CDdo1tDme6o3BkjW48BQTFSA3J/kuZIXb4hlzvkJlh8YBs/lchGY
	FMBPJTJ0hh4NJLuAKSibrceDLH9QDUiY=
X-Google-Smtp-Source: AGHT+IFaLZGslf6Y4e2Gfx83he2249ML5F9vDcpqNRQfr8qUng2lvu/+jwgXrRKaAYQyZeBN0XHoqqFRlqSblUMAP/o=
X-Received: by 2002:a05:6512:12c8:b0:594:27c6:a18 with SMTP id
 2adb3069b0e04-59576df2b85mr79110e87.4.1762884742898; Tue, 11 Nov 2025
 10:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010-efi_fw_bug-v3-1-78259db0f39a@debian.org>
In-Reply-To: <20251010-efi_fw_bug-v3-1-78259db0f39a@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Nov 2025 19:12:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFAf1_MAtyvWHP+eGUa4EvbXUiaLUdHsUw6=Cph3Rr4oA@mail.gmail.com>
X-Gm-Features: AWmQ_bnsrlgAdqA9X701eZqDvHOhfoIS1fhJdslir8NfdVWFk3tPRx4vdeFtwu0
Message-ID: <CAMj1kXFAf1_MAtyvWHP+eGUa4EvbXUiaLUdHsUw6=Cph3Rr4oA@mail.gmail.com>
Subject: Re: [PATCH v3] efi/memattr: Convert efi_memattr_init() return type to void
To: Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 12:44, Breno Leitao <leitao@debian.org> wrote:
>
> The efi_memattr_init() function's return values (0 and -ENOMEM) are never
> checked by callers. Convert the function to return void since the return
> status is unused.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Changes in v3:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v2: https://lore.kernel.org/r/20251010-efi_fw_bug-v2-1-61b2915dce76@debian.org
>
> Changes in v2:
> - drop the other patches from the previous patchset
> - Link to v1: https://lore.kernel.org/r/20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org
> ---
>  drivers/firmware/efi/memattr.c | 7 +++----
>  include/linux/efi.h            | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index c38b1a335590d..e727cc5909cb6 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -19,19 +19,19 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
>   * Reserve the memory associated with the Memory Attributes configuration
>   * table, if it exists.
>   */
> -int __init efi_memattr_init(void)
> +void __init efi_memattr_init(void)
>  {
>         efi_memory_attributes_table_t *tbl;
>         unsigned long size;
>
>         if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
> -               return 0;
> +               return;
>
>         tbl = early_memremap(efi_mem_attr_table, sizeof(*tbl));
>         if (!tbl) {
>                 pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
>                        efi_mem_attr_table);
> -               return -ENOMEM;
> +               return;
>         }
>
>         if (tbl->version > 2) {
> @@ -61,7 +61,6 @@ int __init efi_memattr_init(void)
>
>  unmap:
>         early_memunmap(tbl, sizeof(*tbl));
> -       return 0;
>  }
>
>  /*
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index a98cc39e7aaa8..0b9eb3d2ff977 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -772,7 +772,7 @@ extern unsigned long efi_mem_attr_table;
>   */
>  typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
>
> -extern int efi_memattr_init(void);
> +extern void efi_memattr_init(void);
>  extern int efi_memattr_apply_permissions(struct mm_struct *mm,
>                                          efi_memattr_perm_setter fn);
>

I've queued this up now in efi/next - thanks for your patience.

