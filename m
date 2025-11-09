Return-Path: <linux-kernel+bounces-891817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD33C43924
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 07:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22048347C4D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 06:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8123EA98;
	Sun,  9 Nov 2025 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f70BPCjf"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECB23C513;
	Sun,  9 Nov 2025 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762669416; cv=fail; b=ABVBXWpXK0rdcmA0EbywHY2MUUuzbgDhp9ZHjaSCkGb5AsKk7GEWpnF9odAEmRV/II9wBNsZ5Dpnp9Kj4axYFqDQmTDVP+70a+UBvI/6dgbpJz6nN61tjeMOlN93HmRgs9bzCMPn0kPMd6oCQgDo5OPdFjLSdQdhtsl9nxyUEss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762669416; c=relaxed/simple;
	bh=GkeYJ3WOapOBoYVqxvTqCPhZuKcFS6VODyZ2oX/IJR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwUtf2DV5lFFW00gaawzXyw1/GUOEXDy88OS0NrVngp8fAywEMMUEfEIw4jMUvAB8imEEvckAq0FZlmwwlMN2Wrao+35x0TMoke177RyH1UXSrV0ZuegPEd4Ww3lvWDHtRNYdp1c05Fug6yYv7km3NPBmFStxsClGnpYA5XM3ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f70BPCjf; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzgvZrGO9HcmKNfRrqHNtnYud+i8I8iGl12wjVEY5aeOvLxz8tErobYCi8se8w8TQDxCx1SZUWqTykbLr9dtzuBFLefQ2vl5EdaZkcapOODYHVDMk4Vr9kl5bW45WpZvYasV0Qv8GoJtD6OjqFtI4bul2nnXzrb1rZpYra4bsoGlLudeev7sho6YMje2JaHIRBOUZvxczUW0Kzy8tGC3nNG0RhQYqYKBt7XZl3M5U2CTzx2hFoJ89jIlAnjGaqr2dsHV/YSTeyeSbzot15zkMS4JPi+kat0SBI5xgD89bs5VxNFjamVLsbifO2+lzVJEaKNkdw+a4TYVMtwH8L2I1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg3lQ+ISK3r0/uXhXuPBoRba2yz2pLOi/RBwZvoBl60=;
 b=cwb3kTWuy4boLTuTAaCU0BmIxzqMB8L1ruQOw/Fs2seTYCBPgle5meO8y18a8yN8s0jH4E/mv3okaoU2NwNNSlA1nzydYiIBos/YDar7TdD5f5uF56Eqq03IpHI+kXow5PEjwOWe2fbZBtwKUDksiecoNdcaE/2GQzyCnPixC6m0wv9zovYkWQN6PPvKYz1Q67OqsY9oDxAG2f9FaYex6ke6tZcoCWEJlMcNVj26j9EaIX0iqCWSME5BvoSsl+8ibi6YJlDPn80+e0ZXjisEleRIi499TgjZHKZD5CsJQJBqAsQRjx1Y1QndPHgKwUHwCNBBTvRtUAyy2T8C+WKAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg3lQ+ISK3r0/uXhXuPBoRba2yz2pLOi/RBwZvoBl60=;
 b=f70BPCjfNStYSdZzVCilB4Wit+oDkbTDJFK58TSHZozgfr3uF5hldFOXzItA7PKMdVFhMaRWUZAFXElqtgE6D1onqEQg2jGnBMlraUt+VTmIk6kb12HljbgUrH2RKlasXwKE4zsG/Sj5+mHbbXQ1qkHroXlbNTrXJTfDzZ1yYzE=
Received: from BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16)
 by IA0PR10MB7183.namprd10.prod.outlook.com (2603:10b6:208:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sun, 9 Nov
 2025 06:23:28 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::ff) by BLAP220CA0011.outlook.office365.com
 (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 06:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Sun, 9 Nov 2025 06:23:27 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:23:26 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:23:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 00:23:26 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A96NMte1442735;
	Sun, 9 Nov 2025 00:23:23 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <d.haller@phytec.de>, Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
Subject: Re: [PATCH v4 0/5] TI-K3-DTS: Cleanup CPSW DT Nodes
Date: Sun, 9 Nov 2025 11:51:47 +0530
Message-ID: <176266923845.19596.343240056423598708.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015111344.3639415-1-s-vadapalli@ti.com>
References: <20251015111344.3639415-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA0PR10MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 467d12bf-a88f-4482-f341-08de1f587e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0poMlRoUmg0NUVvM2lhRVRUMmVJMGFwOFNOam5samJWNDlTRjdEa1hmb2hx?=
 =?utf-8?B?RlNIYXpWT0F5bi80TFE1aW1YeWJPcjRaSVdLQmJUSlpPUHhCTHQ0b2VWamVO?=
 =?utf-8?B?WlFzbWZJL3dyYTZHVHRVcmRsYU5POUU1UkphTjkyUm1mTkRCbXlHTE5qOCtE?=
 =?utf-8?B?b0dReW1RUFJBQXltK3Q1cS9pSkx6d0syanhZcWdsMjA2ZDljMFNvUDlGMGww?=
 =?utf-8?B?S3pVa0UxRmh6aXRJWHdmZHQ4ZzlsM2E5UC9SdEhQQlROaWxTWlQrZnA3dTVY?=
 =?utf-8?B?YUcwLytTN0VhbFI5cUV3N2JZcVhqMXo2aG0wQ2c5b3drL205MWxxNlFKWEt2?=
 =?utf-8?B?QUFkcWdTZTg0QWsvcXBheWlVdytrWWhYRXZybkJ6d3NqQjhVN3RoOVZtUFg1?=
 =?utf-8?B?M1RuMTNjMU0zQks3VFFTU3RtTkpDU0J3OWNMVVIrODRlb2hjZThGZ0M5cEZY?=
 =?utf-8?B?MFdyYlV5NE1xN08rOUc4ODgyZG9MU3ZaTVNaZm1sdTcxK3ZjYkdadmRRVit3?=
 =?utf-8?B?RVhqTjBjZGdlWVdPM1h1aml0c0daMVNYMzNlcW12UEZ6Ni9IWkpTa05JcDJK?=
 =?utf-8?B?azgySmh0eFd4cDVWM09WRU9mWTFwV1QyYTQ5bEF4MDhOVUpnOUJFNDBZSW9w?=
 =?utf-8?B?cURNM3hVZlFLeFR4UWZYS1YrdERIT3JleDNVRTlFdjh3Q3JHMUFDV1E1WDFm?=
 =?utf-8?B?elBHWWovNTFUMDdtQXJzOE84dkhmTTdtYmhXRDlNeFV3NEs0MjYzWVNaQzZF?=
 =?utf-8?B?RXBuV0k0M3BoU1JpUGVOMzJwaElCZlhpamFCclJiVDFSa1VvcnQ5c2gvU28w?=
 =?utf-8?B?WCsva1E1YWswaFplWlQ1MURKbWE3Y3M2bGRmdDk0WjFZdXJFYjlWeEhZam5u?=
 =?utf-8?B?L0dDYTNKU1BEQmZRRWtzbVduTDMzY2FZM3JpYUhLUDhJZmZsaUFsT09XTTNN?=
 =?utf-8?B?UjZLVWYwU1d6SXdKL09nSm5XeTBwQ2JYTnhKTFJNTzYvSVptV3VPRVBOTzFz?=
 =?utf-8?B?Viswd0JvUXFaZFJobXBoQWJvUi9YQ2txRy8vU2hiWm01eHdnNm83OExQTHhj?=
 =?utf-8?B?L3ZnZ0xRUnZWSXl6c0FUcHBXY285RTRPaDNBVjA3ajk0WDMzL2JvaW5rNXdV?=
 =?utf-8?B?aXBxbmhMcTYyckJmcFJpZlFrNVJlVzh0K3dXQWppdUFnb3BWQlZiVWgzdWp4?=
 =?utf-8?B?OU56VmdrOFl3MDYwMnFqNzN5NWRvYjhBL2pMeUtuZnhhcGdYMG9DN2RDQWxt?=
 =?utf-8?B?eW4zN2xTSXh6TnYxTTZMU3hITWZkK3hYWEwyYm1Ea1BhZmRxNU9yVGJpZUY0?=
 =?utf-8?B?NUk4VWJXVm1QcHJYTTlGVmF3eHVaTmhyaGNTbXEzVkowbFdwS3lCTGc5aERU?=
 =?utf-8?B?S25TMmNUaUpvK1N2dmx3UzQ0WldhNGhXVE5kZjM0eklHcU5zcTh3Vm9RS20x?=
 =?utf-8?B?K1FZYnFGK3RBUFFQQTVBMXp4SHRsNHpzUVZncWxtcTkrbXNsNFVnSGd5eERl?=
 =?utf-8?B?UEVSWm1TOENZb095c3JjS3gvdldmbjBwMUJ4TW5LTHJJd2NyMXlrOVJUa3c2?=
 =?utf-8?B?cGVTaEwrNXVmT2kzUk9VdllZU1RBMjJoWlFNSmdyWHN1VEUxUjBPanJFMXZF?=
 =?utf-8?B?SG95SGgwVGQ0c2JydGtYNmVqOTBreVdZQldKbVFSWTE4dkJNaTRIN2RBaFBR?=
 =?utf-8?B?SllmNTgrU1kvNW5Ccm5JTzhINGIzUWkzaEpjTWlPWVI0VU5kaVp1ejlCVjVq?=
 =?utf-8?B?K1FuVmgrS1c5WTJ0UHFQMUNGQWFrdUVacnRRbFNOL0JvRnkzUnlmZ1g3OEVr?=
 =?utf-8?B?Q0cvOW1laytENVplUFZZRHFEQ2NBZ0d0TE5UUnBCMTJDREdtQndOMFhyY1Jy?=
 =?utf-8?B?elNNekFzMGZBMmlkZmZUL2tDWWp1eXZLMzlIbmNVaFVyaEVISnZVQnRqMjRv?=
 =?utf-8?B?b0J5V2F0VnM1Qi9Xa000V1RwYmhaU3RVVkFkeDFIR3dNbzNVeFZxWit4S3g0?=
 =?utf-8?B?RVVqaVUreGI5MkMyWWhBOURNTmFVSlJ1OW94K1lUY2pZMHpJcW1MOTNRdG1O?=
 =?utf-8?B?bDJYejM5RmRtMmZmUHM4UHhpQlZWR1Q2WG9RRnEwSzRwNkJQWVlsa2wyZGJr?=
 =?utf-8?Q?09B0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 06:23:27.3829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467d12bf-a88f-4482-f341-08de1f587e9d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7183

Hi Siddharth Vadapalli,

On Wed, 15 Oct 2025 16:43:32 +0530, Siddharth Vadapalli wrote:
> This series cleans up the CPSW Device-tree nodes by updating the SoC and
> board files to keep CPSW disabled in the SoC files and enable it only in
> the board files.
> 
> The following is a summary of the SoCs, CPSW instance and the Boards that
> this series affects:
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am62: disable "cpsw3g" in SoC file and enable in board file
      commit: e8535e2b2786cb072470467f34cf6cf09f07e862
[2/5] arm64: dts: ti: k3-am65: disable "mcu_cpsw" in SoC file and enable in board file
      commit: 6d2138b85ec0d200b6249c413967f913abae212f
[3/5] arm64: dts: ti: k3-j7200: disable "mcu_cpsw" in SoC file and enable in board file
      commit: 5a74aa002cd9ff373c81fc0c8ac7614c9a13c546
[4/5] arm64: dts: ti: k3-j721e: disable "mcu_cpsw" in SoC file and enable it in board file
      commit: ee90abbed770849e8fb1041aa11ce8e8b22c9956
[5/5] arm64: dts: ti: k3-j721s2: disable "mcu_cpsw" in SoC file and enable in board files
      commit: c984dd0ecde05e2464cdad00ccd699da48552a3a

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


