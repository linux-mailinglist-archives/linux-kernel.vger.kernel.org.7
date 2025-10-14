Return-Path: <linux-kernel+bounces-853274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F6BDB165
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9573E68D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF132D5C7A;
	Tue, 14 Oct 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1S4fVe6"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1B2D47E2;
	Tue, 14 Oct 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470740; cv=fail; b=l0zQG8moNp0wV0gW/3dkPsT96I0zbv7TtZ7Yl6slABc9hcGQRnDbvIkK8Ct8WMT/UiDAoxO3G2goEu1tHuQM18QzUmSWHZVGoMm4T1tWzgQCHOQvIkIu/nW7gpa0sN0P1h0hmZEzzmuXzaDXi90z57ZR8ATp1k9DDnCfJbXo1Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470740; c=relaxed/simple;
	bh=4RnVBqZnX6urwIa7PpmAMq+hsU0mF32MABSVMzPNeqc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OUdn2c1szv9CDSPX86QeXeCH/VIS9IntOlUcDG1GKvNcos6y2OK2Bss0umj35OcehD/OUgsx3wbqdirB6sbvMgsost8LuIvcy7sYgx01CcvHCVrrBM5VbNzANBPz5I5qKpiIlGTdHUq3Tltc4JqFsvknB7Re1YSpPmj2JUB0jAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1S4fVe6; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrKrHM/BxfFvY1tvCS2ZTzGBEFGkBZ26cnKa6WC1R8GtI2ZdC9+3og67hG8TWU/3boV7yfno/pig0p/NOr2CFjqOnzwHSpL/YiiUT4swkkB+qhzKGGhxlzOkcUefKDGHkzu7+26Q9qhI8mpi7doLraRkHcGmNLZSjlA2HqHMNTC9VnOd11A+qysPPCyHCONWLW/UX7hD1oP0jYn4Qer9gTTH2EgjRlEAZmwN7CUe6kccGVylZOPAPntyESY+/BQ6wXrkkNiPoy6hFB/UmH58DcFa68+uGMQXOEa3rOH/WQsDYEZ3AD+65CBbmeZHgXCGB9ToOGPwsowE2kD3SekoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65PL8znCqn2YAFcoxdCGvLCqX8bQAPj1Ar3QOIouQxg=;
 b=TIJLo647H7tKT/Rp8RldiOV51asmqyKV+7EgxyqnPlaTcqgQWJwbGSPswQ/QzqOUfRtSzXcwM2xbE6Ab4vemH+UaNc1icT3JdHnRWFI18Ha+/zPf8Vn/VDdaWAegeqJq5eVEN6uOrDUOH6xfvHdk5Vs/EDg7QLOZnSFs04HTaQRThtsprPe9F+uN1nBNmDhcYdf69v5wZzdVEbYT/m29iu0wLzKlXa6/YC6bs5Dn7L/ZJCip8JFi49B9dPQshO3cIgEVJeqpuAxWIsm3KWHzqy6HQhaC8rM7OsnrcfCtUKRLp9y+/TdLbQqZ6dCFxs8Y9oKFWL/T08j+DD4G0/nwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65PL8znCqn2YAFcoxdCGvLCqX8bQAPj1Ar3QOIouQxg=;
 b=M1S4fVe6NfGWCDNfQ8WoGVVp8SzV5yH62uljmDYtrBwnnHyluXo0/0/r6rIOLDOxCvINmxoU7Ttz82tiZMtswrRw6gegeWHXMR4mvNZfLT5wI2LIXJ/UGSl46j9NiV8MtpneS0OVgJ5fBZIvgsU4k2v4W+bkPL8W2wmix3FiMOYE42aFzAsKtYkzibRXp6IVG6BrMVzld3nREM5wPCZg3gDC1Hy7pmaBRL/zN/1Cg7lktJ1qLbfQvcypmgakAf542Y2VNahKCcKjGbEwvqUIJApwxVGi4tHEa9zgjn5r56Q4u08yOt24tTIafikBVFqHqCNmd85gUUhjzrQzLzzjsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:38:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:38:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:21 -0400
Subject: [PATCH 4/8] ARM: dts: imx6q-cm-fx6.dts: add supplies for wm8731
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-4-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=1936;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4RnVBqZnX6urwIa7PpmAMq+hsU0mF32MABSVMzPNeqc=;
 b=ehTQiRcN9h1xqWnQUwkFl1dQikAqmTkIvkPLscdqu1QRXKgsuUNauycJ0DW0jVvUNBdtRnb2d
 90V7qxPYWW3D6EgaBIWkgyVBNDwiHCziPLBRPyd5mNh2tgEGhREr2MJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 71deda58-6744-418b-814a-08de0b59511e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnhJcE5GcnE5Vm9xS2F6MXh1TCswVldKUjVsR1BMZ1pZVFkxUXhkM1FNSUJu?=
 =?utf-8?B?eDlDOW1Ncm9WWlI2ZEFCUEQ4U2Q5aDYzS0VLVFFQdTJSQ2FvYjg1RXE0TUEw?=
 =?utf-8?B?NTRqaDd3OVJLM3NhdklZMXgrR1N6MWF4VlVCc21nUytwUjFGcHhXWTJCWUli?=
 =?utf-8?B?U0dka3FrRCtCaHNCUllaUmw5WW1xSkhYM1gxeWxVcGsxV2ZVM3Y3L1NpbTZq?=
 =?utf-8?B?ejF0MGRZbDh2NWtSMitGdlprRjc3djJabWxkeFZTQ3ZmRzhhQWxWVjhmL2ZJ?=
 =?utf-8?B?R0hIT291RXNRZ0ZmSVFUNWlxQkR6ZjJrSzNoUkt4aVdzSWFXeTkwQkJ0MmIz?=
 =?utf-8?B?THVESjJBVUZNMEI1LzN4YmJuMGlVTDluUzlyZEQ3TWNBYjg5Z2FoNDI4bFY2?=
 =?utf-8?B?WXFUaExEbUR4Z0ZQVDZDc3pLYXNIT3hjcDZtb0w1MVlmTTJPMnZmSm9aNWda?=
 =?utf-8?B?ZHZldHJnWENTaHZiVGt4OGZsT1VmSHpPVkRlMUlnMDV1d282bmhjZ2FrU29N?=
 =?utf-8?B?bVRLd0FCS0hCUTlxcXZJbXVIOVVQM0RXQXo5WTIvamdBeDZTeHJOYVJRNk0z?=
 =?utf-8?B?Ym4zVjJxZmZ6Nk1oUjY4dnNvWUdJS0YyWDcwMThqTXUzQ294NWJmcjhMUmFw?=
 =?utf-8?B?TnF1YjdHMmtSUWFLdlIycXBYbnc3RXVHR0hqRUFYeEZKZ2YzNHZCRTFlaVFE?=
 =?utf-8?B?K01HTUdSNEZEUm5MZEhFYWhhMXNiUDhhUVJldllJTElLSzNESmQ4T3JFY0Vm?=
 =?utf-8?B?VVFSSHVSREF5TkZ3MmM1VEtkNktOMTM5M0JGNFFRNjB6VmQrR1oyaUJud0Rw?=
 =?utf-8?B?aDltR2lra1ZQQWJxVWdxTVNzaUZJN2Z3SWFwS2lJd0hWVnBGMG9Nd2RFd2xW?=
 =?utf-8?B?aEovQVlEWHlncUdhdTM5eU9xeENXWjBCQXRPdkIwRXVVVVJkTTlMYWhmRzRU?=
 =?utf-8?B?bUM1L2xFa3JtM3lDMkQ0dU4yeVRtbVBKdjhkd2NQc1kxNDdQYlNiVjBtS09T?=
 =?utf-8?B?cFMvVWNIS21tWXJNdG41ckd6bGNZNlVHbGVLTE5zRDF5VHJtdmZGT0gzY1Q3?=
 =?utf-8?B?T0VvL1h1U1o3RFY3czI2TWxETmVjU3MyeFdTTHdIbE5uNEhqYjJIRXVYQURX?=
 =?utf-8?B?bDhvNjlaMnp1eVljVDk4b2poRFhMaTlQMHVQR2UrQ29GQndjZjB0aUFsTDAv?=
 =?utf-8?B?eG5wQzU4Zm1WZS9tOVpKV2VFaXcrL0FNMjV0RWdPL1lza3IrMG5tS3A3U2VW?=
 =?utf-8?B?VE5wSytrUlpCLzFtd1hoNGxRbzJ0eDkwUDk4ME43TUNKTXRXMlQvRUJ4ZGpH?=
 =?utf-8?B?ZXE5by9JU1dTRmhkYThQMWwxQUJyMUE1Wnd1cXFBbXN6RzB6c2JtTzRNbnVB?=
 =?utf-8?B?MGRMdkxlZzlDWU84WFM3Mm5kYzZnN2FIMXNZZGpqU2tIT3dzWmMzZlMybWJ0?=
 =?utf-8?B?TmR3T3NoUXJyT012MWpmdkVMTUVzYUpmNXY2bGhBVVJ3NU11VUVlVk5uNzln?=
 =?utf-8?B?WjFQV09aSWgzRVQ4UUdGb25DQmoxZHlqc3l4bUpBK3pPRDZCMDMvQjJJRG9n?=
 =?utf-8?B?ZzI0R0c5ZXlGOHVCRGtNbWduVEk2aVhFb043NFkyY2hwR2NXZWhQMzA5TEF3?=
 =?utf-8?B?NWE3eURqRlZlcDdHZ01QL3BGMGtVKy9YMm5BdGFHZW55MU9BRGRwcWtUbVV1?=
 =?utf-8?B?Ny9uVHpIZGNKWHBkeUFSZS9QV29MNHFQUXViMXhFOHNhR011bzh6d3gzTjQ3?=
 =?utf-8?B?ekRoU1R5bmFIWGR6bVR4bXdPS2NhK3NNRmxUMFdpd05UTW5EZENvVzhvSy9y?=
 =?utf-8?B?N0tQcUxyMEtZYm9GNk1mS1ZvVDZIakEwV3BvVTN1NW9RL2g4V2x3YVovUUFp?=
 =?utf-8?B?bldUWmc3aHVqbUdUSFZkcDJVSTE5OU9OQ3dkaS9ySUUwTkxTQlJ2bDRGZHpu?=
 =?utf-8?B?TEtiU3R6R040QTRuWndsUlZ6Y1BHZkxYMjZySU1pOGpzejlwOWl2VEhUeVl1?=
 =?utf-8?B?SUl1NUI5cHZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zis1dkFPWHlETkFCQnZxYlRHMjA5ZHZ4cnRqREFPY2VKWVB5UkhlS2hPOC95?=
 =?utf-8?B?eDFFZVNyNG04eFdwaUlHMzhwMFdBNmVsKzNmK2RDYW9NV1RtODJkbzJISzV1?=
 =?utf-8?B?TElacWJLeUFKU2VSS3JuVlpYeEVDaE4xWTFZZ3RlbHpmcVRIRkpuSDhRaU9J?=
 =?utf-8?B?dlRHZnI1K1NmMFl6ZlJoZ1NVcmw3eWhNTW1ZWVlkeWFleHpEMStkWmhkTy9y?=
 =?utf-8?B?OWFrWEJqWjdHQjF2L21nOEFFNUlmUnBpeE8wTEtPa2xiZzJoWnd2R2dkalBl?=
 =?utf-8?B?TmdnM1NHbjZ2VlNXeFZ3WklvaXRCOHZpK0J5NW44dFFJemh2dTFEUkJuL1Uw?=
 =?utf-8?B?WG1FVVAvOFZOWWIzR0pjYisxSXZXSzNQZm51T0hsbUlyZDVpRWUrYmdGSTNR?=
 =?utf-8?B?d3o1U01reUY4TnZmWHNaUHhPbzhaS1hTd1NxWFd6K2Z2Nm5raEErTWgra0Nt?=
 =?utf-8?B?VXBaZXNTK05ISkRHOFc2NXcxK01qUjI0ZVNvMmxNTXBOWXVxaS9JWVM0V0kv?=
 =?utf-8?B?UVptYlRMWGxiN3VuMUI0Yk03WDZ2aEFXZWwrY0hMazZzajlLeE5FZXJ6N2xh?=
 =?utf-8?B?Nm1jOHA2RjdzaDFndGNtSEZMZENxV2NkU09FNjYxUmV0UzlkZU9ocFdOcGJR?=
 =?utf-8?B?Z3c4d3JWRG01YjJZM0ZXOHBtOGF6YVZrTTFKMkFva3FERGJYZUFWbGZtL2xa?=
 =?utf-8?B?a1dkRHZwd1pRU3lIUm1rd3VHeWdOR3FrK2ZpWHdYOThrNHBnUGxuaFo3eTNJ?=
 =?utf-8?B?T2dVeWtueS9UMWExbjM0M0s1dVVlNEM2Vi9sWU1LSnFja1ZVNlFHMlBHVXlG?=
 =?utf-8?B?RUVCdStUSy90L1RaaVFYZmtGckhvUFcyYVE1ODY3VGJncmlORlZmZmJVTVBk?=
 =?utf-8?B?WC9ZbXJxMlBWekxmOEhaaEhITTRXWHZOM2duWENMQTYvK1pmazFSdnRqc2x2?=
 =?utf-8?B?SGpOa1p6U0pHWFcvTCt0SkVhU1ltLyt1Y2I5L3dqSGpVNEI1V3lpdWJDcjdM?=
 =?utf-8?B?aU9XRWtiendrZFpxMUV5ZjdIckdBdENmWDhVbUd5cEhpSlQ1bStIUHphVFVB?=
 =?utf-8?B?bVk3RTMydHZ0S0ZGSy91Z1Iwb2pHTkhYZE5lZUhROUdGT2JHSGw3dWZ0ditq?=
 =?utf-8?B?eFlOVVlVaW1Jdll2eUQ5d1g4N09NK0xiTzJkUm45UUdLNk9KeU4wLzViaC9C?=
 =?utf-8?B?aTVsZkpHa2xDdDhWWFFEdnB5UEZGTVQ0bm9GcEhnUUNQOHoydVhmMkI4ZWNW?=
 =?utf-8?B?bkgvcS9GVTVZTC9ZQ0cwY3ZjaFlTdlZOYm5Tdk5PTWdSNXlYSjVEdmZWOFJV?=
 =?utf-8?B?VXBUWFVXS1RYamFPT1lRejVENGV3WGN0YzJVUHZEd2dZeGZPRDhhSzVGQlJn?=
 =?utf-8?B?bmZ0MEdKcHRzdW9mYWpvRWVZeDQ5R2lONzF1U3lPOWdnTDF4YVJiMkx1R1lz?=
 =?utf-8?B?S3pISDFoNmFPaDB2WEV0cGV6cnNMbzBmMitZMjRhYVlFaXFTTS9LaStSNHRv?=
 =?utf-8?B?blVjTkZFVmFjZ0cwaEZVcWo3N3RKK2tSeE02SWh4UXdyTVFDcDZJUVVQdjh2?=
 =?utf-8?B?QmVZSXNJd0RPY3VKMFhYTytMUFpyaHlXTlBOdzhpNkExVFVTdlJlcFBlN1Bp?=
 =?utf-8?B?akQxOE5CeU4vWVE5M2x2YmpSMU5Pd0pycFgwS3FRS2o3NDBnN2lIejcxZ204?=
 =?utf-8?B?Rml4enhtSFFOdXlEQ1VMZFRMZTNqVzhGSXFkQThscCs3YzlYRWIramNqWmw4?=
 =?utf-8?B?bVViM3M3K0FiZ3Y3OFdUQ1JMc0xabHJ6ZU5TWjhOQ2d3Vk9pRW5PTTZKVXpR?=
 =?utf-8?B?NnNYcjRUNy9kRnErRW9hbzIweXVGd3Q3aGl2ejB6OXpRNUJveWJzR00rYWtw?=
 =?utf-8?B?RFA0a1FSWnFnci9jSUlEc0I2NWZTNzZTR2VNR1JQOGZPNk4zT251Nml5My9j?=
 =?utf-8?B?Y2hseFB3YUEwZGZ2S01mUW50b3MraGt5WjNZOStMeC9OVmZERVhYdVcwYUhC?=
 =?utf-8?B?UllGMWZyWmMxS1h4alFxRktYdGpCUFpLdjhxSWdpWjRScmNvemRkcXdnbHpn?=
 =?utf-8?B?K0h5cEJTcFlTYXZCbjRQcXNFWUhaNjl6d2t5L0xuYmwxM0hIdisxM1R2ak9G?=
 =?utf-8?Q?x9gvvizbIExjqomUh5FDk+qCM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71deda58-6744-418b-814a-08de0b59511e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:38:57.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbBMFKKeSBUyIZdCvvWmKKxM0y0Ibv3dVPgmkca94fGn9uJnOQhYCEh7eL9b5wQAUAdeKba8xvZKXiQOyN1c8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Add supplies for wm8731 to fix below CHECK_DTB warnings:
arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dtb: codec@1a (wlf,wm8731): 'AVDD-supply' is a required property
        from schema $id: http://devicetree.org/schemas/sound/wlf,wm8731.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
index 299106fbe51c4ac1e9e0a70a4ec12e16b8110497..1dc5cb41f260843dd1239f49e513891c23ce4121 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
@@ -99,6 +99,34 @@ reg_usb_otg_vbus: usb_otg_vbus {
 		enable-active-high;
 	};
 
+	avdd_reg: regulator-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	hpvdd_reg: regulator-hpvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hpvdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	dcvdd_reg: regulator-dcvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dcvdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	dbvdd_reg: regulator-dbvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dbvdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	sound-analog {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "On-board analog audio";
@@ -307,6 +335,10 @@ wm8731: codec@1a {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8731";
 		reg = <0x1a>;
+		AVDD-supply = <&avdd_reg>;
+		HPVDD-supply = <&hpvdd_reg>;
+		DCVDD-supply = <&dcvdd_reg>;
+		DBVDD-supply = <&dbvdd_reg>;
 	};
 };
 

-- 
2.34.1


