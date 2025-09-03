Return-Path: <linux-kernel+bounces-799369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3406B42AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624C8546815
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92BE362095;
	Wed,  3 Sep 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gwu3wvBQ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7012DECB7;
	Wed,  3 Sep 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930818; cv=fail; b=jPIKkjGAenJ0giISvci3e2ViaJEMD7qrkKMg3IhBeHXvY77HM8ryXxawtPOTelWXeEdj37si/rWVNfZWz/xShZfU0vQQ4TF6xUNBi43PN7cJLNWTnXRqp4x7YAWvFGhwZH86kyZrNUWj/mqNXtan9YsYrXXu66vOF76gyaFT7sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930818; c=relaxed/simple;
	bh=3AqKub9vPQK+mhqBKVCTYPMQFI9oCXjoDsN/kdP3tZ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qvD3HpfD/59/NelJeavhmy7mahkWym8Y9urWuReWw4wUynSMT1uuNOeXl/7PPfn9cSyw+/9/2OIldp6CZPmpeBOxgC4rJCBjM2vjCYsRRW1XzEgp51YMWz9djx6VwVQoZ7c5XGwtf6xzWQOcuW1KAxXTliLM96LgxygURWLqtOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gwu3wvBQ; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4OBxkg29rRLudhCjOzT2ggq87swES62lrcWWrZBX/mf9xtXJOt68/aFDyM69cJQgHFKTPBtnDzaQ6+uIGapQi+UjsWhu4M1gFvoIBpu+5EZNsR3rxxpRAfsbdVuX3Qf0BSODw9dshd/GTUmZKHPsc60ZpGi3BBLLanmNC4SDhynt/SvOkL+6rmUTLp/AYBF+EQtFEGitfnxVLxx+Us07jYHjhGFleBp8Z5X8wTbDsgJj5chO/gaAyntuF3esAKvgbyr47wGpibAIq5F7rIHGEYu/ix7WHsVgi02c1XppulvSIwYlqR1AHHggLToH4iF8j5QCd86+qnC3/en35LdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROa3ymCikBWKU0nlKGzruqw6r16FCBQnPgkhPmhel3k=;
 b=Vtn+8cMIlEPGHkQWUdtkt4sBeD/5ydSzpaBC8k0HNrw2vwdNRDIYzW9N/ntnsr/eRSXJKzqSed5JAzIiiXfsFnWu+NeOZrjk+a6WSPaO5hPX+AsA1oD+ALvlf6XlceeNzUm68V2PNHED6A8HeiLMaoiY4aLb5opPKXEfuaUwaEF3ozpx4kVH6PaXLbreY0bqxLmNohBiJWrVz38gd73hRwBaYy5IHxdNWUcDZ2mSKomU9z3YQB3AYj5jpINsAWPs9K2/oqom46Yr88DDJ8ZKiS2FhhPZkvs5ZbTvJDGmzbKqQAi1AO9rGzvOrwCMWiHt4FYoFTlnml0BRc1aqMnsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROa3ymCikBWKU0nlKGzruqw6r16FCBQnPgkhPmhel3k=;
 b=gwu3wvBQzyXY+MFrDg7by4lhRWO+TkB85r7H0wQJvjuG8cbe8dQnXDnI1Euv2P92wvw+vlNPv1W5L5BAcrVewHaSigWmkhKZ2UQsI0hgr2y8LOtJxwuleXr3gVSJEi9Km7fURlzAyCXZgFL7A3gWH2SqAzs6UgcJiKN/bo8U0X7yx8iWVzsTUZrAuucOdSGXnssLAq6E6xDWgnOVsAl/4X7BjiWm1luzhyh4o21ns8NLj6X0OiFM4er17ciQj42yb6/r9OVatyHRYMhnFd5cHtnyQkFMHyjINBi2gDQDGaF8DkEvXGZye+jAargg8wrq6x/OKpKXB519vGIkHNiVKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:12 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:19:54 -0400
Subject: [PATCH 01/16] ARM: dts: imx6: add #address-cells for gsc@20
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-1-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930806; l=6956;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3AqKub9vPQK+mhqBKVCTYPMQFI9oCXjoDsN/kdP3tZ8=;
 b=Nti09u1bCu3bPY7+sBAYhOZ9NBRJoSaPgH+jrclv2LL6F5/GufYOf/m3nO9m5RbRAy46wHfoX
 za34wMjKL7eAE+l308X2u0p7yEyMMDrU2n77ynHzowSg6V9VIAuAp01
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 485c7a95-8f4b-4894-474a-08ddeb274903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHA1d3BUK3BqTmRqYWhYOFBIR3d1QU80UlVaWXhDdTRQUTVmRWFXRDZrL2Ja?=
 =?utf-8?B?clk2Z0prdnp6aWFjblkvdkJkZkltWkxtZU93dnJVRm56VnRmNUpTWEF6cjBn?=
 =?utf-8?B?MVY4WDF6QlVlWVlXNk5NVnJYS0M0dk5NMWJ1aUdUNytGLy9pcTN2MXBSMzI1?=
 =?utf-8?B?b3gzRCtVbmppanpTZ3ZGYjhJdDRJWDBhQlU4Z1RQeWhlUnJSOXpMcjNOTlVl?=
 =?utf-8?B?Q3VhSVJUN0wyS21ZUTZOVHNhOFFUSzJpZkJ3YVZwYnk3TjN5RVFBY1BEUEdq?=
 =?utf-8?B?bmZiOHc0ZU91OVNyem9qbkRFcjJSWjkydXV2SmpzdlNCS0p5SHhLNjk1SjFh?=
 =?utf-8?B?S3BVNEdrZEdhZ3BvRHJRYlVldWllQVVBS0pMQ0k3V0NjelJmT3U4eDBVNWl1?=
 =?utf-8?B?MmFTazROa0JyZUcrMUhpWkRJdTJzN1FVVUtKU2xJcXFVTlZzODZNV2hxTkRm?=
 =?utf-8?B?bzZjSWJQTzA5ckpxQlFSMDVTcXFNZnQwKzc0QlhhcUhXcmpWQ1ZIdWk1Wmh4?=
 =?utf-8?B?U1cwUkVjMHFGL0J6cTlSZ2cxN2NzOVFUYW1IeGlHL0l2TXFMUFNiNzBWanRl?=
 =?utf-8?B?WndQSlNGZkZicW5sWjRybUhDTjNjUXhmYWFGTVZIV2dySVY3dzFrekRZYzB2?=
 =?utf-8?B?cGlYYVZtQ2lHU2JrK1hLeVFjc3RNN2greEs1U2FCb3Q2NnFuY3psUkpLQ2hh?=
 =?utf-8?B?d1ZNbkNPYm1ZeWczRldWN25nZXBQamxDTURqWnJnd2xleFdrZTZtUWtTVDBy?=
 =?utf-8?B?QnIwUGQzVzRpNjBoOW9RZGZHWWtiTW1zK2tQK3BRa1lDSy8xOTNQM3I5Qnhh?=
 =?utf-8?B?eThvYTVKYk5MejBGU3hVbmlmNkd5Q1hHeTlBT0RNdjN1K09NdStYM3NBTzM3?=
 =?utf-8?B?cjg5aGJiRFpzRUpTeGFyOVBXMGd0VVR5UWFjUytnc2tzSEs4VjNhNE02c1NZ?=
 =?utf-8?B?aFoyKzliQ09QSm9VVnZ6UTVJY2RuTkNzMzgrRUhIODkraS9LTmNkSnZubWdM?=
 =?utf-8?B?MWhHYXlEODZaYlRLUU5jaXhqSFlpUWsxTU5ZRTEvZVZUWUVmNHFwTlMvTjhL?=
 =?utf-8?B?WEVON2VjZnJrdFY2cGQ1YXAxcTFVYlN2a1NaelVsMVNlTE5TVmdpM2lISWVU?=
 =?utf-8?B?WmdxMXR2SnBpWTlURGJPUmx4bGhBZUYyOEdlUytSUlAvY3ZBTCtVNk43OGNx?=
 =?utf-8?B?YnVhaVZIUG9DY2ZBMGEzOUV1c3o4Q2d1QzZkUlgzY2xBeEZUZTJCYlBQWGEw?=
 =?utf-8?B?Tk9JUXdRQ0huR2VJOS9kSCtZN0pLWHdSeTE4c09XbllzV3RCSWg0WXphdG1u?=
 =?utf-8?B?TGhkQ25SWW1CRnFYUFdIZi9sa0doYXJsSWprZU04VnY0V1V1M21ZMGVaSktw?=
 =?utf-8?B?TlZDbHJsUmtsL1dPUUViTTczL3dHeU90RDk1MVczdm5wdzA0WERlSENDVnJ3?=
 =?utf-8?B?L1VnckpUWkhiTll0WElRQ0FsYU1CSU40eEZqdytnL21VdFR5Mjg5eCt3QzhP?=
 =?utf-8?B?ZTJwRnE0RnlNRC9McTRvNmtDRm95aVAvN3BuMHpDWXpQU1BwUEh4Mmo5ZGky?=
 =?utf-8?B?bk5aQ2ZFcnZhcEJhRU14d1hDeS9qSFV4V1BrV0JBc1F0cEJNVG9ZVWszU0xG?=
 =?utf-8?B?d3FkY1VpRkxqYmVjVElzYkJzeVFXMDF1YUZFM1VGYnNHbk5lY3ZTbXkzNVBn?=
 =?utf-8?B?d3MxbGx6WnlGR1RtdnZhdktJWlovOEFuUUtUcVVuUFFXWFdZQ3hrUlFNamFO?=
 =?utf-8?B?Sy9KZ1prVm13TjFuWmJ2d1J3Y0F3cWd1eHYxOUEyT1dDbHB5WnhnbVJxa0Fv?=
 =?utf-8?B?ZWlQTG9MTE84NVJDTjZMOThiWGg4K2R1Q2ZXajQ5Wm5LeWd4S1BjUzJ0QUdj?=
 =?utf-8?B?cUtQWVNwcGFSWlIvaVMrdHA1bm5NUzFGcERtdGhVR0cxdkVwWHd4QkJQOFlq?=
 =?utf-8?B?dm8xSHgxamdIVlh2SS9IR3JFZWFwcFAvYVJuK0ZvMDFuWjMzOC80VEsxRWJh?=
 =?utf-8?B?c011bFhFSFBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRNQjFCM2dEQWpzMWJ3VjZSSzB4c3ZHWDgzWEdtU3dRN2I5ZEFWQTZBcXZn?=
 =?utf-8?B?NHloTHRnaVd5UWhjRloyOGJlblBTTHJ4c1NhSXAwYnhXWjh6VTZIbk1mVnAy?=
 =?utf-8?B?c0phMEMxMGMyMUNZU0ovUWR1cmFwNE9UeUcvTnUwbzRsVG51bFNlb2dFTGhP?=
 =?utf-8?B?aFpTeVRUeS91Zm9hRFBjSC9zMEw1V0ZqMnFvbWxqeTQrMDJkSFEyNFBwNUtz?=
 =?utf-8?B?alFlSEFOcDc0RzdlZ2tQai9ITUJNcVhDZStFM3hOL3hERXpBdHVJU29iTmZ6?=
 =?utf-8?B?NWJvRVdEMUJLNkt2VTU2d1FSYkJIWU9HK2VjR1RDcDZ5cWM3UzRVVUdDS3ZO?=
 =?utf-8?B?ejJYSDI1NFA0ejVheG5HMGUwWnczNTZ2dXJGSFNZQ1JpZ1RLbldkQzFvR1JV?=
 =?utf-8?B?OHR5N2FBSkI5Z0xPWkhqQm1LVzQrWDViK0lXMTdmSmgwSUVrYk5CeTV0ZnVM?=
 =?utf-8?B?UENYRkxQZUYvMjBBZXBTcVQ5d0IvdmZ6cGQ3UzV6ZW5XLzZrVUxpSFpGdjdW?=
 =?utf-8?B?QlVsdVQzNUxhakR2R1ZqbVJydFpVYXlwODNkZkErMEdMVW8xRjAvV0FiMEVu?=
 =?utf-8?B?MktDNUVJcmNqcVhWWGNHY01ISHZzTk9nYndETWZaS3NpOW1ydGNZWnNMZ01h?=
 =?utf-8?B?ZDNXTkJjUitJYlk4K2hEVi9jbCs3N0c4M2VRMzRHR1k1V040UXJCeGpYK1p3?=
 =?utf-8?B?UlV4a2JTSE1WSWhKNU1POExqZWNyMWJqdWlUbW1zeHY2QlNJRzJsZlJJRTVZ?=
 =?utf-8?B?eS8zMkhOaUFSR3M0T2RIZGRid042b24rS2FCODJ0QVlBMUNLaG1sRkNMNmhV?=
 =?utf-8?B?QUJsbW1tUTBVUXVNaFlKT0ZpbEFGUWRwSXprZGZFMWpTSnBsTHlyaEpNSU9n?=
 =?utf-8?B?cTcrdEJrWUoxeHp0akw2aUcwSC8wYVFObFVsWkVFc0FpbFI0YUI1cnZGTGhM?=
 =?utf-8?B?VkRJVHpsOTdueDZycUJNbW5xVjRxT2pDVVppbWowTnFDZHEvTTJXalBCSWxQ?=
 =?utf-8?B?L0pBS2RsT05kUWpXTTR6YXE1NHNrOWRJbHlKRVU2c01wQnRnQzlLRjQyRzZo?=
 =?utf-8?B?UHpvSDNsSGROY2dBZ2dTak0wK09pMmR3Y24rQUlJVkZHcTNFb3NPRjM3RGZp?=
 =?utf-8?B?Q0hzRE9ESjF5b1RwbnRvUkRtSzdBdWtjRlMzOFEvNVpDQjk2ZmMya3M3OHo3?=
 =?utf-8?B?OUREWlhmQmtNQnBPY0tLVkhzNjVSK0cyOVYra0JwQUZIdTg2YXVxcXY4RGNP?=
 =?utf-8?B?aC9RSmlIbllOblZGbXQ2WTF4TVhvdVNqdS96U3FLTVQxZWNCK3pPa2NNK016?=
 =?utf-8?B?eThEQVBieWd6bWJIL2ZJS09oejhTVjVRSVJlSHpuOG5mbHRyTDhMSEV4MXZy?=
 =?utf-8?B?ektrRFg0c2l5NmJYbUsxRFlUUU12b3JDb3V3cEJBZ2I1TWYxU3NQbXc1NTVG?=
 =?utf-8?B?V0M3cEpydzVTNFh4TDhQcEd6YzNmVmNJdDZONnEyUGVUWHRtWUlBRW5XWjRy?=
 =?utf-8?B?SERFeURhdllUd0p5MldZTCtOOU03ci84ZmlRbkVBdmhnckJsbGZhRGtlTUxo?=
 =?utf-8?B?ODFGWnp4bS9Oc2toVzlYamxPTXg2SHJTcmhubmRkNDVFL0EyQzdFSmFMN0hX?=
 =?utf-8?B?T3FWN28vc25HWHNtZzVxNjJnR2l2M1JjT3dGYmp4R2IyRXBCRjhQWVUvT0Rw?=
 =?utf-8?B?cjlvQ05HYTdIbjl2Zzc5V0dKczN0bnJUTys2OFZDbFdSb0sxRkpFUXdSOExE?=
 =?utf-8?B?aGUwTjdpaFV0MHIzREcrRHc0dDBneDN1SFdpclFLazBXeWUrQVJSVnp2VW8w?=
 =?utf-8?B?VzlMVnlONlFkU3hnaVNndmRWTy8xZlRUb0lPT2JoN2JkQTVhS3ZNOTgvNi9h?=
 =?utf-8?B?R1NneDVvc2FFN1pMQzlzRGRkOXN2SlpDSGNvemNRVGlTZmxrQjBTa0Fpblh6?=
 =?utf-8?B?WWt6ZUZHY0hTN3FTOCtQZzhIN1ZGTDNraFE4NHNYRGtFb2MwU0xFOGtVNkov?=
 =?utf-8?B?TWZIUVg1bWlmUUxoVjNDUi9lQ2VxdmwraDZ6a0hpQUdsMXlBYWxLMDQ4VVBh?=
 =?utf-8?B?bTdkY0JjSXJtcnFuYW95bmRLZ1dhN2U0MlprS3ZYTUZYSXVmVHlSTUZMYWxN?=
 =?utf-8?Q?xbglCLYQ0DCDmD2dxssDhCWn9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c7a95-8f4b-4894-474a-08ddeb274903
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:11.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SywbNMfxDjipJm+p7MQKj799J/k8oehhJ7XA4FVuUQNF4o33U94U/E+16lQTTGBlCpuN6vb065w5Fh9REdwxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Add #address-cells for gsc20 to fix below CHECK_DTB warning:
  arch/arm/boot/dts/nxp/imx/imx6dl-gw51xx.dtb: gsc@20 (gw,gsc): '#address-cells' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi | 1 +
 12 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
index e75e1a5364b8544725ef4d57fbc178f310096cb8..c61e70469b66003c1fe62c75dbcd9608a11661ea 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
@@ -156,6 +156,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
index b57f4073f881e3c5c47f71793d5307a87747c850..4f66271bf4a4624cdc6403955022f8fdb69a0c4d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
@@ -230,6 +230,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
index 090c0057d1179efb0e0224f641808e01e3c652bf..cdb40046bd7e58319c897d45c74c9e9c0afe9867 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
@@ -223,6 +223,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
index 009a9d56757c8c11f22b991928547c281b25e866..4db5ef4a3e563dc0889f9a21fffe3818c74d499b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
@@ -179,6 +179,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
index 77ae611b817a4c18dce02507e9569fa8223d836d..5d5ef18a05936eda6fbd6f21911e933d3a17959e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
@@ -146,6 +146,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
index e3b677384a227dc04b03e609af0b613099455bc6..a9dfa7cb69ef5872ba6601286c618aef99de21c5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
@@ -142,6 +142,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index ce1d49a9e0cd5f28f5b95375e895817cc0be19f0..11483daa59fc2c1bead0cff5284415a158b44136 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -254,6 +254,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index 50b484998c49c3057976bcb17b1d05a782a237f1..c48dd7d06bce7fc86e2ad4428a178b9d572f7f86 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -195,6 +195,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
index 3125cd04d4ea66df445fcdbdec6c5c9a0da58160..2d24f9bc4106ae185ec8cbccd866089278218879 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
@@ -260,6 +260,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
index 955a51226eda7566e17bdb891bf964badea8000d..e214a5f2f191b68b05b5101dcc5917fe830845ef 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
@@ -156,6 +156,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
index 453dee4d9227f0fbe4b664699240eefa379eeb4b..02bfec7af9f2cc752534a69ccd2926cd8747beb9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
@@ -165,6 +165,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
index 82f47c295b08559c69129fc073565fa6c24ca33f..0dc239d4975c4583b22c0e38b3fde265a3198888 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
@@ -141,6 +141,7 @@ gsc: gsc@20 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		adc {

-- 
2.34.1


