Return-Path: <linux-kernel+bounces-776426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B6B2CD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE50720026
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD5342C83;
	Tue, 19 Aug 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jEVYAJSk"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6B340DAB;
	Tue, 19 Aug 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632678; cv=fail; b=VNC0Tw/3/a2WYeruuJPTDyjnMUHRwfj9yPVqh1czd7gezDHq2eFQhZ3L4R+EOnzuRkU6boUEDdj/4dktt5VW2paucPkQ2NQ4XG3PcmuOUAdMD2qu4LEap4fLOzfB8yVg79i8eCSo0bJxpeAy5XeKDibd0zp5eNVaiyYRjhjQOLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632678; c=relaxed/simple;
	bh=NB9B8wL9EWOxYbVb0WueARrYzjBu3jE7/370axfMJQU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pO2mF7wf4sNEcj68NfJml5sR3+w5W+tMqySyZS2J+ujVAtkXJKfb40a3S8lyHq7AHGX50bqYBXzRi3o7nWcNYKTG1PVHUL3Q2iJrSkAI7ZSprSObYSHKe0xlN1wTJewKJwPlNQa1hyp36u8bjsQYOf+YTPAvUPsG8xFueERTkjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jEVYAJSk; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIGzj4ZLBlP6w7ZPNQr6VD0CMyJds44E7KsO86L/77U0/imkpYk4FjTm2/8zWu/pze3Ev0ekkHGqHtXD1ATO4ye8zuRFL36mFb6LwJSVooV2AhR5jgJ7SokDIBoeYmZ4OU3Y5/5sFyeJgWzMFJQhjeJupNHS7pnpiiRocTCPz29LxHSGwoGltvBvf+Vj9dT6nSGgl/mWvR6GZO3J5YyOsgcu1jviCj3UW1d3mwNY4TB3+zk8Gku3eLJa1jdfOfT+9Z2/FIJ1xNVjfdPBqrBWWg06MZBbAV1sT0k6fIZNJgM6xBy05zOWIQ2EuQwSKK+fO0FjBDECnYzL14Dd2dnYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDk79hHhuXXR5fjCtggmrvywUHyyLtm5bszqNd3EMsw=;
 b=e/mfmPmkT2peRQOLEhaDgQdq1EmjgOZuigXuNYmW8v4mUbDUoDa55QKuDLSaUhXjBJ3OSIXybJK+3WOt+hRj5uYjE9BPxP5zbFEjiyvltg3VNnVdZSgupNdgjEGMeMNjjWQD8xDMQ1jXLLTyeJ5RhJcRUJSIayT/J9z60/nzhp/A4jeN4oqsR2N8UN5AcTm54h3l/t8t4V1qGyFR7n89nqulQ0o3wdnF70JG7qkKPeyP1fJ0/+0C4WGSHy8JEtflpJb/92JslDcu0eP2WrJRlperTb/hfaAxyF6ukkAdFbLo473I0AtCQtY6hSJFfMVoMtApHGKpObd0uARxzz1CiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDk79hHhuXXR5fjCtggmrvywUHyyLtm5bszqNd3EMsw=;
 b=jEVYAJSkk8lrJGeRClo00/jpcdVguvJ7DzdudAbc0CeYQujMXwtgM16QJC9v/xPbHajiVHS/xHJ9wPj+Bz8iCtItKafs52Fz03nkfDHpkato9a/psvdsaWsqcye9fmyP8LqMYTxHP/vb8Z9unMwWBkTzMiaQ/luhQYpcoe6q79QYwrMtI+9X0W8xLkFlG6AS8ILcg+bQP01EPhqE68MgThQ8CO52L4T1M1geiuH/SiWPDPwBYiSjfjAHLoDb7YDk2uB1DDXz9z/ukbMEIdbvKSQxkgHGbAjd2xLVxEik9zFtWeUgzeTSJCgQneewU8N1Dj+f4kBBHEv7PHSaZ75gSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 19:44:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 19:44:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Aug 2025 15:44:06 -0400
Subject: [PATCH 1/4] ARM: dts: vfxxx: rename nodename iomux to pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-vfxxx_warning-v1-1-080930d8e1ea@nxp.com>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
In-Reply-To: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755632668; l=961;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NB9B8wL9EWOxYbVb0WueARrYzjBu3jE7/370axfMJQU=;
 b=d/5qRjnBWzmJ5Exbf1Onb0D7aQA2FXvRvdXULqViEtfGF6ImD5vcqppP0eDnUoKyOlFmB+GWF
 TGO3XVf533cDwErQlQ/ZIOcU71R5IwQ6z+hesT7eV44XSRbWSFlKIgk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: a26d7036-26f6-4876-67e0-08dddf58d1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enZWT2xuK25SbDEvZk1WOWtLOUo2Q0NsaVBsdTZnNWttSXJsM294amdjNTJE?=
 =?utf-8?B?VmhPU0c1YUhHYWdwRlFuQlVCQStBZ1ZZaFRkUXJrWDREbnpaaGdvalRpVWRq?=
 =?utf-8?B?c0RCOC85RFh6NXV0NDBHS1dvNDlCYnlmTm41VUhnQmtnR2s5WmxFakpWelc4?=
 =?utf-8?B?V3ExVWdWUjN0eFlwNmpXYnNOWUlXZy9hb0N5ZDVSRE1wdEtvQUlVSXFKU1Ft?=
 =?utf-8?B?QzVhdC9DN3hQYUthNDdLakh1eGhCWjFDS3I2c3RWMHRmdnVBQzBtZzdDQVJH?=
 =?utf-8?B?aW5pQmZ2T05qRGNXRUZNY0dVM1d3THVScGNla3Y2Zisxc1Y1bDlOTmV2YVpx?=
 =?utf-8?B?Yk1oUjlRRzVCdzhCUEkzd0IwUFZ4SmVGZW5QempFQjE3VDJpR2xkbEpUSEZz?=
 =?utf-8?B?NTdRelFQK3R6M3A5ZHVEaFZqUk9uZWx1QkpqRHdsdjcwcDhkMVFvY3RlMVpS?=
 =?utf-8?B?SWtpYmQwU0EzQk00bFZDRU1NYzBSVEdNMVc2enJZbVZEUlBrcXVEVG02OFhM?=
 =?utf-8?B?cUVMb0JramZsdWhLUEJTWDQ3dG5pamhPbFdHMTcrVkxrd3ZVOHc1Z2JZWnhW?=
 =?utf-8?B?RTdZZzhzUDkxWG9yZTkwWEpWZnVDOHNwb3ArZ2hkY0F2cEZwKy82SkdnL0x2?=
 =?utf-8?B?ZnUvdzhsVDB5SFp5SWs2NG1RQmI3L0x3Y3R0Y29Cd21TSGQ4aWNkanRaUXEw?=
 =?utf-8?B?WDIycWxuaEZ0azgvU1pYZyttdEhYV0hTVEdqbXkydkNtM3IxZWVUTTh3ak9X?=
 =?utf-8?B?T3ZVNzBnMjlHSDJ4RC93Tk9jL0JyTkY3YXBnK2l1T0h3c0VBbUF5WXJ2ck44?=
 =?utf-8?B?R244azVmRWNsclhtRTlTOEtmU0NJZ0ZZbGgwc1ZIRlFOTzZza0FwRkxCQ3Jm?=
 =?utf-8?B?SmpzV1dVSHlpRlNnTDlwa21uazVhaEJpUW4xZTNOcGU4TnhBRmF5Z2pnSVZV?=
 =?utf-8?B?MjJaR3ZJUkFzTGY4THVMOUd6R3FsdlU5SVd5VjBoSmFqSDlEZGJRR09zalYx?=
 =?utf-8?B?K1pjdU83YzYwKzU4TEp2WGlteHdQazJRaUx0dTRsOC9aTTh2SEdUVVZEVm9R?=
 =?utf-8?B?UjlOcU8wcVE1Q3FMNW9VNHBQVjZWN3lpbzhaaE1ZWk5iTFZWL3gxQXVTS2N0?=
 =?utf-8?B?b3l3bGtXQUFNalRVZktEWVg3NlJCbGpOU0ZLUG4yd0dnZU42QVY2MGljeE1X?=
 =?utf-8?B?MExYeDlXd1pHb0VqY0xyZExWci9KT1dyb3Q0K1UvQUFucFIrUldNS0FOUHlG?=
 =?utf-8?B?Ym5ZYXE4aXE0VTR3MlhlTUpsS1F6MVoyK3QyM3IwM1JMaG95WGtiemVwRlZr?=
 =?utf-8?B?UGlGU21sT29jbjZOZ0c3VGJ0VjQxcjl2QzNRR041dlpoNjh0UjhQaFNFRmRm?=
 =?utf-8?B?bVplVWNvbVlMeTc3YjJrcWh3Tm9idWpkZG5EZUdGZEJyZDI0Znc4cGtTQ0g0?=
 =?utf-8?B?aS9QTzNLZGRWMVFTSU0yQzhZNnhPTnZDT1Q1REJ0N1VMeVVJa3BTWVUvV0tQ?=
 =?utf-8?B?ZUhrYzMvbzY3aTg3Z0ZuUU4rYU15Y2ZkR0YrUzhjNkRqYUwycy9nSG1yVnFl?=
 =?utf-8?B?RVRSbk9UMzg1Q0ZrR2pTVjVTMGhkQTQvR1BVSjdWeHh2aWNoaTNZZmhBdTNW?=
 =?utf-8?B?Zmxhd0pPQTJ4ZnJDd0x0T1J5Qy9pVytyQlI3OThudklNcFF1QU0zbmVrdDF1?=
 =?utf-8?B?RjF3WHJBU3Z4YjZtenQ1Nkd2QTliTitLbHlRV3NYWi9uQTBKZEJCNTlVTEpx?=
 =?utf-8?B?bzdydlJ6eXNrOWNyZ2dhV0N0ODNBTnEyZXN1K3piSlRwcm9aMGcxb21TbDEz?=
 =?utf-8?B?SjVIMXNXYUNhZ1hVQ2Y3RjZDUkMxQTUwb284emVTYUNUVy9tUW9CYmYyVEl0?=
 =?utf-8?B?aFFrZkNmeHZQa0RQZUJlSUo3N1JFZFRpVUdNWFp6RmF2dkJVcWtrWVNXdVg2?=
 =?utf-8?Q?wHPWyWsKU6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWFjd2V3WFJsWU9WUW95YStvNUtFNTFFT0RORUYxb0JnaktOT1ZDZVowUDNR?=
 =?utf-8?B?dC9QYStld2JQYU5PN1NoMFNBbTBYQzdTeUxnQUFrOG96SEV3L1dIOVkyK1JX?=
 =?utf-8?B?ZXFLN2VzQ2lKUGhjT1ZPbm9sSlRpcnRiK0F1UEZEQ3JQNk5VeVIxdVlWL2R3?=
 =?utf-8?B?blFCVTUvOEdXYXFxVnh5eHVyYUZwM0RRMlpSMVptd2tackJmSURmOThhUGJU?=
 =?utf-8?B?Y08yL3J5TUhaMlJTODUvNmQvQVVLU1drdGt3eVVRcksvYWlQOGtWU0RLclFo?=
 =?utf-8?B?UzZLaG01ek5HajFXbXA3WlU1UlkyMlRtMGJ1NW9yYzRQL3hsd2QvTjhKS1dS?=
 =?utf-8?B?S1NFOU5nZzk2SEE4QjBrWjMzd3Y4SW10SUVIcXkvRFBPTlJLclZ1L1g3eE5l?=
 =?utf-8?B?Y3NwSFZrTmJ2VVFjVDA5ZHNoUEZ2ckNqTzFmbFpub1BOcDIza0IzVGJKTEk5?=
 =?utf-8?B?QXFBbm9PaXRyZFVlVXdjRmdySmVqd3hHNFhZUnFjRFZDVGZIekc2MGFHeXpZ?=
 =?utf-8?B?b2JwOHUrVmlKcjdpMUdXY2tQUEV3Y29EMmdpRmdMWGEvVU9HZGpzZ0tNS1ZU?=
 =?utf-8?B?Z2gzZnpuZlVGdWhzWjBqSlhFMlhpNVE5SzVuck15WmV5dDZhRyszYVZSMHBY?=
 =?utf-8?B?SzRDTGJnSU45aDNUcE12QjJGNHlrVGk1VVNUYkNXVmFSZ2lzY1J2ajZFUlBP?=
 =?utf-8?B?SXF1SXEzMUZrc2doVGJOT0Q1RGVnbFErTVdYcmFsbFRGbzZ2dlJ4TjRCdXhH?=
 =?utf-8?B?d2RJM3BxdG96VTBuQkNNaDZsY3dLeFdPdWIxeGkyV0hKT0lnN1VhSUNObFVz?=
 =?utf-8?B?RXRqajNLamF1UXJ4RkI5RE5WaGpMSGJPN2xxejJwYjlXSHRSd2tJSlpKU0NG?=
 =?utf-8?B?MmphRmczeEpQVWFRNCtWaEdsNDVoSXhVTHFJeE9xenk3d1crTWliSzdmZDZG?=
 =?utf-8?B?ZW5rUW9OUGxKSzljKzl2UFZ3VGJlcnUzNlc1TXp3Y1pIeTFlSzdyNVdRMkNq?=
 =?utf-8?B?a2lXTjNmT3N2VmNVa2IwamV4SWRvb0RjN2hnNE9nMUlBYkJaYUZETnd5aFBB?=
 =?utf-8?B?VkQ5K3hMQ01DZXJYdGwrOGFKMWUvYkU3RUlTTnFkeW9MQm12aE5iUnlCSXA2?=
 =?utf-8?B?OXpGV1JzdlNYK21JKzZZV1FJZmlrbW9ON3BwKzVjbFI2OW5jai92OEZlNkh4?=
 =?utf-8?B?aWZRUjVjR2NQTEQ2RmltemZrWjdyd25DaTdqYXhHMHp5Q1lJRTgyZjhtNnJ4?=
 =?utf-8?B?RlRBdHNZbWdJTEQ4MldVa09VTCtZcm8rMm9VUE9HZUpwZFQ0eW45K3BweVNM?=
 =?utf-8?B?cXZoK25qcjloQ2VCOVBpN3dPR21qaXZyUnQxZytoZHg5Ym54S3pGQ1FVaVFX?=
 =?utf-8?B?VjZ0bkF3cGpYY085QmEwdTlpUFVDYnlDdk1zVHNUQ3d4bmw0WStRcE94Ykd4?=
 =?utf-8?B?VnB0OEVsR2w1RHVESnc3QVJuekVycWh3QzdvdW5EcGpkRkNwWGNxVGxGSU9j?=
 =?utf-8?B?WEw1TWwvWWtDcmhtYyttcDhEM3RqY2RrRWU3bCtuM29FTTBqdk1CT0hBRzF4?=
 =?utf-8?B?dmlEQWRvaUI5by9mUVl6b05sS3B5RDludnlvckVjMFRCcXVlYWsyNk9hTkc5?=
 =?utf-8?B?eHp2S1djVnFHSUVPa0lWQzRaalRmajhBMnkzUnJyOVVmd0JpY05KZWZJdFBD?=
 =?utf-8?B?T3NWeFRGem4rcW90UEtZQ2t5T0szZ0VuaDFVNE1YRlI0Rzh2a1pXUTdtQzVr?=
 =?utf-8?B?bTFIN0FFcmFwQzRJazZHYVdRZ2JsSGVQK0xqMVRBWDJxMWZpVkU2bTZxR1dh?=
 =?utf-8?B?NjBZemdYb1lmLythK1Y1cWJLUE02NTRONG44WkpMWGY4V1pwNEN0VHp3aVVj?=
 =?utf-8?B?ZHdpM0g2bUhiNEtzTHlkc2dTZCsySmIrZVJFclRMQXArK1hMc0VaVzJRSFdx?=
 =?utf-8?B?M1Y0WXdER1BOUGlBc1RCTGpQZTJJVldPNHdyb04vZnAxK2sveEVOdndmd3Zw?=
 =?utf-8?B?eS9qa1VKWlVldUVHM1hudXJROFpEMFhsYXlEWi95WUNlSGs2SXhaZEZnU1Bo?=
 =?utf-8?B?dHVtZ0lTa2RZUm41VnRpTFl5MGtHQVQxYUo0RUlnREFRMWxXTzZpOUdjTkVx?=
 =?utf-8?Q?UpFg2y4PdFY77f0Mr6VxGD9iI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26d7036-26f6-4876-67e0-08dddf58d1d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:44:32.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l5xniRx3HGRUNr4+jVAAxJrlgt70sOt7u9wb2NFmBgQsrgXWxa4gT6+AXyIOFjCV2eWhwCEK2QFRl4b0rKBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313

Rename nodename iomux to pinctrl to fix below warnings:
  arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dtb: iomuxc@40048000 (fsl,vf610-iomuxc): $nodename:0: 'iomuxc@40048000' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
	from schema $id: http://devicetree.org/schemas/pinctrl/fsl,vf610-iomuxc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
index 124003c0be26a0cc3b3036b30411f50363117887..19de9506e0c895ee0ba959b4f69424d811f0f064 100644
--- a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
@@ -304,7 +304,7 @@ qspi0: spi@40044000 {
 				status = "disabled";
 			};
 
-			iomuxc: iomuxc@40048000 {
+			iomuxc: pinctrl@40048000 {
 				compatible = "fsl,vf610-iomuxc";
 				reg = <0x40048000 0x1000>;
 			};

-- 
2.34.1


