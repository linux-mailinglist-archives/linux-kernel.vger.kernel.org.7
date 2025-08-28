Return-Path: <linux-kernel+bounces-789561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980FB39761
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2F7189AA86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8682BE642;
	Thu, 28 Aug 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bYWfbzto"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010007.outbound.protection.outlook.com [52.101.229.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545281C01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370736; cv=fail; b=B6UkX/OzjqTMxwsFmnWzyYFi/MhWKvgp1CsvVR7oElq2D5/SBs4mkrt1gC05F4/vJo6T8E10mYv76ba0sqyIEzqpEwuLVVGSN0Ia4BgUGHO1Qm8BdvE7NQkKhYZvAKMAB1cNpbgfue7Drm59HTuMC969x5djSK71eU84vO56eNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370736; c=relaxed/simple;
	bh=5aLRV+wgwAWpuZ2cvxlWUG8caJyzpPN9XzhEq0Q2yWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AifIDRw5B0QNd3S8za9oeO5yio2yxvmC+ynPYCn1X59fFwkqcMjmVgNzAhGDlOYC1JgoodgzTQ33LjUa9U4UbshdgwDdWIzyuRw8SSkzRM3NNDXGtmY2k8v86c6hNDjhLbxHSuGE+5JyEdZhtKqymooriqnHgDVr48/CXzP5o8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bYWfbzto; arc=fail smtp.client-ip=52.101.229.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY19IKiq/TS+gm4xyKZQoMww0cdbb/sxW0aXqd7aJIHI2JFzvRuvoqbA+rOryLzKvNrkn0jY2YPpubSlTsfeShs9kYhcs32ydl+ZynUtl5IJgtxhsV2JC4xHP7HYrcIEcPR6tchAfwd+qbjcM/p8eh+nGZi6Ug5ltDWwYrePDqCyDsNH8C9CjgqEKVdTXQHln1z/qsdXsW6L8IsQBXz8TCC2c4QIaLayVtOY52TwAwa8Sv00SsxnrVf5BuvJDmY35gB+9Nw0sT0qCJDlFhfsF/uoH0jKoJioUuYHJ0TMC+lxqg4eMu1mqwry6t2oAYV9zJl1JWrCBy/a74/ITuTStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=411DjGnlOoCasSlo5p1YCXGIsl+51VxnzAEP+HB7vPs=;
 b=k+7gMkTqUPth3fIMJO26cfc/WYyEAZJdb5+9YJYKp8ap/SHqglcdEMwWk0qskCOSFcFcgv/RQng22h47mHIgMXhnvTJT1CmhEGLfvOs3Af+XNJx/ofAXs7w+4NlRhjoTd6sEXlq8YsrIndj6bGK11K4ujMI46GAVevY51hquO05CnFIvRoGFhoQX7ttpz2GDQLLZurUHYlr7wTY8Bqew99GqBaDdHpNGa74KqPVsZPwi9u2TUUGcNqGln5q8G6giSrC9M0p3YNbpD/Bdkzc9Ev5/TyCpC5+TE8DvC+sf4sSVadppqV4YMOUYpSxMTV18HkXcFwABKAYVvu1An2TOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=411DjGnlOoCasSlo5p1YCXGIsl+51VxnzAEP+HB7vPs=;
 b=bYWfbztoiuwkyA1RHOy9NXJ6aQgxAhq19UsFDPZxeHMt7sGkF12nxU9wTYvpc2rKzI8V9VOjnuIt/W0IfrKNZ7gnQpOFzw55LeHEekaxoZvm4POV7YqT8i8N0A7QbGzGBIB3qK0isd6FLrTrYdMKCwQ585hjod0QBdcxhN5mrqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:fe::6) by
 TY3P286MB3582.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Thu, 28 Aug 2025 08:45:30 +0000
Received: from OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb9b:13f3:8329:52e3]) by OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb9b:13f3:8329:52e3%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:45:28 +0000
Date: Thu, 28 Aug 2025 17:45:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix invalid wait context lockdep
 report
Message-ID: <s2soy7omtrouwk6hdrpcmid526cy7gsh6eopvt52hd77lqi5jd@yovvnge7grt6>
References: <20250827073848.1410315-1-den@valinux.co.jp>
 <86h5xtdj6m.wl-maz@kernel.org>
 <pkfekcmetqyoj7rwvr77kisu7ok7bc6srq5maoydisnsk4bnyy@wimnw744lp5t>
 <86cy8fev72.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cy8fev72.wl-maz@kernel.org>
X-ClientProxiedBy: TYCP286CA0153.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::15) To OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:fe::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB0982:EE_|TY3P286MB3582:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cd4f38-b46c-4679-7295-08dde60f39d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCOBPFTR8yzxpGpQlB4auHiczUuiPrD2jRGJRorPLiBRaE/Rn3TVRF8VR5zL?=
 =?us-ascii?Q?gK2tBf6OTKR5eY+DNqOQbx4D8zfnHxVM/cDX8gRiGND68Fi/+6kUIJHU6stN?=
 =?us-ascii?Q?9TWd5y+gayKZ0wbtqqkoI+c4adO5T3ObbFiUwB4hSjmza2j2NTlDXEnbuagd?=
 =?us-ascii?Q?6Lw72x7KR18Tw+0kTBJ1xvdEuFqHNFaQXIPtOAJyq0lXXgC1o8fG4Ye7fnzN?=
 =?us-ascii?Q?0kFlt9CPTlysD9Wy1MiLc8L79oah1IBBui37NHROxygm5qWJo3oN35KlGOD9?=
 =?us-ascii?Q?8h0nPwoA2c/z+hp8F/3WSZxR1DkVjUz8Af/YvG/+Yh7Min5RXDfYwgC4XZzI?=
 =?us-ascii?Q?iZYyzA5ghxRhXKZFFmHuN1H2tFCT6sVlW7plg9wP3bZgSHGOM3BYxraZOfmr?=
 =?us-ascii?Q?qk4kHd+ZyFbFcoAV67gVxhLKFkPyIS2lltgV2Dd93AaLTLIQYjoRL53P5yRo?=
 =?us-ascii?Q?i1t5MXcNbTr8AybK9w+ETUpPBUdTstNSBQR7mkEHP1zZ4MADjJDJDpeeUJAe?=
 =?us-ascii?Q?EsTxwlcmtCrlS10zWpzWgBkfcYmkb9ALGS9y9uBEckC4uKIe1l+VfJN0s73T?=
 =?us-ascii?Q?Us+NGda7SwKQrVHD8iFlgaMPGuq2JzipufqJUHCQH/KombNwdU1P3yPOuuoC?=
 =?us-ascii?Q?9D6KRcbgPQ3+6KJ89AN2xmsHj6yWv26yFtWpAQNhvIVMOJ7SyQesL/1MI5Jt?=
 =?us-ascii?Q?hphSWtwpLG6OyjSCVQJUngpYxHhWDgKKh891f7viA0NlP9IiWlULnQXXuntD?=
 =?us-ascii?Q?mMoXsMwwkBd0lKTqWHJeAt+wTKRZhFK1WpZ1hheVLMlG6TYJhdMI4zlPd2OQ?=
 =?us-ascii?Q?unHkAMlN5LwB0Qgo51baY6Av0trzEhbIQTcpfs8ZWMxqfmJS5+STLfMLkaa0?=
 =?us-ascii?Q?vvTwB442p3qopSMtGJVfKPJZv6qrKV8Kc9Xs42aSw+0yaCVDWBjIZez/fy3t?=
 =?us-ascii?Q?Vthv3Zpa+OTLAqI9/JIgXVeGDJSvqr05t2FnWAfQAjB22He8WEPhub/PSeYc?=
 =?us-ascii?Q?P1y3oprp6CZhNeL1IGd9TXhU32ZwZbplhp4WSK5uyn4ADcqkgbDkn3QmvTqq?=
 =?us-ascii?Q?rFpsiNYY38ZdzraSHGX1gQJBaBnoZ+1XkFJpn/UUoBoznB1Nt1qawRTupyz4?=
 =?us-ascii?Q?sYckzA2+qFPpMpZdurVB8b158FhjfR+z2W3N36D2Y3YWdloshIqWe4qgaiD7?=
 =?us-ascii?Q?ctBfpouM2S9s7wcDTYc5du0wGIv/IEkDAPYDT5M7L49bp5pHa5f6Ipj+Zz0x?=
 =?us-ascii?Q?bM1lN2P+ZPiIquTKvfE6xwkZwx8HcJO24yG5sK+ZLfur4+9E0nxdzbmx4W/9?=
 =?us-ascii?Q?wvzcO/1PWbmBU+yV5F+9uF9K+CxR+f/VgDTNBGVFDSUtBLd9QHBrpgR5fGpD?=
 =?us-ascii?Q?qZdDYqZh+TbrHUzwoICB7l56AwqXC9mI7t8nCim9vYPPeYkC9JO9zVE2rcS1?=
 =?us-ascii?Q?iMJPWRoAxv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mdpFIdd8pINFBrmyVuVPucCPPvURMNZBnfHGmvOIAPZNjLLzbvQ6DffIgw0?=
 =?us-ascii?Q?VGvaAJ+5mvJ1Q98f2C7GX04YLafNHzQzJ+clrN8VN7qvUShulPgBWa7rSIpu?=
 =?us-ascii?Q?dUrRemee2523U1J5cG4Bu4KgpkLDbhQVAB9InCoBdGo/HAiJMH3jiZwU4ih2?=
 =?us-ascii?Q?IiNjvmnMLqrLDcXvCWAm2FZwk1iKzgMFcM3VpC8X08ttiNHeUkwZWR939rtH?=
 =?us-ascii?Q?nxTu6sXqHnldS+s3jKDzWsDGABoVjmF+IlhuqI68Lsw3a7If4KzMaD5SClbi?=
 =?us-ascii?Q?FcsOHenKfdrwfm2XNDIRm1s2owPOKgtxTTuheuTIdLR5luLB4GU8PapvyLjr?=
 =?us-ascii?Q?PFoK7krvMEK5ysIrQdlbQaVBPAPTI6bVQemT7NvFUIaHmG8yFfl443S2tyfK?=
 =?us-ascii?Q?R4qqBy+/b9bGQYGZpB6XhGmgiQzEFwS1hoa8emJ5yly2/3KemU+5pnTPv1tD?=
 =?us-ascii?Q?x68EyDGR21YzlwH8UjkQ0nBEc10FVvThQzAuaMPGUG08rcGmN67NeeRqA9ua?=
 =?us-ascii?Q?lT6mMMG95gzBshnJsaAp4PZLBeYdq9FnwTDwqyRKX3JQ2JssfYA70tQrom/Q?=
 =?us-ascii?Q?PbiHK/KiK1EL7rEAQYadiN58Ao2p97xN0EZfgXIaMQbCpeUushBCxznuUEhX?=
 =?us-ascii?Q?K2Z09XE+SKUiV9xRwh7GRFk+qNeMXo8Ui3rGBp4InvLjRKh3d3GFES9HTY2X?=
 =?us-ascii?Q?PnmttWo9qvoeSZku/BdNtOWtZL8MYn5PhcYvaeRVa+hqiuxhh+SXRIsBcltS?=
 =?us-ascii?Q?8YJ2GowQNJYyTDhmZfXJ+wEN84RsWRqr9dYATUm5DaWo0rryxKgom4Mf35od?=
 =?us-ascii?Q?7z9uD8oMDvpQs8q4EAcVRmBRMLK21Afs2OUOc7kjqXBW3Mo9OPb3kzNYKTgs?=
 =?us-ascii?Q?qhh9Flrvo3bqJcGKOPHLW9tIkSq7ovUZBYwUTTeog4fRy2LEWcHt073Serzf?=
 =?us-ascii?Q?uGhs0rDra70EIanVVGQNgHuozZ+kzKZly/vS0PoSMBmfIaauoRBSBmor0egu?=
 =?us-ascii?Q?LPQf4CYyiqP7k+Em0v5aDhusw0H3DeaIGWv5EtLjhU60eaI7kmU2yrhjSvCq?=
 =?us-ascii?Q?bIzhUV22l9hk+bMqXQ+df5t5tZqDxvJTaImhuUpQQD7LsFOQ1z4I9No1H7bk?=
 =?us-ascii?Q?AyIUtwNYudZLt7tfOAiqOLdzdd0ReIwhVmCykwhHwVMC2SPJi839iOpTL5du?=
 =?us-ascii?Q?ant0CFwnZ1gBEdRgHGzK5rQ+USYUPPN3qe+Qz8uv60Ita9GmFH+TgwIaBOmA?=
 =?us-ascii?Q?2vaBVSVl+dw9Iii1tg4lBnI5efxroV8C7WGuqJJH476LFdBy9mRjWFS0ULY+?=
 =?us-ascii?Q?vLitnCgyCabrsxS6tbdQ4ppxwP5C3E6dp9JXEtdpcUuaGFpIn6TQpeh+H4Kh?=
 =?us-ascii?Q?1JonPb2lNjmJaKvUTLhwb/nLxuuIVAweVnvycpk+FvoA36rCF+JS1SwZtNzD?=
 =?us-ascii?Q?7D9OdsN/nMH7gehyJej0CBI3CHO8MQpoQnI8Z9bnB/ZgbS+C/fpBCe+44CoN?=
 =?us-ascii?Q?u+jgUHNwF7AJ2fDLQEafbVb+EmdGBbKLrYntRv9s4eGdZr+cp+pb6G9LBHG0?=
 =?us-ascii?Q?zzz+2Bo5I3ysi+Pty/p2fDca53HqrsdO2UJZ5ukpeEx/YL5tKw+El80wIiEo?=
 =?us-ascii?Q?B6N1ScYVa3tuAuZRmQHRZis=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cd4f38-b46c-4679-7295-08dde60f39d4
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:45:28.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lbPlfb3dcrKXz7vCXHp6FiePZGfca+SDW8wOyHD/UIceNDgxb9CMKpOUHdF8loF0kf0wnt7tv6ulUPlSd1n1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3582

On Thu, Aug 28, 2025 at 08:56:01AM +0100, Marc Zyngier wrote:
> On Thu, 28 Aug 2025 04:09:00 +0100,
> Koichiro Den <den@valinux.co.jp> wrote:
> > 
> > On Wed, Aug 27, 2025 at 01:48:33PM +0100, Marc Zyngier wrote:
> > > On Wed, 27 Aug 2025 08:38:48 +0100,
> > > Koichiro Den <den@valinux.co.jp> wrote:
> > > > 
> > > > its_irq_set_vcpu_affinity() always runs under a raw_spin_lock wait
> > > > context, so calling kcalloc there is not permitted and RT-unsafe since
> > > > ___slab_alloc() may acquire a local lock. The below is the actual
> > > > lockdep report observed:
> > > > 
> > > >   =============================
> > > >   [ BUG: Invalid wait context ]
> > > >   6.16.0-rc3-irqchip-next-7e28bba92c5c+ #1 Tainted: G S
> > > >   -----------------------------
> > > >   qemu-system-aar/2129 is trying to lock:
> > > >   ffff0085b74f2178 (batched_entropy_u32.lock){..-.}-{3:3}, at: get_random_u32+0x9c/0x708
> > > >   other info that might help us debug this:
> > > >   context-{5:5}
> > > >   6 locks held by qemu-system-aar/2129:
> > > >    #0: ffff0000b84a0738 (&vdev->igate){+.+.}-{4:4}, at: vfio_pci_core_ioctl+0x40c/0x748 [vfio_pci_core]
> > > >    #1: ffff8000883cef68 (lock#6){+.+.}-{4:4}, at: irq_bypass_register_producer+0x64/0x2f0
> > > >    #2: ffff0000ac0df960 (&its->its_lock){+.+.}-{4:4}, at: kvm_vgic_v4_set_forwarding+0x224/0x6f0
> > > >    #3: ffff000086dc4718 (&irq->irq_lock#3){....}-{2:2}, at: kvm_vgic_v4_set_forwarding+0x288/0x6f0
> > > >    #4: ffff0001356200c8 (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xc8/0x158
> > > >    #5: ffff00009eae4850 (&dev->event_map.vlpi_lock){....}-{2:2}, at: its_irq_set_vcpu_affinity+0x8c/0x528
> > > >   ...
> > > >   Call trace:
> > > >    show_stack+0x30/0x98 (C)
> > > >    dump_stack_lvl+0x9c/0xd0
> > > >    dump_stack+0x1c/0x34
> > > >    __lock_acquire+0x814/0xb40
> > > >    lock_acquire.part.0+0x16c/0x2a8
> > > >    lock_acquire+0x8c/0x178
> > > >    get_random_u32+0xd4/0x708
> > > >    __get_random_u32_below+0x20/0x80
> > > >    shuffle_freelist+0x5c/0x1b0
> > > >    allocate_slab+0x15c/0x348
> > > >    new_slab+0x48/0x80
> > > >    ___slab_alloc+0x590/0x8b8
> > > >    __slab_alloc.isra.0+0x3c/0x80
> > > >    __kmalloc_noprof+0x174/0x520
> > > >    its_vlpi_map+0x834/0xce0
> > > >    its_irq_set_vcpu_affinity+0x21c/0x528
> > > >    irq_set_vcpu_affinity+0x160/0x1b0
> > > >    its_map_vlpi+0x90/0x100
> > > >    kvm_vgic_v4_set_forwarding+0x3c4/0x6f0
> > > >    kvm_arch_irq_bypass_add_producer+0xac/0x108
> > > >    __connect+0x138/0x1b0
> > > >    irq_bypass_register_producer+0x16c/0x2f0
> > > >    vfio_msi_set_vector_signal+0x2c0/0x5a8 [vfio_pci_core]
> > > >    vfio_msi_set_block+0x8c/0x120 [vfio_pci_core]
> > > >    vfio_pci_set_msi_trigger+0x120/0x3d8 [vfio_pci_core]
> > > 
> > > Huh. I guess this is due to RT not being completely compatible with
> > > GFP_ATOMIC...  Why you'd want RT and KVM at the same time is beyond
> > > me, but hey.
> > 
> > For the record, I didn't run KVM on RT, though I still believe it's better
> > to conform to the wait context rule and avoid triggering the lockdep
> > splat.
> 
> Then I don't understand how you get this, because I have not seen it
> so far.
> 
> > 
> > I don't know if there are any plans which make kmalloc with GFP_ATOMIC
> > workable under a stricter wait context (getting rid of the local lock
> > in some way?), but I think it would be nicer.
> 
> GFP_ATOMIC is documented as being compatible with raw spinlocks in the
> absence of RT, making the above trace pretty odd.

I got the report on my ARM64 env with CONFIG_PROVE_LOCKING=y, which
leads to CONFIG_PROVE_RAW_LOCK_NESTING=y on ARM64. And this report says
that it was trying to acquire a local_lock_t (LD_WAIT_CONFIG) while any
raw_spinlock_t (LD_WAIT_SPIN) being held.
So I still believe we're on the same page; while I got the report on
non-RT, the report just pre-warns the danger for RT. There's no
immediate harm on non-RT.

> 
> > 
> > > 
> > > >   ...
> > > > 
> > > > To avoid this, simply pre-allocate vlpi_maps when creating an ITS v4
> > > > device with LPIs allcation. The trade-off is some wasted memory
> > > > depending on nr_lpis, if none of those LPIs are never upgraded to VLPIs.
> > > >
> > > > An alternative would be to move the vlpi_maps allocation out of
> > > > its_map_vlpi() and introduce a two-stage prepare/commit flow, allowing a
> > > > caller (KVM in the lockdep splat shown above) to do the allocation
> > > > outside irq_set_vcpu_affinity(). However, this would unnecessarily add
> > > > complexity.
> > > 
> > > That's debatable. It is probably fine for now, but if this was to
> > > grow, we'd need to revisit this.
> > 
> > Just curious but do you have any plans to replace the current
> > irq_set_vcpu_affinity() approach with something else?
> 
> Who knows. This is the Linux kernel, everything changes all the time
> without the need for a good reason. More significantly, the amount of
> *data* being associated with a VLPI could become much higher in the
> future, and add more unnecessary allocation.

Alright, thank you.

-Koichiro

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

