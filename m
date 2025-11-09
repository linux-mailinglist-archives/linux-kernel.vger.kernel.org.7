Return-Path: <linux-kernel+bounces-891815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D74E1C43918
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4433B23FC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303A23E320;
	Sun,  9 Nov 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ARLlgwxj"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60343FFD;
	Sun,  9 Nov 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762669375; cv=fail; b=lEB2bdGhgq+h7fkE3ti3zSA6L2TcQ/ZcJDgEgNc87jwAyLf0R/lU50Inui/4m2kxQQGWs+2hJ5DJvDK1Gkc8NAldqWzZBwqlDjn46gJfqavQEEYwHQO/q4782GDoRYaymJwrVmQpisvMLZmVYpHUf8cl+k6KbE2WCMT6TgO7fDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762669375; c=relaxed/simple;
	bh=TCFz6T3nnC+qfcmRayJhwMWfGSZbqeEcdr+mIV8LD6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1dAK1azR6jH2AIwd24nXHAJzjfCW71ONHZ/t1uZKTnd8A9bDvN/HwMSwRdwUg5tOrZcRT+c5dDf7rhSpAW9mSA82lrHe+JueKJL36q5JcYhr6MTwUcCvVh5hTd5xbXUnQh0OtF1+km+giXuRql0aL76xSsRKSLdtgkj1h7MLwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ARLlgwxj; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG/wPTFsNWvb2FlbJ5s4Q8AtKD5kjvIJ+WnmlB7lbgh8P/JjsQe5wfIXO70HRtQkguQMJUTtPuVF3D99vNyQEymFpNYGsS+NlB46wdDpId3cUqsNZG/e4AtIT8+JO430j3/XdKcdcf2e8iAATEcP3Pk6Z5UgEBFCBQAk6SbUhjR3VtvLyACw/Q7H1dbTALPiUUCxQPOE3NWXc9K5BhuruKdQYn0E65h/0zkNNpVII/AxPCj0YONW7AMGdsT8CYhRqKlVxbPWWKl85nWHlhGHMoPruyhJRQthhmwxdF7Xt1qbJvlfgaTAga0W3EsCBBT6Oe8BrxENPjCjIFx9AuOFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0012sGsasUmL9P1egl8RDcfxkHos52GUuEeO56ftgo=;
 b=Lmcd+K9p2wu7F8ZZM/wvFulTN9qMVzFGalPcwUDiwF77LHc+bpC6gM8S0SFSwo4nD8rjC+LKcA6uQ+bkOTOAA3eLYKT7ndjslTbuGqra5bOqcuzv0NrcC4saDQMLBFUBRVaSNsLJrtM6r3UrTtPRE+1OrWAtbXrCje/eWMnydlNpXwJl4AilByjyK1N9ziIalN4+B1gq8I4w6RZWkB2l2PtrBQmutMxGKr9q5e6W0IMwPqork3kM7y6AUMJi5zazks2vwMRf6oCnZb3hktvov9/HnqhEexiXsdgZXU09XwWsgnU6qttvxqqbKiE61Tc0gfD94RQOAoG+/9WSgcZ9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0012sGsasUmL9P1egl8RDcfxkHos52GUuEeO56ftgo=;
 b=ARLlgwxjwTgUvFGb6II/6aZYWGcC5fHPk2GylY5bo7DL6KXcDlYOc6y1HGiv0KpMr+Rktl8FsE+M6lP6NLPe7miZiiphYoAlcqzyTab+emnhwwrF3gJX+q8PDf/hSeq3IvFD6SVn5MCdxGu/TA/tT4HK7ncVaT/p2fsykdmfexY=
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by DS7PR10MB4928.namprd10.prod.outlook.com (2603:10b6:5:3a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Sun, 9 Nov
 2025 06:22:49 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::95) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 06:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 06:22:48 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:22:44 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:22:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 00:22:44 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A96MeLS1442141;
	Sun, 9 Nov 2025 00:22:41 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-tqma64xxl: add boot phase tags
Date: Sun, 9 Nov 2025 11:51:04 +0530
Message-ID: <176266923842.19596.8006988246206191233.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251105141726.39579-1-matthias.schiffer@ew.tq-group.com>
References: <20251105141726.39579-1-matthias.schiffer@ew.tq-group.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DS7PR10MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b627bda-caf6-40e7-1da7-08de1f586793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emp0RjFzN0x5SHBabVljZFV5aXpwTkloT1B1MmdBeVJ0akxMWmtVZjlvd3Q1?=
 =?utf-8?B?aytSa0tIWk1uV2hvNWkrMGowN09mSE01dlV2WEZ4cnBjWUZhNVZ3VklDZ01L?=
 =?utf-8?B?dGFsbm1NRS92Skdoc0k2NGRGWlRoY3E5cGIwQ0IxRGRiQ1RHcE5uKzB3eVdj?=
 =?utf-8?B?Q29JdzZJczBpSzhoRjFhV2haSnRqMGtXcDlud1AyY3hCbHZjcmZ4TlYzZGVI?=
 =?utf-8?B?dFdiNHR2T2s4Vll0bDJuUzBtZ1pYUE13MnJRWjA0bW5tcEQvYU1XaVVvZ2hl?=
 =?utf-8?B?VG1DdndlUm1FMG9rTzcxa0pwRlRaQ3ZPNzArNEhKU2sreURNTHBjVE52cjhM?=
 =?utf-8?B?NTdCdlZQVnFXblAxZUJSUEpaTGdvd01vTkpZcTlRN3drdlN4Z2drUTg5OGlD?=
 =?utf-8?B?TCtwaVI4MzJQMmltVi9QRWswV3AzWVE5eExJSHhsNkZJUmRpMFR1OEs5UWVP?=
 =?utf-8?B?b2Juc1Rhd1JGRmdGR1lNaStsdlVxd0ZKMjhvcU0vRm5mU2RUYURWSkN3ektk?=
 =?utf-8?B?TWlrdjJMQURacE1ZMUM4ZkQwMVpuaFNOS2xETWtzTFpPeGR1TVB3Wk9nOE54?=
 =?utf-8?B?WVVZemd0NGtRaDlwTTdyN1o3VXI2bDJ6dmZZRERmNHZMaVlFMDZyQitNZWtx?=
 =?utf-8?B?SW5zQUdFNU4yRkFPTXUrN2dlUnBKc3dhQklkbEtidGJyeExTVjJGZ1ZTYXlp?=
 =?utf-8?B?L21GUzZXd1NRcEVTeUNuMnhHcFFsejVPNE8zaS8zWEVkc2ZTNUVFMkk4eXhB?=
 =?utf-8?B?eTRNVU82STlNeEd6bXF0aCtFY25aajE2Sy9rRjV4WC9uSkRCVS8wMXhPTlUz?=
 =?utf-8?B?S3VrQjQwSHpsbDYxeVdHZFdNZ1ovcUt1cTBXRVdoNjJJZi9CRnhBTWdkLzJs?=
 =?utf-8?B?SEdXNzdkR24wOGRjVjFSd2I2UURJSnYzaGl1MWZGVmVvMmMrbzk2bUp4YVVa?=
 =?utf-8?B?aUVBQTlvMkh5WXlPaEpNaDZoWHpvRzA0MlRuRldnbkdBZXh3dzFBdGpDRWpC?=
 =?utf-8?B?YU4rMDVPc2xFS3FtZm53d3U1a0l0bVhpV1FOM3FiVVl3ZVpsajZQam5YSkJU?=
 =?utf-8?B?LzVDOFJRd28xb3hDT3JqT21TOG8va1BoalpKWkVsRlhXbzJ0L01nM2MwV2Iy?=
 =?utf-8?B?NjREblNkMGRocjlITW5MVm5qRGIvc3d0czBxcmFHRkE4UkgrMEoyeGMyZWJW?=
 =?utf-8?B?NzlKdlNzVG01OXJCZ3VZRUxqTzdzYzVoOWJpcDk4OUc5c0Q1Uld0SXA4TS8w?=
 =?utf-8?B?a1NqSUFuYy9kOGZTTUhILzNiWHptb1VLdmRxMk93VTdkc2R2VkRuR1ZabnF6?=
 =?utf-8?B?TVVNNEptWExtQzRnS2FjTHZ0RXAveHl0MTF6elJhNHdlQkYzcCtNQVNKbm9m?=
 =?utf-8?B?NFp1Uy84Wk5Mc3RtSUhhUmFmNW00bTlpT0JvL2ZCTVdkQ2E3Vk52c2J1Vzdz?=
 =?utf-8?B?d3ZSb01EQ0VtRythUUhsMlNFcHdzWFVpLzFJdzFhdEZHMTlVcE0rV1RUNU10?=
 =?utf-8?B?U3VOV2JrdmhpRHRjRFpXeG9xQ0lXM1pGL1ZNVW14QmZtb1BacThONGlpUi9o?=
 =?utf-8?B?K2gyeUJTY3hmNlhHY0xVU005KzAzUWZ4VURZcVpFbUMyRlMvQWVMVjB5T3pD?=
 =?utf-8?B?RUI1dkZ0czhMa3NsQ2gwQm43ZFdVSVB6QVRSVGhuNmNOQWdoWFZRS25hNmZi?=
 =?utf-8?B?YjRDSFE4WkNUendhZjFlUDdBMEFkV25aZ002QmE3Sm9TRWZxVGlHVkpwR2lr?=
 =?utf-8?B?R3liUjdGWjVTK0pDMkMwamdWNUltdmh2VWl4dGc0eDFRZUg3bkJKQkQweTB0?=
 =?utf-8?B?ZkVIRWplSXM2d3BHYlVuK3dURFQvZmQ3RXZkUmpFVExaNU1CQXFPYVYyZkJ2?=
 =?utf-8?B?eUxsWktYa2RSb3pxR3E1ZS9DZm0rVlg5S1o4SGl1WXRIYVpVZTR4S2VtaWxq?=
 =?utf-8?B?b2dTa2dBNGlXK25qVlAzZEMvRHUzTEozNVgyMERGMmlMVnlsSzc5Ym5GcHlB?=
 =?utf-8?B?dS92UDlIb1ZZaVY2OUpqNDdMaGNINnZlWjdWZkFzcUp6RmFleHpQS0RyY2Zq?=
 =?utf-8?B?NVdHU3RqZGZZcE1mR2NpZ2tyazJlcUVTb0Z3VzBCNDJPVzNjK3JrK05zRnNH?=
 =?utf-8?Q?GVRA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 06:22:48.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b627bda-caf6-40e7-1da7-08de1f586793
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4928

Hi Matthias Schiffer,

On Wed, 05 Nov 2025 15:17:26 +0100, Matthias Schiffer wrote:
> Similar to other AM64x-based boards, add boot phase tags to make the
> Device Trees usable for firmware/bootloaders without modification.
> 
> Supported boot devices are eMMC/SD card, SPI-NOR and USB (both mass
> storage and DFU). The I2C EEPROM is included to allow the firmware to
> select the correct RAM configuration for different TQMa64xxL variants.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-tqma64xxl: add boot phase tags
      commit: c9836bf7c38f70623b2369b361d716b26b50f67c

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


