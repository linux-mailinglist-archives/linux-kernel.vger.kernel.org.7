Return-Path: <linux-kernel+bounces-694979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB3AE1371
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 07:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564327ACEC4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 05:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FEB21E0AA;
	Fri, 20 Jun 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XuA3bjAW"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8921D001;
	Fri, 20 Jun 2025 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398944; cv=fail; b=sxLhVzeHwnptz7LMcJ03DBhHm3GzZILPjYC39K7jh2lZJhJYekwo8FSPpfaXGoWAuAuj9PkNBut/X9o01rBBmtWEel9vW5fcPmzyEcqD7I6PWcLXO9ObjrTNgbLn0Z24Rc/yAHW5V7XeGTMXQxJKQ6OigT+1mAnyY6ZkuMZPVJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398944; c=relaxed/simple;
	bh=gMsTMdO+DW6A50IOnfiCPSn3VhP/LUWzSOX8aTI/Y+E=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JV8bAGkZ8IiE+0KUoQC0eIkrRDSkqhUHqmr3DDVva/uMwojvm5Kp35faOndTuIw2XLZURSeJTVFAp+g2skdZtIbUaqfwESBnNCpvtFByOeqvZV8TS/bPgWPImSG3TfkBQwDPG0LLs3aYQMAJ/DIgUJCwYDTeYDoliSAiFkL65ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XuA3bjAW; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2nOXEJVGjSmebhNmG+J3k8RBwEUwEdV93zfAxMnyVIhnC3l8aDWoi8AuBLy2febRjpdpaViHV05XAdsrmuIzlVxOM6blqFBC6t25x37T7ZkpGfTzbMwEnYq7CUPb3ptaGRv8r4fzTSuYMae2lwVqRqG8JwzJvHViXhTN0qy2Bv7a/RVB0+o1ZKTV49Mqt7UFlOdNbWVeIB3xR046hONS8J8jNR/AoVzmKPooSX4KUkRHWbp+iM3rhD3bv/BK/xtqa1IFnLy0uVYG7gtqWzlSS3g7AMqtcqtZGnz3JnggEJ9hS0P6gIgbcvylt8s/B96jVWq3wDiMWPJe32wecePiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaBagXGmQLEdZKrKomKf4XpbKxcTPMjC2jVIY4/62zw=;
 b=Duc1jb2cO2ZbyF1iB9rWx/PH6sr/sQTX+Ed0dDxBo5yDReWln14yjs6/ASS109AgoWNoYwt/Papfe7ZjUdkD7hlX/X5JO/JFz5zCraK0vCIntUdZtluVW9i4lfceN4tENu8Y9aEtn/RU1BavtL9aVRvU5cutMG0txAbUNjuS94kXZD4XGgmGu8ZIvfjpKJj8LQPn15dhVCN5OZHtRrz+QiN+Sy86bwYntQ8h6tXr8cXkbIAStO6xaD1fkb7W+kGC6CCENU8z1Fc1XgHXm+DTLcukOgTgwpFd9XSsIC2ZAkIyZBXqp6pZ7qSGaxgfwUvRiAhazi3zGpjXrwqEXhxseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaBagXGmQLEdZKrKomKf4XpbKxcTPMjC2jVIY4/62zw=;
 b=XuA3bjAWVKU4mNjJxOK6njIjPlcUrtyfQTi0s85pTPYHmGjdr4tFcKQ0Rjvjgd+H0V1s9ylZLn5mEHFb19cZmtKxG7d9OS04WwNpoBDgroj9hR19I2ueKJzK5FRqKgNriJMu6CJYdVN+sUKZ0gx5uFS/2NZOvHmuY0gC7Ws8pka31Has2q+awXgVdRthNGrmgq9iofLBjw2GgPI0M/tgAkwtr6G29lTkQ9GIbfNpRIWCQrQChAhqIAgDBC/lJH/17yz7K6L0xqwfIwR9rSHRTFwAJEn7kf07oX2HETfwlxkRsdHkw+/daZxIJesdfgQaH8wkcMVrRwNsr8dNKWtwMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 05:55:38 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 05:55:38 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cristian.marussi@arm.com,
	peng.fan@nxp.com,
	sudeep.holla@arm.com,
	arnd@arndb.de,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] ASoC: fsl_mqs: support MQS2 on i.MX94 platform
Date: Fri, 20 Jun 2025 13:52:27 +0800
Message-Id: <20250620055229.965942-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5520d9-8f39-4c06-293a-08ddafbf1495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kcCXKAnQBRw77V1ze/D1waLpe2HUWANlCzzbt+oGhDbIrFpXGLBC3RaMdnYZ?=
 =?us-ascii?Q?kvmFG/RfU7VxfGf/xyO+5Orp/AwgKNQakHLIWd07dT4Hy//Jo5l3aeaGEcqb?=
 =?us-ascii?Q?xbWtia4MJczWwa9Zth5f0qXYH27bjAVBN9dsRyK1npoLGka2KOZwRMod1vPA?=
 =?us-ascii?Q?8Li9QzMFHTJmJ4Y1+ZCb4znOXDWk5XJjYWrecE7Mw52xYp71tPeqluQHnAeV?=
 =?us-ascii?Q?hrr817cc49oMaDOpMFd9b8j+/LqzsKLZHqCqjJ4HC21A3pkaUJxKZIg81DeK?=
 =?us-ascii?Q?uPU9zLj3SkENzzAa+RIVT2U+Tsc2DIGs0KVW4Mo0TigfG/mR0xNzjC0Jc32m?=
 =?us-ascii?Q?Amib9OWW1oAFbcwHveTPnfnjO3Z8lK6yGngE6DHm+cPO6waMxDannvS7jjfS?=
 =?us-ascii?Q?z5Qp9zP+WBXgoTdLc+LJZLH8PPbD3fpoSckhFXdqFpAWibiLMsXo+RffUTbJ?=
 =?us-ascii?Q?PlOwVWWdBdgIc6igzS1Wx/nUA7PNi+JizZNja1cwG94Tlh73nBVTsKHTpfYw?=
 =?us-ascii?Q?fkiAa5IasERvirG/NvkFDjBjUDTIjLNAgEoLn6i+DWlFbFAcY2aXLBXQ0fWw?=
 =?us-ascii?Q?s4KPq6DYykEtbDUWoWc4yQN6gv3FWNYIput/o+/kzq+0/Wwm3dPbxs/79e/c?=
 =?us-ascii?Q?pW6qF2sHz7Ri2JgnnmamFiXh7VEQzZGbrNgNlIYRnfzWHiQOAPc0PWeKs0B/?=
 =?us-ascii?Q?3LQF1IOPzYQiTVS6fshVwCKw1zXQBuHl6tvxLsA1WqoknWvwzYiECGesH5Ct?=
 =?us-ascii?Q?UQo1I2lwxZTj0scQDhMbrjif5LxVm3X6rRR5/03JiBxU0iHo2DKOEI2WGcQe?=
 =?us-ascii?Q?RUwascnsf8vmnYQW4tBBggFdosizQmgTv7njHWkypmV13R2978G0XMfi9INP?=
 =?us-ascii?Q?+sIfJg8sGsYIKbvex5mciFeF5ML2QbrUZ717h1mMGV6pSuASjZCcl67M4VNy?=
 =?us-ascii?Q?dtKIWbjpvvYpSdEnkOy4SnsLDCZnZhyDOGKwmERqzNpgNH5bf/xjBahe+4nl?=
 =?us-ascii?Q?qfMgMjd/LuIqfb4e7IAnORpEikqpbkoQA/xKu8YSfjdFdPQ683wX4h8jCtjK?=
 =?us-ascii?Q?i9YquJuZHQKxoYytvtdsAvxaD+Twelr9EL/6HGaaPPhryZmw/0nW0GsvXCrZ?=
 =?us-ascii?Q?ltwRsmP1yvXhC/s215PnwVXbc1D7p1DDvnijhSxSUlauo6PyRszeohMk9Ymj?=
 =?us-ascii?Q?zxs4K65EP0yHEj6LkEK4aUdEk5bfhkjnCLiH5c7EFHpaujAD3DHOrjNeI1da?=
 =?us-ascii?Q?t9yRUerNUy3BmVS3VrP3O4d+HghR4bD0vISjmpnWgRcdhtsNRKdm9ymLPLXJ?=
 =?us-ascii?Q?nab1O/QJ8exdrsgNe6vtqaenM5fyHYPF0UXElO7Kqz4b/aZZHZ26aJBNSfab?=
 =?us-ascii?Q?fCeo0heXJbI+G2oYmOveiGbYEMzzZSigEUZ5UQGDt7TuGsPg83C6vWnkdtH1?=
 =?us-ascii?Q?lVwv4wOiLjezr7zpoFUmw7SeE2tskbxkhB6fdULf9tf9P8DNblcN1QGf9wu/?=
 =?us-ascii?Q?tkK/w341bfux6pM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?28eUSAor7yEG3719g/i8uLFtt82MUJTcxu7jX9luHe06R2LxOOq5mKF1t+xZ?=
 =?us-ascii?Q?phCXP1eoirRUG2z7jxMumskmi4Tsia2mcyetIXSix/wpkeNZqLwawMjF0ExP?=
 =?us-ascii?Q?fUscMEBTAHHx3eKg4VJWaVK565CSDtK9LM1H7DO+v4fUmiIRquritGW0vUEn?=
 =?us-ascii?Q?t/X7awTspywrdaF0+VZDqJrNX/73q9NyUi5qcuO0wmBS2nlZXYZtKQTqC9t6?=
 =?us-ascii?Q?J30SNC1NGocfAfXGczhlQYi8YdQnV8gYZ4fosXeDViQvaBKZPQIVaEidGIxN?=
 =?us-ascii?Q?T5d8ByyGAxZu8LzoRZZLcQyalFtN+BIDgQRLuWir899HAsfextnVtFjz5qZi?=
 =?us-ascii?Q?a7YSE5w4ANDVk7dFYjxUr589Md8xC4VvNEObZBL/Xz/dIHZXJCuG5wHm/ho7?=
 =?us-ascii?Q?zx/TdQ45NeW9hh2AcM6mQ4zkGlwT/Rncjdcmy+U+3L3sb9tbf405KIRULsTq?=
 =?us-ascii?Q?DEEzGneNxhEh2f9vlHnzJyso8E0mIwHj7iM94o3hdUCBHxEJbAbNcEXS9WQ3?=
 =?us-ascii?Q?IJEk9W4Vr5Ku+s/DDdD+QSwhVs1jMqkLGEme+lh21lm4AUoWleem3NMc9EEg?=
 =?us-ascii?Q?gbqSwXNY8HkIjBL1g7vhFoFcUxgu9LG1pSvD+xran4TY/j9+uubBseGTK6tR?=
 =?us-ascii?Q?WiB1lsFRinq2nN3n+b0HXKbiwg0M2dq78nMnh9SYUGi70ghvdVi/kF3/BclC?=
 =?us-ascii?Q?mLQESS0AkXD9/9uMCA32s099Rk23oHiTD0Vw4NqKL+3GokpuSKSJCXBhjAYZ?=
 =?us-ascii?Q?icsgb0P1AXgnQeTtKei7SYj1JamdT6hyr92uoS/9EpcieENRxHU0mXEH1GnE?=
 =?us-ascii?Q?PKQAFELjamu2xgf3/nw7DViXZxcXdCk+r5EO6/0XmNF0bO1aEhOGc5yfAbnE?=
 =?us-ascii?Q?ZwD4PDq0iqrTdZ/xKRSdOAb+XEbyRcfdxczKgRglngAeA+sGT0C+l/Bm1z6g?=
 =?us-ascii?Q?gIS8Yp79ETGDHRln8C07iNWU51iuOIZwu6UyuITAn6ZWHFzJXTpRth4HSHIA?=
 =?us-ascii?Q?peVFjDgSTKxV7d11HFSRcxQyFuyBzhp4gSYafSA2p0pAjiPNOU+nxCXNE7tJ?=
 =?us-ascii?Q?waqI6xLNc0NdkqIOcSYIOQcJvezN8TIUfnlzP9viPo1DwDOl0I1pRHN0Ybgi?=
 =?us-ascii?Q?HNCKgvIt539uxaXVBWosK6seQh6bah+mABsDLFrK4eR4G4pGtmLZQnSP+4+E?=
 =?us-ascii?Q?ap7tKtWGliOk74KxUpkxeO9EBRY0o8KwZs8S5zkiXJdK++ehEBq3OSuaXyYg?=
 =?us-ascii?Q?vpWdHoSQmujNDTUrz3waHPr6HyZufMzmuH7dELqYswOUqoEH44UQcjJWwtCI?=
 =?us-ascii?Q?vYXZ6GM+dhQOTNDdcOdaVtGntBhnRVvVrINpeTxQxIOgV/8V63QPTq2peoWZ?=
 =?us-ascii?Q?xjof+HCBtUGLiQ81rMIoO5DJhDqMH1Gi5Id9Fc84R2tGUGOKbRZv9oDv3gnD?=
 =?us-ascii?Q?RjlVw37Zy/X/4dQHhCzfm2TggUbfB4tHST2wK5tVAmBtCwcy0J6m7f4fUqdh?=
 =?us-ascii?Q?KHfXU3wy5iZEobWny7krtjPBd+nXzW7f99UcDr6V/GWrDoXFfBYLTsSgHMlh?=
 =?us-ascii?Q?6nsa13KG+E9URNUtUOP8yTXaccBnPbe9jMa8h/4p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5520d9-8f39-4c06-293a-08ddafbf1495
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 05:55:38.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZWeUzoXg0dH2pTU5kNim87e6YUJGb0zqcYQgKy8BnmSvY/v0Ohmy+KoIJvUGoLDSv6+68rQk55GGy8FKiNPFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962

ASoC: fsl_mqs: support MQS2 on i.MX94 platform

Shengjiu Wang (2):
  ASoC: fsl_mqs: Distinguish different modules by system manager indices
  ASoC: fsl_mqs: rename system manager indices for i.MX95

 include/linux/firmware/imx/sm.h | 20 ++++++++++++++------
 sound/soc/fsl/fsl_mqs.c         | 11 ++++++++---
 2 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.34.1


