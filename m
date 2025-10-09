Return-Path: <linux-kernel+bounces-846232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036EBBC7546
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E2F4007F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED624339D;
	Thu,  9 Oct 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oGT2ZhJR"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B323E359;
	Thu,  9 Oct 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981744; cv=fail; b=qX57fww1PFN3uFUwOxAouftGPtMqf5rkHdt7r4znYc20p0wtc8zjVvf8pbVC07IiXEc6NMTUNemBfWe13733FKf0Yp0gzIskQto25JcrZ3nKtvJKW34wPoGYcASq0THWlArxZuHR62PvmC6/58mPAjsAmb7x3Qdb2MgvMtwjYpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981744; c=relaxed/simple;
	bh=NGTTg3PlaerQz8kO1OE+x04WN7zdtC/9CPzewhvK9vY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kNdPDkGNIIsyaImiyXB+ozuqjYM10nOvt0XXYN3pWFsIT8XB26HJaFdDpj508v43YijboKv64GlXQSblEP4Yz65uJYb0GJT+cwYIL+yOXLZTXgmibSqBI63gZDHSdcutZf3rd7quNUqamjRhaB29HdwqrMYWd3STHAUvzQo3c8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oGT2ZhJR; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhgMWdGJRXkhNhUy1cm5B1QvHJx/ob1bdVhXSGV1mGw2DS/n0aS34rqVB2QoqRMGNyBXnWoEQ+YcxwDbixTzvnTgpJzLgVMIjheLP+dWSetAYAEvIJl4GVq9bBbeqqSUknw5OUsMAg1fKKZJvzTPkJhyHbJkEy3/t6VrZAQN9QISFcTDP/1Sy5mSwItEEFEdS0kaKzVlzb9k3rdPrdkEQ5Jr4ylQp3QEJBa1/ga0MOy5T8BDMT2sN52r+nu3WKoZmZ2opA/QPmxcUfG5HN+nLj5sDYU6Nx51Z2Smj7XyW/ybKlbJQ5K3TV1S3rr8wxJOZji92O1bsG0f3K8+KTu0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/dWBPlS8tg2w8bAPeHkCwQAFycscw7MQexhi/fu+Do=;
 b=Wd2vLle89CC2hoCnFxFysyUJUnWa+EZ4VOHLTDtHq/j4K2Z2r5qOYyBttbJAISWgBOeebO3dAuhJW17xXcaCmtr37IDd3xLEHWudxDj6k6OY2rYbZKuPEiel0Vup05nguOYmj13yw6QIeByT9z0w7aOyMte4799EXKe5lILXYEB6anUnIvq6ERzxvv2ritcu45GUSh2rZD/Y9wcP7UPJD4eGJQ4pZTRnkU4WKTlHIwQz6qRzD75D3ZqvLvnX+2p4N1+fKa004VWKgnKuCWZLpssz4Nd+MRU2Lba2FaAFuS1aKm1z8OdQrDHVdpO5S1v2wXib2dMpkRqvQqssft3D0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/dWBPlS8tg2w8bAPeHkCwQAFycscw7MQexhi/fu+Do=;
 b=oGT2ZhJR7hjoK4mjYAEA/6H/bd85SYw2+w3zzkZtZXJ+5fNn6KIWBPeYRMjd1/8Sd7EKX7VytinTP0ZmIJUlSEEubTVshgYON5jmRFVZEh3sOqLBeA2Oe/esSwz1g/J29RjOW3bCcIK+MATK9ad5fq0JpjZjjM727tk2w7ioGW4GYuQWV2y8JK+tDwqXwDwQa5mLzB6CZkYPaKgAKD8KfANdkTDyyZvsabRlBXU9Ceyw5Rkka7QvHDd9gDZ8zE0V2Bl4DeC8MB/4j+Bb+8oulk1fXzb02VDs+IOCFQdrTYWC180ZmUrb80p1vXbYSTmkiQJe0LUsQXTJ1vV9RB13nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:48:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:48:55 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 09 Oct 2025 11:48:18 +0800
Subject: [PATCH v5 5/6] clk: scmi: Introduce common header for SCMI clock
 interface
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-clk-ssc-v5-1-v5-5-d6447d76171e@nxp.com>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
In-Reply-To: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Sebin Francis <sebin.francis@ti.com>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759981702; l=2832;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NGTTg3PlaerQz8kO1OE+x04WN7zdtC/9CPzewhvK9vY=;
 b=YpRItsJZ4Y9m9LAFWD6pwgHX3iB3P0yXqWo/M5HwtQUHd0U4m1L12OgvNudtjD/KUhzM+MR4j
 AGT6+JpA7TcAN1OVFJEqJv+OHsO8M965n55NQAOHvOLqt9dV531DJob
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbda495-3e57-41b5-91bc-08de06e6c51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGg5SzNOWTNXdXBBQ3J3NU5OMVpIeXhyL1JjSnlsWUpUdFdySENGN2hrM2Fl?=
 =?utf-8?B?a3NXV1BIU2RCc09lZ1F3QWVsUElZeFZZMEZaTkFDRlBJMXpQMDBFWWptQVpM?=
 =?utf-8?B?cHJxc0RyQ21aRjdra0NTMEYyUTlHUmxuYzc5OEpZai9aa2VjdVlCN1k2WnY0?=
 =?utf-8?B?VlBSY1h6YXBVcUhpajBVN01OSU5rQWlseHVCMkh1SnlzZjV5TWtGdGNnaTgr?=
 =?utf-8?B?MTY1T0ZSS2JldGJya2djejUwN2psMmZjdW9oR05jZThaQkNvUUdzYXRjdTZn?=
 =?utf-8?B?M1VaOUdTNkhGNmJ4OGJSTm9FL2ZTQS83RTU3NkppNERjWTVyR2NWNEhvckMx?=
 =?utf-8?B?THVOdEE4djZoS3ROMVdBZE5obUt1ckZJaTJ6MFUxTi9TbXFRTGhYNGN5OHNt?=
 =?utf-8?B?ZnJMeXNsN2VVdGNzZHN6K3dodVM0MU9JUTZvYkZRNjJuMUdiSW56MGp4S1NX?=
 =?utf-8?B?cDBXa3krcDU4dnVFSDY1ajYrVUl3cGdmRGEvbEE1T3FzVFdkc2dSZ0FUWUt3?=
 =?utf-8?B?N2ZKV2hiUExKczdqMVhtNGNyTWJaaXhHWkVJRHJVOERMbW03N1BCZnRFVktM?=
 =?utf-8?B?YTZFMzVTNWdub04rZUF0RyttSjl3Y0JwMDNpc0x3RFBtMWk1ZUUrMDdUbDU2?=
 =?utf-8?B?ejdBbUprVEp1aC83TWZtTE9BczNZL2lhWXlkT3paYjRMMUdSV2JvR2FPREsw?=
 =?utf-8?B?anl0WUNXMHlXSkpoK1YrblNpeEJYeW1LZWJ2QkF6ekZFNUd4eTQ1ZThwbDRi?=
 =?utf-8?B?Y0lMS28xQ3BnQ2FIdXhtUnBsQUtWakVhWFJCWEg4RVhpN1VDdjZ1RXdLSWE3?=
 =?utf-8?B?cERINHFQZlcvVUlWa3RnSmxXN1g5eDY1MkZOWDV5aktrWjJLb2hHQ3FoV3ph?=
 =?utf-8?B?YnJNUDBYZ213cUhmd0tBaEZ3dW9UWTlHMFpib1RPUHhnT091c2o3RURMdGhT?=
 =?utf-8?B?Q3B0RTZWcXc4SjhwUnZXNmN6NVk5Sytobmp3V0IzWVJlNm5vNkt1citOZHlJ?=
 =?utf-8?B?bHl1TTJuMFp0K2tiRzlDSEswRS8yOXZaelppZFNRNU93MTJ5TDlXWXdVTDJn?=
 =?utf-8?B?UTlkbXpZcXJnM2t3bGlPTFFlSElPdWN1b0x1UzZWUFMvbEYyMG9TWndxVWRu?=
 =?utf-8?B?ZFp0bmNKYUluWlRiSDFTa2JQMENNeWd0NWlSQzkvOHVmdzhKQUNLVlBuOFVX?=
 =?utf-8?B?YXJlTEVHbUMxcUlLMi9OUVNOait5MEo3Q0RVL1RyRG9TKzd2SVRRdkR6Qksz?=
 =?utf-8?B?VGE3bWM2SmMyZk9oM1ptY1BjMUlJMjBIY0prK2s3czk2M2UvVVVHdzZ3Tk1q?=
 =?utf-8?B?ZytLcUhpdGFYRUJQNkhPR3BDSGJ2N0dHMEh2eFZZWG1DRGh5bjQrbHE2RUpi?=
 =?utf-8?B?Uys1NllRQXByVC9NZU10T1phWTZnRURwUjVvanozN2hEb3Q0M0dhWXY1K2lC?=
 =?utf-8?B?a2Q2T2NHbUYyWW1zNFhrRWhBQUZrNVBVK0wrRXJDWW9FV3Y5ZFJubEpLdG1B?=
 =?utf-8?B?cytzdDNPTHB1SlJ0T1o4ZjlFWnY2WGJ4UHFsenRSLzdJUUROREFzZTR5b0da?=
 =?utf-8?B?TUdrK0FWYmF3YWhDcEV1d0ZiNEZ2LzI4RFh3aGRLS01IaWIvNkhQMEVZa3J4?=
 =?utf-8?B?QlNsaytGemlxM1ByU3BTbHFSTDdzT1BEMVNaaDBtVUlNMmw5Y1JtVUVUN3Ft?=
 =?utf-8?B?dDYralV6ZkdZT0VzamxaQjVlb1lHQjlRMUE1Qlc0UXFiMWpBc01rd2wyNTFD?=
 =?utf-8?B?Zkx5U0k1SFZMT3pHa09GSG9QTG5HNVZQeGo5UjZyMEdxQnBmME1NU1FyZnF1?=
 =?utf-8?B?Y041WERBQlNUcVVJdGlJN1NiWVF6TzBudkJGdHBOc3lEK2xxdkR6VXlDLy9n?=
 =?utf-8?B?YXBmeHUrcldVVjRuaGVIQkhSbmVQeHYxMjNkdE5zbGp6c0ZXYTl0UG1RNFVQ?=
 =?utf-8?B?aVJxajVSbG02MFBCQ0RkYlU0NmNBZVVzeWtCK3FkbXoxM3lPbnZoczcrUXFY?=
 =?utf-8?B?eit4VFdmUlR4Z3VKQmZxSU5YVXgxL1A3N0R5bkwxU0RtQm1kUHFIVjZPY0hX?=
 =?utf-8?Q?pQoQ1S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amJxNmRPWWpaWjhHVk9vbElVYkx3NDBFK2oycHFhK0ltb0cxRS9FTXM5Z0Fj?=
 =?utf-8?B?NUVkKzFHL2Q1NUZIenp3N1N6Y3dNb0xCT203SXhpUlZ6Z0N1WnBVa2NsZkVh?=
 =?utf-8?B?SWdlY1VVTzM4SVUwaXMyQ0thc3NOelFYamZHOFBwV2JscTVSRkVmbkRGczZM?=
 =?utf-8?B?cU11Wi9hRFdhb1FpY0pPa2tRdG0zQ1Q3NDFPcFFuRys4R0xtSkVvOHUzVElL?=
 =?utf-8?B?bjVlOXJpZHpGdlJuTGxNSkJjeFpDWVBwK3RUb2VLOUZsdndlWXFrRnRkMldU?=
 =?utf-8?B?VUlZUVNreEJ2RzNLYXNjeExrVVhUT2daS2RESC9INVRtMFNGLzNadnpoam9I?=
 =?utf-8?B?T3pvSUFqaGtKUW9JcTJLUkxQSjJyNnVITWhKQWNBV1UvK0oxN2czSUV1d3Er?=
 =?utf-8?B?dm5VRDJ6WkV3UzVYaTNhbTNqUGcranNEeklMMHZObE1kamYxUGlOaTAvNVM0?=
 =?utf-8?B?SXU2VE13QU5VYkZDNmYzaXhYRVRnWTNCRG5QcUEwckJzQzlBUGhnY1hYL2JN?=
 =?utf-8?B?dldVQUJhUUoyODNxK0I3RTYzcDZOZWx2Wml2c2h4aW5qbmExbFZUZm1uemhz?=
 =?utf-8?B?SWdtM200T015elVwblAyd0hteEVnNzFwM00yeDdmYW5DTjJkQk02V3F3Qmtm?=
 =?utf-8?B?VGxqVUJqOGI4eTU1c0tBSzBKMzdIV1hmYURmdDF0ZVVMa1BBcDdCbUtTQ0hz?=
 =?utf-8?B?bEJMdkhza2FlSGlrNW1GVnliZVc0R0pyUWF4cVFGeXU1MXJvK211cmFOd3Z6?=
 =?utf-8?B?K1hjMis3UVdvNUdJZC9rWmI5VGJOS3pBSHhBT29iQ2MwbkpEdWxXTUFPT3VQ?=
 =?utf-8?B?UnFWQk5NWUlZSld4V3BhSW5sc1g1WXl2UThKcmt5RXZ0Y2ROQzkzTXBMcUNO?=
 =?utf-8?B?dzZoZ2ZKc1l2a1haT1JOMlBUS3d1QnVSekNJSUNYSTYwdm5ud0lURk84QzU3?=
 =?utf-8?B?ZVE4TTJobWYrQzEzYjlsM0FSa3lCR3BBTFc1THU4ZUlYYW9adHJNMnA1MjN0?=
 =?utf-8?B?eDMweXhvYW0zVzBoeVpOaGZDS1NQa3RpSnhUbVhDSWRHSW1VQS9JVmRsSW1z?=
 =?utf-8?B?cVJlanNWbk1wQUpnaG9hZWV2cW5oZmRHVjcvTVVXeWRoRnZhQ1k1RngyUHRM?=
 =?utf-8?B?VndnUEszai9Gd1J1OExZZ3dnZ2ZyckEyQTBRejgyajk5dWpHdllTeW5pOThM?=
 =?utf-8?B?WXFvYU5XdVhJUlo0N1VGbXEyMFE5Z2ZGNC9kdFVPR25BY3dZTzQxaHNHNGQv?=
 =?utf-8?B?Ujd3SmZiY0NvT2ZrR1ZqaHByNHpHekJZNys0d0xaSWNqYjlQTnNuOFZvNmwr?=
 =?utf-8?B?K3R6OXo0b2dGb252S1ZkYTVtL0ErSmJlS0JGYml1Mkw5S3l0UTcxL1YvWjAv?=
 =?utf-8?B?Z2k4ZEhzaGVqYVYzM2JlZDJWaEFjYW9mcHpuVFVxYWw0M05QVG5iL09jYjV3?=
 =?utf-8?B?SjJ0S2pYQnZQVTlkeVVjZGM5ZVphSDNDRnRUVjFPMkRNSVU5V2ViZEdwNG1M?=
 =?utf-8?B?dVhQU0VCRVd0YUdlRWpoWk8vdjdVSGh5Z2ttK0FwU2F5dG5ybDZrbFBzdW9o?=
 =?utf-8?B?dlh3TVY4QTFRWGxDNllzNE95OHE4RUlYNTA0YXhBRENIQUN0MFlsWUVnZU5h?=
 =?utf-8?B?b0lsemRvdmlnK21KRUNwZ0tLZ3ZyYXA1SXViQnN5bWQ2WE9mZFg1QjUxVE91?=
 =?utf-8?B?L1l2bi95OHoyTGZGZjdHK0ZoTDJoZFNDckxjUkMybjZMMzBMZm5QbmxGWUJa?=
 =?utf-8?B?MFJtVVhMdUh1R3NIMS9ESzFqdHVrN2ZITktJc2IzdDAxM0pFcG45SXJVcDUv?=
 =?utf-8?B?dlVxT0U2OU90YnF4UERoRVBRaTYzaWtGUS9rWldNUkxCdi9McUkzQ0Vta1NT?=
 =?utf-8?B?amM0U2tJMG9tMlBQcENLZG1DQ3IyRk9rbVlvclBTZE1jbERCMUd4WnNPTWVE?=
 =?utf-8?B?VlBFdVAyd3EzUXQzNE9EdE9pczB5eWNIbjlNanpVS0g4ZGZ3ZUsxKzhqT3hv?=
 =?utf-8?B?NERXYzBiVWdIY2xlZG16anlpTkpaMGdLZDd1YjE3ditZcWJSMmhwajJBN09K?=
 =?utf-8?B?cUhYUkpDME5sbzFRV2VxRmpvSXJWZXBQU0MreEJSRWdXbTIvU242SzFaZUlk?=
 =?utf-8?Q?9x28z5qcYdsiXAmuE+0613ehO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbda495-3e57-41b5-91bc-08de06e6c51e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:48:55.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: St0DFbeihIL6+j+oaHiPtvXoymc4i5F/vXqSXf3f2xe0kYrsQY+qDF9Spsj6U4In3iOTTjpzz0tpxeH46J7wYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Added a new header file 'clk-scmi.h' to define common structures and
interfaces for the SCMI clock driver. This header will also be used by
OEM-specific extensions to ensure consistency and reusability.

Moved relevant structure definitions from the driver implementation to
'clk-scmi.h' to facilitate shared usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c | 27 +--------------------------
 drivers/clk/clk-scmi.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 6b286ea6f1218c802d0ebb782c75a19057581c20..bf85924d61985eb9e596419349eb883e3817de73 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -14,32 +14,7 @@
 #include <linux/scmi_protocol.h>
 #include <asm/div64.h>
 
-#define NOT_ATOMIC	false
-#define ATOMIC		true
-
-enum scmi_clk_feats {
-	SCMI_CLK_ATOMIC_SUPPORTED,
-	SCMI_CLK_STATE_CTRL_SUPPORTED,
-	SCMI_CLK_RATE_CTRL_SUPPORTED,
-	SCMI_CLK_PARENT_CTRL_SUPPORTED,
-	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
-	SCMI_CLK_FEATS_COUNT
-};
-
-#define SCMI_MAX_CLK_OPS	BIT(SCMI_CLK_FEATS_COUNT)
-
-static const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
-
-struct scmi_clk {
-	u32 id;
-	struct device *dev;
-	struct clk_hw hw;
-	const struct scmi_clock_info *info;
-	const struct scmi_protocol_handle *ph;
-	struct clk_parent_data *parent_data;
-};
-
-#define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
+const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
 
 static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
diff --git a/drivers/clk/clk-scmi.h b/drivers/clk/clk-scmi.h
new file mode 100644
index 0000000000000000000000000000000000000000..6ef6adc77c836dc2d599ff852cdc941f217ee388
--- /dev/null
+++ b/drivers/clk/clk-scmi.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright 2025 NXP
+ */
+
+#ifndef __SCMI_CLK_H
+#define __SCMI_CLK_H
+
+#include <linux/bits.h>
+#include <linux/scmi_protocol.h>
+#include <linux/types.h>
+
+#define NOT_ATOMIC	false
+#define ATOMIC		true
+
+enum scmi_clk_feats {
+	SCMI_CLK_ATOMIC_SUPPORTED,
+	SCMI_CLK_STATE_CTRL_SUPPORTED,
+	SCMI_CLK_RATE_CTRL_SUPPORTED,
+	SCMI_CLK_PARENT_CTRL_SUPPORTED,
+	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
+	SCMI_CLK_FEATS_COUNT
+};
+
+#define SCMI_MAX_CLK_OPS	BIT(SCMI_CLK_FEATS_COUNT)
+
+struct scmi_clk {
+	u32 id;
+	struct device *dev;
+	struct clk_hw hw;
+	const struct scmi_clock_info *info;
+	const struct scmi_protocol_handle *ph;
+	struct clk_parent_data *parent_data;
+};
+
+#define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
+
+extern const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
+
+#endif

-- 
2.37.1


