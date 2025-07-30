Return-Path: <linux-kernel+bounces-750245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92009B15909
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B3D3BE456
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3E1F3BB5;
	Wed, 30 Jul 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TUEQO4ZM"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7138199BC;
	Wed, 30 Jul 2025 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857693; cv=fail; b=iu2oIvAj+9vweQH9ag5OHkQPQzRQ9aNx+cSpfiPguUnMI4K475Bxsq/giVUzBaxmfZt0pJAaKZxm1oCBysrgrYlvyMOKH1P4gsZbbEbch+bubHBWBNeOvH4s0RUtufAtKK5IXfymd/lJreTTzs0Pn4ehXgdI7s8Ys4EjJJhWKmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857693; c=relaxed/simple;
	bh=Jr28Mwrbs+l8ju9/+8kh9sSngFIku/KTvGyaQh4QhD4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jOlNsksy5yx4/MadzGpO/yo4xYS4IB/uYZribMuOwJSsldJ2SZS8hxgDXebSBUOla7uDN5GdtoPRXYyxJY0B+i+KWpMZk+HF6yKEZTnzCamDsqiXiw1N28g+HVU1w9VcGcYo+SvWttLwnj596k6+hNNZMvqTs8rTKLbm79HF1V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TUEQO4ZM; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUamO0p2MCTPAeByiQ0XoaWiVXfsD36xQwDNDkJQM3Pa+W2JanqyWVCHuCBguM6jalXCeyZM6TG35LechCDI0VeZX9/oysnLBz9D9RmJTsCbpdaiYtRxEeAPFce79lb6MfU+HcEO4s+E3xYvXK9Kr3MDN5pTrhgIAeogc5qqkV81sTL32X3sQfDFaxb9IXA4kXaXxOCNAz6CPorU4YLrgVX/RTOoN/RjjBZxAmZClxWXTsldSPiFyDXGgB/c6RrcfREm1ke7QKcpCVNsOFYCEt6GiUXW2YqU7iWpEOy/kXAyI2i1rJhkAFGq4UCa/dHf+cdyWy1tBue0FvKkpJ+JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPNPUwgg1dlISIAxM/xLrAzmczXukEsM6iAHoK+UCCs=;
 b=ph5V+J3BodBLdhoC0Busq4Z//TfLk4AdSmqCNFX7OJBwPcA+itlMt7qC7KceFJP3GmNUIZOyvlxpAdTZli/Eacy4Rs17hJrCO61peEb9GGfJ1E0JZbJFYLLsHMjsPJGctauOG3vCBJE6twh+IfH09OWK673uGPG39wWbG7WtS+pWQSfJotDlm5BVMCOUTIEuvCeiNMJytd3b/5nyw19DizH1H3osT+kEibv4pJfsIaQwa3kxo/3u38Jg9vNonVh/QWHAjMgjjGz2Jgv9iLqs1YPHnP1fmTHlMqzmu8SZYMrGdb8HktIbjY2VOE3cqVOBWQr7s2IyMV3TYxhC9fyz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPNPUwgg1dlISIAxM/xLrAzmczXukEsM6iAHoK+UCCs=;
 b=TUEQO4ZMyzLJ02eHxV7rB+MATbAotsnhdRTeMir3BDq6TE8sfrR86jy5xMtoTm0FKrlT+HDolDnUVMrlq8zuUAOt8/Rs5/R4DYRNAFgrgx8w0EHXOnDYXPgxQXi7vHBCqMf6jTxmZCY0in0Nw3fAQtP97Os/3Rqim/TbzDoBxyXCRuE0h/IoYSCnS+SOLTYUUS4qjtWWini9CrAmzLXVjpoKde9b9d9Uxh8Xg9D5vLE++/eQ82gvlwSG2JcyGKYiRPD7HvrzE1ElCw5kZ4Alw5YaTSw83zGfTT4CBkG/wrjvqcjAyzsZ3p5mgaMwRAU3/mzb88PRH9hR/aOVDV/fcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA4PR04MB7901.eurprd04.prod.outlook.com (2603:10a6:102:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:41:28 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 06:41:28 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH] ASoC: wm8962: Clear master mode when enter runtime suspend
Date: Wed, 30 Jul 2025 14:40:54 +0800
Message-Id: <20250730064054.3006409-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA4PR04MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f291a2e-70ff-4bf8-99e5-08ddcf341c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CyadCYoQb2NHS7W5U2OKMB9/8LRUEIec5OAb70M8pPkR5wgJ/Aq1+UPbgOQI?=
 =?us-ascii?Q?bgrLWyUaFuELK3GxRjwsAim2Cs2qEc0xomMNN+GeKSurRGmS8HSYuJdkoVPu?=
 =?us-ascii?Q?zLH4+ldqTUhCKdqRTXUSVheqELIM7hFUdzpPxteEdzbf5Zug/hmgzY8JcPVx?=
 =?us-ascii?Q?98aFe5/CR8ALn/c0xkomAKgvcjsBAk+p8MASxtnnuefrhlvao1s9okCYR+Yg?=
 =?us-ascii?Q?93yOj9nwdx6MFlb1SlGobqBn5In9un5aHsEqbOGJy6KaZ3I5+2NQrO2KaedO?=
 =?us-ascii?Q?UXcMuB+hCNQR1rdzlhsos7NQEOUYFnCKbjiCRmsaQJ9ZL+Q0Q/jGBDjIX6Dy?=
 =?us-ascii?Q?exbH++8zR8WFfbB/ex3TJAw3QGg3oDc2fa5MvdmsvcOHetL3dRgFi5QCipdQ?=
 =?us-ascii?Q?qUlFS6t3Wy0YD5Or2Ub5TcCciUNru2pYngrXDOhwQzQpJs0Qoge5Gyux+fzZ?=
 =?us-ascii?Q?7XpBQYrUelFjaxtYmOraplrUUxGry2VlY+WPKDul9qLfNE+4d7cqfO1RRIQ9?=
 =?us-ascii?Q?CaFQjYxlkm/G1FOGdjEY1JgXD1JuJcfJUAjYEUYE4fG7gjF75hcN6wMVGfVl?=
 =?us-ascii?Q?DIYvZ0G2evQupWjV5UHO9T7Qqhqp5gAt3YSd530N1XKb0F8GdmQQJayGJnSi?=
 =?us-ascii?Q?/L+sLq7pVyUYiEn3meqoN7JhaU/30ZwqPYQ9YJddww1ZWvsXTwpc+r+iM+v0?=
 =?us-ascii?Q?0f6ZEMyqNMul04C2CX/m/lqyA27F13RHiFM7NBsgYZb/CEWHo3+wlwyBz0C4?=
 =?us-ascii?Q?14KCsiq70WA64ReWQMV6B/dPctLT2pGWI/dFPKVrDtU8S5B9rSrmD+k0bmUo?=
 =?us-ascii?Q?J+h+qaHPkJuU2h/DLXprIl+YCrBlKFBxHpg5mDFTILeEyXMsPKNaNmu8kRr8?=
 =?us-ascii?Q?wmtOwSotKWvrtB6yqhk3DJw6T2C8AUSOVRogaUU7cNEiVev+SQ+n/3gKYkn+?=
 =?us-ascii?Q?xj5jtCuGnWtDvqDEWA0Sngxep+NfWSVBv+3LySeam16mdxXK1EAp9zuekLuV?=
 =?us-ascii?Q?9Xdh9vZuz547QRFnaNlp2SsuzE7LyNbtrhuUce/BfSu8jbuiuk/5VcuGNZM9?=
 =?us-ascii?Q?sb50oSdHlhl/Opl9IDN0wti9612Ta//bDt/50WSJgZ8Ucpeop815pyc0nS2g?=
 =?us-ascii?Q?UQsUUWw86Wm09u0qVYjg3rzxrFRGxmeRzUs10pacJxEKp3K79FtL+vMdS7ZK?=
 =?us-ascii?Q?MOZz4ddpCxBtEWaHm3QB5X2eE2EqKTlyD94/IK/Q248UUBhZ5xoQ/3aJ/NXo?=
 =?us-ascii?Q?KHF3Ltn3XqjItrpNnddFHe2kyVFeqQYB3WAq9VY3QfWiW2PFVX/XDmGkb0UW?=
 =?us-ascii?Q?GUSPKwMNzg0XMOxQKEAqTRbv1NwPkhOYdPtUZCdKnDJ1Dp9vujRE+YqtoLz3?=
 =?us-ascii?Q?A40isO0IRmcn4cH8/MBonJrUPSQoosERngmsvR9o8h5Wsz52hGa8iA1lHOCf?=
 =?us-ascii?Q?jjBeguMSDBIAT/emTr9zDQLgXuWHvpu+VdQFhrGIf/WA5y+/OVJ4fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lqrS0eYN9hMqZ00f4ZrHPEYRMACNiAGRwIoGdKXJUH6QO9BV3fhyYz3NK3DY?=
 =?us-ascii?Q?4F+MPXkuFMgYiTilp4Ph2bZng43uJ7KdCYb1Q7SA+sFO6gA5jNfsGQkpi6xG?=
 =?us-ascii?Q?VJyAGuUvkLzDAgRoGVLfccCU0J0N8rRFqgh1yCCc2FUAGzLKcoksg5a5uUD0?=
 =?us-ascii?Q?JE2Vye/EwZCMkaufVVM/FDCQG896STGBxLjJ6Tl2AsXFcS1OC4yjHVj8sbA2?=
 =?us-ascii?Q?NdryixEQVcO5CgLpeHhwsxuNb5/6LPs9VnOE9ypOr2DXU9euBmt4PCFY5Nx8?=
 =?us-ascii?Q?DYMMv8ax/z7YqJMi3xYsibaaLcTgpm+xFK4wkznQ3bQSSpMfC/XSjzCsRW/u?=
 =?us-ascii?Q?vMxIs7uKVOJY1fjGuQYjSYu5yinmO+ufwRVOhj+nIOrgIrwsKK1QAM5Yjfji?=
 =?us-ascii?Q?3PsT4V17RYphsiZ1wCQCEgDf18Bm+i8DNw4sS4HOxDDUz/xj5pVWFQV7VNQq?=
 =?us-ascii?Q?a+w+oN/ZNLXiSBoZj0NSIeZrF1a8nQlfZmBWwXYCXRzj2H2zJxxVKOTjDm63?=
 =?us-ascii?Q?Pt8Ph2RKi6ctMRVLVp3QrJdMtZAt5+IWTmHCjl6IUR7Ly3zcTTUP1U6gW+vX?=
 =?us-ascii?Q?DO2VHnz6kA3UsRaEMY0QhJJrq25FYXpKoj94qZfMeOSL8AyIjYcKVm8UhTzE?=
 =?us-ascii?Q?uVwm9piF/7dBTWkBN+HryPJtDXZWkvcZmffcvzYh1FZlx+zvPwzAwWy927Sz?=
 =?us-ascii?Q?DwOnBpxFsyR5aktLIyVgtl4CzjJLiOG/NBqTs1czvlLOskDdIWgpvsIqzu5Z?=
 =?us-ascii?Q?6QIYy0n6ZMKFFouDKmWOGkYFhy4EvAVpUPHqnMOh7HbcYsDKU3fY1arqpGim?=
 =?us-ascii?Q?YTc85foShtMzICPiNF6rLWTHx3Igb/jJvMUv9A0/AHkIZG+FzkLLNytn4FjV?=
 =?us-ascii?Q?FAxvcHqbLck+GJMXIJ4sYTLX+H0FP+6UtEKUXg8ltLajZRJAHauQuInRD3Tj?=
 =?us-ascii?Q?6j0y2oXvrFglh/xQMsEeOLmi5YSIlmp7WNWwk57Qt4m2wiRzMskFViWXRU/Y?=
 =?us-ascii?Q?y43C+TVJEzwJSJjuUGWnP7/itusbsbXBBtPV9bqqGdwIEP/jgsH3bSj5AN3E?=
 =?us-ascii?Q?QabcBRpHIJUnlRLkT8G11SwQj0YkQ0HPQ67GuHLtloIT/2+g2PobRvvbjXk8?=
 =?us-ascii?Q?sAe9fQHrMO1PyczMLvdlpvAQdhtouMRAtVar1UhqC2+yh19OyYeekaAljVux?=
 =?us-ascii?Q?uGAXFrdYdLdGud6Jx5iCrs2lkEGkJDBi2r0Ag+PQOliSYIEqeOVvG3q2ZWO2?=
 =?us-ascii?Q?FSU8zh1FAB0a16nDV28ZCPe9LG+0qmaP6fTRe6I83D8k98l8/X/UWALVqhNT?=
 =?us-ascii?Q?1LzVx7xT1I0HolyQ6Izra/NcBfwHSbXzyzpdZ/6c9Devu52o8fb8vZUD8XAy?=
 =?us-ascii?Q?WlgeiawjYcmltWgzPENkg+TSTvFl3OA33ZoGRYaAoq0+m0rlgZWU7V3JCdgt?=
 =?us-ascii?Q?xDYDPOKrvMOCPSw1wLukkyYV53+IaOkzDei5Ewua6eXPudLf19MtUdYLxopg?=
 =?us-ascii?Q?rUDNJAOsJwi78Rw79oHMZ3r5SBcECY5m6wGEiWanx9P3RWxT1RWk7OFOKiVg?=
 =?us-ascii?Q?1BW8Q23BRtvKqxj+eM52v+BjazCF5BX2ALFlARKI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f291a2e-70ff-4bf8-99e5-08ddcf341c48
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:41:27.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttnWcJYWy1MTDDQ0XtvZcJKs6KskLdoQsQkbe9iWwb1jnRaUeuaC6v48iHUZp9Y5Aey9n414OGyPJtVFWVTdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

The enabled master mode causes power consumption to increase in idle
state. Clear the MSTR bit in runtime supsend and recover it in runtime
resume to reduce power.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8962.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d69aa8b15629..27b4326429a0 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -82,6 +82,7 @@ struct wm8962_priv {
 #endif
 
 	int irq;
+	bool master_flag;
 };
 
 /* We can't use the same notifier block for more than one supply and
@@ -2715,6 +2716,7 @@ static int wm8962_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int wm8962_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
+	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
 	int aif0 = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -2761,9 +2763,11 @@ static int wm8962_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	wm8962->master_flag = false;
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBP_CFP:
 		aif0 |= WM8962_MSTR;
+		wm8962->master_flag = true;
 		break;
 	case SND_SOC_DAIFMT_CBC_CFC:
 		break;
@@ -3903,6 +3907,9 @@ static int wm8962_runtime_resume(struct device *dev)
 			   WM8962_BIAS_ENA | WM8962_VMID_SEL_MASK,
 			   WM8962_BIAS_ENA | 0x180);
 
+	if (wm8962->master_flag)
+		regmap_update_bits(wm8962->regmap, WM8962_AUDIO_INTERFACE_0,
+				   WM8962_MSTR, WM8962_MSTR);
 	msleep(5);
 
 	return 0;
@@ -3916,6 +3923,10 @@ static int wm8962_runtime_suspend(struct device *dev)
 {
 	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
 
+	if (wm8962->master_flag)
+		regmap_update_bits(wm8962->regmap, WM8962_AUDIO_INTERFACE_0,
+				   WM8962_MSTR, 0);
+
 	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
 			   WM8962_VMID_SEL_MASK | WM8962_BIAS_ENA, 0);
 
-- 
2.34.1


