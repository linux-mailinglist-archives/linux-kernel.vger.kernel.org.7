Return-Path: <linux-kernel+bounces-813135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D921B5410C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB4AA59B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7723C8CD;
	Fri, 12 Sep 2025 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BSzeeHeg"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC023817C;
	Fri, 12 Sep 2025 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648180; cv=fail; b=NrAlwRKakePBpDJuk3QL8gs0IMzHQGk0zcsAoRnpKfUhzahb4xlOlD9eHC3tqD/FqgakPl5FQlyCxFJJceEqCVJ6l1pts813aAS9kskkLnAs4oxh6xOrU2n698AdFMBLZVODGOgoZK8thvTW6M7kRBBWYPgdXll7eWsXIPgwuMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648180; c=relaxed/simple;
	bh=VOjq/ghgK837mNXju++QVTEoLeNdTaomT3k2QLbPfhc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p4bJpLogyGvg+6P/vtiDZqAWIlZv4eEb5uCkiwkEU1eN20j1eK8Po15U+IZJq9EUFKkA2mbPBxBDbkIaogEsOJPh73K6cXvdsFnDGDSlX/kZq5dOOPUk60WyL9es1b5sCTg9CkRfKDxVaFC4RfbnAUUFP7uxvv4ERfTDR9iPT9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BSzeeHeg; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkxPaZMWQBPdC6q8gnC2272EwbLHN97Joblt/JPf9vmqIuV/Ro2Vj8rG94rzlRslUxn6HGUaVC6Qy40eLZNchYRAeXIOw7jrE7kgqZ9I+sHCuyK1F7nFj5oLfgw5kIuUxlQHW9cCjulsV0njcJl2dW2zri2Pi+CgCjuDxwig7c1pj+7fBUCaQL9JteZxGU9zITIN9HYcn6yuNQidM97hSTsAX7tUyGYINo0snQIODEk3xF182IuASNezIUyOVtFOruWsJ1ffkAAAPSOqt2k4jT0Qzk5TRHtoAdymqHj9EHxYwdo5WbHgJt6v0sN8TxEBs+jIjNXnOZv0sReESSVBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5b/ZvUj1FD2j2LOdy2VaBnpN1Ag5cyt4M99bUNqglU=;
 b=jtl9YpdktKkq0VehQqj23uP7At6ELroBXtAvTOmzk2ezVFPIz26nl+oUerQRuSNgLyyFKGVtdxF9Fsrot2kaenCBkAIaZRQ7FRfv9tgjd434EZmxPWj1DKAAkB9SZF1HC0peNFubk1Y3OHb0anhpADWEw0QYhwIbc+3mv47x5vU21L79xwUQfUrmfwpkIRDhlFG/nbvxHEGAyicbFRo7l+OZWWIV8DzHDwEQU+t7L9nFs/OruX+PEQEDsiR7PhtTpb08IHl28SeWLcSn6wBcSQn/qL5WVIj3Q8aRN3m+zBE0iODZ24dfDWRpJNuN+IyF4B1+sZvyTEsQBHTttZCEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5b/ZvUj1FD2j2LOdy2VaBnpN1Ag5cyt4M99bUNqglU=;
 b=BSzeeHegZwBmLo0olflrqhadBPySB+oNvw427zfPP2hCIbdz4o4sFUwIDONriy6DwDgplCniSXa+hfKkxpY3wF1jUkfRX8PUP4ZLIAbZE2KOSsYIG0WKuRjIncVlL+peWZMhC1vLLk/M9jjTaP2lNhYr9vpsoasecqlVbX4vL67qaSWtO7bCohOzwFv6nDYFypb/EVxUAMfu8ECvAEX89JmxqEC6QOr6c5dAnRT1KLOBc7zEoqbUnZcU7bpFvXwJ6m5rscFk74gE1uqTbEFQRiXaM3pGcLGaQS+PeCzjWmu7aOJV6tOFcoMZ84MofWgmDjsMKtSm+IJCN3RIuenbaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 03:36:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 03:36:14 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 12 Sep 2025 11:35:51 +0800
Subject: [PATCH v3 2/5] clk: Introduce clk_hw_set_spread_spectrum
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-clk-ssc-version1-v3-2-fd1e07476ba1@nxp.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
In-Reply-To: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648158; l=3482;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VOjq/ghgK837mNXju++QVTEoLeNdTaomT3k2QLbPfhc=;
 b=pNKj/OtcAcEGbwAqeuhSAFE2ZKWYRAZdN5b1RDd7bJFMaM1EwSAYhwy536vSMfVc7uuK1boG2
 2qdR7kepIucCXAyij0JbcT/D/aybiNgVL1xAnUho/nEvkzntFLJFK53
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: a35bb49d-48b3-4eab-91d4-08ddf1ad8690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnpFRUR2TWUrbjhtMlZ5bGVtT0NTU0x2TWlGalp0MkhSbisyYTUvYUY1U1BU?=
 =?utf-8?B?dWtjSDhSRWtQOEtyS3NQUS9UM3BsWjNjMFdNWnkwVzJRNzhWRElmVXl2UTVD?=
 =?utf-8?B?L2pDeGoxUklHNExoUDRRQ3dKaUdON014VEJFd202Uks0VDBSaVlSRytWaTBP?=
 =?utf-8?B?VUl4RzNmWGRWWDRlM3QxbWxGeXRQcWl2TDBrVS92V1VsN1ZTMWwwbWNHS1h1?=
 =?utf-8?B?U3Rsd0VuaHFTa2MvelZ1dkZLMTVNRFhwMFJnYktUYkEwUUdhaEhhSHhEYkha?=
 =?utf-8?B?Nld0K0tRTlRheElDUGF5MG9sTEswNGk5Z0tWUDVWWkZFa0kwNVJTRi9hcWRI?=
 =?utf-8?B?WFQ1Ym5HSFlvaGVKdDIyd2c5L0hhK3YwTVpuZ2NMd0pMTk1TRXV2V2ZraUdH?=
 =?utf-8?B?cUZtaEs0QWJpS0JRNURRcml5Q0N3OGdpcnl0TzBTbTNIaFpKbHBiKzJFeXFj?=
 =?utf-8?B?Q2ZFclQvN0hiZjVVVzJsWWdXR3p1ZkpUc2JsOU4vbFhDQlNmdkp5ckpLenlM?=
 =?utf-8?B?SjJVVFZBYVliMGpTeHh2R2Ryd0YrRHJKQkpHL1Nlb1ZISk4rU28vQUs0eGR6?=
 =?utf-8?B?aStBQnd6TitkRmlQU3AxUXhMSks1SFg4Zml6R1BtRnRJUzdEL0xETFFXbVdX?=
 =?utf-8?B?cEJJdkJpSU5FQXhacWhWM1owZVNCdHc0M0xFRCtEZXR5WDMwY2wyTGM2T0to?=
 =?utf-8?B?enN5ZTZ4OXNyYThlUmdhSEIrVnVsZThNbENoVTF0TEgrdnorWmJHejU1Mk9L?=
 =?utf-8?B?T2dIY1l1dDBHU29OQnFSUjRrMWpFTDBDWG9BZ0xyVVVYRURZZnovMjI2eXNM?=
 =?utf-8?B?L2lnRmFPR2xkSUo1TnZsd2J5OFh2aUdJV3VNQ0w5bSt2Qm56MU1FbWplWGs4?=
 =?utf-8?B?dGthbXVHVnN0cCtqYjVJNXQ1WWFrZUtERFgrRGQxeWFsMlpBTGlBY3hqdEtE?=
 =?utf-8?B?YTJTMGV5S29vNkFST1dJbXhpZWlXdmswNVVmL3E2ZTFlTEJUZUkzOTNFNWQw?=
 =?utf-8?B?d3EvU1plRzBkczI5a0oybCtHR09Oa0RRTzhZczZMc1dQRW9WVDBUY3dRWmNm?=
 =?utf-8?B?MEU5MHIvdmx5MWVlSXJMY0MrTThSUmM4Q1R5aUpTdURaODJ2aWhCMm9McmdY?=
 =?utf-8?B?cjBiKzhVSzlPZVBDVU1xVU5pVmtmdWRiVjhaaWZFTFBkYVNJNDdEMWZoa21s?=
 =?utf-8?B?NGpGQlVtUU8rdGtvNUxZeDFhSHp6VEYwam03UTN2OW9mK2F6UDNIam1sV0Ra?=
 =?utf-8?B?eTJWOWl2NEpoVFd1SVlFWXB1Yk40T0F4cU9zcDFTZVBhekpJQ1g1L1A1YzJD?=
 =?utf-8?B?alV5djVWV0M4R0M5VktWS2NqbU9YUmdXcUtqSVVTUDE2SjhQUjFFTmRtVUFH?=
 =?utf-8?B?bThzbkY2RWhJdGwwVFZ2ci8yZmxZK3phcFQxUHhQYjJUVGJvSTBBQnRkQnpa?=
 =?utf-8?B?TWpVODBNTy9mT1Yvd0krT0lBT3BTUU9KSk1MN2VNbStOcGF3aXRYTVFKdG9m?=
 =?utf-8?B?TUFGNG1VZHd6eWFkNmNTYlRDU0Q5K2dJblgrYzFmMm1tMkV6WVBrdFcrZU5w?=
 =?utf-8?B?R1dZdit0ZmlONWNJZm9URlA4ZUkvRzNoUm11RnBIMWVmT3NrYnNHNjRJbFhL?=
 =?utf-8?B?MHp4TFNPRTVDYVA3M0c2a3Z4dS8zUXdFa1lneXZYSHlZbnB4WmJLSEtVcU12?=
 =?utf-8?B?WW9UaHFLbFUxM3Z1OE5DM2F1ZjBHc0ZmRCtJWjV6R3NHd3FKQkM0ZUd6UmU1?=
 =?utf-8?B?NmxtR25LT2xNK0xUK1lLZ1lacnVaaHhvaWtCQmgrTjY4UGVBcmU3TytvSnFJ?=
 =?utf-8?B?c1g0N0RLK0lOR0tLcjRTdE9tdFdWOHVZMDhxYTd4Q1ZTeHVjWmlGNGkrUEtr?=
 =?utf-8?B?d0RRR0JkTVFjOHNYMlJueGh0R2JCckhTNEFtai9ra0txaFZpL0lCMzNpVE5L?=
 =?utf-8?B?d21RaHNqVGNWYmFDb3R4dTIzRUNFMFZsL1ZKbk9iQm95RUhubCswMDcvUWZX?=
 =?utf-8?B?VTQ5WUNuR0ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjl4bURVNCtyemJuVFlUZUgyN1pRemp5UWJWNjR5ZmI2VDF1eWwxM21mMTNH?=
 =?utf-8?B?SXQ4Zkd5bmJDOXQ2QVpXOUVhNXdZbHlCU2ZCeDBuc2tDOHpSWG1LZFZRaStU?=
 =?utf-8?B?VVQ0d2gzd1J0Nkw5K2hyREN6djZ5eFdIWE4xYUhnU1J4ZUE3QS81ZEtPcDVm?=
 =?utf-8?B?N3N2VXQ5NEs4OVk3MDl5SngzZkE4L1BoVDVtRVlCMWNRR3VHcHJlaFA3SjRm?=
 =?utf-8?B?U0NKUVZBRHVjNzZNRnpBMXNTWnhZd0NrVmx5dDJ6RjM0T3IxZUtoMkFTZkhx?=
 =?utf-8?B?ZjBjQUYzS05yTGFjTUZhajJxdTNYaTdKVzIyZmtLQzhkcVhUaHJ0empCU2Ft?=
 =?utf-8?B?ODI4Y09VRWJWYjFjS25VNkRVNGFTL09pVWVzWGYrckVjT1JIenlFYjBmT1h3?=
 =?utf-8?B?bElDY3ZHWEttWXYvd0gyMFhBV01GczBBZW9jZU5tMHRmbDZuN0FrUEFWUHNq?=
 =?utf-8?B?Y21ZT0FudnQ2c2pkTEhRZEZib0RlU21lRGRtdVRDSmQ3Y0g5UVY3am9EckJH?=
 =?utf-8?B?UmtySTRmTUtpaWh6R2xZdXRmMnpIYWZ2eHhJallCMk94cGVESjBoVTlzak1n?=
 =?utf-8?B?TXBtUnJDdVk0VDRxUk0yNG1zL1ZCMS9jTDdhdjJLQkJ4Wk9uRkdud0krNnF3?=
 =?utf-8?B?cnRDTCsrdUVlMHQzckhyMmtjRjBVWFBqRzA4WW00ZFBnbzcvVVBKTFplY1lI?=
 =?utf-8?B?LzhjM1U4a1RXVVo2K1FNTE04bHFCTGpoblNkNzlub0tOQUxDb0FFMkdpYmJ4?=
 =?utf-8?B?RFFOenhodS90MGF5L2JtWVNGREpwL1J1c3BaaytRZWV2dU91THg0V2ZrTlhD?=
 =?utf-8?B?cEhIWDQrb1JhaHMybWFDa2xKaEVTYnFBWGozbVBuYVgwU2J6ZGYwOFlmZEFr?=
 =?utf-8?B?OVgwdlVtZkFCSDRpeDFuRDJXOHg0OS9ybGpqLzhVNWtJZURiTWlhRlczTjlI?=
 =?utf-8?B?N1dZQjhqbzhFUWt6SmJNekZyY3VOWHdOQStjZDV5cHlaRGp5aW50MjRudnpF?=
 =?utf-8?B?YWVpWU5XTXprazduVmRidy9pYVJIaHZwTHhXNEdwdVlXVDgwcytodzVJV1RS?=
 =?utf-8?B?RzBmSjJwdnRyNHdiTStralZzTWhIOStheWFiTXVtSkZyMmhDMTZWYW11QXlN?=
 =?utf-8?B?SjFtN3N0YlRpUkp6c0liTlMxYXhkWjhHUTM0MlhHS2VOazJjaGRTSWpjZWhs?=
 =?utf-8?B?dlA3S3MzUUh5YnBIc01OUzVsM1Rkc1ZsbUlzSjdlRzRHclRJZXR2NmV1QnlR?=
 =?utf-8?B?ZmtyOHNRK0RXNnJSMnUwbEEzSjR6Q1ZFeXUrMUpXK0pNZ1V4c29TZnVQcisv?=
 =?utf-8?B?VnJ5aTNLbS94UmpDYmNQTlVLNXpSOUZWYWZLbTdyTzYyajduZ0RGYXVXZko4?=
 =?utf-8?B?dllBS3c3RFd6SjdjUFBwTWV0YUFaZ2RyNEQ1dzcyZXlkcXVZT3ZBK2R4T1RG?=
 =?utf-8?B?ZjA4S0ZsSU5kMWlLaUhCOEZUYU52ak4xVVg1U2UvL1BGQmR3SFdYWHdISTRo?=
 =?utf-8?B?RS9iWTBzSkUvOVR0ZEl1d0JkaHI0Rm1kd3MwYWxHQmtvY0pqYlNNek1Qb1Zp?=
 =?utf-8?B?cEtKZlg4VHo1SitFc250QXByTGh5NmVDZ3Jrakh3ZFl6RmcrbUo1WS9RMDFs?=
 =?utf-8?B?d0l5OWZQTmN6Zitsb2lCcHFvdXllUXRya2liYjM3VW5kbFlJV3ZDa0FEM3Ar?=
 =?utf-8?B?S2NtajB6STBkeDJ6QWRPeStWb3k0eTZlV3FmYm51M1U1N2lkR2l6VzdpZml4?=
 =?utf-8?B?R1dSaWFCb25kUFJqTzlNN0VmdmJ2TFo0eTJwR3d4V2RQUE1yYW45Sll2V1lG?=
 =?utf-8?B?d01mQnREdHRHQ3c5SnpUOXJIYTdyQ2FPb081OHRYbmNtT2ZFSTdFekhJVHBR?=
 =?utf-8?B?aEZqRGlkZlRmOWM2ZXRoVFg3ejNmS1FjektFU1NHaE9pdjY2QXBZRTdIS05B?=
 =?utf-8?B?WEZsa0JEQ2tvLzV3RXdEN0VNejIyYkc2ejFPS3R3cmVCdHFIa3BQMHB0YTR4?=
 =?utf-8?B?WGsxUVNpbHIwRGpLaWpxMjRzUUVGOHQvbE5KQ3hmSUVPYzhpaUl4czEya0ZT?=
 =?utf-8?B?bVVBaEdOenhwOTFSYjdFbGs1YlQwbDZiU2tPTXBGTmdwbllPZEdLNkxtSm1Y?=
 =?utf-8?Q?lRledov6JtNFzT147VzbDhhBs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35bb49d-48b3-4eab-91d4-08ddf1ad8690
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:36:14.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Esa04xFfFxDNxwT3aahbJ5kyN0iybWl/CUfV2NLCAN1TddS5fu7s9MeN5pwk9G9l3t08pjFMqhaXKxUcpUtRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788

Add clk_hw_set_spread_spectrum to configure a clock to enable spread
spectrum feature. set_spread_spectrum ops is added for clk drivers to
have their own hardware specific implementation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c            | 26 ++++++++++++++++++++++++++
 include/linux/clk-provider.h | 22 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..06db8918a1b35e3280e565272bc4603a88295a92 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2802,6 +2802,32 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf)
+{
+	struct clk_core *core;
+	int ret;
+
+	if (!hw)
+		return 0;
+
+	core = hw->core;
+
+	clk_prepare_lock();
+
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		goto fail;
+
+	if (core->ops->set_spread_spectrum)
+		ret = core->ops->set_spread_spectrum(hw, conf);
+
+	clk_pm_runtime_put(core);
+
+fail:
+	clk_prepare_unlock();
+	return ret;
+}
+
 /**
  * clk_get_parent - return the parent of a clk
  * @clk: the clk whose parent gets returned
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..4f48a4df95a1c54638a0e91e0a449fcc8aa40b80 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -84,6 +84,19 @@ struct clk_duty {
 	unsigned int den;
 };
 
+/**
+ * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
+ *
+ * @modfreq_hz:		Modulation frequency
+ * @spread_bp:		Modulation percent in permyriad
+ * @method:		Modulation method
+ */
+struct clk_spread_spectrum {
+	u32 modfreq_hz;
+	u32 spread_bp;
+	u32 method;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -178,6 +191,12 @@ struct clk_duty {
  *		separately via calls to .set_parent and .set_rate.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_spread_spectrum: Optional callback used to configure the spread
+ *		spectrum modulation frequency, percentage, and method
+ *		to reduce EMI by spreading the clock frequency over a
+ *		wider range.
+ *		Returns 0 on success, -EERROR otherwise.
+ *
  * @recalc_accuracy: Recalculate the accuracy of this clock. The clock accuracy
  *		is expressed in ppb (parts per billion). The parent accuracy is
  *		an input parameter.
@@ -255,6 +274,8 @@ struct clk_ops {
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
 				    unsigned long rate,
 				    unsigned long parent_rate, u8 index);
+	int		(*set_spread_spectrum)(struct clk_hw *hw,
+					       struct clk_spread_spectrum *clk_ss);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
@@ -1430,6 +1451,7 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {

-- 
2.37.1


