Return-Path: <linux-kernel+bounces-843750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3897BC025A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 06:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D2A18967AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 04:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA821257E;
	Tue,  7 Oct 2025 04:23:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED406EACE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811024; cv=none; b=eDFvmVObn6iq2KKUTp9xHTJnT2U2mqLyNm3LmKdPI61PwDQ5bq4hfhYBsmGfW8qMmGh+Y6IyTvdXladyF22oJfE0cnLJaNHIrzUt7ZJEJ1ta0TxDHevu4IvVOx62IRsxD7VP3GQ3NOHOi+m63eCNqxxFqB0D8/4+8WFRB6ykipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811024; c=relaxed/simple;
	bh=ApsfYwsXPkiFzpFdm7u/nWF08g+tsmnPdnK7NcZIR44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPYIzEmWrUDDR8al22KW4yuSMU4LBD7eVu1eUfpiL9nJwsM/9ZiLVG5E8kKaCwo0J32aXobgLSUb+TxLpXzecRfp9KXGAogit07hCZduGtjIa6uFtrbh74dJtHJhjhCgu8DDFN/we95UqwyA/+vYpzzDPZrcRGTcJTj76+ckyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3549614BF;
	Mon,  6 Oct 2025 21:23:34 -0700 (PDT)
Received: from [10.164.18.47] (unknown [10.164.18.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A99393F59E;
	Mon,  6 Oct 2025 21:23:40 -0700 (PDT)
Message-ID: <78c79b17-6827-4679-aaef-4633eada9043@arm.com>
Date: Tue, 7 Oct 2025 09:53:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] (no cover subject)
To: pratyush.brahma@oss.qualcomm.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/09/25 4:04 PM, pratyush.brahma@oss.qualcomm.com wrote:
> mm/numa_emulation: Code refactoring to improve modularity and
> readability

This should have been the cover letter subject line.
> 
> This series intends to improve the code readability by using
> existing macros instead of hardcoded values for size and improves
> the modularity by moving the size calculation for emulated blocks
> to a separate function.
> 
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

In general, a signed of statement is not required for the cover letter.
> ---
> Pratyush Brahma (2):
>       mm/numa_emulation: Refactor NUMA emulation size handling to use kernel macros
>       mm/numa_emulation: Move the size calculation in split_nodes_interleave() to a separate function
> 
>  mm/numa_emulation.c | 47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> ---
> base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
> change-id: 20250926-numa-emu-6e6c27bd8f6f
> 
> Best regards,
> --  
> Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Ditto.

Seems like portions of this cover letter has been all jumbled up.

