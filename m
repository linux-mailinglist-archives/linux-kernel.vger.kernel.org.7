Return-Path: <linux-kernel+bounces-579737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B79A748D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 11:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8915A7A8932
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328C213232;
	Fri, 28 Mar 2025 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9TDsGYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2801531C5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159546; cv=none; b=Hk2mD2HOgf6dOwPG2yo9m/nq3HBB1d5Ubxy6YK62fXyVMTrLvPIbEM2OGjD7Hypnz3gaD5Gym7COn+WszgHsGk5Fv/NsEZbrIG8yOBodsNTF4ZLUDajUkX8WqnDMIfAu1U9k7/N1VQ5xOyPDCaM1YjbUV+oGXYwryIS4+8lJpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159546; c=relaxed/simple;
	bh=M80BwyeI/5FhFXlfX1oHfEYhuopM64H98lTBJqDtmUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grTOQPYtVRD6yWk2RGifVNJKALDRQhpMaSzo3rezmF1AGoIFKwNHO7za4M1Plqg2UKjSa6R+4XJN9cij0WR7d12FnPagrUuMwO65xHBQUzWMpoY2ub21yzOXYFspQHlZnowyZ0O5lmfRwaVX55iGEpS9JfEsxfDuZmtfr7OGGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9TDsGYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0744CC4CEEA;
	Fri, 28 Mar 2025 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743159545;
	bh=M80BwyeI/5FhFXlfX1oHfEYhuopM64H98lTBJqDtmUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9TDsGYnRmR2NTB+cMFv3V7o4VGVVAeWJz4o/XS8VEzMYhfz1f/tpnAbCoB4D/WLH
	 K+rWsdPhTZplESNX/zBQwfJQj4Izc47Z130tirzVE1hXbyuhL1q39lSBC6rAmMXyTX
	 Kgvf9GvWT7Qbi+XybKYWg3AHJkQ1gJJRam2FHvOA6xBwdwBSwwu0fVyjEizpEaHBto
	 up7QGzu7JRaSNPdOK6KjJ7Bl8mcx4aE6zenTXKAHB9m+I3WdtCDoKRj50PzPFNC0ot
	 X4qtrSjQ8uTwT1J70iilAWU9mG7V/oZT5MRUC3dLroa7uxpundunvmkvKIsD/sFzSB
	 3dnDRGVUgrkVQ==
Date: Fri, 28 Mar 2025 11:59:00 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	nouveau@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lyude@redhat.com, sumit.semwal@linaro.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/nouveau: prime: fix ttm_bo_delayed_delete oops
Message-ID: <Z-aA9LBCtdCK4YYr@pollux>
References: <Z9GHj-edWJmyzpdY@debian.local>
 <00e4d9c4-ecfc-4784-b603-12db04cda806@amd.com>
 <Z9q-ggKKgTsvW-Rz@debian.local>
 <Z9rA0G2urlVHFOSx@cassiopeiae>
 <1f4a534f-8883-4793-b191-60c2773f6217@amd.com>
 <Z9rSTkXlub-JZAz0@cassiopeiae>
 <Z-P4epVK8k7tFZ7C@debian.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-P4epVK8k7tFZ7C@debian.local>

On Wed, Mar 26, 2025 at 12:52:10PM +0000, Chris Bainbridge wrote:
> Fix an oops in ttm_bo_delayed_delete which results from dererencing a
> dangling pointer:
> 
> Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b7b: 0000 [#1] PREEMPT SMP
> CPU: 4 UID: 0 PID: 1082 Comm: kworker/u65:2 Not tainted 6.14.0-rc4-00267-g505460b44513-dirty #216
> Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/16/2024
> Workqueue: ttm ttm_bo_delayed_delete [ttm]
> RIP: 0010:dma_resv_iter_first_unlocked+0x55/0x290
> Code: 31 f6 48 c7 c7 00 2b fa aa e8 97 bd 52 ff e8 a2 c1 53 00 5a 85 c0 74 48 e9 88 01 00 00 4c 89 63 20 4d 85 e4 0f 84 30 01 00 00 <41> 8b 44 24 10 c6 43 2c 01 48 89 df 89 43 28 e8 97 fd ff ff 4c 8b
> RSP: 0018:ffffbf9383473d60 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffffbf9383473d88 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffbf9383473d78 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 6b6b6b6b6b6b6b6b
> R13: ffffa003bbf78580 R14: ffffa003a6728040 R15: 00000000000383cc
> FS:  0000000000000000(0000) GS:ffffa00991c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000758348024dd0 CR3: 000000012c259000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __die_body.cold+0x19/0x26
>  ? die_addr+0x3d/0x70
>  ? exc_general_protection+0x159/0x460
>  ? asm_exc_general_protection+0x27/0x30
>  ? dma_resv_iter_first_unlocked+0x55/0x290
>  dma_resv_wait_timeout+0x56/0x100
>  ttm_bo_delayed_delete+0x69/0xb0 [ttm]
>  process_one_work+0x217/0x5c0
>  worker_thread+0x1c8/0x3d0
>  ? apply_wqattrs_cleanup.part.0+0xc0/0xc0
>  kthread+0x10b/0x240
>  ? kthreads_online_cpu+0x140/0x140
>  ret_from_fork+0x40/0x70
>  ? kthreads_online_cpu+0x140/0x140
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> 
> The cause of this is:
> 
> - drm_prime_gem_destroy calls dma_buf_put(dma_buf) which releases the
>   reference to the shared dma_buf. The reference count is 0, so the
>   dma_buf is destroyed, which in turn decrements the corresponding
>   amdgpu_bo reference count to 0, and the amdgpu_bo is destroyed -
>   calling drm_gem_object_release then dma_resv_fini (which destroys the
>   reservation object), then finally freeing the amdgpu_bo.
> 
> - nouveau_bo obj->bo.base.resv is now a dangling pointer to the memory
>   formerly allocated to the amdgpu_bo.
> 
> - nouveau_gem_object_del calls ttm_bo_put(&nvbo->bo) which calls
>   ttm_bo_release, which schedules ttm_bo_delayed_delete.
> 
> - ttm_bo_delayed_delete runs and dereferences the dangling resv pointer,
>   resulting in a general protection fault.
> 
> Fix this by moving the drm_prime_gem_destroy call from
> nouveau_gem_object_del to nouveau_bo_del_ttm. This ensures that it will
> be run after ttm_bo_delayed_delete.
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Suggested-by: Christian K�nig <christian.koenig@amd.com>
> Fixes: 22b33e8ed0e3 ("22b33e8ed0e3nouveau: add PRIME support")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3937
> Cc: <Stable@vger.kernel.org>

Applied to drm-misc-fixes, thanks!

[ Fixed up the Fixes: tag, where the commit hash is repeated in the commit
subject. ]

