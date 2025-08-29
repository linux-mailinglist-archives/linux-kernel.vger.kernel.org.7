Return-Path: <linux-kernel+bounces-791736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562EDB3BB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F6746860A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D21314B7E;
	Fri, 29 Aug 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TvHQVmRY"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8EB30C60A;
	Fri, 29 Aug 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470130; cv=fail; b=DRcDxqsJm0ri0qdVWOVO1xuckcm4dyfRApGdbPBtlYNQprKdorH0/JkJEnE8Ps2XxzL1nXwartcAN8lzoUziyiPBQJdSnF822gnOLVOA8kWVeLgsj9vQH7PkBlL7ihdSdse4ETFZ7vJoLJca7FgwtgnlxURomXRVQwLcssziUiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470130; c=relaxed/simple;
	bh=0gJaM3KEWNjZvTJJL4suKeEv6tx9wyq2jnPhK4vfdyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXE2ZtSPA5rORWR5nNqvPYuJqQ4qrksEELCXFjstFVgbT56P4KNSZPhGlMrtmhSHtJXFCdjywzsZaQSk/st01AdDoYP00ulnvBGacahBq5q6dqgDGkXCKelgoFHkAD47f4aH7GTCOjLTMIDmJ7F/nQFZ5pQQzjP7lm4RZ2D8lX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TvHQVmRY; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovwGGl9dCcCfYKpdwkTRtrSyVsYOP4MDjjjMyhYmdqxzt6C+6EeL0JuC83oudr+GpLh6V6p6mehADAy5pyt3cGKa6iUcKmkD3P8xxM64itmXooU4DnH2bEy0wNacWTM/bBCQ4OPvVaPNGGm67lKZmLfM3niFYFUcuJKdof4wIp3BQbfQQyDSDyT3sM5aqBT5QXl52KIp9xdTmgCxoNSzQFHyxfKBVWh6aLvbypYPP0NakQ2GxFVY/u9Ifawm6WXzomGPZUrhCOmQlbv5shFaWTXb8uEQtQ347plNcGTmdTSlO+SmNw13uoJoyQSltFAshKZWLaNMjXyl6xTHxBk3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx+kBNu3qEkV7prHxTjcI9oa/dRZ+TFcfCNE4xjEqho=;
 b=YQ7/E2CaMYkKuumzcPLyv9L6cAOfeDVW5Sf+Rgz0dlXV8HFBnId1+pcD1Gnon8ggvBSQD1MWJ7nSmdY1H0OmiONOi3K7sF93VDJV+e8U/z6rXKoqIPYNmdU/JFfnKiun7rsZprxnOKFL+zu9rOZsoMr9VKYhi40oblJ6CyKA/pAeGprsVS7PSTBWFoKYRDM9oDXzCaqVVNiuof+27ybmdkZCeM460+uUyHNa10dbuFzjSYztNnYOSusTzfU6jaoX5oZxobOOJs8KuHnp+fTHhVH3uXEzMpAJgq4ErNs1mrLk7c0xFeVQRaHLuasBuqtr7C6JVp8f1usgRXvLP3QVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx+kBNu3qEkV7prHxTjcI9oa/dRZ+TFcfCNE4xjEqho=;
 b=TvHQVmRYfxUflFDYff8NyS/zas27aRQQG/EllMLRrjjhpMeQ+70irlxO3BUdhevT+wtQ4WxOv/7Kw3ukutr1zT69biSnd32dJOvf7jWhiWlHLGxnMzuF1zYBcPVPdQ+9PHOuzXqWKNg+Qr/2/+Visb7isqdSnM7vN/afgT3pbe595N+PcXPvT4lx9Nwst3qDvELIFDDqQbtJ+Zu0wXMbjnOIeJIM4odrLURXoowAdcwfnPPxaBSjmH6gDmCU3CHPkuK8OBFeZZXfDaMB1s03/rfs4drYSOtzDpQ8yIJfVQK+d8UmlzdQG3ZODaSh9FtcYuZIcMxb5yF60eiftrYe7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9637.eurprd04.prod.outlook.com (2603:10a6:102:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 12:22:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 12:22:04 +0000
Date: Fri, 29 Aug 2025 21:33:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Brian Masney <bmasney@redhat.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: scmi: migrate round_rate() to determine_rate()
Message-ID: <20250829133314.GA30579@nxa18884-linux.ap.freescale.net>
References: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
 <20250829100903.GB16625@nxa18884-linux.ap.freescale.net>
 <20250829-fine-tacky-sturgeon-0ba3c4@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-fine-tacky-sturgeon-0ba3c4@sudeepholla>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: cabcb72e-4947-4772-29b3-08dde6f6a983
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mpq3v/jXfpq6fOgQsD3GqztpMPBZbW42IUNyk3jtyycr/3dprZmFeY3BcBPa?=
 =?us-ascii?Q?k2szSYAMT3FP54aq1wUuLK01BWQeyvtqYWsYBhCtLh3foSP+fVlJxnptR1Au?=
 =?us-ascii?Q?uFMMZSuy2y4eBYIEoBe6R5aIBvKGcu9TLcQStIA5+Odao5zKeCYSepHB4W8P?=
 =?us-ascii?Q?h5rYyUf3ejf/DxqHcTnyfiizGiw3oyp/ibus4K+tDhoQSvGWz3MFesvXYbXY?=
 =?us-ascii?Q?TziQP1psQDodzkUsNDGTnhrpWKt/TVZIXB/A71INtyRJ8B9XshZUyrq6WmT3?=
 =?us-ascii?Q?o4Eye+Y+jlsC9Y8m7vBwBHQLoB9osaaNk2UycaXOvHMD5BXajhRSfuj0z9Us?=
 =?us-ascii?Q?3gysxjP4BNZg34XSKyVviaTjqXT5OeQost6DPSzqMrDuudMBqiO1J/ZYabQi?=
 =?us-ascii?Q?U75dcggYTmMkaoiqPrLhztKWHjemZDsm1EmSnQy+5A7nzOZ1WdWMDQVlNvgD?=
 =?us-ascii?Q?yDSbRi0jNkL0jmnWuQdI3n3c0vMFguDguXoyQ8E1pTNI6jJv0fZQRhvCqMmH?=
 =?us-ascii?Q?byRSNkkhTh9PerlEIXoBaJe7lgD1bOMf0suFcaJ7CgouZT+H6UVM10yJVbhL?=
 =?us-ascii?Q?PAdGeqB4lZlYXIWY2ZOOPuJe74z7B1Kd+4kSZeNIlda4qmAMc5O85me4B+DW?=
 =?us-ascii?Q?YzCZ80kRUzOQmQ39gyMXUjfBDm69294XJa8SBuNVBFr4b734W14mH4WVQZcl?=
 =?us-ascii?Q?EGApCf9sytvxsuLgGrStWyPywhgaPwU6miSYTA04NIDsIoAoOTlZryG1/NcX?=
 =?us-ascii?Q?91tmucwjwF4cI+RBLGL4vxF/uCaZjABwXT1qJUvH0M7ZocUROyRWd+lN7vTz?=
 =?us-ascii?Q?A6yHK6wEy+q9pf3jB0m0SgG8j1bIq3+tL3J//ukZAHV3Ltvg3Tssxntjh/BA?=
 =?us-ascii?Q?aGpYwobtB1ZT+hzRrGpdVPDvGJfkiy4EQ3HVWOQHI7rtVuS/Qm5Us4IPcTaf?=
 =?us-ascii?Q?3UuLlSyIP1duoSHAivProTivpGleWeDENmqklZVFqyiOBzB+B90EZBMVN6HP?=
 =?us-ascii?Q?FNYBjkzPDrlXCgb1HhFpX7QdIbE6S6YYxNBIbjCFDHiD9FjzMMILr+FWeqSw?=
 =?us-ascii?Q?TOf1i6Ojgp279BxXuLCHrrYm+374kenxJRRBm1zu30s9Wb6ZNt3cKV9dY69g?=
 =?us-ascii?Q?EWkWzlG6EZdN1f25zgWn1ARqiIAAtCc+QhuJEFQzJiPa6e4qdPskilZy6qWs?=
 =?us-ascii?Q?DUYE3POCaYKdRJEZ9ga3ucm8Mo74fDZKoxq++fVTdX/+wSnSElez2OP007Wf?=
 =?us-ascii?Q?QUm7qNKFHWJkr3NBgapxKZxJPlZf7ZweT/7kJKfMMYGRJhLpMr+nQUIa2d3G?=
 =?us-ascii?Q?unm7oZbvFpN76tAJg7vOuew/xrudeG+PRsqFy5SMBsIRA8ykLSznnnr2cBxX?=
 =?us-ascii?Q?K/uUjXDItGpnGyY7e0bWCm869SHQGDMJRpa5n3cbjK9FTZCs+oIUfgSNhzQk?=
 =?us-ascii?Q?V8NO2H3b2Xf3kgmMNn9BTOrZ3mwCwT1jPD4qJWp+c4+Uvxx6hjqNAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MciZzCXg6HmTrR1w8BMVpBwC0OaR4NQWXcFgXG4u+Mlh1Uxjr0IMgTpb++co?=
 =?us-ascii?Q?LerU1e/OK2j9CE8ucBEZwuX1g4PNB/CxCm+uv6ukS9V7HeRyGso0mzR8kIVY?=
 =?us-ascii?Q?0KUwgFUT0jG3Ga7HoCC8Hb829/TYldDxBvb4iuh56/2H+G4T96a8GWrHmmxi?=
 =?us-ascii?Q?hBmatoSiG8VWJXBdDAZbDRtnks44oA81Lj2l0ZmlpjxbWTfRe/gp+qFJlA8B?=
 =?us-ascii?Q?1omyQctEROSSZag7UJvMpjMlFK4otdoxTs/YUHaW1WwvsItRh3Uf64GIx/At?=
 =?us-ascii?Q?7utjxJ+f2ooRfVP4cAwu/Z+p1t7QxP5SizFCCRirxJ2/IsKxurthh3djVe2g?=
 =?us-ascii?Q?sYLVmWzFqFQOwcIWrxXISxnaNasaIFjdXGzyyEl4HEtz3k/mMYrl68btpK7V?=
 =?us-ascii?Q?ATKU6jKgi+gh3mxnckUxokM9jY3w4IjkIabxl9WTL1SiGMRkTIhWpoYqF/UO?=
 =?us-ascii?Q?xt1bhfPTx2tgxugElwCTTzx2dWbKLrr3msKSVACWWIAxzgEoSLSPO6ATGCTn?=
 =?us-ascii?Q?E7tjesw+6eYezdEARX84VRzX7YQeoH/1xMSXmClFDhbXXXL89kq4P8a61Zhv?=
 =?us-ascii?Q?HoQWQ5i/QaaHyVLMV0BeyIUz5io6cmwThUn1WhJi3KqoAUy+2ao2NkkQ1oTz?=
 =?us-ascii?Q?pBVkdEtgJ4iwciJsE6M767G6osM7J5GldIROIYYlu5E4GCdAoDZjhsc/mKCg?=
 =?us-ascii?Q?nNl0A9qxFPupVZOHaZqbv9kHGYXn1/Zgs/9jzeKdEDomAgcX6sUIbgTaDPyp?=
 =?us-ascii?Q?4BJxNFSwlAVTVMC34BLcmEerskI1YN4Nj6uABOCPs5hYDE5R0HzCAJZMBAzk?=
 =?us-ascii?Q?IKzstPHFj1k2E+09FUzfw3J7vph2mEfoFeMV+7NslUzoEwqdCJMG5xntb/0a?=
 =?us-ascii?Q?rlzpqEAvTFmpoV4s1S6rIbaTIlb9AUgYHCSeGqUPdIhX8uVkU2a6Vtez+xxL?=
 =?us-ascii?Q?nrYkMayssxZLez/IBFET9mSRMM2s3IZh8DiJi0AbrcDtX8O8wdli9h2H+Pe0?=
 =?us-ascii?Q?vrt+mywDn5AQ98aQ5pZQT93cffDV3UKQ4AyJbTViWuiETmMDOqTVEzVTXUUO?=
 =?us-ascii?Q?kFUA5BtZ/oim3xF7pBnVQ2Mg9eUmFciVzS/bcdoHT/nNVNGEMiqQJmDpSr7X?=
 =?us-ascii?Q?McmaaUhW5XNb7gi/FzPrlxtOef4CsOCAcjtBcQl1GZqGlZqEYWwkN1oAAvMr?=
 =?us-ascii?Q?cLoXy+0iNwZzu6Nvi6gHhcacH4VR9Rpn/v7YdMooWJlq+FFMImibIMbSPQtH?=
 =?us-ascii?Q?FUEfNIyXPaGNaXlMQaDoq6odkeFfrHTdd+XRyV/oMJ28KJ0rNOSob0FNPD0j?=
 =?us-ascii?Q?VFm+cILlX2X8kqNBInpOrPpnA7+mBd42EIsejC/L/MqsocyclzWUBAVtRQii?=
 =?us-ascii?Q?1Zi9Y2+LXTKAbnWPaKlcDbGL+kIox8rSf5V9pZYFY+/n8zbnr2gFtux5JvIv?=
 =?us-ascii?Q?HCg500RgPmvPX4J1QctlXf8WazEZ/IS7hidm86z9VvfJNfqQCrXitGyLNw29?=
 =?us-ascii?Q?peOI4GjH78Y1E1vFQMlMpaJf8xZrjsi6+URoIj7o/TNTaNfJ7hsP5guxJbou?=
 =?us-ascii?Q?9N2CDmnJx62/MUhM7ADV2kiAPSfvUUr8DZsiwoPA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabcb72e-4947-4772-29b3-08dde6f6a983
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 12:22:04.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cl00MX69RYtritC00xcSw59jI4rP/+9haVJb6uUESiqWJooaaHChlfs7JO82Bf4XkIF1E1OtobLMn4yIG8GZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9637

On Fri, Aug 29, 2025 at 10:59:15AM +0100, Sudeep Holla wrote:
>On Fri, Aug 29, 2025 at 06:09:03PM +0800, Peng Fan wrote:
>> On Wed, Aug 27, 2025 at 01:12:07PM -0400, Brian Masney wrote:
>> >This driver implements both the determine_rate() and round_rate() clk
>> >ops, and the round_rate() clk ops is deprecated. When both are defined,
>> >clk_core_determine_round_nolock() from the clk core will only use the
>> >determine_rate() clk ops.
>> >
>> >The existing scmi_clk_determine_rate() is a noop implementation that
>> >lets the firmware round the rate as appropriate. Drop the existing
>> >determine_rate implementation and convert the existing round_rate()
>> >implementation over to determine_rate().
>> >
>> >scmi_clk_determine_rate() was added recently when the clock parent
>> >support was added, so it's not expected that this change will regress
>> >anything.
>> >
>> >Signed-off-by: Brian Masney <bmasney@redhat.com>
>> 
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
>Peng,
>
>It would be great if you can test it with parent clock support on i.MX
>platforms just to be sure this doesn't regress anything.

Just gave a test on i.MX95-EVK, it boots well and eth0 works, 
the results in /sys/kernel/debug/clk/clk_summary also looks correct.

Tested-by: Peng Fan <peng.fan@nxp.com> #i.MX95-19x19-EVK

Regards
Peng

>
>-- 
>Regards,
>Sudeep

