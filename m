Return-Path: <linux-kernel+bounces-853227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BDABDAF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88CC3BE6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E72BE021;
	Tue, 14 Oct 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QxWY4Gew"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF6238C1B;
	Tue, 14 Oct 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467302; cv=fail; b=jfmWm1SZpA3o5/OkfA5Bw+HeTHHdtfbLGlUH83OCVkpgibynF4RDWY54j6F6ByWEs0j6thDdFoYKoopcocxd9WCdtxY+NHllc674tFYN09WqWOQQ6cn1hS+KOIyY/91MEGOS6dxLRBYc7FqY98EnxKGRIm5uXWNFUkHBXbMMEK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467302; c=relaxed/simple;
	bh=U5FSIOuxdjvgm0dIbmcRMowKm/71mlg6v6xhsEUATCk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cyt9/XJ6wDKY7cpySR6Ex6J/D1L7njZxMAgp6H9xTSFdaE4+imac2RprvYxywEr9oefljiID93xyePJEjLVR4tgni36YStP9IUafqW8jxRUFF68EUhoyzDFM3iTvNGK5J3Y8zDRO0qJnQeZ4//mcckF25y8lGtdAs9sn29WEqsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QxWY4Gew; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhklAVO5oWOJYnG5uYMM0zUKi4s/xZpLqcn8QkIG3rV9iLB6ZjINUDRMMPx3uEhRs4Qx5twBRBNwmJjATkoco54XExdi47xubqW+na4OdyI/n3I0drn+j+Vi6NxmTb4Qfu9/0i0gycmZA8IiMvXLED9Ug/K0HQaduJFjxXWEHJ/E26lsCdAMtZayMuN+79Cad21ANTvohqT+h4QYhxW5gZzs9EyZrWfuCVPdKBlO3Yt988U2p4GkKNXTk7vpK6KgC3SNRnip1IYiqMNngb/bRRK8i5jLPlorYUtEyZV7q2/ErXpWs3GMrIF8myU10rIOziUfJaJ8BJz7k6CUZjT/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd+WgXZsWgCGgAKD8vVhtJnIuTIa4U+M+tIBBN8b278=;
 b=YqU32G1+HIoR4Txa++r9u2FijDCoj9pz+CiK6dAqThmnbfBvhsRQi1kQbJO31o8QOsHl4ijpmpP8XBXOEMPOnY4KT1/FmkgqKnPBcsfxSsQnvQqfhingwW6ZSvojTfMbk27vTlT2bP4nO/EOFwXmJcImsLSd0UY2RfybgO9KBkKloazc0meKWd6GnIIc9VERHvi0wBl5a4IW/4L2uJY0n6jRE1Hq8FrYvTb0L+sE0vjNtJRuUcsONs9ZkfbM7Jj1RW5F9UQgelPXEysy4suiJcWaVEGPSJ8J+P0D0qGtI6bEeHMi/frqgXcCqSUv+wZGe18rQXiAap2fXuqQFpnmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd+WgXZsWgCGgAKD8vVhtJnIuTIa4U+M+tIBBN8b278=;
 b=QxWY4GewmE4SA1YIDhz2ESpY7HoymbPExkL9H1MSK2w9tsdTZ+DUUgzZIoY/io8e491KTdZxlMjI1aHYd0AZdtR/cRa65LadYASKj0my3q/6A3AS7WebIpnVMCk3Z3GOLFNODMDuxzH5PB0myvEe2SX0Em13QplEgRBJ35f8h1zw+hwrfKLk/VysHxHXCX3FI8i61N9VMHs5Gf1DYrlJ8gI7x5Eg8Uc8P4LqOV0JpVblM+ZIReK3/1uPRIVh/GsbLvTPiF3MXahFnqcS03z9uUeOU9+1R8JJ4SujubrRF3SJ879XLZuJLer4gt0YZEY8AfJ4AHpt+Ip7+PPb8/TIfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10703.eurprd04.prod.outlook.com (2603:10a6:150:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 18:41:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 18:41:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mfd: dlg,da9063: allow wakeup-source property
Date: Tue, 14 Oct 2025 14:41:14 -0400
Message-Id: <20251014184114.2353199-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10703:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4f4e49-6eb0-4591-e4b8-08de0b514bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0tVF9VkUDGyUCTMDl+3WvzFjrv+uqf2IvU1JilA8gMj7oUDrfA0TU8jTRtgi?=
 =?us-ascii?Q?gXK72tb92ZmbzCNmVKFfLD+CIpzhC4sOjJJzuZY0dMpQQB2LHYVmfSn6sEzk?=
 =?us-ascii?Q?qU5yWw9gl64WwFv6V1QffSQhdsz28NgHuk+/+ubc9PmEF7reCvJjM6MCNAJB?=
 =?us-ascii?Q?EReRwM6saJRVJgUv6YrkpXp/MybKbNUgnvhAasgir1w3524VR5aEMa3BU6Aq?=
 =?us-ascii?Q?Yn49+0KEuXBsrviCEaquKrgFUgZOJzHq+EbrQHebMQ2F555BufOzvJBFWSGf?=
 =?us-ascii?Q?qBp7GW0fbK2JEQtdD8CxJpZcxpe8qbaY5Qm1qZjj4CZORReszELmmbF92Po2?=
 =?us-ascii?Q?JWobD+2uLov+xX2c/5oG+aec1EBlHW+4dmhntcwcC/zduw+vOTEns435bTNL?=
 =?us-ascii?Q?AlgjHmtaVXCrVwAZ68CRsZScpVo6pw9dnAqp9GsNYC63ZUu7SVzh26h3gcTg?=
 =?us-ascii?Q?V0lWBUjqIpfYsL9ira4/jU2ATvD59ESLJg6QhE0nEE8Glgc0L7SWxA1eYWa+?=
 =?us-ascii?Q?5bdsUzYlYznmnvDNneNnROI3E+RMne9Q3HBHVKfEG0S8YuirsJSFkit/Ea9h?=
 =?us-ascii?Q?0AtRo37rw8YIDDhbXcNo8AIjcLVBcGhs9TpJNjJuP+qtsphGx8LgUgW0OWBV?=
 =?us-ascii?Q?mfmGmQ6RO1Qbpb5UANlCm63og5Z1dbMtf0vtwMjRmwxy/gO/8YtLs4qJBrFi?=
 =?us-ascii?Q?RDN9yOAXih0O1Qy83qi5q311hEn1V961L3nNtlIMNDkvREtEWhAmO7taCmvf?=
 =?us-ascii?Q?Ja1SOU81W9UU+U0uhxgr9LryBKaF9fBKBMAjpuEeqDYDmQQTLva7+M6/5teN?=
 =?us-ascii?Q?UwIU6qAiLpRkoRcBR3bGPl09gQYWW1YSvOMvhB0YjPUElN/Dx69ufZ8GUVQv?=
 =?us-ascii?Q?tRN2qM3K+C8H5iLlUO2U0vZ7lXvM/ijNoo8xQZrg5fKZgrB5MMNcb4nJelyX?=
 =?us-ascii?Q?r5LaVrx3DSaZXhPWWZiRDnlsdjDKznrxgHhAD2qVm4+pjiMmSVLCDJZYO1oR?=
 =?us-ascii?Q?R2xUaHhNL3jQFdobOP3S2uhjRSLxIMtdO+1fiIVWTUvuo6iuU4OKUXNPbUqb?=
 =?us-ascii?Q?P8ApQTSbrpsBB1cKX3VjEtrBPTzKbCA4kdrFJbJKmASeHSzz/URV/6SWeiyg?=
 =?us-ascii?Q?oufTtXietcWrfqGXOE5uhIUpqTZgtZ0TZQWkomf+pxOQKLnnM6EHvsxwkcCZ?=
 =?us-ascii?Q?r3XC4Gad4U+MIr3/kq7Bw0RSmBoJ0HRO9/rnQHU5lzmLdjTyNYX11VvTSAeS?=
 =?us-ascii?Q?2BrrsNlZjVd0NFTVLdju/CtADL8L8O0tviR4L5cjkeL3vfe23enBst3jQGR8?=
 =?us-ascii?Q?aLwLpTHkcj9IBBmODKEfNpSHr5zxW1baX81f9u6ui6wqDA9kCFd272aNXnV1?=
 =?us-ascii?Q?sgqikR5jhg/pMz/Cc9csPnuyxNqQAd2WhIb4dXaDclElt26rYm7n9SalY0Yi?=
 =?us-ascii?Q?CK/tqkZY5lnn1OdTs9xAqozOFyd/UeIIUSyATi+CO6d1TSk5BU4ruwqVHCzC?=
 =?us-ascii?Q?e8LSmLrci6gk5nRi4NgKU1+VYDzbqNCx88cV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrvhorlovMgx5G4wkbvpnV4JGSSq+yAnCM8dBIYof8iOlLR/XB3/lV9W+PUk?=
 =?us-ascii?Q?sPiHCB6kQLsVRdlFaMnW5LEkURypwjV4n5EG02jQV5nXa5/H4Ct/lO9z8YLR?=
 =?us-ascii?Q?8RLb0s+1uu7dTI1+RpGTGnxjYeSeZDDQN5jRO41+F/MPOiLIldszGvQSEjch?=
 =?us-ascii?Q?ggX5LRmrwbElD7Nxk5DNzYUy6eRk3vRGlb//G4iINqYKTaAEJhylxQZiIi5E?=
 =?us-ascii?Q?jFK1nLTrukzoDEmmu+PPj6E85M7WgPaEGrpmCdvHx5/LGoL23cAMkquo62hv?=
 =?us-ascii?Q?yKNAc9lYX54HnkcFL18OQZLyFVPn2brToNkcgOXIA6dLeyzHtEtf37Ul/pFE?=
 =?us-ascii?Q?2yTz4OHHIpW4FNT+w5mM1TMndhR6tZQroA+BgRQytKnFX0NTCj0WIvOp9ouf?=
 =?us-ascii?Q?X8iXHOTtuPRnVKgzvmXtUy7jqcMkgdn5CvHgkz6jomCN61xdEKQ+NnEck1W6?=
 =?us-ascii?Q?om8GkdYi2cc0pXkGyUWStmZQX3LcSUeaCyt4lyHMTHCBEwfQXyBN9mSxnLLP?=
 =?us-ascii?Q?uukjiCybyVArQyD86lsUZ1ySwIlacYsRI7Yw0xHAvim5JAvrio5DYixsQifC?=
 =?us-ascii?Q?8EKu3bVrHTns7UX7krplUBACOn99jvzSXUI4fonJYmeWmofSw4E2nNGg6gPm?=
 =?us-ascii?Q?Zk52duwHJHl4vTPumu6ejnlNQPiCg7cw0KqoM/Kf2j1HMa20Tp2cyu7pOG3z?=
 =?us-ascii?Q?HpZEj6ySn4s8I9sHvg3PB13Zki5TMQ9wjoPV4xFR2VAt2AgAGsfxEG9DgVc3?=
 =?us-ascii?Q?cZdbR9AE9cuvbkVf60RBOthQKrm51W6aGgqd1Kz1vSlQeuvp5eI1hPzxnFkP?=
 =?us-ascii?Q?+59dyZj2aoeUTBjA1HFrJvJ2uMrhUZZ1G0Qpg72rAEe/bsnXnx/OOIQOvwq7?=
 =?us-ascii?Q?zxeiHxfVriCQR7wErjsCx4/QesSphn7Lm68AT0hLn1s5w0Wk7Ey25H9X4dy4?=
 =?us-ascii?Q?HO57cOKurQpVKSWZhUpjRJL5d/upDbq+jFAWjRKwuB3mLYc30OzaMahJFxhD?=
 =?us-ascii?Q?j4APLiSkGxjWlBJedDGMGFOGEn5B0BJbDbPKkJnSnfL9kJg2lRzEchG5ebM8?=
 =?us-ascii?Q?13tX9RBT+8cOvxFk5tSkEXi8uEisTCVwhu3A0lNB7Z1qFG3QYNWA7r2xN+Ty?=
 =?us-ascii?Q?M5My89yjFSdmX3h7UfN0UCmdwvP9gYvQnAhSvl6Wvgh96XfUHSbHxBZs7GcQ?=
 =?us-ascii?Q?bMqz8YU7m0XeHVfQmIUBvezSqdrIZdTywiLk3UnItb8vC2R/gJvIM2kwhOU0?=
 =?us-ascii?Q?q8HvzmD+PecMiHIaSQ5zqM3INhgPJUNx4nrFCncapNfL/TxyBbKnLORe+4IF?=
 =?us-ascii?Q?0tGv2Fgvkp0URVEQChx12Pgs/avzPphz1PddcwiCyNLlhvkChhqtyuaKEirO?=
 =?us-ascii?Q?0kw/CZf+NWmjR3p2zxZmoCdfHZbdVFafLP8OyHtiPEcqULaiw46YUOmNqXX6?=
 =?us-ascii?Q?TC/rZj8TzDW8IIYiwOcWAJqsHeZOzRjh08vrTEE14KWi7jLwST2lPL6KYYeb?=
 =?us-ascii?Q?Z/Zer7LFJ/WXNWsy7FuXbRZKPwRqMRwvepw9BfqzE7FqoaIqWhe05yZjdkhp?=
 =?us-ascii?Q?Kq95/N5srtAiLtg1LqlrkGJ7rdyrGzJAjn8HYCbm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4f4e49-6eb0-4591-e4b8-08de0b514bf3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:41:33.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa75tPjtH9I6eY/YMhi6+FgSt3hpigFUgP+4TYwg71ANnktJOUGjYTRin5yY5pkLALbt7yJYDPoZnM1GM/FyqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10703

Allow wakeup-source property to below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pmic@58 (dlg,da9063): onkey: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index 51612dc22748f..4f08e9ac7e564 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -81,6 +81,8 @@ properties:
   watchdog:
     $ref: /schemas/watchdog/dlg,da9062-watchdog.yaml
 
+  wakeup-source: true
+
 patternProperties:
   "^(.+-hog(-[0-9]+)?)$":
     type: object
-- 
2.34.1


