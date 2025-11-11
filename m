Return-Path: <linux-kernel+bounces-894806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC1C4C21F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C083B983E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3432B99D;
	Tue, 11 Nov 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SNF6DWqY"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551A31BC80
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846613; cv=fail; b=mEBN4JKsrAonXjMUNWAOsG1NPcJjEy1cA0oEBHy1GiccWMaA/6lJdYEviGKwWXJqFuSGzBRYLFMpl5lI2Uwcy9MR7vc/yEuZ1BQAatw1Vr4INNnwV1WNbi2l3ZfrSnb678rOxa90u4sZBO+81aMLObXMn4xWlQGiJUmAnmxVOdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846613; c=relaxed/simple;
	bh=sZWpJQE1x5345zg99VA7ivX8FRD6rGuRA4QGUYfUjrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fTaUs7s5oVabN+KT/9FuGf6G6zVtH39GUXDrpcCDprzTEys0HoUDTj1J0KnOt9yYj1kGuGLFJ2VM/Bazv5htVtH5iv5oKVcv90xUPt2uMGkZe+4eqbtRd9B6LGdaIuF3irlpiL0shbkVirAda2pdUUJXS0pq6IQo2kbCwJz+EPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SNF6DWqY; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyX8epcXUP48jL/91xKKNJrQhyWkH/YPdq6gzdCz/HzuqoewreB8vuP82KNLEGD8hil1BJBeSIB0OxIsLOrXoDbEM6G0BcdJwpR/KoqbXZ/1WU6f14jMddIyalUQ4efAeWsT9Q57uYeAXrSzKusRP0CnBpfhAfhgjfsouRPM8RFjPfmfWD7apnr2QUgQjRaZ2DdsbMThjdINbW149w10Mf4zxGX/7EsmOLwitRV7k6kw5nmRfB7/TXVqrQxWb4eaOIMTM9RSfl5S2Cr4nPN2KWYQqFiq4J1qnE3sKiLABCpGfIw3Akb972q+e8xz8FfLvcjpBni6uB6fSrGYPqqvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZWpJQE1x5345zg99VA7ivX8FRD6rGuRA4QGUYfUjrc=;
 b=pTahms+pTTVfvTWMJCOo0eF8jCK203XuS/Uhw9uiLOnQVqc3H8wJKo7qHg/3DqeB8pAMyn3MBJVRagZK7rLuPkAknz7Nb8W3zGVrBZqBtn5czD44lqUqzOphVpTJjb1zl6+3TeZpI+TUB5e/8bT2aQkvtDoPPg0HV4F+uZvJaqqN8794gwFNqTBHHMCzja59sAmdQcSwCGvgbq80mETADcjolFxgM4m44VDVvGKcTSoyj27/6fINqTkvSrz5EJRiX/OztZrd80DY0OIbAhd1noncP/5ZXIH6XVM1gP0DRUcMTKxIpcv5COzNzj+r7+x+cGj/aJNdnHuKVewuXAbxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZWpJQE1x5345zg99VA7ivX8FRD6rGuRA4QGUYfUjrc=;
 b=SNF6DWqYdluQxHktvVmx0tARmvXSHcefA66sp1jNULnX4tn/4l4h2soQNymOCQ5TZ+pbYPBUj4bQCBVdlgyZTvdtNzRyj+DqxlZzDgeDRfNKqBUpcQN0WNgEgkVCYo2Wtn6BhkNru+ET5DF7yOoVc46SvgPoi+8rr5EI3ovePiJUiSjD/fmVhHtZ0+Pj4CoQXgyvNRv7c86YTez48+ViRiYjWDSFYIJwQx3AbO51tarMs5Jb4mlWw/1a417i/u+nl3GVUG/TEvzONC+fJL8BmmAbbanjHzGOgX1cpLLi8XA74PS855nTnA8QrWH0filZeGU6L20GQ/+CeUmnxiYpDA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU7PR04MB11236.eurprd04.prod.outlook.com (2603:10a6:10:5b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:36:47 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:36:46 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 2/4] mtd: spi-nor: micron-st: add die erase for
 mt35xu512aba
Thread-Topic: [PATCH 2/4] mtd: spi-nor: micron-st: add die erase for
 mt35xu512aba
Thread-Index: AQHcUfbhpmf17ZBVVk6IhfhAJRf5dbTrdVuAgAGiYCA=
Date: Tue, 11 Nov 2025 07:36:46 +0000
Message-ID:
 <DU0PR04MB94962152C21F8EFA001812B790CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-2-cde50c81db05@nxp.com>
 <4479a34b-58b3-45aa-9d2e-5e2a64f61e9d@linaro.org>
In-Reply-To: <4479a34b-58b3-45aa-9d2e-5e2a64f61e9d@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU7PR04MB11236:EE_
x-ms-office365-filtering-correlation-id: 7b53d28b-052a-49f7-a2e7-08de20f5115c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?d2RLdVN3elhqMStSQWVaRXAwdE5qaDZiMHRjYzNTWEhDT1JlWUd2M1VnVXRQ?=
 =?gb2312?B?dSt6L2R4Ukk2NHRGSXZiRURScnErMG1NcGNGb1JDbm51TXJ3VloxRGpONUVj?=
 =?gb2312?B?V1RaMllsM2NOdEtxNXB3YVZSSHpMS3VzK2dxbzd4TEN4QTUvM21MZWR6Ykpr?=
 =?gb2312?B?bDZmK1JJa21uMUVoZWFpcFdXZ00wbC82VEVJUklCN0laMC9oSnZoMkNOSUxr?=
 =?gb2312?B?ejM2RzgxM0pQeGpwVEtVb2hnVVNxV0x3OHM2WEVrcFJzTGFiNGJHZG4yVHFH?=
 =?gb2312?B?UDVvaWFZZkFYaWtqbGVxMDBHRnhYUjhUSU5qWWVLQWxNRGQ2Z2tuaEF0MEc0?=
 =?gb2312?B?TzBOVmdUbC9nMVFxYnNnQ3NTcHlBOVRPRDBSWVFJVmZKcHZRMVNSTmxBVWV1?=
 =?gb2312?B?VGE3Y1hvVXJFZHJlNE5xUVJuM3RlZm9XcWNNNG9sajQzbnE3aVpyOHkvandB?=
 =?gb2312?B?ejhkVWpmbVNxVVBpdTRWNUZHdk51ZTYxMGd6K1hYalE0TlM3S1BDbXEzbnM5?=
 =?gb2312?B?TS9zcjM0S2M0MDVHSmd3Ym1HanlMdUpyZGtRcUdoUi9uei92aXhNcGRxVUdO?=
 =?gb2312?B?SW1kUFJIdmZURE1ScllBWHpZSGQyWm5lWFRINUNnR0NMallrcHRNWlNBVkVz?=
 =?gb2312?B?VEQzV0luVVgrT295am1CTkUrSGFjWkh5THhjZ01Yd3V5OUN6TDBXeW9MeHR4?=
 =?gb2312?B?NUtrcngvejRrak1hd3QwckFmODFYd2FhM0M4UEk5aU5jbXY0MytrT0lTbEZs?=
 =?gb2312?B?NHM0VDNucmpXa1UrMVJyczVPUWlDcVlJQjd3ck5nL1FQamxZUytPTEJBQjN0?=
 =?gb2312?B?VHVJQ0Y2SnczbHBTRVBJaWhXYWE1SVJRenkveFhmc05MOGRwT1lJejNRN2Fu?=
 =?gb2312?B?SW1xNXk4dFBJZ0g1WExjSS9BemI2S0YzSnk2TTM5bzlrSC9KZk9yNlpNaG05?=
 =?gb2312?B?UGJxVHRTUmJqcnZXL1hGSUsxc3J3ZmdHaFZhNW5odmhwZXIvME9wRWZEV1JO?=
 =?gb2312?B?ZXI1K0hhZXU0NVJnckVRWCtiankxL1VHcFpYVGF0YjN6THc1V0ljeE9hc0p6?=
 =?gb2312?B?clBuSDVsa3RPb2l2MXVHenRjZTdsWWRVTW5BWjRDM05GRHpQWUh2bHdpQjll?=
 =?gb2312?B?MFA4aGNIZG9CbXZ2Z2owRkNGMk5GSVVMUVpVU0JobGVUSWtxYUxYcitlczNu?=
 =?gb2312?B?d09LUC9NZHlJb2lnTzRidE5nMzMzSEJlZ2xjYmw1TTB4TG0vQjRPbVU2Q2lD?=
 =?gb2312?B?Rm5ZN3d4dUtFclBLOFNyeGNXWmtvU1EwYkc5M3RQSkowWWxweVZtdVVNNkpY?=
 =?gb2312?B?Uldna1JiVG9CRmpFSzFlOXkwWGpQL2VNOUpkWURNaElUaW1XSEloSi9UVjlF?=
 =?gb2312?B?RDJzeklGZm5VSXIyL1c2TGtDaEFwa0hDQ0hBVDNKTzZFYVAwQUZNNU9DYng2?=
 =?gb2312?B?VWxTUXNxSzFQdlFiTkZMMzFBYjZ6T0xMS21Tb0pPaHNnVkdUZ3R4b1BuaHF3?=
 =?gb2312?B?RHBieTcyL0Z1MHVENk9kVVlBVm5Sa1l4VGRZazJLM3dPaTAzU0ZOUkNrSzRl?=
 =?gb2312?B?ekFlOVkvU0lXSlMzbDd0eEUxRXpwR2xUcnVCOW95ZklGbHdrNXdXMHREU0RK?=
 =?gb2312?B?ZUY3blZQWk5UczRUOWREOGw5bG5TQ21ZYlRjbUtTVkRiUjN3Y0pXeWxHYTh3?=
 =?gb2312?B?bDluQkdudW0yNDk1cWlyVHRUL3o3dXN0OE4rYUlBNWVGaFV0aDRnM3hxWStz?=
 =?gb2312?B?RUd2azBJUVFYWFFlQUlQOVk5M2Nkc3JHa2hkaTM1bW00ZDlrNU9hSUlVOTNO?=
 =?gb2312?B?bmt1VmNuSzBvK1kxV3FlUkh1bjhvOHRyOW1xOVpyemNKbHE5RVNvZW5zYVNa?=
 =?gb2312?B?VStkOWltbGxqeFdaaUt1NzRPSVUwUXVkSmpmbm5rdDl6bjFWeXMrMDZlZm5L?=
 =?gb2312?B?TU1hc1hWaDcxZmRta3BWMXVrZnI0czRWQnROYmFZUnRNd05yOUVEb1NsL2hJ?=
 =?gb2312?B?aHJVYk5yb2E0b0RWTDhsNjhIcVdlQkZaU1hVRGdaT0xpZVg4ZVNRQVZCcmNP?=
 =?gb2312?Q?sXIZ8l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bmZ5QUZhNzVCNjQvclF6elpMQUM4UmZzTFJOVmxDQ1RDOUh1RzJUMEQxQ2tR?=
 =?gb2312?B?cFJneHFnTHgyTnBqbkdYdDllMFFvVGpTRGQyZWJJUnU1N1ZOaytUYk10NzVl?=
 =?gb2312?B?djJxZnJuUXR1MHVqb0VEMGMvRzBsa1ppY0lwMG5DY09HVTVuZGVESldZb0dR?=
 =?gb2312?B?YVU3RHI2VFB0MlNDRjl4TDJxN0ZzM2hrV1BSYU44c3ovSFVMYUluTEMyN1Br?=
 =?gb2312?B?TWxZcE93Tmp3NTk5ZzZqU3EveVN1bzlZNXNGQVpHSTNUZzdKV1R6NGJZejls?=
 =?gb2312?B?MmdvakgrZ0hHaGpOck1TelRKcVJOOGJ2WU1sZG5mL25BWVNQdWdmMlIyMm9D?=
 =?gb2312?B?UXo1OCt1NDlOQ2NXdTZBa3IxazVKME0wOW5HNmsvZ0tGQ1Q3THRoVTdnT0k1?=
 =?gb2312?B?OGNNR1hUblVUVzdNWmJFQXNlVHJsR1NrWW5PWFg0N0VWZmJoWThaVUVCTVZq?=
 =?gb2312?B?anNnQTFmdW9wWVh2S0Fhcit4ZlR0TWdBSFJJdVhHbU9qSVNYVWNndkVtZGtj?=
 =?gb2312?B?WUpqOXBXM2FaVXhMcGswQVQ3U2N5NnVvRUtEZUp4bk5vbkNTcmxUNHNmUmNl?=
 =?gb2312?B?WTJJQmFiY1J5Nk16T0hnSWY3bW54d2g3NzZwWHVnQ0FjTTVhdFIwQXdzL2pB?=
 =?gb2312?B?WWJGRnhMTFJ4UzlBeXJTSTVTaU1TZ253blBZMXNtWXlzalhxbDk5dStTZlNW?=
 =?gb2312?B?U2ZiZXFBNzBITVkyRWp4SkQ0WkxIMlBPYWpSWVE2K2hvdFZzTUwxbVpDV0hH?=
 =?gb2312?B?TXBkVjJ2RnBCZlJGVUpkenNoeWZCMWx3SjJjNjBJR0U2Wk8wMkdjbzhua3VF?=
 =?gb2312?B?Wmx5QnNtQjNxS0Q2bVZ0OEhjUjM4d0F5WC9IbFlObXJ3Z05pMmdKL2hySU1N?=
 =?gb2312?B?TU9vRnZaUk1EaVZ1N3A3eEFTV3RyRHZuRklza240VXNIZVMraEVOSHRjZGQw?=
 =?gb2312?B?NUYyR0J0SlA5eFhyNWxtKzNQTGdESTM4OXV6cVd0S2NvN0JZU2dPdHczOHZI?=
 =?gb2312?B?M1YxeE1ieUVLSnE5RVlvdk04NVlIMlhFNXZ1Y3JOMnlaVStVaS9HNTlkd3JN?=
 =?gb2312?B?a1JpQU5RL1U1b0dncXBtQXVBUlhSc29WRzZuQUt5WEZYNUYyN0tjeDJlWDNQ?=
 =?gb2312?B?dmlWNzFHa0N2aW9kRlZ0azE5S2tydUd2M3UxNGlKOTN1QTR6c3RzQ3BEakp6?=
 =?gb2312?B?bDUvT3VsNlk5YkdjY2hZWnoyeTl6UURCb0NkY3p4ZkxpV0ZvVTZiQ2dUMmR4?=
 =?gb2312?B?T3dnZzNqTW9ielllYVBzZC9md2hOclpkdlR3UTZRQmRWVktQOUp1aGNLY1Zm?=
 =?gb2312?B?QnpUZ2lxNnV4SDFDUFhaS1VobUFDSFU1WWh3eGxmUXdPZnp1MjF1RFVuWUlU?=
 =?gb2312?B?aXlpcmdLU0V3UFRVOHFPRGJSeWdtWmtydVYyc2Myb29LRE4wUEMrWmkxUXRu?=
 =?gb2312?B?dmhHdnZTMUIyNUtQZmswMk5ocjFDSVFvMnhqTUt2T3FBTjBPS0VCVlRXRWlG?=
 =?gb2312?B?dU9IRHFFOEI3TmVNNmtPb2hOOGtCc0puU3pLbWxFVEJsbEhsN0RGdnNQN1JV?=
 =?gb2312?B?UmZ6QUJ6NlA2N2lYRmxFZGJ4Q0lsVmdNNnlxUWFsZFFydjErb3kyN0hkTTQ3?=
 =?gb2312?B?dytOYkpMZkNWZDZNRHpRckR4eWMvNGNvQzVURGdHSTl0YWwyNDBPclNEQlFm?=
 =?gb2312?B?Sy9aR25rdHBUYzQ2L2U2YVpueUs5cnIzV0VLWDJYTHpZQTQ1aldITE1qOUVP?=
 =?gb2312?B?Q2tLeXl3VUlzZUpCNndieUlXKzNlTHhpcFNBVmEvdUQ2S3duK3d1eEZIL0o5?=
 =?gb2312?B?Q01zL3R6cm1lSWxiUnVWdnB6aS9GeHkzeFBZVGV3L0xKeHpiWkNJaGtBNDYw?=
 =?gb2312?B?UlpiM2tDRkNGN0V0NTFUNFNLVUcrODVhQ1hneGVWekxLOWlZWUtQYno2WVRI?=
 =?gb2312?B?YWJCN28rZjdxZlhZTjFwSjV1Rk1iMFRUL1pBNjIwSElWQXhCemUzSlcvb0RX?=
 =?gb2312?B?Yko0Sk1ieWRYcG5URFJaYnFXbm9DVi8zVlloaWVRdHBqeU9PWlNZa1hZTWh2?=
 =?gb2312?B?U1BjR3ZrQnU2M2ZNN09JbHdtTmxzdWliMlZLcHoxbnZJbG10TUM4UVpsMmNE?=
 =?gb2312?Q?hlK8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53d28b-052a-49f7-a2e7-08de20f5115c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 07:36:46.3392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMu5b8InE1SiWibenJl19MTnMpo9erpHhCfher+ahz5k4Z0Gbi0dfM2f6jItos9hlXA0Trc5NgPotTVpnHcrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11236

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEx1MIxMMjVIDE0OjM5DQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBQcmF0eXVzaCBZYWRhdg0KPiA8cHJh
dHl1c2hAa2VybmVsLm9yZz47IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPjsgTWlx
dWVsIFJheW5hbA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47IFJpY2hhcmQgV2VpbmJl
cmdlciA8cmljaGFyZEBub2QuYXQ+OyBWaWduZXNoDQo+IFJhZ2hhdmVuZHJhIDx2aWduZXNockB0
aS5jb20+DQo+IENjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDIvNF0gbXRkOiBzcGktbm9yOiBtaWNyb24tc3Q6IGFkZCBkaWUgZXJhc2UgZm9yDQo+
IG10MzV4dTUxMmFiYQ0KPiANCj4gDQo+IA0KPiBPbiAxMS8xMC8yNSA2OjAyIEFNLCBIYWlibyBD
aGVuIHdyb3RlOg0KPiA+IG10MzV4dTUxMmFiYSBkbyBub3Qgc3VwcG9ydCBjaGlwIGVyYXNlIGNv
bW1hbmQsIGFuZCBpdCBjb250YWlucyBvbmUNCj4gPiBkaWUsIGFuZCBvbmx5IHN1cHBvcnQgZGll
IGVyYXNlLg0KPiANCj4gZG9lcyB0aGlzIG5lZWQgYSBmaXhlcyB0YWcgdGhlbj8gV2l0aCB0aGF0
Og0KPiBSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3Jn
Pj4NCj4gPiBVbmZvcnR1bmF0ZWx5IHRoZSBkaWUgZXJhc2Ugb3Bjb2RlIGRvZXMgbm90IGhhdmUg
YSA0LWJ5dGUgb3Bjb2RlLCBoZXJlDQo+ID4gZm9yY2VkIHRvIGVudGVyIGluIHRoZSA0IGJ5dGUg
YWRkcmVzcyBtb2RlIGluIG9yZGVyIHRvIGJlbmVmaXQgb2YgdGhlDQo+ID4gZGllIGVyYXNlLg0K
PiA+DQo+ID4gTGluazoNCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZkYXRhDQo+ID4NCj4gc2hlZXQub2N0b3BhcnQu
Y29tJTJGTVQzNVhVMDJHQ0JBMUcxMi0wQUFULU1pY3Jvbi1kYXRhc2hlZXQtMTM4ODk2DQo+IDgw
OC4NCj4gPg0KPiBwZGYmZGF0YT0wNSU3QzAyJTdDaGFpYm8uY2hlbiU0MG54cC5jb20lN0MyNjMy
ZWMzMWYzNDI0NzQ4ZjhhMzA4ZA0KPiBlMjAyMw0KPiA+DQo+IGM5NzMlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjM4OTgzNTM1MjY2OQ0KPiAwMDI5MCU3DQo+
ID4NCj4gQ1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlp
T2lJd0xqQXVNREF3DQo+IE1DSXNJbEENCj4gPg0KPiBpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0Zw
YkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPUgNCj4gMEJvaQ0KPiA+IHRo
bU9jMHZ1SzZNTmZDWUhDZ1M4ZlBPTldxelBpJTJGaTVnRmxjdUElM0QmcmVzZXJ2ZWQ9MA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gDQo+IEFsc28sIHdvdWxkIHlvdSBwbGVhc2UgaGVscCB1cyB3aXRoIFNGRFAgZHVtcHMsIGFz
IHlvdSBkaWQgaW4gdGhlIG5leHQgcGF0Y2hlcz8NCj4gSXQgaGVscHMgdXBzIGtlZXAgYSBkYXRh
YmFzZSBhbmQgdXBkYXRlIGZsYXNoZXMgdG8gZ2V0IHJpZCBvZiB0aGUgbm9uIFNGRFAgZGF0YS4N
Cg0KT2theSwgd2lsbCBhZGQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzDQpIYWlibyBDaGVu
DQo+IA0KPiBUaGFua3MhDQo+IA0KPiA+ICBkcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5j
IHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1z
dC5jDQo+ID4gYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIGluZGV4DQo+ID4NCj4g
OTJlYjE0Y2E3NmM1N2YyOWVjZTFlZGIzZmU2NTJjNTZkMWMyODg4Zi4uODljZDE0NjA5NTU4NGRk
ZWJkZDI1OGExOA0KPiA2ZjYNCj4gPiAzOThiNDIwZTU4MDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3IvbWljcm9uLXN0LmMNCj4gPiBAQCAtMTU5LDYgKzE1OSwyMiBAQCBzdGF0aWMgaW50IG1pY3Jv
bl9zdF9ub3JfdHdvX2RpZV9sYXRlX2luaXQoc3RydWN0DQo+IHNwaV9ub3IgKm5vcikNCj4gPiAg
CXJldHVybiBzcGlfbm9yX3NldF80Ynl0ZV9hZGRyX21vZGUobm9yLCB0cnVlKTsgIH0NCj4gPg0K
PiA+ICtzdGF0aWMgaW50IG1pY3Jvbl9zdF9ub3Jfb25lX2RpZV9sYXRlX2luaXQoc3RydWN0IHNw
aV9ub3IgKm5vcikgew0KPiA+ICsJc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyICpwYXJh
bXMgPSBub3ItPnBhcmFtczsNCj4gPiArDQo+ID4gKwlwYXJhbXMtPmRpZV9lcmFzZV9vcGNvZGUg
PSBTUElOT1JfT1BfTVRfRElFX0VSQVNFOw0KPiA+ICsJcGFyYW1zLT5uX2RpY2UgPSAxOw0KPiA+
ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBVbmZvcnR1bmF0ZWx5IHRoZSBkaWUgZXJhc2Ugb3Bjb2Rl
IGRvZXMgbm90IGhhdmUgYSA0LWJ5dGUgb3Bjb2RlDQo+ID4gKwkgKiBjb3JyZXNwb25kZW50IGZv
ciB0aGVzZSBmbGFzaGVzLiBUaGUgU0ZEUCA0QkFJVCB0YWJsZSBmYWlscyB0bw0KPiA+ICsJICog
Y29uc2lkZXIgdGhlIGRpZSBlcmFzZSB0b28uIFdlJ3JlIGZvcmNlZCB0byBlbnRlciBpbiB0aGUg
NCBieXRlDQo+ID4gKwkgKiBhZGRyZXNzIG1vZGUgaW4gb3JkZXIgdG8gYmVuZWZpdCBvZiB0aGUg
ZGllIGVyYXNlLg0KPiA+ICsJICovDQo+ID4gKwlyZXR1cm4gc3BpX25vcl9zZXRfNGJ5dGVfYWRk
cl9tb2RlKG5vciwgdHJ1ZSk7IH0NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIG10MzV4dTUxMmFi
YV9kZWZhdWx0X2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikgIHsNCj4gPiAgCW5vci0+cGFyYW1z
LT5zZXRfb2N0YWxfZHRyID0gbWljcm9uX3N0X25vcl9zZXRfb2N0YWxfZHRyOyBAQCAtMTg5LDYN
Cj4gPiArMjA1LDcgQEAgc3RhdGljIGludCBtdDM1eHU1MTJhYmFfcG9zdF9zZmRwX2ZpeHVwKHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfbm9yX2ZpeHVw
cyBtdDM1eHU1MTJhYmFfZml4dXBzID0gew0KPiA+ICAJLmRlZmF1bHRfaW5pdCA9IG10MzV4dTUx
MmFiYV9kZWZhdWx0X2luaXQsDQo+ID4gIAkucG9zdF9zZmRwID0gbXQzNXh1NTEyYWJhX3Bvc3Rf
c2ZkcF9maXh1cCwNCj4gPiArCS5sYXRlX2luaXQgPSBtaWNyb25fc3Rfbm9yX29uZV9kaWVfbGF0
ZV9pbml0LA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5m
byBtaWNyb25fbm9yX3BhcnRzW10gPSB7DQo+ID4NCg0K

