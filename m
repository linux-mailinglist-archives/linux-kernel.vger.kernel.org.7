Return-Path: <linux-kernel+bounces-834511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A23BA4D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA421BC82CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D731354F;
	Fri, 26 Sep 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gkwbDIQw"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8A3112A5;
	Fri, 26 Sep 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909948; cv=fail; b=qQiIXKJfvUXudtDaTxdQ51AWx0bmBIaugW0fQB8IM+REmPgb9a2oN4A+lZK7J3dSQaP2BcH9ahLnttR+SH2176+j2//7TSj6UMZR7bZaabYsD8KqLl5YbbAOu10ipe+9sL1Q701cZq4zXfzhp/9yMQvNI+T3fyaJypNGEY+f9bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909948; c=relaxed/simple;
	bh=ncz5fIMY1NO9IQtuDgYoVkShf5JLZjj53lO/y/N6Tig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9HJIJKFtXeMEKrnx6UpD+XoPCPG+8ZIxxSImibpNt56pXnoyiVzWJoeulwghHX0pgGaOolgO1OmmbDtKAa3TZvGJ0RWbQjeNb4Bf9N5pUaq1S799ALolNx9WL+tbagB+PRhAer5qw6emfX7PK+LsvPLQYMORsvIPtV8tOw2yBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gkwbDIQw; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9kzF4RN6x6a2LlbUz/EaGPfTYIxKvCMaVR9e9XzZ8HHhpn/uCdmE0/9WKnI7tKeTDiHLyz5NmJ9e5EbNXdwJiewTLqqMHaW2yf0jNy0qHdTg3vcaIBkzs6D5fBCkugqIZfWHh+JbphNNmUN9+VtjCefWqwAfJdg9l2Y7TUK/pZBAp8pIGOD5akvNzS4FCTI96RuoBM95kJcc1X/yjpeErwUvSuBrw1TvDgJ7FIBHwacySV8m5eY72nylAJqh9ycd1xc4rc3IDSlpsGDh1BDtefRSEvHCITwlNDLQ4Ejt2CtkxxemSbtrlUUTe1FqFgKTOlY6hggwcqGTkPwrFOeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBDQhiBOD7UunZlOMKY1wZoKSTYFN9s2zvHk+GvVEM0=;
 b=YInDJwUjmjOahWSs1OUTReKyCqC4/ZLJHK5JDaJhJEwL9XtoR0kOAGvgZXmx3e5MY+bzFpeM8Foc2ffu1BIviBhkzcIk3FfA+JnRgmQ3lzwwiS4ZjGS1fPvQV/p82m9R6AHgOvZ8ca91aZKuUNnXpX5ehOYbPb8Te7znQSAYE43KjiI3tBiLeIvEOtSJdLM0vlcqPP3Zt9E3loplxtDI5L2olyyIGW0xr9Q7rUlzALUlhKlLIpJ+xm9pr3diLN4Sc9AK5BUPwBq2cLzcCzNealUofPvoGD1r8UPpud/hCYCNuD7+InRakVe8/Y2wfZ+UBE4udDU+vj00DZvqmXL3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBDQhiBOD7UunZlOMKY1wZoKSTYFN9s2zvHk+GvVEM0=;
 b=gkwbDIQwfkXO6Qbdm18dbH59zmSoWDnnUhT13Siih5L0XSc0sFEqNBNS1k8Kqk87BigzpBpBoyzrp7s/weq4lOsOIqr4Fa7v2d+vIwg+tWQNBpyXDnp8AJ+GZewfhDnMLJqjjoCkM4X1MMNqg7fDQdn1MTxJ6Km6JwtzTSTirtyJ03Iw5g6aGOIcNVrc3i2z+M1rjEIVJB/ZbkSE43dfxtmZFByjJ5AqW62Me+vS+ZUyYMlyWb5cPPGmv1cUaW3H+i9t0+t4YFerUCvVRgR8ZaZ2zx0a6vRZqAjsb73Gf3mAvS9U4FAlMlaqJmcVSBaGzwnQxNNo9BunUbdQ/Y3LFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 phy 12/17] dt-bindings: phy: lynx-28g: add compatible strings per SerDes and instantiation
Date: Fri, 26 Sep 2025 21:05:00 +0300
Message-Id: <20250926180505.760089-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: c5716d2c-bd75-4c40-6234-08ddfd274879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/1M3e2GjI+vA8DQrw4WeOwt6i0dsvhCPnfVsfkpAgAUNGOmSrSoPqJKidIp?=
 =?us-ascii?Q?NxsI2D4D6yFpngHaw1plIHjKr6PUEZuBJRWwaQx8JODnTrbMekoNx7qxg473?=
 =?us-ascii?Q?TLpvGq55wXe7Uw1zUZbyYYI0XdyXZOtvQTeTpMqsubToTkLjepAp520zWTB5?=
 =?us-ascii?Q?3/62q2doUIKSThenFumoBY1AkI+1jomqPo0FeS3xsAtwCFomfZZNxFt7HQaK?=
 =?us-ascii?Q?r7SFcqCuP/pxFrYq71D7uGbz+mo81MHrfQa67i1lm+D+YKwnRD/dnc4fT/iV?=
 =?us-ascii?Q?PVa3xjLncBy72YcBX2hWHfQ/idHnTgdeGYvGjgGUcRyh4FPgbGYCvKGH/a6r?=
 =?us-ascii?Q?S59Zaku5IXZCkYiEqRfGFxRWZEP/cxAppjuTmIHU3tNkop2V3XDYY4nafRYN?=
 =?us-ascii?Q?lzwkblU5H4Ao0JF2ojgoFeoLfJ28HYRGGNHzj2hMleEqI34vxCg8YEadnBXk?=
 =?us-ascii?Q?nYj+1jaH0E5Mh3xZueLCdoSOcyRImFyp+9xKvUWhE4sDLd9lnxLrB3gbh0Mb?=
 =?us-ascii?Q?eiFtG+2agrobHimq8fdrUdwVWqXTA/Rf8IR3fGlCag5DfAm3T2fw1UruYkZh?=
 =?us-ascii?Q?7XzPs+0eMh+GrJ0FGFy059DAGLKvS1qlpRRIcKuKg/4crsqAzW11ZNcgw6mq?=
 =?us-ascii?Q?ymsedoAj/9cuFlzQLBYQsq/CdU4bvwoNv4w2vPJj2sMBOYZaEQeG19o7/23U?=
 =?us-ascii?Q?1E3sVI/5kRzQgUQSqEFRVSvfhdUIfy3kAz+9bygRlkF6hvGyFQonw1Co56g1?=
 =?us-ascii?Q?pLh90BHI3M96t04BStN9Fvjgj4kvKuQPV8m1hoKlvCg9IpQ9+wYy0RfBiRpG?=
 =?us-ascii?Q?ouHshRKYtbIegcCEITxeJqL7HiVpTRgGdcj24DXO3XKypypyeCAaI1P9ozC6?=
 =?us-ascii?Q?hadrNFiy7thQXk3UvhlheH4IjFMFHEdwAdGztb73LdlmdbCQWXwzC5vhVsOX?=
 =?us-ascii?Q?6pTqyPQjiYwAD6uWTSOWY+lL4JRE82EyRLZ2Xs9Yirun7meshWtE02PCgA46?=
 =?us-ascii?Q?BhSUnmrBIgZo0yebD8kl6D0KJLhOO5cG+d1gTGyBa86l/SbzDu76h2/Pf4by?=
 =?us-ascii?Q?EwawWP87tZeW2y8oNFGojsdnxvI8N14Vg0eTUUD3gWM71dLCACayUrodYF4N?=
 =?us-ascii?Q?pGRi5mBIjw5y1ufRjv9vwA33gNCdq1tmp2mG3rJcILYLmiBcu7zpDp8d/XHO?=
 =?us-ascii?Q?eVBf+tT208KVl7+rLu3xpyKp3xlqjyqKJnVdo+pw9ydSu6R0GVJlcJcmD5OT?=
 =?us-ascii?Q?8Z3vwjaDnbf1xMPSZs86Fek/2jbhAKqIBcfhssJf9VvgdTm+eEnzGWRRGqQ5?=
 =?us-ascii?Q?1CLp6pDiH//3p2PFTXX10FLmPqDVuW2OvQoVoSWtBZV/7eHIqAeYfzaNoicb?=
 =?us-ascii?Q?09hdYO6VAp8lTRF56vMyZidE7UtMCi7M/xLYTcoQDY/IPBK7iFSYpRU5aTY1?=
 =?us-ascii?Q?p8nQPl1fncgpSNgLlGSBcd7hmoIUZ/g5XbUPFRFuysYr2eQozu2pSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0TV6e3csnXBJlVYJIWkBt/YwmfH0bfmUzA6Hpqo7fSwbMkZBx09IIVvowqT?=
 =?us-ascii?Q?UYlh7kCAlNlFM0TRTytqQmXl6XIBkBcQByA3UieJNw/A7mFSbgCHOUZk+0PH?=
 =?us-ascii?Q?yAXqoNwKUv2FZWQhrxfUqbPQ0uoOYzQ2SGsJLXqeDkAWZAcwapcdyDMCoslE?=
 =?us-ascii?Q?fTKJyTwTAY0cO+r0iRS/oADWhg6G9kubFs4WuKjbGdeTHZaj2Km/Xq5Gz8+j?=
 =?us-ascii?Q?qoNYWzhT6tyvuqlbiGz8ZeeiK4PlEetZPmmlJngD4N0e+xPXgFenk+u3/Com?=
 =?us-ascii?Q?Dx6fGHWGwnDvClgfMpuTw8OOVpZeI/Ksu8btMU/cY9qbC4lLUVDVDHP6b88o?=
 =?us-ascii?Q?xZ8L+HAVC7ukkq/fTQBMS7H/Dra+TDZ5QiSk5j3E8oznfRMGtenii2ZCt0LP?=
 =?us-ascii?Q?cZ0W0XFe9SaNaO+lVC+6fxLBG8lfnoXwg5u5hLjVoFMyYuFWu1+XMxhGbT9/?=
 =?us-ascii?Q?36nUozxUQ21OW8dW09fbW45OhkbvZNDz8uvytUEsXhc4IPCqoIjNHsajibcE?=
 =?us-ascii?Q?2OJ2Luuy+o/mwUDku7OA/oT5/cYuWrG9DTUtRVPcvypglOBwXJ0QD+5CW3XO?=
 =?us-ascii?Q?zLqawmsAbLsac02kAIBDULZhSSq1LttzCmxM51CWtUcv2Uypa5ETFllVsIrS?=
 =?us-ascii?Q?ZBt9S1mURp0mWWYOX2uHzZs0Q50wCqvq0FnaT1lYT6LByxMlaJcUZOf0aNry?=
 =?us-ascii?Q?SYnzGbU0pvaPdmsUgyhBcXBp428xkYtd5OYp1r3fHIP6j7M6RXnTorqu+twp?=
 =?us-ascii?Q?t3pLNCQIcI5NZZwdClQuWT0iyUWIkP75hs+xs47oDDYM9tbGogJNtIWUvp32?=
 =?us-ascii?Q?6N7/M7QC0KZbbkUX3P/qFCOpx2R+y4kdENXz6yMj0WiOcdIURa7As51g4TG4?=
 =?us-ascii?Q?ZhX8ysvl/jN11Xl7wxOeTts9CQIh1jJQWBlD34i/i5uIgTiw5CPeJsqJEjan?=
 =?us-ascii?Q?CI3jGiwbifkFwm2E4xpbdXiUAPnF6YqXOBlL19KHYQnfe1ITnp/Rrg8UveDi?=
 =?us-ascii?Q?ek7Aqvuy0D2vCbuY2C2L9bp/wO7KFvKO6cUhz16c1rxRPNhlFVFyNLNngZR4?=
 =?us-ascii?Q?UES2N1gUcBKma7kW6khiMz0LnZC9HV4D6kEVjNYv2hbZd3v/h05BuJH/8EUr?=
 =?us-ascii?Q?PEDhs0dF+D+hmiJiM0mcduQ5soECVJOTKmR2UH/A2XV7h0wwr4mq2LYn9nyj?=
 =?us-ascii?Q?iM1kHM3v+1Vs/UDwZvOcAu5qxDj5+7qMOJHyDq4QaGDSDgGT1Bx0Xuay8+Rr?=
 =?us-ascii?Q?ST9jW3D654R/K/9jDQDy17MYUQUam0AT6Skj+X0hrcIMp4saMo2MAY2JlBcq?=
 =?us-ascii?Q?eIy9vE3vDgPt0kqGdlX0/vDKLd/1IsWeVOBpcvozzRHsJyz5MY6sdV2K9+bV?=
 =?us-ascii?Q?eVF1aHLTfXZ2TPTQyawgcn7goxPHi4pZ3EV3KXA+1CmK9GWhrydmdOfUhqea?=
 =?us-ascii?Q?FwWsOxH9fL8ZNj99a2Og4g7OptkY7c/BtYrRLoMPyjpgMZvlS3gR7UE+JysJ?=
 =?us-ascii?Q?YhMPO7wO6OfaEKNl62UwdXhGGLt2GUQ7lU4c1YIW7TDerUlHcaIsTs8NpLMH?=
 =?us-ascii?Q?Pdf35Aot0i/uJFyrumxY+BnZ28HhRLqqMUr7466rPuBWJ4UfGPMfBVozRW4R?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5716d2c-bd75-4c40-6234-08ddfd274879
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:32.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PduPJ2VTL3tGV6cePQDzTjl2Cychr0d6HUEXMpLGw8M+p64njXqNrEJRgJzTxqvnPeGVPkpZ3Qp4cXJ91DaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Going by the generic "fsl,lynx-28g" compatible string and expecting all
SerDes instantiations on all SoCs to use it was a mistake.

They all share the same register map, sure, but the number of protocol
converters and lanes which are instantiated differs in a way that isn't
detectable by the programming interface.

Using a separate compatible string per SerDes instantiation is
sufficient for any device driver to distinguish these features and/or
any instance-specific quirk. It also reflects how the SoC reference
manual provides different tables with protocol combinations for each
SerDes. NXP clearly documents these as not identical, and refers to them
as such (SerDes 1, 2, etc).

The other sufficient approach for Lynx 28G would be to list in the
device tree all protocols supported by each lane. That would be
insufficient for the very similar Lynx 10G SerDes however, for which
there exists a higher degree of variability in the PCCR register values
that need to be written per protocol. This attempt can be seen in this
unmerged patch set for Lynx 10G:
https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/

but that approach is more drawn-out and more prone to errors, whereas
this one is more succinct and obviously correct.

One aspect which is different with the per-SoC compatible strings is
that they have one PHY provider for each lane (and #phy-cells = <0> in
lane sub-nodes), rather than "fsl,lynx-28g" which has a single PHY
provider for all lanes (and #phy-cells = <1> in the top-level node).

This is done to fulfill Josua Mayer's request:
https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
to have OF nodes for each lane, so that we can further apply schemas
such as Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
individually.

This is the easiest and most intuitive way to describe that. The above
is not the only electrical tuning that needs to be done, but rather the
only one currently standardized in a schema. TX equalization parameters
are TBD, but we need to not limit ourselves to just what currently exists.

Luckily, we can overlap the modern binding format over the legacy one
and they can coexist without interfering. Old kernels use compatible =
"fsl,lynx-28g" and the top-level PHY provider, whereas new kernels probe
on e.g. compatible = "fsl,lx2160a-serdes1" and use the per-lane PHY
providers.

Overlaying modern on top of legacy is only necessary for SerDes 1 and 2.
LX2160A SerDes #3 (a non-networking SerDes) is not yet present in any
device trees in circulation, and will only have the device-specific
compatible (even though it shares the Lynx 28G programming model,
specifying the "fsl,lynx-28g" compatible string for it provides no
benefit that I can see).

Change the expected name of the top-level node to "serdes", and update
the example too.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3:
- re-add "fsl,lynx-28g" as fallback compatible, and #phy-cells = <1> in
  top-level "serdes" node
- drop useless description texts
- fix text formatting
- schema is more lax to allow overlaying old and new required properties
v1->v2:
- drop the usage of "fsl,lynx-28g" as a fallback compatible
- mark "fsl,lynx-28g" as deprecated
- implement Josua's request for per-lane OF nodes for the new compatible
  strings

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 159 +++++++++++++++++-
 1 file changed, 152 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index ff9f9ca0f19c..e8b3a48b9515 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -9,21 +9,123 @@ title: Freescale Lynx 28G SerDes PHY
 maintainers:
   - Ioana Ciornei <ioana.ciornei@nxp.com>
 
+description:
+  The Lynx 28G is a multi-lane, multi-protocol SerDes (PCIe, SATA, Ethernet)
+  present in multiple instances on NXP LX2160A and LX2162A SoCs. All instances
+  share a common register map and programming model, however they differ in
+  supported protocols per lane in a way that is not detectable by said
+  programming model without prior knowledge. The distinction is made through
+  the compatible string.
+
 properties:
   compatible:
-    enum:
-      - fsl,lynx-28g
+    oneOf:
+      - const: fsl,lynx-28g
+        deprecated: true
+        description:
+          Legacy compatibility string for Lynx 28G SerDes. Any assumption
+          regarding whether a certain lane supports a certain protocol may
+          be incorrect. Deprecated except when used as a fallback. Use
+          device-specific strings instead.
+      - items:
+          - const: fsl,lx2160a-serdes1
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2160a-serdes2
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2162a-serdes1
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2162a-serdes2
+          - const: fsl,lynx-28g
+      - const: fsl,lx2160a-serdes3
 
   reg:
     maxItems: 1
 
-  "#phy-cells":
-    const: 1
+  "#address-cells": true
+
+  "#size-cells": true
+
+  "#phy-cells": true
+
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    description: Individual SerDes lane acting as PHY provider
+
+    properties:
+      reg:
+        description: Lane index as seen in register map
+        maxItems: 1
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
 
 required:
   - compatible
   - reg
-  - "#phy-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,lynx-28g
+    then:
+      # Legacy case: parent is the PHY provider, cell encodes lane index
+      properties:
+        "#phy-cells":
+          const: 1
+      required:
+        - "#phy-cells"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,lx2160a-serdes1
+              - fsl,lx2160a-serdes2
+              - fsl,lx2160a-serdes3
+              - fsl,lx2162a-serdes1
+              - fsl,lx2162a-serdes2
+    then:
+      # Modern binding: lanes must have their own nodes
+      properties:
+        "#address-cells":
+          const: 1
+        "#size-cells":
+          const: 0
+      required:
+        - "#address-cells"
+        - "#size-cells"
+
+  # LX2162A SerDes 1 has fewer lanes than the others
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,lx2162a-serdes1
+    then:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              enum: [4, 5, 6, 7]
+    else:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
 additionalProperties: false
 
@@ -32,9 +134,52 @@ examples:
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
-      serdes_1: phy@1ea0000 {
-        compatible = "fsl,lynx-28g";
+
+      serdes_1: serdes@1ea0000 {
+        compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
         reg = <0x0 0x1ea0000 0x0 0x1e30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
         #phy-cells = <1>;
+
+        phy@0 {
+          reg = <0>;
+          #phy-cells = <0>;
+        };
+
+        phy@1 {
+          reg = <1>;
+          #phy-cells = <0>;
+        };
+
+        phy@2 {
+          reg = <2>;
+          #phy-cells = <0>;
+        };
+
+        phy@3 {
+          reg = <3>;
+          #phy-cells = <0>;
+        };
+
+        phy@4 {
+          reg = <4>;
+          #phy-cells = <0>;
+        };
+
+        phy@5 {
+          reg = <5>;
+          #phy-cells = <0>;
+        };
+
+        phy@6 {
+          reg = <6>;
+          #phy-cells = <0>;
+        };
+
+        phy@7 {
+          reg = <7>;
+          #phy-cells = <0>;
+        };
       };
     };
-- 
2.34.1


