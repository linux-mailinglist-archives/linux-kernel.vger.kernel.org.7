Return-Path: <linux-kernel+bounces-896601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8757CC50C18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5306118997C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ECC26A1B6;
	Wed, 12 Nov 2025 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UjUr+1k6"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC514A60F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930073; cv=fail; b=SGpPez8eUIGWZ1umFQ6cR8md9TtkZqBvSXNar9UupJ1EeEELUhtGKmt/WAGNnWo0xS0+/r8yuV+l1OMDJ3jB8XklKsCny/i21q54rAdTrkhh5o0w0+SaAMMKat5N7o1SUqKZwjZWDXfujySKRekiL1kWXB0oh3E0FYVrJ0qef50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930073; c=relaxed/simple;
	bh=CgfbFMXtmLuWANZeGIWJpXKwS2N/K8S92LPPhJ2eYaQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=cU7UUycTPsmG3Qd7aDl/B9F+YHR1Y12LOQHSgyNZdbzG8upCL3bCghs/a0cwoFhhYuvT8x7XiORlGmqtFh5shHa3yfL+yQP1nKaNuwgy3rg5/BjLCslEGEqLYInusAiO0OiPMd+N7eh6zQ30S0Kl/CPdHA0YdCRJ0xhp+Nysmiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UjUr+1k6; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqOB4ew6FHn5d/TC3stwEpgUzxVLrmHJY6lHVNhCIqjc/ggh5B1Awlm/SYCzBk4c3ZzoD+ynvifLGnztjmLfcBaR6ScvU/uF2aVZyjM71DqXVWVJsZILZk20cnCgyXtu4KSSjMB2HZVKYwtCmeIuZ6rFJjxQKr09gls12yW0P7SwAkhfkxgD1uMpa0jaB5/MAeLKsi4+I8NsDTo5ELQdy0oJUHBvK57MlJthSvEIupB1jCj2NUoSTU3AZ9Fu2a+qUeDcABIejakJhlZGOaC9AlCDMjzcsQRwHlY6C74SgoTyoeXlseSC/2DbSt+WODWEiDP9Z2TeoLztw2+K18lL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6k6qZjqxAzMTehlRGg34Iu+ccxqRSRM2Itn0sZeXbE=;
 b=jhAhbVhBOIiUZakBs8EEJgqBO4O5UQHtzWFWlwQxIVfJnQ6PKOj72PTS6YjBryKW7fcnod7Hn8il7tRlQ0eijERgF0cgoS1H1lYtSEWuj4cMalACDWIuZiADs0vo15NFnzRuwTL1VX7FACUK1Yvm1cfjWtyf7zUGygFx2NyQqwNsIPpreoDUw+U8CcoX0Ag7X2d/tftS3LP/+gZlKMcyiyWaA3/eZFeLkFZWrmTbFWzZFRaCIcv1cdSAHRAY+5GTnj/iV2XAnxj9A6vbOwlUuD2mXka/wEOnnsCLoUwdAd1Xoe25+tV1al3S01u7OlDLK6AWn2jaeRWa//V2CKa/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6k6qZjqxAzMTehlRGg34Iu+ccxqRSRM2Itn0sZeXbE=;
 b=UjUr+1k6V17Ih6bTsIFT6IwfPN2Dh5W/EtRRDte0yX4Z38WNUei8IcVQD7t5PsYRSvkn+kVCTfSf8lNvICFYJIcJo0n7r/DMBfCKjQEznzNtocHYWGaubGmLAAe/0BqZ251acQaAPaTwgnkyehVJZ226BpOuAEmNmYxKa8UdCtG9gBqB+npXWvnKEKNtMK7F7lylH2a8mUFMDysQ3xO9wSYViUR2Nr3gUg5VaHx5oCs5K/crUlJ8lGw1BxytM+6su+lJpRzodt0UOtXA9aGBuJ1mdLIVxDrs1KgyeizyVtzfozQP5ZV/r43dLa1pFZOdWhXuBH6k4tZXaJSg+Lhw0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB11939.eurprd04.prod.outlook.com (2603:10a6:800:307::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:47:47 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:47:47 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v3 0/5] mtd: spi-nor: micron-st: few clean up for micron
 spi nor chip
Date: Wed, 12 Nov 2025 14:48:03 +0800
Message-Id: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMtFGkC/03MTQ6CMBCG4auQWVsz0/JTXHkP40LKIF3YktY0G
 MLdLWiiy3cyz7dA5GA5wqlYIHCy0XqXQx0KMOPN3VnYPjdIlBURNsL5IHQ5MDZslKoV5M8p8GD
 nfeVyzT3a+PThtY8m2q5fT7j7RAKF6blCo6nvsDq7eToa/4BNJ/kv5EfILHTdtkqrhsqu/Yl1X
 d+0tqtlxgAAAA==
X-Change-ID: 20251107-nor-84fe07ec3363
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762930121; l=2238;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=CgfbFMXtmLuWANZeGIWJpXKwS2N/K8S92LPPhJ2eYaQ=;
 b=6N32XW0ffrkL/2giTfkEcgOu+tODgTyuIltRVH6PXiAZC0YMpQSJ37Ch2HEcrvruvihrKRVIB
 yZkpH0SDwvFCBhof/dYRVXQe4vqUnDTcdjA8g9w7VJaVUk0kVmhEbs7
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI0PR04MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a64f61-9246-4dd6-934e-08de21b76397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXlaUjRqSjd5cUsvNHdtcy90NXdldDdjamlubzBBUUpJNzQxQWRVbG01enhl?=
 =?utf-8?B?cDJYRDdrNi9JVFlzUlJkalJzVVZSbThtRTNvVGFsZmMyb1JxZFNaYm1INGpm?=
 =?utf-8?B?aFJLUld1WWUxazlNdWlERlRPTURvKzFjVUFTNHpuZTE2RStLVHRhaGRlcDdE?=
 =?utf-8?B?N0FVbzN3bFdJMG9rb1BrVmk0ZE9YcHM5L0NvZnIzYUVQcWFmQlpNRnJRS1VF?=
 =?utf-8?B?cGJYTWRyNktSeDBQZEZZc0E3Y1Q2a3BhaWpqL0NuRkUzYjJydVVLSEVNM1Y4?=
 =?utf-8?B?ejkrZnRqOHhFSXJBZ1pXbVQ3QmpvK2JtQVphb2lhS09tM3I2cVJocDhSV2RY?=
 =?utf-8?B?Z0x3NmVvU0VkdHR1Vm44OXBndE9xY3RTUFdqYkhIMHZzMWZVTFA2KzVaODlU?=
 =?utf-8?B?Z0MzZC9MNlVyOW5tem5kWVBkZzF0NDZCeldrUGF4cHlmeHJnVDJIZENGajhN?=
 =?utf-8?B?NU4zdFBaclpzeXVNMXVaZm5RZ3lZWlgyeGdRb0ZHZ1pzV0RwUUVZNEZvVVhn?=
 =?utf-8?B?cHFramxxUlRKcnh3Z1NKUkZ4MDBhSk1rOGlYZUpJV1llaVkzL1Z3S0JVK05h?=
 =?utf-8?B?OXJBaS9mcmwyazRwZXBPVlVmY3dZak9VVHF1eFhYRVJGM2ZjY2FrV2lTL3Vr?=
 =?utf-8?B?Y0pBVTczdWhmQWZxY0hMek15dURaR1dSYmVqQnlDMlFtMUkyTjZZR3A0Tlp3?=
 =?utf-8?B?Sk5uNnhsVDdqM1ZoY3VqMUdTeWM2VHRUSWZkclhST05jQTR0bU5oRjdlVWNi?=
 =?utf-8?B?K0RlSnRpYXg5QmxBM201NnFVd2NoRmJtZmhtS2JXWlU2QzdnaWNrMmVRMExV?=
 =?utf-8?B?ZkJsVWZ6TWFtTzhja2dZaDI5R1VBUWo2eWJ3M1FhTXh3ZjFTTFpnK3pLZDdm?=
 =?utf-8?B?cVdkbDdZL1E3bzl0WTlBME5MbTUxeExDejVoLzJqY1lqVllMNFoyOFJRR3NX?=
 =?utf-8?B?WVMzYjBYTjFncUVqcUVNdkF3alJZVGJMa1dubGdLVVZ5WU5zWHM5Z0Job3hE?=
 =?utf-8?B?S3ZoTjBIWEdITC94Q2JjQ2I0TmtjcmE3V2Z3ZWZ3T1RmZ01pU2d1MjBSanVo?=
 =?utf-8?B?R3gyRXZkbkF2M0l0dDlpakREMlhzSkRlUHBUSnVSSFp2bTQvdk92Wjd1ZG5m?=
 =?utf-8?B?MXN1eDE0ZDlkQzlTeTdveG5YWEc0QVhzV0RuenFhVm5BaFg3RkxTSVh3d3py?=
 =?utf-8?B?QVM5dXVXdE5UVWJGVGUyUmg0c3A1UW5PdzZMMEg3YkdjQnpJMG9idUVTUlRl?=
 =?utf-8?B?SkZsc3h4NmZVazUvMllMSUdkQWYvT2VwU3NrSTFzN1JiMFpTMnU2VGR5ZGo5?=
 =?utf-8?B?WXQyNTVNMW9WNGZnZjBDaTNBbEc3aXhCYjRDSzMreHdoVDBDYWMyZEFxMWtK?=
 =?utf-8?B?azJHZVZTQjJlaXZHSWFkNDhiNit5TEhOYjdsRFlEUU1zZzFiVkRlc0NHalBS?=
 =?utf-8?B?VWtmMnYwQ1VESTlNamk1YjNjTnpSTjBERXZmbmU0cEtieTl4eTVNU1NsS3Bq?=
 =?utf-8?B?Qk03amw1SXBDWVBnaXNlNG9jMXZ6MFJVV2swOXBjZm56N2FHN2hLZElLemE0?=
 =?utf-8?B?U0pUdnZIaWxNRlJ0cmNYUXBRUExXMnBIWFRDbGRwcHJacFc2TmQ5L3kxQ09G?=
 =?utf-8?B?QVFMSVlRcU53SHA2Y2hLVjcxcE5kMm8zN1JJSUM2WGY5UU1oMnRISHljaUlM?=
 =?utf-8?B?YnJrZ2MvVDVXYkVDVENSRllVZzVESDM4aU9yVE95b05LZlhNdjVmSHdWOUhG?=
 =?utf-8?B?WWxYVjRWUG1aSXlrcGNTS1Y5WUZubkxUZ0pXVDJsdStqZDBOZkx2NStVYWJ3?=
 =?utf-8?B?TUljZkhTUXJQbXovOHpCenU5UzFDOG4yemcxcDU4ejFRa1FBa1Q2R1NGMndN?=
 =?utf-8?B?N3FDMjRpb3VKZDk3UjV0SE5valQ3VGU3TVZTQzJOb3gwcnZwaXRjYkxkeGYr?=
 =?utf-8?B?bVRUcEN6RHhDcDd2amswOTJJQUgrY3NuWjRvMVV2aEpRUFZwSExvSU5aU0RY?=
 =?utf-8?B?eklydjBBcVhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3VKclZvb1BTYjhxdDZEcmVnK3ZpYlNXWmJGOCtTTUlGS3cxYzlsczZKM1Ey?=
 =?utf-8?B?Wk5TWGp4UzNaMVFPUzkydXlJK1o2M2ZMcGV0cU0xSkFTSXAvR3BHdmVCVG05?=
 =?utf-8?B?bVAvR3FWRHgybXB3MEhoNFBQYVlpazVmS2s1czREd25acmJXZ0VTSWJybm9u?=
 =?utf-8?B?VFprNUttbUtLNHNhdlFpLzF3bDZadUVCMTY3Mk1QeEYxVUpkd2svRkVnYjVs?=
 =?utf-8?B?a2wzTWpoRVYvekorbUcxdEhwSGtYUk9jN0RGOTVOOThCbTgwemRZY3lKc0Fr?=
 =?utf-8?B?dmJKeDIyOU1BRVZOeHBHY0sxMXI4WTdMU3dzM2h0V2M0WWt2TlVYWko2NThX?=
 =?utf-8?B?R2xQZDNLWTBVNVkzdmhDVzRyTGFqL1M3bWJ6UjJlTjEvbUR2endMWnBMUXBK?=
 =?utf-8?B?dXdjK3h3L0NJUFRTRFkzMGJiL3RTbVlnZjZWTk1KNktqRlNOV1hZdUozenFJ?=
 =?utf-8?B?ZEJOSGY4TmhqZTM0N2xNZTUvT0hXUW16OWtIb2JlSEw2QjZXTi85Z216bXIw?=
 =?utf-8?B?MkJDTGZrRUpjdUIweWVOZmY3N3BQOHN2Vlp2aUVDTEt5dFYzblh0RWk3Zm5N?=
 =?utf-8?B?NUUyNllRc0FnNW9JeVhxKzBKWklHV0E1NTBweEUwemJVWU9lREN2RTB3LzJ0?=
 =?utf-8?B?TW81WG1pa1hxNXdwZDBqYUoxaGt2NjZjck40Ym1MMC83L2JRY0Zib2pabDM5?=
 =?utf-8?B?dkZvQWR2a256Uy9lR2JqSGZIaUZDY0I0QjdxWkN6aFRoZWFVZjIwaHV5MVg1?=
 =?utf-8?B?VmZMdS82T2gzUFNvL3RvRmVCY090bUFjc0kyWEZyakVHbDN1NzNqclc4OHFo?=
 =?utf-8?B?TEN0RFgxVWxCUWU1WStoVDA2YngvekEwM3BPV1NhWHpCb0RNSFozSXZwSVho?=
 =?utf-8?B?cnJTWHhGa0kwYklFREhNbFNUaTBLcjlGanl3U2hQVUV5Ny80NUU0OEMvbUdv?=
 =?utf-8?B?Yzc4bUxwRU5CNHE3WWtiNlZKTW5xTVh0a3VneWY5OW1YcW9OQTFZV0VnaWZ1?=
 =?utf-8?B?K0dpR0YyWU1raHJoekhvaG9FNlpwZUxVd2xrcXpiOHY1SEFMbFk2c3A1MDJ4?=
 =?utf-8?B?dU9SU2t0cWZHSFdXaDQ4MWlYbVBLMEtlcUhuOFNSMHcwN3RwN2hMendKZ0Q1?=
 =?utf-8?B?RVJLRlVlM0ZXYWd2T0E1eFhtcVZBZEV1cm9HN1ZyWmgzK0E0V2h5aGYyd3d3?=
 =?utf-8?B?UFpDa0Q5MVVTTlYrRVlkQy9aTlBENkZVRFk0dDEyNzArQkJuVThsbGR1UlhF?=
 =?utf-8?B?WDE3ZnYyQkFmZTk3M2JNVFRRM3pBNHdtUmh1TzRHd3E1a2FyTW9xYTJxWldZ?=
 =?utf-8?B?RXRyTnJwT0hKc2NEZkZmNEVjVnl4ZS91ZWtRNnNYRmd3WklVTEprdm8yV1Zs?=
 =?utf-8?B?QlJDSm56WHVTSDV6aVdsZWtEbURkeEVwUkdjVmFMdG9Pa3JLZk5xSEE5aXgx?=
 =?utf-8?B?b3pvSllqeEVXMmVocXIrV2pWdW5mVngrRWVMdEZMa3c4ekxTSGkxWkcwVno4?=
 =?utf-8?B?bUN2d2VUZkowU1lCVHF6c1A3eTZCTVh5K0JlUUNMWHprU3hMWWJYTnQwNm9S?=
 =?utf-8?B?Tks0UWJlWis1Slltc2tXS080czVhVnhHOU5TUHBra1BmQUlVNHl5NHorT3A2?=
 =?utf-8?B?WC8xdy9TV3hNaEJmUUJGdFNlVHoyOEpwK1dqV2ZUSXJsUkpFSHd4cjFJMEFB?=
 =?utf-8?B?TmFiazJadVZ4cy9XTkJsclFoT05NeXpzZFBTRGlRUFVxT0M5bm9yemptVG4x?=
 =?utf-8?B?WnBySWdYakoyZ0EwWUdIRDVHRlRoMWw5N2NBT2x6dzQ5T0R5WkRYbGUxREMx?=
 =?utf-8?B?M3VpQlI0ZWhIeFU1cXdQU2dzR203WlUzVk42MHorVTM5dXhtS3BhS2p4T1ZT?=
 =?utf-8?B?SHJNV0JJVFl0Y1VPY1plZTlOSDVQdzFjdmd5dFpzUzlDNHZOYmhBOFJJQTdX?=
 =?utf-8?B?LzZGbkhacEJ0dUd3bUtpSVFIZzhBSFhCcXcrR2RQZkd0TG91ZmtHWGg3V0tW?=
 =?utf-8?B?K2ttVlAwZlhWZmZHeWtSZ0Y2OUVQR01TWHpoODlqMS9Lck1oajd3UWpRTEF0?=
 =?utf-8?B?a1J1OVlPTktydHVpR2RSZVBIYk95WFBwMjVIaGdJaExhTFQzWnBBOHF2cW5m?=
 =?utf-8?Q?aadx7xluQHH5/6ZdJeqLsOpV4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a64f61-9246-4dd6-934e-08de21b76397
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:46.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/ezLXzZRbet7WVHPnK0w2x/ZuaZAVpe0UTzcBrOjqWCda/qHpcpZ0lgEKuW7PeB7O8Fm7HnFHBMIz9br0r3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11939

mt35xu02gcba, mt35xu01gbba and mt35xu512aba are similar, but with
different number of dies. According to the datasheet:
https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
these chips all support die erase command, but do not support chip
erase. But accroding to test, mt35xu512aba support chip erase, do not
support die erase. mt35xu01gbba do not support chip erase, but support
die erase. 
This patch set clean up the mt35xu512aba, and add mt35xu01gbba.
since do not have mt35xu02gcba to do the test, just add some comment
under mt35xu02gcba for further work.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v3:
- only change the commit message of PATCH4, no other change.
- Link to v2: https://lore.kernel.org/r/20251112-nor-v2-0-8699383714b9@nxp.com

Changes in v2:
- PATCH 1: edit the commit message, mention the function move a bit up,
           and add Tudor's ack.
- PATCH 2: new involved in v2, move set_octal_dtr to late_init() to benifit
           all micron/st chips.
- PATCH 3: v1 add die erase for mt35xu512aba, but find it is wrong after test.
           mt35xu512aba can support chip erase, but not die erase.
	   v2 also remove some fixup flags and size, because mt35xu512aba has
	   SFDP.
- PATCH 4: V2 use SFDP, remove some fixup flags and size.
- PATCH 5: V2 remove the code change for mt35xu02gcba, because has no chip to
           test, just add some comment to remider a code change in future if
	   has a chance to test on this chip.
- Link to v1: https://lore.kernel.org/r/20251110-nor-v1-0-cde50c81db05@nxp.com

---
Haibo Chen (5):
      mtd: spi-nor: micron-st: rename the die_late_init functions
      mtd: spi-nor: micron-st: move set_octal_dtr to late_init()
      mtd: spi-nor: micron-st: use SFDP of mt35xu512aba
      mtd: spi-nor: micron-st: add mt35xu01gbba support
      mtd: spi-nor: micron-st: add comment for mt35xu02gcba

 drivers/mtd/spi-nor/micron-st.c | 97 +++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 43 deletions(-)
---
base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
change-id: 20251107-nor-84fe07ec3363

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


