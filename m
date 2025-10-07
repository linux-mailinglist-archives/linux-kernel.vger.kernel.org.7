Return-Path: <linux-kernel+bounces-843672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB24BBFF71
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24B0E34C8D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61501F30A4;
	Tue,  7 Oct 2025 01:30:05 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021097.outbound.protection.outlook.com [52.101.95.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9791DF273
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800605; cv=fail; b=hd9CdlC3oU+HAUEuuvgjh2G3lH1oYcbHYHOQkt5YiauzYF3cHhqyCUL47ecCHkIA5trvO0N/w3U0zFCH2/Eyu8Rb02wFa9q0DziVIT1Ny6gIsTT1sJstYLLirOp5QOvYyLyM3kyYw+Jix3B/1KUxnV1gbSZopnDf7S9aAjFYNq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800605; c=relaxed/simple;
	bh=+i1RlLRzWC+bP+RxKfUdc6vdz/n8cdDXH7sPGxGLdZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GM2PZEtMfYLbXgG4X9I7TTGh5HV1EKPlhw3d/nHMdZ9n+pB4jniqINEV35+aVreBJu8BhSPOuhPOgAJOpn0SgGoI4Bp7hwfHv03p+Z8g5rpLWuvqqS0GvmJp1l21xjF/xkx/X1x9di0X0d4yYf4NMJpM+jRzFPslHXzPB+7m9/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEteBhCFuzcV2ZT62TqaJ0wzy/jVHGRHjVSlfumH5B/bQNzBLcm/GU4Tm7Pwnxmw5vPlVchsMUjAeAOhZC/3A5g+l40Km1UyN0bz+YL21lU7uVIEFkxhe2dlnkq0UpwstaDEZd7he2w/PwRgPx3G4QVs56w/lphpAxt28xZueSJha7Qouex8t9PTuDh4ZHXjt1tf/+U9xJW8FJUmcevVQL5rcq/DP/7jwt6uDZqJUfxCMhyRdyXjAzPM9HI59zzAdKAwwr1yLaaoo2n2JfKApCgwmEgOg1tI9A2oTubIRf8BMmTtC1r3gKJ5TUdxWmWh5/1SyDio3ZVqhrSo5D6EYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OEDErT+ioey9Qc4+Bv+MAt2S23ftkmv4vJ6OSF7keo=;
 b=EP7/F+/loTUSRCPTC6HcrlXlqCCFoVt6COAk9jymvCcai4xCktiesdi9fMuO7XuKnWFMmzc0e6uA+qqr2SomWbtCd78JXQRRZKSYI3qwOyOWt5ZS5blFU2eKIr8nna9LTQOuuWsqfF1I9m1uSoppHTkBD/VxXVWZQBXd6twshHaO09MjbAUErRUDO4Dd37hpFLyS7Z8GDDk/MOBa/3Ge2BEEznPA9bGCdF4QYMJx+vRA4IzMvU9hA7mD6oDb9bp2jC+yiTZVGUoH5r4B+1DPFSQaqVOOhcUIY6bz/5RYOWYVQKj3EBdcOW0GXBGn1N7TjCMJQLTkpLYfMVtBPgLR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8319.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:30:01 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 01:30:01 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] tick/nohz: Expose housekeeping CPUs in sysfs
Date: Mon,  6 Oct 2025 21:29:57 -0400
Message-ID: <20251007012958.16666-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0284.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: ed16e9c8-5367-4b33-3972-08de054108ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ut6Odi1ccjXQUUINi2gbIe+j0dRP9uRySwO7qaacb5b2V5/43QXeBUfxupzx?=
 =?us-ascii?Q?8Ia8Lxs7/j32dJXK0xhUoaR7GGHu4qQOJKwqXy9q9SnIb/aOTlXrm3ojLSYv?=
 =?us-ascii?Q?UIveU8VNaa2jm61gE54e8AYyJ/jqnjvgQt2C559J9hPb2U23+uSVivf9waqN?=
 =?us-ascii?Q?Y+s9pRCng82nQFGd2rbvx1I6XVUxCr2d8+Xf0x8ztMpbPkIDi3O7qbVrZdUn?=
 =?us-ascii?Q?efqc4cECsNIqNsb2Cb3yalRzzfwC3ehNYuon2zDvt8cO4jq1FaB6weXq4iCr?=
 =?us-ascii?Q?1kbsO0L9dQB5kG7+p1vmMVfm0iE6fMRfEfiqBmY2CoaCBvSaj9oUFBPKrGnF?=
 =?us-ascii?Q?2kMpq1kD6aJfcffKAkBNVofr1OXmIL41Jmve2BEE1ix9uA/BkHOywQc/f6ad?=
 =?us-ascii?Q?nLN/K9PolHYuLIikjYnLGPZ66moTi3miiTxwIp+Qey5Bs2Y9BQ7K+w/DDEDC?=
 =?us-ascii?Q?jc6SQQV8089X6T4ovolS4i0ZBx0kGs69ZjBoePuOYyyPWdcDCLGD6lueJH7T?=
 =?us-ascii?Q?v7v4utsvCxm+W4rtFCw7Aj02MYiQ5s7/khqpPq4+a7UX3Vd8q40c+deUWZ3Q?=
 =?us-ascii?Q?q8xkE/cR+myhaVamJcO5LqgPXdGFAmCE+Lx2SD74q9fQtQDNkY1i78SYSn9+?=
 =?us-ascii?Q?xn1mq1Mw11mrE/nqLtRnMGOljVtOBxgAZzmPlTkGFqv67hMUbq2H0Rubqzay?=
 =?us-ascii?Q?hZLRMvTl09J0uh09DNhhdLrOwI4zbYSYHA2IlaOAjNWI+JmyyKS5F9tNxmM8?=
 =?us-ascii?Q?LDEWz2hwUYcVbdlYu/jdSogNffuT2JRZrCp/iwQ1hYNTPZFo1yKQHC18/42a?=
 =?us-ascii?Q?ji1Rfcrvcwkh52Q71I0HIs0YuXvtw0qif9JZ/GzjrF9ogDC5y9xFSK4gS9n0?=
 =?us-ascii?Q?W4pueRwtNgSplpr+HYAGDq5Swf71nKdGzg4vs16DqXVy14/2SsJkOQNw7g+e?=
 =?us-ascii?Q?exTCeemQRDEFAQMbGaQpQj/THSae4HLpG5z+ROoU9VdZJzV05sFotMkhuXRt?=
 =?us-ascii?Q?GWZ/OQDHf5xnlSMeaa2rFhYiSyrWAjOLJ9dNJ//5bE4VJspVm6KQvRlrAHFE?=
 =?us-ascii?Q?k2wjBiZe1uBj39tQKf0xN6mBJIMbOjLuI25h/i7vdQsrH4GBLQBhUSMVaZ3M?=
 =?us-ascii?Q?XGnJ8AQ3WI5rMl+OFZlgI+h6r/timnqiKB+dTh7phc8vrR+iLzeRWWe34BGg?=
 =?us-ascii?Q?7360psZ/dUFVNRjGluh1PTKzghcTjUPw58tvEkMlktq7qX32p2Lto2bQJpCg?=
 =?us-ascii?Q?LkXcL0jhUn6HGKHgWpY+Nw81V86u1OFSkktQ5YoHXiuiT3EmL9silnbBqXmG?=
 =?us-ascii?Q?b4F1HJfG0lAQOj3qUyl9hoNN4yfP3f1uoLzYgHaeknaXoFmEATReikse46Im?=
 =?us-ascii?Q?2RBXhf5Ejcn7gSdZyPC9LE7dylMKO1YE76fXmS9Lxo2weQsz/0aEknYwRLAb?=
 =?us-ascii?Q?VmE6NTAKhm6QSS+0yWlIs/ueptm1Pak71flk6yNnYkqD1C9E3FRtOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tijl26aEVBihWxoA/S2ocZM+hSYpRhUOoY51/OMzsl2WBdRsOLXVYRvGh1Q2?=
 =?us-ascii?Q?8Aj0zEX7E4gg1oeDPR0RPYQLMSzjYJ2mOyNkWkjHQTic/IBNM2D5PiA78G6/?=
 =?us-ascii?Q?ltpawIDjmx0WRF0l2NV04lo5fTkcLtGpuwLq5yEjV/kRS+wKLlIVjA8Hypx8?=
 =?us-ascii?Q?kHa2zcU/DClpfsW/vqP/OMCRSLGu2ILI7ZylOrgi6nQTndtqr/Hh9wFxJvJi?=
 =?us-ascii?Q?73wiqKQa+FSDTj4f4J+BjrXLW8WbrDoKUeNRosbRSxODGfelOEmPQXRKJo/y?=
 =?us-ascii?Q?bQOWnEcoJ+owQ+ma/ObFUyYynzANdZooJIJ9+2dA7MLV/CyX9JA/DwNYX+Mf?=
 =?us-ascii?Q?+8hDt2VPsvfHlKDsvT43Kv8f6okdPRCWYgayhRz+pd2wE3/4qrqYos2uBYKh?=
 =?us-ascii?Q?EBk1xOE2kQbboTp7jinZaYilcTE2T6s9knveOZ0vXuydvAzPMsDiAZnVYyWN?=
 =?us-ascii?Q?tgD/c8xND7XEgUKAri7mvDU1svlMYJzlwSEcWojG6Frx5hn09tmMJL/FC5vT?=
 =?us-ascii?Q?GeZFyGLRQuNuUPEzIMfD2kH31Hsig9TeP/IIrb1A732MNxkFUom7iFIEiR5P?=
 =?us-ascii?Q?GTQ3zNW9dYDLh1yEu7CscyVqlTswimP2jzxdhvNPmAINPloKXre7puo7pqfl?=
 =?us-ascii?Q?nq2JTHKT9Tpz3yo+i7YsicOcXiwjxwb6TC2beL4b0NNJ3Vk0C2arV3rhqsKg?=
 =?us-ascii?Q?qwPezr2Wwh3seG6HglSkVDoPlNbQkTSh3ddQUfQ/64WEbYvYlkld6uxpKOj/?=
 =?us-ascii?Q?rvZWAuGypaHRWsoFNG59iVayiLTU5YUSC+x7uuwBYPUs6r7hNpQq6QgK1iXd?=
 =?us-ascii?Q?E6vKwKrBm3invX798RZv2+Hw8QZWzV5QHVX1ohZYoJP9pMf9YA+8aMywlgO7?=
 =?us-ascii?Q?YV4ooZYd3o++Pl+fAm5VCzNeUGUape79zcd8jVCMAAhKGfv5TdXzE8UlmFon?=
 =?us-ascii?Q?uYedji8NPOhGKuElCRN6q7QeoTh12J8AIQNiilT1CBLrrileVkNMOKGONeCA?=
 =?us-ascii?Q?j/xwIvkzKnmRTRQ6UMQIKLMsmgbjZwUsSet8aZc/prxl49Ot5KYfN8VKu4bz?=
 =?us-ascii?Q?beoVKhc9L/mEHuD/sfEffUY8rAsMHTlwwnwNQuRxAd4IzykG6QGw57njhOm3?=
 =?us-ascii?Q?Av6Va476U88eSWM0Kj9aVaDG19DdkXlZ0Sj/xrA09cWV7mslFPNjVuuBaikG?=
 =?us-ascii?Q?+dYT3Bqt8CfROmlOrNWbQHZKJfoGczA8iiwihBOVVhaBHvy8h2ZgcuBmYY64?=
 =?us-ascii?Q?X0HTYwsLHzPvjhR9RdfVO4A1JfocIrGffUuyzoalV1XZB7jeFACaSBSi+xOR?=
 =?us-ascii?Q?iGF/d6jVIsnRj6JK4NhVaqDNEyDRnvEv/B1puBctcrwRHvskFn0HmzMutKO3?=
 =?us-ascii?Q?AyHugC9N9xglcGoEgKePHZF+FuaCS4aOFSpV4LFY7lxVZTBLW7pBV0hMWJK+?=
 =?us-ascii?Q?FR//GMVF+JGyVCaPRt/gyKOmD2oMFtcr7xCBMZGQsoYpMV/3QzMAyCQAgYsw?=
 =?us-ascii?Q?MM9VyfOSHEAnurOUFjeGvisP8lupJpbtK9aIGe41wnQy/cJpbAtJLMxgCs0i?=
 =?us-ascii?Q?Ich2n4vU+c/WZWI6SpqLSqXBf+TveCnoc8TryYgf?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed16e9c8-5367-4b33-3972-08de054108ce
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:30:01.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYYYmVe0l/0FBS6HlRcl3vag/9P5NSfTYkydmceoYHfkI6wETr+aGAYSRbtTDxpPSpe94rpa6WfSk8keJJ9QXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8319

Expose the current system-defined list of housekeeping CPUs in a new
sysfs file: /sys/devices/system/cpu/housekeeping.

This provides userspace performance tuning tools and resource managers
with a canonical, reliable method to accurately identify the cores
responsible for essential kernel maintenance workloads (RCU, timer
callbacks, and unbound workqueues). Currently, tooling must manually
calculate the housekeeping set by parsing complex kernel boot parameters
(like isolcpus= and nohz_full=) and system topology, which is prone to
error. This dedicated file simplifies the configuration of low-latency
workloads.

Changes since v1 [1]:

 - Refactor to use an if statement (Greg KH)
 - Use DEVICE_ATTR_RO() instead (Greg KH)
 - Document the new file under Documentation/ABI (Greg KH)

[1]: https://lore.kernel.org/lkml/20251006005853.76335-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  tick/nohz: Expose housekeeping CPUs in sysfs

 .../ABI/testing/sysfs-devices-system-cpu          | 11 +++++++++++
 drivers/base/cpu.c                                | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.49.0


