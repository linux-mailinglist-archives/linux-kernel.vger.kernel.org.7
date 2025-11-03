Return-Path: <linux-kernel+bounces-883205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F76C2D01F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7B6566112
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762E32863E;
	Mon,  3 Nov 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fmTi+U07"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD9326D5C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182908; cv=fail; b=f4AsS1zb+JRgWfjAbr3xzf5JFUGFAVGsTNFVKhOv0zdYeNc9NtYFQecC4sF7IXZvLbup34LkNRhJSWzeX3FyyJ7/VhvKifVYDQZoazMTeDLGPwE3fSExflnaG21eny9EGXZZ+oydJOxMYUgAEVu/QNQ3WF+gkGtd2dr4LtT3WTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182908; c=relaxed/simple;
	bh=rLC4O/kLlbSXnAZwyBUcQNgZFy/bbcLfSy4vw1I1bvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cz2hF54DyAa2g3Y14t7+nuoW0YCBkul4U0TdP0rtgvj2Gav2IAzmzn2PzNbi4OuTqBYcDEIkeO5+NgNs9iFavryAgOEPs4kWb5mBW8xnvVyN3oXUA1R6tYbKHhSBw9YR0lg0GSQvJKT+k9Om/8XIbJHZMi9lHJUZAIB8p8vpLLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fmTi+U07; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT+ooJGklcHQOlGVfPXc7WmCdUklBCkIPGihW4yFZXN3BLGj3ux5EjXIWohbk0DIXmwLpbGfr0Z8A2P3ICWeI7ZyBNbwE/PQ5GpvwnT8oRLrmLi9Iw5qNvpGF+VqWyTZPqNQ08b2Udb1re/fhnuQsCGRHbuUVDwGCefKZ3xbRC95fYutG2nRAUlSiiEoFOl7fCjcuccsyxcobolJM1WJ8CixqlY9pHkuKSaJzZgn7g5okaCx3JwraH3iIT4fc3CdBru79AjtE1U3yWhpPuAAarL3lCf2xQqXUqJfTDYtVLB0FFca5AFFnbEX8kKEUJIXWAad2AM6iuKIWbDcm8Iujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1YXNIVu4F7PeIM/myo7/Iqc6fAs5G0bcqdkExPd5Ww=;
 b=J9BX8DWQKsvMpnCO6f3X1JStOCvC1wT5LCfoorjkMuNftJJ7KdcQ5FtALT9Vu/Gi0UhQC4tZiPEqIXv0zX+AnxQ0EwJrI+ncukeabPK5PEzCCr73meb5mkXMtjBOl0yAQYC0mvlWMY9L8tlh4qlouyhiirHAW6gqTpxJG78nb3wX179ukyn+GGTdPPZBpVGzDBMj+a/jU3q/wyq5iOUqsn8KrBwTpw7LZXPJIRFllB/xUIdRpENGWod0sccrBXnpyoShM6RwOJW4Xx7bQUL9Tdmeck1FhfPjcLKsXlvxmcVGZY5zLx+/HsFulJLnDgyP4VoHq1eKtr7lf2nAueIiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1YXNIVu4F7PeIM/myo7/Iqc6fAs5G0bcqdkExPd5Ww=;
 b=fmTi+U07KC0AbsrCongZaDoFFLqxbUJZEwyAp/2tu0lH27/xrT6YOf+LwhFuc9d02FFcUZhyJID9dhglJIZlzS+ZtgSKS2f313prp1oG1nGhlBf6Yhx/Q53NaMdEQzW2OvtXa+Q+dKGljJ5+Ebzi/i2/UXompj74bQwb1PftDGA=
Received: from CYZPR20CA0009.namprd20.prod.outlook.com (2603:10b6:930:a2::20)
 by DS0PR10MB7317.namprd10.prod.outlook.com (2603:10b6:8:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 15:14:59 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::a8) by CYZPR20CA0009.outlook.office365.com
 (2603:10b6:930:a2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 15:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 15:14:58 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:14:55 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:14:55 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 09:14:55 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3FEtrV325063;
	Mon, 3 Nov 2025 09:14:55 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	"Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
CC: Nishanth Menon <nm@ti.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Gregory CLEMENT
	<gregory.clement@bootlin.com>, Richard Genoud <richard.genoud@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>, "Abhash
 Kumar" <a-kumar2@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] firmware: ti_sci: set IO Isolation only if the firmware is capable
Date: Mon, 3 Nov 2025 09:14:53 -0600
Message-ID: <176218288382.3559260.12524155435608432109.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251031-ti-sci-io-isolation-v2-1-60d826b65949@bootlin.com>
References: <20251031-ti-sci-io-isolation-v2-1-60d826b65949@bootlin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR10MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 89da82d9-03d3-473d-688a-08de1aebc082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi8vcXMzVFI5NVdjd0VmNlEyYTRDZnNOOHBKVlZicVlwY1QzUzU4bkppK3Ur?=
 =?utf-8?B?UFBBQm9sUWlYUUpuZEhvbWpwTS96aFBERXIrT3ZaUGtrQ0JZMkV4RHlKY1VM?=
 =?utf-8?B?ZXBYSXQvNmxuWXNwQTdNVk1xNGdHSThBZFJKNkRmaW1IMWcwd1RtdGQ2REdV?=
 =?utf-8?B?UTZ6V0paVldvZEQ2UDhCQkFQQXozaDJ2YlQweEl4SWhMTCt4M1NucXlOQm85?=
 =?utf-8?B?bEZRQXF5ckpHMFp2eGFxcGVLWkpHSFhVajA5SmxMRWo1MkVpd3VvZVh1TXpu?=
 =?utf-8?B?UHlTTVRtNFlDRU1NR3NVbGY0TkF3SmNLYXQ4TTB5NFl3NnFJMmZZUVNnUTZ3?=
 =?utf-8?B?K2NjdnRkbkxEaHk0dEJGcE1iT2pNNk5jckc2YTZUN0k4ODJGWW5rMVFuUkk3?=
 =?utf-8?B?cWJwejZSZTNxdzNmVlhuQW1TS2FWZnlWUTV1eDBoTWV6b0xUamw3SEc0TEsx?=
 =?utf-8?B?VFIzSDI2aWZtanVJVmFEOHk0enpWNjZMcWlqaEl2TlJCa1lNblMzK3RRdW1Y?=
 =?utf-8?B?WHFZRmgxSG1Tclo3bCtCdDh2S21EVWFvaE1tRStzTHlxVkFEdTA3MFRNeWQr?=
 =?utf-8?B?dUdxMEo2Nm9JZHZUUEpVOUdhWmFDZnJvNXBtVHpoNjlrTW54MENjN3I0a1kr?=
 =?utf-8?B?dC9lTFF5VXhkM2ovTTAwbHU4THNaR2p1RXoxSEVPQjdGUDR4YXFBYW02RGJO?=
 =?utf-8?B?YjVMbWFybVdkRVdnemI2WlRkOU9lSHFLbURpTk9BRlh5dmh6dzlKanVuT09s?=
 =?utf-8?B?RGZFa1lLZnByekVjQmxXQ1V0dkFGYXBUMDMvSWZ2Z09WYklVeEh5c3pMMTRN?=
 =?utf-8?B?eXg2bFFIN3NtdzR6SDBhRVlRaXF2TllwR1B0UzJNUWp2bXUwT3FheVQrR3B1?=
 =?utf-8?B?RS81UmVnRE1OZndJNTBvMWhHU3NSeDNEZlgxaHZYT3RlaHhYNUJvSUwxSU5U?=
 =?utf-8?B?RXVWQjBnK056TlBVbmpIcDFreHd2VlVHYXlUbkNtR1RXSDgzNmc1QnpVYmNZ?=
 =?utf-8?B?OGZqY2tSZStxZHE1ZTlKMmlVdWd1Rld3OHFudlBXSk1PMkpIeW4wVFpxamFH?=
 =?utf-8?B?M21IQ3FzMWpic3NDelY1MTJsRk9CU1ByT2grV3RkdXdJYUNIbGVudnM0d2tN?=
 =?utf-8?B?TGQwaTlpZDN3NDdqbzBrSi93ZGVUWG9aQ1Q1Rkd4c3NEbmM4eHRuYWp2dHl3?=
 =?utf-8?B?RDVpZklvd2I2YnpidFJ3NXJ3NGpqaXhuNll1MFhSRTFtUndxaGwwcEhTZW82?=
 =?utf-8?B?N0RmTkI0bnAzR0NBZVpTYjBUNG5UbU0yaEE2cTNQSUw3UENOQTBaV2xNV2F6?=
 =?utf-8?B?OGJDdnRiMVR2WGJuemU2M0ZYVUhDd0RXeTBScnVyeDZkTzREOTRBTUkwNHY4?=
 =?utf-8?B?RjdyMklNM0VWQXM1ejUxZXc5TmtQMFNJN3NhYWk2U1VCcXVUb1dhNkpQMFRJ?=
 =?utf-8?B?OGJnQkNxTkU5eDNTS1Z2KzUyY1dBMHBCRm5talhCeTI5NDVmeEp1cXkrMkh3?=
 =?utf-8?B?QjRvU0E1d0VIaUplNVd0cVRUa0xBVXpQajRKejVLTUE2cStPbUZiVmJrVXhT?=
 =?utf-8?B?NGhObWpsczlUY1lnNWtxMUlXZmVhby9WMmZlbFFrNHFsdS9xZGF3TVlKU2Np?=
 =?utf-8?B?U1hnbm9FTzJsenJqSVpIUk9EVXdMQTJVZGF5U2lOMVZXVE5WbXhEU0tBWnZm?=
 =?utf-8?B?WEpWdDk2NFUwTEk4OEhOVnhLMU9veHIwRWJBR2oyOFdtQkpOemNZWnNBQ3VD?=
 =?utf-8?B?N296SU1sbnQ0ME1Sa0cvOEQzei9Oako4bmNwNTh4aXJwTmM1VzJsZi9kRjdp?=
 =?utf-8?B?YUNoSnpNYmkrNmxxOU1tZGx3K2Z6ekRLcitodG92V3FvWllwdndmRmJNQVBl?=
 =?utf-8?B?VmE3UUl6b3p5Tmc2aThkR2s2Z3JYaHVYbmphdkpEdzVsOW12azB4TEJZUXJC?=
 =?utf-8?B?dVgyWXBkMXNvMXFyZW1JUy81a2RsVUQ2V1diOTNlNWQzYlBhVXpTNkV3d2hP?=
 =?utf-8?B?WUV3aDJHLzJQY1YrRHNUQmltN1krTXplalR1c01Ia05xUjNrTWJFU1hFM21B?=
 =?utf-8?B?Z0d6NEVkUUpwMzR2T1BRSXpabHRYNWFndlNrenRrb2hmN0wwZ1IrbVlBYU1s?=
 =?utf-8?Q?ydFA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:14:58.1704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89da82d9-03d3-473d-688a-08de1aebc082
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7317

Hi Thomas Richard (TI.com),

On Fri, 31 Oct 2025 13:44:56 +0100, Thomas Richard (TI.com) wrote:
> Prevent calling ti_sci_cmd_set_io_isolation() on firmware that does not
> support the IO_ISOLATION capability. Add the MSG_FLAG_CAPS_IO_ISOLATION
> capability flag and check it before attempting to set IO isolation during
> suspend/resume operations.
> 
> Without this check, systems with older firmware may experience undefined
> behavior or errors when entering/exiting suspend states.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: set IO Isolation only if the firmware is capable
      commit: 999e9bc953e321651d69556fdd5dfd178f96f128

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


