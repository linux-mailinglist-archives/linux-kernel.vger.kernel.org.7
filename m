Return-Path: <linux-kernel+bounces-889637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5BC3E1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F552188BB61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351FC2F5A26;
	Fri,  7 Nov 2025 01:24:13 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021130.outbound.protection.outlook.com [52.101.95.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DD2D3A77
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478652; cv=fail; b=lBt9FY0iIAgQ/MYs4UKyy/y5tYnHHiN9Ocje6wgmh3PG3Lp1Z5AuadvJ6peUKMrN92woxoLo5zvs7CXTgujizgQ4KAALiQA8CwV1326vSXv3/aE7n2s21tLak6MW/yUeRi13mg4crggmlNyRQALvUSg40CuPVhDWjfXuPLSnnbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478652; c=relaxed/simple;
	bh=U2dNwtf/lq2gu2vrET0t+kG1CRPTQ1X0+3OMlqhAj0U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a9UAKmYuLCfOEbXD9sn3v7YwTNgoZXIJl7q+Kwlm9ojfYAM07dndnXGIDK4TnQDo1Pky8RmD58zG5VSUTd/sEZecnbCj0Kl26xUmHwTqMgU8tiaBae6x00yox4Xd5hVMJPQnU+QehDageijjRKN0WFjFH5R/KoePU/aaEPCuiRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVSmhGghSvV7pFb13vT7+Qlckzy2kNBjRGna50hASbKgrZ5XB72OdQXoik2rb8r6KFtHszslnWh0Len5dyu6/exj9Uzjb6XZ1UxLifW8VF0CFsvCqr0TXqIR++caIG0hWNK30aOCOHFrRncJt2DT/UaSXlxzbYgUQ6jcRolJxjQFn1XtYPzA6xtP+CATRzHFbzqVj29kAYC8ZujVAZLc/J7d/WMhedmo72NAHU3fNMDLkgdx8TeLSRaHw/twLNfVUtpREXdiFp2QZe5xShljxQkR1OCNlVJ+kDS8X0ARLyUOOoE+u8sWnC3OEk2GDgHTG/XVZrvmBdrNl0h77JoplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VfPIbaAtokRSHRURflWWJQv0F1H6OxF0TLErO41Re4=;
 b=SUIsvJ5SmVNZoYf1fOK9PLrk4NAuRuO581ZxeVRrDCwc9LOqfeSzp0V2g49p5z6B7e39nEJIFYFRFr6CmPKv0yJj8zESQixBgbd3qzGpBz2oDaUHGZg7oDf51myaYyZfBuO/JeRXGhmtxq3/4T74iNT7KD1YpD26jg57ZZ+vU0W+UyCDAQ5SkzIBAUFf4UD6a/FVO9uXYSXo2mif08RRm8432VYuwE8/JSubWqFjuJUENNFPEM+LYoEDgrDgwYZ9yFUAqecIHZUbq3Cb8w0GBYVRb7Y0z2VLu6YMu2aTV9zthIqTcNLbMVwR8hl0ovhwLbSmcM1VhsoATFwszVbjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6922.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:24:06 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 01:24:05 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: dave.martin@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/resctrl: Add io_alloc_min_cbm_all interface for CBM reset
Date: Thu,  6 Nov 2025 20:23:59 -0500
Message-ID: <20251107012401.224515-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:408:fb::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc075b5-ab2a-4f95-70c8-08de1d9c5747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGDUsxa0CYwi4QnTuutC+m2XTzIlCIZqEEiaRnuoFm1vQk8EALqk4/HCnHBm?=
 =?us-ascii?Q?bL2FM3MTq0HT65CvDKhV7CkM986WoD8L9ljeqcNXR3NMTg9c2BUtNybVHnaY?=
 =?us-ascii?Q?4PCJJsKrIsg02Frdsh9HLhte/+jO/rVgtU3eipT7Z9BPyeWO4Bkf7VgQpMvF?=
 =?us-ascii?Q?0nUGe0XeHmLxUIpCngLzOu6Rv/8x43q/tMzUgVnnE2MUKvy4xg4oqvjLONw8?=
 =?us-ascii?Q?9k9HEJWzCY+Nv1jixfSKeuL+PaNTC36rTZazm8rJFKs/1mLueSS6TFE2JvZq?=
 =?us-ascii?Q?cSqI4S6O2PHK5ILitZtPEzbMLRmmD9hYzOgvRwqBAAHr1lPb83d5PbQYw3DB?=
 =?us-ascii?Q?ZX26tU8kzhLNxRyxdRTo/xgJzQf/P/av5GAskSzPiG4iKUQumPhxAaoeAA0F?=
 =?us-ascii?Q?kq3fs5TebTLfiK2nGN0Qon8KQiIrmD43MJQrWqfbC7hhAxV/KJGEdTBoB1eO?=
 =?us-ascii?Q?VFAm737VleqoPZDg21MQweILty5h0UgC3Q2n9hMkRRerbfHvLTKrYK18hXSj?=
 =?us-ascii?Q?AJIGMK+hXWRtgQlhdRvTj8Key5gtoLaWMjVgjsnK1wyFAR4tmu+hSARxdjJt?=
 =?us-ascii?Q?GDXhNiQA6w62XjPBX8Fd9H853lzBOIMvKTGjSYQ+hzdVp6RKt38y0xE/t60/?=
 =?us-ascii?Q?vivT7/2ZsIOKbWBUNf5I3BtQy5UI7CbFPK3VN3r7gZLTWLRAWYbyOMXuwIUV?=
 =?us-ascii?Q?To2JV/OTHBBstovwxq2Si7ZIcxzC10hHVTuyVJHYZ4JA0+tQOvp7CGPinhEK?=
 =?us-ascii?Q?m0y+Ig45kbrm1om+bhgJd3BekTsIGsFnYzKS8OAMUxsk7zSUKrEQItMJg+sQ?=
 =?us-ascii?Q?MBh78JvdKi7dYtbxtSD4QjWslW7qr1PAyFua5JB/9uqHg3WLvJPsivav8TK5?=
 =?us-ascii?Q?5ejy5mtw3rlYPAV+/FRc9OfneABEqVHkV5OFmIYhu/CXU6tRoTJOPJDII2bN?=
 =?us-ascii?Q?kzN4s1trmYcgK8SLQ3+N5JTZ+COs2bHk2U29OgVCJKOAnkb/h7ZMpwQnT4Sw?=
 =?us-ascii?Q?fFsIjo0Fbmc9y4NHtzh9jaOa7Lkfaiqw6qYmTh+15diGv+gXYZxxVJWPc5++?=
 =?us-ascii?Q?HiD1wlVCUho5+lyZLhSLpzB+ewvuP5aGMsw5X6IFVMO117ogjiM+aoSk5bW9?=
 =?us-ascii?Q?hrK9g2H/8Lh2xKj+flDU0jgonR6ST772aJfQF5SNF5jCbGZanApihV4yMPnq?=
 =?us-ascii?Q?HkbBNIbMTpTsKu+AcAIwbsWHqTGewnyVC7aaTm4tmRrV5MEekEvWkq0wTRWZ?=
 =?us-ascii?Q?6Hv3ColQ6sfF+Z/RclZl+OdLqkjWiF0FpQ4pT4El34a6edjiVEQd6jXtcm/M?=
 =?us-ascii?Q?BzT4HsPpFxghfO7Rv09PCkjo3n34VnFeSuyV0kwMhjrk2vm22m3SG9HHiAhw?=
 =?us-ascii?Q?F+raBLI1kKhKj2/C/JBLw7DwzCJKXcQxyUMFISkkYTPbVlTsU2g3jkK/VuYG?=
 =?us-ascii?Q?idcGKg+E6cyeVzjPS66fYRyUHCMdu8z3CqnD+udG+ZSerVLycGWkQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5qkItuMFrEaNsMmAohKSYw41ZxCc6JysaEJtneY54weU01Rf9zwecj5HIxQ?=
 =?us-ascii?Q?AxQy1msAZNoK5NLqztuYGgBeBf7cNiIJC10Xh7NJsxcU6ChmLZvwMVrTrOvQ?=
 =?us-ascii?Q?qC6mtA32qCn8t3Hqk8IlwfeGy9UCo160bJntx2J6byazT6TholgDpHnPw9R2?=
 =?us-ascii?Q?6e6Q9vg4WU8mr+zHaMLwZLJqxi5LtU8t8+0VVAQ/lqyRXmryFh5QfuMZrjgh?=
 =?us-ascii?Q?4ZTkA9vhdLPfpiI2l9neiKoWPf13FeXse44vSO+tlmjNV8zZTgcUF0fZ9jDw?=
 =?us-ascii?Q?glgxCFLx7UidBwv4B4JwfgfxN1VSA+6uGPRbk/4uP2kxAdCDLogA+VT+DER1?=
 =?us-ascii?Q?mvJ1w7JKHF1Nwp9evFqh+uZDgtDuTXhR7wObriJY/Yj2OOVJ7z9WBCwuWTZE?=
 =?us-ascii?Q?7LYB8tuJv2ByAQM7tVdEGgnULq62mxiSBRyddRv/IoIox7qk6TYQCniFBTWZ?=
 =?us-ascii?Q?W08DxZ+ecMr26uSOBtCX2Opfhgp4kEyxPT3DkcKLkzpONHxDl/HagbFqtM5L?=
 =?us-ascii?Q?8kJKZ4Sm35V6OUH8kljkkTPRibTayezSe/n4dhXaFR6suURQAPGPAnkGAS9F?=
 =?us-ascii?Q?RfoGTtVR2V9BG3NqtCj/bPXF8cNZ5xU9VBQsF/sjWgNMK/BofwbiATABymcQ?=
 =?us-ascii?Q?JvsZJYqnjO0aYzQPTxJUiEYWHqT/5Tn94vZZjWc7fJPu/pUyHmyh/7Y0Syqw?=
 =?us-ascii?Q?TkELGW8Sfzn9+g0u3So8kg0Ti/c3Fkl2f9PT+rscu8LnHnmku16rHv++AKk3?=
 =?us-ascii?Q?DHvxWJIpNqGr4U3YSaIPzMpwNKb6XERNtApimJErH8hfY+jadEzKNMRPopnK?=
 =?us-ascii?Q?Ei5rjl5wSeRBE4sFN3NLLVk7yuR/2YCFJKmBK27qwhJZJFOl8edNpdTPVxQa?=
 =?us-ascii?Q?ZcaUjkz9Y2SMCB/zmPWDIpXZWurUlsOvV9X61QI0DIBdioGNmH0n+Nyovx7V?=
 =?us-ascii?Q?A+05Sq7+/TVZXh/Oej198o9UWGSFK/MJ6QZTyQIUq9FDal9w9h9Nj/Sh1uIs?=
 =?us-ascii?Q?rVs2UfjjBSR7vP+lXWnDJ5UVKKf35kXnW1LLBnMOuaUcd7qj/6ySOr5ikDeG?=
 =?us-ascii?Q?HowlCT5MpCe8brdneraZKLWKkxR0QJ+i6dFa5LnvA1BS++5XZbyg0xWqVLUb?=
 =?us-ascii?Q?jyd8I9E52OFmqV9bTK+lQY2iwK47mXGCWAvUVKIE8SWSDfwSa5YQi8LrKl6P?=
 =?us-ascii?Q?goVgafMtUIykPG9OxU6tfseo3l/aaXaWgpkxmMmTxJKPxwdjyoBpq96eg0oI?=
 =?us-ascii?Q?+PaDOlTajtTGs29B7GH6zlKueLunsHF4jMaQ6TiA+9bx/vUln8i46RlZd16c?=
 =?us-ascii?Q?cFQDmJqKI8lP9GC/D3tsXwOcTLFrHiD3xgTU5DN8rcouMIM+rnnkBr5NfgbJ?=
 =?us-ascii?Q?0Fbt8OtX+amCKyg764E1R1hwa/vBAcUpX0z7IVRdZPCCZg3B+8fXjn3Gy4JC?=
 =?us-ascii?Q?ptvZb6g0X2kwDXLE22yS8SGuolk1Fi9vOZto/92MeVY718vOycjvjnw9h5Ny?=
 =?us-ascii?Q?jJlWDv4FTsWvAzq13w1G+pqbuxi0rwLo2Qw2bzBsKoi5m9b6fEIiv2uuaZ9H?=
 =?us-ascii?Q?67T5nCs/KYfGdVVrJO4SqiuK6rYFpOLQXni2cdbB?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc075b5-ab2a-4f95-70c8-08de1d9c5747
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:24:05.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJYAZYy5+1zodeG5k227qBvfZX0/+zdwaU2EbpOdtKG2Z6wu0U5dHR9bSZu0ByK7pB7DFRshChBBOvapBQNg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6922

Hi Babu,

This patch is based on and intended for inclusion with the "[PATCH v11
00/10] x86,fs/resctrl: Support L3 Smart Data Cache Injection Allocation
Enforcement (SDCIAE)" series [1].

This proposal introduces a new resctrl interface file,
"io_alloc_min_cbm_all", to provide users with a clean, unified mechanism
for resetting I/O allocation CBMs. Previously, resetting all relevant CBMs
to their minimum (cleared) configuration required userspace to perform
multiple sequential writes to "io_alloc_cbm". By writing a zero (0) value
to "io_alloc_min_cbm_all", the user can now force all corresponding CBMs
back to their minimum size in a single operation, greatly simplifying
automation and management tasks.

Please let me know your thoughts.

[1]: https://lore.kernel.org/lkml/cover.1761844489.git.babu.moger@amd.com/#b


Aaron Tomlin (2):
  x86/resctrl: Add io_alloc_min_cbm_all interface for CBM reset
  fs/resctrl: resctrl: Return -EINVAL for a missing seq_show
    implementation

 Documentation/filesystems/resctrl.rst     |  13 +++
 arch/x86/kernel/cpu/resctrl/core.c        |   2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  23 +++--
 fs/resctrl/ctrlmondata.c                  | 117 ++++++++++++++++++----
 fs/resctrl/internal.h                     |   3 +
 fs/resctrl/rdtgroup.c                     |  13 ++-
 include/linux/resctrl.h                   |  30 +++++-
 7 files changed, 167 insertions(+), 34 deletions(-)

-- 
2.51.0


