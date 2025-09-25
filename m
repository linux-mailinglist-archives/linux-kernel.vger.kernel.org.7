Return-Path: <linux-kernel+bounces-833238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6BBA17C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AC77AA73B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA63233FD;
	Thu, 25 Sep 2025 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eH+JoTJG"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E2322DC1;
	Thu, 25 Sep 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834878; cv=fail; b=mJGBfmdKfYOrhlv8NN3jEdihEqxNlSLEwNAX5fkIFmLzKZxrMG67xdxSrWcGsK0m4zVDqf3vCYJZs+x5zzCdAE8wjJ/fbGGJlCtdcc+ihBOU+mQglqZ0i2No4Ko0C+urxBnhovR1XALgBIvKwxD5ZwulZctZ5artbWfxLILZ+2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834878; c=relaxed/simple;
	bh=dYcvAmDC93BXEFvwR7Wi5iQXi17SC9Cz3fC3GbytFNw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fqkWMpTxF6ryfJVbRuQU4RUxDf3HOe8VWMOoZaHxMm84ZioOqfyRaq+x4WGmNHI16xHKFJx/SpOkiJ+AKcaHmgFBYy4biqiOlBOrXwLUXEbxT70DFKMMNQ9WKoJB4H77qG7GOtpJEJ7lNYsK0LAhqMsECuVTF2P88NNxGJV8rBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eH+JoTJG; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2rgdULIUyJ8LTQuxH9vewJp5zSMH0R4OM2Q17itMoYXKsuygs9j0G4zl5zI7mirvR537a7e3LcI5biUxsVCOxiJluZZqF+l3sB9GUPtFA0P6YPzs/MUSPmvV0bBHHvIOiNy8bJfv6ICija50RTSmgSBuOOvXaPWMjg8mmscAIOwerqNO7RROm/QPLr7WlqX9lO/5sZIUten1J/r9hh8ZrvIWybjc5RoiDbcyMtYPFblpPnKrtO5qqzDVA/ZUmxWw8Bt4tLSHLrxdTVY2yv627DzTuuk6YuLBlNVyKVamjiim+FJ4OGK40kJhUrUHmNphllWq0Xsv4sesxL1msQBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZUZ1Rbu/+8M6d7SlHfvr29xk1oef76PC+eYqVhaL/Y=;
 b=XNPivQ3MyxHc0rINecwc1YJBTf4yEZmATp+pC/6dVLOYk2tmNX+fkYMj9OH7M4sS7iL0gkTQvfxP3//bnhFIz7CBv6c+BfbcZ9pvbaftfYKnYJ+Ji214xNrAe2zqZRfVqrzOcItw+Vl4NBwPRLBH8r5XSox8akEZI3OJ9iN2TRu21G6JdfIpHgZpkh+uXWfq1IBE5MF/R7tuLBEqPEC/cxnQZpdIRjNxJAiBw2YGT+vL/rkQQMIxJ4Cgsl5arkmCHtoVYAuvKOr8mDaw30Gs6sRmGhsm6eZXcrc9V5vMRL3z/KwDODUDZIaTcZYC3OnpeC5iy7ksvW6H3BMWVNOOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZUZ1Rbu/+8M6d7SlHfvr29xk1oef76PC+eYqVhaL/Y=;
 b=eH+JoTJGVE48wx0LdasnCLCXPbzkyaTERiR3LQHcmWFw9MS9E+CEQYQXnJhzijRfVouB+Df8gkedokSMZBz8nh6V4Lr7FZg0HIj6Gv5A8xpQrnh/PU03apmm/jNbFiCWoDx++VE8iPYCui2j6WsDsJ2LfZw1YguU++iMAmTAHJsqcHA/ltpSyu/CeC+327R6CA9Rg63NWJFLwpiKKUHoaaY5/Kqpigcg/M22IdG2XSu0NEMDk6h8gGboerjyCKipcgdEKcrrDEfNbAU0eNFiWDtbTmoxI0fRD7Z0k5sajZw/F9YooxXrxoTVr8mE1Fk/5OjM/W0GHTJgPdii+qNMXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:53 -0400
Subject: [PATCH 09/11] ARM: dts: imx6q-utilite-pro: add missing required
 property for pci
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-9-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=1718;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dYcvAmDC93BXEFvwR7Wi5iQXi17SC9Cz3fC3GbytFNw=;
 b=lmm1LzXZXVz36WKf0L1JZ35JhGqNYeI4v/jg1hWl3PbipF8aEFbaB80PaZv7Bgg1b8Cnzp5GC
 mXcJN/avk9YB2p9s9DDww6hntrywk3uFE5aCQuNpgE+p+Dk1DA4D2pr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a38a92e-56b4-4651-7539-08ddfc78866d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STVrd1hzbzN1L0UxSjNpTUk1UTRNaXlkYXM4K0x1bFNMRWdRSWJiQ0x4WDFV?=
 =?utf-8?B?UElKMjRWUFppUWhOcHN1ZjJhcDlsK3g5K1hPdXdQc1BnSXJ2aXFGbmNVNHgz?=
 =?utf-8?B?NVJScjBmYWZzWDE5blo1ZDFsQVFmbEJjenNBMERjd2VIdTFtQ25wWDJnQnJq?=
 =?utf-8?B?eDI0WURnd0RvQWRBN2M1azVzcWJ2UnFOY0tobjZycUdML2tBVWxzbnhmcmQw?=
 =?utf-8?B?bVI4L3ptTGh4VkJINUdDR3pkMndpSUVCUTNZZ0F1NHVxaGlkcFdvVG5SYUJM?=
 =?utf-8?B?ZTF0RjVWclVzL05JeDloRTJpM05Qb2VBakxmaDNUbEVBRE9ibXRhNE1pcCsw?=
 =?utf-8?B?dVJvRWFMVVUxYkNMZFVFSjlSUkxUMm1GYVpKeFNZbGpjMHZxeHRxd3MvSWsv?=
 =?utf-8?B?QjZYeEZ0Z0NPY0J0dFlzWDJKU2xHZnluVGN2cFk0QklOOUowSkxHY3BoaEEv?=
 =?utf-8?B?QXRuV2tQZGVOb2hzZWQ3TUNqdmZjZEZCSFJ4ZWdIalRxZFdzR1ZocmVON3VO?=
 =?utf-8?B?WG4rWXNaWDIrZHA2VDEvYmlyVW9rbEFWR0taTHVrZVhqU3NEL2dtOGJ3SHoz?=
 =?utf-8?B?cDk2b01ZUklCK2ZtVWtQV0dpUElMS0M1WHYxRDFKdkJKZG8wR05uZkIzQ3Jk?=
 =?utf-8?B?MTQrQWxNU2lTRTFQb0VPT1JEU1g3WThnZE5TYTRqSXdBVjN0YU1zQ2kyN2E4?=
 =?utf-8?B?UkFZNE1LTWxycVBCZ3RvRE1vVEszUXFHeDBBcDlBcmkvL05DQ1QwUlF2aW5i?=
 =?utf-8?B?QWxPelZjSStqcVNPdXR1cnNLMHJYUlZlV3gyUGFiSGlkVWtDemVpeGtzRmdu?=
 =?utf-8?B?RjhmL3Z5T2E5MnF2UWNrRFZ1N3VDbzErWEZhUU9jYmpRaEM0SGJXU1dabG5Y?=
 =?utf-8?B?b2tORWlTUXhDM25ZMWhYUjhKd2l5YVgzTGJBaWNidTc0MS9Xa0dIeGZXTTU5?=
 =?utf-8?B?dmhDamhMTXlCMUJPdFB5cVZLRW53ak1HT2VLQW5ic0JxVERyVXIyRWhCWlpv?=
 =?utf-8?B?aDdBbmlhVFNFVzZ5VnFOcnZzQnFmVWVQOWdrWm5FK1ZwWUp2RFgrUENSNzNT?=
 =?utf-8?B?Ym0xbnpsRFV1MmZRaCt1V0U0eEhHS3pDSHFGSG1adkI3Vk1QUWxxL0xodnNS?=
 =?utf-8?B?eDhuOVBTSkNVZ1dLalNRMDBndlRiTEFSRkhBNGdsSU10VWxnSTN6UXREbGNj?=
 =?utf-8?B?TjY1SHdBMGg1Z2VrUXRXODh4NER2M1JQRDF4azFUeDNZOWpZRmMxZ2ZLd2Va?=
 =?utf-8?B?Q1B0RDhNbG5CbzI4dXNLNVlsNytXM3gxUFBTcDV0MTBYRzZWZVBZanAvNTUv?=
 =?utf-8?B?YnBjNys1UURpYlNva2FkY3BoNjBwdkp6NmE3RDJ2WWFzaE1BRWNHdEtrL0NU?=
 =?utf-8?B?cEUwVStzZVFoTTZDamRQYS82NUU3UDJidkZGYVNDcjVnWWl4Z3dNUkV2OTVz?=
 =?utf-8?B?MmZvR2FSNW1rVFFMcGo0TGp2S0ZpRlNIbnJHSU5hS2d6V0FKR0kzano3RWs5?=
 =?utf-8?B?LzZiOE9WbllwU0JrMHErWU1SMmwwTW94WUp0TVAxUzExRHQwdFRueDc2U1BR?=
 =?utf-8?B?NEEzbWJCZ2hWVHJXczF6aEp1eHN6N3BkMmc5SmhtVTlrMiszQ0dHaElnQmx5?=
 =?utf-8?B?MXRnZTdIUWY0d2NQaHlRWWhpdkZTNUg1TGxwY3gzUEw2MmxQakIxNldEcnh4?=
 =?utf-8?B?QzJreWJidmJGZ3lNOHVXS0tLMFNNRUp1M2Z4SGJvT2tkWTYrdmkrRGlaV0Ix?=
 =?utf-8?B?cElOUTNuaEZDWmpSQU92VHl0emw0VWRoQmtNYisyUGtMZGxwYjdFWmM4cE82?=
 =?utf-8?B?U2M1QXJiV25wd3pTbmlGcDl0dlVqTk44RXJiT0hrYlc4elFEZUZhTG5ISXpZ?=
 =?utf-8?B?aDZYd3pweWx0OFQyUEVFdFZjQVczRzBKZTlNZStFWTdpU0hXRXltRHNRa3Mr?=
 =?utf-8?Q?N3UsrMhB2k2biB25m/YVyl0f09i8G1+D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEtRMkU1SFA5UTFnMStJTWNzZXp1M2RIeFVHamU0WTdNL2Uza0lKTnlMRXNQ?=
 =?utf-8?B?WTRhUnF5K25FMFl0YmFjbUI3eWlXb2ExelFBcExqNkY2OEVOR2hQY3BLUE9T?=
 =?utf-8?B?YUZGaWFlYTRPY1U2RmpJRkxZdTNQMTdYSnhTbGxiYWRjcVF4MGF4b0hXMllv?=
 =?utf-8?B?TmE0bS9jSFlMRE9XSUhjZ3hrUmVUVm1yNlFzSjZGZXkxb1V3ZmpxYjFTWHlu?=
 =?utf-8?B?M3UrUS9XOEM2dXdldmNYdXBjdDdtaE1mVlh5UTNDcEF1cnVOUnlsR3FSbklH?=
 =?utf-8?B?RUlEWUhZUGNrM3oxS3hpY3lvYVQ5aEFoVEhPUzN2NDhGQlF1RDVkcCtUQmk3?=
 =?utf-8?B?d0FzdEJHanVITW9wdExuNExncWtIOHZpVEovd0V3b2VMbXZ6Uk1Nc2JvQzRa?=
 =?utf-8?B?R3lKRXcxTTZYdDI3Mlg5V3J4S2t0M1ZMNHh6MkxCVmVSNlF1eE5CMmVOR2Jp?=
 =?utf-8?B?OHBwYlhGMTVuUTZZbER0ODlPWEtEOXFxV0hIMHFPOG1IOVUzUHFYQWNUcnd6?=
 =?utf-8?B?Y0FTU1JPMEdKSlF4SFF4MnRSODVKMWVPRlFXVllZVDFnampBSTFwVGRrUjJi?=
 =?utf-8?B?SGlOS210VGtGelY4Qkw0WmJFWjVOYlZLLzR6RW9iREVURFRYUUJoQnFJaVpp?=
 =?utf-8?B?cExTNjNRUGlsdHhaQjZXQzd4QklQdkhoeUNNdnlqa2lsbEUyL0RqdnlyTkFh?=
 =?utf-8?B?V0JzbjdwT0Y4SWpqYWxmWjlMQXVsRnJ5MlNxd0l2OEZHRVErcUo0Sng0OEdW?=
 =?utf-8?B?VzQxT0JFSUkxd1M1M2xOQnF4c2MvOFdGbVN3aVhEM00zdkRGTUtTR1RqaEtQ?=
 =?utf-8?B?RFloY2FnQU14dTFTbkVzb2JOZERJdlFXQjJJRnlUSzk4SzdrS0wvY1VuUE5p?=
 =?utf-8?B?MGFFalFHY1dNYXpkU3g0VXg3Q1VYYU1DNXNjNW8ycXpvdWF4WUpNc21SVm1D?=
 =?utf-8?B?d25JKzA0RFBnMkxlZjBFYjh1SElaMzdZMUd4S242aXlORUJ2Z0h0cFA4U2Jh?=
 =?utf-8?B?cWdWQ1NVUDc2aWU5SE5VWVgvNnR0bnhRR3FzVndJQVdPODYxWU0xQmtVQWNL?=
 =?utf-8?B?SmFnYmNRZjYzcit1Q2pSZDlFUjRiOFYvaUxZYjBGM3NKbVFYayszQjI2eUpm?=
 =?utf-8?B?VHQzT3NEOVhxaEVld04rUEx1cmd0ZVdNYUwyRzNveVF6V3VrT2JaeTR2Szdj?=
 =?utf-8?B?Ukpla3hTREh2M1RmNmgxenlheG9abnZKdlJuNmlKaUdrZnlabXdVL2xSMFFo?=
 =?utf-8?B?ekRiZE1ua0duOGpzSnNCVUZ5NEZDNUhFand5TGx3amRLclkyOUx0WkgxeUE0?=
 =?utf-8?B?UlErYU1ZTHVRSUJQMy9Dd1JJQkd4cE9peHpWVForaURBYVdwanVlSXIyakQz?=
 =?utf-8?B?V1FKcmxvWGhYak5TbEFlUDRQTHVQYlFNMm5KYVBweGszd1FGSGJLSS9CS0pG?=
 =?utf-8?B?MUlUdVhTZjhGRkg4U2pBRFVHNDJvYmIyZHZqaWZGUUhMdDdTekc0MDdyWVRh?=
 =?utf-8?B?WjVIT2VNN0J0M2RjQVp5c0lqRjRSS3E2MENXVURmNjNEQ3NzbzBvZ3dZZ0h0?=
 =?utf-8?B?dU80dHpzZDRaYkhtbzhSaCt3dGdidXBxTElZWjJ1SFJlZ2pSaWVlWVREakZh?=
 =?utf-8?B?djJjQW9jR3E2WW1RWDJwSld5S1FEdUlFTHNKZnV2dlNkc1JXb1ZaWnlSUTR4?=
 =?utf-8?B?bnArY0duZDdqc1dtcXlKZ2pFeWU3VVFwVmFnWU5WQVI0ZmR1cjM0d3BsZ091?=
 =?utf-8?B?K1Ivdzg2c2FIQkdVR0IzeU1QbTN4M0twZTVzMUoxcHRhaHp0ZDk0a1RtckZD?=
 =?utf-8?B?cWs3VXJjSFFFT2lOVXFtekRVQ280WlJmNERiV2Jva2s0KzNmbGF5RjJaU0ln?=
 =?utf-8?B?UEtWNmFVdTVOQ203Tnp1WTBiZ2xIbWZpZU5BcEJ5Ukh2TEVYUlhZcWZuYW9Z?=
 =?utf-8?B?eWVCalpzSVJtTkpQalZWV3ViWERxL1cwTWtwRGFlN3dMNUtXNzNvVkMxYTZu?=
 =?utf-8?B?anp4Q1FLYm5LUlgyUTRiRVEybnVuNkJINm1IVjZWSDBEa01rQmtPRUlmQm1G?=
 =?utf-8?B?M3RoVE9lcWZLckZuQTB6TTJtSUhMZ2RLUnllUXk2VVRwblJ0d2JKa1gyU1FW?=
 =?utf-8?Q?JvoYbgCBhjZIlqe7dQ2OImZze?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a38a92e-56b4-4651-7539-08ddfc78866d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:33.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iakJx5fswBme5vcFDxwin9UWTWmDk1jW+mWlC11GaoEXK3GpcQfqVSSLDuRIK+w2nUsCWM9v87rR2PMAZGYTBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Add device_type, bus-range, ranges for pci nodes. Rename intel,i211 to
ethernet to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
  arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
  arm/boot/dts/nxp/imx/imx6q-utilite-pro.dtb: pcie@0,0: 'intel,i211@pcie0,0' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9#,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
index aae81feee00dba2761f140fc2a76a828f69a8308..c78f101c3cc122f418b708b1c274ca11b586b65c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
@@ -326,11 +326,14 @@ &ipu1_di0_disp0 {
 &pcie {
 	pcie@0,0 {
 		reg = <0x000000 0 0 0 0>;
+		device_type = "pci";
 		#address-cells = <3>;
 		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		ranges;
 
 		/* non-removable i211 ethernet card */
-		eth1: intel,i211@pcie0,0 {
+		eth1: ethernet@0,0 {
 			reg = <0x010000 0 0 0 0>;
 		};
 	};

-- 
2.34.1


