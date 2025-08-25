Return-Path: <linux-kernel+bounces-784137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F60B3371C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD6C202243
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14642957B6;
	Mon, 25 Aug 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CxIZdX/S"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71D28FA9A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105266; cv=fail; b=mF12H0SbGD8tf/8H9Z+jBrdFb3FMiPjaqshYzVsfQd4f3FP2D2m+HcjTRzVts6EFU+E37SsJlcHS0IXr6mVN7zudY88M5iBUGUo5I6derPS6PnChMI3IND/q6h1BV3sBZkzfgsFAJz0IGOS00Sbf/WiZ3CbC2EKOUQ6t5yrqblo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105266; c=relaxed/simple;
	bh=+cP/OBokdnXhYzZK257nF69vAPi473kEdU5krSJOyT8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HthPeEjx45c8YM2BEDY/dyvCHdBH7J427+gOty90zBTaH2uDcXjTyKJ7rYDQnnJRu4HofOq+dT99p91q4OH4aDaV8qmeeV9QodJ2MBR/7wXsl1087ZyeOGwznl+yrvQfakFBK+GvdAy8qTMY3lX1xkILEB1v7xtHxnHBwsHF3oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CxIZdX/S; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwbPFV/Y6OObFeozi2dzBVaLu7Ph6q5iiXzYTG+UPY97/sVp9f5UTEHgUi+nu6PyyuJ+iZNfM6CoeYUIAPxw7IaZpAvT5RGwtyrp74epBcvM26aqOC01rZziTTLYSP9AsjGctQBR9C5iRrC6ywfS+bjNlpVuLLhA3X99yh42kD8/wefpYwwLF7xocRfQrIoIikMzUT7uVE8qJOJmIRhxbuEPgl90ui9dfCFJV/5rnJWt/z6BEHXTf+/zWsMJee+Bkzj4pUd7g6lS3+nfAlZWZ60tCjP4alKsVivmm0whQtLxXENoLo6q3/cFfUurwe+5dAcQJVYSqU9NNcYRWCVwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUSfafNIrnqIj+cVHY2RY0ChxM7tY3tzY2duKCxE55Y=;
 b=DrOCBR1AbiNuxvrZFS2YTPuE0xtQFFBI4G9pzmDy0m/uUBEZX9AUZd/UD0I9DJdiq/6TACcbzW/eKzV3m3712lLJWAt6x6FdquAY86pkvQEg/54ZcbWgF8R1IS4GAQQ+jzQwWRtWGPY59mwaWUDCoJafhwOT2gNE4Q5qIAFbXu91iKllhkTq7E+eDGnCg+eujV5WNsAyO1xi3SZUd6biuWY+WesEPQAuFD+iquhRPj+bbnZ8RiEUPg381iSG1MpMzejpBcq3soA7HYrj7tGSy9mc+FQ7HvWyMKO9gNC4vYuqzHRBU2vOk0K7wj+mfxsVd3G25YEyG6hQto4Zwxkzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUSfafNIrnqIj+cVHY2RY0ChxM7tY3tzY2duKCxE55Y=;
 b=CxIZdX/SbuLYq8JnufFFWDSveKJqJfhnlE7wqtzT7Bqj3s+iH8sYDtV28MkwuyKez2aHFqxuY7lbcbh8swzToM2ZeCrivE5zZPRP3YzE1q7nlk5FfA7q/EUGTYq1t4BTF93WCCBBq4xK6uh/+kWxp2zwNC/a4Nsuy6r2922IsDNWE5fhEd1WZJagUHviS/gMnELvVAF/yclNequfirg3agyz5oP2UEd8dQJbpFQMDxXkMVPEyrFhi25Z42V7SCJAsg2m79OLFQSJd01r1vbjPg6GNmRz6bJMVEHh+8uKsLbjG6LQ0C0Wxc1nLmvkCW2JvyYt5+N8ZksuFq84iP/zNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 07:00:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 07:00:57 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 15:00:32 +0800
Subject: [PATCH v2 3/3] firmware: imx: Add stub functions for SCMI CPU API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-imx9-sm-v2-3-0bae0265e66a@nxp.com>
References: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
In-Reply-To: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756105243; l=1788;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+cP/OBokdnXhYzZK257nF69vAPi473kEdU5krSJOyT8=;
 b=KH8jexihe+FVWd2RE3AUHnPGMb9rRJYsOXDleNQxi5ESrcFy7KCcAWYxLl9FuiV5zjTr12YjE
 amHklMVUf1wAPlUcLrvGJR+uUOAbcCfl7J/AeIVKvFaQu3slZfobKtX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 45996055-63e6-4fa1-7de1-08dde3a52474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXlrUm42b2laWlFIdVVvMloxVWdZOWZsSGxLUnB2aE80dnpDWU01OHh6SHln?=
 =?utf-8?B?VEVheTM5WnU3V0RTenNVVS9LZVRuOVM5YUd6SDR4RmplYTZsK3IwU2haa29K?=
 =?utf-8?B?Q055eW41NHZYVGxBYllCby9tRnp5L0dGVUZBOEFMbXNKdlRnVGNUVk5PdmRq?=
 =?utf-8?B?ZjNybndLN3Rvb1ZFcWNBbnpIbm9UKzJidksvM2xVZUhDY0pTNlIyQlgzWnB3?=
 =?utf-8?B?T3B6aVpITWpvVE0vSUd2ZzEzU3lnZWdqc3VtcWxUOFl6NEtlT3JVVVg3SzBN?=
 =?utf-8?B?SDdGVm9yTXpacVBSNWtmN2s1S3JPejNrNEoxMUFsVW1iZ1dkNEZ5UGVkZGpP?=
 =?utf-8?B?ZExzZVJFMEFUa0FGeFhGUmhRWTgzSm5mMXNSV0FJZEFhMHFFK3pLbzZmMW1G?=
 =?utf-8?B?Vmh3T2NIUnFCdGlRM3NhemZtMkM4UGM1L0ZQQjExMzRqRFV1TitJYTlRRG1t?=
 =?utf-8?B?Yi9ZbDY4TFBINEdLYzdNbmlvNzY2SCtyK0FoWGs0WitBd0I4OEtJZG1Cazlj?=
 =?utf-8?B?SXpCZlBvYXRiSmRCdDFublh1d3lIYlp1T3hOLy83OHIyYW1NeDB2SCtFUW9Y?=
 =?utf-8?B?KzBpN3YyUlMwZEovWHhET0ZOWFFLWTRuVTY1SWtEeTI4Uk5pVm5QcTFQNjFk?=
 =?utf-8?B?UTZwcUdkNk5jZTdMSXFyTUdJZnMyc0FCd3RpUVdsM0hWRVJkYjJmQzR2THp4?=
 =?utf-8?B?K2dyM3RUR2U1RG1aa1Y1YkxpZlloMnhLc0dmMC9lSC8vOWc5S251TjZMbWtx?=
 =?utf-8?B?RFlqY05jeE43TzlVUkpnTWlwWm9GYU5PSm8rRi8yVVVLM3pzVmZXaTlpZ0J0?=
 =?utf-8?B?M29rdWZ4M2xpbHFHdUVYaGN1Um8zNGdscGhOU2NFV2U1YWlVelRWNjhST0pv?=
 =?utf-8?B?RS9vYW5wTXp2aWdINWNUVXM4aWRzSFVOblBJczdkRkF6Uk9mcGR1alRQNmxF?=
 =?utf-8?B?Zk80U2lJdlR0MGRra0FKYVBkVGQ0VkNpTWRRMDdWUWpLYWdXVDVlSGl1REtE?=
 =?utf-8?B?cmRmTHNvRnFxMnUydlVBRG5MNzk4YWF4TUlBSW5aa1diZWZoQW9pMnVOY2tV?=
 =?utf-8?B?dDNvaDdBVW93VGV1dWVFS25GOXFqWE9mM0NMU0JwOG04VmVkNnYybGYvczJ0?=
 =?utf-8?B?aDBuRUtPVnM5Rzg2M0U3YlVSSkthTnRUdkthVVlkdUNEOHoxaEVCNUphTys0?=
 =?utf-8?B?Qm10TGF4R2dRVHdaMlVOV25RY0YvbG1VallkTkxSWTdCWTAzZ0puYXNrUjRD?=
 =?utf-8?B?dDdodmg2MGFiRjBHbU8xL0hUT3R1SzlLdlNGWWw5MjM5dkMwK01WS0JzSGRt?=
 =?utf-8?B?YmVnc3JtUDZTUU01Ui9IRTBTNE8xYUZDM3YxbTJIN1pKWEZGbEN1SVZQUkdy?=
 =?utf-8?B?dlQ4ZkZlYzdUYVd6cGFHZFVuWFNYZjZVOUswdFVjQ3NNQ2s2UFJDMThrbk84?=
 =?utf-8?B?b2VWUHVndDRkVlcxcDEvaUtwRUZkUnJUNksrTmdHaDhmTWxEdEJXUXRnZ0dw?=
 =?utf-8?B?blYxdWx2bWp1ZHN0c3k0SVpmdmR0bE9UQVNuODc5MVpVejRFZHRPYlRNcHND?=
 =?utf-8?B?b29jc2RRM2tPUTZpL21DQ1RFNjE2T0s0Q2NCQm5ETG9Obi9MTldtMXNSRzRr?=
 =?utf-8?B?WHJvb1laY0loajBRTTRaTGsyY21ITkg1RnpaUksyZTVWbWd2ZG5qTkkrVGth?=
 =?utf-8?B?UDFLZmdQWStROXJibjYwa3lEdzRiR1dMK0lJMk1rRW0zR3NwcVpGUTkxc0JU?=
 =?utf-8?B?SmlNbjFZc1Jib2JWZXp3N0VnSTd1RExJcnJvOFptUjV0cGdla2pvaG05VXZw?=
 =?utf-8?B?N3d1T2p3RXpldlp2dTVPd0w4NUprekxmTUNoUTdCaHJBU1J1SFFLVkllRE00?=
 =?utf-8?B?RW9ZazhWVnlkcXRlNi9ORVNrcUxRQ3NYSXZEeExVak9JNW1COEJLM2ordGN3?=
 =?utf-8?B?TTRweFpPMUk5bUZreWxTV3R6MjJVYllOWktRbExQUU1kdWZaK1JXM3hqRTBn?=
 =?utf-8?B?NjF3c212ejlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTQzaTUvODdtb092ZVNkQU9YWTN4R1F3K3hSZHlhc3lhbkxobGVzVWNiZ0t3?=
 =?utf-8?B?b042dDBvUWxHYUY0K216SURwa2N1L0swMFlpR1B0YzZUTlFDeWk5MUhRbGRv?=
 =?utf-8?B?SUhlbTM4UXBCMWNRTEd2eXZTbWdIS2dOSlZSMUoyaThxQTNwVzJCbWF6VU1S?=
 =?utf-8?B?dlQ1elpzS0Y3TGVHS2NHNDBGNGwvdHlVZTExMlBrNmJldEo4TWo1QzJ6V0h4?=
 =?utf-8?B?cGJXbVlhaDVkQ3dxNHBsQTN3aE4xUGduS0xFSlZZQTQ0TjNqczFPOXNvZ3pT?=
 =?utf-8?B?alhjL1pvZlM0MDVScVZXcnMwWFp3NG50akpqdHh5ditCUGxoYzZkUEQxU3dh?=
 =?utf-8?B?NGt6RXZocWtkdlJCbkN3WXFkcEpvQUhQdUZ4c2VGdFJuZ0hXVUJ5NXZ6TVd3?=
 =?utf-8?B?eWZlc2RQL0VSbDVZRFMvY2VGeldYWkFLaXgxZHRwaDRZZVNjaXprSU80TkNF?=
 =?utf-8?B?VWdMWjE3QTRTWkZXQjVraityTHdIcWkzQjN1MjUwdW5pWTZ0NWxyN3JhRDhv?=
 =?utf-8?B?dWpvclVlUFhHS1lQa3pwb041RVRSWEU1ZFZsWXI5V3MxRDhCcXJEZHFRWUdC?=
 =?utf-8?B?d0tOcFFwOUlleUlrcXJzL0xDemFaU2VxMi9QaUZhWjBncnNac0pER3JqR3NX?=
 =?utf-8?B?QU9FWXJmUHBLcFBQQlc2WGxPUEZpQm1SNU5FOGZmNUduMmd3ajA5ZzdpckJr?=
 =?utf-8?B?VFoyWDNKMVJ0a0pxNmFacGNlbkxnVzgwc1hqVlBvSEZKTENOUjRwbzdrRitt?=
 =?utf-8?B?bW1BRTRYZ3g0YW0zc0hldlNZTS91Qm1PYVVoN2tUSW1UWTZEVHhRR1IyMWtq?=
 =?utf-8?B?cktXZDNzSWN1eGU5SlRCbTdLeklOYWlLdWJtR2dLQ2d2d1V2UXlUUUZoRnBB?=
 =?utf-8?B?MUVZMWZTSmlLM25PUHRFa0h6OWV4b2UvWUdqYlpSZE5IQzFzS05DcTNIZUdU?=
 =?utf-8?B?cXd0QkZRWGhVcXpCWml1d2tCRkQ5ZEQxQlhzQW05ZGoxQ0hsaDlhdXhzUDZh?=
 =?utf-8?B?VHFYTXhCOWpFMlExTmdvNUVsYnlwQ2dnZllMbnhwY1hDYXkwWkhMWm5ub1NP?=
 =?utf-8?B?bzZEUkE4ZnVNeWRUdUFVNG5CV0FpUGtjc1NGN3F5bGxNeWZyT0JTRmRxV3BO?=
 =?utf-8?B?cGZiNWRYVEhCNXpRN2hKd05JQlY3ZVgwQi95dWtEajFkdGlnTHhoZnc5SGRo?=
 =?utf-8?B?WU5xMTBaQTNScURGLzEwdW1mZmlrUkJRVlpzN1BYL3RSYm5Kc3plQ2FFeUZ1?=
 =?utf-8?B?Y1ZtNENMRmF6Q0RkQUpLV2RTS1NkTkRXeEZnVnZveHhTcUNka2lNdEprVm9x?=
 =?utf-8?B?dHZMRnVDZUJ1N0VwS01RWHBTbTFJQ0JqbllJNWFIUnBJRzAySm84OTZycWJ0?=
 =?utf-8?B?WG5OMGZQbU5CTnRzTFE5VXh0c1V2S2lFM05qRnMzOXBjV21mSlJ0N0xZTVVS?=
 =?utf-8?B?RjQyN2o3Zm9VaVlrRStDOWlianN6dWYyeHdUOG9TVVUxYU03M1YzWHZIMkc4?=
 =?utf-8?B?d2VTQ0ZSbHphUTVrSjYxd2xRa0I4MGd4SXQveDdTTVQ1TzEzNEpVVk9WdWk1?=
 =?utf-8?B?cEVVL0hUMGJ3cVZUazA4QUpWQ0xaYW9reVp6VGQ2NEFtMHByZ1RvTFFsYVdu?=
 =?utf-8?B?Z00yZzF4OGFSRGVGK3dqKzlSZUNGbnZKaUE4V2FHZmwrbHNBdHBuM1NLSUc2?=
 =?utf-8?B?OHk2VmV4dzBlVnEyZUFKMXNCRDBsYkFBcHQ1RFZPRlM1OS80RzVJVDdQcWJv?=
 =?utf-8?B?TXNMbCs3R0Z4ZW5WV3ZEOUlERkQrN1YxY2tES0ZPcU5KVHdWa2Jqc2pESEFJ?=
 =?utf-8?B?dnREZkd0R0NZU25oOWc2SUFUd2plRDdWaENzUVVwS0c2aEFOaHVNcE8wanVC?=
 =?utf-8?B?NHF2dm9UYis0TEd1dGs3UDBiditCeXF6YmNnbFBmR0JMSU1kYXRKWDh4ajFO?=
 =?utf-8?B?TEtrVk4vb3kyemNQUm1LMVYvSkpGQlhSUFJmcjE5a0NSUE5jQjVUU1dmOGVG?=
 =?utf-8?B?QktDNm1VSU5QRWRRVTR6NWFTNGtXcDdoZk9GNlNaQmhnRS9LZGJPQ3E2L2hU?=
 =?utf-8?B?NFhXemoxZVZCSlFCRnBzYVIrK2FmZnhSYTNxQlB5dFdWa3BYeHJqakxSakJQ?=
 =?utf-8?Q?SRtLpQstkIzpiKl2vSZRSDafw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45996055-63e6-4fa1-7de1-08dde3a52474
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:00:57.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYWBAWAS+rDSpTEXuhLGURHBKo5XQ8wq/CvGv3GNknFETpmbOu5u8sKmJ8qC9hD/ElJfcNu8Ki5Dwl8Z3lYm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

To ensure successful builds when CONFIG_IMX_SCMI_CPU_DRV is not enabled,
this patch adds static inline stub implementations for the following
functions:

  - scmi_imx_cpu_start()
  - scmi_imx_cpu_started()
  - scmi_imx_cpu_reset_vector_set()

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

Fixes: 1055faa5d660 ("firmware: imx: Add i.MX95 SCMI CPU driver")
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/sm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index f2a72177bb37c1d46145a60710e3809641e0f5a2..a33b45027356751f4b8ad9b9136f0dd302a82520 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -41,10 +41,28 @@ static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_CPU_DRV)
 int scmi_imx_cpu_start(u32 cpuid, bool start);
 int scmi_imx_cpu_started(u32 cpuid, bool *started);
 int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
 				  bool resume);
+#else
+static inline int scmi_imx_cpu_start(u32 cpuid, bool start)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_started(u32 cpuid, bool *started)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start,
+						bool boot, bool resume)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 enum scmi_imx_lmm_op {
 	SCMI_IMX_LMM_BOOT,

-- 
2.37.1


