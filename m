Return-Path: <linux-kernel+bounces-824466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B36B894D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A521BC805C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BEF30C100;
	Fri, 19 Sep 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGsmlEpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AE19755B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282193; cv=none; b=JQazASnyIgyrIvNWSlS3VqgDKs8I2irj/IHBm8eC39NXDKe8uKooBB62kMIldlZ/eg3dl5Ue2hJH7DdbkWeiPRxni0B+5TW3Ae7Lnz3f2TbvIEo2J6Y6OtsGvHrw8sAp0tFquphFLzfx3AhXE3aAaPaxkgbry1Pu/4EBEXvWLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282193; c=relaxed/simple;
	bh=5wglAAJW6dtD3zr2BQTAlG8RqtqO5qLqQ6ESZ1Vv9nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnvwkZ8mdaMln0D9jz9/XUl7QaqyOau7t+9EMSZ9yO/sRFCdjBc54ym3D3DrvPbhg//DP4W4NbUY4r26UA0BOWtAyLc+o9+kUfLafG6PdbxqOU4FSOsqlCdMQcPXwVy7RjtKlWEVRJYPmaIULFbU/NVIesMgdHI7AZXzh4MRwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGsmlEpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851A9C4CEF1;
	Fri, 19 Sep 2025 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758282192;
	bh=5wglAAJW6dtD3zr2BQTAlG8RqtqO5qLqQ6ESZ1Vv9nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGsmlEpmgzvww2EUDkPbshduKf9U4oiLIqpMJorBL5ymV8RtIxABtWRBZyI/Xa1E0
	 M7FJyq3adqvTP0doBAN18XoGYF7BYkKI+imJFjheRTGreD4lRVA5N8FboL3J86OHMy
	 nxKObp9UBog6lvkwb8piDCsxuCsFVHyC0v+bJPNWa0Hdg/XQtJC3BlK5wtcEzU/ig5
	 m1r9Qz2Qc3oFWQhssbajVJKGf3RUs4zeBjqT+tBKPl9pchahJf8M3r2VilQX0L1RKX
	 ozQBfdnnbrDOIULdHnrKnjXMnhuroQU3mPnau7gq1WGFBBm+iCH6bSaim92dJbqljz
	 3NCgo9ff0IHrg==
Date: Fri, 19 Sep 2025 12:43:07 +0100
From: Will Deacon <will@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com, sudeep.holla@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	beata.michalska@arm.com, ptsm@linux.microsoft.com,
	sumitg@nvidia.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arch_topology: move parse_acpi_topology() to
 common code
Message-ID: <aM1By_d3K_hW-JTZ@willie-the-truck>
References: <20250919085918.5442-1-cuiyunhui@bytedance.com>
 <20250919085918.5442-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919085918.5442-2-cuiyunhui@bytedance.com>

On Fri, Sep 19, 2025 at 04:59:18PM +0800, Yunhui Cui wrote:
> Currently, RISC-V lacks arch-specific registers for CPU topology
> properties and must get them from ACPI. Thus, parse_acpi_topology()
> is moved from arm64/ to drivers/ for RISC-V reuse.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/kernel/topology.c  | 87 +---------------------------------
>  drivers/base/arch_topology.c  | 89 ++++++++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 90 insertions(+), 87 deletions(-)

I'm fine with shedding code from arch/arm64/ but this needs an Ack
from Sudeep.

Will

