Return-Path: <linux-kernel+bounces-880389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F05C25A55
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6893E42389C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B434D4DB;
	Fri, 31 Oct 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R2ec9n9+"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012014.outbound.protection.outlook.com [52.102.136.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D034EEF3;
	Fri, 31 Oct 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921810; cv=fail; b=J7Mjp+7CQeChvYOU2+eQTCF5r5z+u7cKJ/r+Y2WmT6qHOrKREiXWMatdNQr6NlwMSwW71ziVccCotJvJOMHkzTAxb2mTMvvi8ktrxiQ2Vyb0HqUv5r9/8chwu0yjmQ7aas8Yyfl08JJvSn2GAazolTNL0jSo14NSDhoX4MbHRIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921810; c=relaxed/simple;
	bh=y0iUpJwX090HduBWuBTQAsLAEZcLykawL4JRwdEpbOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsvyib4ja5ueZLQZ0KpD9TRcCB7VzokoV9cyOqupwvStkEAX0UG4yRBJJdbNrnN1VdIVzop89qDn/X2yIoyoCvoRp0VzxL/Ktfv/MJ+/ttEoe0G/6RaqvjgSEd60ZRoI7xn5xMsZQS0kthMsHei+ReY1jlaLpkzAyYIBPM+Eesg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R2ec9n9+; arc=fail smtp.client-ip=52.102.136.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcLj1fAil0NqrY4+0RYZCdxY3QYgBJWEBWgSLjihDGt76QBDxrcKAtsgaZ7IIBlmW0pd97qM0aMuzimCYk8R0Zt598PagpLHlmHz//NS2KOEq29J6XpOExlLUaxcmjrIwz5R8KDGd7dsGmPkAEF3teAxer2+6Vbi+BwyhV1KbMajvZ3FBLCJHiCbLvfLYknhn63D6eE6Da7PN71iD8VM72l3P5b5J2E69C007GndyJkX2jxmm0FwHSy0qjbbJ6IJdHmx3JxiKzJ/lp/7qY7utNH4UuNey9ErXXhJjSKHuYCg2SXc21vwBsTGidj+TqmEL/oHyvNup7rhj0RrFkyINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkVi1XJLrnKEBuqvjZ9+PabCPbBs1GKWW2AZKsCiY2U=;
 b=YUTNHEvuqDWl3Mlqd63M+nA9yNiFDm9U/csY1ZzCizbKR261DmHPK8FuEwvUCBA5Zt/iyru1g++y+jKS2Afq8e4vaeo+6Mr7j6RZcrTMdoJESzK967JWxxcdWqQ0OsFU1wSFxjLNO1RVBTAjppvPOeWzPRIlpcUzXeXReHsEnnwWdvZY2smN/Xpd5OvDwujp/f202yrDNvF1vQmu+g4dn4tGE575jEiYKH9hg87nf3RuPHikjWsuTqpY5pSMKGxwX2tZykZmAx2QaeBgCNS+z9XDE5S5c6bHT7jIBdBK4PMCnyzn/BSuB/OUtQDJoJmxyiGyGI/JUHTc46ydtrAOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkVi1XJLrnKEBuqvjZ9+PabCPbBs1GKWW2AZKsCiY2U=;
 b=R2ec9n9+xIr/EpJijs97fL7PPNwbIige+A85FYFGPpN/lKlZfpACylYHinMY8dfvPmrvhYUT93PT3tc7x84BfVB2s4HARhhl8/pa8YkxQ4EuhRX9iSxnbN+mQpGZSoDCIrSd12oHCOQPOQnwCRQMJ8WSycK337K619tmNiGeQoA=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by MN2PR10MB4254.namprd10.prod.outlook.com (2603:10b6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 14:43:25 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::27) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Fri,
 31 Oct 2025 14:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:43:24 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:43:21 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:43:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:43:21 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEgf5e4024498;
	Fri, 31 Oct 2025 09:43:18 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Stefano
 Radaelli" <stefano.radaelli21@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/3] arm64: dts: ti: Refactor and alignment of VAR-SOM-AM62P
Date: Fri, 31 Oct 2025 20:11:02 +0530
Message-ID: <176192142806.427883.3758940649937563092.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
References: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MN2PR10MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2467af20-0fbb-468c-a5c9-08de188bd8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRGTkc0NHN0dHArQnpoSXAydlFuOEdhVnUvTTVZRXkrc0FTQ2g0MS94TnpK?=
 =?utf-8?B?bHJ3NDZ5ZXkweURGR0Z3bjE4VmZHV05VUlFiNkFkYXV5YW1DbjZPR3FISmhj?=
 =?utf-8?B?S3djQ1FiOWdib3NVTzRIeGRLS0Z0emI3c0FXemRRMkZMUi9IaEI1TG5hT1F4?=
 =?utf-8?B?MUthTlEvUGt4UjVyS1B6d0dwVWtVOTc4YkFlVFdwUDB0SHE5UUFpdEE1S0JD?=
 =?utf-8?B?RTV0cE9MNmY2bnpaNTllbkhkRVF4Y3dDVlFMUHVRK2FNNmkyK1VhZkRvV0Iw?=
 =?utf-8?B?cndKKzEzc0pUMi9kQ094L1RCdGdtc0ZscDE4c3k2VVg1ai9pOE1pODJFTGpn?=
 =?utf-8?B?eG5mK09YZ3lreFVnczNEN1JHcDlXTnNDU2NrbFZWeGMwVGtJWUlJUVZvdjVL?=
 =?utf-8?B?RG4ra1gvNHk2NXRUemErQzAwR1hDdWNDN3BqdEVBcFlpcUh5SDlnL09xVER6?=
 =?utf-8?B?Wm5SL0k4NU8wQ1FiSkdDV2lnYUl2YmJsR09KaGFqVUpjZ1JXQlU1cEhCd0Nx?=
 =?utf-8?B?L1ZYZU85N2RoSVBGQm5QVnZaSFNlVWVOVzZFZ1FRUXlhVXdJejFoWnBjZWlp?=
 =?utf-8?B?dHJHUEVlek9uZkNqWVQwUk1MU0V5UVcxcmJTeG1yKzY0Qmd4UGtOVWxZR0xJ?=
 =?utf-8?B?cXVxUFJOaTIxc1NxZExpYWY1WVZZNFd2UzA3Q0NveExzK0VLWGNVMXluWU54?=
 =?utf-8?B?dGxGOGxkMWJiV3o3VkRXcnVkbUZCVk9JOWNxZHlIb2JiZXFoY2Nsclc4SHVw?=
 =?utf-8?B?Rm5uUEdQczVxZ3NOQk0xTi9GZVB4OW83MDU4YnAxN3FGMk14WFFhY3JXNTVX?=
 =?utf-8?B?RTNna2JlYXpTWSs3bGJyd2RkcUR1bVkya01XK2cyNzFaVjBDZ2NnUFZUSkxJ?=
 =?utf-8?B?YTRTS3BPL3JhdFkzaXNkOTJoL2dFRmdVVVd3eTAvTGVGcW5wRkFWSlFHWisx?=
 =?utf-8?B?ZE54NzRzT2c5MHVnR2tWS3RjR2JTc1hPcDNTTU5hYmRGZ0JCMXN5U1dzVnRX?=
 =?utf-8?B?N2xVdlhiVk4xaDRreXFvTC9sdEJWTVBUWFVadzhtYWRZLzR0OGQ0VC9UU05k?=
 =?utf-8?B?OEFUNUQzZk9lOWQzT1J1VDNXSXdodnpKL1R1alJ3Tm0zY0I0RS9YL29NUGlZ?=
 =?utf-8?B?QW9lckQzYittbGFDU0VlVS9QeHNvZEUxdVBkQlo5ZU9PeExKM0VNTzF3VFp1?=
 =?utf-8?B?VWVTcE5NOUJaRCtBaUIwRkFnZGtjeU9yOUFQZkRGVS9yYjNKTVIwVmt5TG1Y?=
 =?utf-8?B?Q0xFT29TMTRVQlFiYjlXMHMzZDFvcXZjanR1cGgzMW9pOTZnUHVpMmprWVgr?=
 =?utf-8?B?UGFpelFFQ3ZBZGFONUp0VmQzZWhCRDJDMi9LMWtuS3FaeG10by84M1hQSm9V?=
 =?utf-8?B?UUdJOE9rUG55alA1TVpOR2tLeDJTcFZXVHBEKzJEVFhudHNQdFc0dENoSlZH?=
 =?utf-8?B?SUJEWTJCT28wTVZwYXRrV2tqbDc2UGJSWmdHd25XUFlDRm5IRUF0R3BKQVla?=
 =?utf-8?B?eHIyOFo2MDB2V0lUYUd3SUdTc1htM3VOd212TFFhMUpwQU0xcTYxRXpTWE84?=
 =?utf-8?B?TU1qWXJ0OEVTWFZFTXY5TmJCV3BoaHpsWmFHVmp1VTJpb3UxQnh0eUdhSXpi?=
 =?utf-8?B?Ni9JZjg4N1gxQW0zblVNcFJQVUhwamwva09ENGVBaTgrbWhwL3pzTHBFWENE?=
 =?utf-8?B?eTdsVlNyRlRtVEllUkpncEsvSjZka0d2dDJOWnQrZ3FROE4rZm9PYWZXZTF2?=
 =?utf-8?B?YjdjT0I5OW9WbVkxajUwc2cvVkhWaWRxQlA5VXFjcVlsRmtWMjhqRjlSZmVU?=
 =?utf-8?B?NU55M0ZlbDVXQ3RmVTRhY0V4RU8zSGpURzU4WmlXcFNveFcrTUVkZWo0dDQ5?=
 =?utf-8?B?dFZwSmxyQy84L1QxK2tsbHl1R3ZRdUtpSy9MZ3FPVVpvRm9YM1VCR3Bsa292?=
 =?utf-8?B?ZnJCN2Rrb1dqT24wa2puZndEdXNIMHFSZm90REdRMWZGQnRtbGRjQ1E5ejkr?=
 =?utf-8?B?R2hYSmd3ZHZoSEZKTXRZeEQwdkQ3VTFDb1ZLelkvb0ZCTVpEWnpLQ2lIK1lO?=
 =?utf-8?B?QS92dUcwTnZuQUt2bHVFc1JDVkw0RytwNzVZZjdVVjcvNzZ4VWFpdHdHTVNF?=
 =?utf-8?Q?P06Y=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(34020700016)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:43:24.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2467af20-0fbb-468c-a5c9-08de188bd8bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4254

Hi Stefano Radaelli,

On Fri, 03 Oct 2025 14:50:26 +0200, Stefano Radaelli wrote:
> This patch series introduces updates to the VAR-SOM-AM62P device tree:
> 
>  - Patch 1 refactors the IPC configuration to align with upstream changes
>    by including the new common k3-am62p-ti-ipc-firmware.dtsi.
>  - Patch 2 adds support for the WM8904 audio codec, enabling audio
>    playback and capture.
>  - Patch 3 adds support for the ADS7846 touchscreen controller available
>    on the SOM.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/3] arm64: dts: ti: var-som-am62p: Refactor IPC configuration into common dtsi
      commit: 1d10e0e78c2eb91ea62e0a497de1d29f535351f9
[2/3] arm64: dts: ti: var-som-am62p: Add support for WM8904 audio codec
      commit: 6f41007cf80d94b689fe4d7e07535dcd427802e7
[3/3] arm64: dts: ti: var-som-am62p: Add support for ADS7846 touchscreen
      commit: 397dae3cecd7bfa8e77fa18edc38a69b9459811c

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


