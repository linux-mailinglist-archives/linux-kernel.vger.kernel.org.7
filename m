Return-Path: <linux-kernel+bounces-745003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC9B113A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4081CE0911
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BD23B612;
	Thu, 24 Jul 2025 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q3P5+xW4"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE32367CD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395177; cv=fail; b=R+b3IcI67yRC+4FNGs/YogmuyfF+ubDiW0lo3Z6yjzf+026iABiylXZdkHvz0kX1ab5+LMp/afcW3DaWr4sxqyGk09KDKdIqXNL6DK7Xu5WOUbS/U/7YZHJuJVRQcItWC+l68O7kh73Q45dAATob1jGgFl5bpsZiP4/ZCjbBd2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395177; c=relaxed/simple;
	bh=XBhjm7MP9kvombmbBPcWdmFbFp/AAYNiK64YnYjMcVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAGXAF1dmlP1yFfQT7OkyI2sLzfVKgUXaZt/hnkxYTYQRgztoBhmQ8a8rXRwZz0Td11U67FtnQJU6sDix8qgLjy9CW6JDMzuKkmZWjpPu7wLKMsxM2gTa28Cqugaf3ktf1EV2r+lly+g8VnF/XYZy+OU1ff4Wq2QaYpEO5nMszg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q3P5+xW4; arc=fail smtp.client-ip=40.107.236.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGHbiWAnItsLqax/ky8KH0p7ZMC3G0U5Za54WS4fWLD68AYqyDUj+8O46h/qQx+2MFLt6bzC9TmMlUClOptO9nEMKk5K1Cr6BoWRayMiiL0bU5UScUIN2iL4mkh1vVw1Hh5uVEA5YADfITY+Yoz0TwAxW01OYdPn0lK+6f8Le4K6U80yb45VixrtKCyouoPsFXcLn3dl4/h6eGMJvGksKKfYqcdc5QflfxfEZe5Ph3dyBXcAZX205kbjspOT8sQptvZTYUDzDMu9Qj4erS+7+hvy9e+fkmEwz3sGsxrAce8Um2+WhUPf77L9lsapI2lX9BYC52K1glR1aZOvHmK0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA6ktP8Ndf8PLhiEiY8OWVhBinV4MfC1mPsiughW0yU=;
 b=Pvi0Fz4rBrvobPSex1rLry3u27f8TzaosKFJtBl4t0ZbsfmC+wSBm29w3mimCfKqLiS0N+kJZXLqnvqyv8IRg7GlOIUXdjDkoe2TsS7Tpf0VANYNtob1Zxwi8wIjJvVM0cl/+nQ/V8302f35tSgEsFjZQ5T4vQAWDDklxHpv3pC7T5l9kz55d1rtZTK8MPCKeZDxemsjbkdRc3xEvavy9WBPh+BQhyDpCyjthl/q3T6zaQFQMuooXGObThZpYfly4ae1/VzqUXvh+feJmipX831kPDGrPMlqVRBwZkwG0tyXV/veMuJsJM8dNF1awrgnVl1V3m3G/X8iUt5pNyyYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA6ktP8Ndf8PLhiEiY8OWVhBinV4MfC1mPsiughW0yU=;
 b=Q3P5+xW4DuvWzQxAg750+PaMDdHhuZgwG70vK3eTGas0edU5UtFOCij17ceWwX+huBlTVjKDSESw/sD2ZBObsN4siptQs8AdNA4dPPwck8bh5EQPEzd3m/NXKHS91ijFaCaKgepVKRasU5fk8+3oSQ1n2xLKtW0O0sBAgSubQPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB8089.prod.exchangelabs.com (2603:10b6:806:32f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Thu, 24 Jul 2025 22:12:50 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 22:12:50 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	Miko.Lenczewski@arm.com,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: Enable permission change on arm64 kernel block mappings
Date: Thu, 24 Jul 2025 15:11:03 -0700
Message-ID: <20250724221216.1998696-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724221216.1998696-1-yang@os.amperecomputing.com>
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0236.namprd15.prod.outlook.com
 (2603:10b6:930:66::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7b9dcf-e068-48d7-7bf7-08ddcaff3a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AfeNXkfmAPAdfqWySOyIKlaCBsAZKftjx+f5yHhoyA7zT227BihbyaBQaSGl?=
 =?us-ascii?Q?w2uxkmaGBhSXG3GHspmloMiLVaU3laIvhGQj4w6Rp7Vsju8qs39Riqpt/CZd?=
 =?us-ascii?Q?7LPWLmhqv8cHup6FSbWdTW9iXTGOfIPH83M4s0P6/doPulok34Ww+SXnJnE3?=
 =?us-ascii?Q?rqgJrBGvG5N0j05eLZ/10/zqmxKrNZVDwyhDN4RKdBZWAlx6rE5wVolKmW++?=
 =?us-ascii?Q?GaLV+MRYWCLAWwDr0H/U8VdoSVEDMT+yKHk7TDJVTLyVMHYE8WH0gnP72jgq?=
 =?us-ascii?Q?xl6fr9PCQXo0oywK6PmKH306rwQiDoXkIynBFiKx/x1JB0JksnZvvKCLMqIL?=
 =?us-ascii?Q?19SVBehSxc5osL9mRy4QQlbCVCqemxHdTfuQuCLszNbIPXbYppmcgAkqgbCl?=
 =?us-ascii?Q?NPrJRO9s8umDIzRzM0pDSq8M3lLukqhnK7VjXr8WkBsUxa97wQ/Z0bTTU06c?=
 =?us-ascii?Q?cXuChVWqrsLpOiE37k2QQuJ692rvhaDBt5py7FtnUsVXmlDwoIf40CD3jI1h?=
 =?us-ascii?Q?GAdbUm6Tvb2oSdOoG5qub1KIx3Q2C74KxgUfEm4n5+1UojfOL8diS5+Hp6es?=
 =?us-ascii?Q?6xD1LgyjuY3Ur7hXZUOqY3UWZEz7D4/VZCQfjHh9b1dg80d6bOvJc8k3AX7r?=
 =?us-ascii?Q?4pW7YMsglRPPFHpMAakuxNgSx8HJ85XBU0jTqD4N5on6nk62e6jMPpWmYZGI?=
 =?us-ascii?Q?8jOAE/GPueX5fFfNRZGVw1mh5Ob/qt/urIHXluiErBNM/pi9+rsDqmquoCD3?=
 =?us-ascii?Q?Ysbhe4/jgUZrLhw2TiOR0+iBaXaI4f4jH1MQcNbSyknyFZP7odsx1s31KXLa?=
 =?us-ascii?Q?LCgvdci+doVa/cqnmGPsVuCTrsYOuskc0ZLaeWcUNozGfy/r8NZPILuMbyCF?=
 =?us-ascii?Q?OiOAvIudBzVGKnpARDE5LS1o8ZoDW4IbDLhbvI1/W9jO9dWmll3R+aRW9b73?=
 =?us-ascii?Q?cjW1NtV5r0gQjAcbPYDXeOAJGL5RJ+eZkhhnVQB/YO3rIqsmd0XIVjpmrubS?=
 =?us-ascii?Q?g1VPdaMT7U/2zimcyLd3ctQUbffsbZmWdQ2Aprkiwhygn5QEP2m1EEPXx0/z?=
 =?us-ascii?Q?n/xwOhY4Pt1OAb03XhGzugPWebd0Yhi/bsSSq89wg4pURLJh4g0kTb1TMjxy?=
 =?us-ascii?Q?DrlJZtJ712ajmCeDse3z8PFJZjoUaxmsU6iBjtX+EDTVvA1ks+hFe8tkQpWY?=
 =?us-ascii?Q?IBVNshfpFNmv6cpUT5Um5CcFJHQXpVTt21m4Z6yKpO9mrv1FtsO/8WudXa+k?=
 =?us-ascii?Q?k5UhlI/LhEu/jQJ+ARuMIWsvnJHR3O3p8HoOu1ZZLMfAeR3lCRSxImwIzv0A?=
 =?us-ascii?Q?3nBSzC2hgCHAu2WSGWrVkLDScavdY6kyfgdefDfUQ/wcuGlv5EboY6RqEnxQ?=
 =?us-ascii?Q?27lOkRDgsrQsCmc2XzVYJ3HoPBkhiqiySt8er5s8LpZ2jQlQ3BxVXUC5UFQH?=
 =?us-ascii?Q?oX7GtWCkg47QyVnUqKXM90jozZSXeTP2uqo5xVViUQl+qws4cI+Cq94jKhmi?=
 =?us-ascii?Q?4YdgWc6iMsoRt28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSQZv6LzN+mZB2i7ed8BbF4W8jFfOJe6/aT6VoYQwM7LGrAfByuR37ly3keN?=
 =?us-ascii?Q?sZBo0iheEFJghR/rClGwr/EoGnCKBTFEbN8Q1Q0zY2/l57Ad+VuP93e+ZM7O?=
 =?us-ascii?Q?E8n/e/XCk1NVocUSLTKRH5CagE2J7Ww23f+84G5kVaLVVHVaJlLtvIrqi42Y?=
 =?us-ascii?Q?uDD0NwGccdsSnhCfZtXXjKLBVaHR51ift2C3mqD7aptJSvEON9/FAnuNlKoS?=
 =?us-ascii?Q?dgb0zwq5Iaca1pSjOG55cNsSiqWHvZnZ63mDHtJNZzrcrgyhLn3UAjfNhPFv?=
 =?us-ascii?Q?k89r/QnJ2qdjAr9C47PJGeHN1o7/0sSC32efh5vEsfSdU+wS5bmzyfbvKAkl?=
 =?us-ascii?Q?1fsgSiB1wAQM9/95rDNt4YXQPqyq86pMCLvSx/kiIRkkt/lAaMQjjL2bnc7L?=
 =?us-ascii?Q?pdFHePFxNDqD3Rbifk6OT00oXPZvAzCXGWbFPWxFQETbODeJbCuhP2ezg5Sm?=
 =?us-ascii?Q?WXAsoExyV6pN7WYIG3vE51NYcHgXs76xyOwf0jwULbGPThlTgojgUewvZ8WI?=
 =?us-ascii?Q?1ZmIjZ9ozMW+Joy8wEJG0OiqHCoFAO4YHRoLrVtProcFJ4ZTb6d3efscdNak?=
 =?us-ascii?Q?lf0eMb6ItKhl/cquo3xKARbqtZBHYSIepLJwi2nHnWyqq1ROq17GCSTLB5P4?=
 =?us-ascii?Q?HcjCcolc/2kHsbYONlGKpyh7vV8K+gjUIxjDgR1QxQ8/cKwrIxKqhRNQLMx8?=
 =?us-ascii?Q?MOaCvX1wQX7bHtnvMNGGLzO4r5jQZ5OMBBKafO56cg96AuDT1iLYTGLmZ7FU?=
 =?us-ascii?Q?7Yum/zxIdzGv9WZRHCuMzH293OoeXW30hwXAKhpMCLMtZE+EMKjBtlDwW6aw?=
 =?us-ascii?Q?DUw5vuzLDXTTLxSXZPJKfmFsDt3C4Cf0i6hAeqpXf9Oaq2NNy9TU/QHSG20T?=
 =?us-ascii?Q?67kvOTGGJHszdrBDmrxhfzlp0tJs4HlRnxb/Hphb8rckg4EUtoGHPJu6Jb57?=
 =?us-ascii?Q?HUqUg+nnbSNtdHuQ9epqRUrXyZXIhSW4QHB7v4aX14Y1AY+KYPbbOFz5uFj3?=
 =?us-ascii?Q?wvH0l08PMJC9EAkEu22PZQbC/kLwrW+saBY471HWU+BQUmVa+ZaJaVOG5T7d?=
 =?us-ascii?Q?4XBpOemF8lMrrWYtLXeryTzoEV2md4WXgiveB8svLyifKnu3YJcnetSlsDeZ?=
 =?us-ascii?Q?0EgOGYgGLFncwwWMz7dRy0QsA4NNBVBNBJ6YCvmO0I+hbGipkzxmvKKOqVKm?=
 =?us-ascii?Q?rnNsZrW6Iewqya0W549k/n7hgdSnztKCyi/a+vnmLd+rlb6I+TgRwGHqgPPd?=
 =?us-ascii?Q?kT/sRJMC70NjMfM1LTFzJWuzI8AtrDU/LB3ln2VFgmCRNX6PdqJg61sPQJ9B?=
 =?us-ascii?Q?mqPz4DolrpmpanCgPeanUxGn7jiWjf3VCBVjfXORGhghdDR9zYOxoZqxUjiW?=
 =?us-ascii?Q?UVvNhs/d1u0UJN1qVsNWylSXMRedT4hE+Z5j5NcDSvZ0Ci6pqItcQe3GYRks?=
 =?us-ascii?Q?tEivo96vAzah2pnRPK9vygVbrL7nT18m/wytWnZEN7bqzpet5bgDw3Wt2oKB?=
 =?us-ascii?Q?hZViCZcFmGt48xYvi904eShddNx4cJ4gCWhA1fKi1kesTSqPLwSvubB+D4mY?=
 =?us-ascii?Q?DsxnRnHq+Csz7KN3apPRr3UqkZFqO3Sx3QOB4fJ8Zt2o8YjoRYqmgYj8HPg1?=
 =?us-ascii?Q?60OXU+wrkwN3tXuYRDKgvzE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7b9dcf-e068-48d7-7bf7-08ddcaff3a90
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:12:50.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjRgVLT3mZsc/yi3bKgLJcPBUL3vHBU94lByOPJSBSombcwgD35dWWnUm8nmLlNyCLj5ecYYcCjS5hlqMYyOYLCU8tltUD32Picwp0+csp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8089

From: Dev Jain <dev.jain@arm.com>

This patch paves the path to enable huge mappings in vmalloc space and
linear map space by default on arm64. For this we must ensure that we can
handle any permission games on the kernel (init_mm) pagetable. Currently,
__change_memory_common() uses apply_to_page_range() which does not support
changing permissions for block mappings. We attempt to move away from this
by using the pagewalk API, similar to what riscv does right now; however,
it is the responsibility of the caller to ensure that we do not pass a
range overlapping a partial block mapping or cont mapping; in such a case,
the system must be able to support range splitting.

This patch is tied with Yang Shi's attempt [1] at using huge mappings
in the linear mapping in case the system supports BBML2, in which case
we will be able to split the linear mapping if needed without
break-before-make. Thus, Yang's series, IIUC, will be one such user of my
patch; suppose we are changing permissions on a range of the linear map
backed by PMD-hugepages, then the sequence of operations should look
like the following:

split_range(start)
split_range(end);
__change_memory_common(start, end);

However, this patch can be used independently of Yang's; since currently
permission games are being played only on pte mappings (due to
apply_to_page_range not supporting otherwise), this patch provides the
mechanism for enabling huge mappings for various kernel mappings
like linear map and vmalloc.

---------------------
Implementation
---------------------

arm64 currently changes permissions on vmalloc objects locklessly, via
apply_to_page_range, whose limitation is to deny changing permissions for
block mappings. Therefore, we move away to use the generic pagewalk API,
thus paving the path for enabling huge mappings by default on kernel space
mappings, thus leading to more efficient TLB usage. However, the API
currently enforces the init_mm.mmap_lock to be held. To avoid the
unnecessary bottleneck of the mmap_lock for our usecase, this patch
extends this generic API to be used locklessly, so as to retain the
existing behaviour for changing permissions. Apart from this reason, it is
noted at [2] that KFENCE can manipulate kernel pgtable entries during
softirqs. It does this by calling set_memory_valid() -> __change_memory_common().
This being a non-sleepable context, we cannot take the init_mm mmap lock.

Add comments to highlight the conditions under which we can use the
lockless variant - no underlying VMA, and the user having exclusive control
over the range, thus guaranteeing no concurrent access.

We require that the start and end of a given range do not partially overlap
block mappings, or cont mappings. Return -EINVAL in case a partial block
mapping is detected in any of the PGD/P4D/PUD/PMD levels; add a
corresponding comment in update_range_prot() to warn that eliminating
such a condition is the responsibility of the caller.

Note that, the pte level callback may change permissions for a whole
contpte block, and that will be done one pte at a time, as opposed to
an atomic operation for the block mappings. This is fine as any access
will decode either the old or the new permission until the TLBI.

apply_to_page_range() currently performs all pte level callbacks while in
lazy mmu mode. Since arm64 can optimize performance by batching barriers
when modifying kernel pgtables in lazy mmu mode, we would like to continue
to benefit from this optimisation. Unfortunately walk_kernel_page_table_range()
does not use lazy mmu mode. However, since the pagewalk framework is not
allocating any memory, we can safely bracket the whole operation inside
lazy mmu mode ourselves. Therefore, wrap the call to
walk_kernel_page_table_range() with the lazy MMU helpers.

[1] https://lore.kernel.org/all/20250304222018.615808-1-yang@os.amperecomputing.com/
[2] https://lore.kernel.org/linux-arm-kernel/89d0ad18-4772-4d8f-ae8a-7c48d26a927e@arm.com/

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/pageattr.c | 155 +++++++++++++++++++++++++++++++--------
 include/linux/pagewalk.h |   3 +
 mm/pagewalk.c            |  24 ++++++
 3 files changed, 150 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 04d4a8f676db..c6a85000fa0e 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -8,6 +8,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
+#include <linux/pagewalk.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -20,6 +21,99 @@ struct page_change_data {
 	pgprot_t clear_mask;
 };
 
+static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
+{
+	struct page_change_data *masks = walk->private;
+
+	val &= ~(pgprot_val(masks->clear_mask));
+	val |= (pgprot_val(masks->set_mask));
+
+	return val;
+}
+
+static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pgd_t val = pgdp_get(pgd);
+
+	if (pgd_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != PGDIR_SIZE))
+			return -EINVAL;
+		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
+		set_pgd(pgd, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	p4d_t val = p4dp_get(p4d);
+
+	if (p4d_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != P4D_SIZE))
+			return -EINVAL;
+		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
+		set_p4d(p4d, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pud_t val = pudp_get(pud);
+
+	if (pud_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
+			return -EINVAL;
+		val = __pud(set_pageattr_masks(pud_val(val), walk));
+		set_pud(pud, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pmd_t val = pmdp_get(pmd);
+
+	if (pmd_leaf(val)) {
+		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
+			return -EINVAL;
+		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
+		set_pmd(pmd, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pte_t val = __ptep_get(pte);
+
+	val = __pte(set_pageattr_masks(pte_val(val), walk));
+	__set_pte(pte, val);
+
+	return 0;
+}
+
+static const struct mm_walk_ops pageattr_ops = {
+	.pgd_entry	= pageattr_pgd_entry,
+	.p4d_entry	= pageattr_p4d_entry,
+	.pud_entry	= pageattr_pud_entry,
+	.pmd_entry	= pageattr_pmd_entry,
+	.pte_entry	= pageattr_pte_entry,
+};
+
 bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
 
 bool can_set_direct_map(void)
@@ -37,33 +131,35 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
-static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
+static int update_range_prot(unsigned long start, unsigned long size,
+			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-	struct page_change_data *cdata = data;
-	pte_t pte = __ptep_get(ptep);
+	struct page_change_data data;
+	int ret;
 
-	pte = clear_pte_bit(pte, cdata->clear_mask);
-	pte = set_pte_bit(pte, cdata->set_mask);
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
 
-	__set_pte(ptep, pte);
-	return 0;
+	arch_enter_lazy_mmu_mode();
+
+	/*
+	 * The caller must ensure that the range we are operating on does not
+	 * partially overlap a block mapping, or a cont mapping. Any such case
+	 * must be eliminated by splitting the mapping.
+	 */
+	ret = walk_kernel_page_table_range_lockless(start, start + size,
+						    &pageattr_ops, &data);
+	arch_leave_lazy_mmu_mode();
+
+	return ret;
 }
 
-/*
- * This function assumes that the range is mapped with PAGE_SIZE pages.
- */
 static int __change_memory_common(unsigned long start, unsigned long size,
-				pgprot_t set_mask, pgprot_t clear_mask)
+				  pgprot_t set_mask, pgprot_t clear_mask)
 {
-	struct page_change_data data;
 	int ret;
 
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
-
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-					&data);
-
+	ret = update_range_prot(start, size, set_mask, clear_mask);
 	/*
 	 * If the memory is being made valid without changing any other bits
 	 * then a TLBI isn't required as a non-valid entry cannot be cached in
@@ -71,6 +167,7 @@ static int __change_memory_common(unsigned long start, unsigned long size,
 	 */
 	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
 		flush_tlb_kernel_range(start, start + size);
+
 	return ret;
 }
 
@@ -174,32 +271,26 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	struct page_change_data data = {
-		.set_mask = __pgprot(0),
-		.clear_mask = __pgprot(PTE_VALID),
-	};
+	pgprot_t clear_mask = __pgprot(PTE_VALID);
+	pgprot_t set_mask = __pgprot(0);
 
 	if (!can_set_direct_map())
 		return 0;
 
-	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	struct page_change_data data = {
-		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
-		.clear_mask = __pgprot(PTE_RDONLY),
-	};
+	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
 
 	if (!can_set_direct_map())
 		return 0;
 
-	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 682472c15495..8212e8f2d2d5 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -134,6 +134,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 int walk_kernel_page_table_range(unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		pgd_t *pgd, void *private);
+int walk_kernel_page_table_range_lockless(unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private);
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d..18a675ab87cf 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -633,6 +633,30 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
 	return walk_pgd_range(start, end, &walk);
 }
 
+/*
+ * Use this function to walk the kernel page tables locklessly. It should be
+ * guaranteed that the caller has exclusive access over the range they are
+ * operating on - that there should be no concurrent access, for example,
+ * changing permissions for vmalloc objects.
+ */
+int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
+		const struct mm_walk_ops *ops, void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= &init_mm,
+		.private	= private,
+		.no_vma		= true
+	};
+
+	if (start >= end)
+		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
+	return walk_pgd_range(start, end, &walk);
+}
+
 /**
  * walk_page_range_debug - walk a range of pagetables not backed by a vma
  * @mm:		mm_struct representing the target process of page table walk
-- 
2.50.0


