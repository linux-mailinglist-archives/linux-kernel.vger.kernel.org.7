Return-Path: <linux-kernel+bounces-892677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7513CC459A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09104E8972
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95262F7AB5;
	Mon, 10 Nov 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNZ4NAYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532641E47C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766567; cv=none; b=SZUWNdp+B9ROc9gfktVpcFVoD967TmCvLxlm01rFp495xbv0r7BKVJN8mXhuEVBNw8cVJtJ7nE5EAV6V2myqoamkvNZ7EtHGe5fC6pMJoFMBIO0sU4Sy4ucGvvjjzdtekn62wb/iClam3gjcq4aLqFsbKthmuNgYabiJpo7L03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766567; c=relaxed/simple;
	bh=+xiY9MN26eBYxB9c0SfjXDZIdjSMZQRG2772qKMqFlM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rAIIgaX/+BJrNLQI2yK1frCEtqUztx2NY4K6U3GDVOf7mbnWI0pQGSCdkJzlnF3DGZrtudGxuggxrAQMUOwMzK2R9JQ9y/BiFfqzlgYbmSYR9lRYS/KBHZrL17qhWNk1pi/B63VQFk1ZjIUe9OsqeOXU8UIvS1/04pzEVsQ7acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNZ4NAYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995C8C4CEF5;
	Mon, 10 Nov 2025 09:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762766565;
	bh=+xiY9MN26eBYxB9c0SfjXDZIdjSMZQRG2772qKMqFlM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kNZ4NAYDkj9Sw+R4r+dGD3+NO8AfuxxiP72xtldiNIYmVqPaf5J3YkdPklOTlYPGY
	 ObRcEe/2VasAPMzAeODsCrv2fPgTB9BtWmKHrWyJADP2UlTA3QYSi9kApF0CXFmhV9
	 IgYn2WVhMosSdS2MFXyuyrsw/oyFbXvJBgKdHRwdIte/Jk6+twip02quVm0x7+/lhI
	 hwEGKeM6m7DR9sliZKoBM3igT4RYzx48W4mbuL3pobD+jUBfgazCLMGikc8tjrbO+1
	 TMrG/aZguLEeIe5XLQ9htqVOrVOtF0Z5R8jZXSnJtuCU72IpvWs0vc8F0UtUIOLIUH
	 CnbzEdfI7ay8w==
Message-ID: <17b8c497-c1ad-4a31-a8ad-a5d73b7c2e82@kernel.org>
Date: Mon, 10 Nov 2025 17:22:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: revert summary entry count from 2048 to
 512 in 16kb block support
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251104162402.928582-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251104162402.928582-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 00:24, Daeho Jeong wrote:
>  static void write_sum_page(struct f2fs_sb_info *sbi,
> -			struct f2fs_summary_block *sum_blk, block_t blk_addr)
> +		struct f2fs_summary_block *sum_blk, unsigned int segno)
>  {
> -	f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
> +	struct folio *folio;

w/ 4k-sized block config, I suffered performance regression issue while testing
fallocate() on pinfile.

Seems we need to add below code:

	if (SUMS_PER_BLOCK == 1)
		return f2fs_update_meta_page(sbi, (void *)sum_blk,
					GET_SUM_BLOCK(sbi, segno));

Otherwise, we will load summary block whenever we change segment for curseg.

Thanks,

