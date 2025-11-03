Return-Path: <linux-kernel+bounces-882238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE58FC29F38
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C463ADA50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448E4289378;
	Mon,  3 Nov 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kvf9bzmJ"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B327FB12
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140439; cv=fail; b=UnHql+gPd1VxQFyX+gkqRP1+pZM5lR9hOUaMZlhMQv7ZcaEk1oIorXJqsvnq7mSQJwFW3u0EYlqVvGmeJLbYzGrfR+v35zfAokWeCGFuuQocPOxZwSGzatICZONj+iBeztG4uX1If8NKMjFPVSCtO9YL6Z9lZv+AItRe91sUSjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140439; c=relaxed/simple;
	bh=zTezPdwWEMhC3uliXnqLqybFt1fSSEWDm+4NE2Yu7mU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b7ytU+I+LkTNFQfWyiPm2IoZCTqw0oKj/NbZBkayhBVVjRB0PElFm7h5AaQOIn1A8bPXbREpxuH30Ww80DeRQ7pog+8gAgdkITvXL1mq5MYe42yX/klXN5gEVQYWY6eh+SCMsg5RuKvKwuYDX9bBJ3U7E8NwPBfpRj6KnqXKn0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kvf9bzmJ; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFBwMqcZ6f7NibzBJBBE60cRaWX/8t5hQOiXnK1UgjsSvXBWtwulW9J3B7FaPccpQAj/NyRGp7V8bbPKH6FujQo1muyv1TTQ1gNfDVF0hieTxrqVdhgobICyT9cWaRmdQXXD00nDVekA0HcH8Ti+jaOtK7zh/SMJAf31VRrK1FCl0ZojoH3q4sOWScuYdJkC/easakqn5VkAb0ymYbEoS6F0RySZLPrLmx6kd11CcZoiIndjJVsl3WNBYdD/3iuWBLsUx9WS9+opQqaKQIewKvAdbA1wzQRxhebgVmqdZXt12kc7zPCiP5y/3ASeNua8CQTqlrVLXgcexLuPYYencQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6+C2AJ33QS+dB53abeevt309D7WKzSbKJczG5+8msE=;
 b=C6PmqCb1krmgN4o2nNbfTtGgwvcS7nhBahoiB4aJLQ7DAX1qSZYAGN8JBC9F5O1anEU8flcj5tgtEOZLzM13skliBPv/ISl61+L/fe7aXbKbfkyUvuyvfzrfLCDNFkfkaC13KkvntBEEzXhsmVryqprSWHvZ1d0i9BDvDVMAjhJv5u5dVE5TXGfUakd58r/t4uslXQqCi2Op+wYDScEHmIxfx/PeO/br/36wbxG487d/4WvPj8QnNZ8MTVwhYFXRJI+0PuTgWhMI155OTP+HpxRSuIuARpYJ/RucGf2QrD/VTkRoODLOVHTx7dUcvp9gdF+kfpj4UoaEd66l+spbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6+C2AJ33QS+dB53abeevt309D7WKzSbKJczG5+8msE=;
 b=kvf9bzmJXPYL14Qk4h5+Kea9AQAOl7Tdd6njeBwUszEJ0rzz/khwPgrm0TZEvc6ni1BzIoSgG/dPihBtuk+VXfr0SSpy9Vb5b1dPurmlChZRgUVLhebe5T+xEcDe+eu9ukfxedL/AokfEz3cfbU+MaH0hcx3170umIa9evDIt5Fu5BbZ/rIoVrbPUdDDJ4PnDxMpdDfbUq/WY/Msw3AMeRfpBPIj51FhEZMCNjZl4evkT5xsAuL1vc0g6MwXH8k8TkjulSbhVt/QQEEiq62CmgiDs9Vk2H7NNsV6jABzeG8UawPVGFfPffpt9VlQ0oT0jWs3Mjg+qtQ/605RhRRxsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:27:12 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 03:27:12 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Mon, 03 Nov 2025 11:26:47 +0800
Subject: [PATCH 1/3] regulator: pf9453: change the device ID register
 address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-next-pf9453-v1-1-a025d536eee1@nxp.com>
References: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
In-Reply-To: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: a670088e-96bd-4f88-3084-08de1a88e0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V29MNkZqZTRDNERMbTJsYXlYTU1WQTZCd3VZbXYxSnJnWnpubU9qS0gwNjJz?=
 =?utf-8?B?Ump4UStURE5IcHNIT3JHRGszeEJTZzIrZ1h6NHJMa0pnSlgzcW1KSm00SnlC?=
 =?utf-8?B?ZUc4RnFnVVQ4RDczaWtiQ0RmR3c3MDJYN2hpWngxT2xDQVNlZnBuNGdIaUVu?=
 =?utf-8?B?bkxaVmd4anBnTXpaM2J0SmUzWFFxdW1TSnpmRmZKeXJOS3lBMEJ1ZFBNYkVO?=
 =?utf-8?B?dXhVMFRWWFIxeUxRcEZGWUVGQU9yTmh3Q2ZEMERwclJlSExjL0NmbFBMWXMy?=
 =?utf-8?B?KzBGSFdqRTdOdFBkcC9sVkd3SGZFSzVRQnc2K2RkSjBxc3VVWW1QSU01d3FL?=
 =?utf-8?B?ZWVJMFlhTzZCZHZzRWJLeFRRVDFyaTZSSmd0KzJoV1dVUUdjYVlUZkFTRkd2?=
 =?utf-8?B?VE9uV1BaeDRBa0lvbVFxaHRYM2dCdU9jUWxlVm94TzY2aDFBQmsxL0pVYWNS?=
 =?utf-8?B?N0htS0FMVWJlbXhnWFVxTGZXSGhKaTNTN2dEbFpnSGZQSUtOeUF4SXZ0TS9z?=
 =?utf-8?B?OVNSYURDRTEwUFhuYW4rQmlkOWFFa3p4RE1RalUvUzN5dzNyQng3ZU5ad2R6?=
 =?utf-8?B?azA0bnZ2SW4rSTZOSTdVazFoYmhWVXEwbmt2OXJ3U1lmdC85aXQ3ZTV2aUJE?=
 =?utf-8?B?djh6T1lpYlRWVmNhSEUwV1dqL2RVK2tkS2pGOGs4TTNpTEsyYktWTnZnT3Jl?=
 =?utf-8?B?a2s4VEJoaHlQcndzZjl5YTFaK3FXY01CeWtLWVNnL3ZpaHprclQ0a2tpZW8x?=
 =?utf-8?B?Wm9jWG5WSVBOeUp4WXF1MEFSZytOR2ZIM21TZ0VzRUdqYUwwK2xwUFNWeCtK?=
 =?utf-8?B?N3NrVzlmQlhvVTB4dFhhMDFsUTk3aS9xRGlVTUZBYjh1aEVGczJQbisrcUp2?=
 =?utf-8?B?cFhMbmtLSjkzQSt2K3RzdS92N2hmU295Szhub1RHa2hSRjd1RnJNOXdkTCtp?=
 =?utf-8?B?cnRLUXF3YXdhMTRlcTdGZjBSbEZLWU9SZDN3Sk1lUzVwQ2EzbklybHJ5RXlx?=
 =?utf-8?B?aXJpSElzNjMwdEcwYWh0dlRGQk55YXJOc0liRkdoV0h3U2l2aUM2ZTZuamEw?=
 =?utf-8?B?VEkzN2c0S0JacWtXRHg4aVlUbk9MN0U0ZzBFSzNHMXBka1NHQURWVmdBQ05q?=
 =?utf-8?B?Wlg2Nmc3SWhzSGRQa3QwTDdibDgxWWlQVStnL09RcHdJMUJmdXlBd21tczVq?=
 =?utf-8?B?eFltWEZLTGpoem9HSi9CbjdVNnhtamx5ZW55eEhKdkNjekRZSC9Rc3RwcGp4?=
 =?utf-8?B?WnFLa0w0YWtrekY5clNEUVhEd1lhWGlHcGRoNjc1cTlydW92djJ5d1dnY1hi?=
 =?utf-8?B?U3RTdnNDbWtFTmdCaXBpanRBR3lINzVWWkZKa1ozblE3QVgvTGJRRmdLbXpU?=
 =?utf-8?B?dmI5emlROEU1Q0xEVjRFWTdkZ0xjTXNvR05PcUExalJqaktJcmtlQkNUdFNk?=
 =?utf-8?B?NnhoSS9PQkluRXp0MDJjMFFzelhwNEdxRGVOT0J0cVlVaHdreXJmd0NaaHJx?=
 =?utf-8?B?SVBCS0s0Qmh5UVJxVHpnenpMTk5Hc2dTKzFzcnQ1UWZsaEp6T3FBVm9wTE9J?=
 =?utf-8?B?WmRYME9FQ3dacnFKa1VCVlQ5d0ZKMDlNdnZHZjVFR2tvb3BOL1V6TUxHc3Jp?=
 =?utf-8?B?K0Y0VThRc2RyeFBZTHgvVjgrU0M4WDhLbVVkNEhIdk41eUhVb21laFpPS25j?=
 =?utf-8?B?NGNyVTNORFBDMWNzd3BHZE5OWVlkSzIyOHQ4MVh4RjMwdUF3d3NwV3FkaXpt?=
 =?utf-8?B?c3J6SE9uZlBKUFpNWGxvdklYOHVtQ2Zmcm9aVE9KNzg3WDlaM0krTmRtVnJC?=
 =?utf-8?B?T2dZR2Iwbjk5VkNyUEx0QmVJZWRUVm9wcXhOWjBqVmIyWWJXa29uQUtYbkhn?=
 =?utf-8?B?TU5yRWpxQ25hVnVmWEY2Sm5yNGNjbWNYZ3grS05EallYZm9lcnNMSU9Ua1I3?=
 =?utf-8?B?YUpZRWpiMzRaVFZrbURBNGs3MWNRTW9HN0hwdTBvRHdNZmFOSU5lNlBsaUNC?=
 =?utf-8?B?VElxZmptYVBmTmVZWEJCTXg0Q2FkdGxzK0E5NHdHT2taZlpLNnFWS3RlZnBr?=
 =?utf-8?Q?sZkFru?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG9welFGZkxnWCtHY3J3aXBDUys1Wk13WXdUbkNhSUphSDhxOExwS3RLMWhn?=
 =?utf-8?B?MHZ1TStzV3ZBR1dPNzQ2djJ0MGNjQm1uSDMrcndTQjJnUW9qdE8wbGVkcVJ4?=
 =?utf-8?B?NUhjK2N5endSakxEZ1F4T3BwQWdGNGhyZGZVUkZ5eFhseXhBRUxQc2RuQTNT?=
 =?utf-8?B?c2lqMysrbWxuQW02OWlXbm5qNEJWRk0xOHN6VXkxYmxyUkxicXVNNjI5cldk?=
 =?utf-8?B?dnRQK29YbGJYYjVKMUhHUTA4d0xHVmJOY2dYdHBpSTdMdjQrb1lkSGNtNGRI?=
 =?utf-8?B?RmNFU3djempzWGtGc2dDWisrZk1FUncxNHovdENhWW5OeDlEV1R2RHNOWFg2?=
 =?utf-8?B?SlNzYnk0dlp6Z0lVbWhwbFcxZlJjYTVaNnJFcWRlRGF5ZHVJUXdyeER0WTV1?=
 =?utf-8?B?cHF5VDhjSFdxa0x0RURBdXVrdDBNV2JML0hxbU5pOCtDc082aHkrTWpIaFF2?=
 =?utf-8?B?Yis5MjUzUnlrdkcvcHRBalQ5UHU1dWdZL1lLZ3VsZUl5RTFwYkxYNTdoSlgv?=
 =?utf-8?B?bGEzOXdoNUhQL0FmZlhoc1BPZnBTVXFSWXozek1saHBXVTRSOGFod1pHWVNL?=
 =?utf-8?B?ZlQ0MVhQTkdQK0lvTktqUEJZbzRrWUJFMTVadkd2M1BWSTVVcEFrck9JWW1q?=
 =?utf-8?B?RUNCTUFUSWx2aGI4aGkrS3ZFQy85NVlFZHRLVERkdmFJS3k3VGFPYzZkR1R1?=
 =?utf-8?B?cmNqRkh1UUNWZTUvSWxTYmhhRjFlOXAxQ0Y1amZWb3B2N0ZYWHBWTWNSaFJs?=
 =?utf-8?B?ZUViMllnMVk4NTU4QVdiQzdFUTNKZSthS25qUzY2bml1SU12YUNUMk15TmRB?=
 =?utf-8?B?cW04aHdGRCthd21OTUcySEt6MStzRGhiVEgvS2RXWEJDYmZFeDMwMjhBZ3hQ?=
 =?utf-8?B?QTVxTUJ4VWpGeEVxbkt1c011dEI4Unpsck1TUVE1UHZxdytuQVFEakJEcUZQ?=
 =?utf-8?B?Mlc1alpNUGl1RjExaVhqRWYyWG9vTUwzVjhXWFo2NVZ4Mkc1ZVV1aFVNN2Fz?=
 =?utf-8?B?aUVlZ3JUU0pOdzVrQlh5NkxhcHFsc1NGa0gxdXl5VlQvanY5S1U1UEdFZStP?=
 =?utf-8?B?eHovQVBCYVdPb29vdUkwS0ZCaEVaWHJZSnQ4VU9lTTBDUGE5YWx4WHpYdkRC?=
 =?utf-8?B?ZEVnNjc0M1dGWHRJUTVtcTUxUmRQa0R2ODNubVJCT1RWQlBGdTQwMzRZNkFE?=
 =?utf-8?B?U084cUVaVmdNVlE1Vmk0VUhIcWR6M1ppMGd1MkxDbldoU0xvd3FVTkVnaHgw?=
 =?utf-8?B?Q1JBamJOQkdGZER6U0xmUEZCMW1Hbm82bFJmSVpmNUpUUFhLM2FvMXpHVDMy?=
 =?utf-8?B?WkRydTFnMnkwbE1vcm5CN3BJeTdvSjhQanJ5a3ZQMWZzbXNzWDJKMXZWYVpo?=
 =?utf-8?B?VXNlNVR3NGhobGpUUmZMOHQ1eG9naE40eERkZTVJMUpqT2dQM2RVYW1URkNO?=
 =?utf-8?B?YlI2bW8xZkoyNXl0RXloVmxZMHNhamZuYUFrZThTSVhTaFhYZUVmTXRXTVB6?=
 =?utf-8?B?Y3ZQenhzK3JaUWdqU1lOZWRRa3VnWWJ3QTlUSGpCaFEveTJtS2tkUFlCQ082?=
 =?utf-8?B?WW1MSzRUMU1hZmlEalRURTlsYkRrdWRnQzFyNUpLbE9KVlNuT2NyakdERkd4?=
 =?utf-8?B?OFJ3c0lINDBqM2FjL0w2Z3pwUHdNdWdlOFF5V0I5b3h6Njh1eU9QNkhEWVg5?=
 =?utf-8?B?OVNQTm1rcFBUMVhtM1FjenNXeDBGTHkvY3NxNUpQWDQ4M1VCYlpJMHltQTZR?=
 =?utf-8?B?Nk1tN21BdFhyQnJvQWZsL2tCS1NYcEtPbStSTmEyQ2NhVWdZdEd4UVgyV2xl?=
 =?utf-8?B?ZFNVR2tKeXJqR0dVOFBjWTI0aGpoWFNGeXBYYkVkTC93cDdoeEVyTDJkajEy?=
 =?utf-8?B?dW1nMGlzQTRWazFBT2gyQ3VJOUtRN0hBTVdEQlFzbStCQytnbVdDdS8yaWhy?=
 =?utf-8?B?cm9sMGs1TUEzUXh3eStkWjlYclZaRnEyZFVDQ3RVV0svWE9mTHE0S0MyUnZV?=
 =?utf-8?B?NElyamYrazBsRFRuTUgyVHhYazh1MGhTYnBlZXFzRHNYVm43NnpWekZ6cVFG?=
 =?utf-8?B?UDhEcWNheXhTUFJrWTJ4UnlKbTl2ZjUwaEN5dDVCamRuQ2dXUTJvT2Zud0Vh?=
 =?utf-8?Q?eLeCanwYORid9ZFKblIa+dnTd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a670088e-96bd-4f88-3084-08de1a88e0ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:27:12.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqm+50aIrXHF7s/MAmYuVbrsq4bPoITSQb+5mPZHeI54vYnTZmk2WgObZvjoeNb1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744

Remove unnecessary register OTP_Ver and change the device ID address to
0x1. Previous version chip is never mass production. So not broken
compatibility.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/regulator/pf9453-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
index be627f49b61762bb2b3a1830c14ae3a7255034e2..d522715a7c74908b39880ce9f0bfc252a4dd4ba2 100644
--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -65,8 +65,7 @@ enum {
 #define PF9453_LDOSNVS_VOLTAGE_NUM	0x59
 
 enum {
-	PF9453_REG_DEV_ID		= 0x00,
-	PF9453_REG_OTP_VER		= 0x01,
+	PF9453_REG_DEV_ID		= 0x01,
 	PF9453_REG_INT1			= 0x02,
 	PF9453_REG_INT1_MASK		= 0x03,
 	PF9453_REG_INT1_STATUS		= 0x04,

-- 
2.37.1


