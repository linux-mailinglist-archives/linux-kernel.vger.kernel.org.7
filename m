Return-Path: <linux-kernel+bounces-837926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825BBAE149
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F68F7A76F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9424DD01;
	Tue, 30 Sep 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="M0QfT11h"
Received: from outbound.mr.icloud.com (p-west2-cluster2-host12-snip4-10.eps.apple.com [57.103.68.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C824468C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250684; cv=none; b=ib7boAtN1p1cWqQEQNBUjM1tl7w58DZ+znDEHBr+/qCUK07fJjpXnDiggPR5lS3HwRyuHCKRGfPeQspI72PCF47XjNUxlX2Fg6JuAk5gyKvxGB+kgIb/qZP30EHzEKtH8hTK3lF0YoroNWUc9jTHh3AwG2m2pwNWSLfByCyik+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250684; c=relaxed/simple;
	bh=sQiCV8qRWNjiPUhz8IMx60rpDPb2crbK3cdJNDJ3n1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP0j274Lb4OuPnH6HSjnDcusP2xRHOX9qYPdLB9WHwmfzlXwnZd37qnmCBGqFqddy2kvn4PUNaYWkKxNvg9Vm0t+nTmf8sEwdPAoNk4L7WiZrfZ6wbB7CPCZGklKiZ7JKQAW49ksVIuzKhjk/jJVE6gAnfHr8JCXtE/QrQifl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=M0QfT11h; arc=none smtp.client-ip=57.103.68.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id 33C371800475;
	Tue, 30 Sep 2025 16:44:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1; bh=Wm9ID2j2FmK+Vgk8dah0ebA5iBileEnik5nUL2fWP+E=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=M0QfT11hfp4fT0baMyGzDZARMgEcSsCrzc28M8oY1rSNjAjv/jYbuw+JUOHjBAzSkNQTwJLhZJlyzkg92IdsbqHvAYHZE5oSPgOZ1dzRsUIxYnBCjQ1qJhpZrKThBfZ3csrvCi3ZexrLPwXMYEUObien1VJ2cEtu8ioiba2NYGRJ3ctQ7wQv5DhUnrczdbdt16tjaJj+h/oa4vj2sKUejyAakvIk5P/HGjRIKnOYDqgJDQqEDVg7Dh02DF1fZhgOBASkI8MyIGa+qT5Z2bu/RbelwLSzJCa25AF/mX0QRHqj+LHdryZjcv+++3pQ7jFGrLHTZaWhiA/DpFd+jwIwDQ==
mail-alias-created-date: 1632196724000
Received: from hitch.danm.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id 210331800727;
	Tue, 30 Sep 2025 16:44:39 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: rppt@kernel.org
Cc: bp@alien8.de,
	dan@danm.net,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: [PATCH] x86/Kconfig: enable ROX cache in execmem when STRICT_KERNEL_RWX is set
Date: Tue, 30 Sep 2025 10:44:35 -0600
Message-ID: <20250930164435.23044-1-dan@danm.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250716075410.82578-1-rppt@kernel.org>
References: <20250716075410.82578-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cG4KWAmATXQyx7FFLuCD81Uo__oEgFa9
X-Proofpoint-ORIG-GUID: cG4KWAmATXQyx7FFLuCD81Uo__oEgFa9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE1MSBTYWx0ZWRfXz8P3zTxNrIHF
 1KWtKv/lU7Koa3XlAkIY6Aj5DINjS5W+k3NVkhej7CO4nq0dbIUs7q5v84ZWoMoBQNmEX1179Qp
 9Dw/6fwfi0Ne4xu4Do2OLV8cOM/blTNT2A4RAh0QJJwech7afQqxs+Dx4yqfYO3QnYk2U4ryTH/
 W0s/VTyI5V53vJma1Q/IWYBwVXoFz3AIPIo7kaJWZpngE+oc/7W98GtftlJSjmixbrE8IPMQciy
 +RPHeYe+w3YxwQRypYavcbUnuOHqxx1K575eIjfmm9PqC9SDeCDB7VWdYaL9xCQy9AvjyGUrg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=809 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509300151
X-JNJ: AAAAAAABcuBZ8q0QzjvlELe9DWsTh2GsOakWRdAqUjNuhDJWT5r3sHSoGaqoyzKhJF3n0/v10tToMycMq9zku5patHVTMyghakdn4mX0yWg2S8GRgCB3+Rb+8n4DqGhiWJ+PbF/1ak4hg1FH0dS8nvR+dZqJ1XHLalCtNv0XkGWxfZIq9KMZYJofOmQzf+3P/W8aBmVMTV9BffApInu5/0V81M1meMXZyTc8Uj8uTSeoNvAuUQkeFdip7u4AAVqCxh6JUY6rB+LyBed3DN6dAQTRn7bRX330fvSnIKct5NKk+xeyVE5eJe4ztaEYRqfsoNCDZmtOU/z6Cvey3p8pcd/FN09n1klVEky/zmbaMqlcxV51eHaO2MLRdglMLa+QJsB0JUqQMBZpW6eqa99Xf3NDWXxlZzXLRcAPp20aMjNukzLlDrBMkj1QUNAkWuZSlTB62uq3VfqG9IYN0LyT6UKxUSedP+23uUfVTQVmZbtKhRE4wvLk9//gxN9P3Z4fnC6Szl6RWWelAUZh/7uU7FBLvsilXgz330pFBL0v+UXHYPXaXWyZTLyOxWvhf4lvMsO/CC9divcL4bCco4VxL3Rjit2x0o+LsZagVixxmVSBHGtxjOcKAzPWxgo11oO0PEFRxEROTwIQ8A7O2IpiJ6yomONJa/1leUzbV6z4BJY9n1CDvs8zNkN7xDQO1DWrch1c76ud

> Dan Moulding reported that kernel configured without modules produces
> "Found insecure W+X mapping at address 0xffffffffc0247000" warining:
>
> [    6.022847] ------------[ cut here ]------------
> [    6.023020] x86/mm: Found insecure W+X mapping at address 0xffffffffc0247000
> [    6.023200] WARNING: CPU: 5 PID: 1 at arch/x86/mm/dump_pagetables.c:246 note_page+0x6ec/0x790
> [    6.023381] CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.16.0-rc6 #1 PREEMPT
> [    6.023558] Tainted: [T]=RANDSTRUCT
> ...
> [    6.031153] x86/mm: Checked W+X mappings: FAILED, 10 W+X pages found.
>
> The 10 W+X pages are the pages allocated for ITS thunks. With
> CONFIG_MODULES disabled, CONFIG_STRICT_MODULE_RWX does not exist and ROX
> cache in execmem is not enabled so execmem_restore_rox() becomes an empty
> stub.
>
> Enabling ROX cache when CONFIG_STRICT_KERNEL_RWX is set solves the issue and
> makes ITS thunks memory properly protected.
>
> It also ensures that memory containing ITS thunks is mapped with 2M pages
> for kernels compiled without modules.
>
> Reported-by: Dan Moulding <dan@danm.net>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8bed9030ad47..d6d8050683ae 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -89,7 +89,7 @@ config X86
>  	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
>  	select ARCH_HAS_EARLY_DEBUG		if KGDB
>  	select ARCH_HAS_ELF_RANDOMIZE
> -	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
> +	select ARCH_HAS_EXECMEM_ROX		if X86_64 && (STRICT_KERNEL_RWX || STRICT_MODULE_RWX)
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>
> base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
> --
> 2.47.2

Just a friendly ping to see if this patch has been applied. I haven't
been able to find it in any of the relevant trees, and wanted to be
sure it doesn't slip through the cracks.

Thanks!

-- Dan

