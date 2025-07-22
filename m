Return-Path: <linux-kernel+bounces-741437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5ECB0E412
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DF31894C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E1283CB1;
	Tue, 22 Jul 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjMIKqoa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262727A92B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212251; cv=none; b=Tf0ZcAelGt1Qw8wBIvfMy9X2jj/qmy1aPwbBDnZ9qJwxvd9l+B4kfr2aTSmCOX8Y5i9L6LQ7Fdcnsk47GFYDtcnpqvOvPwOnviueoAL3Db9lBB5VOAbDD7Ff4d6zQSP/fWlABvu/skUz9e4bC3W7OWpEDe3bJCXXbNV4wsyYpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212251; c=relaxed/simple;
	bh=A32hbVnyJUL/EIxxvz8NZtumv2p18qbLzg216awHUCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnIpX+B4a3UsBZMPyPZSaMVjCdQKAWHXKG+sFXC9Jz3GoXbZYks+m/OTx3gWFmToGBXLFc4HqKjk+qabcMHVJvZGZSCUHpDqvE6+6K1osgsvQ8SjdoDK4CGWFHicjU74qpKrXiwFH0PD+sqq3FZbb2H1USaYE2My4XQ0TFahb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjMIKqoa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753212248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoPpnzfO/x9/yJX0rcftjTQw+19C2QQbHVAgxYrYBgE=;
	b=YjMIKqoafp5IARdIUQs4rV93lz0VDdRPTd5SZp+O2CvKOKKZ1ceA28aE/1pPZKDJrhi72i
	lXEpdvd1Etr8miVwZNCNwhoMDW1tDNZexjNq6iLSP1gs8CUYAH8GESvythFT0ZgbVDD4JD
	PPkHwnsEV6pp4xD9WPvw9QjuknHyt2E=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-LYuZXQN0M82YmTap2hWCvg-1; Tue, 22 Jul 2025 15:24:06 -0400
X-MC-Unique: LYuZXQN0M82YmTap2hWCvg-1
X-Mimecast-MFC-AGG-ID: LYuZXQN0M82YmTap2hWCvg_1753212246
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e0564038f5so10231425ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212246; x=1753817046;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoPpnzfO/x9/yJX0rcftjTQw+19C2QQbHVAgxYrYBgE=;
        b=ReTleL99VKlyqcSpwS2NovqCA8tQzLHwbh6U6rVKi10GsYosx8arEoc5brku9Wi0VD
         4ByK5Bveacl/cySajLOuEOHARQK+gytlzmq8GVN0rRaxe0PkH7e77cfZXzLpGVP8TKkk
         Sb3m4mvyWVWdHXulJKMev216uVCM58Yf0H641NbsMHJ0QYuEBBJU6H4QDtJpSKMNLqjf
         C978yL2HIWZcaA5wMfkLDDzF9CA/lEer4XV/47abVjNAl7r8YIJ8gxkXVfChAsfBlnj5
         pWOrXdeamn8+9qXQV8G0+le2HU+NgS/tkkHCFrXy3cU+RCPmh20YK9eCv/+SpOyqTeBl
         KDKA==
X-Forwarded-Encrypted: i=1; AJvYcCUo+6XqsATKzFMcOwBJQflCZbTqbBUIXdm+WeM4ddtxmCYxDk31s3rvb3PCpu9u9WFWnxOEsPJ86NsxVxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziA12DeVf96uS3eKl2uz5qBreBTtr3iSdL51ddqtlKny25+Q6N
	zroG01MXgDmjZBBUV5U09gXMWaGysenVtmaknCY9k5mkWqWTpFb+GODdObXWL05YDv3SbD0O8tm
	gHYUFic0WOZBhGNRdHFxgpmN7w7YDFxiQmotMwxnoeZVpOAxPU10inOCfTGuNqa85Cw==
X-Gm-Gg: ASbGncu6LpxB5GB+iO0s4xOiMHr1H98JLAvZgUL4fSYQpiq4II6uOgCssfxbvMbNEfW
	j+Xj6eqIDpBTu/c5TpwaC5xsAMuBHcBuF8CsGC45NWBlsVps9KG7VRYRmiMNxlA3wYQKu4P52fQ
	5/rCOz2lRhs4bq3vrMlcuL0IUfq3p4ecbZ1YewURQIG3Kf2nCp0HSmgszFmlzpsFTFHk8tSo+ht
	1dHbY0kGB6wggsZtiso85u0liWscDc8BbH4o2qjpSeBB7UpYKKheNWpOgwKWcEe6TTWjWo9C/RA
	gX0iQehvHFbRdaxB52A1Zsww1qIT/9ioKXovYXZT3+M=
X-Received: by 2002:a05:6e02:b4e:b0:3e2:b511:1257 with SMTP id e9e14a558f8ab-3e32fbe6d02mr1429555ab.1.1753212245298;
        Tue, 22 Jul 2025 12:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtVPfNQQZe8DOqCr9vtTkI2cNKOF9UOY8F0gy0NieHMIPzKntZTVJ6/MWE3j5uJcQHKrMd+Q==
X-Received: by 2002:a05:6e02:b4e:b0:3e2:b511:1257 with SMTP id e9e14a558f8ab-3e32fbe6d02mr1429355ab.1.1753212244681;
        Tue, 22 Jul 2025 12:24:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca61845sm2706151173.126.2025.07.22.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:24:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:23:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: lizhe.67@bytedance.com, akpm@linux-foundation.org, david@redhat.com,
 jgg@ziepe.ca, peterx@redhat.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Message-ID: <20250722132358.5ab61377.alex.williamson@redhat.com>
In-Reply-To: <1bd50178755535ee0a3b0b2164acf9319079a3d5.camel@linux.ibm.com>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
	<20250710085355.54208-3-lizhe.67@bytedance.com>
	<1bd50178755535ee0a3b0b2164acf9319079a3d5.camel@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 12:32:59 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On Thu, 2025-07-10 at 16:53 +0800, lizhe.67@bytedance.com wrote:
> > From: Li Zhe <lizhe.67@bytedance.com>
> > 
> > When vfio_pin_pages_remote() is called with a range of addresses that
> > includes large folios, the function currently performs individual
> > statistics counting operations for each page. This can lead to significant
> > performance overheads, especially when dealing with large ranges of pages.
> > Batch processing of statistical counting operations can effectively enhance
> > performance.
> > 
> > In addition, the pages obtained through longterm GUP are neither invalid
> > nor reserved. Therefore, we can reduce the overhead associated with some
> > calls to function is_invalid_reserved_pfn().
> > 
> > The performance test results for completing the 16G VFIO IOMMU DMA mapping
> > are as follows.
> > 
> > Base(v6.16-rc4):
> > ------- AVERAGE (MADV_HUGEPAGE) --------
> > VFIO MAP DMA in 0.047 s (340.2 GB/s)
> > ------- AVERAGE (MAP_POPULATE) --------
> > VFIO MAP DMA in 0.280 s (57.2 GB/s)
> > ------- AVERAGE (HUGETLBFS) --------
> > VFIO MAP DMA in 0.052 s (310.5 GB/s)
> > 
> > With this patch:
> > ------- AVERAGE (MADV_HUGEPAGE) --------
> > VFIO MAP DMA in 0.027 s (602.1 GB/s)
> > ------- AVERAGE (MAP_POPULATE) --------
> > VFIO MAP DMA in 0.257 s (62.4 GB/s)
> > ------- AVERAGE (HUGETLBFS) --------
> > VFIO MAP DMA in 0.031 s (517.4 GB/s)
> > 
> > For large folio, we achieve an over 40% performance improvement.
> > For small folios, the performance test results indicate a
> > slight improvement.
> > 
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 83 ++++++++++++++++++++++++++++-----
> >  1 file changed, 71 insertions(+), 12 deletions(-)  
> 
> Hi,
> 
> Our CI started flagging some crashes running vfio-ccw regressions on the -next kernel beginning with
> next-20250717, and bisect points to this particular commit.
> 
> I can reproduce by cherry-picking this series onto 6.16-rc7, so it's not something else lurking.
> Without panic_on_warn, I get a handful of warnings from vfio_remove_dma() (after starting/stopping
> guests with an mdev attached), before eventually triggering a BUG() in vfio_dma_do_unmap() running a
> hotplug test. I've attached an example of a WARNING before the eventual BUG below. I can help debug
> this if more doc is needed, but admit I haven't looked at this patch in any detail yet.

Thanks for the report.  I'm out of the office this week, but I'll keep
an eye on how this progresses and we can drop it if we haven't come to
a resolution in the next few days.  Thanks,

Alex


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
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 1136d7ac6b59..6909275e46c2 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -318,7 +318,13 @@ static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
> >  /*
> >   * Helper Functions for host iova-pfn list
> >   */
> > -static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> > +
> > +/*
> > + * Find the highest vfio_pfn that overlapping the range
> > + * [iova_start, iova_end) in rb tree.
> > + */
> > +static struct vfio_pfn *vfio_find_vpfn_range(struct vfio_dma *dma,
> > +		dma_addr_t iova_start, dma_addr_t iova_end)
> >  {
> >  	struct vfio_pfn *vpfn;
> >  	struct rb_node *node = dma->pfn_list.rb_node;
> > @@ -326,9 +332,9 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> >  	while (node) {
> >  		vpfn = rb_entry(node, struct vfio_pfn, node);
> >  
> > -		if (iova < vpfn->iova)
> > +		if (iova_end <= vpfn->iova)
> >  			node = node->rb_left;
> > -		else if (iova > vpfn->iova)
> > +		else if (iova_start > vpfn->iova)
> >  			node = node->rb_right;
> >  		else
> >  			return vpfn;
> > @@ -336,6 +342,11 @@ static struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> >  	return NULL;
> >  }
> >  
> > +static inline struct vfio_pfn *vfio_find_vpfn(struct vfio_dma *dma, dma_addr_t iova)
> > +{
> > +	return vfio_find_vpfn_range(dma, iova, iova + PAGE_SIZE);
> > +}
> > +
> >  static void vfio_link_pfn(struct vfio_dma *dma,
> >  			  struct vfio_pfn *new)
> >  {
> > @@ -614,6 +625,39 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> >  	return ret;
> >  }
> >  
> > +
> > +static long vpfn_pages(struct vfio_dma *dma,
> > +		dma_addr_t iova_start, long nr_pages)
> > +{
> > +	dma_addr_t iova_end = iova_start + (nr_pages << PAGE_SHIFT);
> > +	struct vfio_pfn *top = vfio_find_vpfn_range(dma, iova_start, iova_end);
> > +	long ret = 1;
> > +	struct vfio_pfn *vpfn;
> > +	struct rb_node *prev;
> > +	struct rb_node *next;
> > +
> > +	if (likely(!top))
> > +		return 0;
> > +
> > +	prev = next = &top->node;
> > +
> > +	while ((prev = rb_prev(prev))) {
> > +		vpfn = rb_entry(prev, struct vfio_pfn, node);
> > +		if (vpfn->iova < iova_start)
> > +			break;
> > +		ret++;
> > +	}
> > +
> > +	while ((next = rb_next(next))) {
> > +		vpfn = rb_entry(next, struct vfio_pfn, node);
> > +		if (vpfn->iova >= iova_end)
> > +			break;
> > +		ret++;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /*
> >   * Attempt to pin pages.  We really don't want to track all the pfns and
> >   * the iommu can only map chunks of consecutive pfns anyway, so get the
> > @@ -680,32 +724,47 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> >  		 * and rsvd here, and therefore continues to use the batch.
> >  		 */
> >  		while (true) {
> > +			long nr_pages, acct_pages = 0;
> > +
> >  			if (pfn != *pfn_base + pinned ||
> >  			    rsvd != is_invalid_reserved_pfn(pfn))
> >  				goto out;
> >  
> > +			/*
> > +			 * Using GUP with the FOLL_LONGTERM in
> > +			 * vaddr_get_pfns() will not return invalid
> > +			 * or reserved pages.
> > +			 */
> > +			nr_pages = num_pages_contiguous(
> > +					&batch->pages[batch->offset],
> > +					batch->size);
> > +			if (!rsvd) {
> > +				acct_pages = nr_pages;
> > +				acct_pages -= vpfn_pages(dma, iova, nr_pages);
> > +			}
> > +
> >  			/*
> >  			 * Reserved pages aren't counted against the user,
> >  			 * externally pinned pages are already counted against
> >  			 * the user.
> >  			 */
> > -			if (!rsvd && !vfio_find_vpfn(dma, iova)) {
> > +			if (acct_pages) {
> >  				if (!dma->lock_cap &&
> > -				    mm->locked_vm + lock_acct + 1 > limit) {
> > +				     mm->locked_vm + lock_acct + acct_pages > limit) {
> >  					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
> >  						__func__, limit << PAGE_SHIFT);
> >  					ret = -ENOMEM;
> >  					goto unpin_out;
> >  				}
> > -				lock_acct++;
> > +				lock_acct += acct_pages;
> >  			}
> >  
> > -			pinned++;
> > -			npage--;
> > -			vaddr += PAGE_SIZE;
> > -			iova += PAGE_SIZE;
> > -			batch->offset++;
> > -			batch->size--;
> > +			pinned += nr_pages;
> > +			npage -= nr_pages;
> > +			vaddr += PAGE_SIZE * nr_pages;
> > +			iova += PAGE_SIZE * nr_pages;
> > +			batch->offset += nr_pages;
> > +			batch->size -= nr_pages;
> >  
> >  			if (!batch->size)
> >  				break;  
> 


