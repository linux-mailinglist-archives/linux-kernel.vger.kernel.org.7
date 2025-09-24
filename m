Return-Path: <linux-kernel+bounces-830301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA3B995B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E498165004
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031DF2DC762;
	Wed, 24 Sep 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qBwQmw84"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185323D7D7;
	Wed, 24 Sep 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708419; cv=fail; b=ebU9IlYgTZQExgZBEgSOnEw5lM/3kKr6p2RtzeXlek+LZ8xLlAy7LsXxvnhylp3tM4OnnIjDymlK8i24Ci9ThPRPkLGN8+6f8cyuXDXZcNHuAEQtpV3HTumR36aIuO4O+sVUyxdj2dKz3slpEO9k+z5dOI4cbyvIuBWtyh1ckvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708419; c=relaxed/simple;
	bh=1e7h4dESQgIpQ1h9gbnk5GirWgxb/vP34pvDRjFo9IE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EmMr3WAKpIFU2emozvQannHEnUaTvKbzP3fEJXe4zMGY+zgVVflI0NagJBC9sPjRisvyJAa/mtljyMfTteQ5cD8Gkpv+tSZlSwtmgsga1bRE0LGi3vcRCj6yut14My9fNado+2pRWzyx8bOeKjmG0UWXyTMP5Y/QiWC0cNjOBVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qBwQmw84; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiOSXCQgm26NdlYv8zCBI+1XqqbdRjOnGkca5ln+KNpYgWtfGXkqr9xJ+uTogHH65Kh1syPT2jx1uH4WpM25Lpz63HBILaYjFaBju+qzAzf2NM8NA43JFtYBQ04NdprwPIaXWC77iB8BOZBzGieVqXRlejhDGpao9rK7bd2S0gEYYmZsHawlYZb6+1mK0DDc3i53R8NGVfGysc+pG/c5DJDWsPNQ8TS/4jiO8VBRQ6v+UcAhsc7GOpHKLBUlhDmbJweOu4xDs2lzx0i+sFpfjPL4zFy8Dy7dh8e26rcsRItCFXK0mvqPj4dKFh7/TtXCSNpR11vcI/96KL7dLH7DGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha5Pudu9zkXdDwzzFSI5KfIZJoavXnuq0rQWRmBgMLs=;
 b=Eo+ifO+Mim79quTSIyfs8Wf6d3488muy0eX7ZaDaY/y4Mg2LLT8SfRSm1T7KkA4m/g/vZ8pXBznNN01Mb9gcB3aGfYGx1Kf7dn//iuO5DOQ6gos7UgSOxkjnGFLZ4toShO3XdaD9OtRnYpeVr/H2g78FgMZxci/rqBIIsjleREqVzdsUKM/lG755ktZUACAQ9fmnC0Mnt7Cz9TtEG3MSLhcb7qGUWCCbESTMBkOz1XxvAD8EXylmAe2ggCUjja9EhKPmnJTvYTYiMCm3+wRxFFP+DHz84Ueh9JFgC8okvxeLZvONjuIlIrcvXthW+ZOM+pv8AZUhY2+gylgVFeHyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha5Pudu9zkXdDwzzFSI5KfIZJoavXnuq0rQWRmBgMLs=;
 b=qBwQmw84UlXiH6mA64gC2pgP34HXWqgoFy6BqZlBMYLBNK3n9mF+Cd3HvaHjaEdgFP9gvXrhXMG9c8aCU2EphMrfCVkEzEF+jgPGkJUpsLmh9g9a4ff16sLUYKspXH0nHZN1erybY9RHbrj1Bk+2H6Lrdwh2DNBerw53tmqFdPtn9Cc21F7L5eTPjE4VTbVkCPvcAW0GqGy6CHXpJPUrvhngyAMe/0ffFLaMUrmZ7XM+QdEfWfmoGOv1DmuiBb0dsJHC5wkZWg9TMa+ZQ8O8LKgon0eLwwKt1nOI8SSr7G0NfuMZpHJq4Zzy+dXWtKFyxS7if7r+d5DNDRXsTqzVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DUZPR04MB9745.eurprd04.prod.outlook.com (2603:10a6:10:4e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Wed, 24 Sep
 2025 10:06:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:06:49 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH 0/3] Add i.MX94 OCOTP support
Date: Wed, 24 Sep 2025 18:06:22 +0800
Message-Id: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7C02gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3czcCksTY90kI/PEFHPTFEOTtEQloOKCotS0zAqwQdFKZYZKsbW
 1AGHzmnVcAAAA
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DUZPR04MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: ac213895-603d-478d-c4cb-08ddfb52138b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODhzaTVmTFduNkhDWmQzaWdwenI3b0VEc3FMQ0YyU3lPMUhmcnhjVDQxZFRZ?=
 =?utf-8?B?R2xhYUNaeUZ2akNrUDFLNnZvck5RdjV3ZFQ4WlhpNHByZEFLUEVyenM1ZEhM?=
 =?utf-8?B?ZmlPZGxZMk04UXNYeDNSTzhtdW9OSUJOTVV5Q0hoOWpJYzVLR1lkc3FEdjZG?=
 =?utf-8?B?SUNpbjFxY3ZWNTFhQzhZeTF5QitTWThmdGNpbUNJVXY1VkNCUWQ4NGVGQ3Nm?=
 =?utf-8?B?elNOaFJUL3BNc2Uwb3hKOW5LbDRWZUxSTzhJTjBibTNGbER6K2VzUkExMm5W?=
 =?utf-8?B?QzIzYTlsNXJtQUtpM3FQcEZYRVlTZFI1QXNDcHF2ei83TW5iRVdnMlpyZkR5?=
 =?utf-8?B?cm5UQ2ZMUDUwZEFVQjViN2YzVUZsaXB2Q1pWMFR3SVA1SjlSODNsTmVjRzN6?=
 =?utf-8?B?OFNxb2Zzdk9QSmpIakhIR0dPTWw5dVB5MmlGOXg5VGZOc0oyRlFBM0YwVmxP?=
 =?utf-8?B?VCszcnlrTkxSdE5kVjNadS9pSC9XSFEyR0V6VlJHbzkzcEtDVGptOHFOWnN2?=
 =?utf-8?B?emN6SHNyRUVXMjhpMUp3M0FJUGN2cFZFWU96UFpITVBmVmRDSnl1SUp6LzE2?=
 =?utf-8?B?VC94b1Y1R3lRT2FkeDhLZHM5Q1VtemZycS9ZM1loM1UvQUs1T3c1bjR2VWxy?=
 =?utf-8?B?a09kNjgzZVJoREZEREhkOXFGZ1Bvb0h4bldsUHluWnQxbEtxaEV3RkZrV1FF?=
 =?utf-8?B?aHBLd2dGT29NMWNDNEUySVk2VENpR3B1ZU04NlRHa00zZXNVYUF5d3YvRm55?=
 =?utf-8?B?OVBSUFpDaDFjMzJ4dzh1dWVlWTZMbXJrSDRQcVdOMDBoSDI1UVlGcW5uRWov?=
 =?utf-8?B?ejVYdUFSSjBxWGdtN2s1dnQ2Y25OVmhSUzYzd0xJNEh0ZVlyNDBoUjRyRVZw?=
 =?utf-8?B?U2dGWG9tSzdOWVVjTXJ4ajJVblFoOEJPK1ZrTlkxQUorSHdnQTVHSmo1emhF?=
 =?utf-8?B?eWtoRGJiN2ZTNXc5UVZSSDNjdDdJYkhSMmQyZDYzNDBLQmZtbUg0Z3duR2Rk?=
 =?utf-8?B?VlFLR29Lb3pzVDhrRVNidE1XMzNkNURVZUhVRFNJalJPR0ltUEplMmVBK0Rs?=
 =?utf-8?B?UFZjcTlsbzhlRjkybG51Qjk4aiszdVAwd1RCRnc5NFU5dXhvMWRPekU1NzU5?=
 =?utf-8?B?ajJiSzBHM3AwU0JDTzZPa0c1R3gxRnNkTTV3YnQvYkxFNkFMa0FPOTdZOEFa?=
 =?utf-8?B?YXRmbmpCVDNHNmg5ZDhtbXpQZ3BDWXBzeFF0L3R4d0Rkby9lN21tazZsc3NN?=
 =?utf-8?B?UHAydE9SVTdtWENWeWVLQlJ5S3NDNVV0cVp5N1Zqd3RSV09HdGtKQ3V5K2hK?=
 =?utf-8?B?Z0xGT1N3akM4dVI4d05sbGhwMW1qN1hrL1N6UGNVYzNtTEJZQjJDY1RRRFdw?=
 =?utf-8?B?Zno2amlNZGp3VXZJVUNmektnVklwQzRPTlg5ektBTDYzQnY0RFQ3bVdyL1FQ?=
 =?utf-8?B?UnF5b1R4MTJmSGluSTdCZkxIbElGUXdFNjMweEQxK3crZElPTFNTY1JQQWtH?=
 =?utf-8?B?clhidHpjdGRkRjV6YkRuOGJuVUQzeWptZjVuSVpsc3BNdXlBemJCZWdYQzc3?=
 =?utf-8?B?Qk92bFgraWZoWnQ3bTU2N0tyL3Rsd1pjb2kvNGFIMzE2NU80bG41MmJiVlla?=
 =?utf-8?B?a1dHakM3dXE3TW1QVUhhZlZCenc4YXR2ZjVZRHgwWHdITUhPVWNCRzI5L1ZJ?=
 =?utf-8?B?U25KbHhnM1NVQm9xb3k4dlpGYndVUlJ2N1hSYU9kTVJlNGlTY1d4VUpWL2xV?=
 =?utf-8?B?VDU3bm1YYS9lQTBOMVlPL0c5aXVaWDUyYUJ4WHF5ejRDLzBoVzByVldURURn?=
 =?utf-8?B?M09QR0lWaFFXNFFrL3BwTzZ4eHBXcFFkUDdXVTRYd2RtdklDL0s1OGM4Q1l4?=
 =?utf-8?B?TGY0NWJpTENNMnBUdkxPbkpiU3huT3BJY21adWU5WXoxcnZIREJBeFJtWkwv?=
 =?utf-8?B?Z3JqRUFvM3IraTk1ZWpCSkRzdVU5U2hJcHJwaUNGUXlMZ2tLZ0V3ZEdXcXRM?=
 =?utf-8?B?V1J6WWU1aGhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWloQzYrMTZlamVmeHpqWDJMWmpkazBXdHozTG9WOFlTckpYWXBqdldMRWcw?=
 =?utf-8?B?cFU4Ui9PMFIzV1QyYzUwVVhnaVgxUmRlaVdwWjFuQTdUbXFIRnBCMG5oUi9X?=
 =?utf-8?B?N0RSN3MyY3RJbVI0YW83LytHTE1KSzZGUzVZQUlvWlFjejN3RFdEQThISzA1?=
 =?utf-8?B?ZzlPdDZDMDlxdVZGQUw4QWJkUEdrZ3hpZUJGd2hOOHFIR2FYWENwM0FQVWx0?=
 =?utf-8?B?bTR0ZU1LT2w3ZU9vOUJMMmJvNW5YQUlUT0lMYTIrWGNIeGdFR0d3aEgxNFFm?=
 =?utf-8?B?M0draytuRm1iTUhYK0txL28xbjJmZmRkODRjSnM1SHQrVHVpeGIxbHZBcDJj?=
 =?utf-8?B?Wlk0ZDNPcGd3dDJsNVg2UVk0eWFmRUdzVXBPRy9wU1R4YmVKSW5paGVMUG4x?=
 =?utf-8?B?SmtWeGtqRG1wck9remNmc2toaHZiaFgwNDBTU1Iwd3FmS244QnBKQ2JPaTZi?=
 =?utf-8?B?SC9lWFNCUSt3dGsxSFF3SHEvelhHUmkvNFJXc2dxK2IraUdLMHh0d1RUUnRW?=
 =?utf-8?B?U3ZtUE9WeHRKUTdhZnRlSXBXckxqUFJKQlhjVmkvMUkydmg0T1p4bytraW10?=
 =?utf-8?B?RWNMUzk2YlpmL09GUjArZ2NxRVZMWkZvS0lBS3ZrTm0yb2FoOVd5MC8veDBJ?=
 =?utf-8?B?Sml0TmNZRVk4eWtiNU9pTUx0eHpqNWJoL1ZPUW5mVHlMQVo1NXZqcHljdlNQ?=
 =?utf-8?B?TCtweVZCMWZ0dHVXNDVwYzNWRlBmSUdTNjNaeHkxRjNNY2ZlNjhqcXRlbGdz?=
 =?utf-8?B?TnVyOW1LeVp1QVlCOVd0TVBpYllMK1NodkZqTXYwK3BDalYwRjdteWpJRDgw?=
 =?utf-8?B?ZFMzbVZWeENrcGgvWDNuV1VFNmxVYXhkWkxTazJBNTdkWHJub0NQMWIramIv?=
 =?utf-8?B?cFVCaEt3Y2w5TlhuUmFWR0tNMVk2U0NJd3ZPUFRGS0VCM2E5dGxsR1dyUGxQ?=
 =?utf-8?B?dVJSWGpDM25ScWRGc3NySHdpbXpyby9SaXRydytaU0FIL1FIeFczbkFJcnVp?=
 =?utf-8?B?QW1UNzVtT0RoVlE2dkFMcFpMTi9hQTZRYmUvMDJxTFdIVEhBOHV2L052cU9I?=
 =?utf-8?B?cGxqa2ZTdkZvWUlxdWJ6VW43RkRLSE5oODBVYTlwd1hWbUh3SDhBK1F2NytU?=
 =?utf-8?B?U2Vqd2FsNE0wSnRXa09KTHNyeC9LVXNKeFliNUJHR3gyc0grL0VIT0FydkJM?=
 =?utf-8?B?UmNQbm1IVFpmNlNIdEcwZkVJM1V1Nis0emMyUE9GY2NoT1dxajBvNGs2Z2dl?=
 =?utf-8?B?M1VOMlp0WGlhRWpKTFZrdTdxQkFERjZydFNGV0lyTXRvNno3WjBHQ01Xclds?=
 =?utf-8?B?NGFSbitZMTcycEd0WVV3UWlNcEFUY3lzVDk4NDVWSCswWDBGNlFFVWd4cUNu?=
 =?utf-8?B?RVRac0o4Z0MzVXpveE1LM3JwZHJ0S2dOL09rcjVCaUg3eVo0K2R2ZW9qZTNT?=
 =?utf-8?B?dFdCYlRDUjJTaFhmeWdLVUJuTnZDUDh1M3JiVGM1bWxxUmlBZkhFRStjK0tY?=
 =?utf-8?B?U1hYaWFlczM5SUZQS3Z2WnU1bVJmNGl6akQzTC9mSUVKSW1RTy9sWFFMV0wv?=
 =?utf-8?B?MTc3ZS9tWWhmNTlIdVBrcVcrV3d2WTBSU2ZZM0NjaEtwUWFXQ0kwVUdUWjFT?=
 =?utf-8?B?YWlFU3VHR0pjT2U2NkZ3UHk1NjhMSlJUWDZ0dFJ3MnJvWWYwMGNKeHJBdnJ1?=
 =?utf-8?B?Y2RkbFdZM0pGZmQ5czB5a0tieEM2MzhUQVU5T2k5ZUcwWjdCeHU2T1ZqY3dI?=
 =?utf-8?B?YzlQN0FFS2RWSWpoREVIMmpZSHJZVHg2dEd0THBJck54VUx1SU44TWJZSHNN?=
 =?utf-8?B?WUxEK1N6RitJWHV3aUJlalpqeWZScmxPckFUWW94SWdQbVcvQjZPckhLSmF2?=
 =?utf-8?B?ejZXN3NDYnhvZzFKVzBEVnJZc1dlOFljYlNHTnk2MDhzdVZJVlRhS1htbHpL?=
 =?utf-8?B?OFFoNlB3RlBac3FKMEVORG5pbE8zYTZhcUNSNWd4T2YrMDJibm5pdVl2NUc5?=
 =?utf-8?B?RXBtRFpoczcyakhsL1NQbkZodnNra0c5N0NhR1RjSTloRDlWWDBrTmxlWVdU?=
 =?utf-8?B?RHBINHlGZnVBQW5DR2o0eXdiYytDS2hLTkxUVDdTNkNzNFdiMURjbmY0bVBv?=
 =?utf-8?Q?/+16BwunMZdz1ZCPBzaSPU4le?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac213895-603d-478d-c4cb-08ddfb52138b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:06:49.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0nS5foLAtzS6/rLbGs3cPMvYXwHxXMrQ5ilsgLsX+BQ8YcPzyYw/mn9FK8V4vei9PL6ZtbgESQfiCNGVHgqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9745

This patch series adds support for the OCOTP controller on the i.MX94
SoC. The OCOTP controller provides access to eFuse regions.

Tested on an i.MX943 EVK board with successful NVMEM read access via
sysfs.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      dt-bindings: nvmem: imx-ocotp: Add binding for i.MX94
      nvmem: imx-ocotp-ele: Add support for i.MX94 OCOTP
      arm64: dts: imx94: Add OCOTP node

 .../devicetree/bindings/nvmem/imx-ocotp.yaml         |  4 +++-
 arch/arm64/boot/dts/freescale/imx94.dtsi             |  7 +++++++
 drivers/nvmem/imx-ocotp-ele.c                        | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)
---
base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
change-id: 20250924-imx943-b27ad75d14fa

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>


