Return-Path: <linux-kernel+bounces-771340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F98B285B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAA55E32AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E02192F4;
	Fri, 15 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IOKTaysA"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0038218EB1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281931; cv=fail; b=YZBN7peBbLHBrV+ITIi9+dNxNbOF9pnHQ3DlXbRYB6nEA59FupB16XZe7hogaEpyla3kSsnFOA9q9CgH/2Fk0IJwNwbZeWpKJmQhpdsU1UOxFi74Grunm52VxE8dAN2yknfKclt0ETu3im8nf8nFx9WYsGr6wWxTt66HTxXZg84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281931; c=relaxed/simple;
	bh=LTFfnG+uMtXPYkwd4V74EwdBm8hFTdmTqJzK15s5ScY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZZufRrTiwiT1a3EEu2tcKMCBzjodpB5p7e5aQR5mZnfW2ST5LqksR39NVf27Nqzw+mqDBs7f95MUvqp6J7Rrs+KkmScYgBXOeHuRuoowEFjP9+1J0VM4xllpsDQwBnUFo9BV5fXEr4eiW6w27TBJWzKXYnqdCyTfN38D2jvL0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IOKTaysA; arc=fail smtp.client-ip=52.103.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU3GKqXBaad2LjBrjupAtmXVtMeqX1xFT7Ptyje2Klve1whgL9QuyrD94xV6GiDUIjavotER7ZtNnnPVQZGW7aSn5fDkf3vCLEumIS2vwpMTBx5dBSxxd1UPgfxaSwKGi1EVJBAxCehjWhskJJmlbsBCfcj9KXWAwws6+PsM8xBSxVBMecHvBkGQp2d4ONNzwguVB4pNQq4b1ASlY7JkAj/5+3n6p8kXTO6MgH/jJ+FMedzGcSgY0cC5xLdQ390TN4gW8Tgm4D4WMohSIUgQm+8+T876MYuyW97JsB45xMbgkoB1vLmNKIzdk/XgKU/XKj4S1VEGd6d+vrnPYnePCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTFfnG+uMtXPYkwd4V74EwdBm8hFTdmTqJzK15s5ScY=;
 b=Em5SS9N2ixb8vcFI9nxzErfB1K/4ZFDPtAUOzBt5ONDoR5eTsy7SLFibyWxz4OFejijP6iNdxB7kA2LYLiQMVQOp7dhJNxK+qt0ZdBrSatvcrXUBjNUzijSd/MBTVkVcqiOf/9sszTs5DOaSWT2N5rgqiBJh3/CIQRxkaoDrZVAzG8udfy12cOrjLW+iviEwpL0YB8i2ETpOC7Nur17V2pNJP8TPafDWZ7GSEdOEcD/nO2WxurXqDFBM/sFH7PWc6TI9buO0AeQZPNQ80ypatul9Gf9El6Sb2pycan+i/wsjk4bT1oMEQYIrrgNAK4ripNB3locYqA34BfG5eAWhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTFfnG+uMtXPYkwd4V74EwdBm8hFTdmTqJzK15s5ScY=;
 b=IOKTaysA6qlp0uZxaPCPDKFOnEvn2IGCoazvmi0jIr0PTpGjR8TNTAqd7vqRlC7q+E0TKd46HCP4VT9SUCm08jF/qtq69ObpB4PUI1bw8xiRivEyyyqaaBJ4IKbszLujGk5lqQ4SjrO0NocsBZ050/QeXi7s/LNAjnu8KombhVmrmGmSx7CjMF7vGtp0jpajraJC+ysDpAFJGF8KCm+JTw2YU8DeBRw9G9xy6JkcIVfF2zz4nzwu/PmQoO8UcTx3RrHfMROH/z5IlpYiVn3XqvT2LTi738F2n8xrLcWiTqb5cFwtPgXJffEHtbThvMny8+PnzdMeZgi2zVlArPG64g==
Received: from OS9PR01MB15202.jpnprd01.prod.outlook.com
 (2603:1096:604:3b9::10) by OS3PR01MB10090.jpnprd01.prod.outlook.com
 (2603:1096:604:1e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 18:18:46 +0000
Received: from OS9PR01MB15202.jpnprd01.prod.outlook.com
 ([fe80::bd40:1d2e:2d1f:e8f3]) by OS9PR01MB15202.jpnprd01.prod.outlook.com
 ([fe80::bd40:1d2e:2d1f:e8f3%5]) with mapi id 15.20.9031.018; Fri, 15 Aug 2025
 18:18:45 +0000
From: Shixuan Zhao <shixuan.zhao@hotmail.com>
To: Kiryl Shutsemau <kirill@shutemov.name>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shixuan Zhao <shixuan.zhao@hotmail.com>
Subject: Re: [PATCH] x86/tdx: support VM area addresses for tdx_enc_status_changed
Date: Fri, 15 Aug 2025 14:18:34 -0400
Message-ID:
 <OS9PR01MB15202207C488796172F1F179B8D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva>
References: <enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610::32)
 To OS9PR01MB15202.jpnprd01.prod.outlook.com (2603:1096:604:3b9::10)
X-Microsoft-Original-Message-ID:
 <20250815181834.16344-1-shixuan.zhao@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB15202:EE_|OS3PR01MB10090:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0f1358-b927-444e-12c2-08dddc282c41
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|23021999003|15080799012|19110799012|41001999006|8060799015|440099028|40105399003|3412199025|13041999003|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbDQANj5HJPxuaqrp8aGyRpp96EKOsIm83K634CPFMWsCZHRmeICw1TIA3nW?=
 =?us-ascii?Q?jd4PafZIBokBaQBQflzz/hb3XSAyxA7Y2U79geseohthPCA776a7N1rNkLrY?=
 =?us-ascii?Q?kSqfeRqgTcrZC/r9IJHseZeJ/Jjb0hMwdQc91iszjBnxhep90mtUFZQGQe+4?=
 =?us-ascii?Q?jXF+9BDsMt6izBSuCLallt5O9buJKrTI8lyu+8Ws9Ea4NzWibLbuVCQoa09d?=
 =?us-ascii?Q?YGvv2ugnaGCbJdcDfqODKgJYd+a7W5MQJj3EZY30AtPT1tqhq4xLAYmVI1yy?=
 =?us-ascii?Q?t4V9uhCsI2iv8t9K/WEp17xq11h36E06mFzEP3jmRjXCyfBfDD+b9poVjBK+?=
 =?us-ascii?Q?DW3cxCsN3377aLqQ/tEHMTAsV4tbXOu1mz9diOpKLHISKo2K4ZU9C6aRB9BY?=
 =?us-ascii?Q?GPtBcY1qHs7ubOAI3zY8oGP8JDsyaVVctcUPfYcJg8OkIz8tvVgUB6EcpKVR?=
 =?us-ascii?Q?7WpGLXo8AbASwEByr23+vq+a6CDxlwxgxPCN8LcIe5hZ9WVEwQwAyGQfbJ0r?=
 =?us-ascii?Q?vbC9SSfRkMLevpdaj5g7Zu0qXNcDPzp6eHaAL37Z9Hj1O1ByHe49iYhDYDJO?=
 =?us-ascii?Q?7F6OyqvHRKrf7OOh0xnhXsXAJ2MNdBOcJtqX4ruLRm16JuMiULrzDz17+FXl?=
 =?us-ascii?Q?TBjEvBmUCMmjnYQoqn6o/JkuSexh8vJxAZM4ebmP/GLb/mG2+lwzsSRIxjTf?=
 =?us-ascii?Q?/eqTr9GjBEELIiibb2oiTWOORlpFXSy1K5cVjy2F3SUL1dyUQr1mDxAwtb/p?=
 =?us-ascii?Q?oHnYy3Dx6Q1WtWw0iT3OeSaP0in0gnPyAadY453E/1DZEWxmsBydONmZmcaY?=
 =?us-ascii?Q?f0mepF1HAYCQBdupDLMMj7WrulsrE72hjj62z+ceo5bBOMFtfqcCX0qB9GsK?=
 =?us-ascii?Q?Ovwzx/qaxHWMtvp5zD9X94QaHLLgqX4HZT/D4du5r2yMSP9QiGWBRiYs84oJ?=
 =?us-ascii?Q?y35nthX8wc5HeYO32n4xjLuPwZm40JdZsr4NSvbyi1agrcSj8ZPZBWOtNcgE?=
 =?us-ascii?Q?QbhCJeRkLmhjMhP/Ob4pzm5kxfVOn24ao2L13hT0keDJzP9NSSesPfnKNW+n?=
 =?us-ascii?Q?NkXCFxCj33QZTuM0HIuL+YC3bRhflhVarLVCWlhiBG81BBYzNUSVR0SRMHLa?=
 =?us-ascii?Q?lDNfAdJnqg6khM3FHI8H4Rh52vBXdhQXiOXqYjMWXYR2RQN/geP6sClgNSME?=
 =?us-ascii?Q?4vDuLf8e1hH4NYge2xSj6QE7fHBUwDKqtmC64Ap1r7ftFiCjwVn5wHCH45xu?=
 =?us-ascii?Q?EO32cQxzoyVOOPNNemx1FpQBL1WhW0KllMkpXQB/aA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Imp0GxqqPp/7t4OcGzz8/bp9sgdBEkhzUcPir5Uhcc/j1yLHMMu3Pwpu2Jap?=
 =?us-ascii?Q?ZR0Yvgbc4YysvlCMnDBk4JA1M9txukHaqCYac5ySdjuRXEXWUdPcWqNM1fNI?=
 =?us-ascii?Q?u3PVKEaNPu0km1p8yaPeHxPSwFgnUKxaRJ++G2yW93KUM8EqKe5B1K1rI4XS?=
 =?us-ascii?Q?Rvqd3EJrqQ1jA/85v5KJaNPEsYdjiIc1dXEGkSIOwRDEDvgzmFvq3nGwvqWi?=
 =?us-ascii?Q?4s/stiD4gBw+GICVOV6MaC0/YhU/H4INCoTXTV6ftoYKY41YQC+6/HRbyQ0r?=
 =?us-ascii?Q?+D8OrSBLyKIaOvk58+014jeW47AaXA3Omh+6XpECQaaxs9hTMGzLXQEo7Orr?=
 =?us-ascii?Q?kSRnPezBIqy9JZ2ZCXQheeAnqyAVikYPt6GG8Fdtv90Qe5KoQqAyBd8wZdE7?=
 =?us-ascii?Q?92lV/+QViX5eDPnyB3HRxc3mEcrQm+lMxw4jHO7K+L1CjCs4qwILeh8WV88d?=
 =?us-ascii?Q?ZvI+J72ePNa+PxJFSx7YVEzlkStOzDv93ZFuHhT6L+6TcquwkyTIbyoxwA2q?=
 =?us-ascii?Q?82JhCw2PQGCvteCJ0vhwrucBRX7OqKTjDSyZLP+BFTZsMAFWVl+rjtSMJMwQ?=
 =?us-ascii?Q?YGBVzwkl0NvQYgI/Sw1IhsuSBkV70zF4LPK8BdGfYWjZKpZhDVuos6kwzQ38?=
 =?us-ascii?Q?jqDRLjVpUQU7oOWZq/CMuxUIYD9lkPTR3YD4GFjpLPAgwzrJ7TAQyhRoJLCh?=
 =?us-ascii?Q?q3fFgVPpg7as34ldwldgqGUQfIRoPDMBn+vGo3uu0wDXBo2yka+DbITIxWc5?=
 =?us-ascii?Q?6RcXXYRjh0t8DulwHwOAVSt4eLUIaItLqM3sqJunBL6Kal84DM9ma3WLse1c?=
 =?us-ascii?Q?P1hC+R+DRekKqQo2vCMQAYL4hiyI4+HZg4rJkMesssC0h4fSOfXTkJumNUFt?=
 =?us-ascii?Q?n7K+whIUeK6AiK9Og/Q7wNWs065ECJZJ3LrpHGMNPoU2zy2ih9OeicDw3dtJ?=
 =?us-ascii?Q?qGUFs9IPSprHmv+XgvpFvUVeYIDBTo13cT0P4iWlfyLmT6XzMa6ZotPjv8s0?=
 =?us-ascii?Q?WvjaWBgVtTT7gToT9pKpJ4BEVrR6gHdajn8deWkWLNUUUWXaAkcLzjfmnwDi?=
 =?us-ascii?Q?+cgEmWOcmfpPSjd8OfYZ85kOVRNSHXrwr4yDrHLZYqd3e8f1uuk+WZ8S3i+/?=
 =?us-ascii?Q?TidoSMpnkBXz1GPpKTZJU9TSP8yHLL22Z/v3hUnZfL7N4HSxc9eC6TEpupoF?=
 =?us-ascii?Q?acVm85PrgNPMiodI/wdmrnw+bHCYZq8NyvY7vAlYfax6sx7f1pHgwfKZGd6/?=
 =?us-ascii?Q?P0r5RQJzlFFtcWG+QwLHaRfJvKR3QsrUnoQfIdpjFA/yhICMq90B9T9jWxct?=
 =?us-ascii?Q?DobeHkHoY/AcociVmLVw5zId?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-9a502.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0f1358-b927-444e-12c2-08dddc282c41
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB15202.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:18:45.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090

Sorry got the Message ID wrong. Resending it.

> Could you tell more about use-case?

So basically I'm writing a project involving a kernel module that
communicates with the host which we plan to do it via a shared buffer.
That shared buffer has to be marked as shared so that the hypervisor can
read it. The shared buffer needs a fixed physical address in our case so
we reserved a range and did ioremap for it.

> I am not sure we ever want to convert vmalloc()ed memory to shared as it
> will result in fracturing direct mapping.

Currently in this patch, linear mapping memory will still be handled in
the old way so there's technically no change to existing behaviour. These
memory ranges are still mapped in a whole chunk instead of page-by-page It
merely added a fall back path for vmalloc'ed or ioremap'ed or whatever
mapping that's not in the linear mapping.

tdx_enc_status_changed is called by set_memory_decrypted/encrypted which
takes vmalloc'ed addresses just fine on other platforms like SEV. It would
be an exception for TDX to not support VM area mappings.

> And it seems to the wrong layer to make it. If we really need to go
> this pass (I am not convinced) it has to be done in set_memory.c

set_memory_decrypted handles vmalloc'ed memory. It's just that on TDX it
has to call the TDX-specific enc_status_change_finish which is
tdx_enc_status_changed that does not handle vmalloc'ed memory. This
means that when people call the set_memory_decrypted with a vmalloc'ed,
it will fail on TDX but will succeed in other platforms (e.g., SEV).

Thanks,
Shixuan

