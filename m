Return-Path: <linux-kernel+bounces-799745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C155B42FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B445188D645
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA831E3DFE;
	Thu,  4 Sep 2025 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZG+uOmf"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED51E521B;
	Thu,  4 Sep 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952525; cv=fail; b=jcG3jHTyvRmnkwqHOQsdXJMJyc5B7slVo+CRt1+nbUAPYrherZw/QPtrmzmgQs7Ec5Zdtiqu2NzbZdIsvCNRK8/w80EyFLcBlt6buJL9osHqqAhWn+n6dd+x5AG0fFY9L2Ark3giXwsFa3WM3blrisVM8jSDerRZ8ucRodN4Jp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952525; c=relaxed/simple;
	bh=OJrvOymifW8tPcCDlt3jcyosaCxFw9/6cKj6g5uOF+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RD/XOxm33KKcKlF8VnKvXlOaQdrrewrqMmryJOm03ddbMHQJ7GDTpTMtGDWh+WEgi7OF0+1s7QpGi6yCiZMeMmVcGSwMQChNx80IN6AUzifssaeH14rxQMqCjxSzO5wTJlm1Hs7pdDDKR0Yrp2zbtsMt3nAQmaepsixOGc05dhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZG+uOmf; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3m7M86MdMgjYyuJEWVG3vbGGbik/WHYnCPbDHrFRreuM4aPDaI6GDwwaXoNEHXuuftDiW3mUyDP2bS3+2++n9/FAq0EkeGRX3sbHThssk1r8iiWJx24TBPEWCc+vxsaLWVcu80cCdzWNB1MRxF5H2chXmFpdSKnyFf/BUxQVSfycUNwPq0ivEefsGRFr4ZdY2OPHGVwohU7QcpkH3LIMc9PjUh3wNZFA343llbvrtETaowOBPf6F0jDPa60xODG+B3b0NW6MH3PP+Fn8I4KydKUXz+9uw4YIiAaAWO7EJR4LMf29y5O1oLLGOUW+LnS329E5z6X6V5u/x51a4RDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbGBZtJDk7qC+hulcRHjxbAc1kMKuY7njWVb9x8AF10=;
 b=AWl7FC1AVadG+cSwxpKWenvZ+KYon2kuy+8EvhiU8N67sVORZXKZtr0tZwBfbtft0eoiG9WWWdc/5knmB4krrw+FNVmPlyWxwXsFWPoWkLtcp8/5AqUGRuhY471k+TuIImQyrCrsYMu5LDdJiFppneorcQl7tgzbluVzKDlnNqs6v3yakHUoK4yxDiVgObLPyjaCCHV8krasEQWCQU0lX+493tTVwSqgjA7JuCwU2xzt1FVATSs1xaKlQ1ilZteIjj6HN1qgghvmoeAOH/YijQJjqPXwO/bNlRnFNdmgYHWv6SuknXSvBKWOLzgloi3VEYZCe9bOBaBaLKpc2+2fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbGBZtJDk7qC+hulcRHjxbAc1kMKuY7njWVb9x8AF10=;
 b=mZG+uOmf+IE3DZsQVPeRKYuzqsXdP/shnR/ALxL1xML/qnTuLQmg+DvNFFr6oQYf2sx/0Wtc6VbKMdrEXG1xntYznfauZR/xmbKVdj1GktOTnc4KZwCTfyPvpOiR/aF75900C699kFSLDtGH5eXvE+je6DYHKEKyCOmb9595CMYqeeupHleuj8NX0ty7/VqADyCz9NviRX3cInj6k4k+JhrdqyVJ9pAR7SkzWEZTiZaH6cVsFto9OSU9/hvK0uQ87ehpKfy9YEhz9VxekHnK29HNI+aHjL/efxwDm4oXGKMx2uvh15bQZldkTPLirrTFEuIBBD5SvM1Wr4eFHoAbLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9509.eurprd04.prod.outlook.com (2603:10a6:20b:441::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 02:22:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 02:22:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	Frank.Li@nxp.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx95: add standard PCI device compatible string to NETC Timer
Date: Thu,  4 Sep 2025 10:00:49 +0800
Message-Id: <20250904020049.1397308-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: f17a12c4-3a7f-4511-aac8-08ddeb59d40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8lYtSc0ilKTK7WH/Y8I7wi9z2OC116gY0KH8z6688rboZDmSSBHvDECLGBtk?=
 =?us-ascii?Q?dy5X4rOo8TBC1JgQz++aVd2pBl3Ia7JdSRbwS1bBnU/wf+0a7kSykoMfk60t?=
 =?us-ascii?Q?hUXMYI67+WdC4YnjUVLK9iE/m6PJ6Gae+1hE8bjO7YvGkymWZUZDtgFvIwpi?=
 =?us-ascii?Q?c5JH0In2I6VLZrE894d1+1sH6pG4RGkxaUoYXfZyiUiNBffYnTUHywpJ7v2x?=
 =?us-ascii?Q?dAYfvjf06HqTIsPmNxe1k0G9BLptb9zATdarSY0KSf99Y4rmBVI8v+fkz7yP?=
 =?us-ascii?Q?aHbL+UAH1DzLsXhkbK4EcOSBNIPlE0glyT3o+6Iy/KJqwzodPQOKCk9UVTBV?=
 =?us-ascii?Q?Z024JnDZjN3O6ha0NGka2+Oe1FQ21CewaFOT5RoRNtnnPm7ryALhI4EklPa8?=
 =?us-ascii?Q?/XTDvC1uh4rvdLErTTqTNdB/UFpC14iI6WmoV5Q2g7UePck5uHhXAlk4svlt?=
 =?us-ascii?Q?k0CJvPUwI3FjVLlkLvYtEbnqjuIrbb2V8mwRTeUh8PCABBecY2f6nSzGFVvI?=
 =?us-ascii?Q?uUirtjUx1KwPnQt9VC1JDRGuQ5VKbugdRfv1oMVaXbJIEB+4mtckmAwWqY9p?=
 =?us-ascii?Q?Mb5wg/c6yLnPpTHOqCHphAjEWw9A3vETLAMztEVpfRVJuuIAQVheDYU3IOrf?=
 =?us-ascii?Q?FHFImtQvzTebtgX4Aj+Up8ixtWQIkrC7UVVUKFeG7xjopoSjRlTRVkOXalQq?=
 =?us-ascii?Q?gzly6bCb8GAhUDOk3JdSoO8grANVwvpW/8AZJx2x4YujQoqy499bmFSTdEVH?=
 =?us-ascii?Q?chv/fRitcuUPe7qtCbmCuWwr04w1pVLvbePWP/N+oMAL3vd7CDdoFw4sG0Im?=
 =?us-ascii?Q?xC+DIhsr30Rr1TZccqaorb+rYOqy3JiRCjm/jEnx1RH3xuMYRJxji1XhxUQb?=
 =?us-ascii?Q?TH4WhyahjNKSewrI731ta1kzCJMJYAM2dDc9ZIkkdtMnfhGPalG252PSiTup?=
 =?us-ascii?Q?tZ5sp+gqnkVTrs5NQOgYVWbvKp/JAlNbq2poM5uD2CimSbx9wQI0UycZwFWN?=
 =?us-ascii?Q?agLJlff+H+jAyMsqLav+9GIibr1bOLyb7okskzH5017zFaQog81wzc/afafq?=
 =?us-ascii?Q?Am2E0OVCCzvVYrhdhoT64E7pWUCupbn61heLBvzGSh1xccTembHFxI1idnPy?=
 =?us-ascii?Q?tG8btzeoDegnPQloNc6j5+9Co4sG5kZ+LuvnziNc61iJx6AE9KoF4J6Ak6e0?=
 =?us-ascii?Q?ppjADcnZwC9fA1fecH7NpHrp+c2cms1KgUfIUDvAN2jZ8avIwaGClPW16Tu/?=
 =?us-ascii?Q?6GyVyq3SdZzB4VwRylQth3axkSQE54PtYaEFVNFLqmBQpRI6kzWxWXN5jqf/?=
 =?us-ascii?Q?8RXrp5BHpht5LIEa8sVY9pliKbrgRGH4sYGKdKgKtMyOYG42MbALpyru6FGU?=
 =?us-ascii?Q?0wiGLdvSZuofjGA/kq6yAoA8GwOgQc4vfdHjt1uSleLM262FMB4X9Svcmjlx?=
 =?us-ascii?Q?1oMs2O2vxniDxEkTm8mI+6hdeOG7kGTXO8KVD8RlUt5X0xHJs8qeUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wNxIG7FpuGnvJq6QuT5PMdE+fmm1iihTtmXPu7g3PiWTx8Rt5n55bv8LMXXE?=
 =?us-ascii?Q?U8gszi6/FLz6ayks/bQ75Qo/E08YJQMovBTfXLDaUS+I2VIK5z4h9BHtWofZ?=
 =?us-ascii?Q?WxJ3O6V68pcyWwsnoU8lVIJx47VAChI/VOc+UpzHvSFTWv9BDhVmPTqzZk8y?=
 =?us-ascii?Q?Zl++gWVTbMGkZ7IZqF2xgTU51/2PZo4wnc4ToHtN8OjuyIB8QN3jSJV1v023?=
 =?us-ascii?Q?QQ9ejy2IEr8uarncqf0pfH6O1fdaeHoY7Azz812DmGVeHVOI7kzIgJdqQCYG?=
 =?us-ascii?Q?8kIhBaqMEJfrRy9NScBuLpwcyiZR7BYQqpBo/W22DCjckjlDxWUBrPp9xkgL?=
 =?us-ascii?Q?Yw8Y5vXSyoeo2gAUl8e/PbZsnZpEucHDVP9Jl6E8U46az4P0C7MWCT5YRaOh?=
 =?us-ascii?Q?4wbcbkz/Cdkc1QWantkh4tEGXfKQq7TgZWtxjKo4Sw8RwU626NQsMCZjfoZj?=
 =?us-ascii?Q?8k9LKWg4RzljQLVFlqsYkMltM0qI1Y9RcJBfSnb0YhOsueabfzVQ5v3hBfPO?=
 =?us-ascii?Q?ZrNJbMj1fTjM5kuzBR6NmH30NVgE8oIGgIQWe17MwExnO9HgKgFvzIwEpNij?=
 =?us-ascii?Q?MyOVx2/8zChGdzNed021RSHmqH79vEBmxlmWJO7MN1Rhcc42P+wDwvs1ec9l?=
 =?us-ascii?Q?MM3QSgb4+2VI1H/VcBJHzyCQ5y/4wQO1uprEgzxwYOCcJmIHe0o7pLb06Z7E?=
 =?us-ascii?Q?YtJ54b/W9vAShD3wCDR+6t9g8uz4/Fe8Rcxu3QAG/yiEI3zvDQWXDaIRCDFz?=
 =?us-ascii?Q?Yt4rcUvow1HIf0tGFOIH3hgn7s6et+OPp1R3k64fV3FBTf+ehl8oxwW3K2aT?=
 =?us-ascii?Q?9HANr3i76eKjBuxbdBAvQA+S2GiGJNmxf9ghjNfIewUcDl/CFMaJHZaZCcWc?=
 =?us-ascii?Q?Lt8iVl/HdjXH4TIEOtoIg39XmU3jAP4jJb9r+7gQeENLAo8LWvCzb/IvPn7y?=
 =?us-ascii?Q?EgKWtitkgaMFIBoTuJ9JWbjfIKcONnEGvf4hU0EZB3CCGuJ2ZCaaLhk5Va+X?=
 =?us-ascii?Q?2sC+AK0i+tHkci2VsoyE8RiPCPuDauuCVv3F2+qj/pO2zqIzBaNKuCBkGUUa?=
 =?us-ascii?Q?7qUTCwohcupg+LY8N6HJ02CxeSLrYRnLnFJWMyj0wrHh6fsne89n9AFDRrbW?=
 =?us-ascii?Q?s+8ABH63IU0mP/kIYmSC9rT1IvUu8J55fgGtwHuYpdplOTOIOByAku+vDdne?=
 =?us-ascii?Q?ykOZss6ECTrCELJ16WwFkB7ADMhgaacjnthjj9XFgZgXBe/B5puAL5MOMm1J?=
 =?us-ascii?Q?qHIos/L9+Tbt8+Hfb8TJB7LOFNeEUkDs1touJP2W4VM6LqX6f0HoLr8l5Kpp?=
 =?us-ascii?Q?hNPsxTKCbnz8guceXmnpRJMfb8I47m2sMHKnDKQXT5fibckYOiAzCo6G/1kR?=
 =?us-ascii?Q?E18f4dMHZFvBRg7DtNVw5aDu98eUjRsz7XXEH3dExWOLgYjiU+SDwIYEBcw4?=
 =?us-ascii?Q?UQs/slzH+ST885QuzBvfCPXk+rYxGJDH0GZH/ewT5nQo0wzvqRFkKvNepJvw?=
 =?us-ascii?Q?QWoUsNEAVs1zRWMdu28NYW4OUJjdVEDWkIymZ9JtfEVrbs8/zZ2aSw25pnls?=
 =?us-ascii?Q?tieJc+pKnboycr0+07GC57zHjtYB5w2Pii8lcJUV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a12c4-3a7f-4511-aac8-08ddeb59d40d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 02:22:00.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgl2ZmsR8xaUN5LxrVwRZNbTi/YyVtt6oFPKuVGqS/qJOWifuPIC9G3bCS7I4+HoVChkFAX/l3fNKXwckJcd8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9509

PCI devices should have a compatible string based on the vendor and
device IDs. So add this compatible string to NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586e..605f14d8fa25 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,6 +1948,7 @@ enetc_port2: ethernet@10,0 {
 				};
 
 				netc_timer: ethernet@18,0 {
+					compatible = "pci1131,ee02";
 					reg = <0x00c000 0 0 0 0>;
 					status = "disabled";
 				};
-- 
2.34.1


