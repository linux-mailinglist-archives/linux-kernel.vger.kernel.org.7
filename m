Return-Path: <linux-kernel+bounces-829589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB0B9765B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98299322587
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2530C603;
	Tue, 23 Sep 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YqDDSmAT"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2B30ACEA;
	Tue, 23 Sep 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656732; cv=fail; b=gSK9RbbEkzVafgsCI93UJxcMKp8TBllPlaK+J+t82MdL6GWJncVBD3UM3sEhKeoVzetwxuODCfhEUoY8vG4c2OG/HFWEtPzJNoQafJZUV6NfRfmC0Gu5j115FyIV+GB6qzpt+XBFRYekpGsBCaG236YPA9XxmzVB2eOWkhNfVa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656732; c=relaxed/simple;
	bh=305ZE5JQb6Vq9eBIZ1GqpAr45nDjKixty4Thjxum5AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+JHQdkBn/anrDhrezkr0HMeU7Pqh4A2VJbZRRDRuKnOjX6q/9Rp27oXqVcE+gihWikX2Sh2F1k+XmWmjL4E6lSQBji4innzEYU6fvuLXGTllBNMVpdozuR9YHTevUgPoF3HcrDCWa7YwFnmDQf7nhwPfgWkfJ5Azv/QkJFn8qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YqDDSmAT; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZoBDk8H83lyqikNK5LRS3dCJWHvvBZWyiS3DZKOQIj5jR1QQgaNxgBzk4vomxT/OZxG5KCkGTOyZlFvxAqEO1hmpv6K4YPrRBtUK4KcEfpT784Q3rmsWpA6o/Ea7ox0Pnx35hzYTIPSd59ivaEW5FtyBHi3KQVOfGNnmguHGNcngeOeX067Zt0L8srzsDyB5bYRCrnQwN8UXU0IYif5cxQ+VwM3LiZ8MF6KdkFCZxxKpI0kYojpxKPwp2aK991kWzN+ivdNALFlhOffXAl08kVd8Fv3v6iarBqYiZjLYVj/vfiKct9/gzoj9wOHzq4XtweIxSiDMgobygQajCxswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMGdN6mL25yQ6KL5LYFI8Zv/EBSd16dVYOQ3b2Srjjc=;
 b=HQY1sAiHQyYixUJBQjhyxs9h5wpAg84j33MNlkT58ad7yAO5nPJceBqgKeTHQbuwUbwI/xyurZ2QkaNAs/26ewLtV77yGWVeuoVMb1kegUZNDZcWICYR3Za/qmB7yAQot7TD9JhR7IBcPnYSEpf5cw13aYrgBL5EH6qnFvclceDU/j3lSVN01GYTC9Zv3r4HMtkheS4PkZjv2hoF18AreVWu8J2VPOkxktV8Eg5n46WHuRcylCL9ns1IabX/6KOwOMFWJbMl/lXhPMxiscKxQYVxDKUbDX7WW3DP7DkbO2QcuDdujWCzwhBW65hqX0XQZ4LgqR0QLTiRQ3Of7/UH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMGdN6mL25yQ6KL5LYFI8Zv/EBSd16dVYOQ3b2Srjjc=;
 b=YqDDSmAT6HgywSdGalGZd5jRmQV50gmNuE7eiDJGupgQrWsSkQfLTpUdPknmsJLerj7zj8jcb1yVKlcY7FtU4wPXK7rLEKHT3nwhgJSLZEaO7DAmdypXTbrdL8RAFQSOZAr5euqShPvL6SDIDToJ0i60moA3oPqd7AxhLlPENW8ZAP3royOc+6SUcrjjqscgEh5DKGK8WWkC0Zl9AP8+ZFNnafpLdOiPKpZhiYqcbwY8ntnL4wObs336LU2DxPceDdfrYLNZV7LgxKHvfyB0RUF8++mId73wYJ3ubYbHvGCg/rGnwbIXR10WQg5dM3QcwaUEMxEq6RNp0cpCpOdvLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:17 +0000
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
Subject: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add compatible strings per SerDes and instantiation
Date: Tue, 23 Sep 2025 22:44:41 +0300
Message-Id: <20250923194445.454442-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0dd112-8338-421b-20c8-08ddfad9b89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i2H9+HTLT274mN+X87e7e7qDY9hElxzEachEp9S1tc39HdXUr2vZe4vO1wGt?=
 =?us-ascii?Q?qN4Zvb60MKMNaPLfqs1nRMv2dYU41vDwTkz2MKCpNI1eEUWvBR+ahhZrwACV?=
 =?us-ascii?Q?id2TwUb3Osp+muR7zBK1H3503be/8fIZVlFgR2Q/JSdhAyfa/W3byrocdAft?=
 =?us-ascii?Q?dowa3XWQ7ath2UXPJ0ecexeYoBV4S5TwBT+8BzhZzCsEuUNw1Lq4K/haA3fs?=
 =?us-ascii?Q?EnQZgMa3B60e/ZYJpYFdsGtcxRdAZke9d8NZu0tYpBNFbDT5pqeQE7GIjwvk?=
 =?us-ascii?Q?pGNChMPKATAaGXgQ5728zexXqxj30LcERjcGozc3otosmalaeKpM6ZEy8Kt9?=
 =?us-ascii?Q?mQlajnru9ba6Gg/k2skuY0V9RuCUojPOYa9rqNs9j8xKDKjPDX+StsduQ8KB?=
 =?us-ascii?Q?lU0paZ4vROWy5o69UAzZdqTZ3PecniFq497ZAr/ENiaTqJz1jLVPHDL14oIx?=
 =?us-ascii?Q?sKtQEb19kTlcGOClo9uxh/nc5WkrbmTLzUSzRuTWt5rVJQT4UL8pcHpu8OsC?=
 =?us-ascii?Q?vriWqzrhq2yvB8LoMt/eDkkFs8ckNS62IXxp4b9N/mLZ2DEtYAStrD8adfQx?=
 =?us-ascii?Q?1EyrmTt22NaHyD3tPjkirHm8ILFg37Lmxd6WsQ6b0DCLlr5eWDH2vt9TIvSP?=
 =?us-ascii?Q?baFkUkMiOXhfTX9viCkxzpTKa8d0bcKcMkFOPpZf/nq2wc1aawJyelp7Fqn3?=
 =?us-ascii?Q?FknNhLbr3m2X/ITfMXKoi02LthfBarsKdMs6BwBn8T5hjjoJfkLAre/jl8/a?=
 =?us-ascii?Q?uVcyrEP5gAfHns9Qpv7I9XIa7+witdJFfEDl1vGe1gsMoioNo0DoXwuOeunN?=
 =?us-ascii?Q?KXN8rR3/wWjLgeDah0BzFYWtEWEzMTjngTSSJT2lyup6PscSWoFJtBj3GP6C?=
 =?us-ascii?Q?m9ci/I9N76ALktmA1R0AKbiyj6EpUEQ15L+4BVRFwB9RKZa4zTegTUZdzVmf?=
 =?us-ascii?Q?PJIGsdrLhDc0ta25oTGbQgldDB4hOWbJZnhIQv1uuQP5FUyQOkaq33SDQl3o?=
 =?us-ascii?Q?uJ7SjLseLXk5LX2/SL6C1eY/7V9Pa0xjzZvPMvzpVTUQFupebgtuerhBRR4M?=
 =?us-ascii?Q?yYcS5ib9d4dKrWXidDdI3TamDBS2wjPj7ECc5R4DWKueBy2fiO5CGH609vlK?=
 =?us-ascii?Q?ORsza7gPw/+Kscs4xGusSLaotgYc5GrbK/qD5H2ZqOBxDiQz7ZeCf8Vrx6sn?=
 =?us-ascii?Q?U/+NBo6tVxLxajyXy6aKq7SBus6sNwkNQxk26pnstRkB890GhQs+X/mu4Jtq?=
 =?us-ascii?Q?TCJzeY0oVW/MbX7Doh50pAiq/xZz+eWWoPppfIsLhl5nfAryFdnvHu6HdLbn?=
 =?us-ascii?Q?6N49vl81zwx+C3vIXSSTHjKXm2b6w/uNyNlAS0kqb6okDrh7OANCf9gJSkji?=
 =?us-ascii?Q?wIRdEiKUE3rWzgFyhkxjY7Usv+6fUnOyPdcN9g9GI+mMa1WiVqad+pa8PV6D?=
 =?us-ascii?Q?rgaLhdarPJaO7kYDzlOhAckX3Qml9yin2R1bg9/PUAr5SC6c3W4zpzZVDhw5?=
 =?us-ascii?Q?285mW6EKkzGGakQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lro+OhjzdDNBQKiUsfusz1mBCqqkzxK7KOSQ2EWcDqUuJmiZaQzA26PCrqeO?=
 =?us-ascii?Q?kedDUma6I/NpV1PBh+14Ik3OgqNA3YGPp0jhx/1pVWdentM36yLwTzKNfFbJ?=
 =?us-ascii?Q?Nb9rxxN/o5Bi6xYIFlzViPmj2BnlC+S2ZC6TJ6PcF3FciAIWCW1AeY6NrmRV?=
 =?us-ascii?Q?F/gCJFXe/P465yE8lGNpr8NxYWgjT41Ok258QbA3jd3Uq4T4Gy/CNXMN1sp/?=
 =?us-ascii?Q?j4d4crRAnpKbnF9+4t+ONJTWYAgkXYty2hbTePVxgCL8oGTM3hueGeqVui/2?=
 =?us-ascii?Q?nW2+TVwj+nfqXZNxHOzgY7/SY1ZOjAm66foPWdvN0JmI6+/9BUhhxPDybzp9?=
 =?us-ascii?Q?MRLwZNGBkwCJ77hDVbbFDkBegd4uFKeMdwWJc5PeIGx9DsPoKURT1g+YmZLg?=
 =?us-ascii?Q?H6HhcQOIzAFXAhXxILSOnc47VA0Wg6vZ/6IxsbX13T0Jg83ZT8bMugv5tMnD?=
 =?us-ascii?Q?wefsK3uSrAIuYF1/4VVH3BI1EYqrzLOn53SMg8WUTESzEicUGRhvqjqg8fDC?=
 =?us-ascii?Q?z8H0Brnhy742Ieu9LnXeDIvAWkS5ICoOrB89uzJmw4Mv/LAh2V2NkGLPytn3?=
 =?us-ascii?Q?mSxFYLkjv4E0BUeotnLnP4xc/RwT6flIfssvQZJFWuvnNmDhNdeQvfSvAddC?=
 =?us-ascii?Q?5Y1SJ0XLaI9xFQESWfPKnteUBX3mgG8SydE5J1iJdbpqaL3H7jWrpXQwIFEp?=
 =?us-ascii?Q?7Ktnz+Y2aleR4Y9iNhqnyTgli5lMWrP3Ukv6pqTq/BgqwJHIU/E4/SJqg4xN?=
 =?us-ascii?Q?SvJ+etIyKjvzbwLjlAe6yAC7lRLkCLfVwalv7lRUkrAY9BdMTFSc0ibCP32L?=
 =?us-ascii?Q?vMEKQUBk+Sx59hxBqk5YasvaqeFXnTfGJoFu03sqbKh8MCPbVeqTMcD+yDWB?=
 =?us-ascii?Q?CNoM6EL0hlKW3J9ME2YfFIu7mZacNwimvnc69tB52zVWtnGMIREgJySQ2uX/?=
 =?us-ascii?Q?+F1C1gf1AdJkunkeGwyO5Up4obaKjY73Zp8hZ+zZNGADd9Re3SQ05l3MoK4M?=
 =?us-ascii?Q?ovzlhCRj5Ho23qgdkxrrRDtcAdeZ9A5gDFOA9hKztzwKWxSzDqoy4os3O+im?=
 =?us-ascii?Q?S/rGZSvho83vIKzuSMtYWNPuDo3UNkd/VFESUQkC2tGrWSDK+K96l8nt9lgy?=
 =?us-ascii?Q?ze4IqRvjRvjg0vnCfq26Kx8pf0Hj7O35W4mSjG5CB6o0Eh1gcBiLphtrMrU3?=
 =?us-ascii?Q?PBnj5CjDT7qEp5dTits9pAnxxE3VtMEUBCcEwZVbuVGNw5mBPyG1yvyNTwSo?=
 =?us-ascii?Q?dgw65gUAluP+9ibdHalXMgLFrLWP/u+B7vQN3cSADKjt1U8td6Aw2Pekc1tr?=
 =?us-ascii?Q?KrSw56uaq4/snJ2bKwBzniErwdWtnYCIY8nQ++6TzHfYrgsN5SPyOCtuepGf?=
 =?us-ascii?Q?Uf+KQDttEpz24uBbwn2ArWnNW8YcX1Et6BfxInsJuSOLnI9LfJu8fD4xmAx1?=
 =?us-ascii?Q?kJOXA2wCNo9cJkbKPxsfVclJVasQdVO2clqSHkphiUmz5pKBows0Qe6ikdHl?=
 =?us-ascii?Q?fRrvcMVy2lKWtAFclbZAOJirgmqMTQLjTrrf3pZCPqEkcOlAmPUEpzelz1Dm?=
 =?us-ascii?Q?RyddUJNyDg0DXQIhP1Lhfn1a0hBzprqP0qn8t3K84LNiPRrVXxsV8jTGw1/t?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0dd112-8338-421b-20c8-08ddfad9b89b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:17.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWPJYoZ9rWmtBqLMiq+7rh52KcUZoL4NVsueAkD5iItJx7ladtrSFTuFLxRwl0sUQUcdBYlg94+SPMiHPmWyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

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

The other sufficient approach would be to list in the device tree all
protocols supported by each lane. That was attempted in this unmerged
patch set for the older Lynx 10G family:
https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/

but IMO that approach is more drawn-out and more prone to errors,
whereas this one is more succinct and obviously correct.

Since this compatible string change breaks forward compatibility of old
kernels with new device trees (which is OK with the known users), this
is a good time to fulfill another user request, which is that individual
SerDes lanes should have had their own OF nodes, so that we can
customize electrical parameters:
https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/

This request requires #phy-cells = <0>, and because "fsl,lynx-28g"
requires #phy-cells = <1>, we obviously cannot have both at the same
time.

Change the expected name of the top-level node to "serdes", and update
the example too.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- drop the usage of "fsl,lynx-28g" as a fallback compatible
- mark "fsl,lynx-28g" as deprecated
- implement Josua's request for per-lane OF nodes for the new compatible
  strings

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 146 +++++++++++++++++-
 1 file changed, 140 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index ff9f9ca0f19c..390c9ecd94cc 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -9,21 +9,113 @@ title: Freescale Lynx 28G SerDes PHY
 maintainers:
   - Ioana Ciornei <ioana.ciornei@nxp.com>
 
+description: |
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
+        description: |
+          Legacy compatibility string for Lynx 28G SerDes. The capabilities
+          of managed lanes are limited to 1GbE and 10GbE (depending on the
+          availability of an adequate PLL clock net frequency). Deprecated, use
+          device-specific strings instead.
+      - enum:
+          - fsl,lx2160a-serdes1
+          - fsl,lx2160a-serdes2
+          - fsl,lx2160a-serdes3
+          - fsl,lx2162a-serdes1
+          - fsl,lx2162a-serdes2
 
   reg:
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+    description: "Address cells for child lane nodes"
+
+  "#size-cells":
+    const: 0
+    description: "Size cells for child lane nodes"
+
   "#phy-cells":
+    description: "Number of cells in PHY specifier (legacy binding only)"
     const: 1
 
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    description: Individual SerDes lane acting as PHY provider
+
+    properties:
+      reg:
+        description: Lane number
+        maxItems: 1
+
+      "#phy-cells":
+        description: Number of cells in PHY specifier for this lane
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-  - "#phy-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,lynx-28g
+    then:
+      # Legacy case: parent is PHY provider
+      properties:
+        "#phy-cells":
+          const: 1
+        "#address-cells": false
+        "#size-cells": false
+      required:
+        - "#phy-cells"
+      patternProperties:
+        "^phy@[0-9a-f]+$": false
+    else:
+      # Modern case: children are PHY providers
+      properties:
+        "#phy-cells": false
+      required:
+        - "#address-cells"
+        - "#size-cells"
+
+  # LX2162A SerDes 1 has fewer lanes than the others
+  - if:
+      properties:
+        compatible:
+          const: fsl,lx2162a-serdes1
+    then:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              description: Lane number (lanes 4-7 only for LX2162A SerDes 1)
+              enum: [4, 5, 6, 7]
+    else:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              description: Lane number (lanes 0-7)
+              enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
 additionalProperties: false
 
@@ -32,9 +124,51 @@ examples:
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
-      serdes_1: phy@1ea0000 {
-        compatible = "fsl,lynx-28g";
+
+      serdes_1: serdes@1ea0000 {
+        compatible = "fsl,lx2160a-serdes1";
         reg = <0x0 0x1ea0000 0x0 0x1e30>;
-        #phy-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
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


