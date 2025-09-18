Return-Path: <linux-kernel+bounces-822188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51498B83401
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177353B12FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623C2E9ED4;
	Thu, 18 Sep 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RmzmphDN"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119082E54D7;
	Thu, 18 Sep 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178984; cv=fail; b=sDjZD99hLQymxWfDFtA9+UcGB0z1QRt7rVm2GbWrTNpJv+zWqEezgoj31fm8IL/7FgNsCwc2qbvsVsYCnIBVhovksQjGRmz9qGApx8DI9zvGwcCCGoT+JyOX9wfIuEFHhjseBtHgVlDU+MIh93plskYc6FURTg0iym7HJgfT1gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178984; c=relaxed/simple;
	bh=lfV8/rgw3390d8ayNhzsgQGfW2Lt+EuCyzNvOArzk5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R+3D/k84Hb1YqTXOgleH/3DZM6NsP2osiamxJzZVMIikB+n6/clIPpbmtvQ6py+gw3aWPhCdjZi3d+GY2UjCRSdwpTpaDX+Qdcs6BLwYhwK3KD8k98aJwmFOPrMH3KmXrtLqR3TeRs7qkylUw6Aen7Ul93My4He64ibQ09ppY5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RmzmphDN; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql8VNB5VQJaCSROOyVP1+VM+p5Zib47dUHVGjNxeZz6X0dr/zDqkuWrnIHvey9TKl9pLdrhXtYj72RY5QklMOc2p1P2IG8UzKkRQFM7nDYtXxhWDIdpj7687s7lS6CyGN5WIE79pukwtOkLgl+M4YhlenqakK6f7vjk7K+i143FnmMzk3CJuHKfMWJEKldsndwaT+QTKfLqJ3dWeWmJr+rBys2tqJvN4c+SqRjddunPtS6r7gWpMw6E6ZxpsS76qnCjZdwinr/ygmX4DSgvOJJHwFvi32OmHpaqS9LFIiD4pOZ+3nbSWV4vaTPD3e3csgzLEZrMAbtxIZOPeZTyILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfV8/rgw3390d8ayNhzsgQGfW2Lt+EuCyzNvOArzk5o=;
 b=BEbzWGVh0OjgrM6bu08jq1GPGJtPjOg07OJ9eQ5ywab5hKA9nRk3rpNnOxsmPJw7JnYTVPPmzB8na4b5xrShW4EYH/Fptw0OUhuSE8XW8XZG0Wae+6Y8Dbqmy08HnZAcW2KreonZsEm+qdtCiCKHD+zA9gDtisfgFgoKKq9gM3KBN70ox731AUm4ZDL2Upt270Cl+H3tNi5bzzfQMT3U2lxY3K7Eu6jrJQLeSkGWjkVK5Ca924FLjpMiik1GCFFrpFASuMO39lIK9dgBzP6Xudf/gnTKQ+x4EXNWpvM5dw2LM7Gv67E8AQGUOPKtUpcPiugjptPOeG6EebPDH3QNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfV8/rgw3390d8ayNhzsgQGfW2Lt+EuCyzNvOArzk5o=;
 b=RmzmphDNKkR0J9l6ecLQKLz04RnukDIBdi1osFQgW3fCkx7knZMsKeqwr39cehoCGkFrCg1GRFzEb2W+wU7RTMQoJP+msUK3cc3HkJi/hSfouJg0SPFd1nbSVaTO6b2XfM/jGR/QwOt+Ii/K+t+VOGvK9hrnFj1Aqz6Pu7H/Se3lFOR9iKwnXKhM+OJQnmgW2eOKT4ybu5+s0mbUiclRtjdGQv4X/5zPegr8mDCDlhqTuyka6sGUgaCxZY3H+Mq0NnjIGVLV6gkRoEr104JjkPmDeObWrlSPCFfCTHEpgAueJAchCI9UlSn65OjBgcWdoQUhNwXsVx+yaw7Jg4FkIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB11193.eurprd04.prod.outlook.com (2603:10a6:800:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:02:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:02:55 +0000
Date: Thu, 18 Sep 2025 16:14:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com, marex@denx.de,
	Markus.Niebel@tq-group.com, y.moog@phytec.de,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	josua@solid-run.com, francesco.dolcini@toradex.com,
	primoz.fiser@norik.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
Message-ID: <20250918081426.GA23028@nxa18884-linux.ap.freescale.net>
References: <20250918014053.696710-1-rpimentel.silva@gmail.com>
 <20250918014053.696710-2-rpimentel.silva@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014053.696710-2-rpimentel.silva@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB11193:EE_
X-MS-Office365-Filtering-Correlation-Id: d24a1019-3816-4238-d3dc-08ddf681640a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?etr9qhnD5nerYIP53uOx5DTmHekbZyFIBXkzVHmofd18H4AvvDlS3KEP8A7c?=
 =?us-ascii?Q?IWuzpljokF11fovay4Jok7DAClRYPEKsxM4rjCS3L9cjxsSdZ8VqJV6R9C30?=
 =?us-ascii?Q?rLxA2+5Bt17lWIjl3R32SxR7x1CeqsRJfAvQrWP93ISvIysMJFy6vP+ZC86D?=
 =?us-ascii?Q?iFyL49twK8ltoN2zFCnq7DekQi1dC0IGJqDQY/L3Q6wcXF3lzyJuE30fm17u?=
 =?us-ascii?Q?LL706sYlPXROVknHR+tDu7DI8lym0Ek7t5AB8gC1q1p69SAP+VL+ShNcXiCf?=
 =?us-ascii?Q?hAXfIXygMKW2J0WAINJ1b5UR1H5Seqbd16YjmX4hXWr7KiNrybqwuMSAQbzj?=
 =?us-ascii?Q?fKXGf47Ad16gFEKc7JkTIjjVM6qJ+jERC7FNNITMrWuggHl2FLYDPEJyYW6w?=
 =?us-ascii?Q?VeFdRnPti1cpDe6nEy4yUmPYpSJZCqRu//9IqMp1yapmiTWlnUz9lVyBb8vK?=
 =?us-ascii?Q?SDx5k702LtusR3BjwTRBuHDCzIeDlIaPsnKQIBo7dn6iBjGIYfBw/0OGLzna?=
 =?us-ascii?Q?kKzQJ44VM69Ux7jWyowbpgM936kLBe0Vr5msapnQJNoN+rILe7u4gcLfbxri?=
 =?us-ascii?Q?Ca6iaW+9HG2wPcObRrfTgiREp/g3lx+Qs2cu4qqyNu0u1E+hsNc5CAg2Ly/p?=
 =?us-ascii?Q?E6nX8cWblYUXSBtGSE0WEIFYlstv9GxvRM7Y/GpcLW4iblUu5XQtRbgAYjTG?=
 =?us-ascii?Q?TxYEUtZ9Y3WMyUskAoCx1ov6Y88eyZS08heQ8KFAQbqF8vvCJULhkYNbImRV?=
 =?us-ascii?Q?m6vXsoDqMggZmSOSeYPWtrd+2UiVWXHcAp0QpP60ua+34VQfE4Endao+4Ftm?=
 =?us-ascii?Q?cH/RxtmvU5GF/nCoe84uc8GDnh/PVKv0Txp18p9gYaT9mXKNatp/Bwf30CYt?=
 =?us-ascii?Q?QiyB1I2+zCA2o/II11qLKyHWwsZ0qK/Is1Q1It92wp9mkm7rcdj13+wCOWKZ?=
 =?us-ascii?Q?amWDWnWlThdwdc1ei8kGnFUwcjIr8LRzh2SjsEtqanpAhWqRe1ZxqTyRNMwE?=
 =?us-ascii?Q?J4rFaAaSdCrt+ie4izg11lXgr+l1f0OwUqQvT4skgirzkq+o43mf+kMgWR4U?=
 =?us-ascii?Q?oa1slLv45CQ+W2js+r5keEn2Vbi6leCwK9fuXtp6BxOAkbAwS4k639VhgF9K?=
 =?us-ascii?Q?UdukkwhHnUZUpi8tEGJRPHQHAsKfE7vAns/QXd3dCmECUpjLSq42RAnonLlh?=
 =?us-ascii?Q?yieAQRjN+z0WIXbeEJw90aGN2x85wp+P4+9zHIsNmLxjSkWcDUzMp/bcmxUR?=
 =?us-ascii?Q?BJirLTdBSs+Ag3c0As5iWBva7Wj/tqw7c/bERM+zG9CNIlcY9oxaSc7l0/aj?=
 =?us-ascii?Q?X4m4xvaR9SfmsZTVXXXUD41g8JNzSTSeGrdB9vidUh9y8umOFjIDJrilVkOr?=
 =?us-ascii?Q?PHOhM2TG+DSrGfyNRofq6WwxbdOVGIAuqQrGZuwtW9R9eqYRYNz/fLIFZhqO?=
 =?us-ascii?Q?uxg++ekpp5zVZKn5Mi8jbCsSB5GqfpHNEnGuqJvd9PQWtwLKsdz3oBXx+Kfe?=
 =?us-ascii?Q?xGX96VYfHjLjTUk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?IVQzILYH1yuPFXPs1GF6Hl06PpKBJglqq75/WhLbSmra6egCFJlYjJiPpcq3?=
 =?us-ascii?Q?cHCZ97rrBTISc657TZC11IiCX/P5jHSS68WHjn9T3zCIph0zr/eKk5qDznKS?=
 =?us-ascii?Q?FU4HJr5uA0SWY3Ep0w4jvFqcsSPtTS5GaWWgUS7MEiiSjO7N2ip0Oo1JyXdM?=
 =?us-ascii?Q?ztLADxecDuaSXfbr2IDeIioyfWHZU3lwT4SGUJ75kYSPwfKKK34ZHx3MBPfu?=
 =?us-ascii?Q?qcRJo/UA9C9n7TeqbxWF2MLH61PdG/rlxFuIYbC67/mh03oAp7h3ADGavDM6?=
 =?us-ascii?Q?3X0WoQw/V4vJaaP1z/l1FvJs7oLpOFM5D0RNXLWxWrRKvuMeIJALgvTfvfSR?=
 =?us-ascii?Q?kMkycnnvTJ39yUUOcl3iDhXD649cJKUun0TNdXWxNRgmvSqttHp8abbj8r7n?=
 =?us-ascii?Q?+qjmCeQSgAq9cBwtNfMx/z7BsqZvlTgLvuECF+pLiFogr+FWY+cFcX4No+TQ?=
 =?us-ascii?Q?m1QSgr2yzMaohpMLRlEx3Dg0UJaMySRFbdlDE3k1l7Ikth7aifGrG9SkEF6d?=
 =?us-ascii?Q?2uOv6+eQov4/tnvFJA8sU2y9w8NNHLn6j9DK9RLXUeWEyxAU/QeJEyhPTmmD?=
 =?us-ascii?Q?NFvTv/rlm+kjnhP2aXiBpxg5dCHq4R9LVpfsMpokAAEbzCT6czxEoxPdx1fO?=
 =?us-ascii?Q?L2nUceERwzkvAINm82W8govh2a5u9KDrQWqf3qygsHzJspODoApx0iazh4Cq?=
 =?us-ascii?Q?3RgohUwmxDOP9p1EUpc2UWYTJSEev21ekkYxekYr4Kj2fq7d7LkEQgC/nfZj?=
 =?us-ascii?Q?9TGhCbJK4homFPoXDjYWtag5gQNl1+GJXsY7/QxEpLICFZX7lLJHgCZ99SS/?=
 =?us-ascii?Q?k75Hx8wyuRvFX4pcW20yOzalqFPFgmOQU92rj+fFa3ssPC/5WmXHTFmTTR0m?=
 =?us-ascii?Q?jf0veFpd7o6J4cNO4YjsIkQvTr5r93N3X6O0YDDRUNZKXN2SCBWc363gTzJ1?=
 =?us-ascii?Q?/TW7r/PYEd5JUupUbkRrss/8eP+v0AUaiIoQnYfKNT6wHDdVgqat6QLcrAwR?=
 =?us-ascii?Q?Y47DNS+GIfv3BB8pyT0CgfjAZ0E9Z9JaLSwXk+mJIPN8Ot2gPY68n6tcQih7?=
 =?us-ascii?Q?UvnzlCrCGDVjjDwSlTUYXEKLQhPnOrg8YkyA+HCN8E8FZ3pa80BOcrW5J/56?=
 =?us-ascii?Q?1s5cvQ8XKezUCrxDdb1MG+aNFfLik0DhWQwkXZlHHEAzObpBOIK37bbmYU1V?=
 =?us-ascii?Q?pS40iC25x1mVv93MmiPPhEVqWbBUjUmyDoDeKC829CeEI9zKYK30oiHe4wUw?=
 =?us-ascii?Q?qKeKOBQtWKv7JxHCIHyjmRb2hAJH/8AQuoH52MwmtaIXrqNv3Gd92L0SGWnJ?=
 =?us-ascii?Q?pFMee2IuFQrtJqf+71bVCy+xMhHFIMIDRitehCiQC6fpyoFpy8nxOkQM9Dfd?=
 =?us-ascii?Q?2aDkdS9EGL5FYLYvfepNUWiHJMSgTn38VCm73apUk0J4eDfApYq/CUiAe8Gq?=
 =?us-ascii?Q?coVI97rCfRr/t5OKYzIjZxIH8UKI/d+BpSZrm3ScEjrGPzLHWzpODPM6Mwvr?=
 =?us-ascii?Q?4KoJsMRcEKLoPmLv6+1bkxFSlc/V74DFRdM0gc11V0ZtArfyHp5lKCRjNM8K?=
 =?us-ascii?Q?pbLBYeXBIZcLD/GYH058Uyzs02gzEAo/VKtwGCR7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24a1019-3816-4238-d3dc-08ddf681640a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:02:55.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdNF7Mcd1PkmtOCioQDb6aTMQbV4BC7yFLDYgQiSRF7tmQKHS7jU4Tyg7yxJdGH//FGxsnHy8106KT6RUPqdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11193

On Wed, Sep 17, 2025 at 09:40:53PM -0400, Rogerio Pimentel wrote:
>The FRDM-i.MX8MP is an NXP development platform based on the i.MX8M Plus
>SoC, featuring a quad Cortex-A53, Cortex-M7 co-processor, 4GB LPDDR4,
>32GB eMMC, Wi-Fi 6/Bluetooth 5.4/802.15.4 tri-radio, Ethernet, HDMI/MIPI
>display interfaces, camera connectors, and standard expansion headers.
>
>Based on the device tree found in the NXP repository at github
>https://github.com/nxp-imx-support/meta-imx-frdm and on imx8mp-evk
>board kernel mainline device tree.
>
>This is a basic device tree supporting:
>
> - Quad Cortex-A53
> - 4GB LPDDR4 DRAM
> - PCA9450C PMIC with regulators
> - Two NXP PCAL6416 GPIO expanders
> - RGB LEDs via GPIO expander
> - I2C1, I2C2, I2C3 controllers
> - UART2 (console) and UART3 (with RTS/CTS)
> - USDHC3 (8-bit eMMC)
> - SNVS power key (onboard power button)
>
>Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>

LTGM: Reviewed-by: Peng Fan <peng.fan@nxp.com>

