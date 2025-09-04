Return-Path: <linux-kernel+bounces-800186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73250B4345E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061A31898D59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7A2BD016;
	Thu,  4 Sep 2025 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Qt4P7yau";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="kL0zO1/0"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C728A1D5;
	Thu,  4 Sep 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971671; cv=fail; b=V3ybDfBVC3jPVHNSgYViMLUIF38ABvjxPh9l3RrfmxusFCwMmXb4TxHmwFT7bVbbZ9wIG0+XSLc+HEesVnyPCddFtTQzZTHsqWVdra9OYJMTftdkqBzcwWC6GshNXianpogtLTbs9PPtxc3miTijvXQ1gJ1w2x5rov0l7qb3rjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971671; c=relaxed/simple;
	bh=YTgzyM6o4R6v28Z/4RlVOX8CsG4KjW4BEzguklezk5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cbhZWODR/QBzLZ97QHkbjz/qVXW4MsJSOjDj+3a6A/01dRca8N3LKuRYwidjSLYmRuXcGx8OPDvplFYijddPC6Y8g1tyV/PMSYGc9wvNUIcV5htagZUduCfoZvNWmPVuhP4HE2DV5yRa1H/g7W+2LiNcupxNdMl3x8SuBTYVINg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Qt4P7yau; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=kL0zO1/0; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5847ddv8017389;
	Thu, 4 Sep 2025 09:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	IQFaX+NCSOFZl5JW7RfGMdPvT2pnJR7kDteLk7nJcoI=; b=Qt4P7yau2YgQ77M4
	1ePTs1NfxNGKeIE57gEv4Jq062MivKUC3F5vh+8ryWjeXZ+NdgjZSaQsXfvH8VPx
	sADNqMsw4O+RtOAjqMUKrRAfn9donU0hW3G5HNkeMo5CYbo9fZCIY2in3JtFvyda
	EUA18yamdKQB3BrX5/+5ja09TbF14CfDC2hQsGXTmr5rN9evUBzgTnSZCWuf4Xvr
	gBfhjAMAPP/ZljojjnVF49C0s6au49IDSE4L1qnwpdZ9amal7G+5/H1chYq0iQoG
	MOxJSVE88L/6CWDXFzFDlppIb2kpMmNrot+Gub9TPPk9z6xRtFANfV4laz29NN1p
	WhbxTQ==
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upe7m7yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:40:59 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxjSHYg9cvJxGww37YKPQDVX5keifYHjGpGMvYxwr4M1oNqjoDgdT/mzryw5HCZufSbdLDDVcrOpG1REmF2weu1K/G1oDwm116DA+W7H+vZN7cYXJUgK7zWTAMovi74OoOr8Hw/qoQTyYbU+8ka52hJDLdWr9P1IbwjGrsWVD3UHS+6usDQV7LD1Tb9fJ9+pvTXhCk0K8aAoX4E32Mx1pjnQQU/05XEhfk9MEmNHE+gks0ElQ9ajarT05ne1QsGNexUyUd4CSjzxgrYbO6HeNXpUsJX0Lx0CzYMvvaf4mARtw8SfiujPGZHgMlR2yPqrLULRsE1rAZEFJ6uJkrb28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQFaX+NCSOFZl5JW7RfGMdPvT2pnJR7kDteLk7nJcoI=;
 b=PDs7MnBhQwimVDfKfSIEJiyiOwHsImazxq7xZ8hbTGxqgESUiUQHlLQ5mJr5H36no2zGgID0GS0kfWsyTC5FbR2aljg0NJze4b/djR7nYphbloxzhcPiZ8qTmrmH9FS2IDk6T9mbyBSvmSPNuijCocIc/K/lsUwCmeKogYTnX/2h2x7l0AbTql9fmel6hzjM02CYK2ZRdyxrbjPFog6qsZuKmxTf1UDD1SqkXlh4yM1Pv5cF4aMW4YuZLcPNGN2uFjJbBjT+K4ii5k1fjohCeNy0pYaARGKPBM2qLOHGxYiqYgjZGveiTGiYuQmOIF8N1Rt66BKL9wjtmyCnKxldJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQFaX+NCSOFZl5JW7RfGMdPvT2pnJR7kDteLk7nJcoI=;
 b=kL0zO1/06GkahmmZl0gJzR087vjuMU6Q43OfrUBXBTffT4JC0cAHFDSblxFQrci0/LQjYP46STw4gmqOCy9NMJK5vvc3M9heR0NAUguG6tfjt363W3J4JYu9QWiltfnuJCDMwxEjem+Kiv+139naf6qMOLsfBrm32rndqooYiwQ=
Received: from DB9PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:10:1da::19)
 by GVXPR10MB8415.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 07:40:56 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::5d) by DB9PR05CA0014.outlook.office365.com
 (2603:10a6:10:1da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Thu,
 4 Sep 2025 07:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:40:55 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:33:41 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:40:54 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 4 Sep 2025 09:40:58 +0200
Subject: [PATCH v2 3/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250904-mp2_ethernet-v2-3-05a060157fb7@foss.st.com>
References: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
In-Reply-To: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|GVXPR10MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: e393f3d6-d2a7-4e99-9a97-08ddeb8661b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVJYem1uZktYZEFWN2Z1bFRIVm8xangxRnJzeHVMeW9QdUJMQzFud2lkTHVI?=
 =?utf-8?B?Um5WMDIxMkEvTTBLdTNLeUpoZm1uNWhNTG9qREI4dHl1eVZhVUErS1FTc0E0?=
 =?utf-8?B?NWJlcnlpdXJEb2d4NEFJbzUzWVB3aTlQcTFRdDRJdGpEZVVKTUhETnlQYmhy?=
 =?utf-8?B?WURyVnkvS1gvanNHamZvd1JyR0tzeUdaQXFlaWFLMEZGcVU2cXB6Ylkxck91?=
 =?utf-8?B?NllrNnJoVkljQWVhUnp2a3hYaWVQMzQxRm1ESDJLYytRQW82ZEJ3UmdIL2hI?=
 =?utf-8?B?bWg5c2huMDM0Z1BNVEpxeTFOTmoveFZaMUJaL0N0amxIRFFNcVI1ODlRV2R0?=
 =?utf-8?B?RXo1Q25kLzhTeXBlWUhiQTRtM2kySVVRZ0tTUkNjTG9uL1RXQ2ZETndneVBL?=
 =?utf-8?B?eWZ1cXNrenk4K2liYy9maktTMXBUSy9QdUU2VTNWTmhhdW9jN05jU1kvc2tj?=
 =?utf-8?B?czBFRjg2ZzFzdTJYdjAyTVZjcmtFZlN2L0RXQmx6bFZPN3Y1T2d1Y1Y4ZUJs?=
 =?utf-8?B?cVc5bytXeHBOVHBZL1hwcGhDZlNPUlVVMDRLWjJoelJ1UU5namJEeDZLa24v?=
 =?utf-8?B?ZXJZZ0o5Rk1vMnJiQUlhMmJrWlNHK2lIMTRvWmI2bDgrSmVCOUlNVy9PTFhC?=
 =?utf-8?B?MWNBc3lrd05vT3lvbDdSTkc2T2t1aGpQVENmMzBCM2Z1bXJ5YkZhSjJNbVpP?=
 =?utf-8?B?S0ZVMnh4NVJzYlpoMjhSUUxyRUU2T01iMFRkVDA0UTQzUllJWEhxeDloVEto?=
 =?utf-8?B?KzZLSHQ3TW0yN0JhSndueUF0bnFuK3hyUjNjUXpIaU5ZK1JZRVpXOVNBajNU?=
 =?utf-8?B?ZG9keFlPUTVqMjBlb2NEZDA1ckV5WXRIeFdyZWdMUGVUQStLbS9kZzhPSkgw?=
 =?utf-8?B?aFZlTUpsVUlScmh4VzlSRHJiMXBMZUhLdFpRUC9scERncDJ2aVJmcnc5cFc1?=
 =?utf-8?B?RHpnZ1l4ZEQ2MUg2b0sxV1lEbUFDVE5mQnovNDdQUUJMcDhJMVNZWU15RTNZ?=
 =?utf-8?B?STFLa284QTI3cFpDZEp4NFFUNmZCRTRKY1RoUE1lbGdPYTNrMXlPTS9xNkRs?=
 =?utf-8?B?UkN1d3U4a2MzWVBDK1pqcFZwblhselpsVk81dWlwTUR2TnNOSkQvU2hWbTg0?=
 =?utf-8?B?SDBIelFrMC9rdStRSWtDOWZUaGk1MXl2a2FOQm9uY1FtNk5oNE9nS01XNU5F?=
 =?utf-8?B?RHdEZlNJVFhRZ2lmbFE4VGNrcXd3NkhzNGtjUjhEVEdQRU5EQ3o3aExseU9G?=
 =?utf-8?B?amJtM3NyUWZ5cFNTNG1lVGN6azY1WXo5L0J0eXVZaW0xaDUrRDlBWjFNSHIr?=
 =?utf-8?B?QlpwcWpxQ3d3Ukc4SnVvWVJhSkxFSGc0UzhOTzFkTVMwM0ttclI0anBhUjd1?=
 =?utf-8?B?VlJNVWNUTnRJeWN6QXhNK0tPZUdUWndPTUxUQXZqUGx1ZmpjVEdRbmpxVVRp?=
 =?utf-8?B?NFZzdUxVS2FxSHlkK29vSkNZaUtUS3hmcVRsdWVEb3FPL3g1bWQydWp5dXRN?=
 =?utf-8?B?cmlSb1FwR05ZZUluYStIL29OdmIyeFdHN1J2NDU4NDM2V3Z5TUFTR1RCeWdU?=
 =?utf-8?B?WWUxcHJpVm1BK01ZMExJTjc0ZEkzanYrL1lDN1dyQjhHYUladklJVXNHMnVz?=
 =?utf-8?B?ejExQUtGMkhjQkJQTFBkUXpLekJKQ1R5dU1MeUtlTjBFR3dVam5ZVXlGZ0F1?=
 =?utf-8?B?M1JCZ1d6eVpYR0hmVDd0ZFc0eW5kdFJsOFN1N0FBMkdlNWhYRjhlSktmZzVS?=
 =?utf-8?B?VDJWUHV4bk1xZzFXalV0TFoxNlhaZTluOEp3dWxvVXdsTkNKVHQ0Y2lWNlR6?=
 =?utf-8?B?WklXWnY3MnFQWU9BV3NkaCtNQWlGWFRFQzFnYS9UY0gzU2FycGpzdDBuMHlp?=
 =?utf-8?B?RE5xZUl1WHJqVTJGdHNjNlFWKzlmbGlqdDJweTgxUUx0bkEyL1QvNVVnZndV?=
 =?utf-8?B?KzJhWXJmQm4xZ2lkZjQwUEVLNUdjSE9Ndjh5d3lLcHZ4dUliVzBOWnhFL3oy?=
 =?utf-8?B?ZHpMQXNCeDEza2pTQWEzTUEzSzBGV0oyRDhkUDIxc2c4RG9MVFpBbmlWTWZl?=
 =?utf-8?Q?v88QVM?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:40:55.2707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e393f3d6-d2a7-4e99-9a97-08ddeb8661b4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8415
X-Proofpoint-GUID: wpPjrynm0qSqcoln2_Mbs3VfadbfCXDR
X-Proofpoint-ORIG-GUID: wpPjrynm0qSqcoln2_Mbs3VfadbfCXDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDIyMCBTYWx0ZWRfX9GFXLEf6Pfc/ LzwdxN4KXG9IJYkGad/aZex/VTiR6HnX4/uEC8DJfJEVMSixnOluvC3doPemSroutHvdDPP153Q h5IVlnOrI77CnNPls+2iYglsoEF/TSGrpHDslLwmD+4+lre+nE92rpsAJC2jDp2LqypK0bHrc5q
 LA5N1sdMje3T57SMMgNCQLe04RBwE6zv3p2kaBONm85L2xtS/vZY1r9pYsnn51A/8bgvd7X7nSV v2wOgDwG5uUkpBGiccP3dKktCbPzdEQjmSk7gBb22ufnolIPXgcMp2Nuhg0wkBSQLxuxXDna6hf VcVM7YJpSTYdcuObxCAya44G+d0OBPVBrc09mP5v4Cx/Jd1RkWAtOWUOmBAAP1EKuu8H0x9feZH +C1tcfml
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=68b9428b cx=c_pps a=Dggi2S453XbURtHHLXeW4Q==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=qvGHX6SqaNg6NtJdrj4A:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290220

ethernet1 controller is connected to the RTL8211F-CG Realtek PHY in
RGMII mode. It can either be used as a standalone Ethernet controller
or be connected to the internal TSN capable switch. For this board,
keep the standalone setup. Also enable this peripheral on the
stm32mp257f-ev1 board.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 4ff334563599b46e987474076798337e75e16ef7..1135826c011ef40c3b16ac5cd888ede85e54165d 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -19,6 +19,7 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet2;
+		ethernet1 = &ethernet1;
 		serial0 = &usart2;
 		serial1 = &usart6;
 	};
@@ -133,6 +134,29 @@ dcmipp_0: endpoint {
 	};
 };
 
+&ethernet1 {
+	pinctrl-0 = <&eth1_rgmii_pins_a &eth1_mdio_pins_a>;
+	pinctrl-1 = <&eth1_rgmii_sleep_pins_a &eth1_mdio_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-handle = <&phy1_eth1>;
+	phy-mode = "rgmii-id";
+	st,ext-phyclk;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1_eth1: ethernet-phy@4 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <4>;
+			reset-gpios =  <&gpioj 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
 &ethernet2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth2_rgmii_pins_a>;

-- 
2.25.1


