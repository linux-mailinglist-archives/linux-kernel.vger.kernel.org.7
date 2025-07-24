Return-Path: <linux-kernel+bounces-745062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19DB11456
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E8B5662EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085B23C516;
	Thu, 24 Jul 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HT4Jx/W5"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9C61FFE;
	Thu, 24 Jul 2025 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398400; cv=fail; b=NLuPj0BLgnPArqg9fNJAGdocqDQdHJA3bWBVCv22llJWAeHu7ostvirQPcw0c7liUoRXKXWPTlk+AIZ++jsQuViW0Nd8PnXMJ4YqLB+RWNi6IwojtakfxZQ8Q1/uAMBYW16508MI9+gsPPodiaqCW87IVBNw+1MPkfzQcNpiPaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398400; c=relaxed/simple;
	bh=/Mkov4QTm1v5F8DynSPD7YsEITZbjNaZPiwXaZ4gbwY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mjf9mU+O2UF+qnuYQoCB7Kelp3lGDVFs8zOwImS81id3SeHQvIpFqXpMBGks/HkJ8oPt1+O9jSsegK1K5WtovKdxflsTCT0dXdHcHi13Pd7zeXrFDCw5si1P/bCYbionh+J7K9UYenwWWxQcrAtB9F50NtPD4pAzgAJIMjLmzlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HT4Jx/W5; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnQ/HZ0LQ9B0ZVAKXonNWBG09PkdZ+B9sIHMPDDd4pS6dUrTduc3ZB1RNs1yWaQjdAhXz5RyiulNoadNTkO+hsW4SV4SFJ26XQVfp2TM/NIm+VeBh37SUpLgnqQnTd0aYOTQE3MFFvr1J7DO0KD27rYU7ycE89GzyaiYunyXnhbjICg5Vo0oZl+XoI9hLW9qrDU7B6vyV9rwVx9djNQGJLPkLbvnWXPSU0kjl8A+3krXKcgR2BK2lb5HBCeukAlFo+6P1MV//UPFXLrC/f4xMfEYYcHuKbX4os/mqYYZZrtgkv6TjTMiGygvBNmslqD7df8SIliDtdlWgxuth31Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZanX+tm9kOhlz7pzw7nH7WhoPxZeJkuErr5LRuzqZh0=;
 b=GvDjsk5VAKBSXPmVCosApKOtDfW1YjG0xwFyYMXH1KZn1Saadlku+efbn5nunKxo1M9mt7Rt4912rH+J4LyQAPQQbACmpzZy36Py7jv+ArzoEsjl+87XDZkpHNRXEEwDjVc0g7tZ9jJbtGrJhjnDiPHfZDz1mAeVZ3KfmTpLhWYGvy55zZ4cWVe7b3CqnBb9PlETf7z+1E8n06wu4xL2Y7U56t3SV8nLIGEcGowW4LHXI0Pnt8UZ/UGIA5doukKHTteSE8C56XB1yDSmRFkh03YcXyIoSmoQY8fYZQXJjt2Vb7AceRX5NwkmOjGpXqbNuDTHuTMmQHQQ3KNYFgzENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZanX+tm9kOhlz7pzw7nH7WhoPxZeJkuErr5LRuzqZh0=;
 b=HT4Jx/W5rlEST8aZBhT350mPMmrG59/24JmPa5HmRjFRHIg4zOiJFlYYXl1vzs9AzZgnNrfXdw+HvKnr1nxGuK+M6iQV2JvNKTqwf7NRSeXuN4JuizM4zAYhBOwcRDv3mpYENEjAYdvgpcLhJrXtZXRscwzh2Mt1qXPZSiEQGK4CSVNBMFdYPO/iin9WD4r14iIVfNMCgGtlYVihDVRW419ho4bK1nXKUR4C2ioUMNWDO+db3ZSDGIRKffYxjwGr4Rm82rGCUTfsSm7GdAMLLWWILBN3KbN12mU2YJ5VlknswRdLKY0w70pfRU9joLQjRbbBQ/TRDnCT3xhvA/bxEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 23:06:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 23:06:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Fabio Estevam <festevam@gmail.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [RESEND v3 1/1] dt-bindings: trivial-devices: Add compatible string synaptics,synaptics_i2c
Date: Thu, 24 Jul 2025 19:06:17 -0400
Message-Id: <20250724230619.1480635-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9294d7-61e5-4e2e-645d-08ddcb06bba4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?spXKRKJPbmoi7DzpAn4d1fIRX8fjqcfbfeuCSL+t6fghNqzmPbhzd+ZWMGMM?=
 =?us-ascii?Q?YnBGe6SxJz50oOcqaDROxMJhJhYYOyRxrxOe7ytK+hZGRrVf02sjxRbMnXDm?=
 =?us-ascii?Q?CV3haJsBLMhKblZ2yl3r0WTF2kvUwXyV93EhlDPUAR4YfsPNvi6im7zRDT6I?=
 =?us-ascii?Q?nvs2mGeY2Cd3CGtJ+ZkrKq3UDtX9phGSsO6qkf0S/OyQah8KGfXIXBnU4HUn?=
 =?us-ascii?Q?rvTrevrj44hUFOqYz7ZYy8EB6+idRe54DdO541Y3vQBrtv9r87QaA/lP4mwl?=
 =?us-ascii?Q?rRUToCfH2kAVeIKf/6we/nyW2DkzcN5tX2XxFo26Wajq6yH23X7JVDF1qG1M?=
 =?us-ascii?Q?bhq8wFBovYXbM7WGNdgaKEMsvsOFXmZKcOfttpJM5iok/r5l18rdFfAaZycr?=
 =?us-ascii?Q?S99Z428dH21RCO1f788zuGIpeAOqdxSJUsv0vCMkTRFErQOEJwXtcs2CYyg/?=
 =?us-ascii?Q?Y9O/jwqyNjbM1PSL89ehFFKB83c1kxJxsNpNG/Nn+svL0x9MbfAe5jDnArWE?=
 =?us-ascii?Q?XNNRgu81svjItTcvQiMk7m4Ww65k9ZKK4/SjxCZvxA96IWGmQ4kKQ9Zqt56Q?=
 =?us-ascii?Q?dL03QjPnYXRNyGeR8bx73+wOM5PURU7Ez42ucl8q3jkgsJi0I6ITNJ6X2Cc6?=
 =?us-ascii?Q?0XO786v0AailsQnj+VyJvQHaWS/qW6oXeqNNBTka15rUcFdSQB56XOnKIWHc?=
 =?us-ascii?Q?wrcasHOdUSs8y6L1/zMOEemXUBNDfOFcah4DKjwXQxH8fkdp6SdW5FfOwVC5?=
 =?us-ascii?Q?mEJHRiIRSZq50OnOz5SS99WXHi5jk7ym1LpLSmz/wMGMAXDoi8UeRywyqTRt?=
 =?us-ascii?Q?jothdfFyWKeAYMBAZ/gGMczLiXX8T+n8HrZC4jOUhcXWdbjVQk0d47581mGx?=
 =?us-ascii?Q?P5jsyLpr7hxE2r6wNyxqXdAq3kkrxor0els6fElZaRT8J88NdZJ80y9LNfNp?=
 =?us-ascii?Q?B2NP1sPDDMTy4ZVOS6dKmiObET3MKQ62zAKEjOOTNQ8en/D5+5ccwAmwgSbQ?=
 =?us-ascii?Q?JDjHOv0YLwEItkhkcxPHiPdcHb7EBd9pCIYf54JleNkUWsV18o26JYDbGlT0?=
 =?us-ascii?Q?g4KIVYWlprbl3wd5Apr5S/HdI8eyq60qyrewgx8/piNdbHaBayc3ZejRk7xV?=
 =?us-ascii?Q?XbiC37XXD4+sEiXWjBtKy90Jls2dVu8MRRmiTuqfxG96TKCucBnP7phgeo4h?=
 =?us-ascii?Q?nGZWZo4zAQHG+up84D4t6DjhnAgjV+5ddC0G6fbz9tPiLFK7sxghAh/RaTXh?=
 =?us-ascii?Q?oFMQQ/IHxWqwqsIh21ajC+ZJKapC8mzY+j8dw8lxB/+jhEsiEZv/bh6CBNsU?=
 =?us-ascii?Q?tsiJV4rLUd4v7P/nUiigktK2QratAHUfkueTFCZZ36ROZXtiNd0/S0IF1Rt+?=
 =?us-ascii?Q?PGOKwWC8svQYttH69sV52w1JErrm2sxBCDhzSE3f64n0K7S7WPsRWSN9VrAl?=
 =?us-ascii?Q?qkFkPXrSXN8oS96g0tqAVd8A+bwhMUr2kzDNIvOnqr4nBC5C78Z7k5tcmOjh?=
 =?us-ascii?Q?CbI8sfm/QJ5Il88=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?IzaxkmkqKbJqPZPROeceAmS3FV49RjjbgBMNDXS9QTcJonbRYss7Vawp4qE7?=
 =?us-ascii?Q?joa88z/0OafZvjsISDaLvu3+jo8U/9W5rv+yrlQ0GwWT9h5r+lo+33vhc2ui?=
 =?us-ascii?Q?5pW9dnwUMaD9Sa9AEBZH0XUzlfEEtPsofK3vEolR2F97hel8udYnJlKsl7oY?=
 =?us-ascii?Q?mU+JIihMZORMWXQFXGx36T0SV4lxOI9fuPHhwfkeiqlKuyYHqLiaIhFrWQvD?=
 =?us-ascii?Q?R/D8bTNmDZ1NfATBN0NAOq+9Df+tuB2UMQM+uvva0L1oPxe2lr0v8mqu0cJT?=
 =?us-ascii?Q?JqCXeXkFVSrvWyqd1wOxb5EYFr7e2zecyU6SuKgPJX2ljaocSqWIrPVlSuiy?=
 =?us-ascii?Q?p2bd5Cvll7OfPTAP6t/tYHOImnlqLJUxGgczaN3xBBuXV6wGuTSgyfJz12By?=
 =?us-ascii?Q?Zn+0UzKHWYT/WvncttkWuEhdSikhYG18+fEkRf/s6ktWwq+uHPny0Yujxq7Z?=
 =?us-ascii?Q?k6IvmIHEatiKpBe37KhjE8iVYNZBF0BbMi5/loLaXwx4aOHLypYjVX1ECM0Y?=
 =?us-ascii?Q?qKyh5Cv2IBXJ55kHsVlGzbWOc5Y3rCoPPuxhEydwb1kDjl804ep73ZzExgzp?=
 =?us-ascii?Q?SY8Hby0D2dE3iYphqBnZnbIut+sA9cHqnyA84JK77KbyumL5lka5rZkttpzD?=
 =?us-ascii?Q?07mwUi2wQJKKitPqHjh8a+rwnRzxssrzNAdVBE7yOZ2o2dTGbyMbq167qSJ7?=
 =?us-ascii?Q?ekbCHVuriyGhFMXC1+oleKecyye5dHZjCz1t7Czb0+SYWNiWumxvWzwYP59P?=
 =?us-ascii?Q?fa1a75Rl9mWx2W1SP7DrwxNS6zJN7A+U/f9fLP8A86zyoeeqaYPot9bN7o81?=
 =?us-ascii?Q?cA3oF8BLiTTcmAWOJUaejOvHDuhT6+LMVAKJec8VStr8fH55gfEzcuGTnbc/?=
 =?us-ascii?Q?daEcaDumG5PdCP4gpk3T8ZDLQL0+H3h7RmQnlwSjnZGOgk9cuN2JKm/MmwgH?=
 =?us-ascii?Q?NZB0Rcb7jRr9RlkhklEm0hTv34gzfsPTRBRXCkmPqNPViHeZGf3/KAbmGHZx?=
 =?us-ascii?Q?9dqEnNTMEdRwumKtmFCQj0niCSDJtgWr0PMPQi0Cz2jdnJBJfHDsfs5NT7IV?=
 =?us-ascii?Q?lcZtn3ByAnxw5yDeLMIobSG+F+krA7E0x69qoz7WdbylAmqQggDfBguA6mIf?=
 =?us-ascii?Q?9pYWedmHkhKvztQOpsMpD1uDUOD2uclLylc8j3jlfrx/rCa78NlrVCnvxnNL?=
 =?us-ascii?Q?ZQJDb/QfSWvQ17OYTWiti/SFkdlamHtag9EuRGr4yPCjWx5ZZ5WjZo74OL2r?=
 =?us-ascii?Q?xzanHSaNUmv8jHJArk07q/vG27Mqou3GElGb2R3jgMmJ2rirSB1UL6Yi+bHe?=
 =?us-ascii?Q?cRe5NDXA43X6NTtMlPw9m2bKSf6hppg55cBFBZBsiODAcfwbGu4mHcf6FGZ8?=
 =?us-ascii?Q?+K4kPaqtoL126NIMd33t4HsoPJK6wHU0KHlN67HVRQkUCFgCztvK4z47oC2B?=
 =?us-ascii?Q?6xUUhawB4KWvvtqhb9VjGmAlui/d0EJPt9TNEnMd+WfEGNiwGWt75cgtVZjV?=
 =?us-ascii?Q?gFKkFYszbMzFzK+ecNEIewOeHs7pMFGYKa/x5nb0yKjXHph7gve9PgG7n3Qr?=
 =?us-ascii?Q?J9TMeMQoiUCqt88SA6Q75u/GfbryqVpX7zk/ZIdF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9294d7-61e5-4e2e-645d-08ddcb06bba4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 23:06:33.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk70j3g5bf8m6qGRdC9e8fJBhAqbsL1W0kUCP5bJNIAKJNtTfENXtCKqqywMgM9N4YnSktYzQeYtG2acPHMazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

Add compatible string synaptics,synaptics_i2c for synaptics touch pad. It
match existed driver drivers/input/mouse/synaptics_i2c.c.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Resend v3 include Krzysztof Kozlowski's review tag

change in v3
- fix order in vendor-prefixes
change in v2
- update vendor-prefixes
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6f..8db4596c616b9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -395,6 +395,8 @@ properties:
           - sparkfun,qwiic-joystick
             # Sierra Wireless mangOH Green SPI IoT interface
           - swir,mangoh-iotport-spi
+            # Synaptics I2C touchpad
+          - synaptics,synaptics_i2c
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
             # Digital PWM System Controller PMBus
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47f540..1809601004f90 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1510,6 +1510,9 @@ patternProperties:
     description: Sierra Wireless
   "^syna,.*":
     description: Synaptics Inc.
+  "^synaptics,.*":
+    description: Synaptics Inc.
+    deprecated: true
   "^synology,.*":
     description: Synology, Inc.
   "^synopsys,.*":
-- 
2.34.1


