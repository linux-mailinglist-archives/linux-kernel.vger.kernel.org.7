Return-Path: <linux-kernel+bounces-883197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9EC2CB91
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E499B4EC0E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E23161B3;
	Mon,  3 Nov 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FFyjAPHg"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844E30F535
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182889; cv=fail; b=OB+u7ftuGyMTqan8d8FUhw50EPMHjLxCcfCcc8/p38hERS9F/nlTSt0mBzG7Qt+ebQEVZUFUzwoc8LLJJ3qcAHs2TAfr4AvKshDEFsWgXdIWRdIhS2vZwj1bcPXhr8d/Vi56/rKWXIgrFy30t4PYHj31ifWpJQDvrUYHaOuU7T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182889; c=relaxed/simple;
	bh=Aj9UNDFSzoBWs/46KdvwUdO4aLN02AAwOb3LnUE247I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5POrlEnWHgN5rVwDrYY6jWP8GJ7/Swn6DEPoPigRe3KDnTMsf29WySjVH0s6xGYN+qJqPwlheDcVKJksAKarEgZ+3KNyLNtcUADp4Zeh5qUn2HApjbC+bXmp/moo2bwon2ihVm3GWxvx7w7AjUaCvXU3//OzQ995TmckECf++c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FFyjAPHg; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6NHQ3toqabVpE6iHI6aQhU3oj3zlnBgViHHdR+ELcR1aTpMU5LJ8Blc4YrTHfccIJDSo0J4Dk3z2BQWgho7lOsnKoqw8pDt8gKircow2gaaYyX48lC1Mly4Y4z66NFukHZQitSJ5QIUvb7JrkjwTcQos53uq9AhvdDh+kpbUC1Sjm39HXCQThQLKUVZa4rUGwnm9Et5PT6Bx16Q0RvtLrEnjTXJ5mT+dzIBDio0ClZ7UrHCmvWRkbc5W0tU8/G75+f6puzehM0vyDOCVPddsntVWUeqiOulqXFXqwQyfNwyv23khjpiqKO+IeCWufsNpeQGgBpQbfnJ+QmkNP03YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaHxGyfUWRtYWRrAwbzqN5Os+W1zyD3kh/kOvOTAJc0=;
 b=yzgnvq4d6Muq6yZaLzY1h96jxJZmx4sNdsna9FJfkMFgy+O3YVPOPzhwQJY585BF7s6o5vDRz4xci+zGeu3YwxzB3ewOtKEbUoRfU5S+gwASaPn2iqFs0z8LTgXOlJkEiKdeVUvKCf6AvZBZlyVLCZmlOqILgVM+JN1vG3QEgE/CwCYKPAtW6mYiKd1X258NjeLGjX6lWPzWB4/TkUe4Z3KmaeGSlo6pF6nfFaBsauPG7+HstHDELXcOi4bAD6b17+kmFZ1YxWdu4/EjkbgBZHIVkK3i9yjJNVPYtqfsVJ4rCQ0DJ1wcKb53lR8lV7lQmbP1Clhtz26dTurlf7wFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaHxGyfUWRtYWRrAwbzqN5Os+W1zyD3kh/kOvOTAJc0=;
 b=FFyjAPHg1ccQVatl+WoEuAwKl8d9sqNaF/0PiMrtZtV15CVw2hzYjLscsp1lFPj6CuV6dA9kWtnzbuD0fMUZQnZdLpADm95Gi5IgJzHbuiBRv4R7lmeJbDcnxaOVSBnc4491AFu6+Tl7hNZocdKI7lcCmN7Vs8URn/yx2A0mV+M=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:14:43 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::74) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 15:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 15:14:43 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:14:39 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:14:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 09:14:39 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3FEdkK324832;
	Mon, 3 Nov 2025 09:14:39 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	"Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
CC: Nishanth Menon <nm@ti.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Gregory CLEMENT
	<gregory.clement@bootlin.com>, Richard Genoud <richard.genoud@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>, "Abhash
 Kumar" <a-kumar2@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: replace ifdeffery by pm_sleep_ptr() macro
Date: Mon, 3 Nov 2025 09:14:33 -0600
Message-ID: <176218286915.3559215.8776729657431757097.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251014-ti-sci-pm-ops-cleanup-v1-1-70b50b73ac85@bootlin.com>
References: <20251014-ti-sci-pm-ops-cleanup-v1-1-70b50b73ac85@bootlin.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CO6PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: bf94d23c-a955-439c-ead9-08de1aebb79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZOcE1KK0RCNmxOeVBFKzZ3Y2FDUUc4Y3plN0gvRUcyeHpDQjduN3JYZ3Ir?=
 =?utf-8?B?OHlyWGlZK1lxcFp2UlBVWkYzdTRPWFVySkRiUzhTTUJsL0NoZHZkQ1dRbnhi?=
 =?utf-8?B?V2J3U2FNL3dxbm5XbHlBempDdVlLa0FwdnVramVqWjFXaTd2WThyQlc3WUg2?=
 =?utf-8?B?cGhEMm5HdE9jcEV3Z2IrTmIyQnFTZVpGaThUZkRYd05TaFpNelN6ZGtPdlBG?=
 =?utf-8?B?d2RnS2J1L1ZYUFE0OWtVVjhmK1BONDZYaGxoRkRGVjg5N216ZDNTTmVIaXhy?=
 =?utf-8?B?NjN3MlVTVE50ak43QytXb3JSdzd3ZjNqS3E5VkFaRHpGb0NrKzVpbmpMdU0v?=
 =?utf-8?B?dnJFT3haQW9wQ3FoK1ZBY1JsMG5idU1nZm00NktvZ1NKMU81cGpJenVlRHN0?=
 =?utf-8?B?ZU5tTmVPL2tyMmEwbmdqWE5sc01LTndReU1CZ2tuTmZ3Q1RXNjFIakVFRFFJ?=
 =?utf-8?B?bDRYRE4xTU84L2c0L2x4dWdOMUJvRzdibGtTaElYTTdUQUhMT1J0a2xVTjUx?=
 =?utf-8?B?TFcrbjBNSE80QUxpL3NValg1a1p6Wm5RT0piSklsek0rYVByNHFuU3FvRm5O?=
 =?utf-8?B?RFZ5Y20ybTEycE1UcU9Zbjk4dmpzcklnelRHMUtYVTZJNkppekpadlp5WWFn?=
 =?utf-8?B?eEJjbDdNRWJpb1ZiVStqNmZDZi9Zb3ZvbGFySzlWak5lSTZXSC9Qb2dZenhZ?=
 =?utf-8?B?ZEh0L2tNTURhUW5jVElWUEFSMnRMWWZlSHh6d0FtZ1h0T3ZjcTRpTTkrdnZk?=
 =?utf-8?B?enNJcFNXcy8yWFpNV0lKeTVZeWpUdldtbXR6L1M5SEtwSzR1WTZKMjVlaTFy?=
 =?utf-8?B?c2haTHVDdHBINGhkUEZuUWxsMHNyUTRhYzdRdFFZTjRmUXkvWXNOdjRMQ1hQ?=
 =?utf-8?B?d0lQQSttN0tzT1MrWU51bkxnS0U3RjlLRGp6R1Z2VjdPcmZHM3FNa3Y5Y0RC?=
 =?utf-8?B?QXBvY2N5dkxwRDJwVFZrQTZZUjQ0OG5TR0xOeExxcWVhWFlnWUtsd0RLUVFN?=
 =?utf-8?B?ZlFDcEQrbnp5bDNmQWxsZ2J5dmZYTFlwNHpyaW50Y2dmRHRhaVhOaHlPa0tM?=
 =?utf-8?B?VWdTOFAybG8waTJhcXF2OEVlRHBGMjNaVnVaQlFndVRsVnllTnVmeTk2TTZI?=
 =?utf-8?B?enArbkpRUUV5YUtEcXk4M0JhQ1BOVmc0YURSWnAwemZXWDlmczMwWlFhWlNT?=
 =?utf-8?B?MnJHeVQ0QVIyNHdRZ0JEU3gvanhxcTlUUGh0UUdQVGpaM0F0bzRqdTh1ajd1?=
 =?utf-8?B?RUtOZWQybUdqS0p1Z3JMakhpalBlYy9Rc0w2S1p5Mm8zS3FEUDM2WWM2eWhx?=
 =?utf-8?B?UTh2M0FvK05sTys3SmY3dG5xeEJDeEVEejNCU0NuK25XY2pSSlhkaU1JVDZa?=
 =?utf-8?B?OHpHNmpTa2pYZ3ZmZFphYThwOVgxWFlsVEtnc1IzOG9yekswY1Zmd2ZDSEhU?=
 =?utf-8?B?aUx6WHVwUzZrMXBucEdIamFuRjcwd1RiMENMdnNKck5WYmNxaWNsb2JBdXQ0?=
 =?utf-8?B?azF2aGZTZktiQUNEYitld0dJRFR4dEp4VFNtWUhtamdpak1vVW1WYWxiK0VB?=
 =?utf-8?B?aUNYcFBTR0JxMzVTZ0xTRXVPZzBDZGU0UDRQMzZNQm1MVFZIdW1Yd3ZDNkNv?=
 =?utf-8?B?eUxubjZvRUpRQkdZQ2JRSWZkQmNXVERUSVJPQTZYdWEyazNwd3lMLzNwQnZk?=
 =?utf-8?B?Q1lBVnlLSldQSVpxVGE0cXhyVWdMZGQrS3RGMkN6Yjk1U3pKbmJCM2QxYmFv?=
 =?utf-8?B?Zk9jYTY5dWw5a25vWUM3NTZwbVJDRlZtM2x3bi84YTNzMytnWVJpUStVTmxo?=
 =?utf-8?B?Y1VLWWFGenJNZVhsMEVmZk54YWlzcnR5RCtPZGcza2xUZFAzcXo3aWxaMnpD?=
 =?utf-8?B?Y21SVjVXMlhUNG9haXg5N294VTFBbEcvSnd2UnIrekdqZCtzbnFQSWN3MmZo?=
 =?utf-8?B?L0dOdXZJb2xMU2p2UjVGNUF3NW8vdDExdVpRUVc1SFlnOENTd005RVJJMG1r?=
 =?utf-8?B?dmhJV2trZUJQelJvQ1RJWEJKT1ovQXQ4TldhZDJYd0h3UmxxbUxTUHNFMncw?=
 =?utf-8?B?bjdMaFpGamdCblBvZVgxV21lTkFOZjdUNzU4ZFM3NDdWczMzd0xUaFlzdW5n?=
 =?utf-8?Q?hwKA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:14:43.2441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf94d23c-a955-439c-ead9-08de1aebb79a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650

Hi Thomas Richard (TI.com),

On Tue, 14 Oct 2025 10:35:23 +0200, Thomas Richard (TI.com) wrote:
> Using pm_sleep_ptr() macro allows to remove ifdeffery and '__maybe_unused'
> annotations.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: replace ifdeffery by pm_sleep_ptr() macro
      commit: 7a4cd87e76fb4547d7843e3124611bf13004b18b

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


