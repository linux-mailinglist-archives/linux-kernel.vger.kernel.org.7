Return-Path: <linux-kernel+bounces-896221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8653C4FE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE043B9452
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBB2ED85F;
	Tue, 11 Nov 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SwP5+Ca3"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AE352F91;
	Tue, 11 Nov 2025 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897376; cv=fail; b=ejneD72RfUa7NxVRQryMioUjgN0LFjtTC8iyfWCWrCoxj174WtZsd39S75wp8U40sQMqz5TXVz6Yj1d5bp5hBih8aTe7DutyUHEXix590DfVCfYIbk8VW0+Ik81/NQt/qj/Jq1tdBlDUIQEzb2MxjjDvpoGudtNS2fjF2TB6Hf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897376; c=relaxed/simple;
	bh=821JGvweGkZLeCSbUFTn/43wIZ6Bq2oJDylytEPu72k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KHOBwNUIxqRHzQHakDfWmiA8wO4+9fXGFPskfMA7gLPHplQzLjyzG/MgX7Hr7Nh4cx+c93VqAEHgWFmRo9pQmgSswHmJnYQsy+DROep8pMCPs0bxreoW/lhZQFqhA058ZKgDL5ShZE6rkBnoPVGChKj4y/c5IYmM/ZknmgfM2t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SwP5+Ca3; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0tG3uBAyYSCs/AHwo9+hi2D4ST3DbKJqW84clWFvFIE1ou5VaNzGJrhk/G6qJoMWvZutCgbsiOYgVNPR8VY1c3HlltxY9R1GxjAw/s0VYzWjdLPS+MUIfQTiEkkay/MIplwKZWiKHVBH0Nl+iqYOhS6edtwNcxtJKHx9uWThylHInoapnL9AW5Mptf7/bzpJGHj+zZHZ7woS6Z6LjVCpcX4rxqhQ3LnK+plQ91lTR3QOF8HXqG66BVXKvsOLWeKwS9PlWZHwgvTqgcgaVh47zL5OiEIuorgjqpPlTqZfyX4i29NW2BWEocbIlHn6UH0K1NxZLZLNETU2S78lxGqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul57GZxBQ5hVeglnhBoJ4mLRK8WpOeZqpkhL4ytFbu8=;
 b=J58jJwe6xoKWbVhiTR0Dk72LiJ57Wt8sAMNVvyfl6TNSDI5B60BTiUN1CLsW+xM6kAaaSqI812eRfXRihFxAuUoYJOKau735adkQj6oSsvceohFZC2t+P+rO4SqS1shdlFhgUmwDlAm33Uht3DwB8wqS5bMR9ViK3jSFikON/2RcHk0KRoN047ffR/kaQAnLhoNKrV2gmEuEeW8lEhCg5G5EX5qWiHHiNonhAXvfGMNBtzaWMCa0XDdrlJrICRLwWmk6ThU8xGR0iGw+Sx+b+oCtRzhcC3DtRzRktUsyOg6DCCjFl7MJwaqq2hML8Yy1JwE1RfDrLQerwrfWn2dVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul57GZxBQ5hVeglnhBoJ4mLRK8WpOeZqpkhL4ytFbu8=;
 b=SwP5+Ca3okM/KjC2ghGLxzXWmQt6vh46maE7tb4T4PDe7UZ32rTKY68p1Vqp/KutLFcFIqSM/hevirODvbGO7gJ2p3l3l1NL/ErfUaW9JH8B6x9j0wKYHOib9wTnJxWsv9jbsJCK1Cd20gWGmxpW8QZ+zEjoaBqBEAoFowJzOPb02o2G3SdJa8JM/CHayd24xCvkIcJ9FMRknmtMsa0apmOI0PEhSl1UOUZS6em9WIN3DKOz/tWqvi7Bqh92yHPXvO7q2CdumSmGSs5h00vmMJOfzGr2Oa9Y7YO9J/H+3f0Wei9YI9r2q3z9KHmA0ZBNuzZdfcH9V2pKVWXFLYY8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:42:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Nov 2025 16:42:15 -0500
Subject: [PATCH v2 3/5] media: staging: media: imx6-mipi-csi2: use
 devm_clk_bulk_get_all() to fetch clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-stage-csi2-cleanup-v2-3-371bb951776f@nxp.com>
References: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
In-Reply-To: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897350; l=4713;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=821JGvweGkZLeCSbUFTn/43wIZ6Bq2oJDylytEPu72k=;
 b=wuBcoNIabt94lhJoPU4ZBzmwyelY8qpY4sgRDWF3+8wDZAlDi2iJxWYLo//yDQrjuRA5hsi7u
 iFYKjJ0hHk1C7XKKQo99h6xrb/ItWSbmozRphHI8L0kWBdpafDmLlvU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: dd52d4f2-1648-485f-3257-08de216b405f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zys4RDZqM0VQN0tQUWV4Y29iRGxUdStVWkY2aWNFYU9oNHRmY2plSm1BZnU0?=
 =?utf-8?B?KzNuRk5pZTRvZkJFVFFlS1ZOREJORXV2MEY4eUZTQTVhbmVPeGsxSkFZaDNK?=
 =?utf-8?B?TTZ1dTNTS3J6QUFKRG1hT0EzWkRDVE52TWE4RXZiOFY4dU9SMnRZN3R3ck11?=
 =?utf-8?B?a25FV2Z2dmZ2NTk5SGJ2V1ZxK2dteC9SclhvWG9mTmFJWFNJUnA1YjY2U2Vp?=
 =?utf-8?B?N0d0dXJReG51RHgwaVNEOXBVS2lkT3dybmdvYnAydUJwbHIzTGJieE5maGRa?=
 =?utf-8?B?NDljK1M3SVluZGhmdk5ud0N6SVg2N01rY0ZFaXk1T3g5RE42ODQ0VkhUZnB3?=
 =?utf-8?B?R2M1MWNOeVhORG9pMjZyenhicEV6UzZGSWkwMXdLQU5kejZxWWNPRUdxNkJ6?=
 =?utf-8?B?dXFOZy9JWlRDcEgzM0tUSkNyaCtTUmFMQkp1V242QlBCZ1pueTNraUdMUXJY?=
 =?utf-8?B?QUJPN1Y5VHY5eXZudHVPTlNMampUVi9mbGViR1Q4LzF0MFFnenpMWGtzanBl?=
 =?utf-8?B?cTI0ME1lbFZ5WVJIQjZTMXhEaGw0WkUwOThuT2EydkZLY0pWek0zRDRhZEwz?=
 =?utf-8?B?eVdNVHVtK3B4TDVGSHA5blVrSkRSUjlydEFKL0JCOHJ5eTZoUnMwRS9mMXJl?=
 =?utf-8?B?Yy9CdXJYVXo2VWd2cDk2Qy9TWXFRcjQ1VUN1dUVPdGc5NXNWRGNJOW9VVVRD?=
 =?utf-8?B?RzluSXdxd3NySk00bUF6TmowaVNFRmg0Ykk2NGEvODQ1WUhheUZrWXh0UkQz?=
 =?utf-8?B?RlA2NHRmVDlZN0llQm1DdGlwRFdkWDc3NTlTd3JzaXJQbGlDU0QwbC9GaWpU?=
 =?utf-8?B?YTBtOHNveC83eGhzc2MvbHFIY2J2bkdWd3NLUmhiRW1jcHVRYURwS0RkNVVt?=
 =?utf-8?B?OW1sYU5EREJLTzFHdUVta2JYbmFNQWNjUWx3QTBsanlQY0hocWxkTFREdkdO?=
 =?utf-8?B?NzVLLzNEMTBQaWxJM0IwTGxPSFZuVGFNZm53cmJpUkxiT3VSTHRxQktRb1lS?=
 =?utf-8?B?Q0l2VlI3aWFMQ0NUbEJFcmNYWmVFSHVVaCt3eVVHS2JrZ1RmT3lsZXFuM3dE?=
 =?utf-8?B?RFF2L3NoN05UVG5mU0x6ejRubXBJaUs4bU5ES2FFTW5BdVNIeGZUY0R2N0lx?=
 =?utf-8?B?cHAwaG5TSlpPVUMxVG93dERtaEl5RU5QbHhTZ1I4eGRobU5mTzF4Z081dzdH?=
 =?utf-8?B?Z2FvU2xYQXFyQXR4UzdMMWlDMjFHd0o1Y05OTkF2SkxROThWTjkxcEczVVlQ?=
 =?utf-8?B?QkFONUFZWVRTTWVxNFQ0T2RtcGNlK21oQVNIUkR5cFhpMnA4Ri92VXhreWl4?=
 =?utf-8?B?djlsRWdzRnFxdkV4eitEVzE3QjJubzJwRDZQdGxDejVPR09RS3BSajBTbGR5?=
 =?utf-8?B?Y2huNHA4VkU5Wk90VXhETTZFVHF3bjB1UDJza2ZzdEdJdWMwRlUwMkhkd2ZN?=
 =?utf-8?B?OVdSRjhPd2dtQTdKWUZYNjFlenVES2R5cXBEMFJ3OTREbytOL01UbnhOTjkw?=
 =?utf-8?B?UkMxM2lwbUJ1RkgxbndWUUJ3NTBXeXlGZlMxY3V6TDExUDlLZzFiRlNJckFi?=
 =?utf-8?B?bnRQbGZ0YnBJLzcvRURwK2RRNTRFdGp6OWJ4b2ptL01DcEFXUEpIYVNaNzRZ?=
 =?utf-8?B?c1UvZ1RjSVBvSldZS1BGcHFjUlVvekRMdFBGZFQ4dUhGTXM0ZU1vc1pGR0ls?=
 =?utf-8?B?YUg2ZklrVUlPMW5iaGFRaDJHTitUbG12Q01kM29DeCs2WEtRK0Y4L2ZaYks1?=
 =?utf-8?B?MGQ5NUtRbmw3OGd1S29qU2RpMmlSZ3ArUkdMT09EMS8xRTB2ay9SZitBb25X?=
 =?utf-8?B?MlpLeSs3TDRlNSsxVVdZWUtNUy9DNDRQcDlHN3BFcEJoUzJzNEllVThCOHlZ?=
 =?utf-8?B?cWY0cGRsN2ZEZnY1VnVkZ1MreFlJd0FLSmUxUnNtNXhuZHVrdVZYaTFaVnNm?=
 =?utf-8?B?RUdMQmE2WlpxVnJxY1IyakFKbW5PNk44UnAwR1Bha00xcnRKU0d6NHRjdnNs?=
 =?utf-8?B?OU5Cc1dLZWVHZ0RORGNySmZTVjlUQ2Y4bEJrQkRub0NCQWYyd25PMnVkR0Zn?=
 =?utf-8?Q?VZjFtO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHo2NStBYXJoWnZkZTgrY25wUnNvYy9YR1RZMHJFODJ1NU52WXJQVXdOeHhF?=
 =?utf-8?B?VWdlVmFmYTFFZVZtQTV5OEdoQzFHcVBqWW5wcFM4Y3JGakFvaWw4dzFXdlJP?=
 =?utf-8?B?SVJVdk14TE9JRmkvNTB0bmZJanhaVzdwcnJJb0IrbXY1VURPdEUrQitsTTJs?=
 =?utf-8?B?dytkRG1ERlg3UWpiM3JLTUhXNGFwTExRUVR6em1JZkxxTTIrQlNtS0Z0azRx?=
 =?utf-8?B?M0VwZ21wNVhlTEZXY3BBcHNJSS9nT2JMMkc3UzB0TndQODZNSjZVTWIrOVRj?=
 =?utf-8?B?eWFTRDdXZEtBTHg0UmNURjRzbUtqYkJSdFNRZk1UUC84YzMyd2h3VmFBV2F4?=
 =?utf-8?B?MGtKZUhndTQ2em5RNGZkdkJyNzc5emhZQUpJZEx6dXJzd1VQcm5mbS92bUxv?=
 =?utf-8?B?QVc5RjFlWWdLaDZmMFMyeUtzcE5LTlU1bHBrOTlJb2ZINWV3cjBtMktLUHJI?=
 =?utf-8?B?eGZaQnYxUGJnWUFzWllaM3JkMmgvUEw2MXh2Z0JKY0dyeFBtSzVZcmkvN08y?=
 =?utf-8?B?RjZpdk5aNVFkbTJpU3M5eWZMMUdEWjhod1hhSnp6OG1uak9sYWRpT0VoVnRQ?=
 =?utf-8?B?bWZTb0tzZmY0S3Z1bmRycHR5b3NWb2c3bFR0dWMyZUhad0dpcFlVUnpGQTJP?=
 =?utf-8?B?RkFqYTBkd0J4YnFFQWh2NjNpTkVTTmpvdEIxZStKZHFCTSt2bDYweXYyOWVD?=
 =?utf-8?B?MzZ6dnJiVW5vcmdVL0V0RjZkVFpuc0VHZGs4WHIwdEpPQTBJZDNLQ1NSbjVw?=
 =?utf-8?B?TElOUU50L1liU1BiLzgrVmtmT1J2eXZpYk5LOEhzTnYvdGtJRlNpcWxNcTlJ?=
 =?utf-8?B?bXhoM2JFa2cvYUZaNGRKRlYzcm1ZY2lpT2JSbmhPdkxIcm9lNkpyNFpRQUVH?=
 =?utf-8?B?MVE2SUhYUU1qNXJ4ZlNRVjB6QVdydkljTjYwb2ErSVI2YjF5MGVFQTdSZmFU?=
 =?utf-8?B?dHAxRUVaS3VWODhLNkxPdHpUMFNsS2w0clowMHJvaHJGTkUrc0dRdnFUR1Vs?=
 =?utf-8?B?MFViSzhQUW90ZDE4ZFgvQ0xOK3V5NTFzZzJUb3ZwUWtwSE1mSThaRWZ1QzYw?=
 =?utf-8?B?bjU5SThmS1R2QnJEQkRrTkR2WXNPcG5kVUxBZUozU09tSmlVWXArZlNybEhB?=
 =?utf-8?B?elp2TDJDdGY4RjhLS2xaTFdkK2dORVk2aG9hMHlBL2NESUxINzJtdTRZeVpu?=
 =?utf-8?B?QkdXOVJNaWMwWEhvWmdxTUlUeFBJVlRvS0R1QVF2T1E5TVhGTnpoYjFXRkE4?=
 =?utf-8?B?cGwxSmcrOVdsZGUzY1hHRUI4K1FUY2dqbDB1bEx5ZGRxRnA4U2F0WXRFNVRN?=
 =?utf-8?B?N2NLMHBRM3FvcGxRVDVnY3I1cXoyUDR2RGkwWmJCZ0hUcDJMdHlQVVB6RHFF?=
 =?utf-8?B?Z3VhUWVESGZWeW5QS2FCRXVualNzNURqSVlSYmlEQ2kyTVY0VEV3M2pKSEdM?=
 =?utf-8?B?Nk5hV3ZxZVd6U0VpNmpWb2p0V3RxZEN2cGxXSmxURjZlU0hHZVN5eThZVWo3?=
 =?utf-8?B?NW1NbWNleW56MStmbVBFOXBRUUZhb0ZoRDNXWFN1dDUrekV1KzJYNGxPMTJz?=
 =?utf-8?B?VlBjdmZUdzY1NUlhb1I3MHhmNEV1WGE3Y1JPYkp1VmtoMkJWcE9WSHd0dm1y?=
 =?utf-8?B?Q1dja1ZRRXlOOFBMTVRkMVZwQzNpbVRJVXo4VGVyZWVEVHV0S1V0L0h0ck1H?=
 =?utf-8?B?Y2VkYWZKSkI5Z05NbEpCVFNKRndsRk00VWpaYUFjMityb05pSVpFMERqam4w?=
 =?utf-8?B?VTRvSGpRbDNDZjNUaDZVWHNOZS82L3VBZmN5OWVtRDRhSUxaOVFKLzNUbmto?=
 =?utf-8?B?MDNXUExOOEVWdzRCc2NLRUEyMUYzQlh6UnZkNHdCdk54U2JDS0l4NzJxc2FK?=
 =?utf-8?B?WVk3QlJXVys2VjJOQWhhdlZQM3ptcFBFNjJvWU83cndScjd3b1RWNXduUTZM?=
 =?utf-8?B?MlhiN05TdFlaSzMwWlFodGFlRCthVkNLcUpHZlpteFIzNE5qYis0MlpIejZo?=
 =?utf-8?B?dzRaMnhoVDBscmtqdkFtZ2ZNaUpwb3ZCaTg5dVN6dnNFV0RleUNLTzBxaHdG?=
 =?utf-8?B?cGlmMXhxWGJPM2tndmhZSmM2M1VPWXhUeUdxb21wb3BSV204a05ia1dsSENF?=
 =?utf-8?Q?U30oRjM3j+tlkuUe3atR4y3i3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd52d4f2-1648-485f-3257-08de216b405f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:45.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8ZCw2u6HYY5fRuCaCgaNM6MdaZnFxND9rVN2Qj110/Jok0hlvEqzqHLGN/Kr87rfa+B9uRQLVgtJqYvdjWRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

Use devm_clk_bulk_get_all_enabled() helper to simplify clock handling.

Defer all clock prepare and enable to csi2_start(), which previous only
enable pix clock here.

Add clk_enable at log_status().

Do that safely because there are not register access before csi2_start().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v2
- add clk_bulk_prepare_enable() get at csi2_log_status()
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 57 +++++++++---------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 4f740170d2bbf586ac0a58b5d25f8f8432e9e6a3..e1b4b7fb53131ce9515b9441d8fc420e85d3e993 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -39,9 +39,8 @@ struct csi2_dev {
 	struct v4l2_subdev sd;
 	struct v4l2_async_notifier notifier;
 	struct media_pad pad[CSI2_NUM_PADS];
-	struct clk *dphy_clk;
-	struct clk *pllref_clk;
-	struct clk *pix_clk; /* what is this? */
+	struct clk_bulk_data *clks;
+	int num_clks;
 	void __iomem *base;
 
 	struct v4l2_subdev *remote;
@@ -343,7 +342,7 @@ static int csi2_start(struct csi2_dev *csi2)
 	unsigned int lanes;
 	int ret;
 
-	ret = clk_prepare_enable(csi2->pix_clk);
+	ret = clk_bulk_prepare_enable(csi2->num_clks, csi2->clks);
 	if (ret)
 		return ret;
 
@@ -390,7 +389,7 @@ static int csi2_start(struct csi2_dev *csi2)
 err_assert_reset:
 	csi2_enable(csi2, false);
 err_disable_clk:
-	clk_disable_unprepare(csi2->pix_clk);
+	clk_bulk_disable_unprepare(csi2->num_clks, csi2->clks);
 	return ret;
 }
 
@@ -401,7 +400,7 @@ static void csi2_stop(struct csi2_dev *csi2)
 	v4l2_subdev_call(csi2->src_sd, video, post_streamoff);
 
 	csi2_enable(csi2, false);
-	clk_disable_unprepare(csi2->pix_clk);
+	clk_bulk_disable_unprepare(csi2->num_clks, csi2->clks);
 }
 
 /*
@@ -570,6 +569,11 @@ static int csi2_registered(struct v4l2_subdev *sd)
 static int csi2_log_status(struct v4l2_subdev *sd)
 {
 	struct csi2_dev *csi2 = sd_to_dev(sd);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(csi2->num_clks, csi2->clks);
+	if (ret)
+		return ret;
 
 	v4l2_info(sd, "-----MIPI CSI status-----\n");
 	v4l2_info(sd, "VERSION: 0x%x\n",
@@ -601,6 +605,8 @@ static int csi2_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "PHY_TST_CTRL1: 0x%x\n",
 		  readl(csi2->base + CSI2_PHY_TST_CTRL1));
 
+	clk_bulk_disable_unprepare(csi2->num_clks, csi2->clks);
+
 	return 0;
 }
 
@@ -749,24 +755,6 @@ static int csi2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	csi2->pllref_clk = devm_clk_get(&pdev->dev, "ref");
-	if (IS_ERR(csi2->pllref_clk)) {
-		v4l2_err(&csi2->sd, "failed to get pll reference clock\n");
-		return PTR_ERR(csi2->pllref_clk);
-	}
-
-	csi2->dphy_clk = devm_clk_get(&pdev->dev, "dphy");
-	if (IS_ERR(csi2->dphy_clk)) {
-		v4l2_err(&csi2->sd, "failed to get dphy clock\n");
-		return PTR_ERR(csi2->dphy_clk);
-	}
-
-	csi2->pix_clk = devm_clk_get(&pdev->dev, "pix");
-	if (IS_ERR(csi2->pix_clk)) {
-		v4l2_err(&csi2->sd, "failed to get pixel clock\n");
-		return PTR_ERR(csi2->pix_clk);
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		v4l2_err(&csi2->sd, "failed to get platform resources\n");
@@ -781,20 +769,12 @@ static int csi2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(csi2->pllref_clk);
-	if (ret) {
-		v4l2_err(&csi2->sd, "failed to enable pllref_clk\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(csi2->dphy_clk);
-	if (ret) {
-		v4l2_err(&csi2->sd, "failed to enable dphy_clk\n");
-		goto pllref_off;
-	}
-
 	platform_set_drvdata(pdev, &csi2->sd);
 
+	csi2->num_clks = devm_clk_bulk_get_all(&pdev->dev, &csi2->clks);
+	if (csi2->num_clks < 0)
+		return dev_err_probe(&pdev->dev, csi2->num_clks, "Failed to get clocks\n");
+
 	ret = csi2_async_register(csi2);
 	if (ret)
 		goto clean_notifier;
@@ -804,9 +784,6 @@ static int csi2_probe(struct platform_device *pdev)
 clean_notifier:
 	v4l2_async_nf_unregister(&csi2->notifier);
 	v4l2_async_nf_cleanup(&csi2->notifier);
-	clk_disable_unprepare(csi2->dphy_clk);
-pllref_off:
-	clk_disable_unprepare(csi2->pllref_clk);
 	return ret;
 }
 
@@ -818,8 +795,6 @@ static void csi2_remove(struct platform_device *pdev)
 	v4l2_async_nf_unregister(&csi2->notifier);
 	v4l2_async_nf_cleanup(&csi2->notifier);
 	v4l2_async_unregister_subdev(sd);
-	clk_disable_unprepare(csi2->dphy_clk);
-	clk_disable_unprepare(csi2->pllref_clk);
 	media_entity_cleanup(&sd->entity);
 }
 

-- 
2.34.1


