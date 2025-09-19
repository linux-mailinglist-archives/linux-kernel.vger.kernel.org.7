Return-Path: <linux-kernel+bounces-824215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077ECB88695
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C55177AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE22FBE0C;
	Fri, 19 Sep 2025 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMmuTwIw"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE23043AE;
	Fri, 19 Sep 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270368; cv=fail; b=VQPMP5AB661u0fc3TEUYIqfeU24MgdzENqQ+v81n4wqa0HmtYJtIXhFP7GiwScAzGX2bVidqXd0sJdljMpnHp3R7cc+UA7kxgcXmtZcS8cfwlKL3OzyPCkXvXRYSgmsDaNOIvCwdDMtQDeLNBp5aGo624KjtOPGwuUvc8VD9wpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270368; c=relaxed/simple;
	bh=xrSuKhYvgnt933JmC7CGX3umc6Fq/7mXxQuAwP1X0e8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vBx4UCcnFYWOqY43UUVsH9s4JavednmOQ7qqzVEy1mRvuI/I+rOCKkHHcbvEpBxNY0gunlVzGgOhlQPQAn7056xXqJ5jL59JU3r2h0auTJHaouHD1QUnzI0WXjYyu7dkbqV9JW6EHf4B/MIOhCuWsXB8XaMRKiICYR1/ZKyWIG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TMmuTwIw; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRpU9/fpFzGVNH7//WSUVKOaze3LxC3L7UJGlxTbeEtm5C03FQDDbIL7iXjM9xhMfvbs084TlGf35TuSXiYnCUHRsd7oNesJ2BvfW1dtj9BLNfYeetc+2n6CeCK0uxBsIUpILeQcxl1PTYSX5xNOA/2leX5DFjNEJKp0oIDMr9wbbFFqLRbbzpdrPWjjHfT2l5tSigYTVLR2W6/OEiMP7jIJzJejd4N8KLNBBk4n1sRTkUdFLtMPRIS9h+H3CaD6B0Wsc/IApFfazy6OT14VI4BfWHrcuGRwZ2zI19WoRFYrp8F/ZthghPmUsRuyAt6qeA9u48PjJ2GYWHxC0RIhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrSuKhYvgnt933JmC7CGX3umc6Fq/7mXxQuAwP1X0e8=;
 b=Bm/6Ecjo4V5k5AClTcT0Bf0KdIBNd0s252W8jb5Ml4BdHY2U5S/PgylKf+TsbLdBg9mFouJTAFNqOwsrtfyOgFe+UJUWJn5d+v0Yq1S4CD+nN84+OLbmHzCx2lR7WCLk+cKlLICbpp2FiumjR+Dos0IxXZg5ipY2zri0cr1c08WvzJRlPtW/AoQKrjSR4Y1usAFN3/kZK3s7nf+FSjqV7MHidLiekF6oDjgl8YwrTnDe9Q8c5bbNVnJCsO16qW3ovr6C8dBBFRqD2aY8+Z6waKskHnqWHRXYOoebchVA1UkH4H39dgHLLYIvx95kRae2a+Lj4/UehrA1cgg4vbkOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrSuKhYvgnt933JmC7CGX3umc6Fq/7mXxQuAwP1X0e8=;
 b=TMmuTwIw5s35Fa+Ux/Tal126Xo/5Ab78sYDib71mYHBTDZMmvdFNcBDuCs+KKAzoVnguCKe66K+Bx3NaiKH+I5KDzCNIBZL0aFbDWyyjF0tDyZ7G5GUrT2upyJN0/h4qMcz3WQRKmgHZvvpmy/28Ses2FofneTT62tKTm+7A5P5WVzvZ7QrD50Jnee4/hFpP41ClLqiFKusHHBrE8StBQy8aIuGKm2n2vjsF3Yod9tHL+Kb2u5tCr21JDzvCdli0JK/u3X9MxvNEmsu21OpzF0DGeX3OekDbF9llDPZCrvMqH5f69RvMHI3JTaYTquXuFh6C6s4xTggdes6kqC9rXg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB11577.eurprd04.prod.outlook.com (2603:10a6:10:607::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:26:01 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:26:01 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Michael Walle <michael@walle.cc>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan
	<peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, Marco Felsch
	<m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] arm64: dts: imx8mm-evk: limit the max frequency of
 spi nor chip
Thread-Topic: [PATCH v2 3/4] arm64: dts: imx8mm-evk: limit the max frequency
 of spi nor chip
Thread-Index: AQHcJ68ICHeMj8+9hU6aNZDJpTxzIrSYpmCAgAF4lICAACHHAP//7Gsg
Date: Fri, 19 Sep 2025 08:26:01 +0000
Message-ID:
 <DU0PR04MB949642DC45B33BD1B0587F059011A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
 <20250917-flexspi-dts-v2-3-7e2a95e3cf4d@nxp.com>
 <20250918090151.GB23028@nxa18884-linux.ap.freescale.net>
 <DCWLMKKUEALZ.CX4XNGWG80B8@walle.cc>
 <20250919093034.GK9196@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250919093034.GK9196@nxa18884-linux.ap.freescale.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DB9PR04MB11577:EE_
x-ms-office365-filtering-correlation-id: c66ea3b2-5b34-4ada-448f-08ddf7562ab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzNsQlZHQnVwR2hDb2cvS0RFNXdmdS9NQ2ZUb2hZTEs4RXZHRmJJTXY2d1Rp?=
 =?utf-8?B?d3Bxc0JrNEdKSUNON0daNjZlRkd5MmFCVHFlOGJTbjZwaC8rOG0wYVB2alhs?=
 =?utf-8?B?M2VXd0J1NHFocFZmWjkzZUI4RWw4RCt6MHVmNTdEcUhWK1grcFNvNHYzQVpD?=
 =?utf-8?B?ODBPeklQekh5UkNNY3pnTlY3c0IxZDRuanE3b2FWNWhBQlRhd09mV0lmS0xh?=
 =?utf-8?B?dm5OK3ZpVWN3RGkzRkprZG9WYThTekhhRDVVemoyTEJNWUl4dVVIYlBUODNm?=
 =?utf-8?B?eEZGMWlDdDRjeFQwNW1qdEtUc2RVY2NqUTg5c2FnaDBycEtSTk50dFo0bUxt?=
 =?utf-8?B?LzFEVmZOS00rRitQWVJIUWMvRWtla3NiVEhyd25KTzM5ZllodXg2WnZybVRi?=
 =?utf-8?B?dFpiUmVzUUo4ZHZRd1pabkFnUVZUNmR4b1I5VStjK1Y5TlAvS1dsZUliTTdR?=
 =?utf-8?B?K1crQ0VFSkg4Wi9HczNCQVJVRElsY3dWeisrVXVETWw0Y1FqbjF3YTFqSWFt?=
 =?utf-8?B?MjRCeVFNR2oybExTeDNXano2Vy9wK0VPc0JKT0lBODc5aE0yVk94YXBTaDVi?=
 =?utf-8?B?VnZqMWprWnFwYUFXTmFIazhUVWdOWmlYSFV4elpLQjRvbzg0c0dVclEzOHFp?=
 =?utf-8?B?cVM5d3pJUWlCOWRSYkVwRjNCVlBEQ21FWm1IVHNmUXNtZmRROXRMczMvWEJQ?=
 =?utf-8?B?UEVKd0w0QkNaMFhRSWhUdXlqcy9iYmx1a2NHYzF0Mjh3M2ZmdlZWQXlWY2cx?=
 =?utf-8?B?NXc3SHNEaTNHakJsRzExT0pzS0ZVVjloK0FIRENhSWVROFNSek92NDNjZzdV?=
 =?utf-8?B?NUo4ZVNQWWl0WnlHdGNPMTJ3QUwxSUZ6NFZNMG01TzlZVUo5TFo3Smhtdkxw?=
 =?utf-8?B?M0d6bU02U0lsK2lDbWRiSjJqUGdZRk1wWGdIUjVXbVRyZVBnd0ROV291VVZr?=
 =?utf-8?B?UDdMUTduUmVQUWJzdGZacVZMZS9ZRndzaHZMcHo5SDFqSERxZFhuaFMraHFm?=
 =?utf-8?B?U0c4QkkzUVFmOXdCZWhYdzdwaVhQdHJhUFY0TVRFNENmSDBIV2VwL2R4OUl6?=
 =?utf-8?B?OWhhdnBqK1YvZHQ5UlJiQkpoYmdyUzE1Nmo2OVgwQjFzRTdaT05VS3FYNXRs?=
 =?utf-8?B?R2tldWdZbnE0dG0wYUVZS09qTWJrUWtjenV3SVN5V1dVTGc3QmUvMnFpUlNh?=
 =?utf-8?B?ZFNmV0lLemZZZytXUVRZYk5md25RTWVVWmlnRS9PQ2w2aXR2eDR4dlUzWFBS?=
 =?utf-8?B?Ti81UERFU2JiSmJtUFZ2VXhGSG9jNzYzbnNuWThpNDViMmJ1SC9WbW5RSUJ6?=
 =?utf-8?B?dG81Ujh0WDBNdEhOd1M2WU0vQXZyQlJFU0pIYjRPeDdqcXBLdXdUckUxN0pK?=
 =?utf-8?B?K0J1aUJVSy8xc2xEMmF6eVJ6U2ZHRVJNTzZTcmpHd0VZK3A3eHBlK3RTcFl4?=
 =?utf-8?B?ajJtUlVlS0dSY1V6WFpNbnNXM2xJckFJYmIrbTdtVHNUTHZrTGoycFUvWDlv?=
 =?utf-8?B?SitDSlhFQUJpNEcwU0VIVUtKUkg1ekRqbmMrV1pkR3J6MlBsZHQ5bGFDKytY?=
 =?utf-8?B?NWdIR0UrSnhkN0tFVlFYdFBrQjJoWnMwYlhJTnF0UVdjMS9vNTE5dkQ5UVVM?=
 =?utf-8?B?NTg4MFBydUVXbWVEdnVNdGFvblg4V3lmbjlwMFBRaDFCRWhnNFgyOXB3VnV2?=
 =?utf-8?B?azdEcnVIR1NQaFd0M0N5ditsSUJGV0ZGdjlrNGpXd0lkNHp5cFZGMHpodHJw?=
 =?utf-8?B?K2hlRHZ5MHZGa2ZXdGt5RGNMcTZlMFlGTEgyOE5xYkNkemtnYXN6U2g2ZDhk?=
 =?utf-8?B?OWtmaWMrelUyOGRaTDZzV1ZzeldmbjJxZ2xGZkVLN3lRUEFFVzJzaEUrRXAy?=
 =?utf-8?B?TzlIeWMxdW1QRGd6NzNkL2x6Q3FOb2l5VGtGY2tiNTU0THhsQ21Ra0JPRjF2?=
 =?utf-8?Q?o/0N+FjM/hg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2l5MnhTQlpkTW8zMGtVSkFpNktnbnFLL3phM2tWbm9GVU5YSUtwVkRMZGpp?=
 =?utf-8?B?ejR4UlEycSswTmFXNnlYR1EwdVpOaDY1RHJHVVRid2V6aDI4YTFhRFpoV2Rj?=
 =?utf-8?B?amt4QkkzT2ZvNnRwaUdhSldwbUJKTkNPVDc5ZUZyR2JTb3BWQm9TTmFrK1BR?=
 =?utf-8?B?UjBVMG93Rzh3RXJEdEVlL0hPS3Z0Uzg1VjhRYnNWaDBGRTMzTytEUG1TM3dy?=
 =?utf-8?B?NkVCWmZUdUlsb3JNK2VSNjkrcjhyS0lUYk4xaXVId3dBaEtyVTFmWmtGeldJ?=
 =?utf-8?B?YjZWaG0wTFg4NkNyZkJqdndQUlhZRHFidzJJMzhta2Y1alNQdmFUamV6ZXBD?=
 =?utf-8?B?VHFkcW9OTHBFN1RBS2FzQjRKSW8yVzg5M0lyVkpqT0J4cTRFZlovRW95ck5j?=
 =?utf-8?B?eGVtTHd4YUc3Yk5ZTlFGSTNDenpYY0l2RUZkMW5zMk1hRmFUQVRuaHlUenlz?=
 =?utf-8?B?MGpQcmNzOWIzYnNxdUdWV3FLTlZyazVFeVcwYms1ZjFUanBVUzlzQlJ1THAy?=
 =?utf-8?B?YVhXZTV5SjlDdVJRSDNmL0Z2SUpwSndlQlJsMUhsQzFVMDQzNGcwc2ROa1dq?=
 =?utf-8?B?eVN1QWs0VXRpRmIvTjlDS1BYTmg3MnJKMVB4bWRKZGRkWVcxeDF1ZGlMSldm?=
 =?utf-8?B?cm8rTmNGNjU0aHlYWUZ4RU54Qmc2dTRKM0FMcDB4bUg1OFpsTUxuQ3E1MEVY?=
 =?utf-8?B?WXpxTFd0bG1mdnk4dk0rTkV1TnZ4a2lNblU0OWtiTlFJcUd3S0tXT2FORUlE?=
 =?utf-8?B?QTJmb1lVYVFwOU5HMGZKbG9mc2tFd29Db0NLbEZsZk80Ujc1a3NZdEcwOTdO?=
 =?utf-8?B?U1gwR0hzUmxtWmRkZlIzYXdVZVdrcVFFdVZMMlI4RCtWUkY3NEp6TXJPZnNj?=
 =?utf-8?B?ODBVd0JEdTZjME5iQjI4NFVTWkNjTDhnbnJNOXYyWWg0Tm1hUm5vTmozTndr?=
 =?utf-8?B?SzNCT1dtRWpERERzUWFJR3psOGpCZWpHSHZQd1ozOTQyYTVXcjNaUllTaG1J?=
 =?utf-8?B?VGlQTTNnVi84ekk3Q0FBOGlEOFZmOUZkdFhQblFEcW5BanFWRi9MZ2x1RXpz?=
 =?utf-8?B?R2VtVVV4NFBzZWI2Z3BjdDlISlVUQ1ZkRkk4MGNJcnFmeE1xQTBuOEFGNFFY?=
 =?utf-8?B?S2RYdmtIN3RwZHYwZWZuN0FPajhhdHBmWWh6S2Nvb3NxRHNxODdidFI4b2VU?=
 =?utf-8?B?QUd5SlVIbFlFWXlNZ0RuYldiTFhVa0p5cVlURDBmak5DSWFlTld6T3FIMlh6?=
 =?utf-8?B?NWhyYzR2dGptT1plUysyTVZobk5GMmNnNGJZR2tCb3daYXZBQXRWSTZjaEJm?=
 =?utf-8?B?bjVFL1gwS2JDVlRvTUR4M0hDWUFTNDFNc0RHRzlMbE9lemJyQnA4aC9ZOGJy?=
 =?utf-8?B?OUtLTDdrN1dsWml1c2JMRUZZMTVQN0JsM3ZuR3hIY3J0NDBjcFluZWhqSytF?=
 =?utf-8?B?bmpFUEZweEV4VjZlN0l6Vk8rZFo1REtYY3FZN1ozdHdzM0RyUmFDT2xBUHVU?=
 =?utf-8?B?NXF0VGd6bGh2VE83VmxxcmM2VXlBNXJiazBLRHNBMmlyYzBSdDkwTFFOOHM3?=
 =?utf-8?B?YlZGMFpicHNZRFc2cXk1VmpMdmZqVUNDVTh6aVVtZ2RpdGl1VUxJL05PYlBQ?=
 =?utf-8?B?YldzQU5QK2JwNTdmMUJIaHNrSWV6eno5T0lVR1o5dTJSYWhTVGIrZmR1aGJs?=
 =?utf-8?B?S0VNTmpmd2x5dnJoUFBvYWpxQXdCdGxlUWhhYkdmbEQ0Qm5qNGJJY1ExYlV3?=
 =?utf-8?B?NkRYZXZLMTRTem0vWWFuQlVpRWJJbnBmV3lRekRlLzU3Q3Z3b08vcXNnVWp2?=
 =?utf-8?B?YkJxbjZ5dGJJK0cwOHZ1QisxOElvN0hGcXhwRUVoZ2xjeW9Kc05TQUpXdjRC?=
 =?utf-8?B?YTNoUXRRWWVIYmVEcG1IM25SaEFOeGk2YjVrQnFZT1FTRCtTVDIxZ3FDa1dh?=
 =?utf-8?B?Q1JYMnR4NlhYeWdKQzFjMmZ0YlJoeXR4L1AxNTMyRmowbnh4dE1OU2RTd2NQ?=
 =?utf-8?B?S3NYeDZNeW5tdDdieG1vUnF0VytKU09QZVYvUkg1SnM4YURXK3cwWFdFTm1S?=
 =?utf-8?B?YWFKUFdtQkRqUVhxMXlIZ1dXZWVqZDgrSklBSkxwZVFyakloaWw3ZTZaZ2RZ?=
 =?utf-8?Q?J+H8=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c66ea3b2-5b34-4ada-448f-08ddf7562ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:26:01.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jknS28ss4tPi0ulKcz2Caz7fe/PhxRjoixWyXt0TUFuAYFdIVothpF0YEnXN3NO6d8HLP0aYWpJQP9NrMLII0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11577

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVu
Zy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IDIwMjXlubQ55pyIMTnml6UgMTc6MzENCj4gVG86
IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IENjOiBCb3VnaCBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25v
citkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hh
IEhhdWVyDQo+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRl
YW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdt
YWlsLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgRnJhbmsgTGkgPGZyYW5r
LmxpQG54cC5jb20+OyBNYXJjbyBGZWxzY2gNCj4gPG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPjsg
SGFuIFh1IDxoYW4ueHVAbnhwLmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBp
bXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAzLzRdIGFybTY0OiBkdHM6IGlteDhtbS1ldms6IGxpbWl0IHRoZSBtYXggZnJlcXVlbmN5IG9m
DQo+IHNwaSBub3IgY2hpcA0KPiANCj4gT24gRnJpLCBTZXAgMTksIDIwMjUgYXQgMDk6Mjk6NDFB
TSArMDIwMCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gPkhpLA0KPiA+DQo+ID5PbiBUaHUgU2Vw
IDE4LCAyMDI1IGF0IDExOjAxIEFNIENFU1QsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBPbiBXZWQs
IFNlcCAxNywgMjAyNSBhdCAwNDo0MjoyOVBNICswODAwLCBIYWlibyBDaGVuIHdyb3RlOg0KPiA+
PiA+VGhlIHNwaSBub3Igb24gaW14OG1tIGV2ayBib2FyZCB3b3JrcyB1bmRlciBTRFIgbW9kZSwg
YW5kIGRyaXZlciB1c2UNCj4gPj4gPkZsZXhTUEluX01DUjBbUlhDTEtTUkNdID0gMHgwIGZvciBT
RFIgbW9kZS4NCj4gPj4gPkFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0LCB0aGVyZSBpcyBJTyBs
aW1pdGF0aW9uIG9uIHRoaXMgY2hpcCwgdGhlDQo+ID4+ID5tYXggZnJlcXVlbmN5IG9mIHN1Y2gg
Y2FzZSBpcyA2Nk1Ieiwgc28gYWRkIHRoZSBsaW1pdGF0aW9uIGhlcmUgdG8NCj4gPj4gPmFsaWdu
IHdpdGggZGF0YXNoZWV0Lg0KPiA+PiA+DQo+ID4+ID5SZWZlciB0byAzLjkuMTAgRmxleFNQSSB0
aW1pbmcgcGFyYW1ldGVycyBvbiBwYWdlIDU5Lg0KPiA+PiA+aHR0cHM6Ly93d3cubnhwLmNvbS9k
b2NzL2VuL2RhdGEtc2hlZXQvSU1YOE1NSUVDLnBkZg0KPiA+Pg0KPiA+PiBUaGUgU29DIFNEUiBt
b2RlIG1heCBzdXBwb3J0cyA2Nk1IeiwgMTMzTUh6LiBERFIgbW9kZSBtYXggc3VwcG9ydHMNCj4g
Pj4gMzNNSHogYW5kIDY2TUh6LiBTYXlpbmcgdGhlIGRyaXZlciBub3cgb25seSB1c2UgUlhDTEtT
UkMgMCB0bw0KPiA+PiByZXN0cmljdCB0aGUgZGV2aWNlIHRyZWUgdG8gNjZNSHogaXMgbm90IHRo
YXQgY29ycmVjdC4NCj4gPj4NCj4gPj4gVGhlIFNvQyBtYXggZnJlcXVlbmN5IGNvdWxkIGJlIGNv
ZGVkIGluIGRyaXZlciBwZXIgbXkgdW5kZXJzdGFuZGluZy4NCj4gPg0KPiA+WWVzIHRoYXQgaXMg
Y29ycmVjdC4gVGhlIHNwaS1tYXgtZnJlcXVlbmN5IHByb3BlcnR5IGlzIGZvciB0aGUgZGV2aWNl
LA0KPiA+bm90IHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIGNvbnRyb2xsZXIuIEkuZS4gdGhlIGZs
YXNoIGNoaXAgb24gdGhlDQo+ID5ib2FyZC4NCg0KT2theSwgSSB3aWxsIGFkZCB0aGUgcmF0ZSBs
aW1pdGF0aW9uIGluIGhvc3QgZHJpdmVyLg0KDQo+ID4NCj4gPj4gRm9yIHRoZSBRU1BJLU5PUiBj
aGlwLCB0aGUgc3BpLW1heC1mcmVxdWVuY3kgc2hvdWxkIHJlcHJlc2VudCB0aGUgTk9SDQo+ID4+
IGNoaXAgZnJlcXVlbmN5LiBCdXQgdGhhdCBjaGlwIHN1cHBvcnRzIFNEUi9ERFIsIHNvIGEgbmV3
IHByb3BlcnR5DQo+ID4+IHNwaS1kZHItbWF4LWZyZXF1ZW5jeSwgaWYgd2UgdGFrZSBzcGktbWF4
LWZyZXF1ZW5jeSBhcyB0aGUgbWF4IE5PUg0KPiA+PiBDSElQIFNEUiBtb2RlIGZyZXF1ZW5jeT8N
Cj4gPg0KPiA+V2hpY2ggY2hpcCBpcyBpdD8gSSdtIG5vdCBzdXJlIHRoYXQgdGhpcyBpcyByZXF1
aXJlZCBiZWNhdXNlIHRoZQ0KPiA+c3VwcG9ydGVkIG1vZGVzIG1pZ2h0IGJlIGluIHRoZSBTRkRQ
IGRhdGEgYW5kIHdlIGp1c3Qgc3VwcG9ydCB0aGUNCj4gPjhkOGQ4ZCBtb2RlIGJhY2tlZCBieSB0
aGUgSkVERUMgc3RhbmRhcmQuDQo+IA0KPiBNVDI1UVUyNTZBQkENCj4gQ2xvY2sgZnJlcXVlbmN5
DQo+IOKAkyAxNjYgTUh6IChNQVgpIGZvciBhbGwgcHJvdG9jb2xzIGluIFNUUiDigJMgOTAgTUh6
IChNQVgpIGZvciBhbGwgcHJvdG9jb2xzIGluDQo+IERUUg0KPiANCj4gQ3VycmVudCBzcGktbWF4
LWZyZXF1ZW5jeSBkb2VzIG5vdCBpbmRpY2F0ZSBpdCBpcyBTVFIgb3IgRERSLg0KPiANCj4gSWYg
ZGV2aWNlIHRyZWUgaGFzIHNwaS1tYXgtZnJlcXVlbmN5IGFzIDE2Nk1IeiwgYnV0IGRyaXZlciBj
b25maWd1cmVzIHRoZQ0KPiB3b3JraW5nIG1vZGUgYXMgRERSLCB0aGVyZSBtaWdodCBiZSBpc3N1
ZXMuIEkgbm90IGxvb2sgaW50byBkZXRhaWxzIG9uIFNGRFAgb3INCj4gOGQ4ZDhkOGQsIHNvIG15
IHVuZGVyc3RhbmRpbmdzIG1pZ2h0IGJlIHdyb25nLg0KDQpNaWNyb24gTVQzNXggaGFzIG1vcmUg
Y29tcGxpY2F0ZSBsaW1pdGF0aW9uOg0K4oCiIENsb2NrIGZyZXF1ZW5jeToNCuKAkyAxNjYgTUh6
IChNQVgpIGluIFNEUiAoMTY2IE1CL3MpICgxLjhWKQ0K4oCTIDIwMCBNSHogKE1BWCkgaW4gRERS
ICg0MDAgTUIvcykgd2l0aCBEUVMgKDEuOFYpDQrigJMgMTMzIE1IeiAoTUFYKSBpbiBTRFIgKDEz
MyBNQi9zKSAoMy4wVikNCuKAkyAxMzMgTUh6IChNQVgpIGluIEREUiAoMjY2TUIvcykgd2l0aCBE
UVMgKDMuMFYpDQoNClNlZW1zIG5lZWQgYWRkIHRoaXMgcmF0ZSBsaW1pdGF0aW9uIGluIHNwaS1u
b3IgZHJpdmVyIGZvciBkaWZmZXJlbnQgY2hpcHMuDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4g
DQo+IFRoYW5rcywNCj4gUGVuZw0KPiANCj4gPg0KPiA+LW1pY2hhZWwNCj4gPg0KPiA+PiBTbyBp
ZiBzcGktbWF4LWZyZXF1ZW5jeSBpcyB0aGUgbWF4aW11bSBOT1IgY2hpcCBTRFIgZnJlcXVlbmN5
LCB0aGUNCj4gPj4gZHJpdmVyIHNob3VsZCBhbHNvIGJlIHVwZGF0ZSBkdGhhdCBERFIgbW9kZSBp
cyBub3Qgc3VwcG9ydGVkIGFzIG9mIG5vdy4NCj4gPj4NCj4gPj4gSnVzdCBteSB0aG91Z2h0cy4N
Cj4gPj4NCj4gPj4gUmVnYXJkcw0KPiA+PiBQZW5nLg0KPiA+DQo+IA0KDQo=

