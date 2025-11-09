Return-Path: <linux-kernel+bounces-891818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF6C4392A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 07:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD88188B0E0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 06:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D374242D9E;
	Sun,  9 Nov 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bl5pwBT/"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1C18A6D4;
	Sun,  9 Nov 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762669438; cv=fail; b=SGkMyuhNPAi0zyoP0t3ASha/sdP0zhlNce0/7ZOjW6G4nG03N/mDVhqkOYtjbxOhThpeO0pm9vh9nUFErYfHLvNgIcT3Rw/QuqHhsUTMaMOwoujQ16z5wCN+IFjHIijempzcMT0o48tzQOheQzUYoPMtDlzDtDjzmujGUSON/No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762669438; c=relaxed/simple;
	bh=WlQBeXmIuFhTGuSy2BVPD9L0NSCyW7H5x18jrVeBxas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5sBy3bzAogopapv7D+mRgDD40U3l8T1UwKzmDoZZI23Es3/45gCLqORENzZ8oadV4QsP0LMrkd87gfZytQbGKftQ5DrXdZq6ag5RViofeh7Md8DBRCd+mI0ZYzygj/885N0ahG9wCMfZCa1xF4GTrddD7wghgUOKvsVyR7AsbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bl5pwBT/; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP0V1teWzGxiCWMw9yr1jTXPPaypYuMAbFzs+k3TdDO3fDxzCDUXmCWWoxGf4geOioammhydtomh0i0vZvrHHQSZUU4VAqItDujxVuNOa/+WUYVMp7CKH7byalOas+K/VAomyWp0kayUXEfgjB9A33lFZL87e+xFMapT65ZwEPA/SpPbes6Pzz8drYz3o+zlnLo2ut2/TUybgluJFm5uhnI437H+8SzEviSPAKqtlwupPwvNP3VbGv04xdyYumo1vLBnd7+rCHXcLayB50sMqzbZn5eNyAgL3tZ8xLUgJR7BPkaLWUAXOVcT/jShkx8Z/mI1KwOS/KPicq+k2CmmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgudAwR5bIKcOAAPo69tM2Y0GUlFpFzOApYXquV1olo=;
 b=kpys5C7iw1XHIjmuHqjPCtz3Nz7EYNGMrfCTWdC9sy0N4e+nhm0xEXnaiCQq7JKS37ibcUZgv1bUdaBI3HlOWVLpK9ApxwgC70v85a2c1j9oeoeQ13ol2RdMKEiVDem457uWOXMW3accJ4lH5BoVNlBYxGkNvAaprIrVmxJ+h9XddbELQakX/AmjPZDDjoFMVZvskdKRPtdqRHU6Vvs0BkkzLoa3jL5q7WazU+sXH03OCwVUiYHXOvWBx4qWgZei+6WUb3+jE3suyMxEDeS4kY+JeEqpm9QOz4RKmgKXKaPZRnPnrZ0bcVF79RaObf0hwicbgkInxOQDuLmSwhxLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgudAwR5bIKcOAAPo69tM2Y0GUlFpFzOApYXquV1olo=;
 b=Bl5pwBT/uBUJ3eQeFi6fr4FAFGdYYUZVjw69RmhuHrzAD16njWgZ6smgL7cjgoglwrv4GHum9/NppoU2P2XI99Gq3mA/MA/Mp8vGRYX9aNryfVpoGnwGAN9XR7BsrKSH/F7APSPcXyGQrRE3tctYHatji1F8zjndgqggYNlHnHQ=
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by MN6PR10MB8070.namprd10.prod.outlook.com (2603:10b6:208:4fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sun, 9 Nov
 2025 06:23:53 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::25) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 06:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 06:23:50 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:23:45 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:23:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 00:23:45 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A96NgeC1442932;
	Sun, 9 Nov 2025 00:23:42 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id for CPSW ports
Date: Sun, 9 Nov 2025 11:52:00 +0530
Message-ID: <176266923843.19596.14963932920480354419.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251025073802.1790437-1-s-vadapalli@ti.com>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN6PR10MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7cb847-4a32-45a0-85eb-08de1f588ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlBZNmNkOTIzZTVGemtLYU5HYlh3Zi9pQ1JTajZaVkNFY2RoSVJ0L0ZxVEdk?=
 =?utf-8?B?VUdBekJNZGZuNjZoUU1FMnJLRjNlTHF4RjRKMVZSeUdITUtiN1JzQXZRbjNG?=
 =?utf-8?B?OTJFaFlFbk8wbHlTdmhEdk5OSzVrWFovNHpmSXVyRStHc1pPZWFTdDd5eVB1?=
 =?utf-8?B?N1FkYTl4cTRpTXNwbUZteUxwQjdrMS9JNTBEK3ZnaEhBNGVDK2JQRkk3emw2?=
 =?utf-8?B?SW5UTDByOTVzMkxUTW9sYUJ4dGFqb2pDTGR6dEdTdml1clJtZjBhWFFIN0tv?=
 =?utf-8?B?bjJUY0FaOEMvYy9yTXlYY25IbnB4Rmt2NG1BM1ZFSFVlRnUrdlFENEEwUWxj?=
 =?utf-8?B?TFZyalU0ZmNzQVBDM1RLcEh3VkljR3BWNjFHTk5rSDhDNkdKQlhqRWxIQVBZ?=
 =?utf-8?B?Z0JZa2E4SDBqbHkvWGM5cmdsMDZFUzdzN1dpV3ZtbXlmSjlrS2hhQURES3pt?=
 =?utf-8?B?NFEwVjFwTTdUb21xUHBaSkFDVFFzbHkveXZEdzlpYzdUZ0NFVXVjU2hrYTI5?=
 =?utf-8?B?TVlYZEN2TzArNytrYmxTanF6SHhLVEU3QkRRbTdvVUp3YzArcHg1RGVpV2dD?=
 =?utf-8?B?cDVBTFNOZFAzTlBZNktHNUZQVU5NcGhnbFhvWkJsZ0M5UE82RlBVejZnaXlS?=
 =?utf-8?B?NlIxUlpqb2ZlOEJ4cUFGUmc2U2xTVGk2S1dNRGc2Z29rRXhwb1pwcytDS0RD?=
 =?utf-8?B?Z0VlYU9kajZ4bTd1TXBmdlUzWFdIUWdVYlZJcUtxc0FXemw5d1g3aWlMci9Z?=
 =?utf-8?B?SEJpamIvcU5tTDdFS0NFZkRZM2picS9Uam5JTEtZQjNSOVlFZy9HTVFKTW5l?=
 =?utf-8?B?SHAxVUtiOCtNUExsRnlLZTlieFpqYmgzWlR4cklLQWdTLzFYcHFZY3BzeGtO?=
 =?utf-8?B?QzNsR1lXSWFKdmRkU2pjL3c3eHN4OUtMMmtwZmdjd2tRN3pUV3kyTjFaWnJy?=
 =?utf-8?B?aFhwVDhVekwxQ1hacGh3MWdYbGovMTUwd29sWVlOazFKQU5VbFp6VzFwdU4v?=
 =?utf-8?B?aks4VzQxaURObnRob2xvRWptUGN4YkQ0VU9MUTVFM0lFRXc5Q0VJUjZNWXFw?=
 =?utf-8?B?Uk9oUzRvcy9ZbVE5WFZkYWpPVzNnMStIdWtBMGxZS1k0d0NQMkxZZ1V0MUtQ?=
 =?utf-8?B?V2hBcTVEbzdQdzk2ZWwyYUdaTGFYQkF2MW1sTFFhWkU2RkdXN0tOYVVqeDRM?=
 =?utf-8?B?WG5UQ2FTSGJqbFN2RmRrdXFjalFIeVl2WnZ3bWpJaU03Wk5YdjBsdllycHhk?=
 =?utf-8?B?UGprdmdhbUtHTVVsend6Yk0rZEhkNVg0WjJKSUlqUmFiYUMxS05BZmV0QTF2?=
 =?utf-8?B?R2FiYzB5ZHdSL2VobUFMUFJIT3R4anVJL09ia3pHWDh3OWlSeWcrZ2FYSmNZ?=
 =?utf-8?B?aVRCY2liaFErclkzeDJZOTVpTWRXMFBNblZEMTBEaDJ1dXV0Mmh5NnRkQ2Mw?=
 =?utf-8?B?UzNlWCtOOEJUa0JSZTNERzhOZmV0eHpwUzg4NEZ4dVViTjBBRzRWQjV1REJS?=
 =?utf-8?B?eW5XRnB5TkI0Vm92aXY2b1ZSS2d3bS9FdU1wUlc2cDJjcUhaZDBlWTlNaEp0?=
 =?utf-8?B?NUkxQ2ZKRmNjY0JCRHdqNkRmdzdnQm9KNmxpOENtaUVRVnpuNnhxUjNXUTVO?=
 =?utf-8?B?d091VWRtKzhvVVAxZ1k1Vk1EY2FBVWVXTUMxTmVELzlHekRIMFYyWGNFanND?=
 =?utf-8?B?cGQxanErdFAvN1NWVFhPcE4yQTA2MjZhb1VEenRsazQxdUJTNUNBMlJScW1T?=
 =?utf-8?B?ckRLMVVwSEZVSUw3Y1lmZUNyblFJQzMzRXhjMnl0OC9YSU53a2FBZ0YvcWdH?=
 =?utf-8?B?Wk9IbXNvdHBGdlc4WHljVWdWY29wVnArWmlGbndnbWZPN2hJRjM4MXpaNUcr?=
 =?utf-8?B?ZDJPQ0JaQ3ZNTnU1UUxCbzEzanRSQ21lZ1BFQzRxREplN3V1M3VQMmtRMXZx?=
 =?utf-8?B?RVkwMFduYWx4TWoyNjB2Ung3NGt5dk9oRXVOWmN3UmlZVU0reW92SUFXZ2dv?=
 =?utf-8?B?MUJmWFVFS015S3htampkOE8rWjU0YThzenJjaGhTSGJFKzZzcHlTbkpjU1or?=
 =?utf-8?B?WGxNNk1ma3VhcUZBMHpXUEZzZFd6WFBTRkEzSExwL3FmSGFLTlR5T3R5NFdR?=
 =?utf-8?Q?/YXM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 06:23:50.9911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7cb847-4a32-45a0-85eb-08de1f588ca9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8070

Hi Siddharth Vadapalli,

On Sat, 25 Oct 2025 13:07:59 +0530, Siddharth Vadapalli wrote:
> The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5G and
> CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. This
> correction has been implemented/enforced by the updates to:
> a) Device-Tree binding for CPSW [0]
> b) Driver for CPSW [1]
> c) Driver for CPSW MAC Port's GMII [2]
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id for CPSW ports
      commit: 1446fc4dc0728328904e8cb402f065bcc905bcec

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


