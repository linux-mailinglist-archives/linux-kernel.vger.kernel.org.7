Return-Path: <linux-kernel+bounces-892327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF034C44DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864AB3AA2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538629617D;
	Mon, 10 Nov 2025 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="UqDBQjz8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD928C00D;
	Mon, 10 Nov 2025 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747023; cv=fail; b=VVbSQIitW8ptaHHMTYm5w+Z60OeBabzGdgcGMHERCBxBwlXboWsG9HEXimm2tLQJH8sxzkplCrvOSJ/y57JeI9oASwBJY0YOrLDVRaM0VLwB4+7WpviKqmqn9EkHz/5kE5SHGRB/V13YzipJrQ1agAMH698PoZDj5PmGiyFONNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747023; c=relaxed/simple;
	bh=5UQPR0Z/Lw21GoEs9bDpKObTxPDym6Nh4qKBLhViHj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K49M8BxKSJc6pUuFrgqj5xkAgknzbSbNeZwo/JF+RwjyxtIyFffyS9t2ywuNXogbv301Cx3WstVE4yZf9Sog4Zcyai6PunfVnCCowC0sq1JfxwqufsH7siZIXma7zpPa7kbUWWMJEQK5nf0k2chBIILpWvyYep9Hzwm4vBa1vPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=UqDBQjz8; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2pL3QsFSdsSJFT1AqA2H3ETCMDIc9Mej0CqTXnRV4/BDHc9cpqz0sLKf06MDdkrhwEWdI0G8jCCm8+QWPmB2/91dXyvk0PZd4eOIOO1m2B9cXTZBZ0kVodXY6pnpqBpTpp9/kkpGnhCvZc1o6wJxLOpyzqn+ArFN7cjDewlo72fBBFBqmEnnMEUUId0+L7hbSy1KEVPSWAoIK9BBmgg9XwOL4IhuNg+rOuGnnPXiUf/Wu3bhNHks95BelTtBeoLqFXhUXiGYYDVuEeSesjX3Ijo/GTz2HU5LoZr9yKl9UUPgGBXclJpYX13T78b4EQJK8K0wa8dFRp0p7J1+ZqXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCorOwqJJQDQ0Y3TcNJ7w1ahAGoqxBylTMM7bCAJniM=;
 b=MxFz2WZyLlAKPFYL7e1JKMh4MwsGEEQAE4dFl69oIE2FmVs41owyq21KAFa0pdAaxIZFhot8lBqZt4n4WEIli6P7oZ9ODJQmg5SylSsgjKQLEVAbu6u16aE92V8V4nftmE/IcCGr7BpznEuavz10jAr1rbpCj4TMQ4seFjTLAzLKSCt7IzW68mtb6PfwArA+fibMcowCKk+MtLM1hVZakhcd+Ek6D64tSWOr/G/BGWtS8WVgTxTnmHgLZv87pGGkaYhzTL7cJuON3PoVqLnlv7VSAnFeQzHwpZ614/7WpTjuDzudrL/K8P455Xrjpov8wApzwObpvEK1/rnTqmQ2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCorOwqJJQDQ0Y3TcNJ7w1ahAGoqxBylTMM7bCAJniM=;
 b=UqDBQjz8eq2HFAQH6m/WtPEVXGHN4N9rJGx+YkD7ZDzZidkR09zV0RhNEGR8IGuqOO2uySMd9tA0d9awNWABupCWP0KY6FBSEtI2srHEnSz3dPGdZZWhdNXVbc3IJ/EfA6HzB7M7s5HfKVO6gKlqpjSfEn00ev+lW1zHBMPjYPktRZz1Su1fVfq+l897GDSBhWBrRaGr5q6rrA31iysxu4ZMe7hjK73H7L5LeMI5Yjz8yJS9QRjgsHtIxjfCQgG2fpwmpwS0qLe+eNX+vrDPMpjwywkYQvrF+9TD9pNyboLQVymgcaDFOrxAt0GBVI7odgQfXgODr+q9uTdC47fyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB10946.eurprd08.prod.outlook.com (2603:10a6:102:46d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:56:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 03:56:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v3 1/3] dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
Date: Mon, 10 Nov 2025 06:56:43 +0300
Message-ID: <20251110035645.892431-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110035645.892431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251110035645.892431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c1d9da-8441-49d8-0678-08de200d3186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FltipgbABgBV0H8mzp0CgffDrOa2HkcFrMOk3fXYKcJoDe9SNMwHefvqJsWb?=
 =?us-ascii?Q?XG4D4q40UDDAuUSHmMSdwOVQSdIfc+uavQs9eiE9eMFpc1pp366QBe+01dD2?=
 =?us-ascii?Q?gFiFJNmqpXaeJgpGKoFhA4W9azgDHwx5iGoF/yaLTkHjrzTaTHkDKpMZwdBx?=
 =?us-ascii?Q?mP+TWU9rhwrnoDbuRh+WPVASx0oDjyY/3aU4sTABAw6xEINp9WLZwS88mn0Q?=
 =?us-ascii?Q?vdrnwweQDfedP21qsAWOAXy29IlCJdv8vehsO0wvzjw+4Q1Zsno5+f8U9Ew6?=
 =?us-ascii?Q?P1cr3hY8RVsRZTxUouT5yVj54K8Ti8HFg14rhFEjzvBwkcqgFLQfKMIEHJr7?=
 =?us-ascii?Q?qDZQjC1ZFIyiX7h+iqF4PVavqz8Cw8c9JA2a/tkwsJIaTOVR176U+oHW8HiP?=
 =?us-ascii?Q?rNK/Kj5+xiW7qjTCnrDPdxm9eE/F/UtE4mwo9wqdT+xTHD7T+7kUpe35mPz2?=
 =?us-ascii?Q?Fc7W/MUXBmu6pZ5aOGbrbzZLknyPuTxZtuunrtBMagpM8muXGETlJ/C+I8q4?=
 =?us-ascii?Q?5c+UR9zefql9Z23ogoCeBxYEr6EQICXq7dfzriF+lBvoGcdk7ZreaZ8aVTAn?=
 =?us-ascii?Q?JO7zYFR+z/0xaT2qBjFHF1yFUncSEIrV+a3hDzubWWYXmX0R/WmRcX1aZpiF?=
 =?us-ascii?Q?vGOdEwsm0kRmxBUqRUmtaMnPOOjYFDSHPUkbFTN7AFSqVfJ3Dv0kDWujjPIK?=
 =?us-ascii?Q?b6WF8BABZIP+6lp+8TDrzqjhpaOH0xC/96f7z2TaETm4e7a1qaHeJl4ytWJg?=
 =?us-ascii?Q?b0K+C8q2XCGqKA27XyX1rhBEndSguM5wnII6DB1yLGR9ambbLuEwd/S7BFm/?=
 =?us-ascii?Q?iiVxnyY+Sa7/4/SpSoYEv8a133jcExkjf0NRw9KKjhfQghdkFXIpDtiTbCpK?=
 =?us-ascii?Q?m+uxx+aty6WkoDcYfx+Oqsw1/qF0UatVlJ21jX4Wh6Bu513wWy1cJ5Flkr3j?=
 =?us-ascii?Q?0P87RKsFK5GYOz6RVT0QcNWGEfFxrUbnV1+W78GFQFE2rBuXU/hjj/WMYh0t?=
 =?us-ascii?Q?YSXdUgw8BMYhPXWi0E5R2FyTwX+1+qC0KVpHagnKtspJRbiD+rVwzZF9se//?=
 =?us-ascii?Q?fnloH4EX758GLDbMenqnTKHl8buEmXjCB/haiWwzomoYQOeIL28+f3Ns1q/G?=
 =?us-ascii?Q?44WOonW+1ND/ot+Xkt4u1e+5rexIuQ4L25cRZV2BSyPEanFSSj3oKPkQp/W/?=
 =?us-ascii?Q?syJMRw3H3ulm8BIWk8IS3Gg1yOyxmLVnYlMi/OVkwiamUVNjK/uaZSpCVOI3?=
 =?us-ascii?Q?BtvRlITvmzRxNAsSEejKJOI+K0uvMVFIYRCoKx0OB7Sop5Sb6IJHB5tOuLaV?=
 =?us-ascii?Q?WIPQ4dukn/nLsso98krVqvQjkEfuEkKCJcWm8U8ASDeukur6qaQNzTrjPGKn?=
 =?us-ascii?Q?E9VXjw47mLgxWpRKC0EXOqz6fGDJqdhaZ/8mppz7G0ovdxJY7A7tAwsQxS+i?=
 =?us-ascii?Q?SIAUuX1mm99R4jiOGyv4NvglWDVQRjYsIU/EdO+Gp/F3rA2KZplRVm5shVJc?=
 =?us-ascii?Q?zBoLmzZnr7+GiXHU0KzZfsBHfNAydP6FNN1nAK5WKjsrZJ9ttpY9Tnod8g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqVcjp/kI6JZ/Q8m7Fuz9cj2mcqYu6a8jPPDT6YXu41rSFdb/MFjQ1rX2vI6?=
 =?us-ascii?Q?nPFTW0HLEdNlyg3JJE+CY0sa/HiRV+W3huN65G6iUMKvekFvRr9ogjoP+le5?=
 =?us-ascii?Q?sCdtUgJVH3BmmE1GpqmPO7wGykiN1hqZ4B+IJV8seBM3+PhQFMpJG4MdsGBk?=
 =?us-ascii?Q?RorucviQAL9MAQ1jy90P3Po0Ik3fR3+qsIJMLSoNJrDkqUZ7h3chNta8wwxR?=
 =?us-ascii?Q?9Kfs4aydpvYIFQTx5vUaERVjQ1eiqAoYSguPzO3wwNVC8dP7/Zh7g4wl0TLW?=
 =?us-ascii?Q?Bslh0kmOE0ZA2u80jODyIzglSv9W37aH/tEII0DXP7Kq7Bidl1rrNDVZsGfO?=
 =?us-ascii?Q?ETQ4TSS6TU/U9PtP21f5JXkUqaiIxwpqmW8+LwCwnOEojcPIizV+VjNZ04CA?=
 =?us-ascii?Q?A84oSHrAI/w7h5PCRttd63JolBmxptMkW12K5cqyWV5lVFLlDSeRhR2e9Xnl?=
 =?us-ascii?Q?2QYqTBEv2SeBkyZ6fo46m41IsM9mpTHmfABy3zuFpUdxUtgnzzM3Qg7mU0/z?=
 =?us-ascii?Q?QZL9ItutuZIqXegqBRUfeWvleS0NQDJZMnKQNafjFNCGnLaibRq32qTE9Zam?=
 =?us-ascii?Q?eDjn2UK7kH561IFMyO8Tov8kiUKRATTadCVxwOwzl8pQ/SPIiqIGQsu97v9p?=
 =?us-ascii?Q?GdAOOxjPdTAFkdu58jHGE3jW5Ft4AcPngJBd6OFYoZ28DAtyVJsVNVEbzybQ?=
 =?us-ascii?Q?LYMIzbSQMvb0QFQDtciJQ1hDAWbqvR7kAkUu4Eu+EZM4glgGHkNaAiX0mXSI?=
 =?us-ascii?Q?x+g6Vtk3BrBygX7Gyk3qC0bJB6NDjDF7fcCNphOPgPdMYHOyzZ6bTgxkc2kk?=
 =?us-ascii?Q?q6JtQdcGFS/v0A83JGZryT9Fl3WGvlYUXgPVB9sHrmlsVWqplM32dxMK6O4r?=
 =?us-ascii?Q?S8s7YWKJHI6UhlVAEXFOYDNSo0q9+cT5fX/N+pvNOj2cWH4yHHSzRnbFlQ6q?=
 =?us-ascii?Q?mTdaWEu1jKlNihDM9vEC2kQs5DLtOKp44rKjK/qNM/zlZpa30t8yIqQdkNWK?=
 =?us-ascii?Q?d+s3G1ss+dHCgrop8YuHDl/gf83RxjvdEg69oUHVfYmQyiALCiOMO5HciLS1?=
 =?us-ascii?Q?tLDchTS4awkAokYNUxoOBolL4dJoh2dJwzpTZkvnck9VtEcxOt/92bTPmlXw?=
 =?us-ascii?Q?qoaxEWtW9KuFAYcO6djU+qBsg9aRsCgq6csc1AoEUaIQThgOjvueULMtXY3D?=
 =?us-ascii?Q?PErzkoef2UwD+TgdLm/cJdccZUKWZNia1UleFM032lIJW12aola4UC1nkE1S?=
 =?us-ascii?Q?QvdjFeNJQ6JZ8OdxBvodyQ8I6lfoeD5xpm9j3HD4LNz6NCd8gILV+rstpolY?=
 =?us-ascii?Q?ePSF61EJ4JzomgWkQcEXijYcvj29cb2LNH5ZOfT1mKeYEAy1AAE3uQJvUMxy?=
 =?us-ascii?Q?WLI9PMFRjlVvk8NBeHfEykVtx8KPuQEAARpc7ThB34hB+LuflVEyX83XgcHi?=
 =?us-ascii?Q?n/VbFv62azoJ3H84zNSzH1Jz3fAhz2+LTInBHbORr5+wrL1k1eOzUZ/PWtDH?=
 =?us-ascii?Q?QEVFp7cDl+GW8jcObIT4T/4UKXdAHYW4nlTKnpnSpE2cb1AeHKAcCyXWV8mP?=
 =?us-ascii?Q?taOdjMVlAjAWOumL1A2J5mVTKwkxGAskG7b7tTTW0X3jqh6RMM2hh1rdNyIa?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c1d9da-8441-49d8-0678-08de200d3186
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 03:56:57.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBig5cErN8Nuoy3LdQzXBw2D0S8oO9xIdISAMdD7N4/4W6RgZXFSHg7HP/wRlsNGi6/Bmc4tKGX/IMqnHGKDmJ0itZHSF3NR8TB5GcTjbM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10946

Introduce reset capability to EN7523 device-tree clock binding
documentation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
index fe2c5c1baf43..a8471367175b 100644
--- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -64,8 +64,6 @@ allOf:
         reg:
           minItems: 2
 
-        '#reset-cells': false
-
   - if:
       properties:
         compatible:
@@ -85,6 +83,7 @@ examples:
       reg = <0x1fa20000 0x400>,
             <0x1fb00000 0x1000>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
     };
 
   - |
diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt-bindings/reset/airoha,en7523-reset.h
new file mode 100644
index 000000000000..211e8a23a21c
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,en7523-reset.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 iopsys Software Solutions AB.
+ * Copyright (C) 2025 Genexis AB.
+ *
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ * based on
+ *   include/dt-bindings/reset/airoha,en7581-reset.h
+ * by Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+
+/* RST_CTRL2 */
+#define EN7523_XPON_PHY_RST		 0
+#define EN7523_XSI_MAC_RST		 1
+#define EN7523_XSI_PHY_RST		 2
+#define EN7523_NPU_RST			 3
+#define EN7523_I2S_RST			 4
+#define EN7523_TRNG_RST			 5
+#define EN7523_TRNG_MSTART_RST		 6
+#define EN7523_DUAL_HSI0_RST		 7
+#define EN7523_DUAL_HSI1_RST		 8
+#define EN7523_HSI_RST			 9
+#define EN7523_DUAL_HSI0_MAC_RST	10
+#define EN7523_DUAL_HSI1_MAC_RST	11
+#define EN7523_HSI_MAC_RST		12
+#define EN7523_WDMA_RST			13
+#define EN7523_WOE0_RST			14
+#define EN7523_WOE1_RST			15
+#define EN7523_HSDMA_RST		16
+#define EN7523_I2C2RBUS_RST		17
+#define EN7523_TDMA_RST			18
+/* RST_CTRL1 */
+#define EN7523_PCM1_ZSI_ISI_RST		19
+#define EN7523_FE_PDMA_RST		20
+#define EN7523_FE_QDMA_RST		21
+#define EN7523_PCM_SPIWP_RST		22
+#define EN7523_CRYPTO_RST		23
+#define EN7523_TIMER_RST		24
+#define EN7523_PCM1_RST			25
+#define EN7523_UART_RST			26
+#define EN7523_GPIO_RST			27
+#define EN7523_GDMA_RST			28
+#define EN7523_I2C_MASTER_RST		29
+#define EN7523_PCM2_ZSI_ISI_RST		30
+#define EN7523_SFC_RST			31
+#define EN7523_UART2_RST		32
+#define EN7523_GDMP_RST			33
+#define EN7523_FE_RST			34
+#define EN7523_USB_HOST_P0_RST		35
+#define EN7523_GSW_RST			36
+#define EN7523_SFC2_PCM_RST		37
+#define EN7523_PCIE0_RST		38
+#define EN7523_PCIE1_RST		39
+#define EN7523_PCIE_HB_RST		40
+#define EN7523_XPON_MAC_RST		41
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_ */
-- 
2.51.0


