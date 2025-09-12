Return-Path: <linux-kernel+bounces-813133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6577B54104
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699C9168DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA13213E9C;
	Fri, 12 Sep 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrTp9Rtm"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB447494;
	Fri, 12 Sep 2025 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648171; cv=fail; b=KElcD4L7JS57Gdbo4kDeuZbwEJ6zP3o//h19HzKWoQV2n57eypsjxgIl1aWM/M+Gfqa3yGoJmC2F7WCutIK4NKc4povEWH3WJQtZyW96AiGavxnGPsMQTFepslSBhpjxIqx9czhjV18lf9ppSHuXkuNEuFH8z+5Ax457Hb3MhY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648171; c=relaxed/simple;
	bh=RTFf8QyccuqRfSjv7R6nLWp5PpdcTG/v8bufNvRnnnY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oyHS/tzDzrM1Y6G1gIhrQ3dLO4kn3LeCMUPDwMj5v+IYrCskvQ0ckySH6ix9I9hFKoyjsjQ420yfyDNU2H86PPwTmbBcNphTj6VH5Pu0N0x/tDSZpXKLysDq72Gp7+IkT8tG/YwDqyAakyw4zrt1ljyqg8PmdSJNrkoFqKa9f8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nrTp9Rtm; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUFJAKB292zTOb8PhaZ0ewXVdRJc1zUU4QimZqecqkghSUrpudyJiw7gYK3P+zN7F3bYoI+lQyV/cjth8n3kNTDmBzfkYATsVmvxeprPVo2AlTSTjHyaY5CyreOacaNPsXhk+JPCIMP49NsMkegfscSDUTzncvdfrTilGBkg5100YdUmlIjcvFwZ9gIOCYwpGrD9IyrlP1QZMVhCMENJHWPArrbM445QNkzjJgZhraWzLBW5kXMi+LOmxFCh0ZLfBUwR7anikBOI8kcPXV0PyIum6ZrzCZsjT+uzHPryi7RjXyS6G/omiqeF7JxJrc4SvmYQ0DTtP0S/sKBgtXUKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNgR5efrhzZPXfsws55x80BcuuOH/+B3kgAlBYi6hZQ=;
 b=JYzlruoanWcJf3PEUGYBd7RiSCHNSRa1rLRuzKIK++z+Cmxm+HqSAHUxsZsWI9wX8nQhjHGXJHDhfID+dcYUSo6iqy5Al0b01qiZKZMN3yObCQY9v95bxCfIgUCEsWuvmp8mo0ktn7NKXdK6jm+0KKG2DU212JQdwSPj0cef75sMXmuJA2iQQSGULejZlmrQ/R/alNxqnpn9m1qabU5VqoMBy7upnt4Qo8zUul+5YqAAk0Plvwq3zshdnPHwg5WaBJKJwQ/hovgnISHvb7dvLGhc0gH9nSLmsKDmUpXCsQ3+nMtBpz7txY8QqhcTOV+Ob7QBj12yRR2zanZVLjnKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNgR5efrhzZPXfsws55x80BcuuOH/+B3kgAlBYi6hZQ=;
 b=nrTp9RtmwMmuVS5dc6eQp/U1nrdDXhTbBIi+msVeXF1xHLoVovNgBkaViROWauxpGQWU2O43sMG47fCffPgaknIF9IGGMCO3CSfJbFEJB6sjFolQM3U4AVGAURmcyZQig4a1IATH5W/RkZn/4ePF/rDJfd6tvFbZtjCkrT5UMEGTWEiU3NcxbPxMNVQ9zKdVWNJREF6hMZVMaxTweRuw2zwuE1LMmnb+1eX2RUi6pon8drz87U4yZKyexNnPSIgVODqLU+XRnuZYvMRntpURc0riNIhb/w7AuaQuW1B0OMbB9mmbJlD1nsRnyPuAaha2GUVT0AzzV3j6GXgnId5MGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 03:36:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 03:36:05 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/5] clk: Support spread spectrum and use it in clk-scmi
Date: Fri, 12 Sep 2025 11:35:49 +0800
Message-Id: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABWVw2gC/32NQQ6CMBBFr2Jm7Zhp1QKuvIdxge2MNCqQ1jQYw
 t0tbNgYl+9n3psRIgfPEU6bEQInH33XZthvN2Cbur0zepcZNOkjlUqjfT4wRouJw3yrsLZixLD
 cXGUga31g8cOSvFwzNz6+u/BZPiQ1r39iSSGhZTEkmlxR0Lkd+p3tXjCnkl71itQPXWddOaoPp
 XEibFZ9mqYvssca/O0AAAA=
X-Change-ID: 20250812-clk-ssc-version1-acf6f6efbd96
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648158; l=3824;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=RTFf8QyccuqRfSjv7R6nLWp5PpdcTG/v8bufNvRnnnY=;
 b=a83MpOrp/UQXqIRuhBm883/2ueXFbKmNopvGlniVbds8+16TOhlIMg9IqCXBSNyA82K2qK4QW
 wO/yMC5AfYuB8J4pdn7rLi5I1UbsktYBTiJuyIBTACPRWTCYPfAomA+
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
X-MS-Office365-Filtering-Correlation-Id: 5d796a19-e642-4ec7-dfa8-08ddf1ad80f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUtpLysvbUNKaEdUcG04NEdEWHhIQ3RCYkZqcXRLRWx6Y0ZuYStJQ2RadnRX?=
 =?utf-8?B?bWk2aDFCVlpZNkU4QXZjQ0JETXdTelZ2U1FKSTd3ZEtEdjBMdURSQmhiWUFE?=
 =?utf-8?B?MUJtZ3k2TE5Nd2JPWk9FV1ZvL3d6VVRBZFV5aVJrRG42RkJpTFVBeWZQRzZB?=
 =?utf-8?B?ZXNjVStFeDRIU3JDeEpPVmVzRGJxR2hOa3pJQUFpcWtaYnROWlB5YzYzeHhG?=
 =?utf-8?B?MFdYTGdZaXlTekxxRi9ZeEx3Z25IUUJNbFFmN2VxVDQ3bjV1MkFSKzVRT0pp?=
 =?utf-8?B?ZCs5am5WTnRMRW1TVlRhNEcvZGFKTkFTREYrYnlIdnY0cEt4aTQ5SUFDdG9N?=
 =?utf-8?B?dGxZbnBxbW82dkUzOTB6MSsyYzJEb0tleHRKVU0ybHNib0xvTmsyZlpycGJF?=
 =?utf-8?B?T1pTVVhwUXk2MDZxV2puZnQ3RmhtLzd2RTBZdlpmN3g4OExXRFFiazJ0RTJW?=
 =?utf-8?B?Yk5DcXdzQUlsTTBtL2d2N2c3NTFpSHZHbkJUOHBDc1BUOUFlMkFZMXNRdmhX?=
 =?utf-8?B?MHdSVERmUmpVUlZMNVNwN0dvQ3RKeGZKT2ZtVkZvSVV3b1dpdUQrbHJEMENJ?=
 =?utf-8?B?NWI1NDVJUW54UjVTNWN4YUd5cGhzWlRlMXZRc2N6enF6MEZtWWp1eVZsMkpQ?=
 =?utf-8?B?bEZPZlZhOVRWa3hnb285cTZSVmFXdHlFKzZ3U0liVGs0eXFPajZVWUlOZkh5?=
 =?utf-8?B?c1A5Q2o4VDhMVXp0UVBsVWUwKy9WdzZxd1ByRnNZSGFodlJJZ1MyZVB5TllL?=
 =?utf-8?B?UGlJZ0dUTjcyM0x3dDkrOVhxNElETExoSUYrYy9TVFlIZSt5TkptUi9FaXM3?=
 =?utf-8?B?OFhOVnp1bTRGdlBob1pHZHZndHpPRXd6OHMwRmZKd3NHSUxsVExKRkZjb0l1?=
 =?utf-8?B?R1h4YlA1MHp1cXRuUEpwWGlwSlhFdjlDSVlpdXNGbzloQi96Szl1N3ZmRXNa?=
 =?utf-8?B?bXdMM1FJNGZ4N0Y0NjdVcmlQeEN2WFM2WEs2NUlBaGpJQmxkKzFvdGpMVW93?=
 =?utf-8?B?VC83NEd2L1gyOWM4bTdHdnowaWlISG54M2FNRjlKZ01LSHl3eG4yNmxpQks5?=
 =?utf-8?B?UkszOHFWQVU4czk1QS8wOHMwNVZWTEZVaVlNcUhYckJ2YXNSM1V1RnUxV1NG?=
 =?utf-8?B?UmQzSTZPNHI0bEJ2WTJ4bDlUS1gvTC95NmFPUDhpTGRjc2FBdzEyeHd5bkFn?=
 =?utf-8?B?bnVmNExLVHljd1U0dEdYSmV4Nksvdyt5QStPd0t3Mm9TTEJTZG9qU0s2eFo1?=
 =?utf-8?B?T1VuS2M0WkZDMFZ5ZEpJRU9SZ2JkVmNocFhlQmpxQURqQWVCcEFKZHNBcHFX?=
 =?utf-8?B?VEN0dDlxMzFDTEhFaThINmxNeC9KUU1kSHpwb3IzNVM3ZzB0LzdzWkVYM1hk?=
 =?utf-8?B?eHRXdlV3emlHOE1QYmZtSWhmcE1rZFJSbTRZK3NyZmJuQmdheHZPLzhGUjk0?=
 =?utf-8?B?Zlp5OGxwOW8xM0ZPY3BpRllDVk14eXFPNUlsa1p6eUt6STBSODdaYXVIWEtK?=
 =?utf-8?B?N0w0b0p4U25VY2R0YTNVL0ppQ0l3b0luUG1rUmJ2eDVHaGQ5WXNuMjQ0T3ps?=
 =?utf-8?B?a0pyVjZsRWNZVEpVTWZ2dm55L1Q2VVVmd3g3Ym9FTFJ1eDNSZkFycEZJSGll?=
 =?utf-8?B?T09DV1BBZGJOZXVBRzRJUlpHMVpFdW1kRWUyVlM1STNnZHJYWjJpSzJiNXEz?=
 =?utf-8?B?eHFvb3pLRmxSNUc4bkpISk9FRDBEcWc5QlBsYXFCaVQyT1RYM2cxU1JIOXRX?=
 =?utf-8?B?NlZiY2NMTDJ0eHp4Q0RSbUxVY0ZUNlh3U1VYNEdMUmc2VGZJNWdTdWI3UERQ?=
 =?utf-8?B?dWNJTFdlUmJtQjJlWnZmWEpmUDJPK0xqbzdxWXVGSVZnL3ZJd0dQVWtWZlI3?=
 =?utf-8?B?K2kyWjZoY3ErOTh2UzNjVnJOaGdlUzZubnlOb0c4WUNwQzRMYjhuNWY1emU2?=
 =?utf-8?Q?2CahFW0U2WkkSzKqPJK7TdzL/o6JQs0O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Znl4K1pvb1lrWjJvTEdTenkrWGVqZGVsRzNnNzVJRHFldU5BUERYcDYyTk8z?=
 =?utf-8?B?SGZELytEeVQ2WEYxNVhVc0RnYnNXNHI4Q1VMK0U3NzN5clVzN1c2dlVHSXlC?=
 =?utf-8?B?STZpVzRxUW43WUJqeHk1dVgzKzl0UzdTS3N6bkxXSW9YalpudUZTSG5COWJy?=
 =?utf-8?B?aHgvQmZHbS9LM0pjM0lXam1DMFd4OXZNUkFFdzdWZko1alYyRXJ2bGYyTVRZ?=
 =?utf-8?B?QmhMYW9jM2kvb2JHWUU5Zm1mUkRyYkJrek5xdFZYaTFXYXlpL2lZaFhpcGR5?=
 =?utf-8?B?UHUwcmFxeS9lcUhwU29DNjJ0a3VqbmlkR2VFUHQ0RWlIMzhQdkNXVUVtRkkx?=
 =?utf-8?B?ZnJVbTFvVWdRSTlzMmdnNlRtanRpaWpvcnlTRHFZZ1JaSHdhQ1llNjltV1lF?=
 =?utf-8?B?dnBoemJMbUpJam14bXlYVXVlUFdVVnlBWlVhdGZtMDFieWRzRVFIS3R3NTFU?=
 =?utf-8?B?SmJIQW9DMW01d0J4dGNvR1BHU3J3U3JmYkRsNmlvQmg1TmN4NkZGM0kvV05w?=
 =?utf-8?B?ejMrRmE3L2Z4KzBEeXgwajVQM1Q1Wm0vcnJzZHNJUllWbFpRZ2E3SXVDWFNV?=
 =?utf-8?B?M0VHNjJpZDdBNWgrZzJndXBLbVlmRTN6cTluTXZ4TDRVaXBHZWcvcDdKaFZL?=
 =?utf-8?B?Z2ZRT1ZCSEtNdkY4d3h2aGZETUtiSkZxWUxaVENUSGkvYi9jK3ZlOTJTSHQx?=
 =?utf-8?B?YWZuYjk1Y3JhWDhQVGs5UzdIeVBSMUVTRmRqMkNlYUpwTEFCU00wdDFBM0VU?=
 =?utf-8?B?Wlhjd0pQazFJUFVFRFZLUDc5cnI4QlMva0VZalRYb0kvWjRxL2k1K1EyU21w?=
 =?utf-8?B?WCsvaXg2Yk1KRmhTbTdITmNsWktFOGhzU3IvK2w5dm5HVmRrQ0o1QTVkSzFh?=
 =?utf-8?B?SU5GQW5DaW5hR3JpNkVkU3lHWVNyMExzSllYbVNMZVJwQnQ1dFRyb2N0dThO?=
 =?utf-8?B?SE9ZQTVUYUtyQ3U5d3FJUkxORkl3VlVzMDNoQk1PbWM1bWV3b0g1cjdBUTk3?=
 =?utf-8?B?djJZeDRuS2ZLV1RiUys4QU1JZEZ6R0NkaDF5YVF0UjBWY1dBem5HUWdkNzhG?=
 =?utf-8?B?SnJlOHViWmNJcDJEVmErN1ZybUxhNVFVcFdHekJCRDI5YURrUTZPZHNzaHpF?=
 =?utf-8?B?YkZaMmZnNlpadkd0WERCa2ZmRXYvRyt0ZzFMbDVBTnkwN016TE5pZnBqeWpa?=
 =?utf-8?B?Q2diUHJZQ0VuM0tvMS81eHMrRnFGUE9tK2ZpbTJGWnhoWmJHcU5NY2U2L0x0?=
 =?utf-8?B?ekN1elc3WExSeEN6TjFmNkZzU3l2V2NqYnc1dUZ6VTBaaVFFa2duZkF1cDBp?=
 =?utf-8?B?Tnh4WUlLTEUxZTFYZTJhRkc4S2FRdmh4ZTZ4SXZod1NsVDVuNlJPdHZoUjE1?=
 =?utf-8?B?Y05xMm5uRzhoY01uMU96WDc4a3NwS252eTFHRVMxeFA4dXora0lRSnAya0I3?=
 =?utf-8?B?UjU5Nk5RWk4wMVl4UkpHR3hEQXU2UEt0SGthZXVZajdFVUlFdWQvbE9PZVBL?=
 =?utf-8?B?bEdmNWtuK1ZzTmhBaEtFSC9GZnVXSVUzNVRFcVlPTWFtUWVMSWRtNElnTkg4?=
 =?utf-8?B?emtpRm9vbUsrbitBampFTzljK3QwWTdPeExXVkxhY3hvT1NvKzh0ZHZDcnJt?=
 =?utf-8?B?cnNzanhmUzc5V0lTckZGcWFpNUpqTDZuNjBwWWJ2dmsvdVNjVyswR0VBVWV6?=
 =?utf-8?B?Ynp1TDVQdnFwN0hIM2tMaEkxem5WT25idHdZc0FyT05tTHZxVGZvRTR6OTIz?=
 =?utf-8?B?WXdWaHZMaFQ1VGZicnY5d1JNd2IzTTRuaC9oaWgzcmVyRjdyQk1sdUVqMTJY?=
 =?utf-8?B?UTdRK25pVFVQT2huT1QvbnhVd1JLY0dIbGYyb0R0L2JKTTRGSndPbUFnckxH?=
 =?utf-8?B?bHIwd0VpSHFuMWhRTHgrQTB5RHBNQmJnMWlxcHpRcTB3VjF2cks0QkxaRnhO?=
 =?utf-8?B?YUQvVnJITktCZWNaTDJNQW1TT0V5Vy9Mb205NEp5QVJzZEduNE1ERWwrUkVR?=
 =?utf-8?B?SXJsNDF0R3JTaTRHc0VYMStCeFY1eDAvNHJnVDRSSHZsL0lmSnVTdXFXVnZi?=
 =?utf-8?B?THZzcjVUaWFHM2NZY2RmWU44ZHJ5YUJvWXROOEswdDI5TkZySWtoUXJpUnlC?=
 =?utf-8?Q?uRJcwCLPiro3nNQVyqV2L3Z3M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d796a19-e642-4ec7-dfa8-08ddf1ad80f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:36:05.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3IYRmBxEWyrsCcLKMf5OewKb2Yz15skik8jmXyILj42e37wv1U66Rn/oaNu93ArTQyR4vJ8bo5G7hzcPm99bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788

Since the assigned-clock-sscs property [1] has been accepted into the device
tree schema, we can now support it in the Linux clock driver. Therefore,
I’ve picked up the previously submitted work [2] titled “clk: Support
spread spectrum and use it in clk-pll144x and clk-scmi.”
As more than six months have passed since [2] was posted, I’m treating this
patchset as a new submission rather than a v3.

- Introduce clk_set_spread_spectrum to set the parameters for enabling
  spread spectrum of a clock.
- Parse 'assigned-clock-sscs' and configure it by default before using the
  clock. This property is parsed before parsing clock rate.
- Enable this feature for clk-scmi on i.MX95.

Because SCMI spec will not include spread spectrum as a standard
extension, we still need to use NXP i.MX OEM extension.

[1] https://github.com/devicetree-org/dt-schema/pull/154
[2] https://lore.kernel.org/all/20250205-clk-ssc-v2-0-fa73083caa92@nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- New patch 1 for dt-bindings per comment from Brian
  https://lore.kernel.org/all/aLeEFzXkPog_dt2B@x1/
  This might not be good to add a new dt-binding file in v3. But this is
  quite a simple file that just has four macros to encode modulation
  method. So hope this is fine for DT maintainers.
- Add Brain's R-b for patch 2
- New patch 3 to add Kunit test per Brain. Since Brain helped
  draft part of the code, I added Co-developed-by tag from Brain.
- Link to v2: https://lore.kernel.org/r/20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com

Changes in v2:
- Simplify the code in patch 2 per Dan Carpenter and Brian Masney
- Rebased to next-20250829
- Link to v1: https://lore.kernel.org/r/20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com

---
Peng Fan (5):
      dt-bindings: clock: Add spread spectrum definition
      clk: Introduce clk_hw_set_spread_spectrum
      clk: conf: Support assigned-clock-sscs
      clk: Add KUnit tests for assigned-clock-sscs
      clk: scmi: Support Spread Spectrum for NXP i.MX95

 drivers/clk/Makefile                               |   6 +
 drivers/clk/clk-conf.c                             |  69 ++++++++++++
 drivers/clk/clk-scmi.c                             |  64 ++++++++++-
 drivers/clk/clk.c                                  |  26 +++++
 drivers/clk/clk_test.c                             | 121 ++++++++++++++++++++-
 drivers/clk/kunit_clk_assigned_rates.h             |  10 ++
 drivers/clk/kunit_clk_assigned_rates_multiple.dtso |   6 +
 ...kunit_clk_assigned_rates_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_one.dtso      |   3 +
 .../clk/kunit_clk_assigned_rates_one_consumer.dtso |   3 +
 .../clk/kunit_clk_assigned_rates_u64_multiple.dtso |   6 +
 ...t_clk_assigned_rates_u64_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_u64_one.dtso  |   3 +
 .../kunit_clk_assigned_rates_u64_one_consumer.dtso |   3 +
 .../kunit_clk_assigned_rates_zero_consumer.dtso    |   1 +
 drivers/clk/kunit_clk_assigned_sscs_null.dtso      |  16 +++
 .../clk/kunit_clk_assigned_sscs_null_consumer.dtso |  20 ++++
 drivers/clk/kunit_clk_assigned_sscs_without.dtso   |  15 +++
 .../kunit_clk_assigned_sscs_without_consumer.dtso  |  19 ++++
 drivers/clk/kunit_clk_assigned_sscs_zero.dtso      |  12 ++
 .../clk/kunit_clk_assigned_sscs_zero_consumer.dtso |  16 +++
 include/dt-bindings/clock/clock.h                  |  14 +++
 include/linux/clk-provider.h                       |  22 ++++
 include/linux/scmi_protocol.h                      |   5 +
 24 files changed, 465 insertions(+), 7 deletions(-)
---
base-commit: cd996742d7bc41dc968843b64e6af19ff32c72fa
change-id: 20250812-clk-ssc-version1-acf6f6efbd96

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


