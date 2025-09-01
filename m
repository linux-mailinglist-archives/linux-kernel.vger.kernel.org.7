Return-Path: <linux-kernel+bounces-793695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA2B3D6E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3541C7A2E52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE31421256C;
	Mon,  1 Sep 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lSvbDA8/"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95610F2;
	Mon,  1 Sep 2025 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695543; cv=fail; b=fxLb0TIRc7/M/n+UGWoQ3ryZPJAClkXsG9BOuvh9p3B9FMLq9x5OfYJHW/ENBCvsXmZSAJ009S1rYoFjOGzVMVrph/T538XRWsZZDJvvHE3Mrmtn4Rc+W9KpHYLAsZ+9dDiTOdo/cnYp1rew7YeJO1q8XB/MzjDPWfqtSVK2qh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695543; c=relaxed/simple;
	bh=aJezsIJ2rp4eLmZctXMoPJsLmwLXiroT+KIZlBWZBC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bVzLUoOW5eamF8WHuF6NbKZM7aQw7kzUHucNXzIedNkDuAaibEVPLtpmWk5TKSLzu5BMcQPXK+Wksy1gsUkb8k8WfTphUTQ8pjVDrbhIm9v9vKv9g5hfYXtZog4sq60TY7YdzQgipDynWpTcQuxVyaC9GWNh5HVoFFHznvCe7vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lSvbDA8/; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLIEM544jFuFFYALnC7cD8YafzzDzhD/cBgq4Ug3Mx7kiwsQEg1PCMG1GsqWf5EcVlyqGlUUuyQdz90faRT0XOTDuc/aa6q7usKz75vKEUQE4p+OxInuT3GdhJnYkEU4Sfyxm2W9u0Qo3MvgRU6SLD8iHjcnMY1gwY8ILJYcz0mJqE29zR4kmMsFkvx+yADwO75ciz+5EifDUKLW5IdnYIjqRkJ5LXawX5GK49kS0wPc354D/B29hE8K4QYfXuPoGo9cWT1svaHY0Q6xeUvBjrgfAZN+9kB3WK5xHQV8kz6TSDwWLhwXkZ5j7Xz6cQ2c8ox45Cpf46LIQx+RkF6mzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpszoBsV4HtMgNhFccg0OurTg12GNhFyaWVChL8D7Tw=;
 b=B1aJu+NBaImtTZs/xn1abZv6YbYLE9qRNviJ5XzKz8AcGrgUzouftlzv7QQc2HKDHTFRTppoUhX5ZJil1HWbngpUfPx1Vo8ODsFF5amjfR+WYxZ293NvqsiMVgR7QXB9LPxs3GXZXKqLYnE4ZcZ+l0KoStxoKQysfMNA0oticq8Lxu/+GKhO11PISEYKuaaP5Gj3gSALFQSdy7KfTvEtVGdSiTGMEymi1F5Jsd2JFE+Fbowc0h4hbMTQVcFnuqNp7P7ry06BAwJ1PH31qxOJy/pJZUC00R2wCGCD4SKs7CJut3tlTeJzdhTPQ42qdUNst4TvQtEPhZt+O4PyxP3/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpszoBsV4HtMgNhFccg0OurTg12GNhFyaWVChL8D7Tw=;
 b=lSvbDA8/xoaNWp6uDWp4YjEvd5WbJBAGoIk2CTVwtli7qQVMnOr6RHw5y6zREmIdYC9YAVorSDciZIGtg3thkrbaBLv3VyK/xwTOzLVDee29z6CIskFbHQ7Jz7ql8smcvO21QoNN6eoqcVSTHx8oD5vmLc9x9ZOkhTUx+ReLQd1bZ54YN56xOzBDhwLTZPGy8+ZOETkBIxGk5HSlReJ8g43et9WX0FAaKbb3dlutoAe1MflBFJt+yaFl+9HIN1QZsy4LYoF+CiA4xwSh24HvMIMOzOyi9XXkKxY9RtvriBSXbtrP49X/6jAolEunCRNjMFJRT2dIQ2h/9n97GnZPwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 02:58:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 02:58:57 +0000
Date: Mon, 1 Sep 2025 12:10:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 0/4] ARM: dts: clean up most ls1021a CHECK_DTB warning
Message-ID: <20250901041013.GC393@nxa18884-linux.ap.freescale.net>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 229bb078-6056-4d23-b17c-08dde9037df7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXxlArLJUsyYY1BS2CM66DBKT2L1/CqBc/AKDRgjRcKsUMRhlPqCzKgz2ypp?=
 =?us-ascii?Q?igBzvCV74Jsmx/+QahJmrcoATFUx/Pg3yVyGQ4KfBJ52vSpN0+RKHwL/ujZw?=
 =?us-ascii?Q?lWVkCHj/gsNXj4Unft9galt92Renq8tYdFUjIvv+EqFztZe7/Te/rTlCG6CE?=
 =?us-ascii?Q?lKjIxKT2Xt+A0W3FSmJRQgp9cfmz5RmX/qwa8vK1B4mj08kSKc86rKuaUFp7?=
 =?us-ascii?Q?WZQo/5W6np0YWQUGboPO0OYGt5FJDiCGUsSZPNRK7N3TyrZXM6qO7KHD9ytH?=
 =?us-ascii?Q?icSNUHxdkYHtCA62JcOU8nFE6UyMCr2tQNbZVWqC+qyVIdhULCD0O0VCZL5/?=
 =?us-ascii?Q?l/ine4OzFuOKEWrMkPFVFf5VbjmICJElqTX1QTHcxgYILq80EMEw9eihySZZ?=
 =?us-ascii?Q?6ZeRFKPD16lmSJENrXjnRg887ZeRG5d7i4z9Dwimj4oIOWEUPv2hAWg7jTuH?=
 =?us-ascii?Q?lBlsYSS2cFl0CyoSCk0TFq7NNkiO26j2CatoiCjt9P/MPWgBfumFEIo2MqtS?=
 =?us-ascii?Q?8Y0ohls1KgRPDG3xp3YqSD4xt9UgH4oXJ24rVM1M3E4sFnRjO2+k8TpQwd9g?=
 =?us-ascii?Q?v4JHnJtHCECDtVqmFM70KCxXf6VDgh+kzF72e0okNGS5V4TREfqHuVUTIRa4?=
 =?us-ascii?Q?t/NMydAqVPzN/nsJJeTxfeu/3x9qAYQpJIa7+OzkEm04EJp/kJ1Hgu0OW6rG?=
 =?us-ascii?Q?ah55RzN4ds0cOluIQflUgfNeLp4Gv/MxpZ3+WEVRj6FModz0ByBWG8pJcAdU?=
 =?us-ascii?Q?bZRWtNKKogzU5B2Cowm1DwaimcNnYoKXLKKJuubat+J9ekz0ChtSOtgTyJcB?=
 =?us-ascii?Q?b3kwB0gBvXo+oIfk9m5hk2K8iEJKEHGCvun/WKmSs8idKgWMq992qu6MuKok?=
 =?us-ascii?Q?AdM2bauKhZ3nDb/32NCceJLji8E1Tf/ms0P/dWlrGP8Z7ipX+Ty911FRgrTQ?=
 =?us-ascii?Q?od2Cs0X1B/wdNfbeR/ghfnAZtd9kG2sv3Cc6dNJosaHEf00PgyDHhVnMntzU?=
 =?us-ascii?Q?Z5dJ0Lx5P9gbRzxFv+5/zAoNL6fdrYZpQeMduvJdsHc8s5CsZD93/V0EXH3e?=
 =?us-ascii?Q?ucCR6hfMauOzrT8t2cwAdLe7qR/3zcvw0t8EFIQWiseSYwUrbI+fg7Ss1mIw?=
 =?us-ascii?Q?zgzTubAziLjhuMa3PnPF9vim8hvSzJuIWqsmNC3nIimnnfsz//SWRCRSrSDD?=
 =?us-ascii?Q?hxcqxKfxFfph4gJg3hBj2TP1/9ifJmbRRsGL9X3KOd1o6lPwpovoO5sKGVuy?=
 =?us-ascii?Q?h3xDqBG8EcHOZDHxARUKpKqx+ZfRTMR2ELC8O1G5j6VueR6WIMhIvjUlVjRV?=
 =?us-ascii?Q?WCWF8OpnXBzCFtjLGCjKXWuJuwhpbQ9CSopYLwE3grOZhIrwA2gyaCTvJ4VL?=
 =?us-ascii?Q?fOpLU86r9bDmGnUf9xIynLUyyFDB3eqayxjNdh10yMvfIg9SSToCCuQvpcMm?=
 =?us-ascii?Q?jTzq3c6fuusGAey+67CkRFwJPUsY6AvO73fouzojjubNd4iCCqVkG2LkshRj?=
 =?us-ascii?Q?NFZs/B/OUpD3VGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?horIGs7T9KlGC9rBJ6U4yG8v2oRhT+jvk6JoTKn1Qg7vaSTP57irUds8zQeg?=
 =?us-ascii?Q?Hm5h0H8rmmji6TItx/xrG3lWqdyUt8vWLCgeKRXPIHAnZOyhyCEpvz5Y+6yn?=
 =?us-ascii?Q?0zTroxkQvDgAaQ7pKVpA1CMuQbTiXDjrS+OX1Q4lqHBxYbQcr2SIAjWbYmRn?=
 =?us-ascii?Q?vX3SIhCx7AxG18NOj0xh1ewfqenLRpZvYvwO7NLDhy4Tw1+KZZpOW/MB/OwF?=
 =?us-ascii?Q?BqBMd+8xr0VpNCRBc52z4NjVs4oYa9+LKHE0yavgu1XbH7OoTZIB8BoVX5oT?=
 =?us-ascii?Q?drllxGAyhLJ/PHmbcFSjiCAd6olNPGwHs67C4bCZ6G0sBDZOM4WBspsfjseY?=
 =?us-ascii?Q?llJj4zN30bQ1EtBNFbyoNcID/AeelX210XPHuPy7mN92lHTaHp3/Ij9ZtazF?=
 =?us-ascii?Q?yqpe+PDnBppw0dhBX5u/qLly/ZwE8RLKbppshMiYQu83HEdWEBv/LfyczBhZ?=
 =?us-ascii?Q?wD9uCKPwlm+GLNF9zLH5gwNIGlb5yK++gflNb/L12ef29qkuTAwXybAfVHHa?=
 =?us-ascii?Q?tfh3Ilav3gkHAQamdsz2ZoZKrcFoLrJYP4CtwuzOck/D4IzRouZfMWUvMepN?=
 =?us-ascii?Q?0ZiW4S3k81OnquLnhb7Y+S3AvJXDocY2TWFQ90YYRmSDYk2zkHVQIjftSySH?=
 =?us-ascii?Q?xcLWepFFdToDp7um4/YFNu7WbVU19bEHYSYyWiALwtzjj1MUUU9vcRLzwxGs?=
 =?us-ascii?Q?G+iJ/elrcBpc7jTAx5yDkkWKWL53y4qq8Np73vLW83O1xoidN9fIJdVyVh2c?=
 =?us-ascii?Q?5AP0dJ3LtS0QppDEz2Ll67qF8Q6B1AAIp/ZoWQtGL+wAE5bFDygbFhfkHmfB?=
 =?us-ascii?Q?SY5qZscDBYpy1mLi/xI6qjjXEOlAu5keo6Wg1VVKEgo7K5gDr5xIDhvUYf5Q?=
 =?us-ascii?Q?HhGcvSF1B3NdBDV6X7ezvvXOh8jhFr9RzWqOgmdrzTouoeuutgjHvYN4b0tn?=
 =?us-ascii?Q?HQSHVIq8yGaqZnrLh+/afy5jL9i5fmCSo3SB9Jf9CZvdVjrA+HiZbhSMJPlb?=
 =?us-ascii?Q?IvyrLjONJmycS1VMNoFl5VOqo9virNBVxPqX8IaulnbRxC+rygtCHiPm0c02?=
 =?us-ascii?Q?NFRUwDw5Ebht2PTjaV4eFhzRFkz3r68zfAMBSdQg4fKkdT9whxoWPt0ztGQf?=
 =?us-ascii?Q?VwQkdE0DIky64HAAQf2h/ab/bfBalB5WRuwsYBDexz32OShiwQyCalFF0LHP?=
 =?us-ascii?Q?zGFc2UopYeVGNmFbwc/wZsceJJC/8N8X7dCvMj9Id8jZjdfnS58+D9/RtyCH?=
 =?us-ascii?Q?eSQX3B439opvyczd5kaDnfu8962a16v5HAp45bQRDRpXyvSNaxuDNoImnChY?=
 =?us-ascii?Q?rKPbPlQ5kG3LaWzDD793jVJIpTCjVh6VSyOT5BytrJUewHvxdCDv4TMQYWoV?=
 =?us-ascii?Q?g55R4vPcjLvN1HFLFEFIjhKmkZUixaadn1a3m+mFHWfDkZfC0+Ndx3hbbLtp?=
 =?us-ascii?Q?HrG5vZl3oY4ySIXkLjeMy30OOk7ALu7Z1i8HmALg/hR5L/ayGRXgsD9AQZ3i?=
 =?us-ascii?Q?mrz7BJ8/kN+TWz04TZqeMU1heyD4C8A83hfHNdBvzCGVcIUKiaQnsZiknRMv?=
 =?us-ascii?Q?MjgKHmDg0QUWklWe/MlP2PA+gWALTetA1/wuVmsb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229bb078-6056-4d23-b17c-08dde9037df7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 02:58:57.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXagczjVzJ64Y1vsCEzRTytnxHxgGUf7Ps0//hdbTYYwf9odI6kVFQ6XntMe+AYLuc7VXm12n9EbNo1qKyafzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269

On Fri, Aug 22, 2025 at 10:49:57AM -0400, Frank Li wrote:
>clean up most ls1021a CHECK_DTB warning.
>
>Old uboot check esdhc@1560000. The new uboot already switch to check both
>esdhc@1560000 and mmc@1560000. So we can rename it now.
>
>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>---
>Changes in v3:
>- rebase guoshawn/imx/dt tree. Remove patches that were already merged.
>- Link to v2: https://lore.kernel.org/r/20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com
>
>Changes in v2:
>- squash rename to flash patches
>- remove duplicate patches already post in
>https://lore.kernel.org/linux-devicetree/20250725061339.266125-1-alexander.stein@ew.tq-group.com/
>- Link to v1: https://lore.kernel.org/r/20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com
>
>---
>Frank Li (4):
>      ARM: dts: ls1021a: Rename node name nor to flash
>      ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
>      ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
>      ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1
>


Reviewed-by: Peng Fan <peng.fan@nxp.com>

