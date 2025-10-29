Return-Path: <linux-kernel+bounces-876539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988CC1BDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B26C584B89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909183358B3;
	Wed, 29 Oct 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="EF+F8dP6"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239C2E6CB8;
	Wed, 29 Oct 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752163; cv=fail; b=uIBMqDMWw0i6ierl5H48564J/Ia2sBFnTUKRcjqJTt0AiUQD6xcq3kVq657SfSQIKDswaB+HfY79m43WAQaRakmVQeE2OyBNcnRDeTByZBGvBFo2B1+Q7YTtj8TqQ/4d1icdP3AgkGk25AOZTryJQzgfAnwCidmbX+JeBV6nV3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752163; c=relaxed/simple;
	bh=SZLP9TdFfujE4a/RF1hiw6+oo0zcLT1Qtpd0rabKyb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lRYSelbPNNjVX4GM58NttrfbYuzBTYsLjvaNubkamm+a7RMfxIhHTacI02Y+Urr7/vSyjDke2kX2qiMAU53/aeTJ5pd8Zi8IyDL49iuS+aieTarWzyTXD75ffb0mVU5nW5Sl8LtTg7IwpDEoBXhJYxbJuN/k4naicJomAlKhsWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=EF+F8dP6; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUW06gbQU9hyNsfjnq57dX5QBA+kXga/gEsJ9tf02fy+4Y34sHle1tIJJpJRBIoiNoOT1QoRHIj9hNSp0lccTpRXYQ7SvSC0yZsZebCplO282w0UTFtmD3EUNNU6w4RUB+UZ9c+xL4tWUkvWFB6fUtYwYA0/XLLrgwETLB6kGM3TOhkeey5pg6mCVd6gxdHUmFX21H5hKDQI1BzGSy/HdO9Bhg9CPFqwU5ObMepuE4h1zLlnFADxWlduf9UYuUw6QV0h2WYY+qVqcqIhm5TNZi+h2hTwmq0wLp5JlAoKum7YaicnhXStj18CQdaxn1jtHlaAAdHCeA0Mns5YnyddgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqwtC3yUyJ5tGs+s1Q7jBPaLPK6DNgoOmjQ8VIRvD78=;
 b=MkSGP0wIBSdNhyFgfwkrG0lhNKwtssDcSe7f2x9d5uTlF5oHq1P5s0JfUmgTImOUVuuIwxZM07BhbE88jImgtmdyg2bUM+PIJMXdZ7QsIGloFV0qvIb5sXakujuZWenv17GEkc1A3DYmQ+IiBgAPGYqQMdPFn/fr67QJxFL5lyRlRNWCs0cWEjqSjzKD7yNNTxQJw+8272DgmGC/YUqR9B/oFJcJA8VjY17doNmcVrVhSP4rcCMDyYGZ+kWgvovqudnjD1UTlAByzvZ1HB6PvA6iqqjlCYtPRVooGHcBCCFFMivddzt+ntngv8GDU/gChRZn6ZbOsPgYqC2K5eQ9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqwtC3yUyJ5tGs+s1Q7jBPaLPK6DNgoOmjQ8VIRvD78=;
 b=EF+F8dP6+Ur76TEypk10f4JhpBPDh3RJT3fRGPomw/ajNK/oftZncldbeU/V/O4wpGPe42jhe2yMok8dNAsa+kxhlQOGLQAtBVMCMMVH1h7sJn0Lh3vQ6EtWNuK4cel3oFoa4ucqnI/MssYfyRT2x06P1TmAw3E69QbLiTteg1KQO9Mvg1by1dF9R5rzQEQOHqw49Fn0blpaUB9mHmDqUk/jVXMWiDjDCiXA6qMxRb1JIARmendFh+Q1O2IHViomlUXz5nHeY7ZqAvbYTziKA2JS4/4otYTK0IQupMbesUZQ3dGnKW/4sFvnsKwCXYFf2a8BAOMn73TA7mPntppgTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 15:35:55 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:35:55 +0000
Message-ID: <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
Date: Wed, 29 Oct 2025 16:35:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
 <20251029104838.44c5adcf@karo-electronics.de>
 <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::20) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0932451c-52c0-4842-6b42-08de1700d970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZ0YkFYR3c0enk0VnVub1V0ZHRTU3hEaEZ1U3RTZXF5ZW9wbzg5Yk9PMUtt?=
 =?utf-8?B?cnJ6RmpsYXdidFRQQzVXTFp2V081K3N2M002cGZsS0pwQ1lTSTJ4NkhGZm1u?=
 =?utf-8?B?VkViSzJHWXU5WjM2V2dqZkZIQkt4ME5uTXdnUm5VZkNEaUJxemVLenRpUGtR?=
 =?utf-8?B?bGJISGE2VWx5eVFXZ2dyK2RiL1RKWDFGMXB5VG53cmV6bU82VjEzMzQzQ3hD?=
 =?utf-8?B?dTJiTzV2TUYrQnMvemdPVmJxTW5RdlhUVkFNRHJBSDh2SW4yZ3VmNWg5Ynls?=
 =?utf-8?B?MnFkZEZHWHpkZTVXNUgrL2lYUEljRU80ZXNRM1hKcVZ2d3MwUlVrQU9WMUNo?=
 =?utf-8?B?VEp4QXFOM0NISnUxOXJmdlpFNHg4ZjBKM1ZVSEkyZGUveFU4M1NsVTM0Z2E3?=
 =?utf-8?B?RHpmWklrNFNGQUswSEFlL1FUY3BuOHA5NW0vMVV3d1BTd0RYVEptdEtpUXhl?=
 =?utf-8?B?VW9sUGU1R1d2TzRiSzhKN0Q5SFZoTGFWRWFZaUxQUXBaS0VOZkZ0d0R1VDdM?=
 =?utf-8?B?UHJsQkdKSVhZUWJTUUR2UVcrZUFOL3ZhakxVYjRHdi9xdEs3N2N0ZkZyb2Mr?=
 =?utf-8?B?dG5JUTduYXhoeGE2NzFFNjBvSHNjNmpsSmRQb2VmNEpwdGl6SWxJbThLY2hv?=
 =?utf-8?B?SllnUDMzT1RvODhmS2dPWjFvZkc1WHkxL1FCbDg1cTZUYngzb3U2cXZkamVR?=
 =?utf-8?B?TGhJVlJmaUdkSVdsWm9yMWpBc1QxTWdkWXFwVjB1RXo3eWlLamtvc09GRGtl?=
 =?utf-8?B?Yy9ha0tsdU8zV0o4RlpXZ1U2ZXZJTlczcExNWU4ralhWTEExUXdBdDlTNy9u?=
 =?utf-8?B?VzJ0aEwycnd1RXZEcE0wSFErUzFvdEo4dTM2cmZCczdEYVVmZVppTW54RUt5?=
 =?utf-8?B?SS8rK0RsZTgvUDNvNS9QbTd1cGZjMGM5Um9SUlBadkcxQTdVaG9yWGRwQmFQ?=
 =?utf-8?B?MU91NTJKSk9Md0tqWSs4ZFRtOHA5eGhsWVZzZzdLVmp2djk4UjkwYmcvTHd1?=
 =?utf-8?B?QkRBcElyNmtuSlV4MVlSNjFpQzM0MDRrU3E1VzNVelh1ZXRQTjZVb3NtUnFx?=
 =?utf-8?B?d2NHQkZVQWtUNzF0OXdIcFk1SEYwMWxJdkc0WEVaYzJMdDhUcks5OWlsMVFj?=
 =?utf-8?B?U3FQQzJtY0lqU1BDdk0rRTdkNGkwL1pTMGRycFNNTXRHSm11UmsxM1JHMWkx?=
 =?utf-8?B?cnFWcHhmRWFXVVo5aFJMZVd6eG9jbmJPcTBDL09KVDhSeVNrc1JZUW5ETnVQ?=
 =?utf-8?B?VUtYK2x0amtPNGRCT2JObmlscTV2eW5KWmVjSXM0YkVKRjdzTnNnSEtnejIr?=
 =?utf-8?B?U25iVU1jRFlFTTZRV3IxOHY4WlhLMXA1dDhrWG9XMzhsWG5tTXhieFZvQWg2?=
 =?utf-8?B?RDZNQVJQa05mcU85TDBia2U4TnkweWJSdkJOblpYZXg1QnVydTJUWjF1K0c0?=
 =?utf-8?B?c0ZScW9HWThHaXdpbTRCVy9peVdxMSt3LzhNdjRvUE1VbFFOL21QdkE3d25P?=
 =?utf-8?B?VzB0V1J2eUt5U3g0L0pOSU9QN2YvWFdwTTdxWDRHK3FvWkxUOHJZZEFmREVV?=
 =?utf-8?B?d3pIQU1WcGlUbE83MExERW45czl2SExKSlpVYUlBbTVxTWtjb1NNZ1RzSjdU?=
 =?utf-8?B?eUdtSW42NUdBcHNNWjcrNHdqWHdIOVhNVkdhWUc0aGQ4alRpei9vc29vRTBh?=
 =?utf-8?B?YUk5QUxYZWlyc0QrL3hpd3dldE5Md2NINnlsUmRvODNFaEhCcnB1WHRzcm4y?=
 =?utf-8?B?M0FPc2dIY28xWFhRREZSbitMbDZsQ2ZtOXkyUmQyTzJkZ1B3M3crWjgwYkYw?=
 =?utf-8?B?UzRFWXpKc2UvazhuMG1IbEZ4d2IrdVdqVWhIYkxXcDkrK1d1MlJuTlVnU2JY?=
 =?utf-8?B?QkJXUjRZV3NLbWE2bmFWVUczQnpFVm1IeHZVUzBvZVlKU2JPZTF3L3BOMnR0?=
 =?utf-8?Q?3MfcXqQ+SRWb2whtNW+8T0wETDmQ4Clj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUxaN2dmWlJGSXhXTFhqWnFNb2JmS093RWc0bmpkMmQ5UkdxSXFzREQ1RGVi?=
 =?utf-8?B?TnNPU0pvMXlQQTRxekVtRWV5SVZUajdIU01TcDc1Q2Ivencrc2hHWFFyT2x3?=
 =?utf-8?B?MnVhdWg0TjdrMktBSVRpSlRWVXhPODZTc0szcmFYaWhOMFludXJLQnprZjJ4?=
 =?utf-8?B?UmxIU0lPSWRQZzg2Y1ptVHVDKzI5blArVmhBZnFCNm1WOGV4R3RlYUFrb0NE?=
 =?utf-8?B?VmZCdGtMNEk2dk5Wb0lGbkNYSzViS3NQRUhpS0ZSNXdTTlZ3OUk3eDF5NFhZ?=
 =?utf-8?B?KzZreVpSSG41N29PRVlUWmJlNWZXSm5pd21kQnBlYldobUhBWVVxVEVsZk1l?=
 =?utf-8?B?TDJYVFNnNm0xMkpQVW1pUjVOd2pUM2pONFZBOFpEdVNOSC94UHAyRk9kWjFl?=
 =?utf-8?B?cUZVbnpicFVMQmpvUDdveXFNM3hlUk5GT2tjOXBQcUJQVENXeEl4M244cmxJ?=
 =?utf-8?B?c2ZiWnFueWFaWmtVeG1TRk9NaTF6bVphZ29SQzQ0RUNQQ1Fxc0d6MU1maEg0?=
 =?utf-8?B?clhrL1FQc1V1bytwdTd1QlJFa2gyWkUvZ3NnREQ5TTlSSW9FSlBmZ0RBSkZm?=
 =?utf-8?B?bTBGT0xMOVlaUzdnU3dQRnNtQlZVOXlVSm9DM2hwbW1zakhxV3hrTENlQ1lP?=
 =?utf-8?B?c3ovQ0FHVEh6QzdDRFFPRFhxQnJuK1hxVGVPa0Mra20wd3UyZGl3OS8vL2pw?=
 =?utf-8?B?amJod055TldWSWQzVktrdU12T2FCZ3NBeWREUGJvWkFheFczZFZFd1QvMFR2?=
 =?utf-8?B?cnJFZEFMUnY4R3lEeWhQLzBISkxpbXVIcHRiM0FDeUM4VmtKckNidFRSeHV3?=
 =?utf-8?B?bkdUVVpDM3NDWUtzaFI2S2R4MzduUmNzb3ZNSkwycE5kc1NNTXNTS1lRR2p2?=
 =?utf-8?B?c0F3OU1kQVJ3VlFsUkpKZGtmbnNwZ2J1M2tlbDVmQjkraFF3OUdtR2VYRUts?=
 =?utf-8?B?VDVBYmZUOGozRmRmNXFHdFpGcFFLUnM0ZWhycEN4c1M1L01oU3Y5V0d4RGdr?=
 =?utf-8?B?czhNZ3VzLytlc3hFQko1NlVvMExUUEsxMFJKWG1XbkM5cnlxWnNLRUIydndp?=
 =?utf-8?B?TnlnVCtuRXNRNG9IQmpvbzFkRWJ0VlNZbk1odXU3c0dTU0JxUTBDU3NoVFZB?=
 =?utf-8?B?VEZ2cHZCOEdjeThwdkMxakhQcTF5M3dibWtJWjdLTnBlZlBCOFNBVHc4alRz?=
 =?utf-8?B?VXRsd0oyTDIrMlA2aHhybzFJTHFaSUlFTFZMQ0ZQQlBQeDFZdm1CbVlqa1li?=
 =?utf-8?B?cTQ4bDZpa09TZVgzY0VLQ0pCalJYNFlhTG9GSXY0Q1JxdE1yM3FDczFFdGNn?=
 =?utf-8?B?UkdJQjFEUEdoMENoWW9BS3R0Ty93bm1LNFBSNU5PQmM0UTMrcDg3NnVXTnpJ?=
 =?utf-8?B?cjdTaDZUMUc3SjJxWEZqZFNaODlneW4vS0tqLzVUK05rYnFRN2hZUnlUZ0hi?=
 =?utf-8?B?b1BzcEJocGF6aklicnBXUmFPRkc2YjBadEN1TTF2U1JoMVlHQWZNV2xMcVVR?=
 =?utf-8?B?WmxNUTR4ZnVxbktncDlHMFhlYm9QdElvOHcwM2xnUW9tUjBKK3BwSjBxU2lJ?=
 =?utf-8?B?b1lkYkh3QjZ5R21lTXhJOUNqRGJFbnpiT2pDTmdRTW1ZZStSMTJFb0VFWDNI?=
 =?utf-8?B?enR1ZjF5Wmh1R2xlays2dmNvcGE4RXdrZWFBSEVmMFJ2cmJwYnBjVGdmRGlH?=
 =?utf-8?B?RlhwaE5ISTF6V1Zyc0kyb3FJeEltbVBVRzloSEFmWjU0a1RSQkRobFB6UHNR?=
 =?utf-8?B?WU1qb2dlQlBjZllDZWdpNDF0WEFaQ3l2dzI3L0Npa0VBV253NW1sT3JlUlBi?=
 =?utf-8?B?cDQvQUpJZDlMa0g1LzAvalMrMVdVR1Q0UmhONjQ0UGwxQURjUFNESmFVRlFp?=
 =?utf-8?B?SFJ5LzFmem9lUU1icHBvb3NqemdUYTFVOXlJbytrZnU1NERkcGlnNEVGRGV2?=
 =?utf-8?B?MVBPZk0wMlVhOXJSTXAwbHptcS90amt3R3YvTkdyUXk2bUZDU2JOSGRFRnZs?=
 =?utf-8?B?TkZ2bVpWTGdyVU9kZFMvcW5uK2V3c045MWd4eERXZEYwMDY0S3RRWHh3eFRJ?=
 =?utf-8?B?R09DVzVZNW9MOElDd3czS2FVQVU3QnVPWEhZMktWRm1oMTI5U0c3UHdacER1?=
 =?utf-8?B?emYyRmJLVVA5OXlMTSs0bjNNOCtWUlkrK0JsdW45OGZBdGhVYWV5cE1BQ21F?=
 =?utf-8?B?S0hhZDdkZGRkeVRjTXVYWjltSzJTc3U5bHFCUmVPNUY3cEc4MnZ2OXI2Z2Fn?=
 =?utf-8?B?RnJDSmFRRE90M3h6cEJBTHV1eVlBPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0932451c-52c0-4842-6b42-08de1700d970
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:35:55.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36WWV/xM4VuHN0XPQE8qbX1EHUjqZbFh6BVuGeKgz/8eViqJQmeX6o+lnPqaGLrYxBHVK1Wqxws+L/ippABLZ6HxeV64nJuOj7IN6xdcmtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193

Hi Matti,

On 10/29/25 11:05, Matti Vaittinen wrote:
> On 29/10/2025 11:48, Lothar Waßmann wrote:
>> Hi,
>>
>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>> Hi,
>>>>
>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>> [...]
>>>>>>> Could/Should this be described using the:
>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>> scaled voltages.
>>>>>>>
>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>
>>>>>> Ah I didn't know those existed, should've checked the bindings in 
>>>>>> more
>>>>>> detail, thanks for the hint!
>>>>>>
>>>>>> I will have to investigate this carefully, since I don't have 
>>>>>> access to
>>>>>> the actual design of the COM, so I don't know exactly what is there.
>>>>>
>>>>> So I am not yet entirely sure if this works out, I used the 
>>>>> calculation
>>>>> in the driver:
>>>>>
>>>>> /*
>>>>>     * Setups where regulator (especially the buck8) output voltage 
>>>>> is scaled
>>>>>     * by adding external connection where some other regulator 
>>>>> output is
>>>>> connected
>>>>>     * to feedback-pin (over suitable resistors) is getting popular 
>>>>> amongst
>>>>> users
>>>>>     * of BD71837. (This allows for example scaling down the buck8 
>>>>> voltages
>>>>> to suit
>>>>>     * lover GPU voltages for projects where buck8 is (ab)used to 
>>>>> supply power
>>>>>     * for GPU. Additionally some setups do allow DVS for buck8 but 
>>>>> as this do
>>>>>     * produce voltage spikes the HW must be evaluated to be able to
>>>>> survive this
>>>>>     * - hence I keep the DVS disabled for non DVS bucks by default. I
>>>>> don't want
>>>>>     * to help you burn your proto board)
>>>>>     *
>>>>>     * So we allow describing this external connection from DT and 
>>>>> scale the
>>>>>     * voltages accordingly. This is what the connection should look 
>>>>> like:
>>>>>     *
>>>>>     * |------------|
>>>>>     * |    buck 8  |-------+----->Vout
>>>>>     * |        |    |
>>>>>     * |------------|    |
>>>>>     *    | FB pin    |
>>>>>     *    |        |
>>>>>     *    +-------+--R2---+
>>>>>     *        |
>>>>>     *        R1
>>>>>     *        |
>>>>>     *    V FB-pull-up
>>>>>     *
>>>>>     *    Here the buck output is sifted according to formula:
>>>>>     *
>>>>>     * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>>>     * Linear_step = step_orig*(R1+R2)/R1
>>>>>     *
>>>>>     * where:
>>>>>     * Vout_o is adjusted voltage output at vsel reg value 0
>>>>>     * Vo is original voltage output at vsel reg value 0
>>>>>     * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>>>     * R1 and R2 are resistor values.
>>>>>     *
>>>>>     * As a real world example for buck8 and a specific GPU:
>>>>>     * VLDO = 1.6V (used as FB-pull-up)
>>>>>     * R1 = 1000ohms
>>>>>     * R2 = 150ohms
>>>>>     * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>>>     * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>>>     */
>>>>>
>>>>> Because I do not know the pull up voltage, and I am not sure if it 
>>>>> is a
>>>>> pull up.
>>>>>
>>>>> So:
>>>>> Vout_o = 1.35V
>>>>> Vo = 1.1V
>>>>> Vpu = unknown
>>>>> R2 = 499 Ohm
>>>>> R1 = 2200 Ohm
>>>>> Gives:
>>>>> Vpu = ~0V
>>>>>
>>>>> And:
>>>>> Vout_o = 1.35V
>>>>> Vo = 1.1V
>>>>> Vpu = unknown
>>>>> R2 = 2200 Ohm
>>>>> R1 = 499 Ohm
>>>>> Gives:
>>>>> Vpu = ~1.04V
>>>>>
>>>>> I am not quite sure which resistor is R1 and which is R2 but having
>>>>> there be a pull down to 0V seems the most logical answer?
>>>>>
>>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some 
>>>>> light on
>>>>> this setup.
>>>> R2 is connected to GND, so Vpu = 0.
>>>> With:
>>>>     regulator-min-microvolt = <1350000>;
>>>>     regulator-max-microvolt = <1350000>;
>>>>     rohm,fb-pull-up-microvolt = <0>;
>>>>     rohm,feedback-pull-up-r1-ohms = <2200>;
>>>>     rohm,feedback-pull-up-r2-ohms = <499>;
>>>> the correct voltage should be produced on the BUCK8 output, but a quick
>>>> test with these parameters led to:
>>>> |failed to get the current voltage: -EINVAL
>>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register 
>>>> buck6 regulator
>>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>>>
>>>> Apparently noone has ever tested this feature in real life.
>>>
>>> Thanks for trying it out Lothar. I am positive this was tested - but
>>> probably the use-case has been using a pull-up. I assume having the zero
>>> pull-up voltage causes the driver to calculate some bogus values. I
>>> think fixing the computation in the driver might not be that big of a
>>> task(?) The benefit of doing it would be that the correct voltages would
>>> be calculated by the driver.
>>>
>>> If real voltages aren't matching what is calculated by the driver, then
>>> the voltages requested by regulator consumers will cause wrong voltages
>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>> safety limits set in the device-tree will not be really respected.
>>>
>>> I think this would be well worth fixing.
>>>
>> Before doing the real-life test I did the same calculation that's done
>> in the driver to be sure that it will generate the correct values:
>> bc 1.07.1
>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 
>> Free Software Foundation, Inc.
>> This is free software with ABSOLUTELY NO WARRANTY.
>> For details type `warranty'.
>> fb_uv=0
>> r1=2200
>> r2=499
>> min=800000
>> step=10000
>> # default voltage without divider
>> min+30*step
>> 1100000
>> min=min-(fb_uv-min)*r2/r1
>> step=step*(r1+r2)/r1
>> min
>> 981454
>> step
>> 12268
>> # default voltage with divider
>> min+30*step
>> 1349494
>>
>> Probably we need to use this value rather than the nominal 135000 as
>> the target voltage in the DTB.
> 
> Yes. When the driver calculates the voltages which match the actual 
> voltages, then you should also use the actual voltages in the device-tree.
> 

Think I've got it:

diff --git a/drivers/regulator/bd718x7-regulator.c 
b/drivers/regulator/bd718x7-regulator.c
index 022d98f3c32a2..ea9c4058ee6a5 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *dev, 
struct device_node *np,
                                 step /= r1;

                                 new[j].min = min;
+                               new[j].min_sel = 
desc->linear_ranges[j].min_sel;
+                               new[j].max_sel = 
desc->linear_ranges[j].max_sel;
                                 new[j].step = step;

                                 dev_dbg(dev, "%s: old range min %d, 
step %d\n",


the min_sel and max_sel fields were uninitialized in the new 
linear_range, copying them over from the old one (they refer to the 
register range if I understand correctly so they should not change) 
initializes them.

Then setting 1349494 as the actual voltage makes it fully work. 
Otherwise it complains:
buck6: failed to apply 1350000-1350000uV constraint: -EINVAL

Final debug output now:
[    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 10000
[    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
[    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up 
configured

I will add this fix to the next version of this patchset and include 
your requested change in the dts.

Kind regards,
Maud

