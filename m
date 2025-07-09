Return-Path: <linux-kernel+bounces-724630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A2AFF50D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193B45A154C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48C23B631;
	Wed,  9 Jul 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="StbQhITc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2125.outbound.protection.outlook.com [40.107.236.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19DB1FF1C4;
	Wed,  9 Jul 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101848; cv=fail; b=rkogxVBAVF8t7aw7Ko7abzmdHxRPt0bw1Y2NBsFtUqFT0Cgv/pnJTGsUQLxT1nDKl2P0AzT+HoaLNuBxhgAyAAMT0kH0+7/bTU2FRhUxBtUIktOPf2AB6g9vhZnmAM0HUG/91eNEy67rAe0wMVkdbNFaio9GX23Ufjq1UGLKMEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101848; c=relaxed/simple;
	bh=Ii+3fxa4Mlj8pMOmQM7ZutcMciq6JzrGuY0N5svYG/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jYcTOCRIvHqVJapcYlbZJ/n2YwvyJ2nyAuhi2m84lYVMcOAKsPKF2qG2gsTvlvPiTh5xhttmipQYlCIIvrhyGjgFdJtcpn775u7sB2Ts0AqwzulAHGuvTGOotTfIEdBqKjbimLvk3qz8JatvH306kCXFiS5B5sCPbZAj272mDJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=StbQhITc; arc=fail smtp.client-ip=40.107.236.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P01KY8g6SCbe8/qrVZC36uKNvWWAOvt/FRDsQBRLMp4lma0X+s0t5VGKDHEpJXQIf15wAs+wL5OLoV45xSZ1JGe1YzqsmyZPXN/V+P9VqVl0Qzpdz/3PTWGuLOGa2hrcfCMIlQcYxM+x1M6YeCMEsG5bMT44g9unOBRds+V+TITxHBPG3MLYN6O7SnF/mdGsZsaY8VrsEAfOoRsR3FHI2IbUB+eVz25M2nkPqlKcciYYMu0PHOIj4dZTW825R8UEWBI3ZYWNaX40leSNrJoLfRIKUyx4rnfZtw/h7GpbL8GBPnnH+FaZEbGOsduqyNJ+/uKMrxrP/rchKlaoB8QceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXKc5qAw6BGo+4ixslpv4+pkr3URrfjBA9SQg0xbAtw=;
 b=fmEu1CGXXDyETc1q77c3fm5EVHDoAbNN3BoOyZCudN0VeVusSnwtNPSaQQkiu2A62MSPxFkp2g0oFO2JsmuTOOqX8PqG9d36EbIWcmDTPk8UnvThOa03A9xlYw1AB/FMZDTjCGp6j1+eO9YAgGbXqD7vkEgJN3dI0dT1jgKcqQ8Kv4ocPFq/iRZNC9beOKXIgHCABjbMTD/FtaZOfsz7B2mNjU1gLlBkZb2x1Yzp/dRJH0e9oGbUqclNYKTBJ0jvl8MbnjkiPQzkaVXpaJqwDakI/OYilYDGraiqXtpUGsxy1TBQbE6KxEM7u91QOtaCZv/dEJTnuAYtDCVkXp+/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXKc5qAw6BGo+4ixslpv4+pkr3URrfjBA9SQg0xbAtw=;
 b=StbQhITcDeSmJXACzUfhaClN7UdwbZzPssdNP+ZbdJuf5QbaCTmU+eWMcvbfGYWi54eekpx0M7VgZdYED4PDpS3C1H+IEpijDuI/CfN0DU87y8AZJFLOCmznpPdNHKHtH5Se3ekcYINePorxHCvWZET7/8j92Qxd2+96dO+yOjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 PH0PR01MB6373.prod.exchangelabs.com (2603:10b6:510:1d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.29; Wed, 9 Jul 2025 22:57:21 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 22:57:21 +0000
Date: Wed, 9 Jul 2025 15:57:18 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	maz@kernel.org, mbenes@suse.cz, puranjay@kernel.org,
	broonie@kernel.org, oliver.upton@linux.dev, andre.przywara@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com,
	james.clark@linaro.org, james.morse@arm.com,
	anshuman.khandual@arm.com, shameerali.kolothum.thodi@huawei.com,
	joey.gouly@arm.com, gshan@redhat.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: errata: Add Ampere erratum AC03_CPU_50
 workaround alternative
Message-ID: <aG7zzpFgWEQuCp4w@zaid>
References: <20250703214657.786288-1-zaidal@os.amperecomputing.com>
 <aGevCYzaRPLMGzL0@J2N7QTR9R3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGevCYzaRPLMGzL0@J2N7QTR9R3>
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|PH0PR01MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b52ebf-6012-410e-25af-08ddbf3bf639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6GXx5qlh0bCl7WtADLtEAaUTnI111vL2fMKSocyle49G/MdhL517vSWuP1r?=
 =?us-ascii?Q?44ywpU8dfm7Y7ctYT7ND3qbzgQgRx2tr6n/UEfC5Qc198LvfNUCZ76ExTGhc?=
 =?us-ascii?Q?u+vdmPIp6cZvWoIVXuc52QhS89Zwc0srzifZ9vay2WLduU/GHT8/OXHRyOsH?=
 =?us-ascii?Q?a6NaDRlVcfqHjW2Z6whgQsni0cYUBqR25WeulS2Yfs2sd92MI0EWQdoIZnHv?=
 =?us-ascii?Q?Gf9YZlqajfEqPKfZX/Rlx3u+YUaqI6kUC73kMgQHNFLllyoqjVPwYYkvrS+t?=
 =?us-ascii?Q?+tmS7tAq9tiHGbQZXMzsh+LPtRKU3VQckaRLwhBtN/6m1A1RfpP004yljUGG?=
 =?us-ascii?Q?52mi3phnXA/HfO7MxfVwnJU2MfcJpGJGCS3nJPzpWDsTX14tH2CnZHNXy0Ub?=
 =?us-ascii?Q?hK5jO5TtEP+qSopxBG4Wji1M4RLdxTa3ZScmbN/A5ZqVljuVhlwx4Z7Zr3mw?=
 =?us-ascii?Q?YCBqC522/BBEcZihKOg3d/0h6GDIjEiKFrracD17rsCUXZeFkx5UX+HNwZT6?=
 =?us-ascii?Q?a499gQ8aRVmhF3HK0hzke3WiPvpdAutf+Pjdlq/b4kU2ZBfuW6KBzmSHWJ3Y?=
 =?us-ascii?Q?Rm/6fZvY3faqvNnjcuJMg9mSjagVFuENnSHzerR9pWHJWStcEnuAILh9vuMq?=
 =?us-ascii?Q?JMxGxy3aZZTUOudUCe+F/JXad5nIISIxpPv+FMLnJh2sXp/xBwDxiJP95DhX?=
 =?us-ascii?Q?dc755jH3+kUQczKGVr4Zw/JZW1K/29uH/iqCkGLAAPHu/ONyqVnrnfOwBDFf?=
 =?us-ascii?Q?3kcs49q91XTadeeGVJhCPjy7G3vEuDeAtg3uo3XngKEz7Qh0bdYWzbIKKA1M?=
 =?us-ascii?Q?K3Okb7klRI/FyG+kCsmHGk95zYlejWbo9QSNDJU6P8ZP2K7NwT+t4621TZOO?=
 =?us-ascii?Q?Gn6S89t2dUh5c97aVZnqWkfg2ZUJhuXoglBQj1FugClH7QNBeIub1XtYwzz6?=
 =?us-ascii?Q?P1Nz4W+YXh/zFAF/Cl2AnJji4leyQPhkZ3qUHmf4F1my2XXrjiPNdy84HSBH?=
 =?us-ascii?Q?v7xp2hpNzQZDfQg40+nrH6bxdmd1gNSro3wDvJaOWhHKZhStmRe0fwRpKNRf?=
 =?us-ascii?Q?wYjLv2i6R/kiLeAZOuUWqYxefIJEgbiSPvknEkFQIMJ7Jw3vTnSmP13YsP/q?=
 =?us-ascii?Q?PXf9qVbIrMO/8iRiAN41WKq85p14y1Rq00xK57oOcIVBzUogUVIZz7/itsFJ?=
 =?us-ascii?Q?Al2R0GrDW5Ihm4NSB1I+5NR70HxYdmpPrQi1rC13u25q7+n9b/KlghIIxepT?=
 =?us-ascii?Q?Eg8Eg61/pJLJDJV0gopIV7Pzz0zIsFSIShFNyApNfaPq2GtPOUW1pIuIv1dk?=
 =?us-ascii?Q?L006VNMjp7EtF/Cugc9CPkwp3FQH3iUSSb1STG/LU9djRtLpiR7DZJVzPaB8?=
 =?us-ascii?Q?2KpAKAMYKSFWBJ+hJ6dw+3qpfVHsHATN57XS6C+akJ6i9lG6NwUJo/kcn4Pm?=
 =?us-ascii?Q?98i+wK+Pwb5S6PKF3OtHAiWkf/0F3ESfBDvqeBKUmEkG9aPvTemIBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yymQeDLGwdIgXqXEJekO8cAnfbIJNlv2jKW1D4IzeFB3c0zV1ieCKdmhqjqQ?=
 =?us-ascii?Q?fannhokuqqh6ypWDKVXF4KCU0ELVcvqjCq4gFL1WOd/mn/qDEtwfNY7+VSnR?=
 =?us-ascii?Q?HHd7/T/wtwEK3MsXW6fQSBNFUXU+YW7LPJktL+MFKFjYWvZSZBCPCSi8r2ut?=
 =?us-ascii?Q?RYlYebVWaDQJBkS1alC/xAivBqmTGb0RDzhoeR24+UGbwQaJ7W4Dw3YcINB2?=
 =?us-ascii?Q?zxnSOko5vwYsP9WHIxUS/CQvMycvAbCKryLAdOT36fhLeLcaPAnmw/jH5l1O?=
 =?us-ascii?Q?/PCE9Qzt9iX+D6PMFgamnjUrXa+Kwl5+XsBCIRQ1FP5d8BqOwV0CkLqs314O?=
 =?us-ascii?Q?1FmDBtWdK0FbTC50jRWmS4ZrxaNWxXhcYARVH76XC6u4levkRCDppqJgjWU9?=
 =?us-ascii?Q?+QErPCbKwAktfMMFdTAyQBbRDoBOioz+3/oom8jcpIDDcMfkUPy7K8JXKIz/?=
 =?us-ascii?Q?QiQ6o50a/Da1p9xOgO3qJ5hEXDjNZ6RnQkaILHPPiU4RUXOrHh87oOkWMHxC?=
 =?us-ascii?Q?uX+n58qYA0cgdd4MjJyoTDVwyhEmj8wfhrhD1n7+ohNxMPcZYcG2VjFPEBWh?=
 =?us-ascii?Q?1KNk3tlQGXe7WnR+4o1UGK4WKG0RuJNf89tiSYC58OQQ6KNWnZuQbxjW2Hu3?=
 =?us-ascii?Q?BwVKe2KLKE28LWyA2i+2WA13JkcRNbhKQ3oRwyLK5+K1xPgGNF2TeCZxret0?=
 =?us-ascii?Q?+P7KbI3/VqT4ExSHMJwX1tDPmsn+mtbHTmAqA+ymSl3UhI2c03APu+iKJi+V?=
 =?us-ascii?Q?xnf/rMVc8wN2bLG604SqCO/nzvSVFF4nQpEOFITfI/pCKfY93CCm0gxcvcI6?=
 =?us-ascii?Q?WqR6DznfNqwEBSWvUnRobidV9JtN3wHlXf7EqKYaVMbZNxrMGPavI5r/7NdY?=
 =?us-ascii?Q?4a1U0gB7WBYAOOMiCubStM7mB6mmxKUbrF+j25ru6uqR80L1+VR3A7BfOMWq?=
 =?us-ascii?Q?FH9qUZn1f3H2umbdbZqY3Qm+nrZtKps7rMbgS/RDvbHW5AbeHGRYt69WLR8T?=
 =?us-ascii?Q?4Ns0RjFyqQhO3Iges6YupEb/18pA6k0OvYVyV26FQhFSb3HUBHvArRTItkXi?=
 =?us-ascii?Q?XtkfpRzyay+c5vk9v78j/ekUC3MUJuAxEqjPwiILCxnn8xT3HUfPFZNiK7gQ?=
 =?us-ascii?Q?Q2VrNTJ9v6Fgo0xHtMCV1ipNVDT2sVwFE7GcGZMtbYjkRIQf2r71D8t3HMv6?=
 =?us-ascii?Q?SXsPAmMMHUyfBM+/ty7VTILN8tBHXIKYmdC5IINL6JfXoeZ1+ml6ESp99jLq?=
 =?us-ascii?Q?4EQSl3nr6OM7yE3H200h58PUH6pofbNF4uv4UENvuqyrwDGmIZmKbb8i5ptI?=
 =?us-ascii?Q?l8ziKys4YX/1bzwCwonL6c8/40wpn48QhoPzjFOuzeUVIJ0eoYPrVb53Y5P2?=
 =?us-ascii?Q?I0TW49vYc+PECLYEROgZhjVCxiIYG+bp7a3KpHQhb4VY57VqNVVNjC+JPtI4?=
 =?us-ascii?Q?t7VFZIltB7VPrSMfGBOj+7Y8ybV22PtqLg+SoSM9nXeYL012C/e4gDx9PLpq?=
 =?us-ascii?Q?2VWYeRkS4zM2cKWHZfMJcXExcubQP00xOdthuB2Ii6NAC3H4C3s8Q2gg5a/T?=
 =?us-ascii?Q?AjcOvoftCvjppGCPgE1wYwhMhlbjSIbWClGQX125KzRVLoY20mcMSO0Ztd/M?=
 =?us-ascii?Q?N+1W2yddoMxJ+73TreFngNA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b52ebf-6012-410e-25af-08ddbf3bf639
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 22:57:21.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqREsbgEaLdNIs4aLxNzDc10hiZNPKFhnQFod4ZCdkX8I2SzVKqsU1yPg0TxVJIGEHFb7LavlmO5md/VtwjrigGhoH7EK8Ftms4P3dNIRVveenPdicu2O4+PGwtrbmwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6373

On Fri, Jul 04, 2025 at 11:38:01AM +0100, Mark Rutland wrote:
> On Thu, Jul 03, 2025 at 02:46:57PM -0700, Zaid Alali wrote:
> > Add an alternative code sequence to work around Ampere erratum
> > AC03_CPU_50 on AmpereOne and AC04_CPU_19 on AmpereOne AC04.
> > 
> > Due to AC03_CPU_50, when ICC_PMR_EL1 should have a value of 0xf0 a
> > direct read of the register will return a value of 0xf8. An incorrect
> > value from a direct read can only happen with the value 0xf0.
> > 
> > This only occurs when the following conditions are met:
> > SCR_EL3.FIQ=1 and,
> > PE is NOT in EL3/Secure state and,
> > ICC_PMR_EL1.Priority=0xf8 (Non-Secure Group 1)
> > 
> > The returned interrupt filter priority is affected by this, and
> > returns 0xf8 but should be 0xf0, as per ARM. This workaround fixes
> > the issue here.
> > 
> > Based on this Defect (AArch-21735), this does not apply to virtual
> > interrupts. It also does not apply when SCR_EL3.FIQ=0, as no
> > modification of ICC_PMR_EL1 is required.
> 
> Last time this was posted:
> 
>   https://lore.kernel.org/linux-arm-kernel/20250127201829.209258-1-zaidal@os.amperecomputing.com/
> 
> ... Marc Zyngier asked:
> 
>   Are you saying that this is erratum is *strictly* AARCH-21735?
> 
> ... can you please confirm?

Yes, this is strictly AARCH-21735. Apologies, I meant to include that
in the commit message.
> 
> > Note: Currently there are no checks against a value of 0xf0, and that
> > save restore of 0xf8 -> 0xf0 is fine, so this is all future proofing.
> 
> This is a fair amount of work for no functional change.
> 
> AFAICT, this can only possibly matter when PMR is configured with
> (GICV3_PRIO_UNMASKED | GICV3_PRIO_PSR_I_SET), and I hope to remove
> GICV3_PRIO_PSR_I_SET entirely in the near future with a rework of the
> way we manipulate DAIF and PMR.
> 
> If we did that, we'd only ever program PMR with:
> 
> * GICV3_PRIO_UNMASKED // 0xe0
> * GICV3_PRIO_IRQ      // 0xc0
> * GICV3_PRIO_NMI      // 0x80
> 
> ... and IIUC that would avoid the problem entirely, no runtime patching
> required.
> 
> Given there's no functional issue today, I wonder if we should just
> leave this as-is for now, and mabye just add an N/A entry in
> silicon-errata.txt.
> 
> Mark.

I agree removing GICV3_PRIO_PSR_I_SET should resolve the issue. I would
leave it as is for now, not sure if adding N/A entry would be useful
since we are not adding a workaround for it.

> 
> > 
> > V2:
> >   - Update commit message to clarify the conditions when the issue
> >     occurs.
> >   - Add entry in silicon errata documentation.
> > 
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> > ---
> >  Documentation/arch/arm64/silicon-errata.rst |  4 ++++
> >  arch/arm64/Kconfig                          | 14 ++++++++++++++
> >  arch/arm64/include/asm/arch_gicv3.h         |  2 +-
> >  arch/arm64/include/asm/daifflags.h          |  5 ++---
> >  arch/arm64/include/asm/irqflags.h           |  6 +++---
> >  arch/arm64/include/asm/sysreg.h             |  9 +++++++++
> >  arch/arm64/kernel/cpu_errata.c              | 15 +++++++++++++++
> >  arch/arm64/kernel/entry.S                   |  3 +++
> >  arch/arm64/tools/cpucaps                    |  1 +
> >  9 files changed, 52 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> > index b18ef4064bc0..29e0bd8b07cd 100644
> > --- a/Documentation/arch/arm64/silicon-errata.rst
> > +++ b/Documentation/arch/arm64/silicon-errata.rst
> > @@ -59,6 +59,10 @@ stable kernels.
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | Ampere         | AmpereOne AC04  | AC04_CPU_23     | AMPERE_ERRATUM_AC04_CPU_23  |
> >  +----------------+-----------------+-----------------+-----------------------------+
> > +| Ampere         | AmpereOne       | AC03_CPU_50     | AMPERE_ERRATUM_AC03_CPU_50  |
> > ++----------------+-----------------+-----------------+-----------------------------+
> > +| Ampere         | AmpereOne AC04  | AC04_CPU_19     | AMPERE_ERRATUM_AC03_CPU_50  |
> > ++----------------+-----------------+-----------------+-----------------------------+
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
> >  +----------------+-----------------+-----------------+-----------------------------+
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 55fc331af337..1ca4c296deaa 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -479,6 +479,20 @@ config AMPERE_ERRATUM_AC04_CPU_23
> >  	  for corruption, and an ISB after is sufficient to prevent younger
> >  	  instructions from hitting the window for corruption.
> >  
> > +config AMPERE_ERRATUM_AC03_CPU_50
> > +	bool "AmpereOne: AC03_CPU_50: Certain checks for ICC_PMR_EL1 that expects the value 0xf0 may read 0xf8 instead"
> > +	default y
> > +	help
> > +	  This option adds an alternative code sequence to work around Ampere
> > +	  erratum AC03_CPU_50 on AmperOne and AC04_CPU_19 on AmpereOne AC04.
> > +
> > +	  Due to AC03_CPU_50, when ICC_PMR_EL1 should have a value of 0xf0 a
> > +	  direct read of the register will return a value of 0xf8. An incorrect
> > +	  value from a direct read can only happen with the value 0xf0.
> > +
> > +	  The workaround for the erratum will do logical AND 0xf0 to the
> > +	  value read from ICC_PMR_EL1 register before returning the value.
> > +
> >  	  If unsure, say Y.
> >  
> >  config ARM64_WORKAROUND_CLEAN_CACHE
> > diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> > index 9e96f024b2f1..299d7e17abdf 100644
> > --- a/arch/arm64/include/asm/arch_gicv3.h
> > +++ b/arch/arm64/include/asm/arch_gicv3.h
> > @@ -127,7 +127,7 @@ static inline void gic_write_bpr1(u32 val)
> >  
> >  static inline u32 gic_read_pmr(void)
> >  {
> > -	return read_sysreg_s(SYS_ICC_PMR_EL1);
> > +	return read_sysreg_pmr();
> >  }
> >  
> >  static __always_inline void gic_write_pmr(u32 val)
> > diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> > index fbb5c99eb2f9..022a3640d584 100644
> > --- a/arch/arm64/include/asm/daifflags.h
> > +++ b/arch/arm64/include/asm/daifflags.h
> > @@ -22,8 +22,7 @@
> >  static inline void local_daif_mask(void)
> >  {
> >  	WARN_ON(system_has_prio_mask_debugging() &&
> > -		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
> > -						    GIC_PRIO_PSR_I_SET)));
> > +		(read_sysreg_pmr() == (GIC_PRIO_IRQOFF | GIC_PRIO_PSR_I_SET)));
> >  
> >  	asm volatile(
> >  		"msr	daifset, #0xf		// local_daif_mask\n"
> > @@ -46,7 +45,7 @@ static inline unsigned long local_daif_save_flags(void)
> >  
> >  	if (system_uses_irq_prio_masking()) {
> >  		/* If IRQs are masked with PMR, reflect it in the flags */
> > -		if (read_sysreg_s(SYS_ICC_PMR_EL1) != GIC_PRIO_IRQON)
> > +		if (read_sysreg_pmr() != GIC_PRIO_IRQON)
> >  			flags |= PSR_I_BIT | PSR_F_BIT;
> >  	}
> >  
> > diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> > index d4d7451c2c12..757e7e837992 100644
> > --- a/arch/arm64/include/asm/irqflags.h
> > +++ b/arch/arm64/include/asm/irqflags.h
> > @@ -30,7 +30,7 @@ static __always_inline void __daif_local_irq_enable(void)
> >  static __always_inline void __pmr_local_irq_enable(void)
> >  {
> >  	if (IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING)) {
> > -		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> > +		u32 pmr = read_sysreg_pmr();
> >  		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
> >  	}
> >  
> > @@ -59,7 +59,7 @@ static __always_inline void __daif_local_irq_disable(void)
> >  static __always_inline void __pmr_local_irq_disable(void)
> >  {
> >  	if (IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING)) {
> > -		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> > +		u32 pmr = read_sysreg_pmr();
> >  		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
> >  	}
> >  
> > @@ -84,7 +84,7 @@ static __always_inline unsigned long __daif_local_save_flags(void)
> >  
> >  static __always_inline unsigned long __pmr_local_save_flags(void)
> >  {
> > -	return read_sysreg_s(SYS_ICC_PMR_EL1);
> > +	return read_sysreg_pmr();
> >  }
> >  
> >  /*
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index f1bb0d10c39a..9033110a4589 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -1223,6 +1223,15 @@
> >  	par;								\
> >  })
> >  
> > +#define read_sysreg_pmr() ({						\
> > +	u64 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);			\
> > +	asm(ALTERNATIVE("nop", "and %0, %0, #0xf0",			\
> > +			ARM64_WORKAROUND_AMPERE_AC03_CPU_50)		\
> > +			: "+r" (pmr)					\
> > +			);						\
> > +	pmr;								\
> > +})
> > +
> >  #define SYS_FIELD_VALUE(reg, field, val)	reg##_##field##_##val
> >  
> >  #define SYS_FIELD_GET(reg, field, val)		\
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 59d723c9ab8f..9eec9977ee21 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -564,6 +564,14 @@ static const struct midr_range erratum_ac04_cpu_23_list[] = {
> >  };
> >  #endif
> >  
> > +#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_50
> > +static const struct midr_range erratum_ac03_cpu_50_list[] = {
> > +	MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> > +	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> > +	{},
> > +};
> > +#endif
> > +
> >  const struct arm64_cpu_capabilities arm64_errata[] = {
> >  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
> >  	{
> > @@ -905,6 +913,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >  		.matches = has_impdef_pmuv3,
> >  		.cpu_enable = cpu_enable_impdef_pmuv3_traps,
> >  	},
> > +#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_50
> > +	{
> > +		.desc = "AmpereOne erratum AC03_CPU_50",
> > +		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_50,
> > +		ERRATA_MIDR_RANGE_LIST(erratum_ac03_cpu_50_list),
> > +	},
> > +#endif
> >  	{
> >  	}
> >  };
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 5ae2a34b50bd..6d76f79335a0 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -317,6 +317,9 @@ alternative_if_not ARM64_HAS_GIC_PRIO_MASKING
> >  alternative_else_nop_endif
> >  
> >  	mrs_s	x20, SYS_ICC_PMR_EL1
> > +alternative_if ARM64_WORKAROUND_AMPERE_AC03_CPU_50
> > +	and	x20, x20, #0xf0
> > +alternative_else_nop_endif
> >  	str	w20, [sp, #S_PMR]
> >  	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
> >  	msr_s	SYS_ICC_PMR_EL1, x20
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > index 10effd4cff6b..de34e36c79ee 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -96,6 +96,7 @@ WORKAROUND_2645198
> >  WORKAROUND_2658417
> >  WORKAROUND_AMPERE_AC03_CPU_38
> >  WORKAROUND_AMPERE_AC04_CPU_23
> > +WORKAROUND_AMPERE_AC03_CPU_50
> >  WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> >  WORKAROUND_TSB_FLUSH_FAILURE
> >  WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> > -- 
> > 2.43.0
> > 

