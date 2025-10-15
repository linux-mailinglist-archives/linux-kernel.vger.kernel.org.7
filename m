Return-Path: <linux-kernel+bounces-854908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC4BDFBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A96F3E93FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3533A01D;
	Wed, 15 Oct 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ccWaQggQ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384F213E6D;
	Wed, 15 Oct 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546708; cv=fail; b=Fl3YTlIsg/NqzQnudp7f6CV0t4wLnwmyhC0miKZPiA9bdrGFI40sOxM8zM32uF12L12DKTa3klRo7AG9difJdYGokInXW45nmazMHRJkW8G3cdGJdU10A7ilOExaLCg684VWOef0Q2VdTvstqubr8aO7JUYviPss4PI3llKmfBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546708; c=relaxed/simple;
	bh=lku6LEUNLaDEbJgtYd21vyazgkoJ0tgikQxZ7UlDai8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P+S0otFcbpsRwBDgYq2xtnWlATScyMh12eyrJZBkrRyfwuMhp/707OYVpuWL6wDD+MwVfNLc0wZBthWMymal4o1UPsDMcMWDEfGb7/MXDKPyoUp3hbRd+Gsj9H+1uoDTk2COZzXyDokWsBdmeL+NSwgK7jpeGKYmiwJixX9IEF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ccWaQggQ; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqLFzBFukKCh23YiM3gFSCRydy3jQdYKVeLZgIUc0Ks/xbBdU1bRzLTupgxTvUXN3tx8H4mx19EP5o40urUkqnEklNHAEcStiBxX6DyE4AkirXAJXYl8NkWQVV7BjHEWfVMZcUjvDciKGRBvKcSDGB+Z1LU18f54b7K3FZv0yoJmSui3Eg/fmKcvUnWi7TMJGDekla1nW6vQbMnGZeInXrNKpOQLAnynsQOWl+s9fGNw11NiJt4n5PJjIbh6w+Flax/4Bu5C9A70V3Hergj17jNKfT9LcKgMQNlOboSkjoWPaTtiobsR2tpVImpbFxUOV5gRTZihJut803WGg1CboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/NMBWR17GAx508bwsDdoerARHmBPnidaxou5gkzLnU=;
 b=C0qFaX3T9X+Z5dRSq+HkkBym7Z1FF2jQOSn2AqAdev8wdrD2l06h1pOWsXcwjsbywerQpHczOlYWFChy0eQiQY1WqBC3X7XzzYxPfzCXLOWiesEWYY4hHeFptMFRgeyu8bLz84eyBCk1J8f4+4Qde2Ue3u6EX7OHV+HPtgPnwQaNM5H7YgtnbOpoUe+SPAi+G5bei5kDWRh4UCcZpvc62Wp3a57Ph46eG48GWn3ra6D3WVYLjdmTrd2iXOEKwKuHuX2weuQFhJ6r7eo93NjXhyZ/7BFhataDggchLrLcTLmS3MiPWeA95aE7pF1dR5lmoJ4sLHxqqV20ue8E9i7h8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/NMBWR17GAx508bwsDdoerARHmBPnidaxou5gkzLnU=;
 b=ccWaQggQwx+UT2KjBWf6beksml1frdn4lEuPOmPq8bXcDQ18Fr4JNaX+N9z5zYn9t+Mi5Gb04J+YfDKUQ0yZQzhehMYzXM5xIB1G4BvMlRC1XGuli8UfI21wji0VGDQEAgDC0rkwcUsMzCvJ30hasiNc+iXKS5sBzK8AlBeoZg/Tm+/UAXJ9lw6ze3ZdunZOF2+eCsz2NOvh5a0cJbS5p5WkgEd5CaEybyyS4t/eNV+7a3k010L82j8JlHHThoBjHJxjLOAqE+mwo9fgUB3ELRdeDLm8XJZIO2pSI+Iy7JMd4aNxk3MMwIClotYNdZFo/Y44GghwHp5NrbblkUplWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:44:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:44:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:29 -0400
Subject: [PATCH v2 04/11] ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-4-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=943;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lku6LEUNLaDEbJgtYd21vyazgkoJ0tgikQxZ7UlDai8=;
 b=vC9/Z06kMKKF4VwTekzqT8IatdvSkewz4uoXBntNohKrWOi+7svjcWMSVvH0E0cRvIhemcmV5
 07i1NYbVyuXDXY9dQcj5csp+rbNKvoa4r4vqSxDsFcVA8KzIDDYWdzW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: d07dccad-3bc0-42e4-ee0e-08de0c0a2cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkpjVXRGRFFObTZDQksyYjF6emt5MUZleXp0TU5xRHM5QXZXMEF4YVJDdXdI?=
 =?utf-8?B?UHhjQkdGWUNic3pITmsvNjFnTFpDWUZwbEtJaXduNG9LOVpRMk1jbVEvZEdI?=
 =?utf-8?B?Z1pKditaVmhvZWdKREZXajlHSVgvNDZyeTk3eUVmakpyMml1RmRKTWRyaU1O?=
 =?utf-8?B?Zk5tR3BUZzN3TmlBZUVwc1VzeFcrYWxuNzFQSGE0Zkw1V2YrcFkzUVU0MEh5?=
 =?utf-8?B?V3gxeFQzYnFqNVFxdmpscEx5dUNQcUNxUC9va1FGSnViRXhqVzZUdmxHU0E0?=
 =?utf-8?B?WG9aeWgwMzRmUE05WnNZMkVVcmo3TFJMZm1kRDZwcGZYR1NudGw0UTFySXdo?=
 =?utf-8?B?VktCenZjR3BuZUcrRzJwU3J2NytKNlkvdWMyTnNGUE9Bd25hNXRLWnRkSTZN?=
 =?utf-8?B?VHRCV1FDdXR4eE1MT1hYL1RUKzhIMVJsOUI3eXgydjdxYXVnMFdrQ09hYURM?=
 =?utf-8?B?T2xpQzVUaFR4VVgyNG9JNlc0all4ejNQUDUwYU8wbTdrb09xSkJSSXJmYzJW?=
 =?utf-8?B?S25iUE1jY3EwZVdEYUFQSUNaWi9IaG9LaTcwd2pxMFdrVUY1UU5WanlpSXpk?=
 =?utf-8?B?bVZScFhMRmRSVXRXNzZOOWNiUTN0WFhHeFdySGRub2xLV3Awd0t2blVVbmFm?=
 =?utf-8?B?TDEwbEZiMWRDRmN2VkRZbFJpNlkyVDRRem85ZklBeU10cnp5eXJJRVNhVS9m?=
 =?utf-8?B?dGVKdFl3RFUyOWlUT0FhRkQwQlJJRXRYRFRLRDBXSmc0eXRQY3J1TGlzZ3I2?=
 =?utf-8?B?dGM1aTlYS2ZJSGpscDJRbTZkTGh2T2YxMnN1UW9TbWxQd2VlZlRWZlJTQWFQ?=
 =?utf-8?B?a2FTaUprWDZTQjQxbHVCTmJjUkQ0ZU9Tb3JzNmc2OXJIQmNqS3lyTVFmbjEy?=
 =?utf-8?B?ZXVWelA0TGxTK0k5Qm9NdXlxeEFZUlNBYmRmV1pOMHowR2QrZXpNUnBJQWNL?=
 =?utf-8?B?R3Q2WmR3ZGFVeVRRRXdmemk3QnlCUHdJZEp3UytBNDB0SHNqMWp6ckJlbm5B?=
 =?utf-8?B?cHlQZWJ0UmxJQitjbmpmdmhxMDJ1S2V0Ky9PMkNPQkZzWXN3VkhDQXkxSzVi?=
 =?utf-8?B?VHhFYjE1ZDEvM0cvM2lPcnNseGg1SXhzN3d5VlIyWFg0OVd5MmE3ZGNBdEwr?=
 =?utf-8?B?cm1NNnJDb0J5WXZmWGRmN3ZiSkRGb2VtSE41eEhRWS9mVThOWndZRzEydDNP?=
 =?utf-8?B?K2Nkd1hJUUJRK0hUdmFaLzA5ZUMvTGtmSnpxNmY1MlhDQ3NaUUV0YzY4czdB?=
 =?utf-8?B?OG5oK0E2SU9LQ3h0MVdTZ0QyZ0w1QWR2WHR5ejYzdGhiMjdwVDVPZG8xUmtC?=
 =?utf-8?B?ZjFXWisyNzVZcndvb0d0T0pJSjJnM09Eb2NNUHpmamU1cklFYmdtZ0FBUWJw?=
 =?utf-8?B?eDJicFVCbGNBMktTRFhKOFVGelNPb1ZEVnVTeTZ2d2tFb1ZVcHBOSzY3YVo0?=
 =?utf-8?B?bUN3ODJiTVRRbWQ5VkYxaTFQRU9VbHoxMHV0UU1nUHlUNkx4K3h5V0prN3M0?=
 =?utf-8?B?Qnp3NlYyZmRvektDanNna2VTOUwzSEV3a2ZLU2JhNFRZbjQyTndmQjQ5K2dQ?=
 =?utf-8?B?aTdEMXdoMWZEWGhqMHlabTRIaE9kVjFCaklqTHByVy9menlUZUdUWHhPRmky?=
 =?utf-8?B?ZXZVOEhic0NuOVNaRE92SXBrdGFsYURuMUpmSFVVZ1llMCtPbXo1aEhzOTFN?=
 =?utf-8?B?OEErQ2cwdXJpV2RwUGdXYmc3WDNURWNRVkJqYUVkbTFzWU5BdjN1d0hYT2Jz?=
 =?utf-8?B?RjBFQXFuZ2NZZlNhakpDeVVkRkh4RForVi9jWmN1c0JlM1QwY3V6ZWxXS0hO?=
 =?utf-8?B?cno2ZEdVekVNSzBkdXNoSmZxR05Mc1ZiaVFvOXdHeDh5K0Ewd0o0Ti9hTmxY?=
 =?utf-8?B?TzNET1Y3MURZSkh3N0h0QnltUm1pMkRvakxhc291M3kzalNoZFl3OStIY2JI?=
 =?utf-8?B?K3BMV1ZKSDA5ZEx6VU5ud3ZBVVRUaU5HTVMzaFhRNkE3UHpNSVltOTZqQzJU?=
 =?utf-8?B?bmNGWnZ1bXZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R08wVG5CaVdjRDg1VEdlMHNWcDJRWGFKYmhPRGxPQjhLWVZuSVJqOVluZE9X?=
 =?utf-8?B?U2M3aWxJMXNRMEN6Z2s0QUdGdmtFMmprM3VnUEtUbEVOd3JNc0tiTDUwa1Jv?=
 =?utf-8?B?dE9zSVM2ZzMyaFVyc2Y1WGRWZlpBSUdxOUFhMTI1LzVtaStIc1pYcTRPWlQ0?=
 =?utf-8?B?VzA2R0s2djl6V0VPQUdYK292SDVsZ01LMnNjVWtXNko0K2dkZXgzZU5qSFE3?=
 =?utf-8?B?ZW1jVmFnamFFRDBZc1pEckloTklHQzMyd2Mxb0FGZ09IRFNwRVhXMkwvMENr?=
 =?utf-8?B?TUJ2bXJpUk9lakpjQm1NSzRGM25iaDhENXZUc2s2ZlFpKzdObUFKTVJOK3Fz?=
 =?utf-8?B?TExQQ3hWV0RHVWdaM0tOaTBVZStGN3VuQ1pqSnFCaGEvZ0JFQ0pKa3k2WTFs?=
 =?utf-8?B?SVlncTFGMlB4NlN6ckd3NEVDcm9XbS90VkRheEJoc0ZaVi9qQXBtbThiTy9t?=
 =?utf-8?B?azZhR1N6NmJHdXR1K1JTZHA4Q3ZSazR1MEM3WWpGb2VHbEtvSjFjZWJmWklm?=
 =?utf-8?B?ZC94VGZMMFQ2N0hMaysrZWJUSDVPQ1pKemFlbU9PNUZGU05GU21HaStENzN3?=
 =?utf-8?B?T25tWFZhaXA2WGhmemYzUGhlWlNKVXYzdlNGTjVzWVRhaWFvNDd0cEdzUSsr?=
 =?utf-8?B?VCtwYkZhQzZ4b1A5d2lPOGpqUzBWeTdwbTJmL0doS1hZRFljUU1VSGxVT050?=
 =?utf-8?B?SU9hUTJoaEtyQVhGcTNlSUxvUHJ0dDhsM0hhSXJDYm9ZWWZPbTNCUUFkZ3BX?=
 =?utf-8?B?K1FMemphUDd3WTlwRGFReFViTW9HT3Erb3puNmtPajludlREemV2L1BEVElX?=
 =?utf-8?B?bWhGWE1aMkNOMmVWN2lheWZ5cXR6RXRueG8vWnJ2cEhnTlA5akwxZjF4NHFR?=
 =?utf-8?B?UjVScFQ0MVRNcHVxQW5NbjAvZEN3SUMxbkJzMjN4Y1JNazQvV0djdFVHRm82?=
 =?utf-8?B?b1dDcHZaWk5TdXRtTVJYWGdlaEhBUVZ5dDh5TXdxTW9DLzBLVTZUeER4dko1?=
 =?utf-8?B?cUFybklLb3l6ZEMzdW9pMDVkNXZGek1KZ2diSFYwOVpDUFphb2krOEdydjF6?=
 =?utf-8?B?c0dHOHRjSTVqbjlGNDFWNVQwb2wrU2lpbS82S1J4aHk2c1ZqWDdxNVVrclhj?=
 =?utf-8?B?UjRQWU4vNksydGhscUE1bEJSOFpLSUQyYlhBdngyblVpclo0YnpMRFhjeUZx?=
 =?utf-8?B?bVR6cFJTWWVGNGlxaXRteVBxWEpDUjJNb3hCbU12YmZEeG9RaE9mKytGT0xm?=
 =?utf-8?B?dnJqdURZd0Vwek9iYnVsY2dqZFEyUkIvSGROWU1CYTRPbGFhRTJtb1lUTDhU?=
 =?utf-8?B?L1hDcnlNNlF3UHQySytxT3MrK1ZmYXN6YzlQaE1kc1dHOGdwa0orSXpiS3dj?=
 =?utf-8?B?WE41aWd6cGJjRDg2K0ZFZ3V5WndZVkV6QXZoL3dCc1FCbkQ2UzQ2RDRRajVT?=
 =?utf-8?B?RHh2NjBkeUNEaFptK0ljV3pHak9MNllNbURzZW5LL1gweTNZUktVOVdpcUJC?=
 =?utf-8?B?dFYrZ1lrcVJBcnZlRGJvLzd1b2NaWDh6dThDM2pHWVFidGNLQTB4bk1qbmlx?=
 =?utf-8?B?YXM3b0hCTGg0WE5vNG1LV01TZ2NldWdETThnUkZIc3pBbzJSakRHSVlNSkRv?=
 =?utf-8?B?T3VEd3dlUVowRVhERWkrTmYwT2JrRkRWNmFzTmE0VTNzVkhycmo0QnJmTGM0?=
 =?utf-8?B?UHJ2SzNVR3dIM0FyWmlzMDdHVFlIWlVlbDVHZ2RWdkkvSHQxRUdZVmhLTVhS?=
 =?utf-8?B?NnlaNEZoQXVNNFhvZkgvSFBybCt3VXJOeDB0cERSZnBTOG9FbTFnY0VnOUNv?=
 =?utf-8?B?R1hOVVJvLzhTTDVqckJ3Zk9WL2ZnWkZiMlR2Qlo1Zmt0b3JmWTZ6OXN1UXY4?=
 =?utf-8?B?N2lSa1RrNTZFc1hubGZvMDNzL2VMY2w4ZDZyOW11SjByeS9HUnVQdkNVM1Vp?=
 =?utf-8?B?cEJieVVKakFjMmUwZlhUbnRuWlBDSXlZSklvZTE4QVlqQWxSM0RjdFZxcWo2?=
 =?utf-8?B?OTNPM2duZDlTUHY0aTRqWXZQMWxneUM2UXo0Um5YZnQzb2hwbVBUTzBKdmdG?=
 =?utf-8?B?aHJ4Nlg5QnBkNG04b3d5bDRCZ3JuNWMzUEFMNklldVJoZ0ZuUjZyYVpwb3U5?=
 =?utf-8?Q?+5MM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07dccad-3bc0-42e4-ee0e-08de0c0a2cca
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:44:57.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwGRLVr4JF7sAovFnYRA01Zt4DNfxPEngH7UHiqqcLkfD80+jDDVQVmAIZ+KwWz40ko1FTGLovkfMAxx/D/g1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Rename ngpio to ngpios to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-ts4900.dtb: gpio@28 (technologic,ts4900-gpio): 'ngpio' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/trivial-gpio.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
index f88da757edda5a172d82745d5b5c1abb935b7d79..948b612496a5b70d832c1ce13f2504b36d9da46b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
@@ -140,7 +140,7 @@ gpio8: gpio@28 {
 		reg = <0x28>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		ngpio = <32>;
+		ngpios = <32>;
 	};
 };
 

-- 
2.34.1


