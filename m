Return-Path: <linux-kernel+bounces-774483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C155B2B2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250681B21DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80BF2773C9;
	Mon, 18 Aug 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nocSw5e6"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12693279354;
	Mon, 18 Aug 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550133; cv=fail; b=MpnAJzIvboC165fWFUdXqeCXBNnmVT06S3T8HgCy8f81h0tbeGLwoAkdMcmmyrtxHsYbwbyKgqv9HWjFu5MOCBP8SQWtfQL6VtmrPUVLUOVN35N+Muxg3a8aZVhwQTtXb54QP5x/w75LC8vYTjJip5IZCyb2K42nl/R8QcenLNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550133; c=relaxed/simple;
	bh=tn3W5ery3JBAeWLtuF56BZcs3OIz5vCwgrdXDSTo9kM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CD4DE5aSc/ksclGEOKP34lVHSjgx9Pp4i0NxTZ151wT/zf4iphqWNbxUbLp/pORPeca2LcnHbP04PFxo+SgtzUj5i0paUv4gh5uMPtm/5YfU5XFJFb/jq49SfVvQQasTZSMeZNXXGfplexUe5lhg6KIroH8fg88eo6nvUmRSk5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nocSw5e6; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsaWaeW+xlbs+KkKEJMED6GmrWBxtk7JOWhc9qkxVq8D2HyBVwgb1rx5qaDssdKF/TapAbYAG5Ix4+W4/amrwY2rNDfOeuCfUwGYNnesvtXrr4lHA7T5lm7wINynYarGM87GbtTfLSmnVcy4a4bFqQtpKAnjuOXQaw9IN+mb5Pc/O1+PxO3gBkJ+0Oe2l9FsQLtz7ZplnVY/51J0l1v+luJ4Gx4MSZev6k3dAtUwLBrIyuAcMetM1jZGqDubv4uMCAlNBdm1UCguLFBxOv0V5xt1/dASCjnG9dHPbhC7rk/KhXa0xJoUVeVvpkbZ8sCufq8xKt/vY3Fy5ad076PBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dw6e1s7qrZJCJ58z1m7odrGK1W38mJ2csPuV4f/1d5Y=;
 b=VgIaw4enUWgxgO7Tn5zNJnVRKFLOji3bTouf4cndxC7gaFmkXXVVr5K2bCADCFo/lPAFGVRAmas8uh9tdmfOS/FI5VxlmGTy9h1X/L1Ilfo1UoBZKCetxpyclv7tLvou4e9qb0Bwh55JHPUFGKCNLmvDVYTgfFAOY1aO4xIf7VQkiTRSFx92UYM/VhevbYWO0NgMmmD9yeYMlzNzAU2CCh2Gq6rIAOHcxat+avZ9Bw44FeEWFUeKB+7XqcFtmGrgKz0cUx7Bb1TOb55e+pF1dvlyIm+gtjkQqzKQrODB2uJBYRExNgvfSYixBFKl5CXhFweUMnC7pV2I1T6RexRyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw6e1s7qrZJCJ58z1m7odrGK1W38mJ2csPuV4f/1d5Y=;
 b=nocSw5e62c/TnE8zK/c2su+X4LgfvbF3EbKcUsBhSlxdZYYBu3NrIETjJpNt+5VcSJvkDOtgaF/VDf6JjjTfGg7h+VjvktGqNKQhnj9XBp2xIRUv3FaQ2h5USyq0NuUAfe5IFTJveQyk7HoH8go04UxglnAy2JyULRPGInI8yRrA7s2v8WU1sL5FrSIeqHc8bF2/qd6wydsiGsxP6sdoX9W18/Cv/oMHxYpHjnu+gL+5FZq6wNzWPwF5d6WIFh+U3+9QlRqmCfbR7u9oe46YwGrEVy+tGx6DjdhafUUQCYA8nNSXCkTqywb9AaFW3lTfcWjBgaj4M30+LgynFvNQ0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:21 -0400
Subject: [PATCH 10/15] ARM: dts: ls1021a: remove big-endian for mmc modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-10-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=931;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tn3W5ery3JBAeWLtuF56BZcs3OIz5vCwgrdXDSTo9kM=;
 b=LzaNKN/MUdIw5/Kol5gB7Ai42FqGtfoUeTAs8g+tPjxQB7x9X2ikg0NCF22TFYyQHKjZEXkRW
 TiIrLZjtMAVDDIm+rlulD+e+w0UdFL/chMxytkE0A3iSXq+VLgeBC2q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cee97c-3235-47ac-60e9-08ddde98a0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1dySSt0NS9SQ09YWDhnbzdybzhnNnJCNmkwcEdwYTF0bUJBc0lwNHNZVm9a?=
 =?utf-8?B?Rng1U2RYUHc3dlNoYmtsQkVxVUhTbUlmdkhzbHdoeVdBcVNmY1lGQjVueGpT?=
 =?utf-8?B?OXY4U3RiT2l4K1Iza21IVzFYeWczWDQ1QXNCaFlLaTBIK2t4Ykl5QlZ1a3B3?=
 =?utf-8?B?WWdlbEd5aEpqNTFyS2ZLWVE0VENmckNvWDFBL0RubmNaMWRwemExSHlhdS9k?=
 =?utf-8?B?K2dtbWVlRWMrWkR5TExjeTFQSWVGK1JNZDZPZ2E3RVVLcERHSTRSOGdOSSsr?=
 =?utf-8?B?THMyck5sdEpzWmp2U2xYZXY0bStRNFord1IwWnU2cE5vV1h3SHZSVFMvVlFI?=
 =?utf-8?B?SHQ0RVRGa0hQUlplK2t4R0ZBaFN3RmF6aml3SzczQ3BRMXdrQ1lpR08zc0pv?=
 =?utf-8?B?ZFIxT252ZlgrK3dqYXVLSzJ6ZWpsMjYyRGpWcGgyNWp6VkJEYkF3a1dVQWM3?=
 =?utf-8?B?OVVPcUsydDhhZnBvZWxDV1YzMWNKbjB3UC9TVjRYSTNmQ2IzV0tVbEdMRDBz?=
 =?utf-8?B?KzFVR0oyWjJyQmRNeFZLU3E5eW1TRHBGang4TkRxay9yeWpWbWx2YnRtUHpH?=
 =?utf-8?B?SGRobjNJM05pQmEyL3I4QlRWUnZyZEludnZseHd4Y2dzYXVmTGtGekFWbTUr?=
 =?utf-8?B?U2FXMUdEK1BqblpPdUlsbGRHNTU1OXM0ajVRdzVudWVhNUNrT1hZN2tFQ2lE?=
 =?utf-8?B?aFZGdkhHemZHVDQxQUhlckdPOW1IUHdFMERkYjFVTXVxRWNuQTUxYnNmSkk4?=
 =?utf-8?B?SFpkYmdrSU1HVkdMbE9PaEhnVzBLT2FJQzVlbnl6aHM0WW0zamlEMG9XNDRT?=
 =?utf-8?B?dG9uMjFqeWVjRFJFNTVVc3hQTjhramhiR1BLYm5tb29QMnFXdEJaVnUxMXBT?=
 =?utf-8?B?aTR2alp1RmhndkpSQVA2NGpCbjcwVzRJamRrcUhNeTZhWTZtemMvMi9tK21J?=
 =?utf-8?B?eGVydnpvYjdReE9kcy95Mlk3TEt4dnVNbkxoSmp2bjBsbThwWk5LeFRHZDYy?=
 =?utf-8?B?QnVGQ1poQ0dGcW94TG1PYm5uOENTRU1hN29EMVp0Nmt3c0hINmFxWkhBaUhW?=
 =?utf-8?B?MzRBWXMyaVdwU3VsYVp6RjdwcFpoRU1oZVdJOGRqclZPSis3dVZxOXl3L2ZG?=
 =?utf-8?B?cGoySzM2UGVsby8yMU0yR2YxaStuOXFvQjNWcWNQNENwbkJycVhhbEtFZGdC?=
 =?utf-8?B?eU8rSXNGbnpORUpwWmNFWlZTNjRkVnYzYllPaFp3TEZxU3dRbEg0Y2pyQndi?=
 =?utf-8?B?bmhILyt3ZnFxcUk3WHo0WElhdVRCQUZIdUZVWEQ1TWh3b0MzNmxiL08rOGhP?=
 =?utf-8?B?M2xyQStKWnlVMUxzaUZ4Rk1OTkNwTER2QWNuTG9RRjBmcHVDYmtWZTFnV0RG?=
 =?utf-8?B?YmYwdlIxT1hQemtpbHJneE5RU2x5bGNUbm0rTGtKVzJacVpEVUtMZzNBczhw?=
 =?utf-8?B?Q0FMQlpPVXVkSlFLRnRFRnVQdkRHUUpsYU0weTg0b1V5TlA0dXVtU3IxK0Rq?=
 =?utf-8?B?bU5wYWxJUW83WUZhbUhyVkdQS05Tbk5CeSt6UkhyNUgvSFNyTi9SNW1Qemxo?=
 =?utf-8?B?TDZ4dDFIZmpOWGlabGlBQW43L2dSdmlZYlhGSlVhQnl4cVlaNnpiaU03Yi9h?=
 =?utf-8?B?ZEpNYVd0WnZ1TEdpQkdpNi9hYjdIUnVqQjZ4WCsvUXFWZ1pjSzVKbG9hVC9F?=
 =?utf-8?B?SGIzZXJTTDlkY2grWW5vcGZ6Mk1RdEgxc0lvelQrKzB0bW5rSVNPS1M5U281?=
 =?utf-8?B?em9HY1F0WXJjS0kyNEw1ZTFKUDdSVFpYMGEza2xpQXJTUFBwdVZYTTZid1Yy?=
 =?utf-8?B?QUFqWGgxVGJYNVkrYllqTWNtZWxUMkdkVlg0WEc1WXE1NjRyYjJrNmprZ04r?=
 =?utf-8?B?akNXWldUbGdmM3pyUW53Rjk5VXpOWk9JV0tZWmJXQ3RzNVFBbVFPdWd5MXJt?=
 =?utf-8?B?L3ppR0UyTXlyYllsZmZMNVJiL2JHN1BKVjZZajR3YUJkb2RmMWw3ZnJUUEtO?=
 =?utf-8?B?MWlMWnhVbDZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3ZKL2l2NlJhL3JIUFRtenh3MmpYdmpSU1FyaFRoMUV6TlBrbnkrYnVaayt2?=
 =?utf-8?B?S2xWQ1RiWmhLUFNlQ1hRT2p6RkJpM1VwU3RzSm5GS1NodWpDRzdZSCtUdlhE?=
 =?utf-8?B?UFRic1FZTTFKaXlkVHVWVXVvUkRXVzA5T1p3ZlBZU3V2LzRjbVlId0M2RUdX?=
 =?utf-8?B?Q0JLTW9CNlJHdHBrbFN4WnlIMWR2VFlmUzYzZGs1M1FjR2JyWUx6dVRXb3Ri?=
 =?utf-8?B?QTd2YnhLNVNLcXZXc0k5aHRpSkNoOE9FeUdlajdSTCtGT0c3ckFGYXpJemdP?=
 =?utf-8?B?eUZxQjJ3SEc2bnpsU0NnUXYxb1NHU1drOHhxUEZNZDlnRU42L3BJb1UwSEVk?=
 =?utf-8?B?amVlZ25aYm9ReFg1dGFOek5reEhsanUrSHlxSGJMbFF0Q296aVVyNzFzZk9a?=
 =?utf-8?B?SkhySVVheXJMajNKU3Z4WWhWYXdtLzFGdVRISDRxdkpSOHQ4SDhxaTJaMDh3?=
 =?utf-8?B?d1NOUGQ5dURGaEZEOU9HRzRSdlQ5TlNDbE5nNmxmeFRjY1ZKa2hmR0FUWWZ0?=
 =?utf-8?B?eHplWnQwd0NNanRBYWptQkpkL0kxZWZYSlkwemUxMWxmSmovdUtnMll3U1NL?=
 =?utf-8?B?cTczY0tnYVQ4blhQazZyOFpXNFk0azM1Z3VQMzhRdlp3WTMxUVBGZzVFQTJQ?=
 =?utf-8?B?c1JSenNVdExrNERiWm4rWDRITnp2WTJNTGdpdkU0NHk3TU9RbG0yNGRqZ010?=
 =?utf-8?B?SUIxcTExdW1ESjN5S1pRVGlETlJvL2FOb0JiUmFQNS8rVUF0elN6U1BkdVZT?=
 =?utf-8?B?QVFIYi9KSnJHUW9OYmNPTGhtbnV4KzJJUkJBNkJTNG9SQVpMZE0rbTJSUStG?=
 =?utf-8?B?UXU1SkN3TUMra09CNVFSTGFESXRsMmlqdndKQ3VzTlc0MHl1ZmZlTlJHbkFD?=
 =?utf-8?B?dE04R2xvdldqYnIvVlBaKzdienZzZmxxcFZKZmZjU0d1Y2Rta0p4R29CcFlZ?=
 =?utf-8?B?TjZqeG1iWDgySkhPOTFjV1dWMmhOWHdYRjR5RGtEN3lqY2VBS0d1V1ZrQTZ6?=
 =?utf-8?B?TUpRZlhMcXdONFY4Ky9DbmZOVGk5ek85Qks5SVJmWjJYWXJDVTRHUzZrVFRq?=
 =?utf-8?B?MDFreURpYU5KcVlKRU16aElRM0pvUGZCYmlhMTJYcmNEUmtVZy9Sa0JjbllN?=
 =?utf-8?B?bjZMdURCUjgzM3NDVUhnZ2V5VC9Ialo4QitYQWhQZ1lTc0lnQmVWV0pRQmFO?=
 =?utf-8?B?N3NSc01XS1JPUHFHNHp3U0VwRHMxSmd1RERFOGVHcU9WaGNtTGx5eThwcXM4?=
 =?utf-8?B?U3FUd2xlY0o5RVRDMGJiTWRGcDcvWEZSTDBaQ1BJTmZxcEM5Q0RrTmkzc1NH?=
 =?utf-8?B?eGhEd0dpaFE5RmkyakR2Skcvb2plOHljci9ZV1JoVU90M2NZYVB6d1I2MVdl?=
 =?utf-8?B?R1M3ajZpK0UvL2dPdm9FNDU5V0pLQmo1MGJHUkkzUittWnR1V2hWUFRCYzZp?=
 =?utf-8?B?YmpFOFJYL2lsYkZKUUhOeGJka004UVNrRTk5QmVrWkdNNm9mNmVNd2RXaHV2?=
 =?utf-8?B?UnlrVElJOE5EMG9MVUtJNUhHSUlqYlFRbE5QbVNRTW4xbkIrVUZOa2U0ajNO?=
 =?utf-8?B?TmVlRTdBeTBIckZrbW9JaS9LMDU3aExVWmNRL2tiRDE0SnJROS9SMkRTaWF5?=
 =?utf-8?B?VHZFVXBkOGE3OW1LRk9EbEM2MTBNSStqS1J1dmE4OGl6L1VmeU1sMDFNdXcz?=
 =?utf-8?B?UTMxQjlmZmNIYmZXYnRwRW9VT1g4dVV4cmdPcEg3SDh0ZUcxdmJDL01ZTTg1?=
 =?utf-8?B?Rk91UUhhZmthTXlXazAwelBtTXg2SW4yTXFtU3lDK3d5ZjVqMUN6Um9Ob0Vw?=
 =?utf-8?B?TzJyZUszZDJURm5ob241QjA1dDlDSG9OOGcrTHBlRWhyVldDajJZVm5kd2Zo?=
 =?utf-8?B?VU1tTDVwNkM2bFlyelhlcGEyVTkyVWw2bHlDMHdjN1lVVlNCZXh1bi9uZUFs?=
 =?utf-8?B?V2U5NllhQ2x3dEg3K1FMcEQ0WU8xZTUvcC9aMEpBWGNCK05BQmxuWVVIcnUr?=
 =?utf-8?B?QnBmVkNKUXNkOVdJUlFyY1pQdEtKZ29BdCtFclpwOE1sOTI2cWR1K3ZpclZY?=
 =?utf-8?B?S1ZHSEtBNGU3ZjJTZHFERDI0TzRrekY3eUswL0VaVlVrcDdxOEVxNDFoR3Z3?=
 =?utf-8?Q?LbxZeIkZ599YXgJTlPN9eqyvm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cee97c-3235-47ac-60e9-08ddde98a0b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:47.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n5NwK3uSAo1NYLAdj0Z5XEf4pRyA7knrI1pUa+px2HEV8yckh6ZHqMedoePyE7zO5397oG8G0WDOtaoH2ivag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Remove undocumented big-endian, there are already define little-endian at
binding doc.

Fix below CHECK_DTB warning:
arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('big-endian', 'bus-width', 'compatible' were unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index e16f7f2e3878372f3e622c57705cdbe9f5c7d15b..444fa5e2d42cc8f0ad81efded818b4420683622b 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -161,7 +161,6 @@ esdhc: mmc@1560000 {
 			clock-frequency = <0>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 			status = "disabled";
 		};

-- 
2.34.1


