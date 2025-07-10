Return-Path: <linux-kernel+bounces-724870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D888AFF7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81504A8098
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10669280CCA;
	Thu, 10 Jul 2025 04:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m72KPMgx"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA7DDC1;
	Thu, 10 Jul 2025 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120161; cv=fail; b=DxJu08bUvnX4xVOQMca6zwdBPld9CucB6Y3CKtluHrqDXpfYuNMUMR/imQ9O7ZbzAu6xq7bf5sptgsvbC7XUHXWq0nUVVQVa4dl4YTCX0FL/qV1Mx8S6sGqnEPYxJxGpxp6zGSR7zQKHiLfsAGV4XyYM94pcqKSKVHWGrDajrSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120161; c=relaxed/simple;
	bh=DA3JQNpmSsMs5T52qKucncGly51pl78V6zJ5rXxGRQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSsCwE1gOhg46PGqtdojf5uigXutpN911NY3+UQ8ScDgNuPVfWXxAylDu69Pd5KNsehrlYKmooyfWV2oi/Ssijkrv2e0V4DI/Fn8lh620x8dJUl9CigyS4oG2JsEGKu4uzvX4Oq4D9PkoZOtne54WbJBKxVMjXZFX5oZK7QOaTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m72KPMgx; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Jo1sEy8WCOlO2xCT3tZfaG1TJjMy05KT4fWEKGhjUPzUsXOnyT3nO8xkAEZeU3McmFgpXCeGCROLGqG6Rq2xz3lJjUgf8cCnA7+mILcK0yOEwrv/4Pgt/MAkKnJh8XgCaQQSoPL21RBjIU1n/OqkM6WjH0xP7yMAGu/l2H0bUyk4lOHi9jZju9fRTQZd9/nM1Dy53YAJj/eZRegYmLe2NKeJsY9JIsdHL7ZkvGeSTMZtnixW+5aWNx+eN8thPtff50wmL3BKqw6Kj+BfrlaqEvo055KQAe7cTiLDeyOepc+xjd+c17TPw/rNpXfcU8E9UvzFQHVPZ9ZsLOzZE6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAp6l2j1snW7FZBnIZJfafYb32FNSXlk73MMiWZmgEk=;
 b=up3mKzbhaa84KsAvEOp5ZMCvgUpwtq5uM8Oo2GZRkBaOOMdV5vxGBMTyqqfftYDBxLSmxcJR6kDjISlkkBEbWWa8FYLxDaz3Dlvxbf48yXSBk6jXLMnro9Ee1T97e8mP9/lHmp4UOTCYfV+IkECMo0Iv3QLTUZQrruRsEjY8jHYCYm8OrKlEmQK3a3TMKsBjmyNcBULLSP0VvbQmV3akEgr5O95yk7hkOF+ZEaWppa/2lcrE/0Muh+2A0npLUlWC4nPnJ4gJ1pCAB1nfv3RbT3ci8s/IcZP6cqH+/pTf36/73IdDiNme3CJFCBp1Ln8ctWIGUkDgHmQoszNjFlF/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAp6l2j1snW7FZBnIZJfafYb32FNSXlk73MMiWZmgEk=;
 b=m72KPMgxchmBSEe9llBp8A/PnRn+77r/UEnmra1RJuOc5o1wX5DEWZ+mGJHUjGX2Pz38f1HpwvMlNGFkwMTkkbQswEDspMfpTPJsOtYcAEqcte7U6PAr9LcQdInqy/GvlpWoh7ZXpxuYjiB2HDUewsseaE0Qk9+dXS6xeqRZv2L7VCWpeHmo2nuExYcz6zoyNy7Tim3REkefCkJnBtdLgghEGmbGsNQYsI6ArOpMgFaEOnXzU5iJwRh9omThhqjrViZkBYR0Id9EPPrfGRrfzWAX2Ntp6U7R2sgqzrBnz8uKdww2sop30KSEHpJgRQs0hYx7Wzrd7qU7rypQCe+7pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 04:02:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 04:02:35 +0000
Date: Thu, 10 Jul 2025 00:02:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Karthik Poduval <kpoduval@lab126.com>
Cc: jyxiong@amazon.com, miguel.lopes@synopsys.com, anishkmr@amazon.com,
	vkoul@kernel.org, kishon@kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: dw-dphy-rx: Add dt bindings for Synopsys
 MIPI D-PHY RX
Message-ID: <aG87Vjo5IwTBkp3H@lizhi-Precision-Tower-5810>
References: <cover.1752106239.git.kpoduval@lab126.com>
 <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>
X-ClientProxiedBy: AS4P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1da75a-3d1f-48ea-d6b5-08ddbf669a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mgem4Jhsw0BlVMKeUfzmladk+vUSrIHbjye5E0CrTsgZZw8GTPIgSNVwXmsc?=
 =?us-ascii?Q?AU3W/Jp9Zfex00dtTf/VrRo8uikvY7G+dq/x8lG98lZPTcFEiZ/BQxnQ95wc?=
 =?us-ascii?Q?UqM5EnAgHy3CjOfEILdE/y+eThTCLrx9lNadkBWtG40kBcaUI2FwpzyX+/rm?=
 =?us-ascii?Q?AbovsM0fj9eO8iF32SsAdD08aN3UO07hbVLG3xdtd3LvEPwK8aktKcpHSYG2?=
 =?us-ascii?Q?wnBnobIEAXcOwOHR4zdwJHxvmpv6SBGNy2JpQ/ut2cByra/JqaDE5p6Tqla0?=
 =?us-ascii?Q?UfsrV4/VmiSOCwmjrVl6BY9E7TdyT2D/RBbBC9ZOLfClONofqMwMTdRn0BhQ?=
 =?us-ascii?Q?ttqybX5HHXFFMn0HmrswjZJGfoQIzYsqW1tNepaRP3ElIKynZkqanAJ4GsNA?=
 =?us-ascii?Q?oNz6LInlHRBfkjaRFA2nifaPvWopGBHyqxwzdMcL/vhltRRMvs4GP2E9Z9Mc?=
 =?us-ascii?Q?4W50pzq0R1IJudhzBmI1dVzmITxgRHxUnzx5HxGDUD+0SUX/RBL97fZA7xbs?=
 =?us-ascii?Q?H0rPPy9Tyhy0LrO6JE1TvHQRU3RLh3Pv7MVEedxeVZTCFT11SyFiCyhd+ZMh?=
 =?us-ascii?Q?W637HQLz7vzFUREmAlE9oTxVzlgwpZxxpqMRpnOdf9G2RbsnaWaohD807Ts9?=
 =?us-ascii?Q?v/PZ1GcT+OhgPMGVdss5lQmDBgFX1jDkLj8mqZzrieQ/AuN2it/A+8OrlNZS?=
 =?us-ascii?Q?xJqmBqp6z9knGDxmKcWufZDsq1qMvqReoiNIV0za0kHMeyC5TG1dpJGLqijY?=
 =?us-ascii?Q?fchMaIlqikHCgPf4aBtpOSDBq5HgHQ51BahMFW69qf9KB4P9LnvwzG3FuQmL?=
 =?us-ascii?Q?j6h/LU2AZ3R341iFr9xe6MY/ehqaII+tRmQgwD05eY9bL4+RsB7RhR3JqJcg?=
 =?us-ascii?Q?deFQLxTKhKdSBVIitX2rHc3sEwAG1NkayXu8xy7t5Si6RuBU5/xLr/hQdJLD?=
 =?us-ascii?Q?9R8ti5JRWBbVnZ94A5+uPMffz2N19s+MvBK5e6ZlchYRBwvKMLPwtKOXMTYo?=
 =?us-ascii?Q?HKppIOEIR3Z4fPxG7Iq+rVdp9DV8qgl508haPng4nETBiL9QqSyzVRJuPhVk?=
 =?us-ascii?Q?3a4KFLqZ8BVZYEloifHP7fzjNtlP6wbmQUWZ+XRb2FPmz4InKhlPR8kwESHV?=
 =?us-ascii?Q?GxBNtir9YTN3D7x53hJm/yb9pLHxAIg1Cnsp4K4yXusSXV/f8jS6rUe8B007?=
 =?us-ascii?Q?tiKegolpRBK/ihe5lA2QpQLS1+gIp8Cxo60vm9olMK2bUGFRmaSquqdNzj+m?=
 =?us-ascii?Q?nrAKt3eeTTQBjNCJvGIWABrA3869LM9TIvjJldxJIMUXhSvfAHxmS5tMs5jo?=
 =?us-ascii?Q?mPTOFevsxKafB/HPBzuOP/1a07iiysMxw0ha2D03O1jRh/ZK0+ZOOqqlj0nV?=
 =?us-ascii?Q?TE8svsp1wz42WRCK9GdITjg8V47AxzovqbZo6VgQCJ4gkvLa+eZS7T6MlmZu?=
 =?us-ascii?Q?FpF3afVLQqNxGxnMaXzh3Z3TW3ohn/ur?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tufR/v2y78YaPDMXwmofIzU/xDv8/WmUplTUmbpivPXmS4odrrmT0+pYXTLS?=
 =?us-ascii?Q?buocv0+H5PMQnk024uTZ14VHThJmrmBXWecMBtFkviXUukXVpwBwfv1nlqrf?=
 =?us-ascii?Q?EZsLc1ScsgEAhVjythMjLzj7ZHRNzyXkpdYhTMeULf9825TBqZCnC+asgsjG?=
 =?us-ascii?Q?Fr3FHzrvQN4aNSyAAPUvZr/PhBiOLb1G+PnOVFvfW0s4xCwEZ8ox3d+8Z1H5?=
 =?us-ascii?Q?KzBreI3SdW6vSzdXVW6nZe27sVOIOfV+bHCIOAmHnjUUaePtjSy84TiSUw1K?=
 =?us-ascii?Q?6iB94gqHouyj/5D5byFzjrUSS58R2kU+HDslfAht/CLfAZl8HMDQwgyxRE9W?=
 =?us-ascii?Q?qMaAAT88fer9qrFj/wogNm3YJRAE2Cy9Qba+dL0RTpxbrZtMu7PiIbawHYbB?=
 =?us-ascii?Q?AeFS7IwCd4xAXPe1Yhuz5rVpO3fQIj3b/x3eT60WgbtE95HLEgTTqeRi7J7N?=
 =?us-ascii?Q?5kBP+dE3kbRALB6SKWaLtIB64G8tzlw9ZoIBcr65z/MpYkYUcoeq3B6jEeNN?=
 =?us-ascii?Q?rGE2l/M23OgsZno6OFGvI/+WPyHJ0mwKybSMvo9Zs69VeHtAHm7q8zuGCROb?=
 =?us-ascii?Q?fmW8x8ZC6T0wqPNwLE/+iujEgDFHpM+iuxfTJ7DCRBfFlLh80UZaL+tI+FHv?=
 =?us-ascii?Q?uGGWA83ZCOO881MA/Kn1kB5FgEwMOBtw6Wxj7zxASM+mHbTDOHpIJY36m7/9?=
 =?us-ascii?Q?lJMB9hP0wF48amXkoL3euNHylCsdRPmr1IrvYsglM02UyF9p6t8IuZne5Jz6?=
 =?us-ascii?Q?XNINmFwtCD81XOv2ByXN1cKF2pRA2yv9ct6pBmhZwLFRHuh2CZblo/1MdHRi?=
 =?us-ascii?Q?b/zbxswc4l+n9xDlAh7XuHgk5zbuRQnwMtzO7kNwErDk08fsaVdyeRAxsv7x?=
 =?us-ascii?Q?7vT2GI0i1hYLC1mz/hdOlxn8gjcGdf3E5w+BkKMvnnaZYx3mNVMAPeDHERhS?=
 =?us-ascii?Q?M4LUbTxAC49PdsTWGbENjZnb5VVYL9SAisXwe7TFBkpnMF+t7eVe16PCcmKH?=
 =?us-ascii?Q?Mis9njSFTl4BKqtu2VcqmWnmhrIf68328fSPND9aHu5Ne+Mke3si0XZ5M4XG?=
 =?us-ascii?Q?F/OFMHqyymgp8MBA2B8FymHRh1MjSfCzqA/EzNDtFjfIqWmYXyYmkUhC6lvO?=
 =?us-ascii?Q?NFVZbZU/uSFuIybNf/kg0Pb8FMV9edw/fGPFKyljABOncwamwBWI2W9iD2co?=
 =?us-ascii?Q?aXv3iv699FeyiFNPIwJ7w5DjV17C3YQLbKFW58bWdlBxyWQivOtUxkF+OYFE?=
 =?us-ascii?Q?FNDaQE250pGeH6vT6xi/MoUpXxe0V1sx2/8mNkVjNAlcaaxloIqc3FH+39og?=
 =?us-ascii?Q?MvfjqVDAK76w2+pPS7uhch38dkjjMAqg/lC93zvYuPZulcclRwcDQrGjaw5A?=
 =?us-ascii?Q?WVHhfT2B6s+Ywdczv6GeROSma9jhH3jmUYGV9lACovoulIgSXSlfieEo4Vv2?=
 =?us-ascii?Q?DlgVw48fEhqQDR4CQare5I8C13txdUTsga+fUbUoNJ/ElgNLrdjRl3T3NeuW?=
 =?us-ascii?Q?a4S8Zeba7+t0nJJDdpKqDttm6tKeDD2T9oCFvN9Q5qdJWDFyX+wu+aXK8UrX?=
 =?us-ascii?Q?hCU0jNsAE3AYoAj4S6JJAf7OuOFRtr5VNF+xdSJl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1da75a-3d1f-48ea-d6b5-08ddbf669a2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:02:35.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxx5W6SBqiTaOH+AEY0yrxLZuUIr9q6n68MQpeCgu1uSA7W4Gz2evE1Jk6F+zaCqpXiHhcW6Cag9zkC3j8CTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072

On Wed, Jul 09, 2025 at 07:42:21PM -0700, Karthik Poduval wrote:
> Add DT Bindings for Synopsys D-PHY RX, presently tested on version 1.2
>
> Signed-off-by: Karthik Poduval <kpoduval@lab126.com>
> ---
>  .../bindings/phy/snps,dw-dphy-rx.yaml         | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
> new file mode 100644
> index 000000000000..c3c657b1e77d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/snps,dw-dphy-rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys Designware MIPI D-PHY RX
> +
> +maintainers:
> +  - Karthik Poduval <kpoduval@lab126.com>
> +  - Jason Xiong <jyxiong@amazon.com>
> +  - Miguel Lopes <miguel.lopes@synopsys.com
> +
> +description: |

Needn't |

> +  These are the bindings for Synopsys Designware MIPI DPHY RX phy driver.
> +  Currently only supported phy version is v1.2.
> +
> +properties:
> +  compatible:
> +    const: snps,dw-dphy-1p2
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

items:
  - description: ....
  - description: ....

Not all dphy have second register.

> +
> +required:
> +  - compatible
> +  - '#phy-cells'
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dw_dphy_rx: dw-dphy@900000040 {
> +        compatible = "snps,dw-dphy-1p2";
> +        #phy-cells = <0>;
> +        reg = <0x0 0x90000040 0x0 0x20>, <0x0 0x90001000 0x0 0x8>;

Some DW MIPI CSI2 test1/test2 register is not tail part of whole MMIO space

such as imx93.

Frank
> +        status = "disabled";
> +    };
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5a472a544cf..5fd5a92431bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24217,6 +24217,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>  F:	drivers/dma/dw-axi-dmac/
>
> +SYNOPSYS DESIGNWARE MIPI D-PHY RX DRIVER
> +M:	Karthik Poduval <kpoduval@lab126.com>
> +M:	Jason Xiong <jyxiong@amazon.com>
> +M:	Miguel Lopes <miguel.lopes@synopsys.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
> +
>  SYNOPSYS DESIGNWARE DMAC DRIVER
>  M:	Viresh Kumar <vireshk@kernel.org>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> --
> 2.43.0
>

