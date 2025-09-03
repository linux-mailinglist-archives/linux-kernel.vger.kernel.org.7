Return-Path: <linux-kernel+bounces-798514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A9BB41F17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A03A1FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CABA2FF150;
	Wed,  3 Sep 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZzLre4iG"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3372FF669;
	Wed,  3 Sep 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902850; cv=fail; b=uc7zvZJjt/5+W0G9PwcciHgbbRrkZuCT6wFO3R88kptHOrPuygiWYNyW81n1K1XxxoAAyx+WW5IfSpBegFLt39DBKuXcsdiAZGCQTgg6joctGO8+rUuE1/uE2nlcilvyM4aF8Iy7kW/5CbChzvFbs2X7rCM7nwKXFBIc+dU3clk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902850; c=relaxed/simple;
	bh=HHQW7hv6TUUXsWsFmKQ9tTGplqjBFVz/btBRvZCNqM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J06NwVuHP+NnzuhYTXpThuL56fzPNOP8Y1B4k9fiecXeX0OuuMFUYi6pS3P8d/m1SDzNYQzARgr9xtrlgnxb+ez6YuYtwujQSygbD8/DlT3R1XZMOCpbHeN48BHb4UDII4WrNZOHyIYEzYaN5p+9BXcVDTdFqEbcg2AE7HQA2Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZzLre4iG; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvESAWX2p+6R8hI2JZcFEAKxBVZUjMtkwVJwuB6i8xFWrs26kK85v/sCn2T89VP08pgbsDUu8Itg3ovmtN1oyakEITbokJEIN7rXspfyDigumbpgIAljcqEUxgoN4pXupf+hYFHi4NV3jK72yCSwTL7U4tqDZmKpJZQY4Uqq5/04ZBaLxqHcK76hEG6aPSaCViBSn1tbHSUth/WV1f3X5IkAGDY44hiE0+msoN+qc2pM+tOoKYoG5aE8irSeElcw3ITTQdwDREMBlQRW/aSW+i2lcDvwwxdXzv+4+wv5WzD8NxN9mzw1TUbPQPx0guX0UhcwFg1I9Mgwc0LjNHXMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvNJvdnuYL6rjw5LY0fKwamRArZ8aIt0mEWbFpknP+o=;
 b=m8nSFY4/JYbC3yhVKN6eutrOJDO9M5SiFfJOT3xObqwSUvNmQt4JnJwDP4RTxSxzKt3e+10b4O02BC8I7c+2XhbjjOZ80o6hKPlgL9eGh1+g6OQdtWkpu+2j2ZBVWS1PCC4sWbM+oa/uVAqeuSIt/4r2OeZ9gu4X9LU1kt2RXR3so7uTRssHPHZrD6pqp9lk6uM+rECDw+UawO1HIspXg55PqRoqPLP5Rp4VixKMWw6BF3K6WIfQ7L5L8OYLeU+tsEzIb9fuRiNvQWrd4wPtjCLu8AM4M1OoNOoN7Y9roN8kCb3HBpDF8lWSaJbmmeL5AL5veo36ZLHtbJD1HTieew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvNJvdnuYL6rjw5LY0fKwamRArZ8aIt0mEWbFpknP+o=;
 b=ZzLre4iGUHRw38L1Y3VrUdBytC4XVZva4SMSVZdeiCkNIEvYoAGnt+wRlaD2K2gPiTzluHrSOq11mrDex3C8LT+gQQ0altDOYiAo2D4lfYsjfHizGcSacE18sZ7kI+Qr1320lV8f0RRx1hJTGETSTK7NjPiBE5nxnErR0O8a7SEWqJPdxAgXHclT0xHPctJVM11LirBRQvHzhWoz4AiDCY128fwqZonR1DM/W+XJWPj1Jxxq9E1zTb+K0uZtIUB11cMR2O5Wn9oaTkaRKIsIIVRIr+CDjLrRqFO/gcn03o3m3Bj0lEczqKq2pFCb3V4rGVfmLQZDsrKoy5Si4cbrUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:34:03 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 12:34:03 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] dt-bindings: display: imx: Add bindings for i.MX94 DCIF
Date: Wed,  3 Sep 2025 15:33:22 +0300
Message-Id: <20250903123332.2569241-5-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6247828f-4dd7-4069-1181-08ddeae62a64
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Md/aTfYJYHMbolPSXah5VA1UEa10CU2CMqk8B6y+ffkDWU0PmH6pduaAszVV?=
 =?us-ascii?Q?pPpjj9TU04bteVmp4uRK8sVF5jxR9tVA8tUGu1BDqnxsRhgAxr541XxG3DBk?=
 =?us-ascii?Q?zQv8ZqcbGLoMF7tQowS5nwQWWzTn6VxndAldJVYBcS2Bw4/s2GhGDckV3K+/?=
 =?us-ascii?Q?Wp/La1SlO8XKgLNuaGlVi+i/chGfNBHyI5qxbJusHWzxQXggyF5WmrK3CyLD?=
 =?us-ascii?Q?VkVlE+mZn03KrSX4M4KcVDvNnmICqVyMRF/3TofIndFWc4rjOPmyhmMhORdk?=
 =?us-ascii?Q?GK4y5+rF9uymV2pyIxJSDTR12HkeUrQxPDTwSi/BpE4htuW0k9Rky+ozbXtA?=
 =?us-ascii?Q?etlC3AlkgN1ist5cPfqGp/xLndzk3jpQOkRuyBZZ3rv7Gz+DmCFM3uTEMw4i?=
 =?us-ascii?Q?5bebrRLHkhpMYupiCd5llz3Zb4UmKJRj3KGNKCcOb0Lc7V6nqSMbENVJqFeB?=
 =?us-ascii?Q?hIGT0EEv9HWna8GSvPVO7tuKOQcX0OsE/0tWDdDukFgtIM+9Le30gKMeQlpc?=
 =?us-ascii?Q?19Wdwcd8AUHoN3z/wy2FYIucUuWFOKOMLKv/ZSpgxAYsbJFWJR/tyel6JSjX?=
 =?us-ascii?Q?MfM/NUW4V5gn2R8pqvN6YYKsqeUGK0yDw+AC2sISpceKlixod86UjZIWAQaf?=
 =?us-ascii?Q?MMNouq+CCYt7dnrJFdwraTF2UWSCm8ijNBSDVNpkE0DjYay1Y4o1OZO13RJI?=
 =?us-ascii?Q?JcH0v3uLUi8NP1mNDSFp9YegBM4xAmDg4H1SGIltTX3w1T63FJgTmcNxQtsG?=
 =?us-ascii?Q?HjZxvPxlLkALax+9Oe77gcHzQ4RYrnb/93mvtYnRK6rVv17AAFI8ONLwCcSh?=
 =?us-ascii?Q?WyUXdcyCqD1nuuIxotkHzfylPAq+FIwQEoBCx0VvUmSnsS+3mTVSTytXUxyj?=
 =?us-ascii?Q?6XXWgb9rnfRmt+EoCJiliJUpKPd35AKAXjYJpkjyFiSwOHs+l2lIczCTK56O?=
 =?us-ascii?Q?ydDsOp/7snrnbndiWzFoBFusdOBUrO3dT4eer0v+ZR5NlOr6c7nfbp+1spTo?=
 =?us-ascii?Q?h56wtix1hwg4dS7krnJymxNwUIAWpocUfCx/9dRg37mW9FO1IuiiYOqugiQV?=
 =?us-ascii?Q?+RhIIPl38EsiYq/iJq23fDqNoyDrogXBsztVpAawhdyouOQzTVl3WRL/dDwV?=
 =?us-ascii?Q?ZxfuN/+WWMxstE2TQYUmS+YB/0VlRqct271thwPt82LGWC9y0Mq7qkeWfCoB?=
 =?us-ascii?Q?3e1hMD/dw+OOOblKKH/mTJtnu29sKidKUyoxe+nJkJSOkVdDnE+BJMqO+tUQ?=
 =?us-ascii?Q?BezS41zoq/Eapx/7pI8HeuKPM/dpkR5nGCNxk3Y5fRs6v0ypInmiwLkPj0vp?=
 =?us-ascii?Q?CXNdGpKpJeQHBeov6KGxc06RnazIT56Vy8qf5kzxzBF4YEjwTgWcNNoNvlHj?=
 =?us-ascii?Q?rGjf9zMxRarfEciCNC1ir0Vn8PX9fFsIC0iPzMZCj3UuBruOCjl5SARZNQcc?=
 =?us-ascii?Q?QCctPMFA28U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PV0jvmKIxGrIbapqrS1isNyU+68k+S+O//AMj3xSaQZxcrkW6DVe54VrylG?=
 =?us-ascii?Q?A4B3RdeekZCGtKPqWly5XHOFJDYLL+uUEvZBJ3xXjA33NlZ/SUAu02ogCdqp?=
 =?us-ascii?Q?Hc5vr+CyxSRtM52M1m0TRNr6zTZjnE0hl5VzBIuYkbYQ9CGYMMnuDvI6eEFP?=
 =?us-ascii?Q?jqyIIHG0mWsa/O0wFwuLMzUEvkZKUJXUm4T+4EKKayundou6xHH459UAAt9H?=
 =?us-ascii?Q?01xKOxICSlhpg1KBTGgSrXCRcQO1auUY6F2m0HInH421ENilGoSHFERbBUmE?=
 =?us-ascii?Q?Mgeq06dffxtBrj8ZeCEbnIeDjYWluJ4bqw6WlAmD3vmVKXyyPw1qgKNuP5EL?=
 =?us-ascii?Q?99Rhf+hUwIoCOHaeM2qR/M684FSoGCHzO/8u5Q/rbQlaqzeigVL8UgKXF3rI?=
 =?us-ascii?Q?U6eLs15XSAjBAkIBHeTamsPm5sXMupGdVWrMfuOGNkL4771nh2qv7kXcv5t7?=
 =?us-ascii?Q?a6zhjtP4rW6rNiVunBHfRuNAEnESTw10eW0KvTtn7NPKGetVw9t5kcMOZrSU?=
 =?us-ascii?Q?Y0l4zfO3BPkTZfFQs+u72eGznq4TN6hoZ/HfJ1qqYWGP5I362e4QVhwB1wAg?=
 =?us-ascii?Q?o+y0WMvzamQk29prcIQAHIta6NU7XIjLkXMF8K0cGueL7+/QJEXsZs+ppVkh?=
 =?us-ascii?Q?pFXW2dJAElckabRi3cCyKfWku41wbuhu65vpIrTBk5Kv1Tmb+qKJ1Gw6PZ52?=
 =?us-ascii?Q?2lNA30xSLv5Zoocy9biVLVKPenNz0sIE0iVn8nE9fwpzseixeKdJsLvbKmI4?=
 =?us-ascii?Q?MBPoe+PkfEjdMMHHu7Xy2ITJsJbTdLrNAo0/mZRoxZTyrOu+7rA9XbxO0Tl0?=
 =?us-ascii?Q?dEfAcm3bwhHJhh1G5fisGOxh6HtKBbtbxKJE35bdwSyrr5kUAvzjXv9NPuJj?=
 =?us-ascii?Q?CIx4PKzi/o5AOKX6QOr+GSabHEyHCwXy6mmXRseqWbJpMVDoQHbYfV/xYOek?=
 =?us-ascii?Q?hrWvuiCokl3QgW7Fgog9AOzZfuJ5xP1q5Fwz0G9KhnBWU0OBzeH0miVWgKyD?=
 =?us-ascii?Q?iYJL/YBA5n1jLQkkmoYQw1dlYTXTbqlGakAh6rvQnSViILjOA8Wh3gjaZxjZ?=
 =?us-ascii?Q?2D4QOTOGdyfAiihwGrq78SFNqF/lwcNzxwW5I41vqcSmpBERagOTNgtzyxGp?=
 =?us-ascii?Q?1GRDKuaG1xMXPDZK6WHIN63r4LvBVSO6nOF3gRE9lmsKvt9nPCLwWj1DscfP?=
 =?us-ascii?Q?ahg9JXy9jkDz2mGJvOPvwA89uWJj7+xIC0A4dtY0Nyxt6dBpuA8VQKHKd0YL?=
 =?us-ascii?Q?LaYFiLeR/fKS4pPxmZZm0E0Cz3H6SAbAnGCsk+P0F/6bF6beDcxJAs/bZmVY?=
 =?us-ascii?Q?7awMkdIoulzpodnFd5Iz40sdUe414RGRMHD4kqN+DDU7VlAVZPO5paRGW4md?=
 =?us-ascii?Q?GyULdVow2vEObrqwa6lsaUBaUzYaTwM1VN/xpHhWC/QYlFGb8hpHl/QD+kbQ?=
 =?us-ascii?Q?iosR/HIacSLDtQslcAVPdrPqZE+g9BZZngQQzhKhcUb8kzuf5HQIYAMahpFo?=
 =?us-ascii?Q?XDNHmWf+VWO//nCtwwhxMLuG1aXWM/iooTRc+wPfg629lXyasW2Xf2Aa3/tv?=
 =?us-ascii?Q?3u0alrwnJnSOQmAJvdPx5frGNFNvxKu0uXuUhnm58knOPW81mO3oblDeba4b?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6247828f-4dd7-4069-1181-08ddeae62a64
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:34:03.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzD5BnpHpG8W574GqDOzC/l2EfRrDuvvztt2kV0R9T7MGT1sOBtlYpDUwFGYVRsdtdgXI6Xna6jQlUCBx4mg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

DCIF is the i.MX94 Display Controller Interface which is used to
drive a TFT LCD panel or connects to a display interface depending
on the chip configuration.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/display/imx/nxp,imx94-dcif.yaml  | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
new file mode 100644
index 0000000000000..54419c589ef74
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/nxp,imx94-dcif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX94 Display Control Interface (DCIF)
+
+maintainers:
+  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+
+description:
+  The Display Control Interface(DCIF) is a system master that fetches graphics
+  stored in memory and displays them on a TFT LCD panel or connects to a
+  display interface depending on the chip configuration.
+
+properties:
+  compatible:
+    const: nxp,imx94-dcif
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: CPU domain 0 (controlled by common registers group).
+      - description: CPU domain 1 (controlled by background layer registers group).
+      - description: CPU domain 2 (controlled by foreground layer registers group).
+
+  interrupt-names:
+    items:
+      - const: common
+      - const: bg_layer
+      - const: fg_layer
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: apb
+      - const: axi
+      - const: pix
+
+  power-domains:
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Display Pixel Interface(DPI) output port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        display-controller@4b120000 {
+            compatible = "nxp,imx94-dcif";
+            reg = <0x0 0x4b120000 0x0 0x300000>;
+            interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "common", "bg_layer", "fg_layer";
+            clocks = <&scmi_clk 69>, <&scmi_clk 70>, <&dispmix_csr 0>;
+            clock-names = "apb", "axi", "pix";
+            assigned-clocks = <&dispmix_csr 0>;
+            assigned-clock-parents = <&ldb_pll_pixel>;
+            power-domains = <&scmi_devpd 11>;
+
+            port {
+                dcif_out: endpoint {
+                    remote-endpoint = <&ldb_in>;
+                };
+            };
+        };
+    };
-- 
2.49.0


