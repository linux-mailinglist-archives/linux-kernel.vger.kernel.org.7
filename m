Return-Path: <linux-kernel+bounces-787832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB9B37BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7561BA208E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204B31815D;
	Wed, 27 Aug 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pE6Z06yV"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2497205E2F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280338; cv=fail; b=Bn6/s1wG/YpMFGu+Y+7BjkiVRk+YMAbxT9MDiV8ORLqdhrE6dGf6uOznNruAbejT2v9P4GRpppiGW7e6dzsfnFLSLc2bBTPOp8jbWPcS9IaFyhslLf5u+hjXZVjFSAuSZYbOKLtxJqBKTr4vSPE8H7IB5yTg2sRzBzK/hneEDtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280338; c=relaxed/simple;
	bh=B9lTxIGQ9UdCXqppNI3c4anqNeISMMIJOh4JIYhqdu4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VvDKH/XV36a8sOQxIBySoiyNPt4UbR8Z7TF0t/hAzcjEGmJCdct84uFcMUPb6qXREkGCiB2WIRlNRoz/P+j6WkCdbWr7xP+D0BdvMzUDDJG2K1xOEKoc9mp0IfkaOYTSIpon/TvN9L7GcjPhDsfux+oo+dOCXsF8lJ+8FDAqeIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pE6Z06yV; arc=fail smtp.client-ip=52.101.125.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTAM9sSFc1oNeC/6tB4w/36u7jrZa8J+RNsQIqQKkbsVPenqDc21S6PnijUKkuWAOIe0IEWlIPAd5jzYFrUwssc+TW8cFRypMwA8vD70XFYoTHKqzrgPaGJiYIbIJp4IHL3wrjEX7ymcEztxwWDvtTs03jj9OYwwI7NsRqX55q20xgGo4IJutKPa0I4s/F5vgRiOslJs7O0ygO0Sle7NLr9OL/yhpwY4l+LCtUUUvW8ms6mDSp6joMNKrqud2/agG5RM183fCCQbMgsAsZNemSFDXL9BMOaORZcbvGwKiELzEvjUK2t9tJp0CwC+PsAOl/HWJTtN1tnm/JPFXg/DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPrQAyHzb8qJW7CfbazZ72WiTQUb3Qt0lgmSA2Q/IRQ=;
 b=cqf2rO672Cg8JhhRqEGioiPNP5HVgO4r48oyrvAgfIXci1heahKGEkCXLIqLaKXOFptmjnPv9vGcI8DYAoknx902KUhMPtOEKTrcq0t+2Vn833Qj9CzeeQT1KKzwX3X4jl3DSbzIywXrGlcwIbMbFKzW58QthbjIOgAIbdzYWdhINPk/9epcUaknqEMFnn9r1ZVIGa7Kr/033lVhDxx2ipn8AGQ/iygHgvf73ZBdd1SSDsWSMOlLNCnE/uM2H60zPsOqiJCBDpxXTYQULewbsCGgx9o61a9Md6Ll9QUJYQjM0KWSW6poFiO2zwQ0Qhyoj63Yg3bSQYJqvvU/g/oZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPrQAyHzb8qJW7CfbazZ72WiTQUb3Qt0lgmSA2Q/IRQ=;
 b=pE6Z06yVV5afKaO/s4IdafcfouLRgaBQQGlbTV709QjQDon1puudYGJdxQHZ7aa3fT5SfvASn2BMXJ1PMmMI6ouQWVmiwCoKx2PjbODI/lzH9b1D6KLCKuwQO6164zc6/j25ZykXCFUZEOzfBIfiJ388Qs0zoGvLUtMkD5FJS60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:fe::6) by
 TY7P286MB7010.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Wed, 27 Aug 2025 07:38:53 +0000
Received: from OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb9b:13f3:8329:52e3]) by OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb9b:13f3:8329:52e3%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 07:38:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3-its: Fix invalid wait context lockdep report
Date: Wed, 27 Aug 2025 16:38:48 +0900
Message-ID: <20250827073848.1410315-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::15) To OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:fe::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB0982:EE_|TY7P286MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: a43a116f-93b1-4352-cf2f-08dde53cc575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R8SlnroUIVoQ04XTbP6U8GWQ8y9B5lhXhIoYvBxRO8teYGzYKdmo7E1Gp9sc?=
 =?us-ascii?Q?kt2ymNKX8OTgDdR1gU888eSdAT7fSRUM2OT9vsvw+KAfFRky2P1GExiw+Z5T?=
 =?us-ascii?Q?Yk9h5FjUxS4fwN4A93odhMVz4V1RZWTtfD5GnXRNa42QYZ5Yvjys+19f7GsZ?=
 =?us-ascii?Q?LNcNq/TmRV6Exi/OaZylDEXAO7RQSWHRUcLZSRvMYnHoR62h4DWJVhs++yJS?=
 =?us-ascii?Q?5Pn+4Za93xsEVf1ANr7XrwhFa+bqKMBGK7HtVW8ni0uA7xTpWh4598AdTaVy?=
 =?us-ascii?Q?w7513RY7e2izhhgG+UXb4nTfE7vQwJ0v0f3yj5q50sw5UwMOTP02izBaAxTI?=
 =?us-ascii?Q?hrSsxR1ll3QviRQJzCeC4WEr+PevkHZi59MdB+a+/D1foM0PL/8HqixEby77?=
 =?us-ascii?Q?wWPUlXC7rfV8q1P2RcUcCjlf+OjvB7lvZnDucuNMxYQfRkh30pqOiMjeyegM?=
 =?us-ascii?Q?8RTKUNFJgXIN6HLdeXsSCvYvFC/8GmaC+cAavicURX+9jYyv5xHREsWlgZKN?=
 =?us-ascii?Q?cpZT/kLBp4cFOgrxHSadYG9Qw5ZWgwejbQlEjVI7t7dwTYtretMWqx6h2KWN?=
 =?us-ascii?Q?nHMmrryZWOjIqhfZ046EninNXF1qTQ2+top+lR7ehglEushSNnh/L63QOAPJ?=
 =?us-ascii?Q?j65WQu/SQQ+XoFUWenAK/lTtfAQmF1wtZt+mRKswXW2gCl0SHCHS2Wsa0Fd/?=
 =?us-ascii?Q?c3Wx2p3B72SM0obZDnxAPkHC9m6iBen9W3+0AQrv8Rzk7GXA5BcxLm0BZAYh?=
 =?us-ascii?Q?9DyDjDRepu1v7qkgzjVxtL+k8h1LQPDhJ2h1vNO4lANckBvNtHz5mXq8FisL?=
 =?us-ascii?Q?f5oS/lzQwvhJGM1YGXnzSZgnTS5qPlL9WWVhBjtwCyXpCVkeXZ931GZgF8Km?=
 =?us-ascii?Q?wQCFM6WvaiKILlrCjzmwGtoqkpeo74ZRnQo2t1X2CraE25RILOrtzILup0eK?=
 =?us-ascii?Q?U7b3oYMAz10CqWxJiOd1G8qKe3xfAQI0JzHep66L1hzHOwe1VqNBPDgVZat/?=
 =?us-ascii?Q?HeLE7m9ycSh+Fq2wtaDpn8PpFJ/X6OJeGbBFBzY/LHtEfvJJai3T8WieIadh?=
 =?us-ascii?Q?D7BCvO3nAlHqxBh2ALeib/9g5HZFHxnRy+zrnBRP9/wTOCYS0E4Sbz8mksGE?=
 =?us-ascii?Q?kqptoU3GP9jxpe7Cp2UHly5AnWuOG2X2SyakbAVYL1JAOGr35eA2zRgyM5Pd?=
 =?us-ascii?Q?NGlifUrSUxmKRCuJKBBkIsQTzZIFfggTacEYBo+8HtLXiAx55eWa9R5N9NxV?=
 =?us-ascii?Q?Cszig0l6+/UBmG723YoC6+CJP0A4bipMgv5Zp336IYREqNr4vwYSxsXpFfdi?=
 =?us-ascii?Q?erIlkDyuP8MKJm0Zv+OzC63uTAG3ZqNfF8LIAnMTU1NRk/51gWqbYlf4E0/i?=
 =?us-ascii?Q?AQokPtgx3GxLx2VDvAc8yDxyu6d5TvoBNkX67Gr7qtDNz0qBLN65sjAKtz7v?=
 =?us-ascii?Q?5K7ivb3HT5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23fQMke7ushdEchpbQ1udU6Q83r2N5lIDCkgzikofaCSB0/W+8cKrWtKgyVs?=
 =?us-ascii?Q?B365amksKeXcWEyaigwcBGJPVULSoFfpCiSx+4Vmtk9Ts6I5B4jEZRs/82Et?=
 =?us-ascii?Q?aAhRTkv3QNs4KCvorQkvDdDC6yR5h08ZDbNrZEpx7WaXog3+MbJsglGqLzNV?=
 =?us-ascii?Q?YCaLjmBtRPq4fywA9OqWURs9khNLU/JKLjh5qv6PLjbyLvz0mkYCLZOytc4j?=
 =?us-ascii?Q?YMkuARdUb50IXRe2QuZMKklDLi3B53iqY3N7CI222YtZf9s5UcA04mbXajbV?=
 =?us-ascii?Q?meL24VaCvOiJfg956zgaaTC7jkxo1NsAlbPgG5EAsblAPsj1iZ/qmjXXgP40?=
 =?us-ascii?Q?/tjQWdE/oiB82pXDK+HhmKVq178LREfN3W7pjJKSaUH6eey351DLOKiCs6qC?=
 =?us-ascii?Q?TbjTmfgD2ga2j8EhULaLrtWylT+WGra/k/GnNREusDGlRXDRkPDpVzzP2KC8?=
 =?us-ascii?Q?HjCNA47Z8uzIprPP0RK9k/JSCNtEm8wdY7YphhGdXh4hP1H3JPz14MifXgUS?=
 =?us-ascii?Q?ZlAcIkIpnBa/tPDIg6Jsck3neXwXyG9hwq3nw5GPEYhcXQHiZtwbHHinzb3K?=
 =?us-ascii?Q?STO8BRDkOUhnKYGdL5ylaCNRhu08WLoOkuCU6Yei4wmxbHi/MWTpp66m5YpP?=
 =?us-ascii?Q?6jqm5CDUn1cQYqiqaXtltFdJVSz1cF+HBcwzNgupkXFa0fV0IrT+KAF+Ji0S?=
 =?us-ascii?Q?Vix1q1zl49NPQV4fRJTZC3Qe2Y9GRBzYI6XhZBgpcnGGr/4qa1pd+SB0xAWu?=
 =?us-ascii?Q?6VeNZAZsNeIXT7cn1qQgDNk6myLgoZLPzrbKs3AbFPuoKEC9sUpxgSekULuc?=
 =?us-ascii?Q?krsUpVlONwmhfEOQkwNJzxcffVlClMz4nRjdd+drqgrXzbN0G5ZdrlUQySKm?=
 =?us-ascii?Q?oC393UmqRgvNlMQM5ItCY4SAGysMhcc4Efk3VJFxoydJ2ZzXAQdCHh4C22R8?=
 =?us-ascii?Q?md7zYfIE4l2Jlka+KZGZswYo5znuKW8R3xUomTj5mc7aRhdbFXwgUfK/Y4HQ?=
 =?us-ascii?Q?N6wPwUNPlaKEJoNQk4pPjdWvmTazQbbXrE/KINa77FRF/Mq9EHJ5hakMmBJg?=
 =?us-ascii?Q?JJ1M567D1f8g6cIS0KfKLvwy2JUAXLZp3IVx9p+Z4MRY7nEX7s5zy5OamDJD?=
 =?us-ascii?Q?ZF6cixFrXM/Oph86cjMUEVB5mb9WzGAdNN7LF7egIAemPLVcBSOrrIplIbi9?=
 =?us-ascii?Q?sUk6jD52rTAdukOipkAzzQ+x00jeSE4kYnaVFVbSDN77NRAQME7Eez+/vZ2r?=
 =?us-ascii?Q?iGMD05AXTnUWoCb1BgEaRycnrXpjuVA0PhqGtBuMvnea3EiSxQypoJw7vE+A?=
 =?us-ascii?Q?uihwgxSu4Mt+wpX7Kyjd2hetIpvlm1VqX/1zWgYW1kA/WrSPni0zadrTLYEL?=
 =?us-ascii?Q?99xdczdzk1X73LTNnjaZ5KyIVPZx7/B2Wuh3JIEbUfDmnsFK/iaiw8/PqAQW?=
 =?us-ascii?Q?OwmoCWe1JW0iytH3rKKo7zrWSD/GU2RcOp87hz5HgR4PL/Ae9MgYQOknx75/?=
 =?us-ascii?Q?gEy+TntOskMVcABfEdvX93RVpaI52YG0dW/KoDwOV3O02u/0kw2rYEhGZ04B?=
 =?us-ascii?Q?MI3YEVjFSFw0N9Ldi4Zn3nMy87RWx+288bUf0Br9Zq1jSWS3RXc69hkfTMOg?=
 =?us-ascii?Q?VNhXhFkwwrAUCUmN5/sDbxc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a43a116f-93b1-4352-cf2f-08dde53cc575
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB0982.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:38:53.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raymrFPzgtf+77TxMhefFXz8knrqb2+yIx8G860GEatwdCrPTa4ZNK4ScOiH8SLsqmTgWA1zFIbkfwOzJ6sPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7010

its_irq_set_vcpu_affinity() always runs under a raw_spin_lock wait
context, so calling kcalloc there is not permitted and RT-unsafe since
___slab_alloc() may acquire a local lock. The below is the actual
lockdep report observed:

  =============================
  [ BUG: Invalid wait context ]
  6.16.0-rc3-irqchip-next-7e28bba92c5c+ #1 Tainted: G S
  -----------------------------
  qemu-system-aar/2129 is trying to lock:
  ffff0085b74f2178 (batched_entropy_u32.lock){..-.}-{3:3}, at: get_random_u32+0x9c/0x708
  other info that might help us debug this:
  context-{5:5}
  6 locks held by qemu-system-aar/2129:
   #0: ffff0000b84a0738 (&vdev->igate){+.+.}-{4:4}, at: vfio_pci_core_ioctl+0x40c/0x748 [vfio_pci_core]
   #1: ffff8000883cef68 (lock#6){+.+.}-{4:4}, at: irq_bypass_register_producer+0x64/0x2f0
   #2: ffff0000ac0df960 (&its->its_lock){+.+.}-{4:4}, at: kvm_vgic_v4_set_forwarding+0x224/0x6f0
   #3: ffff000086dc4718 (&irq->irq_lock#3){....}-{2:2}, at: kvm_vgic_v4_set_forwarding+0x288/0x6f0
   #4: ffff0001356200c8 (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xc8/0x158
   #5: ffff00009eae4850 (&dev->event_map.vlpi_lock){....}-{2:2}, at: its_irq_set_vcpu_affinity+0x8c/0x528
  ...
  Call trace:
   show_stack+0x30/0x98 (C)
   dump_stack_lvl+0x9c/0xd0
   dump_stack+0x1c/0x34
   __lock_acquire+0x814/0xb40
   lock_acquire.part.0+0x16c/0x2a8
   lock_acquire+0x8c/0x178
   get_random_u32+0xd4/0x708
   __get_random_u32_below+0x20/0x80
   shuffle_freelist+0x5c/0x1b0
   allocate_slab+0x15c/0x348
   new_slab+0x48/0x80
   ___slab_alloc+0x590/0x8b8
   __slab_alloc.isra.0+0x3c/0x80
   __kmalloc_noprof+0x174/0x520
   its_vlpi_map+0x834/0xce0
   its_irq_set_vcpu_affinity+0x21c/0x528
   irq_set_vcpu_affinity+0x160/0x1b0
   its_map_vlpi+0x90/0x100
   kvm_vgic_v4_set_forwarding+0x3c4/0x6f0
   kvm_arch_irq_bypass_add_producer+0xac/0x108
   __connect+0x138/0x1b0
   irq_bypass_register_producer+0x16c/0x2f0
   vfio_msi_set_vector_signal+0x2c0/0x5a8 [vfio_pci_core]
   vfio_msi_set_block+0x8c/0x120 [vfio_pci_core]
   vfio_pci_set_msi_trigger+0x120/0x3d8 [vfio_pci_core]
  ...

To avoid this, simply pre-allocate vlpi_maps when creating an ITS v4
device with LPIs allcation. The trade-off is some wasted memory
depending on nr_lpis, if none of those LPIs are never upgraded to VLPIs.

An alternative would be to move the vlpi_maps allocation out of
its_map_vlpi() and introduce a two-stage prepare/commit flow, allowing a
caller (KVM in the lockdep splat shown above) to do the allocation
outside irq_set_vcpu_affinity(). However, this would unnecessarily add
complexity.

Fixes: d011e4e654d7 ("irqchip/gic-v3-its: Add VLPI map/unmap operations")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 467cb78435a9..b933be8ddc51 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1923,19 +1923,10 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 	if (!info->map)
 		return -EINVAL;
 
-	if (!its_dev->event_map.vm) {
-		struct its_vlpi_map *maps;
-
-		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
-			       GFP_ATOMIC);
-		if (!maps)
-			return -ENOMEM;
-
+	if (!its_dev->event_map.vm)
 		its_dev->event_map.vm = info->map->vm;
-		its_dev->event_map.vlpi_maps = maps;
-	} else if (its_dev->event_map.vm != info->map->vm) {
+	else if (its_dev->event_map.vm != info->map->vm)
 		return -EINVAL;
-	}
 
 	/* Get our private copy of the mapping information */
 	its_dev->event_map.vlpi_maps[event] = *info->map;
@@ -2010,10 +2001,8 @@ static int its_vlpi_unmap(struct irq_data *d)
 	 * Drop the refcount and make the device available again if
 	 * this was the last VLPI.
 	 */
-	if (!--its_dev->event_map.nr_vlpis) {
+	if (!--its_dev->event_map.nr_vlpis)
 		its_dev->event_map.vm = NULL;
-		kfree(its_dev->event_map.vlpi_maps);
-	}
 
 	return 0;
 }
@@ -3469,6 +3458,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 {
 	struct its_device *dev;
 	unsigned long *lpi_map = NULL;
+	struct its_vlpi_map *vlpi_maps;
 	unsigned long flags;
 	u16 *col_map = NULL;
 	void *itt;
@@ -3497,16 +3487,28 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 
 	if (alloc_lpis) {
 		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
-		if (lpi_map)
+		if (lpi_map) {
 			col_map = kcalloc(nr_lpis, sizeof(*col_map),
 					  GFP_KERNEL);
+
+			/*
+			 * Pre-allocate vlpi_maps to avoid slab allocation
+			 * under the strict raw spinlock wait context of
+			 * irq_set_vcpu_affinity. This could waste memory
+			 * if no vlpi map is ever created.
+			 */
+			if (is_v4(its) && nr_lpis > 0)
+				vlpi_maps = kcalloc(nr_lpis, sizeof(*vlpi_maps),
+						    GFP_KERNEL);
+		}
 	} else {
 		col_map = kcalloc(nr_ites, sizeof(*col_map), GFP_KERNEL);
 		nr_lpis = 0;
 		lpi_base = 0;
 	}
 
-	if (!dev || !itt || !col_map || (!lpi_map && alloc_lpis)) {
+	if (!dev || !itt || !col_map ||
+	    (alloc_lpis && (!lpi_map || (is_v4(its) && !vlpi_maps)))) {
 		kfree(dev);
 		itt_free_pool(itt, sz);
 		bitmap_free(lpi_map);
@@ -3524,6 +3526,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	dev->event_map.col_map = col_map;
 	dev->event_map.lpi_base = lpi_base;
 	dev->event_map.nr_lpis = nr_lpis;
+	dev->event_map.vlpi_maps = vlpi_maps;
 	raw_spin_lock_init(&dev->event_map.vlpi_lock);
 	dev->device_id = dev_id;
 	INIT_LIST_HEAD(&dev->entry);
@@ -3546,6 +3549,7 @@ static void its_free_device(struct its_device *its_dev)
 	list_del(&its_dev->entry);
 	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
 	kfree(its_dev->event_map.col_map);
+	kfree(its_dev->event_map.vlpi_maps);
 	itt_free_pool(its_dev->itt, its_dev->itt_sz);
 	kfree(its_dev);
 }
-- 
2.48.1


