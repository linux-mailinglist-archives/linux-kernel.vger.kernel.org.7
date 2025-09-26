Return-Path: <linux-kernel+bounces-834501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF2BA4D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C131BC70D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906A530E0CD;
	Fri, 26 Sep 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YoDRDNh0"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6930CB3B;
	Fri, 26 Sep 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909939; cv=fail; b=AFHHHDDB9cl7uXnI7T5sNn0LytMLZ01KarnlAgS11M18l0ZRF7PiaewXnU/SYQBIEEcI6FSLPVX35u7Z39E5fg+HzXMc4U3Y8I/qz6mIrgLbSRNmafiYQxaN/zh5Ha+mnlgpv0X2CNe5pEp/PxUhoq8JqOI93bLSmwDmJNO3zMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909939; c=relaxed/simple;
	bh=ZRdZRE4YQC4d0lcM0RtUUCg/r+5+J9j7VkPVau5YFUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKsj88JlJvCKOJ8prNOiltYoBIgtF9lBkGyBPK6rQgOq2f5p1LQRdFN9NVqxdn0plxL44cnxVCszxQeD03pa6k+OEsGKt3xC5BZcczu+kg2RD7fjQ2pH9lh5FPlb7jSy8nQ7D96otg99zUHEHFr6FNoUTKUTgG68c0/XA8w2pZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YoDRDNh0; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuV4DzrnM/J/bCiDSTP9feWtMJ5QE6nkCTMJK37B+l+pMnSYmCUI+U9tbT/OuBoV0Ej/sjQJmNL7IT20OLx4yFMY45wLEx578IPQdxy3SSytHy+pq/kiNvNXe9NPUKqdQ+rUZP90+mjEqm4ymQT0DSCJccTSF08xrNJhjvBuCH6bq+JZIcuuWxMlA0uwppePemb8POYuuXj/eADRdNU0WnNdPY5/eFt03QtTeQftboKDb+0gw+4pbGKvwjT1F2A2eeFJ9iPqMz+Ys2oiGGlirtR0t8jq+++DA7SLJyIvGJnGgxnYsngmp/DBFw/CN2bwy0aJ6brKftFkc4aEh01zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZWJfdY0fFxCmwUmxj3wyFkXA58fPvUoU1y+otUB9L0=;
 b=jaN3YMGpG3vQ27TyxpgNF0CdggiJj1Nj9xOGs50AtoTHsMMCs6eMzdw/B0aLPD+PgvySL4TEt3kkSCWLQr1szJ3SH1xZCiIJ7TRWul9N5so3wLLGC1LlKDhReBK95WeNGtvq+pQntv+eXMF3z6nxDgjn2CMP8ODaIusowUbhULGXwllD424uvBqNHTyq+y235PyuSWk0sHzfiJ1pqjqHMM6sffUmUJUOohmSRUzjNzdrDA6kL4xNiKXYvqcmv9ZHb5jblWGmbMpZEJEBB+5u7O98B0wN0NlL/QXPKYKFHRJVyUexoiHS9JTgL0Z3EKHAqK8Qf/7KNdeYT2+S8omjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZWJfdY0fFxCmwUmxj3wyFkXA58fPvUoU1y+otUB9L0=;
 b=YoDRDNh0WEWBIJdUd4x55R/xX7nyZqo3iqOg1ru8pxaraMiSQpuFRw6oTMBsMW4Tol1jvpDdNj+V0IbjnkAfTcxzrrLW4f4CoSnOMVebGKy8WBuw3jQaTH7ZIyJ8L6mz5amRacaCCElzSVArRBNNHvA44QU6NGyLSmPPzHOErw5oNUG5VOlGDiJqlHtIbLurLJm5uPdb2JPzqK5UHMy5GA/NSGe+HOrSmp7oHkGu0wzSYPRlQfcmGkRe/4ghrSjtUHxcpN8Sr2SGkMhvdNOobhZe/vRtho21qDTj96JbrUNSR0CK+wbS2AU9DkV+GzCNQoscVkz6r+BDlUUbE+1mXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 18:05:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:33 +0000
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
Subject: [PATCH v3 phy 13/17] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
Date: Fri, 26 Sep 2025 21:05:01 +0300
Message-Id: <20250926180505.760089-14-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 56560b11-8223-4d61-2f38-08ddfd274912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHsX9jBedXvKkZxrhK/kmTbl3kRdGaevzTdofxejo//XNpm3+ab7baR5snG9?=
 =?us-ascii?Q?fpSQUf/Sy2u0nyA1EsZgkJKCTnZgwDjARJzWZ0/WLTcJh2saHgcWymW6jjjE?=
 =?us-ascii?Q?PVX/Gxap469u1/arq3T7J4p5+pKswnus0qXptej5vYih51A3laJK1lEbPV6M?=
 =?us-ascii?Q?iIYIa8VJ9VNlLWjiilg0FxnRpHlUIY64aFnsaoFPGsgsrD9SyWRSB6y08iTn?=
 =?us-ascii?Q?rvfyMwu8DJKs9S2ycD6fZ5Lbg3JjHf5p8yq0xpty15rgBOOFXwlvsKH0gtyC?=
 =?us-ascii?Q?FK9wn7KZGR1UOGXinHMomAuOnDVfyQU2KpQBuTTfqKNXDXB61WtuksvNEBXN?=
 =?us-ascii?Q?F1uhUg3E8YBChUDdX1DGoX3RInYKlHnX/f6G7iEolT2dYsaIr5ZgGiG+P0m2?=
 =?us-ascii?Q?dsiis842+rEC3VKY9rxsuJL0wer1yg+MLslttRq/m+dR68vZADOaiyY46hfi?=
 =?us-ascii?Q?QyL8NduTzegehrM8gH5qnuiqe0v2XrFLJG/KKgzurfDK7Zrn4/sHkj1OVzP5?=
 =?us-ascii?Q?9NxFr+n4ky63ahoevfQeb4yLFQ6k2Pg1GPd69NHpoNYpg2RJ0v/0ssCte/my?=
 =?us-ascii?Q?peSlv+xHngwLZNKUxfDVisWEcdePOY4uYuF/jSNY1eBaLXtx7+MCp0iGCxBP?=
 =?us-ascii?Q?d554WLQ/7qf8x95TJoj0prGw/D6iPf0Yt4dgBpCr4qurmuWGDrety7z5KuDA?=
 =?us-ascii?Q?s/LY6OuF+Db/I/0F27U9B06pK2tpO5wfc2Viqh2hORfLCiHA1ShYTVclNjRx?=
 =?us-ascii?Q?pX9OXMXB7A52Q9CiL4g3JKNz/1ZbJVw8rdcrZupGV0RcNJLkCQkWSgcCiqkh?=
 =?us-ascii?Q?0oVG8UwH6SkUBBgBpbjpsZfeQ9RN4kZIrlS/S2DyDQ+LPT6c7/2wfC1mThWG?=
 =?us-ascii?Q?5ltN+w/UIJVaf8A/E3G8zkYtLwQmDK2JcXUV2jFV2AMg3XI64FcKl4lOEvMC?=
 =?us-ascii?Q?AiOtTDtrr70ixCrPkhh88Fat8Wdb83JMJYKNdlwQwEdcAny4g9Cz0QMruaiv?=
 =?us-ascii?Q?g8qtiB0FbAJCboBSDfJDDRVx0TDI2SddeMZ5hnGQXRYY/aAp41DkduFJc/hf?=
 =?us-ascii?Q?tNjHayi07lQfAcBqjI76mgkqcqmgrj1uI1PaFzqquWBDHb+Nmmhcl1Ww27VY?=
 =?us-ascii?Q?dEOt9pS1F4UYaH4kgoyBvbpuJrb9saPbhMyFE69Jkt+ckNGFEP8+Z8rY+o6a?=
 =?us-ascii?Q?2JBCUMI3Dy3s23LyPvDNCa4wiwARQG/XBEfUhwQmXaYPrv7y9GI8MNExXC1t?=
 =?us-ascii?Q?mDlpt7JntPm+QoU5gwxyJcTvgfTyZO+Um5hwGf/iRY3WmnK81YaWLYdkiJKj?=
 =?us-ascii?Q?QRtcMStKKI8WNevcqyavDkP703dQNe/HU1oRvABsr1uMnq3J9y2tomphvAjv?=
 =?us-ascii?Q?AQSVGYTN2TPro6Eia939pE0D/Vlpecvau92kuPs+IMxCLRYsSMgWpsKD3sEl?=
 =?us-ascii?Q?Z6MuJ/3Vo7usN2DDDZJ6icO43tq48FIDrDaUI2xD08iQPGg+M1bmprpdwi6n?=
 =?us-ascii?Q?fL8pEAMBAzruuL4zZXJa9N7S20IHMjtXghxN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCqCy0eylYms2PJtUei2fl3mxLiLtvCF4KhZtr2uN4A+BBo6LTkSTkzNTzyy?=
 =?us-ascii?Q?LUnbqqk5yZ12YQ3SZJ9O1njcgdGX5mMx9GMVHrE7VC7YKd6iFeBQRSeBELa4?=
 =?us-ascii?Q?wkGLuCFsNTa7hQ9pF7wtZXhcevmw3kj2q3MKsW7MxCxJ0mUGzp8GQg1WgLtb?=
 =?us-ascii?Q?B7O+Aq4GLPFn6WmQcr0oeDqCU/PPVgloqi8JOQtrgdEQKPlwq9I1DewQPs05?=
 =?us-ascii?Q?uCIVX5dWUkFaZqn8CtdQtRd89jrGlepvQil+ihN/nstMVsX9iKe4+Oc4mzHE?=
 =?us-ascii?Q?Mq3YTH1RrRJfVixzFrdt8uBX52kkQq3stClrLjO1t9JoQjmkO4XVtRAUHrl1?=
 =?us-ascii?Q?vnPby/TbzXd5xF1TQSiZlnjC2OzBfQAS+svDNwQ/o8tgXS3museiFkIlKs0r?=
 =?us-ascii?Q?zzRgIrZ7ftKDRDW3+aSFis5A0CIB9svKj/Py7X9uAcPCcMhPWtUJ0ua0Et9f?=
 =?us-ascii?Q?3rZtpS+c/Zj2PHDk69USQS6/vCE/7V5pg3mv2Moc1HHENB45ZXsy11lJmfGR?=
 =?us-ascii?Q?axFY1Io4HAzR0U1g13NesrB8GRWvP5f8Rd3SuBNpWsajEUhRXqJ8kB7pdmlX?=
 =?us-ascii?Q?15+AVlWK0fC8c9G7k0Bwt+ccyx/b6mZSYHb38WOjCt7QUxLx2AWB1kCie6Lk?=
 =?us-ascii?Q?gaR26DCGvpOvA8nrqFrdh1BXYoxopWF36dPDdez+Aud9ucCwYERh+dHCiubS?=
 =?us-ascii?Q?VHSlgjBkjzgYsygK9HlhOeg39wj+8g+YVYVKgjbRnBrIRGqNz27KEQIoJNJM?=
 =?us-ascii?Q?d/gLAlqqz8BkDjSHARXOhuUICUlUwSwCDFSpaioiQFSla+KpRm3g2GQEai5/?=
 =?us-ascii?Q?aj0SVR29kcrDrrEYAtMwPEXNbupLFew678PyPK/uWdOtGWrddIFKtC/fFEKS?=
 =?us-ascii?Q?6fQ/SEy8tEbgAWqg5axGKdBt3XRQd6Vh+skhKhePYweSdxoUBjs9NRY/OVgx?=
 =?us-ascii?Q?XRPshQSNusVRwLQ/l5+SgpFymeSbpoXw11bPxG6xd+eUolCeNfXeE+R1CmIT?=
 =?us-ascii?Q?iPzHw89kXp2N6Fi1upV0SZlHvhht7eFSI2kQnl9P4wYDFdTp2zrt3mkc7hhX?=
 =?us-ascii?Q?1+d0fwbI9LGy/pJ/Z4TnugfsD4DkBDgvmI8DLMZGFRRuj81G1BLCu49OyoSZ?=
 =?us-ascii?Q?gXACd8Pd+tpmfDEC0LGn9gxqwWU7Dx3yr6o+8ttKZBxOAq+KoFDRqqGTveqD?=
 =?us-ascii?Q?LAAwjiv2l9oYyGYOAdu+/cWdAZvAOcKl4G7LVzE4AaMwM6c+iNAAljN66O7T?=
 =?us-ascii?Q?gdrnf3sT9hsKJkA7o1OftfDc56x3FSv4y6S2tgnyT5Cf0+x3kA0Jjy9NdjDF?=
 =?us-ascii?Q?Set8cPJsyBLusM8zmUheQg5B2zX6Xi5wCuZjk7hK2/Qttidf+p2XqaUbCom+?=
 =?us-ascii?Q?M7YAq/v6OQjpuzaQR4BYRFcWES+kXTX4m9MkqT+7I1BIMvYLSfpg+QLoXvk4?=
 =?us-ascii?Q?qpMZdXQDZuI0KIkroESy5WQT0MiVRqPg41zTvYhmqBweidor7wcyLxB1xQJV?=
 =?us-ascii?Q?t2PlsC5MPKFwTPC3f1dFAJaxj9nXz43lzd40+e/IF8JUA7PAMKI3qJHSq5uc?=
 =?us-ascii?Q?ZKStwHTWPConwVVA+Bjk7eSaoZIPhFWX+aWjVEh+yBrL91if0fVwpQ7sbiXD?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56560b11-8223-4d61-2f38-08ddfd274912
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:33.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wEosfhHmPf7EzwnGwb51TTRGvZIdLhzwhiuwD+pU34hoxnh5FXFfURn4o+DShiTuV5WaTsJU+AcMyBIwnWMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

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

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 453e76e0a6b7..1ddca8b4de17 100644
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
 
@@ -1120,24 +1213,48 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 	struct lynx_28g_priv *priv = dev_get_drvdata(dev);
 	int idx = args->args[0];
 
-	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
+	if (WARN_ON(idx >= LYNX_28G_NUM_LANE ||
+		    idx < priv->info->first_lane))
 		return ERR_PTR(-EINVAL);
 
 	return priv->lane[idx].phy;
 }
 
+static int lynx_28g_probe_lane(struct lynx_28g_priv *priv, int id,
+			       struct device_node *dn)
+{
+	struct lynx_28g_lane *lane = &priv->lane[id];
+	struct phy *phy;
+
+	memset(lane, 0, sizeof(*lane));
+
+	phy = devm_phy_create(priv->dev, dn, &lynx_28g_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	lane->priv = priv;
+	lane->phy = phy;
+	lane->id = id;
+	phy_set_drvdata(phy, lane);
+	lynx_28g_lane_read_configuration(lane);
+
+	return 0;
+}
+
 static int lynx_28g_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	bool lane_phy_providers = true;
 	struct phy_provider *provider;
 	struct lynx_28g_priv *priv;
-	int i;
+	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	priv->info = of_device_get_match_data(dev);
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
@@ -1146,26 +1263,60 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	lynx_28g_pll_read_configuration(priv);
+	if (priv->info == &lynx_info_compat) {
+		/*
+		 * If we get here it means we probed on a device tree where
+		 * "fsl,lynx-28g" wasn't the fallback, but the sole compatible
+		 * string.
+		 */
+		dev_warn(dev, "Please update device tree to use per-device compatible strings\n");
+		lane_phy_providers = false;
+	}
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
-		struct lynx_28g_lane *lane = &priv->lane[i];
-		struct phy *phy;
+	lynx_28g_pll_read_configuration(priv);
 
-		memset(lane, 0, sizeof(*lane));
+	if (lane_phy_providers) {
+		struct device_node *dn = dev_of_node(dev), *child;
+
+		for_each_available_child_of_node(dn, child) {
+			u32 reg;
+
+			/* PHY subnode name must be 'phy'. */
+			if (!(of_node_name_eq(child, "phy")))
+				continue;
+
+			if (of_property_read_u32(child, "reg", &reg)) {
+				dev_err(dev, "No \"reg\" property for %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			if (reg < priv->info->first_lane || reg >= LYNX_28G_NUM_LANE) {
+				dev_err(dev, "\"reg\" property out of range for %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			err = lynx_28g_probe_lane(priv, reg, child);
+			if (err) {
+				of_node_put(child);
+				return err;
+			}
+		}
 
-		phy = devm_phy_create(dev, NULL, &lynx_28g_ops);
-		if (IS_ERR(phy))
-			return PTR_ERR(phy);
+		provider = devm_of_phy_provider_register(&pdev->dev,
+							 of_phy_simple_xlate);
+	} else {
+		for (int i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
+			err = lynx_28g_probe_lane(priv, i, NULL);
+			if (err)
+				return err;
+		}
 
-		lane->priv = priv;
-		lane->phy = phy;
-		lane->id = i;
-		phy_set_drvdata(phy, lane);
-		lynx_28g_lane_read_configuration(lane);
+		provider = devm_of_phy_provider_register(&pdev->dev,
+							 lynx_28g_xlate);
 	}
 
-	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
 	if (IS_ERR(provider))
 		return PTR_ERR(provider);
 
@@ -1184,7 +1335,12 @@ static void lynx_28g_remove(struct platform_device *pdev)
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


