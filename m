Return-Path: <linux-kernel+bounces-896605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747CBC50C24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE977189B93D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791482E5B0D;
	Wed, 12 Nov 2025 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzOXzhal"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047F2E285C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930085; cv=fail; b=jh8Wf2PFUMNNG8FsSEvYDgVvN0HuMUYkrm1bS6Fs3kyK6QIoOIR5ooT+d8+e+1gFTpYhYL69iO3jntwty0HAQrvJpJEwcdNlwVZ/yux7Tyjlodbj5UBbT3vrejgq41wo9pc92z7TgpGL95PDw8xS5ovuk5DJS3w0RFid3l0x7Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930085; c=relaxed/simple;
	bh=4O1wc6LDiPqXHZbKOzzkhdb6sDkoG03OpRKISQvxtIU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pqtchZZIWZBMlMHBY5jPEwAA7F834Mo8FgLQnj2lZIvM71qjpRxvKslHiPRIGq56LuwCjbut6bHkZF6hRmEyYVX4em/7vaz9Zk9SfFEEVLL6JIyjD6cTKavsxU2jPQdJJFO3QxOxPpb6QeqnliY8PQjI0OTnLWmVtR06qq2HZ/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LzOXzhal; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRUnPjC7kLERIwcBVZJqY2yOHz9oDqpwesifs9YcW1RL8w8lKvnSOYfIQuiEi2HeLYQ0qTTFd6Vafpd6j/6ZUnveHSfyV8mmlsBqf3HQPyAWbb4Qas0b2r1BOanZpGePFox7N5J6g1zO8dqWnSE5el1lb/Wjboy7iaCpiaEJj4PI7qjqDTag7NPBnuTEXWrVNJT6hcjeDDiYB39o2FbbKNwE9+4HXjwJ1bfHbXr3jK9Z4fOx/uaePJ6Mv9r5cvSS5KOeEEDLxuFGxPVq4lmsezYyS/AEOsOAqJzXZfLQEKUDa4VSCxprdmpWHGSmOMtPkMAvT7ekP66UPgLyYP7/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1lPTHAvNxNLHItwedBXZzqmIlUIL613zkyKkmfhtBs=;
 b=OCmmeSMQtgrLJYnBW5qYpNvZje9Dos8RqnxemdDpadrhUnj5IxAAuumGG/15iUGaDPXCUOPlAI/HHik2xdfCKTn20yPIDBhhULyAI3uR8zMvFfFVCJmCdoJPOBTH/D8UDBg39Iuis3Svx+4rgJocMfHNShLWNijWICvZxmrYWy6LdBErREPwhoRbpqnAmxeOQypXGNDerDmukpgrvzOUDDqjYxSn1XOVNDAo5Qh5sBt+/KB0mV17jQ43KFzFkRVhjHRqCnI2b0qNeM4sChUIuVmxsjtBWC/ANRuNgO6TtPDXsUL7+vVbK7AV8US1g3vA0QEe15y2Kf0PoiEupA4PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1lPTHAvNxNLHItwedBXZzqmIlUIL613zkyKkmfhtBs=;
 b=LzOXzhalYRvnhOSQiQyoGwFyyjEfIKqPfSTlSOit1XKUfjmsOiw6jMyQpvE9GatsFAqRKbmUA7ECF3J51tEbzjXew6TG45rw3MsT9zdikhydK1rXZ0k6UjN43OY3g7VHQTpIwYMCDTZTQ5u9q+UBE95N3iAZ9poxX9TJte2exkpp2g8DCFgKDHpVHnwgE0gnIJG0JzhJc7rgEKlvqCGtfwFE7isY2D7m/cmLQrnLyFjJ3p9INFHtNPtwVV/1K1uXFIGONUvmG06e7Ps5OWyKV+Fp2rwyHnYszEigAg6r9FqQZy/D1qpcnplg9kGrNSViuciBhGOTg/wwbGC7Ah/Tyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV2PR04MB11301.eurprd04.prod.outlook.com (2603:10a6:150:2b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:48:01 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:48:01 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:48:07 +0800
Subject: [PATCH v3 4/5] mtd: spi-nor: micron-st: add mt35xu01gbba support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v3-4-20aaff727c7d@nxp.com>
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
In-Reply-To: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762930121; l=6815;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=4O1wc6LDiPqXHZbKOzzkhdb6sDkoG03OpRKISQvxtIU=;
 b=sSLtxJtt0rskQq1Fg+NqQ68foqQjNBUQhuCdOJkPD96V2DBgNR+/KZ7Le7nFRh/P+KMf1c/IO
 uox7NQo69W6D1gHA+cdPViAP9X7JQVW3jrtC6JbbIH8se9z5+bc+oXl
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV2PR04MB11301:EE_
X-MS-Office365-Filtering-Correlation-Id: 682d7c3e-37aa-4a0d-f15a-08de21b76c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJrY2xENEEyalV0UXFza05CakZZeTdyRFVQSFdYaEhpcHFVcU4vS1pZZzVi?=
 =?utf-8?B?eE9mY0RFSmRsRE9OcXh2UlFHMDNkY250d0ZDaks0OUo2RGtQTC9oVUQrQ2tY?=
 =?utf-8?B?M29PeU93T0FFZDdKM2J2cWFockFJT044RUlDeC94QVp3RTJhbjd4bk1Qb29o?=
 =?utf-8?B?eEM5VDZVQmhQYjhiTFhJRzNidnVKc3hXTVVuSnFYeGFBa2FrUjR0a2ZDbzU1?=
 =?utf-8?B?eUVUUE9uS1Naa2FuRkp4UnlidmIvaVhvTWQ0TXQ4UzFJRUtvTWNWeVpuL2xl?=
 =?utf-8?B?M2Fwcis4bjJWQzFqQ29iOHVOaWRCVGtYb3dWNkVKak9xMWdjRkdWQ1R6bGRM?=
 =?utf-8?B?citIS3NidWRQa1dkdjc5U0gzelNXL3JFNVlWZkpnSDIyWm9vK3VTamVISnRi?=
 =?utf-8?B?My9JekZ0dXZOaHl2d2I3Y0lkWUxnV3VxaUU5VU5xcjY5YlE3dWRqc1JlN3Ay?=
 =?utf-8?B?WWNHUkFvQXhNRy9SME9mVUxUSjBPZHZKWjlRQXZmOW0yU0M0VG1nRnZxcll1?=
 =?utf-8?B?Zk1iRGtOWkdIdGxHK2NYVUFHL1pOTkdtWk1IUW9oZHVPMS9TU0pwNGp2QlM0?=
 =?utf-8?B?NnAwZnFndDl6SG5rU3lURTR3NWxMZUVyVXl4KzVRbmF1UTNIL3lvNmRaSFBL?=
 =?utf-8?B?Q0FXd00yRWJMem9NT0RHQzE4YlpXVksrRzNjZUNSR1BWTnh3Y3dVS0cyS1JZ?=
 =?utf-8?B?eVAvYTRzb3dxL2VSWjNKWEo3aUVmcEt6UnZsRkwrdHdLenRsMXZzMkZpWklS?=
 =?utf-8?B?dHJvUEtqd1VrcFU3OWR0ZENDQ1NFS1p6WlFGL05Qcy9sL1ZTN1JZdGZGbE1h?=
 =?utf-8?B?NTJBbUJTU1dHMzNzSUJFT09aZDVvdzdRQkNuS0o3THhYd08yWXh5akNZU2Jt?=
 =?utf-8?B?NGVES3Jmb2VQMzAweGZrUVVrZVVKaXpadjArVENZWHBtY01vS3VwL0lMcm9u?=
 =?utf-8?B?aTNnc1hibC9KYkdXa09VcU0wUEF5by9uZGh4RTlhVk9kRTZ6V3hwS2V6Yzlo?=
 =?utf-8?B?QTNmSHVzZHNrSWl1QWZuQ1BJVm1SYkVheEtaR0YvVVM2VWxmdjYwMXBtN2Rz?=
 =?utf-8?B?eEdjRWtjdTRWa0ltUVl1UjFZQUd4aUdXclBTcm9JN3kxY0lSSnJGRmIxTGlU?=
 =?utf-8?B?OHdvOFNKR0diNE1vdVdJSGNCbkg2akJOWFBQNTd6S2ZSTEt2Qld2cm42VVlG?=
 =?utf-8?B?T0pqQy9kYUtaQUo1ODFMVkRUTWhrVmZPcjduTWUrQSsvTkxZSndDOVIvM3M5?=
 =?utf-8?B?NnVnckY2RytqejM0N1dwZmk4SWUrZzMrWUtuMzhKNE5jeTlkbEhNV1ZENGh1?=
 =?utf-8?B?d21rUkNhdHczcVJWVDJ4cW5YVTN1MXlSUzRxVEhuU3NzUmFRay9IRUUxU0U0?=
 =?utf-8?B?TXA2V295bFZoR0FiMEtzRCtFUWFpQzlhb2E3WkkyeUdxWDd2U042SEFzYmFq?=
 =?utf-8?B?Ti9YT0plVGI5ZzV5OGl4R3hPbjY1NW5QTTd6bzJMR09pTWk0M3NIQ3B3WERE?=
 =?utf-8?B?cHRBSmhyMUIwL09BbjBMS1RlWWx3SXB0SHY2dHRVdEorSUQ2bDN1UWlOUG5N?=
 =?utf-8?B?a1ppYm9UQmJCaGtlTHZ5R3Z6SFdnTjNUSWdoYktxbGVuM0Y0NmI1NUJLNnFv?=
 =?utf-8?B?WVpjMk5pckhWOVRRSzBvMHA5d2laZ1liMEtUWDkzTm5KR1dtUmxOSUsxMjhR?=
 =?utf-8?B?ZkpjeHRoL3hHSXpqTWFnNkY4Z2syK2dFQXJqV0xTWTcreWNOZFhFQWR4bHBZ?=
 =?utf-8?B?ZDg4VGR4Y0JjbmY0WkdvSjUyTk0ySEJGOThZaGpxeDVvMDdIMTFvYnpldURD?=
 =?utf-8?B?NTBFdVZqdVBNeTRmdVBnYWdtSW9Lc2h3Nkx4Kzh2eFRadld1SXVMWWZWMmk0?=
 =?utf-8?B?NldmbG5JWHE5OUpVWk0ycWNrRVkzaExPSzRUNVRoSytvNS9jc3FKQkwrOGIw?=
 =?utf-8?B?U1dGdGFveU9RY0dsbFpnUm1TZHB6cUpHaHlRRmZ1ZFd2aEdVS3ZPWGRaNkhP?=
 =?utf-8?B?LzNYTURoK3NRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWl3WlJvdFNwQ3FPTXVoUVVBTU02bFFaSHFJTXJ6OVpscnptMkZmQm1zalBB?=
 =?utf-8?B?MHU3eVlyLzVjZktVbzAwYngxakdKODk4ckxqUDlvbVRyT01hckR2THpTQTIv?=
 =?utf-8?B?djd6MFpUY0oxcGRrWmNVS3k0SEVXNzBuZ0F3aVZzREtPRWkrRlMrR1ZDQnNl?=
 =?utf-8?B?aEV0RUhOYkdpSmIwb0ZMK2s0MUcveGUyVkRaM0pxS1U1NVk5SlpGS1FHNTNn?=
 =?utf-8?B?WE1RKysvZTg5ZlQ0UmVPL2UzUFJKeEIxMnFqUlhRZWVwb3BqQThVbFNvUGsv?=
 =?utf-8?B?bWRZVXBDNUNMbWYvTEh2TmJvelNDZ1Q5VWNHRUpiS09nbTZ2V2VHNG11cXoz?=
 =?utf-8?B?bkhDUkVScDI4VEtjTVFIOW9TWXlsMFFlNGJSTGRmN28rUDBURWdIMVV3VkZi?=
 =?utf-8?B?b29BSlRwc3cvaEgvNytiMTZ3WGd3L25jSStLejNqWW9SU0piQlRzaFdFTSs2?=
 =?utf-8?B?dFNrVEtJSjRLRWovUjhPRzJ6UWQrcVFRVWtYaksxbzZFenQ2cUU1TGZKVUJt?=
 =?utf-8?B?L0ZoMjJPVXZTaVRlT3liODQyQ0FIODlieWovN0ZxdjNQaE5LQmVxcEZIQWRQ?=
 =?utf-8?B?MDlvQ091WWd4cnA0QnFORk5MLzRBSGxVd2UrZ21tTlRtc253dncyRlZpd2Ry?=
 =?utf-8?B?WGl6UWsvbnJtZDU3TEp1eDBtZ2NHYTFMWjhMVE01dGduMng3dG1CcUZFWGF3?=
 =?utf-8?B?cmtSR3RCOXlDRWFFRThVcVFtdmxrRFduZ0FBZzdSU1hSdWVzRmVTMndIS3FY?=
 =?utf-8?B?WGozbFRqREEwNGhsZXBTUkZyblNQYzV4L0VwdGJCN25uZEdLRHVmQ0Zsano0?=
 =?utf-8?B?SGpoYkZuTTA5QlV4WE96WWE4dmM3bFhoRlJ1S2J0SGFUSHdYT2twVFpkRmh6?=
 =?utf-8?B?ZmEya3NXSnA4M0hhS29TWm4rZTIvUXdrZ2s4WHlBajJFRjJUa3FCdm5qS1Rz?=
 =?utf-8?B?cmVXWDNaeG1OYjVoYVcyL0NsT3RaZ2h5bGRKTlZPdDdzYVA2T0pGcWJuUVN5?=
 =?utf-8?B?YW0xZWhROU0yUHhYMG5Dd3kxdlRra3oyeGw2QnJEZUw5REN1cWYyRkNnU0lT?=
 =?utf-8?B?WTlEUFZZaWdKSHR1cGppWXI3YnhaZXZRb1JpclorOVJXdEs0dkZCOXF4MTd2?=
 =?utf-8?B?TDcrdXhSOU9tYkIxK1QvWTVxUEdNbWlSTCtvb3FlaWhwaDdzblNjYXQwNERY?=
 =?utf-8?B?V2RNN09UWWhuOE9sUFlaWUIzNU5oZUo5UkVGM0h5NzdpYTRoK0ttd0dVYXFm?=
 =?utf-8?B?b0lJWFBuU2t4YUJqcVRxOE5ySWxUZHFOUkpjRHdTU0l1RHM1RGFxTlZ1N3Fz?=
 =?utf-8?B?b3p3bzhrY0pmaVlFUUxVejU1T0FhWXB1NDQ2VWZYUUxzTXlEOFJUNlVGeWFQ?=
 =?utf-8?B?a3l0K0NwU0tTaWgzMkpEc2tCekxnekJOWWxKSHN4ZVlVc1czVWpBRThDNnB3?=
 =?utf-8?B?VGVkZDJZRUlwWUZHUnhEdFZtNWRBd1Z1RGtjTmVkbG5TYzNkY2VsSzUzVGEy?=
 =?utf-8?B?ZSsyL1gyN3VSTm1pdVVEVGxnLzd2YzAwd0c0S2xValZHSlB1Wmg3U3Mzd3dJ?=
 =?utf-8?B?S3ZoZEJucVltK3VRekNXdVFabG5uUVFDSVNMU05rYU1HUzhGbE9KOFhYcUFi?=
 =?utf-8?B?SDJoeDJtM3FQd3F0VVExWDl2VVNPanZBOTVQTGtGU2IxVGQ3bHBqV3JEYmRz?=
 =?utf-8?B?UERZVnJ4WXdQeHBGbmE0OEtkaWVvcWJsY2hFbmpGZ3ExUHRmNUVDdWVrWmhp?=
 =?utf-8?B?b3dHc2Q5bHJHMEZPZlpMa05ENEpvaEZNT3A4NjVnaU5BQWcrU3hqRFF2TitI?=
 =?utf-8?B?aDYwZGpUWkpPTW1qUEI2VEMrWFV2UFFQMnkzdDdjN3ZjdmJYcVZLajBNY1Vh?=
 =?utf-8?B?bDZLY2xaaXZVek0xdjlsOHdVcFJ1bjluWk83V3p0NXJkeEZ4d1RQZTRRbGtE?=
 =?utf-8?B?RmNTRFBoa3BqVzJFd1VMZ0ZsSXhpTUo0bndQZ2pWaUZ1WDRoMGJtbm91MHNQ?=
 =?utf-8?B?NlA3bWRBRWNaY1Jhc2d1ZXNmZnZUV3lCNmt4Y1ZTMHZaT3RvaW5NbjB5SGlv?=
 =?utf-8?B?d05ZNzF4eWY0VlpTL0VOK2cxdzlFVmlIVXlzNjZoQkJjcFFRem5HbGg1cUN5?=
 =?utf-8?Q?HibUgIAOb1Si/iNvcjh9myqo1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682d7c3e-37aa-4a0d-f15a-08de21b76c4e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:48:01.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0ozH5M79uaouEsz3FLRQRtTou9WfcnphBlr8oCorDIUFK05eNeut5yQRZhTxJg/RzUswa8NddXs0/YiZ7zgfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11301

mt35xu01gbba is similar with mt35xu512aba, but with two dies.
mt35xu01gbba has SFDP and support 8D-8D-8D mode, but SFDP
lack SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.
Besides, mt35xu01gbba do not support chip erase, but support
die erase, so add that in late_init().

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---
1) This mt35xu01gbba is populated on the imx95-19x19-evk board, was
   tested at 200MHz using nxp,imx95-fspi SPI controller.
2) root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/jedec_id
   2c5b1b
   root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/manufacturer
   micron
   root@imx95evk:~# hexdump -Cv /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   00000000  53 46 44 50 0a 01 03 ff  00 08 01 17 30 00 00 ff  |SFDP........0...|
   00000010  84 00 01 02 90 00 00 ff  05 01 01 06 a0 00 00 ff  |................|
   00000020  0a 00 01 08 b0 00 00 ff  ff ff ff ff ff ff ff ff  |................|
   00000030  e5 20 8a ff ff ff ff 3f  00 00 00 00 00 00 00 00  |. .....?........|
   00000040  ee ff ff ff ff ff 00 00  ff ff 00 00 0c 20 11 d8  |............. ..|
   00000050  0f 52 00 00 39 61 99 00  87 8e 03 d3 ac a1 27 3d  |.R..9a........'=|
   00000060  7a 75 7a 75 fb bd d5 5c  00 00 70 ff 81 50 f8 a1  |zuzu...\..p..P..|
   00000070  2f cb 27 8b 00 00 04 01  00 06 01 00 ff ff ff 8e  |/.'.............|
   00000080  00 00 00 00 00 00 00 00  00 00 00 00 ff ff ff ff  |................|
   00000090  43 0e ff ff 21 dc 5c ff  ff ff ff ff ff ff ff ff  |C...!.\.........|
   000000a0  00 0b 80 9e b1 81 b5 85  00 f0 ff 9f 00 0a 00 00  |................|
   000000b0  00 0a 1a 88 10 00 00 00  ff ff ff ff ff ff ff ff  |................|
   000000c0  00 00 06 01 00 00 00 00  14 01 81 03 00 00 00 00  |................|
   000000d0
   root@imx95evk:~# sha256sum /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   3848f0bd2436d7ca1373cee33f90e09d6479d0f4dc4bfd19f6a082d9e0039495  /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
3) root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/capabilities
   Supported read modes by the flash
    1S-1S-1S
     opcode        0x13
     mode cycles   0
     dummy cycles  0
    1S-1S-8S
     opcode        0x7c
     mode cycles   1
     dummy cycles  7
    1S-8S-8S
     opcode        0xcc
     mode cycles   1
     dummy cycles  15
    8D-8D-8D
     opcode        0xfd
     mode cycles   0
     dummy cycles  20

   Supported page program modes by the flash
    1S-1S-1S
     opcode        0x12
    8D-8D-8D
     opcode        0x12

   root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
   name            (null)
   id              2c 5b 1b 10 41 00
   size            128 MiB
   write size      1
   page size       256
   address nbytes  4
   flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET

   opcodes
    read           0xfd
      dummy cycles  20
    erase          0xdc
    program        0x12
    8D extension   repeat

   protocols
    read           8D-8D-8D
    write          8D-8D-8D
    register       8D-8D-8D

   erase commands
     21 (4.00 KiB) [1]
     5c (32.0 KiB) [2]
     dc (128 KiB) [3]
     c4 (128 MiB)

   sector map
     region (in hex)   | erase mask | overlaid
     ------------------+------------+----------
     00000000-07ffffff |     [   3] | no
4) root@imx95evk:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
   2+0 records in
   2+0 records out
   2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0207974 s, 101 MB/s
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
   root@imx95evk:~# sha256sum spi_read
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   root@imx95evk:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
   Copied 2097152 bytes from spi_test to address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug info /dev/mtd0
   mtd.type = MTD_NORFLASH
   mtd.flags = MTD_CAP_NORFLASH
   mtd.size = 134217728 (128M)
   mtd.erasesize = 131072 (128K)
   mtd.writesize = 1
   mtd.oobsize = 0
   regions = 0
   root@imx95evk:~# flash_erase /dev/mtd0 0 0
   Erasing 131072 Kibyte @ 0 -- 100 % complete
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
---
 drivers/mtd/spi-nor/micron-st.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4cfa89b0fc3dcc16fe47fc58c043971f4c474ba4..6d081ec176c37249e5ddb724b61bd70f68088163 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -185,6 +185,11 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
 
+static const struct spi_nor_fixups mt35xu01gbba_fixups = {
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = micron_st_nor_two_die_late_init,
+};
+
 static const struct flash_info micron_nor_parts[] = {
 	{
 		/* MT35XU512ABA */
@@ -193,6 +198,13 @@ static const struct flash_info micron_nor_parts[] = {
 		.mfr_flags = USE_FSR,
 		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu512aba_fixups,
+	}, {
+		/* MT35XU01GBBA */
+		.id = SNOR_ID(0x2c, 0x5b, 0x1b),
+		.sector_size = SZ_128K,
+		.mfr_flags = USE_FSR,
+		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixups = &mt35xu01gbba_fixups,
 	}, {
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",

-- 
2.34.1


