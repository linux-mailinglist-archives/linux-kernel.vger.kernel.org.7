Return-Path: <linux-kernel+bounces-760161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59359B1E738
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F93E7A1DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A327A139;
	Fri,  8 Aug 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIZcQEQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794C27A123;
	Fri,  8 Aug 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652278; cv=none; b=VSHtzwa7FnNyfN5BBOwCl9rqe81Zu1m6XbPefLn9enxAIoKaixv2c+J4459zgIdPsjZz3eWeCWvV0RphV5iRqizm9Ik1wt+oh66KgQg8IhYYrBN32nxaiUqxQ1e61Hi4QmGwlN40z2fKqnXG4paOrAJWDaIUhccdnpLPJUcwQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652278; c=relaxed/simple;
	bh=G8XBDE8Dsdoq13Ly8auEDySbXA8PcvpOjtCB/bcB1Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uypwYNa0Nge9Nqv+9D5uY02+XNR1kFaVWulbGrNH4ITo3G3zBNs7hEPc7W1z9yzmFMukm0IPHezOawPR1Y7clis8PgrEeJoYXSuvokJt14KEoSy3JGQfEjOEIPFMVxKR8dQMUQcC411M8oE9xM0rvr1k64sqHjklZAiG/lmF77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIZcQEQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB49C4CEED;
	Fri,  8 Aug 2025 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754652276;
	bh=G8XBDE8Dsdoq13Ly8auEDySbXA8PcvpOjtCB/bcB1Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIZcQEQmb2EsfdnJKyBOEKi4tLdQvrZbohWfRHKkpyfRXc8CwqqzT5fVnB7/GxZiE
	 NqvDvbO4ZofZBESiChq3+nW4tIus+68ZlNH8bsly4+si/u0YfbqkwIBGq8CFCViQo4
	 /KhACcUbFOa0OD8+hkffDEz53ZtHcRhP1ZcDz+dp9ex6vdXjgiSYUeg08PwL34nuLk
	 9tr9mKmtKQv+CSfPjHCUgCdqEMwBiuvRTP/4xDR283aGd0217HwI/mLBUEGy0wfAQF
	 NRZb9J0t9hYHj+70EY/k0GNkk+nHieD6LzEgUR+J5wAHMKByrjlA4gj6Add953CoDc
	 E6v1BLX2jkjkA==
Date: Fri, 8 Aug 2025 12:24:29 +0100
From: Will Deacon <will@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-mm <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250729: PREEMPT_RT: rock Pi 4b Internal error Oops
 kmem_cache_alloc_bulk_noprof - kernel locking rtmutex.c at
 __rt_mutex_slowlock_locked
Message-ID: <aJXebTmgnrWw7Ks4@willie-the-truck>
References: <CA+G9fYumD2MGjECCv0wx2V_96_FKNtFQpT63qVNrrCmomoPYVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYumD2MGjECCv0wx2V_96_FKNtFQpT63qVNrrCmomoPYVQ@mail.gmail.com>

Hi Naresh,

On Sat, Aug 02, 2025 at 03:45:51PM +0530, Naresh Kamboju wrote:
> ## Test log
> [  527.570253] Unable to handle kernel paging request at virtual
> address 003f0020f94020a1
> [  527.570274] Mem abort info:
> [  527.570277]   ESR = 0x0000000096000004
> [  527.570282]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  527.570288]   SET = 0, FnV = 0
> [  527.570292]   EA = 0, S1PTW = 0
> [  527.570297]   FSC = 0x04: level 0 translation fault
> [  527.570302] Data abort info:
> [  527.570305]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  527.570310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  527.570316]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  527.570322] [003f0020f94020a1] address between user and kernel address ranges
> [  527.570330] Internal error: Oops: 0000000096000004 [#1]  SMP
> [  527.570336] Modules linked in: brcmfmac rockchip_dfi brcmutil
> cfg80211 snd_soc_hdmi_codec dw_hdmi_i2s_audio dw_hdmi_cec
> snd_soc_simple_card snd_soc_audio_graph_card hci_uart
> snd_soc_rockchip_i2s snd_soc_es8316 snd_soc_spdif_tx
> snd_soc_simple_card_utils btqca rtc_rk808 rockchipdrm btbcm
> snd_soc_core dw_hdmi_qp bluetooth snd_compress reset_gpio analogix_dp
> snd_pcm_dmaengine panfrost hantro_vpu dw_mipi_dsi rfkill rockchip_rga
> drm_shmem_helper drm_dp_aux_bus snd_pcm gpu_sched dw_hdmi pwrseq_core
> videobuf2_dma_sg v4l2_vp9 snd_timer drm_display_helper v4l2_h264
> v4l2_jpeg phy_rockchip_pcie snd v4l2_mem2mem cec videobuf2_dma_contig
> soundcore videobuf2_memops drm_client_lib videobuf2_v4l2
> drm_dma_helper videobuf2_common rockchip_saradc drm_kms_helper
> industrialio_triggered_buffer kfifo_buf rockchip_thermal
> pcie_rockchip_host coresight_cpu_debug fuse drm backlight
> [  527.570493] CPU: 3 UID: 0 PID: 34254 Comm: mkdir Not tainted
> 6.16.0-next-20250801 #1 PREEMPT_RT
> [  527.570502] Hardware name: Radxa ROCK Pi 4B (DT)
> [  527.570506] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  527.570512] pc : kmem_cache_alloc_bulk_noprof (mm/slub.c:5343
> (discriminator 1) mm/slub.c:5403 (discriminator 1))
> [  527.570527] lr : kmem_cache_alloc_bulk_noprof
> (include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/atomic/atomic-instrumented.h:33
> include/linux/kfence.h:127 mm/slub.c:5307 mm/slub.c:5403)
> [  527.570533] sp : ffff80008e24b8f0
> [  527.570536] x29: ffff80008e24b930 x28: 00ff000000584610 x27: ffff800082b30538
> [  527.570545] x26: ffff8000816b64dc x25: 0000000000000cc0 x24: 0000000000000000
> [  527.570554] x23: 0000000000000004 x22: ffff0000f7579d20 x21: 0000000000000001
> [  527.570563] x20: 0000000000000001 x19: ffff000000405b00 x18: ffff80008e24bcd0
> [  527.570572] x17: 0000000000000000 x16: ffff800081e18420 x15: 0000ffffa2670fff
> [  527.570582] x14: 0000000000000000 x13: 1fffe000017942e1 x12: 0000ffffa2470fff
> [  527.570591] x11: ffff00000bca1708 x10: 0000000000000001 x9 : ffff8000816e41a4
> [  527.570600] x8 : ffff80008e24b850 x7 : fefefefefefefefe x6 : ffff800082b30000
> [  527.570608] x5 : d63f0020f9402021 x4 : ffff0000f7579d58 x3 : 0000000000000000
> [  527.570617] x2 : 0000000000000000 x1 : 0000000000000100 x0 : 0000000000000080
> [  527.570627] Call trace:
> [  527.570631] kmem_cache_alloc_bulk_noprof (mm/slub.c:5343
> (discriminator 1) mm/slub.c:5403 (discriminator 1)) (P)
> [  527.570639] mas_alloc_nodes (lib/maple_tree.c:1278)
> [  527.570651] mas_node_count_gfp (lib/maple_tree.c:1339)
> [  527.570661] mas_preallocate (lib/maple_tree.c:5538 (discriminator 1))
> [  527.570667] __split_vma (mm/vma.c:528 (discriminator 1))
> [  527.570677] vma_modify (mm/vma.c:1633)
> [  527.570685] vma_modify_flags (mm/vma.c:1650)
> [  527.570694] mprotect_fixup (mm/mprotect.c:819)
> [  527.570704] do_mprotect_pkey (mm/mprotect.c:993)
> [  527.570713] __arm64_sys_mprotect (mm/mprotect.c:1011)
> [  527.570722] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> [  527.570731] el0_svc_common.constprop.0
> (include/linux/thread_info.h:135 (discriminator 2)
> arch/arm64/kernel/syscall.c:140 (discriminator 2))
> [  527.570737] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> [  527.570744] el0_svc (arch/arm64/include/asm/irqflags.h:82
> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
> arch/arm64/kernel/entry-common.c:169 (discriminator 1)
> arch/arm64/kernel/entry-common.c:182 (discriminator 1)
> arch/arm64/kernel/entry-common.c:880 (discriminator 1))
> [  527.570752] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
> [  527.570760] el0t_64_sync (arch/arm64/kernel/entry.S:596)
> [ 527.570772] Code: 1400000c f94002c5 b4000aa5 b9402a60 (f86068a0)
> All code
> ========
>    0: 1400000c b 0x30
>    4: f94002c5 ldr x5, [x22]
>    8: b4000aa5 cbz x5, 0x15c
>    c: b9402a60 ldr w0, [x19, #40]
>   10:* f86068a0 ldr x0, [x5, x0] <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0: f86068a0 ldr x0, [x5, x0]
> [  527.570778] ---[ end trace 0000000000000000 ]---
> [  527.570800] ------------[ cut here ]------------

If you're able to repro this, please could you see if the patch below
helps at all?

https://lore.kernel.org/r/20250806145611.3962-1-dev.jain@arm.com

Cheers,

Will

