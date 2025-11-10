Return-Path: <linux-kernel+bounces-892694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA0C459F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475CF3B72A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A490303C81;
	Mon, 10 Nov 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dp2cQoq3"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3D302CBA;
	Mon, 10 Nov 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766601; cv=fail; b=NostHkNiPVCR7CaotjagVwZB7GeF25GwnuCDdB3fc/+ES64oZ02DrCoQxRyiFfaGbpE0zbk3NlMfkdLQAsI9INRCLn4QFbRtdPa7st7tmVB1m2K3ACvWoTGZMYiLuOfYD+x9iN+/GfCIyoHk4LojXj3RbrN8WvGWlx7TbqNT2So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766601; c=relaxed/simple;
	bh=nNG0d2oKKImTpxb+medXWKHGiruLXQrpJvjnQlD5XQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gy+I9ONOKbOiyv+CtJrXf3py20iqZ3jcPLEWCLdD9s/cSBatYKPYIbE/zWabRUB1TZ9KMJU7+MXehUCwLtYRQ6GQFOVUbLyLLsjS+kInmfsbE2TNbDwAZbBCRSyO/qWeiJVB0ht9ZhflvpVANp1iYZYM08DA/d0+xcAQIVTFYk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dp2cQoq3; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly7veVpTyWOB8WGcIianMjykeaXXD6dTtSRyOO8Z+PqiMBZe+a2CRX/LHtjFveIXzE8aUXy2STZLnJIsDgNjaHW/PH+J8lyL3BpxlnDfDuSTwhrT/A+jNbDFBqS9jLAlQ2voh74RM9P1i2WLJuGc6sFVpjFr/6k6G2jbbG6p/1E7LgnyMWJV7XKCHm2E7lJBE0h4w9mGkLeK+fDOHMhVgoH+2t0W1at2htoUTjqbyfjoCsj7voGt4JXDMpfVjMm5R4r+rvU8i21UuGC7DhTkdqeApp3EQDu7ysDsZQBThAj0giIuK8jtKznRbNGHQOcwca0YR8goU67TRsenRwBCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6V56qS5LFJ/LQdqBUa6lF/WBThqSQnrlIAGEUicuOU=;
 b=BPZJgL1+WCAUjifp0SBmkAHzXranHhqvNYyh8ZoHpGb8arpjA4oOR0b8nvUI0L9lXsYtNHu+O+8sSrfTgVVSnCpcXO66UXvi6UaE7CsiTCj4LoD52iaakpB4U1+LUvdojrnVz6D6ShD/pzmFaOlnNKh2Mc4wi+dZOiCnuQ3z+JWjz0LK99395u7/aOyULtpPTMwIeoVMcdUPHtupVbXm+ZO/2aQkguVOp7u6YTzK0zmXVg5mCGZMwW90292D4AN9HXcMAT7DtK4PVnBp5rQXcF5QcYdsotrryoo6LGjiDhzgEeOZ6740YylUNat4xTPSQyjIUzZ/WbEON3NusHJHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6V56qS5LFJ/LQdqBUa6lF/WBThqSQnrlIAGEUicuOU=;
 b=Dp2cQoq3JxYG5OvDPOdA1q/lGKoV/L6qU8qDow1pfaPr8OhaUXMhIGwcOA39uMRMyPDz5lLSdwebpAclMAnSeGQf5e6IU3dYEEb6Oh6DCdu5ehqyLrV5QIj7aqXkkWe4tx8KZsxPOGJmem7IFyY24vkwEWdpSvQdVV0ylCBR8bRJdBA2vFod6l7l1CRwJOWhe0+iYTgSyfEkDzww3MZVwvvH8uc3MtpkPTHJwx20CCBdABx/8Ub5R59dnvoYR0MA+paPErAh8QUyaZbgoCM7gpvbEmFt79BoN+J5GDPlcVdKiG4B2HKK5QHTr02qIpplgDIk3f6BK5OV0y93BigzUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:16 +0000
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
Subject: [PATCH v4 phy 16/16] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
Date: Mon, 10 Nov 2025 11:22:41 +0200
Message-Id: <20251110092241.1306838-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ce343e-3d6c-4d9f-2ce1-08de203ac746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ifLaf359OMwVtSco86g92nwk1GkI0Bm3KR0W3H/wzU89gQ8SWAOsbOFJZk+E?=
 =?us-ascii?Q?2Ls3Cr2Qe1NM7h5qMHjjV6x2DbqcLNhlEIY3RKJDFS2bWoubF3JBrAz22G/n?=
 =?us-ascii?Q?srNzTHyecf7h2PRIXrnbVmgA2sY7kwz776B04QYpsLGjsYmTmD/J5dUCFyo3?=
 =?us-ascii?Q?Y9zy1qY532xPq7oQ5r8vObPP3wj1zkabagAk5fKLyTpGmAFRlE5ue/Alb4Qe?=
 =?us-ascii?Q?+AHvP1hDnD5lqIQbEQmTHzjrrdsYrmMrRhJ60DUlSfOTzLTU602MDYD8Ua1U?=
 =?us-ascii?Q?i1CVIz2PUvw9F2Llx6e73U+GQWAFf1nLfXsJZMqWtDOnVJFedMMDPFvashz1?=
 =?us-ascii?Q?9511DVVqJhtT66VVLuCtYabNzpyrJfh4Xe2/0kLEuY4IZfFGV9g7Q0vX2O+4?=
 =?us-ascii?Q?r3QHZJl7OxPqRaHi+ouU968a7WLhyBZT2nkKdI/7iZ/U5SF0TwxMHUpccEol?=
 =?us-ascii?Q?R2MEPC4jYsoDw/evp1dhvWWWyYkolve6WseGxXfYquyWW5YTvBr0PT4lC2JP?=
 =?us-ascii?Q?HDv869pOAHtJUJyTrfvl22+rXwBFfdjO7ZJ9HvrqPoUAVUHQNyXJIkJDiz8U?=
 =?us-ascii?Q?9zB6KoVTDpQu518lt9nAkRL0WTj9oy9Tf1Lhct3KmTmL1hKWz+VB3w0B4/hY?=
 =?us-ascii?Q?3tG+S8iSqOVz4vPdc7zTCcW+MDVMxgGa+9DWYjEWaIREz/O3bB+/HtxvgOSI?=
 =?us-ascii?Q?E7DMXZyd3SeEN7+Kgf+rcGcQeRC0bAfeYS/KmGR3F7rKlAwhOMvAFGZO3+9c?=
 =?us-ascii?Q?TGi1bYMW0kOgs7tBnUNZuzHjp/N/7Oav5jaz+q+g+6d6j4BWWYBKGvdg8sbJ?=
 =?us-ascii?Q?y7ASx+8EVHYmVawER3UYnoSCFp6pvRwbbNWQiPaNLsgUvtcAp6U5kI43M4BY?=
 =?us-ascii?Q?T4gvXM0F9gRHURcGksXZL6es1000dKASvIjV7VmgzdN312MH7tEI4LNmjnCU?=
 =?us-ascii?Q?xCgMcK3UmhlgJWH9dyrBkajp2f4awgxIoc/Bhy4EwCIOPYcsHbawN+dK5AqK?=
 =?us-ascii?Q?RDHc2aZ3MD9sx9EIJjOnoyxLxcnZXk6Qqp+w+Ez35c0CliiF7k2DIJqR4Fo0?=
 =?us-ascii?Q?Xs/DoVSZ8N0qhwYyYklYeAwxNHo0MvWtDM4KQo1YN4W5nf8FMPeDIbjzz1pS?=
 =?us-ascii?Q?yUpguKuQYUcbdth0fHwtJPMuULOpploxTpOKUsmi1mVgscK8/z2VZvN7vw3+?=
 =?us-ascii?Q?ozpspNsyt0OvGthSVZ2wYVkNmW/43Xn9OaCKqZu206YdlqqkiyUWeO9pDfxF?=
 =?us-ascii?Q?ZdPcKD3vEGZ6wQJqdmyn5XTbxQ2/JMrhhPp5EnnJhbwcJOStZqKA8Uaszz7v?=
 =?us-ascii?Q?pGSoEltU0btWJQCyA/zV+EuIbLGzMAcoQMyGR5HKu7IsKqUug86pR+l5Vqyr?=
 =?us-ascii?Q?tR2D2Uyjdq83BEj4lHs4N7xbn7ZpjClojkF1acIznwpkwmuWg/ieu33IimfQ?=
 =?us-ascii?Q?YImZmDMg4PvxQPKmiCwnlrwJsw3y0yX8zNl1zYDNkIDW84D2qkzTpcA5aLqw?=
 =?us-ascii?Q?J0cF7Nyq0Wi3ZFQUk4vGFZDGMQaLgeVhjSq/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbRoEdwHFZJjMbsXg/E9YWGXyYM0wJ5+ZkJ6Yt5HERPC29gVY0sYOgzGtiOe?=
 =?us-ascii?Q?q3J7Uys9nrnYBXdn+wyGwP+lrLBCi49rIA+OdSm9lMsIH4VeKypQdtLtuxQF?=
 =?us-ascii?Q?YzHh5ESDvILn0r9bJV37XaUCjro1hcuqw4Xgld8uwhGUTnoHagoX9hhoMf/M?=
 =?us-ascii?Q?j0YVq24OETaN863yGl3WVImP4e0lNB1j52PzdIppBwSv9QQ74iVeMGbUu10c?=
 =?us-ascii?Q?0IWPOejJyOJ87p6K8EMLmusDLqzQAy6MmX/LTJv1/uk04KcFxZ0FRSE30gUT?=
 =?us-ascii?Q?BV7YMj+DxiACZ5LIeCJRq3RiQvbmuZMNH7AYzLUxoI0KmqAXNcXDbYySOgSg?=
 =?us-ascii?Q?/nESePTaYxFddyCe+eGWBMOeXZevETDy6jEvb+Hqe+PYYKsgd07kuGdHVnCy?=
 =?us-ascii?Q?i3QqhvE4hEJ5k9co/hhoGT2xxHR8YSc42OtcY5eA8rzTjLIsWKz+e5PQsQqI?=
 =?us-ascii?Q?GUiEuC+tioxlrfpVvEj0uAiF9vcKXHt8naIfB9s5xqWWezaEa+rYFdFGYp0C?=
 =?us-ascii?Q?qsqN4jIYBdrHYXDCz7ec2wZpVznMJWt0SuvRRvG6Fqenr7eVImcs3fxGopwQ?=
 =?us-ascii?Q?zyhD2bkRKEDIG7utfsiAbomAlTfsNQfcrGlvC9sNz6oIVcaj+THuqeIBFWQM?=
 =?us-ascii?Q?GVILj4iNjTeGzB8AUJ95zEVIkALipMX6BmnZ1M95kI6mSXfASDHuTlN6sLYS?=
 =?us-ascii?Q?aFqMAgSvAADWug5oCgpKlqXQNA+CTx07dv3WKlRMmz1wTKqExDKx7Ar5VdCr?=
 =?us-ascii?Q?Lml0ddO9ZB8EmzrAEiee7uqcWoUH7AW8Jw4xxC/d6UfdcPTHAERmiQegyezY?=
 =?us-ascii?Q?T+yTjUfmqqLodkbwrgaXAzPMSxW0JAIdWOgy26g/6+oWZ/KFD+dT2OwNtQW7?=
 =?us-ascii?Q?0c0eKTZY3dB3+vmJwQOjPyEPG2qpypLyLLjJwFB6i3/o4FTWT2i3WFr4pBsX?=
 =?us-ascii?Q?NBITNRz6iVvz8k0MjDukcj+nq3b+R7b1yGnUDV9JH032uahmyyxDTlYs5Tkm?=
 =?us-ascii?Q?uEePobDkYsNlaDKv76SCHEhISdvwm7/9XGSqgZmEuFE5A7o7YLBE018Rbkak?=
 =?us-ascii?Q?FFTwiI1z0+FrdQytQY2fMGQEfPYm64lmr9BQ4oOobJie01hEc0QBgymRnlOA?=
 =?us-ascii?Q?LQDYOv/Y8rL6Ig7AmaSTLpGcTQxxQ78ppX4UUJ1vrfUlkE46yvT+VV6W7P7G?=
 =?us-ascii?Q?ARIxCBVo/O1j2k7F9SijleW+yVbUmyRl+WbiNcsSCZ2W0fi+bNlsK72VaiAv?=
 =?us-ascii?Q?en7u0JsuxGJi129G/Cw5sE5QOyaWS9IcOuarxWX+Nvn0S61zTdRsA1pd1rew?=
 =?us-ascii?Q?8+3cZZDqgL3v9CI5ZJCSOXQu08+5eNQwc/wUPeOE/pQfR7PjMMIx4TolDVsd?=
 =?us-ascii?Q?UPQ4OpnannwxAFoiyCX4mY2ot1diC+dUjouwpbgmYgPPQYgshEG13BwOKgMi?=
 =?us-ascii?Q?NtigUJ156mSzzL6QJZjcd5qhf0wIPNbbYGcc4iqs1NC5SpS7QZZqrybdi3bZ?=
 =?us-ascii?Q?sz9TpZKjlHvF9/L6+h85k0LprNKxAkurUowETz41I34s2bXT3FAK5NQzpMU0?=
 =?us-ascii?Q?wsM0k9lPkbfK114NwvEnQ2ZEsdB5wNgUkuUQSSPbS436Th38lNURVKqZvKKF?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ce343e-3d6c-4d9f-2ce1-08de203ac746
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:16.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mX767hOhU5Ta72CnU67BasnztjPlcRqDAW3VUSbgvHZB3APN6Kwl/0DZSpkDg0b5pf9A9AKM6aRMc/NlvBEeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Add driver support for probing on the new, per-instance and per-SoC
bindings, which provide the following benefits:
- they allow rejecting unsupported protocols per lane (10GbE on SerDes 2
  lanes 0-5)
- individual lanes have their own OF nodes as PHY providers, which
  allows board device tree authors to tune electrical parameters such as
  TX amplitude, equalization etc.

Probing on "fsl,lynx-28g" is still supported, but the feature set is
frozen in time to just 1GbE and 10GbE (essentially the feature set as of
this change). However, we encourage the user at probe time to update the
device tree.

Refactor the per-lane logic from lynx_28g_probe() into
lynx_28g_lane_probe(), and call it from two distinct paths depending on
whether the modern or the legacy compatible string is used, with an OF
node for the lane or without.

Notable implication of the above: when lanes have disabled OF nodes, we
skip creating PHYs for them, and must also skip the CDR lock workaround.

lynx_28g_supports_lane_mode() was a SerDes-global function and now
becomes per lane, to reflect the specific capabilities each instance may
have.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- the introduction of "bool lane_phy_providers" from lynx_28g_probe()
  disappeared, and the whole "is the SerDes a PHY provider, or the
  individual lanes?" question is now handled by "[PATCH v4 phy 03/16]
  phy: lynx-28g: support individual lanes as OF PHY providers"
v2->v3:
- reword commit message
- add some comments regarding the "fsl,lynx-28g" fallback mechanism
- skip CDR lock workaround for lanes with no PHY (disabled in the device
  tree in the new binding)
v1->v2:
- remove priv->info->get_pccr() and priv->info->get_pcvt_offset().
  These were always called directly as lynx_28g_get_pccr() and
  lynx_28g_get_pcvt_offset().
- Add forgotten priv->info->lane_supports_mode() test to
  lynx_28g_supports_lane_mode().
- Rename the "fsl,lynx-28g" drvdata as lynx_info_compat rather than
  lynx_info_lx2160a_serdes1, to reflect its treatment as less featured.
- Implement a separate lane probing path for the #phy-cells = <0> case.

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 202 ++++++++++++++++++++---
 1 file changed, 179 insertions(+), 23 deletions(-)

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 127 +++++++++++++++++++++--
 1 file changed, 117 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 649c5c2fa4ad..906cd1a4af19 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -433,9 +433,15 @@ struct lynx_28g_lane {
 	enum lynx_lane_mode mode;
 };
 
+struct lynx_info {
+	bool (*lane_supports_mode)(int lane, enum lynx_lane_mode mode);
+	int first_lane;
+};
+
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	const struct lynx_info *info;
 	/* Serialize concurrent access to registers shared between lanes,
 	 * like PCCn
 	 */
@@ -500,11 +506,18 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	}
 }
 
-static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+/* A lane mode is supported if we have a PLL that can provide its required
+ * clock net, and if there is a protocol converter for that mode on that lane.
+ */
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_lane *lane,
 					enum lynx_lane_mode mode)
 {
+	struct lynx_28g_priv *priv = lane->priv;
 	int i;
 
+	if (!priv->info->lane_supports_mode(lane->id, mode))
+		return false;
+
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
@@ -687,6 +700,86 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	}
 }
 
+static bool lx2160a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2160a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return true;
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return lane == 6 || lane == 7;
+	default:
+		return false;
+	}
+}
+
+static bool lx2160a_serdes3_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	/*
+	 * Non-networking SerDes, and this driver supports only
+	 * networking protocols
+	 */
+	return false;
+}
+
+static bool lx2162a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2162a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return lx2160a_serdes2_lane_supports_mode(lane, mode);
+}
+
+static bool lynx_28g_compat_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct lynx_info lynx_info_compat = {
+	.lane_supports_mode = lynx_28g_compat_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes1 = {
+	.lane_supports_mode = lx2160a_serdes1_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes2 = {
+	.lane_supports_mode = lx2160a_serdes2_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes3 = {
+	.lane_supports_mode = lx2160a_serdes3_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes1 = {
+	.lane_supports_mode = lx2162a_serdes1_lane_supports_mode,
+	.first_lane = 4,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes2 = {
+	.lane_supports_mode = lx2162a_serdes2_lane_supports_mode,
+};
+
 static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
 			  u32 *val)
 {
@@ -939,7 +1032,6 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err = 0;
@@ -951,7 +1043,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	if (lane_mode == lane->mode)
@@ -984,14 +1076,13 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts __always_unused)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	enum lynx_lane_mode lane_mode;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -1067,8 +1158,10 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	u32 rrstctl;
 	int i;
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
+	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
+		if (!lane->phy)
+			continue;
 
 		mutex_lock(&lane->phy->mutex);
 
@@ -1127,7 +1220,8 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 
 	idx = args->args[0];
 
-	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
+	if (WARN_ON(idx >= LYNX_28G_NUM_LANE ||
+		    idx < priv->info->first_lane))
 		return ERR_PTR(-EINVAL);
 
 	return priv->lane[idx].phy;
@@ -1167,10 +1261,18 @@ static int lynx_28g_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	priv->info = of_device_get_match_data(dev);
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
+	/*
+	 * If we get here it means we probed on a device tree where
+	 * "fsl,lynx-28g" wasn't the fallback, but the sole compatible string.
+	 */
+	if (priv->info == &lynx_info_compat)
+		dev_warn(dev, "Please update device tree to use per-device compatible strings\n");
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -1194,7 +1296,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			if (reg >= LYNX_28G_NUM_LANE) {
+			if (reg < priv->info->first_lane || reg >= LYNX_28G_NUM_LANE) {
 				dev_err(dev, "\"reg\" property out of range for %pOF\n", child);
 				of_node_put(child);
 				return -EINVAL;
@@ -1207,7 +1309,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
-		for (int i = 0; i < LYNX_28G_NUM_LANE; i++) {
+		for (int i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 			err = lynx_28g_probe_lane(priv, i, NULL);
 			if (err)
 				return err;
@@ -1233,7 +1335,12 @@ static void lynx_28g_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id lynx_28g_of_match_table[] = {
-	{ .compatible = "fsl,lynx-28g" },
+	{ .compatible = "fsl,lx2160a-serdes1", .data = &lynx_info_lx2160a_serdes1 },
+	{ .compatible = "fsl,lx2160a-serdes2", .data = &lynx_info_lx2160a_serdes2 },
+	{ .compatible = "fsl,lx2160a-serdes3", .data = &lynx_info_lx2160a_serdes3 },
+	{ .compatible = "fsl,lx2162a-serdes1", .data = &lynx_info_lx2162a_serdes1 },
+	{ .compatible = "fsl,lx2162a-serdes2", .data = &lynx_info_lx2162a_serdes2 },
+	{ .compatible = "fsl,lynx-28g", .data = &lynx_info_compat }, /* fallback, keep last */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
-- 
2.34.1


