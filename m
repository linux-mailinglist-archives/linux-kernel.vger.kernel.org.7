Return-Path: <linux-kernel+bounces-871359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE2CC0D070
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 804144E42D6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AFF2F6932;
	Mon, 27 Oct 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1i3VFp9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6EF2F12CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562518; cv=none; b=uAzBe8jDygzjTcJ6SELIsSFQzj3MQlRmp2ufbobTd7udatv1JlEw3p64Lr+2F8VCcPilcfq+/vYd2pNFDfFKG5bPaPYuZSOuMjvmf4unPb3gxk3SppG6p8OMdALwrVLt9KLCU1PB7cOjxOa7A1I10b8mX6y+5bfSzGmzOKBeru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562518; c=relaxed/simple;
	bh=3fwo38ms8nGzEG6hFj5mAdcLcwwXqYE04olV9vcAGWw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fiCAEd9ylIN5sbWqTVaX0a8YvkJR14k9YSOKyOS9sWcet4DclNmDEOBdRTv6C5QIYL9XUY7xPSegc7q46MvA6vdgHUDwhs++19sGoEb0uB3V2XbZgSqHRo/rrvH9puwdKOOe9WV0fMAJmnVRmj45LX6zqBTRGHjUTn1fur+/bOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1i3VFp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0A4C4CEF1;
	Mon, 27 Oct 2025 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761562517;
	bh=3fwo38ms8nGzEG6hFj5mAdcLcwwXqYE04olV9vcAGWw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=X1i3VFp9/ehOiIEMThFMBK4kV0y2sBGaPPEBW11EW7n7ZZmLM/pI81R279hQroNuU
	 VBbFPJy8Jep5oTFNw8YqeIz5zCnRnoumCQ1VJlSBVUqPXRcsKdvVC2gfV3e/3IoZZv
	 bqmG/U4Jf/pTL+X8ROU/Pk7GhKpAn1g+73CnNe05GSLtE7SInAGFq1Ql029CXAE3PT
	 X8Wg/jZTZYXPR3hI67KFl6EVXBO6S+fbjkqAwLHsfhD477CQ7HMqD8Os8XZaHRs+JP
	 4FY1/yzMX/79IXX0YlIUYk9YMpJ320q23QXzSqxZAMLcRoYmku3WiqG/NAH+8UAosO
	 /SlsF1pIJ6f4A==
Message-ID: <e1771667-d801-4778-9f95-d6dc722584f0@kernel.org>
Date: Mon, 27 Oct 2025 18:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
 stable@kernel.org
Subject: Re: [PATCH v2] f2fs: fix age extent cache insertion skip on counter
 overflow
To: Xiaole He <hexiaole1994@126.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20251023035416.7943-1-hexiaole1994@126.com>
 <20251027092341.5011-1-hexiaole1994@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251027092341.5011-1-hexiaole1994@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 17:23, Xiaole He wrote:
> The age extent cache uses last_blocks (derived from
> allocated_data_blocks) to determine data age. However, there's a
> conflict between the deletion
> marker (last_blocks=0) and legitimate last_blocks=0 cases when
> allocated_data_blocks overflows to 0 after reaching ULLONG_MAX.
> 
> In this case, valid extents are incorrectly skipped due to the
> "if (!tei->last_blocks)" check in __update_extent_tree_range().
> 
> This patch fixes the issue by:
> 1. Reserving ULLONG_MAX as an invalid/deletion marker
> 2. Limiting allocated_data_blocks to range [0, ULLONG_MAX-1]
> 3. Using F2FS_EXTENT_AGE_INVALID for deletion scenarios
> 4. Adjusting overflow age calculation from ULLONG_MAX to (ULLONG_MAX-1)
> 
> Reproducer (using a patched kernel with allocated_data_blocks
> initialized to ULLONG_MAX - 3 for quick testing):
> 
> Step 1: Mount and check initial state
>   # dd if=/dev/zero of=/tmp/test.img bs=1M count=100
>   # mkfs.f2fs -f /tmp/test.img
>   # mkdir -p /mnt/f2fs_test
>   # mount -t f2fs -o loop,age_extent_cache /tmp/test.img /mnt/f2fs_test
>   # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
>   Allocated Data Blocks: 18446744073709551612 # ULLONG_MAX - 3
>   Inner Struct Count: tree: 1(0), node: 0
> 
> Step 2: Create files and write data to trigger overflow
>   # touch /mnt/f2fs_test/{1,2,3,4}.txt; sync
>   # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
>   Allocated Data Blocks: 18446744073709551613 # ULLONG_MAX - 2
>   Inner Struct Count: tree: 5(0), node: 1
> 
>   # dd if=/dev/urandom of=/mnt/f2fs_test/1.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
>   Allocated Data Blocks: 18446744073709551614 # ULLONG_MAX - 1
>   Inner Struct Count: tree: 5(0), node: 2
> 
>   # dd if=/dev/urandom of=/mnt/f2fs_test/2.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
>   Allocated Data Blocks: 18446744073709551615 # ULLONG_MAX
>   Inner Struct Count: tree: 5(0), node: 3
> 
>   # dd if=/dev/urandom of=/mnt/f2fs_test/3.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
>   Allocated Data Blocks: 0 # Counter overflowed!
>   Inner Struct Count: tree: 5(0), node: 4
> 
> Step 3: Trigger the bug - next write should create node but gets skipped
>   # dd if=/dev/urandom of=/mnt/f2fs_test/4.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
>   Allocated Data Blocks: 1
>   Inner Struct Count: tree: 5(0), node: 4
> 
>   Expected: node: 5 (new extent node for 4.txt)
>   Actual: node: 4 (extent insertion was incorrectly skipped due to
>   last_blocks = allocated_data_blocks = 0 in __get_new_block_age)
> 
> After this fix, the extent node is correctly inserted and node count
> becomes 5 as expected.
> 
> Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
> Cc: stable@kernel.org
> Signed-off-by: Xiaole He <hexiaole1994@126.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

