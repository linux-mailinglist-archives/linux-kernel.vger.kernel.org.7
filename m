Return-Path: <linux-kernel+bounces-738917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0CB0BF07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215783B5547
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBC2877E4;
	Mon, 21 Jul 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdGt8B6m"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF3286D5D;
	Mon, 21 Jul 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086916; cv=fail; b=CYQjXzZJP0tzDO6oCBqxqL7M7TM7vJ9cV5oMUEmMBswlzA6PJr0WfNrD27YkVkYKXqQnOm0W+CnAgGFUGOOLDyajknW6VgNgtiLzqRXCxZHvX1aEXrp13tedgh+birNqeW7uljGDcAKpq0RHrfICiNKZ3OCTeaAi4bBpNHtzWl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086916; c=relaxed/simple;
	bh=kmPpr7SPKrnM1KzKc6THa/8Im7Ot7DSQehCr4KbooaI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbBWyhR5qW11QmOpHU0vrcwtqpsi1p85BjPob68dqFwrcMJ/7o4iJzsM6wMhxYG7l3CNJACCokpOCv54r7MzS+q1p9doXmjU8DsXmXTxuAC9eJBHqJ9rt+jPavf5/WFRpWyBawzLWY6EVODK43W0lf7fI2t16ZJJrmEy8QST1T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bdGt8B6m; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJs5tetZ+0jWvIJmdTcCtVfpS9LQYM+AKD7V1tmS1AINlQDzipSDivCD58kER4SrTAYyM01i0fR0inmK0yp7G3GWnjTQvelk1Ksyo0ozVTh1UBkuVWibVLQEd24V1uk5JRAMLIV0Z6xVgZldpT5dFACd2jYxxuhXQB8NZ++WnplUyZe+6UWOR1c5pP3hXswlNAOiLFPiPjKbfOX2WXkhfxc0PTf90WawHsYAmrBYnYOTpP6v7UphcyrmT8XrH/PxlYEVWom4n1iBxEpLDC+oeTL/SiZ2mLrEatA0Jcb7cQT6T4QSi/EPfz1BHdx+qSXETuX6QEcp4Zl2/X8xIW/xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw5wETra2/BxtHKHj2UoacC+7o4fpMSDVGzSZqHvbGo=;
 b=l7NBTluI5vh088tIHs8BUlu2aPPlkYPeOnGKY6aDi2WJHAVEs2lyj2CQOrllXvLtOrZQ8pr3gOq9M8b6nrYCH0CgnIWgZJQ7b2eQHuwBSuEo2SD9KnpkBPpV/wOCacsm0eCCDU29ts764hd4K65EaPAJWuZz6HnDzHE001skC5TNOriEc+x+nerwPJ9A/d5Z4OmUHaJ0iG8potzYcXqqEvd5eoy1k12DCbGGhupsYOGGZOVuvByHmXXDmfuVniJaZwCxbNRySpSmKkagO9MjVxq0PJpX9JigyDdX7i+yOiOahhuUVc9YmMQYly64S7VEYnYkCDBcTDAuHuLYe5okhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw5wETra2/BxtHKHj2UoacC+7o4fpMSDVGzSZqHvbGo=;
 b=bdGt8B6mturoS0RIC2qIK2r/FVjeUTPKoqSPAx1T1RzsGQFfFUlNccHcTeVBt15ARCeVmG2hgZ9Hgym0Zkn/lS3PBWkVm4JhtZcy52jT+DaiYAwY6JegqA6ethX7PsoQNQR80OD3SO0B8Vb6V/xWW2xxk7DCxjAbQtY58DAEwR5oIXzl06CtStYD5MBbXbKMV+bQPutETtanggygKLfb6+7FFDDJFbraksX/nvFy1+zSMReZRM3SPz0n9gqQisP5wDtq9DuGdbvMcdczn4uKLNCBg42fZ5aMsN+ZvNFfNVQKlL4BGHM4ewQctcjJ4yWxw7tWvNaYtrnI6uTetargNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:35:09 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8943.024; Mon, 21 Jul 2025
 08:35:09 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 1/3] arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
Date: Mon, 21 Jul 2025 16:34:31 +0800
Message-Id: <20250721083433.25711-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250721083433.25711-1-shengjiu.wang@nxp.com>
References: <20250721083433.25711-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0714c630-3990-4a22-9f98-08ddc831805f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSuuLJ/iEcKRcmA710HIn0Na+FHlQUcNiD3c8Wcm6afHmqO87y2WEiLIzj/t?=
 =?us-ascii?Q?1flWuLHPoHbzEZTM0nhQQdC/75IcPyfvdPQYkYLowONUAKecabNe2O2eRV+I?=
 =?us-ascii?Q?YuLJxCKFR9+xJhObC/1TZmUuevS3jcySdNZ3p6jLWRv3ILfrfCH49sl4dsfZ?=
 =?us-ascii?Q?w54QYXJMFTmyhi2SV7YK5n3rNhhdODEE+GodjN7UidnBb1F1ZM17rBWcoxoH?=
 =?us-ascii?Q?A9RDgcL3aOTtIx42UeLpbGisF/pGdOjRDyqnytnXHyI2IvsqWdD/c4IDlfi2?=
 =?us-ascii?Q?4iQE/RTvrSQJgmBbpmF4kLwePj6DbEaa19ZFEc5Vg3BDhHLKLCsMgHxHSDNo?=
 =?us-ascii?Q?qYfhbgx6G8J2uwFP14Vd3MiNIRZCD5wxZ74GuR1kKct/HLlPkSuatHYZgJJY?=
 =?us-ascii?Q?ECiydRTeVcGJrKdIHDkROlOqCZCcCrUJJw2PntMMwhNGoB64h3CZ2s5ezxMY?=
 =?us-ascii?Q?tVWTBVEMn63SJD5BpniBpIEUSj93aowlCfX37RDpFNh/z3WKFMIj09RYLWz6?=
 =?us-ascii?Q?wkCreFcg1sBHvwzlYmFERCwQOzILIw8DI233oaxg+IzUTpnqwGBHhKgBMBBH?=
 =?us-ascii?Q?e8V3PR9Ykr+291tBUaAzuKYQp6gsYJ+omRHyfnGz7qM4sStTnt1vnxlNtYNm?=
 =?us-ascii?Q?JMxpgXTSmqDKg5ZxG7QHW7D5QM7yCZPjooip8G1U9zsJjDeIjVv7HSo/jesb?=
 =?us-ascii?Q?yDO+WbaSZFeaOyqHRNrRyeBSOqMxNr9X5cBdknsDRYyj38h417QONmYznzfB?=
 =?us-ascii?Q?S69PNmylR6w3XtiJvphAvH1K7XkIcA9ZYgN9bHsZmB2ajZFDQofhOG4XiA0i?=
 =?us-ascii?Q?kq8pHPpbEQqJPSyKW5A1PBbiOfRZOo7gTFy+t410zS7T9ZpPOJwSR6MJtRt8?=
 =?us-ascii?Q?e8lmj0NGq7z3ap7vhimPKPZb6XBS9SEEn8eqkwkFsGdzH2C1JMAmh6Ks3Aio?=
 =?us-ascii?Q?drcCK/S7dZ7eJZ92cMdOuUYD6a1DEQjA2byHdPbpaeYNiI5Rs58Wo+mfPTwG?=
 =?us-ascii?Q?nuYKn+Xyep0GuQUN1IB+aN/ubohg1zvcu6LYAr5/lLA/lRRaOyXt7Mx5ndtt?=
 =?us-ascii?Q?sWpcmHiFSdnBZMZkzn8Hlqa6pUvhzcV4Px29kkqGYCZXg6z0JrLuAmZjZfua?=
 =?us-ascii?Q?+I5wpQnKaWtnBnlJqWSkOi2a3XKfFtkjaEeoyjwqPIZjcRGgY1pon6ATYbUJ?=
 =?us-ascii?Q?LK/oPlajkinq8TALAjrMEEbyJ4SkJGPR+lZqSnInXB3BdJT0iXlp5nzjCwqW?=
 =?us-ascii?Q?Oll6EyZc5LPFPjaudNTUdWphDdS5qjqah5713Jf23hIur212mmYryJ9mC3we?=
 =?us-ascii?Q?c6M1+mGSs4K/RkGgrTkTtvPzS8HJxxXF4xgKG3K3Ih5WXw1SoP9ffEPmpqks?=
 =?us-ascii?Q?mz5PGNsReLbpk8dcxd82pfxf4tA1hi5+ONcP/R0XCUEhqUVrt30EcQ30KdvK?=
 =?us-ascii?Q?W72AXk9qkp20srlmqF/jljUwcVzpuzYdcp03rTsC6PoXOjU1wRZTzqoyViKZ?=
 =?us-ascii?Q?iSaJ/73lWzyRcwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6D4Zhxj0pqPSr00it96hB4Nys1Z3qCHx2lMAKmjekGZhxj5HQsz7TAVPNM0?=
 =?us-ascii?Q?v1cLiJH82mLQ3HL0sKao06EZza2eDjccL9UJZnwaY4oXxgJbMnZN5qYE8Xbl?=
 =?us-ascii?Q?N2cmQQJ91XgHLuvEX+XZtFENcE7/IinfCfaJa1ak+UlvG7AkDai++/k/Jk0Y?=
 =?us-ascii?Q?0QuQ5/OgbL5icfeuRLbDpeuDEfeuPQlVmBsVQnBRop53E9kg+kgc+zzsDgCZ?=
 =?us-ascii?Q?ZCWJ4dmPBYIIidh6T7i8IIqsd9RkCTV9XFM42czHK/OH9FN/efdydNcrt4mm?=
 =?us-ascii?Q?QJCsvU2IMbub/Vo/RgZQh2NljjciF67SSMCXcSCpIYBPq7clMUOtpO+i2GeK?=
 =?us-ascii?Q?1XFPhm7pl/1ot44IwM+AqMlyRaN8ZmU0hbiKovqvKw4giHjxj9vpzzsh8Cst?=
 =?us-ascii?Q?CT8g8qBOy4t2N3SQtf1Ri/vd2KTNclTlva4mBHdivVqFaZdKIkHlgduLU5sf?=
 =?us-ascii?Q?ihUCGnwCJPoEtDXES6wBlp/+imHpJcGK49b60vn3oWd/djjfDi53hWaaHFyq?=
 =?us-ascii?Q?Xykh8Y2wiZTCRHoloNdH7VNN4tF1qLwonlNLw7wg7X31B3jmII9IpL1Ar6J6?=
 =?us-ascii?Q?H45qE9AYnMrj9ugjShS2evg7ry6j7a6fmVdyxzxuyRq88rv5wkoGAuGRcMJm?=
 =?us-ascii?Q?FdrheJxV3pgW25lMTn0oiRkJ/x6kcEMhxm7hIxcMWKZIj9s5RZsJFDJTftEn?=
 =?us-ascii?Q?dj6FKqLfhBArEV1XZsZpPI4sY1gfrUhaIKn7emScckq5hNFPnCEWCR0ycEZC?=
 =?us-ascii?Q?gc2T3rXNRqhrYHsYShmOGX1HZuv3tCQlngM1I0y59WZ/EHZ/H26WDIG9O2E0?=
 =?us-ascii?Q?PkFeJWOqgZiC5EDt4xhnWTp/gBUYSdTV+3tQuiVhkRXtPGLpEuCUNYxGwvu7?=
 =?us-ascii?Q?8hK2cnSI3Sfn6I5/sUZC9xzxcTS4UGFbFnn2t1q4j/3WjuAAXQSDvVMwWVSZ?=
 =?us-ascii?Q?1mc+60pSkgDkHwLtwlFVhxj7LhXeMdTGi4xwvxZmt+uB6Ob4p2AKCm/bmwKR?=
 =?us-ascii?Q?2HhM6UHRXJZJIjEl48t1CI/DZIItjbbrhSzaSH38EZDcj3SHfFWr6iQvqLee?=
 =?us-ascii?Q?SBrEx4P+ko2qE0/YFrvrZgX1bOOiaqH+68MFrNmN1vBsSqju2WYLVuCpx5y5?=
 =?us-ascii?Q?FmTGSYggyTSU2e/NKyVf03sR5WfpZXVZC65Uk+V1zxOGS1EcJAlZOfF7JVWd?=
 =?us-ascii?Q?dfdsuoJFk6hFLZ4CtS34L0TprrP4/LxaHr53zG6szdZNN3ynTHBeH5IPHRFw?=
 =?us-ascii?Q?l8Cn+eBtxJ79yA1RBv65T608vlR49L2W1CnRS1YwBqAtAm7EyALcLc0ee4Lr?=
 =?us-ascii?Q?uc4qRWiMWOHhjJfXhBh69bnRcC2DtG3pbgMGy0FpIRUiQFTqBlyFKP+L/kTF?=
 =?us-ascii?Q?0Begha/YHnGRBnIalFmgHiPSpixE2il+/pey++P/muSzH1WOcl4kOzKhyUS2?=
 =?us-ascii?Q?TjFjyJFag0EVDxQ/axGxGxyRJDXtU3qvHGMPg3HRTYkU9FiLhXUsl7ZI3vis?=
 =?us-ascii?Q?L0HZYmUcqDDzhFVaNkzLMzAV5bwpfLnQYpKFQjHEKlB/G4QtKbuvz3ujxobp?=
 =?us-ascii?Q?XnUgUGpoVnptufjvrbge3vCXwe9ieyYUxlt7gcgj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0714c630-3990-4a22-9f98-08ddc831805f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:35:09.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9c9v66bWP0ClydBC2YpiUaWajL7T7xdwoOa+X9mlCVj7Av+n3CZ8pGCqtflQZCH6vLpFcl4o+x8prbuYoXyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MM, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

As commit 17cc308b1833 ("ASoC: wm8524: enable constraints when sysclk is
configured.") make wm8524 release the constraint when codec's sysclk is
not configured, so we can configure the cpu dai's sysclk to support more
rates with the 'clocks' property removed.

Add mclk-fs property for the sysclk ratio, which is required by
calculating the sysclk, 256 is a common ratio for audio.

'system-clock-direction-out' is a must have property after
commit 5725bce709db ("ASoC: simple-card-utils: Unify clock direction by
clk_direction") to specify the clock direction.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 622caaa78eaf..ff7ca2075230 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -147,6 +147,7 @@ sound-wm8524 {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&cpudai>;
 		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,widgets =
 			"Line", "Left Line Out Jack",
 			"Line", "Right Line Out Jack";
@@ -158,11 +159,11 @@ cpudai: simple-audio-card,cpu {
 			sound-dai = <&sai3>;
 			dai-tdm-slot-num = <2>;
 			dai-tdm-slot-width = <32>;
+			system-clock-direction-out;
 		};
 
 		simple-audio-card,codec {
 			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
 		};
 	};
 
@@ -570,9 +571,17 @@ &sai2 {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
+	assigned-clocks = <&clk IMX8MM_AUDIO_PLL1>,
+			  <&clk IMX8MM_AUDIO_PLL2>,
+			  <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <393216000>, <361267200>, <24576000>;
+	fsl,sai-mclk-direction-output;
+	clocks = <&clk IMX8MM_CLK_SAI3_IPG>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_SAI3_ROOT>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_AUDIO_PLL1_OUT>,
+		<&clk IMX8MM_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
 	status = "okay";
 };
 
-- 
2.34.1


