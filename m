Return-Path: <linux-kernel+bounces-784133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4FFB33714
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E37F3AFBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31528751B;
	Mon, 25 Aug 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAOisC0y"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABA28851E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105258; cv=fail; b=j4IAFFsR6X1yO4LWGuWrCMc5fv54Cmrgz6bW3lTOD5frmPy1CiXxmgGReYcdWzPjwhZncX80/B7q9ORMYpaoaYRImTn6PUe/2eG9SaIxU+CbWCUOl94YW1KNPQHge+r5eFkcU9b4tpywlf0dMPzcljoLqZSYD5tyTR9n6Vlqygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105258; c=relaxed/simple;
	bh=46RO6J8o1VWP3rO5LavGD37vIq9dMFHIKm0ln/I5e0U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H/AYfbpNtKJ48SI7QH1EIjEdpAt5HASe0KLZwSFMvhkGQC+xErPEIqY6z0zlaxQK/aEGnZIfJht2P2v1GgQYLf5XCHVeDcVdFjJMyolJ0TR7vCVEuH4rrPAj0hgW/bYXHNu8IwUeQ1bObPOUgC+oIiEEWYIAsnLxtZXsB6EKARo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WAOisC0y; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boY6wxI9j0+WK8O/nkRegLCgnn6/gk8ZmiPbVQvracl87rNlGWU3m48nPILTLp4Ekw7eBoUyiNwMijqmH+GReokIu9odMfVEey44cfiw/IbTNoX+AKzwJo0Z8GBYejGwIQCvvyW7QC6jTJkU2G2yz9axqDhdzhZTwaaDWdzCW7+RYklPOhcRNcS9Zt97BbaDxwFGWrd8LaMkg1YyZaFzmSLv9Dy2ZsZ1oIHd/8mO9P1xl7Chjas9mt0qQZaQQ9xa+loN3D5xMYxfxXhHcGhPHyt9RaBfmZzkrsQVX9H23MEI6lieM/R45h8JKwRnsk6xquCAxK3JfLlRODAMkFEp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbTHJDRHaSCkBgBh5NVdKCeLbXFqS3FaTzNaYO6003k=;
 b=ahEK6M54bCZWobooahvrBnDN/dKQyXVuyXOjcLaI0uBffoUWFWCuCMwNHulOlUZFGweXpiphiVKeGsQLxXwkWw4TPuJGaZ1WpdqC8Bfk30DOtINurhuabIn5rSp/BT805IemLGBID3eVLTdwppMH85VirpArbk8wx/+GKi/pKVg11tDgzZiLGwGGdSvmcse9LflU2ZB6b6O2gitduv1lK39ftpuGkXk7HJphsP7N7hIOLBV/9vkTY2esJ4pxD8HuV4SKocnPl23QAEyFEEAYc1/nB5Hd7JH0yLwTglowB/TjQ1NL169YgNEL259bAqg27rIMUWcuR5UG9Ac45pMUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbTHJDRHaSCkBgBh5NVdKCeLbXFqS3FaTzNaYO6003k=;
 b=WAOisC0yEdoP9UTk4K0scZIrAOAIiNJXbTlNDjAX6IdY17dT3DI/sw5RKYc9juXFlJxBI0Dg2+cQxnpj1V5zN+GE705U3A6qWYd8x3Trz6sTfDy26BFy9VQpsm8cvPuE/47y2bZ1o4uSNSkvWETYhpJIxIWLo3Ljc8mJ/HvIkrLBu7UJ3ZjYgazUzUVYwHxtSdQUmscxhNUklgflIvZvAXDW1iQNAvC0lMejYvgn67GVryHEnsL5Xlorr5mxXfTtJyFC9b5NiERVkp+RzPUgoIoGL94hPV+ymwEcLD98t/JZy7z5wA1ItVWHsCqIbWGvdw4iOB1i0f+zxdlmxUYzvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10325.eurprd04.prod.outlook.com (2603:10a6:150:1e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 07:00:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 07:00:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 15:00:31 +0800
Subject: [PATCH v2 2/3] firmware: imx: Add stub functions for SCMI LMM API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-imx9-sm-v2-2-0bae0265e66a@nxp.com>
References: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
In-Reply-To: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756105242; l=1811;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=46RO6J8o1VWP3rO5LavGD37vIq9dMFHIKm0ln/I5e0U=;
 b=GFp9sVnXJyxqVBWlzwdkuVo0aW+HizXQrvdwa30iE2HxzENpSNxWmztVE1jVgZRiCiUC5sQyf
 ciYseMY7xrgAsh8NmC5TGrFrSYDxO0dL4zj5WHT+/MMAFSUkCmV7j/z
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10325:EE_
X-MS-Office365-Filtering-Correlation-Id: 064e1f4d-59eb-47a7-5841-08dde3a52266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUlLM2lTSE9VcFp0R2w3bmV0ZVNINUU4c1RHekNFM1AzdndxYkd3MFkyV2xX?=
 =?utf-8?B?Zk9hbERxY1FBY2h1NnRXS04wbW5UR05PTFZFc0dMUURlVDIvS3V2elVMOXcy?=
 =?utf-8?B?YUN5VWxhUlZrQllEeWVmaThEQ3dQdTJFOFVSTUJubHU4Rm14UndJWnc2SFND?=
 =?utf-8?B?amtGbEF5LzNzRmQxWnhZNXd3eGNZQUh6K2RNekpqYjJoYi85SWFwdnJlTnpv?=
 =?utf-8?B?aktlOXNNTmNWN2U4VTk1SEEraWRsSHk3cWhVUjVIWjduVkwxYUdJUVhNY1Zp?=
 =?utf-8?B?Yk5kR1ZmNlVOTFNEWkFoVFRKUkFpTU1KU2UwS1UxdVZva0lyZFFqMk5zMS9m?=
 =?utf-8?B?RHFLUkRvbU5XTDNPa3ZkdkZLUDNVRXRDd29WNjFzOFhsQVRmK3ZFLzJUV1B0?=
 =?utf-8?B?eWpnMWRGUEwwMURZbXhQV2VzTUQ1WGo0RHE1QTlnK3ordlZlMHBkWUg3NmZQ?=
 =?utf-8?B?MDR5dUl6YWtOcXN0SEg5a0RwVEIrejJ3ZkFTcnVrTmVnejVsVXBLTTZNM0Nw?=
 =?utf-8?B?TEpsQ3FEMnRPVGphMXdGSlFTRmpZZzA3SS9wdlFvRjZkRGlQSFQvTGZVYzhG?=
 =?utf-8?B?bFVsWGJ6MGF4b1lGNHN4TGJpM01mVDF6QlZybTZiRW1hN1VybmJoUHh5a0dT?=
 =?utf-8?B?SWIzSEJ0bXlZUUFucVBYVStncG10a01ocU5KZFpGQkJicUNNMjM4clVYV3Yv?=
 =?utf-8?B?dWVDL01UaVk4ZllDZnA3V3V6YUtlbXJERVVaT1N0SlpPS2NMdDhlRDlkSkds?=
 =?utf-8?B?WVczRkdDTkcwV0JpaGRBZks2WTFrcW5KaDljUVRiMmZNL3VXVG1mMjd3c3hZ?=
 =?utf-8?B?aUtQQ0tHTm1TQVBmbmdIWkNYQ2dBZVhOVk5pWFh5bDFneUVJbExLL2ljazlG?=
 =?utf-8?B?OXdlUks5dmhkdEVkZGRxcmc3Nm56QnlObG1raUpIU1R5YTNJY1BIckNheEl2?=
 =?utf-8?B?Y2dRYXJ5THV2L1JPZTJDZzJUU0R0N3ZlUk9rLzExNkJxRGlJM05aRHVDd2RG?=
 =?utf-8?B?WlBGdmd6dlFOUHNpN0p3MmhGMEVFS3pWVVBYS1pId0lTQTUzbzJXZGdPMVF0?=
 =?utf-8?B?SThGTW1VZTU1QmpQL3hpbXFHdlVXamdJK3lSQXppaU5IRTFKV2JsaWgrSEFD?=
 =?utf-8?B?M2Z0WGJXY2hhNUlhTW1pczZpNVFXalh4WnR0M1IwR0Ira0ttK0lmOUFTb0pl?=
 =?utf-8?B?L1J1TGE5bUJ0a0tlUUlzUWtQeFVreEQ3RkNCNTh1dmYweDd4M0NiZzBvTFUw?=
 =?utf-8?B?QUhjZEFndDFzZEloNDUzZXFGRWtIdlhCTUUranpzdnZlTkZOWU5uTzlTRjRO?=
 =?utf-8?B?bDh4ZWFEazlmWHZPU3ZQOU9oa21pZ1cxU0pYWHlVeWkxZDJEK3hZelpDSnhI?=
 =?utf-8?B?aDRLYUxiKzdmWkJncjhybGxDamV1OVQ2Q1l6WjFyQWo4a0V1eG9BVE91U1F6?=
 =?utf-8?B?Y1RRckZycU56QXFpeG40eklRYmhBRFNjTzg0WFVKNUpaajY3eXZEMW9ZQzgy?=
 =?utf-8?B?QWpFRXNFd1dnZVFqaHJhRFZPcEc3ay8xNTJhY05UdDFKTzVlUUQrclpFT2c5?=
 =?utf-8?B?R0NCclRUZnllTnJRRXBSaUFKOUgzaHB2RUxpeW5WRWRuSHlBVURhOHFMdjdF?=
 =?utf-8?B?aTNWZ0I5U3piTlEyMm92UVJDYUt5YkYvZkJVcmtYcHJvclpJWkxydXg2MXp1?=
 =?utf-8?B?YzVpamFDYW84U1cvMUdWbkdNZmN4bU5hTk5zOXpVMXE0NHN0a0o0ZlVTVXNw?=
 =?utf-8?B?d0RwOU5RVnZTN3lvZlhlL0orRktBYUYzVG1TZWNDMW1jeVQ4VFZzaUpTaDA3?=
 =?utf-8?B?bzNWMWJNeG9sbGVrR0dlTkZNdUllYVhTNThQejRFRmszUzNWdERtVktJQTRL?=
 =?utf-8?B?Qk1UZnhGYTBkVGFSZTg0eDVsazdIZDhGcENibWpYSUhoM2VNamF4cENhRklt?=
 =?utf-8?B?MDVlZnhPRng1UDNBdDNRa093Qkp0R0FTbmVhVlRLT2R4aTd0NXRxOUZSWlRU?=
 =?utf-8?B?bmt6YStZOWh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJDMGJIMmU1MEhJNDB1cXd5YUhtdTg2Y3dHV1J5SU1ESmdhRHRTc3ZaQ1dC?=
 =?utf-8?B?cGhyQTZyUWtzbkVSdXZTdi9hMityWXJxdVZLak1yVlBxeFJ1SGlRNVFZdktY?=
 =?utf-8?B?d3lXRjlOQVBoa3lQUHdzTThJK1g3U3A5eHdINUdzT3Y0NFBVclZMdXg5dkRQ?=
 =?utf-8?B?TUEvbk1xcldoUXJMWEx1VVhXdmJJb2Ftc0o2M1gwZzhHSnREQkd1OUZ2UENF?=
 =?utf-8?B?NklyVUZCZTlCdE1wV3JDTVhodU5zZzlMS1JaYzhHRWR0Z0w1Q0VMTE53SGJN?=
 =?utf-8?B?U0JmcUxzK0tuaFZSL1F1RTVDMWxkTXhvTjU2UWRHbjJVaTNKbjc4WmVyK2Vz?=
 =?utf-8?B?cWwrd2NxUldTZGxZYkIxcC96YWlxMkJUM21hVUhXd1F0UDcybFU0VDRsS0pT?=
 =?utf-8?B?NGF1MFZMenZvdnRMRitISFJ6OXVqZGVpR2Q1d1ZFWGZKSkdrcEl1MEt6ZHpq?=
 =?utf-8?B?eXZwdEtjM1ZycUZWVGV4Zjd2cW5mSE9tc0hZSVFldFpRZ0E5MDJGeFBRcjBq?=
 =?utf-8?B?Y0ZqU2hDRmpkbFY1UVBwQ0RVVkdCTHhlMmk2VDUxMTFKT1UwQWpwL3MrelhQ?=
 =?utf-8?B?RHVadlhXRmpaNldPTmY0V01tOHd2SlFIT2wyVmQyVlFLMlZLTWVESDdRVStB?=
 =?utf-8?B?aXJIdnBWemJzM3hSMVRhN0RyNjZLN2RKMzZ4ajdKSGF5TlNIcERwUklyM1lR?=
 =?utf-8?B?UXdtaWNJYWNxRmRyVklqK3VPVk9vSXFNYTBHVlVad2JoUkwrQVdrN2ZPUDFH?=
 =?utf-8?B?VW9UUXpaMTBUbUlLdDArTmoxb0Jrck80R2gvVnNGaUQxYmdhbHhCQjF5UTJI?=
 =?utf-8?B?QUkrVERhRDJoNGNUMXlrSE45ZDlCaWFSU3hLU2lhRlNONGFBMFBCOXFZeUNi?=
 =?utf-8?B?OXZRTE5Lbi9oTkEyeVZCRjJlY2lQTWtBRGk3Nm0xV2wxWm9uWnA2NHpIaUNi?=
 =?utf-8?B?NCs3NEVZV3NzRktnSXE0MDNSY0FtcGk2MnNnbC8vY1FyNUNRdC9qOEZuOEpZ?=
 =?utf-8?B?a2QzeFpZRFlWRldnalRSNVg5MzNwUWgvQ3NpZXdsMGFaT0pyUldJR09VTmsw?=
 =?utf-8?B?V3V1a0V6N0RYL2l6R2tZT2RxZnJYdlhDMFE5S2tOZ3V0em9UTjlJbzhzU2lS?=
 =?utf-8?B?ZVBwNS9lMEdrUkEvUW5vMklrVDNqcks3MUJpMzd2d2VUd3BobDRDV0NCS2NR?=
 =?utf-8?B?Um9rTkorZE8rdlRKWnNlRGNwZ0hyUmtzcFMrc1lFMlNRbXNZSklROEd6eDFq?=
 =?utf-8?B?WVBoK1ZRQXRyV2pmdTFvL0FCTjBQMTJCUGRtMWhDRmFpeFJoQXFJQzkwQWsz?=
 =?utf-8?B?YWxGUmFGNGl1d1JBaXhFTDFTTDhxdkR3QU1oanhyVTZUcW5qQUxOMHhaQ1hs?=
 =?utf-8?B?bHZBc2laU1lIZmg4NG8zUVpITk9VOWJ1Y294eW5OcjFrYlVHQ3hPUkxVVnZw?=
 =?utf-8?B?U2F2UUFCUWJMcDZNL1A4MDlIamt5REl5TzlVeEFLWWs2V0hhVUFLTXJTKzZP?=
 =?utf-8?B?aXpGRlFMb0xlRFdQYWMyMFJXYmJydXlhRTcyd2dsNktiaDNXdk9yVU9JYWpV?=
 =?utf-8?B?ckhTVHpQWURJc0dOaEtlTTR0SlU1Ylo5cHBLOE1SMFVVZXRlR0JZVlM1Qy9S?=
 =?utf-8?B?OTdYS0FMR3pHYVVHdFRhT1lFRWtsbkZyRlNWNUhvNnhOTUNxcENWR0RZcW5P?=
 =?utf-8?B?bUxWZXVnejREVG5GWjZZSWhFNkZTZXhla1dQbUZkMTNndWh2NTJwZFQxR293?=
 =?utf-8?B?OFR0TTRCZE5vTm94U1FrczRzS2hKdlBmeTZTMzU3ODBnc05DejNJYmhCOUZB?=
 =?utf-8?B?Wm1XbE92WEhZcHFkcUJGdSszRXhycm9PSFlnbmwvaHRnU3Bzc3YwRmp5a1Ey?=
 =?utf-8?B?elZINi9kWm9salZYQjVrd1ZIN25PUEpMMFZJMFpNVm80VzVOcWNoSG5qb2Yz?=
 =?utf-8?B?NkpXanZ3WmxUQWlaN0VFcXZwWnFpbUc5SkMyU3JBTVhJQm11NkIzTDliQWIw?=
 =?utf-8?B?QlRWTWJ3ZmdkYVErakRYaDVIMEFsTVJEY0xyaGZZSnhZV2NteDFKZXIvUkxN?=
 =?utf-8?B?UzN4eGEzQ3k1WDVCQmxha29LdFp3K05Ub3VwdXl0UFk2cUY2SzFSR0dQbWVZ?=
 =?utf-8?Q?Lad1IkHjB5HkCsN0/uaIqsFqd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064e1f4d-59eb-47a7-5841-08dde3a52266
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:00:54.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etpAs8hcFcuFvHBMIZEQhQD8mg18Zh97oM2oUNXGJCKXbwPKN2cqh2iM5ap8JUMct4bIeyFQtks32oQSVcR+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10325

To ensure successful builds when CONFIG_IMX_SCMI_LMM_DRV is not enabled,
this patch adds static inline stub implementations for the following
functions:

  - scmi_imx_lmm_operation()
  - scmi_imx_lmm_info()
  - scmi_imx_lmm_reset_vector_set()

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

Fixes: 7242bbf418f0 ("firmware: imx: Add i.MX95 SCMI LMM driver")
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/sm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 99c15bbb46aa8329b5aa8e03017e152074cdf492..f2a72177bb37c1d46145a60710e3809641e0f5a2 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -56,7 +56,24 @@ enum scmi_imx_lmm_op {
 #define SCMI_IMX_LMM_OP_FORCEFUL	0
 #define SCMI_IMX_LMM_OP_GRACEFUL	BIT(0)
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV)
 int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags);
 int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
 int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
+#else
+static inline int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif

-- 
2.37.1


