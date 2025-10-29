Return-Path: <linux-kernel+bounces-877102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C2C1D32B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 817C24E11A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB0363342;
	Wed, 29 Oct 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAzL1ysJ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F503563E5;
	Wed, 29 Oct 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769704; cv=fail; b=XOTQsYLkLmqYXN5SoADOGVOCvUPmS/UAvqWElyl8wsIHLAWbqjACt+85UfKHVCTWjAOTMDLEkmiOs/Ovafjh7Xp+C7l0GQPySMy4AOuqjZ/xLZLJS0kyqqvCBrjPhd90902isIP6Pyci1MkajbZUiSpKtbrNcVbmEw8rSmtx3QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769704; c=relaxed/simple;
	bh=uCQnLCIUCMDC7cCXmK3Wb5SE9e7bfrM3PiR4xzH5rm0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=moEtGv8nK0xaerI0uH5+OKBQhQ/gbGWDcO/GuBOHCEMS38uhxoziW+vEhKE90HeAkU+2DxiDsH9M2wGahosm5M8T4dRvEq9pcrc1xXWvOwSuzOYfC8iM3+SUevnK5D1fK0y741y+AkEhJ5L9LGM1aqgp4h/CSwbdO4rQrL00vZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cAzL1ysJ; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaZAcb2D7dsQLdwfZEBwWUxU4FnVcTy+elt/kCHjHmMB13kLPUDvyhH0pWGI+CK7N9Y9b4Q9i22JbGNnUPfsvWq6uRgXDc7gTdLxBZ//1fikr3u2UhbMFntPrThUyELYQpxDIAIn+sylOr6OkMDD8Qz9VQVWtoZ8r5wjUU3rjaRpedEweeFgELKD9P2DnOLZMFTdTVK3KK4a2dqyxooMakpFBzbvEiZKhDt59uizDMu5NGHQqbs8FM+aSUMV5YNeezepbZadx963znALzYckhnuEvGvHWDSDnPM6fNfeGW4YOq8H88UyikEvQjBid2nDLEd7QvQb1GEokPK/cwL3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XS0sQBC7VyhoDsZv2+ASr+FG58mhsyzFnFLhYsLFOw=;
 b=oEn38wmc35V366qXTF4/d58kGxm/ci5TvnyxGc1evu6bv/Yl1ghO9D1azEeD1U/HSUO+Alq+1c7428mgRFkW4JcfCvan8PF4KKK0uImND9b9qzILdYveiU3jS+XCDAmkbJ9jt2XDvLqiyxRylWV9nhfxSqyJOLqETJ7i1WSuCe69PxIaa665kO7wFm54Nsof92cHtsO7lZedA8tkTkd11528DUg4KyWKbGBLbDE5RM7+G3QyjcVrcTYc76c5JFIcSyYuAFI+9bd839HrfAwMJHcFZL/lHuVJA9IQo73fCGHFsL99shng3uG1KQCYowC30vayMyOMCpbCI1ea8IJbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XS0sQBC7VyhoDsZv2+ASr+FG58mhsyzFnFLhYsLFOw=;
 b=cAzL1ysJLqifuVHTS0cgUoRmWwFDT/hNv01VKRtxdFc4ZdUl3ww8dNe0i5reuqT2dLmtq+2i78QO0JPR3Vnl2aF2dSreYY30CCBjEbXtV9SX8jPaiJwUK+BMymW0r19i3aHgjSwjXaEMEJahIGfuLM7mx+HpvKH9j5zGU98j/EufuDdQowJxehW8y5J0PqxrRPe/ugSnW2QhQFKJsS5Zii07j8J5L+UgJ6VZ2mBH6kFBD6KGUAvD52eMZe2DpCG/Q/A0mMshgYuuweYFbQ/eABP1BR326A2I6c1g01zu+ps2cDz/elUFPma40lDlInEzAYIZQJvVx77+f47QdVpxRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 20:28:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 20:28:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/5] ARM: dts: lpc32xx: add bus surfix for simple-bus
Date: Wed, 29 Oct 2025 16:27:57 -0400
Message-Id: <20251029202801.3963952-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c6c652-baad-4244-9d89-08de1729b264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/+0uWH+VhazZPw3gWVwPCPBrUAGwYcAIiIzddODcOccDIH1zVI3wWRn525N?=
 =?us-ascii?Q?jtPtoUlsOj7wrAh+nmx4u2PYTdE+cAEKiTLTTEkP6g//CSbKWvhNcds0fx8k?=
 =?us-ascii?Q?pynWW/KwBNeSLkKE+clH2EtCCNqQiDWI064zHmMkiIOw6gdizccum9RWAGSK?=
 =?us-ascii?Q?1qykqOMqr6YPyXsrqe5g0uDj4rOTSwSO6vebG91qNeHh4cyAoTVsL2fYouaI?=
 =?us-ascii?Q?zv0lxXSBYWxWqYvXT40Twkor6C7xMVDJxKa3SPkMJNl0eNOjmj9Hgx2X473p?=
 =?us-ascii?Q?jRtU3orb03jrV1zn09grUoVvsqFmZf0DhIXz0FpmSxD8iZgmVrBepR761sGL?=
 =?us-ascii?Q?9VI8cAEwIXu4tjTntuVoreVU8+8ZjCRaT++W5GFUM9I2uSD/3IbaADp/7/GR?=
 =?us-ascii?Q?CN2S60DHPIBmiu3w3J56579Co17aJTz5TQQWNya4tEprKCKOFS5v3nuT2E58?=
 =?us-ascii?Q?UBntx0/jIqQlNmzX6a7e68qb41R+qlgYE2YpqKurGLG+TbeupQF3WbT0efBa?=
 =?us-ascii?Q?uKpgA5nRdEeWjH2Ps7yvSls0akFeBibj3xWmkjfThBkleF/glNaqf4RpRyVe?=
 =?us-ascii?Q?AzTuJqnpB3yIfIsJFu1hxsQYn635GqyAdCkI9VCth0g3EVqJPcgPw8vZ8qgr?=
 =?us-ascii?Q?v8ZuvnrQhjMF7Eo5tLS1D2R3XVdTDPYIWi0dilF5JBIN7X0NTGKUHqOe4lLh?=
 =?us-ascii?Q?aobBjvk768zZdGQRIufxAJxGtbOLY+V5JS1ITd7U6CMuvT7BkrNWSWNOVkxq?=
 =?us-ascii?Q?BIbxJX18BiWTYpOs7MmALJCsfrrxPFkVduDS2nCzpAyaf1k6YJu0jXXY/Q1w?=
 =?us-ascii?Q?hVPqCh2EbFeniN4566CGr8szZaQgx09568cC1M8BIMAwHmrl7a7etB7au8/M?=
 =?us-ascii?Q?GP04coevJuFnaQmfuCylHoe+XrNQc1PIuTHEgAJWVQUvzsRNO8ODTJZiTrYn?=
 =?us-ascii?Q?Wan0R6R6rVhJNgocXlPGHbfpkhJeUHfZKFdImFamBOx9fs4m+jK0C/xqCAjs?=
 =?us-ascii?Q?pXiUCYGs0iKT7SfppkIvPzk6VBOMWPePF0UEqBt13cNeuHNOUVjOxX9UYSEw?=
 =?us-ascii?Q?ucAS/66k1RwadijD8zHq7jZqcdlz7Jv5L7+xuSvsy1KjV/SauWaoowwHUjJq?=
 =?us-ascii?Q?O1Nh//Rp0/ntNfE6t4O7u6SJ/0zWXN+WJ5EpBLpcAgGwIMNOSj/QwD65pfp0?=
 =?us-ascii?Q?BOqRrbTludJ/m4qE56PuISf2EY77PIbjzQnZKm2zctq+970iVMNaDNJY4HBY?=
 =?us-ascii?Q?R9d+P6yTpUJFb0BKDtP4Jzt4iTKmyS5ThDZbtCnlk+wGMfSa5Bjk+iE7QeUe?=
 =?us-ascii?Q?DRPdxkG4UhLaffB3e7Dz98L1JfR57Ifjuate5GClVoMUUji+h7swPN1JEpXf?=
 =?us-ascii?Q?wg5VNif5CLwKSKFz23O+J97GHF6Q21/zJN7UAEl/bUGJoJw4btil9SpJdP8v?=
 =?us-ascii?Q?nroXGedTQZ0zvBFaYXXJYPj4myQL1xRuyACe36PGKF0r/THmEti5JA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2IyaJjURX/B6RfukH+5WG7dub0MqFans7jiKc17+Jtdwc2CGXk7qSU0fP0as?=
 =?us-ascii?Q?KbOIevxi6Vnqn95lE5JGQ+xQgJj4HK6zxvcS+YKOmiaB9NlxLNMgExmXKBSD?=
 =?us-ascii?Q?8PXoZVEsdp5/OUjtrtww1cCwTJylnCa+ESlfbDX26HHm2gHzRaTI80zqmb71?=
 =?us-ascii?Q?0xuwon+ErDRXIrCQNx3wGrXVjddICgJJISoRDa9ebONew/OyFC6ohnjSA+EO?=
 =?us-ascii?Q?wxwsHSRqiKKnVo6PDBlj8KXZ+OdAxswVdt4mk85hAlYs3HxheYnbjO/ElJH+?=
 =?us-ascii?Q?0A0uQsr3c8vwUxzy1pvp3T6qP+LwPEXYU26OSb4f+qD/3LSjVg3fXXusOsqf?=
 =?us-ascii?Q?ikJh6Q1tdAk09M6nVXvB2+FvARZQ0y72kZgs8f7OJMpiCdFlfOYv/FuadXmt?=
 =?us-ascii?Q?YyKmPH5utZVHHYOd4cVOcs8DfKkVj3vyekKN1EoSNLSvIAUc/5hXd7svz02O?=
 =?us-ascii?Q?YUZmzs1QqhUvxPHMjGhk1f1k0v23XEZp/zwn0lMFFqhdS/cd6ksdlF3hIG4l?=
 =?us-ascii?Q?1FSD8juKrUNpSuODlJC1cRXEv0Z8hKFGtosn60PeG1YpygGixDkssNNKBkGn?=
 =?us-ascii?Q?0B/vSnhrDSutCET+Na1cdR/j6xc/JzYNtos1ALeGjAelp36VCEtJlhqV2G8g?=
 =?us-ascii?Q?bwRDM2h0H1jWpFEsPONdovyYBko/W64iJLLDw27VLzrxZUqox29IZxvRl51j?=
 =?us-ascii?Q?Jf4NP9I4GS/e64d6sj21/PaU64+EUpsVQtMMLiSoSDjXODXef8DnxBT8wic4?=
 =?us-ascii?Q?MjcJHiqNgu4eLaSh6qdM68qQTxsDb0P5beM8n4RKAH0a7ilrwaNA5s8SLn53?=
 =?us-ascii?Q?WbWo3Bs8fUNx/XW5JlIyVkTQbA7GQ0JzmlQnM/kSyDYSt4usPQARgqjQN0f0?=
 =?us-ascii?Q?dRF71rZRBaI57ofP+CxNmacw1Qzv1w7lc6f1XEkJnkQPpIAsvk/r3vC+SF+r?=
 =?us-ascii?Q?AzHgS6YA9Frj7O/FzR8usIkU0ovF6xUSDG/T9kM2jXCjup2pGuA5mt4Em6R0?=
 =?us-ascii?Q?/8vgEpADcCRAEmyRNMnCaW3myiCWWj4wBx7ZW+pJDJHuR4qeBM+qlM5y/peX?=
 =?us-ascii?Q?vgWIDbxRg/2FBp0gqTWXn6lyo/RjLFXZSSc/+5KzT/pbpq1JR265iAxjtBkF?=
 =?us-ascii?Q?NCJa4vWs1WhOpOk8l1v7HslayrGZHDDs1d0ZywXspuwvARY4gH5wMM1yyKPR?=
 =?us-ascii?Q?2wPWWaZ6NhR1o+q/9dusR/iec2ta4gEeeKNyJk7U/TduSF1AuHWQiOhAuVzI?=
 =?us-ascii?Q?eogRmS3VBz38ortfdczoZnvo+DFUoVo+wdgrai9DXOXyP2IN7TEctnsuLM1W?=
 =?us-ascii?Q?P1lN91agVlv8AAjyjg2iR3Oja+r6EIuchL0qqFAXVYcy8azjL4uXh7aM5lEe?=
 =?us-ascii?Q?NuJngPhutorSsB1WVVTCkDITsRLn6Gskdq814aZbEd7MpBbYZKevyRQjwe4D?=
 =?us-ascii?Q?UwQXeJsZtgC1h2kPMnX9+3w63ONBwdS5HBhyUJJ0E3udHsNolnsxUwzqg62E?=
 =?us-ascii?Q?+2ArmEuW7JWjAEKuY8spThTfIuUv4icG24LY1IYn3aqw2Sn+iv21c1qcBcAX?=
 =?us-ascii?Q?x/+qRNsmqhNT5RqzTNc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c6c652-baad-4244-9d89-08de1729b264
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:28:19.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWHso73ZDn0qUd5xGaK48CWC7FImgsAVJgrSkt7s4pErpkwUnWQFaxKW2xbUhivlJHu+OCeC0AzliKOByWNjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

add bus surfix for simple-bus to fix below CHECK_DTBS warnings:
arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: usb (simple-bus): $nodename:0: 'usb' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
        from schema $id: http://devicetree.org/schemas/simple-bus.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 2236901a00313..9790b0a1d6537 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -86,7 +86,7 @@ dma: dma-controller@31000000 {
 			#dma-cells = <2>;
 		};
 
-		usb {
+		usb-bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
@@ -307,14 +307,14 @@ mpwm: pwm@400e8000 {
 			};
 		};
 
-		fab {
+		fab-bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
 			ranges = <0x20000000 0x20000000 0x30000000>;
 
 			/* System Control Block */
-			scb {
+			scb-bus {
 				compatible = "simple-bus";
 				ranges = <0x0 0x40004000 0x00001000>;
 				#address-cells = <1>;
-- 
2.34.1


