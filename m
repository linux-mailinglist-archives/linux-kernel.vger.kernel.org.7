Return-Path: <linux-kernel+bounces-782224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EBFB31CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A5B26B03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA031771B;
	Fri, 22 Aug 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gFdy8J+B"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247C313545;
	Fri, 22 Aug 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874227; cv=fail; b=nP/rE27oxOKCZiFoe0Vy7DIl6FcZHzNn+mEtqIq1Wfd0fCParlf5bFTUp24z6SRTFS66ka5nAh0WpYl0M+SogryQLMwf1lPkggkqPfQ+iqf+jPvOHfytf7OPPXnD28vLYfYKxgW4oKg6k88Ya0zzaalOLy/kTuDc7NskYhPZOn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874227; c=relaxed/simple;
	bh=u8KaPIg5WEbrrBMCxyVbENjWjCDwS4br2WKQxeAXjms=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mCrbW79WE+6+I+4qLQYjV+aXyjc/EED3Oj8R7CH0GRCsRgsfgSUFEKLCnVeMGfuEMbUHq6NdqF5Ey0AIm8p6Tvux955r+dzJrr0c1oVJsk56rPL5TWspLfrvmkLAzSgg0kOzMKAT+4YA+rICZZtv/I2PAhOj0FgiTYiyUukLfl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gFdy8J+B; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHVY2NgcfM8MJTodFelclazFHyY7j/kj3R2WrZb0tnB9AyGQyj21COfqhZgV0qmvGAuO/X56/cCPFepljNK1q6F1wbkbCbhkf61bx3e1GLTXfPsObcPH41mpIhyMpnJsY6Mkd8I4COz4n03r8z7tPutl0hDAnf7x5q3CXNqQToh2MbQJx5+UAB9xXJvvR16Yz8M77D5Xq6uKxJK7qkdLeYXl0fWYvfHu6Mjc6hL7SrEtTZ1lve50ghbH8zrFR6nUujuMSZxppyiyqWATgMMRo3XTg615dxcgBhiDbkGNFZzJJPhz0G42NpUvb8wI0YQev+sbsOfNA1q98R8rKdrmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbJhogPXWV+l0PE8+VDWiLqgnaLDqe0J9oaTWmq/4Mw=;
 b=T979Dr7M0JUFQuu3DHIJqkdPizYJGECYCOfb5JZhAKSPIq/86fyQWBMzy24ODAJmQPmGmjoGhgs1GBt+jXDW3dG/m7fWH1BF0mZyc6nWKMoC8hIT37AzJNg0R/WGeQQWxFvC4msUNkTsNEt03cZNpuFKWiAX3/Vkcc/V3y0if09DOEf8UPnc30mQViVduAhPTSnByCBNUoW1Ae5BS0PrmgPio8fQ7joULSIQO7M69/MqxjQWKPeJ078h4L1FOzjZA0yBKuHe3ymHF811aNk9qNyWTDb1D2xMe1JM8xsv4gSvU1vKoiLt2k2QV0HBccBhpY4fgo+GIzgqULyoUVPjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbJhogPXWV+l0PE8+VDWiLqgnaLDqe0J9oaTWmq/4Mw=;
 b=gFdy8J+B309e6Ssw5gWQ0KvPMjfTX+R2vvyMDdqcRXsmRZo7eWK+m54Aeak+oMsQ4Q6AhARmk3LHHjZKacX2pg1NyHg4511OaIERtYyTxIDPbrVsmzkhqFiuAdDOWpKaXYJtWMmnYJHo03tYfqGB0jwyRVWWIFVwDeoi5NKpqwCrr20CAMP1vulJmLg6kDI6LEPn92WiMN3mN5J2QVqwEZA+7DphAbmRn9/nkfs7DLiFn9siZbkUTan2hYm2t8hxDW8dbZstVij4eRxwPq5//WDhxpBpBRyxcvQAb9GmINiiYzxcjSr+e+J6tagzy8K3rWX4Lii26K+sb+nGAZRRcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 14:50:23 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:50:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 22 Aug 2025 10:50:01 -0400
Subject: [PATCH v3 4/4] ARM: dts: ls1021a-tsn: Remove redundant
 #address-cells for ethernet-switch@1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ls1021a_dts_warning-v3-4-6b611a2f23a4@nxp.com>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755874209; l=1081;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u8KaPIg5WEbrrBMCxyVbENjWjCDwS4br2WKQxeAXjms=;
 b=DnBoA5QSGLukI4l6U6X1y+5+BzqkpTQl9Q+vzch7cvKLkgdpJhVxq/8eOhELDyfrz1mNZDjcS
 qyNCp0+GQ2zAsKU0LuwddmObhYKtc2jA2DpVNK4kD+MTGr0tblAJy/Y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7d77ad-0194-4aae-301b-08dde18b38ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTRrZjR2YWkva1NMNEZXRVBqQlpOekR5UndOSHRLdjBacjFqRGNuaTBvQ3FR?=
 =?utf-8?B?UTJQVFl4YXl4Rk5TOFJOZG1WQnJZUEpnc3JiUUZ3MmoyRDZoSFEvNmNqL2NB?=
 =?utf-8?B?YW5rbVFnbWFJZnhrekxraVcrcit1Q0tvcFY2cUU5RUZnN3dTRWRJYlBGbExP?=
 =?utf-8?B?OEV6Q1ppanE3ZVNXZE9nUG9pZ2Y5cmtEd0NWblRPV1E1Z0xGZndGK0FyWWtG?=
 =?utf-8?B?aWtHNjBmcVkvQUhvcFIwZlpoV1JsM094M1F6UHYxaWYxMElWUHJ5RWtnNHlM?=
 =?utf-8?B?bzArME5CVlFzTWNaSmJTVC9xeDNLNHY1L0NJK25ZSHh2dXZENUhCRTVVQzFF?=
 =?utf-8?B?VFpEb2NHdnNXS3l1YkNxdDBKRmY3cS81U0dxQmxYcGNic3N3NktQYThKSDVB?=
 =?utf-8?B?MkhmM0dOYTNjYlVtQ0REcFB1K3NEdmlIQkdoK21rZXJ3dDRRMFdtejI3RXpi?=
 =?utf-8?B?OGpkRUtjbmxTRlRIZG9qTWRvZzVOVkNKTFdBMXBxdXNHTjE5a0I4Vy9ScXN5?=
 =?utf-8?B?YzVQVnlVVmZuT0hWdlVrdGNFTFdsbHczb0owYU9EN2FJbzF1aWtseHB1NEJU?=
 =?utf-8?B?VGpZN3lYNE5Ba29vS0hBNzhaRVhraDg1Z3JodzkyeHAxdmQzWm83eFJwWnk5?=
 =?utf-8?B?TjhSSUFPRGFUUnpHZjdqVUlvY0NCYzBDTGNqdjVHbWdCWmxNeHBaVUhzalpv?=
 =?utf-8?B?TUoxSGRsbTBKNUdheHBET05aZTFqZlNHUkZKMkptYy9tQndrOHpiZ3QwcFNM?=
 =?utf-8?B?ZGpHWG16U2wrOUZOS3I0NEpjS2YvZDVUek01VGYxbmxEdUpNSGdRVmFwajhM?=
 =?utf-8?B?QWJhRlc0UUNZNVNjTjQ3bEhuK3NqZzVwRGtWaDB5MU02eGplb3kxUGhxSy93?=
 =?utf-8?B?V2hveVk5STFHbnhISHdKZUR3amZ0NzFvU291b3R4dDNpOUtSbjR6aE42S1pk?=
 =?utf-8?B?NW5VNWpGdi83Y1d3WldsSE5rRlFVRWhQdC94VTZid1RJbnUwa1VXbG9GMy9L?=
 =?utf-8?B?dFcxazYzbmIwZlpUUnlGejVHUjJuTEMzaUZJdUFyblhaM1hna1k5cjQ1Tzd6?=
 =?utf-8?B?ZHZPTEs4N2I5ejNsNXlVUHFJbXVUN2ZHbVZpOUo4UWV1ckFTUkxIcFNNUVlG?=
 =?utf-8?B?ZmExMnpoNW8xNFhmdGVndUVXZHN5V3g5V200RFJ4b2JyalNFS1lLVnNwWVJF?=
 =?utf-8?B?Z0dwbUZhTDUwMTRGd0QvMFMvdGVON3dwYzB4c1VTVFV3Z0V2WFNhS2Q1d2ll?=
 =?utf-8?B?ZzkxVlc5UjFaRTRxYUlkOTBiNlV4RFU0QW5MOVRhVkNpdXhsc3ZsYU94czRi?=
 =?utf-8?B?THg4dGZsVm8wa0UvMmVjQTVQNU5GR0tpMkxtQ1ZtcWJuUjExMmhEa0dhcERY?=
 =?utf-8?B?d1VycVlXOG0yMVZwOVMyV0NxWDJ3YWEydnM2b0d6N3V5N1BsM2hreTJZeWVQ?=
 =?utf-8?B?SWdnbmw0R3BDQmZ4cFhyRGFRZkpCYlhRb0FxeFUzZmMvWTRTbHdlM1I4Y3RZ?=
 =?utf-8?B?d2QzeTB5NGxNNDl0WjZYdmh1dUFmTENNN3o2N1lFVldramRjVi9YTjBzdG9n?=
 =?utf-8?B?NXVNQlN4RHlMWkErSmFqSlFCSFhnOWpuNUFadmlGS3ZSZWl5cTU2NGlpcXNr?=
 =?utf-8?B?Z2NoaTBpdFlLd1pCOTFydklabDZmVDhGSUREV0xlbmhDR1JCYjJjU041bEZ0?=
 =?utf-8?B?bUI3T2R5K3ptUmwxekFIUGxNU09mMjJjcVRXSXVEMnp2VXF5bjlhMllLVWJa?=
 =?utf-8?B?NjBVcmhvdG1oT05UM1haTzhkVnFaN25obm1Vdm83SVc2czd3TTJpT1E3YlpC?=
 =?utf-8?B?S1dpckkxWjNrS3NxMXFhdk5qZ0ZwM3pJQmZNc0czN2p6TmVGYmdkVHVzZmNQ?=
 =?utf-8?B?bWEwNFpIL0g4N2ovYmRJMnlPMDVsNTRLYUFiZjJPWjBPWWpQVGd0R2VUamtv?=
 =?utf-8?Q?yZV+l8O1z8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NjelFSSDhOeHQ5MmdVM2JvbXJVRnAyczYrbFk4UHdPV3pOTS96ZXhHVGlE?=
 =?utf-8?B?QmRSdjh1bTkvcVVzZ21rZm1rcU9XUE5RdmJFdEZ2aWsvYWhOSEJlZWRFalll?=
 =?utf-8?B?YWhBM0xQdXJLcXMrY1V2cng3cVkxL1FlRm1uMDlLVjJ6blhrOUNYdVUvUUZ4?=
 =?utf-8?B?aktHT0F4S1FwclZRMldneXFRY0I1S2dsU0tyaGRrRW5IODg3Y2RhT1E5dExX?=
 =?utf-8?B?ejA2QS80cm9jOTNJamNwL0xNd2J4TnJtZzQwT2puMUYvNGo0V1pJZG9qT3hP?=
 =?utf-8?B?ZE8vTzd2ZkhBcjRHdHVIZHlLZGh3ajhMSWtFZnoyeXBicUlYUWNmUE5hajVu?=
 =?utf-8?B?ZHluLzNFQkt5Tlo3UEtxSEVTSkt5bm0yNjRDTW0zZEZlMmMrcmxVMkNEYVY2?=
 =?utf-8?B?aDBwVUlNZUdyalVrMXEyRUtFQS80N0ViMk8yN3B4bThMQkY2QmpPRTVzRVp3?=
 =?utf-8?B?Z0F5MjBsa3FiMUpqczZaL3B6UDdsNFFnUmI2N0luZUcrQjBRZjlUMm1IY0s4?=
 =?utf-8?B?bU5DakZkSVBlNklDdkdsNDJKVWdBUW1YMnNoS1BLSEFob0h2czdUcXBiVW1z?=
 =?utf-8?B?RWRRaldyTkJ2S1RKdTc4WVRsSnpDdG44bHFsRDIrTkNJMDNqbVEzaHk3MjBR?=
 =?utf-8?B?Qm8zenk0Qmt5UEgzK29FOWxmelFGeFI4emxxMWNndHNGN3lJZkFtODkrbGxY?=
 =?utf-8?B?Y1FhdzJ4bmIxanlMZDVRbWxtZWVvd09mSFZPeTRqZk5JekkxeWZtUG4zamNM?=
 =?utf-8?B?K3c3N2FWc3FsVDM4Ylk1VHVlSjd0TW9vamd6NXZYc3NUTWRoZmRWRFduU3Nl?=
 =?utf-8?B?UWJOeENvajA1b0VYNkQ1bjIzd1FYL3BuWHhrVjBrTVFDbW9uVXJoMXNybXQz?=
 =?utf-8?B?OWVVeXViN2dkK0hldDg1WUhKdk1GQ3RURURwOVR4VnhNZmVmdE12M0o4V2Qx?=
 =?utf-8?B?aVVReGJIWGJRZmNzaFJ4YW5OaXVWWFFpYnN4Tm4xL3ZKd2lXc3dDejRWWmt1?=
 =?utf-8?B?VkdxRDZOZ3ZnUGVaTTlGSjNpUy94VWp2cFg4Y2l5UmNtV0F1eU8wZkU0YXFE?=
 =?utf-8?B?b084a1dRUmFJeWFHbWpSR29pM2JNa2dPUldGTVlZNTFEQXZyN1ZPZ1JQWXJG?=
 =?utf-8?B?Y2Z3ck5jeUlFbWVjQ3NLZHRUbm0vVVJOQmVLbERxOWMzTFpzUFBOSjc3R2dm?=
 =?utf-8?B?SkhheTJDUk1HME9CSnRGcHZkZUlVNVFIVG9BY3d2N1VYWlV2QUswcE9BWDZO?=
 =?utf-8?B?dW53TWZRZ2wvUVpRZkh6Sms4bWkwMzhZTUpsVDgwczdXYmRmK1lVZFZUTUxG?=
 =?utf-8?B?VDNVTThHMkZtTk9lU1hWb3BqbzFMYzJYa2dPS1hCOGZGeWw3V1R4cldEV1FR?=
 =?utf-8?B?dTJyc0hWa05SYU1ZRUViY0hsdWFJd3RFMkVNSzdMZDBxWDJ1UVhFdUUyRHEv?=
 =?utf-8?B?Zys2K256WkJJa1RwOWkwQUpGd1BRRDkzd0krU1V1dExxMG9FeUU1bG4yZ2JK?=
 =?utf-8?B?Q1czOWxERTdBNTlrL056WTRhcWJ6RTI1MGRJZ0NuMWlLSWpUeXpaUFdSZlFU?=
 =?utf-8?B?Nm5MeGNMUjdET2l3N0lwN0w5cUZaSnpBOGRzV2xYNUpPL2hYeEFjbFNlcnhh?=
 =?utf-8?B?b2llcUI1R2lHNS9HTzJDY0Zla044blRsN1kvSy9iS3cwSnRJY0JJaXBxR3Fp?=
 =?utf-8?B?ejE3QmNlVGZxaTFRcXlJUVMxQXNxWTlYZ0Rsc3FiVWpGZ0QwUE1OYlhMcGRw?=
 =?utf-8?B?RDBCNTV5L1JvQ0FoMUdFb2hGMkQ3cEFvR2ttT0ZlWDAwVnBYZDBmN3d5ajVx?=
 =?utf-8?B?ZFpGVGs4cXoxWDdHQlZ3OCsveFBsSm53NGQ0WUVheGwrVVJNcTVWMXBjbmJM?=
 =?utf-8?B?ZE1qam9NTEY2dkFsYW5qT1EzNjVHUTZ3aSs0RFp6S1ZFR00yZVh5QTdNVWFi?=
 =?utf-8?B?QnJMdSswd21YdC84YUNRSFViQTV3ekFBU3o4b0FScUY2YnlLZS9VVGhGcTZi?=
 =?utf-8?B?bFplMXNZb2E3SWkyMjNRK2tsRVZ2NnZBZkg5a0Q4aW0yQitTNk8vczhlSFAy?=
 =?utf-8?B?QStvTkljUGRSKzBTSXVaUXEzSTdLckw4WEl1WnhtcWhndkxoRVExeXY3MlRZ?=
 =?utf-8?Q?OcWA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d77ad-0194-4aae-301b-08dde18b38ad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:50:22.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 875M0GZ2clAqb44wK8N7EaP3X3CE91TO0Rv3uzlrdmgqYSlxIEJMqM/+soLsUqt4XbxQ8pZ7WvTKVv+ugU8Pog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

Remove redundant #address-cells and #size-cells for ethernet-switch@1
because children node have not address.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dtb: ethernet-switch@1 (nxp,sja1105t): Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/nxp,sja1105.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
index 1ea32fff41201b7a787dd116eef675318861ad19..da76566f3510ce866586a214b4df6992e5fc4843 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
@@ -40,8 +40,6 @@ &dspi0 {
 	/* ADG704BRMZ 1:4 SPI mux/demux */
 	sja1105: ethernet-switch@1 {
 		reg = <0x1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nxp,sja1105t";
 		/* 12 MHz */
 		spi-max-frequency = <12000000>;

-- 
2.34.1


