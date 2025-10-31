Return-Path: <linux-kernel+bounces-880381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D4C25A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BE71A65216
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADF34C9BF;
	Fri, 31 Oct 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZPCFVcp8"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3934C982;
	Fri, 31 Oct 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921778; cv=fail; b=pdCiKqE7mxgDPmmdr53ojNzW4XC725G7+ouTHWEjLyGipkx2aRQI7hBVolO2EgP65uW+lBNOgCtYzgKbVw6RV402kNpvt3IlIfQbnyL1UUtdvUFN8g4gEGmcXHG1fPtHp5RTHR8ry5LY3sqXoRzTFaJlOJIQ4Pv5EgA81je3SBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921778; c=relaxed/simple;
	bh=vnQXiL0jK0pvirRFRba6ELrQ4TPHECQkYidC98sHhIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbFqkGF2mBxNvAj0SQxtKQhpuG8HBeMOEPJpR8skUY6162yGcRl0e0nJ3jTwwHzoweSUd08JrVUmEPiK5YCUpcs64jGHEY7PqGdDjQmZEcf7VtFVQWdZmPrFRwaCpIclpdkFtl3VjvdC69XV9+BcF0l6Xy/Ll0HmhMIYgh7ObTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZPCFVcp8; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiUtoJSTnoaLNK/dJVhHjFG+JzlLYcE64R5+OkHIt+NUf7AD1WJhK1piEcjqPFyORmaw8fn52GDxrCPg9TNVoIYJzZ5sQY6KrQSZemNYaZ8jI9TfnwCrQv8TF28KyGV9KTnyOyqA61Xkw408FwCHbGAXAMtGBcUGYumT6zLWaCnWVb1m7YWbHmA2/0A0dU44KNek0eV0o46x/oqB/x7ckE81buMf5feRHm5zluM6g/X/atsiKR+zgrkJqvdFwHB3zprbuEtaIMlScnIX0sNWqe8AyEitFriHie3KLnEEgrviKCr5wkW0tjmOWe5dCOLFtKO3QQvmnNx24qTAOf4Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csmx5SMDLLlNrmYWFllgKqVZ7T6KuRkk9eFLswmWBU0=;
 b=K5GWrAKkyRIk+BehXPKlecJ7rHgZxflyRcY7qpSZ5wQQibS45I4G4CnSh0LC8rtw5lZDMPl5EkJJCABfrVLXirgcovmJu2ahUO/le4/X5DWthL/BvIDmBFqxKCegm8KW0e5evqFwopY3wKmKeTd9gxhBKc7VlNknn0t6Lyh0PaSHXwEAl5EeK4qL5b11TTPVxo6BP2Ge5J9+0xjLUc09YxJzdIxyekM0i+jDtskvD+NVjuiAWUsY3XZwBMe4qYUMmilZ1uZIwx9Q6PAESIxLShsKe/+c2JcDy15TfDwOp5GRL9J23FU0ZaEtgW2bnpT6JIpLeSwls0jKXf7N43iuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csmx5SMDLLlNrmYWFllgKqVZ7T6KuRkk9eFLswmWBU0=;
 b=ZPCFVcp83cOMGRGKvCIBzvcYkKkVGZHk942wDjxoUdYI/PNSzNMHLxjjD99bZB7AiMf6y7Fr/zR+3kummR/CgT8PuDRhYNJu4e70BLZIAmvoUPUoubhDZH59VIe+Hyo0Y9wQkrbuMZf+FPZnqp/WHledD3G6IrcgN4Qp/jy1Zp0=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Fri, 31 Oct 2025 14:42:50 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::10) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 14:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:42:49 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:49 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:42:49 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEgf5W4024498;
	Fri, 31 Oct 2025 09:42:46 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Dominik Haller <d.haller@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <upstream@lists.phytec.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-phycore-som: Add pmic label
Date: Fri, 31 Oct 2025 20:10:54 +0530
Message-ID: <176192142808.427883.13302707913583517689.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251014002240.85045-1-d.haller@phytec.de>
References: <20251014002240.85045-1-d.haller@phytec.de>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9020e109-09be-4b1f-b735-08de188bc3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEtlWmNDSklsMHJsYUdjL2JsZHZCUUo2TU1IcjlPUXBrUDV5T2t5aFpIOVJQ?=
 =?utf-8?B?VVpZQmo3eFEveDY5MGIrb3cyaWNITFhhWFhnNC9PYlNnQ0Uya04zcG05RndM?=
 =?utf-8?B?ZUp0YkxjWk42Ym5uMU9tZDNWTlpwVVR3WjdMQ3VBWnhjWjR4Z0RZTnNPK2Zu?=
 =?utf-8?B?S1VablJ3dFQ4U2cvNS9TRFJhRU5lZVdEelpJQWhBa1VBNDZNekNKR3lyeTNr?=
 =?utf-8?B?ZFY4c3NTemI5QnhhV0Q2QmJsS3NTKy9BUFlNTStQdXlIQm00czcvQmNtZUJx?=
 =?utf-8?B?MFJVK3BHOStWUTFMVzJMdGZ4R0lKUy9ZT0xhbXpKRlhhWVgvcVdtS2F6MDMz?=
 =?utf-8?B?M0o5WkNlcEwrY2ZBNG9WQmMyVzN2K3JZTjhpUldNQStwb1M3Q1JYc2xxT0hB?=
 =?utf-8?B?YVUvNnZ2S1ZEZDNEeDIzNWR0eG9MK0dodjNVV1RMdmE0ZWM4MzZ3KzFWSjNH?=
 =?utf-8?B?b1cwUy9OeUVJYi9WaUNnaGVvemNLdTN5b09SY3pWTkJNZDhYQXhmdVV4b3hl?=
 =?utf-8?B?anVVcHRDMlp2MDVUM0hpVU1wdkZMMEgvQTlvaEVtUkZDeThhYXBITTloeTV5?=
 =?utf-8?B?Q0g0b3RCcWZqdEhsQVlMZU1RWDlzajl1RVNxVzVnbUVYTTdSV1hTRDE2R0c3?=
 =?utf-8?B?OVBFU21NK2poQkV4YS9BSVNqNEx2SmhtSnUwZm5FeGFWZDhtR25OaTUwc05s?=
 =?utf-8?B?ZmNTK2FXSnNLTHcrVnNsRVZLYnhaeThhejNBcXA0TmFBYnprSlo1REwxbENn?=
 =?utf-8?B?RExmVEl6dStOaUpDemFxeldQcHNCQjFYUU1mTU9sVlh2R1FoZnpCNjgyaVF3?=
 =?utf-8?B?QW1raHN4RTB6NWNpRlB6OXp3N0hIQTlCRDU3Z0trRDBmWUVtelo5SElyUVh2?=
 =?utf-8?B?QjJsNmlaSkJRWlJBck9Xb0hHL0IxTTZ2Z0NEYkVjWkVsU0JuV1p2Z2tNUlE5?=
 =?utf-8?B?bmIvZjJEKzF3bmxvQ2VlVTNadVA2N09rRE80NFY2M25tN3lKajJwWEJnaUt6?=
 =?utf-8?B?Y0xYVDZJSE14eGoxVzZ5WktXSFlXQUp2WTdRN2VUUi96bFhxL2VoQjFRbmhs?=
 =?utf-8?B?ek90WGp0NDVnbTlIcEFsWjBzSlUxSml0M21xNDVtS1dWTWxvWlRGaWVyYUZC?=
 =?utf-8?B?NHNmMitBVDJ2MmdzM0o3OVhvV1IvOUNoVVZHUWxzTUI3Zkp5OTNXYVNpeVI5?=
 =?utf-8?B?MFVHejFTRzduSlBSR2hYSFgyQkp3a2FONFZiUFIvL1Q4SHU1MFc3OGluMW50?=
 =?utf-8?B?ZENFb0VwYU5qMmNTYTl6Ujd0bmw2WWhTc3dmSko5SmM4UUJQRzQ0QmVPVVdB?=
 =?utf-8?B?YUFubDk5aWFXaUJ6MG9QUjhUMjZ2K1NqcXUxRmpzeEtMZktDUmRXT0JxKzNO?=
 =?utf-8?B?Rm5FSUxsT25rV1liRUg0UENsTTA2Tk9wei93K1gwWnFJdkJJSFBiaFVGQjh3?=
 =?utf-8?B?c00yblp2dkVndnF2dkprekNKcWRWTERJMnJPSVRNeUFGZjBQK2VENmd6ajdZ?=
 =?utf-8?B?K0ZOQUZ3Nm9MUlM4ODE5aEYwNStsSVQzM2h2Z3lNNnVpNlJ3WEl5VVdVd1J6?=
 =?utf-8?B?TW5sZll5YjVrTi9BMWtpWEVnSTFmdTVLYlhBNmlhQTdaOFkybS9YSW91ekRk?=
 =?utf-8?B?NVJna1QrUzdHUkxaRjhPbTBXTHhIUTZSRDBtMThBaDRqcWRrVTZDWWpaaDZ5?=
 =?utf-8?B?Q3RjVm41SDZHNDhHUzQ1Y0UrVFRvUmhLQ09EZGhsOGxyd0RIelZoZHJkbzhR?=
 =?utf-8?B?OU55Rk41b1p4SFRNNjczamNSZjNMNlp5S2k1L0VHc3F4dXpUSy8wR3BSMktG?=
 =?utf-8?B?MkgrZ0djVk9QV0g1eXRXcVYvQW5iTEZRU1B2ekZRSmNtWWZVWXlPSGxoSEVY?=
 =?utf-8?B?QTVQMlF6TDh4T1h0UDBObW5aZXZjcHV2ZEwrM0dXekVJNzJGUVY1SDdsczNL?=
 =?utf-8?B?UjcvNTFWV0dkZndic1BvNDg0RFVOd3ZYMHFlN3ZNUEQyNFpjNXVYZ1BUSXpJ?=
 =?utf-8?B?by8wdGFuSXloajdkVjdjcW9yWWg2dXRVanhyTzlFOGtaWHR5eGhMNmhyWVFu?=
 =?utf-8?B?T1NZblpvNVVPaGJPTWNJV21wOERZMTZIVG55UHJJRHdnZHN4b1RjUzU5VW9s?=
 =?utf-8?Q?+ICI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:42:49.6954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9020e109-09be-4b1f-b735-08de188bc3ce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917

Hi Dominik Haller,

On Mon, 13 Oct 2025 17:22:40 -0700, Dominik Haller wrote:
> Add a label to the pmic node which is necessary to configure the pmic
> esm in the spl devicetree.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am68-phycore-som: Add pmic label
      commit: 33a2c98caba8a45d2da0c7678f14b036b5d8d750

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


