Return-Path: <linux-kernel+bounces-880384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43072C25A70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3521B237BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8372C34DB4E;
	Fri, 31 Oct 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pOZUMJ88"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B43EA8D;
	Fri, 31 Oct 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921798; cv=fail; b=ajeEuvk8o3Ddp9RQQ8G1zy3HTWQW55uNsh1uzDLLXQMU5cX/dThITxPf5eV5dIamzN3KtSIzYiWVTYSAKCCWZBge6XuPs2q/hZLXado0WriYWw0Z08jNwb/rBEdMBlHnoVMvYWDTYk/T4/t1DIvWSwkgvaUna4rTLHlI312OH/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921798; c=relaxed/simple;
	bh=Mv4qOjd3Ei3nXolzf+Ymd+EIX97k4JPXZky+3snAZTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwYfyV9dUkUDfpMFoDOHN3GD2/kvIEYe/ACQkKZ8T/5cqoP66lifuPS/VbiXMn4bUreN2vWvogWUaXlfqzjkBvxMq4KijJ1cXpf/ql/Gk7k11NA/PlxVoRInn4vr/RUBccftsOmQ3Pk7g2fmwCCjnnaQPK04n3kn8DMFwJvNO6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pOZUMJ88; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEihO8Ig85W/g5kkL6aMljXun4S2Tag5bD2TB3HnuCEhVdVA4P8oMDeGTQFDqIj0C28hHFQEe9c8rtPJ8q5ve1nj/U3FDSeTKY+3pQ2wRwTqvql5Hou/5A6xngjpTyWoewaS07tAUonpdUBgqvqcqx1jidmQNMwawYDjNdQwqx28kBZPdPipIvOW8uYbzBDZEcC8TyG59cWMPvl6qlPh6mFcvc1dGj8uePWu5Pns0rN7dLpWJWTeoeik1RPPxwq0UwWYlHMIh6AusxiZakMANkMxZDqCu7YT+eniLU2ON46tdDRDPYbhiTxKfS/DSnagAqWT3+7bVB3jHkJzqB+qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYJeF3wmuBjGKWXkbVsWKBWFrVKnzhhmbYWuAgQb6eA=;
 b=nd59DJv1HQqOkZdUSm/WAEpfVtyUZ/ImokDyEHt1NXyB8AR7ZlyMjl8qJjY6xi9MRRwt9CWGSNwi2Mkx3zpsWBV4An3BkX/PiUm6lMolimZrO6ZUvgCSw0K+dTobG0/g7RRraPhytNXz8LmLvghkcRNIuwh0tC09MaLAx0gfvdsEFtlfamofltdJcLaFKtDzrXlYmwKk52UvPpssTaVaeEcsMogkZ7NQaRNKgPsQ6QrL/Xhhb/xl3sW/sUVoapSNL/gDqq45lD35DslC4QX8uz/LPqz6jbkyiee95WGClHyfzCnWBHXEiDoQtKPvk+bEn/A8Si7t9s/Dx9n/7eV04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYJeF3wmuBjGKWXkbVsWKBWFrVKnzhhmbYWuAgQb6eA=;
 b=pOZUMJ88Fkvf5cVo5WX9chwp10O2BPSDHrfLEZgQE4eWIXX/kAImnSsxi9zNoezNG/oP4zTOIBvP6ZORbDR+oMANVgtyh5TTM9khxatukDjEMVJO9UxxbXEDBZRGyRlojTTW+B9TdcxbdtF7lHl6ijkjcUyPSZQ7MDwfd+OGX08=
Received: from MN2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:208:a8::27)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:43:12 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::dc) by MN2PR12CA0014.outlook.office365.com
 (2603:10b6:208:a8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 14:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:43:09 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:43:00 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:42:59 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEgf5Z4024498;
	Fri, 31 Oct 2025 09:42:55 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <praneeth@ti.com>, Paresh Bhagat <p-bhagat@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
	<afd@ti.com>, <bb@ti.com>, <s-k6@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Remove unused ospi0 chip select pins
Date: Fri, 31 Oct 2025 20:10:57 +0530
Message-ID: <176192142799.427883.12507657912485328517.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251029032144.502603-1-p-bhagat@ti.com>
References: <20251029032144.502603-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbd9a83-4aa9-4896-a953-08de188bcfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0swZk8vUGwxZExTZnc0MHYzRkJWS3QvUDkrTHBJQjZOT0dyS3c5NXJkYnNl?=
 =?utf-8?B?NFJWTnNQclMzcm1zc0RGeG41Q0FlZ0FTRFQyZ1Z4a0pLMXo1OCs1U1lHVXpo?=
 =?utf-8?B?YTY2SlVqaFB3YjZoeEJYZVZmVUFOSFhTSXV2bEFwbTQyVURSYmRQWk1NUE16?=
 =?utf-8?B?L0U2NGtFeEVSZHVkd1l6ZVZQdEQwOVU1VDJZYzVsaGhBbzkzbURDbnAzR1hL?=
 =?utf-8?B?dUkrUTVNMi9oeFVwR2NNSm9pbkNCTkJzSzhNUUNIQzhNcTA5dERkTm1FU203?=
 =?utf-8?B?d0c4RUI2OHhUWHdtU0xqNlFFdVovb2tPbEpyNk1RbHN0dXZKYTMvOVdFNFND?=
 =?utf-8?B?Q0xEemRuOGh0R0lIN1IzOVlpQmV6Yk9tTVpkRFI2QUZ0WmdMd3FHK3J5Q2w3?=
 =?utf-8?B?STI2cGdWaDFGdnpCalExai9xbEpSMFZuQ2g2cWZXNi90VjdndWhEUjFaR3NS?=
 =?utf-8?B?YStqMEpXMDd4TWpjdTRGL0hFVHp1MWlEakxaWVQ0eDUreWI4MFJmQW41Z25r?=
 =?utf-8?B?VEF5UGR5WUtlVGhSSTZLd1p6NlA4ak5FMG9pUlQyYUs5WVUzV0ROSkVnZ0sz?=
 =?utf-8?B?SW5EVkxJQTQrRE9GUDRxVWtZMUlJNk9DQmtGMTJ2UzlaTlkwdGRTMVBsYXpC?=
 =?utf-8?B?R3NDTnExM3A1TDFEbHJDTjZDZWlLOUJqZ3dEVkREMXY3NkR0bGNpeVlkSmRz?=
 =?utf-8?B?Vnp2Q3JkS0NUWFBrTU51cG8wZXlUZ2JTekJkK3BaZ3lTMWxMc0JkZ3FzbG05?=
 =?utf-8?B?NzVZMGV4a3dqRFdRQmsybUI4WmtOQklyeXBmeGpMQllDRHZmRWNaOEViMEdu?=
 =?utf-8?B?cTcwaHpqZmNhcHhxT0MySmtIR21lV3lCN1k2dEw5ZERxb1A4N3djTEZJMlhU?=
 =?utf-8?B?SHZ1K0tXMXM5c1dNbHNsdzBlZ1U3MVZvQ3IwaGhtZSt6ZGNqL1RHdjBDdTc5?=
 =?utf-8?B?ZTBBeE5NQjBvNW1tL0hVc3ljOGZ5SFFzMGk4Q1JrY1N6QTlhSnkwWkhSeVRk?=
 =?utf-8?B?ZDdIWkNQNkNtdXlhZHJOeVYzSFJnZXNERXNNRXcwbkdUaTEyQUpmNk4vK3FC?=
 =?utf-8?B?ZWJDRXNDTnJEaVNWVUE0U0pJb0hZc1pkeXZyWWJwU01TM3gyZ1FveWZEbS9F?=
 =?utf-8?B?N3JBSmpObldWeDc3QnQxL0VjWnRWaC8zdms0cmZwS1lKOVVUYWxkK2YzQkZV?=
 =?utf-8?B?VDF0bGJHakhFbnpMVHpGaVp1WStHdEs5eEsxVG9YcmV2aTVJY20yWEZ1dGUr?=
 =?utf-8?B?QUJ0NnJ6ZlhhV0I0TmxlWnpzTW9jV29PNjlaWWxrMDhEbUN5TWdRY29JbmZv?=
 =?utf-8?B?Zyt4M0luUFhhVUtnalZHYXhUeEFwTEt5Q2ZtNzJYN3pwWmt1eEFQQWdWUXgy?=
 =?utf-8?B?aW5IektSb1N6SEFIMzUxeUFkSlRTdk9ycFh1YVg1azNvL3VabXFERUxVZkhw?=
 =?utf-8?B?c1hWR3grR2R2VkVZTnVudGJXMVc0eWpWZ3JSVTAzeGw0YjlPMGZWQkYyRE5k?=
 =?utf-8?B?R25oMEtPTEYvUlR4ODJMTXFrL3RuckpZM1JuWjdpdkhqMWNCR1ZLbEpNZlhN?=
 =?utf-8?B?eFhyNmZtWDVMcVY3c0FoOTdWZXpFQ1dra2JHRGp2amVnZnBNMGcyK2NoZEhi?=
 =?utf-8?B?Z1dnbUwxcWdHYVhhUTBObStQQnk1Z2VGbXBWK2RGVXdxQVdpaTFMTHA5azB2?=
 =?utf-8?B?QmRtUlVaVXVIYW5lSi92U3czdVh5UzlNZ1BKdHl0bDZmR1J4QUZMYmVESHZD?=
 =?utf-8?B?WkxycDJpQkdyNS9Yc3dtY1h5b2xRZVVyWmc3S0p5UjVYNGR3S3dTdVJhWEQ3?=
 =?utf-8?B?MDNzZ2kzcUx1NlNyeFdKS01xZXlaVUs1RXRRalJHeU43Vm5xdUYydWFiU0M4?=
 =?utf-8?B?K2pTUXFPWTdMMzFEd1djanBveXNwcVdRUlNkV3JHZndzNHk0cnpDZmkyT0pw?=
 =?utf-8?B?U2RQM1cvUE9oL1FzYkh3L2dUTUZCeHlEYlRjQndLR0xTUjd1SEI0SGNJYk41?=
 =?utf-8?B?WGdaMUszZHVnb2hFSmtNMUJaNFczUk1CQlRIYzkvM3VPektmd0JRNDJJU09X?=
 =?utf-8?B?QytsTlp6SEdURWpTUG5iVk5GTnU1ZVIxVDJaa3l3Y3RNMlh1NGJ4Z0pHZXpN?=
 =?utf-8?Q?Ox8w=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:43:09.6067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbd9a83-4aa9-4896-a953-08de188bcfaa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465

Hi Paresh Bhagat,

On Wed, 29 Oct 2025 08:51:44 +0530, Paresh Bhagat wrote:
> Since only a single flash device is connected to ospi0 retain only the
> OSPI0_CSn0 pin configuration and remove the unused CSn1-CSn3 pins from
> the default pinctrl. This simplifies the ospi0 pin configuration without
> affecting functionality.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62d2-evm: Remove unused ospi0 chip select pins
      commit: da84d094ded6e332c88c67218faabfbf8d3d59e5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


