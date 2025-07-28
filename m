Return-Path: <linux-kernel+bounces-748631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48078B143EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7073717B85B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9C275AFE;
	Mon, 28 Jul 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS3ukugG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB64A33
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738652; cv=none; b=htImMMiJcX5jiKq0fmvO7/g+wVzMWIKRDdE2GjRRynI80jt9axY1Qhj0YFuGtyVv3rWAyi5surl1AAKSlq3SygeUyxxJVidn/kupcZS+vA25Hl9qiVapHs+hTEVaG6Vu4sgWQzRfN0yRImiyXRzOYGmzyDK6UcgTeCiyZv6NJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738652; c=relaxed/simple;
	bh=vmK7LuAf2Esv7j9pLWUfBPHqlLS3iMrw6D4xegLhTdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjtjUJCNxUOaBV/+gqYt3ZYoorRVhN8Z1RwAgYbYVuc+P7ZIgK82Y/AcdmiYyMahvB5MmlOfpTn+E5iwLS8JJPhPGY7LZyt9qZVGUIA5iLZKp+IA7n9stIr1KvI3jbiPv2rh/VIjTsfZ/2VRTTeWrbD1DfU3CoMVcSHMiPFZ0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS3ukugG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753738648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSSUSvYO/OHvphkbSQkQlLCmeUpTcTQ6sJaW2h42KWU=;
	b=cS3ukugG1xNSEy7pUtKYUapHVCMr+ImAWUDJgENEWDNKjIKOWKNVG6wpXo7bivWcOmRFq2
	0Dj3FVrpFmxLXp094jD7oxYdBtE97yp+71w5cisJosdbGlJSxuIJTE3k14siHAvRUt7vz6
	snwAAizVf6EBGvzNX//KXO87HWb3SwQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-r01VL3qxP-u7J0UoT9f54Q-1; Mon, 28 Jul 2025 17:37:27 -0400
X-MC-Unique: r01VL3qxP-u7J0UoT9f54Q-1
X-Mimecast-MFC-AGG-ID: r01VL3qxP-u7J0UoT9f54Q_1753738646
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3d91ee461so4401145ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738645; x=1754343445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSSUSvYO/OHvphkbSQkQlLCmeUpTcTQ6sJaW2h42KWU=;
        b=t6n+JM9hrFbFznaMdgQBbf57s5rMppFbzni6GKcKA7+tAPU7u2tmwfVlY9G1SlZIOW
         i+5aagjlZAOs9VzoibOQRAXyXZremfUvAp0s9lIGCvGHOCCfGVmBsfDQMY1KZKvkX/Rs
         qe6/9bQpa0ltF/jlg0SP+4e1A3h+OXtJ/xJYdRjnIup44VL17rCupRBieiq4dcL7WRyf
         Lk2wemgTClFyOzX6Gf5RqrXp0EFwkHIRx5e15xkXdsvqypWxcPBcybSuE9qB/57G43EG
         /ZYlfL4rZrRHXT5+tomeq04dF1sr8NbS5vGPz5fEq4bH3UMrP4YNVEXwfcTA0mQ936h2
         sjkg==
X-Forwarded-Encrypted: i=1; AJvYcCWXvcUOST6yvqnVMcTeJxJpjv/QdPnPLsF+tPYWw0W5W9jj/MU1i6C3FaIwl4O2L5fYWHbpTfYkOFxQfh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SJJFYJE3kwcuRLTdsI5HEhvoq0VyES0KJg9Dh4JtSnu8Mku0
	F7p5ZI/HODj62mvzwm/+9JCFDHI7c8Je7B/oMdzQZXKyKveM8cms1d0s9nSrpezKZ9TLmoQV7tT
	IfpAhVOEmTqDlFRfcVlaIDsJ/elvvbVCWK6nR1mPgXNwltTxL11BcpqgaEBLunIBLhsFosy6GOg
	==
X-Gm-Gg: ASbGncuWP3D+uJfgHJY46gUr+Bb5lnDz8oWN+jPhVrNUrDIFfcTiLo9qI+0fwnpKP7b
	NUyg6plUyoA3Sd8qFUPM2gkYc1/rkV5mrbtm2brp/R0oiYLRqG8DaWzNpqYX9UvgVfrDkjnrGKS
	6AV64iz5jPh4+gmJMaXepiV5J8rx3g8IAa7koohONcnx5N0DuLOzMCy8zuvC6uPT5VQtkF93qy5
	TtQ7pv9PUmHHMTXsJFnuGZK/fGOYNDq9yTWTrWNd1wYZHkhy1cr+hazdsaEAHkWTZQyioEfAyd6
	pmcP8mrAvch96BxF3/SnbDk1Jbc07fy14VRIa9MQTEY=
X-Received: by 2002:a05:6e02:3704:b0:3e2:94ec:e379 with SMTP id e9e14a558f8ab-3e3c5385e09mr67989335ab.7.1753738645037;
        Mon, 28 Jul 2025 14:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErX+WEsrqeHKni/uNNPldbJZPrUamuSASB+1k/g600fZ+i2JnjVLimIUTw7/v6P5+PLxYaZg==
X-Received: by 2002:a05:6e02:3704:b0:3e2:94ec:e379 with SMTP id e9e14a558f8ab-3e3c5385e09mr67989095ab.7.1753738644528;
        Mon, 28 Jul 2025 14:37:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91edeb1sm2117893173.35.2025.07.28.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 14:37:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:37:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: lizhe.67@bytedance.com
Cc: farman@linux.ibm.com, akpm@linux-foundation.org, david@redhat.com,
 jgg@ziepe.ca, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, peterx@redhat.com
Subject: Re: [FIXUP] vfio/type1: correct logic of vfio_find_vpfn()
Message-ID: <20250728153722.4b4c1442.alex.williamson@redhat.com>
In-Reply-To: <20250725070054.66497-1-lizhe.67@bytedance.com>
References: <20250724105608.73b05a24.alex.williamson@redhat.com>
	<20250725070054.66497-1-lizhe.67@bytedance.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 15:00:54 +0800
lizhe.67@bytedance.com wrote:

> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In commit 492d1e9f0df7 ("vfio/type1: optimize vfio_pin_pages_remote()"),
> we changes vfio_find_vpfn() from exact-iova matching to the interval
> [iova, iova + PAGE_SIZE), which may cause the following problem.
> 
> [  215.671885] ------------[ cut here ]------------
> [  215.671893] WARNING: CPU: 10 PID: 6210 at drivers/vfio/vfio_iommu_type1.c:1204
> vfio_remove_dma+0xda/0xf0 [vfio_iommu_type1]
> [  215.671902] Modules linked in: vhost_vsock vmw_vsock_virtio_transport_common vsock vhost
> vhost_iotlb algif_hash af_alg kvm nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4 nft_reject act_csum
> cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables pkey_pckmo
> s390_trng pkey_ep11 pkey_cca zcrypt_cex4 zcrypt eadm_sch rng_core vfio_ccw mdev vfio_iommu_type1
> vfio drm sch_fq_codel i2c_core drm_panel_orientation_quirks dm_multipath loop nfnetlink ctcm fsm
> zfcp scsi_transport_fc mlx5_ib diag288_wdt mlx5_core ghash_s390 prng aes_s390 des_s390 libdes
> sha3_512_s390 sha3_256_s390 sha512_s390 sha1_s390 sha_common rpcrdma sunrpc rdma_ucm rdma_cm
> configfs iw_cm ib_cm ib_uverbs ib_core scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey autofs4
> [  215.671946] CPU: 10 UID: 107 PID: 6210 Comm: qemu-system-s39 Kdump: loaded Not tainted 6.16.0-
> rc7-00005-g4ff8295d8d61 #79 NONE
> [  215.671950] Hardware name: IBM 3906 M05 780 (LPAR)
> [  215.671951] Krnl PSW : 0704c00180000000 000002482f7ee55e (vfio_remove_dma+0xde/0xf0
> [vfio_iommu_type1])
> [  215.671956]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  215.671959] Krnl GPRS: 006d010100000000 000000009d8a4c40 000000008f3b1c80 0000000092ffad20
> [  215.671961]            0000000090b57880 006e010100000000 000000008f3b1c80 000000008f3b1cc8
> [  215.671963]            0000000085b3ff00 000000008f3b1cc0 000000008f3b1c80 0000000092ffad20
> [  215.671964]            000003ff867acfa8 000000008f3b1ca0 000001c8b36c3be0 000001c8b36c3ba8
> [  215.671972] Krnl Code: 000002482f7ee550: c0e53ff9fcc8	brasl	%r14,00000248af72dee0
>            000002482f7ee556: a7f4ffcf		brc	15,000002482f7ee4f4
>           #000002482f7ee55a: af000000		mc	0,0
>           >000002482f7ee55e: a7f4ffa9		brc	15,000002482f7ee4b0  
>            000002482f7ee562: 0707		bcr	0,%r7
>            000002482f7ee564: 0707		bcr	0,%r7
>            000002482f7ee566: 0707		bcr	0,%r7
>            000002482f7ee568: 0707		bcr	0,%r7
> [  215.672006] Call Trace:
> [  215.672008]  [<000002482f7ee55e>] vfio_remove_dma+0xde/0xf0 [vfio_iommu_type1]
> [  215.672013]  [<000002482f7f03de>] vfio_iommu_type1_detach_group+0x3de/0x5f0 [vfio_iommu_type1]
> [  215.672016]  [<000002482f7d4c4e>] vfio_group_detach_container+0x5e/0x180 [vfio]
> [  215.672023]  [<000002482f7d2ce0>] vfio_group_fops_release+0x50/0x90 [vfio]
> [  215.672027]  [<00000248af25e1ee>] __fput+0xee/0x2e0
> [  215.672031]  [<00000248aef19f18>] task_work_run+0x88/0xd0
> [  215.672036]  [<00000248aeef559a>] do_exit+0x18a/0x4e0
> [  215.672042]  [<00000248aeef5ab0>] do_group_exit+0x40/0xc0
> [  215.672045]  [<00000248aeef5b5e>] __s390x_sys_exit_group+0x2e/0x30
> [  215.672048]  [<00000248afc81e56>] __do_syscall+0x136/0x340
> [  215.672054]  [<00000248afc8da7e>] system_call+0x6e/0x90
> [  215.672058] Last Breaking-Event-Address:
> [  215.672059]  [<000002482f7ee4aa>] vfio_remove_dma+0x2a/0xf0 [vfio_iommu_type1]
> [  215.672062] ---[ end trace 0000000000000000 ]---
> [  219.861940] ------------[ cut here ]------------
> 
> ...
> 
> [  241.164333] ------------[ cut here ]------------
> [  241.164340] kernel BUG at drivers/vfio/vfio_iommu_type1.c:1480!
> [  241.164358] monitor event: 0040 ilc:2 [#1]SMP
> [  241.164363] Modules linked in: vhost_vsock vmw_vsock_virtio_transport_common vsock vhost
> vhost_iotlb algif_hash af_alg kvm nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4 nft_reject act_csum
> cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables pkey_pckmo
> s390_trng pkey_ep11 pkey_cca zcrypt_cex4 zcrypt eadm_sch rng_core vfio_ccw mdev vfio_iommu_type1
> vfio drm sch_fq_codel i2c_core drm_panel_orientation_quirks dm_multipath loop nfnetlink ctcm fsm
> zfcp scsi_transport_fc mlx5_ib diag288_wdt mlx5_core ghash_s390 prng aes_s390 des_s390 libdes
> sha3_512_s390 sha3_256_s390 sha512_s390 sha1_s390 sha_common rpcrdma sunrpc rdma_ucm rdma_cm
> configfs iw_cm ib_cm ib_uverbs ib_core scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey autofs4
> [  241.164399] CPU: 14 UID: 107 PID: 6581 Comm: qemu-system-s39 Kdump: loaded Tainted: G        W
> 6.16.0-rc7-00005-g4ff8295d8d61 #79 NONE
> [  241.164403] Tainted: [W]=WARN
> [  241.164404] Hardware name: IBM 3906 M05 780 (LPAR)
> [  241.164406] Krnl PSW : 0704e00180000000 000002482f7f132a (vfio_dma_do_unmap+0x4aa/0x4b0
> [vfio_iommu_type1])
> [  241.164413]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> [  241.164415] Krnl GPRS: 0000000000000000 000000000000000b 0000000040000000 000000008cfdcb40
> [  241.164418]            0000000000001001 0000000000000001 0000000000000000 0000000040000000
> [  241.164419]            0000000000000000 0000000000000000 00000001fbe7f140 000000008cfdcb40
> [  241.164421]            000003ff97dacfa8 0000000000000000 00000000871582c0 000001c8b4177cd0
> [  241.164428] Krnl Code: 000002482f7f131e: a7890000		lghi	%r8,0
>            000002482f7f1322: a7f4feeb		brc	15,000002482f7f10f8
>           #000002482f7f1326: af000000		mc	0,0
>           >000002482f7f132a: 0707		bcr	0,%r7  
>            000002482f7f132c: 0707		bcr	0,%r7
>            000002482f7f132e: 0707		bcr	0,%r7
>            000002482f7f1330: c0040000803c	brcl	0,000002482f8013a8
>            000002482f7f1336: eb6ff0480024	stmg	%r6,%r15,72(%r15)
> [  241.164458] Call Trace:
> [  241.164459]  [<000002482f7f132a>] vfio_dma_do_unmap+0x4aa/0x4b0 [vfio_iommu_type1]
> [  241.164463]  [<000002482f7f1d08>] vfio_iommu_type1_ioctl+0x1c8/0x370 [vfio_iommu_type1]
> [  241.164466]  [<00000248af27704e>] vfs_ioctl+0x2e/0x70
> [  241.164471]  [<00000248af278610>] __s390x_sys_ioctl+0xe0/0x100
> [  241.164474]  [<00000248afc81e56>] __do_syscall+0x136/0x340
> [  241.164477]  [<00000248afc8da7e>] system_call+0x6e/0x90
> [  241.164481] Last Breaking-Event-Address:
> [  241.164482]  [<000002482f7f1238>] vfio_dma_do_unmap+0x3b8/0x4b0 [vfio_iommu_type1]
> [  241.164486] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> This patch reverts vfio_find_vpfn() to exact iova matching, thereby
> resolving the issue.
> 
> Fixes: 492d1e9f0df7 ("vfio/type1: optimize vfio_pin_pages_remote()")
> Tested-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to vfio next branch for v6.17.  Thanks,

Alex

> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 6909275e46c2..827e0987fab5 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -344,7 +344,7 @@ static struct vfio_pfn *vfio_find_vpfn_range(struct vfio_dma *dma,
>  
>  static inline struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
>  {
> -	return vfio_find_vpfn_range(dma, iova, iova + PAGE_SIZE);
> +	return vfio_find_vpfn_range(dma, iova, iova + 1);
>  }
>  
>  static void vfio_link_pfn(struct vfio_dma *dma,


