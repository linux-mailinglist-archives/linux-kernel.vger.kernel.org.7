Return-Path: <linux-kernel+bounces-874649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF2C16CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C86A4F89C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB02D6E62;
	Tue, 28 Oct 2025 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yu9a40bv"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CB25CC5E;
	Tue, 28 Oct 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683464; cv=fail; b=aC6NlM77hxs1C2QrYKR61jmmI6w57z2vjiB7+c9WvTJzUNDKHTu4QUM2mQr9dwzURpz1QnCkdI2e36MZOvsv5RxMQSS2dYUBqEGWLC6j97OfkPShJS66W8t8dy5c3fcC6jXfgDkiT1mK/6tZ3UVqDgI710QtmUDGgJwtzFaIJk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683464; c=relaxed/simple;
	bh=75vig7IKteXUz3E04sCzeUjMIP0JvaBbxuZ9d5I4JA8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KKLGSWNhNUufviCfAE4NdflyGK7i4BR9kocomb/g2TddmKszrGtOsIoe7Zv3NKe+5s6/iZj+F9eGNaUE0sWwB0YIbAuPLeG9EM1EajnRCK50gHsjktJ9u51DXFsFog0LWB+mUQoE5+c5TrjHQC6nz/fe4MTBrc/U4S16lq7L2Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yu9a40bv; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtiE7pT3Y4hp4CT+NaeRsjHepSMkIsP/8fkrQY00Fvb66/nBT9abNyrEHjQdYG6wseTLeKoqty4Hu9SIgiCjgdD78ubPTGQ2MieXw0NaCZX0WdFWmfCLVWdQ27ok3nqjXCPFHCHjck9tZChDm+kXQaHiJCREDlaC6pWi8h5mibLdaxAVyEHmLiGfRta+DJMvqdHb9Gk0HURDfkpYtPYBTV+Yv+NqWqf2hzp6hI7TeRuhkyDK1bDVxh0NastJisRzwO6xhVyLtgm0PidiLkpMLTmq0JUIdJGW2vgk6NbyiXPJ/h+tARerh4sTpdDNRFYJoBNXYijbpYbOcNaWRGfBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivtY0GMauDra9oOObMZ2IH0j54tFtRLE7UpLIbe0hck=;
 b=HJUfnSWiyEd6i+DfnIeyfGHNo4cf52C2q0LzSnGSA+H8jLpysz6BT5avxLSOI4bNqiIHu84cmMQDGcLtR0FNkhSd9mUIgDgvrD08YHGbSq24kLMamSt7I5jClBUlARnkjJ4MGUXjViQMSD6sIHPuhohkp2b9QbqQDK+MJKS6xOCtq277D5nKobWjgkbA/Un4CIPWuFqew2odpyBLFH/wITeoi7yLYBbz0xUgBAkg++0EhQb9n/qiJwgWIabr4Mr6Xfmbx4alRRKkifWI0rbKDo8+qox6QZFnmUlXrzG/Fj63k8doRSYCiYXtckeR3W60xcjjpF/lWKK3zPLNELzTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivtY0GMauDra9oOObMZ2IH0j54tFtRLE7UpLIbe0hck=;
 b=Yu9a40bvg3ztLsr43GakHcxwsQ8Krv75Ytveefx5w9v1n5a0qCrAnn0kZCWbmYVDNzMPfUoHbSeHXWCd1WyDLpaCvYpydZNyc165bfRnY7wfTX31/wMbvIaXaUJvSTyevOFJSS1MaLDSZ0vR5cV2jzVtS9D4OHiWEiPJptpFgGVw6JAG2SV/JeFN0+MXkwDyENWWcuipBfcpns1CG8UX3zgT3maW4ekYm9gbSzjfAvvBwFhwmdpaOvAzwUhMUAaei5GEJ1wrDfivqeCIOQjTqjl6ShenvfWLWe0Jhe2XRcpPbSvEOwU/DrkBQNmUxEu216zn9Sr9cPNZDL3NcyZgYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:30:59 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:30:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:42 -0400
Subject: [PATCH 1/8] arm64: dts: imx8qm-mek: add state_100mhz and
 state_200mhz for usdhc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-1-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=1757;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=75vig7IKteXUz3E04sCzeUjMIP0JvaBbxuZ9d5I4JA8=;
 b=K+7mQsW9/fAu/U3p3J1sn6xQxRKD/ROqw3eAodsrCNmAZgPecvr80pQUiozlk7/5dypUjedQU
 47zJN3ZRx1cCDHIacXXNDfU5jc19+tjuLuc79ONN+r4Svq0U0BVUwyq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bb5139-63b2-4e47-4223-08de1660e7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azhPTHA4STJNaCsrYTJZQjk5UW94TDZIMTlXUFJoak5QbTFMOFpRNS9ScTh4?=
 =?utf-8?B?QUkwMmxpQUJkaGIwWk5jUDdlSVB3VzFNZjVRSlZFN1FFTlNCbWQ4SXZWU0tp?=
 =?utf-8?B?bzJzOWF2OFdVVGdmS0dXS2t1UTg2a3BiVEdzcldxMjNBWit0VURtZXNjeGp4?=
 =?utf-8?B?R2F0VFFUZFpzeHY5K3VoVldDRUZBOUpqUHQ5LzRTQTliR1ZITDA4UkUrcGtM?=
 =?utf-8?B?Mk1aYkxqU2lJd2N3Nm1DOVlxZVpwNTZVcUtURVYrRUhMNU9hbmlzS2tjeFlF?=
 =?utf-8?B?Q2xkZjRlMXB3WExjUjdMc29DcVlTQkNuZmQrNmt4SWRvY1FSVmtBZldFWFgy?=
 =?utf-8?B?dEpib09UOXo2YUE3RGJCOGRtMWFOdlR6dHBYSDdQd01VVzRDbEREVm1RajBO?=
 =?utf-8?B?N3pPWjVLeXIvRVg0cGtkN3BSdEZLZDhmVHU1NWRjdWVsUXEvdzFBYVNwcUZI?=
 =?utf-8?B?SXpwTVpUUTdLSjFNVnArOGFZenh6S0pSblIwMGhraHplZEJkSGR0VERUeHor?=
 =?utf-8?B?N3RQWGlXUnl1SHl2WHovUDlxRStHQ0hlY1pNVzNhZVJNekptblVnN1BaNTFQ?=
 =?utf-8?B?OGsxTUlzSklhQjlIYTR0ekVjQ2t6b24vQllyL1pTQkFrdmZsNDJud1lpUXlj?=
 =?utf-8?B?YldnYmxPc0NFOWd2cUpKcUI4Y1Z5N0xEMmxEYXBmMGF3MEJuWlNLRDd1Snlp?=
 =?utf-8?B?QVV0cWdjYjZUWk1mVmJNR3ArNE5zbVd0anZnK3N5RVQ0NGd6MEMzUDJYRVdm?=
 =?utf-8?B?NDA4TzRZMjZNV29XbmxoY0NPcDJXcXBnUVNRVXNEeGxhd0NyZUZqbG5PdXE2?=
 =?utf-8?B?MDYwQ0l6Zm9xT3Rsd0NlMS9rVXB6OEoySHF2QXBHN2czNnJScmxqYWM2aDha?=
 =?utf-8?B?dnRCUmJJemVROGd5eFJJYVJIbGFKeEd6cjVMQ0tjNlJjTU5IVXp4Y25sOG4w?=
 =?utf-8?B?ZEl6R1RoTHdhNjBpZmpBL0VXdE9QYWVvVW5HRk52UTdua1BqNWJ4S1l1aXVK?=
 =?utf-8?B?T1Jxbm0xTFU2ZFJtMFhuZ3U4MlQ1QmlXOXF0cWFSdXNPUko4SnN4NWVGVE83?=
 =?utf-8?B?VUZqT0JWcklHemo3NlNoamp4eFlRd3VKd1RwM3FGT2tGSTl5a29uekNENVJh?=
 =?utf-8?B?L1FodXVESFFrdnRXVnZoQXRrcU1iUmVQUXZGMWtGSCtyNnpybkIvVytzSG4x?=
 =?utf-8?B?OVJpZm5iSkRXclBtSnRSNjljek9NSE1ZejE0dmFpcTltanppK2luWnJkdHM3?=
 =?utf-8?B?QTExSkgyWlRsZkM1VlM2Yjd3SGd1SmlSRG1RdFV6anMwMnJKMlFCSlFMZm1F?=
 =?utf-8?B?Z2xqM2oyT3FvVTBXTVV3aUlRdVA0dGd0am1nMC9ETDBINEU3STRMT0lXN25p?=
 =?utf-8?B?bGNRYXl6RDIweThFMTRGdlR6cG5YOE92bUlkUmYvR0xBVzlFM2JxV09nb1VI?=
 =?utf-8?B?STByQVBMcWk3cG5FS0tlM1hNa3pucTI5NmRpZHhFV0cvUkZoMkk5S2srOE94?=
 =?utf-8?B?c0tRU3lqcUk4cXVKeW10UndQQjNvVEJTTTV0UlhtcHRRT0xzdlpmVUpSV0pI?=
 =?utf-8?B?bTZkRStmTXZZOHlCcFZvOWk5d3F0bDZMVktRak5wTmR5UkhVVjBOT3IxWjNC?=
 =?utf-8?B?NkVOOFBOeGlZb0ZRdS9JVmR4V3hvTElLQ29TTDVKcHRIdU9wSWpPSDdscmh2?=
 =?utf-8?B?eHVURTFwY3pUSUtTenRBWFh6bXFway90Y24wdldoWVgrNk5SdFZDMldlaUFV?=
 =?utf-8?B?MjQvQW1nS3FWZi9wZ2VHcjBUVG15am5SemdxeVplRjZFNVJMcStHcTMxVXVh?=
 =?utf-8?B?ZmlTSFp2MUdYVjRrU3RMKzlQYXlyVnZxQjJaczJkRkhSMjAxMnR5Y25ZMDI2?=
 =?utf-8?B?VkF4MklnZkp5My83NzM5YUhpQmlacjRBMDQ4aEhGVTBnY0lGYUgyTDdTckdx?=
 =?utf-8?B?WVh2RmwxY2xEak43QVplck5lWExRd0l3aXo2OVErdDIvY2hDeWdYL3BNZ3VG?=
 =?utf-8?B?eURPM3lvRHRXdWo3Q2hSNzZNdEJ1Z0hrcDAzc0Y4dFMrdWNNTDYxNFlmd093?=
 =?utf-8?Q?xa/9iW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm4zVTNnMTVBbWRQS0IvUEUrOXVoRFd4aUw0Zk1RNHIraTNhcmwvYXJtRVE2?=
 =?utf-8?B?aTdScUpXNWVpRTFVV0FMc0IyMnRVZ2xnVDhWbmJEVklYS0h6aWZCZDl4WHBR?=
 =?utf-8?B?alRJQlh4YjhRQXppOHlwdWF5d0c2akVkWlRoUWhLYXdKVVExL1QzZENmZnlv?=
 =?utf-8?B?enNPbTZqR29GZGlGY0k0U1gzeFA4YUtTbU50QjVENDlQN1BXbzgrMzRzSWxR?=
 =?utf-8?B?cHVsU0ZKeUJmU0ladE5TRk1LbW5PeG9qQ0V1T2ZUMENqTGd1eERtckFUbVZZ?=
 =?utf-8?B?YUwrdGFvd0xPeUwra3pMZ1VGQXpVQVNwQmFSRDZmU2dsWXdQVE5HQlpIcmwv?=
 =?utf-8?B?S08wcWEyOEhST2hOSUxueGNoU1EzZkRVekFQSThON21vSU1sMWV3a040UjVR?=
 =?utf-8?B?MGFEU0JMOHAwSCtvRmI0cmp4L3NYUVd4c2hNZm9tWEpSU2tqUTVobDRZRG95?=
 =?utf-8?B?Qyt5T0dkRDhFc2VtTVkwaFZVbDVaRkF1T014eGpBNThCaERBcGJsQXh1Z0hl?=
 =?utf-8?B?QUlDSUsrMWExd3ZUWktuTk05N2dJaHBSVHpxcWh1d2YyR0pIOVNkdkk3U2hl?=
 =?utf-8?B?aFkxK0lVcndXbXVDRVhLNmZQdDM0ZjM1OGFzMVhUVFJkZGh4alFtTjFIK1hT?=
 =?utf-8?B?WjgyYXd2Z1FkRXBzVERrdUk2enplSThVUVMzcjdZeUtUSThDOEFTNWhhb3o4?=
 =?utf-8?B?dkREUHZERmVmSUE0aWpydGJJRExtblBVMEpLc3RNZFg1S3drZm9reXdIYml4?=
 =?utf-8?B?UEtlWndIUjN6UEdnQmNndkJMTjR2UGJVc253TU5tQVRheWxjb1J6SzA0Mktw?=
 =?utf-8?B?Ty9abGlkbEVld3ZpWEVieHBFbjVuZ0pOM2h6U0N5d1ZJamw1N1l3aHRIdXRj?=
 =?utf-8?B?NlJqMDc3b1AyZVVtL3BCMHNhMzlmb2c5akJOeXN5YVdFMjY5VzR4bEJ2bXVN?=
 =?utf-8?B?aU51S0VKblNPWW1nN3BoRzBaMFpOenVaN2FDVDJOQ0daWjMzRENlb3REdDdx?=
 =?utf-8?B?VnptZHRQMW5lZys4ZGpCNEt4VzZ3b3g4MXIrRG5CQ0hlR2k1cloyd3dGMFhp?=
 =?utf-8?B?SmZOaWhCanZzZkhqaFY4aEoxTTNpOTcwWDhaYlE5Q1ZUV1JpdmprVWx6alN6?=
 =?utf-8?B?M0VMcldJSFg5RHZyS1UwdTJ3VHBtbTNJMWJpQjdqMm9uVDNKYzFvem9CK2xh?=
 =?utf-8?B?b1NlYk5ZOEdBRFVnM05PZWNjcjA4VWpkSFRKN3M1NzBiRGNmbFNoVEhrWThn?=
 =?utf-8?B?bi9la0N5NFpVUUg2TXRsb2hzSTlVZk13emRIUFhMQUNKdVVpNG9YZXF0ZmxO?=
 =?utf-8?B?bU02TisvUUxqRVI0Y2wzR3gySnFIZjhXWnRpSEhUNWNncE90UDZ1azdrd0NE?=
 =?utf-8?B?a1dWZnN2ZGQrMkFGd1NVR0RyVncwWDVoMDliOHYzZ20rYnd3RWNCMFUxZFFW?=
 =?utf-8?B?N2UvRklib3IwdWVhR243Zzh2TzFQTkV2TjI0ZkZTUmJLMkFCdlVJZ1I2QTEz?=
 =?utf-8?B?Q1dOMUlNRkEvbVc2UjliT1ZaQjQxNUU1TnRsWmRhOElJRDNTdGlRekd2dUhk?=
 =?utf-8?B?bllKL0o3ZVNaK0Zsb3c2ZWN3UmVUS1ZpVXdIZ2JrRmRTeUtrUG9SSE9nVmxL?=
 =?utf-8?B?V1R3TGcrejZaM2dudEFnTXBaWTFZRjdCMW1mdFM4Y2p2b2xKUmcyNkE1b09S?=
 =?utf-8?B?TGRIK3BTTGdGQ3NiR0JxOXRNOWxNVWVKc1EwSE9ZaXZUUWVJYjI2Y1hGeDIy?=
 =?utf-8?B?Y2xKRmZOMHFLVEJZZTRIeHhoZlFxOStUSW16ZUJSNmdIQ083UHR5OGNwUEVr?=
 =?utf-8?B?K1RYR09VVGZSRUNJclAwY0pOanBpV2tYUW9MVWdOaE9HTWdMYmNCOHY3RTBW?=
 =?utf-8?B?bDR3dk5waWg0UXBRREtPR0VTSFh1UWcwbnFEaXlQWTJ6ZFZnVWxxZmZQRDdZ?=
 =?utf-8?B?U0tIMjdIUUVuSmpyc1B2T2Z0SUxkeVpNdDRiNjZqaFNxWlI1dmM0V3FWTTQy?=
 =?utf-8?B?Y210SFVVRDAzV1U5cGpiNmpWcjR5WFdFVFZaZXVjQUUzRWg0dzdrdnNGV3lr?=
 =?utf-8?B?K29Qd2E1T2lZdDdjTmVkNFVVWG9WMExtemYzN2Z6UWtLRkpIUkVDUzdpZ2tD?=
 =?utf-8?Q?e2HM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bb5139-63b2-4e47-4223-08de1660e7f4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:30:59.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYBip5Uxi4qF6HW2fuSxI8n3AwNo+5n03NFLSsbv4s1a1SKEFBpkIXiG0pHM8TGAG8gpA6OHwiGYo/YJbeOYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

default, state_100mhz and state_200mhz use the same settings. But current
driver use these to indicate if sd3.0 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 202d5c67ac40b844ee38e8fb0f9caf2e186cfa9f..6f1c78fcf384a7691f7f8ea1b50ab21cd6e72ba1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -800,8 +800,10 @@ &pwm_lvds1 {
 };
 
 &usdhc1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
 	bus-width = <8>;
 	no-sd;
 	no-sdio;
@@ -810,8 +812,10 @@ &usdhc1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	cd-gpios = <&lsio_gpio5 22 GPIO_ACTIVE_LOW>;
@@ -1228,4 +1232,12 @@ IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3			0x00000021
 			IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT		0x00000021
 		>;
 	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21			0x00000021
+			IMX8QM_USDHC1_DATA7_LSIO_GPIO5_IO22			0x00000021
+			IMX8QM_USDHC1_RESET_B_LSIO_GPIO4_IO07			0x00000021
+		>;
+	};
 };

-- 
2.34.1


