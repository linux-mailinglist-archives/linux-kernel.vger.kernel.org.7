Return-Path: <linux-kernel+bounces-830091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C0B98B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBEB3B951C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF644280018;
	Wed, 24 Sep 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPQ8XGB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CE27FD62
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700744; cv=none; b=QIzxBnlO3nJTbk4cnvAgRPjr+rgWgezThpYloguX0Dj5xNfOYthdokBrLF/DpQIqa5GBqTa4M0X5rYlKvCky/+UxZWlwEAYDOoChEJwCRy4uN4ItsvkiPSCqgtvFJMtT02LSF2hBcYX+NK8scrfh36HZXbJMTW2YMg0XYjIt328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700744; c=relaxed/simple;
	bh=ebGmTogsoiIyNshxuoFonK4bfNHzVNAVFWeWw4P6UXs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O3d4PSHfPR/CruPBYRypyB/KiAB6qNYaKiOLnrCeSZWghqYobUoCzBTahtdzhumqllSLwjth9e7euodPuHZZJO60IgzbxbsTIpwLidZZLy8YmvoB099A6NcJGsyzrnPNkWN/vQZAYC16JVrHK+/1nql59jjiwMkmBCdPT/LcQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPQ8XGB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB21C4CEE7;
	Wed, 24 Sep 2025 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758700742;
	bh=ebGmTogsoiIyNshxuoFonK4bfNHzVNAVFWeWw4P6UXs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LPQ8XGB7T0yQzn+lDE3chKsbahiJJmvuFHgieF8/se7iVnfHY32swQwMLjw6jDL8X
	 njuN9dNeSNJoqDHMS11aZ0VFj+J2NO8wMdkjFepFgc7FthNiP+HkpNQv13ANedFr4f
	 NlkMU1Zb3TlocBBQk+l7Gs6ptIr4I45hBHRY3N/wWrEojhM/mm7V4abUGain9Vnf7H
	 4mckGpU2v5XwHat794wQH3jhNB1vQv8SxjoSONKaJMM8hf0/cZ5QNZKG6QGev/ytQc
	 LvTpK8xkpns7fEdTIUt+hUn0nw4yFwFfmgE1yueM7lJSpunxfOncjpecexy9BA9JW1
	 OSTbjZ3xT6uzQ==
Message-ID: <6529ffee-d2ee-41ff-97d0-bf483fd0530a@kernel.org>
Date: Wed, 24 Sep 2025 15:58:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Sunmin Jeong <s_min.jeong@samsung.com>
Subject: Re: [PATCH v4] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE
 mode
To: Yunji Kang <yunji0.kang@samsung.com>, jaegeuk@kernel.org
References: <CGME20250924074405epcas1p3a116daa0efa4a22d1741437b0cf59f8d@epcas1p3.samsung.com>
 <20250924074358.253759-1-yunji0.kang@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250924074358.253759-1-yunji0.kang@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 15:43, Yunji Kang wrote:
> In f2fs_precache_extents(), For large files, It requires reading many
> node blocks. Instead of reading each node block with synchronous I/O,
> this patch applies readahead so that node blocks can be fetched in
> advance.
> 
> It reduces the overhead of repeated sync reads and improves efficiency
> when precaching extents of large files.
> 
> I created a file with the same largest extent and executed the test.
> For this experiment, I set the file's largest extent with an offset of 0
> and a size of 1GB. I configured the remaining area with 100MB extents.
> 
> 5GB test file:
> dd if=/dev/urandom of=test1 bs=1m count=5120
> cp test1 test2
> fsync test1
> dd if=test1 of=test2 bs=1m skip=1024 seek=1024 count=100 conv=notrunc
> dd if=test1 of=test2 bs=1m skip=1224 seek=1224 count=100 conv=notrunc
> ...
> dd if=test1 of=test2 bs=1m skip=5024 seek=5024 count=100 conv=notrunc
> reboot
> 
> I also created 10GB and 20GB files with large extents using the same
> method.
> 
> ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
>   +-----------+---------+---------+-----------+
>   | File size | Before  | After   | Reduction |
>   +-----------+---------+---------+-----------+
>   | 5GB       | 101.8ms | 37.0ms  | 72.1%     |
>   | 10GB      | 222.9ms | 56.0ms  | 74.9%     |
>   | 20GB      | 446.2ms | 116.4ms | 73.9%     |
>   +-----------+---------+---------+-----------+
> Tested on a 256GB mobile device with an SM8750 chipset.
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yunji Kang <yunji0.kang@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

