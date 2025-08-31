Return-Path: <linux-kernel+bounces-793249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73366B3D111
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369A517FB90
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5F221739;
	Sun, 31 Aug 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHB07dS1"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FD2CCDB;
	Sun, 31 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756623189; cv=fail; b=pmNHsP+K2OKX3doONQZUJcKxzV+bGu35s6CkT+rms1Vw/lQQp9CkYsBnM8sxg7BcW6u3oLBLZa+5XZWUTg51x+LzEGlD0dV0T0YklpOtVNaFIKrfOFZaAUHTqrGnNQBAL6xOfgSWKJaIq+8MOsylwYo75N59ogCFpCmSvhL+QMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756623189; c=relaxed/simple;
	bh=jitSfmGIV5W9t1RJ6AbGTydFxeiQ9QJdguVuEyY97yA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=gvsUg2Q73UiXH5G4LAj5BK5tsRdxMS1oBF1BJTQLGVRb4RJz7xxQdnk4+NjY/R0WQVhQIpZxhN2u0bzyjuefuaSpSdL0neQzn9GePJJAtu+ZnaJ5R9IiXIAFMlN4wnosbyfa049HVyedxVcgHEYwez5xZ4Mdl+Yre5B/SgqYBE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHB07dS1; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrDXyd1igbH7OvUhsy1kzrInZgFEsCJ3tjgKfHQRQo0771LH557PGpXwEs4oTUWPbfAQAqNlablwM1+i2pcYCc/yLFLUd2DXet12yJLjgxCK12WaqDgha0ytrACweAdydrTHBSSxjvwFUlfuuOBY4lzDd5Wf8r3HTw7ZWk20tGto3lDzfyvGi+lkQNq5/S7sD+ZVWOLLr7d/vdd0PPvS2VV21mbnwHc3+9NQr2AUsIGx5p6efya5opPfX/GwzjXvEG+AnlJwrXp77ObU8tPMl1sfwVie9J7n+n4s+q0UBpfzkgLrOBeLzEthcYlngtvq7StAnG+SJxfukNYIAzccaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zU8QHTwibUZPZEInyV6WN+DmIrPUEWk2NEVidvinjk=;
 b=rmBm1DZ5CDC25L83+NjllSNfp5LJwI2qPxZ9HCDN8X6o/4kSRUMMfq7DHhtkUxIQYH0n7L2pnSUZTrn4IZhcg0yzgmk7ep4E4d0s2Y1XKTOagkPGN2Urwq4yEU8hN5MIO/jQl8xfVEH6bqv7Q2H9O7pZ32P0M+fyuUl30kStbfdriOHT8mXkvA/GG62u4XKoA8L+AMXKBxDKoNb21x2UcACBV1s8W3u01ckxOdbXW1GaJWlay3ofqH8KyA5GzJ0P0qC4KfcP64flT4xvfmNxS0UlpBODS/Gh9xGCuS0+XNc53mZzHj99MMvV9RHDmRomiOQBGHRb4gELTyTlZ9WkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zU8QHTwibUZPZEInyV6WN+DmIrPUEWk2NEVidvinjk=;
 b=DHB07dS11sln0DooUNjcSd0obXZvs9PX2mNhBK4EUu73l0ce/iqJxn1fB77PV44eON9jXuAvagMBg2IuMwmj3C8/a6Ca/MOtTtP8J/sAc5dqBILivdqe4aPYJdo0+TJL1O5MSOQ/k7Q5sed/g5euEbASiWxFBnsx8xf086k8B6I7l9m8ebcXOxEw4BDpYnwM45VAMwnEhpsECaQ0ecg/t/kq4PN5DhaxOYmorU9sQdGXxA7e/djKZmLL46iF1BTaiM+79yjdp8VZPtlDWt7GIGzjcdivklon2WjFug+RZrU/KBhDwYH0r21ZcRWG46j7y5ozSa1ezEQsrv6JVVDsRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10156.eurprd04.prod.outlook.com (2603:10a6:150:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 06:52:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.011; Sun, 31 Aug 2025
 06:52:58 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Sun, 31 Aug 2025 14:52:37 +0800
Subject: [PATCH] firmware: arm_scmi: Fix typo for scmi_perf_proto_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-scmi-cpufreq-v1-1-493031cf6e9b@nxp.com>
X-B4-Tracking: v=1; b=H4sIADXxs2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC2ND3eLk3Ezd5ILStKLUQl1Ly1Qjs1TjFGMjAwsloJaCotS0zAqwcdG
 xtbUAVH2zdF4AAAA=
X-Change-ID: 20250831-scmi-cpufreq-99e26e3d3208
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756623174; l=1042;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jitSfmGIV5W9t1RJ6AbGTydFxeiQ9QJdguVuEyY97yA=;
 b=FOAyKMWMC0NSNNpklu6NjB6K+jxWK0n8fL0OniYHnA2fbj1T0jq8JdWwAp0Ktm429/91Jl0qM
 Wk09p9yf98zAZ2JbxZpxXKKt1v4RTzxP3Ry9fp/zjKgkFqMuywVX6u3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10156:EE_
X-MS-Office365-Filtering-Correlation-Id: ea329421-fe3b-45f6-c6cc-08dde85b0501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3Z5a3RoNUsyYzJmM2c2NktWSzM3TU5lcndSUHZnL1hRQmROQVhVZk1LbmZK?=
 =?utf-8?B?Rit4YWh4RkhpUHdBQjVUb1p5RTZNc09ueGc2MGh1bnV1ekZCc0lJeTFRamZZ?=
 =?utf-8?B?eVB2bWZsSm5RUXBWeEUxZlVBM1c5ZUJxTWVZUlpPbjRwa2FNbTZzbkEyUzRE?=
 =?utf-8?B?M0FkeHovU1ZpMUZXVVFIdmtRQUEwdVZRMVpQSnRjYVl2cGlKcVBoeExXL2la?=
 =?utf-8?B?OG1OcGNiSmR2ZEVmNmdOS2Y5TUdpYUwxUGw3ekNIR1Q4bFc5MVJDN0JSejM4?=
 =?utf-8?B?N0Q1SUZ0RWhDR3phb0R3RjNmNjFvZTRnd2l0RnNHNEhyN1paVlp0WXdXZWF3?=
 =?utf-8?B?ZVpYYUo5Rld4dXVLbGthY1BiZHZQRzBsa0lha3JYU3hLOFNQT3cvVDU3YWdO?=
 =?utf-8?B?OXBZUmpoTVhNVG15NkpsQUpOdFZUL2c3aUpJUEdheUE2M3doblZOVStuMlZv?=
 =?utf-8?B?M1NtNXVXTDg0NDlCUGUyRXgxMWpvSlZSNUVpdVdIbW9PWmtWVkxBYWYxTThy?=
 =?utf-8?B?MUFHZm1tV3Zzd3dJMG1DVzdseUNXOTMrRk5WdTFNK2FjS1FCbG4yUERuS01k?=
 =?utf-8?B?R2FIVzZmYmZiZGVUQ0NKdElUU1VwaW83a2J6TWNIR2sxNzBHSU4yYWwyRlBp?=
 =?utf-8?B?NG1NbXBhLzV1VGlOenREamUvVW51RzQzbENzaGtxMnFhSEtlclNLVCtWMmF5?=
 =?utf-8?B?d25PNWZXeXhoQlNXREZKMU9GZCtnSnBnd0JGRzVMYjFiTkFETEdPbDFZaVZi?=
 =?utf-8?B?bjRMYVpZN1pxUERwcjh0QUNoQ1ZKcExTdFlBUEl2NW9BWGV4SkRJN3dJeFgx?=
 =?utf-8?B?WFlVTVAzbjFIKzEyTzFHMEZqK0ZQRXFLYUxpWUdNSTN2c0I2Rm8wcjRkNElD?=
 =?utf-8?B?RlJWZ0RmZVpKRjZFMWh1Rm9WREhRT3JHSGF1dTdqeHZ1eGptTzN2OXhLRE1Q?=
 =?utf-8?B?M2lyWnFURDgwNldKTVFwd01vT1FZMHpGRG15TGc3YkY4dGQ3bkkxeEJiOGNB?=
 =?utf-8?B?WmNCenUwbU9FWWRQNXZld1poUURhVnBzYlZmL2QyQXZ0TnNFajg0TktKYmJL?=
 =?utf-8?B?bU1HaXZ1M3BoRzF4QmY0RGpuZGtobm94cDUrQXNZZWJ5cnpCdjVaSE5meW1x?=
 =?utf-8?B?Ti8xNW1wTTRSbU9pUTU0aURGYktmM2E0Q2dpZEg5UTUvZnBLWGlZbjllQ3cz?=
 =?utf-8?B?VEpsVGxzQmhTRmVuWXpkMzM2QXZ4N0pOcEZoZW16WWJpd1l6cTVTdFZwRGZM?=
 =?utf-8?B?eitDZWVRdGNNUXhmWXFHNnk0aEhqZTBhY3E0UW05Nnl1cjRFU3R6RnVsd1Nv?=
 =?utf-8?B?VE1YcXVGNjRuMmV5U1dYMXdRRDBmK2pzdmtzNlN4Z05kRUVEU0NwLy9TcVdy?=
 =?utf-8?B?cno5dmFqaTdyTVM4RGlna2hOblRtN0NRdTVRNWVVOWtxamw5NldmTTdPazd4?=
 =?utf-8?B?Z0tucXkvTlUrSXBUanlQMmt5ZVhncUg2V2cvRGlnck9RZVB4T3YxcHpyMHVh?=
 =?utf-8?B?ZHZpdksyVndyNTFSMTZuQytXaGJSZ29BNVFtYlpxd0RhdDJsOStmR1hvSE9V?=
 =?utf-8?B?OVNsYStrVG93MjMxYlNPenUzTUczUzFOWWxRck42U3BORFFOQjEyQ3pQVEcz?=
 =?utf-8?B?Zk90aHVyY21ZbVpLTEl2ekMvajdZbmcvdFJ4UFVVM2F3dHY2aVEyZ2VsMU5C?=
 =?utf-8?B?M2RKTjBtZnYvUHNhL05SSXVnc0puRDNPbThLeGpYT0ZYeWpqUGhDMzlCaEg1?=
 =?utf-8?B?TzlJNEpGUzl5SlBtYmlPTUIrWTRpWk5WZm1TRjhsN0RTRWpzU0V3MkxuVW01?=
 =?utf-8?B?UkpoQllsUWlRbko4N29hcms5cU1VN2MzY3A0SVBiMWxYbE9TRUNxVzhvSExZ?=
 =?utf-8?B?WFZGenFPQWc4b3RIeUZ1aytLT0xpQ3lqUGlWV0xwQ1hXQjJ1NlNkWGVwL1Nt?=
 =?utf-8?B?b2VMZHVneW53Z05tMlFldFBOak10TkwyUTZYTk9KMEMzMFJpQTBkL2hhS2NV?=
 =?utf-8?B?UUIvVHhLRjdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBRaisxV01ROFIzR1cvM1NJYllkeW4xYklzYm9hUnlpMk1OWER2VCtsWTk0?=
 =?utf-8?B?c2lzc0pqanc1Y0RtWGhtRjI1ekVEWFU2ZVY3Y3BGdXl1VjV5eWxDenkyVHRx?=
 =?utf-8?B?NjljclBmMHI5WVNWLzVJWlRxME8zb3A3UGxZNlN3QW5pTmpTQ3hxWlVPOERR?=
 =?utf-8?B?ZWFEZXlud1FuejhOT3ExOGo3NXZCT25zUDZsZjB6SjBPRzlNcUdpaEk5d2pC?=
 =?utf-8?B?Q3NhM3d4R2kwbS9neCtVWTR0UHcyRGs5dnc2RStWMUxsckJ5QnUzSFVtakFu?=
 =?utf-8?B?YnRTMWJpRWt0N29sK0JDa3FDNXpnVXNHcGRIVnZaMnl6VmFLcXBNNzJSZ2Z4?=
 =?utf-8?B?ck4vYjQvbDlKNGZnQTd4WG9FS3M4S3FtVmxyK3FpaDFua0M5R0h1VHBSYk5C?=
 =?utf-8?B?WU1Gc1B3VjRQZEV1Tm9yMXhpU3RFWFZFOHN2b0gyZHoycVRkQmxicmpKV2Jn?=
 =?utf-8?B?VzlLUlBKRDBRRm9rcGhGTVpiWk5ZOTNKNlVNRFpIWG9uK1hBWXFXSDVqdWxw?=
 =?utf-8?B?cVI4Y2lXdXE2SXFoV2JrNi85VkhOVENEczVVNlRPM2liRXNEZzE3TWt1eGFN?=
 =?utf-8?B?ZjdWazFXbllGdXp1WERjMHdiVy9oSkx0ZDFxT0dEakVVRVdubktkYWxSQmdI?=
 =?utf-8?B?b3FFU2Z5a1k5a0llcXlWT0Nud3dPOS9ZOVU3RGJvdjMxTXRYTlByZGFCTmJ5?=
 =?utf-8?B?aFBNOHFEeUhiMXNhQlkvMWRpUkpYM0dhTk1sNlNXTktNTlgybkNrVlhkeUtU?=
 =?utf-8?B?c0I2MVBtdDZKSlkyNXlWeEY1T1RQS3NHLy9ETTVBQVpTRHlyQkxROWozVlNR?=
 =?utf-8?B?cklrVFZmdDlwNVIzWFd3TUhzWnJpWUJiUUNidWtIanMzRGRqR2prWnhwOG5Y?=
 =?utf-8?B?djJWMHpMc0VSNVdBczdnL3ppaGgyMEdqYzlvblVFdVF6QWRnRkdSdVZ6OWl4?=
 =?utf-8?B?VlRIOVlKazd5SmpGYjRTWjAvaWJobFN3TjY4TEVsbUhEeWU2d2lEbVRkMHVT?=
 =?utf-8?B?elZKNDZlRWFzYnRXcy80SGY4NXk0cWNkREd6cjR2clhsalRKRFZtVit1QUFJ?=
 =?utf-8?B?OSs3S2FDYWp2d2MySEEwVk1sRWFpMGlYQVgwWHVrNERqUm5YQm4rbklsbUoy?=
 =?utf-8?B?bXFPWjFldXFLbzR4OG1kREFKc0pNZ0FYZlZvQWRSY2xzcWNsbDBZMVhTcGpS?=
 =?utf-8?B?ZW9pdW0rSnh5KzJ6SDVZMmZUVit0aFhCVlFWZk5NbUJsbFBKUE5XYU1ES0xl?=
 =?utf-8?B?SkZWdDByK0RXbEFkVzZsdlptQWFTN2JIWVpvZ3dHdWZHMXVBdEdoZDBSSzIz?=
 =?utf-8?B?b2s0OWVXTTZYajBRRUdwNVR0N29xNUd1dDU2Rncycm4ra2ZJV2VsVjJnSGk4?=
 =?utf-8?B?U2piZUg2VDYxSXB2bTYwNmI2a09ocklZbkVUSlYydy84d2wrRVFzbVA2WDU5?=
 =?utf-8?B?R2d0QmlKc3JPZ3BEVzh5eGxtWnlPUFRoeTlqYTFldVdycWpBbCtpQ2ZibEhx?=
 =?utf-8?B?MFVTdzVUb29Lc1NDQUlzQ3hjWS9SQkFSbm1FMmFUZlRSQjJ5RFZQbHZRdzRW?=
 =?utf-8?B?N3lWbmdzMUVWUEd5Sk83V0FHWTBuREtDUkZXc2d4cXYrZmc0KzU0QXBHL2o1?=
 =?utf-8?B?NWhxcXVQK3htZlRDU3IraXlrRGR0djRjMytwS2dGdWVjZWNvN2UxQ2x4bTZn?=
 =?utf-8?B?aEVKUG5NZDdlNjhJaURDQWJNNHNjOVpnalVBZHU3ZDMvZDFRUHZVd0N6ZHBm?=
 =?utf-8?B?Yllmd1gvczdmVGw4dGFjZ1dHSUhHR3UzSXFTRmFja1dFNHYvT1hHN1VWUlVQ?=
 =?utf-8?B?dWF3Z0FJbmR0NlFRQ21MUHVWUURmYm5laVBtajQ1UzRGVk42Sll0V3lINXF3?=
 =?utf-8?B?R1ExVzg4NVRZK3ZRSmNjTHljZFZZbGRDREdaNk9kMEtOMCtJYWhhbUdYSnJT?=
 =?utf-8?B?VXJDVGZPdWNOZzlHcll1MDNzczFWcFA0WWZ1MUFUUmVaUTRXK0NWSlcwTDg2?=
 =?utf-8?B?VE1CT09GcVYrSU5EWU5jVGp2WTVFMDV1NVhMRENIYWkyTldNVWMwRk16VFVy?=
 =?utf-8?B?YjZtcVMwRFFGa25CWVc3SnhIc2VFN200ZStZSHUyaitRTG8yQStEYVJPd0RL?=
 =?utf-8?Q?qcqgG4R1TcPRWo0KgOgZKDMoS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea329421-fe3b-45f6-c6cc-08dde85b0501
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 06:52:58.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN40ow2kP+F5UJLOl2j0sXh520kHjJLzcftgxfs0yllCRID2Zly0YBoy+I8Qr4PveR0KcF4vX3FTwSmOcb59/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10156

The name is power_scale_get, not power_scale_mw_get, correct it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/scmi_protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816247d24704f7ba109667a14226b67..aafaac1496b06a6e4f0ca32eee58a9edf7d4a70f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -153,7 +153,7 @@ struct scmi_perf_domain_info {
  *	for a given device
  * @fast_switch_rate_limit: gets the minimum time (us) required between
  *	successive fast_switching requests
- * @power_scale_mw_get: indicates if the power values provided are in milliWatts
+ * @power_scale_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
  */
 struct scmi_perf_proto_ops {

---
base-commit: 3cace99d63192a7250461b058279a42d91075d0c
change-id: 20250831-scmi-cpufreq-99e26e3d3208

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


