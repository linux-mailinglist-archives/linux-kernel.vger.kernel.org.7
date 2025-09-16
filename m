Return-Path: <linux-kernel+bounces-818411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE951B59167
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBEA1BC2182
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F444299AA3;
	Tue, 16 Sep 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GdBUdckr"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6F285404;
	Tue, 16 Sep 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013059; cv=fail; b=hNFSn6LfZUROFScKM/6xeDgg/yhUYg7srHsqpvA41NzK66PLEm32aA5Re70DC3NG8bwqp7NvOusty8Lr3kBWc0pBXSdZyo2XZY+6VvfMg3IcCaBOmkNaLdQl9KnEblTwxvks4jRnf2Jbdl82VfmU1wEJo98Un9yYKz8eLjqxpc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013059; c=relaxed/simple;
	bh=lozLWwKw8pey+U1Kp9yNzktLgdBVjX+YdVrJcw/5Q90=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=SuB9p9rGXUQjrsm3CglQ2w/Dc+LK4rWSjyasIVQFQ26D5AH5IzkX/A9LjGv3pHYsyzRoblnOJaIGjhl6UBIc6pnU3+ScOQs6vFXoVTuEiWf/FL0Lazlo5TMRTIzyEscmpjNyZSHcVsUepYLk0+7EEJN3miqfc1HI1PeBnyHHH+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GdBUdckr; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxvZKTlBVDsuNGB1WyYar3kKVEABJ5Cz0SUg3hQRXCh6XON2z+KOYkolsiy6WCFWH3jiBX6J5AZYIIWii9Xl8ZxTAHpRrrwF0JgdGzf5Rw61FlOKrbd4VJkl2GzBc+GthXohdMjfXhXvI2tOdyDU91il7tbwb+H+GD0Qt4QNq8kTviyfdWu60eC3SDfcPPo3iJsy8W+o6WuC9m0M8AJkeftPhGuNPYiQKWukWNEjyJV9kYQ7MBlPwFRHF4XoP9/6UtQJIWeQ4kV7jIrVj9GCVWBX+ICzVhCv158YHfUQ/HoeAQTNKPh5fPjpHkRfxtBs5z7T2uljD04Yr0oyIVTRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7Lr16FtYeEf4lJm2jk4iZNIWzC+0CrHYoAmKGMjjoQ=;
 b=xv1P9WtM/bHD/ELPb6KQPZ3ZgSenAxrzg81EOc4JhT0YdWEtpxkxGkPsSfO1thBBxUi/k8VGWA4OlB7L6BiFnSq5ZEw04+6B5qkcc8m/aJzkYhpnBlpvo7Vq9cozm1BUdgrFUwJFR6qGAr0cd+zhYedNG8AbS+O/KXBw/M5L2Ya1Ul6NhQ6IFv8X05lIbc7DBdhQMHyhgMgHwR5vzqp9k/HldCU0BNWVT0QY2r26avvKf8KSzvG1eTvOWg+yqasZBFp4FkCX9JvrgNDX5itb8N3fG//1Exv2qB75LKHHfWSND2GGwFLG/TDkrcjZomdz0Eu8oHUb9THHazx9pcySVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7Lr16FtYeEf4lJm2jk4iZNIWzC+0CrHYoAmKGMjjoQ=;
 b=GdBUdckr0bswsxJ7zrKqhmaUhlttN6GSkebWynZ2wu/exdnVdPi3huGSKwhEpvnjsb9tXEDCtmf3oUcjwHYVsgJRgI3TdyB7lbsjzaDwD0UzGPa9rb7Y8t4BJ//HxB7P6PyLOyJrTLns/goIE513iu2ITxBBkVmbbu2chieGHIrCJvtIRf6BabXXX30j4Uc8Bebjf0/AyQUhTvsUmhh79uWDO1YoIyr+gOCyvu3o6kDyk5bZtEXnt3yiBMqs3lT6GTii0Eh3zZDPj9ZKkNKZNc8V62MwZn3EQPAjl9cvFTcGciuohakRhmdHzlgNPwzC8kHG51jwQgv5jsdHmEYAhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 08:57:33 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 08:57:33 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/2] few small change for flexspi setting in dts file
Date: Tue, 16 Sep 2025 16:57:29 +0800
Message-Id: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkmyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3bSc1IrigkzdlJJiXSOTxDSLJLOkNBMzCyWgjoKi1LTMCrBp0bG
 1tQCSg7WyXQAAAA==
X-Change-ID: 20250916-flexspi-dts-24af8b6bf468
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758013066; l=851;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=lozLWwKw8pey+U1Kp9yNzktLgdBVjX+YdVrJcw/5Q90=;
 b=+KwMRUTUUG8aM487ey0jSiwSCb1/2sZYScFpvV+wkZYnT+gPDjSwq2veLEszxAC5QP33FIpMt
 QlHYQeTkPKTCoKmvCb+M95wWQlQbUUtEIDwKeYkAZV/1JRsYC5F/WWa
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10416:EE_
X-MS-Office365-Filtering-Correlation-Id: db7f508d-ea90-4974-25b5-08ddf4ff1315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGMyOXV0MnRMeDlKMDRBd293VXBkU3pvejJLdk1xeEJ0MnNoWHdSSm1FVjR5?=
 =?utf-8?B?Y25PeFp5MFkrVWtWZ3ptR1ZjaVdpSWIycXFpRDV6dThURFVpVTFERnZYWXli?=
 =?utf-8?B?bzFEbHNGODV5RHBhRDlqNXFhRk5WeVJJenNjRjVzYnY0SG1RMENVaVBjd2Y0?=
 =?utf-8?B?dEZ0VzFpKzF6MmJDQUxSbWtORmMzQkVIVG1KNGlBNENBeUJFVkxUc1VUaXZS?=
 =?utf-8?B?SVllK2hJVG1DNHlpR2dBOFBCSWN3OGl0RVlSWSt4aHN5VlhrcU5XQnpmRnc3?=
 =?utf-8?B?TWFWK25ZKy81VTV1K09VaHJlQktNbTRPb3FTa0NHem1PSU54dTVDZ3R6UXpY?=
 =?utf-8?B?UUhKZVVFVjI0MVpTVUF3aTJtRGxaWmpGeFUycjlhQk4vL1pZeGlaWlg1MUZC?=
 =?utf-8?B?WVB2YkFlM0YxK3lDM3NPUG8xNGJkVGIvVTFsMW5FK0pWMUNmNDhzcjU0Ulgv?=
 =?utf-8?B?OFUzeGc4clE0aWpaU251cXFGd1F2VHRjdkNwdDdKbmtnYW5NSUxJaW5UN2U4?=
 =?utf-8?B?REdkWHI4RDZJeFdQQm1vWk53dkgwRzloaDJIWDNXV01ac1N1Uk5RMjUxeHFB?=
 =?utf-8?B?WG8xajhpZmRZZlhIMlVYemFQKy9uVmd5VkZKSzAwMDlkdTZWUmNEUGNIdmUw?=
 =?utf-8?B?ZmFzSUJ2VmF5RVBGV3AxR1pOREVyY1hmTE1SNmxxYWNveHFYWFdoL0xVWTlw?=
 =?utf-8?B?bTdPaG9nVXc3MUxyM2V3RThmTFNQYkZMUytxSm9ydzQySmU5R1czYk9UeHJp?=
 =?utf-8?B?MkFwRzRJT2NsSFE1MmhKVnBRVVkySjRrMGtrZWFnajczaGpWQXdCak90aHY4?=
 =?utf-8?B?aHUwYWdwRktWdWkwVmRrSnNwUmRyVHlkV3lRTE9QUjMzK2xWaXZoK200KzMx?=
 =?utf-8?B?dFJ4akt2UWQzdThhYnVWWmJQeFk1VDRES3VDaDh5QUpVYkVVbEVpenBrNEFh?=
 =?utf-8?B?Z1h5TldRMkFmSUhuVXJwdTJVTVBUVVZSWFFOVVk2NGxkcEs4RjRidVZFcjB4?=
 =?utf-8?B?cTA4RlVFdHNkaU83blZWa1FRZEUvU1pkd2lXVXAzKyttM2JvMm1acEtqalIv?=
 =?utf-8?B?enkwcThnYUoyUzZEMENGRmcrWVl6L3JKeDFuMnRFYnAxZ3VuZ1dOaXM0Sy8z?=
 =?utf-8?B?TnhqSnhZU0xSeE43NFBVa3Y0RmNXTERyQWE5cWtyLzBqaUsvc3BZVE5CRWdZ?=
 =?utf-8?B?NlZqODRjV1B3ZjZNRHF4VHVLcTN4UWR4NWZqY1hHaXJCODI3aENmdTNGT3F1?=
 =?utf-8?B?RGxUN3JESGE1OTFPV2tNRjVqb25SUUlwZmR2SG5HRHkrZVpYRzQrN2t1TFhO?=
 =?utf-8?B?OENxRHp1aGpveEQ5NG45S2V2RCtmaENvNkRUQit1aUxGYjZHRnd0cnRPQ3h4?=
 =?utf-8?B?VWJpSHZiUXgzdXJRVTlialdmWXZ5TkdmMXowRlEyanB2U2ZIRytaTzE5blpv?=
 =?utf-8?B?dTdXSkRlZWVsRnlXRlg0bWhBaHloKytzTGZKM0xha2ZmbENlQ1dIY3dOdWta?=
 =?utf-8?B?SDdrU0wwUVhKYk13QVZ1YzI1TzlxUTZqL256MGRlcmo3ek1mTUUrSm1lQlpT?=
 =?utf-8?B?UStlUzNmUlhUSkpaNzJIc0R2NGFqZVBLN1grSCtOZTdObkMvZVZDY3FvalF0?=
 =?utf-8?B?dVdOV2hGUzhpRDF4TkFMY0JwNnJxSDQzbGtmcXgxb1U4NjA4S0J4RUVYS0tY?=
 =?utf-8?B?T0dsNk9yQm0rZDhZaGhtUElybnZyZ05CWFUxakFCcmlxSCsrUGxCdVBJMkhK?=
 =?utf-8?B?bXg4aUtrMzZvMDFYUlk4YmtiTk1QbXN4UU9ZN04wdzlLcUhKN05ZQ3ZQVUho?=
 =?utf-8?B?K20zMDZCOW9qRFBNWk56ZllDellyelZiSll0RWpmWERwVmdYb1VaNldISXMw?=
 =?utf-8?B?OXZKNEgvN0ZzMTNHbjU3TmxScWFOcFE1NXAySDcxQ1pXQitnYm1ielZrZVJN?=
 =?utf-8?B?UG1WVnZiVE1DZUtrVFBzaTFtdjBDdWhMZkNFRGR0UURUOFNNRUxOekZ6N3o1?=
 =?utf-8?B?UUd0dm9EQzJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09MVlhBbjVleUYveFBLYUYrL3h0UzdSQXVmWFRzU2tQRUREV3Y4MDF4QWQ5?=
 =?utf-8?B?dk1zVnZwbXdicUVWYm14TUs5Q2RBamNuR0RoWVBWYWIzeWtsQ3lhSGZURGRT?=
 =?utf-8?B?VlYxZ1k3ZTBWMVQvMkdhVHZNRm9hMFJoaDk5VnpaMUtqSnd0NitCSTNxWVRr?=
 =?utf-8?B?N1FBWDhlTmxJUHl1cUw4dzVwTGgrTVFLSFU4WWdlTTRlTGQzQnVuUGNMTXox?=
 =?utf-8?B?V1dOWVNGWXdaWkEvQ1NPZUdLVDFRejFlei85bjJ4anI0b090ZXBPc0s1VWJo?=
 =?utf-8?B?aVlNeTVFb0gxU2M4TmhVRlFDa1pqWXZVdnFwTFV3YlI1K01mZkRValJJSWdh?=
 =?utf-8?B?NDRFSEN1VVhPZkJ4TmhidXdTUW5Hb0FyWTl1Z29hSkpUVHJMQU1CdDhGQzBR?=
 =?utf-8?B?ZDVYNXYxMDVxNEMzd1Z3KzF0bUpGTXdCcjJFUy9jWU5GWnBNbTdzeGRTa0JK?=
 =?utf-8?B?cThUZVp1RXhwRjg5U0l1QkJDTVVJZ1lqWTlub0t3TkRSa3Y5SW9iWHlVU0VU?=
 =?utf-8?B?OCtNUHJER1YyeWdpMFl6aUlnWE9yRmxzU3R4dGZmN29oODExcTBhNExUUEVl?=
 =?utf-8?B?cC9oU2Q4eW4wR2VkQjIwQkViSnhFUHZxamNsT1JDdVd6eklERGNJQzFQQ0Fu?=
 =?utf-8?B?T1FIU3VzTUZpYmFoZzhYWTdvNjVHdzBMd3Eycm9QSVVNOVA2dUs1eVJhaTYz?=
 =?utf-8?B?YVRNQ3d2ZXczMUFCTzFLakdXUXRORTgxWnlKenZrVlRYZ0dzeHQ3WTNVUXR4?=
 =?utf-8?B?dzlSanVhN2xUWnAvZE5vRlNzNHVGdmdESytSbmdsbGdJbGh4WnV6Smtha1J1?=
 =?utf-8?B?dGF0R3Z1STNVek9NTmFsZmpQcXhldEQ3c040UlJjQUhpUXdLOXFHVTYyeWR5?=
 =?utf-8?B?U1l6cHcyR1VnQ3dWZG9HdVIxaVNTWTJEWDdYUDdvTndqUlFmdms5VjEyMGF0?=
 =?utf-8?B?MEJnZnd5MVlrMWN2MzNJb0pISXdpUENPdnZITUpJN0FXWXBzenRZUFJydmpW?=
 =?utf-8?B?bUZCbXVrZ1NFN05aTk9yZkVqTG9zTFIzaVBMeHlnQmkrWEJGc1MvYmM4NDRL?=
 =?utf-8?B?ZVZvZkJjL3B5akZYTldXdTJSdDlZaHJRTzFZWDd3aUQyVGg3YWdva0RRRE1V?=
 =?utf-8?B?Nkx0YUwycE9nVjFpNWhOTTR6amdlYjlnbjZtSzkreTZJaG5uZnVVeTQwWGxQ?=
 =?utf-8?B?RHg0WjVyV2tXQnBYR2t0VGIyQUY2SmFjMHJXWGNHZElxUWY0MTIxQU1RNC9M?=
 =?utf-8?B?bmJiRlNRMGFJUE5Cditkc1hpd284dkxUWlNmbm9FeEFodjNxd2x0UUltQ3Ex?=
 =?utf-8?B?VkZsOW0yRFMxTW9RUUxTVFVSK3FwUFZHSGNGcHNnZWZpRjljQ29JMldjYmM3?=
 =?utf-8?B?cDE5SEpTOFFLN3BKSkN4TitUZk9JZkxJVTB4Tzk0UzBPdVgvN2greHlSdzBr?=
 =?utf-8?B?Ykhpekp5L0tZdnNJenhLZXFQRHhpeGZEQWlDQm5wMlJhblRxd0tuYThGbUhp?=
 =?utf-8?B?Y2ZrbWxUc2NPc3UxSWw2ajQ0UmxJU2dLd3JVWGE1SlZiL2gxL0RSeGdqcU4w?=
 =?utf-8?B?TjRPbEFZaDJLS1NJNnA4RE9LMmFndzc5QXhqMFNxQkc1WnZ5V3MvTGRETzdk?=
 =?utf-8?B?RlpnM2kwczZCb1F6Z0lZSlM1NlkzS0R4ZEpFYTd0YmhXcGhBV1dzUXF6b2Vx?=
 =?utf-8?B?Z244Um02UW14M0ppamd5SzlKRVVtdDB2V0F4aUc4dUpsSWIvQ0VCREh5UU90?=
 =?utf-8?B?Nk5Bb0RhSU56QWEwOHFXNFNKZURMSS8wblI5UjZSUUtIakZ0cEJ6ZG9XdXk0?=
 =?utf-8?B?dWlyWFFobXUrdWV4UEp5STJJQmlHOEo1OWo2WXczM0hyY1pVZlJPUXA2Q01N?=
 =?utf-8?B?U3cxdVZDanZQeUdBR0Nmb3BMeEhaaDlHU3ZkTk8xd2ZLQ2ZsTzh4VnJGV3VK?=
 =?utf-8?B?aFZJVHdxSkhEVDNHaXcxNXRYTSsxc1RyVHVTditGRFo4VzFWaXRaTmhpRFcv?=
 =?utf-8?B?ZGxQQUpJVURwbHN0cDE1emZ5OWx0L1ZWYTZvdkI3SjVwL0tPTjFyWllxRFkr?=
 =?utf-8?B?Y3M5T3hzY2lBUzFuOEJkT1ZUaFFVMjd6SXBaK2lGd2ZlVURGcjFSZmxDRWpj?=
 =?utf-8?Q?bswBa1OusgtTqtUMjuvHqZx26?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7f508d-ea90-4974-25b5-08ddf4ff1315
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:57:33.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ8BbhhbDuKdC2TbAJ9VVfYxoycBYKBquWT0HI8dlu7aWfgQ47yooKu2esvX1fxcKcdLZ/sQwxiHVC5/CbcOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

PATCH1 adjust the compatible string to align with yaml
PATCH2 limit the nor max frequency accroding to data sheet

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (2):
      arm64: dts: correct the flexspi compatible string to match with yaml
      arm64: dts: imx8mm/mn/mp: limit the max frequency of spi nor chip

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts       | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi      | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       | 2 +-
 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-flexspi-dts-24af8b6bf468

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


