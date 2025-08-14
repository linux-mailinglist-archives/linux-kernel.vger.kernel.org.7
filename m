Return-Path: <linux-kernel+bounces-769713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB075B272BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1557725DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5B2853E3;
	Thu, 14 Aug 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtf5cjKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC055211A19;
	Thu, 14 Aug 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212501; cv=none; b=PP96+SvpSou+P+rWBvFeBVkkRz0rPMSejV1RMkup5h1G24VImT4WrAdhN7J4/lbHag8Q28KD4kxrpm+waqFki/HRbCNoqnEgtwgt5PPv+jUKrY3snYCMQVSK4ri2MSTccM6toWOzxq5kk9OT99ZPFwbkSdHHx8UT0HeAC68B234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212501; c=relaxed/simple;
	bh=71270bDwQGdyjI2tptY1IgBLbrB/+yi1tFe2mVuz4C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6HCNo3+nT98j22YlzW1DlLizNsVwHH9WIQFj5IImrlDZ9pKNqBDWPepL+unRYhm9f65c7XOEtPHAK97OObTCJ1NCd2JsFPXNWkomQLoC5poDzUhEF8uLKgWEZ/GpXhVlVe+YR2YsToLG99yTikfIYze+NYXQC1xaxeHmFenqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtf5cjKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA21C4CEED;
	Thu, 14 Aug 2025 23:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755212501;
	bh=71270bDwQGdyjI2tptY1IgBLbrB/+yi1tFe2mVuz4C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vtf5cjKRs3CRafEa4qw9FGnBuhKVtmby7/CdYjmzF1Opmlbyaz5yL4yGknkkQPlPK
	 GW0Vu1jxMrVOcpZhtc2NMCmbaKZbtaoXy4kV2eT7AQeck3QXZO8ueHADf8GDE+BIWa
	 PapHIDMT+Bfjopjsb/9W/r29u45cKnL+klCdz3koCB0xHaM0RHiHf8qU68Sy3XamX5
	 SUiZYAUAQhXCQzRskkxv7yAIf18wzwqJSUmgQCcNDf89oLeVCtwlDdBGWhl2kMDRXJ
	 Ym8QmJIzcIkJAv0xX25jI86HT0QTbDMGAN1x47QY3g11LE5ZeTdIvGh3VFR/O55YWL
	 66b0qbmPfn0Bw==
Date: Thu, 14 Aug 2025 16:01:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix objtool warnings if LTO is enabled for LoongArch
Message-ID: <20250814230137.GA2247447@ax162>
References: <20250812132716.1465-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812132716.1465-1-yangtiezhu@loongson.cn>

On Tue, Aug 12, 2025 at 09:27:14PM +0800, Tiezhu Yang wrote:
> The patch #1 should be a preparation for patch #2, that is to say,
> the patch #2 is dependent on the patch #1, otherwise there is build
> error if LTO is enabled after only applying patch #2.

Thanks, these two patches do indeed resolve most of the warnings that I
see.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> With this series, most of warnings have been silenced, only remains
> the following warning by now, it needs more analysis:
> 
>   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel() falls through
>   to next function __efistub_exit_boot_func()

Yes, I do see this one too. Odd, as efi_boot_kernel() ends in a
__noreturn function...

Cheers,
Nathan

